Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0127CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wWI-0003Or-Cg; Sat, 04 Oct 2025 03:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wV8-0002RW-5D
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wV5-0005PK-Tw
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so1412603f8f.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562174; x=1760166974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/jYvGOrOe33ufI4kFW7Rd8uIp9s0RhtS2HUhVAorcWQ=;
 b=UHsVmUMRDLTAwAHGTTEi43l9414E+LL4DrZIqZ2c9fLZXvfCTi5GqoAa+nafS4JSKH
 RT2U/QBIYtayayWXENb2KCVOor7y2IPfvWwFt1eiHe7jIqI8q2zFz6Hei35Hjl9qShCx
 WkCQiuS9f6aA9V1XWfVu6h6swpIbrJxuygFyCxguYC5tMKffE4lFG9X7TiuXe4N7RxmX
 FlwnLL1k85ut1ojUSrpBaC9SkeJxQXSjhZ5CdsN/4Xm6zJ3VBTD3PH5a+R8KxhCDNeYi
 SJFvnI9T8EvDmOuWaR/zu86BEJLWgtW0VzjpO9ht/kIpBiznX5zLkQM4JL715SzAuFQa
 1onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562174; x=1760166974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jYvGOrOe33ufI4kFW7Rd8uIp9s0RhtS2HUhVAorcWQ=;
 b=LA8F+dLwaTxwKwZMi3QVrfi+tw1+bEeEprojzaFFHPCZHP7bMMCso4o7QwmTXL/i9B
 HVhEaXGUhGvs65shDcP7C9O/Vqt1ZnPGmHjfu+3f8yI7kQ6dYdIoXO2fKdKFKonql184
 AHKQcaxW51kVqL0NFCyl6bW2lAWDnD9XlTr8WU5lS9Qq31VPFBaqUJze66y5/xxs6ZOK
 ZQr0sM/8cjjLD724l+D5K5DxWrzxq4qeYLM8MUy3MA9QEnXZh5zrrU4ZVNZRANWEfUwq
 V56oY6AmLcWOqIL18GiXU+cq4FdwHPxCGimSlPfTBHAyKxGdkuOOFw2iFbL9fS2uvinS
 ezZA==
X-Gm-Message-State: AOJu0Yzi6iKmYDbKIqPYMSfU27w3RNJq62x3NaGX1wDWPxsMx0pV+RYP
 AVzVJLALBwPlzYq4OUSUj755ExtbWCiLpSUXVb+lyj1fYBxmQuz9ZlSo4qfQu191vcwYqLp8RBO
 x1tHpSnKS2g==
X-Gm-Gg: ASbGnctsCvhxVAJo+WvBvVBmOfP0n6s74GMyjWvGzn4H2VFPUMuiSZakJUKOmjv4hmQ
 Xsj0YCvn1PwMmTguEVDFO8/BKRhGgPldu4Sus4/hCBSPJbFh/3IJ/vLu7H+UYY1GGEVxJkTfhdo
 XEQLk7eGwT22PpGtWbXAy4jcw/K+eUHBtWh6KilaJJx1qHGjejbrG12DVUI43EyzR62k0Ft+1K0
 JXYBEvHdfPYHY7Cp6Lx/a3Z/QFjb8UhHUoGI3aSGP6SboKz4SVcbuhM7RCKPjEvCWP0/zvZGk2I
 h+NKReVmmxO4iwKVzNFANYqj+rIoL6nUIDyRxOymM/375rAD8fAcBwIFX/w/NwuwdsUWqT3Xo4V
 KhtIWTmT934W8UtV6nnKsTCb6UIYTFBvXgLHuRphmF5cbrwy9/1LafCqMz2h7BTvEZcp/vFD18L
 DkW10tQys7zltjtjRZUwoKytezq1i8UboJLQs=
X-Google-Smtp-Source: AGHT+IEdisP45cFbWCkrocaZuRR6xkn7VVBKosQyUGLabLcSA3snthQ2qaFWfC5IQhoc6OlBVFnf1Q==
X-Received: by 2002:a05:6000:2583:b0:3f1:5bdd:190a with SMTP id
 ffacd0b85a97d-42567137bffmr3419844f8f.3.1759562173712; 
 Sat, 04 Oct 2025 00:16:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d869d50sm11456803f8f.0.2025.10.04.00.16.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:16:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/41] system/physmem: Reduce
 cpu_physical_memory_sync_dirty_bitmap() scope
Date: Sat,  4 Oct 2025 09:13:05 +0200
Message-ID: <20251004071307.37521-40-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

cpu_physical_memory_sync_dirty_bitmap() is now only called within
system/physmem.c, by ramblock_sync_dirty_bitmap(). Reduce its scope
by making it internal to this file. Since it doesn't involve any CPU,
remove the 'cpu_' prefix.
Remove the now unneeded "qemu/rcu.h" and "system/memory.h" headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-17-philmd@linaro.org>
---
 include/system/ram_addr.h | 79 ---------------------------------------
 migration/ram.c           | 77 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 80 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index cafd258580e..d2d088bbea6 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -21,10 +21,7 @@
 
 #include "exec/ramlist.h"
 #include "system/ramblock.h"
