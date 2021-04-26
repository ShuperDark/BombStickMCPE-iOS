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
struct LevelRenderer;

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

enum class EntityLocation : int {
	IDK = 0
};

static Item** Item$mItems;

LevelRenderer* renderer = NULL;

Level*(*Entity$getLevel)(Entity*);
BlockSource&(*Entity$getRegion)(Entity*);

void (*Level$explode)(Level*, BlockSource&, Entity*, Vec3 const&, float, bool, bool, float);
void (*LevelRenderer$playSound)(LevelRenderer*, Entity const&, EntityLocation, std::string const&, float, float);

void (*_LevelRenderer$tick)(LevelRenderer*);
void LevelRenderer$tick(LevelRenderer* _renderer) {

	renderer = _renderer;

	_LevelRenderer$tick(_renderer);
}

bool (*_Item$useOn)(Item*, ItemInstance*, Player*, int, int, int, signed char, float, float, float);
bool Item$useOn(Item* self, ItemInstance* inst, Player* player, int x, int y , int z, signed char side, float xx, float yy, float zz) {
	if(self == Item$mItems[280]) {
		Level$explode(Entity$getLevel(player), Entity$getRegion(player), NULL, {(float)x, (float)y, (float)z}, 10.0f, true, true, 10.0f);
		LevelRenderer$playSound(renderer, *player, EntityLocation::IDK, "note.harp", 20, 2);
	}

	return _Item$useOn(self, inst, player, x, y, z, side, xx, yy, zz);
}

%ctor {
	Item$mItems = (Item**)(0x1012ae238 + _dyld_get_image_vmaddr_slide(0));

	Entity$getLevel = (Level*(*)(Entity*))(0x100657df8 + _dyld_get_image_vmaddr_slide(0));
	Entity$getRegion = (BlockSource&(*)(Entity*))(0x100658034 + _dyld_get_image_vmaddr_slide(0));

	Level$explode = (void(*)(Level*, BlockSource&, Entity*, Vec3 const&, float, bool, bool, float))(0x1007a9118 + _dyld_get_image_vmaddr_slide(0));
	LevelRenderer$playSound = (void(*)(LevelRenderer*, Entity const&, EntityLocation, std::string const&, float, float))(0x10040249c + _dyld_get_image_vmaddr_slide(0));

	MSHookFunction((void*)(0x100746be0 + _dyld_get_image_vmaddr_slide(0)), (void*)&Item$useOn, (void**)&_Item$useOn);
	MSHookFunction((void*)(0x1003f9f90 + _dyld_get_image_vmaddr_slide(0)), (void*)&LevelRenderer$tick, (void**)&_LevelRenderer$tick);
}