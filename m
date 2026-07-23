Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC3BC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1xo-0005iB-2D; Thu, 23 Jul 2026 18:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wv-00055R-Hy
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:29 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wt-0001Tn-MJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:29 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-80cebd41372so10794047b3.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845882; x=1785450682; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K2yffjOSvF7DKJc73OqN7e50BGgio3XnC3khWPJsclE=;
 b=XlozkjfSSOaV0m15bu33w42D2E/N60PCYwrwHqml5cPCpun+wtV++MZsrZyZ2KCbzC
 crSwt8gdQVg2sYJqQQSfkub2iJegTRdsCINDuYgG/f5NjjgnA0OmrexSMTgoRfl/z33U
 9rNNs1EDncMAu2pN0piWMuSHef1EU5ZUyg6ImoCOJY0FoXf9XKVpeNDXx099+rVdHc2O
 m7wvYGylkcl5c5QwRFrcAGIeEBz257s9IT5x27ZMw60ShRk6rKNqva5RB2xtdTqNDF33
 wfo8ci5TSOtEnVFTva0G0hWxHn88ryEV4byl5kIbk3D6mB7NntmNXW0mjJRO/VbVltIQ
 B0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845882; x=1785450682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K2yffjOSvF7DKJc73OqN7e50BGgio3XnC3khWPJsclE=;
 b=Z7LiJ1rYBbDq6oUXyZJbM30QvvvDCpzzMRHt+PiYt8cUt1q6UBc9384t5dSGsvFk7h
 78AabO3uGU6SZIH5X6eF87sctSlp3SIY42lFLXlULu3XcdiRJe4nX8bLM2iuupDcv5G/
 Hwp1oqaRU5s1PMV7Nmes3zwEKiKeieeCr+a6zzMBQ8v2sCTfGU2auOy0+nwK6mV0Z4z0
 iPi2NRmpAbOcT2E4Ch26jtCsAKg5YjPSBShcJ6GQrNidq7JmhnP9DzVxPdHKqSVJNblZ
 c3IwMQt5NR6SXw/Hk1FZqzefpTr55uTGQvWN21qBnRkRu2weU4uwxuao+aohXtAjH+Rv
 O1Uw==
X-Gm-Message-State: AOJu0YxnmPTVrbJ4BJcgFs8Hg8EybrhLSbL+3TxKtXJUtPT/0oFYNUaO
 ydKW+VlHt34JoNA9DbTKdFCYK6HmBwDDMUa/WYT6S8t7MxhvL93dfvib
X-Gm-Gg: AR+sD11N5frcsHgSwm+0IT/X/2d1XtUFefO6S614x/ZCAYgmYR5bstMv97Ybx8b3VDc
 2tvy8D/Eho2BW+iGPQxaA07a9O4a1RqheDzq5vdoZN23sCRPs5hlsCZbHQWsp+OS1DsqCwobfSU
 5wppCDyoncxsfGRhyphj4iyxLyy7I6pRAZ8oeeSVmOgG+Xj272GucutO/Jt9rAB0ILtOjlW3Tfw
 axUQkO1iSuk7ddtZqwiWI11yvPy/KyvYAt3kySYlm+gr1zQdzRqoposslxTIiuhYHZ1BKkuJhns
 5sfSf8d4fq5NZiAcg6jLp8gaBp4G+7/q2TdCKjpEnqd19AdxEAQZF5UvQEdVFSCFBvRUaC23PAg
 hmSIo16wlkr+5rHCfpvh5vRNGIDcrzXY/yTqgX/2O2mZ/2Uup8E8Wc2kJI0InptXb4IIVpMY/K6
 QAHEZ7NAQ=
X-Received: by 2002:a05:690c:6f0c:b0:80d:66b2:852 with SMTP id
 00721157ae682-81f4c30bf1bmr16154247b3.44.1784845881639; 
 Thu, 23 Jul 2026 15:31:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:21 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:10 -0700
Subject: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=6829;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=wDscEQxvQqYDZSfNPahD+DjyKJ1NxmTiWn45TwBb6QE=;
 b=CJBOJE+xeUrGOcOb0j1TMC/d/upLE8YRQ1ckKJaYNdC/WEZqJNmR6hP/uMpLdIVbgQQT72fZk
 /+ilUmq3t0wBqEgT68PxM+KMmkpBKIL4XbZU2459hbbQ9BZRoTOIlhX
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If memory isolation mode is active for the vhost-user device adds
features to:
- Gather the size required for bounce buffers and vrings in shared
  isolation region
- Allocate the required space in an anonymous file
- Create a vhost-iova-tree with space to map entire isolation region
- Map guest memory regions and shared vrings into the tree
- Release these resources upon backend cleanup

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-user.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f296b63fb9..710cf966f8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -18,6 +18,7 @@
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/vhost-iova-tree.h"
 #include "chardev/char-fe.h"
 #include "io/channel-socket.h"
 #include "system/kvm.h"
@@ -25,6 +26,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/uuid.h"
 #include "qemu/sockets.h"
+#include "qemu/memfd.h"
 #include "system/runstate.h"
 #include "system/cryptodev.h"
 #include "migration/postcopy-ram.h"
@@ -320,6 +322,13 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
 
