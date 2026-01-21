Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEE8C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 18:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicSI-0005UN-QU; Wed, 21 Jan 2026 12:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSF-00052D-4E; Wed, 21 Jan 2026 12:57:19 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSD-00020U-Dh; Wed, 21 Jan 2026 12:57:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvBvXL7I/gylSOQqQrD7Q1QJgIDoEkajQCc10rQU4z5zYeIRt2cjiARtGv6+lJaHJ/CaplDWVKw6N0NA7vCOO+c7kSqDakfjtJHzVU0LfiaMAPm34ubNbpUh0Nknj/9VOLGCxIep4oObVd5XzMWOIO01k0ftI6FquYe1yOaqTOqVvxabo4WOWggPV+qVNMK6ERv0uQfmQ2GsACtFRL3hEacrVmnkiox5Jw9EArpcvgI2t3DIqwMjqugp0zUB4DpkBHqtpSwmEvwLmewRHSJ/OuZ4JM1Bl6m9u3wbflN0x5C0ZRT2As8uAHo3K4y09aKR98JKYITwgQNFdh3F2+eP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1xsAzGDAdcdPNV6VOkSzf89JAEVK1A+rmJSTaHldLI=;
 b=TNeKPZvwwxRlnAyG1KCYDhfyIizFfS/XHBcxsDwhznqp9pw33Kp9zSxb3IiKnX48nFxbrbKhx8OErv0Wnf5S9XGF1QmEmIovNPv98mSqQN+qtmWe9MuljJvZ2QSML9Je6jcrlra1sNmkNUQF/jc0cHv3K6aCbNBI09mizd95+Gkhq5cb09auGdmP8JlbfnaGAHfzXUoO/GG7Rk5hNLU1hJXkzsltUw038JQOZjWBnC6zSac+nD8o15IZJS2tGZAIruCr1fSWZ1S2Gkjw26GQW7dpd6fV61/vhwN5P29/1oL9L97tAt/lAHawDsQ+lkwTmEr8SQaiYg39mQRfAhU2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1xsAzGDAdcdPNV6VOkSzf89JAEVK1A+rmJSTaHldLI=;
 b=DnC5avSSYLBFzeFyc38YHGRPAX2u5BZU7GwtbAW8xPZxt8vmQhCNu9/Rp+1SZOCspbRYUXu4fkdUe/EuJUwD3PWnbxGeLW6diCiv2vKjpWtbdi8sgBdX4BtFffpn5JgBsRGGlzLhjwwqG3Vxm0ZpF0E4q0Gs1HfXjCPpKyEJcWUf21INm1gocrUYkeyK/gj+VH90wzw5lv6np76spRH8p91h1tdtwX0DDx0oTpuyvRf91vMZhE2YZsHVoZdXQtgD2IXNDcnCG6pwu0BCOGkQp9YE2XuOZysw1ys72yU5BiFpjY+NWlAtrgK00JAPYhmSaapqrKgs7USI+w8c5CPVcg==
Received: from BN9PR03CA0458.namprd03.prod.outlook.com (2603:10b6:408:139::13)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:57:10 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::e7) by BN9PR03CA0458.outlook.office365.com
 (2603:10b6:408:139::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:57:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:45 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:40 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 20/37] hw/arm/smmuv3: Initialize ID registers early during
 realize()
