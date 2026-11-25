Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB50606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=D6hUI3YF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2ti-0000Uy-1N; Tue, 24 Nov 2026 21:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2t6-0000Du-Uu
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:42 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2t1-0006lf-2S
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:35 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b4d543b6b6so30047107b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795574249; x=1796179049; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vyF3/kzV3O1q7jjDD58BkdnbYUlXeLTew5EMFvL29Yc=;
 b=D6hUI3YFdRlOiF/cgUtL3YkWsWod66uox+8sBkoYfToLXDXP2i0Apuged0ylIQckWW
 wLt29wVg8RNM2nu3kwa7oT7EFwiFSlbWolBFUZb+E6ldHGcCZnmS5ScW9cZqFSZq0RO6
 2gC8l5aY8BwGqp3Djq8JPtceBNcaEMrjziNFnJMrYq+hcAhKfQ+U1dESTsIeuH4tVm4+
 0Zb+XSMynV0NeY2cxsEV9avJfyMPGxXeNkTDqtQiULvxww3Qr1ZEPT8tTrqTPm6cWrwz
 VixXw/OP+cN/ue+jOTKrQz5V/00AFInX13qtMW3aYQHPwcn65VZ940fPW/H3Rm/1Ipio
 Crlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795574249; x=1796179049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyF3/kzV3O1q7jjDD58BkdnbYUlXeLTew5EMFvL29Yc=;
 b=liYpL6loj3kx830ZZf+34w7lA78Ov3jnOjP5dPtR8vAB67rfTs9DVEeIpii89LMPd7
 inFNhST5LUwc1bUOuPqsPy9YOrshuEWcyZB4AS84I6NlftkyepfXcOCCxmoIaG8DmjHH
 xRBnpuytQd0uvonvNDKO/atE3DT0alFikRjyPONNz7llJmr1NVAKRDwX9gBsZGTOuU+R
 E0aUM9fn8YZaz1RmRH9W+FCTqPaduci0MqS5wYPZ9rr8FUafyhGdK07C5vXRtCXAjoGx
 H4MQi/qhIoIHjGseFEyXeM1kyiV0+p4r7BSS57eud340Keio0v33nAq1pcGWBt/ZZMMy
 NXlA==
X-Gm-Message-State: APuU4Z/IPKKeq7kI7ZRU5W9ucXmHODCMsWNZbKuZraq58Ju+V+4v4RNa
 HSaTRI97aeOnZkwu4ngHn1xWK81+bPJA8f7TvprpkHVntXyLBKYasU9SIApjZen46KQ=
X-Gm-Gg: AZFdTZfrPpDRLeQ6ngzKCkKFefelOKAfb0h60/HLHODppyCykcj/waogZWJsXyfWMct
 D9xykrZydx/s6vgq66KzjVoWBEiI5JkDlIomC41t2Qy+OuHIKhtUY73qiyZGFzefWy7dRnqI9nn
 DLoFgl83iKCaouMfSbU1Lkvvi18v8UhrjySghvewtT27m3/VOA6MVHh2f7qBA79Mqw7/XYih9iZ
 tCQ2SkNHPeS1vlFNezIvdNmFd9jf2ez2ClhQWnrbBZhGOQd6+n7hkeaB0QxvT/kJkVtXbmSU82d
 POQ9sn+Xc4hHmFRI/QT7YHEDUCjmnm9xynfqV4DHbAADHEm+GZqyEqF/1pYAnp/BPos1zRqaydx
 la/63Xyv6UojAcQLEgll3x/+bI9pfqq0N2EgDDLM0SytY0ImG6+xaioIefdT5BUeL7zeaOnoRpC
 tViPhZJBsq44gYdSN4hSX0IeFQIqH4/d63hmCNuN1i1EajJDa6ZzQbcuL6gzDWZ5rmuhsI1NJmT
 dLDqqB7a/akcwCkUqVnNwJsC+vwOddaZE7Wu81KNpc3QdntuNNAdxs9b3Lk1FqyrfK0IAXISYS1
 LZlZ1jncOoW1bwbj5igTslNtKPTb2vkNIH13Ev3zJbWTIhz8jF38YosTejb9hC+oZRVM5OJ2TL/
 Y78/imEsw
