#include "substrate.h"
#include <string>
#include <vector>
#include <cstdio>
#include <mach-o/dyld.h>
#include <cstdint>
#include <stdint.h>

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

struct BlockSource;
struct TextureUVCoordinateSet;
struct PlayerInventoryProxy;

struct Item {
	uintptr_t** vtable; // 0
	uint8_t maxStackSize; // 8
	int idk; // 12
	std::string atlas; // 16
	int frameCount; // 40
	bool animated; // 44
	short itemId; // 46
	std::string name; // 48
	std::string idk3; // 72
	bool isMirrored; // 96
	short maxDamage; // 98
	bool isGlint; // 100
	bool renderAsTool; // 101
	bool stackedByData; // 102
	uint8_t properties; // 103
	int maxUseDuration; // 104
	bool explodeable; // 108
	bool shouldDespawn; // 109
	bool idk4; // 110
	uint8_t useAnimation; // 111
	int creativeCategory; // 112
	float idk5; // 116
	float idk6; // 120
	char buffer[12]; // 124
	TextureUVCoordinateSet* icon; // 136
	char filler[100];
};

struct LevelData
{
	char filler[48]; // 0
	std::string levelName; // 48
	char filler2[44]; // 72
	int time; // 116
	char filler3[144]; // 120
	int gameType; // 264
	int difficulty; // 268
};

struct Level
{
	char filler[160]; // 0
	LevelData data; // 160
};

struct Entity
{
	char filler[64];
	Level* level; // 64
	char filler2[104]; // 72
	BlockSource* region; // 176
};

struct Player :public Entity
{
	char filler[4400]; // 184
	PlayerInventoryProxy* inventory; // 4584
};

struct ItemInstance {
	uint8_t count;
	uint16_t aux;
	uintptr_t* tag;
	Item* item;
	uintptr_t* block;
	int idk[3];
};


struct Vec3 {
	float x, y, z;
};

enum class LevelSoundEvent : int
{
		ITEM_USE_ON = 0,
		HIT = 1,
		STEP = 2,
		JUMP = 3,
		BREAK = 4,
		PLACE = 5,
		HEAVY_STEP = 6,
		GALLOP = 7,
		FALL = 8,
		AMBIENT = 9,
		AMBIENT_BABY = 10,
		AMBIENT_IN_WATER = 11,
		BREATHE = 12,
		DEATH = 13,
		DEATH_IN_WATER = 14,
		DEATH_TO_ZOMBIE = 15,
		HURT = 16,
		HURT_IN_WATER = 17,
		MAD = 18,
		BOOST = 19,
		BOW = 20,
		SQUISH_BIG = 21,
		SQUISH_SMALL = 22,
		FALL_BIG = 23,
		FALL_SMALL = 24,
		SPLASH = 25,
		FIZZ = 26,
		FLAP = 27,
		SWIM = 28,
		DRINK = 29,
		EAT = 30,
		TAKEOFF = 31,
		SHAKE = 32,
		PLOP = 33,
		LAND = 34,
		SADDLE = 35,
		ARMOR = 36,
		ADD_CHEST = 37,
		THROW = 38,
		ATTACK = 39,
		ATTACK_NODAMAGE = 40,
		WARN = 41,
		SHEAR = 42,
		MILK = 43,
		THUNDER = 44,
		EXPLODE = 45,
		FIRE = 46,
		IGNITE = 47,
		FUSE = 48,
		STARE = 49,
		SPAWN = 50,
		SHOOT = 51,
		BREAK_BLOCK = 52,
		REMEDY = 53,
		UNFECT = 54,
		LEVELUP = 55,
		BOW_HIT = 56,
		BULLET_HIT = 57,
		EXTINGUISH_FIRE = 58,
		ITEM_FIZZ = 59,
		CHEST_OPEN = 60,
		CHEST_CLOSED = 61,
		POWER_ON = 62,
		POWER_OFF = 63,
		ATTACH = 64,
		DETACH = 65,
		DENY = 66,
		TRIPOD = 67,
		POP = 68,
		DROP_SLOT = 69,
		NOTE = 70,
		THORNS = 71,
		PISTON_IN = 72,
		PISTON_OUT = 73,
		PORTAL = 74,
		WATER = 75,
		LAVA_POP = 76,
		LAVA = 77,
		BURP = 78,
		BUCKET_FILL_WATER = 79,
		BUCKET_FILL_LAVA = 80,
		BUCKET_EMPTY_WATER = 81,
		BUCKET_EMPTY_LAVA = 82,
		GUARDIAN_FLOP = 83,
		MOB_ELDERGUARDIAN_CURSE = 84,
		MOB_WARNING = 85,
		MOB_WARNING_BABY = 86,
		TELEPORT = 87,
		SHULKER_OPEN = 88,
		SHULKER_CLOSE = 89,
		HAGGLE = 90,
		HAGGLE_YES = 91,
		HAGGLE_NO = 92,
		HAGGLE_IDLE = 93,
		DEFAULT = 94,
		UNDEFINED = 95
};

