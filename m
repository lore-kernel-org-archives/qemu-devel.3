Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68FDC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNw7-0005EQ-PG; Sun, 05 Jul 2026 10:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNw5-0005Dz-Uh
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNw4-00019L-2q
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GWgLSgRjMvIhm/wnAk+8Q7OAoMVBC49d4pbNeVzxotc=;
 b=A4VFX0tUcbZAl5JAh2kjXLEvxje5meHUBK8Jf08ANoAg0tESHzT/M660We+kpLzcIjndJ9
 vI8Ygi6v4b8VJmTrytR6NGLUMldZEMhxGwfuT7Jf5TpbABCbDB+KdSAt7S4t2XO14klI3T
 7qgOSCptjO+C9SH6JSSCMhQcOAbg9eQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-VkDJ3WviM6Gr429wGiNDUA-1; Sun, 05 Jul 2026 10:35:01 -0400
X-MC-Unique: VkDJ3WviM6Gr429wGiNDUA-1
X-Mimecast-MFC-AGG-ID: VkDJ3WviM6Gr429wGiNDUA_1783262098
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-472bdd6f529so1206744f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262098; x=1783866898; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GWgLSgRjMvIhm/wnAk+8Q7OAoMVBC49d4pbNeVzxotc=;
 b=ZcIsoLac1uPwOj4q0cVcolmTnmWyXKK7ESrwxCy4a4RIq9V/jCtQmDcIMFbeldVgXd
 beqF7d9QE9qiI+2BOn7CMLHV1OoqNAdV0bRJLO+KjWJo3y/Q9FwGnBHmdHF0c51RKq9I
 wq5F3nLiSpKnQDQ0VP7NlzgmwsO4mbbCNpZt2d73b/mgfk/olALILJis0NtnvU4UUY9V
 2oX8CDV2Wi6zpdHpDSEDGI7OT/QEJ9v9dPqUrI0aPXaClErDZDnjFm1DpEgYEra/g8/d
 bqXd+coiqjQqQ8nEg/6cGQHFr9Z72lh6V7rUVPRL3aoJqBvJbjMOv05kyXzPZE10uR5O
 i6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262098; x=1783866898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWgLSgRjMvIhm/wnAk+8Q7OAoMVBC49d4pbNeVzxotc=;
 b=I3+oB7UEsCx2m85QltfR12bwoEQtGfq1J+rLu8OzDx8E/TkpW75lGroSyNWoxsKEV3
 16PN+P6rRk85rvXURuPUcukX8JduTbip4Xzd/WB7IfpTrQk9HhGLSPmTserN86bvpU5C
 HH77Q/bQ2guxcfmQEBG/6gntoJ7pem8EGMpzOQbckdIfEKH6N0KgPI1bUIDmfu/sXzQw
 HQLVRxjC+sbkoiN4hQpKUcmGAGBLbYt+aZDUofOkPVuKq4Flikyw0kr3gBNJ6faLmbct
 jSbDu6lsqZGbeVU1Emn825VEbrLHF/jlEEKIJuZ1bVYItu6DV9UEsCY8qKV/aOnoAvpP
 76kg==
X-Gm-Message-State: AOJu0YzuVyybKYdJ+J/SBqtPwzfHdEbl/5d8AKFX7dz3QIA0GL0OVX1M
 zH01psc0xPv0QLsah3TU8MZZyz4/s71WaVFATUzqBNrlTtoZ1keKkeT+0J7BBFGtGzKvhzL+JaG
 DBQXtF65t08KXcqpkuwWrYj98lpVzEkM1IYuylx/zDY2s0FcXaWcMFE3YKDrpdH0TIbHBfcaES4
 QrzaRFd4ap/wpuNV8DLK5xOxR+eF7Lh1vArg==
