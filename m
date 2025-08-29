Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512E3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBW-00061q-Ez; Sat, 30 Aug 2025 11:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUX-0002x6-9d; Fri, 29 Aug 2025 04:29:49 -0400
Received: from mail-mw2nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f403:200a::612]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUU-0006Ro-D0; Fri, 29 Aug 2025 04:29:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZhPJHFt53hW9UDb9b6mSX7d2R14M54DdLZo+TK4ng1z4aFkSQvjFeQy13NZsttgrX6tclp1STkIKb/M+If6Jk7sg+QzRhNuZUQ6gYY+KPaL2bCn0ZbOJQPmZkpGNM+a/yVR2c3mMlvD8PUdf9HbTe7Nqzh4pJtPbPTnDIWm26ZxEj5cdfUXlJGCyooFcsROxkGTj5fpVq235DNdKWyzNOY515nBaqJ06OW4LOd7ArE4MK7W0n0VyBMFRDPQ/e6tMhbw76Z9CE4hen5bxKsPkEEKhEfOUh70PjIKbtUEYGYlKzfSgCDGvw4xjbGDHl9GNwaFB7Slgv2eT2wlPRkHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TSYuc66NvFc6I3z/mZ3bgpbOKpqLcoE3U5aW30576w=;
 b=Z1+KNoDRYt4uRid9R+dWI43tp/NKBLFnMe9gW7AGSqIUzPjDWv2uGmipJApuoV2Lo0Os2MJ6R0HzMthcWjgt2cT+VdI35yfnUY94c4yam3VdbLZHhNVQmkD/C4G7sGFwAOp1Z10viUN1TE0ioyiAN7VK/01iQU1MyLd3JI5umsfSDoNTBR8RNtw9OpgCh5A2QPoe05YERSBikQjR495LqSdl5+HrfN23lXmR9IXh9N23cq2Hbr+HmJ2leTVO/N24sjATJqs1VAlSvPs7P0kth46t2mHWkEZPp6NZjDPncMc3COxod2bpexbxBnthr/bkcB0yK3uK6Hz0ctcQzeXUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TSYuc66NvFc6I3z/mZ3bgpbOKpqLcoE3U5aW30576w=;
 b=Dt+k1jfz9QCodre10kyyboRx+SiwHuDZyJ1DK42+Dwt2DIi2OLIZW8UpPhp/zdckidZHSajiO0/nucoNeQAvWv5LZdy+ZLc7w2jT7GsC9IWGMfYdMW+M+7tGy2FYgTpsbuO6+K/vVSkIVPcKnSrzOFw0QD7J4ceIe1fvsGKq1hmHpInXU3Q92XTluyC6v/sNnR9NRY/G5z6TfwZjfYLloMc62lB30BIXKA1Q8VolMLceuxJ6alr/1vO46MmDyL5i4YcKfaDzCIxPJKAEuJOx9XJ/x5oeZM5XKpr6MMVxiul4EBZKEq2irG75aXdhU4b8Peuavmog9DFsarIBqhbuTw==
