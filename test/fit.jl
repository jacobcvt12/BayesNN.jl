@testset "Fit" begin
    using Distributions, BayesNN, StatsFuns, GradDescent

    # data size
    N = 1000  # number of observations
    D = 3     # number of covariates including intercept

    # generate data
    srand(1)                  # insure reproducibility
    X = rand(Normal(), N, D)  # generate covariates
    X[:, 1] = 1               # make first column intercept
    b = rand(Normal(), D)     # coefficients
    θ = logistic.(X * b)      # simulate dependent variables
    y = rand.(Bernoulli.(θ))  # simulate dependent variables
    net = Nnet(y, X)

    @test_nowarn BayesNN.fit(net, Adam(α=1.0))
end
