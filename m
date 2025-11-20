Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA92CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fP-0001Ts-Gi; Thu, 20 Nov 2025 08:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fH-0000se-MA; Thu, 20 Nov 2025 08:25:36 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fF-0002dl-Nx; Thu, 20 Nov 2025 08:25:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJQJRCxKU/W5Ma2rWwnj2eqCO04f5NP0U1hnU0J7h45BG4tXQmsCbM0lFa0HYaEZx+NpLDQzb4+2ewxN12qYKF5g7Iihn1KMhGFAFQ1XwKrEF04TJQtL0uvDuwWTxCYE09oh0FdXNDUokmWhsfvw0s/31oMq6LHWUbZ5eiL3cEsJVvhF7Lids78tLWi8oNRdkVNjM5BM7WtrrJV6ICnIhZZril1vQkFou7ryYIPQXoxrKIa3Bsie0UeYObdpRsID9yLFdZkci49SpV9hByLMSyTtDH3FkiObcpLErvH0wPUHPhVFMB4EeOWNsw6h+iHT0M2x3V5CTlK8YSXcLQu64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bndi3VDmaTDe+2Baj2LxVJwRePVjcFOoecmidwzt0x0=;
 b=CyHUzZ/V3XjomPXfKHRi2OEFkR8BvuyjA1IAnm1bNscV51ETJIuROtX9kDrPlYt9TEbrpsWZ9qyquCx5PKc8x28iEW8P5Uz5SMxM5PkXyrn7gvpTcEEOVu3Ip5uSc2im+qHVtJ8Q1rOrxoYdIKCn5CtaS6+6fc3bHLILdX/pLxfQ8k4iMj7J82JrDQb0e7TXmmvlvoK9Dy+mKwfTmPEPWUJZvNZkgrWuZoDMp5pbce2Qwh207Iw/Cc7tHrlSTNZwOEeMnMuMzcT47hc1V0kV9c2atYNVpVZfrwUXeBzcA1aOsfm1nZcs+mWx3neswlK1KG2viYHD2LIGAkA0OAbW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bndi3VDmaTDe+2Baj2LxVJwRePVjcFOoecmidwzt0x0=;
 b=L7nmqFeQXrwiJTeg3aj5EjGyu63iF6bfuMOsHajnN2+EGxn1NswPbviU3Yx8/l8hCbp0UyTwMrZPBh/n7jbPyCBT7QTgGj5yfpAeEcw+9Ep4I6Yn+Jg+8ZhWX+k/cOGqNeh+8t31/654vNPKi3IXBf5iftwcTOmU9TxXDCNO4Cj41CppMWbjb98YrT1I//zC6JNcbgHZ8TzBrKMt+HsL7qAQRXlXu2FrBiNbP5dTAZ1FGMlA5CxKB7A/Mq/LE3zjJnlQm5Nz9H28EHj6pLOFKfbnai9ofwj9IJ58TWB8izAd3uEUEukLLQKXJE9bIHMC1Go0Dl1wDyEU6O8b4f5yrA==
Received: from BYAPR07CA0053.namprd07.prod.outlook.com (2603:10b6:a03:60::30)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:27 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::eb) by BYAPR07CA0053.outlook.office365.com
 (2603:10b6:a03:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:10 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:07 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 26/33] hw/arm/smmuv3: Add accel property for SMMUv3 device
