Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0197CCA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFEnG-0000WK-TY; Fri, 09 Oct 2026 13:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MCrJagsKCgcuhthun1sh0pnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--namangulati.bounces.google.com>)
 id 1xFEn6-0000VN-IT
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:54:00 -0400
Received: from mail-qt1-x847.google.com ([2607:f8b0:4864:20::847])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MCrJagsKCgcuhthun1sh0pnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--namangulati.bounces.google.com>)
 id 1xFEn4-0006FT-Ca
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:56 -0400
Received: by mail-qt1-x847.google.com with SMTP id
 d75a77b69052e-53397338004so183464331cf.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791568433; x=1792173233; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=neFlIRomAUzJHtB2qDbjA3qGPB5L9JPvsWNz4Rrq2mo=;
 b=XQVckcX4FotB5bR2RnEYmFZrGRC4wbldcjPTxY23Q268CmndgNjmnZr3MeQMlcnrYZ
 qn7ThEpCueJYbm6JbIHKoxNHbCQmAhngWDTTzxapUJ4ud6DYjbupjEmHrvwHCh/MoyYU
 i3/L6ySFh2fqugSmmprFgNTEBcMrz9oILFXHAd8KSZymLD+maQs7FQ66tPkqYI7qaEL9
 LDnGKxhHiZTzy9Cp4+dLI64cunzeWEELGRzfQ8uFGFnVOrf6X0WWPiGJ897cENJswJGY
 Uywg5maiE0gULuXg+pL9BooEhJoH529K5xN7Qj5qw1TxFVs043Xo5kXBsyuRLXt1xBsU
 luNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791568433; x=1792173233;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=neFlIRomAUzJHtB2qDbjA3qGPB5L9JPvsWNz4Rrq2mo=;
 b=pJQ6yi1HwwugwRCiq8FGk2l6hj8yw4Pfipsi3La8YPyaFNqH+ll0ilbn9XAyqxGI0X
 QuW+fpMjuQ59wTIBceW1Ha+qMBo98uQPqQRnhfnVctCr2adUvrys1oojQvdn9LZh6QnO
 l4k+9MT7KswdgEYlNAs+PSv47Uweu76vf0S+OjjNPNZ70KZCnhg/WY7hWb9MWOFKZVRS
 w+GGQA/Fi/PB68CT6PRKPtE9WGvrNxySBJF5hi5+OUsAvAdmo73bMq1vOtOyulhe1NnL
 lN49i1RraMUt2GbDZ69q1bOp7l+pjleEQI6iGIIvwhTTvixb5ttetGdAcuWTv1hNV+22
 zY/A==
X-Gm-Message-State: AFq9FYJUWJ0TFTa4GZZzLswQza9yxLto0anUD3b6gWyj6qTcM05xZ0/+
 V0ZZlOka+mL9tw+A/UniW9UwDbDf45mjbtM6CTm7I9eV+hZkTvH4N/thE0oYoWEi4CaqJAvS1pa
 5YQB7tP25OPHuzk/SJ5iUxp/95kaCtSor7JfIdn+ktZjPh090SwlqBL2I6ZxeX/sBrcb8XXpjeO
 xFwBpTqhbjG27w3gguR2B5x2Sk0pUQSj/2Mts8jo26eMUbGYC2IoZgu6XyA/1bqw==
X-Received: from qtbp17-n2.prod.google.com
 ([2002:a05:622b:d1:20b0:535:7a68:6636])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622b:97:20b0:535:a5f8:a5c9 with SMTP id
 d75a77b69052e-535a5f8b5bemr22008941cf.73.1791568432502; 
 Fri, 09 Oct 2026 10:53:52 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:53:14 +0000
In-Reply-To: <20261009175314.1823347-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261009175314.1823347-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009175314.1823347-5-namangulati@google.com>
Subject: [PATCH v4 4/4] vfio-user: support multiple FDs for sparse mmap regions
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::847;
 envelope-from=3MCrJagsKCgcuhthun1sh0pnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--namangulati.bounces.google.com;
 helo=mail-qt1-x847.google.com
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
(capability ID 0x8001) in vfio-user, and advertise support via the
"sparse_mmap_fds" capability in VFIO_USER_VERSION.

Update vfio_user_device_io_get_region_info() to receive multiple file
descriptors passed in SCM_RIGHTS ancillary data for a region, store them
in VFIOUserProxy, and implement setup_sparse_mmaps in
vfio_user_device_io_ops_sock to validate and populate per-area file
descriptors and fd_offset values.

