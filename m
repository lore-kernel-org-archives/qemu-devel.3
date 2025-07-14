Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C45C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKE-0006rH-R6; Mon, 14 Jul 2025 19:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIV-0003jB-Kj
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIS-0005qQ-Dt
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9MfyLI51ZGlhvFL7ll8x4gM+wsOFXmgTxRbWPYlHUXM=;
 b=NnDUrdkJnPCkydwt4xvlHBdSvd3oFwgR/tmR3j/7cf1vPOUW9FdgLe8Ku3QDQnQJXzzH7k
 bwbRlWRRVF0VPi5Sf6qFRbJkKtHMLSy3pa2TBVKKBlD+OlT21WC4MDEkDaWwDoRoxOpq0N
 yCsMY+K2E5Mf14vKL7OaAwbl/VPDTMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-b61yh_MIN1ehjnLrCZcVDQ-1; Mon, 14 Jul 2025 19:09:17 -0400
X-MC-Unique: b61yh_MIN1ehjnLrCZcVDQ-1
X-Mimecast-MFC-AGG-ID: b61yh_MIN1ehjnLrCZcVDQ_1752534557
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b5f97cb8fbso811743f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534556; x=1753139356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MfyLI51ZGlhvFL7ll8x4gM+wsOFXmgTxRbWPYlHUXM=;
 b=amu9yICcScVb1XHjqwid444uw8Ba2kbZIgGZX6GItn1L4Z/Jy8OR56pj/ecjw4q3Oo
 586a4HGV2V6g0Xvx89eVznVQxvmPof9qTCbvDI0U3lvrGm7MBtKxLGr+TnXBcleQu4QB
 pocFsx0AWF7N/8j5mC/+Gy8awxH6DdzbVGhX/196xcU1NHr1bCXsSH1qeJCX1j67Y301
 zdGuLyrZ4eijwZqhgOKuHDoTaZJNl8EXMNidgA/mWrCVecSR/Difc+ZbtTmjCwOWxffd
 eA5Vt2MusdmlGfesB9Zdc0u5NGz1VHg4B8FVjulQdnhw41eTX7gUY0og193O9kgs9fjK
 vw1A==
X-Gm-Message-State: AOJu0YzfViTD4jyJEYR/pRHkJT4dRP6fTj15ie3e1YrjWTWkrVQiq3Z5
 gXnBcoOIytUTIiRG4hysPv9/q/4EmL85J0Cjq5WbfrbnuveQqMlqTTA1DxZi6PMhOwR4sxyF64Q
 LqTjq3TqxNT9LE01OP99KFdf+x9jcNUQ4YEoZ7wJ35S61QkaR+EOx7p7sqGiyTap12JBQrapPEb
 gXmHzPYC1eNr5onDZpa6V+XrM+q2lpSQ3fRA==
X-Gm-Gg: ASbGncvYIlXIFiv/9zeFOWNHrDyHmpiLyvifffw3PVQda8s79jbKs8w/LO3LI9Rz+Fv
 CK51SynDtWgveZHp/OMfzG0VwIGErj4I+6dtyIlsN7hKMo2Ljb8s3pb3uNyNn1OGj61loCWdwPC
 808h5pw/lJ6tqTIBsc4eYwcGzup4moh53Qht1VfzZ97dJi1O8gDwdhja/wjJR8tB1AjufV0WTzW
 WIMccCzC5R2LfngksJrabwJf6CMwzuN9M1OZcvclkBxGMAd9lOrn5FK7PfXTquj7Ys1SiNLLyVp
 p9bRc68AOIrB/nlcCaP0cTzrio5OiwcC
X-Received: by 2002:a05:6000:42c2:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3b5f187ebeamr8569166f8f.2.1752534556218; 
 Mon, 14 Jul 2025 16:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUEGjaSD2MBq82qIyiEw6WuOil0WjACok4Kkj/HmQqiQA3O0wUmT/F++iD9VPvZPD0HZcMBg==
X-Received: by 2002:a05:6000:42c2:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3b5f187ebeamr8569145f8f.2.1752534555777; 
 Mon, 14 Jul 2025 16:09:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a62sm13380445f8f.40.2025.07.14.16.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:15 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 69/97] hw/arm/virt-acpi-build: Modify the DSDT ACPI table to
 enable ACPI PCI hotplug
Message-ID: <e48e0ababd51b8552a08bded786e0297c72a613c.1752534227.git.mst@redhat.com>
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

Modify the DSDT ACPI table to enable ACPI PCI hotplug.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-24-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/pcihp.h  |  2 ++
 include/hw/arm/virt.h    |  1 +
 hw/acpi/pcihp.c          |  1 -
 hw/arm/virt-acpi-build.c | 17 +++++++++++++++++
 hw/arm/virt.c            |  2 ++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 5506a58862..9ff548650b 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -38,6 +38,8 @@
 #define ACPI_PCIHP_SEJ_BASE 0x8
 #define ACPI_PCIHP_BNMR_BASE 0x10
 
+#define ACPI_PCIHP_SIZE 0x0018
+
 typedef struct AcpiPciHpPciStatus {
     uint32_t up;
     uint32_t down;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4375819ea0..365a28b082 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -80,6 +80,7 @@ enum {
     VIRT_ACPI_GED,
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
+    VIRT_ACPI_PCIHP,
     VIRT_LOWMEMMAP_LAST,
 };
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2db2f16940..f1594e664a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -43,7 +43,6 @@
 #include "qobject/qnum.h"
 #include "trace.h"
 
-#define ACPI_PCIHP_SIZE 0x0018
 #define PCI_UP_BASE 0x0000
 #define PCI_DOWN_BASE 0x0004
 #define PCI_EJ_BASE 0x0008
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3dc1cfcd67..b01fc4f8ef 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -969,6 +969,23 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         build_append_pcihp_slots(pci0_scope, vms->bus);
     }
 
+    if (vms->acpi_dev) {
+        bool acpi_pcihp;
+
+        acpi_pcihp = object_property_get_bool(OBJECT(vms->acpi_dev),
+                                              ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                                              NULL);
+
+        if (acpi_pcihp) {
+            build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
+                                   memmap[VIRT_ACPI_PCIHP].base);
+            build_append_pcihp_resources(pci0_scope,
+                                         memmap[VIRT_ACPI_PCIHP].base,
+                                         memmap[VIRT_ACPI_PCIHP].size);
+
+            build_append_notification_callback(pci0_scope, vms->bus);
+        }
+    }
     aml_append(dsdt, pci0_scope);
 
     /* copy AML table into ACPI tables blob */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8070ff7b11..817adedb31 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -76,6 +76,7 @@
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/pcihp.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
@@ -186,6 +187,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
+    [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
-- 
MST


