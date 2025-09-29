Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC3ACAC5BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8t-0003ya-7W; Mon, 29 Sep 2025 09:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8B-00039b-OM; Mon, 29 Sep 2025 09:41:33 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7g-0003oz-My; Mon, 29 Sep 2025 09:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRZVs0I3MBZiyRd52SNfH2mr9nhjPRasVng4uBjEZ+giBRxG6NW3/RCZlrG+NY07p7bADdEsQDO9nGkc+EOQwoXAsGw/pBEI64VjIl9mxjHotIWfafC7vc22vnnpxlDRkfoFDn5s7/mIC3pVxo+FPGl9eURNWxIOZlXbdPFt7jN9Zt53uJFF3XVGiY4DAJh7k1SjzhZQjUiTGHjMRBeFh9u6QMpbwZfleq+xOC4QGVQ4HXOq6RWwmJI+gasYt9OskRBKByN5Uh3FddGgJoLs0HT3NV2vxpuhm/hOuLbH9l/U6ggEih+1zOD7P8qQODw6XgBzHSIRE2MUIyMA2KCspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeSXk1ZvgD+JoeDYLbnyjtQw21XJVAA5ryFMPVivjP0=;
 b=NTs695hMfzaPQl+FxsTqI7OoL15LuUUd9bvQ7ylCWalAFm8VYEaLi+6KQHOXHEtHM+6RxWCQNPM8UmPbXTf1s/sI82+OGJM+GTyijBTEfOLFwiSN2C/AmD1Ho6cDIuBfqnj/tkTQ9crMnIT0RTdJYACHqjK23/U9dbtnTW8V5fv9BkLKtfPwijdvGtCjGmkoatSjmaqkJnG45tI/Epj7r3sicwcDP+/z5pti1F68n7OR4SVnNglICw8TWbi/UK4Yv3nF/ExnKJsWecP35OEo3yFE9luhhjquyW5wsgKpZGFW10uW+eYzgIEcxIgqSsf2nEls1G01f94M+KqmW0rqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeSXk1ZvgD+JoeDYLbnyjtQw21XJVAA5ryFMPVivjP0=;
 b=bcjYikdVfh/tGmMGTgLlvq+iE+/MnO7t6dFj2eUFtn/9cYnSuNFVefw1yJgzXVsEQVncEdYXfgM6oGasje8h8Z/EQdj/KtApRQpz5wob7GNCN2UzvtUxcNLpBkdHL9T9RrJ+2p6WEaDEPtsDWk6VBcfJ0Yrd9aZZUOqXs56FAZkKke2jEcUsIV2vPb/CqrNiZZeADdZ7HNirC45gfmLv/XRd6R13Xr9Zn4LR5TUDDPAzByXklW15rwu+n/NOVJ7NWiztogNgRKLlY75/YYX5sxusHnVAovRXH4yFINe8QazFN3ZwbLXdSW5IUO4FfoVRjGX96Uwb03vlEi+AbPCAhA==
Received: from CH2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:610:4d::25)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:43 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::43) by CH2PR19CA0015.outlook.office365.com
 (2603:10b6:610:4d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:40:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 20/27] hw/arm/smmuv3: Add accel property for SMMUv3 device
