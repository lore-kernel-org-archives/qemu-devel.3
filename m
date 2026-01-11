Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2962CD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1Yd-0007Ka-Rd; Sun, 11 Jan 2026 14:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1YE-0006jR-Bl; Sun, 11 Jan 2026 14:56:39 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1YC-0003si-RC; Sun, 11 Jan 2026 14:56:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUdK3IkuFObLVOoUtXEGE9wCHNUfJRM53171DdaflHaELiqS90kU9TqsDg4N0vnc/h6yqvq6eeUwNSxYFPfk4PVWlSafVEaidR16i4r+CfDtYWXOG96IbJuLJmXdf4UbhfHGB81R336pWTuaZ/oMPml6sMCo18WpMXtaRw04wxC9idtDhirh7PgIkZj0TKVX/urKQc1antIh7v6YT4Khn43ImlyvuKgIHfIziiGXPFCPeTvUKilkwlUGRWv6BJwy8ck44rPBzEP56RN/Xb2J9RRkIbhwWMIlmJLoy1Kt29pseZzzlGSQj286TluYmW1ZmHJahsL3EVxPT7GS2nOOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=516P3AKLlGH8uWKUyIJMycxGOnz1hceF2gQ+NErec7w=;
 b=dg6BUPcsCe1KRfYbjSH3p3ZvIgCARQF0nj6FVWC6z2Cme9cG1fll0O8hPXFeHaNAzbK6HZX0FNNGX3q79LxS3cu9FKx0znc1M6Oc1cOzPwqfPSCZEy2KE/GAU7KTjOxpZeOyFnUhf9MqGRxCuUliW7djQmiYW/CcxdHvCQtmeUMNR0hpCANlNGbhZCrUDauPEcnzjksNboD6AE13mQpgk0KhfXbcXYTvxxmBChNtHwq1RzwGNVFTEcZI43Jb92VlvUSIxQKMdSkLTse7/F3mABjotxFfrJMwnJUCCuOXA2lbnmSbnCBiFzZnjEWYYdU3UQiyTpjNUAzm5tHZLV7JJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=516P3AKLlGH8uWKUyIJMycxGOnz1hceF2gQ+NErec7w=;
 b=sJSqA/rxDjApImkNCd1HRlOek8Xe/X/VZc5VNJdVTSZ7oLkeE2+tVKa6/e2GNfgePot7mcpTGghoA+wGinzd23O6eiTENKIz/br1Mu/gXNAsxRH876e3zvDXNVmUW2gVfrx2+FIv/mx/WwTPxL5qd4KS1vTkDY6Tw0vb/nBMCSfKa6CdYTf3g8IBcHPHENsLeGLtJc56SQ4WZONBca9tz3no/qlSY9WjxVA0xmR67USH+Yusp3GGw0a6MD/URL2QG2QwAJm//WS/vfrqGmAn3xK14atci8ZjDCAXV8ACQmHkZWm7NqDshkT9saye9aehcgsH+WiTEsCHtD/ZwPthaA==
Received: from SA1PR03CA0006.namprd03.prod.outlook.com (2603:10b6:806:2d3::19)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:56:28 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::e4) by SA1PR03CA0006.outlook.office365.com
 (2603:10b6:806:2d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:25 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:20 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 08/36] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
