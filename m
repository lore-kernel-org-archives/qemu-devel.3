Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72552C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4x-0007tU-19; Fri, 21 Feb 2025 07:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4n-0007WU-5h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4k-0007Ap-72
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y55Lq3nnb4wo+Mep9PSIMyZizGYpu/mdV63SxawIIlg=;
 b=aabNhQw8IMcm7+llcpSMw0oJIgJtoJLuVURlvy4YEIsWNzwTlWB03VLPptg9g0IbMcjMJn
 b7WPd9eFW+LGm7qqOh1B7aEQ332xCT0Vl4yTaJLAtt+Qambnti4+/3nnh9ABxqbpbyfYud
 1Ep9xcCrQgCaROWP4BeoVwSzbSJA1gg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-sPgT0ernO1WXshOxFlWDRQ-1; Fri, 21 Feb 2025 07:24:12 -0500
X-MC-Unique: sPgT0ernO1WXshOxFlWDRQ-1
X-Mimecast-MFC-AGG-ID: sPgT0ernO1WXshOxFlWDRQ_1740140651
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43942e82719so13917555e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140650; x=1740745450;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y55Lq3nnb4wo+Mep9PSIMyZizGYpu/mdV63SxawIIlg=;
 b=oy60sa0a/0BJ6GIDu8Wbvz/4Q/qwReJBnJVEktaw4ILhjLZ792LCmOVJ3cSAXogZbj
 P/CcO+cjLKOndcpZw2a/L2x6dS7qXfSRkASlfchJMIqnH7ykW5LDly120hDCF5YlX8NU
 xd7W4ULy+/yvtOu3l5ggYIs4w+EB4fE3grZIYaHJx8kV/0ZNIp35rHvg0jU4HLNlwsPv
 ZVZS/nqK9YCcm/2DBFX0rJJWfN9S2my5Ab9zUC/5gHAux5ymcvLSfj4xRiC3AYMilsv1
 ptViLcD6SC44UN2LkxtD5o4mLBDlvLm3I3OPBuhIAUXhCb4W8lxK33kLhggcepG1Q7JX
 A2ZA==
X-Gm-Message-State: AOJu0Yy+PMFEJaK4ND7LmQX+4iVoJswogwnMllKdk/R3i16YOk0mria8
 L0h3Mng0YRQspCHhJf5fmzf/2OD3uZ91ylr7aTI538UfTUof2QaY70vFTXr3BU3pjP4zrDtQWfe
 L0Vuuu3jXB0EqJkOqiLwCf5xp+dth7PU4mjBpgK5poNIyepO5QEXA7/Zr3WzTwvri7/ImjCzRui
 uus/TOXoBojxMYbus1quCaM/gxWDtz4g==
X-Gm-Gg: ASbGnctwfSuOfDL0lRrzsBus8gIB26nyorCJiAOtkRVphYFkULsacapJPOHxwTIlZJJ
 UpZx/vwULeWxEMvHoCex6+9tqMPmoTaBSHR4K4eO26p17X3qJf9nV8yLw8ZjfgX6btgdEqxhOF9
 4I32i/B7amWpA98SbGpZMyJsAA4ATWlSQL7pPRCWKNHoE+WinX39EISZkputJh4Ce3kdsSjbcEG
 zoysBKo8VWWgd6OCn1fIsmv499GTbq9ALM8lTtgOLqJ7XP3FVsZrYXvsLtZ/Yjr/5U6PQGe0QPz
 QotRUw==
X-Received: by 2002:a5d:47a9:0:b0:38f:3888:33bc with SMTP id
 ffacd0b85a97d-38f6e755eebmr2956940f8f.10.1740140650247; 
 Fri, 21 Feb 2025 04:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1jDVsRMsGdie1M/p/c7fTH9AvdNu2+7DPqbDnkNGxE7mSHJYD/rRv7K8qAaHKQGbg3i0uWw==
X-Received: by 2002:a5d:47a9:0:b0:38f:3888:33bc with SMTP id
 ffacd0b85a97d-38f6e755eebmr2956895f8f.10.1740140649660; 
 Fri, 21 Feb 2025 04:24:09 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7ecsm22997792f8f.49.2025.02.21.04.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:09 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 28/41] vhost-iova-tree: Implement an IOVA-only tree
Message-ID: <92cf61e70838c20adc82daa3170fdbb9d174b508.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Creates and supports an IOVA-only tree to support a SVQ IOVA->HVA and
GPA->IOVA tree for host-only and guest-backed memory, respectively, in
the next patch.

The IOVA allocator still allocates an IOVA range but now adds this range
to the IOVA-only tree as well as to the full IOVA->HVA tree.

In the next patch, the full IOVA->HVA tree will be split into a partial
SVQ IOVA->HVA tree and a GPA->IOVA tree. The motivation behind having an
IOVA-only tree was to have a single tree that would keep track of all
allocated IOVA ranges between the partial SVQ IOVA->HVA and GPA->IOVA
trees.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Message-Id: <20250217144936.3589907-2-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-iova-tree.h |  3 ++-
 hw/virtio/vhost-iova-tree.c | 26 ++++++++++++++++++++------
 hw/virtio/vhost-vdpa.c      | 29 +++++++++++++++++++++--------
 net/vhost-vdpa.c            | 10 ++++++++--
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 4adfd79ff0..525ce72b1d 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -21,7 +21,8 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(VhostIOVATree, vhost_iova_tree_delete);
 
 const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
                                         const DMAMap *map);