Signed-off-by: Naman Gulati <namangulati@google.com>
---
 hw/vfio-user/protocol.h |  35 +++++++++++---
 hw/vfio-user/proxy.h    |   2 +
 hw/vfio-user/device.c   | 102 +++++++++++++++++++++++++++++++++++++---
 hw/vfio-user/proxy.c    |  46 ++++++++++++++++--
 4 files changed, 168 insertions(+), 17 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index c478d1353f..b823689254 100644
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
@@ -69,12 +71,13 @@ typedef struct {
 #define VFIO_USER_CAP           "capabilities"
 
 /* "capabilities" members */
-#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
-#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
-#define VFIO_USER_CAP_PGSIZES   "pgsizes"
-#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
-#define VFIO_USER_CAP_MIGR      "migration"
-#define VFIO_USER_CAP_MULTI     "write_multiple"
+#define VFIO_USER_CAP_MAX_FDS           "max_msg_fds"
+#define VFIO_USER_CAP_MAX_XFER          "max_data_xfer_size"
+#define VFIO_USER_CAP_PGSIZES           "pgsizes"
+#define VFIO_USER_CAP_MAP_MAX           "max_dma_maps"
+#define VFIO_USER_CAP_MIGR              "migration"
+#define VFIO_USER_CAP_MULTI             "write_multiple"
+#define VFIO_USER_CAP_SPARSE_MMAP_FDS   "sparse_mmap_fds"
 
 /* "migration" members */
 #define VFIO_USER_CAP_PGSIZE            "pgsize"
@@ -166,6 +169,26 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
+ */
+#define VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS 0x8001
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
index 1a01e748cd..5c63c83a7c 100644
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
@@ -518,12 +542,76 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
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
+    int i;
+
+    hdr = vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS);
+    if (!hdr) {
+        return vfio_default_setup_sparse_mmaps(region, info, errp);
+    }
+
+    if (vfio_get_region_info_cap(info, VFIO_REGION_INFO_CAP_SPARSE_MMAP)) {
+        error_setg(errp, "%s: region %d cannot specify both "
+                   "SPARSE_MMAP and SPARSE_MMAP_FDS", __func__, region->nr);
+        return -EINVAL;
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
+    if (!user_fds || user_fds->recv_fds > sparse_fds->nr_areas) {
+        error_setg(errp, "%s: invalid fd count %d for %u sparse mmap areas "
+                   "in region %d", __func__,
+                   user_fds ? user_fds->recv_fds : 0,
+                   sparse_fds->nr_areas, region->nr);
+        return -EINVAL;
+    }
+
+    region->mmaps = g_new0(VFIOMmap, sparse_fds->nr_areas);
+
+    for (i = 0; i < sparse_fds->nr_areas; i++) {
+        struct vfio_region_sparse_mmap_fd_area *area = &sparse_fds->areas[i];
+
+        if (area->size == 0 || area->offset > region->size ||
+            area->size > region->size - area->offset ||
+            area->fd_index >= user_fds->recv_fds) {
+            error_setg(errp, "%s: invalid sparse mmap area %d in region %d",
+                       __func__, i, region->nr);
+            g_free(region->mmaps);
+            region->mmaps = NULL;
+            return -EINVAL;
+        }
+
+        trace_vfio_region_sparse_mmap_entry(i, area->offset,
+                                            area->offset + area->size - 1);
+        region->mmaps[i].offset = area->offset;
+        region->mmaps[i].fd_offset = area->fd_offset;
+        region->mmaps[i].size = area->size;
+        region->mmaps[i].fd = user_fds->fds[area->fd_index];
+    }
+
+    region->nr_mmaps = sparse_fds->nr_areas;
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
index 197aee07bf..44e2a839b0 100644
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
@@ -1214,6 +1238,18 @@ static bool check_multi(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
     return true;
 }
 
+static bool check_sparse_mmap_fds(VFIOUserProxy *proxy, QObject *qobj,
+                                  Error **errp)
+{
+    QBool *qb = qobject_to(QBool, qobj);
+
+    if (qb == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_SPARSE_MMAP_FDS);
+        return false;
+    }
+    return true;
+}
+
 static struct cap_entry caps_cap[] = {
     { VFIO_USER_CAP_MAX_FDS, check_max_fds },
     { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
@@ -1221,6 +1257,7 @@ static struct cap_entry caps_cap[] = {
     { VFIO_USER_CAP_MAP_MAX, check_max_dma },
     { VFIO_USER_CAP_MIGR, check_migr },
     { VFIO_USER_CAP_MULTI, check_multi },
+    { VFIO_USER_CAP_SPARSE_MMAP_FDS, check_sparse_mmap_fds },
     { NULL }
 };
 
@@ -1280,6 +1317,7 @@ static GString *caps_json(void)
     qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
     qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
     qdict_put_bool(capdict, VFIO_USER_CAP_MULTI, true);
+    qdict_put_bool(capdict, VFIO_USER_CAP_SPARSE_MMAP_FDS, true);
 
     qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
 
-- 
2.56.0.385.gd3acb90ef8-goog


