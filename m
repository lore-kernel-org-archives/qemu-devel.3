Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB474C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSJF-0005R9-TD; Mon, 14 Jul 2025 19:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHs-0000QL-69
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHp-0005ks-HU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e0VIeJ6HIXfBrS3uzEABVTHWPD5pN/hDcySao/2aIR4=;
 b=A6okobHJY3p1ybo+9tMjqCy0HufJtMT5PGy61ti93mAMVrle2ouMGpwa7UzF48A7qH9d6L
 UKDRZkmSapkOFfVj0aR8ixhBqYlB8PtwdyMdm9NiUnwChrf5ZG38Wc3SRUy+ENS+O0kdBV
 vZxmN0xLXlFYZGTREzQPGkNSnalN6b8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-7AIRNtFbPo2IHOYU0KK4kw-1; Mon, 14 Jul 2025 19:08:39 -0400
X-MC-Unique: 7AIRNtFbPo2IHOYU0KK4kw-1
X-Mimecast-MFC-AGG-ID: 7AIRNtFbPo2IHOYU0KK4kw_1752534518
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so18207715e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534518; x=1753139318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0VIeJ6HIXfBrS3uzEABVTHWPD5pN/hDcySao/2aIR4=;
 b=M3G+tTHJ5+j4PibR6EmAftzZpNj4QqIh6uqZefVi5gdDosqTYTtKlPXyGNSfHPSFP2
 wnubIOPstiVgDg/RdvFUjrgAkGqIFebwtNrKDpM7bIOEBLlUUnewp416f7Ce1XIBc3uf
 Wq5Uiw1CJ3dfbIICH+mYkRzG6yp2JaGE+hEq5hIq32NCl5EYW6SWGY7+5Z0aMco6+Th+
 50MJXkUBshx0UGRGUkx7OdSCDLvy/Lq+Y4i8xmYBDDwugy/cy73qnqd2bIrKg0j2y2rb
 S/CMwTg+U7G21UDDo8+EluSxOCsZRgJvJuRXCe02iXpF/E+Qg0T35BWIUqQM4QI0wL8F
 x2hA==
X-Gm-Message-State: AOJu0YxYhUtnhuR7RpLHmu/CZv4rNLdK8KotK0J10hTuYlInlf+o0KIm
 3TcsI9S+Ti8iiFiiFNtv7Wdnu2oiNmh79iAf225JrejEokPKj0xzI11VMf3NNCooF0iEopHJCwb
 azZC9sROWldk0udR9rwfhUgp+tdedAdYj67Ruz3m7V9oiwe8MSybhcmFXk6NiHaEw9x/H8P4pm2
 N+GykiR068s9FEJm6JKdf6T73YoqKq20I/ag==
X-Gm-Gg: ASbGncv17qd3FXlpfC4dKFuAsY8aEqBdnpKkxx+PdNy6H+QbQv9YaHadgHFsuIbdwcK
 6u///en3hIYh5175dqV+C4xUAaTVF2e6YaqlVoqeHcyNaM2tA6TqKcBYbDNUEV5AyfoX70KnO6R
 C5AjEvpNbt/CnERtZkrZVUwZdoibTkZGnG+zlc6+uwhVcceHsVGAiOuibT49+nNca4fe+6PWQzX
 PJ4TEe/Jxfy8PMnQPQSg9B1GNWPWfHEizBrhtX6fsNgRsA5tXeUMOdXU/6l04Bb+q1Ei62M7rIe
 1oPBk3FaoJju/kp1h7ZT6PInQNhbfqxD
X-Received: by 2002:a05:6000:2485:b0:3a4:d4e5:498a with SMTP id
 ffacd0b85a97d-3b5f2e248cdmr11445620f8f.42.1752534517667; 
 Mon, 14 Jul 2025 16:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgpvDiAX63suerVtX7QeUAmmcB8J5wQiKRDcQPO0wWuiIcsvLILFbSzEyC5bHUVKWl4OZyFA==
X-Received: by 2002:a05:6000:2485:b0:3a4:d4e5:498a with SMTP id
 ffacd0b85a97d-3b5f2e248cdmr11445605f8f.42.1752534517231; 
 Mon, 14 Jul 2025 16:08:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560538da14sm87688685e9.23.2025.07.14.16.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:36 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 55/97] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Message-ID: <1ac89b617dfd42bff96f6e6d0282951c39c285d5.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

