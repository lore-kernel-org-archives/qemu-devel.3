Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064CBC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfE15-0003Es-0r; Thu, 02 Jul 2026 05:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1wfE13-0003EP-VB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:47:29 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stojkovicdusan555@gmail.com>)
 id 1wfE11-0002Xh-Of
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:47:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so1838203f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782985646; x=1783590446; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ylBpQ0bt/QK9zQ9BEMnv21TmNMn+xhUv/pb6/Do4RGs=;
 b=XpsTUu2JUbTRMLG7CSirenpB7ezd0mZkeN7o+oV19I68mxuhGNqqEQYzD6uY6rqf1F
 KHQXSSXc/ndO2sO+02xDQDTwM7YsAh5nvfAp71xhg3xsfOaE3FawdtUgQeorrwjZyZg2
 5VAchDjCm7MZPexiFshk8LdGkj9scmAeXg3PYORAQbEgjFk2YP/qyWvnwO8PcQ79qBh6
 o1oy8mR9R/GmCwGyqWS7DZS8uPcYq5uThFsgL7ToVPMk/pHVBhhBi3H10gK+4dmswgIk
 Z30qBiCNPCVvo1w4rTrV5g+Efdeo3WK4M0MmMD64VDEus7BMOtsALZ3ztgSyvFEvc3Ay
 9DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985646; x=1783590446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ylBpQ0bt/QK9zQ9BEMnv21TmNMn+xhUv/pb6/Do4RGs=;
 b=aADV0XQZSn/i2JQbMWl7TeS5LtWY5jpX4c+XMuuw41iqGopghKuoJx6jgSclRm73hh
 pcSZHw92kj0HKETzrcaOy6m63XVL12IWG/5cPqU3VLGBBm9ykxDiImm5tOZ6spa6WciY
 l8JQmRZ1c+IXxWDDl0oWsq8F6al+3LsUytx+G5QQmvMC4Auqv6Tn7ny9Ksp8PzLJGYQt
 8adVM87i91UfD67aOOYXJ61mq8P1zsTunHOm8TNLUITm0jQuRAjJJ1TvvaWsvo4QINAU
 lmnQpQuuClgN+SFknohDa7YdE5O97mY1Zs0+K6kljxk8g3ueKGWYyfYSKcKfJtNN4VN/
 U5ig==
X-Gm-Message-State: AOJu0Yxa+iXx5eBzmBw8IndMMX9zuWE5Cy2uLPOyij2p0voMx32lLMhJ
 snZstZTM1PKAJgstDOyHBllEStLjrpbfIHYrLDKXpLg/3FdHZCeoJtw/N9wJ2GxpwL0=
X-Gm-Gg: AfdE7cldek2z9+zjpbGaNmKgCjCv0zTsWZBstL+d/ablQPE1He3mTaRXslCGbOiApwx
 wk9qD9gJoFzR1cm53lGFMO6x/GY5EqBYcN50mgTO8I0vjkVBwGzBFbgVi0ANWef4amH8H7Xddx5
 4AKd75opWHISP9/G5qkdG7o2ysivuz5zLdAHWQDbCLfSr5VGgw7Dud+44oGjjMVEZnn9+XOAt4u
 rh5PPHbMuK06+4uoMnOAwCB+oJyp1nrHqXquWPlkqLzimuAboKt60S1W12vp5ZgjTWzPbEornTa
 rSCg5qOzYAaNxeumT7GQ50r7a6INXlF+zF1BcXAPjANu6GWs1uMFkerj7Ms/aDp8sVrzZtHEJeX
 2XzQPFe9oQDFHhaReBnTmpV00b8eCjsFmEHj/7JbEyQF3ob8tU2zfmM2u2+fLABqGjf0JigkH9z
 3kAnEM8WFi8yh+7Hdd/TY65afyNFY9Cy6AhEwGmpEV3g==
X-Received: by 2002:a05:600c:8286:b0:493:c42c:7e88 with SMTP id
 5b1f17b1804b1-493c42c8307mr52961315e9.34.1782985646320; 
 Thu, 02 Jul 2026 02:47:26 -0700 (PDT)
