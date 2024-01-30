Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C4DC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUobW-0007gM-9H; Tue, 30 Jan 2024 08:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rUkwM-0002mO-IO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:02:02 -0500
Received: from mail-co1nam11on2061.outbound.protection.outlook.com
 ([40.107.220.61] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rUkwK-0002fl-5h
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:02:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXTwW6VPmYElmeYq9wHxjBCT2VPsX7IR0ZOVBIo1HqfKTl8csOHo/ukrKL71neBE50Gm4U7hcscYS4nn+iCsrr35pE/OGC1fzRohxhdPmcXu3U3KSekLnGP0qDm/3tYoTED+pUlvc5QcrvfgZrSkKOXagN/LjApFvJ7QMP9W99pg/noaYSUHpPIyqldIkNUcJSwTQ9acFj6V0YSbfIpiOfvUq1/x6Pv2Oa0SRMKC8hgfOmXD51C2V4QOqpRyzv+f6yaz4d2y1YJG8EqSoGTielb65bcSWdPnQ79+8mStacv8o+tHe/+BMwiZlojoOMms9TtMoG5j86TdI6Q/axKiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xypyhnSkwSedbMVvCIjthXC8xlimfYnCCpPwbFol3cI=;
 b=f4cl+SdMvmimxg0TIDSg6gPB8eUdiUL2wr+hmNAh0G/O6vc6eNn++PEKoOyY4gN+/TIJDou9RaQEgx4DGT60UbOmEywuxFmp2jNyRyBRIi5kkrovUcEQ5dw+vPaNOBTUvl864Fmxsfwvt30wAf21WqdbwBbMi3RJTFbBB5h4RBoMJyBtsiI+Hl4jShQSxszk7Aw+Ay8vVAun3fJ7yQMege87L0kCs263yb4/fIoIaN3+CMqN0qZR95mC47wrzD3IscEOFwQ/hgCWVG/i05K17fNwRDAN2eaPkJlM0sYOLhGH5NyWOM1Uze97GftK2L8J4aCm4OGJ38eO8TjnaJXOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xypyhnSkwSedbMVvCIjthXC8xlimfYnCCpPwbFol3cI=;
 b=NiTGqL/9Jv4PzGyTksSBdyTLoWwEFzT+LToz/vOtLvmZUjLNPlQkVNsI2pbKjtisvj5iPTRn7Ny8Wjjjn/BL6xeq36c28Cb4/I2IE/MkwJa8PETmjgX4pCuyF0YSBL89l+FTnAeX5WTxzVewIqT1bMcwOUzPj6EdkiDtKtF5PElubgAW3fe4O2ui1GrN6aTRvVanLvpCIkNGHI4PIs4rtIG+7PLePuJvbLEFBE2I2F5XSTFw315nQyjoMnpwLv3irGbj+HI/GR2Pb19jrheVqgl3LiqUdpaNjqcoyykPL2cBdeKoTQ6zDH+TqGgmOOdn8zmWIlVT9fla4tXfxiKCig==
Received: from BYAPR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:74::36)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 09:56:52 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::81) by BYAPR05CA0059.outlook.office365.com
 (2603:10b6:a03:74::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 09:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 09:56:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 01:56:33 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 01:56:32 -0800
Received: from vkale-dev-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 30 Jan 2024 01:56:30 -0800
From: Vinayak Kale <vkale@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <targupta@nvidia.com>, <cjia@nvidia.com>, <acurrid@nvidia.com>,
 <zhiw@nvidia.com>, Vinayak Kale <vkale@nvidia.com>
Subject: [PATCH] hw/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Date: Tue, 30 Jan 2024 15:26:17 +0530
Message-ID: <20240130095617.31661-1-vkale@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b68c212-fec1-4998-c14c-08dc2179c88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSjgvLI2vhhe53HSgqzVMX1DHp8c5G1EUy5+0DP5qAtprTlHMx7GEqwtlvG/hmFHP6OfFOEE/7g8O2L+Jp5cQa+Jf6/Nffr1a5ldFJ0X9znOfziMoRNWKLk67GFzV+HbLbR/xyKtwCA3gyeozUEh1SR+vCZ9EaOAXaZKABVz5YbeGbdzaySfJHmJJmPokmupMWrPL8HkwK31iz2yq/iGSozieXxcpLI7bOEPADQwJx/WxTMMaVgo9koACRHLfKEUTFY4Ipuw0jtb8MyFyxJqKoKOPK8ZmCIaOJF4E5SO+oETDMlZ6pI/IPAunBZetVPk/sQI81FkUHfEc1flYpI+dFFXanzwXlf7Vwz5S9/NGooMEluoNeE2GaoOVWr5yxEPCWoJKl+Mf3TBnXFtOscF7GdNhIig+sr3aueN0Xg7ikMUwpK636cG8LhKxqs6JKXeyIxuG18HCBRVperN81GQJNXuD8woIRIgDN5fYxWwTDE2U44d9I/imqfeAtGYpiJXxDrYNs1hlN6yNWuf97F0BBG/p7MfHbL4wa/p8kFBPsAcfLkfiMDC2XZ+gyuv5k2XHyTRWegute6CHdH2J6H5S4RJskED278bf2oi50DmUghEfyBUWFqo6noXNOxrGnb0OfzQPaBx7kjkdrvSktrkeXt69Stp/WMn84d7Ya3y+7r+Sg7ZatFYOVtpdhlDj0JF8sRfWDrAiQDNsiRUgu9j8P3+R2jAAMW5aIpy2BiaFtp/otFmdiznr5337EUQF/WQ
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(40470700004)(36840700001)(46966006)(336012)(66899024)(316002)(54906003)(36860700001)(47076005)(36756003)(82740400003)(8936002)(41300700001)(356005)(83380400001)(86362001)(478600001)(7636003)(4326008)(70586007)(426003)(26005)(6916009)(70206006)(2616005)(1076003)(6666004)(2906002)(7696005)(5660300002)(8676002)(107886003)(40460700003)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 09:56:51.7501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b68c212-fec1-4998-c14c-08dc2179c88a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
Received-SPF: softfail client-ip=40.107.220.61; envelope-from=vkale@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jan 2024 08:56:43 -0500
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

In case of migration, during restore operation, qemu checks the config space of the pci device with the config space
in the migration stream captured during save operation. In case of config space data mismatch, restore operation is failed.

config space check is done in function get_pci_config_device(). By default VSC (vendor-specific-capability) in config space is checked.

Ideally qemu should not check VSC during restore/load. This patch skips the check by not setting pdev->cmask[] for VSC offsets in pci_add_capability().
If cmask[] is not set for an offset, then qemu skips config space check for that offset.

Signed-off-by: Vinayak Kale <vkale@nvidia.com>
---
 hw/pci/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76080af580..32429109df 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
     memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size, 4));
     /* Make capability read-only by default */
     memset(pdev->wmask + offset, 0, size);
-    /* Check capability by default */
-    memset(pdev->cmask + offset, 0xFF, size);
+
+    if (cap_id != PCI_CAP_ID_VNDR) {
+        /* Check non-vendor specific capability by default */
+        memset(pdev->cmask + offset, 0xFF, size);
+    }
     return offset;
 }
 
-- 
2.34.1