X-Gm-Gg: AfdE7cmEoyxHL3hm1KMrhMyY89jUq4/Dg38Rr1xYmkn2pdsuyFR+TlPrm/S3MnNxatw
 0tE6AaseZWoRY0Wd13ImUbT8G8wOzHDW9Q7ZeCWB/pwSIYAv+2LO2wmKKCyzDCpGnSc71W73f8O
 PNFFllhgSRuKoGR7VCghMr2A8RXw2V2cddFDmbtq/OW8ux0KulSC/AyWV5fQN5WV9HXI6cSPsSq
 8u0m9htOavHhnFLHnw+57yKL2tStK7RBgyEOx/eWzl0kGlYKM8w7uoQ4+VWTYF02nkXlWYjmCZV
 jTasw9qngBTQu5v6OUIcLapWgZI0wsVK9F5eNhfyzz4CWSLK9XFZ6KggXj49wnWAj/qNdhYWeN2
 dsqSj+OtkL9uyhbUkjnASP6YPqemlWbmp
X-Received: by 2002:a05:600c:8b67:b0:493:bc88:ddcf with SMTP id
 5b1f17b1804b1-493d11f35f7mr74037015e9.23.1783262096213; 
 Sun, 05 Jul 2026 07:34:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8b67:b0:493:bc88:ddcf with SMTP id
 5b1f17b1804b1-493d11f35f7mr74036665e9.23.1783262095661; 
 Sun, 05 Jul 2026 07:34:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm197009035e9.4.2026.07.05.07.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:34:54 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:34:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/44] hw/mem: add sp-mem device for Specific Purpose Memory
Message-ID: <e83b01083631544bec27cbb3a381420b1ac7dc38.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: fanhuang <FangSheng.Huang@amd.com>

Introduce a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
SOFT_RESERVED memory exposed to the guest with a per-device NUMA
proximity domain.

The device targets accelerator memory (HBM and similar) that the
firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
in the guest -- rather than the kernel's general allocator -- owns
the range.

Usage:

    -object memory-backend-ram,id=spm0,size=$SIZE
    -numa node,nodeid=$N
    -device sp-mem,id=dev0,memdev=spm0,node=$N[,addr=$GPA]

The device is boot-time only (no hotplug).

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-2-FangSheng.Huang@amd.com>
---
 include/hw/mem/sp-mem.h |  33 ++++++++++++
 hw/mem/sp-mem.c         | 109 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/Kconfig          |   4 ++
 hw/mem/meson.build      |   1 +
 4 files changed, 147 insertions(+)
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/mem/sp-mem.c

