-- Question 2: 
SELECT
  *
FROM Courses c
WHERE c.credits > 3;
-- Question 3:
SELECT
  a.id AS AsessmentId
 ,a.type
 ,a.name
 ,a.[percent]
 ,c.title AS CourseTitle
FROM Assessments a
JOIN Courses c
  ON a.courseId = c.id
WHERE c.title = 'Introduction to Databases';

-- Question 4:
SELECT
  e.studentId
 ,s.name AS StudentName
 ,s.department
 ,s1.code AS SemesterCode
 ,s1.year
 ,c.title AS CourseTitle
FROM Students s
JOIN enroll e
  ON s.id = e.studentId
JOIN Courses c
  ON e.courseId = c.id
JOIN semesters s1
  ON e.semesterId = s1.id
WHERE c.title = 'Operating Systems'
ORDER BY s1.year, s1.code, e.studentId;

-- Question 5
SELECT
  c.id AS CourseId
 ,c.code
 ,c.title
 ,COUNT(DISTINCT e1.studentId) AS NumberOfEnrolledStudents
FROM Courses c
LEFT JOIN (SELECT
    *
  FROM enroll e
  JOIN semesters s
    ON e.semesterId = s.id
  WHERE s.year = 2019) AS e1
  ON c.id = e1.courseId
GROUP BY c.id
        ,c.code
        ,c.title;

-- Question 6
SELECT
  a1.courseId
 ,a1.code
 ,a1.title
 ,a1.NumberOfAssessmentTypes
 ,a1.NumberOfAssessments
FROM (SELECT
    c.id AS CourseId
   ,c.code
   ,c.title
   ,COUNT(DISTINCT a.type) AS NumberOfAssessmentTypes
   ,COUNT(c.id) AS NumberOfAssessments
   ,RANK() OVER (ORDER BY COUNT(c.id) DESC) AS rnk
  FROM Courses c
  JOIN Assessments a
    ON c.id = a.courseId
  GROUP BY c.id
          ,c.code
          ,c.title) AS a1
WHERE a1.rnk = 1;

-- Question 7:
SELECT
  e.enrollId
 ,e.courseId
 ,c.title
 ,e.studentId
 ,s.name AS StudentName
 ,e.semesterId
 ,s1.code AS SemesterCode
 ,SUM(m.mark * a.[percent]) AS AverageMark
FROM enroll e
JOIN Courses c
  ON e.courseId = c.id
JOIN Students s
  ON e.studentId = s.id
JOIN semesters s1
  ON e.semesterId = s1.id
JOIN marks m
  ON e.enrollId = m.enrollId
JOIN Assessments a
  ON a.id = m.assessmentId
WHERE c.title = 'Introduction to Databases'
GROUP BY e.enrollId
        ,e.courseId
        ,c.title
        ,e.studentId
        ,s.name
        ,e.semesterId
        ,s1.code
ORDER BY e.studentId, e.semesterId desc
