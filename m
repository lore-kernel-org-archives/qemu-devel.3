Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC753C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53C8-0008Mc-9y; Fri, 11 Sep 2026 11:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53C4-0008L3-Ab; Fri, 11 Sep 2026 11:29:36 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x53C2-0007H0-IC; Fri, 11 Sep 2026 11:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhgIfeV6YyrHLCJQ66X2FlbKIIWSaFov8rVoyL8/bmechYA/9wuxx2/+s1lWzluDBpNkG6wbsTFX72pZk4wCmd1zGkn0QAwgyVWFRca+zXdOY1cV4SZzJ+f9KGbWYjNgqzqHAs50eQkEkLGqlHwGK+epkOqSezvtz4gZvuAwbVucV2nuK8PN1C0IaAA+8NROioDRl150NmHGb3BzfkU0yEX0YObuKzGGd3gQPi/tYttdDoitVPo6B0rouuR5A7ZL9K9nnuDPfhIL0x6nook5cil0TuAEMMwdh7xBhw3mx3E7+Y7TMtupsITVDASAZWUizx0fUqYcoq039A8wNcEHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IayHG9jvRxAIe2Wtqs0j9eJbTZ1Dx6bG1jWZGbo+iE=;
 b=nX6i7VDlRV6FIZI4K56BTjhV1dOyATY6UKu1cTLr9oBQT9EO9XPaYKWLSrM9tIXB1d6e7Ki8DyqIWDTC7FnOtWbGd0k8dgIMdvf1vElgLld6GcHB+Qtk3uQStKKllomMaJPjj9U4yeSfhtFtZ7DBWlqIW4YMb+iIJXidM2X4rBzElT3uokH23a1uyz8KS+TccVoeGHAPHw+Qs7Kqgaz4ZyxF5yg1/BlezC4sBMBPaHM+FnPNU3IVY0Ufw/Fx+ZJzpDjqcVCKqwWKHDVOWyQJf6JlHVBGkbtF5EAGPv7i+UU+PEmSmBOe6P0rjPq0Z1SS+ddhdeJYHUuMdIEEtZgR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IayHG9jvRxAIe2Wtqs0j9eJbTZ1Dx6bG1jWZGbo+iE=;
 b=n8gsMwcYCLDZ5xqbCxOi+T6t5XkBnOFOkAPdmToFrB2bRrKoq+fX/20B+wm2aV0ZY3LAn07awkz9GlYRQaytV8VnIgmUvTfl5GLQ5KFfPm5nLEKUFFLWUlDo/NyjiLPkPX7RIBBLGT4/ezZPOpLE9DVg1gU7IkTvuzqvcVsoZd1arUtiNSY0vGDYgM2yF39RzGsliOKkGtJaWqpKDpvq+3xuRjoF3Q0TWjM/KimkQZbV32iSjEUmt11hQSrXsjSOSn4TGmjgPN6qte62JfzLZKX0w8HQQyxCg5kBH7BrrAGUrBWT/fRwE3wX7Fpmgol8SCwgVyxW/tFO46nfEgHNNQ==
Received: from SN7PR04CA0063.namprd04.prod.outlook.com (2603:10b6:806:121::8)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:29:28 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::9) by SN7PR04CA0063.outlook.office365.com
 (2603:10b6:806:121::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:29:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:29:00 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 08:28:57 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <cohuck@redhat.com>, <sebott@redhat.com>,
 <berrange@redhat.com>, <peter.maydell@linaro.org>,
 <khushit.shah@nutanix.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <wangzhou1@hisilicon.com>, <maz@kernel.org>,
 <oliver.upton@linux.dev>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 5/5] hw/arm/virt: Add Target Implementation CPU support
Date: Fri, 11 Sep 2026 16:27:54 +0100
Message-ID: <20260911152754.706518-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911152754.706518-1-skolothumtho@nvidia.com>
References: <20260911152754.706518-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 4678dc77-2437-416f-9471-08df101977b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|7416014|18002099003|22082099003|3023799007|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: nFPHdv3zHhXQGmo7qeHD+IkM1lMmuv0qJlh+qmHNbeHTxLDIaRSqlo2u2MssEYMId2r+04AzrT5M7IS/wIrU9awA1opEBAOvIhI4tz8izYZrPYvBgsKgRKN5U0ocw65jYIs5+9519qxCn6wXM805gJCUSqjraCkF+YXQlGxMk8dWmLBLmSMp2RHBTxL5HCnqr+8uNxW20i6Y3D7MB0UdqFM8zZAv39/G+XLNDC9mUxMfzpvQShaUTJz0X+Iq3gjRJ+NDshNirpI7B8JiLLCVqCuO3sdD9CXXU9L4bC75OPbnCZ0r3Ef1a7rOp4NVrkpXBQmxP55k3NIGzcK9jHg++aCQX2GYmaQj/CMjHHuZ4xgutI9dLdksXwY0+mAA1L6XtGre5TR440KyODh1d6xvY7gco0IzTtFdT12LUvl+HBgAPo3jJqjBwpHRy9ijQw2T8Z9McDS8LUYVmTizHkwAbs/XO5aXQkFUGtIEXfbAB/lHu3yaxwWgimRb5zcvNJDa1Y4aT7/cmgBdLhT0/bg9gOUJiUondc9SKUTg8y/hZ/pQqZS0R3vYt5mWEwrX3LHvRpUE7ynxSf3+EPhhNszTsjxJDKi5QwIVxza0ZMBOpRV3zeMo+mvxgQTdoBgcYYZx67fu7m7Oewp0MwIlL0TpsMQEWZrsp7PDT9TFjnaZV4cAyduZz9cqyMWfrEebc4M7f42LL8IK9Qa+KygLYB4qGg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(7416014)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Msyu6foK9gex38CMCjzJEYXdBy6z2UEDzFh2RATSxHVf5CXELeFqVEOGPHFdQCih1ViYA+0tXWMlaD/doAtmzNHTG2Oogy8Be8JBqtvtJEbUX5PieaklbyqwWsWxQ/KC8JlDLBr/GrD6dumok+WJi1pcfO0ONKtTYY0v2hx29sqxjsvpoK4UHlZBMEVvcEvCAQOcDrYqoIrlnryJ2m69syiXAyPZ/An/0djfuP3WmSR7qbRYzViF1W/K00eG7r1179qZRWI1I5QclNDuDAVc8g8h8JySjqiyHyNMkZz9ZBPXKQ6zWk8Fuf6JgDqQUesW1EpapvDax3JhT9BwhKPwzxeZp7bbXrpnxJuEkyqG0skyzycDWydzgyvS0FY5Waa3Q5yZcf/og/k6MHsUaFsfESrBZQB7Hv7NVDnZazEqmKBmQFTNbnkNbKwye+CVLKlz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:29:27.6746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4678dc77-2437-416f-9471-08df101977b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

