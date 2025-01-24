Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8297EC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMKj-0002cI-9X; Fri, 24 Jan 2025 11:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbMKb-0002bl-OS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:14:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbMKZ-0003O1-Px
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737735290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7f1tc2RLZwpuRlPJgEUQZlg3M09OnkBiQJFOVKYZjo=;
 b=bO9kfNZdPYiNXeKIxReyova3Ub/CZ0xJsHz3FKLDrVY3alw6g34HmltEADJYMI3eeM2mO7
 sm7dzkAUkp1SYwOWQwpb/QoqqRXbuTdVCeopJWdNo20/iY+yhVCaB+4LZqgZRou1wmJ+zR
 oK3tPuZXd1f+Vj40vaIggzRN1QAEcj4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-i8S0E-FpNq--NVWqiWhgzA-1; Fri, 24 Jan 2025 11:14:44 -0500
X-MC-Unique: i8S0E-FpNq--NVWqiWhgzA-1
X-Mimecast-MFC-AGG-ID: i8S0E-FpNq--NVWqiWhgzA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so16061955e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737734982; x=1738339782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7f1tc2RLZwpuRlPJgEUQZlg3M09OnkBiQJFOVKYZjo=;
 b=ZzJKrBBQA2WPoUymK2dmzV9ozaIOcmY8F2/MXVIzwyFbuA5ZVwAhMCOvaoIQQYWBDd
 yiPx6/ICSO2E6u3u2YhaWEEb9UtuhSWhzcrr/bvZnWVQsdTLBuyOBADENabDw4779Nzn
 07RkH02k816yJqmVvPgd1BH3FG6IzEGqthdE5X8Qoyr5EXeuq25r363HyMRefePHhyfV
 1Zlzc+nfKf3a1n2ouS3MfjmI8fc6+kCBMIi/MMVcNIspCLl2PCfY9H2Agj2gTMvcFc0+
 4uckhvFyU3+6qOIQhn+f34kq7D0twXS2ijHfFdirFH5UtG8EuKwDhzHF6CPRuo4IsLQy
 MpKA==
X-Gm-Message-State: AOJu0Yw0IVABpzAciIhzs+8fGcd8ZO3Y9Am09Ltm19D3n9EIryyPUJG8
 C8KGbD+XeOGW9z3sK40Hd00fNRIJ/OkkVNho5H3SFogmNk7DqGITCydY76Y+smdfy97RJWTUDVJ
 YloNYQoJptl2yHC/76HMIKeAE3BQ5UFzbqdZaKhtqRMs6nlruspGLkR+0f2sm3xnhvbgm5mWdCi
 HjpGG+miwY8O5yEY8gYhY03ZjnWPf6WtU3tLkv2A==
X-Gm-Gg: ASbGncszpVBxTuiDk88Ppo8x2uROGtjnMA1lUM/Yq/X1J+QlkzEJGtcPmfmgcRAzs+n
 MY9ABicY14gyLVFfAChIgu1mjzU7cvd2uevPmfUhDedLCkEtV8VR/sxQUKiB3gpQmjlXBLe2dOC
 oKsPWIVHpIAUy9EnABs+p1Iq5HljR4wu4/RX94tQDe+hvKBrQofeRMKOc/gEENHDT85P8QL4nFo
 sHYK1HDOmtE/i9aoUeaYmOSyf+OybWjqwaLCi3VKIrl8nSQYuYhRqSFcoE9p1epNGn7oYk0jO7M
 e/waAY6/VL2XUxaNcwrr1cz0XI5PhYrdpa4fDfgBZ43m4iSqiEH7Wpk=
X-Received: by 2002:a05:600c:1c9d:b0:434:ffd7:6fd2 with SMTP id
 5b1f17b1804b1-438913ca1ccmr279964225e9.7.1737733550988; 
 Fri, 24 Jan 2025 07:45:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJC/3Q0TwiZdF42xv3QCiPhESIUDe2Hj+8cQ21pQULCDUoa5eYGiH8k9Xxew9m+CFzpIfpNQ==
X-Received: by 2002:a05:600c:1c9d:b0:434:ffd7:6fd2 with SMTP id
 5b1f17b1804b1-438913ca1ccmr279963855e9.7.1737733550551; 
 Fri, 24 Jan 2025 07:45:50 -0800 (PST)
Received: from localhost
 (p200300cbc719e000ca2c77c5de7dce89.dip0.t-ipconnect.de.
 [2003:cb:c719:e000:ca2c:77c5:de7d:ce89])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-438bd54c0f7sm29813815e9.28.2025.01.24.07.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:45:49 -0800 (PST)
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
Subject: [PATCH v2 5/7] memory: pass MemTxAttrs to memory_access_is_direct()
Date: Fri, 24 Jan 2025 16:45:30 +0100
Message-ID: <20250124154533.3534250-6-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124154533.3534250-1-david@redhat.com>
References: <20250124154533.3534250-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/loader.c          |  2 +-
 hw/remote/vfio-user-obj.c |  2 +-
 include/exec/memory.h     |  5 +++--
 system/memory_ldst.c.inc  | 18 +++++++++---------
 system/physmem.c          | 12 ++++++------
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4dfdb027ee..66de4da21f 100644
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
index 3b4449e847..b3287518f0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3002,7 +3002,8 @@ static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
     return !memory_region_is_ram_device(mr);
 }
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
+                                           MemTxAttrs attrs)
 {
     if (!memory_region_supports_direct_access(mr)) {
         return false;
@@ -3043,7 +3044,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
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
index 2d4f8110e8..52b20b8ae5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -571,7 +571,7 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
                                     is_write, true, &as, attrs);
     mr = section.mr;
 
-    if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
+    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
         *plen = MIN(page, *plen);
     }
@@ -2761,7 +2761,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
         return MEMTX_ACCESS_ERROR;
     }
 
-    if (!memory_access_is_direct(mr, true)) {
+    if (!memory_access_is_direct(mr, true, attrs)) {
         uint64_t val;
         MemTxResult result;
         bool release_lock = prepare_mmio_access(mr);
@@ -2857,7 +2857,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         return MEMTX_ACCESS_ERROR;
     }
 
-    if (!memory_access_is_direct(mr, false)) {
+    if (!memory_access_is_direct(mr, false, attrs)) {
         /* I/O case */
         uint64_t val;
         MemTxResult result;
@@ -3166,7 +3166,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
     while (len > 0) {
         l = len;
         mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
-        if (!memory_access_is_direct(mr, is_write)) {
+        if (!memory_access_is_direct(mr, is_write, attrs)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
                 return false;
@@ -3246,7 +3246,7 @@ void *address_space_map(AddressSpace *as,
     fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
-    if (!memory_access_is_direct(mr, is_write)) {
+    if (!memory_access_is_direct(mr, is_write, attrs)) {
         size_t used = qatomic_read(&as->bounce_buffer_size);
         for (;;) {
             hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
@@ -3379,7 +3379,7 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
 
     mr = cache->mrs.mr;
     memory_region_ref(mr);
-    if (memory_access_is_direct(mr, is_write)) {
+    if (memory_access_is_direct(mr, is_write, MEMTXATTRS_UNSPECIFIED)) {
         /* We don't care about the memory attributes here as we're only
          * doing this if we found actual RAM, which behaves the same
          * regardless of attributes; so UNSPECIFIED is fine.
-- 
2.47.1


