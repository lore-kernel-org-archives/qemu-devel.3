Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE696C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5kz-0002jg-O5; Wed, 26 Aug 2026 01:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BHOOagsKCn8qdpdqjxodwljrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--namangulati.bounces.google.com>)
 id 1wz5kw-0002j0-4d
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 01:00:59 -0400
Received: from mail-qt1-x848.google.com ([2607:f8b0:4864:20::848])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BHOOagsKCn8qdpdqjxodwljrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--namangulati.bounces.google.com>)
 id 1wz5ks-0003sk-5R
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 01:00:56 -0400
Received: by mail-qt1-x848.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso5317901cf.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 22:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787720452; x=1788325252; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b12QXxLcUt6BFDnnymY2XfEHw+7hm2Vsk4uRaVQQ38k=;
 b=U8sjpstL9ZFid42vvPYBhWi3dJ3Km9E2AuQHv4L4zzG69Y6dOTqbSRXVPNe2sJJBHG
 xc3ePSfpjIbDJLQvtosA8Q9rDoKUWaAy8xPscdB9znrahU9X3q9LEwuxto22XQDpDj8c
 m5L4PDvUqz2ZygeKRju53Ym1JrWJx8rt2OtnG22FN7ZMh5RfuxBLLcjVsAXjPtCniBJ7
 o+8gWcGw25UtZUozIEHc5W4f/UatjaqPOkpjspbt5x3BNa4i530y0kptVxTQoXghNpaf
 lkFFFFTp0sNe/kXXX3ZaVT5mn+jhy6p7JM68BZ2byP+IZjiduxzXgsKFN8NOKIgbx0MS
 9sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787720452; x=1788325252;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b12QXxLcUt6BFDnnymY2XfEHw+7hm2Vsk4uRaVQQ38k=;
 b=TFrxY6JIBD4pQ20z1v4zcxbiXXsFtMqF6Ls7d/QES6T0Dbqk96PDdv1MG1mZkRK6sb
 2Twgi/EgGSCxLg78hASlDCPwX3s6NDfQtB6d2zBxiY+uNJHzjeAY2sLF4XkN+6JGKv7M
 rVndBVZBeBBHmxKqynJ0RvIm42dC/1K1IhKoNwAI4UsMLau4eoLqZGZVY0XODq3/cpq2
 jpap6qwYRClWb4/fCcKXhfJ8hTxC4eS6+hH345QkR8TRmB9SMnDEKwv38UoSgIW74RBz
 nxaj0y6nsTLzlnMR2Mp1FCRiK6sPK4fZhPXOmvMhNYSDd30mF6yoiSR9xY+Zfg8zbUqe
 h/Dw==
X-Gm-Message-State: AFuF++nS7HVyFC68t89ci+PZiY2v/1iOMAOScn0J/YedDbasgsnwQxPi
 77JDiFAYdd5pyLdsoSwLXORWCMokRJWb/5SlDS7L9Lveg5yVRP/OG6g41PJoYxUyOq82Ln4xOMS
 ulxzuvmmltCxrkhZEi4gU4akqJNodniMIfS5xprwzqrahAmvC2fnbHrjKir/BL3VUdkACbte5Il
 PWDqvL1h0qYCfKhdEvPDxDK1EGPJtZBsvB0xa6kB9zpbgweYyyQjvVQXsqCCW+cQ==
X-Received: from qtbfc18.prod.google.com ([2002:a05:622a:4892:b0:51c:a432:e62])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1347:b0:51c:8432:1753 with SMTP id
 d75a77b69052e-52e423a77e0mr36007831cf.30.1787720452021; 
 Tue, 25 Aug 2026 22:00:52 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:00:39 +0000
In-Reply-To: <20260826050039.2068138-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260826050039.2068138-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826050039.2068138-4-namangulati@google.com>
Subject: [PATCH v2 3/3] vfio-user: implement client support for multi-fd
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::848;
 envelope-from=3BHOOagsKCn8qdpdqjxodwljrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--namangulati.bounces.google.com;
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
index 03a7026778..58a691601c 100644
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
@@ -172,8 +175,9 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
                                                struct vfio_region_info *info,
                                                struct VFIORegionFDs *region_fds)
 {
-    int fd = -1;
-    VFIOUserFDs fds = { 0, 1, &fd };
+    int fds[VFIO_USER_MAX_MAX_FDS];
+    int num_fds = VFIO_USER_MAX_MAX_FDS;
+    VFIOUserFDs user_fds = { 0, num_fds, fds };
     int ret;
 
     region_fds->fds = NULL;
@@ -183,7 +187,7 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
         return -EINVAL;
     }
 
-    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &user_fds);
     if (ret) {
         return ret;
     }
@@ -194,10 +198,12 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
         return -EINVAL;
     }
 
-    if (fds.recv_fds > 0) {
-        region_fds->fds = g_new0(int, 1);
-        region_fds->nr_fds = 1;
-        region_fds->fds[0] = fd;
+    if (user_fds.recv_fds > 0) {
+        region_fds->fds = g_new0(int, user_fds.recv_fds);
+        region_fds->nr_fds = user_fds.recv_fds;
+        for (int i = 0; i < user_fds.recv_fds; i++) {
+            region_fds->fds[i] = fds[i];
+        }
     }
 
 
@@ -483,9 +489,52 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
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
2.55.0.860.g4b6b3295ed-goog


