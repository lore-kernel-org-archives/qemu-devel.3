Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C7CCA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9s-0004qD-Qn; Sat, 30 Aug 2025 11:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUP-0002uA-94; Fri, 29 Aug 2025 04:29:41 -0400
Received: from mail-co1nam11on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2416::609]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUK-0006Pg-FR; Fri, 29 Aug 2025 04:29:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEUPi5FD7pmWirSitcUXyGKDPFCICpgXSKQMboznznNPkB8/AW6vDd0AyrlqNw6pV89Xn/pJoXH3hVmhn8V3pFyXCdfN1p0on+/qNW34kETDXXh4rmXv7cUq57CggjdO9fwXafSMD+DESQSyac6Rbthp+BWYWaF0Elc0BS09s2ZcSB1cxnmzmpRrcLTW6clNRV6LcUOchDsZA6M8wwH/XRqEureqUKeL6ur1sFFqAXaxkN2Ngc4B2zRAiqcWtsyVPBXnpScCcdXKBFkKqCG1UNHTE+S5uFeuHGvW+sqw4d2xEWzK4DpkI965cHRjGNFwkRhLDwi4xPgj6u3bWrxFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiuWu3euAYwxQjZogCjngvPToHKnsSxrZjoKOqG/pPc=;
 b=pG3dCxOIw7/wbj2l9PxVG8rQ3VmvZJFAWifXpjvBm8NNcvR5b+ckL1bb5r0ae72sLHq/h6hRNdA3SwTfhk1rjTJggjJ1cJVDr/mCuxsShOBRUn0WNT+isdfS5h+cPgz538QiFM4+I6RDb/ldQfCIfNZBIg83HN4xaf7KTl/gevVX9C+WThmUcFG7Ensfl56w4Q91VrufgfDy7b/t8Usk43kPXvx91oQbCl7OvZUtxX5j2NUtcQzMbGWG7/nHCQIR0TA3LQPb0MI2qiLpjq6V/uK7bdl/y5sBpL1ujedx/vGU9G4SoYg7Vzk7IKGIksdsgbzeGesL+hSqiuI/WkQRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiuWu3euAYwxQjZogCjngvPToHKnsSxrZjoKOqG/pPc=;
 b=m/yEl+NSUtkS/hrEDrwJMhGwvczXm129sOcZiWCpDz6dCYaXjl/urDkUtv7oqZDYiZrvTuYA3aIV/0JIyibcEJa3qBW7C6zni5NQudVmwCnbi+iuYSWt+7C5QXCktETyFpasOu/G+YXd/ulM0Ahac5O39SyfeRpt0kkHllBVvJWzBakqWIwpK10upEy32+zhn4BULC4AGDrkVQkXM5FpL7+6pto1AFOv36wR1UIlPbFhalVInDCFbdALyByufmlkk/apPMZgO/sHhUo6wGfUYBo0xHVVSKrE4GmEmyI407Ze6N93SvyHd24X2O0+dGN7uLmNq6lUHkI9xRqTTE57sQ==
Received: from BYAPR08CA0041.namprd08.prod.outlook.com (2603:10b6:a03:117::18)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:29:20 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::b) by BYAPR08CA0041.outlook.office365.com
 (2603:10b6:a03:117::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 08:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:02 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:28:57 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 05/11] hw/arm/virt: Add an SMMU_IO_LEN macro