Received: from RTRKN1313-LIN.domain.local ([89.216.37.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a15sm7539152f8f.14.2026.07.02.02.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:47:26 -0700 (PDT)
From: Dusan Stojkovic <stojkovicdusan555@gmail.com>
Date: Thu, 02 Jul 2026 11:46:13 +0200
Subject: [PATCH RFC v3 2/2] vhost-user: implement
 VHOST_USER_PROTOCOL_F_XEN_MMAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-vhost-xen-foreign-mapping-v3-2-2b8ef913382b@rt-rk.com>
References: <20260702-vhost-xen-foreign-mapping-v3-0-2b8ef913382b@rt-rk.com>
In-Reply-To: <20260702-vhost-xen-foreign-mapping-v3-0-2b8ef913382b@rt-rk.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Viresh Kumar <viresh.kumar@linaro.org>, 
 Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>, 
 Nikola Jelic <Nikola.Jelic@rt-rk.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=stojkovicdusan555@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>

The vhost-user specification reserves protocol feature bit 17 and
documents an extended memory region description for backends that map
guest memory through Xen rather than mapping a file descriptor each
region carries two extra fields, "xen mmap flags" and "domid" (see
docs/interop/vhost-user.rst, "Memory region description").
The layout is implemented by rust-vmm's vhost and vm-memory crates
and used by Xen vhost-user device backends.

Implement the front-end side for foreign mappings:

- negotiate VHOST_USER_PROTOCOL_F_XEN_MMAP

- when negotiated, build SET_MEM_TABLE payloads from the extended
  region layout, with xen_mmap_flags = FOREIGN and
  xen_mmap_data set to the guest's domain id.

- under Xen, do not call vhost_user_get_mr_data(): guest RAM has no fd
  and its userspace_addr does not correspond to a valid mapping in the
  address space. Backends map regions through privcmd using the guest
  physical address and domid; the fd accompanying each region only
  satisfies the protocol's one-fd-per-region requirement. Pass a
  /dev/xen/privcmd fd and close it once the message has been sent.
  Tracepoints for opening and closing xen fds are added as well.

- suppress VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS under Xen:
  Postcopy is likewise refused.

The userspace_addr field is carried unchanged; Xen backends derive
mappings from guest_phys_addr and domid and do not interpret it.

Signed-off-by: Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>
Signed-off-by: Nikola Jelic <Nikola.Jelic@rt-rk.com>
---
 hw/virtio/trace-events         |   2 +
 hw/virtio/vhost-user.c         | 120 +++++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/vhost-user.h |   2 +-
 3 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 2a57edc21e..0f3c58fd78 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -30,6 +30,8 @@ vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t
 vhost_user_postcopy_listen(void) ""
 vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
 vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB offset:0x%"PRIx64
+vhost_user_open_region_fd(int index, int fd) "region:%d fd:%d"
+vhost_user_put_region_fds(int index, int fd) "region:%d fd:%d"
 vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
 vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
 vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d627351f45..932ead4eeb 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -30,6 +30,8 @@
 #include "migration/postcopy-ram.h"
 #include "trace.h"
 #include "system/ramblock.h"
+#include "system/xen.h"
+#include "hw/xen/xen.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -181,12 +183,36 @@ typedef struct VhostUserMemoryRegion {
     uint64_t mmap_offset;
 } VhostUserMemoryRegion;
 
+/*
+ * Memory region flags for VHOST_USER_PROTOCOL_F_XEN_MMAP, matching the
+ * values used by rust-vmm's vm-memory (MmapXenFlags).
+ */
+#define VHOST_USER_XEN_MMAP_FLAG_FOREIGN    0x1
+#define VHOST_USER_XEN_MMAP_FLAG_GRANT      0x2
+
+/*
+ * Extended memory region description, used when
+ * VHOST_USER_PROTOCOL_F_XEN_MMAP has been negotiated.
+ */
+typedef struct VhostUserMemoryRegionXen {
+    VhostUserMemoryRegion region;
+    uint32_t xen_mmap_flags;
+    uint32_t xen_mmap_data; /* domain id for FOREIGN/GRANT mappings */
+} VhostUserMemoryRegionXen;
+
+
 typedef struct VhostUserMemory {
     uint32_t nregions;
     uint32_t padding;
     VhostUserMemoryRegion regions[VHOST_MEMORY_BASELINE_NREGIONS];
 } VhostUserMemory;
 
+typedef struct VhostUserMemoryXen {
+    uint32_t nregions;
+    uint32_t padding;
+    VhostUserMemoryRegionXen regions[VHOST_MEMORY_BASELINE_NREGIONS];
+} VhostUserMemoryXen;
+
 typedef struct VhostUserMemRegMsg {
     uint64_t padding;
     VhostUserMemoryRegion region;
@@ -294,6 +320,7 @@ typedef union {
         struct vhost_vring_state state;
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
+        VhostUserMemoryXen memory_xen;
         VhostUserMemRegMsg mem_reg;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
@@ -594,6 +621,8 @@ static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
 static bool vhost_user_gpa_addresses(struct vhost_dev *dev)
 {
     return vhost_user_has_protocol_feature(
+        dev, VHOST_USER_PROTOCOL_F_XEN_MMAP) ||
+        vhost_user_has_protocol_feature(
         dev, VHOST_USER_PROTOCOL_F_GPA_ADDRESSES);
 }
 
@@ -612,6 +641,23 @@ static void vhost_user_fill_msg_region(struct vhost_dev *dev,
     dst->mmap_offset = mmap_offset;
 }
 
+/*
+ * With VHOST_USER_PROTOCOL_F_XEN_MMAP the region fds are opened by us
+ * rather than owned by the RAMBlocks, so they must be closed once the
+ * message carrying them has been sent (or on error).
+ */
+static void vhost_user_put_region_fds(struct vhost_dev *dev, int *fds,
+                                      size_t fd_num)
+{
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_XEN_MMAP)) {
+        return;
+    }
+    for (size_t i = 0; i < fd_num; i++) {
+        trace_vhost_user_put_region_fds(i, fds[i]);
+        close(fds[i]);
+    }
+}
+
 static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                                              struct vhost_dev *dev,
                                              VhostUserMsg *msg,
@@ -623,13 +669,41 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
     MemoryRegion *mr;
     struct vhost_memory_region *reg;
     VhostUserMemoryRegion region_buffer;
+    bool xen_mmap = vhost_user_has_protocol_feature(dev,
+            VHOST_USER_PROTOCOL_F_XEN_MMAP);
+
+    if (track_ramblocks && xen_mmap) {
+        error_report("vhost-user: postcopy is not supported under Xen");
+        return -ENOTSUP;
+    }
 
     msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
 
     for (i = 0; i < dev->mem->nregions; ++i) {
         reg = dev->mem->regions + i;
 
-        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+        if (xen_mmap) {
+            /*
+             * Under Xen the guest RAM is not mapped into our address
+             * space; the backend maps it through the Xen foreign
+             * mapping interface using the guest physical address and
+             * domain id carried in the region descriptor.  The file
+             * descriptor only satisfies the one-fd-per-region
+             * requirement of the protocol: pass /dev/xen/privcmd and
+             * close it once the message has been sent.
+             */
+            mr = NULL;
+            offset = 0;
+            fd = open("/dev/xen/privcmd", O_RDWR | O_CLOEXEC);
+            if (fd < 0) {
+                error_report("vhost-user: failed to open /dev/xen/privcmd:"
+                             " %s", strerror(errno));
+                return -errno;
+            }
+            trace_vhost_user_open_region_fd(i, fd);
+        } else {
+            mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+        }
         if (fd > 0) {
             if (track_ramblocks) {
                 assert(*fd_num < VHOST_MEMORY_BASELINE_NREGIONS);
@@ -642,10 +716,21 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                 u->region_rb[i] = mr->ram_block;
             } else if (*fd_num == VHOST_MEMORY_BASELINE_NREGIONS) {
                 error_report("Failed preparing vhost-user memory table msg");
+                if (xen_mmap) {
+                    close(fd);
+                }
                 return -ENOBUFS;
             }
             vhost_user_fill_msg_region(dev, &region_buffer, reg, offset);
-            msg->payload.memory.regions[*fd_num] = region_buffer;
+            if (xen_mmap) {
+                msg->payload.memory_xen.regions[*fd_num].region = region_buffer;
+                msg->payload.memory_xen.regions[*fd_num].xen_mmap_flags =
+                    VHOST_USER_XEN_MMAP_FLAG_FOREIGN;
+                msg->payload.memory_xen.regions[*fd_num].xen_mmap_data =
+                    xen_domid;
+            } else {
+                msg->payload.memory.regions[*fd_num] = region_buffer;
+            }
             fds[(*fd_num)++] = fd;
         } else if (track_ramblocks) {
             u->region_rb_offset[i] = 0;
@@ -663,7 +748,11 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
 
     msg->hdr.size = sizeof(msg->payload.memory.nregions);
     msg->hdr.size += sizeof(msg->payload.memory.padding);
-    msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
+    if (xen_mmap) {
+        msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegionXen);
+    } else {
+        msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
+    }
 
     return 0;
 }
@@ -1149,10 +1238,12 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         ret = vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
                                                 false);
         if (ret < 0) {
+            vhost_user_put_region_fds(dev, fds, fd_num);
             return ret;
         }
 
         ret = vhost_user_write(dev, &msg, fds, fd_num);
