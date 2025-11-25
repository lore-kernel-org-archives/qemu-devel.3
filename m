Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8570CD0EE00
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNx05-00027H-Ky; Tue, 25 Nov 2025 12:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vNx00-000261-8S
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:38:45 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vNwzx-00027c-VL
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:38:43 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b3377aaf2so3395034f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 09:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764092320; x=1764697120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tGVeJ0F4ibxE2fUpl0SKLmrEQxLUitBHAjDBavXfKBI=;
 b=KByKnK61QeOOqvpKYl0SxR0f0s9lh9rqU+9xntbLNJ0lPa6nt772YX1OGYWB7GVxc2
 PgaxhILfhXC4a8v73+LbIer8Wj8a1YuYv32sBrq9Jc4dokn0dhXnHe5WM8XVDtkq5kVw
 qTuNg8so9l8jFtHsf5hwi+LFE7TlVBRbqteo+TUuIMtt8vc8HySPOWtRAFGhtHePhkDL
 VLVAnAJL0vh7lDqTVD5+/7FjsA0wGrFKjcTuLvTXR+oQRvpRw24v5PZ3ABTND5IdnjYj
 zJGL0eokOXGJ56EiU+HtwYzGeGzgK0blCMJpX2V+9cqFL3CLi38NhTaHuGLzUBgqAfYZ
 8oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764092320; x=1764697120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGVeJ0F4ibxE2fUpl0SKLmrEQxLUitBHAjDBavXfKBI=;
 b=mNCfPX+Hw/Sm36HCZFYUAhtJAd1CkQ+aPWjfohChVJtKtqlxileggdcRg6uEX6xUf8
 +UkYiQcoA9c3qfM3+NzXF4MuyKeNk2TaG6gOQv+OyFCA2OxJFVbET53bD1ko2L3GVAkD
 FTM48kVYdrmIpt0ukM0jKHdRqk2ujYjPFWKpgYys4QUft5P8qxTOHuL0P+PszL+SyYlb
 +jtQ+7j+v9W+vCDsbEqsSlg7HsqbSlz9rPrVBs85QI4ZD4fOLIMgZlezgFqtZnla9X/K
 egiXpbyDPqYHLmLYGei5gKo9lg6Xa6V9pSEr0D8Q19EEfrjWevkEyY47duHhTj3xogx+
 ybvQ==
X-Gm-Message-State: AOJu0YyZiLFxa2uTz3EWuXRk6NQABM2hzNkSbIIjQ4dWCQEXZWVWcmYE
 E9kvdh+vh3PuB1sIElGPyuZq2ih+1oBo2nkj7ZxVq2dL8LnWYokU4EDAKhJrXZO5B9Lzjg==
X-Gm-Gg: ASbGncvPit7FNx+zV5/P6GNURfsQFmqUfzwEgXMxE6j94dPKBg7QGlQAl14Irbs5be3
 DBCKHu7W9Q1f7uv9q49rr4Ju3BxCOxZGiIveIxN2GmxHKo44yI/cZuWyxgzIvKdyeg7a4KcVaHY
 IvHf8o4MM3NtmZ6F+Mxn2/5ZNncc415nG7tUXHlXuRdxwJL37oYZ7+l2ZQDr9scLqGKa86sUw3k
 xW2SfLUlElSIqJYlpdi4Sn/rJ1jg/TCbtvsG4ZyfOqZ8BUpNdFojhKRWAmLgZPapexh0/tp3qQl
 lgMjpq9xubRusH4MyRUcWgjPv5H2aT0MnCuXkz/moKvh5wOoK+1rIakfb3m3R3FIm/mCJmDThjC
 I8o62gopG2zDtLy8gOtwRwK4GtZhRq1At6J6Po1pDTMRxYvw28FhespyYwevQaU14dzJQ2VFZiX
 WmrfC/ozU=
X-Google-Smtp-Source: AGHT+IFrcjv8XneEboSkCqanyuYNE8us2FSlCftHXfUrmX2qnkh4JAEmR01wKVSDOmMk/4pzqmLbvA==
X-Received: by 2002:a05:6000:1ace:b0:42b:3746:3b87 with SMTP id
 ffacd0b85a97d-42cc1d22d28mr16965034f8f.52.1764092320102; 
 Tue, 25 Nov 2025 09:38:40 -0800 (PST)
