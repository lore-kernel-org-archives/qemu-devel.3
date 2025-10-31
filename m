Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DD3CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmn5-0007Vi-Cx; Fri, 31 Oct 2025 06:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmi-000759-TY; Fri, 31 Oct 2025 06:55:10 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmY-000348-Bb; Fri, 31 Oct 2025 06:55:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG8UDQzwnoeWFmJleiyG82HrIsBq160zP+/AvkAx5FgNYpeWtfS/U36Imt+/UfMrKJ9hCqRNimc1GCLYJa4HCvWQXQ5M7Uk8VeGX6Hc9/WY8Bx4g3bSwL6oVlMsHFaoK502l8WigV1eQKiMJ9S0IQT1dgMDx+ISMbjV9QmAIAxgfRF30BPKssbMaRTzyENkY3XrYh4TJfBCAx0KyxhJoAH6+O5CeAwzF2iUUIQk0cVgkZ4z3KUhkFGVKDKsNcIxr4CBpkJBL0az2Q7V3wYCNnqsXP/86WP82f+uy6C+k+JR4E8Jq9lITl/BE5q24QjRgnVA8IVu9KFvx2OpaG1YwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH9mjxg2kouO5o9J+if50959fgzIOxD5nTgCjCmcM7g=;
 b=AZtKGXdS1cuEoQ+P0ygvFuIHHdmb7DWZgUXwtbWUajKNyA0/FD+3kUCG8A8wuJEfvr3j5FZ0j9l3XkZ+WIlXRfwdqyEOZp0erPCKYxzShgq4E3c3O1B4CLwb2NY1j8Sq0rgUEUvuGJiG1O16DOvcFPo9+Ay+AsZVQJTOAiyqIw1gQfhTlNZN7BufjfdbDDUGaIVU77Z8GkzYLhRXZFb1t+VlzEnItpmNKE2lUJ44vpadb68Ci0wkgoU5tf/eNIE0NgyAfnMPI/i2tR77gSwYEVEqnlm5r+UR/RRf1JRWhkZjYIENPUetYOWSoambT8JjkCf9wnf11cF8183g0UEUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH9mjxg2kouO5o9J+if50959fgzIOxD5nTgCjCmcM7g=;
 b=h3jWilh2jWANBeMmrvkXVnysht2HIWiUIOHsf+PnsOayFho0shNIny6/enbr9nbxtaKu7x2YtxPXwG+H46WGHurhS5KvMBRYgTITNNv8lSQ/tnqgrZgLGYWno/sdsUdF5wFdvVQAJTURHaaF2Ug8YudVoqcOtsKoUQ5D4Lb2Ct7UkfwDaq9FbNPYXPBOxUuCmGY5wGSvMNVkbZCil2nQ5gzmTrZ5DInrt4mdfUFPFRw7MRT85sjsVoqUTdXUeK4rakorgoVEIwAJNUpnxbx4cmXqMH0Hg3JqxMbbiF2+AdNNOiyjRXAMd4gSsH3aeyS5iIx0x/hTgoT/KncDog028w==
Received: from MN2PR12CA0021.namprd12.prod.outlook.com (2603:10b6:208:a8::34)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:54:43 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:a8:cafe::cb) by MN2PR12CA0021.outlook.office365.com
 (2603:10b6:208:a8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:54:34 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:30 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 26/32] hw/arm/smmuv3-accel: Add a property to specify RIL
 support
