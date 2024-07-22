Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCA2C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgly-0005Cw-Al; Sun, 21 Jul 2024 20:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglR-0002aw-64
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglP-0005xW-DF
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WUYDk8FUt/O+FXoIUIkb4reQo415JT0gLF3CIIPrYls=;
 b=VmTpe/biTdDPcmQYRvhipjj+Eta1YD5XGg96KLs7F21vQXD7T45lzPQDaMDfsYISeVs0UM
 OT6IrOr34Zu6CQRES7WlR4eolweVhXEQvByuIR9yl1gIHz27xU4t1RiO9DnWqZYooR/oZM
 a0V7tC7SY7+1DiQt2eqKtQHiGKQ9zYo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-K80vAoScPzCy9VhLksNZLw-1; Sun, 21 Jul 2024 20:18:49 -0400
X-MC-Unique: K80vAoScPzCy9VhLksNZLw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42671a6fb9dso25239965e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607528; x=1722212328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUYDk8FUt/O+FXoIUIkb4reQo415JT0gLF3CIIPrYls=;
 b=TSLRYyiYbgkLnnHr3tGmk02m7UDwzaDUHOkFpUqU55DvtfeYv3RyNdb/4WkmIM/el/
 f6GPzH+pwejZieb9d0U4ToTV7+u26E73k5og2AryRgr9jOLTat1TzXH7xJacrcaRXSvB
 5LX1DimhfDtQ/UsarPCbJn968+gd4OAb4p5yUb/0ylMb4PaUBZIVIHLm/qrqnXgOsbBa
 X84jWrjlD1l05gssj6mdqzUDD359Zq1bV7y1Hfu5D4jLcUAn1R8w9SRa5QezTkzNO9ZH
 imV09+EEvVl/pblwvsXSAv8AP3lwONrtM110Ay3LrPsS7k2me29KjKTtoH4h3gEs9Ht2
 3Z1w==
X-Gm-Message-State: AOJu0Yxc7AoFEEZP15efFLv9FkXWS7bOeXjEmWij7ow8KV2TvfM4RxoW
 B8FAoW5A8gqhW+VIObwPGtNi6aC87hlQx3mXs5pqqD56J46kX0n+jzqkWOXtYXI3sgiFIBVYfrX
 cy+AGpi9ZEwBb8tncgFZXZB8NqhbdMrk7SDdv/SJpJ3hkx28bYYSKxRd/S6Ut5xpvaf1O8Q+9iw
 3HfwRAgFbNy8TaItzEKbMlKIqXUSjEAA==
X-Received: by 2002:a05:600c:3ba3:b0:426:5de3:2ae5 with SMTP id
 5b1f17b1804b1-427dc520291mr38634635e9.10.1721607528007; 
 Sun, 21 Jul 2024 17:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm0kI/w09KN27i6SCc7Nyn2TmcReM1GKo5eFcICdIBK5s45Gj3934GA+ivd2ww5odWpowjew==
X-Received: by 2002:a05:600c:3ba3:b0:426:5de3:2ae5 with SMTP id
 5b1f17b1804b1-427dc520291mr38634425e9.10.1721607527081; 
 Sun, 21 Jul 2024 17:18:47 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e2a1sm132413165e9.31.2024.07.21.17.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:46 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 54/63] acpi/gpex: Create PCI link devices outside PCI root
 bridge
Message-ID: <e196a89bd12e38615699271240c3ae2fa2e94194.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

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
Message-Id: <20240716144306.2432257-5-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


