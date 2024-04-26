module Extensibility

export extend_model

"""
    extend_model(model::ModelSpecification.Model, extension::Function)

Extend an existing model by applying a user-defined function that modifies its components or parameters.
"""
function extend_model(model::ModelSpecification.Model, extension::Function)
    try
        # Apply the extension function to the model
        extension(model)
    catch e
        throw(ArgumentError("Failed to extend model $(model.name): $(e.message)"))
    end
end

end # module Extensibility
