Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FDBD46961
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicTO-0008Qz-UI; Wed, 21 Jan 2026 12:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSo-0007Lp-Rv; Wed, 21 Jan 2026 12:57:59 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicSn-000287-8w; Wed, 21 Jan 2026 12:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk6RUeaDwWLnQICjwN4xKxdZfSypO4bneV5f6N0MMCehF7hr09wovvwcz5rqwf+aM/BWwh6pVIc7G2PZf08nbgNyTb6uI5XjROIOWQLUOE0mPBDfHbA5qpBTPQaMT7py39q4troNYUoqsUe4ly5aBqdQWvre1Yi6hm+8vWWSxrTIw3khKC1cwbCizu6Mf+YnvdbcvhGjTuJ9ZPoN930Rxv7Q/yARY2a61Zh0wMCu7OmTz66H8Nlrxmee/ADsmkb7l3i/jpmafV0HabHcdgO2M/K72J0teqDFn+XbGSfmcKC8QY5mLVU1y+ksukUj6j6mFZs6i2C8qtPI33zglXkd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDnRsvAi//efRK5JnNaaRJq2ZkhxcZYysAZUVBtJ74g=;
 b=o9h1H0r2LwoKDGBYvgXtD/3jn6Z/TyMCfU7Q4GDxJo7VLlvqMnKV7tohPjkrtanDIj4/1+kuBNvquVyuG4barxflNmaIzO7jgaojehWbC9fHct/4e0d+r2DbKzuet+3WEMdll8oKdwrDMXvcH38pU/VmqNPCrcEuKuNFDgq1XjYbYjlTmNK0/zHNoqEMSVhIirK4L9RIah0PHxCxVfbc9WMVmeWFjAEe7SUavfPmyp7HboHHUWts2FcGegjJhAGW1oRwFfcQRqf+ZyTY1VtoO6AmKqfu5D7Rl6McIuzOfmqI9gQ5t3CbwUJcyzz8J2lz6npa56Ifz9p+ssIegQXPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDnRsvAi//efRK5JnNaaRJq2ZkhxcZYysAZUVBtJ74g=;
 b=H3PWvTy1XRRLE3L8zgJJF40C6EZKg0jmdKJGOBVcYBMld870l89HzYMDmKiImiagmWISbYDtBLCwJzwivVzsOSYDQu4iSiIzXytxAO9GF1eLrdjQAN1qvG/j32YFDEcDK05tFef4mWkPAfv9NWoFWibER36RpI0YMkDTk554Y3ndj6l1JdSSE1kC8kzd/EeuaRPi3YSNAV3gKQS+mlDiAfS9bXXtc6LCL3JYb9cML7HMiw4zz6tbdf2+/UwoxFl/LBH+NCuH6xwiItpdzL0CaroQFNmIM0auzFZKcozFIj8y2UIHngloYm3ANrWFcvaL3D8Y6pwbtAD3AVOU5sQ7Ng==
Received: from MN2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:208:a8::26)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:57:46 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::92) by MN2PR12CA0013.outlook.office365.com
 (2603:10b6:208:a8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:57:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:57:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 26/37] tests/qtest/bios-tables-test: Update IORT blobs
 after revision upgrade
