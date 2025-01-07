--Huy
--view thống kê top 5 mặt hàng bán chạy nhất
create view v_top5banchay as
select top(5) chitiethoadon.mamh,tenmh,
	sum(soluong) as tongsoluong,
	sum(thanhtien) as doanhthu 
from chitiethoadon
	inner join mathang 
	on mathang.mamh=chitiethoadon.mamh
group by chitiethoadon.mamh,tenmh
order by tongsoluong desc
--view thống kê doanh thu và lãi 
create view v_tienlaitheongay as
select ngaylap,
	dbo.doanhthu(ngaylap,ngaylap) as doanhthu,
	dbo.tienlai(ngaylap,ngaylap)as lai
from hoadon 
group by ngaylap

--view thống kê hóa đơn đã thanh toán
create view v_thanhtoan as
select * from hoadon where TTthanhtoan=1

--???
--Đức Anh
create view view_DoanhThuKhachHang (makh,hoten,sohd,tongdoanhthu)
as
	select khachhang.makh,hoten,count(*),sum(tongtien)
	from hoadon,khachhang
	where hoadon.makh=khachhang.makh
	group by khachhang.makh,hoten

select * from view_DoanhThuKhachHang
order by tongdoanhthu desc


create view view_DoanhThuNhanVien (manv,hoten,sohd,tongdoanhthu)
as
	select nhanvien.manv,hoten,count(*),sum(tongtien)
	from hoadon,nhanvien
	where hoadon.manv=nhanvien.manv
	group by nhanvien.manv,hoten

select * from view_DoanhThuNhanVien
order by tongdoanhthu desc

--- Hoang
-- view hiển thị các mặt hàng và khách hàng mua nó
create view v_khachHangTieuDung
as select
	khachhang.makh, khachhang.hoten, mathang.mamh, mathang.tenmh, tenlh, 
	dbo.f_SanPhamHayMua(khachhang.makh, mathang.mamh) as 'So luong'
	
	from mathang, chitiethoadon, khachhang, hoadon, loaihang

	where khachhang.makh = hoadon.makh and hoadon.mahd = chitiethoadon.mahd
	and chitiethoadon.mamh = mathang.mamh and mathang.malh = loaihang.malh

select * from v_khachHangTieuDung


-- view hiển thị só lượng đã bán của từng mặt hàng va so tien thu duoc khi ban mat hang do
create view v_ThongKeMatHang
as 
	select mathang.mamh, mathang.tenmh, tenlh, dongia, sum(chitiethoadon.soluong) as 'So luong',
		   dbo.f_ThanhTienMh(mathang.mamh) as 'Doanh thu'
	from hoadon, chitiethoadon, mathang, loaihang
	where hoadon.mahd = chitiethoadon.mahd and chitiethoadon.mamh = mathang.mamh
	and mathang.malh = loaihang.malh
	group by mathang.mamh, mathang.tenmh, tenlh, dongia

