using Test
using MODL

@testset "MODL.jl Tests" begin
    # Test the model definition
    @testset "Model Definition" begin
        model_expr = @model TestModel begin
            X(t+1) = X(t) + 1
            Y(t+1) = Y(t) - 1
        end
        @test typeof(model_expr) == ModelSpecification.Model
        @test haskey(model_expr.components, :X)
        @test haskey(model_expr.components, :Y)
    end

    # Test the simulation engine
    @testset "Simulation Engine" begin
        model = ModelSpecification.define_model(:TestModel, quote
            X(t+1) = X(t) + 1
            Y(t+1) = Y(t) - 1
        end)
        params = Dict(:X => 0, :Y => 10)
        result = SimulationEngine.run_simulation(model, 5, params)
        @test length(result[:X]) == 5
        @test length(result[:Y]) == 5
        @test result[:X][end] == 4
        @test result[:Y][end] == 5
    end

    # Test the analysis toolkit
    @testset "Analysis Toolkit" begin
        result = Dict(:X => [0, 1, 2, 3, 4], :Y => [10, 9, 8, 7, 6])
        plot_result = AnalysisToolkit.visualize(result, [:X, :Y])
        @test typeof(plot_result) == Plots.Plot
    end

    # Test model extensibility
    @testset "Model Extensibility" begin
        model = ModelSpecification.define_model(:TestModel, quote
            X(t+1) = X(t) + 1
            Y(t+1) = Y(t) - 1
        end)
        Extensibility.extend_model(model, function(m)
            m.parameters[:Z] = 100
        end)
        @test model.parameters[:Z] == 100
    end
end
