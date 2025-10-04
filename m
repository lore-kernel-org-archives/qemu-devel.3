Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAAACAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wWF-00034p-J7; Sat, 04 Oct 2025 03:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUt-000216-M2
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUr-0005O4-FP
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso22391525e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562159; x=1760166959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wq8EUE1+HgXo/7MII74NvB7vzZYmBEyyIERlDAVIhgI=;
 b=Z0z9fIFvv9TUT7jT6UlzniQ5KUntr5fGuATWbIdR2HWbU+9BDLyWZvPKCHzMJoQfap
 pCoBxiDYpRDOEejn2yy/E0jRilkp3V+AFyIBZQXRvnWRMAA/asJOVoYdAJIl8SoWkfoy
 x5Oq6VPM3OZ18AXnRiT4fWChz4RM2ICkMXKpYsPK49TZpXpEW7zdEg2rUrVZRNfE2gRK
 /XXW4eOaIzs0qPV/t7gcvVfY4PCwXtlJ3oSgzxXf8V1DtKUAVYqnot9Kqxk7hkPXM91U
 XK4UmVkTE6yOGNEy2EClir8JV28DkY1S7IWfv4eyIQ4ttFGBGyi8EPQpn+fS/5BkocuQ
 yl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562159; x=1760166959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wq8EUE1+HgXo/7MII74NvB7vzZYmBEyyIERlDAVIhgI=;
 b=d7Md2/JCNZhdCqXtwZM+oNNlf/QnaDiAEMbPB94FOATuMfZfNagjlhXBqn7Aulcdc6
 O7zezhe0plgDglKeIu3vnqfMnWclcxLyPuC30j3nH8AULHu99g6V69kEi7v1DTlbucLp
 8MQsF2JYEND3Z9SnuyBWBCcQKWiAbmSmDBXe41KE6mr3vQA9t54D9JiSFXu5iVy0+i8d
 boN4rn8mt4Ax/NT1OCwbWZIqUmT5Pil3MaDozxbn476GYkhB6FIexeZp5N9iVXwYEIBR
 lQ+KNFXXCUewN5byyO3QDkF9AkmNzUvCLjDdZqe+F+9cij1ACwrE1O2rpRVxX/F8jodA
 euMQ==
X-Gm-Message-State: AOJu0YyPJz6E+FbAcOOsYgP6XWIrXIROZ7XvdSGdiSNkMQpZLRPOtMdb
 MNvxKg1z4gmXLx08uo8o6WPltNchyh1Hp4xkx7vZB4KG/T80tRdB20gg/AhJDPlLjYPv9gloEDz
 4wdkwJwSq8w==
X-Gm-Gg: ASbGnctFq9iLf/NXzknF8py27cYysVBrcmUMXOXuohun+NaGbldoZkJ3Bnnisxnii30
 WNGzgT4ZE/AAvDUH19is6ypishlMcdR7srcWCHj4oBFlLjOgQJyGOP2WR4xyIYAhgYu5f7CTJgm
 m/C0iABP3n1t7/u+QJxqoc/w5W8KE41Wzzp8PictMD0F5oSyR5x+C/tKY711pheV/9NvVZqCO0z
 2etXc1fFUSK8DzHgAfVtMuu3ywJTGDn/SZT/hEAKVbYz84PEv0JvjXuz2wzMcZ7GsvPyKJKkPjx
 OgGgZq6k270CD/NCohGOm7Lq35RgpGy5hV73YKFWpV/WrpIONUQziwVX05bUbP3t3x6oOYJZocD
 nzz5q5wCgTnj06qGGPz9N2g8dKrti0m/GWidjC/kZJGlpXlNXzqOdiAQksz3oSOoimeB2Z7c2FG
 mPefbIViZY5DMw9K7q5XNkzTvBhTD2Kv+TVF4=
X-Google-Smtp-Source: AGHT+IGA3XFqWjT6iWiOaPSmTDrM1ufeySLED0WvrKdkAR4XoxNMyV/pjSOtosd/NtfXtfZ6RJMnSQ==
X-Received: by 2002:a05:600c:6092:b0:45c:b6d3:a11d with SMTP id
 5b1f17b1804b1-46e70c48dc8mr41885825e9.1.1759562159486; 
 Sat, 04 Oct 2025 00:15:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723624b3sm60765325e9.17.2025.10.04.00.15.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/41] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_lebitmap()
Date: Sat,  4 Oct 2025 09:13:02 +0200
Message-ID: <20251004071307.37521-37-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Remove the now unneeded "system/xen.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-14-philmd@linaro.org>
---
 include/system/ram_addr.h | 102 +------------------------------------
 system/physmem.c          | 103 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 101 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index fbf57a05b2a..49e9a9c66d8 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -19,7 +19,6 @@
 #ifndef SYSTEM_RAM_ADDR_H
 #define SYSTEM_RAM_ADDR_H
 
-#include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
@@ -161,108 +160,9 @@ void cpu_physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
  * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
  * weren't set in the global migration bitmap.
  */
-static inline
 uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t start,