gpex build_host_bridge_osc() and x86 originated
build_pci_host_bridge_osc_method() are mostly identical.

In GPEX, SUPP is set to CDW2 but is not further used. CTRL
is same as Local0.

So let gpex code reuse build_pci_host_bridge_osc_method()
and remove build_host_bridge_osc().

Also add an imply ACPI_PCI clause along with
PCI_EXPRESS_GENERIC_BRIDGE to compile hw/acpi/pci.c
when its dependency is resolved (ie. CONFIG_ACPI_PCI).
This is requested to link qemu-system-mips64el.

The disassembled DSDT difference is given below:

  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001A4F (6735)
+ *     Length           0x00001A35 (6709)
  *     Revision         0x02
- *     Checksum         0xBF
+ *     Checksum         0xDD
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
                 {
                     CreateDWordField (Arg3, 0x04, CDW2)
                     CreateDWordField (Arg3, 0x08, CDW3)
-                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
-                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
-                    CTRL &= 0x1F
+                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
+                    Local0 &= 0x1F
                     If ((Arg1 != One))
                     {
                         CDW1 |= 0x08
                     }

-                    If ((CDW3 != CTRL))
+                    If ((CDW3 != Local0))
                     {
                         CDW1 |= 0x10
                     }

-                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
-                    Return (Arg3)
+                    CDW3 = Local0
                 }
                 Else
                 {
                     CDW1 |= 0x04
-                    Return (Arg3)
                 }
+
+                Return (Arg3)
             }

             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-Id: <20250714080639.2525563-10-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/gpex-acpi.c | 62 ++++-------------------------------------
 hw/pci-host/Kconfig     |  1 +
 2 files changed, 6 insertions(+), 57 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 44737a8d81..952a0ace19 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/virt.h"
 #include "hw/pci/pci_bus.h"
@@ -50,61 +51,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
-{
-    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
-    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
-    aml_append(method, aml_name_decl("SUPP", aml_int(0)));
-    aml_append(method, aml_name_decl("CTRL", aml_int(0)));
-    aml_append(method,
-        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
-
-    /* PCI Firmware Specification 3.0
-     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
-     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
-     * identified by the Universal Unique IDentifier (UUID)
-     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
-     */
-    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
-    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
-    aml_append(ifctx,
-        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
-    aml_append(ifctx,
-        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
-    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
-    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
-
-    /*
-     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
-     * and PCIeHotplug depending on enable_native_pcie_hotplug
-     */
-    aml_append(ifctx, aml_and(aml_name("CTRL"),
-               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
-               aml_name("CTRL")));
-
-    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
-    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
-                              aml_name("CDW1")));
-    aml_append(ifctx, ifctx1);
-
-    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
-    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
-                              aml_name("CDW1")));
-    aml_append(ifctx, ifctx1);
-
-    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
-    aml_append(ifctx, aml_return(aml_arg(3)));
-    aml_append(method, ifctx);
-
-    elsectx = aml_else();
-    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
-                               aml_name("CDW1")));
-    aml_append(elsectx, aml_return(aml_arg(3)));
-    aml_append(method, elsectx);
-    return method;
-}
-
-static Aml *build_host_bridge_dsm(void)
+static Aml *build_pci_host_bridge_dsm_method(void)
 {
     Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
     Aml *UUID, *ifctx, *ifctx1, *buf;
@@ -133,8 +80,9 @@ static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
                                               bool enable_native_pcie_hotplug)
 {
     /* Declare an _OSC (OS Control Handoff) method */
-    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
-    aml_append(dev, build_host_bridge_dsm());
+    aml_append(dev,
+               build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
+    aml_append(dev, build_pci_host_bridge_dsm_method());
 }
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 35c0415242..9824fa188d 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -54,6 +54,7 @@ config PCI_EXPRESS_Q35
 config PCI_EXPRESS_GENERIC_BRIDGE
     bool
     select PCI_EXPRESS
+    imply ACPI_PCI
 
 config PCI_EXPRESS_XILINX
     bool
-- 
MST