Date: Fri, 31 Oct 2025 10:49:59 +0000
Message-ID: <20251031105005.24618-27-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: e1859523-4165-453e-618d-08de186be5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXJVWmwvS1E0Mm1sQ0ZaQ3pvdk42UzUwQ3prUnRPOTI2UW9sYnVZbytwRmlt?=
 =?utf-8?B?ZWpCeDE3aU13cE82emkxZkNLZFB1Um5aaE1rTDE3VklTS3ZTM1VRN1Q2MlQv?=
 =?utf-8?B?eC9tREp2bnpEaHM2YndtTS9YSXNFazZ3d1p3QXJ5aURoemJQbmNXWVRqazlW?=
 =?utf-8?B?SG5DdEFxcTUrNGlsdHVWQ2Zwa294K3pGRTFOS0htb2docmFPeEduRFVNVTc4?=
 =?utf-8?B?WmFVYU95bUNpMElOMTEydTdaRExUQmtWOHVtYy9jQ3FmRFNnaUJkVDJSQm1B?=
 =?utf-8?B?d29LaHZsVW9oc3ZBb0taMngyQzR5dzR6UDN4WXNxSmN4aVJyT2VINEJuV0Zp?=
 =?utf-8?B?TUF1Zkt0eDhFYmJnNFFQMWZCUURsRGUrcFBucnBybGVlQlVXRkZUTytkYTU0?=
 =?utf-8?B?Y0VUKzVzZGhXTFJta0dsS1RsV2JKM1JFM3Z0YWUvT1pXclFPWjFYM2tzWXli?=
 =?utf-8?B?Qm5yUDB1VjhuMEdTSW5zTVhaZDJrczFPT1ZZSmRBU2Q4WjM3OURZdUtyZHkx?=
 =?utf-8?B?ZWp3dUt4RVdBd2xqUzFGc01PKzNibDR0cVVQWS9FMUozbFlwOGJSN1NDb29m?=
 =?utf-8?B?Nzc1U2wrb2lWbHhJWitjRGVvU0R2OXdsb3F0c2RneUxPNWVJRUhJcktzcEhQ?=
 =?utf-8?B?Nzk1eS81NzM4bzhFSk5ma2dMYTdmbGVST0x2VWVvbVluMXdiTERuOTBVbS9E?=
 =?utf-8?B?SERITFUzYWIvQzdZREYrZmVrYmVWYjEzVDVFKzBBekJ0UTlOS1RhYk91SmJW?=
 =?utf-8?B?K1FlWGUxMDhpYTczektUbllVQTVJVWxOM3AyWVRtQ0x0RjZ6aXJMZG0yZFZh?=
 =?utf-8?B?RTJvYk5RdGUra3lnVmY3SGRGU1M4YlMzdFkxU3Q0OElEUGh5RWZIS0g2Q214?=
 =?utf-8?B?QmtKY0RORUtNQjJ1K21xRUJrQjltSTJiZWtrV1B1OHRzeXF0dGREc0gxMkRY?=
 =?utf-8?B?RGhJLzl2ZG1MMXBqRCtnZnpBTjRYRGZ3RldURE1jRm56TndNajJ6cG9iM0F3?=
 =?utf-8?B?cE1TVnR1NU5kcjRHSDlNdlR4T01KMVZnVDlBUkl3cExJbXF6N2FIdlNNaTVR?=
 =?utf-8?B?eENXNnoraEdQTkFCS1N3dkwrTDBPdjF4RDJlNjAybk53U0p0c29NZ2hWT1pX?=
 =?utf-8?B?ZEpnQzcwdXBRVEszclpEY3dubUlpVnh1VTlUbXdUNndKUHJ2ZEJnMFRyM3VJ?=
 =?utf-8?B?d0xkeXYwVWFBY1pZTVQvZXJiNlRVSlFzM0xYd1F6djNNcjFhOVV1RGVQOUZl?=
 =?utf-8?B?T1A3T29JaC9PYms0MzVPMzl0enBIL0VuRTg4WFpiMDBDelhaeHRtNVVXVFNM?=
 =?utf-8?B?UjVmTHNPb0M1MkcxbWV6aVUvNE9PTWNzc1AyekI4Z3dHS0ZrRklvOVRTQU1S?=
 =?utf-8?B?aDBhekFsQk4zK1A2citBSXBid09uNVBsb0F3Y3JrVjE2TTdGd1ZaSUU4Yy9j?=
 =?utf-8?B?dmZKamJYMEZLZ29GWjhmeDdxVVVaNVVmNmZSMmRIYXU3Z1ZwYytBNjYvUGh5?=
 =?utf-8?B?M25JMXdxekxrcmVFOXhRMDJYWW1ldEEzeFFQYXhGVlpEMnJ4OE1PSFdSL28x?=
 =?utf-8?B?VStPR2g2SGx6Ukw3SXpycFFzNlpCVDFjNFZwalA4emY0b3F1bDY4S1M3bThJ?=
 =?utf-8?B?WllqNVp3V2NJTVlKVldrNFFIQWxHQkdXTjRpanVZMmdMcU5MbDJOL2M4cE1u?=
 =?utf-8?B?cWE1SFA3WVNxTFFmYmdheDN2TFY3NHlUaktydjVNK3g4NFR0SkM2eXhsVGZk?=
 =?utf-8?B?QXFkOUxuVHJxbDB2R2luVUIwZ2NoMzQ2blNGTVhsa0FUQy9ZamZHNnYvRC9I?=
 =?utf-8?B?S0MrV3E3M0YxazZnemxPQjRFKzZmV2J4eGh4VmJ3Mk5yaUZuODJ3dklsZCt6?=
 =?utf-8?B?N3FRQ3pCbG5tWFdKa0YxNllhWnE4UEYydTVaTjRZZnAvUFdIM0cwU1RFMFoz?=
 =?utf-8?B?MHp3WS8vUmVvNWZyTEpBRTRJUWVXeWFON05QcmR2WSs2T0RUVjlURXRtNjRC?=
 =?utf-8?B?WjRZbGVpQzVSODI0M2VKYVVhNzBTbTdvUFBwdWtQMURwRzU5aGRVYkNXYzZN?=
 =?utf-8?B?aU16Q21BdjA5QWxDVittZ0prR0JRYTl0WEJXV0xjV1FBa21PcTZLd0wrWTk5?=
 =?utf-8?Q?Y+uQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:42.8510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1859523-4165-453e-618d-08de186be5de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
