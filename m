Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F86CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGI-0008DF-H4; Tue, 23 Jul 2024 07:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGC-0007en-R2
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGB-00031M-6H
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WUYDk8FUt/O+FXoIUIkb4reQo415JT0gLF3CIIPrYls=;
 b=YLazTbqbystr1fUWyNBKMsMcZW1ybM3WNjCTut3eGczOqLLD0AzTz94ZlNQw5LL3qQOIfe
 qIwthFIiSKfFV+iA5DERvsCBvEOpar8aMR0Tt5qubAzdBJ+bEj90q439ohZfCc+RKOZHXf
 2lOU+Qr8aVwVM40TPThwLGnhcDm6k00=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-Mh3ApXBKM5uraHrG4lmnUw-1; Tue, 23 Jul 2024 07:00:44 -0400
X-MC-Unique: Mh3ApXBKM5uraHrG4lmnUw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3687a1a6846so3053149f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732442; x=1722337242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUYDk8FUt/O+FXoIUIkb4reQo415JT0gLF3CIIPrYls=;
 b=dR6fZ4gRLNSby4JwiPQxklRRo6EryaSY1Yk/IvHbBu/MXNl3MizKqdECZPxa3Fplqg
 tz1BmW3Dh41v6bDZKeRVRW2vCvZMzHf3nSh5u5uRxi8UoLzWHlQl1X2WCubuy7IVEQul
 RdDd2bR/7G8xwbH2v6OBf8d82LUdC8jci4u/JZ8jKtfLu5T2k4bqFIBSWHLkDMCUe2dH
 xxjUpXgiCm/0c76OnY/JyMaVLU18VhAyfPUhSPN28gHpDlzHxjxZ4/0icvGUYGarTaSX
 rJ+ZI3vtffdXfaCc0yVcSKjBHiUzazIBnosrX9oBc4AnBL0DiTeX0+/7Bd3E6MJvjcC/
 1xgQ==
X-Gm-Message-State: AOJu0YzAmfgFPRBFGxOdX+Nr4GPulGfqlJ8SjVTblqri8bXjdAMenaS4
 38WB5mVcm6XUUEaVaHhnwAMcZVk8MzxXNBLJIVzdTnWNko2UcbraZTIS3jdNYS1nFmbIT++7F9R
 bQAFbrqdDsgzBryFkWCGmy0iy37jlacRkzFEXmqXml/1n19bV2ZSiqAxyUdNrO2gxfIHxNZvZiu
 CBQOYtye9oH9HjA3PXfi1AD4vgefhYog==
X-Received: by 2002:a05:6000:c11:b0:366:eade:bfbb with SMTP id
 ffacd0b85a97d-369dee4fae5mr1826395f8f.46.1721732442125; 
 Tue, 23 Jul 2024 04:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsebRkAOtJJeyWouMvgJv5+KTf0JwYM9JvFkYSDQYUHvQtmHi4i9YjQUs2EA0vybefzC98NQ==
X-Received: by 2002:a05:6000:c11:b0:366:eade:bfbb with SMTP id
 ffacd0b85a97d-369dee4fae5mr1826352f8f.46.1721732441416; 
 Tue, 23 Jul 2024 04:00:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced56sm11179803f8f.80.2024.07.23.04.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:40 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 53/61] acpi/gpex: Create PCI link devices outside PCI root
 bridge
Message-ID: <35520bc702a8c3d7b434305ac403de437003d4bc.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


