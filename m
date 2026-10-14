Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF66CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGreb-0008TX-W3; Wed, 14 Oct 2026 01:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGrea-0008TP-7v
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:35:52 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xGreY-000338-D8
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:35:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux03Uhc5xcRHITkvFolyQ2DBqszGeJz+U7fqD/xjfej3rXbu84MJ5rGnzJebMPPgD1jG3+E4Os11zDYFmPckwVCsvAbfvgu1njgIHY7M8rnzrUWSrH/7hUhr71VCc9dNnWM0aAk9M4fiGFjX4UZYmr+9BqWztL8l17DBQBwAVIWpLn8us4JqpVTBaQilxgijVza89SbaT4XGbuaU0s4dILUkaA62XmjP/bdeOm6kjuHZyAFNw/u8t5T9gHikJPGAVNBa3WlTsOR04GkI4xuDOUKdzTv04JcTIN18uGlXmWUam+xycrY+dIx46T9QHLOXZsBlXW7jh0DbJx5g0L5Lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9rj4hNtlJPIDtJHl6MIiQq6/9r+mk0Fq8y6LGwixnw=;
 b=tvqLJPH6uGvnWA59UkdoSSuKsDf/ZeaftwQ6GBw0yHluN7axbblNNU3uo/pJvmJjP32AwKoQKOxpvq7P453UcHFjS4dcP2XVqvI6kWPw9A9mNbhOq9FkqehgoyvAWlBieoUR+s1DzGXMDDcXjM9G7+IQUfiSYiSLcyXKpiD+/kv9roHQGnpPhL9DfcMdZyUpoV/nX4P8fNoimnURK85hKt+HHX5UoZGlpLiWWRQxamzIy9F6zExOteTJzVX8yMlUqU68VYRFdHZusxWjD7jst7frC5VkFEYNjaALLnkf1FC/xeuv6azwULmg26RH1JZvAH5PcaXQ6fuhaf/s5i/y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9rj4hNtlJPIDtJHl6MIiQq6/9r+mk0Fq8y6LGwixnw=;
 b=yprYCar8ow37x1qRVa3pgvJaCs1j2OlyfCIh6anJWEEWm5aC4Lxg+xnyyjVEiRwSFB9fkx3AnWTYvH2tZvqGdqnDzfMA5k2gds0ZJLAfNUW5/gqzU6BkZxWGwCcM1vG3lvNqRD3DBo0r6S1O/y+V9zfgh+OCWnLvT2Xi7eA1mBM=