Date: Thu, 20 Nov 2025 13:22:06 +0000
Message-ID: <20251120132213.56581-27-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf2b12a-49ee-4047-ee26-08de28384522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG5xOWl5d25UV2lRMTFZTEhjOVM0NSsvSmNVK3JSZ0pqYzlLQkRKeFp0Z241?=
 =?utf-8?B?dkNCc3pyaDA3RW4vSmpTcHV1ZmhtNnpQZnJqc1ZQNkcycXNPS3ZFa3pTeklQ?=
 =?utf-8?B?Vkp2aEptSFNOeGhScnphQ3JNdFMra2pydnBqa1lJUDgrclVOcGwzc1BLRU03?=
 =?utf-8?B?U28vc29yZ2tocXFIREg1U1RjWUtMaVBRaW56Rjc2Y2I3S2NzcDNyUFg2ek5j?=
 =?utf-8?B?RVNrcjRNN09rMlY1TnN5eW5ONU9ucENGcTRHc0ZETm0zWS81NmFrQTFaT2Rs?=
 =?utf-8?B?NFZiV0d2UXUrWkk0ZXVNa1BkSkxna203akpMbG1QN2xRUHprUDRnTzRhWkwr?=
 =?utf-8?B?R2hUdXlIampYZ3RvTFNrbzBTOUUvZUxNQmNRZ2V3NzhFTlVnT3VZamU2bjgy?=
 =?utf-8?B?b3VKNGJwaFNjNkd1NGQ0eFYyazdpYUN6SW1YRVIrMFZONkJjY3NHS1p1Uno2?=
 =?utf-8?B?WjBTTnl1bDNOSWl4d01mcVVyR0JhTUpZTDlDV2lzYXNvdnJvY2EvdExiN05O?=
 =?utf-8?B?S1VldmNPeXpVMDBsc0x2MlBoTUdMdDhnalI1L2d0SldBdVpWZ2x4R0lIUFA0?=
 =?utf-8?B?NHkySGMrR3BNcnFGMStxM3lMdUgzZzdQejYrWkoyVUc2M1BYcGFLMldZcExE?=
 =?utf-8?B?TFhOendSKzVDcGZIZ09jSFNCRVo3TlVvUGdkWEZFb0Rlc0lHdFVTY0owZ0VR?=
 =?utf-8?B?L2FseFlWbHpUSzZ6eUxoNnNYK0tNZW1HRytlTUJKd2k5c1B2aGYwVjhsUWVN?=
 =?utf-8?B?dUNyN1l2aVVuZkRXNCtudjlOeDdoeDhIZlAzQ1Nzb0FMQmtBeTN0T2tXNTNs?=
 =?utf-8?B?Ym5UY0hGOG1DdzA5NndhanJwVzQ1VXdJNnozODQ0ZGVneUtySlpZRUFqUlFM?=
 =?utf-8?B?QTNISFlwRld5K1pmR3N1RlJmb2lpYTJUUEhUVTZBeFVMTkhrb2VBMlo3Vzhx?=
 =?utf-8?B?eFFZTisxcTZrRmNOQVZpWlByWUNtVE01b2YzMTJHWmxEeUNNUEtLYjJGNkNH?=
 =?utf-8?B?RmRtUXNwVC83czBxMGRvZ3F5bHQydkphS3Eyc1N4SWU4T1pvalh5UGRIMFZx?=
 =?utf-8?B?KzJRcTNacktyL2VjMDJXMXJ2S3RGUVZlMll5eEh4a2VGNjZQcmlIdDNTODNT?=
 =?utf-8?B?M0VPYzF6R0llRGJuK3RnTnQxb0tOWStFNk0xN1hBZUZQT0FJRWdJbzh2M3pD?=
 =?utf-8?B?TmREWjFYRTFHUVNWNHloWEtPcUhsSlFFc3pBNXJJdVZjSThsakwwdEx1S3NW?=
 =?utf-8?B?YmpsS3VNU1dBUCsxSkZ4bVROKzN3VFFFRkxGYnZiRTBMOU43YUxKR2MvTlNQ?=
 =?utf-8?B?TWVCSURocS9pYlVxOXhRUkJiS09aS2RJak1oWVROVHpodllYWjZKTDB2bjJt?=
 =?utf-8?B?dDF5Mk1CWENEOUNlU0laU1RlZmlqaXF4UnhtblMybUd6TXVrQ0pKVVhuTE1j?=
 =?utf-8?B?dUlGdUVudnA5cU1pbXBIUFJ5blRKUmYxWWUrSlg5cU94eDhqSitLckxTaHdo?=
 =?utf-8?B?elN4TXlVZ2FNSkExRm1hcTU4Smt5cWt6Qy9sUkx4R3FGL1JmOGpFbnFXRkc4?=
 =?utf-8?B?YnhvdGMvZmZFeFZrbUxFOVdtVWFja2JKME1KaW8rTzZUcHRGZG1yUjVqUDQ0?=
 =?utf-8?B?dWZGVDJBcjFQNHVCRHZ5MHVFb01nNGNYN2Y0SkpOUVlHZzVHaTNVbW9Ud0JV?=
 =?utf-8?B?aVBLK3BBRkJuUXhGbExtcGIvbUZDdTh3RUJ0RzlVeEhZQmx6ajlCN3BHaDgy?=
 =?utf-8?B?VVNWWmltWVFVVjJZSmh4SHBxQTA0c2hTSmlDaTh3NldvblVsSFlRcHliUmI2?=
 =?utf-8?B?c1JVWldzTEMxbHVwcDh5dzVvZ0xWMGUwZHlzQXU0eklTZTZoSElmajNWWXZL?=
 =?utf-8?B?cHE2VlZ3b09kTW1XNEkwUmUxL1k2TVFQYmNXY21kVXNMUkVHcTZJWWtodVdK?=
 =?utf-8?B?YVZtTXA0ZThSM1pXZnZRSzJzNEQwazUzSVBvc0RkQW5wQWhFc1R5WGZjVVdC?=
 =?utf-8?B?STBXbHBzcmd3RU4wWEE0QXdBWUhGMkE5akNyTFdoM3lMMWorWDliV21kQXMx?=
 =?utf-8?B?c1ovUWRLelViVGg2ODJOcTgwbFA5TU5WZyt5eDZjc3g2Q0V3WExRMlMxM0Fs?=
 =?utf-8?Q?lnAY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:27.5407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf2b12a-49ee-4047-ee26-08de28384522
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Introduce an “accel” property to enable accelerator mode.

