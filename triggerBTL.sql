-- HUY
--trigger khi insert chitiethoadon sẽ tự cập nhật thành tiền tổng tiền và số lượng bán < số lượng còn trong kho đồng thời giảm số lượng còn trong kho
create trigger trig_insert_cthd on chitiethoadon after insert 
as begin
	declare ci cursor for select mamh,soluong from inserted
	open ci
	declare @sl int,@mamh char(10)
	fetch next from ci into @mamh,@sl
	while(@@FETCH_STATUS=0)
	begin
		if(select soluongtrongkho from mathang where mamh=@mamh)<@sl
		begin
			rollback tran
			print N'Số lượng bán phải nhỏ hơn số lượng còn trong kho'
		end
		else begin
			exec updatethanhtien
			exec updatetongtien
			update mathang set soluongtrongkho=soluongtrongkho-@sl where mamh=@mamh
		end
		fetch next from ci into @mamh,@sl
	end
	close ci
	deallocate ci
end

create trigger trig_update_cthd on chitiethoadon for update
as begin
	declare c2 cursor for select inserted.mamh,inserted.soluong as slmoi,deleted.soluong as slcu
	from inserted inner join deleted on inserted.mamh=deleted.mamh
	open c2
	declare @mamh char(10),@slmoi int,@slcu int
	fetch next from c2 into @mamh,@slmoi,@slcu
	while (@@FETCH_STATUS=0)
	begin
		if(select soluongtrongkho from mathang where mamh=@mamh)+@slcu<@slmoi
		begin
			rollback tran
			print N'Số lượng bán phải nhỏ hơn số lượng còn trong kho'
		end
		else 
		begin
			exec updatethanhtien
			exec updatetongtien
			update mathang set soluongtrongkho=soluongtrongkho+@slcu where mamh=@mamh
			update mathang set soluongtrongkho=soluongtrongkho-@slmoi where mamh=@mamh
		end
		fetch next from c2 into @mamh,@slmoi,@slcu
	end
	close c2
	deallocate c2
end
--trigger cho update cthd sẽ hoàn lại và tính lại số lượng trong kho

--trigger cho delete chi tiết hoá đơn cập nhật lại số lượng trong kho của mặt hàng
create trigger trig_delete_cthd on chitiethoadon for delete
as begin
	declare c1 cursor for select mahd,mamh,soluong from deleted
	open c1 
	declare @mamh char(10),@sl int,@mahd char(10)
	fetch next from c1 into @mahd,@mamh,@sl
	while(@@FETCH_STATUS=0)
	begin
		exec updatett1cthd @mahd,@mamh
		exec updatetongtien
		update mathang set soluongtrongkho=soluongtrongkho+@sl where mamh=@mamh
		fetch next from c1 into @mahd,@mamh,@sl

	end
	close c1
	deallocate c1
	
end

--trigger cho delete hoá đơn sẽ xóa cả chi tiết của hóa đơn đó
create trigger trig_delete_hd on hoadon instead of delete
as begin
	declare @mahd char(10)
	select @mahd = (select mahd from deleted)
	delete from chitiethoadon where mahd=@mahd
	delete from hoadon where mahd=@mahd
end


---------- HOANG ------------------

-- -- trigger ko cho gia nhap > gia ban
create trigger tri_giaNhapLonHonGiaBan
on mathang for insert
as begin
	declare dsmh cursor dynamic scroll
	for select mamh, dongia, gianhap from inserted
	open dsmh

	declare @mamh char(10), @dongia int, @gianhap int
	fetch first from dsmh into @mamh, @dongia, @gianhap
	while(@@FETCH_STATUS=0)
	begin
		if(@dongia < @gianhap)
			delete from mathang
			where mamh = @mamh
		fetch next from dsmh into @mamh, @dongia, @gianhap
	end
end
-- trigger ko so luong mat hang am
create trigger tri_InsertSoLuongKoAm
on mathang for insert
as begin
	declare dsmh cursor dynamic scroll 
	for select mamh, soluongtrongkho from inserted
	open dsmh

	declare @mamh char(10), @soluongtrongkho int
	fetch first from dsmh into @mamh, @soluongtrongkho
	while(@@FETCH_STATUS=0)
	begin
		if(@soluongtrongkho < 0)
		begin
			delete from mathang
			where mamh = @mamh
			print @mamh + N'bị lỗi do số lượng trong kho nhỏ hơn 0'
		end
		fetch next from dsmh into @mamh, @soluongtrongkho
	end

	close dsmh
	deallocate dsmh
end



-- trigger ko cho update so luong trong kho nho hon 0
create trigger tri_UpdateSoLuongKoAm
on mathang for update
as begin
	declare dsmh cursor dynamic scroll 
	for select mamh, soluongtrongkho from inserted
	open dsmh

	declare @mamh char(10), @soluongtrongkho int
	fetch first from dsmh into @mamh, @soluongtrongkho
	while(@@FETCH_STATUS=0)
	begin
		if(@soluongtrongkho < 0)
		begin
			delete from mathang where mamh = @mamh
			
			insert into mathang select * from deleted where mamh = @mamh

			print N'bị lỗi do số lượng trong kho nhỏ hơn 0'
		end
		fetch next from dsmh into @mamh, @soluongtrongkho
	end

	close dsmh
	deallocate dsmh
end

-- trigger ko cho insert loai hang bi trung
create trigger tri_loaihangkodctrung
on loaihang for insert
as begin
	declare dsloaihang cursor scroll dynamic
	for select * from inserted
	open dsloaihang

	declare @malh char(10), @tenlh nvarchar(50)
	fetch first from dsloaihang into @malh, @tenlh
	while(@@FETCH_STATUS=0)
	begin
		if(exists (select * from loaihang where tenlh = @tenlh and malh != @malh))
		begin
			delete from loaihang
			where malh = @malh
			print N'Ko thể nhập loại hàng đã trùng ' + @tenlh
		end
		fetch next from dsloaihang into @malh, @tenlh
	end

	close dsloaihang
	deallocate dsloaihang
end


----- DUC ANH
--trigger khi insert/update nhân viên sẽ tự cập nhật lương khi thêm hoặc cập nhật hệ số lương, giờ làm
create trigger trig_luong_nv
on nhanvien
for insert ,update
as 
begin
	exec updateLuong
end

--trigger khi insert thanh toán lương thì sẽ thực hiện cập nhật trường giolam = 0
create trigger trig_reset_giolam_nv
on thanhtoanluong
for insert
as 
begin
	update thanhtoanluong
	set ngaythanhtoan = getdate()
	where matt in (select inserted.matt from inserted)

	update nhanvien
	set giolam = 0
	where manv in (select inserted.manv from inserted)
end

--trigger cho delete nhân viên chỉ khi lương = 0 thì sẽ thực hiện cập nhật trường hesoluong = 0 và giolam = 0
create trigger trig_delete_nv
on nhanvien 
instead of delete
as begin
	if(select luong from deleted) = 0
	begin
		update nhanvien
		set luong1gio = 0
		where manv in (select deleted.manv from deleted)

		update nhanvien
		set giolam = 0
		where manv in (select deleted.manv from deleted)
	end
end