Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023A7C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBrIm-0003bQ-Kf; Tue, 28 May 2024 03:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sBrIl-0003ai-Jz
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:31:19 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sBrIj-0001e2-QK
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:31:19 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso389406b3a.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716881475; x=1717486275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqmGp1q1QLZg7tcFOz2rAYVe/1SozcmikYc8Vhl1qtE=;
 b=fS40hUgGv+c2jckRg5Ki4Zp0Hf/gbPk9Kvi5Eyg1/BXbK+/y3iVxbVINBypmp701Lb
 koDUFvwtMO5s7BPJIGQKYa+mHC/hFIgJX9SgSGR4Zm+Bt7XoxMJyn7sWxFVSyJLH4Hwu
 +L2mYOWWUcvTSJ8n2W9BqiU1s9mhFKErtIsTnq2E0603RQu8OoKl2qwRPXd+vQTuubHU
 w3uTptdpitW3aA+yu6z4Uvx9pNySNmZTPB5VFH6FYidIS9YSRrjob+xYDduTG+QMOZMJ
 0oquqSPH2VJ3WiAJsTsRjf8bw1W3Tn7/ZmFViNbcY1WM3snG3yujkxdOdieX91nF0VLO
 cDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716881475; x=1717486275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqmGp1q1QLZg7tcFOz2rAYVe/1SozcmikYc8Vhl1qtE=;
 b=VQfwdKowk0ybpaG0zsSgg21JvwOYkf08+hoS4noR38xprPUB6KacL+r/xQOqWyRbyb
 lEmGUHfrPYWtj9hVBlU0ArNQTw9mpJekToPW+2VtDmL2iR7V3l8x6fxshjP83O+atJ9R
 ax+nrezSwWRu6/FCuQqxvd7Xl7PB9tfIswwQ8sO+mhlGeL7EYxBMsaIiamc+at01vg8u
 O+bNSo2ZnBtNdROln/IzQZtFl9FCA7RR/LM974hFpZyHuwUydor9VvLWAXsmaDVhFIRg
 kU/lb7KYGGbBVa600BIRaTIkOE/JUOyWsA1apsL4habLgN9+CT42Dq4roXRycj0G3MUI
 kpyA==
X-Gm-Message-State: AOJu0YxNTUrNZegeuGHfCIJQjTkU5ttR64SpxTJOaLEz69FE2tzVGNSE
 V7W19EArgZ0S5J0cR1xedaDEwsPdYMJJ6FzXXrVyWgFaIkeQ2oHTJqdeViVzFTHoPV3zqFdbZsV
 Btfc=
X-Google-Smtp-Source: AGHT+IH6YJfvYVJlSfNqhIVKjk5TAWaDXKz+x34edxD07Hvvo9bhIL70qKCEs+7bVXas+ZoSm2A1fg==
X-Received: by 2002:a05:6a00:1d8d:b0:6ec:ef1c:4dcd with SMTP id
 d2e1a72fcca58-6f8e955aa5fmr16073812b3a.6.1716881475343; 
 Tue, 28 May 2024 00:31:15 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd4d51a2sm5881080b3a.189.2024.05.28.00.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 00:31:14 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 1/3] gpex-acpi: Support PCI link devices outside the host
 bridge
Date: Tue, 28 May 2024 13:01:01 +0530
Message-Id: <20240528073103.1075812-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
References: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Currently, PCI link devices (PNP0C0F) are always created within the
scope of the PCI root complex. However, RISC-V needs PCI link devices to
be outside the scope of the PCI host bridge to properly enable the probe
order. This matches the example given in the ACPI specification section
6.2.13.1 as well.

Enable creating link devices outside the scope of PCI root complex based
on the flag which gets set currently only for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/pci-host/gpex-acpi.c    | 29 ++++++++++++++++++++++++-----
 hw/riscv/virt-acpi-build.c |  8 +++++---
 include/hw/pci-host/gpex.h |  5 ++++-
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index f69413ea2c..cea89a3ed8 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -7,7 +7,7 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/acpi/cxl.h"
 
