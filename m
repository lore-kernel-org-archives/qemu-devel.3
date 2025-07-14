Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24620C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKH-00078u-6s; Mon, 14 Jul 2025 19:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIP-0002to-AR
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIM-0005pR-TW
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UsGvHLuViq0eG3d8AKEXA0j+N6nfPMsx/ttHRgiNFf8=;
 b=U56b1ZlJDDtLE7J7UTb1+1MuHHhaR0uxleX9T/EvVrtCBmw0S/cE0hZ/jAbJnXn9d3atuh
 SrUgo7QrVkqMQ29RZftgccLkGv79pLGTWgUZGod+RYIzJheqjiDPH4spLRUZnqVNeRrE2U
 jqecB/jlSwPJu1kyuBI9GVdFStB0YWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-RGZn9dlgOPCNYT8CAytDBQ-1; Mon, 14 Jul 2025 19:09:12 -0400
X-MC-Unique: RGZn9dlgOPCNYT8CAytDBQ-1
X-Mimecast-MFC-AGG-ID: RGZn9dlgOPCNYT8CAytDBQ_1752534551
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so14814765e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534551; x=1753139351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsGvHLuViq0eG3d8AKEXA0j+N6nfPMsx/ttHRgiNFf8=;
 b=UQtSvXNFbMTJ1I9ONnlMCmlEZeht574+QRZLEd58SuXlqeWs7OF51ekehNsLXM111g
 m05a0nIyA2KcwxMFg+rEhWq5ld23MQnZw9OMrwcxdqTaEgPSD4vLKMuDXvLFnkg9d8z1
 td5rLJ984yq5ZvYZh/ITpXsMP5Pv3FQUwtrk3lqyDK0kacW+9fNzkIDaGr/MvgBdndhh
 rvn1itGJVCyw821zPcpcDxJmQJTSP+nBSFx9YH9QUmwYO/8qREsFH2DVuPTMw+LfZRyf
 RZ2JkTA9iym8u8d/SqCuLNfBFiQ4cuwZJdOFI4ywCZtGLNFzxc93h8Lj9f02jwa0Kv+v
 NIMw==
X-Gm-Message-State: AOJu0YxAqhXXC7KPxBoRGEIQBPIeT392e/2ULh9a8e0z30M5NFXA/+Bi
 k5HzUs9v+TPkV0IqGWeRAkTlIZcuUoLhe0J8y+tEk15dDaKfMmucRXHOK2PoV3iCRgqt1Geq8zE
 VcH9ECd7ehw1hODw9xIhPXTH4Qlg5r2vWbZPjoezjoSwIQuLpQTvaIWMtynIEjzskYFpbkUFQfw
 UfXhYuU7mSQk5aMjlFOf0W5mgpnC7aEGtorg==
X-Gm-Gg: ASbGncv55/oJfrisYoTFyYyiJbFVmQMF7sy8RwF7G1NC4r8yW7hjWh0xfIIppiQWrsq
 YIq9WaBU4LTjJ4YqtYJapliCoCo9fq+ZQ6UBsi6COZJDVtU73mvzmjZV7nb2CIX+Y/IvRNgF5Z5
 STNj0OdZZCzbSoUdgidFvCLtmDlqOwyE40CqmMyxnpL3++X7yf/JqfO9Z1WtXuXCqgFYqhF7+j7
 wQI7WoiKGaVBrDEXPucmkXbMDbeakfDNlrK4aV+zqCV+bQouozrYSwwFezpTc17dTt/ShvpIH/D
 NOH5SQD/KU1A2KkKsrTVCebgjsiOf2kw
X-Received: by 2002:a05:600c:620f:b0:456:2771:e654 with SMTP id
 5b1f17b1804b1-4562771e755mr3600445e9.24.1752534550972; 
 Mon, 14 Jul 2025 16:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGW68l2u+m2NscAhgpIkVRnoQOQSdxGgbPL86GHDJ/2260IraYJ0ERBlSzO4E801O6K+ZXqA==
X-Received: by 2002:a05:600c:620f:b0:456:2771:e654 with SMTP id
 5b1f17b1804b1-4562771e755mr3600165e9.24.1752534550514; 
 Mon, 14 Jul 2025 16:09:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456114a417csm66266125e9.25.2025.07.14.16.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 67/97] hw/arm/virt-acpi-build: Let non hotplug ports support
 static acpi-index
Message-ID: <63e48f0e334767ade8310f27f01ef73ba1145a34.1752534227.git.mst@redhat.com>
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

hw/arm/virt-acpi-build: Let non hotplug ports support static acpi-index

Add the requested ACPI bits requested to support static acpi-index
for non hotplug ports.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-22-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 12 ++++++++++++
 hw/arm/Kconfig           |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f3bad69aa7..3dc1cfcd67 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -34,6 +34,7 @@
 #include "hw/core/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/nvram/fw_cfg_acpi.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/aml-build.h"
@@ -906,6 +907,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     const int *irqmap = vms->irqmap;
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
+    Aml *pci0_scope;
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
@@ -959,6 +961,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     aml_append(dsdt, scope);
 
+    pci0_scope = aml_scope("\\_SB.PCI0");
+
+    aml_append(pci0_scope, build_pci_bridge_edsm());
+    build_append_pci_bus_devices(pci0_scope, vms->bus);
+    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
+        build_append_pcihp_slots(pci0_scope, vms->bus);
+    }
+
+    aml_append(dsdt, pci0_scope);
+
     /* copy AML table into ACPI tables blob */
     g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1634e26fcc..2aa4b5d778 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -34,6 +34,8 @@ config ARM_VIRT
     select ACPI_HW_REDUCED
     select ACPI_APEI
     select ACPI_VIOT
+    select ACPI_PCIHP
+    select ACPI_PCI_BRIDGE
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
-- 
MST


