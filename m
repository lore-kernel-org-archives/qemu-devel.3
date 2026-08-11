Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB31DC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtw4k-0004UJ-LF; Tue, 11 Aug 2026 19:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wrJ7agsKCnEcPbPcVjaPiXVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--namangulati.bounces.google.com>)
 id 1wtw4i-0004Sh-9M
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:40:04 -0400
Received: from mail-qt1-x848.google.com ([2607:f8b0:4864:20::848])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wrJ7agsKCnEcPbPcVjaPiXVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--namangulati.bounces.google.com>)
 id 1wtw4b-00089g-8y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:40:00 -0400
Received: by mail-qt1-x848.google.com with SMTP id
 d75a77b69052e-52d28f8737eso8118511cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 16:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786491587; x=1787096387; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vsSsUaWkE9fwhAgZ2+bdUQDI55jmxvdXVAy5V/8lZmU=;
 b=WMiSRB97fC+zFmx283T9vqJ7+yXQ1thLozqu6FHVAZEXF9p+GXt9Bs1KlpWpa/Xd/f
 xGPkdicplRUn9CesehwiwvOEXIwPEAwRwhVz42GZe4RNb/3dey/vGIeU53Z0FQXbSHDp
 BnGRAmdEIzR9HVycVVXZh6VgBvI+DDO1X1Oe3yvhlPNvClpMuKJKyGuETxWbG+XtwP26
 ssvQQpiJFjU2y7DX+lcpZCxqM0AqdMyhM4NfCSJieHCp+8B5udS3zHqpBF0jypT+5IWS
 7ed1BCqgN0k+35pNWZJwaPKaOvZ7M2B0RpEQ4m7d0EFrqQqc/Xk66ihKQt4qinK1tAdG
 P0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786491587; x=1787096387;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vsSsUaWkE9fwhAgZ2+bdUQDI55jmxvdXVAy5V/8lZmU=;
 b=P2ZE6eDv95EYRps+zk2eC6FwbaCKysyFl9eQzFpLqSi+HPUjn0P4Ah7Y8fpHD+ENMW
 OwUEajAJNjyHEauGXh8y8XsE63kZ54MtMh8Z99wF2zCvkeqGS6U90Rpa6LxpwzFlQ4ou
 Tz5qRUNuVvUNhlRv+9CcP0zBCpRSLGEmvHmbQbn2rkgW1XR7Uo3bYPAnt6oI7doTTDxn
 CLmdzyHaxm685EGRmm6NxPTG6GccRG9ScUnByx+5Bg6ICacqncEodKE3QCdNcyLNbpun
 pn3Bw/CprhzN/3olmxnMTZjmJ+QKFlmEMY3DJ14GhGSyiqpaRynJVZmJ/Ezg9WPWi6rz
 VTcw==
X-Gm-Message-State: AOJu0YxV0PNkYnk5gTaYmnC3Ffn+GHOpKCrjVn2+EiWQD6W07Go62aR3
 i/tobOMakz4QmmD26A7e3RaOVVExyYosy8RGu4Uo3bH3flNdlWFYGjQbp7Vo68+G50wo9H10Mgi
 J7eUVpcZBPDWUNrEV8HVzsI5RhjLdRV+R4WFI43nTA6KLK+L/JGwLPMsEi1LZ5NLwPAH43aHhJD
 kjr9n0608EmLPCe22Xcxp04F9saQSCSGG9BZkczQYJ6czx/EwogJa+UpbzVMdeKQ==
X-Received: from qtvl9.prod.google.com ([2002:ac8:4cc9:0:b0:51c:9d78:8252])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a8c:b0:519:55c0:a1e5 with SMTP id
 d75a77b69052e-52d646afa6fmr8285021cf.8.1786491586365; 
 Tue, 11 Aug 2026 16:39:46 -0700 (PDT)
