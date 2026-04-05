Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19623E64014
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvN-0003wN-C2; Sun, 05 Apr 2026 03:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvL-0003w3-Uh
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:35 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvJ-0007Io-SA
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:35 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2ce102afb0aso738817eec.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374172; x=1775978972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRcv4xt6lJaEweEPbwSohpIgPBQdb1KaetHX8GecBts=;
 b=W1RFJG1F3xTUI/Sq9LdkTx7VutsXVm1jS+6CURFXdLjbQ/ymnl6+yA757jSqaIqy3f
 oRrcHZSniLFiXgc7tEcxcFORw9d9F220kzcVg9LQ5fwYC8G714cVL9F9V8dsiat3aNFN
 dltSrPYbVEYvMpMpZrWofNK+v/8ZDWqelkwdL5j85GVKFAtxcs++8BFGA8jJFoW0/Tz8
 ulscVAXzhQnJUXQRxKoZQcytE+IzAjSZduTMksYfmGb1MB15IOzDoEf8KBZp0uosqSGI
 9ja9MiCK3j+EB59XAMIMuSHkDFOkaGV4Zm1M6Q7JfqT5jiuWH/r/bvybrrwP/ENgzluz
 q7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374172; x=1775978972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bRcv4xt6lJaEweEPbwSohpIgPBQdb1KaetHX8GecBts=;
 b=r1fXCEay7os4GBqiMOJ8aZMtpcErhC0GBH7tgBKZkCCr/QIexgOXE0vGOXvea8KXGT
 MBH7RdL+NJDwGZsnQRamhXBs2lHT+Pwu0zn3K3WL9iuoI6it+E/BoAlYVLLtUKCScNMs
 OW1iMevLNfZtKsVmwNtIC33U1hjpCE/2bH1c7RyhHLGMLqhnRLObYHtCjN3AtBsI1LPv
 vlmKb3nAx1vPEL2xU+FY23wPYjJd2LMBz7eaYHjVeueD6QJV4RzRsdpCuqykGHWSQZiP
 Jd3zuTurezplilvKJss1/KobdU6ylJd9Uj/gw4nounHJYNb4QdBejVoaL5DzI31ZKUOo
 h4+w==
X-Gm-Message-State: AOJu0YyIRWnCKEwTBUAuNCfqk1UBmlInUqlVatr/8hf1nvKOal+8Gl/L
 OxjAPTm60UNlezZoOweJaX93F8fLhQAzvRjx7aK1qpaS4U2DinATZ6yUPYIE0JDf3hY=
X-Gm-Gg: AeBDievF6Kd746PxHwulPcBlxho0WpUEA6W59vLddZNaxmsUM3Vzmte8m7ObQip6QvA
 XOLbwKtAWAFvj7+305Q6LzAOU2kC82W4y0RGsiKhoA3Qsd4dqoUHfD/m7B5wEnqlnb+/NMHUapm
 2JBwTvz+sfI6NiKJHmbiBPQkFvNVjGNRQnc0iwQxGMQUwj5PidqCgPrk94Bt9cDScGsfdBbwIbO
 0NGPjvpo/P8H7DShFqkLtlx0yR5VMDckQCZ9vv/g0l+2UqDE2Dc/1ebjxdbrKPUbdjGA8FYWRIw
 icuCiyCw4co/FNE0WlLKSxsxarcjZSFPVTd7XrEciAOZersB3+H6ShQ4Z11bwT5LsdWagWivxf2
 qDBVPM5QfwRb4duQ9V9x16e8lB+hoB3XuLt9P0GzTyNisGi/fgX/Po4efiymJBC1dk/MugwU9rf
 QUAFDKuZyHlS+srwQDwgunL83HbGn/17BrXXQSM7QhU6yg6F4taMd7bSsH/UYYgtw7o5oS2kdPW
 SNxUcR1Umvoj4nZV8lEeGHFWsk=
X-Received: by 2002:a05:7301:1688:b0:2c4:a862:2372 with SMTP id
 5a478bee46e88-2cbf9af888dmr3972848eec.9.1775374172077; 
 Sun, 05 Apr 2026 00:29:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:31 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 05/10] vfio: Add region_map and region_unmap callbacks to
 VFIODeviceIOOps
Date: Sun,  5 Apr 2026 00:28:49 -0700
Message-ID: <20260405072857.66484-6-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename vfio_region_mmap() and vfio_region_unmap() to
vfio_region_mmap_fd() and vfio_region_unmap_fd() respectively, and
introduce new region_map and region_unmap callbacks in
VFIODeviceIOOps.

The new vfio_region_mmap() and vfio_region_unmap() functions now
dispatch through these io_ops callbacks, allowing different backends
to provide their own region mapping implementations. Both the ioctl
and vfio-user backends implement the callbacks by calling the renamed
fd-based variants.

