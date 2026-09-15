Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6F6C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VbN-0007pn-0L; Tue, 15 Sep 2026 12:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbL-0007oZ-UF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:43 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbI-0003R5-Q9
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:43 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c29703cb470so633978466b.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488089; x=1790092889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Ix6Bz84rGwLrSJHlstEkxjqG1KUrjUEpiFi8wTHgT8=;
 b=lWxhlnXZYy0w2+uGKRKRTP9AWSvZUVX3CaBIcpkXsbQWYJScKZVhQN3yh2lGcZ6oQl
 DYiPwK3GzZ5PKZ1XYlNg3G+KCR++0afOYMkakZh9HIJ2/OsASo5Bck2/sCuE+ZEMVJmg
 +SYhxN8vkWwMxQ+2dPyN1YwJ970BBqY6YZMIH6gw/InCzoAt17x7fz0chsv5XEKvtQYd
 DHYQ+chmXvF7Q+ThanUxImp1dugxlMYpc+j5iGeih+LT+qY9slGfY3CMS+/Z4kGCvXrQ
 EyCDz2oBLzReQ23MaszRAOQ1Wc+ERR0VcfhJ2o+19ZF8O5yUxt7diOEDs13hX5M8Z/yt
 GUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488089; x=1790092889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Ix6Bz84rGwLrSJHlstEkxjqG1KUrjUEpiFi8wTHgT8=;
 b=Opt6Twxlc04mpIVhwmM13Yb2UIFbzDahty48efRefXoLkKJaMsFaAeQs6/Td6SbPDF
 hB6S5k8nMMYTNBWqdgNPGt+Iwfyo1pQxFQXx9VmGUddKvMa3IIfFHVXlj7RETyg8tGKe
 Xso3JHo5fQ25JVQSNlBjvFxEUfnQTYQb4tGIUSRdZxu2Au2v0X32PywXXwmcXZnv7kt+
 ql4DoKzzUo2c5UvPlxnoRRK7Fds8XpwfHWmBm0Z6LNCX3VCdaRbRs5W0bwBLpQM1WYC6
 aa1U1TuumHUnwdyKwslhdZVs6JB9iGlMa9/iBTzgcUa38BOjK3qmZGHVbUKnX1A1eCEW
 1gww==
X-Gm-Message-State: AFuF++k3VJxwaq+5DbwebeVI3g32iCoiI7/83jofpTtbks+CUYxnDvdv
 K82bfnU9Jqm/1/kUrA1TZbJMnmGAXSy+jcXXWv5Mqtw9acF6Ce/r4b6h2zPSYA==
X-Gm-Gg: AYBFou3dNxW3aEj6HsVDNlervmw/rnOpLzshQZAUddS8C2I4mmatQVPpwSYxKgM98Tv
 bSQmna0wdFa1vkDgaYjjXl/KF+74ZoqDtKGG9xQohxcopn/ABMfLpH/R7etERbf6K2eNEzWTYHL
 ojCdvNvjFK581A5+VCjU6eEBap1FyVB26+o2O7vN2/fiT1z/HHak2bKX/qxmYvNEpWU/8ZxIoY/
 2YO2MuUdCJ688vdzDNMFrEZ5FRLyZj8YLm+prqNLnS4AX411mbqwUKXyTfrZUoa5oTobHUPTHEL
 97y8GtGsg78ZfdXVY6JdAeYhNTNoTQe9WvRQXZ9YObPdbOan3eaRCL1bfd5IxmPvYvzmYHXoXJo
 /vsNrPpO48XzUaP4X4evEa7C/An7xrlLCgkyj/a7LhSI5FHl6Xi7/quL9lWRsw856NeMv4CGi/q
 4JTACrZeUj372WKta2u0pjFPgg3okMfid93xqkzVX5yb/rk4f0lrqltNE84mLPhD99kxfNwSFnn
 E8eU6mvtJ4lBDzM1MuhvY+3Yo0iakqBDBQCqACOn75s5w==
X-Received: by 2002:a17:907:3f22:b0:c29:4490:50c8 with SMTP id
 a640c23a62f3a-c29b8601f32mr1074764966b.8.1789488089244; 
 Tue, 15 Sep 2026 09:01:29 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:28 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 10/20] hw/core: Add Remote Port Memory Master object
 skeleton
Date: Tue, 15 Sep 2026 18:00:34 +0200
Message-ID: <20260915160044.345788-11-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce 'remote-port-memory-master' device skeleton.

This device exposes a MemoryRegion within QEMU that represents
resources located in the external simulator. When implemented
fully, read/write accesses to the region will be encapsulated
into Remote Port packets and transmitted to the peer.