-                                                ram_addr_t pages)
-{
-    unsigned long i, j;
-    unsigned long page_number, c, nbits;
-    hwaddr addr;
-    ram_addr_t ram_addr;
-    uint64_t num_dirty = 0;
-    unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
-    unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
-    unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
-
-    /* start address is aligned at the start of a word? */
-    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) &&
-        (hpratio == 1)) {
-        unsigned long **blocks[DIRTY_MEMORY_NUM];
-        unsigned long idx;
-        unsigned long offset;
-        long k;
-        long nr = BITS_TO_LONGS(pages);
-
-        idx = (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
-        offset = BIT_WORD((start >> TARGET_PAGE_BITS) %
-                          DIRTY_MEMORY_BLOCK_SIZE);
-
-        WITH_RCU_READ_LOCK_GUARD() {
-            for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
-                blocks[i] =
-                    qatomic_rcu_read(&ram_list.dirty_memory[i])->blocks;
-            }
-
-            for (k = 0; k < nr; k++) {
-                if (bitmap[k]) {
-                    unsigned long temp = leul_to_cpu(bitmap[k]);
-
-                    nbits = ctpopl(temp);
-                    qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
-
-                    if (global_dirty_tracking) {
-                        qatomic_or(
-                                &blocks[DIRTY_MEMORY_MIGRATION][idx][offset],
-                                temp);
-                        if (unlikely(
-                            global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
-                            total_dirty_pages += nbits;
-                        }
-                    }
-
-                    num_dirty += nbits;
-
-                    if (tcg_enabled()) {
-                        qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
-                                   temp);
-                    }
-                }
-
-                if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
-                    offset = 0;
-                    idx++;
-                }
-            }
-        }
-
-        if (xen_enabled()) {
-            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
-        }
-    } else {
-        uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
-
-        if (!global_dirty_tracking) {
-            clients &= ~(1 << DIRTY_MEMORY_MIGRATION);
-        }
-
-        /*
-         * bitmap-traveling is faster than memory-traveling (for addr...)
-         * especially when most of the memory is not dirty.
-         */
-        for (i = 0; i < len; i++) {
-            if (bitmap[i] != 0) {
-                c = leul_to_cpu(bitmap[i]);
-                nbits = ctpopl(c);
-                if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
-                    total_dirty_pages += nbits;
-                }
-                num_dirty += nbits;
-                do {
-                    j = ctzl(c);
-                    c &= ~(1ul << j);
-                    page_number = (i * HOST_LONG_BITS + j) * hpratio;
-                    addr = page_number * TARGET_PAGE_SIZE;
-                    ram_addr = start + addr;
-                    cpu_physical_memory_set_dirty_range(ram_addr,
-                                       TARGET_PAGE_SIZE * hpratio, clients);
-                } while (c != 0);
-            }
-        }
-    }
-
-    return num_dirty;
-}
+                                                ram_addr_t pages);
 
 static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
                                                           ram_addr_t length)
diff --git a/system/physmem.c b/system/physmem.c
index 8e6c6dddc3c..e01b27ac252 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1207,6 +1207,109 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
     return false;
 }
 
+uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
+                                                ram_addr_t start,
+                                                ram_addr_t pages)
+{
+    unsigned long i, j;
+    unsigned long page_number, c, nbits;
+    hwaddr addr;
+    ram_addr_t ram_addr;
+    uint64_t num_dirty = 0;
+    unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
+    unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
+    unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
+
+    /* start address is aligned at the start of a word? */
+    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) &&
+        (hpratio == 1)) {
+        unsigned long **blocks[DIRTY_MEMORY_NUM];
+        unsigned long idx;
+        unsigned long offset;
+        long k;
+        long nr = BITS_TO_LONGS(pages);
+
+        idx = (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
+        offset = BIT_WORD((start >> TARGET_PAGE_BITS) %
+                          DIRTY_MEMORY_BLOCK_SIZE);
+
+        WITH_RCU_READ_LOCK_GUARD() {
+            for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
+                blocks[i] =
+                    qatomic_rcu_read(&ram_list.dirty_memory[i])->blocks;
+            }
+
+            for (k = 0; k < nr; k++) {
+                if (bitmap[k]) {
+                    unsigned long temp = leul_to_cpu(bitmap[k]);
+
+                    nbits = ctpopl(temp);
+                    qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
+
+                    if (global_dirty_tracking) {
+                        qatomic_or(
+                                &blocks[DIRTY_MEMORY_MIGRATION][idx][offset],
+                                temp);
+                        if (unlikely(
+                            global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
+                            total_dirty_pages += nbits;
+                        }
+                    }
+
+                    num_dirty += nbits;
+
+                    if (tcg_enabled()) {
+                        qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
+                                   temp);
+                    }
+                }
+
+                if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
+                    offset = 0;
+                    idx++;
+                }
+            }
+        }
+
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
+    } else {
+        uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL
+                                        : DIRTY_CLIENTS_NOCODE;
+
+        if (!global_dirty_tracking) {
+            clients &= ~(1 << DIRTY_MEMORY_MIGRATION);
+        }
+
+        /*
+         * bitmap-traveling is faster than memory-traveling (for addr...)
+         * especially when most of the memory is not dirty.
+         */
+        for (i = 0; i < len; i++) {
+            if (bitmap[i] != 0) {
+                c = leul_to_cpu(bitmap[i]);
+                nbits = ctpopl(c);
+                if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
+                    total_dirty_pages += nbits;
+                }
+                num_dirty += nbits;
+                do {
+                    j = ctzl(c);
+                    c &= ~(1ul << j);
+                    page_number = (i * HOST_LONG_BITS + j) * hpratio;
+                    addr = page_number * TARGET_PAGE_SIZE;
+                    ram_addr = start + addr;
+                    cpu_physical_memory_set_dirty_range(ram_addr,
+                                       TARGET_PAGE_SIZE * hpratio, clients);
+                } while (c != 0);
+            }
+        }
+    }
+
+    return num_dirty;
+}
+
 static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
                             uint16_t section);
 static subpage_t *subpage_init(FlatView *fv, hwaddr base);
-- 
2.51.0


