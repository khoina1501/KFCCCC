CREATE DATABASE QLBHKFCjava
go
USE QLBHKFCjava
go
CREATE TABLE NHANVIEN
(
MANV CHAR(5)
CONSTRAINT PK_NHANVIEN PRIMARY KEY,
 HONV NVARCHAR(100) not null,
 TENNV NVARCHAR(50) not null,
 GIOITINHNV NVARCHAR(10)
 CONSTRAINT CK_PHAI_NHANVIEN CHECK (GIOITINHNV IN(N'NAM', N'NỮ', N'KHAC')),
 NGAYSINH DATETIME,
 DIACHINV NVARCHAR(100)
 CONSTRAINT DF_DIACHI_NHANVIEN DEFAULT 'CHUA CO',
 DIENTHOAINV NVARCHAR(20),
 EMAILNV  NVARCHAR(50),
 CHUCVU NVARCHAR(20)
)
go
CREATE TABLE KHACHHANG
(
MAKH CHAR(5)
CONSTRAINT PK_KHACHHANG PRIMARY KEY,
 HOKH NVARCHAR(50) not null,
 TENKH NVARCHAR(20) not null,
 GIOITINHKH NVARCHAR(10)
 CONSTRAINT CK_PHAI_KHACHHANG CHECK (GIOITINHKH IN(N'NAM', N'NỮ', N'KHAC')),
 DIACHIKH NVARCHAR(100)
 CONSTRAINT DF_DIACHI_KHACHHANG DEFAULT 'CHUA CO',
 DIENTHOAIKH NVARCHAR(20),
 EMAILKH  NVARCHAR(50)
 
)
go
CREATE TABLE NHACUNGCAP
(
MANCC CHAR(5) CONSTRAINT PK_NHACUNGCAP PRIMARY KEY,
TENNCC NVARCHAR(50) NOT NULL,
DIACHINCC NVARCHAR(100)
 CONSTRAINT DF_DIACHI_NHACUNGCAP DEFAULT N'CHUA CO',
 DIENTHOAINCC NVARCHAR(30) NOT NULL,
WEB  NVARCHAR(50) 
)
go
CREATE TABLE LOAIHANG
(
 MALH NCHAR(5) CONSTRAINT PK_MALH_LOAIHANG PRIMARY KEY,
 TENLH NCHAR(50)
)
go
CREATE TABLE MATHANG
(
 MAMH NCHAR(6) CONSTRAINT PK_MAMH_MATHANG PRIMARY KEY,
 TENMH NVARCHAR(150),
 DVT NVARCHAR(20),
 SLTON INT,
 DGNHAP FLOAT,
 DGBAN FLOAT Not null,
 MALH NCHAR(5)
 CONSTRAINT FK_MALH_MATHANG FOREIGN KEY (MALH) REFERENCES LOAIHANG(MALH)
)
go
CREATE TABLE HOADON
(
 MADH NCHAR(6) CONSTRAINT PK_MADH_DONDH PRIMARY KEY,
 MAKH CHAR(5)
 CONSTRAINT FK_MAKH_DONDH FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
 MANV CHAR(5) 
 CONSTRAINT FK_MANV_DONDH FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
 TRIGIA MONEY,
 NGAYLAP DATETIME,
 PTTT NVARCHAR(100),
)
go
CREATE TABLE CTHOADON
(
 MADH NCHAR(6) 
 CONSTRAINT FK_MADH_CTDH FOREIGN KEY (MADH) REFERENCES HOADON(MADH),
 MAMH NCHAR(6)
 CONSTRAINT FK_MAMH_CTDH FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH),
 SL INT ,
 DGBAN FLOAT,
 THANHTIEN FLOAT,
 PRIMARY KEY(MADH,MAMH),
 
)
go
CREATE TABLE PHIEUNHAP 
( SOPN CHAR (5)  CONSTRAINT PK_SOPN_PHIEUNHAP PRIMARY KEY,
  MANV CHAR(5) 
 CONSTRAINT FK_MANV_PHIEUNHAP FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
 MANCC CHAR (5)
 CONSTRAINT FK_MANCC_PHIEUNHAP FOREIGN KEY (MANCC) REFERENCES NHACUNGCAP(MANCC),
 TRIGIA FLOAT,
 NGAYNHAP DATE ,
 GHICHUNHAP NVARCHAR(100),
  )
go
CREATE TABLE PHIEUXUAT
( SOPX CHAR (5)  CONSTRAINT PK_SOPX_PHIEUXUAT PRIMARY KEY,
   NGAYXUAT DATETIME ,
   GHICHUXUAT NVARCHAR(100),
  MANV CHAR(5) CONSTRAINT FK_MANV_PHIEUXUAT FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
   TRIGIA FLOAT

)
go
CREATE TABLE CTPHIEUNHAP
( SOPN CHAR (5)  CONSTRAINT FK_SOPN_PHIEUNHAP FOREIGN KEY (SOPN) REFERENCES PHIEUNHAP(SOPN),
 MAMH NCHAR(6)
 CONSTRAINT FK_MAMH_CTPHIEUNHAP FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH),
 SLNHAP INT,
 GIA FLOAT,
 PRIMARY KEY (SOPN,MAMH)
 )
 go
CREATE TABLE CTPHIEUXUAT
( SOPX CHAR (5)  CONSTRAINT FK_SOPX_PHIEUXUAT FOREIGN KEY (SOPX) REFERENCES PHIEUXUAT(SOPX),
 MAMH NCHAR(6)
 CONSTRAINT FK_MAMH_CTPHIEUXUAT FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH),
 SLXUAT INT,
 GIA FLOAT,
 PRIMARY KEY (SOPX,MAMH)
 )
   
go 
CREATE TABLE QUYEN 
(
MAQUYEN INT CONSTRAINT PK_MAQUYEN_QUYEN PRIMARY KEY ,
TENQUYEN NVARCHAR(50),
CHUTHIC NVARCHAR(100) CONSTRAINT DF_QUYEN_CHUTHICH DEFAULT (''),
)
GO 
CREATE TABLE USERS
(
ID INT IDENTITY(1,1) NOT NULL ,
MANV NCHAR(10) NOT NULL ,
TENDANGNHAP VARCHAR(50) NOT NULL ,
MATKHAU VARCHAR(50) NOT NULL ,
QUYEN INT CONSTRAINT FK_QUYEN_USERS FOREIGN KEY(QUYEN) REFERENCES QUYEN(MAQUYEN)
)

  

