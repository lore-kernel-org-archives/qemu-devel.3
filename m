Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E8CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAf-0008F1-Nv; Tue, 16 Jun 2026 15:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8T-0004iJ-UV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8P-00013O-5a
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:45 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so112099f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636844; x=1782241644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VDaWMEHLJlGMMFHNhVRPokbxg5QakMSEfI8x6+01vJo=;
 b=gRzkby7Raiskkdykg47Ba0BP9w7FG1keRbEvDeLZFs3cJyQFySVRE95tUtha53vSeS
 8xubBGFN0DmmBWHKK+XYl/CIoFdUAkLJoyTxlOfSfgP82VzJsEik/gO3wS1F3u6AdXy2
 4zlIUBp7PRP2r/xlR7osl494I+wVD2h8AePhz6+IiganEkIZLBF1GSSfRi/XBaRszuMJ
 5U6s7lWt9fnd91NBFL7PQpXxFFXAZbKkIDEKAmNXQoK27BXoJWMgLbY4Fu1gXx7nOeZc
 mDLHVxvUWh7S3C/EfRBtQsEZ17pkeKvSGWYUy3SJdjJGNxeuKEt3BoPcsCxos3+f9CUV
 wJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636844; x=1782241644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VDaWMEHLJlGMMFHNhVRPokbxg5QakMSEfI8x6+01vJo=;
 b=lPSGbeltksSZFTuvXGVRExogZwsXRuDyKXub/94pBLr3urIHS0rCR78bqjOpeIMLk4
 N53cPz+iVyo3MtiDeZ77adKLeVaqzJz6UOa/qiEkDJcnOBZ9SRDYGdycK18f9Hn2zMan
 G33EutEVmDabnI9Gh2TjrqT9i/H4RL23GatUNfAOOJLDSFKWzlDnz6zoeQWOpVNg3tW0
 QoToLeMv66YU9CXPlWGoYpsjiSIQrS+sBHOFTAnsKxrJ/gfexn+DGmVnh/NuM09KuJRj
 gO4OUwSZJyLBESUZr4iGjpg+Bb4TneJqJRtkf4puGMZgJhqAUtgQu/GgvJHQUB5Gzyc1
 NPNg==
X-Gm-Message-State: AOJu0YxhXL5xH6tGGA4ZptEMMEK28kyzU0q4Tgv3EZi4a8OffiwF1Wql
 dzl0NcUSZVwKk1M2mLOUwc00tOicFAnFxUjom0CE4Ws7eC99gRfnRQe6viqJXXhldRhq+/5v2Ry
 bV1QD
X-Gm-Gg: AfdE7cmtLiq04uJWZB97iNS3Ezd083X/Qrn+1Q1jXPqS0LsXVyBRGKudt9BLqabufFD
 +Q4nHIZmPM7q5TtnTivIVNH42jaRMj0OznZAXx4wZvpxyteiD4Apq2OTLsZbsnEbZXLTJeqTNiJ
 Omph+dBWkxkw5nYlM4w74DSuMMxeDym0JYEy3TIPoJNviO35beBzpR1FZsM1PlxSSH0oPiZ/g1s
 VY8s+VtttZLdjbLeZmp9/TgnzE05lLQPHeykyyjOwMeIou/IxxQsla8hWqmAVfi489gocJm53fi
 QYSxExFi0aY3NnveCoMxTYvmzMurWf/541cUNsUPtELMidElDrranZGATJbRgjcog5ImygNhVag
 FCGPkNR++SR35YKxQE88fvO7njpHaL/MER9jyBgSlIL44IhA4AiMDDrGzu1JJUy1m9q/uxxm/0T
 naYlryPW9MEc5w4V5mo+doSjDIzZtIhVGYBbULoItkli9SxdTCcHxHjRdTjPYRpgvjSSy4PDVor
 //dY+j36yAlmFs8r0ifOTYFJz7/lKFZ
X-Received: by 2002:a05:6000:1ac8:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-462699af50fmr28173f8f.12.1781636844271; 
 Tue, 16 Jun 2026 12:07:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/61] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT
Date: Tue, 16 Jun 2026 20:06:15 +0100
Message-ID: <20260616190639.3462006-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicolin Chen <nicolinc@nvidia.com>

Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
created with tegra241-cmdqv.