Add the impl-cpu property to virt machine. This will enable
user to specify the target implementation CPUs as the example
below:

...
-M impl-cpu.0.midr=1,impl-cpu.0.revidr=1,impl-cpu.0.aidr=1,\
impl-cpu.1.midr=2,impl-cpu.1.revidr=2,impl-cpu.1.aidr=2 \

Make use of helper functions to check the KVM support for target
Impl CPUs and if supported set the user specified target CPUs.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 docs/system/arm/virt.rst | 22 ++++++++++++++++++
 include/hw/arm/virt.h    |  2 ++
 hw/arm/virt.c            | 48 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 5f6dd17978..a27a5dc8b1 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -259,6 +259,28 @@ x-oem-table-id
   Set string (up to 8 bytes) to override the default value of field OEM Table ID
   in ACPI table header.
 
+impl-cpu
+  Set the list of target implementation CPUs that the guest may run on, so
+  that the guest kernel can enable the errata workarounds required by all of
+  them. This is intended for migrating a guest between hosts whose CPUs
+  differ in their ``MIDR_EL1``, ``REVIDR_EL1`` and ``AIDR_EL1`` values.
+
+  Each entry is described by its ``midr``, ``revidr`` and ``aidr`` values,
+  and all three must be given::
+
+    -machine virt,impl-cpu.0.midr=0x481fd010,impl-cpu.0.revidr=0,\
+    impl-cpu.0.aidr=0x551,impl-cpu.1.midr=0x481fd011,\
+    impl-cpu.1.revidr=0,impl-cpu.1.aidr=0x551
+
+  The list is reported to the guest through KVM vendor hypercalls, so this is
+  only available when using KVM on a host kernel that supports them.
+
+  The list must include the CPU of the host QEMU is running on. A guest that
+  is given a target list stops consulting its own ``MIDR_EL1`` when deciding
+  which errata to enable, so omitting the running host means the guest will
+  not enable the workarounds that host requires. QEMU does not currently
+  verify this.
+
 SMMU configuration
 """"""""""""""""""
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a11..1095a5d326 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -42,6 +42,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
+#include "qapi/qapi-types-misc-arm.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -211,6 +212,7 @@ struct VirtMachineState {
     MemoryRegion *secure_sysmem;
     bool pci_preserve_config;
     GPtrArray *smmuv3_devices;
+    ArmTargetImplCPUList *target_cpus_list;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e7a56e37f7..dde22830f5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -75,6 +75,7 @@
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-visit-misc-arm.h"
 #include "qobject/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
@@ -3027,6 +3028,20 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->target_cpus_list) {
+        if (!kvm_enabled()) {
+            error_report("Target Impl CPU requested, but not supported "
+                         "without KVM");
+            exit(1);
+        }
+
+        if (!kvm_arm_target_impl_cpus_supported()) {
+            error_report("Target Impl CPU requested, but not supported by KVM");
+            exit(1);
+        }
+        kvm_arm_set_target_impl_cpus(vms->target_cpus_list);
+    }
+
     create_fdt(vms);
 
     assert(possible_cpus->len == max_cpus);
@@ -3560,6 +3575,26 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
     strncpy(vms->oem_table_id, value, 8);
 }
 
+static void virt_set_target_impl_cpus(Object *obj, Visitor *v,
+                                      const char *name, void *opaque,
+                                      Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    ArmTargetImplCPUList *list = vms->target_cpus_list;
+
+    visit_type_ArmTargetImplCPUList(v, name, &vms->target_cpus_list, errp);
+
+    qapi_free_ArmTargetImplCPUList(list);
+}
+
+static void virt_get_target_impl_cpus(Object *obj, Visitor *v,
+                                      const char *name, void *opaque,
+                                      Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    visit_type_ArmTargetImplCPUList(v, name, &vms->target_cpus_list, errp);
+}
 
 bool virt_is_acpi_enabled(const VirtMachineState *vms)
 {
@@ -4348,6 +4383,19 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
 
+    object_class_property_add(oc, "impl-cpu", "ArmTargetImplCPUs",
+                              virt_get_target_impl_cpus,
+                              virt_set_target_impl_cpus,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "impl-cpu",
+                                          "Describe target implementation CPU in the format: "
+                                          "impl-cpu.0.midr=1,"
+                                          "impl-cpu.0.revidr=1,"
+                                          "impl-cpu.0.aidr=1,"
+                                          "impl-cpu.1.midr=2,"
+                                          "impl-cpu.1.revidr=2,"
+                                          "impl-cpu.1.aidr=2");
+
 }
 
 static void virt_instance_init(Object *obj)
-- 
2.43.0


