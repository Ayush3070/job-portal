<![CDATA[
-- Job Application Portal Database
-- Database: job_portal
-- DROP DATABASE IF EXISTS job_portal;
-- CREATE DATABASE job_portal;
-- USE job_portal;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('JOB_SEEKER', 'ADMIN') DEFAULT 'JOB_SEEKER',
    location VARCHAR(100),
    skills TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Jobs table
CREATE TABLE jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    company VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    job_type VARCHAR(50), -- Full-time, Part-time, Contract, Internship
    salary VARCHAR(50),
    experience VARCHAR(50),
    description TEXT,
    requirements TEXT,
    skills TEXT,
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deadline DATE,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE'
);

-- Applications table
CREATE TABLE applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    job_id INT NOT NULL,
    cover_letter TEXT,
    resume VARCHAR(255), -- stores the file name or path
    application_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Applied', 'Under Review', 'Shortlisted', 'Rejected', 'Selected') DEFAULT 'Applied',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE
);

-- Optional: Companies table (if needed, but we are storing company name in jobs table for simplicity)
-- CREATE TABLE companies (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     company_name VARCHAR(100) NOT NULL,
--     description TEXT,
--     location VARCHAR(100),
--     website VARCHAR(255)
-- );

-- Insert sample data

-- Admin user
INSERT INTO users (full_name, email, password, phone, role, location, skills)
VALUES ('Admin User', 'admin@jobportal.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '1234567890', 'ADMIN', 'New York', 'Admin, Management');

-- Note: The above password is 'password' hashed with bcrypt (cost 10). 
-- In a real application, you would generate a proper hash.

-- Sample users (Job Seekers)
INSERT INTO users (full_name, email, password, phone, role, location, skills)
VALUES 
('John Doe', 'john.doe@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '1234567890', 'JOB_SEEKER', 'New York', 'Java, Spring Boot, MySQL'),
('Jane Smith', 'jane.smith@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '0987654321', 'JOB_SEEKER', 'San Francisco', 'Python, Django, Data Science'),
('Robert Johnson', 'robert.johnson@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '1122334455', 'JOB_SEEKER', 'Seattle', 'JavaScript, React, Node.js'),
('Emily Davis', 'emily.davis@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '2233445566', 'JOB_SEEKER', 'Austin', 'UI/UX Design, Figma, Adobe XD'),
('Michael Brown', 'michael.brown@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '3344556677', 'JOB_SEEKER', 'Boston', 'AWS, DevOps, Docker'),
('Sarah Wilson', 'sarah.wilson@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '4455667788', 'JOB_SEEKER', 'Chicago', 'C#, .NET, SQL Server'),
('David Lee', 'david.lee@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '5566778899', 'JOB_SEEKER', 'Los Angeles', 'Machine Learning, TensorFlow, Python'),
('Lisa Taylor', 'lisa.taylor@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '6677889900', 'JOB_SEEKER', 'Denver', 'Cybersecurity, Ethical Hacking, Networking'),
('James Clark', 'james.clark@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '7788990011', 'JOB_SEEKER', 'Atlanta', 'Project Management, Agile, Scrum'),
('Laura Martinez', 'laura.martinez@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeG3ZlKUxW6VxV4YbV5V6V7V8V9V0V1V2', '8899001122', 'JOB_SEEKER', 'Miami', 'Digital Marketing, SEO, SEM');

-- Sample jobs
INSERT INTO jobs (title, company, location, job_type, salary, experience, description, requirements, skills, posted_date, deadline, status)
VALUES 
('Java Developer', 'Google', 'Mountain View, CA', 'Full-time', '$120,000 - $150,000', '3-5 years', 'We are looking for a skilled Java Developer to join our team.', 'Strong Java experience, Spring Boot, Microservices', 'Java, Spring Boot, Microservices, REST API', DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_ADD(NOW(), INTERVAL 20 DAY), 'ACTIVE'),
('Frontend Developer', 'Microsoft', 'Redmond, WA', 'Full-time', '$110,000 - $140,000', '2-4 years', 'Create responsive web applications using modern frontend technologies.', 'Proficiency in HTML, CSS, JavaScript, React', 'HTML, CSS, JavaScript, React, TypeScript', DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_ADD(NOW(), INTERVAL 25 DAY), 'ACTIVE'),
('Data Analyst', 'TCS', 'New York, NY', 'Full-time', '$80,000 - $100,000', '2-3 years', 'Analyze large datasets to provide business insights.', 'SQL, Python, Data Visualization', 'SQL, Python, Tableau, Power BI', DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_ADD(NOW(), INTERVAL 15 DAY), 'ACTIVE'),
('Machine Learning Engineer', 'Amazon', 'Seattle, WA', 'Full-time', '$130,000 - $160,000', '3-5 years', 'Build and deploy machine learning models at scale.', 'Python, TensorFlow, AWS', 'Python, Machine Learning, TensorFlow, AWS', DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_ADD(NOW(), INTERVAL 18 DAY), 'ACTIVE'),
('Cybersecurity Analyst', 'Deloitte', 'Chicago, IL', 'Full-time', '$90,000 - $115,000', '2-4 years', 'Protect organization from cyber threats and vulnerabilities.', 'Network security, Ethical hacking, SIEM', 'Cybersecurity, Network Security, Ethical Hacking, SIEM', DATE_SUB(NOW(), INTERVAL 12 DAY), DATE_ADD(NOW(), INTERVAL 22 DAY), 'ACTIVE'),
('Software Engineer', 'Infosys', 'Bangalore, India', 'Full-time', '$50,000 - $70,000', '1-3 years', 'Develop and maintain software applications.', 'Java, C++, Data Structures', 'Java, C++, Data Structures, Algorithms', DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_ADD(NOW(), INTERVAL 17 DAY), 'ACTIVE'),
('UI/UX Designer', 'Wipro', 'Austin, TX', 'Full-time', '$85,000 - $110,000', '2-4 years', 'Design user interfaces and experiences for web and mobile apps.', 'Figma, Adobe XD, User Research', 'UI/UX, Figma, Adobe XD, Wireframing', DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_ADD(NOW(), INTERVAL 13 DAY), 'ACTIVE'),
('Backend Developer', 'IBM', 'San Jose, CA', 'Full-time', '$100,000 - $130,000', '3-5 years', 'Develop server-side logic and APIs.', 'Java, Spring, Node.js', 'Java, Spring, Node.js, REST API', DATE_SUB(NOW(), INTERVAL 14 DAY), DATE_ADD(NOW(), INTERVAL 24 DAY), 'ACTIVE'),
('DevOps Engineer', 'Accenture', 'London, UK', 'Full-time', '$95,000 - $125,000', '3-5 years', 'Manage CI/CD pipelines and infrastructure.', 'Docker, Kubernetes, AWS', 'Docker, Kubernetes, AWS, Terraform', DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_ADD(NOW(), INTERVAL 16 DAY), 'ACTIVE'),
('Product Manager', 'Capgemini', 'Paris, France', 'Full-time', '$90,000 - $120,000', '4-6 years', 'Lead product development from concept to launch.', 'Agile, Scrum, Product Strategy', 'Product Management, Agile, Scrum, Roadmapping', DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_ADD(NOW(), INTERVAL 19 DAY), 'ACTIVE'),
('Java Developer', 'Google', 'New York, NY', 'Full-time', '$130,000 - $160,000', '5-7 years', 'Senior Java Developer position working on cloud platforms.', 'Advanced Java, Spring Cloud, GCP', 'Java, Spring Cloud, GCP, Microservices', DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_ADD(NOW(), INTERVAL 14 DAY), 'ACTIVE'),
('Frontend Developer', 'Microsoft', 'New York, NY', 'Full-time', '$120,000 - $150,000', '4-6 years', 'Lead frontend developer for enterprise applications.', 'Expert in React, Redux, TypeScript', 'React, Redux, TypeScript, Webpack', DATE_SUB(NOW(), INTERVAL 11 DAY), DATE_ADD(NOW(), INTERVAL 21 DAY), 'ACTIVE'),
('Data Scientist', 'TCS', 'San Francisco, CA', 'Full-time', '$110,000 - $140,000', '3-5 years', 'Develop predictive models and machine learning solutions.', 'Python, R, Statistics', 'Python, R, Machine Learning, Statistics', DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_ADD(NOW(), INTERVAL 12 DAY), 'ACTIVE'),
('AI Engineer', 'Amazon', 'New York, NY', 'Full-time', '$140,000 - $180,000', '4-6 years', 'Work on cutting-edge AI projects.', 'Deep Learning, PyTorch, AWS', 'AI, Deep Learning, PyTorch, AWS', DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_ADD(NOW(), INTERVAL 11 DAY), 'ACTIVE'),
('Network Engineer', 'Deloitte', 'Washington, DC', 'Full-time', '$85,000 - $110,000', '3-5 years', 'Design and maintain network infrastructure.', 'Cisco, CCNA, WAN/LAN', 'Cisco, CCNA, Network Engineering', DATE_SUB(NOW(), INTERVAL 13 DAY), DATE_ADD(NOW(), INTERVAL 23 DAY), 'ACTIVE'),
('Full Stack Developer', 'Infosys', 'Hyderabad, India', 'Full-time', '$60,000 - $80,000', '2-4 years', 'Work on both frontend and backend technologies.', 'Java, Angular, MySQL', 'Java, Angular, MySQL, REST API', DATE_SUB(NOW(), INTERVAL 16 DAY), DATE_ADD(NOW(), INTERVAL 26 DAY), 'ACTIVE'),
('UX Researcher', 'Wipro', 'Boston, MA', 'Full-time', '$80,000 - $105,000', '2-4 years', 'Conduct user research to inform design decisions.', 'User Interviews, Surveys, Analytics', 'UX Research, User Testing, Analytics', DATE_SUB(NOW(), INTERVAL 17 DAY), DATE_ADD(NOW(), INTERVAL 27 DAY), 'ACTIVE'),
('Cloud Architect', 'IBM', 'San Francisco, CA', 'Full-time', '$150,000 - $200,000', '6-8 years', 'Design cloud infrastructure and migration strategies.', 'AWS, Azure, GCP', 'Cloud Architecture, AWS, Azure, GCP', DATE_SUB(NOW(), INTERVAL 18 DAY), DATE_ADD(NOW(), INTERVAL 28 DAY), 'ACTIVE'),
('Security Consultant', 'Accenture', 'Dubai, UAE', 'Full-time', '$100,000 - $130,000', '4-6 years', 'Provide security consulting services to clients.', 'CISSP, Ethical Hacking, Risk Assessment', 'Security Consulting, CISSP, Ethical Hacking', DATE_SUB(NOW(), INTERVAL 19 DAY), DATE_ADD(NOW(), INTERVAL 29 DAY), 'ACTIVE');

-- Sample applications
INSERT INTO applications (user_id, job_id, cover_letter, resume, application_date, status)
VALUES 
(1, 1, 'I am excited to apply for this position...', 'resume_john_doe.pdf', DATE_SUB(NOW(), INTERVAL 5 DAY), 'Applied'),
(2, 2, 'With my experience in frontend development...', 'resume_jane_smith.pdf', DATE_SUB(NOW(), INTERVAL 4 DAY), 'Under Review'),
(3, 3, 'I have a strong background in data analysis...', 'resume_robert_johnson.pdf', DATE_SUB(NOW(), INTERVAL 3 DAY), 'Shortlisted'),
(4, 4, 'My passion for UI/UX design drives me...', 'resume_emily_davis.pdf', DATE_SUB(NOW(), INTERVAL 2 DAY), 'Selected'),
(5, 5, 'I am eager to contribute to your cybersecurity team...', 'resume_michael_brown.pdf', DATE_SUB(NOW(), INTERVAL 1 DAY), 'Rejected');

-- Note: The password for all sample users is 'password' (hashed).
-- In a real application, each user should have a unique password.
]]>