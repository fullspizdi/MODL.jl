module SimulationEngine

export run_simulation

using Dates

"""
    run_simulation(model::ModelSpecification.Model, timesteps::Int, params::Dict)

Run a simulation based on the model definition, over a specified number of timesteps, with given parameters.
"""
function run_simulation(model::ModelSpecification.Model, timesteps::Int, params::Dict)
    # Update model parameters based on input
    for (param, value) in params
        if haskey(model.parameters, param)
            model.parameters[param] = value
        else
            throw(ArgumentError("Parameter $(param) not found in model $(model.name)."))
        end
    end

    # Initialize state variables
    state_history = Dict{Symbol, Vector{Any}}()
    for component in keys(model.components)
        state_history[component] = []
    end

    # Simulation loop
    for t in 1:timesteps
        # Update each component based on its defining equation
        for (component, equation) in model.components
            # Evaluate the equation in the context of the current state and parameters
            new_value = eval(:( $(equation) ), merge(state_history, model.parameters))
            push!(state_history[component], new_value)
        end
    end

    return state_history
end

end # module SimulationEngine
