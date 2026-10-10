<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Jobs - JobPortal Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="admin/sidebar.jsp" %>
    
    <div class="content p-4">
        <%@ include file="admin/header.jsp" %>
        
        <main class="mt-4">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3">Manage Jobs</h1>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#jobModal" data-action="add">
                        <i class="bi bi-plus-lg me-2"></i> Add New Job
                    </button>
                </div>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Company</th>
                                <th>Location</th>
                                <th>Type</th>
                                <th>Salary</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="job" items="${jobs}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${job.title}</td>
                                    <td>${job.company}</td>
                                    <td>${job.location}</td>
                                    <td>${job.jobType}</td>
                                    <td>${job.salary}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${job.status == 'ACTIVE'}">
                                                <span class="badge bg-success">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#jobModal" data-action="edit" data-id="${job.id}" data-title="${job.title}" data-company="${job.company}" data-location="${job.location}" data-jobType="${job.jobType}" data-salary="${job.salary}" data-experience="${job.experience}" data-description="${job.description}" data-requirements="${job.requirements}" data-skills="${job.skills}" data-deadline="${job.deadline}" data-status="${job.status}">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" data-job-id="${job.id}" data-job-title="${job.title}">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        
    <%@ include file="admin/footer.jsp" %>
    
    <script>
        // Handle modal for adding/editing jobs
        const jobModal = document.getElementById('jobModal');
        jobModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const action = button.getAttribute('data-action');
            const modalTitle = jobModal.querySelector('.modal-title');
            const formAction = document.getElementById('formAction');
            const formSubmitBtn = document.getElementById('formSubmitBtn');
            
            if (action === 'edit') {
                modalTitle.textContent = 'Edit Job';
                formAction.value = 'edit';
                formSubmitBtn.textContent = 'Update Job';
                
                // Populate form fields
                document.getElementById('jobId').value = button.getAttribute('data-id');
                document.getElementById('jobTitle').value = button.getAttribute('data-title');
                document.getElementById('jobCompany').value = button.getAttribute('data-company');
                document.getElementById('jobLocation').value = button.getAttribute('data-location');
                document.getElementById('jobType').value = button.getAttribute('data-jobType');
                document.getElementById('jobSalary').value = button.getAttribute('data-salary');
                document.getElementById('jobExperience').value = button.getAttribute('data-experience');
                document.getElementById('jobDescription').value = button.getAttribute('data-description');
                document.getElementById('jobRequirements').value = button.getAttribute('data-requirements');
                document.getElementById('jobSkills').value = button.getAttribute('data-skills');
                document.getElementById('jobDeadline').value = button.getAttribute('data-deadline');
                document.getElementById('jobStatus').value = button.getAttribute('data-status');
            } else {
                modalTitle.textContent = 'Add New Job';
                formAction.value = 'add';
                formSubmitBtn.textContent = 'Add Job';
                
                // Clear form
                document.getElementById('jobForm').reset();
                document.getElementById('jobId').value = '';
            }
        });
        
        // Handle delete modal
        const deleteModal = document.getElementById('deleteModal');
        deleteModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const jobId = button.getAttribute('data-job-id');
            const jobTitle = button.getAttribute('data-job-title');
            
            document.getElementById('jobToDelete').textContent = jobTitle;
            document.getElementById('deleteJobId').value = jobId;
        });
    </script>
    </div>
    
    <!-- Add/Edit Job Modal -->
    <div class="modal fade" id="jobModal" tabindex="-1" aria-labelledby="jobModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="jobModalLabel">Add New Job</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="jobForm" action="${pageContext.request.contextPath}/admin/jobs" method="post">
                        <input type="hidden" name="action" id="formAction" value="add">
                        <input type="hidden" name="id" id="jobId">
                        
                        <div class="mb-3">
                            <label for="jobTitle" class="form-label">Job Title</label>
                            <input type="text" class="form-control" id="jobTitle" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="jobCompany" class="form-label">Company</label>
                            <input type="text" class="form-control" id="jobCompany" name="company" required>
                        </div>
                        <div class="mb-3">
                            <label for="jobLocation" class="form-label">Location</label>
                            <input type="text" class="form-control" id="jobLocation" name="location" required>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="jobType" class="form-label">Job Type</label>
                                    <select class="form-select" id="jobType" name="jobType" required>
                                        <option value="">Select Job Type</option>
                                        <option value="Full-time">Full-time</option>
                                        <option value="Part-time">Part-time</option>
                                        <option value="Contract">Contract</option>
                                        <option value="Internship">Internship</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="jobSalary" class="form-label">Salary</label>
                                    <input type="text" class="form-control" id="jobSalary" name="salary" placeholder="e.g. $80,000 - $100,000">
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="jobExperience" class="form-label">Experience Required</label>
                            <input type="text" class="form-control" id="jobExperience" name="experience" placeholder="e.g. 2-4 years">
                        </div>
                        <div class="mb-3">
                            <label for="jobDescription" class="form-label">Job Description</label>
                            <textarea class="form-control" id="jobDescription" name="description" rows="4" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="jobRequirements" class="form-label">Requirements</label>
                            <textarea class="form-control" id="jobRequirements" name="requirements" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="jobSkills" class="form-label">Skills (comma separated)</label>
                            <input type="text" class="form-control" id="jobSkills" name="skills" placeholder="e.g. Java, Spring Boot, MySQL" required>
                        </div>
                        <div class="mb-3">
                            <label for="jobDeadline" class="form-label">Deadline</label>
                            <input type="date" class="form-control" id="jobDeadline" name="deadline">
                        </div>
                        <div class="mb-3">
                            <label for="jobStatus" class="form-label">Status</label>
                            <select class="form-select" id="jobStatus" name="status" required>
                                <option value="ACTIVE">Active</option>
                                <option value="INACTIVE">Inactive</option>
                            </select>
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" id="formSubmitBtn">Save Job</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Job Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Delete Job</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete "<span id="jobToDelete"></span>?"</p>
                    <p class="text-danger">This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" action="${pageContext.request.contextPath}/admin/jobs" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="deleteJobId">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="admin/footer.jsp" %>
</body>
</html>