This enables QEMU to map remote peripherals or memory into
its own address space.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-memory-master.c         | 152 ++++++++++++++++++++
 hw/core/remote-port.c                       |  19 +++
 include/hw/core/remote-port-memory-master.h |  81 +++++++++++
 include/hw/core/remote-port.h               |   4 +
 4 files changed, 256 insertions(+)
 create mode 100644 hw/core/remote-port-memory-master.c
 create mode 100644 include/hw/core/remote-port-memory-master.h

diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
new file mode 100644
index 0000000000..4b0283f9fe
--- /dev/null
+++ b/hw/core/remote-port-memory-master.c
@@ -0,0 +1,152 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU remote port memory master.
+ *
+ * Copyright (c) 2014 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+#include "qemu/log.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "trace.h"
+
+#include "hw/core/remote-port-proto.h"
+#include "hw/core/remote-port.h"
+#include "hw/core/remote-port-memory-master.h"
+
+#define REMOTE_PORT_MEMORY_MASTER_PARENT_CLASS \
+    object_class_get_parent( \
+            object_class_by_name(TYPE_REMOTE_PORT_MEMORY_MASTER))
+
+#define RP_MAX_ACCESS_SIZE 4096
+
+static MemTxResult rp_mm_read(void *opaque, hwaddr addr, uint64_t *data,
+                                 unsigned size, MemTxAttrs attrs)
+{
+    /* TBD */
+    return MEMTX_OK;
+}
+
+static MemTxResult rp_mm_write(void *opaque, hwaddr addr, uint64_t data,
+                                  unsigned size, MemTxAttrs attrs)
+{
+    /* TBD */
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps rp_ops_template = {
+    .read_with_attrs = rp_mm_read,
+    .write_with_attrs = rp_mm_write,
+    .valid.max_access_size = RP_MAX_ACCESS_SIZE,
+    .valid.unaligned = true,
+    .impl.max_access_size = RP_MAX_ACCESS_SIZE,
+    .impl.unaligned = false,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void rp_memory_master_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(dev);
+    RemotePortDevice *rpd = REMOTE_PORT_DEVICE(dev);
+    int i;
+
+    /* Sanity check max access size.  */
+    if (s->max_access_size > RP_MAX_ACCESS_SIZE) {
+        error_setg(errp, "%s: max-access-size %d too large! MAX is %d",
+                   TYPE_REMOTE_PORT_MEMORY_MASTER, s->max_access_size,
+                   RP_MAX_ACCESS_SIZE);
+        return;
+    }
+
+    if (s->max_access_size < 4) {
+        error_setg(errp, "%s: max-access-size %d too small! MIN is 4",
+                   TYPE_REMOTE_PORT_MEMORY_MASTER, s->max_access_size);
+        return;
+    }
+
+    assert(s->rp);
+
+    rp_register_dev(s->rp, rpd, s->rp_dev);
+
+    s->peer = rp_get_peer(s->rp);
+
+    /* Create a single static region if configuration says so.  */
+    if (s->map_num) {
+        /* Initialize rp_ops from template.  */
+        s->rp_ops = g_malloc(sizeof *s->rp_ops);
+        memcpy(s->rp_ops, &rp_ops_template, sizeof *s->rp_ops);
+        s->rp_ops->valid.max_access_size = s->max_access_size;
+        s->rp_ops->impl.max_access_size = s->max_access_size;
+
+        s->mmaps = g_new0(typeof(*s->mmaps), s->map_num);
+        for (i = 0; i < s->map_num; ++i) {
+            char *name = g_strdup_printf("rp-%d", i);
+
+            s->mmaps[i].offset = s->map_offset;
+            memory_region_init_io(&s->mmaps[i].iomem, OBJECT(dev), s->rp_ops,
+                                  &s->mmaps[i], name, s->map_size);
+            sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmaps[i].iomem);
+            s->mmaps[i].parent = s;
+            g_free(name);
+        }
+    }
+}
+
+static void rp_prop_allow_set_link(const Object *obj, const char *name,
+                                   Object *val, Error **errp)
+{
+}
+
+static void rp_memory_master_init(Object *obj)
+{
+    RemotePortMemoryMaster *rpms = REMOTE_PORT_MEMORY_MASTER(obj);
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&rpms->rp,
+                             rp_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("map-num", RemotePortMemoryMaster, map_num, 0),
+    DEFINE_PROP_UINT64("map-offset", RemotePortMemoryMaster, map_offset, 0),
+    DEFINE_PROP_UINT64("map-size", RemotePortMemoryMaster, map_size, 0),
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortMemoryMaster, rp_dev, 0),
+    DEFINE_PROP_BOOL("relative", RemotePortMemoryMaster, relative, false),
+    DEFINE_PROP_UINT32("max-access-size", RemotePortMemoryMaster,
+                       max_access_size, RP_MAX_ACCESS_SIZE),
+};
+
+static void rp_memory_master_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+    dc->realize = rp_memory_master_realize;
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT_MEMORY_MASTER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RemotePortMemoryMaster),
+    .instance_init = rp_memory_master_init,
+    .class_init    = rp_memory_master_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_REMOTE_PORT_DEVICE },
+        { },
+    },
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+}
+
+type_init(rp_register_types)
diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index 4425ba1b08..b4c9fa1528 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -81,6 +81,20 @@ void rp_restart_sync_timer(RemotePort *s)
     ptimer_transaction_commit(s->sync.ptimer);
 }
 
