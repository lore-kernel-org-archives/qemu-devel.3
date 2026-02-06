Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3961EEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNCU-0004AU-UE; Fri, 06 Feb 2026 09:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAU-0000zU-47; Fri, 06 Feb 2026 09:50:47 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAS-0007Sg-H8; Fri, 06 Feb 2026 09:50:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9X1hyv/zTnh1m2ZdYn46bwwpK/U/FOZ+zjXujvAByNmkMmUgLIoG6aVsbpYGwRpF6FH08P5SH2ARtBFu1sM+ob0H27Q/oiPpmoL0s/yETFjxDqd/xOxoaKXkfx9uRqV1+fhmtCRByfI/iz+xA3Yv7LWGjWlxT2Zjlz2/ZeLJN/CHraBNeoaUR1y2sLUkww5d+16FXklp1RqlHeCVoATlHGn4/BMalf3qz9wIsVsH/qwpXD5snJJoG1BN1QJIGupjgUAzCDnpmVkbU/lxY8iN2IsO9Jmn8qo7zO8Uv4RJqaK9I2vZ/57lTQgFmDh645X8LXqT9yoG9jJ8cvCh0VCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0lq9Ea3aLcsTKBfpiHg2o0amzKUzPn1y4nT1LqyL+E=;
 b=vpLcyw6eGYsgliobuCILtZR69eEJ4RudC8mVMnrSuhrzSxJt8V6lHLRQX6zjYp+Lr4MGg1+LYIiwxLp1zVBp9dtrsvt8YsWJHJCWM4YAgCNMv7ZYv2v9odAzPSy4gkuk0A3aLC3KIawAXJA105kVJsQPh5Y4RnNGPTvx6Hl+oAX5IZ46mz90K6rL7naUgHuUxivanLc22eW8O3irBTYdRrSOH4QeSQ1DS/kED71xWmXlk0GL0mhykGKdkqKHmzaNVSgWyLxpCZ6WeMt027/xTzc1R9up/8zMKFyfQFNTxD89lZEY4XD24l1Vg8zvpnulT29FjE54reAzPmT0izJ+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0lq9Ea3aLcsTKBfpiHg2o0amzKUzPn1y4nT1LqyL+E=;
 b=lnCfHFw/5EeuXxvaDFjBsrevw+ahIAoAV2g3H99V2yJgUbJcWJY2BN8RkHkV7MOIGVFhBvJ0djB5Nza9PKyElm4iFHrley0E/7tuB2t/aFWNBljGc/8eKudON5ScDuBChwkINtLcKzBRT8xLPrYYknd27cn2Wk36Wmyt9FR+SIldOB2kPuOWl7wgdBtaa1CehREeHfqkwk2AAwa1YWsYOXe4CSuYuEKHb0r3ZpLSGuSu1h79ntqNPgFZEhq3OIr+gaElqhxl2x3gs/kDDc+GyBPFM/++YBJxh27A7NEofrwgeyVnap0gfhH+7TYu51eRY+sn4zHnRdqA88I5z6IeFQ==
Received: from BY3PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:217::33)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:50:32 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::31) by BY3PR04CA0028.outlook.office365.com
 (2603:10b6:a03:217::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 14:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:10 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:06 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 16/24] hw/arm/tegra241-cmdqv: Use VINTF page0 for mapped
 VCMDQ registers
