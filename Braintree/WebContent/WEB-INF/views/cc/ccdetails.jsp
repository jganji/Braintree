<%@ include file="/header.jsp"%>
<%@ include file="/index.jsp"%>
<%@ page import="com.lss.tbg.service.BraintreePaymentService"%>
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<style>
	.hosted-fields-container {
  height: 50px;
  margin-bottom: 1em;
  padding: 0 0.5em;
  border: 1px solid #ddd;
}

.hosted-fields-container.braintree-hosted-fields-invalid {
  border-color: tomato;
}

.hosted-fields-container.braintree-hosted-fields-valid {
  border-color: limegreen;
}

</style>
<%
	BraintreePaymentService service = new BraintreePaymentService();
	String clientToken = service.getClientToken().toString();
%>
<form action="/xxx" method="post" id="checkoutIdxx" enctype="multipart/form-data" onsubmit="return false">
<input type="text" value="venkatram"/>


</form>


<form id="hosted-form">
    <tr class="required">

    </tr>
    <label for="credit-card-field">Card Number</label>
    <div id="credit-card-field" class="hosted-fields-container"></div>

    <label for="security-code-field">CVV</label>
    <div id="security-code-field" class="hosted-fields-container"></div>

    <label for="expiration-field">Expiration</label>
    <div id="expiration-field" class="hosted-fields-container"></div>

    <label for="postal-code-field">Postal Code</label>
    <div id="postal-code-field" class="hosted-fields-container"></div>

   <button>Pay</button>
</form>
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>

<script id="braintree-client-token" type="application/json">
    <%= clientToken %>
</script>
<script>
	var nonce = '';
    var clientToken = document.getElementById('braintree-client-token').innerHTML;
    braintree.setup("<%=clientToken%>", 'custom', {
                id: 'hosted-form',
                hostedFields: {
                	onFieldEvent: function(event){
                        console.log('field event triggered', event);
                    },
                    styles: {
                        'input': {
                          'font-family': 'sans-serif',
                          'font-size': '16pt',
                          'color': 'black'
                        },
                        'input:focus': {
                          'outline': 'none'
                        },
                        'input.invalid': {
                          'color': 'tomato'
                        },
                        'input.valid': {
                          'color': 'limegreen'
                        }
                    },
                	number: {
                        selector: '#credit-card-field',
                        placeholder: '4111 1111 1111 1111'
                    },
                    cvv: {
                        selector: '#security-code-field',
                        placeholder: '123'
                    },
                    expirationDate: {
                        selector: '#expiration-field',
                        placeholder: 'MM/YYYY'
                    },
                    postalCode: {
                        selector: '#postal-code-field',
                        placeholder: '12345'
                    }
        },
        onReady: function(){
            console.log('braintree ready');
          },
          onError: function(error){
            console.log('an error occurred', error);
          },
          onPaymentMethodReceived: function(data, event){
            console.log('event', event, 'data', data);
            nonce = data.nonce;
            alert('Nonce -->' + nonce);
          }
    });
</script>

<%@ include file="/footer.jsp"%>