is enabled, RIL has to be compatible with host SMMUv3 support.

Add a property so that the user can specify this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 15 +++++++++++++--
 hw/arm/smmuv3-accel.h   |  4 ++++
 hw/arm/smmuv3.c         | 12 ++++++++++++
 include/hw/arm/smmuv3.h |  1 +
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 8b9f88dd8e..35298350cb 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -63,10 +63,10 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
-    /* QEMU SMMUv3 supports Range Invalidation by default */
+    /* User can disable QEMU SMMUv3 Range Invalidation support */
     if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
                 FIELD_EX32(s->idr[3], IDR3, RIL)) {
-        error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
+        error_setg(errp, "Host SMMUv3 differs in Range Invalidation support");
         return false;
     }
 
@@ -635,6 +635,17 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_address_space = smmuv3_accel_get_msi_as,
 };
 
+void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+    if (!s->accel) {
+        return;
+    }
+
+    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
+    if (!s->ril) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
+    }
+}
 
 /* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
 void smmuv3_accel_gbpa_update(SMMUv3State *s)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index ee79548370..4f5b672712 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -55,6 +55,7 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_gbpa_update(SMMUv3State *s);
 void smmuv3_accel_reset(SMMUv3State *s);
+void smmuv3_accel_idr_override(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -83,6 +84,9 @@ static inline void smmuv3_accel_gbpa_update(SMMUv3State *s)
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
+static inline void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f040e6b91e..b9d96f5762 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -305,6 +305,7 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
     s->aidr = 0x1;
+    smmuv3_accel_idr_override(s);
 }
 
 static void smmuv3_reset(SMMUv3State *s)
@@ -1936,6 +1937,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 #endif
+    if (!s->accel) {
+        if (!s->ril) {
+            error_setg(errp, "ril can only be disabled if accel=on");
+            return false;
+        }
+        return false;
+    }
     return true;
 }
 
@@ -2057,6 +2065,8 @@ static const Property smmuv3_properties[] = {
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
+    /* RIL can be turned off for accel cases */
+    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2084,6 +2094,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
                                           "Enable SMMUv3 accelerator support."
                                           "Allows host SMMUv3 to be configured "
                                           "in nested mode for vfio-pci dev assignment");
+    object_class_property_set_description(klass, "ril",
+        "Disable range invalidation support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 6b9c27a9c4..95202c2757 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -68,6 +68,7 @@ struct SMMUv3State {
     bool accel;
     struct SMMUv3AccelState *s_accel;
     Error *migration_blocker;
+    bool ril;
 };
 
 typedef enum {
-- 
2.43.0


