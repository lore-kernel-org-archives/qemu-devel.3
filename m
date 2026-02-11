Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C090AEB594B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 03:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq0dm-00056F-3d; Tue, 10 Feb 2026 22:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vq0dj-000566-K6
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 22:11:43 -0500
Received: from mail-eastusazon11011039.outbound.protection.outlook.com
 ([52.101.52.39] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vq0dh-0004sh-Ur
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 22:11:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsEdOfoR/4CPat9o7ZbXH0iLNzE1KkhB3qQ2CumGGXeWY2RmSTKoV/puElx9cdBY30JutmebCLDA+XHUuQne5UqD8R9EDGeHuRdPWP5OUDLeR0Eq9ObyBMDecAApkGnofdWhmHqMuxMZPJvwuJZgUYhGjfFMhuw0sw7ptjtnoUYT64Ay0b8NpTNFCd8DC/2n1CuHel1ylNEdhEEZWY3wW16WsFrb0uXw5SNXzivexVyo0wHP0Xjx9prNHNrQmPlNBba75vWxkjfQ05hVupD8zdFhtaJgy9b56JfQGXSEq5E+66Y++ymvIhhPN0NTvG5ZHRVS4P4Ry0PqKvgHNPiRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DhAZjvuDvVu49L7yRCJv7igGcsNMpKbhm7Hbdkj/dA=;
 b=uC/XfB7ZXJ/i8EIAnSyKfmUOL24RkXpsSPmFgvvmO1b1xvp8a4iWGWI5h03+MCS7oCODuNui8qDYbYpR5C9np3IeGKscGHGNNtGTd4Plf8p4H21uBMyvwgTIZN/Q9C1EY/b+n0AOH4gEiNSU6sJkPtbgLjE7iidahSawfyo0LIY9fMyQBnVsvNqviPdDm4hYLhAZFpMLkomp0gotS2neBDVW63NE2NC8bc0q0WDMXs6QFxHk1Ks71eokrN4BF4AJVq9S/ODOMuX/As8A5B5QQqVT5Z1e9M/UzqmfLZ583YRilbhx4zO3zb/+jOhhbeCPXje7UQg8LqF4OYdEhxRNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DhAZjvuDvVu49L7yRCJv7igGcsNMpKbhm7Hbdkj/dA=;
 b=nzlwEWsKspSpZdji1jrmqg7DvCysfpzfQWfaOsvQRUzRlmQKR86IsyiyK6xqjggoQtErBryC1EmcoMFCxG0YUNh/kyJArlur6iDO0FjxCKHhIWvlfdAPxBH0d7o4nisZxie/gYLyxmUhO2X7d6CddW/7MNE88EA31Ncldf9VtNHgxcbToDjpzZyowoVqRbzHSlM6pmUfU/K2FlFm+NuK9CDofwNefHyftruTYgsEU4EDzIPNxx7hypuOBCJ+u/50ClWABwNKhkhwrbqDi/vxGE91rpwI6eLGQE1i7pyMsW4xkF3NcSrJiOQsHDKzhtUcZDq+f0P5Zpwr2jb0ld0Z8g==
Received: from CH2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:610:50::18)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 03:06:34 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::7d) by CH2PR16CA0008.outlook.office365.com
 (2603:10b6:610:50::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 03:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 03:06:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 19:06:16 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 19:06:16 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 19:06:15 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/2] hw/vfio: Enable hugepfnmap for non-power-of-2 device
 memory regions
