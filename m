Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134BECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9h-0004lZ-Ou; Sat, 30 Aug 2025 11:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUb-0002z0-Bn; Fri, 29 Aug 2025 04:29:54 -0400
Received: from mail-bn7nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2009::607]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUY-0006SC-3z; Fri, 29 Aug 2025 04:29:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4Xr5sl8k10G9Oj53KiSYPClQOhzitcVafdFTGJWkeDxabZUjku9zSftYPIvf5CL1aVly4yH0eY5ZZfM07xLc0Qz28InwXFvT5P3uyZNJsW2yF9LVLhrwXnBgiKMDKjhHWxbEw9/haMuvNyeBSQTZ52+HX2GA2PDpFhIQ+3DQyz/oWa8t1AiFnuUYIRwDZ4MDiNEYhJ2xe2RyMpDDL5Uu1R1C3DZoC7m+37gwDRNYQscFBSAzsWzG4tskwGm5QJeq/GXrAZs1XRcFAbczn2RpY0eb6R5vaQArs10nqkJOxpMdsTZ9QCFhy7Ow6fR/klgt5hOEJQcYmS09Ahpg8E4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pd4jhN0OjT+8xqHnIQkgwvg08Zr+SKqt0RKec9023dM=;
 b=YLzjp3i3uHMCl61rawRCMG5yh/KVliXBmCEcKfwGBhfxIJ2LKlLwqyCkf1+wC3BrFEPy8GJ+YRqbrmvwdG+3YxSk/xsByr4N520nwwOo2iFVOvbBPhucPg08FdVCvqcvhom5gBIBvkno4kKOX4cL1QvGkd2JvpJzBM6lcMmVTwFs+KwpYP8JANydGMRxGccvrV5TpmhMVJx0+q9Xpm/FLZK04fnAnMNgDCSAbC5A3TTHXk/rj8on1URmYkF5wTbmLKK/YKGGWZzAA71y90kYMkU8W1JFv5p/Uo0Id5+Osxorl/SIbNj8Duj2tjihA3eM/Tz2KtXZF2bGwaCvTWflDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd4jhN0OjT+8xqHnIQkgwvg08Zr+SKqt0RKec9023dM=;
 b=o04UYb58Y6vlNz/7FLbR3egYPXRAv6Gd8TRGHV+OeqitYt9U2TFnBuJ7j5K0WQoc8XkVR3CkBNhW6lX+BFCnVshmQL5dvhKS0ERFuiyhP88UbhjvEwK0AyMZyCeW0nmxc2FN5Sz4a4klTF1ixLVjUPCPUtAzNoqHvTIMnQwG61NLHpDPiQzNLjCJE8JK52SXvZ25l+Y0MDgUwlq4XQN52s1SCWTRvYy8upXJS5bI65D4jVMfoq3RRyEWfEZ3kW9oYFF6vze8ycddURvhrpgzvgT6ZyK8VDcpdV/OBJDAbZbhfGOZW8wjHtndk6BrTgyT8iOXu4qbERAAm3x8pcU9FA==
Received: from BYAPR02CA0011.namprd02.prod.outlook.com (2603:10b6:a02:ee::24)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:29:39 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::e1) by BYAPR02CA0011.outlook.office365.com
 (2603:10b6:a02:ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.25 via Frontend Transport; Fri,
 29 Aug 2025 08:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:21 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 09/11] bios-tables-test: Allow for smmuv3 test data.