Received: from localhost ([51.37.163.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm35398740f8f.2.2025.11.25.09.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 09:38:39 -0800 (PST)
From: Pawel Zmarzly <pzmarzly0@gmail.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	michel@michel-slm.name
Subject: [PATCH] scripts/analyze-migration: Support mapped-ram snapshot format
Date: Tue, 25 Nov 2025 17:38:39 +0000
Message-ID: <20251125173839.249765-1-pzmarzly0@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=pzmarzly0@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The script has not been updated to read mapped-ram snapshots and is currently
crashing when trying to read such a file.

With this commit, it can now read a snapshot created with:

    (qemu) migrate_set_capability x-ignore-shared on
    (qemu) migrate_set_capability mapped-ram on
    (qemu) migrate -d file:vm.state

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
---
 scripts/analyze-migration.py | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 67631ac43e..73ea7dea2d 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -19,6 +19,7 @@
 
 import json
 import os
+import math
 import argparse
 import collections
 import struct
@@ -127,6 +128,7 @@ def __init__(self, file, version_id, ramargs, section_key):
         self.dump_memory = ramargs['dump_memory']
         self.write_memory = ramargs['write_memory']
         self.ignore_shared = ramargs['ignore_shared']
+        self.mapped_ram = ramargs['mapped_ram']
         self.sizeinfo = collections.OrderedDict()
         self.data = collections.OrderedDict()
         self.data['section sizes'] = self.sizeinfo
@@ -170,6 +172,47 @@ def read(self):
                         self.files[self.name] = f
                     if self.ignore_shared:
                         mr_addr = self.file.read64()
+                    if self.mapped_ram:
+                        version = self.file.read32()
+                        if version != 1:
+                            raise Exception("Unsupported MappedRamHeader version %s" % version)
+                        page_size = self.file.read64()
+                        if page_size != self.TARGET_PAGE_SIZE:
+                            raise Exception("Page size mismatch in MappedRamHeader")
+                        bitmap_offset = self.file.read64()
+                        pages_offset = self.file.read64()
+
+                        if self.dump_memory or self.write_memory:
+                            num_pages = len // page_size
+
+                            # Read the bitmap to determine which pages are present
+                            self.file.seek(bitmap_offset, os.SEEK_SET)
+                            bitmap_len = int(math.ceil(num_pages / 8))
+                            bitmap = self.file.readvar(size=bitmap_len)
+
+                            self.file.seek(pages_offset, os.SEEK_SET)
+                            for page_num in range(num_pages):
+                                page_addr = page_num * page_size
+
+                                is_filled = (bitmap[page_num // 8] >> page_num % 8) & 1
+                                if is_filled:
+                                    data = self.file.readvar(size=self.TARGET_PAGE_SIZE)
+                                    if self.write_memory:
+                                        self.files[self.name].seek(page_addr, os.SEEK_SET)
+                                        self.files[self.name].write(data)
+                                    if self.dump_memory:
+                                        hexdata = " ".join("{0:02x}".format(c) for c in data)
+                                        self.memory['%s (0x%016x)' % (self.name, page_addr)] = hexdata
+                                else:
+                                    self.file.seek(self.TARGET_PAGE_SIZE, os.SEEK_CUR)
+                                    if self.write_memory:
+                                        self.files[self.name].seek(page_addr, os.SEEK_SET)
+                                        self.files[self.name].write(b'\x00' * self.TARGET_PAGE_SIZE)
+                                    if self.dump_memory:
+                                        self.memory['%s (0x%016x)' % (self.name, page_addr)] = 'Filled with 0x00'
+
+                        self.file.seek(pages_offset + len, os.SEEK_SET)
                 flags &= ~self.RAM_SAVE_FLAG_MEM_SIZE
 
             if flags & self.RAM_SAVE_FLAG_COMPRESS:
@@ -663,6 +706,7 @@ def read(self, desc_only = False, dump_memory = False,
         ramargs['dump_memory'] = dump_memory
         ramargs['write_memory'] = write_memory
         ramargs['ignore_shared'] = False
+        ramargs['mapped_ram'] = False
         self.section_classes[('ram',0)][1] = ramargs
 
         while True:
@@ -674,6 +718,7 @@ def read(self, desc_only = False, dump_memory = False,
                 section = ConfigurationSection(file, config_desc)
                 section.read()
                 ramargs['ignore_shared'] = section.has_capability('x-ignore-shared')
+                ramargs['mapped_ram'] = section.has_capability('mapped-ram')
             elif section_type == self.QEMU_VM_SECTION_START or section_type == self.QEMU_VM_SECTION_FULL:
                 section_id = file.read32()
                 name = file.readstr()
-- 
2.52.0