Live migration is currently unsupported when accelerator mode is enabled,
so a migration blocker is added.

Because this mode relies on IORT RMR for MSI support, accelerator mode is
not supported for device tree boot.

Also, in the accelerated SMMUv3 case, the host SMMUv3 is configured in nested
mode (S1 + S2), and the guest owns the Stage-1 page table. Therefore, we
expose only Stage-1 to the guest to ensure it uses the correct page table
format.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c          | 26 ++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c |  4 +---
 hw/arm/virt.c            | 15 +++++++++++----
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index dba5abc8d3..8352dd5757 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
@@ -1915,6 +1916,17 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     smmuv3_accel_reset(s);
 }
 
+static bool smmu_validate_property(SMMUv3State *s, Error **errp)
+{
+#ifndef CONFIG_ARM_SMMUV3_ACCEL
+    if (s->accel) {
+        error_setg(errp, "accel=on support not compiled in");
+        return false;
+    }
+#endif
+    return true;
+}
+
 static void smmu_realize(DeviceState *d, Error **errp)
 {
     SMMUState *sys = ARM_SMMU(d);
@@ -1923,8 +1935,17 @@ static void smmu_realize(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     Error *local_err = NULL;
 
+    if (!smmu_validate_property(s, errp)) {
+        return;
+    }
+
     if (s->accel) {
         smmuv3_accel_init(s);
+        error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
+                   "accelerator mode enabled");
+        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+            return;
+        }
     }
 
     c->parent_realize(d, &local_err);
@@ -2023,6 +2044,7 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
 };
@@ -2046,6 +2068,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, smmuv3_properties);
     dc->hotpluggable = false;
     dc->user_creatable = true;
+
+    object_class_property_set_description(klass, "accel",
+        "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
+        "configured in nested mode for vfio-pci dev assignment");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7a7b2e62c1..fd78c39317 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -400,9 +400,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
     }
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
-    if (object_property_find(obj, "accel")) {
-        sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    }
+    sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8503879c3d..51b15aef37 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3052,13 +3052,21 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             /* The new SMMUv3 device is specific to the PCI bus */
             object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
         }
-        if (object_property_find(OBJECT(dev), "accel") &&
-            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+        if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            char *stage;
+
             if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
                 error_setg(errp, "SMMUv3 accel=on requires KVM with "
                            "kernel-irqchip=on support");
                     return;
             }
+            stage = object_property_get_str(OBJECT(dev), "stage", &error_fatal);
+            /* If no stage specified, SMMUv3 will default to stage 1 */
+            if (*stage && strcmp("1", stage)) {
+                error_setg(errp, "Only stage1 is supported for SMMUV3 with "
+                           "accel=on");
+                return;
+            }
         }
     }
 }
@@ -3096,8 +3104,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
             }
 
             create_smmuv3_dev_dtb(vms, dev, bus);
-            if (object_property_find(OBJECT(dev), "accel") &&
-                object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
                 hwaddr db_start;
 
                 if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 5616a8a2be..9c39acd5ca 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -68,6 +68,7 @@ struct SMMUv3State {
     bool accel;
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
+    Error *migration_blocker;
 };
 
 typedef enum {
-- 
2.43.0


