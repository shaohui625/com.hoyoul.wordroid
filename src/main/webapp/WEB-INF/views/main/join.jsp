<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
	.short {color:red;font-size:13px;}
	.weak {color:yellow;font-size:13px;}
	.good {color:blue;font-size:13px;}
	.strong {color:green;font-size:13px;}
</style>
<script>
$(document).ready(function(){
	$("#submit").button();
	$("#joinform").submit(function(){
		
		$(".error").hide();
		
		var hasError = false;
		
		//LoginId Validation.
		var loginid = $("#loginid").val();
		if(loginid == ''){
			$("#loginid_error").html('<span class="error">Please enter a login ID.</span>');
			hasError = true;
		}
		
		//Password Validation.
		var passwordVal = $("#password").val();
		var checkVal = $("#password-check").val();
		
		if (passwordVal == '') {
			$("#password_error").html('<span class="error">Please enter a password.</span>');
			hasError = true;
		} else if (checkVal == '') {
			$("#password-check_error").html('<span class="error">Please re-enter your password.</span>');
			hasError = true;
		} else if (passwordVal != checkVal ) {
			$("#password-check_error").html('<span class="error">Passwords do not match.</span>');
			hasError = true;
		}
		
		//Name Validation.
		var username = $("#username").val();
		if(username == ''){
			$("#username_error").html('<span class="error">Please enter a name.</span>');
			hasError = true;
		}
		
		//Email Validation.
		var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
		var emailblockReg =
			/^([\w-\.]+@(?!gmail.com)(?!yahoo.com)(?!hotmail.com)([\w-]+\.)+[\w-]{2,4})?$/;
		
		var emailaddressVal = $("#email").val();
		if(emailaddressVal == '') {
			$("#email_error").html('<span class="error">Please enter your email address.</span>');
			hasError = true;
		}else if(!emailReg.test(emailaddressVal)) {
			$("#email_error").html('<span class="error">Enter a valid email address.</span>');
			hasError = true;
		}/* else if(!emailblockReg.test(emailaddressVal)) {
			$("#email_error").html('<span class="error">No yahoo, gmail or hotmail emails.</span>');
			hasError = true;
		} */ 
		
		if(hasError == true) { return false; }
	});
	
	$("#loginid").keyup(function(){
		$.get("./main/check/"+$(this).val(),function(data){
			if(data != ""){
				$("#loginid_error").html('<span class="error">'+data+'</span>');
			}
		});
	});
	
	$('#password').keyup(function(){
		$('#result').html(checkStrength($('#password').val()));
	});
	
	function checkStrength(password){
		 
		//initial strength
		var strength = 0;
	 
		//if the password length is less than 6, return message.
		if (password.length < 6) {
			$('#result').removeClass();
			$('#result').addClass('short');
			return 'Too short';
		}
	 
		//length is ok, lets continue.
	 
		//if length is 8 characters or more, increase strength value
		if (password.length > 7) strength += 1;
	 
		//if password contains both lower and uppercase characters, increase strength value
		if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1;
	 
		//if it has numbers and characters, increase strength value
		if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  strength += 1;
	 
		//if it has one special character, increase strength value
		if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1;
	 
		//if it has two special characters, increase strength value
		if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,",%,&,@,#,$,^,*,?,_,~])/)) strength += 1;
	 
		//now we have calculated strength value, we can return messages
	 
		//if value is less than 2
		if (strength < 2 ) {
			$('#result').removeClass();
			$('#result').addClass('weak');
			return 'Weak';
		} else if (strength == 2 ) {
			$('#result').removeClass();
			$('#result').addClass('good');
			return 'Good';
		} else {
			$('#result').removeClass();
			$('#result').addClass('strong');
			return 'Strong';
		}
	}
});
</script>

<form:form id="joinform" method="post" action="main/join" commandName="user">
<table>
	<tr>
		<td align="right"><form:label path="loginId"> *Login ID </form:label> </td>
		<td><form:input path="loginId" id="loginid"/> </td>
		<td id="loginid_error" align="left"></td>
	<tr>
	<tr>
		<td align="right"><form:label path="password"> *Password </form:label> </td>
		<td><form:input path="password" id="password" type="password"/></td>
		<td><span id="result" class="error"></span></td>
		<td id="password_error" align="left"></td>
	<tr>
	<tr>
		<td align="right">Confirm Password</td>
		<td><input type="password" id="password-check"/></td>
		<td id="password-check_error" align="left" colspan="2"></td>
	<tr>	
	<tr>
		<td align="right"><form:label path="name"> *Name </form:label> </td>
		<td><form:input path="name" id="username"/> </td>
		<td id="username_error" align="left" colspan="2"></td>
	<tr>
	<tr>
		<td align="right"><form:label path="email"> *Email </form:label> </td>
		<td><form:input path="email" id="email"/></td>
		<td id="email_error" align="left" colspan="2"></td>
	<tr>
	<tr>
		<td colspan="2" align="center">
			<input id="submit" type="submit" value="Join" />
		</td>
	</tr>		
</table>	
</form:form>
