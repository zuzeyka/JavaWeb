package step.learning.dto.models;

import step.learning.dto.entities.CallMe;

import java.util.List;

public class GetCallsModel {
    private boolean allowDelete;
    private List<CallMe> calls;

    public boolean isAllowDelete() {
        return allowDelete;
    }

    public void setAllowDelete(boolean allowDelete) {
        this.allowDelete = allowDelete;
    }

    public List<CallMe> getCalls() {
        return calls;
    }

    public void setCalls(List<CallMe> calls) {
        this.calls = calls;
    }
}
