Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B705CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E8z-00043B-VD; Mon, 29 Sep 2025 09:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E8B-00039Y-Mq; Mon, 29 Sep 2025 09:41:33 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E7c-0003nj-RK; Mon, 29 Sep 2025 09:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfxt1ct45levoitBC+ZdOSYyhzrpbp5QQ8+4/C5FljOQpCyBI5lOThXNS6/TeR/YYRKFPu4tRMBdlCcmZaxadAEMTropPHTEuVVGteP6AfROMUkPZUdY4yB7ukiz3A0mi3z/+jQj6WFr0xpSpfRbqxNsWcKLsCqHz+P7qnSBfPA/cTPu6GlhXINHN6GT7o/XzqxAkJG1KB6XjzJ3+l59TIBoIJYKwb45y0XyP+2s5rXPfIyzj551UqsJSArModhBd9BdF6izQXWp1NCgBww5AaE6FdSZhCfeWf+zPRYZJIHXsPtJBGKOl0D0305yX8PfFirxqg/oeKiVXActGXP2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y05lOc/F0yzTGAprW32qL/Sh2/EsDG4GzfbW8EmHc8=;
 b=GPQt45usZsvKzaZclMZI51hrqRcqs0E7P+xUvDtia2rz6r1i98wFzAt7tzx3CFlUtTRdO+Uxyei0yFabTazPEyDcoKx35Y5XAV8vs1lA+kyUsGDA2O6rDAg08pExdl0vOfC+x53doXGTG5d9iWXqoLzFeZ+sOi3zB0DmcvLSoj+3oXKZ8Ib8yH2mOLGoMAIlzUhYZkhr9UvYO8CCi3m6TQwmGmPR7T/zlBZnilfRE7i09uQLwojMsZpGRD8YTc7zsh/9TjG3mR1kWyc9MwjPcQzrvftOSPWZIH8ffDGyT15zimm52Ko6ui3Lv4PJbLcjs1hL3seqrqOIT31U7xq6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y05lOc/F0yzTGAprW32qL/Sh2/EsDG4GzfbW8EmHc8=;
 b=f3uw6hIGEkikf+KNFZPCJv9SNnGGMrekAndD0SZPjRVgTcA4hylKFKFGois4S0lFu5GCocj661mJc6Vr99z/+1/Vt731pjymCOoaEJpsfGqYLwKdgJP0GH9cVYGCd7j8eVWQqRP6PGubYM7hGePAhOwCe7zU/ZsWi+WQF2cYfgDJdDjZ5Z3sHFVdw9sx4M6K1MyOqJvkKOgEUVzJs4bYlyiiQiJvnnpKbjZJjKWn4YzfkY1gqdMYO5ScpRHwfKEvMldhqn8yv0lu3/PneE2zsj7INWd8T7LJ4XESKFWQwwxM7MV8lLSaa5DNeJlXRk6saKwBZGVE34afluUaPo9f/w==
