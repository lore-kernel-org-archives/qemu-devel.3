Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E747E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MHs-0004Gx-Et; Wed, 30 Oct 2024 23:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHa-0003MJ-EW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:38 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MHY-0004FY-8x
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:38 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso5125115ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346934; x=1730951734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPJ56p51jUwPXu8Ez1zHmGEShlFqS/1QkrR7SYDO4z0=;
 b=TpRE63ILOd2p/uYGiEoJ4+SeN3D7MZfYdDNF2VP6/Da2p4rIxY8z+KJNIM1chF6UCP
 zV7izJSvrD9lic/Jr0kvsuubR4mcO7GGbBr6ZTwkmQS/XiEV2iyzQRkxH0y6Gkh7Fa99
 nLxYctmKjFLf1eQr4D1TylrMYCopUbijVSoLPuPYmPhKlKyqGWcn1UeWRbcEQ0ZmSPYB
 45s0gbGNYiVpvP/g1PUzC97OPH9sa2tA/qHM3OR0gQphYYNR6BSD3xNsJmgVM6PdoYI1
 waKgrRwOl6F5VeOab1oo+SmmxlhPJXwG2ZMO+Z3Vw4OTBQnpt7Wq81fZBCucWn1/lGHt
 O41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346934; x=1730951734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPJ56p51jUwPXu8Ez1zHmGEShlFqS/1QkrR7SYDO4z0=;
 b=KW2v0+gTH6oO/Buw8p72fifgVe22oO0WucGrnwVQYkxbWtnOujifiSwieeEZOTuNNb
 PGRKEbd/zKyWaHXzyBfLuQEhCP4sAuXP2zQU0Y8WIm4oG/9DcI3+Eb8TnARFzJYfs329
 FzCHv+YVK4jEIGjQ/k/ST6ICuZ2a/BYdC8/wYug2BrVN054qH0jeLejauT/YvAg0LLKa
 SaF8pD5B2pvFKQEqV5t0l3Mtf1bcquOohmbjLzPKvuyB/dB6zsA5gPk2LMhOJ1F7nPK3
 /DZPsdbKc8ZJseHNris7ZvZsiPJRN8CjLE5k+AFmgKzgaFJ6fIW6krpj18zGYtB9tC8V
 X0FQ==
X-Gm-Message-State: AOJu0Yyuy+Vmc+YRtZ3yI/GsjxsxC54cGvWDlAB7XPESF3l8FX6/kr2h
 bMp3HY0wjO3Ri9JcXFPmThJyiCZDqea9LqLqJGyY+jwMkc9/5Y6y2iS40/fY
X-Google-Smtp-Source: AGHT+IERn4gSM3YApUZHTnnZMSua0OeXITZc3TranRV20u8kC6Ga3gYPjR+IhO4iXX+OxhQ7x9vFGQ==
X-Received: by 2002:a17:902:e80f:b0:20c:9e9b:9614 with SMTP id
 d9443c01a7336-210c689bd32mr224368535ad.15.1730346934502; 
 Wed, 30 Oct 2024 20:55:34 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:34 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/50] hw/riscv: add riscv-iommu-pci reference device
Date: Thu, 31 Oct 2024 13:53:08 +1000
Message-ID: <20241031035319.731906-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tomasz Jeznach <tjeznach@rivosinc.com>

The RISC-V IOMMU can be modelled as a PCIe device following the
guidelines of the RISC-V IOMMU spec, chapter 7.1, "Integrating an IOMMU
as a PCIe device".

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241016204038.649340-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-pci.c | 202 +++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build       |   2 +-
 2 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/riscv-iommu-pci.c

diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
new file mode 100644
index 0000000000..a42242532d
--- /dev/null
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -0,0 +1,202 @@
+/*
+ * QEMU emulation of an RISC-V IOMMU
+ *
+ * Copyright (C) 2022-2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/qdev-properties.h"
+#include "hw/riscv/riscv_hart.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/host-utils.h"
+#include "qom/object.h"
+
+#include "cpu_bits.h"
+#include "riscv-iommu.h"
+#include "riscv-iommu-bits.h"
+
+/* RISC-V IOMMU PCI Device Emulation */
+#define RISCV_PCI_CLASS_SYSTEM_IOMMU     0x0806
+
+/*
+ * 4 MSIx vectors for ICVEC, one for MRIF. The spec mentions in
+ * the "Placement and data flow" section that:
+ *
+ * "The interfaces related to recording an incoming MSI in a memory-resident
+ * interrupt file (MRIF) are implementation-specific. The partitioning of
+ * responsibility between the IOMMU and the IO bridge for recording the
+ * incoming MSI in an MRIF and generating the associated notice MSI are
+ * implementation-specific."
+ *
+ * We're making a design decision to create the MSIx for MRIF in the
+ * IOMMU MSIx emulation.
+ */
+#define RISCV_IOMMU_PCI_MSIX_VECTORS 5
+
+/*
+ * 4 vectors that can be used by civ, fiv, pmiv and piv. Number of
+ * vectors is represented by 2^N, where N = number of writable bits
+ * in each cause. For 4 vectors we'll write 0b11 (3) in each reg.
+ */
+#define RISCV_IOMMU_PCI_ICVEC_VECTORS 0x3333
+
+typedef struct RISCVIOMMUStatePci {
+    PCIDevice        pci;     /* Parent PCIe device state */
+    uint16_t         vendor_id;
+    uint16_t         device_id;
+    uint8_t          revision;
+    MemoryRegion     bar0;    /* PCI BAR (including MSI-x config) */
+    RISCVIOMMUState  iommu;   /* common IOMMU state */
+} RISCVIOMMUStatePci;
+
+/* interrupt delivery callback */
+static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vector)
+{
+    RISCVIOMMUStatePci *s = container_of(iommu, RISCVIOMMUStatePci, iommu);
+
+    if (msix_enabled(&(s->pci))) {
+        msix_notify(&(s->pci), vector);
+    }
+}
+
+static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
+{
+    RISCVIOMMUStatePci *s = DO_UPCAST(RISCVIOMMUStatePci, pci, dev);
+    RISCVIOMMUState *iommu = &s->iommu;
+    uint8_t *pci_conf = dev->config;
+    Error *err = NULL;
+
+    pci_set_word(pci_conf + PCI_VENDOR_ID, s->vendor_id);
+    pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID, s->vendor_id);
+    pci_set_word(pci_conf + PCI_DEVICE_ID, s->device_id);
+    pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, s->device_id);
+    pci_set_byte(pci_conf + PCI_REVISION_ID, s->revision);
+
+    /* Set device id for trace / debug */
+    DEVICE(iommu)->id = g_strdup_printf("%02x:%02x.%01x",
+        pci_dev_bus_num(dev), PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+    qdev_realize(DEVICE(iommu), NULL, errp);
+
+    memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
+        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE));
+    memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
+
+    pcie_endpoint_cap_init(dev, 0);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
+
+    int ret = msix_init(dev, RISCV_IOMMU_PCI_MSIX_VECTORS,
+                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
+                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0, &err);
+
+    if (ret == -ENOTSUP) {
+        /*
+         * MSI-x is not supported by the platform.
+         * Driver should use timer/polling based notification handlers.
+         */
+        warn_report_err(err);
+    } else if (ret < 0) {
+        error_propagate(errp, err);
+        return;
+    } else {
+        /* Mark all ICVEC MSIx vectors as used */
+        for (int i = 0; i < RISCV_IOMMU_PCI_MSIX_VECTORS; i++) {
+            msix_vector_use(dev, i);
+        }
+
+        iommu->notify = riscv_iommu_pci_notify;
+    }
+
+    PCIBus *bus = pci_device_root_bus(dev);
+    if (!bus) {
+        error_setg(errp, "can't find PCIe root port for %02x:%02x.%x",
+            pci_bus_num(pci_get_bus(dev)), PCI_SLOT(dev->devfn),
+            PCI_FUNC(dev->devfn));
+        return;
+    }
+
+    riscv_iommu_pci_setup_iommu(iommu, bus, errp);
+}
+
+static void riscv_iommu_pci_exit(PCIDevice *pci_dev)
+{
+    pci_setup_iommu(pci_device_root_bus(pci_dev), NULL, NULL);
+}
+
+static const VMStateDescription riscv_iommu_vmstate = {
+    .name = "riscv-iommu",
+    .unmigratable = 1
+};
+
+static void riscv_iommu_pci_init(Object *obj)
+{
+    RISCVIOMMUStatePci *s = RISCV_IOMMU_PCI(obj);
+    RISCVIOMMUState *iommu = &s->iommu;
+
+    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
+    qdev_alias_all_properties(DEVICE(iommu), obj);
+
+    iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
+}
+
+static Property riscv_iommu_pci_properties[] = {
+    DEFINE_PROP_UINT16("vendor-id", RISCVIOMMUStatePci, vendor_id,
+                       PCI_VENDOR_ID_REDHAT),
+    DEFINE_PROP_UINT16("device-id", RISCVIOMMUStatePci, device_id,
+                       PCI_DEVICE_ID_REDHAT_RISCV_IOMMU),
+    DEFINE_PROP_UINT8("revision", RISCVIOMMUStatePci, revision, 0x01),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = riscv_iommu_pci_realize;
+    k->exit = riscv_iommu_pci_exit;
+    k->class_id = RISCV_PCI_CLASS_SYSTEM_IOMMU;
+    dc->desc = "RISCV-IOMMU DMA Remapping device";
+    dc->vmsd = &riscv_iommu_vmstate;
+    dc->hotpluggable = false;
+    dc->user_creatable = true;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, riscv_iommu_pci_properties);
+}
+
+static const TypeInfo riscv_iommu_pci = {
+    .name = TYPE_RISCV_IOMMU_PCI,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = riscv_iommu_pci_class_init,
+    .instance_init = riscv_iommu_pci_init,
+    .instance_size = sizeof(RISCVIOMMUStatePci),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { },
+    },
+};
+
+static void riscv_iommu_register_pci_types(void)
+{
+    type_register_static(&riscv_iommu_pci);
+}
+
+type_init(riscv_iommu_register_pci_types);
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index cbc99c6e8e..adbef8a9b2 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -10,6 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.47.0


