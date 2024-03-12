Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CEEC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAaf-0006Ya-PO; Tue, 12 Mar 2024 18:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaD-00053k-4q
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaA-0004KD-Sn
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xADFZP6JmWXiAhsHChjJDu1LMnWZYRBzbs2QYwTiK+0=;
 b=NWQ9SGzk5wTxfB3Ka+2/VyPqWrL8WxBdbVFbmed0O7zbUP3ctDUd+t6LAuwbFl62vNr99R
 ejXBrGlnddgXmGDEiWtEmKWG8THutGUzt6d1fUNFPti5HkujHr3fuy5XeW6A3TUJuIzhio
 ellOBZx4MRB05DHqY+a2fCvaeUaH4xM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-xAJRcectMhWDwJ4MyZGJVg-1; Tue, 12 Mar 2024 18:26:48 -0400
X-MC-Unique: xAJRcectMhWDwJ4MyZGJVg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5682e95fc68so226393a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282407; x=1710887207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xADFZP6JmWXiAhsHChjJDu1LMnWZYRBzbs2QYwTiK+0=;
 b=jf3W4oO/ey3Kogs4Bky7Eio+wiKFOsR1kxh/XsqUc1RsZUlogsvVPGNrF7/hgG/dO8
 e/LrJnM6u3Zn4MmPOSjCJ8OoMCAr0eLlRgrv7BynIM3HqdI6ZEO9KKDWroSKh5AyWRui
 yj02Ea2axEyVoLqnffJ3NpB+exyaI8tRm6Tj3B7f6Bce0GBuwsOeKyzrUndz9RV+Fmwi
 K8SsM/VNEOznJsuNUEoh22i8nlAtYMXxorAp6uOnQZatwP+R2oUxSlNts5SdB3004VoB
 aKoFe3aALD0gya1skBnIa28dRPZpYMKVL6zdl9KoP8nIPO5fJx/OGaDyYI+lH5thEsxv
 dazg==
X-Gm-Message-State: AOJu0Yw1DlYQQ+3qv/lfrgHxJmfz26AGZS/a4ug5MOrYUytBvLhMWEh2
 Pawf+QS4dHrlSHDSrDOrS6V3ZKlYvBLbtRyHOCKLAtN8SE3LcBgsjEdzCVHoDrOrafFEC1RT30v
 AJMpPlc/etgMiXpCZRm+72l7FuisN9zKO5vEYWxSmX/cytfsRLwfS8sCYcedcKckmTpstQadQJb
 4lE71NDSvR9ep1uhmCC53lNsLWRHJtv2dj
X-Received: by 2002:a50:d498:0:b0:568:13a5:1801 with SMTP id
 s24-20020a50d498000000b0056813a51801mr1045882edi.1.1710282407333; 
 Tue, 12 Mar 2024 15:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHooA28wMiPqcekjOLj9whtrMBauh9vFIgFa1856uX+Ih5nsseTkmdvkKP0gBaQ2g3si3rDJw==
X-Received: by 2002:a50:d498:0:b0:568:13a5:1801 with SMTP id
 s24-20020a50d498000000b0056813a51801mr1045861edi.1.1710282406699; 
 Tue, 12 Mar 2024 15:26:46 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 t21-20020a50d715000000b005682a0e915fsm4571629edi.76.2024.03.12.15.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:46 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 24/68] libvhost-user: Dynamically remap rings after
 (temporarily?) removing memory regions
Message-ID: <67f4f663cd6179d57f3e5a558f1526c7dc8c6742.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: David Hildenbrand <david@redhat.com>

Currently, we try to remap all rings whenever we add a single new memory
region. That doesn't quite make sense, because we already map rings when
setting the ring address, and panic if that goes wrong. Likely, that
handling was simply copied from set_mem_table code, where we actually
have to remap all rings.

Remapping all rings might require us to walk quite a lot of memory
regions to perform the address translations. Ideally, we'd simply remove
that remapping.

However, let's be a bit careful. There might be some weird corner cases
where we might temporarily remove a single memory region (e.g., resize
it), that would have worked for now. Further, a ring might be located on
hotplugged memory, and as the VM reboots, we might unplug that memory, to
hotplug memory before resetting the ring addresses.

So let's unmap affected rings as we remove a memory region, and try
dynamically mapping the ring again when required.

Acked-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-14-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 107 ++++++++++++++++------
 1 file changed, 78 insertions(+), 29 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index ed0a978d4f..61fb3050b3 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -283,10 +283,75 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static bool
