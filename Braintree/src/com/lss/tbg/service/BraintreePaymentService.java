package com.lss.tbg.service;

import java.math.BigDecimal;
import java.util.List;

import com.braintreegateway.BraintreeGateway;
import com.braintreegateway.CustomerRequest;
import com.braintreegateway.Environment;
import com.braintreegateway.Plan;
import com.braintreegateway.Result;
import com.braintreegateway.Transaction;
import com.braintreegateway.TransactionRequest;

/**
 * @author ashok.janagam
 *
 */
public class BraintreePaymentService {
	Environment environment = com.braintreegateway.Environment.SANDBOX;
	String merchantId = "dc629vhqjgc7tnx5";
	String publicKey = "vshsthbzzv7fbkht";
	String privateKey = "fcbrv5wyzd659d5t";
	BraintreeGateway braintreeGateway = new BraintreeGateway(environment, merchantId, publicKey, privateKey);

	public String trDataForRecurringTransactions(BigDecimal amount, String returnUrl) {
		CustomerRequest customerRequest = new CustomerRequest();
		return braintreeGateway.trData(customerRequest, returnUrl);
	}

	public String trDataForOneTimeTransaction(BigDecimal amount, String returnUrl, Boolean submitForSettlement) {
		TransactionRequest transactionRequest = new TransactionRequest()
				.type(Transaction.Type.SALE).amount(amount).options()
				.submitForSettlement(submitForSettlement).done();
		return braintreeGateway.trData(transactionRequest, returnUrl);
	}

	public String fetchPaymentSubmissionLink() {
		return braintreeGateway.transparentRedirect().url();
	}

	public Result<Transaction> confirmPaymentRequest(String query) {
		try {
			Result<Transaction> result = braintreeGateway.transparentRedirect().confirmTransaction(query);
			return result;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public Transaction searchTransactionById(String transactionId) {
        return braintreeGateway.transaction().find(transactionId);
    }

	public List<Plan> findAllPlans() {
        return braintreeGateway.plan().all();
    }
	
    public Object getClientToken() {
        return braintreeGateway.clientToken().generate();
	}
    
    public Result<Transaction> getResult(String nonceFromTheClient) {
    		TransactionRequest request = new TransactionRequest().amount(new BigDecimal("100.00")).paymentMethodNonce(nonceFromTheClient);
    		Result<Transaction> result = braintreeGateway.transaction().sale(request);
    		return result;
    }
}