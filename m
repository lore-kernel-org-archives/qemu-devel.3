Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2905C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPS4-0006w2-Pa; Mon, 10 Feb 2025 03:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRh-0006LZ-1J
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRe-00046T-UM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seVdatnc3fgAG3CaO7ikg8bHeVCEogup7eSy/wrd7Ng=;
 b=BXrpfZDg7ZyC3BsJS0GH6Qkw7/h8wDoCZuLPQOagLuiH8Tsw+q3JCGBBU3cmo0TrHHdAoE
 CHaBOhWYyeBVYytKmnEOpCM1PIVMMsRcDvkzBsFBKwgkvW7YhVpsg13mPtfTkRvZfgEMN/
 t91fM8wVWqsS2/HehlAKwEg8G++jj+I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-9UyV-bUjOAyLzMhiV2nImg-1; Mon, 10 Feb 2025 03:47:08 -0500
X-MC-Unique: 9UyV-bUjOAyLzMhiV2nImg-1
X-Mimecast-MFC-AGG-ID: 9UyV-bUjOAyLzMhiV2nImg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dcd8ddc5eso1711863f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177227; x=1739782027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seVdatnc3fgAG3CaO7ikg8bHeVCEogup7eSy/wrd7Ng=;
 b=GFIGp7eZ+DLMgrEsJdupyjFoPVb7buUYDO90/ES8wE9MxROtB7I9ifODhD6DtRSD2R
 4m7YuR7ywS1X6/RgIhB7gOTn9Q55pv8xjdSvhhcaI9BNOW1vfH5cV28AdUdk51h7h0OM
 neCpBY2CHEu452ne0C1Jm0dvGPZqx3S2BVu/GAjDAAjxbZXFm9uInzx8aheCfBE0S/Qt
 Qofllx4w5/pOoBT9pbQ9netwNYsOGIUuT+PuJcw68BKEw7rtr/YPzOnQwBWJQDc0dwK8
 C8XdrHP5NFa4XKIpFEW0JjWt90LNiqAO+rLaepNXN7K5WUcnW0OyMKrP6OjJEpunyvcs
 NNSw==
X-Gm-Message-State: AOJu0Yx1reoaP7LLeGlE4mJXl+2KAmOh1cMVTsZTynWp7HijmM6jFubI
 cwVi7LORpaC7PztqL2vng2ASTku7V/UXDam4r+kqI31CGWlx6JqWSzPCEO5bmoiMEi4TsjAFEmG
 stAOkM71Dmr31YqQEMFhVOuh1arck8l1aJOqBHlOcqcPChY8iZB81wbvVlK6r6jpr9in68lzLPO
 x2NptSthLUdhVhlzE2tY9T6U/+w3xasmw0
X-Gm-Gg: ASbGnct9yDq8oQ/8oFOyUVLrQeAhtyzG20SmfYfcNFxvDg+PFuWS3VUmf3LY1rlz3Cj
 fR28uziRF/YZkOFsiXD+HA0/VY+HazrvSkw22GsCRpQBL0uMkk8CldJh1L1w22xKhnPJjzLnlA6
 fhSJvlVxpneRLzcGOqqvP9BIvFZcTK4SbUX4O8iBQX1p8dDUmyOR7wbhad68GYtWCI7jh6cFx8d
 yy6bSkbzCAe3fB4xaavtB1VbhbKfpZZzG/KEilPzxwHwn5MnnKL6RkRgs4iuvXnLXp1lSglGeFb
 f7d8OTzP2GJqeC8+O/yrugT81kcGHIyXGIpx22YeTo+mMDvnzUSG2yOoXsSOSUiCyw==
X-Received: by 2002:a05:6000:1fab:b0:38d:deb4:4ee8 with SMTP id
 ffacd0b85a97d-38ddeb453b0mr2496659f8f.28.1739177227338; 
 Mon, 10 Feb 2025 00:47:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvjaJjZSDcMP+j5oeEvAv7tB7Wuv3EmgtCRLgGWIT6Qc1hxoudvQYFZRHeZwKLI45oSRPLhQ==
X-Received: by 2002:a05:6000:1fab:b0:38d:deb4:4ee8 with SMTP id
 ffacd0b85a97d-38ddeb453b0mr2496619f8f.28.1739177226837; 
 Mon, 10 Feb 2025 00:47:06 -0800 (PST)
Received: from localhost
 (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de.
 [2003:cb:c734:b800:12c4:65cd:348a:aee6])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38dcb781bdcsm8582700f8f.23.2025.02.10.00.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:47:05 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v3 5/7] memory: pass MemTxAttrs to memory_access_is_direct()
