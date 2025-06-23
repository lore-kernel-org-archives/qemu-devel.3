Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B9AC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRl-00061Z-9b; Mon, 23 Jun 2025 16:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRj-00060X-HE
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRh-0003Wm-BO
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sa8C9j/5zo9gPDkTFjiv5qUB1g2PT33c0z+8t2nsN4g=;
 b=PDI+2/9KRtoPlNpE8THY1Fy3K715+x3YTT+RDHsB0I67VA1y4O/MQNN8HrUgrfoJDO8tSk
 djNqF0vCGxx7VO8od5G/arNM673AfEk4ykhSNdLFl0lSad6zaqOI0AfFUMRfVtmpahSc9G
 GHtQKiMN0oHLykLjBTWtRnJCVNYtICE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-L3EqyVKaOL-g2dBihDU1rw-1; Mon, 23 Jun 2025 16:07:11 -0400
X-MC-Unique: L3EqyVKaOL-g2dBihDU1rw-1
X-Mimecast-MFC-AGG-ID: L3EqyVKaOL-g2dBihDU1rw_1750709230
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6facf4cf5e1so81558966d6.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709230; x=1751314030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sa8C9j/5zo9gPDkTFjiv5qUB1g2PT33c0z+8t2nsN4g=;
 b=PTAsBqqqNOqnNP6U2ZdXr91wH8WpJ6VjbEohWVQnY0al/JrmUhe+oaprhFVcT1pvxQ
 0pifXlY8ksG+0SjzJ7zbPOV1UTOiJx0TYlbzu8qsmCbbNEH+iQiP8Ediknq/gsOXWCdK
 V4s5cuKjz1gDq75y9Gaj8b5wkK2UjqC85hq27R85Q71n6XiGT/70b2+UBJHeV2/EXEMP
 VJN7zwg+6V+w9n2lAR7TFRxVOfbWXL/Vtprg/EHkJ0fmMUiVwIGDH6W3LMPFwg9kN1zg
 sl8lYCYoDEEdVrbk2Z6tijgRvj4VsXeWhztm1jjVaBlw8DI8xE53zRDpd/2c9SxjshEp
 bbow==
X-Gm-Message-State: AOJu0Yzm65Iyj9TbWibpqj99mUr+r2dhllTkRu1rgEvmhD0VmgKCLicz
 KbGzqt4xF4oc985Cwl6UWrXN6FpemJNXC1FR6DZysCMA1GBFdcLd6h8166ibNf2gc03KalHZUl2
 H7xfQpb13h2+BLHTjdoo9GoqfMW3VXNxqkeKqy5J3AnMle8YN+YG1IcF2+TD2FInm/Xc8+6XO04
 zg1whanlgk+6QEmtO+vLrTYQA4M+rR0KyQalU4BQ==
X-Gm-Gg: ASbGnctgyRcb2WrZt5NQRZooCpTR7BUh5MNAuykHwo6H5Nq4q+aMvIegtGcekfSrV6B
 0mZgJ3npuy1+Wnwb9k7xojwea9ZiFT9lrLfY3wojnjOd11ha3jfwb1Tne1Xm7dui7/IID64CWs6
 4UhkRkoVJtFEW8EV8tkHE2Jpf53jAG1IaewOLR2paOaTdElfMgd49+3b4jYY7/JSyrDw1WhXIES
 AhOzag4GFAGCQ/1TQtyfgciTRA+zNH8aUZovI5dDM9Y8BW9mJXGtJsA8VGmAkZpACInMJ/9xlyY
 mOmhaXF6q0g=
X-Received: by 2002:a05:6214:21ef:b0:6fa:c6e6:11f9 with SMTP id
 6a1803df08f44-6fd0a4aa3d3mr200507506d6.11.1750709230057; 
 Mon, 23 Jun 2025 13:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElNXihsJbWDTH0G7V8Yo16+7C6fXN5aUPZlP9N15mlyikHefQXzEVUQ68REoCDlMfBCqrtYA==
X-Received: by 2002:a05:6214:21ef:b0:6fa:c6e6:11f9 with SMTP id
 6a1803df08f44-6fd0a4aa3d3mr200507076d6.11.1750709229624; 
 Mon, 23 Jun 2025 13:07:09 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 07/11] memory: Export a helper to get intersection of a
 MemoryRegionSection with a given range
Date: Mon, 23 Jun 2025 16:06:52 -0400
Message-ID: <20250623200656.1882674-8-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