Date: Tue, 11 Aug 2026 23:39:29 +0000
In-Reply-To: <20260811233930.401797-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260811233930.401797-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811233930.401797-3-namangulati@google.com>
Subject: [RFC PATCH 2/3] vfio: mmap sparse regions backed by multiple FDs
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::848;
 envelope-from=3wrJ7agsKCnEcPbPcVjaPiXVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--namangulati.bounces.google.com;
 helo=mail-qt1-x848.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Generalize QEMU's VFIO core layer to support mapping sparse memory
subregions from distinct file descriptors within a single device
region.

Replace list of region_fds in VFIODevice with a collection of struct
VFIORegionFDs that internally holds a collection of FDs to mmap per
region.

Add setup_sparse_mmaps hook to VFIODeviceIOOps to allow transport
backends (such as vfio-user) to handle custom sparse mmap capabilities,
falling back to default kernel VFIO sparse parsing.

Store per-subregion fd_offset in struct VFIOMmap to properly address
the mmap call for a subregion.

Signed-off-by: Naman Gulati <namangulati@google.com>
---
 hw/vfio-user/device.c         | 12 ++++++---
 hw/vfio/device.c              | 50 +++++++++++++++++++----------------
 hw/vfio/region.c              | 41 ++++++++++++++++++++++------
 hw/vfio/vfio-region.h         |  8 ++++++
 include/hw/vfio/vfio-device.h | 29 +++++++++++++++++---
 5 files changed, 102 insertions(+), 38 deletions(-)

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index b8d2b7c1a8..9c4e10c1fd 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -169,10 +169,10 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
 }
 
 static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
-                                               struct vfio_region_info *info,
-                                               int *fd)
+                                               struct vfio_region_info *info)
 {
-    VFIOUserFDs fds = { 0, 1, fd};
+    int fd = -1;
+    VFIOUserFDs fds = { 0, 1, &fd };
     int ret;
 
     if (info->index > vbasedev->num_initial_regions) {
@@ -184,6 +184,12 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
         return ret;
     }
 
+    if (fds.recv_fds > 0 && info->index < vbasedev->num_initial_regions) {
+        vbasedev->region_fds[info->index].fds = g_new0(int, 1);
+        vbasedev->region_fds[info->index].nr_fds = 1;
+        vbasedev->region_fds[info->index].fds[0] = fd;
+    }
+
     /* cap_offset in valid area */
     if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
         (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 1a7f8088aa..ea571e33ba 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -202,7 +202,6 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
-    int fd = -1;
     int ret;
 
     /*
@@ -226,7 +225,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
     if (ret != 0) {
         g_free(*info);
         *info = NULL;
@@ -237,9 +236,14 @@ retry:
         argsz = (*info)->argsz;
         *info = g_realloc(*info, argsz);
 
-        if (fd != -1) {
-            close(fd);
-            fd = -1;
+        if (index < vbasedev->num_initial_regions &&
+            vbasedev->region_fds != NULL) {
+            for (int j = 0; j < vbasedev->region_fds[index].nr_fds; j++) {
+                close(vbasedev->region_fds[index].fds[j]);
+            }
+            g_free(vbasedev->region_fds[index].fds);
+            vbasedev->region_fds[index].fds = NULL;
+            vbasedev->region_fds[index].nr_fds = 0;
         }
 
         goto retry;
@@ -248,19 +252,22 @@ retry:
     if (index < vbasedev->num_initial_regions) {
         /* fill cache */
         vbasedev->reginfo[index] = *info;
-        if (vbasedev->region_fds != NULL) {
-            vbasedev->region_fds[index] = fd;
-        }
     }
 
     return 0;
 }
 
