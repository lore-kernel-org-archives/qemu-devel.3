Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E8C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRJ-0000MQ-Th; Wed, 21 Jan 2026 12:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRA-0008Qg-CF; Wed, 21 Jan 2026 12:56:13 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicR8-00016I-Re; Wed, 21 Jan 2026 12:56:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfdOfXz5hWITNQE4Svz2uY2lkgirl+Q6KqzZ/GRcrmIL8thMsuVImqdFuzMu9CzSIzyivGrKgWlw3rDnYJBY1cyffOGtDmaULd/EbHpcEG47h6OK1tj2oMaiSCYphOZYcBt3R/HgnBAJQeR0MN0nfjAmXpnMgq+WGOVIjlYcM2sEjRsezKyIkPiirvpDMbCFp5tOuR0thJtI0WU4CsWJGUTNwX0hYnxEVMzMnE0dfqpUXosyi7ZzuEz/egoeI/Ym75aLFkft7ROrBdw8cUH688oBSCZ9KvVlNWSdS3G8wfH8jp4LmNToZf1HlRpgPpxowPlOc2LLwVwxQJiS9ZvgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtOUfsa1VCInpnm7XuU/uj+SqVHRjuzwS6zpRaRNLIY=;
 b=lNy6m3SiGl7mWmguhzg8ydna2PhKh+DJq+8D5twul+HfHGFpyNsNAQKYHCktiZxZdvyvPqu4zWQATpnEHgx8yPFkmJIlPRXzac8fGr8XeHNnTSvbK/DUbKVOYaMiMg037wBZ8NsXfYqmPdCbarLeW/TGoHJnASm5hQsQC32kJ2c712mw0YM5JYCImhaaqEbaEzm2pL+1UojoiLnFYtaq4xtgbT6iZm/Xuf9kG2n54uiboqrorWASLlcVZMcIpNtSs3dP6z5JYk/UtqFCbjgwbpPzOpgOy2w/6NRa5pfMSQ+Wz+3CLGAVGImYuLbHIiPnOxsXZMAv5pAbNG4D2rO7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtOUfsa1VCInpnm7XuU/uj+SqVHRjuzwS6zpRaRNLIY=;
 b=MKw21N+w8h+/yX4ggz11tkXDiURumwgzACiwL1EaQ+tiwqR28pQwt07HWJ/lkyiyW0J5wpgovZCprFpBqLAIdXhK1g7HTxT8XknrDcJ1t3/a9/LtzFF1neIO6Aq8UR4NKemtK1zQw/f3rRVOWJdKLhv2bmoB4gf5cG8nuefW2kHC9UGnu4otSNXnYSqN68QGzwcuhZMdtCrbMKLOeHR7Y/jsToyiF6uONIeuJUIxqW98QQQzCwID3o1b1nEUi/XKgealL+y0M+ClEvzVKpcWDudzKLOPtsWIuCAOGAGDPTdxVnb+ZYjhiN7RRWqH12Rs5m0iuscNCL/LLf+GnhkhXA==
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:56:02 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::46) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 17:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:42 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:38 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 09/37] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
Date: Wed, 21 Jan 2026 17:52:14 +0000
Message-ID: <20260121175248.87649-10-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b90890b-613d-4d62-1edf-08de59165756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K03C38/a8ERljqFDONCIG6Io2wEBFTSggO0u/MgS4AYbSR+ZU+DPlUhVBDEi?=
 =?us-ascii?Q?TQtUdlJ0vchV5rWVsLzeVfUxkxQ6ppz/lkMtNd4T2TEubWdGVIZBgFobEs4L?=
 =?us-ascii?Q?v73XZb1twcjLwoeSZ+fvPtrL6jRc+jrsQkAO93NtTN6ZU2XYwBv4SkRcjdUn?=
 =?us-ascii?Q?0SBmxO3LD9Eu+V7RtcxFoDsKBs+B7Q0JU5OWL8Ql7OV/VJ4fCGIWvKXrutl8?=
 =?us-ascii?Q?jdfAKtPwsHG+fwLRHZxkr7ZCuzkoi2WNsNnhA4Q8Xbnrgqhe4Sao5WTU7IZd?=
 =?us-ascii?Q?XpDBdX75VshYaKYFUwQQ2eCtV6F3pr6MJVGVy6SO+p9Hllcs2ct08Bz8QVJt?=
 =?us-ascii?Q?+CChbBXIljeu90RxaQnmQhaoftQ+jw60/L9cp15/Y+G67nrfJ/zsrTcQAwcT?=
 =?us-ascii?Q?e3UDz9d3EJpf5myHehpe3aNJsLmHiNTVB5ZR5EvNLPzmQodwtztqmgPtnxyY?=
 =?us-ascii?Q?9Hm+v6z+3Rht3gosKSWZVfnxrBim9Klz7sCK+Gb/rtsgZvnDdUBNfNGFlZ/g?=
 =?us-ascii?Q?dCCwdw+ZlV6+FgNkuxcUwtRnFd1VArhQ5OKYHIcM0/fMXzMmdkQ0AOn1Lput?=
 =?us-ascii?Q?MESVtqpVfUwQM2HWKBdQW9IBF553PsgwB7J9lmgk59oZR/57DY+lhjixAYru?=
 =?us-ascii?Q?67XysRNbHUCyq9EjhMo6G0eGLJI32Hs3h7Lw9b/C1c71Paesa0/sTKpvefNC?=
 =?us-ascii?Q?EsSJyccw0eW6oi70tm6Mbg6SH8HdJnMHjJRG30oYv6DykUFuU57SbZizFXcC?=
 =?us-ascii?Q?LzCCkAxlWTapgzrxb9syhQB29twC3w8xPw5N5h7z44neLatwnOo9kFwwrL8O?=
 =?us-ascii?Q?fUmKAbwpQBYXxi0qkb9avvqyre4t5yrsqu8zL5wDxBleGgc9PmA0VKtxXv2o?=
 =?us-ascii?Q?Y5IU8uY46pNzxN/0gTcQbQJIZDYfiFNn+EHNMjaH/EqDOC6cxQbEm2IdG1e4?=
 =?us-ascii?Q?9c3du5F7Mgz9c5TI0at6GiZh2NR5fNM2kv89Fx0YYPqVs40uSUr5mbhMHFLq?=
 =?us-ascii?Q?dNN/7FMZbgCANi52E985mptnNtDHZWZI0pxcAXVdisCZD/8jnPScDCeXc5K9?=
 =?us-ascii?Q?S/sHOJtMJTR5JTrgnMPh4KjeN6K80gL3itVenmIJIed02axB/vNU8GPSZYBu?=
 =?us-ascii?Q?zXlJsRXyYyrL8wAuU2QS1N4YFDORRUsx2MpceBo670RP1RHy3tgiRLvXlhda?=
 =?us-ascii?Q?wkHclkILt3Rc+ypDLcMHWx8bBITKv6nwpS7wJJ6EB/Y3DGQcLAxSH+iygq+D?=
 =?us-ascii?Q?XB7dJzKfQ2BJ7tRaseFMa1CN1Wjn2wc1L97kNz6A2M+SDf9N2yRlNlb372vq?=
 =?us-ascii?Q?/rIbVeYA/Urz2BzMijRhUTuts4yWKDjB6unOG1t+PO2Sojmj1IeoSpgPaB/N?=
 =?us-ascii?Q?g6GhMQ2/yeKeF3SDb03kpFzJkVzwAUBkNgtI1a306yZzygeS/lcPFzNzryIy?=
 =?us-ascii?Q?Of1HvYx+d+xTylbCeGHQZBlAL6tbAyd/ymKcymVj6H058pjfe5mVs/uiLzZv?=
 =?us-ascii?Q?KRKzkqMwvr4rD6Hsm3PzoOlNfIV9VAKgxfZVjaD/hzZIWA+UBNo5VzbWSxLX?=
 =?us-ascii?Q?/v/1wFjNoDLaaSzQnfh1mUg8xDIMkT78HNLTgH7hg4FZCWpi/WO+jdSMGsQF?=
 =?us-ascii?Q?ckLJzHiLNhiIiJUntwz1I2BCBqqhNKzy5PpdAIIjE6aSuJsaYV9hA441w+jK?=
 =?us-ascii?Q?GXiGxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:02.2314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b90890b-613d-4d62-1edf-08de59165756
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

Move the TYPE_PXB_PCIE_DEV definition to header so that it can be
referenced by other code in subsequent patch.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 1 -
 include/hw/pci/pci_bridge.h         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 08d40aa2ea..b6e2eb7969 100644
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


