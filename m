Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C077FCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmlt-0004VD-Ai; Fri, 31 Oct 2025 06:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlW-0004Gl-2p; Fri, 31 Oct 2025 06:53:54 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlN-0002wk-Tt; Fri, 31 Oct 2025 06:53:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoZTxAGORYLlZtK+8k8UXZkLGlWN1viII9nVaJKJJpen644UWEhagoKmN8oDaN855/kch8qHopaYG8d4q+gEs04elIPVbahXCGJWWP82bDk63M1x5ntk1NEsM+SG5xBhOwwD7Glu7TzFA1S/U5yffPKH30bgI4n6urqnf6X7D9pNH+WXyFiyn8mz6vMOVYrCqyJd8SCjYDajNsO9+B6nAppAojRdPDqu1S48Es+iBhWDcAGGM1YQ1sYBVVCTZ9F0CrPHp0BAeMPIA8rPKnPPCoQKNTCU281qpxLeDV0gcRLGub1ChCFBftSULtXiSo17KyOrOEouwE/dFadMubrcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx0t6yErUDaEZlgyh2m6Z+oTtSQN8Wl6skzEnWig61c=;
 b=Ht5Bmmebj2YaF+futSaaIBq3WgL5iW2Lk2jQRI/TgA4EzrrB2or0gN4yQPoUbQPDUeK1LuyykpJwjD4XHLHx813Fb1EHFE1IKmajdwScE4jxppgl8M46CkRFbYoSSqyqrR4AF2HHLC8q/mLy2g5PFDFtS0OHGO9ne6uw51PsvkHwfJuce6JBrT/XtYKGqAlPAVsPzHIqckJfcHzwJ1rB/AtCxaxT+4R0lXWZLiBYM42NerZXh4vcb2+MuYvWMRpVKPkfwp/GPAo3MP6Q9/OT5peTmSIXgHgYIYgjhplFjxeka7/g1JtzPlCOZHkLfhU3flMdcvnMswTHQJUTLakFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx0t6yErUDaEZlgyh2m6Z+oTtSQN8Wl6skzEnWig61c=;
 b=QNzDaexIGi3ToPqlYM47vqxZwhLRiEdW+8fqMNLSuIKL0p3pnFhWiuxl6B/uputV9DhKX/I4AW2UPdbQWtHNiq5taMiWDv3qbEwc6rtQadXPtbgGtGAtajkIDSfI9GBMtibfhribrtJCBB1TxowKk9z8b8FIe2xHzTyPvDv0rxm5843cBhZrYjILVMQSfmA6RiRAmMuAWu+HbgCabZGFSQu0ptRlP/+8FDQOXtteJDuV9WZ5vGMHGu1Eb4kmY1+oy5CyuhbPR8nSXpWB4v3OdqJlettspnodGOl6GOAAkV7/XAD6Z7qAMj7IDjrdM64nVK5v9RAdJBeFI0C18N4aIQ==
Received: from MW4PR04CA0315.namprd04.prod.outlook.com (2603:10b6:303:82::20)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:53:33 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::1) by MW4PR04CA0315.outlook.office365.com
 (2603:10b6:303:82::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Fri,
 31 Oct 2025 10:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:53:17 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:13 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 09/32] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