Received: from MW4PR04CA0070.namprd04.prod.outlook.com (2603:10b6:303:6b::15)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 05:35:43 +0000
Received: from MW2PEPF00014677.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::16) by MW4PR04CA0070.outlook.office365.com
 (2603:10b6:303:6b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 05:35:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014677.mail.protection.outlook.com (10.167.249.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:35:42 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:35:30 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Jason Wang <jasowangio@gmail.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
 <sarunkod@amd.com>, Yi Liu <yi.l.liu@intel.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/8] x86-iommu: Introduce x86_iommu_device_get() for x86-iommu
 retrieval
Date: Wed, 14 Oct 2026 11:04:27 +0530
Message-ID: <20261014053433.24564-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014053433.24564-1-sarunkod@amd.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014677:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 84768c9b-ac6a-4232-3e76-08df29b4fd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|11063799006|56012099006|261009223027099003|921020|10067099003|22082099003|18002099003|20046099003;
X-Microsoft-Antispam-Message-Info: HtZDFvO3P53Ar0MedV2d0iVAPY/zDwC9GYG13yaJHG6Qi7KIgh40ZNsrcIE53rxwwqzD5BpCzzjtbIHxRAFetSKNew3GmdrEWtRnIfbP5U/128bE6WKDadhGA/UPdWc4WSlp1IpcL5Mwwfu7zV0L453w7HfgegVxaQcUhM9NwtFnC1R/hdixz4IQr1ldrFqko/BdmJcglQz00HUUW61mX+mmaI9Q5nEL+BnPFHXQ2Q0J7b0a+goss2hLS1BMxMkNKbIxaEY4+t2MbNe5LYZ8ZvNLttIHYTFSUuR9+96MgztUHeY1Z+Z7T9wMTBr3DMp0nzuxeBdLBLaT45puk1cVEsIOcoHH0XCQWhr5Cja3abHcgz1Qn3TBMQZ/jQbwYQlNnmiCI3QZxVMUI6OusmCNY66hbG1Jaox7n/sQN3Cv4t1lZgJDhAeTMIxeSraE7KIEe8sViBfe7hX18DPWATHHk4wrHjjGjrjT5TNkCtGTynJc9193FG5AvMt3VYoD3slyzBP/T0Tle653k9ITcq3PlFsktC3O1DloP61oDNtczY4CXn9Ds81ObH3JnqyrEVsDcRtpnf/Qnz5K8/fYaUVxVvdPykKa8gol1ttXVPgIF55W5VhHcNEaDgxwCxrPAIXeleb1uMfUCzAJx/+xHzxJ0a10Mz+cSdzd+7eQkcBYz7SFfSz0hf30ZIn20F2qpLnRpsH+xkoPIj9zOGgwGzYd+rvlDFzNekoUVYoBNZ4b5TJZSDKbMMCGMovMHHWG2edl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(11063799006)(56012099006)(261009223027099003)(921020)(10067099003)(22082099003)(18002099003)(20046099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dxGXmICQ5Yt3spCGUH0a/Moy1G5dIONsBMaWcDynLaWwAWhWro6QFHlS1MuBGA/oZJyqm4LoMvSa6gNL9PL8ZJu4pZDo4kKcl66fgqbxSYONw9DkQfOgwPWlpSGKPsDIoMcwprvVLp1ygSH56i1Tzpiqg9MaPHrXL1Rppi1UcrBvxic1H1Zdn14o6T9pbN1YBQt4hBeJ4Hk2qbOHwj+CTda56AQM9zBKD3hwA+6ePEn748FH1CjOfpk8SPsFIoqATVx3syUdAz2Xtls9phieB0zi6ohhfFQvK64ELosMPGNWO8It66kPURP559DqwWZ6v5TBB+yaQgTq1FcwtOJcHpeS3dRbN76iOeOih5MvTunSYHjkoUXyJLfkhj4oFgn5XiNPltdFA/k4QIX0wqKyENUkks/NcLP3MLvFb0G7PBQAlxsr4f7DxZgpcpnSqhOo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:35:42.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84768c9b-ac6a-4232-3e76-08df29b4fd0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014677.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Sairaj.K@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

kvm_arch_fixup_msi_route() and kvm_arch_add_msi_route_post() use
x86_iommu_get_default() whenever an IOMMU is present. This selects the
correct unit only when a single IOMMU is attached to the system bus.

The following patches allow an IOMMU to attach to a different bus and
isolate the subset of devices below it. Each IOMMU then serves only part
of the PCI topology, so interrupt remapping must determine the IOMMU that
actually serves a given device.

Add x86_iommu_device_get() to locate the IOMMU bus for a PCI device and
retrieve its X86IOMMUState through a new get_x86_iommu callback.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/x86-iommu-stub.c    |  5 +++++
 hw/i386/x86-iommu.c         | 16 ++++++++++++++++
 include/hw/i386/x86-iommu.h |  6 ++++++
 include/hw/pci/pci.h        | 12 ++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
index 781b5ff92227..b0383d2290b1 100644
--- a/hw/i386/x86-iommu-stub.c
+++ b/hw/i386/x86-iommu-stub.c
@@ -32,6 +32,11 @@ X86IOMMUState *x86_iommu_get_default(void)
     return NULL;
 }
 
+X86IOMMUState *x86_iommu_device_get(PCIDevice *dev)
+{
+    return NULL;
+}
+
 bool x86_iommu_ir_supported(X86IOMMUState *s)
 {
     return false;
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index a57445404ef8..601db5cfea09 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "system/kvm.h"
+#include "hw/pci/pci_bus.h"
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
@@ -90,6 +91,21 @@ X86IOMMUState *x86_iommu_get_default(void)
     return NULL;
 }
 
+X86IOMMUState *x86_iommu_device_get(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+    X86IOMMUState *iommu = NULL;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+
+    if (iommu_bus && iommu_bus->iommu_ops->get_x86_iommu) {
+        iommu_bus->iommu_ops->get_x86_iommu(iommu_bus->iommu_opaque,
+                                            (void **)&iommu);
+    }
+
+    return iommu;
+}
+
 static void x86_iommu_realize(DeviceState *dev, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 0a1e1ba72571..eb575271e9d7 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -134,6 +134,12 @@ struct X86IOMMU_MSIMessage {
  */
 X86IOMMUState *x86_iommu_get_default(void);
 
+/**
+ * x86_iommu_device_get - get IOMMU device for given PCI device
+ * @return: pointer to default IOMMU device
+ */
+X86IOMMUState *x86_iommu_device_get(PCIDevice *dev);
+
 /**
  * x86_iommu_iec_register_notifier - register IEC (Interrupt Entry
  *                                   Cache) notifiers
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a0b..f3c4c3a4db56 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -698,6 +698,18 @@ typedef struct PCIIOMMUOps {
      * Returns: the guest physical address of the MSI doorbell.
      */
     uint64_t (*get_msi_direct_gpa)(PCIBus *bus, void *opaque, int devfn);
+
+    /**
+     * @get_x86_iommu: get parent x86-iommu for given hardware (AMD/Intel)
+     *
+     * Callback is required if IOMMU defines x86->int_remap()
+     *
+     * @opaque: the data passed to pci_setup_iommu()
+     *
+     * @x86_iommu: A pointer to store the x86-iommu object
+     */
+    int (*get_x86_iommu)(void *opaque, void **x86_iommu);
+
 } PCIIOMMUOps;
 
 bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
-- 
2.34.1


