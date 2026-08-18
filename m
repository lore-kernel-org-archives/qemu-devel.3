Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A3DC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC7v-0005DG-3I; Tue, 18 Aug 2026 01:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7t-0005CQ-H9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:41 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7r-0003mY-In
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so3523185b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029958; x=1787634758; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8wuYe3aPv+YJ4aJ8Ua2kMF85cw3TlH8w6CZl7jDCufE=;
 b=MPTbaOyz7Ro1op+PYtuiY/Qie17UT86ym+AFqn5i+bnd7VjrCN0blojku81y5ySpxR
 XE43ndOW1lBN0kRwS/kBlGuYBtqbW5EzYmHTIrdYiRfHCZrUT2cpMQ0TRU8n6ZsC4SD4
 VD8/Hn0ZuKc9OePeV7kXHtDPIDJLII81ufNYdbnBVo3sMrkdFVY7Xlw1MXolZSa4YsuJ
 lF0TbWWOO5HwC/9NMAirpKGnpJB0+N84o1h9fTdY2bUsDhE0DpFQdB1K+v9kZwS88lAi
 ej3tPTcvIUjQ/ndvA+9gv/AmNQpzXOHNNAqSn0jwpWOrStbsjbOLtMgmA5bNwuzTPt9n
 7xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029958; x=1787634758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8wuYe3aPv+YJ4aJ8Ua2kMF85cw3TlH8w6CZl7jDCufE=;
 b=KVrRWz9pUstlyiFBkJYOTB44FchXtRBAvvWAgVUx2sc0B3FM8I/Zm1FVmD7/TH0w0O
 8uYMNhPldcTkhs3+dd5HH8LH93cnZn+HB53xAeG2CE9iWA2nqP6I7iACU3Z+jCNAS6YC
 DVIe5GkIIHWzZtI+pdCYXNKkvT34h4wMZ3yiBvGZnQzoXZJSMydEmmil7rQ+gQ0Ud8nQ
 QMPcONepSMvpdmeZkHOdcDR+o9hzeaYx+C6GrFWbpNvHbcBysxu1VHFAA6k4xYpb3ZG0
 Rd9R1fHg/63pt+drzKCG9drxt+RTsPXMBD2rDf6umCP0260hoAf5ADx9ranYyvvXB92S
 8xGQ==
X-Gm-Message-State: AOJu0YwEJ15Bm5ukIsTw6rQndNsk0TFH0epg91cqkSvweGMDx1yVhBGS
 rwZRcwTQKjc5+hls6cgoy7s1ITBneDQvarUQjEZj1Dd35Vz/dTBKwOT1
X-Gm-Gg: AR+sD12UhVDl7+f+W7n0NpPYAeK0TUopUB4hT1hx4JGI8eS8HGxgwNE2ePvHKeQWVdE
 Jwqkd9v6X5YI6qdMWMHlTWlL2FoFCIlXxgfy9ymxoKzVWVifT4hev+X9AbjAHpvZCCdvGObjuFn
 17BgKhMS3cNhWtyKCAtkWIk/VQ3Undgz5H0HD07Ix0jif6lbY/T3VeE19oBsGzS71KtlHdRVJX/
 ci8sgclmGoIgouZEM4PdPg0fSvGjJr53l7uCztOCLRonz9HjSZbmXnFpkhenM0Rz97Bgv60jRfA
 fr00l8+S89QBko00jGqSsufeeiP5gassIY5r/ctEFn2CGSKOg8SPtA8sdbVrw9DitRN1IB0oWd+
 sUmUtQJ/cJJxvDm41iGLYx6GKoY+AzVISaWUMEreFK/+GJv+3Z730KUJo8GiSjNIZcXC9lwEk6I
 X4EnqGwWXUhb7+XdcrOR3q88lOf8zZf+UnTUEHgpj7mHD4S7qiIWx46zW1zMiDPffwEA==
X-Received: by 2002:a05:6a00:4193:b0:845:e9e8:645c with SMTP id
 d2e1a72fcca58-84fde11e46amr33116869b3a.6.1787029958217; 
 Mon, 17 Aug 2026 22:12:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:37 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:22 -0700
Subject: [PATCH RFC v2 07/13] hw/virtio/vhost-user: create isolation region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-7-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
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
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=7145;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=Y8FMqK8tl2z1lXfprKV5PVmmovyeXR0vRWxv7yRJE+M=;
 b=DaG7i69Lze5UQiIRdjFrHrvlHhMlGExbU4HaxptGfmc+ci4x+2veNzCD3oqlLHpolAAoJQUd6
 zh60ilHkTbrAZHEawyGYCD8tg5ozrk3Hu0VChDUafW8BKSBtXlO+1F0
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x42d.google.com
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
 hw/virtio/vhost-user.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1c003e4d9d..7e9233e174 100644
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
@@ -320,6 +322,17 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
 
