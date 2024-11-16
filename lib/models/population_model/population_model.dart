import 'dart:math';

class PopulationModel {
  /// Calcula la población final usando el modelo exponencial
  static double calculateExponential(double initialPopulation, double growthRate, double time) {
    return initialPopulation * exp(growthRate * time);
  }

  /// Calcula la tasa de crecimiento en el modelo exponencial
  static double calculateExponentialGrowthRate(double finalPopulation, double initialPopulation, double time) {
    return log(finalPopulation / initialPopulation) / time;
  }

  /// Calcula la población inicial en el modelo exponencial
  static double calculateInitialPopulationExponential(double finalPopulation, double growthRate, double time) {
    return finalPopulation / exp(growthRate * time);
  }

  /// Calcula el tiempo en el modelo exponencial
  static double calculateTimeExponential(double finalPopulation, double initialPopulation, double growthRate) {
    return log(finalPopulation / initialPopulation) / growthRate;
  }

  /// Calcula la población final usando el modelo logístico
  static double calculateLogistic(double initialPopulation, double growthRate, double carryingCapacity, double time) {
    return (carryingCapacity * initialPopulation) / 
        (initialPopulation + (carryingCapacity - initialPopulation) * exp(-growthRate * time));
  }

  /// Calcula la capacidad de carga en el modelo logístico
  static double calculateCarryingCapacityLogistic(double finalPopulation, double initialPopulation, double growthRate, double time) {
    return (finalPopulation * initialPopulation) / 
        (initialPopulation - finalPopulation * exp(-growthRate * time));
  }

  /// Calcula la población inicial en el modelo logístico
  static double calculateInitialPopulationLogistic(
    double finalPopulation, double growthRate, double carryingCapacity, double time) {
    return (finalPopulation * (carryingCapacity - finalPopulation)) / 
        (carryingCapacity * exp(-growthRate * time));
  }

  /// Calcula el tiempo en el modelo logístico
  static double calculateTimeLogistic(
    double finalPopulation, double initialPopulation, double growthRate, double carryingCapacity) {
    return (-log((carryingCapacity - finalPopulation) / (carryingCapacity - initialPopulation))) / growthRate;
  }

  /// Calcula la tasa de crecimiento en el modelo logístico
  static double calculateGrowthRateLogistic(
    double finalPopulation, double initialPopulation, double carryingCapacity, double time) {
    return -log((carryingCapacity - finalPopulation) / (carryingCapacity - initialPopulation)) / time;
  }
}