Received: from BYAPR02CA0015.namprd02.prod.outlook.com (2603:10b6:a02:ee::28)
 by SJ5PPF665EE4E73.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::996) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 08:29:34 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::25) by BYAPR02CA0015.outlook.office365.com
 (2603:10b6:a02:ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.25 via Frontend Transport; Fri,
 29 Aug 2025 08:29:34 +0000
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
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:20 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:15 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 08/11] qemu-options.hx: Document the arm-smmuv3 device
Date: Fri, 29 Aug 2025 09:25:30 +0100
Message-ID: <20250829082543.7680-9-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b9a4b5-d892-446d-0ad7-08dde6d62f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JxToHQRp1j7c1d9uXtis8QL2/mWe2aU6vrC4y/jOTdhFyMD24uq6QCru+jVN?=
 =?us-ascii?Q?8ZUmxGBrLAOEaZOa7a8iP9t84CtfQ//uGTIYCWlQyvNVx0Zx58oGjABbG18D?=
 =?us-ascii?Q?fyZ/N9xmYAPfeT3xFecvyknB6OpkE+xSKvY8wfn5AMWmK4HFodOE59Tooszp?=
 =?us-ascii?Q?6jA942C24MwlFSLj+COZ9i4JXgFO0OoA0UtLlpLOY8ayCH3DK9lb432ZC8ol?=
 =?us-ascii?Q?GgmUa8ggxxEVezehwcfiGvNKEGp3EohxDpiWR1j4+DBFSnyl7CE4YtBhCgsY?=
 =?us-ascii?Q?YSrQ8mnqs7h1Y6/iiuWLiVTGCXRqDCMY4laTqVC1pQ8SP8KVSbwAbP9Vxyg8?=
 =?us-ascii?Q?JA5vbeRx3QYsddytdFIfOoHYXyodQAVpEP/J7JAePnc92Q0vRep5XyXs9YPb?=
 =?us-ascii?Q?bx13anVHpHb8A5+938V9SJL5AshLw2wyUGm2bR8rDcoFQW5zFMzLQbZFvr3S?=
 =?us-ascii?Q?lXjlGR+DILZjAUzx36fo0ic1QtpxQi0BGJcxmUUffn5cNd1cA7MAeoVpsZO2?=
 =?us-ascii?Q?WGuwPn/1ExuGyosiJ5jwX5IpI76jZ/DxLfbaounMz2WlLeJOAJnCa6X7W7t3?=
 =?us-ascii?Q?3ErrEgmywMLUtJffj/t8rR0vx5DxoRnUsLucizsoNL1cYi0i4KsTXH+jCH6r?=
 =?us-ascii?Q?6fWl17ScE19ZAwYkB+k3ii/Bnildz32uACYabgVb7NkK30MXUvNyqrtMyoxk?=
 =?us-ascii?Q?O7QFaYQgWbjfGBIaw3cYGDmE/RJfwl3i5OoykFOaPDiXydM/f/OVFpC+eNTi?=
 =?us-ascii?Q?tdxAUw5s/sHx4ENMRLD3dSdw7pIq5+PVGDtHokV7b0SZ1KgapZV9vJBu24ZP?=
 =?us-ascii?Q?UuJEMkXONjA3Q8HiMp31JI2HDKlWk17PzNC7nwoPYqlT+rrb8WZaDJcojp6Z?=
 =?us-ascii?Q?3t7eDzBcuLFaiKacGo5umi4/HRR1rclmXOKhC/7gTokiDUbOU1YkSvBwNl4O?=
 =?us-ascii?Q?xGVvhGFh+JN9Mdc3Qj8zqorGbRJ/r/HeReRGvNikJ800ZiYUx3wKHCpJsIs6?=
 =?us-ascii?Q?nvQSmMP15+QNh3wn4dPltrRj32AOQVSqMFxgmXXu20iuUecx3r7/A6iOJgaR?=
 =?us-ascii?Q?MAjPVXN71XTrNAl2fiYtwvqzI367cJwCzWVLvN208vAT0IyNKfe5C0WH1bnl?=
 =?us-ascii?Q?EU0M6DvgyIHKIGvBaTtUnFtDzs+uW/D2MVgjFq2sHCTbJAIH3mWPd/svBOJ1?=
 =?us-ascii?Q?/cwJh/ZxmZkEO0R4qHdgGvnZnfa1hi9EXXQonW1nuAmJ/AzKe8nY8SXOb/oi?=
 =?us-ascii?Q?YjbA07XZku2UiFnP7oTRdYvxvTV2ZjTi5MHcOBGxoiPxLOCJAVXEX5ApRuq1?=
 =?us-ascii?Q?skGLCb5x1nDsJoeSQlSvJegOiKCqqScPfEYXPZ5Ny3N9C2XkfeYeSkb/yuLf?=
 =?us-ascii?Q?9QuNjKQvy6GBx8qJpyO+q015auIAWX6Ho5uNqJeoWOPL+XkjkpNZnihX9zNh?=
 =?us-ascii?Q?JGKBUIbq+aJclPycvj2aZkcwdJ46TmovyjlS5+lyGf/lRAG0XFr7uKd6T/UM?=
 =?us-ascii?Q?PSB0wv6j7AdbTTgiFgtbv5MaX3pTyWrxH+lh?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:34.1401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b9a4b5-d892-446d-0ad7-08dde6d62f05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73
Received-SPF: permerror client-ip=2a01:111:f403:200a::612;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Now that arm,virt can have user-creatable smmuv3 devices, document it.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 qemu-options.hx | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index ab23f14d21..64c1f1352d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1231,6 +1231,13 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of the IOVA address space.
 
+``-device arm-smmuv3,primary-bus=id``
+    This is only supported by ``-machine virt`` (ARM).
+
+    ``primary-bus=id``
+        Accepts either the default root complex (pcie.0) or a
+        pxb-pcie based root complex.
+
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
2.43.0