Date: Mon, 29 Sep 2025 14:36:36 +0100
Message-ID: <20250929133643.38961-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c2c3cd-4605-4ce2-a393-08ddff5dc936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjZvZFhiK0R3aFdJOHU0REZCeW0xTmd1SWRBRkU3bVJ5R21FbFNheGpYQlRr?=
 =?utf-8?B?a1M4VkNLNW9SRFRoVEhmYjNMekFaTnkzTlN2RDdTSGNUaSs2NjYrZDRZNU56?=
 =?utf-8?B?VFV0cENRSTd1ZllDeE1GM2kydkF2YjdPYTlRa1lYa25zeTBtL3JtZVo0cGJy?=
 =?utf-8?B?QzAwSUJLczRpRXA5YjZ1dmdFWlp4Tkc5QmkxdG9ObHJJL2dIczBLR0daTlRJ?=
 =?utf-8?B?N1IwNHBKcENIYVlBanVsZkJZd3M0Tk5VM3pzOWdFTkc1S1FlS3M4RHpKSmJG?=
 =?utf-8?B?QmFLOXpKUDNFV0czY0duRW5YcjJZNEZTWnN5YVR3SmJ2a3pWUW41dk5oL09S?=
 =?utf-8?B?ZUVTU053VDlyZitFeDBVR1pITFhjQ3VtbWl4NGVhNWRWTDFUYkFTaUF2ai8z?=
 =?utf-8?B?bGhldzdwUlUzK3VHbmQrS3BQUTBPcm5nRVhkdmNLTXNNb2FSb09VNm4rYXFq?=
 =?utf-8?B?dm1zZ2M1aFluUEUyRXdyTkVaWFVGL1g3WW16Nm04QXJTL0VpbmZla1p1QzF3?=
 =?utf-8?B?SFp6cVZ6WFJSbTZHWFcydGZ5QlhkTmVHQzdFS3hwTnVMNlZuUXR3SmRIYUxL?=
 =?utf-8?B?cjh2eE0vcERqVEozS2J5dkRKK1ZDeE4zMnFGMSt6bXBUcjYzdGlrVHJhK00x?=
 =?utf-8?B?cjIxa09JTVBjY2Vpb0FENTU0T2JFMEJybmVsakZmMStmaC9jdCt6UTI0dkc3?=
 =?utf-8?B?aS9QajJWc0lJcldTejc2VU9nRmV1aEdjT2xEeTB6VDJTenJaYkY2K2pCNE8v?=
 =?utf-8?B?SHNBU3Zoc0lKQmpKcjJoODNIbGI2M0h2T0tWeHRrNWowd3czUkNlaUdJN0JB?=
 =?utf-8?B?WE1zL3VHNEJua1RUYk1xQ0Q2bjZ3S2s3WkJuSElQYmtaNFo5Smd4UHJDLys5?=
 =?utf-8?B?ZXFEZ0theWk1enBWelppSGJWUm93VnN6SFVoU3FENGJIUVM0VEJaUVdjUFBv?=
 =?utf-8?B?ZnVCbEJMZk9NTkNxb1ZUemVSZVprNmExOHpXcEpicEV4UldSeGlTMkdKSmV1?=
 =?utf-8?B?eFBXV2tTNCtLakZuOTJiQzBKOW5lam1RdUpYRTFoQ2licFZYbFMxQXJMdHBP?=
 =?utf-8?B?UzVjYTVTR3EyaGpKYXlGSzk4bG9yRFYva0Iya0M4OHpGY3A1NEY5ZEpGbHJa?=
 =?utf-8?B?MWtNWmZiRWVIY0JEV1l0Smo5WXp4WUNEcVQ0anFjdXJlQmVneUVaR3FkSHJu?=
 =?utf-8?B?WEUxT1VRQUkwa0NoWVc5dTl4RWpmdC9Rcm5HVFZ3TVZ1VktxMUpuZTliamF3?=
 =?utf-8?B?cWZ0Wlp5ZUhwVndOZDIxYi8vN3FqbzdmSHMyRGtoMzQ3UFRhL3RiL3ZyYzFq?=
 =?utf-8?B?MXlOaGNHRE1MSXRseUhCbmsycUVONURraGt2TUhXYWxoSDBzdEpteVBJcVNF?=
 =?utf-8?B?ZHo4SW1WOWwvdElTbnFsZkw4dktOMGFEV25BeXlTbEtMaDY3NTJtTlJXZU1z?=
 =?utf-8?B?VC9nWno0aFBhWGdXUHF5UWVxY3FnMERkZkRiWHZGcUM4ZzRsakwza3hGek5P?=
 =?utf-8?B?dWZyeXQzMUZGN3o1RFowL0lpcE0ydURjc24wNWlZV3B5c0l6eCs2RE5iajUr?=
 =?utf-8?B?UDRsaFBGNnVadkptL1hNQnhlWnJFbnRuSWt1ZDNHaTMzRlRnNUo3U1ZHT0tw?=
 =?utf-8?B?TTVvT2h6Tkpvb3dMRGFMMXg2QVRGeGlOQlVlVVVEVklSYk40eE8ycWRFTFpJ?=
 =?utf-8?B?Z3hzQ0tEbklJazU4RnFpS29ES3hPYkNGMmpoVHNNMUQyUzB0ZGpsd1R2QXRQ?=
 =?utf-8?B?dktuclY2QmRYNFU3Nmt3SUtERGxERVY4S2E0UmhmS0VnUE9vWG5zSWdISHF4?=
 =?utf-8?B?SEk0Z09IYVUyQ21hVGt2cm9zendtV2ZBanBJLzl4RG9HOXp1SnhDM2pCRy9I?=
 =?utf-8?B?VWxWbXg0OTI3cGRSM3FrUG1oS2lJRWJhRE12cDh1Q1N1SGNXcHc1Q2FFZVBt?=
 =?utf-8?B?WE9mQjRyM1RVNGF0YlRHUzRYMXdHRXFqT1BWQ0JCOXVWZjBsYXVCMENlYm9r?=
 =?utf-8?B?YjdXUzVNSlZZdzQ1NUdka1NWTHY1ZHVGT0oyQmQ4ZVZCOGRjOGo0M2F6R1NE?=
 =?utf-8?B?YXB1dFo3N0VMTkxHMzZYTWp2dExYR2Q1RmxSOWxDYXNEZ2VmYnVpb1F3TTZI?=
 =?utf-8?Q?uiyA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:42.7851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c2c3cd-4605-4ce2-a393-08ddff5dc936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c         | 28 ++++++++++++++++++++++++++++
 hw/arm/virt.c           | 19 ++++++++++++-------
 include/hw/arm/smmuv3.h |  1 +
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 94b2bbc374..a0f704fc35 100644
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
@@ -1916,6 +1917,17 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     smmuv3_accel_attach_bypass_hwpt(s);
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
@@ -1924,8 +1936,17 @@ static void smmu_realize(DeviceState *d, Error **errp)
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
@@ -2025,6 +2046,7 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2046,6 +2068,12 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
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
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6467d7cfc8..6b789fd7b5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1474,8 +1474,8 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     g_free(node);
 }
 
-static void create_smmuv3_dev_dtb(VirtMachineState *vms,
-                                  DeviceState *dev, PCIBus *bus)
+static void create_smmuv3_dev_dtb(VirtMachineState *vms, DeviceState *dev,
+                                  PCIBus *bus, Error **errp)
 {
     PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
@@ -1483,10 +1483,15 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
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
@@ -3086,7 +3091,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                 }
             }
 
-            create_smmuv3_dev_dtb(vms, dev, bus);
+            create_smmuv3_dev_dtb(vms, dev, bus, errp);
             if (object_property_get_bool(OBJECT(dev), "accel", &error_abort) &&
                                          !vms->pci_preserve_config) {
                 vms->pci_preserve_config = true;
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 5f3e9089a7..874cbaaf32 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -67,6 +67,7 @@ struct SMMUv3State {
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
     struct SMMUv3AccelState  *s_accel;
+    Error  *migration_blocker;
 };
 
 typedef enum {
-- 
2.43.0