Date: Fri, 6 Feb 2026 14:48:15 +0000
Message-ID: <20260206144823.80655-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: a14ca640-169b-43f0-0a64-08de658f13e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+kAaynSVbLxrX/c/1azfLOghu1ugrO/rZadRaUPM01dhshjyyr4xR0e5ToI1?=
 =?us-ascii?Q?tYF7sHdIJU7hNd9L8GqZF1IDY+6ni0thlKJCkhM2imeg/VZduwax7IPmPJsn?=
 =?us-ascii?Q?U4imdyHRkqFD9Kwyi3b1KjKs1bpIcTrh8GbWPSzytGiV5AJ8M8AIDtbLO8ff?=
 =?us-ascii?Q?2qT4uiwreULqydofvviUBRJlV4SCKv91taLznpRbBLMJSsegsGlylJSJpMvs?=
 =?us-ascii?Q?2jspWbCTfJwUCS0/N/vv3o3Z+PhKaSJnoz4KPzFQvUag21HaQV0+vEE6wHB3?=
 =?us-ascii?Q?G4IJPBI7ltzgU+BUdl2cFKhg4guFn9126aSo0eZMvN5ruRux/j/B+xHvNh30?=
 =?us-ascii?Q?hMG2j6h/GxTxO+Ar4BMtP902y2ICFGh9k42E/Y+81fBw9UIb9tRR4Ru70FaG?=
 =?us-ascii?Q?JhXZ1UNRkbDn/1T8PeZ9aj6bJtTQbD5xz9Tbc0N9EjbQS78gddvfD1hSDNxp?=
 =?us-ascii?Q?QS9L0qqnN2QjtaZnFp+Vt08vPGewYeTr0tXcObCIXoj/aQUjrjF2Q6JeXjyn?=
 =?us-ascii?Q?c02LmIxFEU9ZzpgUIudThht1WNoKJfck6BGfZeTy9S1hEWbNruKCldERwhdN?=
 =?us-ascii?Q?sz3V0mFlp0G64MhobqSet2xoviumzRIXhUhQ33Lfuap9GcifqDg2t42bb6Ii?=
 =?us-ascii?Q?UNNA9r9WKbeuk1y7iIxbe/nVhu/gY35EiVC8My231EgXwTysP0MyEP1daq5M?=
 =?us-ascii?Q?ae+xCvMYRBN24c0ztFJpV08EdpD9BztZb+KjazDTTyUqh3X5fSGaEf82rXHm?=
 =?us-ascii?Q?cpWRZ++jOP4SQlkLm01gE25ODmJQkRwphYb6OjRlaRr0B2EGLa61FuL860XW?=
 =?us-ascii?Q?LLJykkZDwiQt2YCVHo0bhhHgu3Q7bUX56n62r7XuoDHH6iW1rLruw34R3I+v?=
 =?us-ascii?Q?Y0JEDqsEVTuoJfMFysKxeTTJuiiPC1ECy8DqAfSCtaAFaL2+X8oPOUkNBYRX?=
 =?us-ascii?Q?o/tJ5ORYa/MyN8oG3ocQRFpM3vaRIh4IFhFrAwTUXE31gyZf2r2hbJLHUh96?=
 =?us-ascii?Q?6DjrBbRUG1BCKLiO90w7AIDwBB2quyCZSLMMbIyNnrznJHiVw+9oW0lQyJNP?=
 =?us-ascii?Q?oc8s+9mtoVJFAhaWgL4yWqiQvAyloynZLxfSz+kqy/NVmuhNUOaD5S9ItFDy?=
 =?us-ascii?Q?lMCdlY3U9aKQUSK8HUAn28gRBeXlVlG2H7ZciRnqOcO5G79h2G/Vo/aS5qdH?=
 =?us-ascii?Q?NxAh+nJhASozSQ1RJSxERa1oHT5fwaPyGUZ/SpKPirJj3QP+nf9TMhr84m4M?=
 =?us-ascii?Q?9c9GNNRZo4L4hWV0r9LFj4PksHjgswldsnUoapvttF3/8aO/WJ4psv8oGBfZ?=
 =?us-ascii?Q?d9oDSmaC9jqbe7G8RJVs+fL9t7ukVZDT90+zosbaW9GJp13CXqVx+udUUdJQ?=
 =?us-ascii?Q?/wMNCSzF3+f1EZfeMk5K1wfdLDD/yfSUsJbrBd6eCJINGXdb9USbIuvzgJFv?=
 =?us-ascii?Q?KlIepo0r/NfAL9duYXf1UM9myj0oNWQwAdamtGt+3MJfaOe0HugGpgmOXBCc?=
 =?us-ascii?Q?lTLHkicJB4Iv3p9CtSr+m7PuynuSxP/fFHYE8AUmBBRm89QCG2tvPkH7n8Yu?=
 =?us-ascii?Q?vZW8HtaECQlz595wwWlDZX/d5UszN1KLeL/+OCRtOzYTOtKwGEsMxT6LaP0y?=
 =?us-ascii?Q?0SbvypULxrd4pq0s+smSj8Cv6+H9meC6y7UC0SSZziOA6++rfHrQXQaOdB/y?=
 =?us-ascii?Q?0xVhVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UwpGxigGQnwcs5RJd4WAkTRnTOp0HR6jPFDt1I5EyQfI69OKfxxdl51cysrcsKuCE0dNOZph4IfoOxs9GYaeqjFT0bDho7/SEylVvuiaWfvmIuLp4bxWvgtSTdkwqG4bE34CL6kvGLGwRTo88mgQvF9WFI51Si3V2GJwJ0PZzjLb2MjZzMhxttvU+8J+VjyEp1jfWOwyprxKeQHm29/BBsPudbya6boUhtnS7tXx/mQss/SIegWQ57LAttQHEDjkrS4a54ijSjey1YY8tvSPT5GU93ed+/ENsv+vcgYbofvYeD2ujGuyNSaTtVJEe4RCk53GGkuhAPpKV6TOkpqvGK4Enb+DoBW6E5IJVluls1XYiumfbXjEnb8WdonO4dawB1u6Mytlc3MeKpfpoGAmHaFdSAIrwNeY+TV6tIWaGfrI1ncnYLTjwTHqSmypZURE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:31.9308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14ca640-169b-43f0-0a64-08de658f13e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

When a VCMDQ is mapped and VINTF page0 is available, read and write
VCMDQ registers directly via the VINTF page0 backing instead of using
cached register values.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 44 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 153fd70edb..c7e70d8e1d 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -38,12 +38,32 @@ static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
- *
- * All VCMDQ accesses are currently trapped. Use cached registers
  */
 static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
                                           int index)
 {
+
+    /*
+     * If this VCMDQ is mapped and VINTF page0 is available, read directly
+     * from the VINTF page0 backing. Otherwise, fall back to cached state.
+     */
+    if (cmdqv->vcmdq[index] && cmdqv->vintf_page0_mapped) {
+        uint64_t off = (index * 0x80) + (offset0 - 0x10000);
+        uint32_t *ptr = (uint32_t *)(cmdqv->vintf_page0 + off);
+
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_STATUS:
+        case A_VCMDQ0_GERROR:
+        case A_VCMDQ0_GERRORN:
+            return *ptr;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         return cmdqv->vcmdq_cons_indx[index];
@@ -241,6 +261,26 @@ tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
                            uint64_t value, unsigned size, Error **errp)
 {
 
+    /*
+     * If this VCMDQ is mapped and VINTF page0 is available, write directly
+     * to the VINTF page0 backing. Otherwise, update cached state.
+     */
+    if (cmdqv->vcmdq[index] && cmdqv->vintf_page0_mapped) {
+        uint64_t off = (index * 0x80) + (offset0 - 0x10000);
+        uint32_t *ptr = (uint32_t *)(cmdqv->vintf_page0 + off);
+
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_GERRORN:
+            *ptr = (uint32_t)value;
+            return;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         cmdqv->vcmdq_cons_indx[index] = value;
-- 
2.43.0