+        vhost_user_put_region_fds(dev, fds, fd_num);
         if (ret < 0) {
             return ret;
         }
@@ -2551,6 +2642,29 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
         }
 
+        if (!xen_enabled()) {
+            /*
+             * Xen memory mappings only make sense when QEMU itself runs
+             * as a Xen device model.
+             */
+            protocol_features &= ~(1ULL << VHOST_USER_PROTOCOL_F_XEN_MMAP);
+        } else {
+            if (!virtio_has_feature(protocol_features,
+                                    VHOST_USER_PROTOCOL_F_XEN_MMAP)) {
+                error_setg(errp, "vhost-user backend does not support "
+                           "VHOST_USER_PROTOCOL_F_XEN_MMAP, which is "
+                           "required when running under Xen");
+                return -EPROTO;
+            }
+            /*
+             * The ADD/REM_MEM_REG message path has not been adapted to
+             * the Xen region format.  Xen guests expose a single RAM
+             * region, so fall back to SET_MEM_TABLE.
+             */
+            protocol_features &=
+                ~(1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
+        }
+
         /* final set of protocol features */
         u->protocol_features = protocol_features;
         err = vhost_user_set_protocol_features(dev, u->protocol_features);
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 06c360af18..46be9cd57c 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -30,7 +30,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_STATUS = 16,
-    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
+    VHOST_USER_PROTOCOL_F_XEN_MMAP = 17,
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
     VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,

-- 
2.43.0


