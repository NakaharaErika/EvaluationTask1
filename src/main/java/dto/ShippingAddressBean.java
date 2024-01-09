package dto;

import javax.validation.constraints.Digits;

import org.hibernate.validator.constraints.Length;

import interfaces.group.GroupB;

public class ShippingAddressBean {
	
	private int shippingAddressId;
	private int userId;
	@Length(groups = {GroupB.class}, min=7 , max=7, message="{max}文字で入力してください。" )
	@Digits(integer = 7, fraction = 0, message = "半角数字で入力してください。")
	private String postalCode;
	@Length(groups = {GroupB.class}, min=1 , max=25, message="{min}文字以上{max}文字以下で入力してください。" )
	private String addressee;
	@Length(groups = {GroupB.class}, min=1 , message="{min}文字以上で入力してください。" )
	private String address;
	private int mainShippingAddress;
	
	public ShippingAddressBean() {};
	
	public int getShippingAddressId() {
		return shippingAddressId;
	}
	
	public void setShippingAddressId(int shippingAddressId) {
		this.shippingAddressId = shippingAddressId;
	}
	
	public int getUserId() {
		return userId;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getPostalCode() {
		return postalCode;
	}
	
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	
	public String getAddressee() {
		return addressee;
	}
	
	public void setAddressee(String addressee) {
		this.addressee = addressee;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public int getMainShippingAddress() {
		return mainShippingAddress;
	}
	
	public void setMainShippingAddress(int mainShippingAddress) {
		this.mainShippingAddress = mainShippingAddress;
	}
	
}