Date: Fri, 29 Aug 2025 09:25:27 +0100
Message-ID: <20250829082543.7680-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 578c7ebc-badc-4ea1-c490-08dde6d62678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WEtfpa3eAxcU5FXwcFNkVIO+Gme9I8M7UReAG85GFJI9KfxrCwgBkNbZM40o?=
 =?us-ascii?Q?lwSFXuwDpDRwxHQo4D9mQvN20EOQYvU0wPnTzSDrLvS+Zt9XeiDO/BllpzJ1?=
 =?us-ascii?Q?gvtO2c79h494s0hL86GXvQvoK1QW/NefKLnKPNV9AR/IDu2hODp2n7ZJcQ8K?=
 =?us-ascii?Q?AGhn4mSmlIjdMg9KZE1X3eq9LjhVzzYPfaXbfNzwlwrFGOIL6xOwcukYFg54?=
 =?us-ascii?Q?Ox2WreFZhDhtJ3+vcCxwG4v7KsDIK4UWp4QQjbrEL46PO2dIcJVTBkmMrMPm?=
 =?us-ascii?Q?KVLwBziiNjAUNGTNe5BAusgRFdQE6p/ySaE8A8MMWtrF0eo3Uh0AmvkI1D2w?=
 =?us-ascii?Q?zJBeNY206mVYzOnCOmRl0KetOXxkEEMaPGtN9y4m2LntXRrVUNYOPF+E0XCp?=
 =?us-ascii?Q?GC5t+PnxpLFDFiUFLiwYCGY3tEG/Z06N6Fh3zA+5S/5IHJGJySWIQG1BIJXt?=
 =?us-ascii?Q?hf285GDnazt6Bv0GyxASmJnmzHP2ITN7b5XqWcxFHOTXlggn6SbxBICbO09t?=
 =?us-ascii?Q?QVdCMQrUs7HK9gOd4C8tkgoeQVZ0MuelFlYPbQHGq07XWhFY77SKWpPUXqXm?=
 =?us-ascii?Q?8MC9nPXZo5zduE8EHX1ePz+ncVRecZZ7Lf3u2nWFWOQ2kiunjM0MtdO3Ywvt?=
 =?us-ascii?Q?x44nFRVKFMjqbuO0oPjkCz/b7Gsdntrh5L/A2LUNz5Mnori0B/GAsWuiL1nw?=
 =?us-ascii?Q?tyjoko+8t4bCT200N76rAg2wwz1pX9oVL3Eq8Dk9BCQQHxHzyu1QY5jn2uMc?=
 =?us-ascii?Q?LTOmR/JfAkFzlRpi8Ol9n0bl0a4w5rTGrn1oza++wnH9Px6F/E90kl+km6WC?=
 =?us-ascii?Q?w+rzKv2P3kR2C7VKyI9hkLchUl/oUtbiWdI3BmRmTiXQHG2e9C+nxY/cwrmi?=
 =?us-ascii?Q?a1IlBOChDe2KStw/VO3c5puCDRD66V2eqXv0cg7gOAAkkQ1po9jT7DR6e1WB?=
 =?us-ascii?Q?7l+CjAM5g4CVxf2ENXa0lScA2Q/3mFhP1OCRRecq5ih3Y6LbJ5MEsHmgEEFK?=
 =?us-ascii?Q?pju16DuNqUeCP3d5bUDbAozE4qjiJbLDR3NpRAQYTI+Z7Q9kvAsowd9LLH0t?=
 =?us-ascii?Q?zNK1sfGGzpJd+Eleny0lBF9tu5yNv3wNgr3NPMjJlkIP94vRl6+Aj38Qzz4G?=
 =?us-ascii?Q?pPYEA598427nHS+W+K65lCDy+TBHseeiSE36n8zI467frARn5GspROA7TL8e?=
 =?us-ascii?Q?rtBmb3sxCEb6Y0Vow03dQgPS4IWHNOfxCetggf3eBo1osiGDvpCeM3VRztCg?=
 =?us-ascii?Q?RYTp5Vu4+p+/NljXmOYqdiDgTP7RWJuNpAvnnSZvKekoCh7whCh8CEsCmU65?=
 =?us-ascii?Q?HsmTOZJO5y2T+9fBWCs5QlSQmorb0u6ffkNbUHM21FMBknnVRf4a9IyETWiM?=
 =?us-ascii?Q?hxOQ3pN5rTQ/8UAYHsRhLW67wuKxA+CEebtdlSuPHGrTkmGPvbFoCos/eSxw?=
 =?us-ascii?Q?dafRhBCCzZDSyNkZk8YvaZNJ3o8TI7/TOL+7X5LtZTdw65LTCTBrL94ie+A/?=
 =?us-ascii?Q?jKFKKSvfjAYx6Svzp6e5zl4Ed2j1HMSz8Y5e?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:19.7974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 578c7ebc-badc-4ea1-c490-08dde6d62678
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
Received-SPF: permerror client-ip=2a01:111:f403:2416::609;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 09:59:54 -0400
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

From: Nicolin Chen <nicolinc@nvidia.com>

This is useful as the subsequent support for new SMMUv3 dev will also
use the same.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d0d93fc0b9..430bc8a174 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -150,6 +150,9 @@ static void arm_virt_compat_set(MachineClass *mc)
 #define LEGACY_RAMLIMIT_GB 255
 #define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
 
+/* MMIO region size for SMMUv3 */
+#define SMMU_IO_LEN 0x20000
+
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
  * 128MB..256MB is used for miscellaneous device I/O.
@@ -181,7 +184,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_UART1] =              { 0x09040000, 0x00001000 },
-    [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
     [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
-- 
2.43.0


