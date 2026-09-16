Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233CDC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yHJ-00037P-6j; Wed, 16 Sep 2026 18:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ehqragsKCrckXjXkdriXqfdlldib.Zljnbjr-absbiklkdkr.lod@flex--namangulati.bounces.google.com>)
 id 1x6yHG-00036z-Uh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:55 -0400
Received: from mail-qt1-x845.google.com ([2607:f8b0:4864:20::845])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ehqragsKCrckXjXkdriXqfdlldib.Zljnbjr-absbiklkdkr.lod@flex--namangulati.bounces.google.com>)
 id 1x6yHE-0006zc-MB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:54 -0400
Received: by mail-qt1-x845.google.com with SMTP id
 d75a77b69052e-52fb8f67601so1400181cf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789598330; x=1790203130; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b9efIHp4+HhSVXI85vz8ntN5hQXERDbX6ri96OxHJs4=;
 b=hBNfQ4TcW8+QWo1a8usxqg3Jw2VcLpw+cY6461iEeizjVj6MjVpOJrLPnysHFOyIvW
 Z9aeKJ0SCW8QhdowjTooTT527QVLxXeENORe5PVB0iDxIY5YAq4RhAIbQ22L4IHGKtpG
 nB9i57S6IEqW3yhThdSr96gXt82ujISe6dAK1CZAky3nDWg+GpwwqXg310+Ve1LpQTeH
 r8jPymfFDtCqdCSe2xEAmxTdP5exLQDHx3xBoObHMdMhH+r9pM1/pX6evWLBuhjSpmx+
 q2Uk4R75O9xnvaPn5HMj2Az1QvHzwLvjKqHe879BPVPFGM5pRqHLH4+Qk2T8cnqvaSBr
 MQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789598330; x=1790203130;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b9efIHp4+HhSVXI85vz8ntN5hQXERDbX6ri96OxHJs4=;
 b=Rc6iYj7YHFLcywg0Njdd7XTRpwHZROaXBJDIPoNlNaaeAgTbxfGM8UUzQE2kDcCCfj
 Y5yhNhq82wDwe2prsRT4y3AyvHdAknzkftDjm31+gMk6AkHFAkUjh2WrqIT9+wRzlB28
 wyavCfv/s/ziGej6KXHih5S7I5/6LfyMZl0aR/C4XlRmkwkUzpIRy2ZxGArBiFpqiahV
 8IbDK452YE5UhebOfIHeo4zSaJWA2EGg41EgeFtNKzSfdCo7gYjwMdDSuJQICCIgpnMR
 FMmID4QxcyXkLnR5qXwyALVzWLs0IE5Yq4g6tI1RP7x+qmKWYQ93QSqmZ9/HFbo5bR8n
 WU/w==
X-Gm-Message-State: AFuF++kP2qTf+LYPiHaspjcEPMxw1ZlC9ah9oyg4mo7vcI2j+B1xxN5T
 GiK4g29t3N7YQJgV3N/q1k6XpQurr1Rwcm2jBVm0jNcLfS/jmyZojd24tFs/6b6mWqQGnJcJml9
 YXCnpOo7ApGnr++uKCtWUJP766RHfB/hLkUimCMZlHQ/rEOsiVTojbZYsPs/Fp6ljo7i0dtQ9UA
 Hpt1kRnavINr1/8kmzGPSfZflvRitKnt/VtmjBNU8b9J3X8gKjsm57wDr3tqH7Mw==
X-Received: from qtpf1.prod.google.com ([2002:ac8:4701:0:b0:530:fe8b:15f2])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:451:b0:530:aa4a:993a with SMTP id
 d75a77b69052e-5327eef1639mr80082431cf.41.1789598330125; 
 Wed, 16 Sep 2026 15:38:50 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:38:43 +0000
In-Reply-To: <20260916223843.3995552-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260916223843.3995552-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916223843.3995552-5-namangulati@google.com>
Subject: [PATCH v3 4/4] vfio-user: support multiple FDs for sparse mmap regions
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::845;
 envelope-from=3ehqragsKCrckXjXkdriXqfdlldib.Zljnbjr-absbiklkdkr.lod@flex--namangulati.bounces.google.com;
 helo=mail-qt1-x845.google.com
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
index b8d2b7c1a8..f70321c060 100644
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
@@ -172,14 +174,17 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
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
@@ -187,10 +192,29 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     /* cap_offset in valid area */
     if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
         (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
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
@@ -472,12 +496,64 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
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
2.55.0.1082.g2b9226bbc0-goog


