Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B53CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 00:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEFbX-0003XS-DA; Tue, 06 Oct 2026 20:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3h43FagsKChY9w8w92G7wF42AA270.yA8C08G-z0H079A929G.AD2@flex--namangulati.bounces.google.com>)
 id 1xEFIU-0001N3-5G
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:14:59 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3h43FagsKChY9w8w92G7wF42AA270.yA8C08G-z0H079A929G.AD2@flex--namangulati.bounces.google.com>)
 id 1xEFHo-0000lT-SL
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:13:44 -0400
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5352a4bba0dso52637081cf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791331720; x=1791936520; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=48YWQL5SaxeiqHBx5CeDimJtkbddU1hOzOaZwEJ0A2I=;
 b=UHzQDK65GbttkZHhUh1AHUP22Ys15sJDtb9ISBHlYyi/hijdshtSqjsbJ4/DYgJgva
 S8gFe9mFqlR74UVw2qEEr8A3a2wFsxIoxaXQ3rVod8KQ+I+sOpajd6S8IaVvWd4LE+bD
 tl+RCtM/UWamqm4AZLlbhaholWR/GJTYY1PSAYJgC62nqzxo1gO99b4yjTR6GboxIMej
 gQjDN24NFv+NWPjz35SHDtbHSg7grAkX69y6CjHTWtpTjLG4tkPZDD4Fp4er23ZK+zKm
 I3DzcolP/jgv/e7g3EsvngTioA576qwE+xfDVaCM2UW/ycXkBF1gfnQ9KdhUrqcWCNV7
 fiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791331720; x=1791936520;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=48YWQL5SaxeiqHBx5CeDimJtkbddU1hOzOaZwEJ0A2I=;
 b=gV/Mz6JVph9ofO1G15TRbSL8L3cjZvx99p9WuCVu5H4ALFEt/1xfzvfY51c+ZgVcsg
 Tf9XNYgKYdM9inc6MHhaNgD+bZKy+kNrn27DDdc2Tm1ACDV4ODn1z8yTWpkiATJ8joLJ
 Kaf0ArN7G0WFCtQnydp5PBo85fiqKP5up1tr2woTnyXRNqeXxHmlUkg24OUA2TGqIQkZ
 XHypsAhlf7WvtA8PqrMBUgsWrqFZP/t63Jy0yzTb55ipaEB2a0623I+6+J3sJ9xRFUyM
 Jk5RR8Q1Fq1FCu4tCTyw1sSkmT6s+hbysduV2G0QKHtDuwISRSYxy78lgmct/WeaTSfo
 CpIQ==
X-Gm-Message-State: AFuF++nAFcS4s2tTzZMnmaO1Bx7DmEUYn7ica7BwYQQcBYwThExWzJCW
 SdBBkIjjM5NDiioMso7E6CUHlMXRRX1DUp7yMdF5h2PInGVD2IW03yeII1oHOLOu+ZrN5r76TVq
 WQ+nBn2pqcaIgvJMkv1LYWtmLYogC5Og5222aZWQswQk/i2I5fiQNGqsZajybVzOH7RDc3byUuj
 XiSyrAvV/lKufUHeSne1nyfcs5DS5UUDrMHMM5hwQvnnBiOhg8ZfyU6o2h/HLaNQ==
X-Received: from qttr3.prod.google.com ([2002:ac8:7943:0:b0:535:247e:c776])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d44:b0:530:430d:87f7 with SMTP id
 d75a77b69052e-53575592babmr9413421cf.47.1791331719590; 
 Tue, 06 Oct 2026 17:08:39 -0700 (PDT)
Date: Wed,  7 Oct 2026 00:08:33 +0000
In-Reply-To: <20261007000833.2445641-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261007000833.2445641-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261007000833.2445641-5-namangulati@google.com>
Subject: [PATCH v3 RESEND 4/4] vfio-user: support multiple FDs for sparse mmap
 regions
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.160.199;
 envelope-from=3h43FagsKChY9w8w92G7wF42AA270.yA8C08G-z0H079A929G.AD2@flex--namangulati.bounces.google.com;
 helo=mail-qt1-f199.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
