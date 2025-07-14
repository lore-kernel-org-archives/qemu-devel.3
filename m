Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BB7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIX-0003tt-QS; Mon, 14 Jul 2025 19:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHg-0007Re-15
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHe-0005ip-9P
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+wbJnSPmdnkTB07xxoDVx4fnjYZMrqWMMUZI9R+zM+Q=;
 b=RJxi3ev5oyvUWzo4rBrz+PQ8GoAtixyOeUPjzgOXxNBm6y6DaAwGEjak557HcWyLz+B12/
 Q/2ZP85uHYv/FkLJjcYYigfj1Z+HnytrytrNSqZTBfqq14mWtGJj1rUTjcnpwTJ1z09Yow
 zjvyCJlyq61c7C8wFbPLgC4hB9rfKCg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-XstMK5cgP6eC4OrUzjRmVA-1; Mon, 14 Jul 2025 19:08:28 -0400
X-MC-Unique: XstMK5cgP6eC4OrUzjRmVA-1
X-Mimecast-MFC-AGG-ID: XstMK5cgP6eC4OrUzjRmVA_1752534507
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455e9e09afeso16525205e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534507; x=1753139307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wbJnSPmdnkTB07xxoDVx4fnjYZMrqWMMUZI9R+zM+Q=;
 b=TyIBYReGke/MT8gdflMqSQEP73+YPtZTGLgWZmxK1gitu2eTx2EbthB6jBlu0LuTMc
 WmLOHpIece4Oeg+6koJchDY+quLr4Uaazx8bTrJZo32rjfaRx2UEdqSKx0N2Zix4E3nT
 48SqXE5pJPLINFXQfPO7eYsBUCB4Me975qD0oUJg4SDyzxG7pIGgjVEMuhzFFlk15Ew9
 G49jj9Wg8ex2e5t/qXmTRCW8lAtGjPYvUv3xa5zmfQ8yqBZ9dE08zkVhdA95hgXCyf/T
 gOPW+fR6pGq+Fj9h75H1BNSKZBhGxcHsmMV+HhBpMJXAq2+dc/Ax3I/Jl5D8I8FJfyxy
 7F/g==
X-Gm-Message-State: AOJu0YwVAQDY8nOT+hozs2U/CXiCID4lvwPQ3gLNM17Y10iNAVlKWZvA
 1cJJhM5LRfsg8ez4hHvHT2P3dzbIvEBm+xaMGTmxJ66T5rNyzLMAFSSVT0HyoYm7EXX+fVxAeqY
 V9y9QtV6QRBQ7Kgfi+eCarTDfGrkO40krvIq+HW4toOEJkiLs+YOz1ZMyu/yXws8wKp2cf9srok
 dyLruy90N/qyO1Ui9BsLxRwpnNcjZjlmU1Vg==
X-Gm-Gg: ASbGnct0yS3yj2Egniq87spgNq+Pr7TSiw+HFhDFjvfIwmWXzvwRLCGSSUIEOeob/GE
 soOxzW4Hp6iMEtaFBjlbCFPAE/VJ9p3jljA1KzipXJqICwUlcX7Hv8FMVOi4PjSpH+jzZmHKLzZ
 wxa/44/i/Z9RbxrAYjC+PbK0I5aLChFNjmE6Ion16MRbOOMhWz5lYkRViW0MM541t+xEG5gxCIy
 Y78o+NCm+2eGfGD9LTeDRJt0gH8qv+3YTyGPaubJ7njzhHuiL1V9klIL10GKC0ttALqITkwVJMQ
 4eZs+/Q0k4BakOk/t8YGNhzEYAH9GWsp
X-Received: by 2002:a05:600c:c117:b0:455:f187:620c with SMTP id
 5b1f17b1804b1-455f18765ccmr91903045e9.24.1752534506918; 
 Mon, 14 Jul 2025 16:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEudzg4cwByo1xfLkKDRkXzYxm1dK7Zx8TlZ/PlIWznE1A3mLlWyVvsuyZzjefPuLkHxDdjTg==
X-Received: by 2002:a05:600c:c117:b0:455:f187:620c with SMTP id
 5b1f17b1804b1-455f18765ccmr91902885e9.24.1752534506533; 
 Mon, 14 Jul 2025 16:08:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14ce6sm13745217f8f.68.2025.07.14.16.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:25 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PULL 51/97] hw/pci-host/gpex-acpi: Split host bridge OSC and DSM
 generation
Message-ID: <5ea2a84eab8fb2759eb4146219b90c0afa6f416e.1752534227.git.mst@redhat.com>
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

acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
it appends the _OSC method but in fact it also appends the _DSM method
for the host bridge. Let's split the function into two separate ones
and let them return the method Aml pointer instead. This matches the
way it is done on x86 (build_q35_osc_method). In a subsequent patch
we will replace the gpex method by the q35 implementation that will
become shared between ARM and x86.

acpi_dsdt_add_host_bridge_methods is a new top helper that generates
both the _OSC and _DSM methods.

We take the opportunity to move SUPP and CTRL in the _osc method
that use them.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-6-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/gpex-acpi.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index f34b7cf25e..80fc2bf032 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -50,14 +50,12 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
+static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
 {
-    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
-
-    /* Declare an _OSC (OS Control Handoff) method */
-    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
-    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
+    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
     method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
+    aml_append(method, aml_name_decl("SUPP", aml_int(0)));
+    aml_append(method, aml_name_decl("CTRL", aml_int(0)));
     aml_append(method,
         aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
 
@@ -103,9 +101,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
                                aml_name("CDW1")));
     aml_append(elsectx, aml_return(aml_arg(3)));
     aml_append(method, elsectx);
-    aml_append(dev, method);
+    return method;
+}
 
-    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
+static Aml *build_host_bridge_dsm(void)
+{
+    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
+    Aml *UUID, *ifctx, *ifctx1, *buf;
 
     /* PCI Firmware Specification 3.0
      * 4.6.1. _DSM for PCI Express Slot Information
@@ -124,7 +126,15 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
     byte_list[0] = 0;
     buf = aml_buffer(1, byte_list);
     aml_append(method, aml_return(buf));
-    aml_append(dev, method);
+    return method;
+}
+
+static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
+                                              bool enable_native_pcie_hotplug)
+{
+    /* Declare an _OSC (OS Control Handoff) method */
+    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
+    aml_append(dev, build_host_bridge_dsm());
 }
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
@@ -193,7 +203,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             if (is_cxl) {
                 build_cxl_osc_method(dev);
             } else {
-                acpi_dsdt_add_pci_osc(dev, true);
+                acpi_dsdt_add_host_bridge_methods(dev, true);
             }
 
             aml_append(scope, dev);
@@ -268,7 +278,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_pci_osc(dev, true);
+    acpi_dsdt_add_host_bridge_methods(dev, true);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
-- 
MST


