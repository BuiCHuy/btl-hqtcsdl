-------------------------- HUY 
--function trả về doanh thu theo ngày
create function doanhthu(@ngayvao date,@ngayra date)
returns int
as begin
	return (select sum(tongtien) from hoadon where ngaylap between @ngayvao and @ngayra)
end

--function trả về tiền lãi 
create function tienlai(@ngayvao date,@ngayra date)
returns int
as begin
	declare @von int = 0
	declare mh cursor for select soluong,gianhap,ngaylap from mathang inner join chitiethoadon on mathang.mamh=chitiethoadon.mamh inner join hoadon on chitiethoadon.mahd=hoadon.mahd
	open mh
	declare @soluong int,@gianhap int,@ngaylap date
	fetch next from mh into @soluong,@gianhap,@ngaylap
	while(@@FETCH_STATUS=0)
	begin
		if(@ngaylap between @ngayvao and @ngayra)
		begin
			set @von =@von + (@soluong*@gianhap)
		end
		fetch next from mh into @soluong,@gianhap,@ngaylap
	end
	close mh
	deallocate mh
	return dbo.doanhthu(@ngayvao,@ngayra)- @von
end

------------------------------- HOANG
-- viet ham tinh so luong san pham duoc mua boi 1 khach hang
create function f_SanPhamHayMua(@makh char(10), @masp char(10))
returns int
as begin
	declare @soluong int
	select @soluong = sum(soluong) from khachhang, hoadon, chitiethoadon
	where khachhang.makh = hoadon.makh and hoadon.mahd = chitiethoadon.mahd
	and mamh = @masp and khachhang.makh = @makh

	return @soluong
end


print dbo.f_SanPhamHayMua('KH1', 'MH2')
SELECT OBJECT_ID('dbo.f_SanPhamHayMua');


-- viet ham tra ve so tien thu duoc cua 1 mat hang
create function f_ThanhTienMh(@mamh char(10))
returns float
as begin
	declare @tongtien float
	select @tongtien = sum(thanhtien) from hoadon, chitiethoadon
	where hoadon.mahd = chitiethoadon.mahd
	and mamh = @mamh

	return @tongtien
end

------------------------- DUC ANH
--function trả về lương của 1 nhân viên
create function luong1NhanVien (@manv char(10))
returns float
as begin
	return (select luong from nhanvien where manv=@manv)

end

select dbo.luong1NhanVien ('NV1')

-- function kiểm tra thẻ tích điểm có tồn tại không
create function func_KTraTheTichDiem (@makh char(10)) 
returns bit 
as begin 
	declare @count int 
	select @count = count(*) 
	from thetichdiem 
	where makh=@makh 
	if(@count > 0)
	return 1 
	return 0 
end
print dbo.func_KTraTheTichDiem('KH1')

--function tính tích điểm 
create function fnc_TinhDiem (@tien money)
returns int 
as begin 
	return FLOOR(@tien / 100000) 
end

print dbo.fnc_TinhDiem(1400000)

--function quy đổi từ điểm ra tiền
create function fnc_QuyDoiDiem (@idThe int)
returns money 
as begin 
	declare @diem int, @count int
	select @count = COUNT(*) 
	from thetichdiem 
	where mathe = @idThe

	select @diem = diemtichluy 
	from thetichdiem 
	where mathe = @idThe 
	if (@count > 0 )
	return @diem*1000
	return 0
end

print dbo.fnc_QuyDoiDiem(1)
