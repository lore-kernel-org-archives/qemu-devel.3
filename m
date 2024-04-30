Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F57C25B5C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qhH-0000cP-W5; Tue, 30 Apr 2024 12:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgk-0006nr-9Z
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:43 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgh-00065B-5L
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:41 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51ca95db667so5702737e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495833; x=1715100633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DU0xtzI9Cm5N5WksUYgPVqXR4B2xCZmxh2qO529TbRk=;
 b=ZQNnnBvdj4R9M70zfuHqHMAalF+cPBVom1jP4zTWFeOLkJa2iJunutXx4BY3Fq7YeT
 mp1ZFirYZT6pRS9wnm1sUpLpIDkEGihTrVW+pP5TEmcQBm880LFzp7OKVgc5Oz1uQHWZ
 s6ax08qfczEwdfEwxJFiy23pk+9fWcyNG5uroM15A74mvhUt37ruLtvp6SpB7sYjmXU1
 4H+Ye2QFdyoyze3Farobia4+DliWEhFm2HKr43opJFl1fp7kdnjddClJh+RVmuhdKvlj
 6UnjWolWNJwIdKl9k71L+Fdk9SI4DQFSvrLVELl/tC90gUP6mo6+lXR6tpJ+jnzAvKSl
 5pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495833; x=1715100633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DU0xtzI9Cm5N5WksUYgPVqXR4B2xCZmxh2qO529TbRk=;
 b=gRUVDRAZnzxSfNYg4DIEJAk8x2hityuWBH/eBpQUZGDi3UvNGZgQ0VdC4FoytCIRGv
 EqbIT3ctMr+LXf0iCYMiUS1iDlMIasHWqfKlqbm2tuiXksQXYtp6MnNi5vRK0Soo9kWB
 FCEFDnpBUgVaFunkspG+jdsCXZiaChYUlrtOlFTq7x8u+nD9SDA3IsWKGCz0wHMyQH5t
 s3S54MoXi6e5Fxd8Hiv6E4bZoM0ApzVwH0MBszdGg7vdDxXH6r/2RPqTZpGPqAUa2y+F
 nr2cyUeLparI341XOmmyMZpWVneANj76+NWt6HdRQPilt7tDlEF7d2jUpqeyUJ06ExCk
 sbRw==
X-Gm-Message-State: AOJu0YxqbSNx++RB2aqdG0fFeGtVdnrdUnYOUIaYTDpuRvXn2LjgluNH
 4xekQ/bIbKyp9z9gy8f873sIRzTSXUbCyHkStihbU5Wm3iLPOEtTiUZqVlqw
X-Google-Smtp-Source: AGHT+IH5mCn6s8y3JJfLC094G9xqUv22UPPMyi0CQHk4jd06RZgbi6+GzYUXShvTx3wLunuX1iTX8w==
X-Received: by 2002:ac2:4852:0:b0:515:a8c9:6e99 with SMTP id
 18-20020ac24852000000b00515a8c96e99mr42447lfy.5.1714495833071; 
 Tue, 30 Apr 2024 09:50:33 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a19380f000000b0051aaf26f4a0sm4359741lfa.101.2024.04.30.09.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:32 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 13/17] softmmu: Pass RAM MemoryRegion and is_write
 xen_map_cache()
Date: Tue, 30 Apr 2024 18:49:35 +0200
Message-Id: <20240430164939.925307-14-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
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

Propagate MR and is_write to xen_map_cache().
This is in preparation for adding support for grant mappings.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c         | 10 ++++++----
 include/sysemu/xen-mapcache.h | 11 +++++++----
 system/physmem.c              | 31 +++++++++++++++++++++++--------
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 0365311788..09b5f36d9c 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -264,7 +264,7 @@ static void xen_remap_bucket(MapCache *mc,
 
 static uint8_t *xen_map_cache_unlocked(MapCache *mc,
                                        hwaddr phys_addr, hwaddr size,
-                                       uint8_t lock, bool dma)
+                                       uint8_t lock, bool dma, bool is_write)
 {
     MapCacheEntry *entry, *pentry = NULL,
                   *free_entry = NULL, *free_pentry = NULL;
@@ -387,13 +387,15 @@ tryagain:
     return mc->last_entry->vaddr_base + address_offset;
 }
 
-uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
-                       uint8_t lock, bool dma)
+uint8_t *xen_map_cache(MemoryRegion *mr,
+                       hwaddr phys_addr, hwaddr size,
+                       uint8_t lock, bool dma,
+                       bool is_write)
 {
     uint8_t *p;
 
     mapcache_lock(mapcache);
-    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma);
+    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma, is_write);
     mapcache_unlock(mapcache);
     return p;
 }
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index 10c2e3082a..1ec9e66752 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -18,8 +18,9 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
 
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
-uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
-                       uint8_t lock, bool dma);
+uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
+                       uint8_t lock, bool dma,
+                       bool is_write);
 ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
 void xen_invalidate_map_cache_entry(uint8_t *buffer);
 void xen_invalidate_map_cache(void);
@@ -33,10 +34,12 @@ static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
 {
 }
 
-static inline uint8_t *xen_map_cache(hwaddr phys_addr,
+static inline uint8_t *xen_map_cache(MemoryRegion *mr,
+                                     hwaddr phys_addr,
                                      hwaddr size,
                                      uint8_t lock,
-                                     bool dma)
+                                     bool dma,
+                                     bool is_write)
 {
     abort();
 }
diff --git a/system/physmem.c b/system/physmem.c
index f114b972a5..ad7a8c7d95 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2190,11 +2190,22 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
 
 /*
  * Return a host pointer to guest's ram.
+ * For Xen, foreign mappings get created if they don't already exist.
+ *
+ * @block: block for the RAM to lookup (optional and may be NULL).
+ * @addr: address within the memory region.
+ * @size: pointer to requested size (optional and may be NULL).
+ *        size may get modified and return a value smaller than
+ *        what was requested.
+ * @lock: wether to lock the mapping in xen-mapcache until invalidated.
+ * @is_write: hint wether to map RW or RO in the xen-mapcache.
+ *            (optional and may always be set to true).
  *
  * Called within RCU critical section.
  */
 static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
-                                 hwaddr *size, bool lock)
+                                 hwaddr *size, bool lock,
+                                 bool is_write)
 {
     hwaddr len = 0;
 
@@ -2217,10 +2228,13 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(addr, len, lock, lock);
+            return xen_map_cache(block->mr, addr, len, lock, lock,
+                                 is_write);
         }
 
-        block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
+        block->host = xen_map_cache(block->mr, block->offset,
+                                    block->max_length, 1,
+                                    lock, is_write);
     }
 
     return ramblock_ptr(block, addr);
@@ -2236,7 +2250,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
  */
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
 {
-    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
+    return qemu_ram_ptr_length(ram_block, addr, NULL, false, true);
 }
 
 /* Return the offset of a hostpointer within a ramblock */
@@ -2746,7 +2760,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
     } else {
         /* RAM case */
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
-                                               false);
+                                               false, true);
 
         memmove(ram_ptr, buf, *l);
         invalidate_and_set_dirty(mr, mr_addr, *l);
@@ -2839,7 +2853,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
     } else {
         /* RAM case */
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
-                                               false);
+                                               false, false);
 
         memcpy(buf, ram_ptr, *l);
 
@@ -3233,7 +3247,7 @@ void *address_space_map(AddressSpace *as,
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
     fuzz_dma_read_cb(addr, *plen, mr);
-    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
+    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true, is_write);
 }
 
 /* Unmaps a memory region previously mapped by address_space_map().
@@ -3329,7 +3343,8 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
         l = flatview_extend_translation(cache->fv, addr, len, mr,
                                         cache->xlat, l, is_write,
                                         MEMTXATTRS_UNSPECIFIED);
-        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true);
+        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true,
+                                         is_write);
     } else {
         cache->ptr = NULL;
     }
-- 
2.40.1


