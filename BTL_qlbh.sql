create table khachhang (
makh char(10) primary key,
hoten nvarchar(50),
diachi nvarchar(50),
sdt varchar(20)
)


create table nhanvien(
manv char(10) primary key,
hoten nvarchar(50),
diachi nvarchar(50),
ngaysinh date,
gioitinh nvarchar(10),
sdt varchar(20),
luong1gio float,
giolam float,
luong float
)

create table thanhtoanluong (
matt int not null primary key identity(1,1),
manv char(10) foreign key references nhanvien(manv),
ngaythanhtoan date
)

create table thetichdiem (
mathe int not null primary key identity(1,1),
makh char(10) foreign key references khachhang(makh),
diemtichluy int
)

create table loaihang(
malh char(10) primary key,
tenlh nvarchar(50)
)
create table mathang(
mamh char(10) primary key,
tenmh nvarchar(50),
malh char(10) foreign key references loaihang(malh),
dongia int,
soluongtrongkho int,
gianhap int
)

create table hoadon(
mahd char(10) primary key,
makh char(10) foreign key references khachhang(makh),
manv char(10) foreign key references nhanvien(manv),
ngaylap date,
tongtien int
)


create table chitiethoadon(
mahd char(10) references hoadon(mahd),
mamh char(10) references mathang(mamh),
primary key (mahd,mamh),
soluong int,
thanhtien int,
)

insert into khachhang values
('KH1',N'Nguyễn Văn A',N'Hai Bà Trưng, Hà Nội','0123456789'),
('KH2',N'Trần Thị B',N'Đống Đa, Hà Nội','0989898989'),
('KH3',N'Bùi Đức C',N'Hai Bà Trưng, Hà Nội','0323456787'),
('KH4',N'Trần Văn D ',N'Hà Đông, Hà Nội','0323546787'),
('KH5',N'Nguyễn Thị E ',N'Thanh Xuân, Hà Nội','0948838636')




INSERT INTO thetichdiem (makh,diemtichluy)
VALUES ('KH1','5');
update thetichdiem set diemtichluy = 50 where mathe=1

insert into nhanvien values
('NV1',N'Trần Văn T',N'Hai Bà Trưng, Hà Nội','2004/7/2','nam','0989898989',20000,20,0),
('NV2',N'Nguyễn Thị Q',N'Hà Đông, Hà Nội','2004/12/1',N'nữ','0912345678',105000,40,0)

insert into loaihang values
('LH1',N'Đồ ăn'),
('LH2',N'Dụng cụ học tập'),
('LH3',N'Đồ điện tử'),
('LH4',N'Gia vị'),
('LH5',N'Đồ gia dụng')

insert into mathang values
('MH1',N'Bim bim','LH1',5000,100,4000),
('MH2',N'Gói kẹo','LH1',9000,100,7000),
('MH3',N'Bút','LH2',4000,500,2000),
('MH4',N'Thước','LH2',5000,100,3000),
('MH5',N'Máy tính Casio','LH3',40000,50,30000),
('MH6',N'Ấm siêu tốc','LH3',100000,10,90000),
('MH7',N'Nước mắm','LH4',40000,100,30000),
('MH8',N'Tương ớt','LH4',20000,100,10000),
('MH9',N'Kéo','LH5',20000,100,10000),
('MH10',N'Chảo','LH5',80000,20,60000)

insert into hoadon values
('HD1','KH1','NV1','2024/12/23',0),
('HD2','KH1','NV2','2024/12/24',0),
('HD3','KH2','NV1','2024/11/11',0),
('HD4','KH3','NV2','2024/11/1',0),
('HD5','KH4','NV2','2024/10/10',0),
('HD6','KH5','NV1','2024/10/9',0),
('HD7','KH5','NV2','2024/11/10',0)

insert into chitiethoadon values
('HD1','MH1',2,0),
('HD1','MH2',1,0),
('HD2','MH3',2,0),
('HD2','MH5',1,0),
('HD2','MH4',1,0),
('HD3','MH7',1,0),
('HD3','MH8',1,0),
('HD4','MH6',1,0),
('HD4','MH10',1,0),
('HD5','MH1',5,0),
('HD5','MH2',4,0),
('HD5','MH9',1,0),
('HD6','MH3',1,0),
('HD6','MH4',3,0),
('HD7','MH5',1,0)

