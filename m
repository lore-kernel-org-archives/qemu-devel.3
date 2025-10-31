Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2173CCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmne-0008WK-4o; Fri, 31 Oct 2025 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmV-0006Kh-Hn; Fri, 31 Oct 2025 06:54:55 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmM-00033H-Se; Fri, 31 Oct 2025 06:54:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExRC0VFyYrJ1mnzwBADnOddI+gCWxlfX+py5f+R33Qkg1qLo2F9bTJCsWkm9fjdzpo+1uFUrgCitOdz6E+c9bFisbRJspTX0VHkhelSMFsR4H1th1xN6qIUFplvHOnhwBDD9kXZM0YrVlXys+iztpIIINaVSDiUI784+3mByf2yzzGRyW+akV7bE5uDxHcsuz6ybyK896zTg3ELIEA+Weu7rFvOSsza49OVCE9MuSZTrVMNVs5xYk7j5pGILSKYIXiu1aK+WmTR/s/gHu54FhceHVnG17l8sbV2r9BOVL2ctUE7UnDHHtplowi+Sxy3Qx3DVpJFmUYtk6oP5yRPe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb1Aq72Q2W7XboVlRPnewxnNumrDIjMDhpprbT6jj8A=;
 b=NF9+RyNjPh/vkf6uj8DAjNvA/udcmzE22VYY/dVpL3FFIINYC265V5E9OxGSzRFu/iXw/rvt5jvBVeGKEamTEWtp7MxFhe2FP7ebAOmBcmbyXYO2WpZceUJlkN4krL4AI3oydzMbtmpPm0sThLDClmQefcB5c5zRCwpA0OVr99dXBEHdGPb4pQ3HJfwIVcA4M+BM7wqsXBPwcQN2LdvpWaRKU23lP9ZhSbFVmTT+XV3Pw/ZFXku/lmZAADXmRtqR2yM/5PL9XmZUrmV6riRt2ckEUyg0A/pGyKxHw4rg4N9wNuO9kUnlKIdBCH5lSSFyOF6e8UIzRtHYU9KpAmDvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb1Aq72Q2W7XboVlRPnewxnNumrDIjMDhpprbT6jj8A=;
 b=FEwuOHxDs5wkUlXa3rTnAM8G9VCjI5K4EJhkNo8lGrKnZ8H6jaOEvQpQ3L5tLfRLDGRPS8uL4UZZxOcr3d+lBHVaJU6CQNhjYTO3pbgoINgPAlN8fimIQSQuga7Fl+lakiRPofpCuM4Oe9Bs8vSHng484E/q+vjSISRm7HbDyNPxq0+LElDOjJfcxqFO6zOS347TF6Fn3weHwbUhNlua8WYdVPZfUnj/etviMxlVIjPA0oeCAsGL4WvinM8xmGZcy7I7dZFiED9G5YVgpj1uYs2LR3QtvVMdK80HHa7sKEPrrSxyZbPaAEcrIqb3Lc+zyJ/VqeVcc4GvmwHMS2lNxA==
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 31 Oct
 2025 10:54:39 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::f8) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Fri,
 31 Oct 2025 10:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:29 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:26 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 25/32] hw/arm/smmuv3: Add accel property for SMMUv3 device
