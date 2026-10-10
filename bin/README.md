# Job Application Portal

A complete job application portal built with Java Servlets, JSP, JDBC, and MySQL as a college Java mini-project.

## Features

- User authentication (login/register) with session management
- Role-based access control (Job Seeker and Admin)
- Job search and filtering
- Detailed job views
- Job application system
- Application tracking for users
- Admin dashboard for managing jobs, applications, and users
- Responsive design using Bootstrap 5
- Secure password hashing using BCrypt
- MySQL database for data persistence

## Technology Stack

- **Backend**: Java, Servlets, JSP, JDBC
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5, Bootstrap Icons
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Apache Tomcat

## Database Setup

1. Create the database and tables using the provided SQL script:
   ```bash
   mysql -u root -p < job_portal.sql
   ```

2. Update the database credentials in `src/main/java/com/jobportal/util/DBConnection.java` if needed:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/job_portal";
   private static final String USERNAME = "root"; // Change as needed
   private static final String PASSWORD = "password"; // Change as needed
   ```

## Running the Application

1. Build the project with Maven:
   ```bash
   mvn clean package
   ```

2. Deploy the generated WAR file to Apache Tomcat:
   - Copy `target/job-portal.war` to Tomcat's `webapps` directory
   - Or use the Maven Tomcat plugin:
     ```bash
     mvn tomcat7:run
     ```

3. Access the application at:
   ```
   http://localhost:8080/job-portal
   ```

## Default Admin Credentials

- Email: admin@jobportal.com
- Password: password

## Project Structure

```
src/
└── main/
    ├── java/
    │   └── com.jobportal/
    │       ├── controller/  # Servlets
    │       ├── dao/         # Data Access Objects
    │       ├── model/       # Entity classes
    │       ├── util/        # Utility classes (DBConnection)
    │       └── filter/      # Authentication filter
    └── webapp/
        ├── css/             # Stylesheets
        ├── js/              # JavaScript files
        ├── images/          # Image assets
        ├── WEB-INF/         # Configuration (web.xml)
        ├── admin/           # Admin JSP pages
        ├── index.jsp        # Landing page
        ├── login.jsp        # Login page
        ├── register.jsp     # Registration page
        ├── jobs.jsp         # Job listing page
        ├── job-details.jsp  # Job details page
        ├── profile.jsp      # User profile/dashboard
        ├── applications.jsp # User applications page
        └── admin/           # Admin pages
            ├── dashboard.jsp
            ├── jobs.jsp
            ├── applications.jsp
            └── users.jsp
```

## Screenshots

*(Add screenshots here)*

## License

This project is for educational purposes only.

## Acknowledgments

- Bootstrap 5 for responsive UI
- BCrypt for password hashing
- Maven for dependency management