enum class EntityType : int
{
	ITEM = 64,
	PRIMED_TNT,
	FALLING_BLOCK,
	EXPERIENCE_POTION = 68,
	EXPERIENCE_ORB,
	FISHINGHOOK = 77,
	ARROW = 80,
	SNOWBALL,
	THROWNEGG,
	PAINTING,
	LARGE_FIREBALL = 85,
	THROWN_POTION,
	LEASH_FENCE_KNOT = 88,
	BOAT = 90,
	LIGHTNING_BOLT = 93,
	SAMLL_FIREBALL,
	TRIPOD_CAMERA = 318,
	PLAYER,
	IRON_GOLEM = 788,
	SOWN_GOLEM,
	VILLAGER = 1807,
	CREEPER = 2849,
	SLIME = 2853,
	ENDERMAN,
	GHAST = 2857,
	LAVA_SLIME,
	BLAZE,
	WITCH = 2861,
	CHICKEN = 5898,
	COW ,
	PIG,
	SHEEP,
	MUSHROOM_COW = 5904,
	RABBIT = 5906,
	SQUID = 10001,
	WOLF = 22286,
	OCELOT = 22294,
	BAT = 33043,
	PIG_ZOMBIE = 68388,
	ZOMBIE = 199456,
	ZOMBIE_VILLAGER = 199468,
	SPIDER = 264995,
	SILVERFISH = 264999,
	CAVE_SPIDER,
	MINECART_RIDEABLE = 524372,
	MINECART_HOPPER = 524384,
	MINECART_MINECART_TNT,
	MINECART_CHEST,
	SKELETON = 1116962,
	WITHER_SKELETON = 1116974,
	STRAY = 1116976,
	HORSE = 2119447,
	DONKEY,
	MULE,
	SKELETON_HORSE,
	ZOMBIE_HORSE
};

static Item** Item$mItems;

Level*(*Entity$getLevel)(Entity*);
BlockSource&(*Entity$getRegion)(Entity*);

void (*Level$explode)(Level*, BlockSource&, Entity*, Vec3 const&, float, bool, bool, float);
//void (*Level$playSound)(Level*, LevelSoundEvent, Vec3 const&, int, EntityType, bool, bool);
void (*Entity$playSound)(Entity*, LevelSoundEvent, Vec3 const&, int);

bool (*_Item$useOn)(Item*, ItemInstance*, Player*, int, int, int, signed char, float, float, float);
bool Item$useOn(Item* self, ItemInstance* inst, Player* player, int x, int y , int z, signed char side, float xx, float yy, float zz) {
	if(self == Item$mItems[280]) {
		Level$explode(Entity$getLevel(player), Entity$getRegion(player), NULL, {(float)x, (float)y, (float)z}, 10.0f, true, true, 10.0f);
		//Level$playSound(Entity$getLevel(player), LevelSoundEvent::NOTE, {(float)x, (float)y, (float)z}, 4, EntityType::ITEM, true, true);
		Entity$playSound(player, LevelSoundEvent::NOTE, {(float)x, (float)y, (float)z}, 4);
	}

	return _Item$useOn(self, inst, player, x, y, z, side, xx, yy, zz);
}

%ctor {
	Item$mItems = (Item**)(0x1012ae238 + _dyld_get_image_vmaddr_slide(0));

	Entity$getLevel = (Level*(*)(Entity*))(0x100657df8 + _dyld_get_image_vmaddr_slide(0));
	Entity$getRegion = (BlockSource&(*)(Entity*))(0x100658034 + _dyld_get_image_vmaddr_slide(0));

	Level$explode = (void(*)(Level*, BlockSource&, Entity*, Vec3 const&, float, bool, bool, float))(0x1007a9118 + _dyld_get_image_vmaddr_slide(0));
	//Level$playSound = (void(*)(Level*, LevelSoundEvent, Vec3 const&, int, EntityType, bool, bool))(0x1007a9118 + _dyld_get_image_vmaddr_slide(0));
	Entity$playSound = (void(*)(Entity*, LevelSoundEvent, Vec3 const&, int))(0x10065965c + _dyld_get_image_vmaddr_slide(0));

	MSHookFunction((void*)(0x100746be0 + _dyld_get_image_vmaddr_slide(0)), (void*)&Item$useOn, (void**)&_Item$useOn);
}