-int vfio_device_get_region_fd(VFIODevice *vbasedev, int index)
+int vfio_device_get_region_fd(VFIODevice *vbasedev, int index,
+                              uint32_t fd_index)
 {
-        return vbasedev->region_fds ?
-               vbasedev->region_fds[index] :
-               vbasedev->fd;
+    if (!vbasedev->region_fds) {
+        return vbasedev->fd;
+    }
+    if (index < 0 || index >= vbasedev->num_initial_regions ||
+        fd_index >= vbasedev->region_fds[index].nr_fds) {
+        return -1;
+    }
+    return vbasedev->region_fds[index].fds[fd_index];
 }
 
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
@@ -480,7 +487,6 @@ void vfio_device_detach(VFIODevice *vbasedev)
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
                          struct vfio_device_info *info)
 {
-    int i;
 
     vbasedev->num_irqs = info->num_irqs;
     vbasedev->num_initial_regions = info->num_regions;
@@ -495,10 +501,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
     vbasedev->reginfo = g_new0(struct vfio_region_info *,
                                vbasedev->num_initial_regions);
     if (vbasedev->use_region_fds) {
-        vbasedev->region_fds = g_new0(int, vbasedev->num_initial_regions);
-        for (i = 0; i < vbasedev->num_initial_regions; i++) {
-            vbasedev->region_fds[i] = -1;
-        }
+        vbasedev->region_fds = g_new0(VFIORegionFDs,
+                                      vbasedev->num_initial_regions);
     }
 }
 
@@ -508,8 +512,11 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
 
     for (i = 0; i < vbasedev->num_initial_regions; i++) {
         g_free(vbasedev->reginfo[i]);
-        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
-            close(vbasedev->region_fds[i]);
+        if (vbasedev->region_fds != NULL) {
+            for (int j = 0; j < vbasedev->region_fds[i].nr_fds; j++) {
+                close(vbasedev->region_fds[i].fds[j]);
+            }
+            g_free(vbasedev->region_fds[i].fds);
         }
     }
 
@@ -592,13 +599,10 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
 }
 
 static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
-                                          struct vfio_region_info *info,
-                                          int *fd)
+                                          struct vfio_region_info *info)
 {
     int ret;
 
-    *fd = -1;
-
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 
     return ret < 0 ? -errno : ret;
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index dbde339180..3a555e574c 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -162,9 +162,9 @@ static int vfio_mmap_compare_offset(const void *a, const void *b)
     return 0;
 }
 
-static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
-                                          struct vfio_region_info *info,
-                                          Error **errp)
+int vfio_default_setup_sparse_mmaps(VFIORegion *region,
+                                    struct vfio_region_info *info,
+                                    Error **errp)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_region_info_cap_sparse_mmap *sparse;
@@ -188,6 +188,8 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                             sparse->areas[i].offset +
                                             sparse->areas[i].size - 1);
             region->mmaps[j].offset = sparse->areas[i].offset;
+            region->mmaps[j].fd_offset = region->fd_offset +
+                                         sparse->areas[i].offset;
             region->mmaps[j].size = sparse->areas[i].size;
             j++;
         }
@@ -195,6 +197,25 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 
     region->nr_mmaps = j;
     region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+    return 0;
