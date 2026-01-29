Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1D8D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUbB-0001rY-Jx; Thu, 29 Jan 2026 11:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUal-0000UU-MK
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:01 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaj-0006lZ-6j
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:58 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so992261f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702995; x=1770307795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=erO1JdZYmv8Pfd/7xs/k34qsisbhKkUpc7RaxG5e6+o=;
 b=uzFksaLdGSYauoNXH2ZEbwV45pyFisDW3UYXr78H05RhHLXwWtvmZRZ0VYKp4DmsWE
 U1xqcYafAUloGyHwhzHYcP8cegXEeq+GZvqi1fF7VjXESMRfF368VvsWeasJRFotchTO
 R3UYgR8gZ8WJkiTZJCIwsVAjCGhPHarSjbONvrE0Pgnz3UeUXyKl67Y3c7HVpTKEQg3F
 3bQPyfyg1XfeJtdbg1LZ5bkdyJM29vZEGHgYTQ0vl5p9RjHFjJJnHuJimz3/wJ2YRT8A
 b8R27gAKAvFSWS+pidslmsCr5EOaWFOxjnJns+Yd+Qr4jipTiQawJuQh20NOi2bzoAki
 kIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702995; x=1770307795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=erO1JdZYmv8Pfd/7xs/k34qsisbhKkUpc7RaxG5e6+o=;
 b=MhzMMDjLJ4j26LySKhTD8tKjBW+3idbJk9HJiuPoLTWJoLw1ikUjYxzSae4j0sgeXW
 ymFz3BL/7vsbeJB14VzWdvcEDGtG4Eu+XuJc2FNYW2EZolOi05X3YjXB0tQBzk/ffBvE
 TTaCgAfUEpHPq64NxA2XzH6cYx8nOYTuNC1jtp/IVBlD26s/4FBuLECz3cA4v18YAVG2
 gWl5GruasyQbSHToGXMBrdyJAK58UAnpszIvTD/PUboT5/b87y3lj/Bqgj5HOBOJ6ghN
 qBZ5armFt3YcY7Fh/Z9MrTou9iSTONgV9z4q3OkGLT1/gfxCCY84lxad9OIeCgvgSDAI
 4dXQ==
X-Gm-Message-State: AOJu0Yx/Z0QIDKsnfahZNpLM4t4G62etLOFdK1kQc5jWXWzqDm723F5W
 erRULO5Z3yuBIfchdeU+zVNX9glW92Y3KO/uxBT6QQ5ZwfP36dqH+/wfjm0o2IfODXp/Lx0wqPz
 3On9Gx04=
X-Gm-Gg: AZuq6aI3hB90d7ZFk30XzCCSGnsXN5Q81n4OQxCR+8c51cdS7l2GLZYVRUyti4omEMz
 gC12bzfquBd9RmnMNfNrwutqIOQE1Sw85SN5l4S5SZUGZ84h/3HtNA21iDFMNjTfVngrySk+eCD
 BUaO/CSZunEmugKG3YWVZjaloP521CdwMR9xeaZw60/Lr0yzBc0BKmBpuIpaEznXLW2KPiZQI2p
 ykxOukaD4SU+wIpO+Xeg6T2S59jUcZ7v82p1oJIMQvknzcXJvASAzRFQ7mzw75BcGSbUEBQvqaN
 du+dR57YJZ/1ZG0f8L/tkMNzVuh3XLYfzMIH9EWe6OIo+9g2kjC3b6WDyqnCvAFfDrJupcd44N6
 YaN3NnIufnrB0gLfqvtJ2LvjvTaJ07xAI6Vla2fmO4FTpXPwFmDxtlZDcgRJcEOwus09fycxWwK
 /wEorT+HzhhomEekSNvRuzZ2hz63YadA==
X-Received: by 2002:a05:6000:220d:b0:435:dd9e:9704 with SMTP id
 ffacd0b85a97d-435f3a62928mr188239f8f.8.1769702995051; 
 Thu, 29 Jan 2026 08:09:55 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/43] hw/arm/smmuv3-accel: Add support for ATS
Date: Thu, 29 Jan 2026 16:09:04 +0000
Message-ID: <20260129160917.1415092-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
be useful to report ATS capability to the guest so it can take advantage
of it if the device also supports ATS.

Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
registers alone, as firmware ACPI IORT tables may override them. The
user must therefore ensure the support before enabling it.

The ATS support enabled here is only relevant for vfio-pci endpoints,
as SMMUv3 accelerated mode does not support emulated endpoint devices.
QEMU’s SMMUv3 implementation still lacks support for handling ATS
translation requests, which would be required for emulated endpoints.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-31-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c    |  3 +++
 hw/arm/smmuv3.c          | 24 +++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c | 10 ++++++++--
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index df82f1e32a..a97abc1f79 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -654,6 +654,9 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 
     /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+
+    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cb619f19df..ca086ba00a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1498,13 +1498,27 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
              */
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
             break;
+        case SMMU_CMD_ATC_INV:
+        {
+            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
+
+            if (!sdev || !s->ats) {
+                trace_smmuv3_unhandled_cmd(type);
+                break;
+            }
+
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            break;
+        }
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
         case SMMU_CMD_TLBI_EL2_ASID:
         case SMMU_CMD_TLBI_EL2_VA:
         case SMMU_CMD_TLBI_EL2_VAA:
-        case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
         case SMMU_CMD_RESUME:
         case SMMU_CMD_STALL_TERM:
@@ -1931,6 +1945,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
+        if (s->ats) {
+            error_setg(errp, "ats can only be enabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2066,6 +2084,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2093,6 +2112,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
         "Disable range invalidation support (for accel=on)");
+    object_class_property_set_description(klass, "ats",
+        "Enable/disable ATS support (for accel=on). Please ensure host "
+        "platform has ATS support before enabling this");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3126aca42c..c145678185 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -346,6 +346,7 @@ typedef struct AcpiIortSMMUv3Dev {
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
     bool accel;
+    bool ats;
 } AcpiIortSMMUv3Dev;
 
 /*
@@ -401,6 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
+    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -544,6 +546,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, nb_nodes, rc_mapping_count;
     AcpiIortSMMUv3Dev *sdev;
     size_t node_size;
+    bool ats_needed = false;
     int num_smmus = 0;
     uint32_t id = 0;
     int rc_smmu_idmaps_len = 0;
@@ -579,6 +582,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         /* Calculate RMR nodes required. One per SMMUv3 with accelerated mode */
         for (i = 0; i < num_smmus; i++) {
             sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
+            if (sdev->ats) {
+                ats_needed = true;
+            }
             if (sdev->accel) {
                 nb_nodes++;
             }
@@ -678,8 +684,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, 0, 2); /* Reserved */
     /* Table 15 Memory Access Flags */
     build_append_int_noprefix(table_data, 0x3 /* CCA = CPM = DACS = 1 */, 1);
-
-    build_append_int_noprefix(table_data, 0, 4); /* ATS Attribute */
+    /* ATS Attribute */
+    build_append_int_noprefix(table_data, ats_needed, 4);
     /* MCFG pci_segment */
     build_append_int_noprefix(table_data, 0, 4); /* PCI Segment number */
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 533a2182e8..242d6429ed 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -70,6 +70,7 @@ struct SMMUv3State {
     uint64_t msi_gpa;
     Error *migration_blocker;
     bool ril;
+    bool ats;
 };
 
 typedef enum {
-- 
2.43.0