For each accelerated SMMUv3 instance, add a Tegra241 CMDQV device
object under the DSDT \_SB namespace, with HID "NVDA200C" and a UID
that matches the Identifier of the corresponding SMMUv3 IORT node, so
the guest OS can associate the DSDT device with the right SMMU. The
_CRS covers the CMDQV MMIO aperture plus its interrupt, and _CCA
declares I/O cache coherency.

See ACPI Specification 6.5, Section 6 (Device Configuration) for
_HID/_UID/_CCA/_CRS.

Generated DSDT entry for a CMDQV instance paired with SMMUv3 Identifier=1:
  ...
  Device (CV01)
  {
      Name (_HID, "NVDA200C")  // _HID: Hardware ID
      Name (_UID, One)  // _UID: Unique ID
      Name (_CCA, One)  // _CCA: Cache Coherency Attribute
      Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
      {
          QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
              0x0000000000000000, // Granularity
              0x000000000C080000, // Range Minimum
              0x000000000C0CFFFF, // Range Maximum
              0x0000000000000000, // Translation Offset
              0x0000000000050000, // Length
              ,, , AddressRangeMemory, TypeStatic)
          Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
          {
              0x00000094,
          }
      })
  }
  ...
Generated IORT SMMUv3 node (Identifier = 1):

  ...
  [048h 0072 001h]                        Type : 04
  [049h 0073 002h]                      Length : 0058
  [04Bh 0075 001h]                    Revision : 04
  [04Ch 0076 004h]                  Identifier : 00000001
  [050h 0080 004h]               Mapping Count : 00000001
  [054h 0084 004h]              Mapping Offset : 00000044
  ...

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260609112552.378999-29-skolothumtho@nvidia.com
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/trace-events      |  1 +
 hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 0bd718b1ab..1b16f710fe 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -9,6 +9,7 @@ omap1_lpg_led(const char *onoff) "omap1 LPG: LED is %s"
 
 # virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
+virt_acpi_dsdt_tegra241_cmdqv(int smmu_id, uint64_t base, uint32_t irq) "DSDT: add cmdqv node for (id=%d), base=0x%" PRIx64 ", irq=%d"
 
 # smmu-common.c
 smmu_add_mr(const char *name) "%s"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9d05982137..99490aa7b1 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -65,6 +65,9 @@
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 
+#include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
+
 #define ARM_SPI_BASE 32
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -1121,6 +1124,51 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
     build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
 }
 
+static void acpi_dsdt_add_tegra241_cmdqv(Aml *scope, VirtMachineState *vms)
+{
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        Object *obj = OBJECT(g_ptr_array_index(vms->smmuv3_devices, i));
+        PlatformBusDevice *pbus;
+        Aml *dev, *crs, *addr;
+        SysBusDevice *sbdev;
+        hwaddr base;
+        uint32_t id;
+        int irq;
+
+        if (smmuv3_accel_cmdqv_type(obj) != SMMUV3_CMDQV_TEGRA241) {
+            continue;
+        }
+        id = object_property_get_uint(obj, "identifier", &error_abort);
+        pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+        sbdev = SYS_BUS_DEVICE(obj);
+        base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
+        base += vms->memmap[VIRT_PLATFORM_BUS].base;
+        irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
+        irq += vms->irqmap[VIRT_PLATFORM_BUS];
+        irq += ARM_SPI_BASE;
+
+        dev = aml_device("CV%.02u", id);
+        aml_append(dev, aml_name_decl("_HID", aml_string("NVDA200C")));
+        aml_append(dev, aml_name_decl("_UID", aml_int(id)));
+        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+        crs = aml_resource_template();
+        addr = aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                AML_CACHEABLE, AML_READ_WRITE, 0x0, base,
+                                base + TEGRA241_CMDQV_IO_LEN - 0x1, 0x0,
+                                TEGRA241_CMDQV_IO_LEN);
+        aml_append(crs, addr);
+        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE,
+                                      AML_ACTIVE_HIGH, AML_EXCLUSIVE,
+                                      (uint32_t *)&irq, 1));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+
+        aml_append(scope, dev);
+
+        trace_virt_acpi_dsdt_tegra241_cmdqv(id, base, irq);
+    }
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -1185,6 +1233,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_tpm(scope, vms);
 #endif
 
+    if (!vms->legacy_smmuv3_present) {
+        acpi_dsdt_add_tegra241_cmdqv(scope, vms);
+    }
+
     aml_append(dsdt, scope);
 
     pci0_scope = aml_scope("\\_SB.PCI0");
-- 
2.43.0