SELECT * FROM NHACUNGCAP

SELECT KHACHHANG.MAKH, HOKH+' '+TENKH AS HOTEN, 
  CASE 
  WHEN COUNT(MADH)=0 THEN NULL
  ELSE COUNT (MADH)
  END AS 'SO HOA DON DA MUA'
 FROM KHACHHANG LEFT  JOIN HOADON  ON KHACHHANG.MAKH= HOADON.MAKH
 GROUP BY KHACHHANG.MAKH,HOKH+' '+TENKH


 SELECT NHANVIEN.MANV, HONV+' '+TENNV AS HOTEN, 
  CASE 
  WHEN COUNT(MADH)=0 THEN NULL
  ELSE COUNT (MADH)
  END AS 'SO HOA DON DA LAP'
 FROM NHANVIEN LEFT  JOIN HOADON  ON NHANVIEN.MANV= HOADON.MANV
 GROUP BY NHANVIEN.MANV, HONV+' '+TENNV

 SELECT NHACUNGCAP.MANCC ,MAMH, SUM(SLNHAP) AS 'TONG SO LUONG HANG ' 
 FROM NHACUNGCAP join PHIEUNHAP ON NHACUNGCAP.MANCC= PHIEUNHAP.MANCC JOIN CTPHIEUNHAP ON PHIEUNHAP.SOPN=CTPHIEUNHAP.SOPN
 GROUP BY NHACUNGCAP.MANCC , MAMH
 go