+/* Memory region shared with back-end when memory-isolation is active */
+typedef struct {
+    void *shared_mem_addr; /* mapped shared memory */
+    VhostIOVATree *tree; /* controls mapping of regions into IOVA space */
+    void *vring_hva_addr; /* beginning of vring region in shared memory */
+    size_t vring_region_size; /* amount of shared memory reserved for vrings */
+    size_t size; /* size of the mapped shared memory */
+    int fd; /* descriptor of anonymous file backing shared iso region */
+    Int128 iso_iova_offset; /* translation from IOVA to hva of iso region */
+} IsolationModeCtx;
+
 struct vhost_user {
     struct vhost_dev *dev;
     /* Shared between vhost devs of the same virtio device */
@@ -353,6 +366,9 @@ struct vhost_user {
      * by the backend (see @features).
      */
     uint64_t protocol_features;
+
+    /* Data specfic to isolated memory mode */
+    IsolationModeCtx iso_mem_ctx;
 };
 
 struct scrub_regions {
@@ -1112,6 +1128,125 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
     return 0;
 }
 
+static void cleanup_isolation_regions(struct vhost_dev *dev)
+{
+    struct vhost_user *u = dev->opaque;
+    if (u->iso_mem_ctx.shared_mem_addr) {
+        vhost_iova_tree_delete(u->iso_mem_ctx.tree);
+        qemu_memfd_free(u->iso_mem_ctx.shared_mem_addr,
+                        u->iso_mem_ctx.size,
+                        u->iso_mem_ctx.fd);
+        memset(&u->iso_mem_ctx, 0, sizeof(IsolationModeCtx));
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
+
+    g_autofree DMAMap *buffer_regions = g_new0(DMAMap, nregions);
+    size_t buffer_reg_size = 0;
+    size_t total_vring_size = 0;
+    size_t total_mmap_size;
+    char *reg_name;
+    uint64_t first_IOVA_addr;
+    uint64_t last_IOVA_addr;
+    DMAMap *map;
+    DMAMap vring_map;
+    int r;
+
+    msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
+
+    /* In case of reset, clear old regions */
+    cleanup_isolation_regions(dev);
+
+    /* Gather information for bounce buffers to be mapped */
+    for (u_int32_t i = 0; i < nregions; i++) {
+        hwaddr size = ROUND_UP(dev->mem->regions[i].memory_size,
+                      qemu_real_host_page_size());
+        buffer_regions[i].size = size - 1;
+        buffer_regions[i].perm = IOMMU_RW;
+
+        buffer_reg_size += size;
+    }
+
+    /* Get space required for all vrings */
+    for (int i = 0; i < dev->nvqs; i++) {
+        VirtQueue *vq = virtio_get_queue(dev->vdev, dev->vq_index + i);
+        total_vring_size += vhost_svq_vring_total_size(dev->vdev, vq);
+    }
+
+    total_mmap_size = buffer_reg_size + total_vring_size;
+    u->iso_mem_ctx.size = total_mmap_size;
+
+    /* Allocate and map an anonymous file to hold the isolation region */
+    reg_name = g_strconcat("iso_mem_", dev->vdev->name, NULL);
+    u->iso_mem_ctx.shared_mem_addr = qemu_memfd_alloc(reg_name,
+                                     total_mmap_size,
+                                     F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                                     &u->iso_mem_ctx.fd, &err);
+
+    assert(u->iso_mem_ctx.fd >= 0);
+    g_free(reg_name);
+
+    if (err) {
+        error_report_err(err);
+        cleanup_isolation_regions(dev);
+        return -1;
+    }
+
+    /* vhost-iova-tree enforces non-zero lower address */
+    first_IOVA_addr = qemu_real_host_page_size();
+    last_IOVA_addr = first_IOVA_addr + total_mmap_size - 1;
+    assert(last_IOVA_addr > first_IOVA_addr);
+
+    /* Use 128-bit operation in case of large negative offset */
+    u->iso_mem_ctx.iso_iova_offset =
+        int128_sub(int128_make64((uint64_t)u->iso_mem_ctx.shared_mem_addr),
+        int128_make64(first_IOVA_addr));
+
+    /*
+     * Instantiates iova tree sized to map bounce buffers and vrings to the
+     * isolation region in host va.
+     */
+    u->iso_mem_ctx.tree =
+        vhost_iova_tree_new(first_IOVA_addr, last_IOVA_addr);
+
+    /* Map vrings into IOVA tree */
+    vring_map.perm = IOMMU_RW;
+    vring_map.size = total_vring_size - 1;
+    r = vhost_iova_tree_map_alloc(u->iso_mem_ctx.tree, &vring_map,
+                                  (hwaddr)u->iso_mem_ctx.shared_mem_addr);
+
+    if (r != IOVA_OK) {
+        cleanup_isolation_regions(dev);
+        return r;
+    }
+
+    u->iso_mem_ctx.vring_hva_addr = (void *)int128_get64(
+                                    int128_add(int128_make64(vring_map.iova),
+                                               u->iso_mem_ctx.iso_iova_offset));
+    u->iso_mem_ctx.vring_region_size = total_vring_size;
+
+    for (int i = 0; i < nregions; i++) {
+        map = &buffer_regions[i];
+        r = vhost_iova_tree_map_alloc_gpa(u->iso_mem_ctx.tree, map,
+                                          dev->mem->regions[i].guest_phys_addr);
+
+        if (r != IOVA_OK) {
+            cleanup_isolation_regions(dev);
+            return r;
+        }
+    }
+
+    return 0;
+}
+
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
@@ -2684,6 +2819,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
     g_free(u->region_rb_offset);
     u->region_rb_offset = NULL;
     u->region_rb_len = 0;
+    cleanup_isolation_regions(dev);
     g_free(u);
     dev->opaque = 0;
 

-- 
2.43.0