This refactor enables future backends that may require alternate
region mapping strategies.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 hw/vfio-user/device.c         |  16 ++++-
 hw/vfio/device.c              |  14 +++++
 hw/vfio/region.c              | 108 +++++++++++++++++++++++-----------
 hw/vfio/vfio-region.h         |   4 ++
 include/hw/vfio/vfio-device.h |  25 ++++++++
 5 files changed, 131 insertions(+), 36 deletions(-)

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 64ef35b320..957d19217b 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -12,6 +12,7 @@
 #include "qemu/lockable.h"
 #include "qemu/thread.h"
 
+#include "hw/vfio/vfio-region.h"
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
 
@@ -428,6 +429,18 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     return ret;
 }
 
+static int vfio_user_device_io_region_map(VFIODevice *vbasedev,
+                                          VFIORegion *region)
+{
+    return vfio_region_mmap_fd(region);
+}
+
+static void vfio_user_device_io_region_unmap(VFIODevice *vbasedev,
+                                             VFIORegion *region)
+{
+    vfio_region_unmap_fd(region);
+}
+
 /*
  * Socket-based io_ops
  */
@@ -437,5 +450,6 @@ VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .set_irqs = vfio_user_device_io_set_irqs,
     .region_read = vfio_user_device_io_region_read,
     .region_write = vfio_user_device_io_region_write,
-
+    .region_map = vfio_user_device_io_region_map,
+    .region_unmap = vfio_user_device_io_region_unmap,
 };
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 338becffa7..1b703dcbec 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -23,6 +23,7 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio/vfio-region.h"
 #include "hw/core/iommu.h"
 #include "hw/core/hw-error.h"
 #include "trace.h"
@@ -656,6 +657,17 @@ static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
     return ret < 0 ? -errno : ret;
 }
 
+static int vfio_device_io_region_map(VFIODevice *vbasedev, VFIORegion *region)
+{
+    return vfio_region_mmap_fd(region);
+}
+
+static void vfio_device_io_region_unmap(VFIODevice *vbasedev,
+                                        VFIORegion *region)
+{
+    vfio_region_unmap_fd(region);
+}
+
 static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .device_feature = vfio_device_io_device_feature,
     .get_region_info = vfio_device_io_get_region_info,
@@ -663,4 +675,6 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .set_irqs = vfio_device_io_set_irqs,
     .region_read = vfio_device_io_region_read,
     .region_write = vfio_device_io_region_write,
+    .region_map = vfio_device_io_region_map,
+    .region_unmap = vfio_device_io_region_unmap,
 };
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 47fdc2df34..9f7780e06c 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -273,15 +273,48 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     return 0;
 }
 
-static void vfio_subregion_unmap(VFIORegion *region, int index)
+void vfio_region_register_mmap(VFIORegion *region, int index)
 {
+    char *name;
+
+    if (!region->mmaps[index].mmap) {
+        return;
+    }
+
+    name = g_strdup_printf("%s mmaps[%d]",
+                           memory_region_name(region->mem), index);
+    memory_region_init_ram_device_ptr(&region->mmaps[index].mem,
+                                      memory_region_owner(region->mem),
+                                      name, region->mmaps[index].size,
+                                      region->mmaps[index].mmap);
+    g_free(name);
+    memory_region_add_subregion(region->mem, region->mmaps[index].offset,
+                                &region->mmaps[index].mem);
+
+    trace_vfio_region_mmap(memory_region_name(&region->mmaps[index].mem),
+                           region->mmaps[index].offset,
+                           region->mmaps[index].offset +
+                           region->mmaps[index].size - 1);
+}
+
+void vfio_region_unregister_mmap(VFIORegion *region, int index)
+{
+    if (!region->mmaps[index].mmap) {
+        return;
+    }
+
     trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
                             region->mmaps[index].offset,
                             region->mmaps[index].offset +
                             region->mmaps[index].size - 1);
     memory_region_del_subregion(region->mem, &region->mmaps[index].mem);
-    munmap(region->mmaps[index].mmap, region->mmaps[index].size);
     object_unparent(OBJECT(&region->mmaps[index].mem));
+}
+
+static void vfio_region_unmap_fd_one(VFIORegion *region, int index)
+{
+    vfio_region_unregister_mmap(region, index);
+    munmap(region->mmaps[index].mmap, region->mmaps[index].size);
     region->mmaps[index].mmap = NULL;
 }
 
@@ -342,14 +375,13 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
     return true;
 }
 