+typedef struct IsolationRegion {
+    uint64_t base_addr;
+    uint64_t vring_base_addr;
+    uint64_t size;
+    int iso_fd;
+} IsolationRegion;
+
 struct vhost_user {
     struct vhost_dev *dev;
     /* Shared between vhost devs of the same virtio device */
@@ -353,6 +362,10 @@ struct vhost_user {
      * by the backend (see @features).
      */
     uint64_t protocol_features;
+
+    /* Isolated memory data*/
+    struct IsolationRegion iso_memory;
+    VhostIOVATree *iso_iova_tree;
 };
 
 struct scrub_regions {
@@ -1109,6 +1122,121 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
     return 0;
 }
 
+/* TODO: Is there any notifier cleanup required here?*/
+static void cleanup_isolation_regions(struct vhost_dev *dev)
+{
+    struct vhost_user *u = dev->opaque;
+    if (u->iso_memory.base_addr) {
+        vhost_iova_tree_delete(u->iso_iova_tree);
+        u->iso_iova_tree = NULL;
+        memset(&u->iso_memory, 0, sizeof(IsolationRegion));
+        qemu_memfd_free((gpointer) u->iso_memory.base_addr, u->iso_memory.size,
+                         u->iso_memory.iso_fd);
+        u->iso_memory.base_addr = 0;
+    }
+}
+
+__attribute__((unused))
+static int init_isolation_regions(struct vhost_dev *dev,
+                                  VhostUserMsg *msg,
+                                  int *fds, size_t *fd_num)
+{
+    Error *err = NULL;
+    struct vhost_user *u = dev->opaque;
+    uint32_t nregions = dev->mem->nregions;
+    uint64_t buffer_reg_size = 0;
+    DMAMap newEntry = {
+        .perm = IOMMU_RW
+    };
+    g_autoptr(GArray) buffer_regions =
+        g_array_new(FALSE, TRUE, sizeof(DMAMap));
+
+    msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
+
+    /* In case of reset, clear old regions*/
+    if (u->iso_memory.base_addr != 0) {
+        cleanup_isolation_regions(dev);
+        vhost_iova_tree_delete(u->iso_iova_tree);
+    }
+
+    /* Gather information for bounce buffers to be mapped */
+    for (int i = 0; i < nregions; i++) {
+        struct vhost_memory_region *dev_region = &dev->mem->regions[i];
+        hwaddr size = ROUND_UP(dev_region->memory_size,
+                      qemu_real_host_page_size());
+        newEntry.translated_addr = dev_region->guest_phys_addr;
+        newEntry.size = size - 1;
+        buffer_reg_size += size;
+        g_array_append_val(buffer_regions, newEntry);
+    }
+
+    int num;
+    size_t desc_size;
+    size_t avail_size;
+    size_t driver_area_size;
+    size_t device_area_size;
+    size_t total_vring_size = 0;
+    size_t total_mmap_size;
+
+    /* Get space required for all vrings */
+    for (int j = 0; j < dev->nvqs; j++) {
+        num = virtio_queue_get_num(dev->vdev, dev->vq_index + j);
+        desc_size = sizeof(vring_desc_t) * num;
+        avail_size = offsetof(vring_avail_t, ring[num]) +
+                        sizeof(uint16_t);
+        driver_area_size = ROUND_UP(desc_size + avail_size,
+                            qemu_real_host_page_size());
+        device_area_size = ROUND_UP(offsetof(vring_used_t, ring[num]) +
+                                    sizeof(uint16_t),
+                                    qemu_real_host_page_size());
+        total_vring_size += driver_area_size + device_area_size;
+    }
+
+    total_mmap_size = buffer_reg_size + total_vring_size;
+
+    /* Allocate and map an anonymous file to hold the isolation region */
+    u->iso_memory.base_addr = (uint64_t) qemu_memfd_alloc("iso_r",
+                              total_mmap_size,
+                              F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                              &u->iso_memory.iso_fd, &err);
+    u->iso_memory.size = total_mmap_size;
+
+    if (err) {
+        error_report_err(err);
+        cleanup_isolation_regions(dev);
+        return -1;
+    }
+
+    uint64_t last_addr = int128_get64(int128_add(u->iso_memory.base_addr,
+                                                 total_mmap_size - 1));
+
+    /*
+     * Instantiates iova tree sized to map bounce buffers and vrings to the
+     * isolation region in host va.
+     */
+    u->iso_iova_tree = vhost_iova_tree_new(u->iso_memory.base_addr, last_addr);
+
+    assert(&u->iso_memory.iso_fd >= 0);
+    DMAMap *map;
+    DMAMap vring_map = {
+        .perm = IOMMU_RW,
+        .size = total_vring_size - 1,
+        /*vrings are allocated on tree first, so will be assigned base addr*/
+        .translated_addr = u->iso_memory.base_addr
+    };
+
+    vhost_iova_tree_map_alloc(u->iso_iova_tree, &vring_map,
+                              vring_map.translated_addr);
+    u->iso_memory.vring_base_addr = vring_map.iova;
+    for (int i = 0; i < buffer_regions->len; i++) {
+        map = &g_array_index(buffer_regions, DMAMap, i);
+        vhost_iova_tree_map_alloc_gpa(u->iso_iova_tree, map,
+                                      map->translated_addr);
+    }
+
+    return 0;
+}
+
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
@@ -2681,6 +2809,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
     g_free(u->region_rb_offset);
     u->region_rb_offset = NULL;
     u->region_rb_len = 0;
+    cleanup_isolation_regions(dev);
     g_free(u);
     dev->opaque = 0;
 

-- 
2.43.0


