Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B3BCCFA1E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vo-00029L-H0; Sun, 09 Nov 2025 09:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vm-00028s-Tp
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vl-0001mU-3H
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xlzluGzx7auUP3YqO2kjwqtM8LvQRyJhDsEvxP82Pm4=;
 b=bjvJkMbLc8ML7HxpCq2Zx4TQpUarmYusjPhj2SDETyAk0Fctnx+Ze6Ygiukn4K56zbX/QO
 Jpfr+No4VFdIUApI9cAFCqTTBS6jjaVR5TiMM1IOWXtsgfeHpWGtQKrJGA+AQZUDsfc9aA
 h0qX57W43L3NgGd9Z1f1YXEczJFGr8M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-N-mDW7oZM3qgmlw61mP4NQ-1; Sun, 09 Nov 2025 09:35:18 -0500
X-MC-Unique: N-mDW7oZM3qgmlw61mP4NQ-1
X-Mimecast-MFC-AGG-ID: N-mDW7oZM3qgmlw61mP4NQ_1762698917
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso10618805e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698917; x=1763303717; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xlzluGzx7auUP3YqO2kjwqtM8LvQRyJhDsEvxP82Pm4=;
 b=RSpccAueORIK4s9ZkD/sxHzbzaOzqcx4yk5EfJ8zmSPyRq4yLph/eTc5loWtAzs0G7
 wPjJ1vzoPXr5DywM1cP9Kn/WRc4uOqHyJC842YCf8Kz6HgoGRfvTuuHHrO0iRlqNdjg5
 8NdrssCHbyV+rGKxcmqYLikkSL56rvTNUaF/g4gAVdjDN0fh3iQ7e+DwKd4mMEcJCwtS
 XeoevO6SZCn2vHaOEXoZQ8XMFf/KVR8RXCH2ch1sTQCcxDFzCcDZDeJPMlciEZAoSYiw
 sBx1MuCRDdRLxoq8NiwqU0Um76HordAVIZt8hXbvnyhsXAnRn9YEA4ZXyANwvXhwx2FT
 BcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698917; x=1763303717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlzluGzx7auUP3YqO2kjwqtM8LvQRyJhDsEvxP82Pm4=;
 b=IqCd1zBZ6wcofHGQkda5Wq55+E49Sgl8gj4L+tdSxJK1BATi51lKGJl9ViIuQKIG7d
 XxHf1bkJ5Ur4ImbBCLmTP4+1L+OjkouhQMN6qXLmh8wLD8Pa8XE2k8dIn5rkaiK7U4Ao
 Gem4k9YKSEwXPtAjDHl576MGu0c93N7JdjG9mJ3ig0sBNrDAWzREIKZJHEwFO9itzZzN
 8JkWDYWbXtLgN6ss+COOQQPebKahnheCzFwjHs/uTPNYKtr4pnTOpZ+G5nY0UT2EJp6A
 K3YTSuDo7weWYg2w6/FKs1zp+Xg2m7vRDDNzKEVlzaX44uO+Kil/QqBPlmr3UkvlKrMt
 VMOA==
X-Gm-Message-State: AOJu0YzrxR22toSIOGVQq8NNMTl50O0cZeAfJe8tm5wYnjNxpy3P+CsI
 bN5+Qd5qMz0IaMSTyJk7CJfYhuvByaihlh5hbEbEQVTsnGD8QyUxIvRoGn3eW4YEaqMKq6rpFUf
 zbv/BY+cREUPeA/kpfGyTXUUJIE2uSFQRukQKhjt2C3mWuorkwtpUyxFp+dGzfLCc649YcOFWFE
 a11+Qpk+YLY/XPqbJ3SzYwC6K/hFlLBeiHbw==
X-Gm-Gg: ASbGncu0LjcN/12QtkWPHjpJq2RDreIJLbCa3arIesPucXAZM//VKOjGI9wNZqkWm4i
 8Y4v3BEPbcpWe5km0+tm19fhDjZEQl8rU0U6hXHzS32ivWye1yYME8GvTAYVAgJP2W6V9Cb0soh
 SdDfM277NT+ViW9eX3yrjt7rvxS5P5nTaML//+39B4r4901CU3LFqBG4ph7y1kBWJkd0ub0QqqK
 I2BYUck7QnLiJ2JY36a91A9KlIieBvoAW/ub7CSh3Z6K2Lw4fhZjKrfeuSyApIuBTExbeE6jFA1
 H64eNUg6NCzqng2bsI9/fjsV1Xnnsbq3IpcKn2UmVL8YB7hte5Uhr0fA3VjVQpz73rA=