-int vfio_region_mmap(VFIORegion *region)
+int vfio_region_mmap_fd(VFIORegion *region)
 {
     void *map_base, *map_align;
     Error *local_err = NULL;
     int i, ret, prot = 0;
     off_t map_offset = 0;
     size_t align;
-    char *name;
     int fd;
 
     if (!region->mem || !region->nr_mmaps) {
@@ -417,21 +449,7 @@ int vfio_region_mmap(VFIORegion *region)
             goto no_mmap;
         }
 
-        name = g_strdup_printf("%s mmaps[%d]",
-                               memory_region_name(region->mem), i);
-        memory_region_init_ram_device_ptr(&region->mmaps[i].mem,
-                                          memory_region_owner(region->mem),
-                                          name, region->mmaps[i].size,
-                                          region->mmaps[i].mmap);
-        g_free(name);
-        memory_region_add_subregion(region->mem, region->mmaps[i].offset,
-                                    &region->mmaps[i].mem);
-
-        trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
-                               region->mmaps[i].offset,
-                               region->mmaps[i].offset +
-                               region->mmaps[i].size - 1);
-
+        vfio_region_register_mmap(region, i);
         map_offset = region->mmaps[i].offset + region->mmaps[i].size;
     }
 
@@ -457,13 +475,13 @@ no_mmap:
     region->mmaps[i].mmap = NULL;
 
     for (i--; i >= 0; i--) {
-        vfio_subregion_unmap(region, i);
+        vfio_region_unmap_fd_one(region, i);
     }
 
     return ret;
 }
 
-void vfio_region_unmap(VFIORegion *region)
+void vfio_region_unmap_fd(VFIORegion *region)
 {
     int i;
 
@@ -473,41 +491,61 @@ void vfio_region_unmap(VFIORegion *region)
 
     for (i = 0; i < region->nr_mmaps; i++) {
         if (region->mmaps[i].mmap) {
-            vfio_subregion_unmap(region, i);
+            vfio_region_unmap_fd_one(region, i);
         }
     }
 }
 
-void vfio_region_exit(VFIORegion *region)
+int vfio_region_mmap(VFIORegion *region)
 {
-    int i;
+    VFIODevice *vbasedev;
+
+    if (!region->mem) {
+        return 0;
+    }
+
+    vbasedev = region->vbasedev;
+    if (!vbasedev->io_ops || !vbasedev->io_ops->region_map) {
+        return -EINVAL;
+    }
+
+    return vbasedev->io_ops->region_map(vbasedev, region);
+}
+
+void vfio_region_unmap(VFIORegion *region)
+{
+    VFIODevice *vbasedev;
 
     if (!region->mem) {
         return;
     }
 
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
-        }
+    vbasedev = region->vbasedev;
+    if (!vbasedev->io_ops || !vbasedev->io_ops->region_unmap) {
+        return;
+    }
+
+    vbasedev->io_ops->region_unmap(vbasedev, region);
+}
+
+void vfio_region_exit(VFIORegion *region)
+{
+    if (!region->mem) {
+        return;
     }
 
+    vfio_region_unmap(region);
+
     trace_vfio_region_exit(region->vbasedev->name, region->nr);
 }
 
 void vfio_region_finalize(VFIORegion *region)
 {
-    int i;
-
     if (!region->mem) {
         return;
     }
 
-    for (i = 0; i < region->nr_mmaps; i++) {
-        if (region->mmaps[i].mmap) {
-            munmap(region->mmaps[i].mmap, region->mmaps[i].size);
-        }
-    }
+    vfio_region_unmap(region);
 
     g_free(region->mem);
     g_free(region->mmaps);
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 9b21d4ee5b..afdce466b1 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -39,6 +39,10 @@ uint64_t vfio_region_read(void *opaque,
                           hwaddr addr, unsigned size);
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name, Error **errp);
+void vfio_region_register_mmap(VFIORegion *region, int index);
+void vfio_region_unregister_mmap(VFIORegion *region, int index);
+int vfio_region_mmap_fd(VFIORegion *region);
+void vfio_region_unmap_fd(VFIORegion *region);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_unmap(VFIORegion *region);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 17c5db369c..1a3b42bcaf 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -44,6 +44,7 @@ enum {
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODeviceIOOps VFIODeviceIOOps;
 typedef struct VFIOMigration VFIOMigration;
+typedef struct VFIORegion VFIORegion;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOASHwpt VFIOIOASHwpt;
@@ -260,6 +261,30 @@ struct VFIODeviceIOOps {
      */
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
                         void *data, bool post);
+
+    /**
+     * @region_map
+     *
+     * Map a region's directly accessible subranges and register any mmap-backed
+     * subregions with QEMU.
+     *
+     * @vdev: #VFIODevice to use
+     * @region: #VFIORegion to map
+     *
+     * Returns 0 on success or -errno.
+     */
+    int (*region_map)(VFIODevice *vdev, VFIORegion *region);
+
+    /**
+     * @region_unmap
+     *
+     * Unregister any mmap-backed subregions for a region and release their
+     * backend mappings.
+     *
+     * @vdev: #VFIODevice to use
+     * @region: #VFIORegion to unmap
+     */
+    void (*region_unmap)(VFIODevice *vdev, VFIORegion *region);
 };
 
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
-- 
2.50.1 (Apple Git-155)


