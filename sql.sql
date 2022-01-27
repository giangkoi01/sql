 /********* A. BASIC QUERY *********/

-- 1. Li?t kê danh sách sinh viên s?p x?p theo th? t?:
--      a. id t?ng d?n
SELECT * FROM student
ORDER BY id;
--      b. gi?i tính
select * from student order by gender asc
--      c. ngày sinh T?NG D?N và h?c b?ng GI?M D?N
SELECT * FROM student
ORDER BY birthday, scholarship desc;
-- 2. Môn h?c có tên b?t ??u b?ng ch? 'T'
SELECT * FROM subject
where NAME like 'T%'

-- 3. Sinh viên có ch? cái cu?i cùng trong tên là 'i'
SELECT * FROM student
WHERE NAME like '%i'
-- 4. Nh?ng khoa có ký t? th? hai c?a tên khoa có ch?a ch? 'n'
SELECT * FROM faculty
WHERE NAME like '_n%'
-- 5. Sinh viên trong tên có t? 'Th?'
SELECT * FROM student
WHERE NAME like '%Th?%'
-- 6. Sinh viên có ký t? ??u tiên c?a tên n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? tên sinh viên
select * from student where name between 'a%' and 'm%' order by name asc
-- 7. Sinh viên có h?c b?ng l?n h?n 100000, s?p x?p theo mã khoa gi?m d?n
SELECT * FROM student
WHERE SCHOLARSHIP > 100000
ORDER BY FACULTY_ID desc
-- 8. Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i
SELECT * FROM student
WHERE SCHOLARSHIP > 150000 and HOMETOWN like 'Hà N?i'
-- 9. Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 ??n ngày 05/06/1992
select * from student where birthday between  to_date('19910101', 'YYYYMMDD') and to_date('19920605', 'YYYYMMDD')
-- 10. Nh?ng sinh viên có h?c b?ng t? 80000 ??n 150000
SELECT
    *
FROM student
WHERE SCHOLARSHIP BETWEEN 80000 and 150000
-- 11. Nh?ng môn h?c có s? ti?t l?n h?n 30 và nh? h?n 45
SELECT * FROM subject WHERE lesson_quantity > 30 and lesson_quantity < 45

-- 1. Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: Mã sinh viên, Gi?i tính, Mã 
		-- khoa, M?c h?c b?ng. Trong ?ó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr? 
		-- c?a h?c b?ng l?n h?n 500,000 và ng??c l?i hi?n th? là “M?c trung bình”.
    select student.id, GENDER, faculty_id, 
    CASE when scholarship > 500000 then 'H?c b?ng cao' else 'M?c trung bình' end scholarship
    from student 
    
-- 2. Tính t?ng s? sinh viên c?a toàn tr??ng
select count (*) as tongsv from student
-- 3. Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
select gender,count(*)  from student group by gender
-- 4. Tính t?ng s? sinh viên t?ng khoa
select faculty_id,count(*) from student group by faculty_id
-- 5. Tính t?ng s? sinh viên c?a t?ng môn h?c
select student_id, count(subject_id) from exam_management group by student_id
-- 6. Tính s? l??ng môn h?c mà sinh viên ?ã h?c
select student_id, count(subject_id)
from exam_management
group by student_id; 
-- 7. T?ng s? h?c b?ng c?a m?i khoa	
select faculty.name, sum(student.scholarship) from faculty, student where faculty.id = student.faculty_id group by faculty.id,faculty.name;
-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
select faculty.name, max(student.scholarship) from faculty, student where faculty.id = student.faculty_id group by faculty.id, faculty.name;
-- 9. Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa
select faculty.name, gender, count(*) from student,faculty where student.faculty_id=faculty.id  group by faculty.id, faculty.name, gender
--10. Cho biết số lượng sinh viên theo từng độ tuổi
select birthday, count(id) from student group by birthday;
-- 11. Cho bi?t nh?ng n?i nào có ít nh?t 2 sinh viên ?ang theo h?c t?i tr??ng
select hometown, count(id) from student group by hometown having count(id)>=2
-- 12. Cho biết những sinh viên thi lại ít nhất 2 lần
select name, subject_id, count(number_of_exam_taking) 
from exam_management, student 
where student.id = exam_management.student_id
group by name, subject_id 
having count(number_of_exam_taking) >= 2;
-- 13. Cho bi?t nh?ng sinh viên nam có ?i?m trung bình l?n 1 trên 7.0 
select student.name , AVG(mark)
from exam_management, student
where exam_management.student_id=student.id
and exam_management.number_of_exam_taking=1
and student.gender='Nam'
group by student.id, student.name
having AVG(mark)>7