Date: Wed, 21 Jan 2026 17:52:25 +0000
Message-ID: <20260121175248.87649-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0e5d32-934a-4bac-663e-08de59167fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aC3XVedHqC7yJHv9/+EzMjXpX1qQTFL908fX7fiIlfbSqAQu9smCPRdUOL6Z?=
 =?us-ascii?Q?6V2wYvs/JEe3lmpqcldLxtPlxNZUEGJMDwk41motBxaPJrWUAZofNEDgXjgY?=
 =?us-ascii?Q?eoQ/sJCLSFKPuvje/YZ5iU29ByQXB6ailt7qNlC7+PeBE02sepSgwGJbgwPZ?=
 =?us-ascii?Q?RTx6pqPGt24IW9EbXllQNR06nSmOfoO6zz+eA4a4pzsfYhvhv4cahIzvRcSE?=
 =?us-ascii?Q?Ny8QvtD2cRDN6y3yaB7Wr5Ye40VuNGTTNMhBRm/BQvOX5Einl0LKnWCgAQBf?=
 =?us-ascii?Q?OuGp4vBeJRlHlG2TxO+WfF+JVOC7t89XrT9QOkjuVAh6Qe6TPB4uUfAeG0ZK?=
 =?us-ascii?Q?WUjD1wSfVWzN7Z3E2bQvi+kcm0uNJAs+kPEheShKKHa+W2jm4O+6sJRtzHBe?=
 =?us-ascii?Q?KfLlu2x2Gn9b72ZNKhaPsJb1GV9LwLUUGHfY7Jy1ksMYojFtxstjv/jKTwNk?=
 =?us-ascii?Q?eFWDT3mHEvUUJ51qnsU8oZdz+MWZL4FMRAUywoUhAlrtqvdX5H438dqGzxRT?=
 =?us-ascii?Q?gyksHLD4HiiwJPuKAkS4DJX43Sf7Qq894RtFreTb9aG5puY+V7JsiE4imqKE?=
 =?us-ascii?Q?CrQzHn9uFGD1zj/Y+MErEAoem/y7+UuhNJoFDYcvJQ3tkGLKNJoPcq8x8mbm?=
 =?us-ascii?Q?+deYw/QyUllmDrGaip4st+rNNaNN/LxJXK4OW2/9LxCvAjlGgrQ/45n1+FZW?=
 =?us-ascii?Q?HxSKaKfKMRhTFfwd+SjCZGhlgCnrYgN5w1RvxcxX9ndndTtrWqtzOgCFQ5x/?=
 =?us-ascii?Q?z2zlMwz+fzqBHC400qH4UCZqfcf9AgYF0mwVOpPZj8dRgRjNd4NXsIiGN1Ju?=
 =?us-ascii?Q?0Iar1r0JG6p1WmSh37AU6w9LWxDnt5irquX7gndzrKYimkQgDhAjlKDFL4W+?=
 =?us-ascii?Q?fAiPPWrm7I60qdjMHzYqLpVTvcD6eVBK/4he5U+Gtk4Pp9Zl8aNbRSZOf4Ip?=
 =?us-ascii?Q?aaGlu8VDps5PlvomT49Hsd3+8IRA5tkjfapG1kIQZGAATdIqn+WzVtcHFV4D?=
 =?us-ascii?Q?6ztAFj/lrQSEQq4zcLqvWx9jttyvzDe6ZtXGR4LiF28+u9KChaBWDmT8k7/H?=
 =?us-ascii?Q?WP8aJ0zNlmqTeLysAFR23OKnh0Z28gVGy8TPeBHYEhcU/1WwCwp4ZIPDIgNq?=
 =?us-ascii?Q?s3/L+itbGynefi32HBHpY9UEtR0XWYfUZBnViTgUtbBKxmAcPh57HdFCn5QR?=
 =?us-ascii?Q?sdeZi3SGfgqR1ApXeGd7ZOY13ffTPjo9oijhmeRydppoZFezrwGyy0Ep5vBH?=
 =?us-ascii?Q?Lu6JNK5VQ+WhlKmBXwMz5gBOMHPNyofloS4iLaHGUdCyCyQ/rWCsqoY1053E?=
 =?us-ascii?Q?iMSLpbS8+fAS7xL/MYnnUg/a1Ua6S0zJP7ZVvH4jIbibVChImGxB/dLVLlDY?=
 =?us-ascii?Q?KpfJdSOrEnMCXx/Jw496v7FtnoIrdNxSogiJpLkuKBqPmMvsQw2qm0tkwsS4?=
 =?us-ascii?Q?2e1DM/EHGkAvrzDSQXaWp4/WH1R6TEwjRQE7V5fYXg9Oa0UZyXAXZUupNKoB?=
 =?us-ascii?Q?fODkg2UBf3lfdNu9uSlgY3ZMiZAtg5RO07D08FVBBmE2+ELoFCcF9HCTKYSd?=
 =?us-ascii?Q?SnlVXVkC6TXZG3nvBrw2Cl9OnWwES4b87abXJvYHnOrGYMT3T6EFj+NnSRJz?=
 =?us-ascii?Q?TO7vkyXTcg8SeH3NhsJcVKz8LJQLLPb09I9ZV/FQt7bUrUDox7WqKdDpbRni?=
 =?us-ascii?Q?51EpIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:10.0220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0e5d32-934a-4bac-663e-08de59167fd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Factor out ID register init into smmuv3_init_id_regs() and call it from
realize(). This ensures ID registers are initialized early for use in the
accelerated SMMUv3 path and will be utilized in subsequent patch.

Other registers remain initialized in smmuv3_reset().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4efef73373..e301bb467d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -258,7 +258,12 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     info->recorded = true;
 }
 
-static void smmuv3_init_regs(SMMUv3State *s)
+/*
+ * Called during realize(), as the ID registers will be accessed early in the
+ * SMMUv3 accel path for feature compatibility checks. The remaining registers
+ * are initialized later in smmuv3_reset().
+ */
+static void smmuv3_init_id_regs(SMMUv3State *s)
 {
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
@@ -298,7 +303,11 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
+    s->aidr = 0x1;
+}
 
+static void smmuv3_reset(SMMUv3State *s)
+{
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
     s->cmdq.prod = 0;
     s->cmdq.cons = 0;
@@ -310,7 +319,6 @@ static void smmuv3_init_regs(SMMUv3State *s)
 
     s->features = 0;
     s->sid_split = 0;
-    s->aidr = 0x1;
     s->cr[0] = 0;
     s->cr0ack = 0;
     s->irq_ctrl = 0;
@@ -1903,7 +1911,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
         c->parent_phases.exit(obj, type);
     }
 
-    smmuv3_init_regs(s);
+    smmuv3_reset(s);
     smmuv3_accel_reset(s);
 }
 
@@ -1935,6 +1943,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
     sysbus_init_mmio(dev, &sys->iomem);
 
     smmu_init_irq(s, dev);
+    smmuv3_init_id_regs(s);
 }
 
 static const VMStateDescription vmstate_smmuv3_queue = {
-- 
2.43.0