Date: Wed, 11 Feb 2026 03:06:13 +0000
Message-ID: <20260211030615.3202-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdaf2a8-f24e-48b0-535c-08de691a8f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LhaRu10fQBI3RaF1P7eBcvnBEd3D59ASDQuyJlC0jTk6z9z++Ss3e6I620+R?=
 =?us-ascii?Q?n/RjXKW0OAXGuCaF+FHc5a7wecdYrgQH09BDgVR8jUjHRhpqEhNNNNwWuT2m?=
 =?us-ascii?Q?FoeQ1uae9D9M+LR0Ct5MaLIahZC16VvePh3381/ReHNxBZXQN+g/rn7lwOTx?=
 =?us-ascii?Q?GWCZSevTR9qvsJj4fYKnqQ8nfHzUQs0qsW8T+MMIx9LQBJrDcylrdrwrW4pn?=
 =?us-ascii?Q?dAe+807Gx7UAiAhi7mWNcJoFE1TnMnmawGlnCrWyJf+muLaD7gFGa1X7lYLj?=
 =?us-ascii?Q?U6DKt53E/vRAwjYSv48iNSmd1NcjHOQJKZdNWGoHol0WpBtQtRur5qsR8p5Y?=
 =?us-ascii?Q?WJGln9Dm05gNAfnRQcd+DunXp2kbqZMSG3HG54YpV0cExj6gE/toiKxfxBb8?=
 =?us-ascii?Q?RxHwm6b5ksD56W8HAeP+9v+/jKdaJAtHt4wZnJjAqYf2BRoDtF+sTc0TN/Zj?=
 =?us-ascii?Q?2fTDWGL03J44tbQDBv6EEFGa1c44ZSPjgJQ9gj7Mv6cFNfWFRGnJ9JxCyyK+?=
 =?us-ascii?Q?rrObnBUw5zJ/v85eu0gAUTtRxq0brfj1Bc1N0WXU828m13eWieDxUIcxCSlm?=
 =?us-ascii?Q?fkkw+fhcCk0Dh1wTGoTSLKNIupc22FwFLxf7hWrXvq6LglWWqlJiA0ASMZRg?=
 =?us-ascii?Q?qhzxIckXh/E6/luku1nTh/oVABzK9zsyRsYNisBJ4nC0YqsZLhvQ9sjmWlE5?=
 =?us-ascii?Q?YfJGu9NHyjctFaPyestBbHn0yAvOjBpKWeOJDA8X0ucem+dksDyvdlZUet1y?=
 =?us-ascii?Q?/wuCpdec/haShJxuowkCVDX12wmd2Tn8UO1REMOByumB39ML75qVKhDhmfJh?=
 =?us-ascii?Q?ZD5NvYIXWnvyJ5INZmnFHwaWWZXozzJqRh6VrEiNdRhI+Qes6sNAzhqyPIBX?=
 =?us-ascii?Q?wVzNfJWcjD8USDwmDg0LkHqUyDOYuJrfPGnpa4q+baBGXAckJI6xWPnSvStt?=
 =?us-ascii?Q?B6LsmGjFudI6ny7W4disMrHha3y8JNu9JNBi8maRsjI917AIfP4tNehdHscP?=
 =?us-ascii?Q?GhivyntPFYTlxELEs06z9CtjaPCggynm6Y5ShZG+rOzPf3Wn0GC1Y1Ad0Mdc?=
 =?us-ascii?Q?XaLh3AuE4I2FTlYsHH5aoRVNbPQn50U6DesZ2yOc+RRLbaczqqFo8R4/i9Ro?=
 =?us-ascii?Q?3d6SuEVZK62fz7UF41i6ybNscQob3SXHZSgsid2mT2b6GW4FE/jJXHp2XRha?=
 =?us-ascii?Q?TjdqhGR08/Ng1BlN3D3kVaYehtFwYHkwGff0P9vCViiPJV2f4L5QEDpW8bOH?=
 =?us-ascii?Q?U2Y933T1omgKByoz5sHMdmw8fiY8J9RV64F0sK0Kx67hXzjbxZXdakeL07Qk?=
 =?us-ascii?Q?oaInqm1yOgDsMWR2X4Zl9+fgha0XzEY74kQl6PIObJcoxwv/txGYnqfeocSc?=
 =?us-ascii?Q?2AeM6nMGgIEGaL3DToU/Zg34Ad8gglmEYBeu8f6C659//E0SgQHeEwZoM1ik?=
 =?us-ascii?Q?nuePlKdfU5gTuC18Ersl99rvsvil9nrg4HOl+eeS3KxbXqTv6bElWeLNaU3p?=
 =?us-ascii?Q?5W1DTZ+nynv8EIdZjTYffgKJWv/kZ5eAOo+TNI6hrkZdXEdFezpANw2yUicy?=
 =?us-ascii?Q?ATEKcP3Vw7SKMLArj7yvhGaL5ej75fT9ZM6nxRNa/pYIgmCYTEvdyGx5Qi6T?=
 =?us-ascii?Q?49qINi9OkB+y/jl/seIsS5U//auS/4pPmkAvbGdC1ahIrrSsk1Kv3cy0O2Ex?=
 =?us-ascii?Q?K++WCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3eonoore6aL0JGfDsWqtHlojyt2aC1Z8SKcr7fMnbbsfZqPZlgb0vSRbQHNshQJ3Z4M+RVJuwJa+XJ/7P3xajSI68/LgoWZUmk6bJUktSSWjRheEAE8a0XI+k60MIE9NI/jO1sSyCy87+Ni33TQP9M8y9rPS/fHPTBxjTZnNehjVnmyDmgPyxk2gQLDi8Zv1TBR5kBvjQWslurR6gEissQjVrOZQzbWLsNBJykKJb79dXgEb+WkBWr/JUbM0KPYjqTGyprVe7fvXYOzU/3bEfbKmQpVCpPZeKMeVe6uUqwYtqEConcRThv1oiOySou11XI+KmopuBp7PVcJfjZHULCi9BsnhzFd2VgoAAUI3hy0/M1/ADClnyteFldcA99Jz6wU9jictXrlUVFyiEwHsjg3SgZcwE4rBZFZmwjSBrMMCOWY2j44dd/A1DIOjABn4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 03:06:32.8910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdaf2a8-f24e-48b0-535c-08de691a8f7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE
Received-SPF: permerror client-ip=52.101.52.39; envelope-from=ankita@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Ankit Agrawal <ankita@nvidia.com>

This series enables hugepfnmap support in QEMU for VFIO device memory
regions that have non-power-of-2 sizes. This specifically addresses the
needs of Grace-based systems (GB200) where device memory is exposed
as a BAR.

## Problem

On Grace-based systems, device memory regions can have sizes like
0x2F00F00000 (not power-of-2). The current QEMU VFIO mapping code
aligns each sparse mmap area independently using the trailing zeros
of its size (ctz64), which results in suboptimal alignment for the
overall VMA.

This prevents the kernel from using hugepfnmap that enables huge
page mappings for device memory. Without proper alignment, the
mapping falls back to PTE, significantly impacting performance
due to increased TLB pressure and page table overhead for large
memory regions.

## Solution

Patch 1: Sort sparse mmap regions by offset during setup and validate
         that they don't overlap. This ensures predictable mapping
         order and enables gap detection.

Patch 2: Change the alignment strategy from per-sparse-region to
         whole-region alignment using pow2ceil(region->size). Create
         a single aligned base mapping for the entire region, then
         overlay sparse areas with MAP_FIXED. Gaps between sparse
         regions are explicitly unmapped.

v2:
* Fixed the code returning early without trace (Shameer, Alex)

Link: https://lore.kernel.org/all/20260130040649.42485-1-ankita@nvidia.com/ [v1]

Ankit Agrawal (2):
  hw/vfio: sort and validate sparse mmap regions by offset
  hw/vfio: align mmap to power-of-2 of region size for hugepfnmap

 hw/vfio/region.c | 126 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 28 deletions(-)

-- 
2.34.1