insert into NHANVIEN
values ('NV001', N'Lê Thị', N'Cúc',N'Nữ', convert (datetime,'5/4/1989'),  N'Lô C, phòng 28, chung cư Thanh Đa', '092987987', N'cuclt@gmail.com',N'Nhân viên'),
('NV002', N'Mai Minh', N'Mẫn',N'Nữ', CONVERT (datetime, '3/7/1990'), N'78/12/8/Tân Hội', '098789789', 'manmm@gmail.com',N'Quản lý'),
('NV003', N'Võ Tú', N'Hoàng',  'Nam',CONVERT (datetime, '9/8/2000'), N'178/97 An Dương Vương', '091234234', 'hoangvt@yahoo.com',N'Quản lý'),
('NV004', N'Trần Hữu', N'Thắng','Nam',CONVERT (datetime,'5/12/1985'), N'50 Nguyễn Du', '092678678', 'thangth@yahoo.com',N'Nhân viên'),
('NV005', N'Nguyễn Duy' ,N'Hưng', 'Nam',CONVERT (datetime,'3/5/1987'), N'68 Nguyễn Trãi' , '098456744', 'hungnd@gmail.com',N'Trưởng phòng'),
('NV006', N'Hồ Phước', N'Duy', 'Nam',convert (datetime,'5/7/2000'), N'Lô B phòng 33, chung cư SaLa', '092466987', N'duy@gmail.com',N'Kế toán trường'),
('NV007', N'Hà Thùy', N'Anh', N'Nữ',CONVERT (datetime, '12/5/2003'), N'523/11 Nguyễn Tri Phương, quận 10', '033563789', 'htta@gmail.com',N'Nhân viên'),
('NV008', N'Võ Thị ', N'Hạ', N'Nữ', CONVERT (datetime, '4/8/1999'), N'59/22 đường 385, Tăng Nhơn Phú A', '054264234', 'vtth@yahoo.com',N'Kế toán viên'),
('NV009', N'Trần Hữu', N'Biên','Nam',CONVERT (datetime,'1/1/1998'), N'60 Trần Đình Xu', '093538678', 'bien@yahoo.com',N'Nhân viên'),
('NV010', N'Nguyễn Thúy' ,N'Kiều', 'Nam',CONVERT (datetime,'8/9/1890'),  N'111 Bà Hạt' , '098456535', 'kieu@gmail.com',N'Trưởng phòng ban'),
('NV011', N'Lê Thị', N'Cúc',N'Nữ', convert (datetime,'5/4/1989'),  N'Lô C, phòng 28, chung cư Thanh Đa', '092987987', N'cuclt@gmail.com',N'Nhân viên'),
('NV012', N'Mai Minh', N'Mẫn',N'Nữ', CONVERT (datetime, '3/7/1990'), N'78/12/8/Tân Hội', '098789789', 'manmm@gmail.com',N'Quản lý'),
('NV013', N'Võ Tú', N'Hoàng',  'Nam',CONVERT (datetime, '9/8/2000'), N'178/97 An Dương Vương', '091234234', 'hoangvt@yahoo.com',N'Quản lý'),
('NV014', N'Trần Hữu', N'Thắng','Nam',CONVERT (datetime,'5/12/1985'), N'50 Nguyễn Du', '092678678', 'thangth@yahoo.com',N'Nhân viên'),
('NV015', N'Nguyễn Duy' ,N'Hưng', 'Nam',CONVERT (datetime,'3/5/1987'), N'68 Nguyễn Trãi' , '098456744', 'hungnd@gmail.com',N'Trưởng phòng'),
('NV016', N'Hồ Phước', N'Duy', 'Nam',convert (datetime,'5/7/2000'), N'Lô B phòng 33, chung cư SaLa', '092466987', N'duy@gmail.com',N'Kế toán trường'),
('NV017', N'Hà Thùy', N'Anh', N'Nữ',CONVERT (datetime, '12/5/2003'), N'523/11 Nguyễn Tri Phương, quận 10', '033563789', 'htta@gmail.com',N'Nhân viên'),
('NV018', N'Võ Thị ', N'Hạ', N'Nữ', CONVERT (datetime, '4/8/1999'), N'59/22 đường 385, Tăng Nhơn Phú A', '054264234', 'vtth@yahoo.com',N'Kế toán viên'),
('NV019', N'Trần Hữu', N'Biên','Nam',CONVERT (datetime,'1/1/1998'), N'60 Trần Đình Xu', '093538678', 'bien@yahoo.com',N'Nhân viên'),
('NV020', N'Nguyễn Thúy' ,N'Kiều', 'Nam',CONVERT (datetime,'8/9/1890'),  N'111 Bà Hạt' , '098456535', 'kieu@gmail.com',N'Trưởng phòng ban'),
('NV021', N'Lê Thị', N'Cúc',N'Nữ', convert (datetime,'5/4/1989'),  N'Lô C, phòng 28, chung cư Thanh Đa', '092987987', N'cuclt@gmail.com',N'Nhân viên'),
('NV022', N'Mai Minh', N'Mẫn',N'Nữ', CONVERT (datetime, '3/7/1990'), N'78/12/8/Tân Hội', '098789789', 'manmm@gmail.com',N'Quản lý'),
('NV023', N'Võ Tú', N'Hoàng',  'Nam',CONVERT (datetime, '9/8/2000'), N'178/97 An Dương Vương', '091234234', 'hoangvt@yahoo.com',N'Quản lý'),
('NV024', N'Trần Hữu', N'Thắng','Nam',CONVERT (datetime,'5/12/1985'), N'50 Nguyễn Du', '092678678', 'thangth@yahoo.com',N'Nhân viên'),
('NV025', N'Nguyễn Duy' ,N'Hưng', 'Nam',CONVERT (datetime,'3/5/1987'), N'68 Nguyễn Trãi' , '098456744', 'hungnd@gmail.com',N'Trưởng phòng'),
('NV026', N'Hồ Phước', N'Duy', 'Nam',convert (datetime,'5/7/2000'), N'Lô B phòng 33, chung cư SaLa', '092466987', N'duy@gmail.com',N'Kế toán trường'),
('NV027', N'Hà Thùy', N'Anh', N'Nữ',CONVERT (datetime, '12/5/2003'), N'523/11 Nguyễn Tri Phương, quận 10', '033563789', 'htta@gmail.com',N'Nhân viên'),
('NV028', N'Võ Thị ', N'Hạ', N'Nữ', CONVERT (datetime, '4/8/1999'), N'59/22 đường 385, Tăng Nhơn Phú A', '054264234', 'vtth@yahoo.com',N'Kế toán viên'),
('NV029', N'Trần Hữu', N'Biên','Nam',CONVERT (datetime,'1/1/1998'), N'60 Trần Đình Xu', '093538678', 'bien@yahoo.com',N'Nhân viên'),
('NV030', N'Nguyễn Thúy' ,N'Kiều', 'Nam',CONVERT (datetime,'8/9/1890'),  N'111 Bà Hạt' , '098456535', 'kieu@gmail.com',N'Trưởng phòng ban'),
('NV031', N'Lê Thị', N'Cúc',N'Nữ', convert (datetime,'5/4/1989'),  N'Lô C, phòng 28, chung cư Thanh Đa', '092987987', N'cuclt@gmail.com',N'Nhân viên'),
('NV032', N'Mai Minh', N'Mẫn',N'Nữ', CONVERT (datetime, '3/7/1990'), N'78/12/8/Tân Hội', '098789789', 'manmm@gmail.com',N'Quản lý'),
('NV033', N'Võ Tú', N'Hoàng',  'Nam',CONVERT (datetime, '9/8/2000'), N'178/97 An Dương Vương', '091234234', 'hoangvt@yahoo.com',N'Quản lý'),
('NV034', N'Trần Hữu', N'Thắng','Nam',CONVERT (datetime,'5/12/1985'), N'50 Nguyễn Du', '092678678', 'thangth@yahoo.com',N'Nhân viên'),
('NV035', N'Nguyễn Duy' ,N'Hưng', 'Nam',CONVERT (datetime,'3/5/1987'), N'68 Nguyễn Trãi' , '098456744', 'hungnd@gmail.com',N'Trưởng phòng'),
('NV036', N'Hồ Phước', N'Duy', 'Nam',convert (datetime,'5/7/2000'), N'Lô B phòng 33, chung cư SaLa', '092466987', N'duy@gmail.com',N'Kế toán trường'),
('NV037', N'Hà Thùy', N'Anh', N'Nữ',CONVERT (datetime, '12/5/2003'), N'523/11 Nguyễn Tri Phương, quận 10', '033563789', 'htta@gmail.com',N'Nhân viên'),
('NV038', N'Võ Thị ', N'Hạ', N'Nữ', CONVERT (datetime, '4/8/1999'), N'59/22 đường 385, Tăng Nhơn Phú A', '054264234', 'vtth@yahoo.com',N'Kế toán viên'),
('NV039', N'Trần Hữu', N'Biên','Nam',CONVERT (datetime,'1/1/1998'), N'60 Trần Đình Xu', '093538678', 'bien@yahoo.com',N'Nhân viên'),
('NV040', N'Nguyễn Thúy' ,N'Kiều', 'Nam',CONVERT (datetime,'8/9/1890'),  N'111 Bà Hạt' , '098456535', 'kieu@gmail.com',N'Trưởng phòng ban'),
('NV041', N'Lê Thị', N'Cúc',N'Nữ', convert (datetime,'5/4/1989'),  N'Lô C, phòng 28, chung cư Thanh Đa', '092987987', N'cuclt@gmail.com',N'Nhân viên'),
('NV042', N'Mai Minh', N'Mẫn',N'Nữ', CONVERT (datetime, '3/7/1990'), N'78/12/8/Tân Hội', '098789789', 'manmm@gmail.com',N'Quản lý'),
('NV043', N'Võ Tú', N'Hoàng',  'Nam',CONVERT (datetime, '9/8/2000'), N'178/97 An Dương Vương', '091234234', 'hoangvt@yahoo.com',N'Quản lý'),
('NV044', N'Trần Hữu', N'Thắng','Nam',CONVERT (datetime,'5/12/1985'), N'50 Nguyễn Du', '092678678', 'thangth@yahoo.com',N'Nhân viên'),
('NV045', N'Nguyễn Duy' ,N'Hưng', 'Nam',CONVERT (datetime,'3/5/1987'), N'68 Nguyễn Trãi' , '098456744', 'hungnd@gmail.com',N'Trưởng phòng'),
('NV046', N'Hồ Phước', N'Duy', 'Nam',convert (datetime,'5/7/2000'), N'Lô B phòng 33, chung cư SaLa', '092466987', N'duy@gmail.com',N'Kế toán trường'),
('NV047', N'Hà Thùy', N'Anh', N'Nữ',CONVERT (datetime, '12/5/2003'), N'523/11 Nguyễn Tri Phương, quận 10', '033563789', 'htta@gmail.com',N'Nhân viên'),
('NV048', N'Võ Thị ', N'Hạ', N'Nữ', CONVERT (datetime, '4/8/1999'), N'59/22 đường 385, Tăng Nhơn Phú A', '054264234', 'vtth@yahoo.com',N'Kế toán viên'),
('NV049', N'Trần Hữu', N'Biên','Nam',CONVERT (datetime,'1/1/1998'), N'60 Trần Đình Xu', '093538678', 'bien@yahoo.com',N'Nhân viên'),
('NV050', N'Nguyễn Thúy' ,N'Kiều', 'Nam',CONVERT (datetime,'8/9/1890'),  N'111 Bà Hạt' , '098456535', 'kieu@gmail.com',N'Trưởng phòng ban')
go
insert into KHACHHANG
values('KH001', N'Nguyễn Thị Minh', N'Ngọc', N'Nữ', N'123/6 bis Lê Thánh Tôn, Q1, Tp.HCM', '098123123', 'ngocntm@gmail.com'),
('KH002',N'Trần Anh', N'Tuấn' , 'Nam' ,'49/12B Nguyễn Thị Minh Khai, Q1, Tp.HCM','091321321','tuanta@yahoo.com'),
('KH003',N'Lê Nam', N'Anh' ,'Nam', N'Ngõ 6, phố Thanh Xuân, Hà Nội', '090312312', 'anhln@gmail.com'),
('KH004',N'Nguyễn Quốc', N'Khánh', 'Nam', N'67 bis Nguyễn Thượng Hiền, Q. Bình Thạnh, Tp.HCM', '090812812', 'khanhnq@gmail.com'),
('KH005', N'Lê Nhật', N'Đông', N'Nữ', N'61 Ngô Gia tự, Q10, Tp.HCM', '098156723', 'dong56m@gmail.com'),
('KH006',N'Lê Gia', N'Huy' , 'Nam' ,N'77/2C Nguyễn Trãi, Q11, Tp.HCM','095475421','nguy88@yahoo.com'),
('KH007',N'Lê Hoài', N'Nam' ,'Nam', N'99/ 11 Trần Hưng Đạo, Biên Hòa', '090344212', 'nft6@gmail.com'),
('KH008',N'Nguyễn Thục', N'Hiền', N'Nữ', N'67 Trần Đình Xu, Q1, Tp.HCM', '090876558', 'hty5@gmail.com'),
('KH009', N'Lê Quang', N'Đạt', 'Nam', N'97 Man Thiện, Q9, Tp.HCM', '098123123', 'fy65@gmail.com'),
('KH010',N'Ha Thuy', N'Tu' , N'Nữ' ,'88/4 Chương Dương,Tp.Thủ Đức Tp.HCM','091321321','fr7@yahoo.com'),
('KH011', N'Nguyễn Thị Minh', N'Ngọc', N'Nữ', N'123/6 bis Lê Thánh Tôn, Q1, Tp.HCM', '098123123', 'ngocntm@gmail.com'),
('KH012',N'Trần Anh', N'Tuấn' , 'Nam' ,'49/12B Nguyễn Thị Minh Khai, Q1, Tp.HCM','091321321','tuanta@yahoo.com'),
('KH013',N'Lê Nam', N'Anh' ,'Nam', N'Ngõ 6, phố Thanh Xuân, Hà Nội', '090312312', 'anhln@gmail.com'),
('KH014',N'Nguyễn Quốc', N'Khánh', 'Nam', N'67 bis Nguyễn Thượng Hiền, Q. Bình Thạnh, Tp.HCM', '090812812', 'khanhnq@gmail.com'),
('KH015', N'Lê Nhật', N'Đông', N'Nữ', N'61 Ngô Gia tự, Q10, Tp.HCM', '098156723', 'dong56m@gmail.com'),
('KH016',N'Lê Gia', N'Huy' , 'Nam' ,N'77/2C Nguyễn Trãi, Q11, Tp.HCM','095475421','nguy88@yahoo.com'),
('KH017',N'Lê Hoài', N'Nam' ,'Nam', N'99/ 11 Trần Hưng Đạo, Biên Hòa', '090344212', 'nft6@gmail.com'),
('KH018',N'Nguyễn Thục', N'Hiền', N'Nữ', N'67 Trần Đình Xu, Q1, Tp.HCM', '090876558', 'hty5@gmail.com'),
('KH019', N'Lê Quang', N'Đạt', 'Nam', N'97 Man Thiện, Q9, Tp.HCM', '098123123', 'fy65@gmail.com'),
('KH020',N'Ha Thuy', N'Tu' , N'Nữ' ,'88/4 Chương Dương,Tp.Thủ Đức Tp.HCM','091321321','fr7@yahoo.com'),
('KH021', N'Nguyễn Thị Minh', N'Ngọc', N'Nữ', N'123/6 bis Lê Thánh Tôn, Q1, Tp.HCM', '098123123', 'ngocntm@gmail.com'),
('KH022',N'Trần Anh', N'Tuấn' , 'Nam' ,'49/12B Nguyễn Thị Minh Khai, Q1, Tp.HCM','091321321','tuanta@yahoo.com'),
('KH023',N'Lê Nam', N'Anh' ,'Nam', N'Ngõ 6, phố Thanh Xuân, Hà Nội', '090312312', 'anhln@gmail.com'),
('KH024',N'Nguyễn Quốc', N'Khánh', 'Nam', N'67 bis Nguyễn Thượng Hiền, Q. Bình Thạnh, Tp.HCM', '090812812', 'khanhnq@gmail.com'),
('KH025', N'Lê Nhật', N'Đông', N'Nữ', N'61 Ngô Gia tự, Q10, Tp.HCM', '098156723', 'dong56m@gmail.com'),
('KH026',N'Lê Gia', N'Huy' , 'Nam' ,N'77/2C Nguyễn Trãi, Q11, Tp.HCM','095475421','nguy88@yahoo.com'),
('KH027',N'Lê Hoài', N'Nam' ,'Nam', N'99/ 11 Trần Hưng Đạo, Biên Hòa', '090344212', 'nft6@gmail.com'),
('KH028',N'Nguyễn Thục', N'Hiền', N'Nữ', N'67 Trần Đình Xu, Q1, Tp.HCM', '090876558', 'hty5@gmail.com'),
('KH029', N'Lê Quang', N'Đạt', 'Nam', N'97 Man Thiện, Q9, Tp.HCM', '098123123', 'fy65@gmail.com'),
('KH030',N'Ha Thuy', N'Tu' , N'Nữ' ,'88/4 Chương Dương,Tp.Thủ Đức Tp.HCM','091321321','fr7@yahoo.com'),
('KH031', N'Nguyễn Thị Minh', N'Ngọc', N'Nữ', N'123/6 bis Lê Thánh Tôn, Q1, Tp.HCM', '098123123', 'ngocntm@gmail.com'),
('KH032',N'Trần Anh', N'Tuấn' , 'Nam' ,'49/12B Nguyễn Thị Minh Khai, Q1, Tp.HCM','091321321','tuanta@yahoo.com'),
('KH033',N'Lê Nam', N'Anh' ,'Nam', N'Ngõ 6, phố Thanh Xuân, Hà Nội', '090312312', 'anhln@gmail.com'),
('KH034',N'Nguyễn Quốc', N'Khánh', 'Nam', N'67 bis Nguyễn Thượng Hiền, Q. Bình Thạnh, Tp.HCM', '090812812', 'khanhnq@gmail.com'),
('KH035', N'Lê Nhật', N'Đông', N'Nữ', N'61 Ngô Gia tự, Q10, Tp.HCM', '098156723', 'dong56m@gmail.com'),
('KH036',N'Lê Gia', N'Huy' , 'Nam' ,N'77/2C Nguyễn Trãi, Q11, Tp.HCM','095475421','nguy88@yahoo.com'),
('KH037',N'Lê Hoài', N'Nam' ,'Nam', N'99/ 11 Trần Hưng Đạo, Biên Hòa', '090344212', 'nft6@gmail.com'),
('KH038',N'Nguyễn Thục', N'Hiền', N'Nữ', N'67 Trần Đình Xu, Q1, Tp.HCM', '090876558', 'hty5@gmail.com'),
('KH039', N'Lê Quang', N'Đạt', 'Nam', N'97 Man Thiện, Q9, Tp.HCM', '098123123', 'fy65@gmail.com'),
('KH040',N'Ha Thuy', N'Tu' , N'Nữ' ,'88/4 Chương Dương,Tp.Thủ Đức Tp.HCM','091321321','fr7@yahoo.com'),
('KH041', N'Nguyễn Thị Minh', N'Ngọc', N'Nữ', N'123/6 bis Lê Thánh Tôn, Q1, Tp.HCM', '098123123', 'ngocntm@gmail.com'),
('KH042',N'Trần Anh', N'Tuấn' , 'Nam' ,'49/12B Nguyễn Thị Minh Khai, Q1, Tp.HCM','091321321','tuanta@yahoo.com'),
('KH043',N'Lê Nam', N'Anh' ,'Nam', N'Ngõ 6, phố Thanh Xuân, Hà Nội', '090312312', 'anhln@gmail.com'),
('KH044',N'Nguyễn Quốc', N'Khánh', 'Nam', N'67 bis Nguyễn Thượng Hiền, Q. Bình Thạnh, Tp.HCM', '090812812', 'khanhnq@gmail.com'),
('KH045', N'Lê Nhật', N'Đông', N'Nữ', N'61 Ngô Gia tự, Q10, Tp.HCM', '098156723', 'dong56m@gmail.com'),
('KH046',N'Lê Gia', N'Huy' , 'Nam' ,N'77/2C Nguyễn Trãi, Q11, Tp.HCM','095475421','nguy88@yahoo.com'),
('KH047',N'Lê Hoài', N'Nam' ,'Nam', N'99/ 11 Trần Hưng Đạo, Biên Hòa', '090344212', 'nft6@gmail.com'),
('KH048',N'Nguyễn Thục', N'Hiền', N'Nữ', N'67 Trần Đình Xu, Q1, Tp.HCM', '090876558', 'hty5@gmail.com'),
('KH049', N'Lê Quang', N'Đạt', 'Nam', N'97 Man Thiện, Q9, Tp.HCM', '098123123', 'fy65@gmail.com'),
('KH050',N'Ha Thuy', N'Tu' , N'Nữ' ,'88/4 Chương Dương,Tp.Thủ Đức Tp.HCM','091321321','fr7@yahoo.com')
go
insert into NHACUNGCAP
values ('NCC01',N'Phúc Đạt Food',N'83 Phan Văn Hân, P.17, Bình Thạnh, HCM','0909090909','https://phucdatfood.com/cua-hang'),
    ('NCC02',N'Đồng Xanh',N'34/23 Hoàng Ngọc Phách, P. Phú Thọ Hoà, Q.Tân Phú, TP.HCM','0936685268 ','https://kaifood.com'),
    ('NCC03',N'Đại Phong',N'Lô 15A, Khu Công nghiệp Trà Nóc 1, P.Trà Nóc, Q.Bình Thủy, Tp.Cần Thơ','02923842486 ','https://daiphong.com.vn/'),
    ('NCC04',N'Thực Phẩm Sạch HD',N'1164 Phạm Văn Đồng, P.Linh Đông, Tp.Thủ Đức',' 0833300055 ','https://www.thucphamsachhd.com/'),
    ('NCC05',N'Nhà Vườn Hưng Thịnh',N'Thôn Hoàn Kiếm 2, xã Nam Hà, huyện Lâm Hà, tỉnh Lâm Đồng',' 0835500055 ','https://vuonhungthinh.com/'),
    ('NCC06',N'Phong Linh Food',N'Cây xăng 74, Ngọc Hồi, Thanh Trì, Hà Nội',' 0972813893 ','https://phonglinhfood.com/'),
    ('NCC07',N'Rau Xanh',N'27 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 0783536798 ','https://sibafood.vn/collections/rau-xanh'),
    ('NCC08',N'Nakayama Food',N'5E10 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 089236798 ','https://www.nakayama-foods.vn/'),
    ('NCC09',N'Tiến vua Food',N'Số 8 Võ Văn Ngân, TP Thủ Đức',' 0123457812 ','https://www.foody.vn'),
    ('NCC10',N'Vua Gạo Food',N'177/24, Đường 3/2, Phường 11, Quận 10, TPHCM',' 18008012 ','https://www.linkedin.com'),
	('NCC11',N'Phúc Đạt Food',N'83 Phan Văn Hân, P.17, Bình Thạnh, HCM','0909090909','https://phucdatfood.com/cua-hang'),
    ('NCC12',N'Đồng Xanh',N'34/23 Hoàng Ngọc Phách, P. Phú Thọ Hoà, Q.Tân Phú, TP.HCM','0936685268 ','https://kaifood.com'),
    ('NCC13',N'Đại Phong',N'Lô 15A, Khu Công nghiệp Trà Nóc 1, P.Trà Nóc, Q.Bình Thủy, Tp.Cần Thơ','02923842486 ','https://daiphong.com.vn/'),
    ('NCC14',N'Thực Phẩm Sạch HD',N'1164 Phạm Văn Đồng, P.Linh Đông, Tp.Thủ Đức',' 0833300055 ','https://www.thucphamsachhd.com/'),
    ('NCC15',N'Nhà Vườn Hưng Thịnh',N'Thôn Hoàn Kiếm 2, xã Nam Hà, huyện Lâm Hà, tỉnh Lâm Đồng',' 0835500055 ','https://vuonhungthinh.com/'),
    ('NCC16',N'Phong Linh Food',N'Cây xăng 74, Ngọc Hồi, Thanh Trì, Hà Nội',' 0972813893 ','https://phonglinhfood.com/'),
    ('NCC17',N'Rau Xanh',N'27 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 0783536798 ','https://sibafood.vn/collections/rau-xanh'),
    ('NCC18',N'Nakayama Food',N'5E10 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 089236798 ','https://www.nakayama-foods.vn/'),
    ('NCC19',N'Tiến vua Food',N'Số 8 Võ Văn Ngân, TP Thủ Đức',' 0123457812 ','https://www.foody.vn'),
    ('NCC20',N'Vua Gạo Food',N'177/24, Đường 3/2, Phường 11, Quận 10, TPHCM',' 18008012 ','https://www.linkedin.com'),
	('NCC21',N'Phúc Đạt Food',N'83 Phan Văn Hân, P.17, Bình Thạnh, HCM','0909090909','https://phucdatfood.com/cua-hang'),
    ('NCC22',N'Đồng Xanh',N'34/23 Hoàng Ngọc Phách, P. Phú Thọ Hoà, Q.Tân Phú, TP.HCM','0936685268 ','https://kaifood.com'),
    ('NCC23',N'Đại Phong',N'Lô 15A, Khu Công nghiệp Trà Nóc 1, P.Trà Nóc, Q.Bình Thủy, Tp.Cần Thơ','02923842486 ','https://daiphong.com.vn/'),
    ('NCC24',N'Thực Phẩm Sạch HD',N'1164 Phạm Văn Đồng, P.Linh Đông, Tp.Thủ Đức',' 0833300055 ','https://www.thucphamsachhd.com/'),
    ('NCC25',N'Nhà Vườn Hưng Thịnh',N'Thôn Hoàn Kiếm 2, xã Nam Hà, huyện Lâm Hà, tỉnh Lâm Đồng',' 0835500055 ','https://vuonhungthinh.com/'),
    ('NCC26',N'Phong Linh Food',N'Cây xăng 74, Ngọc Hồi, Thanh Trì, Hà Nội',' 0972813893 ','https://phonglinhfood.com/'),
    ('NCC27',N'Rau Xanh',N'27 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 0783536798 ','https://sibafood.vn/collections/rau-xanh'),
    ('NCC28',N'Nakayama Food',N'5E10 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 089236798 ','https://www.nakayama-foods.vn/'),
    ('NCC29',N'Tiến vua Food',N'Số 8 Võ Văn Ngân, TP Thủ Đức',' 0123457812 ','https://www.foody.vn'),
    ('NCC30',N'Vua Gạo Food',N'177/24, Đường 3/2, Phường 11, Quận 10, TPHCM',' 18008012 ','https://www.linkedin.com'),
	('NCC31',N'Phúc Đạt Food',N'83 Phan Văn Hân, P.17, Bình Thạnh, HCM','0909090909','https://phucdatfood.com/cua-hang'),
    ('NCC32',N'Đồng Xanh',N'34/23 Hoàng Ngọc Phách, P. Phú Thọ Hoà, Q.Tân Phú, TP.HCM','0936685268 ','https://kaifood.com'),
    ('NCC33',N'Đại Phong',N'Lô 15A, Khu Công nghiệp Trà Nóc 1, P.Trà Nóc, Q.Bình Thủy, Tp.Cần Thơ','02923842486 ','https://daiphong.com.vn/'),
    ('NCC34',N'Thực Phẩm Sạch HD',N'1164 Phạm Văn Đồng, P.Linh Đông, Tp.Thủ Đức',' 0833300055 ','https://www.thucphamsachhd.com/'),
    ('NCC35',N'Nhà Vườn Hưng Thịnh',N'Thôn Hoàn Kiếm 2, xã Nam Hà, huyện Lâm Hà, tỉnh Lâm Đồng',' 0835500055 ','https://vuonhungthinh.com/'),
    ('NCC36',N'Phong Linh Food',N'Cây xăng 74, Ngọc Hồi, Thanh Trì, Hà Nội',' 0972813893 ','https://phonglinhfood.com/'),
    ('NCC37',N'Rau Xanh',N'27 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 0783536798 ','https://sibafood.vn/collections/rau-xanh'),
    ('NCC38',N'Nakayama Food',N'5E10 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 089236798 ','https://www.nakayama-foods.vn/'),
    ('NCC39',N'Tiến vua Food',N'Số 8 Võ Văn Ngân, TP Thủ Đức',' 0123457812 ','https://www.foody.vn'),
    ('NCC40',N'Vua Gạo Food',N'177/24, Đường 3/2, Phường 11, Quận 10, TPHCM',' 18008012 ','https://www.linkedin.com'),
	('NCC41',N'Phúc Đạt Food',N'83 Phan Văn Hân, P.17, Bình Thạnh, HCM','0909090909','https://phucdatfood.com/cua-hang'),
    ('NCC42',N'Đồng Xanh',N'34/23 Hoàng Ngọc Phách, P. Phú Thọ Hoà, Q.Tân Phú, TP.HCM','0936685268 ','https://kaifood.com'),
    ('NCC43',N'Đại Phong',N'Lô 15A, Khu Công nghiệp Trà Nóc 1, P.Trà Nóc, Q.Bình Thủy, Tp.Cần Thơ','02923842486 ','https://daiphong.com.vn/'),
    ('NCC44',N'Thực Phẩm Sạch HD',N'1164 Phạm Văn Đồng, P.Linh Đông, Tp.Thủ Đức',' 0833300055 ','https://www.thucphamsachhd.com/'),
    ('NCC45',N'Nhà Vườn Hưng Thịnh',N'Thôn Hoàn Kiếm 2, xã Nam Hà, huyện Lâm Hà, tỉnh Lâm Đồng',' 0835500055 ','https://vuonhungthinh.com/'),
    ('NCC46',N'Phong Linh Food',N'Cây xăng 74, Ngọc Hồi, Thanh Trì, Hà Nội',' 0972813893 ','https://phonglinhfood.com/'),
    ('NCC47',N'Rau Xanh',N'27 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 0783536798 ','https://sibafood.vn/collections/rau-xanh'),
    ('NCC48',N'Nakayama Food',N'5E10 Đường số 9, Khu phố 4, Phường Bình An, Quận 2, TP. Hồ Chí Minh',' 089236798 ','https://www.nakayama-foods.vn/'),
    ('NCC49',N'Tiến vua Food',N'Số 8 Võ Văn Ngân, TP Thủ Đức',' 0123457812 ','https://www.foody.vn'),
    ('NCC50',N'Vua Gạo Food',N'177/24, Đường 3/2, Phường 11, Quận 10, TPHCM',' 18008012 ','https://www.linkedin.com')
