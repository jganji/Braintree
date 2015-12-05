<%@ include file="/header.jsp"%>
<%@ include file="/index.jsp"%>
<%@ page import="com.lss.tbg.service.BraintreePaymentService" %>
<%
BraintreePaymentService service = new BraintreePaymentService();
String clientToken=service.getClientToken().toString();

%>
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<script type="text/javascript">
braintree.setup("<%=clientToken%>", "dropin", { container: "payment-form-dropin",id: "checkout"});
</script>
<form:form action="pay" method="POST" id="checkout">
<div id="payment-form-dropin" class="row"></div>
<form:button>Save</form:button>
</form:form>
<%@ include file="/footer.jsp"%>