Date: Mon, 10 Feb 2025 09:46:46 +0100
Message-ID: <20250210084648.33798-6-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
References: <20250210084648.33798-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We want to pass another flag that will be stored in MemTxAttrs. So pass
MemTxAttrs directly.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/loader.c          |  2 +-
 hw/remote/vfio-user-obj.c |  2 +-
 include/exec/memory.h     |  5 +++--
 system/memory_ldst.c.inc  | 18 +++++++++---------
 system/physmem.c          | 12 ++++++------
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index fd25c5e01b..332b879a0b 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -144,7 +144,7 @@ ssize_t load_image_mr(const char *filename, MemoryRegion *mr)
 {
     ssize_t size;
 
-    if (!memory_access_is_direct(mr, false)) {
+    if (!memory_access_is_direct(mr, false, MEMTXATTRS_UNSPECIFIED)) {
         /* Can only load an image into RAM or ROM */
         return -1;
     }
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 9e5ff6d87a..6e51a92856 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -358,7 +358,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
     int access_size;
     uint64_t val;
 
-    if (memory_access_is_direct(mr, is_write)) {
+    if (memory_access_is_direct(mr, is_write, MEMTXATTRS_UNSPECIFIED)) {
         /**
          * Some devices expose a PCI expansion ROM, which could be buffer
          * based as compared to other regions which are primarily based on
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4e2cf95ab6..b18ecf933e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3012,7 +3012,8 @@ static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
     return !memory_region_is_ram_device(mr);
 }
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
+                                           MemTxAttrs attrs)
 {
     if (!memory_region_supports_direct_access(mr)) {
         return false;
@@ -3053,7 +3054,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
             fv = address_space_to_flatview(as);
             l = len;
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
-            if (len == l && memory_access_is_direct(mr, false)) {
+            if (len == l && memory_access_is_direct(mr, false, attrs)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
                 memcpy(buf, ptr, len);
             } else {
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 0e6f3940a9..7f32d3d9ff 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -34,7 +34,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, false)) {
+    if (l < 4 || !memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
@@ -103,7 +103,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 8 || !memory_access_is_direct(mr, false)) {
+    if (l < 8 || !memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
@@ -170,7 +170,7 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (!memory_access_is_direct(mr, false)) {
+    if (!memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
@@ -207,7 +207,7 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
-    if (l < 2 || !memory_access_is_direct(mr, false)) {
+    if (l < 2 || !memory_access_is_direct(mr, false, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
@@ -277,7 +277,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, true)) {
+    if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
 
         r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
@@ -314,7 +314,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 4 || !memory_access_is_direct(mr, true)) {
+    if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_32 | devend_memop(endian), attrs);
@@ -377,7 +377,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (!memory_access_is_direct(mr, true)) {
+    if (!memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
     } else {
@@ -410,7 +410,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 2 || !memory_access_is_direct(mr, true)) {
+    if (l < 2 || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_16 | devend_memop(endian), attrs);
@@ -474,7 +474,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
 
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
-    if (l < 8 || !memory_access_is_direct(mr, true)) {
+    if (l < 8 || !memory_access_is_direct(mr, true, attrs)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_64 | devend_memop(endian), attrs);
diff --git a/system/physmem.c b/system/physmem.c
index 7cfcc6cafa..9766c6d2e0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -573,7 +573,7 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
                                     is_write, true, &as, attrs);
     mr = section.mr;
 
-    if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
+    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
         *plen = MIN(page, *plen);
     }
@@ -2869,7 +2869,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
         return MEMTX_ACCESS_ERROR;
     }
 
-    if (!memory_access_is_direct(mr, true)) {
+    if (!memory_access_is_direct(mr, true, attrs)) {
         uint64_t val;
         MemTxResult result;
         bool release_lock = prepare_mmio_access(mr);
@@ -2965,7 +2965,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         return MEMTX_ACCESS_ERROR;
     }
 
-    if (!memory_access_is_direct(mr, false)) {
+    if (!memory_access_is_direct(mr, false, attrs)) {
         /* I/O case */
         uint64_t val;
         MemTxResult result;
@@ -3274,7 +3274,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
     while (len > 0) {
         l = len;
         mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
-        if (!memory_access_is_direct(mr, is_write)) {
+        if (!memory_access_is_direct(mr, is_write, attrs)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
                 return false;
@@ -3354,7 +3354,7 @@ void *address_space_map(AddressSpace *as,
     fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
-    if (!memory_access_is_direct(mr, is_write)) {
+    if (!memory_access_is_direct(mr, is_write, attrs)) {
         size_t used = qatomic_read(&as->bounce_buffer_size);
         for (;;) {
             hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
@@ -3487,7 +3487,7 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
 
     mr = cache->mrs.mr;
     memory_region_ref(mr);
-    if (memory_access_is_direct(mr, is_write)) {
+    if (memory_access_is_direct(mr, is_write, MEMTXATTRS_UNSPECIFIED)) {
         /* We don't care about the memory attributes here as we're only
          * doing this if we found actual RAM, which behaves the same
          * regardless of attributes; so UNSPECIFIED is fine.
-- 
2.48.1