SELECT * FROM student;
SELECT * FROM faculty;
SELECT * FROM subject;
SELECT * FROM exam_management
-- 14. Cho bi?t danh sách các sinh viên r?t ít nh?t 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)
select student.name from student, exam_management
where student.id = exam_management.student_id and exam_management.number_of_exam_taking = 1 and exam_management.mark <= 4 group by student.id, student.name;
-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam
select faculty.name, count (student.id)
from faculty, student
where student.faculty_id=faculty.id
and student.gender='Nam'
group by faculty.id, faculty.name
having count(student.id)>=2;

-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000
SELECT faculty_id, count(faculty_id) FROM student group by faculty_id
having count(faculty_id) = 2
-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t
select name, max(scholarship) 
from student
where scholarship = (select max(scholarship) from student)
group by name;

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có n?i sinh ? Hà N?i và sinh vào tháng 02
select name,birthday  from student where to_char(birthday,'MM')='02' and student.hometown = 'Hà N?i';
-- 2. Sinh viên có tu?i l?n h?n 20
select student.name, current_year - to_number(to_char(student.birthday, 'YYYY')) as age
from student, (select to_number(to_char(sysdate, 'YYYY')) current_year from dual)
where current_year - to_number(to_char(student.birthday, 'YYYY')) > 20;
-- 3. Sinh viên sinh vào mùa xuân n?m 1990'
select name, birthday from student where to_number(to_char(birthday,'MM'))<4;
/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH V?N và khoa V?T LÝ
select student.name 
from student join faculty on student.faculty_id = faculty.id
where faculty.name ='Anh - Văn' or faculty.name ='Vật lý'
-- 2. Nh?ng sinh viên nam c?a khoa ANH V?N và khoa TIN H?C
select student.name 
from student,faculty
where student.faculty_id = faculty.id and (faculty.name = 'Anh - Văn' or faculty.name = 'Tin Học') and student.gender = 'Nam'
-- 3. Cho bi?t sinh viên nào có ?i?m thi l?n 1 môn c? s? d? li?u cao nh?t
select name, mark from exam_management
join student on student.id = exam_management.student_id
where number_of_exam_taking = 1 and subject_id = 1
and mark = (select max(mark) from exam_management
where number_of_exam_taking = 1 and subject_id = 1);
-- 4. Cho bi?t sinh viên khoa anh v?n có tu?i l?n nh?t.

-- 5. Cho bi?t khoa nào có ?ông sinh viên nh?t
select faculty.name, count(student.id) from faculty, student    
where faculty.id = student.faculty_id 
group by faculty.name having count(student.faculty_id) >= all(select count(student.id) from student group by student.faculty_id);
-- 6. Cho bi?t khoa nào có ?ông n? nh?t
select faculty.name, gender, count(gender) from faculty,student
where faculty.id = student.faculty_id and gender = 'Nữ'
group by faculty.name, gender having count(student.faculty_id) >= all(select count(gender) from student where gender ='Nữ' group by student.faculty_id);
-- 7. Cho bi?t nh?ng sinh viên ??t ?i?m cao nh?t trong t?ng môn

-- 8. Cho bi?t nh?ng khoa không có sinh viên h?c
select faculty.name, count(student.id) from faculty
inner join student on faculty.id = student.faculty_id
group by faculty.name having count(student.id) = 0;
-- 9. Cho bi?t sinh viên ch?a thi môn c? s? d? li?u

-- 10. Cho bi?t sinh viên nào không thi l?n 1 mà có d? thi l?n 2