use test2;
CREATE TABLE Subjects (SubjectID INT PRIMARY KEY, SubjectName NVARCHAR(50));
CREATE TABLE Mark (Mark INT, SubjectID INT, StudentID INT);
CREATE TABLE Student (StudentID INT PRIMARY KEY, SubjectName NVARCHAR(50), Age INT, Email VARCHAR(100));
CREATE TABLE ClassStudent (StudentID INT, ClassID INT);
CREATE TABLE Classes (ClassID INT PRIMARY KEY, SubjectName NVARCHAR(50));
INSERT INTO student (StudentID, StudentName, Age, Email) 
VALUE (1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
	  (2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
      (3, 'Nguyen Van Quyet', 19, 'quyet@gmail.com'),
      (4, 'Pham Thanh Binh', 25, 'binh@gmail.com'),
      (5, 'Nguyen Van Tai Em', 30,'taiem@sport.com');
INSERT INTO Classes (ClassID, ClassName)
VALUE (1, 'C0706L'),
	  (2,'C0708G');
INSERT INTO ClassStudent (StudentID, ClassID)
VALUE (1,1),
	  (2,1),
      (3,2),
      (4,2),
      (5,2);
INSERT INTO Subjects (SubjectID, SubjectName)
VALUE (1, 'SQL'),
	  (2, 'Java'),
      (3, 'C'),
      (4, 'Visual Basic');
INSERT INTO Mark (Mark, SubjectID, StudentID)
VALUE (8,1,1),
	  (4,2,1),
      (9,1,1),
      (7,1,3),
      (3,1,4),
      (5,2,5),
      (8,3,3),
      (1,3,5),
      (3,2,4);
      
# 1.	Hien thi danh sach tat ca cac hoc vien 
SELECT * FROM student;

# 2.	Hien thi danh sach tat ca cac mon hoc
SELECT * FROM Subjects;

# 3.	Tinh diem trung binh 
SELECT AVG(Mark) FROM Mark;

# 4.	Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
SELECT Max(Mark) AS highest_score, Subjects.SubjectID, student.StudentID From Mark 
JOIN Subjects ON Mark.SubjectID=Subjects.SubjectID
JOIN Student ON Mark.StudentID=student.StudentID
GROUP BY Subjects.SubjectID, student.StudentID;


SELECT student.StudentName AS StudentName, Subjects.SubjectName AS SubjectName, Mark.Mark
FROM Mark
INNER JOIN Student ON Mark.StudentID = student.StudentID
INNER JOIN Subjects ON Mark.SubjectID = Subjects.SubjectID
WHERE Mark = (SELECT MAX(Mark) FROM Mark);

# 5.	Danh so thu tu cua diem theo chieu giam
SET @row_number = 0;
SELECT (@row_number:=@row_number + 1) as 'STT', Mark 
FROM Mark
ORDER BY Mark DESC;

# 6.	Thay doi kieu du lieu cua cot SubjectName trong bang Subjectss thanh nvarchar(max)
ALTER TABLE Subjects MODIFY SubjectName LONGTEXT;
# Trong mySQL không có kiểu dữ liệu nvarchar nhưng thay vào đó là LONGTEXT 

# 7.	Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
UPDATE Subjects SET SubjectName = concat(SubjectName,"Day là mon hoc ");
UPDATE  subjects SET subjects.SubjectName=concat(subjects.SubjectName, "Day la mon hoc");
SELECT SubjectID, CONCAT("Day là mon hoc ", SubjectName) AS SubjectName FROM Subjects;

# 8.	Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
ALTER TABLE Student ADD CONSTRAINT check_age CHECK (Age > 15 AND Age < 50);
SET SQL_SAFE_UPDATES = 0;





