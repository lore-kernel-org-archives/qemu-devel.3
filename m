Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCBCCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v414h-0003qj-26; Wed, 01 Oct 2025 13:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v414N-0003Mn-3s
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413g-0001Bj-NI
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso565625e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341361; x=1759946161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mkNvNweP1pxd0bnKscXA4YxA7b00HLHFCf5l8AtEj4=;
 b=nzBr+v/KNiY7FEh05RZlSrWuk3iR3+cXStRFRO8RrTuQzfmmSx/03jqNtTOKuABAtr
 cahCivcccr4XfpSpLPpG0IztrlP0ZJZAH9QKRvgH3+qhlQMJZ675OdVnHQGUhs1c1FUv
 fkALax7MmpEvYwgQ4344EbnDz0JoeQgw9ZddOquYWwXLsW3O4hRa6/6D7ydfRX2DdmFF
 L8JsP31gER3VX+350bpv3/panJ/0mH6D6iADLkG+Otnuzk6KeOGdJIcop/wmGt2YBqNr
 52QMtIHXv9OcxMHpvRPJkogHmfrso5vd/MadgQKyNV7+hOAO+Nj2xJLhfUkHb8/z+5zx
 3g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341361; x=1759946161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mkNvNweP1pxd0bnKscXA4YxA7b00HLHFCf5l8AtEj4=;
 b=uHN/PSzEyK10B6snKsQnpzWngTfUT4Jjp1AjDKqhutGxd0lqMzXRu8QagFmUXEZqCJ
 pSU9shtXq67J6peLXF9YMJWlUq4D2gdZgVivIXpjzUjlU0bzNJDKvTA5DpKZbTu+d4+P
 XAg4kOkB9wCPA6yqCZV1oPZMB081Bkt+qwmoNsrtpq1FvCdaOS6tzx3FBl99a+nzjM1W
 9gULp0iU/Chko6BmVaO4SG5QbiKrs4hrDli0NHzYK1fhk5WzzMTiwrmY/fAMX61zutNX
 10lbPwaHVurIS4UNyRVFcHgLDcihRNhW3a8pm+8tSOBmcZdH0NkBPGHNJ3RFsDnNdl0N
 uqig==
X-Gm-Message-State: AOJu0YyiFl5gUUFTeI6LU8Zpri9fcsK5JqHSBSJd2tQRsvpBP2J7jXr3
 Y9LUMdX9XbQAaMNboNIr2m+Rb9EwL173ITE5+5maXaVTeJQKAYnlKs3iIa0lObdXnO2GtjCNRYR
 hHLYmYgOnAw==
X-Gm-Gg: ASbGncvJ1bytXK7pGOo4hXlRQK/AwAT24b0LvoEuSvvCWXFk6HchiSHf6BrKQz8hYpf
 udzGTjOIJmAwnHIqVM12Wgi0lqpT52Gn1gaVgKMGGNc9n3n2FSRh7Gpn22RcnDUM21GkMcLy7fW
 n2ZPJfT1Z8EQF0nu+G716lBpLb/eJh9cN8HEDMZ/HIhWkki2A188WIR1Rl0gMJkcHDfU2y8XtjG
 P0slbeRbQTRiqdmb9m9h7aOzFSuQofoR8wWAMduuz6gmUj8NGwFMe/LfdPIXF4zWpUHn6uNldwE
 5iTE1MVMV5pbZp46jyFmh8QD+Bw1oQ7yIflNoTQMXmP5o2Fyoz7gvj7QNKf65yTjBTHRRDlDNUr
 nvBojGZ3aNF6Ok9xBot8QGS4nCUtzb5BxGM15iufRLIhInAsykAD63nuVaYErg35ELP6MqRLWXi
 C78EchlzhjxWILD6vunuf1Hvoiuw==
X-Google-Smtp-Source: AGHT+IHq9VNc9JggIDZKso6cjA0ZuxmHGfw+jg4YC7/WYfBxvvIDxxthg/1nTg2Nzka46BbMEMaitw==
X-Received: by 2002:a05:600c:6692:b0:46e:502c:8d6a with SMTP id
 5b1f17b1804b1-46e64641e65mr26102255e9.25.1759341361449; 
 Wed, 01 Oct 2025 10:56:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6917a867sm1316275e9.5.2025.10.01.10.55.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:56:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 13/18] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_lebitmap()
Date: Wed,  1 Oct 2025 19:54:42 +0200
Message-ID: <20251001175448.18933-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


