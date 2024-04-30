Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C244C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qhJ-0000nb-5q; Tue, 30 Apr 2024 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgl-00075V-Sg
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:43 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgi-000660-HH
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:43 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-516d68d7a8bso5469257e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495836; x=1715100636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1O0c3lbCIPcVTDP2OG2o9vVTYuu5kyg6TUhLFf8SY0=;
 b=GTyCqx+hWaBOZWEH2w3Deo0TtW73/V1l5pLYKXyxCJQYF76939gEZ4p+gDMR6UKmRs
 R2qOGD+dM+qOqyVsLyuylpnIVvRA600xtfxP9ScLUr0diJ7I7ALFa8kKVYdAIZatCaSR
 JIWghPegpquToD/gR1Fg7hlRgoyhQb7MMMckNiUNZsruU9LuSloPv2ZGWSJWmKzQHETa
 DsxfHHG2yzKAUoM4rVHEYlj12oS1pP5oxY29JwtKnSm+qL26HJNmIzeAQh60DEX4a2CL
 quUDttIbB4dlZ3iCVL0wO40NqS8q3KWAOjjiGDlIQPQrkvSzupzKbQRbo6tnOuuh+AJs
 HlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495836; x=1715100636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1O0c3lbCIPcVTDP2OG2o9vVTYuu5kyg6TUhLFf8SY0=;
 b=fLfMjnpEvDdZQymDv+Z/zvdRALu8riO1JkajuJ9v6Nz/HRODd5xbtZrVhohToKFC4e
 bWv7kK3pXEqSXmpyjME3xGWMtLY/91m2J+TiVPFgQ/QLGJwpoC3tHR+m3elGzs2y5Fq0
 Fd/xzNtI9uaIAaCTKtD8edzFG0JzfqB2gQcEIvk5mMiuAM9o/xkE8pmR1EXx4eOYMayE
 hxE+t0S3qnrBcXwxrqy92ajJ8oQtyev96h+15UNjEi+AfFp+9I7nV7pqDNLsx1oMwHKV
 fZZHCFlXzc/xdpSCKTgSfAg377g/r4nK2ETQ8583qwFD2//HSJDLBVDURUZdnLwK70sV
 T/PQ==
X-Gm-Message-State: AOJu0Ywn6gmCOjwV7kzedsEGvyveA1aPpXAskYPI0k8KQv+nMQc3g73F
 uVC8bmtInbUty3NTZchW65BmnMT1zERB0WgojAiJB81gQS46AfDqakmhfJZW
X-Google-Smtp-Source: AGHT+IEvjQlWDNSp7Iep3p7LGdRlo9ppcQEfRdIFgR8UUsJQ+BGno9B+qbCWNATble5SB4/21MS5zA==
X-Received: by 2002:a05:6512:21e:b0:51a:bd22:12a7 with SMTP id
 a30-20020a056512021e00b0051abd2212a7mr1077307lfo.26.1714495836367; 
 Tue, 30 Apr 2024 09:50:36 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 v28-20020ac2593c000000b0051905a9c212sm4531378lfi.195.2024.04.30.09.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:35 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 15/17] xen: mapcache: Remove assumption of RAMBlock with 0
 offset
Date: Tue, 30 Apr 2024 18:49:37 +0200
Message-Id: <20240430164939.925307-16-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The current mapcache assumes that all memory is mapped
in a single RAM MR (the first one with offset 0). Remove
this assumption and propagate the offset to the mapcache
so it can do reverse mappings (from hostptr -> ram_addr).

This is in preparation for adding grant mappings.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c         | 25 ++++++++++++++++++-------
 include/sysemu/xen-mapcache.h |  2 ++
 system/physmem.c              |  8 ++++----
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 09b5f36d9c..1b32d0c003 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -43,6 +43,9 @@ typedef struct MapCacheEntry {
 #define XEN_MAPCACHE_ENTRY_DUMMY (1 << 0)
     uint8_t flags;
     hwaddr size;
+
+    /* Keep ram_addr offset for reverse mappings (hostptr -> ram_addr).  */
+    ram_addr_t ram_offset;
     struct MapCacheEntry *next;
 } MapCacheEntry;
 