descriptors passed in SCM_RIGHTS ancillary data for a region, store them
in VFIOUserProxy, and implement setup_sparse_mmaps in
vfio_user_device_io_ops_sock to populate per-area file descriptors and
fd_offset values.

Signed-off-by: Naman Gulati <namangulati@google.com>
---
 hw/vfio-user/protocol.h | 22 ++++++++++
 hw/vfio-user/proxy.h    |  2 +
 hw/vfio-user/device.c   | 90 +++++++++++++++++++++++++++++++++++++----
 hw/vfio-user/proxy.c    | 32 +++++++++++++--
 4 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index c478d1353f..7b27a70db5 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -15,6 +15,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#define VFIO_USER_MAX_REGIONS 100
+
 typedef struct {
     uint16_t id;
     uint16_t command;
@@ -166,6 +168,26 @@ typedef struct {
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
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 7b97460cc5..4b9834a436 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -72,6 +72,7 @@ typedef struct VFIOUserProxy {
     AioContext *ctx;
     QEMUBH *req_bh;
     bool async_ops;
+    VFIOUserFDs *region_fds[VFIO_USER_MAX_REGIONS];
 
     /*
      * above only changed when BQL is held
@@ -111,6 +112,7 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 VFIOUserFDs *vfio_user_getfds(int numfds);
 void vfio_user_putfds(VFIOUserMsg *msg);
+void vfio_user_free_fds(VFIOUserFDs *fds);
 
 void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 1a01e748cd..1b5025f205 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -14,12 +14,14 @@
 
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
+#include "hw/vfio/vfio-region.h"
+#include "hw/vfio/vfio-helpers.h"
+#include "hw/vfio/trace.h"
 
 /*
  * These are to defend against a malign server trying
  * to force us to run out of memory.
  */
-#define VFIO_USER_MAX_REGIONS   100
 #define VFIO_USER_MAX_IRQS      50
 
 bool vfio_user_get_device_info(VFIOUserProxy *proxy,
@@ -209,14 +211,17 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
                                                struct vfio_region_info *info,
                                                int *fd)
 {
-    VFIOUserFDs fds = { 0, 1, fd};
-    int ret;
+    int fds[VFIO_USER_MAX_MAX_FDS];
+    VFIOUserFDs user_fds = { 0, VFIO_USER_MAX_MAX_FDS, fds };
+    int i, ret;
+
+    *fd = -1;
 
     if (info->index > vbasedev->num_initial_regions) {
         return -EINVAL;
     }
 
-    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &user_fds);
     if (ret) {
         return ret;
     }
@@ -225,10 +230,29 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
         (info->cap_offset < sizeof(*info)
          || info->cap_offset + sizeof(struct vfio_info_cap_header) > info->argsz)) {
-        return -EINVAL;
+        ret = -EINVAL;
+    } else if (vfio_get_region_info_cap(info,
+                                        VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS)) {
+        if (info->index < VFIO_USER_MAX_REGIONS && user_fds.recv_fds > 0) {
+            VFIOUserFDs *saved = vfio_user_getfds(user_fds.recv_fds);
+
+            saved->recv_fds = user_fds.recv_fds;
+            memcpy(saved->fds, fds, user_fds.recv_fds * sizeof(int));
+            vfio_user_free_fds(vbasedev->proxy->region_fds[info->index]);
+            vbasedev->proxy->region_fds[info->index] = saved;
+            return 0;
+        }
+    } else if (user_fds.recv_fds > 0) {
+        *fd = fds[0];
+        fds[0] = -1;
     }
 
-    return 0;
+    for (i = 0; i < user_fds.recv_fds; i++) {
+        if (fds[i] >= 0) {
+            close(fds[i]);
+        }
+    }
+    return ret;
 }
 
 static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
@@ -518,12 +542,64 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
 /*
  * Socket-based io_ops
  */
+static int vfio_user_device_io_setup_sparse_mmaps(VFIORegion *region,
+                                                  struct vfio_region_info *info,
+                                                  Error **errp)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_region_info_cap_sparse_mmap_fds *sparse_fds;
+    VFIOUserFDs *user_fds = NULL;
+    int i, j = 0;
+
+    hdr = vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS);
+    if (!hdr) {
+        return vfio_default_setup_sparse_mmaps(region, info, errp);
+    }
+
+    sparse_fds = container_of(hdr, struct vfio_region_info_cap_sparse_mmap_fds,
+                              header);
+
+    trace_vfio_region_sparse_mmap_header(region->vbasedev->name,
+                                         region->nr, sparse_fds->nr_areas);
+
+    if (region->nr < VFIO_USER_MAX_REGIONS) {
+        user_fds = region->vbasedev->proxy->region_fds[region->nr];
+    }
+
+    region->mmaps = g_new0(VFIOMmap, sparse_fds->nr_areas);
+
+    for (i = 0; i < sparse_fds->nr_areas; i++) {
+        if (sparse_fds->areas[i].size) {
+            uint64_t end = sparse_fds->areas[i].offset +
+                           sparse_fds->areas[i].size - 1;
+            int fd = -1;
+
+            if (user_fds &&
+                sparse_fds->areas[i].fd_index < user_fds->recv_fds) {
+                fd = user_fds->fds[sparse_fds->areas[i].fd_index];
+            }
+
+            trace_vfio_region_sparse_mmap_entry(i, sparse_fds->areas[i].offset,
+                                                end);
+            region->mmaps[j].offset = sparse_fds->areas[i].offset;
+            region->mmaps[j].fd_offset = sparse_fds->areas[i].fd_offset;
+            region->mmaps[j].size = sparse_fds->areas[i].size;
+            region->mmaps[j].fd = fd;
+            j++;
+        }
+    }
+
+    region->nr_mmaps = j;
+    region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+    return 0;
+}
+
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .device_feature = vfio_user_device_io_device_feature,
     .get_region_info = vfio_user_device_io_get_region_info,