diff --git a/include/hw/mem/sp-mem.h b/include/hw/mem/sp-mem.h
new file mode 100644
index 0000000000..a8951b49e6
--- /dev/null
+++ b/include/hw/mem/sp-mem.h
@@ -0,0 +1,33 @@
+/*
+ * Specific Purpose Memory (SPM) device
+ *
+ * TYPE_MEMORY_DEVICE subclass for boot-time-only memory exposed to the
+ * guest as an E820 SOFT_RESERVED range with a SRAT memory-affinity entry.
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * Authors:
+ *  FangSheng Huang <FangSheng.Huang@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_SP_MEM_H
+#define QEMU_SP_MEM_H
+
+#include "hw/core/qdev.h"
+#include "qom/object.h"
+
+#define TYPE_SP_MEM "sp-mem"
+
+OBJECT_DECLARE_SIMPLE_TYPE(SpMemDevice, SP_MEM)
+
+struct SpMemDevice {
+    DeviceState parent_obj;
+
+    HostMemoryBackend *hostmem;
+    uint32_t node;
+    uint64_t addr;
+};
+
+#endif /* QEMU_SP_MEM_H */
diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
new file mode 100644
index 0000000000..d088222f54
--- /dev/null
+++ b/hw/mem/sp-mem.c
@@ -0,0 +1,109 @@
+/*
+ * Specific Purpose Memory (SPM) device
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * Authors:
+ *  FangSheng Huang <FangSheng.Huang@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev.h"
+#include "hw/mem/sp-mem.h"
+#include "hw/mem/memory-device.h"
+#include "system/hostmem.h"
+
+#define SP_MEM_MEMDEV_PROP    "memdev"
+#define SP_MEM_NODE_PROP      "node"
+#define SP_MEM_ADDR_PROP      "addr"
+
+static const Property sp_mem_properties[] = {
+    DEFINE_PROP_LINK(SP_MEM_MEMDEV_PROP, SpMemDevice, hostmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_UINT32(SP_MEM_NODE_PROP, SpMemDevice, node, 0),
+    DEFINE_PROP_UINT64(SP_MEM_ADDR_PROP, SpMemDevice, addr, 0),
+};
+
+static uint64_t sp_mem_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), SP_MEM_ADDR_PROP,
+                                    &error_abort);
+}
+
+static void sp_mem_set_addr(MemoryDeviceState *md, uint64_t addr,
+                            Error **errp)
+{
+    object_property_set_uint(OBJECT(md), SP_MEM_ADDR_PROP, addr, errp);
+}
+
+static MemoryRegion *sp_mem_get_memory_region(MemoryDeviceState *md,
+                                              Error **errp)
+{
+    SpMemDevice *spm = SP_MEM(md);
+
+    if (!spm->hostmem) {
+        error_setg(errp, "'%s' property must be set", SP_MEM_MEMDEV_PROP);
+        return NULL;
+    }
+    return host_memory_backend_get_memory(spm->hostmem);
+}
+
+static void sp_mem_realize(DeviceState *dev, Error **errp)
+{
+    SpMemDevice *spm = SP_MEM(dev);
+
+    if (!spm->hostmem) {
+        error_setg(errp, "'%s' property is required", SP_MEM_MEMDEV_PROP);
+        return;
+    }
+    if (host_memory_backend_is_mapped(spm->hostmem)) {
+        error_setg(errp, "memory backend '%s' is already in use",
+                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
+        return;
+    }
+    host_memory_backend_set_mapped(spm->hostmem, true);
+}
+
+static void sp_mem_unrealize(DeviceState *dev)
+{
+    SpMemDevice *spm = SP_MEM(dev);
+
+    host_memory_backend_set_mapped(spm->hostmem, false);
+}
+
+static void sp_mem_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
+
+    dc->desc = "SPM (Specific Purpose Memory) device";
+    dc->hotpluggable = false;
+    dc->realize = sp_mem_realize;
+    dc->unrealize = sp_mem_unrealize;
+    device_class_set_props(dc, sp_mem_properties);
+
+    mdc->get_addr            = sp_mem_get_addr;
+    mdc->set_addr            = sp_mem_set_addr;
+    mdc->get_memory_region   = sp_mem_get_memory_region;
+    mdc->get_plugged_size    = memory_device_get_region_size;
+}
+
+static const TypeInfo sp_mem_types[] = {
+    {
+        .name          = TYPE_SP_MEM,
+        .parent        = TYPE_DEVICE,
+        .class_init    = sp_mem_class_init,
+        .instance_size = sizeof(SpMemDevice),
+        .interfaces    = (InterfaceInfo[]) {
+            { TYPE_MEMORY_DEVICE },
+            { }
+        },
+    },
+};
+
+DEFINE_TYPES(sp_mem_types)
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 73c5ae8ad9..39ddb36710 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -16,3 +16,7 @@ config CXL_MEM_DEVICE
     bool
     default y if CXL
     select MEM_DEVICE
+
+config SP_MEM
+    bool
+    select MEM_DEVICE
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 8c2beeb7d4..f410d75475 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -4,6 +4,7 @@ mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
+mem_ss.add(when: 'CONFIG_SP_MEM', if_true: files('sp-mem.c'))
 stub_ss.add(files('cxl_type3_stubs.c'))
 
 stub_ss.add(files('memory-device-stubs.c'))
-- 
MST