go
insert into MATHANG
values('MH001',N'Gà Truyền Thống',N'miếng','100','20000','35000','1'),
('MH002',N'Gà Giòn Cay',N'miếng','120','20000','35000','2'),
('MH003',N'Cánh gà Hot Wings',N'miếng','125','10000','15000','1'),
('MH004',N'Đùi Gà',N'miếng','100','20000','35000','2'),
('MH005',N'Đùi Gà quay tiêu',N'miếng','100','50000','66000','2'),
('MH006',N'Burger Zinger',N'cái','80','35000','49000','6'),
('MH007',N'Burger Tôm',N'cái','80','32000','42000','6'),
('MH008',N'Burger Gà quay Flar',N'cái','100','35000','45000','6'),
('MH009',N'Gà Giòn Cay',N'miếng','120','20000','35000','2'),
('MH010',N'Cơm PHI-LÊ Gà Quay Tiêu',N'phần','90','30000','41000','3')

go
insert into LOAIHANG
values('1',N'cánh'),
('2',N'đùi'),
('3',N'cơm'),
('4',N'sữa'),
('5',N'nước ngọt'),
('6',N'bánh'),
('7',N'mì'),
('8',N'salad'),
('9',N'gà viên'),
('10',N'nước khoáng')
go
insert into CTHOADON
values('HD001','MH005','10','66000','660000'),
('HD006','MH004','5','35000','175000'),
('HD003','MH007','3','42000','126000'),
('HD007','MH009','4','35000','140000'),
('HD005','MH001','3','35000','210000'),
('HD002','MH003','12','15000','180000'),
('HD009','MH009','23','35000','805000'),
('HD008','MH003','15','15000','225000'),
('HD010','MH010','17','41000','697000'),
('HD004','MH002','10','35000','350000')
go
insert into HOADON
values('HD001','KH001','NV002','660000','02/03/2022',N'tiền mặt'),
('HD002','KH002','NV003','180000','01/22/2022',N'chuyển khoản'),
('HD003','KH003','NV008','126000','11/23/2022',N'chuyển khoản'),
('HD004','KH004','NV003','350000','12/02/2022',N'tiền mặt'),
('HD005','KH005','NV005','210000','08/19/2022',N'tiền mặt'),
('HD006','KH006','NV009','175000','01/22/2022',N'chuyển khoản'),
('HD007','KH007','NV006','140000','08/22/2022',N'tiền mặt'),
('HD008','KH008','NV007','225000','09/08/2022',N'chuyển khoản'),
('HD009','KH009','NV002','805000','01/02/2022',N'chuyển khoản'),
('HD010','KH010','NV004','697000','12/22/2022',N'tiền mặt'),
('HD011','KH001','NV002','660000','02/03/2022',N'tiền mặt'),
('HD012','KH002','NV003','180000','01/22/2022',N'chuyển khoản'),
('HD013','KH003','NV008','126000','11/23/2022',N'chuyển khoản'),
('HD014','KH004','NV003','350000','12/02/2022',N'tiền mặt'),
('HD015','KH005','NV005','210000','08/19/2022',N'tiền mặt'),
('HD016','KH006','NV009','175000','01/22/2022',N'chuyển khoản'),
('HD017','KH007','NV006','140000','08/22/2022',N'tiền mặt'),
('HD018','KH008','NV007','225000','09/08/2022',N'chuyển khoản'),
('HD019','KH009','NV002','805000','01/02/2022',N'chuyển khoản'),
('HD020','KH010','NV004','697000','12/22/2022',N'tiền mặt'),
('HD021','KH001','NV002','660000','02/03/2022',N'tiền mặt'),
('HD022','KH002','NV003','180000','01/22/2022',N'chuyển khoản'),
('HD023','KH003','NV008','126000','11/23/2022',N'chuyển khoản'),
('HD024','KH004','NV003','350000','12/02/2022',N'tiền mặt'),
('HD025','KH005','NV005','210000','08/19/2022',N'tiền mặt'),
('HD026','KH006','NV009','175000','01/22/2022',N'chuyển khoản'),
('HD027','KH007','NV006','140000','08/22/2022',N'tiền mặt'),
('HD028','KH008','NV007','225000','09/08/2022',N'chuyển khoản'),
('HD029','KH009','NV002','805000','01/02/2022',N'chuyển khoản'),
('HD030','KH010','NV004','697000','12/22/2022',N'tiền mặt'),
('HD031','KH001','NV002','660000','02/03/2022',N'tiền mặt'),
('HD032','KH002','NV003','180000','01/22/2022',N'chuyển khoản'),
('HD033','KH003','NV008','126000','11/23/2022',N'chuyển khoản'),
('HD034','KH004','NV003','350000','12/02/2022',N'tiền mặt'),
('HD035','KH005','NV005','210000','08/19/2022',N'tiền mặt'),
('HD036','KH006','NV009','175000','01/22/2022',N'chuyển khoản'),
('HD037','KH007','NV006','140000','08/22/2022',N'tiền mặt'),
('HD038','KH008','NV007','225000','09/08/2022',N'chuyển khoản'),
('HD039','KH009','NV002','805000','01/02/2022',N'chuyển khoản'),
('HD040','KH010','NV004','697000','12/22/2022',N'tiền mặt'),
('HD041','KH001','NV002','660000','02/03/2022',N'tiền mặt'),
('HD042','KH002','NV003','180000','01/22/2022',N'chuyển khoản'),
('HD043','KH003','NV008','126000','11/23/2022',N'chuyển khoản'),
('HD044','KH004','NV003','350000','12/02/2022',N'tiền mặt'),
('HD045','KH005','NV005','210000','08/19/2022',N'tiền mặt'),
('HD046','KH006','NV009','175000','01/22/2022',N'chuyển khoản'),
('HD047','KH007','NV006','140000','08/22/2022',N'tiền mặt'),
('HD048','KH008','NV007','225000','09/08/2022',N'chuyển khoản'),
('HD049','KH009','NV002','805000','01/02/2022',N'chuyển khoản'),
('HD050','KH010','NV004','697000','12/22/2022',N'tiền mặt')
go
insert into PHIEUNHAP
values ('PN001','NV001','NCC01','8000000','01/05/2022','Nhập nguyên liệu thịt gà tháng 1 năm 2022'),
('PN002','NV001','NCC08','7500000','01/05/2022','Nhập nguyên liệu rau củ tháng 1 năm 2022'),
('PN003','NV001','NCC01','400000','02/05/2022','Nhập nguyên liệu tháng thịt gà 2 năm 2022'),
('PN004','NV007','NCC07','900000','02/05/2022','Nhập nguyên liệu rau củ tháng 2 năm 2022'),
('PN005','NV007','NCC01','1500000','03/05/2022','Nhập nguyên liệu thịt gà tháng 3 năm 2022'),
('PN006','NV006','NCC06','2900000','03/05/2022','Nhập nguyên liệu rau củ tháng 3 năm 2022'),
('PN007','NV001','NCC01','4800000','04/05/2022','Nhập nguyên liệu thịt gà tháng 4 năm 2022'),
('PN008','NV002','NCC10','600000','04/05/2022','Nhập nguyên liệu  rau củ tháng 4 năm 2022'),
('PN009','NV004','NCC09','3000000','05/05/2022','Nhập nguyên liệu thịt gà tháng 5 năm 2022'),
('PN010','NV001','NCC03','2400000','05/05/2022','Nhập nguyên liệu rau củ tháng 5 năm 2022')
go
insert into PHIEUXUAT
values ('PX001','01/10/2022','Xuất kho tháng 1 năm 2022','NV001','75000'),
('PX002','01/20/2022','Xuất kho tháng 1 năm 2022','NV001','102000'),
('PX003','02/10/2022','Xuất kho tháng 2 năm 2022','NV001','100000'),
('PX004','02/20/2022','Xuất kho tháng 2 năm 2022','NV007','300000'),
('PX005','03/10/2022','Xuất kho tháng 3 năm 2022','NV007','430000'),
('PX006','03/20/2022','Xuất kho tháng 3 năm 2022','NV007','200000'),
('PX007','04/20/2022','Xuất kho tháng 4 năm 2022','NV001','350000'),
('PX008','04/10/2022','Xuất kho tháng 4 năm 2022','NV002','80000'),
('PX009','05/20/2022','Xuất kho tháng 5 năm 2022','NV004','75000'),
('PX010','05/10/2022','Xuất kho tháng 5 năm 2022','NV001','103000')
insert into CTPHIEUXUAT
values ('PX001','MH001','100','12000'),
('PX002','MH002','150','45000'),
('PX003','MH007','50','22000'),
('PX004','MH009','38','35000'),
('PX005','MH004','40','3600'),
('PX006','MH010','50','14000'),
('PX007','MH006','25','2100'),
('PX008','MH004','50','2400'),
('PX009','MH001','120','7800'),
('PX010','MH002','200','2400')
insert into CTPHIEUNHAP
values ('PN001','MH001','100','7500'),
('PN002','MH002','200','10200'),
('PN003','MH007','50','10000'),
('PN004','MH009','30','30000'),
('PN005','MH004','40','43000'),
('PN006','MH009','50','20000'),
('PN007','MH006','25','35000'),
('PN008','MH004','50','8000'),
('PN009','MH001','120','7500'),
('PN010','MH002','200','10300')
go
insert into QUYEN
values ('1','Quản trị viên',''),
('2','Nhân viên','')
go
insert into USERS
values ('1','NV001','Admin1','123451','1'),
('2','NV002','Admin2','123452','2'),
('3','NV003','Admin3','123453','2'),
('4','NV004','Admin4','123454','2'),
('5','NV005','Admin5','123455','1'),
('6','NV006','Admin6','123456','2'),
('7','NV007','Admin7','123457','1'),
('8','NV008','Admin8','123458','2'),
('9','NV009','Admin9','123459','1'),
('10','NV010','Admin10','123450','2')