-#include "system/memory.h"
 #include "exec/target_page.h"
-#include "qemu/rcu.h"
-
 #include "exec/hwaddr.h"
 
 extern uint64_t total_dirty_pages;
@@ -175,80 +172,4 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
                                             ram_addr_t length);
 
-/* Called with RCU critical section */
-static inline
-uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
-                                               ram_addr_t start,
-                                               ram_addr_t length)
-{
-    ram_addr_t addr;
-    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
-    uint64_t num_dirty = 0;
-    unsigned long *dest = rb->bmap;
-
-    /* start address and length is aligned at the start of a word? */
-    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
-         (start + rb->offset) &&
-        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
-        int k;
-        int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
-        unsigned long * const *src;
-        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
-                                        DIRTY_MEMORY_BLOCK_SIZE);
-        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
-
-        src = qatomic_rcu_read(
-                &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
-
-        for (k = page; k < page + nr; k++) {
-            if (src[idx][offset]) {
-                unsigned long bits = qatomic_xchg(&src[idx][offset], 0);
-                unsigned long new_dirty;
-                new_dirty = ~dest[k];
-                dest[k] |= bits;
-                new_dirty &= bits;
-                num_dirty += ctpopl(new_dirty);
-            }
-
-            if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
-                offset = 0;
-                idx++;
-            }
-        }
-        if (num_dirty) {
-            cpu_physical_memory_dirty_bits_cleared(start, length);
-        }
-
-        if (rb->clear_bmap) {
-            /*
-             * Postpone the dirty bitmap clear to the point before we
-             * really send the pages, also we will split the clear
-             * dirty procedure into smaller chunks.
-             */
-            clear_bmap_set(rb, start >> TARGET_PAGE_BITS,
-                           length >> TARGET_PAGE_BITS);
-        } else {
-            /* Slow path - still do that in a huge chunk */
-            memory_region_clear_dirty_bitmap(rb->mr, start, length);
-        }
-    } else {
-        ram_addr_t offset = rb->offset;
-
-        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
-            if (cpu_physical_memory_test_and_clear_dirty(
-                        start + addr + offset,
-                        TARGET_PAGE_SIZE,
-                        DIRTY_MEMORY_MIGRATION)) {
-                long k = (start + addr) >> TARGET_PAGE_BITS;
-                if (!test_and_set_bit(k, dest)) {
-                    num_dirty++;
-                }
-            }
-        }
-    }
-
-    return num_dirty;
-}
-
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 91e65be83d8..52bdfec91d9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -935,11 +935,86 @@ bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start)
     return false;
 }
 
+/* Called with RCU critical section */
+static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
+                                                  ram_addr_t start,
+                                                  ram_addr_t length)
+{
+    ram_addr_t addr;
+    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
+    uint64_t num_dirty = 0;
+    unsigned long *dest = rb->bmap;
+
+    /* start address and length is aligned at the start of a word? */
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
+         (start + rb->offset) &&
+        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
+        int k;
+        int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
+        unsigned long * const *src;
+        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
+                                        DIRTY_MEMORY_BLOCK_SIZE);
+        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
+
+        src = qatomic_rcu_read(
+                &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
+
+        for (k = page; k < page + nr; k++) {
+            if (src[idx][offset]) {
+                unsigned long bits = qatomic_xchg(&src[idx][offset], 0);
+                unsigned long new_dirty;
+                new_dirty = ~dest[k];
+                dest[k] |= bits;
+                new_dirty &= bits;
+                num_dirty += ctpopl(new_dirty);
+            }
+
+            if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
+                offset = 0;
+                idx++;
+            }
+        }
+        if (num_dirty) {
+            cpu_physical_memory_dirty_bits_cleared(start, length);
+        }
+
+        if (rb->clear_bmap) {
+            /*
+             * Postpone the dirty bitmap clear to the point before we
+             * really send the pages, also we will split the clear
+             * dirty procedure into smaller chunks.
+             */
+            clear_bmap_set(rb, start >> TARGET_PAGE_BITS,
+                           length >> TARGET_PAGE_BITS);
+        } else {
+            /* Slow path - still do that in a huge chunk */
+            memory_region_clear_dirty_bitmap(rb->mr, start, length);
+        }
+    } else {
+        ram_addr_t offset = rb->offset;
+
+        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
+            if (cpu_physical_memory_test_and_clear_dirty(
+                        start + addr + offset,
+                        TARGET_PAGE_SIZE,
+                        DIRTY_MEMORY_MIGRATION)) {
+                long k = (start + addr) >> TARGET_PAGE_BITS;
+                if (!test_and_set_bit(k, dest)) {
+                    num_dirty++;
+                }
+            }
+        }
+    }
+
+    return num_dirty;
+}
+
 /* Called with RCU critical section */
 static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb)
 {
     uint64_t new_dirty_pages =
-        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length);
+        physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length);
 
     rs->migration_dirty_pages += new_dirty_pages;
     rs->num_dirty_pages_period += new_dirty_pages;
-- 
2.51.0