@@ -165,7 +168,8 @@ static void xen_remap_bucket(MapCache *mc,
                              void *vaddr,
                              hwaddr size,
                              hwaddr address_index,
-                             bool dummy)
+                             bool dummy,
+                             ram_addr_t ram_offset)
 {
     uint8_t *vaddr_base;
     xen_pfn_t *pfns;
@@ -244,6 +248,7 @@ static void xen_remap_bucket(MapCache *mc,
     entry->size = size;
     entry->valid_mapping = g_new0(unsigned long,
                                   BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
+    entry->ram_offset = ram_offset;
 
     if (dummy) {
         entry->flags |= XEN_MAPCACHE_ENTRY_DUMMY;
@@ -264,6 +269,7 @@ static void xen_remap_bucket(MapCache *mc,
 
 static uint8_t *xen_map_cache_unlocked(MapCache *mc,
                                        hwaddr phys_addr, hwaddr size,
+                                       ram_addr_t ram_offset,
                                        uint8_t lock, bool dma, bool is_write)
 {
     MapCacheEntry *entry, *pentry = NULL,
@@ -335,14 +341,16 @@ tryagain:
     if (!entry) {
         entry = g_new0(MapCacheEntry, 1);
         pentry->next = entry;
-        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
+        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
+                         ram_offset);
     } else if (!entry->lock) {
         if (!entry->vaddr_base || entry->paddr_index != address_index ||
                 entry->size != cache_size ||
                 !test_bits(address_offset >> XC_PAGE_SHIFT,
                     test_bit_size >> XC_PAGE_SHIFT,
                     entry->valid_mapping)) {
-            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
+            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
+                             ram_offset);
         }
     }
 
@@ -389,13 +397,15 @@ tryagain:
 
 uint8_t *xen_map_cache(MemoryRegion *mr,
                        hwaddr phys_addr, hwaddr size,
+                       ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
                        bool is_write)
 {
     uint8_t *p;
 
     mapcache_lock(mapcache);
-    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma, is_write);
+    p = xen_map_cache_unlocked(mapcache, phys_addr, size, ram_addr_offset,
+                               lock, dma, is_write);
     mapcache_unlock(mapcache);
     return p;
 }
@@ -432,7 +442,8 @@ static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
         raddr = RAM_ADDR_INVALID;
     } else {
         raddr = (reventry->paddr_index << mc->bucket_shift) +
-             ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
+             ((unsigned long) ptr - (unsigned long) entry->vaddr_base) +
+             entry->ram_offset;
     }
     mapcache_unlock(mc);
     return raddr;
@@ -627,8 +638,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
 
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
-    xen_remap_bucket(mapcache, entry, entry->vaddr_base,
-                     cache_size, address_index, false);
+    xen_remap_bucket(mc, entry, entry->vaddr_base,
+                     cache_size, address_index, false, entry->ram_offset);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index 1ec9e66752..b5e3ea1bc0 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -19,6 +19,7 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
 uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
+                       ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
                        bool is_write);
 ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
@@ -37,6 +38,7 @@ static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
 static inline uint8_t *xen_map_cache(MemoryRegion *mr,
                                      hwaddr phys_addr,
                                      hwaddr size,
+                                     ram_addr_t ram_addr_offset,
                                      uint8_t lock,
                                      bool dma,
                                      bool is_write)
diff --git a/system/physmem.c b/system/physmem.c
index 1a5ffcba2a..5b16eeccca 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2228,13 +2228,13 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (xen_mr_is_memory(block->mr)) {
-            return xen_map_cache(block->mr, addr, len, lock, lock,
-                                 is_write);
+            return xen_map_cache(block->mr, addr, len, block->offset,
+                                 lock, lock, is_write);
         }
 
         block->host = xen_map_cache(block->mr, block->offset,
-                                    block->max_length, 1,
-                                    lock, is_write);
+                                    block->max_length, 0,
+                                    1, lock, is_write);
     }
 
     return ramblock_ptr(block, addr);
-- 
2.40.1


