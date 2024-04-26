module AnalysisToolkit

export visualize

using Plots

"""
    visualize(result::Dict{Symbol, Vector{Any}}, components::Vector{Symbol})

Function to visualize model output. It generates plots for specified components of the model.
"""
function visualize(result::Dict{Symbol, Vector{Any}}, components::Vector{Symbol})
    plots = []
    for component in components
        if haskey(result, component)
            p = plot(result[component], label=string(component), title="Model Output for $(string(component))")
            push!(plots, p)
        else
            throw(ArgumentError("Component $(component) not found in the simulation results."))
        end
    end
    plot(plots..., layout=(length(components), 1), legend=:outertopright)
end

end # module AnalysisToolkit