Date: Fri, 31 Oct 2025 10:49:42 +0000
Message-ID: <20251031105005.24618-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1f98ba-33f8-4550-ee44-08de186bbb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AcFDborJxIV9K+yruZr4dPQH8RUkZKXNhSd5n7MXwDgpbfR2lDpDGY/KDPvy?=
 =?us-ascii?Q?Xf+G/ZSe+vJ6ZdnCPmZrncgZ4uYBSRWKUQH9fgOx/lalsHaxqv3bVC+oT4fO?=
 =?us-ascii?Q?VYLLg2yBDt8SdPEruClc9O/rQLnSFWvqa66uUMb/R5sYCr2Jf7oA4/I/jiPj?=
 =?us-ascii?Q?wuyQO6B+Qd36bql+bsJCM7KlLH8RaGNtGI+sgLM7F4A49ptkDQo00iEdgRpd?=
 =?us-ascii?Q?+rLIZ/Dq/K00j0+W5QsmXWSirzJRLfaqQ6sPxFkmN1QpRqI2/JEke7D5MH1g?=
 =?us-ascii?Q?gRuDxwDk4UYygH5lcFtFVeHt+GsFKSrsMA/e4rVAMYE2OMJHvuDxdPW2PLtC?=
 =?us-ascii?Q?pvexyLB/Ty6kHQGU+I8ZkhDstWjlP14TpIh2Iu1ZA6Hx76YsDHjYj3LMgrar?=
 =?us-ascii?Q?i0H7cp1EqnhEIBiHvAbTWReFqXZm8p785bVm8MlxOouUuZTns9UevZREnESO?=
 =?us-ascii?Q?uz/DXLKQVI8vH9sonb19lwhus50y0w+TpT7FWqEahdH7RyJ95gfihzXhwviT?=
 =?us-ascii?Q?JilmCxZwDQigXC4QOS6ooshM50SSw6PuCHEQWei38MdC2RyFQwqpS3J/oGMb?=
 =?us-ascii?Q?UXn7SybAXrKaJZyp54pXVC2qWaGpVaAvxVf5cgUdpTTpheTlXq/H4coW5uF5?=
 =?us-ascii?Q?WuWTfIr1mzVr8DnsVqrMUeX3K/ySqnCXZw8WKz2gIcqEUcfQQSUcBkpcvxh0?=
 =?us-ascii?Q?vRj+gQMcQiyFHLJEzor+kfA0IWQzYwIC6AIFW4qqffQshKE61BkZKXBygmTa?=
 =?us-ascii?Q?v2rP4Y9O7qEblRKFUyagWOOyl2xqtgxQdP8RvDoofJ0jjGXmvn+HmCYhi+Ws?=
 =?us-ascii?Q?dDl35nNNBYNsS1ZWFPHshR6A83vOTDQVmdWeylvY+1+i62qa8yXa94imPRJT?=
 =?us-ascii?Q?GOx8nJQ0X9Y6xCkihxksbLIYxOnbNekR4rRK4+i0M5tShbDE6sbXS+2BVV0q?=
 =?us-ascii?Q?pypDaQgbt5pHJ0cdn/nC1KyoFPWGgPJVmsMG1zkNHFBv24zj6nld4RtRMc9p?=
 =?us-ascii?Q?79PsbjnWM02V9oHbbVnnaIXyX46hLqS/OEvUYmuCp27Csx5lzqjjJ6JgChUW?=
 =?us-ascii?Q?uxnrIor5etSGD1UzR3RQZ5NTyrABHo5YUiiDnqRHcTbvGmDd4ag53DODYAkC?=
 =?us-ascii?Q?6CPVMipFhF6Od9h8qbhEzI2awCQo3+S49GVH+VfnBL3igiQCSULnlc5b7+JI?=
 =?us-ascii?Q?1ztsbSVEWCAnC2Zt4Ds8IDqbLrlmygCVlxxdKrA5T74Y1x6PGDgvgUAXpxDF?=
 =?us-ascii?Q?9IN33Md8eAZ1YCqJFo1YNPJPrbbEAKNbmHjykju5eKpWU+kH21IPaoU4BCoS?=
 =?us-ascii?Q?yqh87DoHptPyrFj8khXw7eD/9mZO+5BHuEXVrUXYt9Aau/GW9b+Dz3TpVn6B?=
 =?us-ascii?Q?PuFqxSHLI7+7e/t6GkbBBGtygC/JOhEuPPkHTPkRIBbYfVIypF3Bbtp3q2XJ?=
 =?us-ascii?Q?G3jk9R/xfQF13HjLbPEqGbgHkHROELRregoTK8tp4AqkpVb0a8RNoSPbWb0M?=
 =?us-ascii?Q?/bp2y9KfgpphtRsYuzNIBLvHFDt/Yrg08t4srpc/Qo83luWD1AdpBajn62GZ?=
 =?us-ascii?Q?Op2n3TOytjxA3cfWPp4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:31.9856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1f98ba-33f8-4550-ee44-08de186bbb9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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