Rename the helper to memory_region_section_intersect_range() to make it
more generic. Meanwhile, define the @end as Int128 and replace the
related operations with Int128_* format since the helper is exported as
a wider API.

Suggested-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20250612082747.51539-2-chenyi.qiang@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 30 ++++++++++++++++++++++++++++++
 hw/virtio/virtio-mem.c  | 32 +++++---------------------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0848690ea4..da97753e28 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1211,6 +1211,36 @@ MemoryRegionSection *memory_region_section_new_copy(MemoryRegionSection *s);
  */
 void memory_region_section_free_copy(MemoryRegionSection *s);
 
+/**
+ * memory_region_section_intersect_range: Adjust the memory section to cover
+ * the intersection with the given range.
+ *
+ * @s: the #MemoryRegionSection to be adjusted
+ * @offset: the offset of the given range in the memory region
+ * @size: the size of the given range
+ *
+ * Returns false if the intersection is empty, otherwise returns true.
+ */
+static inline bool memory_region_section_intersect_range(MemoryRegionSection *s,
+                                                         uint64_t offset,
+                                                         uint64_t size)
+{
+    uint64_t start = MAX(s->offset_within_region, offset);
+    Int128 end = int128_min(int128_add(int128_make64(s->offset_within_region),
+                                       s->size),
+                            int128_add(int128_make64(offset),
+                                       int128_make64(size)));
+
+    if (int128_le(end, int128_make64(start))) {
+        return false;
+    }
+
+    s->offset_within_address_space += start - s->offset_within_region;
+    s->offset_within_region = start;
+    s->size = int128_sub(end, int128_make64(start));
+    return true;
+}
+
 /**
  * memory_region_init: Initialize a memory region
  *
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a3d1a676e7..b3c126ea1e 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -244,28 +244,6 @@ static int virtio_mem_for_each_plugged_range(VirtIOMEM *vmem, void *arg,
     return ret;
 }
 
-/*
- * Adjust the memory section to cover the intersection with the given range.
- *
- * Returns false if the intersection is empty, otherwise returns true.
- */
-static bool virtio_mem_intersect_memory_section(MemoryRegionSection *s,
-                                                uint64_t offset, uint64_t size)
-{
-    uint64_t start = MAX(s->offset_within_region, offset);
-    uint64_t end = MIN(s->offset_within_region + int128_get64(s->size),
-                       offset + size);
-
-    if (end <= start) {
-        return false;
-    }
-
-    s->offset_within_address_space += start - s->offset_within_region;
-    s->offset_within_region = start;
-    s->size = int128_make64(end - start);
-    return true;
-}
-
 typedef int (*virtio_mem_section_cb)(MemoryRegionSection *s, void *arg);
 
 static int virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
@@ -287,7 +265,7 @@ static int virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
                                       first_bit + 1) - 1;
         size = (last_bit - first_bit + 1) * vmem->block_size;
 
-        if (!virtio_mem_intersect_memory_section(&tmp, offset, size)) {
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
             break;
         }
         ret = cb(&tmp, arg);
@@ -319,7 +297,7 @@ static int virtio_mem_for_each_unplugged_section(const VirtIOMEM *vmem,
                                  first_bit + 1) - 1;
         size = (last_bit - first_bit + 1) * vmem->block_size;
 
-        if (!virtio_mem_intersect_memory_section(&tmp, offset, size)) {
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
             break;
         }
         ret = cb(&tmp, arg);
@@ -355,7 +333,7 @@ static void virtio_mem_notify_unplug(VirtIOMEM *vmem, uint64_t offset,
     QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
         MemoryRegionSection tmp = *rdl->section;
 
-        if (!virtio_mem_intersect_memory_section(&tmp, offset, size)) {
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
             continue;
         }
         rdl->notify_discard(rdl, &tmp);
@@ -371,7 +349,7 @@ static int virtio_mem_notify_plug(VirtIOMEM *vmem, uint64_t offset,
     QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
         MemoryRegionSection tmp = *rdl->section;
 
-        if (!virtio_mem_intersect_memory_section(&tmp, offset, size)) {
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
             continue;
         }
         ret = rdl->notify_populate(rdl, &tmp);
@@ -388,7 +366,7 @@ static int virtio_mem_notify_plug(VirtIOMEM *vmem, uint64_t offset,
             if (rdl2 == rdl) {
                 break;
             }
-            if (!virtio_mem_intersect_memory_section(&tmp, offset, size)) {
+            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
                 continue;
             }
             rdl2->notify_discard(rdl2, &tmp);
-- 
2.49.0