+}
+
+static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
+                                          struct vfio_region_info *info,
+                                          Error **errp)
+{
+    int ret, i;
+
+    if (region->vbasedev->io_ops &&
+        region->vbasedev->io_ops->setup_sparse_mmaps) {
+        ret = region->vbasedev->io_ops->setup_sparse_mmaps(region, info, errp);
+    } else {
+        ret = vfio_default_setup_sparse_mmaps(region, info, errp);
+    }
+
+    if (ret) {
+        return ret;
+    }
 
     /*
      * Sort sparse mmaps by offset to ensure proper handling of gaps
@@ -261,6 +282,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                 region->nr_mmaps = 1;
                 region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
                 region->mmaps[0].offset = 0;
+                region->mmaps[0].fd_offset = region->fd_offset;
                 region->mmaps[0].size = region->size;
             } else if (ret) {
                 return ret;
@@ -355,7 +377,6 @@ int vfio_region_mmap(VFIORegion *region)
     off_t map_offset = 0;
     size_t align;
     char *name;
-    int fd;
 
     if (!region->mem || !region->nr_mmaps) {
         return 0;
@@ -392,8 +413,6 @@ int vfio_region_mmap(VFIORegion *region)
         return ret;
     }
 
-    fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
-
     map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
     munmap(map_base, map_align - map_base);
     munmap(map_align + region->size,
@@ -405,12 +424,18 @@ int vfio_region_mmap(VFIORegion *region)
      * offsets being in ascending order.
      */
     for (i = 0; i < region->nr_mmaps; i++) {
+        int fd = vfio_device_get_region_fd(region->vbasedev, region->nr,
+                                           region->mmaps[i].fd_index);
+        if (fd < 0) {
+            ret = -EINVAL;
+            goto no_mmap;
+        }
+
         munmap(map_align + map_offset, region->mmaps[i].offset - map_offset);
         region->mmaps[i].mmap = mmap(map_align + region->mmaps[i].offset,
                                      region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED, fd,
-                                     region->fd_offset +
-                                     region->mmaps[i].offset);
+                                     region->mmaps[i].fd_offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
             ret = -errno;
             /*
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 58b236f113..0bb082e9a6 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -10,12 +10,17 @@
 #define HW_VFIO_REGION_H
 
 #include "system/memory.h"
+#ifdef CONFIG_LINUX
+#include <linux/vfio.h>
+#endif
 
 typedef struct VFIOMmap {
     MemoryRegion mem;
     void *mmap;
     off_t offset;
     size_t size;
+    uint32_t fd_index;
+    uint64_t fd_offset;
 } VFIOMmap;
 
 typedef struct VFIODevice VFIODevice;
@@ -43,5 +48,8 @@ int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
+int vfio_default_setup_sparse_mmaps(VFIORegion *region,
+                                    struct vfio_region_info *info,
+                                    Error **errp);
 
 #endif /* HW_VFIO_REGION_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8472420d3f..c97a35fa80 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -43,12 +43,18 @@ enum {
 
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODeviceIOOps VFIODeviceIOOps;
+typedef struct VFIORegion VFIORegion;
 typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOASHwpt VFIOIOASHwpt;
 typedef struct VFIOUserProxy VFIOUserProxy;
 
+typedef struct VFIORegionFDs {
+    int *fds;
+    int nr_fds;
+} VFIORegionFDs;
+
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
     QLIST_ENTRY(VFIODevice) container_next;
@@ -89,7 +95,7 @@ typedef struct VFIODevice {
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
-    int *region_fds;
+    struct VFIORegionFDs *region_fds;
     VFIODeviceCPR cpr;
     VFIOUserProxy *proxy;
 } VFIODevice;
@@ -211,12 +217,26 @@ struct VFIODeviceIOOps {
      * @vdev: #VFIODevice to use
      * @info: set @info->index to the region index to look up; the rest of the
      *        struct will be filled in on success
-     * @fd: pointer to the fd for the region; will be -1 if not found
      *
      * Returns 0 on success or -errno.
      */
     int (*get_region_info)(VFIODevice *vdev,
-                           struct vfio_region_info *info, int *fd);
+                           struct vfio_region_info *info);
+
+    /**
+     * @setup_sparse_mmaps
+     *
+     * Parse sparse mmap capabilities for a region and initialize region->mmaps.
+     *
+     * @region: #VFIORegion to set up
+     * @info: region info struct containing capabilities
+     * @errp: pointer to Error*, to store an error if it happens
+     *
+     * Returns 0 on success, -ENODEV if not sparse, or negative error code.
+     */
+    int (*setup_sparse_mmaps)(VFIORegion *region,
+                              struct vfio_region_info *info,
+                              Error **errp);
 
     /**
      * @get_irq_info
@@ -317,7 +337,8 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
  *
  * Returns the fd.
  */
-int vfio_device_get_region_fd(VFIODevice *vbasedev, int index);
+int vfio_device_get_region_fd(VFIODevice *vbasedev, int index,
+                              uint32_t fd_index);
 
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 
-- 
2.55.0.679.g6767b8d81c-goog


