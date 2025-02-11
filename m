Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B912C021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6I-0005hN-NQ; Tue, 11 Feb 2025 17:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6G-0005gF-1D
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6D-000564-SE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLWlmmzb89GolrhpSAzIBMC01IwngDNc8Jt0Hcx2LH0=;
 b=ZNtZzQtL8SLKZ9MPgJrn6pmJg9TUhMIb5sByq/vFXZXn/dGdDCiIL7ah5DD1nkk3f21z4Q
 GkgfeoE4+D37Vz0uh4qYioc4hWRzSGBUQFH4tbtF+83DlXOnTJ0+kJA94gJWzAjeriXtHM
 bBYg4AnlCfUwZwKh+kv8pT/8lH8+UdM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ybGuAkzpMxmC8X1iDtB1gg-1; Tue, 11 Feb 2025 17:51:22 -0500
X-MC-Unique: ybGuAkzpMxmC8X1iDtB1gg-1
X-Mimecast-MFC-AGG-ID: ybGuAkzpMxmC8X1iDtB1gg
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3f3b93f4810so2086657b6e.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314281; x=1739919081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLWlmmzb89GolrhpSAzIBMC01IwngDNc8Jt0Hcx2LH0=;
 b=r+CK27H4PWS3WOWTkvGi69g7Ava/9r0ZsiiyLds733gxNbVGClEfk7c7DQ22s/QTYg
 AMO2La8hA9onOSbxm7PgOf1By6LbSjqjaPs8Ty/W6oeop7o6qcdOKK7DTSN2BYnBrsbW
 7CCGzsvgfC28nhM0NiFfBOGIMaNvwe2kjfQRPVHZbClsRH7ED+Ps8P3XV+yGMN6gMh3b
 whxtwz+/lFa3dUPq9Sw3HuL2zPN+Q0XtoaeD8iw2EQxG1klwO2By1XEB+Wkk47EsrH01
 yRi9FZCIzd7nLXDkm3MRMiy/waQiG3nPqsXgBA+Me60dj4zrd6PPGbuiyDyo9/6enq6F
 5ZqA==
X-Gm-Message-State: AOJu0Yxr+f/RhltWZQpDB6NALyTb7mP++ZwTVdBUmpVRyguH3x+eQwN/
 qhDxmcr2z94/mccQzyJuz7EAJCxnpWA2ejaeWaXffVGOIct9HQ7SQ7Fa8aoX41x5SpWjIKQsbh7
 R3pA7sJP9AYtyGhjKs4GtPgI1yhPhEQkYJ/eICzNghwIFAQLfBACsz8GuN+ir3aRvTLTwW7jvCx
 yB87QG0m45/in5arxDOqZTNC3uYmSbTBqSRg==
X-Gm-Gg: ASbGncuq46mDFt9r8zttMrbbu/YretDeLcWqyUySKkiSUrLKSDnPy10JKD3niOeSUDm
 w9GcJziFDT13x6S30xlGDcvffzZ1JFhhMMSgPF8Kdm2F63VC1A5dcMpO9WDWmvFib3tU75+94r2
 njgAMTTGF1HRe4jutJac3alafByuvpsUC1vxYYzT+/Hvqh6MLRC0KF/Jio8wAc3/wmMSqtSqp8l
 zknDz+eRaAD3tq7tLIrKknE73yAjeTZOqK1RM7JTFCIqm+O6njEpM0u
X-Received: by 2002:a05:6808:17a9:b0:3f3:cb68:a90a with SMTP id
 5614622812f47-3f3cd3f1451mr1225966b6e.0.1739314281240; 
 Tue, 11 Feb 2025 14:51:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0nKLedXfFlHw6W3fdTt3YLXfhItv4b6cfCx1+zV4lK4nTiJINHUfzaf++Ytw+V9jpPB9lNQ==
X-Received: by 2002:a05:6808:17a9:b0:3f3:cb68:a90a with SMTP id
 5614622812f47-3f3cd3f1451mr1225955b6e.0.1739314280951; 
 Tue, 11 Feb 2025 14:51:20 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:20 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/14] memory: pass MemTxAttrs to memory_access_is_direct()
Date: Tue, 11 Feb 2025 17:50:54 -0500
Message-ID: <20250211225059.182533-11-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: David Hildenbrand <david@redhat.com>

We want to pass another flag that will be stored in MemTxAttrs. So pass
MemTxAttrs directly.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250210084648.33798-6-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h     |  5 +++--
 hw/core/loader.c          |  2 +-
 hw/remote/vfio-user-obj.c |  2 +-
 system/physmem.c          | 12 ++++++------
 system/memory_ldst.c.inc  | 18 +++++++++---------
 5 files changed, 20 insertions(+), 19 deletions(-)

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
diff --git a/system/physmem.c b/system/physmem.c
index cff15ca1df..8745c10c9d 100644
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
-- 
2.47.0