+map_ring(VuDev *dev, VuVirtq *vq)
+{
+    vq->vring.desc = qva_to_va(dev, vq->vra.desc_user_addr);
+    vq->vring.used = qva_to_va(dev, vq->vra.used_user_addr);
+    vq->vring.avail = qva_to_va(dev, vq->vra.avail_user_addr);
+
+    DPRINT("Setting virtq addresses:\n");
+    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
+    DPRINT("    vring_used  at %p\n", vq->vring.used);
+    DPRINT("    vring_avail at %p\n", vq->vring.avail);
+
+    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
+}
+
 static bool
 vu_is_vq_usable(VuDev *dev, VuVirtq *vq)
 {
-    return likely(!dev->broken) && likely(vq->vring.avail);
+    if (unlikely(dev->broken)) {
+        return false;
+    }
+
+    if (likely(vq->vring.avail)) {
+        return true;
+    }
+
+    /*
+     * In corner cases, we might temporarily remove a memory region that
+     * mapped a ring. When removing a memory region we make sure to
+     * unmap any rings that would be impacted. Let's try to remap if we
+     * already succeeded mapping this ring once.
+     */
+    if (!vq->vra.desc_user_addr || !vq->vra.used_user_addr ||
+        !vq->vra.avail_user_addr) {
+        return false;
+    }
+    if (map_ring(dev, vq)) {
+        vu_panic(dev, "remapping queue on access");
+        return false;
+    }
+    return true;
+}
+
+static void
+unmap_rings(VuDev *dev, VuDevRegion *r)
+{
+    int i;
+
+    for (i = 0; i < dev->max_queues; i++) {
+        VuVirtq *vq = &dev->vq[i];
+        const uintptr_t desc = (uintptr_t)vq->vring.desc;
+        const uintptr_t used = (uintptr_t)vq->vring.used;
+        const uintptr_t avail = (uintptr_t)vq->vring.avail;
+
+        if (desc < r->mmap_addr || desc >= r->mmap_addr + r->size) {
+            continue;
+        }
+        if (used < r->mmap_addr || used >= r->mmap_addr + r->size) {
+            continue;
+        }
+        if (avail < r->mmap_addr || avail >= r->mmap_addr + r->size) {
+            continue;
+        }
+
+        DPRINT("Unmapping rings of queue %d\n", i);
+        vq->vring.desc = NULL;
+        vq->vring.used = NULL;
+        vq->vring.avail = NULL;
+    }
 }
 
 static size_t
@@ -786,21 +851,6 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
 
-static bool
-map_ring(VuDev *dev, VuVirtq *vq)
-{
-    vq->vring.desc = qva_to_va(dev, vq->vra.desc_user_addr);
-    vq->vring.used = qva_to_va(dev, vq->vra.used_user_addr);
-    vq->vring.avail = qva_to_va(dev, vq->vra.avail_user_addr);
-
-    DPRINT("Setting virtq addresses:\n");
-    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
-    DPRINT("    vring_used  at %p\n", vq->vring.used);
-    DPRINT("    vring_avail at %p\n", vq->vring.avail);
-
-    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
-}
-
 static bool
 generate_faults(VuDev *dev) {
     unsigned int i;
@@ -884,7 +934,6 @@ generate_faults(VuDev *dev) {
 
 static bool
 vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
-    int i;
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
 
     if (vmsg->fd_num != 1) {
@@ -930,19 +979,9 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
         vmsg->fd_num = 0;
         DPRINT("Successfully added new region in postcopy\n");
         return true;
-    } else {
-        for (i = 0; i < dev->max_queues; i++) {
-            if (dev->vq[i].vring.desc) {
-                if (map_ring(dev, &dev->vq[i])) {
-                    vu_panic(dev, "remapping queue %d for new memory region",
-                             i);
-                }
-            }
-        }
-
-        DPRINT("Successfully added new region\n");
-        return false;
     }
+    DPRINT("Successfully added new region\n");
+    return false;
 }
 
 static inline bool reg_equal(VuDevRegion *vudev_reg,
@@ -995,6 +1034,16 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
         return false;
     }
 
+    /*
+     * There might be valid cases where we temporarily remove memory regions
+     * to readd them again, or remove memory regions and don't use the rings
+     * anymore before we set the ring addresses and restart the device.
+     *
+     * Unmap all affected rings, remapping them on demand later. This should
+     * be a corner case.
+     */
+    unmap_rings(dev, r);
+
     munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
 
     idx = r - dev->regions;
-- 
MST


