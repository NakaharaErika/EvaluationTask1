package dto;

import java.util.ArrayList;
import java.util.List;
public class BookProcessing {
    private List<BookBean> successfulEntries;
    private List<String> errorEntries;

    public BookProcessing() {
        this.successfulEntries = new ArrayList<>();
        this.errorEntries = new ArrayList<>();
    }

    public void addSuccessfulEntry(BookBean book) {
        successfulEntries.add(book);
    }

    public void addErrorEntry(String janCode) {
        errorEntries.add(janCode);
    }

    // ゲッターとセッター
    public List<BookBean> getSuccessfulEntries() {
        return successfulEntries;
    }

    public List<String> getErrorEntries() {
        return errorEntries;
    }
}
