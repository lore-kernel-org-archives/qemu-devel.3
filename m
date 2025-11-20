Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6042CCF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4eg-0007GU-Vc; Thu, 20 Nov 2025 08:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eT-0006lF-Rl; Thu, 20 Nov 2025 08:24:48 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4eR-0002Ky-II; Thu, 20 Nov 2025 08:24:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ibf1H5XeFE70VtGgDOaq2LrbAAbnfyNtGkcDCswxVAqD9H9IySVNSrHdHjkJGwz+xIbqrzq3ufLl0rI1THCl28uN5SLpl0wO9lVPJF/4Uqv7HN3iNysPZ4tzn0tmMBRscArpCkn0pc+ZcriVXN2X0oTxyjkvniKufrO6QDkomfnR9tEpPbw/X9dDcM/kvIcLmTwZdGIoVyTSkDPjIZIyuFblloYg8dBz+Jv5fgU2Jq/kMtZxvf9Lg8kdmkR2uFI92gMdPwQToaP+2FyM4EMK+EP1mcuxR4KyMNq8qMnJ5aM1PkdjupogpswrKn0VEt9+oa/VRlTgM/leKHZsv8NPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rut3qctFBCSe30FQNAxyNxM5Vtp9yOPXdOaUnFshpqs=;
 b=CS+mdDQDQxsYg9hH6Ppy/75d6hRaTMQnqw6RVa4VE0Lt7Nn+GfE/INIqU0pS701Jhgv80HZi/S/wD1vTwrjAZmctPQIUdSwv7y4PXpBjK2EafAKKq6A0YOJ6q6fUxZU7ovfe344zcDng8OswOWBq+7GFA/oly7yTO+EMQZ8n9v370AvQHPNic8VCqJG8jC/9cJiEPZbAAcLEWrHTzxF7aCK/JBi/shZRgBvf/RfkknEaE7LAi9z30HeH67RBXBlDpsiiYld2bGKV2NQeMSuEOBYBSO6QU2bO/Czvg5GqAliOvmtXqOsx2vLN0+A4YSJMdGGZJYLf+uhbprx1rcetYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rut3qctFBCSe30FQNAxyNxM5Vtp9yOPXdOaUnFshpqs=;
 b=OSELDv49FZUYcxg4Ftu5bRrCXvxXo+6X89QnRQHUI+eIWv5/yOjEzVzmMtu4Cm1vSejY9Xn1DKhLtS7qKz8th6gghRXNWFyzissDsouqO80nBsch2GyGswYScQXgUI5Pbwa0MP1dKVeB7228u5ydKLW+pz1o9OuenmkZ2oUVinIgKZxp7AYcbmukmm39/uzMT/mzfUTKrmIn96XBX1n7vnK/i2qUF/l7b5G7DGBjWdYbncEYIkkZEdTOqgCcu5yyC4TilVavvKSpD4VreSvLSjIMUojNPrliyBIF/5f3CkJpAQy3dj4h12qEgaJE4TCJDST5IiEc3up6fQZQ8ZQSjA==
Received: from CH5P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::16)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 13:24:36 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::83) by CH5P220CA0004.outlook.office365.com
 (2603:10b6:610:1ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:21 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:24:18 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 15/33] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