Date: Sun, 11 Jan 2026 19:52:54 +0000
Message-ID: <20260111195508.106943-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 778d4d9d-e983-41cc-5feb-08de514b8249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ch1WPFp18Ea4hIHEosbYOyHjWoGNxlGy9lTr+dT8i4j4YS0x4pTF7MFnmfd9?=
 =?us-ascii?Q?Nvd87v71NqbOHPk/ZmyF9xizyoWkBchH3AB5sTK2sm3GxlvAB7BgMUUGesDg?=
 =?us-ascii?Q?SjDcoC578yIZbn27OA8E2EXkuuRntQ+HxaUNonyMZ5IotIP8HG5LS40RqgHt?=
 =?us-ascii?Q?DC79+DfpTcmDny7GtzEdiOcIkHZSrySQ/4egk7q/TQ1pFhgw3zbMaohEVGfo?=
 =?us-ascii?Q?PUeydjrdpspIfB4iYLLB6UgUKVcOmMmrI3zd30w2z7NusNPEwVfrtmG+msdw?=
 =?us-ascii?Q?Rybx1e7aB5px1Yei2hNwxhawIqHCPYntBhUey+b35oF4kZhJ04Bpo7GDfSRJ?=
 =?us-ascii?Q?midXh48x//7Tj/nYDSxYzzKhA9FTjzY5ztMoC02cDtVMY+Xxc/TPupVu6xnm?=
 =?us-ascii?Q?vURyuMN0Zd6CoyVJ8EXS4r/xCo2FAzgL6If2aQEgIMLdOUchcvcMIgnWqcdV?=
 =?us-ascii?Q?sJCFpdYD40XRJyGII0S72+9Cb7eST7iSnjh6fxAS2PeHLcd1gudTJ+Dd5wW/?=
 =?us-ascii?Q?Mfzlsf4eTlf39niHcAtP+9lnNzG3a/OYb4/MLvOe0eTAZb1Bq5l5lKIJ4L6J?=
 =?us-ascii?Q?6oFyT4Wkh8RWbxDnT+JQBHR6HMHsvftRaIXz+QS2wnaIAdrZNLRxcaWERQ3Y?=
 =?us-ascii?Q?3OQDdmCOSpEU+KaHFWIOYaqliJbfTBVWXYo2isKy7hNhM6xBH1hNjwLgXggL?=
 =?us-ascii?Q?5K0Ivi07PiWcaOK3qRbgtkYyBACAI7Moe9GaYW9w93GtInHWvUHihBkoIgBs?=
 =?us-ascii?Q?8qjJPchg6StpwtjrWWWZvHArcFo69KYqjAFk2SagmiWLNlI7ocmouV5R6zx7?=
 =?us-ascii?Q?0eY4GcsJbHX8Z3Ga8XzmL91O0nW8gf9LEW3ouwus1ttFuj/IPNU64aRb9ued?=
 =?us-ascii?Q?TGc3cycs7bV2AUfT0CEOiaZGk3kgQuq/wJJFWb4EwE/NhnXUH+muASEq52Nr?=
 =?us-ascii?Q?41XFYlcRb1/aHIvQ/js5z8zOsG5fizRK0UAdyDmp2W9U1Gg+UjUx1MlYFDQK?=
 =?us-ascii?Q?hTm6dNQN1JpMSJD+0Chu9BW0TL6OIXCZXwRW6Patlm+Qn8EILNHkro9uPYma?=
 =?us-ascii?Q?2B1e6AkZVlcA/Hh9rprQJcAp4MFM+6swV72y6U9d37jD89FDxtAeJ9oowDST?=
 =?us-ascii?Q?mqdqsMdd4PtXUek0jhb2JwJSCbP+btG51XoXpYHxU5ZLoFgRi+vKSxHyOWqp?=
 =?us-ascii?Q?az+UCVBQN7Wq3M+8Mbr0q6HCb5+8Aj75IAEPCkFGRDGw3/K27/5Tqz2avu1J?=
 =?us-ascii?Q?qkbUzwR/Mwto6lQX/fnUM19nr1mFQVdwcfSLEXhWwhaktMDhmAjR7YkER4zd?=
 =?us-ascii?Q?caFUrHZsz99kC3l9MbgNzJVy9nqhULGmi0zl08eO57Ri0vh0UrtklMAw+4NK?=
 =?us-ascii?Q?Oc4aSK0D7Invmv+HF2Zh0YAiVWZayAeGWmbbbFsVype33Q/yzXXCBdkbFdwu?=
 =?us-ascii?Q?7ue66CutifAWJxlebxnr5xekel5Aw36lzEDSqiPh/HKwoRhyKitvTv5s5/ns?=
 =?us-ascii?Q?Qzfznc8tNjPKNKu4Az+sK9LnogndvaSIh8qov7hipQUHrlGAcdNhfWzX4hk6?=
 =?us-ascii?Q?PupZoWz9mxgTSt3E7tE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:28.1960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778d4d9d-e983-41cc-5feb-08de514b8249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


