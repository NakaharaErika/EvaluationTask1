package dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

public class BookBean {

	@Length(min=1 , max= 13, message="{min}文字以上{max}文字以下で入力してください。" )
	private String janCd;
	private String isbnCd;
	@Length(min=1 , max= 500, message="{min}文字以上{max}文字以下で入力してください。" )
	private String bookNm;
	@Length(min=1 , max= 500, message="{min}文字以上{max}文字以下で入力してください。" )
	private String bookKana;
	@Min(value = 1, message = "¥1~1,000,000,000で入力してください。")
    @Max(value = 1000000000, message = "¥1~1,000,000,000で入力してください。")
	private int price;
	@NotNull(message = "日付を入力してください。")
	private LocalDate issueDate;
	private LocalDateTime createDate;
	private LocalDateTime updateDate;


	public BookBean() {}

	public String getJanCd() {
		return janCd;
	}

	public void setJanCd(String janCd) {
		this.janCd = janCd;
	}

	public String getIsbnCd() {
		return isbnCd;
	}

	public void setIsbnCd(String isbnCd) {
		this.isbnCd = isbnCd;
	}

	public String getBookNm() {
		return bookNm;
	}

	public void setBookNm(String bookNm) {
		this.bookNm = bookNm;
	}

	public String getBookKana() {
		return bookKana;
	}

	public void setBookKana(String bookKana) {
		this.bookKana = bookKana;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public LocalDate getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(LocalDate issueDate) {
		this.issueDate = issueDate;
	}

	public  LocalDateTime  getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime  createDate) {
		this.createDate = createDate;
	}

	public  LocalDateTime  getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(LocalDateTime  updateDate) {
		this.updateDate = updateDate;
	}


}
