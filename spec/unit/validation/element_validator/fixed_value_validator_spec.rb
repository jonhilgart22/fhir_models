describe FHIR::Validation::FixedValueValidator do

  let(:validator) { FHIR::Validation::FixedValueValidator }

  let(:element) { '867-5309' }
  #let(:element_definition) { instance_double(FHIR::ElementDefinition) }
  let(:element_definition) do  FHIR::ElementDefinition.new(id: 'Element',
                                                           path: 'Element',
                                                           type:[{code: 'String'}])
  end

  describe '#validate' do
    it 'returns a single result related to the fixed value' do

      # allow(element_definition).to receive(:fixed)
      #                                  .and_return(element)
      element_definition.fixedString = element

      results = validator.validate(element, element_definition)
      expect(results.first.validation_type).to be(:fixed_value)
      expect(results.first.result).to be(:pass)
    end

    it 'detects when the fixed value is incorrect' do

      element_definition.fixedString = 'INVALID_FIXED'

      results = validator.validate(element, element_definition)
      expect(results.first.validation_type).to be(:fixed_value)
      expect(results.first.result).to be(:fail)
    end
  end
end