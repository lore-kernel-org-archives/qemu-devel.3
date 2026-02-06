Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3247EE20AC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNBo-0002m6-4i; Fri, 06 Feb 2026 09:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAD-0000ln-2q; Fri, 06 Feb 2026 09:50:31 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAA-0007Pk-H9; Fri, 06 Feb 2026 09:50:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8ItlBP5B466rQm3si5m+GJ03Hhi28fZU2iXzJ6KLFJTIog46m0e2RmffCbLkzeyQo0qwkPHrLgh/s30yxQ2yudxhu1WjCIAL7JBexSS2UPJPjbiZeZrcAWrMX7pyD1DgREMWlEJqUG4cu63LJ1Gk6M6jbeH+cb8S8rJcMwN6XCqZ8oVPeEU4aJFSiDF7VsdFWV+RRGpdzi6vBLSeL3Xlq9oRRqOs45ddX5jzlItsWfzcTrA/+TXudztJPX/fMzNOcg72kslDGVTnCQ0ySPLFl9IsBtQ3khOwYuTmVWtjR75C3hTnDp5I5zcYURQLBemPJbii6LuKcYcBM87ZzYELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuMgcmw/ga6gA4QtRjINXGgoFWUcFPOmqmTaQ2+SQg4=;
 b=VYPDD/7SDYMQp62UHJYhpvgUV9hU0TNdA7VR04YnlN3llnkZaiTD/LQR2iWkmRdYGuOQGgzl8s+aTy5pBNzlT8TOJY5idKRrze6XUnCM7PSQvNAum1/Gc7IXGcBnWUX/1m31fff0oSowHkjKtNKSTtvcmK5sWCo9sxGBvdD7BDRmpltx2QQ4TtdpydZviNCKNMm/4q5HmyoXYYT4CNM5FrDyLYvGmiZ5z3iktZ85gOGpIgqMIRwdvdGEkwS0vmjmDMnQZA6hyol1ZjHK5NeC/SMnZ0AtiikiFbDIdHmwtX0yb4EE3PnuQatapbgKZptXgqaitxJ9Z+ZYRQ5vlxinRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuMgcmw/ga6gA4QtRjINXGgoFWUcFPOmqmTaQ2+SQg4=;
 b=ot2RkGyQFXZ5Ku7Fgi14S9Q4Cs0ONAaPQa5xxV8jSVf33acU6WFc5UGgIyIcUcNqLlqbiyJvaC7GHkNa8Mn/mkVKerq00uY5CP++vZqPTLPxxWzE0nFGb3jE8o40UduFToJRFTzGYi3qCDUltOuKCKZWlqyM0cDuNG66lnIk/i6face0r3vfZacBC0+2yfvGVhMo0F+6RMA6wdUYQr7y2dpcjP9aJo3HWECfBcU+vdIF33YtPFT0zKbJ/3zqdHqLC16JvxcEK4lF2Yh8CFWJXV2z7OvlFQC8Cv4BQSOCBcDOx+U+WguRpkK/3gPnc23LjzwAJj03JFgh2QSdC+wdrQ==
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:50:16 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::46) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:50:13 +0000
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
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 13/24] system/physmem: Add address_space_is_ram() helper
Date: Fri, 6 Feb 2026 14:48:12 +0000
Message-ID: <20260206144823.80655-14-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 829bb157-2f66-4710-2b29-08de658f0a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pW7Qj+JnuyxeOHRPsv9BKoVmaqHYhcpyw+x8F2mb5Jq248WGrv47VBoF8sW9?=
 =?us-ascii?Q?0yXS8LlIgVyTqBYTnIQMsYC5BY9Id2jfedBpBVruPIQMBicctt7v76wPvzrl?=
 =?us-ascii?Q?2zUZvEmw2QSI+9NjCB6kRJahRW23lL6R01Uy8V/tXf1c9hBEXPgXbnd5DqJa?=
 =?us-ascii?Q?X3eR6db+hYEXqu4bjEJik1fFtSCPIuSYTvBwiwQGvo/65olvaaco3JKuELcu?=
 =?us-ascii?Q?l4S0YwfEClipGKyuTSinbh7oo/2rbxDl4x4y4ICe4ssUbCVOPCtVRJvb0Rmk?=
 =?us-ascii?Q?SrAWWxDOJkwmSaBdm4+1Ek2HkcRTgCdmRgYJLSsBNu8i6xbuq0SlOCdoBWXK?=
 =?us-ascii?Q?NmK4K+KpRBI8XH40iawJQHjEU+zEgBiMpbn1JgpGQo4YK7EoDbXra2+VpTWv?=
 =?us-ascii?Q?l/RO6jlVvytOZnjv1HfjnAnQ8yfC1wtymZW/yteSd2nfNW4zBihGFWwkuCc0?=
 =?us-ascii?Q?mbZ0dGSO8f7mxA4PFd1mUsAWSm3xCCvIs+ZKhMca9A8BX2Qa9af9lzpMbMtk?=
 =?us-ascii?Q?zEiuRbVdCCFsZYRKiVU5b2Vn7dpsw6tG3IMdRm1VCJ6folvuCucaDB11ATiu?=
 =?us-ascii?Q?bCdhjh83X1TjzJtcbKoimpDKa7ncjkLEzTO9aBZZEzDFEReL/B3N+pVfZQ+u?=
 =?us-ascii?Q?OrodmEkxSaMuzGsioT9lkJcguotm9hRQkJINAr51C0UCapJkv8+AqeiMV95a?=
 =?us-ascii?Q?PaJz4SbbEFdhZtOaz+/9R5zBYJJ2Qgb+oIuy0rGL1YlvHJ3olHUB5FdL17gu?=
 =?us-ascii?Q?HtAiSHZySvPGq6gYg2hIk5//NzWUjiT5KLZGFCL6Hzshdv7U+NyW4Otd2b1G?=
 =?us-ascii?Q?bvflUXanlFp9Lh7gE/hA151V8fjJb8RX9n3OhI9Xs9xvXq7YLUyJUuPpIYSM?=
 =?us-ascii?Q?+uxoh+Bo0BB/qq/fITSyXp/K1+vIkEzM2LtkmVYxwQDwBiihvMDeuAIgDQV2?=
 =?us-ascii?Q?it1+j6P5MBbkZNLYGspYJ1GsXMCJDAVJnGIxmVyOj47VrfCxZNx5xkS9oOTb?=
 =?us-ascii?Q?A6f/hkrGE1fG/FsecOAvguBW/Rt2zOQ32/mAFmjFRXf1x8SEke38ISgzb7Ze?=
 =?us-ascii?Q?h6kPYSxgXqbmr53PVr/+59OzLAk0i3AFzIBhe9asfRyv+XMG5PIPcTfcDJlV?=
 =?us-ascii?Q?aRF50HwieWOiVCL0Wo4amnI31AffgVIlbSAIgVNCMFHrwgXvd49EpFiNAT6D?=
 =?us-ascii?Q?q6JNy8jxuB02EmU/2sBsSyCP4XlNAeqr7SjKVQtBIXgxd2h+OQ0rcEe7nxbK?=
 =?us-ascii?Q?rDS5tnvYdQadFtF3AEgdCIt3hqx/BOQIsDMNGF9DQtuG7mZtLmZpukCf/loi?=
 =?us-ascii?Q?YxQpUFTW+ufaWKjWrcoYoXIgUAcDDXOboFfaxXmiepXpPqhdFNMAFjJ+dyV9?=
 =?us-ascii?Q?VAdo9sED0HEKw7iLS/ENND3m1v8r1eJdmcc6CFCZhL2KvfOPirLutrMdauu8?=
 =?us-ascii?Q?iLvW0cRN1U+4dzAlwGBbVNzjuy4V592K6EjkA7+mXzcftk2U1sJAK6gxSHS1?=
 =?us-ascii?Q?IS1VtGXMAFEAHGuVO3LydD2gaUPFGr3TeX67W8aiyIhSmS90XU1ym8WQCjFY?=
 =?us-ascii?Q?tOBohnsAPLRG5xcnKxuqMV4yzOTmn5vyxZmlhXpXy7EpCOfg99QklDd+JhMy?=
 =?us-ascii?Q?VDfIKU5DqhVhmh1neZJLMwNCnL1MW+ztfExpVv/LaTznRyxXgvilkJQVKh+c?=
 =?us-ascii?Q?tUAEhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: igIgHrJ3yDwtKYRdQt0MqmXrJ8aljv+s80HpPlyRTQG7yo7db1XHle7s2nVogB7kioWvuRDv0AEkMZdB8mUElsvCoaDSz9xMeAPdfG3UqLr91rIncQmDB3QHMPA2noaikji8tPEfVAcMDoQjYUgpYOEdS6hxiCMpDYM9j6jdL1YeTYN5O1RBf0vHVqoA4lkBRKnqbqrP8C/PgeJVVsixjMzdPcZnBs43ihZhzpx9+q6lWEqJtOvvUA9ELlWZrSMeuwuY73ddCPSc8BY91Q61iGP+e+xkiQq2liCZqw9PX816heRZlpE2ckEBPhu9Uoh5Xv6bxYlDKUeBtoqAbWYFI3huqigtDUtpFJi903zYb81+IY1l4atIfvnNIp876YGVb/gWIho8dfTQaUao79sZWz9HfiY/nmy5Fi3T1k6FltROJrbNed6iwqtTFytt2zF6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:15.8656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 829bb157-2f66-4710-2b29-08de658f0a48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Introduce address_space_is_ram(), a helper to determine whether
a guest physical address resolves to a RAM-backed MemoryRegion within
an AddressSpace.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/system/memory.h | 10 ++++++++++
 system/physmem.c        | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af3136..02b2e83fd7 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2900,6 +2900,16 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
  */
 bool address_space_is_io(AddressSpace *as, hwaddr addr);
 
+/**
+ * address_space_is_ram: check whether a guest physical address whithin
+ *                       an address space is RAM.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ */
+
+bool address_space_is_ram(AddressSpace *as, hwaddr addr);
+
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
diff --git a/system/physmem.c b/system/physmem.c
index 2fb0c25c93..ddcf921311 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3646,6 +3646,17 @@ bool address_space_is_io(AddressSpace *as, hwaddr addr)
     return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
 }
 
+bool address_space_is_ram(AddressSpace *as, hwaddr addr)
+{
+    MemoryRegion *mr;
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(as, addr, &addr, NULL, false,
+                                 MEMTXATTRS_UNSPECIFIED);
+
+    return memory_region_is_ram(mr);
+}
+
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
                             hwaddr target_len,
-- 
2.43.0