X-Received: by 2002:a05:690c:6f91:b0:8b0:d9ff:4f4d with SMTP id
 00721157ae682-8b520319b4fmr54093657b3.10.1795574249182; 
 Tue, 24 Nov 2026 18:37:29 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:ea8f:7897:2f4d:9891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d628sm65626717b3.8.2026.11.24.18.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 18:37:28 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 24 Nov 2026 20:37:21 -0600
Subject: [PATCH 2/8] hw/ufs: Add Spacemit K3 UFS controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-spacemit_k3-v1-2-e911d6e88542@oss.tenstorrent.com>
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
In-Reply-To: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Jeuk Kim <jeuk20.kim@samsung.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement a UFS controller for Spacemit K3 that is built on top of the
existing sysbus-ufs controller. The K3 has a standard UFS controller
with a vendor region with PHY registers overlayed at 0x1b00 within the
sysbus-ufs device's standard register region.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 MAINTAINERS              |   1 +
 hw/ufs/meson.build       |   1 +
 hw/ufs/spacemit_k3_ufs.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/spacemit_k3_ufs.h |  27 ++++++++++++
 hw/ufs/trace-events      |   4 ++
 5 files changed, 142 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a9dbb39815..89e40885a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1858,6 +1858,7 @@ Spacemit Machines
 M: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: hw/ufs/spacemit_*.c
 F: target/riscv/tcg/spacemit_csr.c
 
 Tenstorrent Machines
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
index a84627b96a..a8ba27fe16 100644
--- a/hw/ufs/meson.build
+++ b/hw/ufs/meson.build
@@ -1,3 +1,4 @@
 system_ss.add(when: 'CONFIG_UFS', if_true: files('ufs.c', 'lu.c'))
 system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs-pci.c'))
 system_ss.add(when: 'CONFIG_UFS_SYSBUS', if_true: files('ufs-sysbus.c'))
