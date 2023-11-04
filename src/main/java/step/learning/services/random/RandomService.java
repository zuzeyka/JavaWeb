package step.learning.services.random;

public interface RandomService {
    public void seed(String iv);

    String randomHex(int length);
}
