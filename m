Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B405C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeec-0005Gy-Fe; Mon, 11 Mar 2024 08:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rjeea-00054U-52
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:21:16 -0400
Received: from mail-mw2nam04on2078.outbound.protection.outlook.com
 ([40.107.101.78] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rjeeW-0008Lt-1w
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:21:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdFIPWZbW35cnjoWZxVS/lcsWz3PCbDlY8cXZrWAA67UGR9nYFWOBTx55t7x+mnpks1PQbqNbTRFmQ2u73R9uPkJkJ+riaIeoJw9/rZKr5kH873NfxIbWmFKl1Xifj5TT6C7oWGvLCusMHov+hY+2cMg9x2fm1GmYF7gDvKYqd64c4mEvp5YwSfjTjYeV2juWHdJGbKZldg2nWYK4OwNz8Ih+SKA13qrLbQlDzHc6VyJ9BfS1VgUwmyvLPIMK+fpjoQUNCWqEJCpyBjHiHPdmSDf5/FevpJ7COVgcqIUGNBQz65RTQaoconcZCM9IJ5OkmorLDBVCCZ2Oc5MLGtRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnYlo/jpCzeKmtItcUAolkia80g+SLSC9y26UXblya4=;
 b=NjH8huwgq90mOy1TjhaO7fvbW/liNmLCgN0sRhhHMP93Vn141IeRc3QbzDfdufXQIs/hlWwaR05+G5acPk7aw0NA6/q+Qr8eMsxfEyejteMVnYGLTrA1LxbxgS+vIWl86jjGHIgCYxghqLV4HhRoshVSK9dH61KthsUT3BhIOig1BxdAqfuaPMDq//ZTHIvldRSS3nrV3BE91WXAFn78FDhbrO8mXdayneioAllCNFvcqvbNiid7ldvcqaw4Fv+EWJAdSfWqI1ILfhAjD0CzxkjQeP6XWrfETPY54OJvimKCMDwqG06C9f3CLQQSiNjyOi/T93tMPhe+CBsIlJ7CVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnYlo/jpCzeKmtItcUAolkia80g+SLSC9y26UXblya4=;
 b=s0czAKY7and0gp6ScASvukO9okw370PvrQJhBGOjlld3YqG3W2KVcUAk4tScx97h5ORWLp2YZ9/Mzj4aKYT9cIf7QUy4XLVgdis/uNliLO0EuiQw9PV6sOlTL8SH3cpIEBpc11i3++KiVpkiI5jYA6ctng196CubXUcBRlXLsC47jGNDHL/HSpHXe1r8PT3OMfb8DLc5IrWdPyLphzHqx6y/imJrPxdtn85yTwYAHUJxQYdeJeahITVE4via4idFk2vjyUhgc+ZibAoVYNVDzlQb4Icuh5eoyNEI/ZzqaxojNBgW0ls4AZOWYSIMxTj0y2a3Y7M5aKtQgwCSxR+FnA==
Received: from BN9P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::19)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 12:16:05 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::4d) by BN9P223CA0014.outlook.office365.com
 (2603:10b6:408:10b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 12:16:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 05:15:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 05:15:52 -0700
Received: from vkale-dev-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 05:15:49 -0700
From: Vinayak Kale <vkale@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <avihaih@nvidia.com>, <acurrid@nvidia.com>,
 <cjia@nvidia.com>, <zhiw@nvidia.com>, <targupta@nvidia.com>,
 <kvm@vger.kernel.org>, Vinayak Kale <vkale@nvidia.com>
Subject: [PATCH v2] vfio/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Date: Mon, 11 Mar 2024 17:45:19 +0530
Message-ID: <20240311121519.1481732-1-vkale@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 53078364-ad67-4d3d-1441-08dc41c50684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXXpz8nRrLWeXJ3x4b+r5erAp2lUoRh+h8LJQ2iGL+8xQUm3ToCF6fEi72Qv1cO2UQEHOTt6tU1L324sYWylGVCogg4AXkwAzzJFtBIFNvEzNscdnPtcRQpycBx5M9j0CnrsUJHDYkyKQfuFPX9SrkX5F55Zn9xG2tCeUX6B5cMyybZ7P7YlWtKR8xM5U+dnM7m+UmPsleiiBIIpJXE9GhsgJ9FYwDNJuqhmebebGnK4ukgKwrDuaOLCU1p9MdbUYCils5aXAFsIObc6KxSUNTMcjAA7IkNyZE9j0mEbMl0NYSj1ZoToa+K0NdrY36XUe+wUUNSt0aa4Ye1yxrWPqf+NOsgmOcpO2+/jVgfbrEZN2kjd3EDDPL+IxkYsJJWSFORBnwzv1CAXg6FHO+uqPJWu+SsQkM+1bvR3NLxGX3bSfj52p3gEI07PHQvEpehdOKMGvgqQw+uaqKlheyvXKaxhcUiZaasAF2uB5H3+8lUELxN0qR3xsbneLTaRLSwkcGH3ZN1wOYZTjUPGcYFIld0roESEjSqXdgl3S8s/qy5xHDJeHg3w+jqyWKixMlxyEi7492zzkmYVV7nk/pJzi8MC6QAi3WHaet1UDq21OeLsWMDYfHHwnfpULFcdqwaGQI9bQlrcfwHFI8rgkLW9FJGMVTNS4GFRtCyUSe2zHdNqxm+NR93TvLt+sE/3QsqpOds2u8k17yHq6DiKn5D/YXk6oUhbM5/vVKJj7BUJzK81Faj8xHq5msWOLOd6XSLy
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 12:16:05.1574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53078364-ad67-4d3d-1441-08dc41c50684
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Received-SPF: softfail client-ip=40.107.101.78; envelope-from=vkale@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In case of migration, during restore operation, qemu checks config space of the
pci device with the config space in the migration stream captured during save
operation. In case of config space data mismatch, restore operation is failed.

config space check is done in function get_pci_config_device(). By default VSC
(vendor-specific-capability) in config space is checked.

Ideally qemu should not check VSC for VFIO-PCI device during restore/load as
qemu is not aware of VSC ABI.

This patch skips the check for VFIO-PCI device by clearing pdev->cmask[] for VSC
offsets. If cmask[] is not set for an offset, then qemu skips config space check
for that offset.

Signed-off-by: Vinayak Kale <vkale@nvidia.com>
---
Version History
v1->v2:
    - Limited scope of change to vfio-pci devices instead of all pci devices.

 hw/vfio/pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7fe06715c..9edaff4b37 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2132,6 +2132,22 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
     }
 }
 
+static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
+                                        uint8_t size, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+
+    pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
+    if (pos < 0) {
+        return pos;
+    }
+
+    /* Exempt config space check for VSC during restore/load  */
+    memset(pdev->cmask + pos, 0, size);
+
+    return pos;
+}
+
 static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -2199,6 +2215,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
         vfio_check_af_flr(vdev, pos);
         ret = pci_add_capability(pdev, cap_id, pos, size, errp);
         break;
+    case PCI_CAP_ID_VNDR:
+        ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
+        break;
     default:
         ret = pci_add_capability(pdev, cap_id, pos, size, errp);
         break;
-- 
2.34.1