Date: Fri, 29 Aug 2025 09:25:31 +0100
Message-ID: <20250829082543.7680-10-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ef980b-ddcb-4f48-93c4-08dde6d63209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ju8xAhLfF9GJ8VBs4pS9AQklIq/aIPSNAC0+igmiqFinR1SpNmXvSl6zgOiK?=
 =?us-ascii?Q?uiRVXiMmYjq7hfRKw6cQ6EBboCa0cXLqe8rTMDPwuZlTev1C+v86WxaDw/1X?=
 =?us-ascii?Q?YbKBBBLclw7ZK+Z010gkGGW/K6l9ptAC0M4wAH5PXejPTOWicsV4DRevd4IX?=
 =?us-ascii?Q?Tq/5W8FX8Xyu0xo7DmQJWqJ7WPur2fygeFghw4whPx+MzcmrjhNZa3zdxWKd?=
 =?us-ascii?Q?51OQlBha30073oPz/r6ltAxfmIEZDCXrZa0X5W81txgZOMzvCGt9ibjAy1K4?=
 =?us-ascii?Q?nxnCTtPpSos/1gJzsaVo665ReiozldrP4S6ZOYecoFDN3XbPLcwBHmsd97oW?=
 =?us-ascii?Q?AvJdegeuIn8fc0rWxOathlXFvHiHLy01epCKfwioyqVCIKbYaWGQlU5Pp4wH?=
 =?us-ascii?Q?pXaQF2iElfDsEmnhpW5OozOUKhKCNHFg4493PA0JAmd6sm4Bu3TxRcCMowQB?=
 =?us-ascii?Q?Daxt9SrX4BsbA4OrwzhSGff188GDaj7G8M6112p5mMxoqMwNvxkyYTRJnWTq?=
 =?us-ascii?Q?Ppr/J7TKzfQ83fzbxBHQAmfuxKpfxz5kn9rtFoQ+8SGPuqrthsJeTOmXTWTd?=
 =?us-ascii?Q?pZuoAsbIS7Mr8yahhUZ3xWTIhdjfOttnUmIDMv8YXpukzb6rlb5Zd6RlQVpM?=
 =?us-ascii?Q?tJEwOsfzuNDAhrd8+ZSJEK/XXAXcZRoc1b5lVyyHOED53qVr1x6BDssE1OBq?=
 =?us-ascii?Q?GNDst+UxOhXI2knkImwOk8Z2K6yi7BZAtjzyVfF2pxRUfHuEwA8FW0SE4nPQ?=
 =?us-ascii?Q?n0k918n36fnqm/CaxVY7rmF8PYkgvcQziSu1bcfrPYAs+5Q4drYlFnAzO9Mx?=
 =?us-ascii?Q?HSkAQaaC61E8IEewpvJNl7jVrZ88R2cX20nGDSOMtjjFDj0kO0oASol3iSzP?=
 =?us-ascii?Q?F42Bc6a+cQw3QSDr6/4R4uwDiVWp0bsBr7qlit/7lFcuqMHbZ25uLazKHBDY?=
 =?us-ascii?Q?ACjwQGgO+vp1VPlJvuMG9ACudHjreuMWNwLdZHRVJBM837nZqbhT1qDnu7Hl?=
 =?us-ascii?Q?BZ6qPN196IvT81K2Px+WBu5pTOhXy+HId198UHHMaXzY0hmOniPXpJqiw5J/?=
 =?us-ascii?Q?A3sz/aZmSbC+6PhruXAYMkbyei+WlDTm5BT54bzaW6WS/huUi/WGmuYmou+1?=
 =?us-ascii?Q?H0wMLtaS23Vro6Yayi7HOXh8h2x6GfwWj3Duui3qn/aNL2jwJXxiq0dskO1S?=
 =?us-ascii?Q?OvWNTjuzc4WN36WRYZDz/ooUoUIhzYNgNmqIn+RYI7pbSasc2Qz/KCMql9bV?=
 =?us-ascii?Q?3Ik1dDjeJ2rr04VmRVbD2UIGWp5Jlg4FGZ9wMY79gp4IOV8JqjFMZ88Dfa66?=
 =?us-ascii?Q?u1aqmJgqKv9zxhOU8UK3+Y0iDqIIySXQtAHOrCBM/pHeMiCskxrQRspWjPgS?=
 =?us-ascii?Q?DHYndZDg0VqLO4tGHXiMplArTPwIRufAKOOKIRkmwq741eJ/+5etliA/x8OL?=
 =?us-ascii?Q?WDgF9KDIlJIcu+aBxYJMq1k/b0pfMpIxMUchLU/CBpaA4jmKFwzBqdak4LTT?=
 =?us-ascii?Q?R1EQY7O9h53rwxqNdbB/T5gk+BRImIRc+S7a?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:39.2495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ef980b-ddcb-4f48-93c4-08dde6d63209
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
Received-SPF: permerror client-ip=2a01:111:f403:2009::607;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

The tests to be added exercise both legacy(iommu=smmuv3) and new
-device arm-smmuv3,.. cases.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev    | 0
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy | 0
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | 0
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | 0
 tests/qtest/bios-tables-test-allowed-diff.h     | 4 ++++
 5 files changed, 4 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..2e3e3ccdce 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


