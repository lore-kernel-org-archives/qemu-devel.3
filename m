Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6AFC5CFE7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtw4e-0004RX-JN; Tue, 11 Aug 2026 19:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3w7J7agsKCnIdQcQdWkbQjYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--namangulati.bounces.google.com>)
 id 1wtw4c-0004RJ-V6
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:39:58 -0400
Received: from mail-qv1-xf46.google.com ([2607:f8b0:4864:20::f46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3w7J7agsKCnIdQcQdWkbQjYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--namangulati.bounces.google.com>)
 id 1wtw4b-00089o-8w
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:39:58 -0400
Received: by mail-qv1-xf46.google.com with SMTP id
 6a1803df08f44-907ca5abf1bso2013936d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 16:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786491588; x=1787096388; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zoecSgXF0jz6AVCJIPmOWnugkxgSmyxGxo8IvlDkpE8=;
 b=L9Xb1ss/tVTsEFc0Ve/itMKsalf6IwsA9jvBt4WhVlDVgNVZ2gCJMN3oE4dc9ZZ0t/
 rsErdcGfYJf4p8dvjxi0K7m0QKzEZCviHIX0pxn+ZRKeP6+AXucYXtiYPHtEnhR1cEBl
 u0pWFAH+j7RB0C1LQvLuS4FcTn/UB/UPY6aZxk01ej5p014+WCCKHgSYFiYVCuxl0QPF
 b6OtCoYlGsoxBj4DdDwxCKA8DLfHSPzwawxM8d+Flr938T4k6oLDRzlEuiVIpWNdxiPw
 suXqVlwLQdob4J47CXWE8d5ZBsuB4hkA2O/CtDdHNpJxJJQjLKJkWBlYXg8y4gnKgB4g
 SHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786491588; x=1787096388;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zoecSgXF0jz6AVCJIPmOWnugkxgSmyxGxo8IvlDkpE8=;
 b=moTuv7M0eXQ9kDQ3e5kp7XpQDqqI1PMhKThgAGxTovt9X9SCk3BcCDs5e0ec3LoQug
 6yUFGx085IeHGqCuNEuYJENUTmXf3qRE+3ceheQ6LvA7/+7XN89yF3vqVtjPxJkew+6W
 EIbQi4HJ5tlCOUD1WkcwG4rLnwDqG5gP8azmLSlxe6caYSSv5NLU9fBMyi5MUV2uyIkv
 EAMEhS/1H7wZ6+0F+lNjAvri0Wz/0Gv061LAJEalY4UhMVgRtoAqXsqTiiZMum9Y8RXf
 pz/hOIBXIx/8R3tlwIJhfoLB30mT+YWKzoaTHyoN46pM+EHyE4RniNTy5ZZDzvnY+Ma5
 qBkg==
X-Gm-Message-State: AOJu0YwANhjSERoOB3asbC0aS3zF3GRGdVDyHBsgAnmncyuERDw6fcms
 WSOt2TqzJn9sUfTjcsemCQULFa+HDpD5dsmX7mYttrNIJNae4DkHmkKjzY3Vurd3ANAY0Zo7MJu
 LlUKYeYDPkZlLi4SK1liW9W0J9h//cQWdSPj7wS5vpApM0P/GOOfJr6RjH4dBRbofTEGaSa+Qan
 Ajw4T86fZoJF5HjonB2C49Bs8juQwhbNa78sLHHRYK0rw9RuU34AejXkQXZe2DTg==
X-Received: from qvpt8.prod.google.com ([2002:a0c:ea28:0:b0:905:7485:50e3])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2dca:b0:8fd:7913:b345 with SMTP id
 6a1803df08f44-90a7004ba71mr7477406d6.22.1786491587666; 
 Tue, 11 Aug 2026 16:39:47 -0700 (PDT)
Date: Tue, 11 Aug 2026 23:39:30 +0000
In-Reply-To: <20260811233930.401797-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260811233930.401797-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811233930.401797-4-namangulati@google.com>
Subject: [RFC PATCH 3/3] vfio-user: implement client support for multi-fd
 region mmap
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f46;
 envelope-from=3w7J7agsKCnIdQcQdWkbQjYWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--namangulati.bounces.google.com;
 helo=mail-qv1-xf46.google.com
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

Add client support for capability VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
(capability ID 16) in vfio-user.

Update vfio_user_device_io_get_region_info() to receive multiple file
descriptors passed in SCM_RIGHTS ancillary data for a region, and
implement setup_sparse_mmaps in vfio_user_device_io_ops_sock to parse
per-area file descriptor indices and fd_offset values.

Signed-off-by: Naman Gulati <namangulati@google.com>
---
 hw/vfio-user/device.c   | 63 ++++++++++++++++++++++++++++++++++++-----
 hw/vfio-user/protocol.h | 20 +++++++++++++
 2 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 9c4e10c1fd..48b1cd8f1e 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -14,6 +14,9 @@
 
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
+#include "hw/vfio/vfio-region.h"
+#include "hw/vfio/vfio-helpers.h"
+#include "hw/vfio/trace.h"
 
 /*
  * These are to defend against a malign server trying
@@ -171,23 +174,26 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
 static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
                                                struct vfio_region_info *info)
 {
-    int fd = -1;
-    VFIOUserFDs fds = { 0, 1, &fd };
+    int fds[VFIO_USER_MAX_MAX_FDS];
+    int num_fds = VFIO_USER_MAX_MAX_FDS;
+    VFIOUserFDs user_fds = { 0, num_fds, fds };
     int ret;
 
     if (info->index > vbasedev->num_initial_regions) {
         return -EINVAL;
     }
 
-    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &user_fds);
     if (ret) {
         return ret;
     }
 
-    if (fds.recv_fds > 0 && info->index < vbasedev->num_initial_regions) {
-        vbasedev->region_fds[info->index].fds = g_new0(int, 1);
-        vbasedev->region_fds[info->index].nr_fds = 1;
-        vbasedev->region_fds[info->index].fds[0] = fd;
+    if (user_fds.recv_fds > 0 && info->index < vbasedev->num_initial_regions) {
+        vbasedev->region_fds[info->index].fds = g_new0(int, user_fds.recv_fds);
+        vbasedev->region_fds[info->index].nr_fds = user_fds.recv_fds;
+        for (int i = 0; i < user_fds.recv_fds; i++) {
+            vbasedev->region_fds[info->index].fds[i] = fds[i];
+        }
     }
 
     /* cap_offset in valid area */
@@ -478,9 +484,52 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
 /*
  * Socket-based io_ops
  */
+static int vfio_user_device_io_setup_sparse_mmaps(VFIORegion *region,
+                                                  struct vfio_region_info *info,
+                                                  Error **errp)
+{
+    struct vfio_info_cap_header *hdr;
+    int i, j = 0;
+
+    hdr = vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS);
+    if (hdr) {
+        struct vfio_region_info_cap_sparse_mmap_fds *sparse_fds =
+            container_of(hdr, struct vfio_region_info_cap_sparse_mmap_fds,
+                         header);
+
+        trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
+                                             region->nr, sparse_fds->nr_areas);
+
+        region->mmaps = g_new0(VFIOMmap, sparse_fds->nr_areas);
+
+        for (i = 0; i < sparse_fds->nr_areas; i++) {
+            if (sparse_fds->areas[i].size) {
+                uint64_t end = sparse_fds->areas[i].offset +
+                               sparse_fds->areas[i].size - 1;
+
+                trace_vfio_region_sparse_mmap_entry(i,
+                                                    sparse_fds->areas[i].offset,
+                                                    end);
+                region->mmaps[j].offset = sparse_fds->areas[i].offset;
+                region->mmaps[j].fd_offset = sparse_fds->areas[i].fd_offset;
+                region->mmaps[j].size = sparse_fds->areas[i].size;
+                region->mmaps[j].fd_index = sparse_fds->areas[i].fd_index;
+                j++;
+            }
+        }
+
+        region->nr_mmaps = j;
+        region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+        return 0;
+    }
+
+    return vfio_default_setup_sparse_mmaps(region, info, errp);
+}
+
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .device_feature = vfio_user_device_io_device_feature,
     .get_region_info = vfio_user_device_io_get_region_info,
+    .setup_sparse_mmaps = vfio_user_device_io_setup_sparse_mmaps,
     .get_irq_info = vfio_user_device_io_get_irq_info,
     .set_irqs = vfio_user_device_io_set_irqs,
     .region_read = vfio_user_device_io_region_read,
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index c478d1353f..135b965d99 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -166,6 +166,26 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
+ */
+#define VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS 16
+
+struct vfio_region_sparse_mmap_fd_area {
+    uint64_t offset;
+    uint64_t fd_offset;
+    uint64_t size;
+    uint32_t fd_index;
+    uint32_t pad;
+};
+
+struct vfio_region_info_cap_sparse_mmap_fds {
+    struct vfio_info_cap_header header;
+    uint32_t nr_areas;
+    uint32_t reserved;
+    struct vfio_region_sparse_mmap_fd_area areas[];
+};
+
 /*
  * VFIO_USER_DEVICE_GET_IRQ_INFO
  * imported from struct vfio_irq_info
-- 
2.55.0.679.g6767b8d81c-goog