+system_ss.add(when: 'CONFIG_SPACEMIT', if_true: files('spacemit_k3_ufs.c'))
diff --git a/hw/ufs/spacemit_k3_ufs.c b/hw/ufs/spacemit_k3_ufs.c
new file mode 100644
index 0000000000..03a631e45f
--- /dev/null
+++ b/hw/ufs/spacemit_k3_ufs.c
@@ -0,0 +1,109 @@
+/*
+ * Spacemit K3 UFS Controller
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Anirudh Srinivasan
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "qemu/module.h"
+#include "hw/ufs/spacemit_k3_ufs.h"
+#include "system/memory.h"
+#include "trace.h"
+
+#define K3_UFS_VENDOR_BASE 0x1b00
+#define K3_UFS_VENDOR_SIZE 0x500
+
+#define K3_UFS_TOTAL_SIZE 0x2000
+
+#define K3_UFS_MPHY_PU_PLL_LOCK BIT(31)
+
+#define K3_UFS_MPHY_PU_CTRL 0x4
+
+static uint64_t spacemit_k3_ufs_vendor_read(void *opaque, hwaddr addr,
+                                              unsigned size)
+{
+    uint32_t ret = 0;
+
+    switch (addr) {
+    case K3_UFS_MPHY_PU_CTRL:
+        ret = K3_UFS_MPHY_PU_PLL_LOCK;
+        break;
+    }
+
+    trace_spacemit_k3_ufs_vendor_read(addr, size, ret);
+    return ret;
+}
+
+static void spacemit_k3_ufs_vendor_write(void *opaque, hwaddr addr,
+                                           uint64_t value, unsigned size)
+{
+    trace_spacemit_k3_ufs_vendor_write(addr, size, value);
+}
+
+static const MemoryRegionOps spacemit_k3_ufs_vendor_ops = {
+    .read = spacemit_k3_ufs_vendor_read,
+    .write = spacemit_k3_ufs_vendor_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+};
+
+static void spacemit_k3_ufs_realize(DeviceState *dev, Error **errp)
+{
+    SpacemitK3UFSState *s = SPACEMIT_K3_UFS(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *ufs_sbd = SYS_BUS_DEVICE(&s->ufs);
+
+    memory_region_init(&s->container, OBJECT(s), "k3.ufs",
+                       K3_UFS_VENDOR_BASE + K3_UFS_VENDOR_SIZE);
+    sysbus_init_mmio(sbd, &s->container);
+
+    sysbus_realize(ufs_sbd, errp);
+    memory_region_add_subregion(&s->container, 0,
+                                sysbus_mmio_get_region(ufs_sbd, 0));
+
+    sysbus_pass_irq(sbd, ufs_sbd);
+    s->bus = BUS(&s->ufs.ufs.bus);
+
+    memory_region_init_io(
+        &s->vendor_mem, OBJECT(s), &spacemit_k3_ufs_vendor_ops, s,
+        "k3.ufs.vendor", K3_UFS_VENDOR_SIZE);
+    memory_region_add_subregion_overlap(&s->container, K3_UFS_VENDOR_BASE,
+                                &s->vendor_mem, 1);
+}
+
+static void spacemit_k3_ufs_instance_init(Object *obj)
+{
+
+    SpacemitK3UFSState *s = SPACEMIT_K3_UFS(obj);
+
+    object_initialize_child(obj, "ufs", &s->ufs, TYPE_SYSBUS_UFS);
+}
+
+static void spacemit_k3_ufs_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = spacemit_k3_ufs_realize;
+}
+
+static const TypeInfo spacemit_k3_ufs_info = {
+    .name = TYPE_SPACEMIT_K3_UFS,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SpacemitK3UFSState),
+    .instance_init = spacemit_k3_ufs_instance_init,
+    .class_init = spacemit_k3_ufs_class_init,
+};
+
+static void spacemit_k3_ufs_register_types(void)
+{
+    type_register_static(&spacemit_k3_ufs_info);
+}
+
+type_init(spacemit_k3_ufs_register_types)
diff --git a/hw/ufs/spacemit_k3_ufs.h b/hw/ufs/spacemit_k3_ufs.h
new file mode 100644
index 0000000000..68b9c13323
--- /dev/null
+++ b/hw/ufs/spacemit_k3_ufs.h
@@ -0,0 +1,27 @@
+/*
+ * Spacemit K3 UFS Controller
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2026 Anirudh Srinivasan
+ */
+
+#ifndef HW_UFS_SPACEMIT_K3_UFS_H
+#define HW_UFS_SPACEMIT_K3_UFS_H
+
+#include "hw/core/sysbus.h"
+#include "hw/ufs/ufs-sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_SPACEMIT_K3_UFS "spacemit.k3.ufs"
+OBJECT_DECLARE_SIMPLE_TYPE(SpacemitK3UFSState, SPACEMIT_K3_UFS)
+
+struct SpacemitK3UFSState {
+    SysBusDevice parent_obj;
+    SysbusUfsState ufs;
+    MemoryRegion container;  /* Main MMIO container */
+    MemoryRegion vendor_mem; /* Vendor regs (0x1b00 onwards) */
+    BusState *bus;
+};
+
+#endif
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 17acbebd30..81bd9b517f 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -61,3 +61,7 @@ ufs_err_mcq_delete_cq_sq_not_deleted(uint8_t sqid, uint8_t cqid) "mcq sq %"PRIu8
 # HID (Host Initiated Defragmentation)
 ufs_hid_defrag_operation(uint8_t op, uint8_t state) "HID defrag operation 0x%"PRIx8", new state 0x%"PRIx8""
 ufs_hid_defrag_progress(uint32_t remaining, uint8_t progress) "HID defrag remaining %"PRIu32", progress %"PRIu8"%%"
+
+# spacemit_k3_ufs.c
+spacemit_k3_ufs_vendor_read(uint64_t offset, uint32_t size, uint64_t data) "offset 0x%" PRIx64 " size %u: data 0x%" PRIx64
+spacemit_k3_ufs_vendor_write(uint64_t offset, uint32_t size, uint64_t data) "offset 0x%" PRIx64 " size %u: data 0x%" PRIx64

-- 
2.43.0


