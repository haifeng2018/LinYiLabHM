/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: FileUtil
 * Author: Victor
 * Date: 2024/09/30 17:26
 * Description: 
 * -----------------------------------------------------------------
 */

class FileUtil {
  getFileNameByPath(path: string): string {
    let fileName = ''
    const items = path.split('/')
    const count = items.length ?? 0
    if (count > 0) {
      fileName = items[items.length - 1]
    }
    return fileName
  }
}

export default new FileUtil()