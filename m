Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765B7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmnF-00086A-QV; Fri, 31 Oct 2025 06:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmx-0007Jr-2E; Fri, 31 Oct 2025 06:55:23 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmmo-00035s-88; Fri, 31 Oct 2025 06:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7l7M18YdkHjRzN7qKPQkbJRF9w0zquMGLN4Ncb1VAQYo4msKfvTCFGJoPegwBxXluijWFp9srzzOEP+9uIL2dYVjMbp+LRfnWQxXmqz5SuqOe8J/HFsaASXK3jQPZQLLd1QzNA2f253+0sWvk9zTS09iL7Iuce28XlbCZqKNVi+rjhmqbPTnLpc87J7KSGN0YXYHK5AeUttrhecK9jlUuxxdcF1zopFX1EbgWO8oQhgEP4GETLT8q1/pzcn161VCbTLB2L+FSyi+HfAhO6aG9xFzbErhgTxklGM0Y4EwAuzmmiOnCvtqgVUjBRE99sEenpjE5vxcV13blTNMvJlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBazrr0JimmmpntV4QYv7Hnj6RiDU9fJDnZUh01DEsA=;
 b=iKHulP2PotUAesfFVFJjdIolLje7BN+EGPH8W1JUQvFYHLbOxGllAtHERUqeQ7LQxJhhTSaBhyFOCpwn24PNm9lgIsN5szk02FIfmFAIFbGqM9cIyFg0Hm884TYWJvUMYvlSTVqW1qGjOVEEpVKc5YJWGAJGivcTStwh+219rBFCRW6ePhFncFXf1PPrsgGAkLQG2Tm0JpZSY20SJOSqN3AJgpjLxyeVhPvwiIuQJT1+4DL2QHEkje8c2Ahse7FSE/m+nMOwQR+qBDTmJ+1KIoTDEKqj1e1GyohLkj89fRT9YEJEYhSthzSxD1UUeY6LZHwbx+Qam4CeYSjlHAZ86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBazrr0JimmmpntV4QYv7Hnj6RiDU9fJDnZUh01DEsA=;
 b=KpH8/3Sa0qRdkWf7jBA3LEIozCqn3xGQl+26LWcRyXp9/pJGgERHpGWmNJXT4tarAb1s7+4grXDyH+nLnGcB6bn//2K11wFd36J3ar28zRs1rIkR+Kw3+0yqvVPES/1OMKdoMGSRsA4QoMu0B/fNdq1CpXNp0gmFWYMIKo4pm4wbQ5rLe+OdDmY5i/EADOC3fWztToowAMux3Qu5f6Gz0PLhjlQcb0Fb5BW2Hjetu0y8kHQNQA1QuAUgduk9KCVc8JCNjkEObcEfEoLMIBDLFbbEZEjwDuKWoSjXHWKvoVY7TdO/UaJhPEbj8WOBpb3vWYk/urGmTlJHIUwgGwCtlg==
Received: from BL0PR0102CA0031.prod.exchangelabs.com (2603:10b6:207:18::44) by
 MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:54:54 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:207:18:cafe::fe) by BL0PR0102CA0031.outlook.office365.com
 (2603:10b6:207:18::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:54:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:54:44 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:54:40 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 28/32] hw/arm/smmuv3-accel: Add property to specify OAS bits