-int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
+int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map,
+                              hwaddr taddr);
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
 
 #endif
diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 3d03395a77..216885aa3c 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -28,6 +28,9 @@ struct VhostIOVATree {
 
     /* IOVA address to qemu memory maps. */
     IOVATree *iova_taddr_map;
+
+    /* Allocated IOVA addresses */
+    IOVATree *iova_map;
 };
 
 /**
@@ -44,6 +47,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
     tree->iova_last = iova_last;
 
     tree->iova_taddr_map = iova_tree_new();
+    tree->iova_map = iova_tree_new();
     return tree;
 }
 
@@ -53,6 +57,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 {
     iova_tree_destroy(iova_tree->iova_taddr_map);
+    iova_tree_destroy(iova_tree->iova_map);
     g_free(iova_tree);
 }
 
@@ -75,6 +80,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
  *
  * @tree: The iova tree
  * @map: The iova map
+ * @taddr: The translated address (HVA)
  *
  * Returns:
  * - IOVA_OK if the map fits in the container
@@ -83,19 +89,26 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
  *
  * It returns assignated iova in map->iova if return value is VHOST_DMA_MAP_OK.
  */
-int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
+int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map, hwaddr taddr)
 {
+    int ret;
+
     /* Some vhost devices do not like addr 0. Skip first page */
     hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
 
-    if (map->translated_addr + map->size < map->translated_addr ||
-        map->perm == IOMMU_NONE) {
+    if (taddr + map->size < taddr || map->perm == IOMMU_NONE) {
         return IOVA_ERR_INVALID;
     }
 
-    /* Allocate a node in IOVA address */
-    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
-                               tree->iova_last);
+    /* Allocate a node in the IOVA-only tree */
+    ret = iova_tree_alloc_map(tree->iova_map, map, iova_first, tree->iova_last);
+    if (unlikely(ret != IOVA_OK)) {
+        return ret;
+    }
+
+    /* Insert a node in the IOVA->HVA tree */
+    map->translated_addr = taddr;
+    return iova_tree_insert(tree->iova_taddr_map, map);
 }
 
 /**
@@ -107,4 +120,5 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
 {
     iova_tree_remove(iova_tree->iova_taddr_map, map);
+    iova_tree_remove(iova_tree->iova_map, map);
 }
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..703dcfc929 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -360,14 +360,20 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     llsize = int128_sub(llend, int128_make64(iova));
     if (s->shadow_data) {
         int r;
+        hwaddr hw_vaddr = (hwaddr)(uintptr_t)vaddr;
 
-        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
 
-        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
+        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region, hw_vaddr);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't allocate a mapping (%d)", r);
+
+            if (mem_region.translated_addr == hw_vaddr) {
+                error_report("Insertion to IOVA->HVA tree failed");
+                /* Remove the mapping from the IOVA-only tree */
+                goto fail_map;
+            }
             goto fail;
         }
 
@@ -1142,16 +1148,23 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
  *
  * @v: Vhost-vdpa device
  * @needle: The area to search iova
+ * @taddr: The translated address (HVA)
  * @errorp: Error pointer
  */
 static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
-                                    Error **errp)
+                                    hwaddr taddr, Error **errp)
 {
     int r;
 
-    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle, taddr);
     if (unlikely(r != IOVA_OK)) {
         error_setg(errp, "Cannot allocate iova (%d)", r);
+
+        if (needle->translated_addr == taddr) {
+            error_append_hint(errp, "Insertion to IOVA->HVA tree failed");
+            /* Remove the mapping from the IOVA-only tree */
+            vhost_iova_tree_remove(v->shared->iova_tree, *needle);
+        }
         return false;
     }
 
@@ -1192,11 +1205,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
     vhost_svq_get_vring_addr(svq, &svq_addr);
 
     driver_region = (DMAMap) {
-        .translated_addr = svq_addr.desc_user_addr,
         .size = driver_size - 1,
         .perm = IOMMU_RO,
     };
-    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
+    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
+                                 errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq driver region: ");
         return false;
@@ -1206,11 +1219,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
     addr->avail_user_addr = driver_region.iova + avail_offset;
 
     device_region = (DMAMap) {
-        .translated_addr = svq_addr.used_user_addr,
         .size = device_size - 1,
         .perm = IOMMU_RW,
     };
-    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
+    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
+                                 errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq device region: ");
         vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 231b45246c..5a3a57203d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -510,14 +510,20 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
                                   bool write)
 {
     DMAMap map = {};
+    hwaddr taddr = (hwaddr)(uintptr_t)buf;
     int r;
 
-    map.translated_addr = (hwaddr)(uintptr_t)buf;
     map.size = size - 1;
     map.perm = write ? IOMMU_RW : IOMMU_RO,
-    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map, taddr);
     if (unlikely(r != IOVA_OK)) {
         error_report("Cannot map injected element");
+
+        if (map.translated_addr == taddr) {
+            error_report("Insertion to IOVA->HVA tree failed");
+            /* Remove the mapping from the IOVA-only tree */
+            goto dma_map_err;
+        }
         return r;
     }
 
-- 
MST


