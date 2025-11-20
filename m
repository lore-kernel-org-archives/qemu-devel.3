Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98889CF8859
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4e0-0005xm-SK; Thu, 20 Nov 2025 08:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dx-0005nm-DR; Thu, 20 Nov 2025 08:24:13 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dv-0002Gh-V0; Thu, 20 Nov 2025 08:24:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNnCBWJI4w8gPNOWx0wKfjjL5iS8bE/LfXir9RCqVbSBtGrEqS633T4oT9HbVlbAKZAoFam5O5p1oat7uojtq+YLow0bjQREs15rLi4n5UJ4PP/nBfceQ8b4wzACh9z7zMqoMa+EHaF57t3OWdEk7VQ8HDI/WwIU3hXwY3qRMBnrFo2jXMXEfQMZwevVMFNW+btTUbCQ0rYI0UzPH1KF3DwgMRWlZNpxrENU9lKMHrmE/Wm8lOV5fHju2H1nP5rtbpnFuTxalpQ1DvhOqS36Ddj78v9B9lO0tAecer8i7wluWCEF21cipzTOlj1UqDN6rvMu7t5EjeygITByDXG/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUumZKZtDgYU+yNqY691HohKKvfp21IYqrjTupC8Ryg=;
 b=tvG3cjsVuP1jTbfuGyzWjAMDuKuKSAH0ocISsw1Hxj0kcejCPYzktV0PJZB5SCSglSj2oMPcs40Pwac5z6eMr4pWiqjIkyyeDUSmtedotevyrg0xhxX5N5dMRd9ftRiRDrx2o3xngflgEq5et57kUWkKPCw7pi1o/ICeBU48BQy6DIUQKddA/xKnUSnf+ikM7oRDFQHOqOjEA6Bul5ftXPnOqsEthdiSKfyKd0/GA0bh7FGSNzTZvSPzmaEaitmzaulEKngqguaX0g0IUsTTeAUEswg/k1d6To6Ng+6X113sR4/FWSoeHwcZrkwBLNon8WTEH3pefhtyfJdbyXz6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUumZKZtDgYU+yNqY691HohKKvfp21IYqrjTupC8Ryg=;
 b=uOzquYJPjUDqQDURrPseDXaLqHaHHshWHSq2ywqkbqd6avYPeDGZxJaZdEqfIBXmFYnUMNCzSB9EgevyBqqu2rej5Njj6CzUgLRzmK7/lD0tw35yNrJ3SIJav4REvbOtl1V4ckC1bUlqVWn3M/cCU7GTiVPCJmd6/G3+vzk6bXzQK8I6flgJvcD/gops3QQMUikaedd/Pn54cu7BhGpMgJ7++Dds1QoARynkqVIM2VKXAawUFg57qTyndNaOsXSUG7x/3yqoU48uhCbR3TZsE8Nvc1XJWMuToAv4JGcezQUZMX38ZsPeH5mayExEYI/b+48DFHONQquhnef+3tqRfQ==
Received: from CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::11)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:24:05 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::e3) by CH3P220CA0029.outlook.office365.com
 (2603:10b6:610:1e8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:24:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:51 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:47 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 09/33] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
