Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ECDC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyI8-0000wh-E3; Tue, 13 Feb 2024 14:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyI6-0000wC-6J
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:18:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyI4-0001rk-Kp
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:18:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso39253005ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707851879; x=1708456679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cY4ikSKCxmC+6uAkCnxF29PkaA1kZnfjTko29Y6DKw=;
 b=JD8uPbGbtVDFK7g4RX7OYvoZMTCl8g9O1lFN+EIfCExHleiOSMsFq2CCmO5KQPNeo6
 9ySVH9aCR4WFsjOP7kC76ayQJoZ427P0BP8xtGRaCPwHrt+euzqKDaiB8pthVF/YcYd1
 nJ5/kUTkdxALjiVc5D0pkFy9go1IHQq7JCaMIovSV2bp+ftMbg9B1l7VarOYQMlXlOMs
 NGxZyWm28Z/Y3AhfLNl6PSSpCL+Mw7t/vPV/MUJGPRVQpSH34rVpswDe1r5oesRwqTVg
 QmvX8V/1bim3wjhrK0fRwBAXMvQHO/U+98oG2fphTI0gNU+wh+5/+JiFcdMIy6FowlBa
 KKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707851879; x=1708456679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cY4ikSKCxmC+6uAkCnxF29PkaA1kZnfjTko29Y6DKw=;
 b=gnySFpaEi/1Fhi/gSC2B80SfZtpRX2PURAut0lOu5LoOQFzcV6ldea71BnhA9Bij+h
 bXK7nimFdvt8ObKvmAFvNFmTeWIDmBdIrrNZxUFUJE/csfWYfkLciR7nlaG0PZGBI/DC
 bG4QR4CPaY8lrsYR7T2lyDv9t+6HOcx0M7N86VfiFRlgmymWhpbDSspfzWr1sgBRRMBH
 YEcQ1vpLbCjwHMKxio276xHOIxkt9LHDts/VFXuhF9wNax8bIEGF81R1V0XyFrCdoxfr
 cQA9hFpIeWbuuosYc1aEl+wahT+QJAMpwSnPKxllCwv8rlqxDmro63argwLkkDiaFySS
 iW0w==
X-Gm-Message-State: AOJu0YxSiP9udO3UDMpa+II6bNAzQs6JHZGhbYjmkf71/j0BjaEmAbEP
 8RRk9EBxhLUuDWYOUCH+xS/eZbczYJDphMisOsimy+Sm6pV2VPhn5ejBljcp4WANzz9pjXYqpnK
 1
X-Google-Smtp-Source: AGHT+IEk+QOkvNBkpHOBHLtndJ4/ttaGauXQdxAWIHbUblo2pPz/8KKw1YD77/xSYra9Hl/bq9TFog==
X-Received: by 2002:a17:903:25c9:b0:1da:105d:6a88 with SMTP id
 jc9-20020a17090325c900b001da105d6a88mr366567plb.56.1707851879080; 
 Tue, 13 Feb 2024 11:17:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVmuwCM/ZWDScKMGJ4XSWw/V2n5oALQWpJhd0GPgmLA7HTgB+wYFubhhj6HtG19rIChPvTvo1jeVfoPSKcvU7VJkPgErzWiGGNw+5w1gyr1pYQij7qmf6Ha+qOHw0ogrkeyiao0++vitCJKosCrrVoeyWQJI2bI2g2RiqXW5lFJAN0URtgh29lF5rv/0nWvTmcrleEMKEwlOVzt5EId095DRWUhedqnE3WtR96eDqY2bM71+B8kZyDo5G57dCgZF3G+xFGMrZA77IxcIDFCsmalZMzLJ/opBamPKDZGJDpnCnm7bhdQOwN40j4f6ExW/E474SK7Cxr35cVQERg3GevaD3q2UoqxZj5OtHNtEgr0t/KUtIwPDxASj0Y5C5Oic8MH98yXC9VPm8Wi
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d60500b001d8f81ecea1sm2416335plp.172.2024.02.13.11.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 11:17:58 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 ajones@ventanamicro.com, alex.bennee@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/6] hw/riscv/virt.c: add virtio-iommu-pci hotplug support
Date: Tue, 13 Feb 2024 16:17:34 -0300
Message-ID: <20240213191736.733334-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213191736.733334-1-dbarboza@ventanamicro.com>
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We want to add a RISC-V 'virt' libqos machine to increase our test
coverage. Some of the tests will try to plug a virtio-iommu-pci
device into the board and do some tests with it.

Enable virtio-iommu-pci in the 'virt' machine.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b540f4d3da..54ad809b44 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,6 +53,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
+#include "hw/virtio/virtio-iommu.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia(RISCVVirtState *s)
@@ -971,6 +972,34 @@ static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
 }
 
+static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
+{
+    const char compat[] = "virtio,pci-iommu\0pci1af4,1057";
+    void *fdt = MACHINE(s)->fdt;
+    uint32_t iommu_phandle;
+    g_autofree char *iommu_node = NULL;
+    g_autofree char *pci_node = NULL;
+
+    pci_node = g_strdup_printf("/soc/pci@%lx",
+                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
+    iommu_node = g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
+                                 PCI_SLOT(bdf), PCI_FUNC(bdf));
+    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
+
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg",
+                                 1, bdf << 8, 1, 0, 1, 0,
+                                 1, 0, 1, 0);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
+                           0, iommu_phandle, 0, bdf,
+                           bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1680,7 +1709,8 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    if (device_is_dynamic_sysbus(mc, dev)) {
+    if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
@@ -1699,6 +1729,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                      SYS_BUS_DEVICE(dev));
         }
     }
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
+    }
 }
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)
-- 
2.43.0