Date: Wed, 21 Jan 2026 17:52:31 +0000
Message-ID: <20260121175248.87649-27-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1169f1f8-1e0c-4a22-03c7-08de59169529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E8kkMMkQPkn7DEgGh/L5axhIJ1iufl84+ACR5YxG1XwsLvImHtsYpPaDDDeY?=
 =?us-ascii?Q?zHXcEx0O81sUqw6yr3wpD5VsEfEa8hAqwG+qA095e5RVErtmHZrO/b7Kopy6?=
 =?us-ascii?Q?k914C63QnWn2dWcIwYBhcSy9Ujx9rJbMGrMEys/y6By99xKIR+JPdyKYnz5f?=
 =?us-ascii?Q?ItcPqrFcfBiJn+gbC8R0F9kGWl7FMPqIpS6KV7v05iru/UsB07kZ3q3jZDCt?=
 =?us-ascii?Q?oyBybh1IPtpZmZhsNLoToY7+Oydm3PFXwBa5hQbME3NmQdTNU+4bHLzzID/a?=
 =?us-ascii?Q?dLQX9VvDOISNAnFInvl1wRefffg7McBDyOaSW8jyDstodnUV7Ag4LUrM7q72?=
 =?us-ascii?Q?6q+/JVbeC0sDcJBIR7o2XVyl4yURzHyCeUIQBu7D+DhtDnEBAmFsbMqq2zop?=
 =?us-ascii?Q?bZ0AG0McfVnpf7GMx39NhBY7p5xBug1gKldUH5n9IAHOtYxXEb6GX+a3KDZH?=
 =?us-ascii?Q?X1KuZ/qPebSqfwyhJYav5YAyQ73d1B22y1frHJlVO8WKXr2XxR3XqTPKlGir?=
 =?us-ascii?Q?wNw9JarNS8Pz/USlZgTLtbHYT5sNnA4ox1fHhIe9tzCgdY7RLwu1SgVHM60M?=
 =?us-ascii?Q?6f26ZakjJhyHgOtbL94BQakz4wsjYc7n3lTIf2THS6nR1mfJnzJRjGjC9btS?=
 =?us-ascii?Q?bYZlTRgm5g0vx5yq1R+lPO+nP3f/RITUBEwaxOBK6BP+gur0EezgQ+pDYve7?=
 =?us-ascii?Q?clxo7fMsqOgIUrCKEwY2PaKXmCO2BK3eFVOIRpFOmMcyOd10ErmGxn9t2UHM?=
 =?us-ascii?Q?SeV84osizQBDSRLjAZp6o0yHiIIMmHvu99PtoJLhzuk0jqZlbW8ugv4umer4?=
 =?us-ascii?Q?2qF8HsF2SiTBWNkoKfzbwis7d6HGPMXa8cg3G9JtjjwMxWymxwhc/kSfaqff?=
 =?us-ascii?Q?SwOlPgZegO8ApcBxTrGTFZNnatt3972J1kV86Gi65HhOf6a1O1Brd1a//20M?=
 =?us-ascii?Q?ATCp4INlFcnvITNOoFdMzuNTrpTkHheQp1fVESrhvo/4pzmAPlN0FgB1j6Cd?=
 =?us-ascii?Q?HKy+oQNc1XHfljwo5BFOHOZSG3YsiYy7paFuxgJ3cBQrQOWCEDQezIm1qOs7?=
 =?us-ascii?Q?upnvCkKD70xedrieOA6wgrij2Dvm+9AwN/hkJn+PNpX5DnGGxVGPfP0GMgV8?=
 =?us-ascii?Q?0rYoYSY+unJOc4qiZCQX7afUaQ0cxBoiwSQInk4qOzTxzG6QzHuIFSJE8Awj?=
 =?us-ascii?Q?jOrnVWeheQcvl8cFtpTaV8nHHyTaIqjiCvWzqpxIgXKBL9adTe8MaKRdl260?=
 =?us-ascii?Q?WTmPNnYLYiv1J5fliW5HDbSLV3lPLX34Vc85nAXITG0FZMR42z1KH1wAwmFe?=
 =?us-ascii?Q?8RmYJWltN3UatCPqtEUteH9AwlmO3eyVxM4ELALn6DKrW9uKfYOE4ftlwBQR?=
 =?us-ascii?Q?rL6jbKUt/bD51a2+UseXzuM8SGIukgmF+VmCLTi5dx2CCQAjR8dg7clFm1XH?=
 =?us-ascii?Q?494Adx6QdTZ+JmNVqIaY7GlBU+dLP81wjr5IFgRWknbmOryxivJ88XTbaVHB?=
 =?us-ascii?Q?oQyWAN++lrG0Oc58M19vPu5qN5hO0dhIhWU6N9E0sruN++l7mF88LRMPTyn8?=
 =?us-ascii?Q?F2MSVWBi+hBXbBaeiFqm7v3snuBNpnCsfAJ2QZJWIvaGs3rfeSkPxYw3PL0O?=
 =?us-ascii?Q?Pfsq9xqvCLqeoj5BkLUkf4qE3PkG9GyDB+/meenPf1L3g2gwBRSaK+hQFb4j?=
 =?us-ascii?Q?CsN0Zg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:57:45.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1169f1f8-1e0c-4a22-03c7-08de59169529
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

Update the reference IORT blobs after revision upgrade for RMR node
support. This affects the aarch64 'virt' IORT tests.

IORT diff is the same for all the tests:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/IORT, Mon Oct 20 14:42:41 2025
+ * Disassembly of /tmp/aml-B4ZRE3, Mon Oct 20 14:42:41 2025
  *
  * ACPI Data Table [IORT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
 [004h 0004 004h]                Table Length : 00000080
-[008h 0008 001h]                    Revision : 03
-[009h 0009 001h]                    Checksum : B3
+[008h 0008 001h]                    Revision : 05
+[009h 0009 001h]                    Checksum : B1
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001
 ...

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off       | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 364 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
index 7efd0ce8a6b3928efa7e1373f688ab4c5f50543b..a234aae4c2d04668d34313836d32ca20e19c0880 100644
GIT binary patch
delta 18
ZcmZo*Y+&T_^bZPYU|?Wi-8hk}3;-#Q1d;#%

delta 18
ZcmZo*Y+&T_^bZPYU|?Wi-aL`33;-#O1d;#%

diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
index c10da4e61dd00e7eb062558a2735d49ca0b20620..0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3 100644
GIT binary patch
delta 18
ZcmZ3(xQ3C-(?2L=4FdxM>(q%{ivTdM1ttIh

delta 18
ZcmZ3(xQ3C-(?2L=4FdxM^Yn>aivTdK1ttIh

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index 67be268f62afbf2d9459540984da5e9340afdaaa..43a15fe2bf6cc650ffcbceff86919ea892928c0e 100644
GIT binary patch
delta 19
acmaFE^oEJc(?2LAhmnDS^~6T5Bt`%|fCYU3

delta 19
acmaFE^oEJc(?2LAhmnDS`P4?PBt`%|eg%C1

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index 41981a449fc306b80cccd87ddec3c593a8d72c07..5779d0e225a62b9cd70bebbacb7fd1e519c9e3c4 100644
GIT binary patch
delta 19
acmbQjG=+)F(?2Lggpq-P)oUXc7b5^FiUXej

delta 19
acmbQjG=+)F(?2Lggpq-P*=Hjc7b5^Fhy$Mh

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3279638ad0..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/IORT",
-"tests/data/acpi/aarch64/virt/IORT.its_off",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


