public inherited sharing class Animal {
    public String animalType;
    
    Map<String, NoiseBehavior> noiseBehaviorMap;
    Map<String, MoveBehavior> moveBehaviorMap;
    Map<String, SwimBehavior> swimBehaviorMap;
    Map<String, NoSwimBehavior> noSwimBehaviorMap;
    
    public Animal(String animalType) {
        this.animalType = animalType;
        
        // Noise Behavior Map
        noiseBehaviorMap = new Map<String, NoiseBehavior>{
        'Lion' => new LionNoiseBehavior(),
        'Cat' => new CatNoiseBehavior(),
        'Horse' => new HorseNoiseBehavior(),
        'Alligator' => new AlligatorNoiseBehavior(),
        'Bear' => new BearNoiseBehavior(),
        'Cow' => new CowNoiseBehavior(),
        'Dog' => new DogNoiseBehavior()
         };
                        
         // Movement Behavior Map
         moveBehaviorMap = new Map<String, MoveBehavior>{
         'Lion' => new LionMoveBehavior(),
         'Cat' => new CatMoveBehavior(),
         'Horse' => new HorseMoveBehavior(),
         'Alligator' => new AlligatorMoveBehavior(),
         'Bear' => new BearMoveBehavior(),
         'Cow' => new CowMoveBehavior(),
         'Dog' => new DogMoveBehavior()
         };
                                    
         // Swim Behavior Map
         swimBehaviorMap = new Map<String, SwimBehavior>{
         'Lion' => new LionSwimBehavior(),
         'Alligator' => new AlligatorSwimBehavior(),
         'Bear' => new BearSwimBehavior(),
         'Dog' => new DogSwimBehavior()
         };
                                                
         // Swim Behavior Map
         noSwimBehaviorMap = new Map<String, NoSwimBehavior>{
         'Cat' => new CatSwimBehavior(),
         'Horse' => new HorseSwimBehavior(),
         'Cow' => new CowSwimBehavior()
          };
                                                        
         }
    
    public void makeNoise() {
        if (noiseBehaviorMap.containsKey(animalType)) {
            noiseBehaviorMap.get(animalType).makeNoise();
        } else {
            System.debug('Unknown animal type for noise: ' + animalType);
        }
    }
    
    public void move() {
        if (moveBehaviorMap.containsKey(animalType)) {
            moveBehaviorMap.get(animalType).move();
        } else {
            System.debug('Unknown animal type for movement: ' + animalType);
        }
    }
    
    public void swim() {
        if (swimBehaviorMap.containsKey(animalType)) {
            swimBehaviorMap.get(animalType).swim();
        } else {
            System.debug('Unknown animal type for swimming: ' + animalType);
        }
    }
    
    public void noSwim() {
        if (noSwimBehaviorMap.containsKey(animalType)) {
            noSwimBehaviorMap.get(animalType).noSwim();
        } else {
            System.debug('Unknown animal type for swimming: ' + animalType);
        }
    }
    
    public void roar() {
        System.debug('This animal roars');
    }
    
    public void meow() {
        System.debug('This animal meows');
    }
    
    public void neigh() {
        System.debug('This animal neighs');
    }
    
    public void hiss() {
        System.debug('This animal hisses');
    }
    
    public void growl() {
        System.debug('This animal growls');
    }
    
    public void moo() {
        System.debug('This animal does moos');
    }
    
    public void bark() {
        System.debug('This animal does barks');
    }
    
    public void run() {
        System.debug('This animal runs');
    }
    
    public void walk() {
        System.debug('This animal walks');
    }
    
    public void slide() {
        System.debug('This animal slides');
    }
    
    public void doSwim() {
        System.debug('This animal can swim');
    }
    
    public void doNotSwim() {
        System.debug('This animal does not swim');
    }
    
    // Behavior Interfaces
    public interface NoiseBehavior {
        void makeNoise();
    }
    
    public interface MoveBehavior {
        void move();
    }
    
    public interface SwimBehavior {
        void swim();
    }
    
    public interface NoSwimBehavior {
        void noSwim();
    }
    
    // Animal Noises
    public class LionNoiseBehavior implements NoiseBehavior {
        public void makeNoise() {
            new Animal('Lion').roar();
        }
    }
    
    public class CatNoiseBehavior implements NoiseBehavior {
        public void makeNoise() {
            new Animal('Cat').meow();
        }
    }
    
    public class HorseNoiseBehavior implements NoiseBehavior {
        public void makeNoise() {
            new Animal('Horse').neigh();
        }
    }
    
    public class AlligatorNoiseBehavior implements NoiseBehavior {
        public void makeNoise() {
            new Animal('Alligator').hiss();
        }
    }
    
    public class BearNoiseBehavior implements NoiseBehavior {
        public void makeNoise() {
            new Animal('Bear').growl();
        }
    }
    
    public class CowNoiseBehavior implements NoiseBehavior {
        public void makeNoise() {
            new Animal('Cow').moo();
        }
    }
    
    public class DogNoiseBehavior implements NoiseBehavior {
        public void makeNoise() {
            new Animal('Dog').bark();
        }
    }
    
    // Animal Movement behaviors
    public class LionMoveBehavior implements MoveBehavior {
        public void move() {
            new Animal('Lion').run();
        }
    }
    
    public class CatMoveBehavior implements MoveBehavior {
        public void move() {
            new Animal('Cat').walk();
        }
    }
    
    public class HorseMoveBehavior implements MoveBehavior {
        public void move() {
            new Animal('Horse').slide();
        }
    }
    
    public class AlligatorMoveBehavior implements MoveBehavior {
        public void move() {
            new Animal('Alligator').hiss();
        }
    }
    
    public class BearMoveBehavior implements MoveBehavior {
        public void move() {
            new Animal('Bear').walk();
        }
    }
    
    public class CowMoveBehavior implements MoveBehavior {
        public void move() {
            new Animal('Cow').walk();
        }
    }
    
    public class DogMoveBehavior implements MoveBehavior {
        public void move() {
            new Animal('Dog').run();
        }
    }
    
    // Animal Swimming behaviors
    public class LionSwimBehavior implements SwimBehavior {
        public void swim() {
            new Animal('Lion').doSwim();
        }
    }
    
    public class CatSwimBehavior implements NoSwimBehavior {
        public void noSwim() {
            new Animal('Cat').doNotSwim();
        }
    }
    
    public class HorseSwimBehavior implements NoSwimBehavior {
        public void noSwim() {
            new Animal('Horse').doNotSwim();
        }
    }
    
    public class AlligatorSwimBehavior implements SwimBehavior {
        public void swim() {
            new Animal('Alligator').doSwim();
        }
    }
    
    public class BearSwimBehavior implements SwimBehavior {
        public void swim() {
            new Animal('Bear').doSwim();
        }
    }
    
    public class CowSwimBehavior implements NoSwimBehavior {
        public void noSwim() {
            new Animal('Cow').doNotSwim();
        }
    }
    
    public class DogSwimBehavior implements SwimBehavior {
        public void swim() {
            new Animal('Dog').doSwim();
        }
    }
    
}