X-Received: by 2002:a05:600c:45cf:b0:477:7b16:5fa6 with SMTP id
 5b1f17b1804b1-4777b16628emr10215185e9.3.1762698916875; 
 Sun, 09 Nov 2025 06:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyb/lF3WWnMNiqHos/VZyw7RvULl6ERJhsA2N1X8NB+2c1XkxHtR+PwxPWbgyQwUZrTQPMMA==
X-Received: by 2002:a05:600c:45cf:b0:477:7b16:5fa6 with SMTP id
 5b1f17b1804b1-4777b16628emr10214945e9.3.1762698916348; 
 Sun, 09 Nov 2025 06:35:16 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2fb308f5sm8657371f8f.42.2025.11.09.06.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:16 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 03/14] amd_iommu: Support 64-bit address for IOTLB lookup
Message-ID: <637dc49a3ae6b72cdb6415dcdcdb22ff770f2c8d.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

The physical AMD IOMMU supports up to 64 bits of IOVA. When a device tries
to read or write from a given DMA address, the IOMMU translates the address
using the I/O page tables assigned to that device. Since the emulated IOMMU
uses per-device page tables, an ideal cache tag would need to be 68 bits
(64-bit address - 12-bit page alignment + 16-bit device ID).

The current software IOTLB implementation uses a GLib hash table with a
64-bit key to hash both the IOVA and device ID, which limits the IOVA to 60
bits. This causes a failure while setting up the device when a guest is
booted with "iommu.forcedac=1", which forces the use of DMA addresses at the
top of the 64-bit address space.

To address this issue, construct the 64-bit hash key using the upper 52 bits
of IOVA (GFN) and lower 12 bits of the device ID to avoid truncation as much
as possible (reducing hash collisions).

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251103203209.645434-4-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h |  4 ++--
 hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 38471b95d1..302ccca512 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -220,8 +220,8 @@
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
 
 /* IOTLB */
-#define AMDVI_IOTLB_MAX_SIZE 1024
-#define AMDVI_DEVID_SHIFT    36
+#define AMDVI_IOTLB_MAX_SIZE        1024
+#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5c5cfd4989..d689a06eca 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -106,6 +106,11 @@ typedef struct AMDVIAsKey {
     uint8_t devfn;
 } AMDVIAsKey;
 
+typedef struct AMDVIIOTLBKey {
+    uint64_t gfn;
+    uint16_t devid;
+} AMDVIIOTLBKey;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
              PCI_STATUS_SIG_TARGET_ABORT);
 }
 
-static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
-{
-    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
-}
-
-static guint amdvi_uint64_hash(gconstpointer v)
-{
-    return (guint)*(const uint64_t *)v;
-}
-
 static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
 {
     const AMDVIAsKey *key1 = v1;
@@ -425,11 +420,30 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
                              amdvi_find_as_by_devid, &devid);
 }
 
+static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
+{
+    const AMDVIIOTLBKey *key1 = v1;
+    const AMDVIIOTLBKey *key2 = v2;
+
+    return key1->devid == key2->devid && key1->gfn == key2->gfn;
+}
+
+static guint amdvi_iotlb_hash(gconstpointer v)
+{
+    const AMDVIIOTLBKey *key = v;
+    /* Use GPA and DEVID to find the bucket */
+    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
+                   (key->devid & ~AMDVI_PAGE_MASK_4K));
+}
+
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    AMDVIIOTLBKey key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr),
+        .devid = devid,
+    };
     return g_hash_table_lookup(s->iotlb, &key);
 }
 
@@ -451,8 +465,10 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
 static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
                                     uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    AMDVIIOTLBKey key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr),
+        .devid = devid,
+    };
     g_hash_table_remove(s->iotlb, &key);
 }
 
@@ -463,8 +479,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
         AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-        uint64_t *key = g_new(uint64_t, 1);
-        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+        AMDVIIOTLBKey *key = g_new(AMDVIIOTLBKey, 1);
+
+        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
+        key->devid = devid;
 
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
@@ -477,7 +495,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
         entry->perms = to_cache.perm;
         entry->translated_addr = to_cache.translated_addr;
         entry->page_mask = to_cache.addr_mask;
-        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+        entry->devid = devid;
+
         g_hash_table_replace(s->iotlb, key, entry);
     }
 }
@@ -2526,8 +2545,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
-                                     amdvi_uint64_equal, g_free, g_free);
+    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
+                                     amdvi_iotlb_equal, g_free, g_free);
 
     s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
                                      amdvi_as_equal, g_free, g_free);
-- 
MST


