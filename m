Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C479CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK75-0008BA-3V; Mon, 26 Jan 2026 05:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6C-0007K4-Q9; Mon, 26 Jan 2026 05:45:42 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6B-0005YY-BG; Mon, 26 Jan 2026 05:45:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFgI6fLtb5Mg9/PMj8WSNJFc7kBJJyY6Q+1f/qEZNaEEnPjBRNixb1W3dV0sORADU5maAas4NSlvyPGH9waQwz4h+I/2ebbkcJ2CFPlGU45EfkHvt6Ck7WSm9mR3eO835PC0AxNsA5jCPWqpma/minVMxYU1NwuMGIHzrmQyVh7m10EfxsMbfrR1ULVFyOgzhwwjILM20SWMcNcRprl7OlYPpDAbm1BDRh3mtW0bqf12GfbOic1o742PIyHDPX78hNA5fhnkGvI42Z80NnJ5wqTTZ8Qfi0qKB5a12VIDA1IrnbDIGfQcjg6dNN4cnGNbenDkZmTdhjIcePGIk4gTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtOUfsa1VCInpnm7XuU/uj+SqVHRjuzwS6zpRaRNLIY=;
 b=BWOpCL+HAHs83b1hqrnso70I1Foeaw/NoV4Nj6cm6V9Dq13H6aXjeGnPwYYGTuXwv+YyzpNdjCaOa/7pORGpio4oDuhCgLlJ4VumkQuwuU98HQyhdvfqydA/XBiZqXyApAmAFdhbCfrJFvR2RreKMteUYbhrSYItH9XhFNXQ5gQlq6mdsitO4Ug1EnOab4h8rgprdJzDCeEvd5lUrldWju4jXpdxvpgNDkQ1w7zkwJtpNF62ZiON0IDOPEjiUr46iIb+WPtiOeoXz3J1Q8r1IWgCi2qCN/s6QIZgkLHrXLYQJngm4//bclpiTgOGMLfY0AG6HXkspLFqcaMiOnNXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtOUfsa1VCInpnm7XuU/uj+SqVHRjuzwS6zpRaRNLIY=;
 b=WORGlen0fYDL22EkfFuWOawQUNeeXjA8UofJTbfJtMkjFqwdpdqu6tBRvuLsMwI+5b+jJDpkZ9PzmTehkW9FpcngqO62mWzFV3Uns2EmZzUWEEnq2Q0u7pEjW4EAsAzi9qvPcBdmmTlgjrVLLDwd1mIyJlldd0h0yNKmD8wt99x8AXoZta7nowAf1eHYnZKC0TX1bOGv1yIVy4hRSu7Ibr81Ho0gVl6XeeQ3JRfSVgJI5i/1+khGlBLivWsit4ZYRbCyrcPU2VoVX99lyByO3Yead8T2fqYTu8jSq2D8Vw7kQBfxWHCNEcewnb8OqDXpw4WOg2tJJzOWB/qHgaU3QQ==
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 10:45:27 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::9c) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 10:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:45:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:11 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:06 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 09/37] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
Date: Mon, 26 Jan 2026 10:43:06 +0000
Message-ID: <20260126104342.253965-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: d11e670c-20f1-47e2-8035-08de5cc804ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jhLIFL224bLVdAZ6aZEhwBN4TqwfSel5tkCMJ2EO8xUkOs+OhHbVMFMmhPTw?=
 =?us-ascii?Q?4BY8p162lfRCCccPOtVwT7jXRs4cMPO7aLblROVxqJlYCGV8Mq+sWiIh8tWw?=
 =?us-ascii?Q?RH7fwxHdMEfHkq+5QUFdw6VEfZt/pm4u+3WFVq3SCxyZSVR744cxgRl2+Q16?=
 =?us-ascii?Q?2R0bI2uEti8/GTm+93B0xNvbMskG4iaQEss/Ex4n44C+fIqMpZkMQCsy+H1e?=
 =?us-ascii?Q?gcCHf4MS5Qch5/c7TZ/L9nm7cQeQcT7LcbIuTR4m/Yoly0PuAGh9R711h4mn?=
 =?us-ascii?Q?sceBMkc3y411KtxnMqg4bm2IfbZTi1PV0bPbxzqJL8kFPzP3u6BsLTXJ9wCu?=
 =?us-ascii?Q?yJtvnJoA66cvudCkJ9gqEeP3HgGEXpNtTArJOY7NmPRFbiRCBDocwXdhTbg/?=
 =?us-ascii?Q?45moMWLmMZM2C6NTbwtHG7fyEuPKoftajGd8o0uaNNOpJg067iE534wtoq1s?=
 =?us-ascii?Q?sf+jn/E/l4bKWHT49gnkpQwE4kgbceJG7rb2aEybaXIPgL+zm38G0rqERVMu?=
 =?us-ascii?Q?gvsCImWDFXraQGDwgVDd/OfglE8HaoIgcOLiNPMx3FqhInDS2lCs9Ldpa3KO?=
 =?us-ascii?Q?1qDqkIKHk15ZUtZrPXhEDO9B7544PgJqW8/U97tCvnQ1AmF7ibwxinFzpj+N?=
 =?us-ascii?Q?52EgN0+sQ640s7wnKdcnylXPUhPGRoLnTJVx7dr9/cYwQldIFA4UN7cXg1YL?=
 =?us-ascii?Q?oh5J0by4a3PbFuL732pLLIGYZIF03wj+oSdOXlu4Lp7DW8M75PSC5rGvHVgU?=
 =?us-ascii?Q?WTS8/7O7n5QmNfBBrGo/R0U98O2suu9ZBtC/NwinwWlbRu0D1/Z2p+WIYEwz?=
 =?us-ascii?Q?r06KaGc2H/Q0CEjQXP/On/RnzfrRTe5wcEWFLJ8MLUfh959eaDolTCJBPgrL?=
 =?us-ascii?Q?tHENk4r/Bus0XZ8M7O5fArtArLGoTMVfEd3QG96uKK5ifsRj3GVcC49qTQ8w?=
 =?us-ascii?Q?BlJ//oGuSIsSofDvmgU2IBjjJpiQpA8cVhi/fEyOszt2pe+umfM68ko4/OFb?=
 =?us-ascii?Q?WiXNoSveSBI0d8ADz5ESVnus1NyzTEZDzUuUR5xDmAmGgiNubBqyw5+ADAY/?=
 =?us-ascii?Q?677gRfIpgvnHfPyLGwEPwph0HL7WznnkbZfN7tbSIbK/HApy3ht1z2OcUp9c?=
 =?us-ascii?Q?AjD4pyOzmikDOCnW+Itwn3ikd1637knMFBf3axzD4ZINd4As8336ZaNDOBmO?=
 =?us-ascii?Q?jn37tblF/BFtlKjQF0nSYAUPB3xGMSOvyczoRxhPAGhqj7Bl/92RkWpBJPGk?=
 =?us-ascii?Q?sMURxGC2mcjmmtHAQDpoWCjzmkzfhH6r5QXzaRnGpEu4T2ETmuku48NW31Gj?=
 =?us-ascii?Q?fAvuQUfYbHOHvcYWfWXyPe667NA9R53vGpzMCPtejCoh7aLVCexLWmYFUnh+?=
 =?us-ascii?Q?Id3Ofk/3UuuqsWhOR+jEqWC2g5yjWz1S53KVNZobZqTGaIDXSADT0fKORO5k?=
 =?us-ascii?Q?efoFiW+RQ+h8tjNU600WfOAhRIlLNouCgDUvVBq0GKXV7+hQJdSvRAnQ+p1L?=
 =?us-ascii?Q?XYbO76efq/BARcdJXp8ohX7acvTgML2u4FE70D+fwfw4ZF96AtXKS6bYGH0f?=
 =?us-ascii?Q?s1WEL59MfJ4EVD5Ledi4El1fR9esOc1miESGofVYb7od3roiAUhBkCjni6EL?=
 =?us-ascii?Q?j5PNAqqUx1ZkEI28Wch9Af/bsFpEi+E0GfM8mgexWAaaAlQQn0RSbcloiJEJ?=
 =?us-ascii?Q?uSYXoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:27.2917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11e670c-20f1-47e2-8035-08de5cc804ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