-static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
+static void acpi_dsdt_add_pci_route_table(Aml *scope, Aml *dev, uint32_t irq)
 {
     Aml *method, *crs;
     int i, slot_no;
@@ -45,7 +45,17 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
         aml_append(dev_gsi, aml_name_decl("_CRS", crs));
         method = aml_method("_SRS", 1, AML_NOTSERIALIZED);
         aml_append(dev_gsi, method);
-        aml_append(dev, dev_gsi);
+
+        /*
+         * Some architectures like RISC-V need PCI link devices created
+         * outside the scope of the PCI host bridge similar to the example
+         * given in the section 6.2.13.1 of ACPI spec 6.5.
+         */
+         if (scope) {
+            aml_append(scope, dev_gsi);
+        } else {
+            aml_append(dev, dev_gsi);
+        }
     }
 }
 
@@ -174,7 +184,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
             }
 
-            acpi_dsdt_add_pci_route_table(dev, cfg->irq);
+            if (cfg->flags & GPEX_FLAGS_EXT_GSI_LINK) {
+                acpi_dsdt_add_pci_route_table(scope, dev, cfg->irq);
+            } else {
+                acpi_dsdt_add_pci_route_table(NULL, dev, cfg->irq);
+            }
 
             /*
              * Resources defined for PXBs are composed of the following parts:
@@ -205,7 +219,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
     aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
 
-    acpi_dsdt_add_pci_route_table(dev, cfg->irq);
+    if (cfg->flags & GPEX_FLAGS_EXT_GSI_LINK) {
+        acpi_dsdt_add_pci_route_table(scope, dev, cfg->irq);
+    } else {
+        acpi_dsdt_add_pci_route_table(NULL, dev, cfg->irq);
+    }
 
     method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
     aml_append(method, aml_return(aml_int(cfg->ecam.base)));
@@ -282,7 +300,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     crs_range_set_free(&crs_range_set);
 }
 
-void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq)
+void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq, uint32_t flags)
 {
     bool ambig;
     Object *obj = object_resolve_path_type("", TYPE_GPEX_HOST, &ambig);
@@ -292,5 +310,6 @@ void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq)
     }
 
     GPEX_HOST(obj)->gpex_cfg.irq = irq;
+    GPEX_HOST(obj)->gpex_cfg.flags = flags;
     acpi_dsdt_add_gpex(scope, &GPEX_HOST(obj)->gpex_cfg);
 }
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0925528160..832a3acb8d 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -417,19 +417,21 @@ static void build_dsdt(GArray *table_data,
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
                              VIRTIO_IRQ, 0, VIRTIO_COUNT);
-        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ, GPEX_FLAGS_EXT_GSI_LINK);
     } else if (socket_count == 2) {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
                              VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
                              VIRTIO_COUNT);
-        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES,
+                                GPEX_FLAGS_EXT_GSI_LINK);
     } else {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
                              VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
                              VIRTIO_COUNT);
-        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2,
+                                GPEX_FLAGS_EXT_GSI_LINK);
     }
 
     aml_append(dsdt, scope);
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index dce883573b..bee17d62c5 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -47,8 +47,11 @@ struct GPEXConfig {
     MemMapEntry pio;
     int         irq;
     PCIBus      *bus;
+    uint32_t    flags;
 };
 
+#define GPEX_FLAGS_EXT_GSI_LINK BIT(0)
+
 struct GPEXHost {
     /*< private >*/
     PCIExpressHost parent_obj;
@@ -71,7 +74,7 @@ struct GPEXHost {
 int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
-void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq);
+void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq, uint32_t flags);
 
 #define PCI_HOST_PIO_BASE               "x-pio-base"
 #define PCI_HOST_PIO_SIZE               "x-pio-size"
-- 
2.40.1


