#include "bitmap.h"
#include "stdlib.h"
#include "stdio.h"

BitMap::BitMap()
{
}

void BitMap::initialize(char *bitmap, const int length)
{
    this->bitmap = bitmap;
    this->length = length;

    int bytes = ceil(length, 8);

    for (int i = 0; i < bytes; ++i)
    {
        bitmap[i] = 0;
    }
}

bool BitMap::get(const int index) const
{
    int pos = index / 8;
    int offset = index % 8;

    return (bitmap[pos] & (1 << offset));
}

void BitMap::set(const int index, const bool status)
{
    int pos = index / 8;
    int offset = index % 8;

    // 清0
    bitmap[pos] = bitmap[pos] & (~(1 << offset));

    // 置1
    if (status)
    {
        bitmap[pos] = bitmap[pos] | (1 << offset);
    }
}

int BitMap::allocate(const int count){
  if (count < 0)return -1;
  int hole = 8 * length;
  int start1 = 0;
  bool empty = false;
  for (int i = 0; i < 8 * length; ++i){
    if (!get(i)){
      int temp1 = i;
      while (!get(i) && i < 8 * length)++i;   
      if (i == 8 * length && temp1 == 0){
        empty = true;
        break;
      }
      int tmp = i - temp1;
      if (tmp >= count){
        if (tmp < hole){
          start1 = temp1;
          hole = tmp;
        }
      }
    }
  }
  if (hole == length){
    if (!empty){
      return -1;
    }
    else{
      for (int i = 0; i < count; ++i)set(i, true);
      return start1;
    }
  }
  else{
    for (int i = 0; i < count; ++i){
      set(start1 + i, true);
    }
    return start1;
  }
  return -1;
}

void BitMap::release(const int index, const int count)
{
    for (int i = 0; i < count; ++i)
    {
        set(index + i, false);
    }
}

char *BitMap::getBitmap()
{
    return (char *)bitmap;
}

int BitMap::size() const
{
    return length;
}
