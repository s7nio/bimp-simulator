<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<script type="text/javascript" src="./js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="./js/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="./js/bimp.file.js"></script>
<script type="text/javascript" src="./js/bimp.parse.js"></script>
<script type="text/javascript" src="./js/bimp.forms.js"></script>
<script type="text/javascript" src="./js/javascript.js"></script>

<link rel="stylesheet" type="text/css" href="./css/style.css"></link>
<link rel="stylesheet" type="text/css" href="./css/jquery-ui-1.8.16.custom.css"></link>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' type='text/css'>
<title>BIMP Simulator</title>
</head>
<body>
	<div id="main">
		<jsp:include page="_header.jsp"></jsp:include>
		<div id="contents">
			<div id="instructions">
				<b>Here are some instructions</b><br>
				<ol>
					<li>Please select a valid BPMN file.</li>
					<li>Press <b class="blue">“Continue”</b> in order to add/change simulation information.</li>
					<li>Click <b class="blue">“Start simulation”</b>.</li>
					<li>Tick the <b class="blue">"Generate a log"</b> box if You want to be able to download simulation log afterwards.</li>
					<li>Be amazed and wonder how such magic came to be.</li>
				</ol> 
			</div>
			<div id="upload-area">
				<form id="upload" modelAttribute="uploadItem" action="/uploadfile"
					method="POST" enctype="multipart/form-data">

					<fieldset>
						<legend>Upload your .BPMN file</legend>

						<input type="hidden" id="MAX_FILE_SIZE" name="MAX_FILE_SIZE"
							value="300000" />

						<div>
							<label for="file-select">Select the file:</label> <input
								type="file" id="file-select" name="fileData" />
							<div id="file-drag">or drop it here</div>
						</div>
					<span id="fileName">No file selected.</span>
					</fieldset>
					
				</form>
				
				<button class="button" id="continue-button" disabled="disabled">Continue</button>				
			</div>
			
			<div id="logCheckBox">
				<input type="checkbox" id="mxmlLog" name="mxmlLog" value="mxmlLog" />Generate a log<br />
			</div>
			
			<div id="submit-button">
				<button id="startSimulationButton" type="submit">Start Simulation</button>
			</div>
			
			<div id="data-input" class="gill-font">
				<div class="layout-right">
					<a class="toggle-all">Collapse all</a>
				</div>
				<form action="">
					<h2 class="toggle-trigger"><a>Main start event</a></h2>
					<div class="toggle-div">
						<div class="startEvent">
						<table class="form">
							<tbody>
								<tr>
									<th>Name:</th>
									<td><span class="name">Event's Name</span>
									</td>
								</tr>
								<tr id="arrivalRateDistribution">
									<th>Arrival rate:</th>
									<td><select class="type" name="type">
											<option value="fixed">Fixed</option>
											<option value="standard">Standard</option>
											<option value="exponential">Exponential</option>
											<option value="uniform">Uniform</option>
										</select>
										<div> Value: <input class="small value" name="value" type="text"></div>
										<div> Mean: <input class="small mean" name="mean" type="text"></div>
										<div> Standard deviation: <input class="small stdev" name="stdev" type="text"></div>
										<div> Min: <input class="small min" name="min" type="text"></div>
										<div> Max: <input class="small max" name="max" type="text"></div>
										<select class="timeUnit">
											<option value="seconds">Seconds</option>
											<option value="minutes">Minutes</option>
											<option value="hours">Hours</option>
											<option value="days">Days</option>
										</select>
									</td>
								</tr>
								<tr>
									<th># of instances</th>
									<td><input class="instances" name="instances"
										class="small" type="text">
									</td>
								</tr>
								<tr>
									<th>Simulation start time</th>
									<td>
										<!-- TODO: date and time input, 
										get rid of script, 
										normal handler for starttime onFocus --> <input name="startAt"
										class="normal datepicker startAtDate" type="text"
										onFocus="if(this.value==this.defaultValue){this.value='';}"
										value="yyyy-mm-dd"> 
										
										<input name="startAt"
										class="normal timepicker startAtTime" type="text"
										onFocus="if(this.value==this.defaultValue){this.value='';}"
										value="HH:MM:SS">
										<script>
											$(".datepicker").datepicker({
												dateFormat : 'yy-mm-dd'
											});
										</script></td>
								</tr>
								<tr>
									<th>Currency:</th>
									<td>
										<select class="currency">
											<option value="EUR">EUR</option>
											<option value="USD">USD</option>
											<option value="CAD">CAD</option>
											<option value="GBP">GBP</option>
											<option value="CHF">CHF</option>
											<option value="NZD">NZD</option>
											<option value="AUD">AUD</option>
											<option value="JPY">JPY</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
					</div>
					<h2 class="toggle-trigger"><a>Resources</a></h2>
					<div class="toggle-div">
						<div class="resources">
						<table>
							<tbody>
								<tr>
									<td><a class="trigger add" href="javascript:void(0)">Add</a></td>
									<th>Name</th>
									<th>Cost per hour</th>
									<th>Amount</th>
								<tr>
								<tr class="resource">
									<td></td>
									<td><input class="normal name" name="name" type="text"></td>
									<td><input class="small costPerHour" name="costPerHour" type="text"><span class="currencyText">EUR</span></td>
									<td><input class="small text amount" name="amount" type="text"></td>
									<td><a class="trigger remove" href="javascript:void(0)" title="Remove field">X</a></td>
								</tr>
							</tbody>
						</table>
						</div>
					</div>
					<h2 class="toggle-trigger"><a>Timetable</a></h2>
					<div class="toggle-div">
						<div class="timetables">
						<table>
							<tbody>
								<tr>
									<td><a class="trigger add" href="javascript:void(0)" title="Add new field">Add</a></td>
									<th>Resource</th>
									<th>Begin day</th>
									<th>End day</th>
									<th>Begin time</th>
									<th>End time</th>

								</tr>
								<tr class="timetable">
										<td></td>
										<td>
											<select class="resource" name="resource">
													<option value="*">*</option>
											</select>
										</td>
										<td>
											<select class="startday" name="startday">
												<option value="Mon">Monday</option>
												<option value="Tue">Tuesday</option>
												<option value="Wed">Wednesday</option>
												<option value="Thu">Thursday</option>
												<option value="Fri">Friday</option>
												<option value="Sat">Saturday</option>
												<option value="Sun">Sunday</option>
											</select>
										</td>
										<td>
											<select class="endday" name="endday">
												<option value="Mon">Monday</option>
												<option value="Tue">Tuesday</option>
												<option value="Wed">Wednesday</option>
												<option value="Thu">Thursday</option>
												<option value="Fri">Friday</option>
												<option value="Sat">Saturday</option>
												<option value="Sun">Sunday</option>
											</select>
										</td>
										<td>
											<input class="begintime" name="begintime" class="timepicker">
										</td>
										<td>
											<input class="endtime" name="endtime" class="timepicker">
										</td>
										<td><a class="trigger remove" href="javascript:void(0)" title="Remove field">X</a></td>
								</tr>
								<tr>

								</tr>

							</tbody>
						</table>
						</div>
					</div>
					<h2 class="toggle-trigger"><a>Task</a></h2>
					<div class="toggle-div">
						<div class="tasks">
							<div class="task">
							<table>
								<tbody>
									<tr>
										<th>Name:</th>
										<td><span class="name">N/A</span></td>
									</tr>
									<tr class="hidden">
										<th>Task id:</th>
										<td><span class="id">id</span></td>
									</tr>
									<tr>
										<th>Resource:</th>
										<td><select class="resource" name="resource">
										</select>
										</td>
									</tr>
									<tr>
										<th>Fixed cost:</th>
										<td><input class="fixedCost" name="fixedCost" /><span class="currencyText">EUR</span></td>
									</tr>
									<tr>
										<th>Type</th>
										<td><select class="type" name="type">
												<option value="fixed">Fixed</option>
												<option value="standard">Standard</option>
												<option value="exponential">Exponential</option>
												<option value="uniform">Uniform</option>
											</select>
											<div> Value: <input class="small value" name="value" type="text"></div>
											<div> Mean: <input class="small mean" name="mean" type="text"></div>
											<div> Standard deviation: <input class="small stdev" name="stdev" type="text"></div>
											<div> Min: <input class="small min" name="min" type="text"></div>
											<div> Max: <input class="small max" name="max" type="text"></div>
											<select class="timeUnit">
												<option value="seconds">Seconds</option>
												<option value="minutes">Minutes</option>
												<option value="hours">Hours</option>
												<option value="days">Days</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
						</div>
					</div>
					<h2 class="toggle-trigger"><a>Gateways</a></h2>
					<div class="toggle-div">
						<div class="gateways">
							<div class="gateway">
							<table>
								<tbody>
									<tr>
										<th>Type:</th>
										<td><span class="type">Type</span></td>
									</tr>
									<tr>
										<th>Target name:</th>
										<td><span class="targetName">N/A</span></td>
									</tr>
									<tr class="hidden">
										<th>Id:</th>
										<td><span class="id">id</span></td>
									</tr>
									<tr class="hidden">
										<th>SourceRef</th>
										<td><span class="sourceRef">SourceRef</span></td>
									</tr>
									<tr class="hidden">
										<th>TargetRef</th>
										<td><span class="targetRef">TargetRef</span></td>
									</tr>
									<tr>
										<th>Probability of execution:</th>
										<td><input class="small probability" name="probability" /><label
											for="probability">%</label></td>
									</tr>
								</tbody>
							</table>
							</div>
						</div>
					</div>
					<h2 class="toggle-trigger intermediateCatchEvent"><a>Intermediate events</a></h2>
					<div class="toggle-div intermediateCatchEvent">
						<div class="catchEvents">
							<div class="catchEvent">
							<table>
								<tbody>
									<tr>
										<th>Name:</th>
										<td><span class="name">Event name</span>
										<td>
									</tr>
									<tr>
										<th>Type:</th>
										<td><select class="type" name="type">
												<option value="fixed">Fixed</option>
												<option value="standard">Standard</option>
												<option value="exponential">Exponential</option>
												<option value="uniform">Uniform</option>

											</select>
											<div> Value: <input class="small value" name="value" type="text"></div>
											<div> Mean: <input class="small mean" name="mean" type="text"></div>
											<div> Standard deviation: <input class="small stdev" name="stdev" type="text"></div>
											<div> Min: <input class="small min" name="min" type="text"></div>
											<div> Max: <input class="small max" name="max" type="text"></div>
											<select class="timeUnit">
												<option value="seconds">Seconds</option>
												<option value="minutes">Minutes</option>
												<option value="hours">Hours</option>
												<option value="days">Days</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
						</div>
					</div>

				</form>
			</div>
			
			<br>
			<div id="file-info"></div>
		</div>
		<jsp:include page="_footer.jsp"></jsp:include>
	</div>
</body>
</html>