+    .setup_sparse_mmaps = vfio_user_device_io_setup_sparse_mmaps,
     .get_irq_info = vfio_user_device_io_get_irq_info,
     .set_irqs = vfio_user_device_io_set_irqs,
     .region_read = vfio_user_device_io_region_read,
     .region_write = vfio_user_device_io_region_write,
-
 };
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 197aee07bf..a686ffe25e 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -363,6 +363,8 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         }
 
         memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+    } else if (msg->fds != NULL) {
+        msg->fds->recv_fds = 0;
     }
 
     /*
@@ -740,6 +742,10 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 
     qemu_mutex_unlock(&proxy->lock);
 
+    if (!ok && fds != NULL) {
+        fds->recv_fds = 0;
+    }
+
     return ok;
 }
 
@@ -867,17 +873,30 @@ void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
 }
 
 /*
- * Close FDs erroneously received in an incoming request.
+ * Close and free received FDs.
  */
-void vfio_user_putfds(VFIOUserMsg *msg)
+void vfio_user_free_fds(VFIOUserFDs *fds)
 {
-    VFIOUserFDs *fds = msg->fds;
     int i;
 
+    if (!fds) {
+        return;
+    }
+
     for (i = 0; i < fds->recv_fds; i++) {
-        close(fds->fds[i]);
+        if (fds->fds[i] >= 0) {
+            close(fds->fds[i]);
+        }
     }
     g_free(fds);
+}
+
+/*
+ * Close FDs erroneously received in an incoming request.
+ */
+void vfio_user_putfds(VFIOUserMsg *msg)
+{
+    vfio_user_free_fds(msg->fds);
     msg->fds = NULL;
 }
 
@@ -967,6 +986,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
+    int i;
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1027,6 +1047,10 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
         vfio_user_iothread = NULL;
     }
 
+    for (i = 0; i < VFIO_USER_MAX_REGIONS; i++) {
+        vfio_user_free_fds(proxy->region_fds[i]);
+    }
+
     g_free(proxy->sockname);
     g_free(proxy);
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