Date: Fri, 31 Oct 2025 10:49:58 +0000
Message-ID: <20251031105005.24618-26-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 7831eac0-2486-4fef-a282-08de186be35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2x0cTdOOWU2Nkw4eE80a1U0R21nOEtKd3c1SmNRV1VUREdWNWVkQlZRcEI4?=
 =?utf-8?B?WVgzSkRoTndyZEdWc1FDRmFpNDNsMG9JWlRCN1paeUI3Mkp5ZVptWjVqQ2NI?=
 =?utf-8?B?amtkU1NBZUlFZUYxTWZsNkozekJ3ODdtbzI5bmVuK3lFS1pFRDBMWmw2UTll?=
 =?utf-8?B?cTN0TUlLK3F6L2pXdXErc3phdmJWS2h4MzNuT0M1WVUrcTMwalRtOW94Nzll?=
 =?utf-8?B?Umx2WE5kNmh2bHRwNzFyOGFQMmxmLzVEU21aVUNZSmNVSGd1UHpzOVV2NXdZ?=
 =?utf-8?B?YkVCZ0EwK3pVRnk0bVVQVjIzOVF4S2NFbnBpKzNkYlNKUzZwcW92MHNCejZx?=
 =?utf-8?B?cHpra1kxa2h5WEo5VkNBbFlaMmY4L0g0bTFHdnc1SHh0VS9ZYWVLMEViWWVC?=
 =?utf-8?B?Z3pNd21XYXp6dVB4SjNXekF3bDNrZUFyMkc3cUR0YnIvNTJId2hZM1o1RzhI?=
 =?utf-8?B?TFd3c0E2dVd4eUdlL1IwWWVOaHRDeVh1RkJtaVpuK0I5S0x0aENuanZPR1Vr?=
 =?utf-8?B?dEllUWt6anNvRHg5Q2FpOXVZWjBCOVpFRzhnU0JBWlpES0tlSDFjT2lxY2lk?=
 =?utf-8?B?aFRhNy83RUljTmsyOHg4SW1ndnBzOFozRnBuRm0ydUd6N2cyNXRyaGNZY1Ft?=
 =?utf-8?B?d1UzdzZabmNGRFZyQlcrWXlKRXVwZnhNZEhaMGR0cU01MXB2dk5UNENNMnUr?=
 =?utf-8?B?TjAvMklKYjN4ZnFXUldrZHRuSU1qaHQrN0FpejdPdGoxOEwvalFwYlFWMkow?=
 =?utf-8?B?UFJFbWNpMmZqeFlDdTdlZmtjdXJHVEJXd1hQZVh6WFFRSngvaVQwNDhETzhG?=
 =?utf-8?B?c0UyUkJJN0o5QkFmQi9HWGNUU2c3WmI3TUZQU1BGUVNHdElzVlBLUkJKYkg1?=
 =?utf-8?B?WFk2ZCtvN2V0RUx3YWZRRkEwdlpHT09BS2QybkxDTTg3dUxVRm1rVVJidFJ5?=
 =?utf-8?B?NXdBNHlCUGJxRDY3M3lORWJsMHlpSFV0WVV5TXNWTDVxdnpsaHFsYTlCaTdo?=
 =?utf-8?B?QjF6NFZjcXduS1VyY2xRSnpJTzI2OXZ1czNRUzJQakliZ09DbFArWkZFcS9P?=
 =?utf-8?B?ZGNvakVRSW5jaG02Yk81VzljZGtyWjdkQXFBOXQ3UTVWTmFwdjR6Zi80a0c1?=
 =?utf-8?B?bGYvdmFZa1g2V3hGdnVaSDQvK3dNTWcwNG1FM0Q1NDlCemUrQlJQUnQwanYw?=
 =?utf-8?B?bWhKYlowVlZkdnRZTEYvbGU4OHE2WE5SYXdBVFNpbkpiMHZHSzZKZEFZem5h?=
 =?utf-8?B?OE9yaWxBanVraFlTQVJBYUFRalQ2MkpSYWswN1drZ2NPTmdRWXBPdFFXTENz?=
 =?utf-8?B?dFh5RjRGNkNQZFRSSTJRbjJ1Vi80cXpBTTN6Vk9JaTM5bUtXSnJ0NHhKajlK?=
 =?utf-8?B?cHVTbjNTV1c5cXB3SkZRTXk5YXVoL3NWQlBBVE1UcXEzdjN1NDFHZ0pxN2I3?=
 =?utf-8?B?MHZONExMN3R2ZXYrT0lsYjhoV3hqUnhsaldEL21WS2ZlMUZBMUlpSGJleXJ2?=
 =?utf-8?B?eUt0aEpWOFVGbkpSNUZ5UmI1Qi9maUZZMkdhMzE0eUpIK1NmV25nbnhGUXhV?=
 =?utf-8?B?QVdacDVFUFdZN0t1L25WbzZsN0xLMmVKR25zc0t2QUVFMWRIN1NZZFliSGFQ?=
 =?utf-8?B?clJ4elFsMy8zdG1RaE5jMFlKdHZyaFROUHdJaTk5Y3lOemt3YzM0TVFqQ3lu?=
 =?utf-8?B?czBkVkl2TFZ0MW9JaXppNDR2U0kzM09Oank0alhYVmMwYXhMQ1hvY0RMMkt2?=
 =?utf-8?B?WTdFSzJCL3AzdE04a2hwNTcxRjU0RzVvWStRYVJ5aERxS3BxNkN5MzZNV1Z1?=
 =?utf-8?B?Z3NvZ3M0K2hGZWMrNndIem8wSHRVaGp2Z016Qk9LcGNLaWZSNGlsZlpEUFV3?=
 =?utf-8?B?UDhxQmV2R1RqQUtuL2ZCTEdDWmNjNlNqVzBBcFZKYjQ1RzdEWjFQZ2pYejkw?=
 =?utf-8?B?dXFPbmxsdFAyY0hvVnJ1SUh0S25ZQkdOKzhsemZZYkZya1FBV2FwSTB4V1kv?=
 =?utf-8?B?YmN5SVN5azUwdnR3UkFJYmlpM0JHZ21OaUZacEZmZkFiYzVER1BHbzRhc2dI?=
 =?utf-8?B?VUFCbDBnNDVXU2czaGxJa0ZybUp2VUpsM1gzeFFCNGpsVXBkT1drNmt2WFZO?=
 =?utf-8?Q?0Kjc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:38.6444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7831eac0-2486-4fef-a282-08de186be35b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c          | 28 ++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c |  4 +---
 hw/arm/virt.c            | 31 ++++++++++++++++++++++---------
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index fae545f35c..f040e6b91e 100644
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
@@ -1927,6 +1928,17 @@ static void smmu_reset_exit(Object *obj, ResetType type)
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
@@ -1935,8 +1947,17 @@ static void smmu_realize(DeviceState *d, Error **errp)
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
@@ -2035,6 +2056,7 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2056,6 +2078,12 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, smmuv3_properties);
     dc->hotpluggable = false;
     dc->user_creatable = true;