+void rp_register_dev(RemotePort *s, RemotePortDevice *dev, uint32_t chan)
+{
+    assert(chan < REMOTE_PORT_MAX_DEVS);
+
+    /* Skip if device registered via 'remote-port-dev%d' property */
+    if (s->devs[chan] == dev) {
+        return;
+    }
+
+    assert(!s->devs[chan]);
+
+    s->devs[chan] = dev;
+}
+
 static void rp_fatal_error(RemotePort *s, const char *reason)
 {
     int64_t clk = rp_normalized_vmclk(s);
@@ -721,6 +735,11 @@ static void rp_init(Object *obj)
     }
 }
 
+struct rp_peer_state *rp_get_peer(RemotePort *s)
+{
+    return &s->peer;
+}
+
 static void rp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/include/hw/core/remote-port-memory-master.h b/include/hw/core/remote-port-memory-master.h
new file mode 100644
index 0000000000..011867f366
--- /dev/null
+++ b/include/hw/core/remote-port-memory-master.h
@@ -0,0 +1,81 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU remote port memory master. Read and write transactions
+ * recieved from QEMU are transmitted over remote-port.
+ *
+ * Copyright (c) 2020 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_MEMORY_MASTER_H
+#define REMOTE_PORT_MEMORY_MASTER_H
+
+#include "hw/core/remote-port.h"
+
+#define TYPE_REMOTE_PORT_MEMORY_MASTER "remote-port-memory-master"
+#define REMOTE_PORT_MEMORY_MASTER(obj) \
+        OBJECT_CHECK(RemotePortMemoryMaster, (obj), \
+                     TYPE_REMOTE_PORT_MEMORY_MASTER)
+
+typedef struct RemotePortMemoryMaster RemotePortMemoryMaster;
+
+typedef struct RemotePortMap {
+    void *parent;
+    MemoryRegion iomem;
+    uint32_t rp_dev;
+    uint64_t offset;
+} RemotePortMap;
+
+struct RemotePortMemoryMaster {
+    /* private */
+    SysBusDevice parent;
+
+    MemoryRegionOps *rp_ops;
+    RemotePortMap *mmaps;
+
+    /* public */
+    uint32_t map_num;
+    uint64_t map_offset;
+    uint64_t map_size;
+    uint32_t rp_dev;
+    bool relative;
+    uint32_t max_access_size;
+    struct RemotePort *rp;
+    struct rp_peer_state *peer;
+    int rp_timeout;
+};
+
+typedef struct RPMemoryTransaction {
+    union {
+        /*
+         * Data is passed by values up to 64bit sizes. Beyond
+         * that, a pointer is passed in p8.
+         *
+         * Note that p8 has no alignment restrictions.
+         */
+        uint8_t *p8;
+        uint64_t u64;
+        uint32_t u32;
+        uint16_t u16;
+        uint8_t  u8;
+    } data;
+    bool rw;
+    hwaddr addr;
+    unsigned int size;
+    MemTxAttrs attr;
+    void *opaque;
+} RPMemoryTransaction;
+
+MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
+                         struct rp_peer_state *peer,
+                         RPMemoryTransaction *tr,
+                         bool relative, uint64_t offset);
+
+MemTxResult rp_mm_access_with_def_attr(RemotePort *rp, uint32_t rp_dev,
+                                       struct rp_peer_state *peer,
+                                       RPMemoryTransaction *tr,
+                                       bool relative, uint64_t offset,
+                                       uint32_t def_attr);
+#endif
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index e16661af03..cef7471a73 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -129,6 +129,8 @@ struct RemotePort {
     RemotePortDevice *devs[REMOTE_PORT_MAX_DEVS];
 };
 
+void rp_register_dev(RemotePort *s, RemotePortDevice *dev, uint32_t chan);
+
 
 void rp_rsp_mutex_lock(RemotePort *s);
 void rp_rsp_mutex_unlock(RemotePort *s);
@@ -146,4 +148,6 @@ void rp_process(RemotePort *s);
 
 ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
 
+struct rp_peer_state *rp_get_peer(RemotePort *s);
+
 #endif
-- 
2.43.0


