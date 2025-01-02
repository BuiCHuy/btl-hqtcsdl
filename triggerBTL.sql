-- HUY
--trigger khi insert/update chitiethoadon sẽ tự cập nhật thành tiền tổng tiền và số lượng bán < số lượng còn trong kho đồng thời giảm số lượng còn trong kho
create trigger trig_insert_cthd on chitiethoadon for insert ,update
as begin
	declare c cursor for select mamh,soluong from inserted
	open c
	declare @sl int,@mamh char(10)
	fetch next from c into @mamh,@sl
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
		fetch next from c into @mamh,@sl
	end
	close c
	deallocate c
end

--trigger cho delete chi tiết hoá đơn cập nhật lại số lượng trong kho của mặt hàng
create trigger trig_delete_cthd on chitiethoadon for delete
as begin
	declare c1 cursor for select mamh,soluong from deleted
	open c1 
	declare @mamh char(10),@sl int
	fetch next from c1 into @mamh,@sl
	while(@@FETCH_STATUS=0)
	begin
		print @sl
		update mathang set soluongtrongkho=soluongtrongkho+@sl where mamh=@mamh
		fetch next from c1 into @mamh,@sl
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
			rollback tran
			print N'bị lỗi do số lượng trong kho nhỏ hơn 0'
		end
		fetch next from dsmh into @mamh, @soluongtrongkho
	end

	close dsmh
	deallocate dsmh
end

create trigger tri_loaihangkodctrung
on loaihang for insert
as begin
	if(exists (select * from loaihang where tenlh in (select tenlh from inserted)))
	begin
		rollback tran
		print N'Ko thể nhập loại hàng đã trùng'
	end
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