Date: Fri, 31 Oct 2025 10:50:01 +0000
Message-ID: <20251031105005.24618-29-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 2410e5cb-efe8-4637-9a52-08de186beca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ouoAgBzl+RCFCeEXW/jRwCUw/KWQW5x79+TeQXqW3F26swdhjG70z7OrUVTg?=
 =?us-ascii?Q?cqIulWjELVFrxilA40+nkwhstpVJYXUdSF2LsroNN2ZDTrtP7F9aTpDeeCgO?=
 =?us-ascii?Q?DbHVaVrJdh6+rTT0F6Mob6XrcxPZgCn6IHdsApM+a5fEmCdUWypKKCDqbe4E?=
 =?us-ascii?Q?EDPLXX4IGnQFawdZ/TkYBdiAJel7sDUm2PGHJjilTJB3La2rRPMistN6nm2e?=
 =?us-ascii?Q?AWsf+iNl5pMPN/Lzow2OyB0pKrJBl/hh3KOTHj/L079GucES0/NjY5RmPeJo?=
 =?us-ascii?Q?Q14MLp8cflv9q/wDleCVKT4grrNl7Ia0yqSMasmcCte1sOLmvwRZOYcTNt1N?=
 =?us-ascii?Q?GqgiQmcG/lUaLkrPRHEdE4xTRVtArx4X4qdTik/VpnnZa5SRCPlxaiBgY6R3?=
 =?us-ascii?Q?ny2W/V/Z7/0Ol4fe89/ck2qFRAmRAAUKuMZhk5mRUT3rxTTCv8HVx0HbdtYm?=
 =?us-ascii?Q?tDFyr2EJOLr/09/ugTkOe5AQ6Mpk2vuRtrKN2945VyD6uzlySQ9Wjaf8XwIS?=
 =?us-ascii?Q?q7wNatxlFeDr8uW4BjmSw/fAL/7dIsDca2/VuHr/IJoGWZjmj0BUSdbowwY4?=
 =?us-ascii?Q?MHfVJxZ7q1QTL9lLnR726A6e4ZQ9CqbxfWUzED5hp5FyoKb4n/mksJyMpjSu?=
 =?us-ascii?Q?HTHCuzi5VuIA5K5yKm5atk2yrIuZlGFzoFjYx/d2uCt9GqP3XwwPp3wKehLk?=
 =?us-ascii?Q?OQpNXk+ehqax1IkuVjTneneja1Y/3dcssDuImrgEQfwJJ/aP1b+WaPF/Cg9M?=
 =?us-ascii?Q?746t1+MCXH9p0ZL+j4logKx3G8338JsxXW6uHBVgbiu4krW5YIcEdzHDjQEp?=
 =?us-ascii?Q?ngfV8ShR8RCOZifTwXk9cAp59AucmUiE4kTcEZUugJCplfPICDNDSGaNUb9N?=
 =?us-ascii?Q?MVTbVSr5e3rfuM0yzaCBw70OX6cLz8V0svaO1+jMs3hLCy0pU3NgceL8/pzd?=
 =?us-ascii?Q?drNj5iQRE6yP35MMW+k0GWX+nkMVWUp9HhOev+0mOvfsZI7xjYUdHSKh9Q/h?=
 =?us-ascii?Q?udChq9Uoa87dzFoWbsPKco2IV/S10gFY/4oBfPmipDkUj/sFPbukES+Mp1RD?=
 =?us-ascii?Q?/x/YXJ5Z2m9GrB8W98qoGdOZtcLd/Uwok+NslYGUxRZKEht+YAGj07h3D1J0?=
 =?us-ascii?Q?fVFe/5XY9s9ix8LtZBvNGPrCEVZReyU9TERw7eZNOB42TEeOB1VUTdUmwUwg?=
 =?us-ascii?Q?DODAQ8uSqjpj3ClwqY9fkEELcAxUxKNgNPtA6a8vQbJPwM7XGxhOmQD7iirU?=
 =?us-ascii?Q?ouqTlvB4wcb+wjuCf+Zng7MR54xltO96G+RiQAXIJm/8ChcE6ny1L2eIHr2I?=
 =?us-ascii?Q?455o+A3UzRtAWBKD7qOpOg6RqcWkfcGn57ukKZtA+1jKOYYVspTYiI/3E80D?=
 =?us-ascii?Q?vbPo6Z6QAbvsBZ9rrFV36GwZmrQ5kmabH8A7BFjW+5YsDxWi+ClUCd7xV+4w?=
 =?us-ascii?Q?RT1yn5VloHJMQg+jDzplN+Rag+nAHle1pcvvu81/dNuE28NYtnc1NZGcCRI6?=
 =?us-ascii?Q?q/XhWuRNKKPEStJPnD/lQtLz+dS9yy+Jed0h7+rPdQdtoYM1IXqn+NVRhze8?=
 =?us-ascii?Q?kMxAYw3wUut92aS/KTw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:54:54.2506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2410e5cb-efe8-4637-9a52-08de186beca8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits. With
accelerator mode enabled, a guest device may use SVA where CPU page tables
are shared with SMMUv3, requiring OAS at least equal to the CPU OAS. Add
a user option to set this.

Note: Linux kernel docs currently state the OAS field in the IDR register
is not meaningful for users. But looks like we need this information.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 22 ++++++++++++++++++++++
 hw/arm/smmuv3-internal.h |  3 ++-
 hw/arm/smmuv3.c          | 16 +++++++++++++++-
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 5b0ef3804a..c46510150e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -28,6 +28,12 @@ MemoryRegion root;
 MemoryRegion sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static int smmuv3_oas_bits(uint32_t oas)
+{
+    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
+    return (oas < ARRAY_SIZE(map)) ? map[oas] : -EINVAL;
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
@@ -70,6 +76,18 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
+    /*
+     * TODO: OAS is not something Linux kernel doc says meaningful for user.
+     * But looks like OAS needs to be compatible for accelerator support. Please
+     * check.
+     */
+    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
+                FIELD_EX32(s->idr[5], IDR5, OAS)) {
+        error_setg(errp, "Host SMMUv3 OAS(%d) bits not compatible",
+                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)));
+        return false;
+    }
+
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
                 FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
@@ -649,6 +667,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     if (s->ats) {
         s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1); /* ATS */
     }
+    /* QEMU SMMUv3 has OAS set 44. Update IDR5 if user has it set to 48 bits*/
+    if (s->oas == 48) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+    }
 }
 
 /* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 5fd88b4257..cfc5897569 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -111,7 +111,8 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_IDR5_OAS_44 4
+#define SMMU_IDR5_OAS_48 5
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index d95279a733..c4d28a3786 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -299,7 +299,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* OAS: 44 bits */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1961,6 +1962,15 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
+        if (s->oas != 44) {
+            error_setg(errp, "OAS can only be set to 44 bits if accel=off");
+            return false;
+        }
+        return false;
+    }
+
+    if (s->oas != 44 && s->oas != 48) {
+        error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
     return true;
@@ -2087,6 +2097,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2119,6 +2130,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this");
+    object_class_property_set_description(klass, "oas",
+        "Specify Output Address Size (for accel =on). Supported values "
+        "are 44 or 48 bits. Defaults to 44 bits");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 5fd5ec7b49..e4226b66f3 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -70,6 +70,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     bool ril;
     bool ats;
+    uint8_t oas;
 };
 
 typedef enum {
-- 
2.43.0