+
+    object_class_property_set_description(klass,
+                                          "accel",
+                                          "Enable SMMUv3 accelerator support."
+                                          "Allows host SMMUv3 to be configured "
+                                          "in nested mode for vfio-pci dev assignment");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 097a48cc83..6106ad1b6e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -399,9 +399,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
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
index 8a347a6e39..2498e3beff 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1488,8 +1488,8 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     g_free(node);
 }
 
-static void create_smmuv3_dev_dtb(VirtMachineState *vms,
-                                  DeviceState *dev, PCIBus *bus)
+static void create_smmuv3_dev_dtb(VirtMachineState *vms, DeviceState *dev,
+                                  PCIBus *bus, Error **errp)
 {
     PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
@@ -1497,10 +1497,15 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
     hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
     MachineState *ms = MACHINE(vms);
 
-    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms)) &&
-        strcmp("pcie.0", bus->qbus.name)) {
-        warn_report("SMMUv3 device only supported with pcie.0 for DT");
-        return;
+    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms))) {
+        if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            error_setg(errp, "SMMUv3 with accel=on not supported for DT");
+            return;
+        }
+        if (strcmp("pcie.0", bus->qbus.name)) {
+            warn_report("SMMUv3 device only supported with pcie.0 for DT");
+            return;
+        }
     }
     base += vms->memmap[VIRT_PLATFORM_BUS].base;
     irq += vms->irqmap[VIRT_PLATFORM_BUS];
@@ -3090,9 +3095,17 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                 return;
             }
 
-            create_smmuv3_dev_dtb(vms, dev, bus);
-            if (object_property_find(OBJECT(dev), "accel") &&
-                object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            create_smmuv3_dev_dtb(vms, dev, bus, errp);
+            if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+                char *stage;
+                stage = object_property_get_str(OBJECT(dev), "stage",
+                                                &error_fatal);
+                /* If no stage specified, SMMUv3 will default to stage 1 */
+                if (*stage && strcmp("1", stage)) {
+                    error_setg(errp, "Only stage1 is supported for SMMUV3 with "
+                               "accel=on");
+                    return;
+                }
                 vms->pci_preserve_config = true;
             }
         }
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index e54ece2d38..6b9c27a9c4 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -67,6 +67,7 @@ struct SMMUv3State {
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
     struct SMMUv3AccelState *s_accel;
+    Error *migration_blocker;
 };
 
 typedef enum {
-- 
2.43.0


