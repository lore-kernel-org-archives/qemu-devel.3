Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1299DC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjP4-0004xu-Eo; Tue, 16 Jul 2024 10:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjP2-0004qM-Gu
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:40 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjP0-00031y-IN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:40 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2caff99b1c9so1627213a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721141015; x=1721745815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KfKbby5lTjhfa6Vdk/itKY016O5bwA9FOzSxkIpTYs=;
 b=T9n6TNDwp3xYE7XboJyQ8X+rARDHC1dL1SuweI84HuhY2RWiNw7MyfGmktgvO4M3cy
 x5X2bD2zGPfQbKybAfg3P8cT7/uaQHlGOd8WTtchG5W9ft5x4YcYIbVcvMVTKe+mp/Xw
 njC8yBc0yw9493ny7ulySYY8w1Xvd0uWqpRz6UI67wguECDeAY8Tyv27Uu0AEHJM/DAp
 +KsUygaUvaOH295aGdLP8wVoKKFSBazw0LqHMVKlntIh8fx0/tJukLcjxhayGbxM2XMC
 3Bznfhl1Oj9pG6Q9flyPXh37RzMQYii/zUugfrciKK/C7WaTbStRtd5puzQXjq32R3x7
 xzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141015; x=1721745815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KfKbby5lTjhfa6Vdk/itKY016O5bwA9FOzSxkIpTYs=;
 b=K48hRu052rZIcvBJ2LaIwKvYbx0vCZQ/uhjs8CYQ1JmOX4/6/h0mWWpT7DhjK/boRs
 MW/EGmaFe/mA6v9FO1lu8e7unXJqxgsDYabg9wcPd+DlgvKFq1n9FOcRd+cZP+ey/wfz
 /jFYVXdPR7Jl0JRP6Qpob2FiQnpANqper5d9oIJyIE8CcNeP0UgwvS7qC13QPRw3CfjD
 o0Eo2Kke0V7e3iy5lMBU3ZocqyJYLNhuwuZgB3zGQowpBllDp//xL7M4MK6CKJr9lyZG
 OFBiLoIcSOSMfqSuxYNvX1YVEk51wyOK9ze+Em53klDyaLxLoKEhFq8vOzlA7txXHAp6
 u97g==
X-Gm-Message-State: AOJu0Yz9mWMbynQ42xZ9Yk85WaeaMuZTW6sBD2OqtbMH3b4/6PsL6FBC
 PP4v6aExIFKlaMuOZpfbCis8SlUoSqe+i3gjgz9mHuMpy+kK5+065nHPpxoQtUNNAkgfKw3hJU9
 uCsc=
X-Google-Smtp-Source: AGHT+IEi8ohGsBAli3I+6roxo6TS2R0wtWdlpKQ+RvgnhLTyTpZtsNfB2/eojXGNsQRvXWUcUpaIuw==
X-Received: by 2002:a17:90b:4388:b0:2c9:80fd:a111 with SMTP id
 98e67ed59e1d1-2cb36d88feamr1863873a91.18.1721141014898; 
 Tue, 16 Jul 2024 07:43:34 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caf480d61bsm6084782a91.18.2024.07.16.07.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:43:34 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 4/9] acpi/gpex: Create PCI link devices outside PCI root
 bridge
Date: Tue, 16 Jul 2024 20:13:01 +0530
Message-ID: <20240716144306.2432257-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
References: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
scope of the PCI root bridge. However, RISC-V needs these link devices
to be created outside to ensure the probing order in the OS. This
matches the example given in the ACPI specification [1] as well. Hence,
create these link devices directly under _SB instead of under the PCI
root bridge.

To keep these link device names unique for multiple PCI bridges, change
the device name from GSIx to LXXY format where XX is the PCI bus number
and Y is the INTx.

GPEX is currently used by riscv, aarch64/virt and x86/microvm machines.
So, this change will alter the DSDT for those systems.

[1] - ACPI 5.1: 6.2.13.1 Example: Using _PRT to Describe PCI IRQ Routing

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/pci-host/gpex-acpi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index f69413ea2c..391fabb8a8 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -7,7 +7,8 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/acpi/cxl.h"
 
-static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
+static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
+                                          Aml *scope, uint8_t bus_num)
 {
     Aml *method, *crs;
     int i, slot_no;
@@ -20,7 +21,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
             Aml *pkg = aml_package(4);
             aml_append(pkg, aml_int((slot_no << 16) | 0xFFFF));
             aml_append(pkg, aml_int(i));
-            aml_append(pkg, aml_name("GSI%d", gsi));
+            aml_append(pkg, aml_name("L%.02X%X", bus_num, gsi));
             aml_append(pkg, aml_int(0));
             aml_append(rt_pkg, pkg);
         }
@@ -30,7 +31,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
     /* Create GSI link device */
     for (i = 0; i < PCI_NUM_PINS; i++) {
         uint32_t irqs = irq + i;
-        Aml *dev_gsi = aml_device("GSI%d", i);
+        Aml *dev_gsi = aml_device("L%.02X%X", bus_num, i);
         aml_append(dev_gsi, aml_name_decl("_HID", aml_string("PNP0C0F")));
         aml_append(dev_gsi, aml_name_decl("_UID", aml_int(i)));
         crs = aml_resource_template();
@@ -45,7 +46,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
         aml_append(dev_gsi, aml_name_decl("_CRS", crs));
         method = aml_method("_SRS", 1, AML_NOTSERIALIZED);
         aml_append(dev_gsi, method);
-        aml_append(dev, dev_gsi);
+        aml_append(scope, dev_gsi);
     }
 }
 
@@ -174,7 +175,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
             }
 
-            acpi_dsdt_add_pci_route_table(dev, cfg->irq);
+            acpi_dsdt_add_pci_route_table(dev, cfg->irq, scope, bus_num);
 
             /*
              * Resources defined for PXBs are composed of the following parts:
@@ -205,7 +206,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
     aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
 
-    acpi_dsdt_add_pci_route_table(dev, cfg->irq);
+    acpi_dsdt_add_pci_route_table(dev, cfg->irq, scope, 0);
 
     method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
     aml_append(method, aml_return(aml_int(cfg->ecam.base)));
-- 
2.43.0