Date: Thu, 20 Nov 2025 13:21:55 +0000
Message-ID: <20251120132213.56581-16-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb5974e-f974-4fbe-1d26-08de283826bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8iBpbjQv0DbH27jcf9DIxCEOwvSbadh1RaVrqVGOjUVhov6qPfr/VJCtJ8QO?=
 =?us-ascii?Q?zq0MDBsT5W/sbN1l6DcXfXOtM9nL6EkK56pZiInentjGLN6P4kt4+nptDsus?=
 =?us-ascii?Q?BEl3HUNKQ+Hm4kHwmWGF4IOJZbEMQpWvTl8b0en/kHNO9Fm/UVG9sXaF61Ed?=
 =?us-ascii?Q?luAJhZ40SQ0leDC1oYuv6tR/eFI2+ztB4JnSWqjA6jsniUG+XIknTbd3ScHS?=
 =?us-ascii?Q?BPMRUj9qQvlpEDnXwzylJ1l7wrZMcqg9Uqo4gxwSEfgx4vIiuTWfH43iv399?=
 =?us-ascii?Q?uWplw0Ldre68f3w76cjd88QlXsfsZ+AKNqO1ytrQ88PohnCAuYqQfkB80kuI?=
 =?us-ascii?Q?OLgLyROar/NtCwuhBhHK9D4B6SivpYpBqO/Z4Bvi2CDrShNcbEtvYg0ljXOC?=
 =?us-ascii?Q?nWGy8fCTp48x4W2Jd0q9jQhkVFKsu3AGWuk9h34pgKO4vsCXGQcq9wrqtsz4?=
 =?us-ascii?Q?C0E+ySCjhWO0v7pOmUer90XIxABJ1c0SkbumRJza193xw0u6Gf5UmcePtmAY?=
 =?us-ascii?Q?JWaPUsMQb3LeJwDE2lkgtg4efk7iafMK8F5bJEUatrY7yIrfCLWn/D+8vpwC?=
 =?us-ascii?Q?M0BZbEN6jKl8oNS5XDCLOUemEqrKd1F5nMIqEDBWILS2KfxvQQdYUaSMtIT3?=
 =?us-ascii?Q?FCigvS5mDJyp50Av+JYcr/rV3TJHvv4HKuSwuhY0wuvNZmHz2mgx3sTcF7Lg?=
 =?us-ascii?Q?cFtd7OsSbKRwovrrTF75DXPuteGEyCW29ZJ8Jvw6TDcDf7ZViVHy9/uOirLI?=
 =?us-ascii?Q?Bwx6v1CiuZjqiDb9vAFV8dkbxUZrem+14EIUD6IHNrTu9+PaRIaQVbh+1kPf?=
 =?us-ascii?Q?hwLG+4KWGtURLLnoX3w8PKhU18XuHi+SlXXp8g9KSg04eQEwnS4tm31EZk/C?=
 =?us-ascii?Q?rz1Gn4RdEmj8n/f6fjQmoD2d0SsMS9NpWZrDwiHgSxsGTK+THO/PtKHv2uZI?=
 =?us-ascii?Q?YPU8fP4B3W09154+8SXrv90pgbQFxK1eqx6xqeTHoDJHwb2CGGU6Xrg8BuyJ?=
 =?us-ascii?Q?tf/myrk6xCmEl6CwijT+b1fEkrQNJ7yLCu6CuD9SutqP4PBbPYoYJxh8dEiS?=
 =?us-ascii?Q?oyjalaI+0QKQ/ypZLeUxQgSDyZhTudKKM1akKyGojgYZrD2l9OsX4+cYHO97?=
 =?us-ascii?Q?h4hqJPInk0nM7YoQH8yuL/8pSwU/xsOwT34CdHFGbMY710QkVy75kA5wC8Ew?=
 =?us-ascii?Q?oG02J4eMS6TItd4QFDBFqjtsgSaeprTYFf01TgtuYnl90QgDZcr8kPoYqQSg?=
 =?us-ascii?Q?LCp9fQTjdXBaI0s4Nzsy42Ja1Zx8afylnstDuKk4n6KTOkVA8XusgiQs17xc?=
 =?us-ascii?Q?iQrhn3rVKdBMBCjxRWgMHCSTteT2NXp48lqx651O7/15eTStcDhAZO8gz0CR?=
 =?us-ascii?Q?WlqOyrBr6oVlgObtRJ4LZBxzYocYwQYV0+5QBmn1mUEpYcwSppnP3RhgAL48?=
 =?us-ascii?Q?qZ1IB+/86ZN3DtPmMRp+yFCKOJcoI1ilFe1EK6TxTEldsJcL+gDGja+ql3jv?=
 =?us-ascii?Q?dLJWTkrVWK49FRRxkP51vSp+5l9pl65vhd+kIvTsiBDPTuW4lk23sZEkCICz?=
 =?us-ascii?Q?Ml4LsRB6uwP6KOOIHUw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:36.4907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb5974e-f974-4fbe-1d26-08de283826bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On guest reboot or on GBPA update, attach a nested HWPT based on the
GPBA.ABORT bit which either aborts all incoming transactions or bypasses
them.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  9 +++++++++
 hw/arm/smmuv3.c       |  2 ++
 3 files changed, 47 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 2e42d2d484..65b577f49a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -498,6 +498,42 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
+/* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+    uint32_t hwpt_id;
+
+    if (!accel) {
+        return true;
+    }
+
+    hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
+                                                   &local_err)) {
+            error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
+                              "idev devid %u", hwpt_id, accel_dev->idev->devid);
+            error_report_err(local_err);
+            local_err = NULL;
+            all_ok = false;
+        }
+    }
+    if (!all_ok) {
+        error_setg(errp, "Failed to attach all GBPA based HWPTs properly");
+    }
+    return all_ok;
+}
+
+void smmuv3_accel_reset(SMMUv3State *s)
+{
+     /* Attach a HWPT based on GBPA reset value */
+     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+}
+
 static void smmuv3_accel_as_init(SMMUv3State *s)
 {
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index ae896cfa8b..2d2d005658 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -44,6 +44,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -60,6 +62,13 @@ smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 {
     return true;
 }
+static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+static inline void smmuv3_accel_reset(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index bfb41b8866..42c60b1ec8 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1600,6 +1600,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
+            smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
         }
         break;
     case A_STRTAB_BASE: /* 64b */
@@ -1887,6 +1888,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     }
 
     smmuv3_init_regs(s);
+    smmuv3_accel_reset(s);
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
-- 
2.43.0


