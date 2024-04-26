module MODL

# Import necessary Julia packages
using Dates
using Plots

# Include the various components of the MODL package
include("ModelSpecification.jl")
include("SimulationEngine.jl")
include("AnalysisToolkit.jl")
include("Extensibility.jl")

export @model, simulate, plot

"""
    @model

Macro to define a model with its components, parameters, and relationships.
"""
macro model(name, expr)
    ModelSpecification.define_model(name, expr)
end

"""
    simulate(model, timesteps, params)

Function to run simulations under different scenarios, including parameter sweeps and sensitivity analyses.
"""
function simulate(model, timesteps::Int; params::Dict)
    SimulationEngine.run_simulation(model, timesteps, params)
end

"""
    plot(result, components)

Function to visualize model output, calculate summary statistics, and perform common analysis tasks.
"""
function plot(result, components)
    AnalysisToolkit.visualize(result, components)
end

end # module