Received: from CH2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:610:5a::32)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:39 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::c2) by CH2PR08CA0022.outlook.office365.com
 (2603:10b6:610:5a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 13:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:40:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 06:40:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:40:20 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on reset
Date: Mon, 29 Sep 2025 14:36:35 +0100
Message-ID: <20250929133643.38961-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: efda8cde-f01e-4649-1f3f-08ddff5dc711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MsBcBwVoxFa+pgm4c/SYLK0Ddod43Aw/5fY9G1lFpONhL6gio1pnkNwCjZGE?=
 =?us-ascii?Q?51Z/ViEJS3mTYZ68dJhhuIDZaduDmzkAm+UVv7Rt5xuGAg/caz9BV9d1OMem?=
 =?us-ascii?Q?g9rZqZ9dqRBbmECWdaNdznvwEphdB4tqWRN51y/FvbwZZpfdNW2lyEmnwCA8?=
 =?us-ascii?Q?lJogjjCXXdDWaleNOi1cNCQ/GXtD7UzOUYO+qBvvvrXBUtJZKaxAuUfUKH8G?=
 =?us-ascii?Q?F/37OL38jOBfZ6V1peVYoVP0TxveGFhXwfQgWC0zL9n+WrPL+tBtcsKgZ21k?=
 =?us-ascii?Q?a3ZUSTC91zrMXzSf8R9403sr+OkId7kUbhBTs1Hy/9s7QOPjmA2VQq1Xwq5O?=
 =?us-ascii?Q?uwRUY088ex+alV0oFjg6eAXVOsVyEhCfjqLAQuSgEcC/vuJC4cTR+OtI1b5J?=
 =?us-ascii?Q?MVq536p/MZdaoA4RmuCnnUomre+nM4TV/pbSkM4wT8pfFPjt7lXt2DStzSkV?=
 =?us-ascii?Q?Mp7LngytLznRNdhberpJgxjn6lqgCCFEU5hYIZq9loAP72LjWmCt1LIL8eSb?=
 =?us-ascii?Q?z1JZ18h9iRQV85phbXn5YUw7RHHcfoCMb8X1BsIsCWx0wC9HgDlywoJHjrtH?=
 =?us-ascii?Q?NRrbWrUNKJkFBtQKN9DCP9vM2shIlNgMZCYbMEVQKF7O/aKiWxXrWvYHnETl?=
 =?us-ascii?Q?X1le01Teuwv2c3eLI+4QwHTma4UoBIBQa09mwbBto8L/by7CwqxBR+0N25Ty?=
 =?us-ascii?Q?ixNJSz61bC+tB1nuXiCKmS6DFmWtHPic7njtzfrpX7/tJ19V/10eqxFYfKUX?=
 =?us-ascii?Q?0DOKuo/G0O7TaUfuYei9nMMYTHT+KfQAiXEHOLHrNbDIXCDYCfiWXzeLv4TX?=
 =?us-ascii?Q?e8W6/oq/ldYLOz1zmClk/fcdM6p+ioUNA8Zon05tsOnN7KaT//1+Lf6SztY5?=
 =?us-ascii?Q?B2/COZbe8K0XY9oyEmE12dSdEOKgNTa+t5q7RZmW5UCID+xG6bWw+5eMhPV2?=
 =?us-ascii?Q?T6CREYgUaFEemNTHS1cqV399laFuxJAu6Rp9FfIDmp1TFqxClQlKyA/ORl0+?=
 =?us-ascii?Q?F1Fid+074h6VC/iWZNHGEvJn1J6BpNtkIM4cnYI2BRqw+LacVSypOmmGmTf+?=
 =?us-ascii?Q?0RkoGixbPYd2z0/+5/m1QFP/S9KeN39G8z+Fz41FUeGsvG3vSX3eq9xOER7K?=
 =?us-ascii?Q?xnDm3GpoA0kuzQhYG33v46PoS202QlgU6EjZLUSTp46Twc8E47XjxaOVliWe?=
 =?us-ascii?Q?ygVN2n+RUg727UZ5LoNNGBZD4zi23gTDgRBSFkTLR3/q2ce4jJUMWr2P5w/I?=
 =?us-ascii?Q?6R19FIHco2tV/xFXYI56AV4X2E08hBIcfS2WpclRdS/kzBosKiWRVlR9aL84?=
 =?us-ascii?Q?p7J/PxMTAC/BkTHE613rBjfT+5FAbZv8dIXtR/37xDTwfVAwOVRDkhuAGn55?=
 =?us-ascii?Q?MYREzqZ7dLAhaoDZkfR7Ox0uv3dbirY6gfMe/Z2PJ3O1H4+fQTqo8OdBW/wa?=
 =?us-ascii?Q?6rlkkEoMpvllzJA4924UK1dpf/POUQ3jL5qjzH27Yhbqa7CSiUekm9xVTSkX?=
 =?us-ascii?Q?2qWXgTXTK+W3LRseEXugRdJEaI85Khv0UBE653bAu+5/faAjj6Dq72uq/ohT?=
 =?us-ascii?Q?ke+Rn4+ildGsXUQf9Fs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:39.1687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efda8cde-f01e-4649-1f3f-08ddff5dc711
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When the guest reboots with devices in nested mode (S1 + S2), any QEMU/UEFI
access to those devices can fail because S1 translation is not valid during
the reboot. For example, a passthrough NVMe device may hold GRUB boot info
that UEFI tries to read during the reboot.

Set S1 to bypass mode during reset to avoid such failures.

Reported-by: Matthew R. Ochs <mochs@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 29 +++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  4 ++++
 hw/arm/smmuv3.c       |  1 +
 3 files changed, 34 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index defeddbd8c..8396053a6c 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -634,6 +634,35 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_address_space = smmuv3_accel_find_msi_as,
 };
 
+/*
+ * If the guest reboots and devices are configured for S1+S2, Stage1 must
+ * be switched to bypass. Otherwise, QEMU/UEFI may fail when accessing a
+ * device, e.g. when UEFI retrieves boot partition information from an
+ * assigned vfio-pci NVMe device.
+ */
+void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)
+{
+    SMMUv3AccelDevice *accel_dev;
+    SMMUViommu *viommu;
+
+    if (!s->accel || !s->s_accel->viommu) {
+        return;
+    }
+
+    viommu = s->s_accel->viommu;
+    QLIST_FOREACH(accel_dev, &viommu->device_list, next) {
+        if (!accel_dev->vdev) {
+            continue;
+        }
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                                   viommu->bypass_hwpt_id,
+                                                   NULL)) {
+            error_report("Failed to install bypass hwpt id %u for dev id %u",
+                          viommu->bypass_hwpt_id, accel_dev->idev->devid);
+        }
+    }
+}
+
 void smmuv3_accel_init(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 3bdba47616..75f858e34a 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -48,6 +48,7 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                            Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
+void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -70,6 +71,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 {
     return true;
 }
+static inline void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5830cf5a03..94b2bbc374 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1913,6 +1913,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     if (c->parent_phases.exit) {
         c->parent_phases.exit(obj, type);
     }
+    smmuv3_accel_attach_bypass_hwpt(s);
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
-- 
2.43.0