Date: Thu, 20 Nov 2025 13:21:49 +0000
Message-ID: <20251120132213.56581-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b476b21-c052-49ea-4337-08de28381421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SE1odOO6v9FGcJAc1RJTwHXaLcX9ec7ZsnGKY3stb1yXODL0JZJwb3zjRfGA?=
 =?us-ascii?Q?/VVtChzBRcLhMHit0Qf5l1PA+lBWzGmJKnGV4xFs8N0DRwc2/Crl5tX7ds1Y?=
 =?us-ascii?Q?prfEDXwADtQ9iH/wbWObhDmcillLGV10mkH3znw675sWFY/qTgtgunzPpgv4?=
 =?us-ascii?Q?pQOc+A8V73rnEnVtc7PdoukLcloupRCeeARnhlzFEL1B8d8SNJWi8cQqDUhl?=
 =?us-ascii?Q?oYKraJ8/iDwSpDyxe0/pikuszMwNa7uKsV7STNl8rxFenX9EAM05Ssn/X/OM?=
 =?us-ascii?Q?CyzSEvuzPyG05pOZmfgUBF3FIRhtrcRXTA1vtuKjH6wZQyzGHcz4NQ1l9lBK?=
 =?us-ascii?Q?AJrREXY/hlYqe1BdiBRo7kgEmUkWpWMar60BI2VAgMXN8chC8NJqugvsfgbN?=
 =?us-ascii?Q?2Hm5v6ocgjzw5KjaM9ylxN8PWDn+0dcw//JdNeaeyfdLcQIsUWtw/Tp/4Jn4?=
 =?us-ascii?Q?n/KEnAD1PMaSjgw6LIwzPRUvJXFmPoS/bShqwoz1I1FcuBvTOx6F7QuLz3/P?=
 =?us-ascii?Q?wIsRrGfFbTLdVVmCTt6oSxMYDwi9jMrlmLvfC/poYabHSFb8bFaTzYrtVQQm?=
 =?us-ascii?Q?i0Hhm/lst+Sj2p07sk1hGaDhiYXWGpusI1XaPi/fw+CCHur9ibNE5RPqjZmD?=
 =?us-ascii?Q?8ECLuysonOoUm+gRYBb1IrcJkWseq70yuP93vf7RCfpwEn3jQi2BduH3amKS?=
 =?us-ascii?Q?BCfG57EwBL6ENYV7d2onMtFrtRZZ25fnLctLLHkafkKW3nW4vY6V5D8UkcF5?=
 =?us-ascii?Q?fEgKdwC+Kg8hIRkMx24GGeRjB3MGzdw+lgTDAuwTpOqr8dpGxpy7629qvp+m?=
 =?us-ascii?Q?027seSxxfGNMZYTi03NOfwKZ+FxX/nWEqdUnerWT+AvkVy56UkHB5zo5351u?=
 =?us-ascii?Q?n3GPk0XrVNqqTaBBJwHRm/0/uqoZijLvzW2sf7mRLEdw5tcXocLvxLJo1/D8?=
 =?us-ascii?Q?jrjz/AtrahC/4U9gQU9RttchxyAEH6gZHr4wKQDwMBIaLqr431dafnFZov5M?=
 =?us-ascii?Q?r6my1DI+eyZt0/2kZ7/rAw7pMmaDfpwIuPfAvBOuS4mYIcI9eGs1Zc4Y+49g?=
 =?us-ascii?Q?u+DUkyW1RRs9WQ/XSmqb58XIPFUUyfu8eNmc0dhVNWckipwIvfJzgIuQ4QGa?=
 =?us-ascii?Q?l+eIjHtnW07n2FYvl6MfytN69sqDbfY5mIxmhvO+NrP8W9DCQfciT77f9Mt7?=
 =?us-ascii?Q?bgoaMLVc55PdrcpdDHWxC75BxAQ6FfGp8d/N52et1J6n2i2dY1UG9bKX6I+A?=
 =?us-ascii?Q?bIa1MUScr73xOBm+9arxai6wJMI4hD68gaAeNAJCY23xHcNNrZf/Xjm0nbvX?=
 =?us-ascii?Q?8uBt6s93QXuD84pBbNh/8ly5NfsulcxasFJpS4sGDpSYdPtYDTWeBHx6CS9M?=
 =?us-ascii?Q?41RGyY+6yw1c8Tzyk0sxCPK1numeYbqBDhninAIjNVvJMH+Il0V5zZptiNoF?=
 =?us-ascii?Q?t/p7CoQIEMd5q7EltzE4FUwhKhOpOzTiBqk9bxBK0AljeHF2mr+qK+6w2PdC?=
 =?us-ascii?Q?LEiaSUALjat2IaQtdK7MiHaghbuTOq2oRoEKOWUtFRfquj0vgKfwTliUX8gc?=
 =?us-ascii?Q?yeZGJ+yLv+N0OdFZyGk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:24:05.2117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b476b21-c052-49ea-4337-08de28381421
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Move the TYPE_PXB_PCIE_DEV definition to header so that it can be
referenced by other code in subsequent patch.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 1 -
 include/hw/pci/pci_bridge.h         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1bcceddbc4..a8eb2d2426 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -48,7 +48,6 @@ struct PXBBus {
     char bus_path[8];
 };
 
-#define TYPE_PXB_PCIE_DEV "pxb-pcie"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
 
 static GList *pxb_dev_list;
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index a055fd8d32..b61360b900 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -106,6 +106,7 @@ typedef struct PXBPCIEDev {
 
 #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
 #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
+#define TYPE_PXB_PCIE_DEV "pxb-pcie"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
 
-- 
2.43.0


