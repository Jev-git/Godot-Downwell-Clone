# Doing
BUG?:
* Move into a wall while jumping up from a prop destroy the prop immediately instead of upon landing.
* Bullet can go through the floor sometime
# Collision
* Layer 0: Player
* Layer 1: Walls
* Layer 2: Bullets
* Layer 3: Enemies
# Terminology
* HitBox: Area where you deal damage to other
* HurtBox: Area where you receive damage from other
# Time frame
October 2021
# MVP
The first level of the first world:
* Player
    * ~~Jump~~
    * ~~Shoot on air to delay jump~~
    * ~~Reload on landing~~
    * ~~Bounce off props~~
    * ~~Bounce off enemies~~
    * ~~Bullets can damage enemies~~
    * ~~Blink, bounce, knocked back and vulnerable after taking damage~~
* Enemies
    * ~~Can damage player~~
* Map
    * Made a map manually
    * Win condition: reach the bottom
    * Lose condition: HP = 0
# Things that take time
* Side room with upgrade
* Shop
* Random upgrade after each level
* Map
    * Manually make a bunch of small room
    * Randomly put them together (rewatch GMTK's vid on spelunky for reference)