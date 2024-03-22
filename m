Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B586C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 06:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnYh5-0003oW-G5; Fri, 22 Mar 2024 02:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rnYh2-0003oH-DH
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 02:47:57 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com
 ([40.107.237.68] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rnYgx-00013S-9d
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 02:47:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLMGoXvbme2xrZQMR8SqZW4mWTzFcdh/wxMtb5SKSIzED00mArQwd+XYJGTDqap6unEOFrx0fj+Jy8RykhGbNMy0sv8VPrzq8gwLjAAN3LRp9vDt1mc7iznWz8ZYrOrG4yHihtXMiUpLy6LGxt4kMBlKAdyylXhUhcbWydgJK4F4dwNRrle/eUONc2sjpq6/jG3mqA1QOYLY5c6JWCKjoHADkl5MZj3CeuyuJVO0LL6UtfAPjdyK4LDOlf6RRbZVZDAjVRlfZeG+wmOXzJokf/5092tA2qM7MKFrY/JmV7mfktaSOV2duyvUbFSyEJC2kdv/kxwgT/VkqxsNgDubUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbbxXrcwvRYtjYm83Z3muw0qSHQbsXQVykRIti2Lau0=;
 b=B6kX0L9B4y0f61KUmTt8w63ppQkFhIdMQ59cPyoIcH7xVHOKob/vqL7fSmcUb8svyFxmxRQyIFLAECoHc2Lf6pPWioUTUKNnBgKHCmd6gzwY1nWjuUtuz3bfRl+cDfVcvO+NjvqfBTzmm4RCRTLeswbp77JQsYgIGdoBi1cit369sP/TAQ87/7k3X21u5P4+MBrhC/V7QhhKrN0z2XHIjClGLe8+JIWPV0bIaWQYKFLSi49UA37GPERT8MMgEmZ4DFW/YkldCzN5loa80OMr0mSl0zh13j6aQrSrXE4o8y1ZIjg4+ID9PCQ70WmM9IwhWr9nTIrz8Ejn3rSfuZXMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbbxXrcwvRYtjYm83Z3muw0qSHQbsXQVykRIti2Lau0=;
 b=HsAXL0Aa2R1xMBDY1zfOYDySpXENg5iojwDaY3A+VqvWyyhipINIYwWfQeHpLYcWObTGhZLBp5Pz+dTx0kWH7GOwhOsiOtxTPSSnBkr7g1abyAGegtl/exHR1VIKd/FEAZqncPzl3nc9gz8CBM5No1AYOVaOWKSPYu1sQRG7ho+gp4qIuuzUtlgQpT9iyfsppCKQ1LOlryqzI+LTTmjRwe4f0uFvwcW4azierQsXoDBbJ1S0yMeoe5VF3j4bYqcR80JjGCibZ62FVHr7vBBdWKEMAdmIQsgT9aXY/7hC+NiOTmW3rnqn3YfIjPDaxnwLNOeXlqa8DmiCcr6OARJRzQ==
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Fri, 22 Mar
 2024 06:42:44 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::99) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 06:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 06:42:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Mar
 2024 23:42:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 21 Mar 2024 23:42:33 -0700
Received: from vkale-dev-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Thu, 21 Mar 2024 23:42:30 -0700
From: Vinayak Kale <vkale@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <avihaih@nvidia.com>, <acurrid@nvidia.com>,
 <cjia@nvidia.com>, <zhiw@nvidia.com>, <targupta@nvidia.com>,
 <kvm@vger.kernel.org>, Vinayak Kale <vkale@nvidia.com>
Subject: [PATCH v3] vfio/pci: migration: Skip config space check for Vendor
 Specific Information in VSC during restore/load
Date: Fri, 22 Mar 2024 12:12:10 +0530
Message-ID: <20240322064210.1520394-1-vkale@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 21273839-0d7d-42f0-43f7-08dc4a3b46fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePcYB+IfMUqbPjnGOa8R/WF2Vul0nIOPbEZ8dU2D5kbImBFxeBbr8KPGLKBhjKB/WNuIE8bbLMciCZjUhrdEfgoRvr/OyE5UM6O9xY9CNXGMxxWD5zPCGgsCLyQoXX+XI0jygwvCgdUlAiPVc9HjGAaEXP6B+X2eco16ZkXQdg2BNEhzIriSlG/qdUvZwiyhoLhOCIRal7y+KGUZ71vD9XR9wrclEFOA6IHeiadC223ovt/dtj9apjYsR+4H5SMRn7cZsfZVKGS0zaIpbbM+x2iF1luj3SrYJz7CaDBmbxaTOwFrM9ZYDoMGmUe573gGBYC/btaLBHvvvrYa1QzpiseBKNFNKQiy1okUrdYZCjQWWfLSYxrp3Z4cR7tk1gKC+bDe+R+bb98hEtvG/iQV+Bt0d7sdYgNwBPm3ipEXOBPbYT1LHYJ2kqfUMN1G9jKH6JKKM5S7w6BgLhRadE+k2Qs+On16T4yh2ysf9fgPJDlZsuG9ccmJy3nNQCwEW8uZCAQrq4O8+mGqS8vo3g4QQyAnQgPYGuOM0FUS1p3MX9fpFC/McYLRLwCOa/v47p6nlRiZO4n3Req3/LSeP5Ri9PrPFC2xCBKaxPPDL1Hlv2oxNpCOWijGG+JCaikRyMI/c8l/jhTR1ytXGvTu5jxaW0ylu/AbYZDbF/qOyArEMHwr+J1IGhE15S/Kx3LvAeFfuwtHEVeO08EKplY9j/0AZfyNmhYETUS2NzxFA+26wYH9+B9evskLzv0AwdgWrDVO
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:42:43.3918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21273839-0d7d-42f0-43f7-08dc4a3b46fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
Received-SPF: softfail client-ip=40.107.237.68; envelope-from=vkale@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Due to qemu's config space check for VSC, live migration is broken across NVIDIA
vGPU devices in situation where source and destination host driver is different.
In this situation, Vendor Specific Information in VSC varies on the destination
to ensure vGPU feature capabilities exposed to the guest driver are compatible
with destination host.

If a vfio-pci device is migration capable and vfio-pci vendor driver is OK with
volatile Vendor Specific Info in VSC then qemu should exempt config space check
for Vendor Specific Info. It is vendor driver's responsibility to ensure that
VSC is consistent across migration. Here consistency could mean that VSC format
should be same on source and destination, however actual Vendor Specific Info
may not be byte-to-byte identical.

This patch skips the check for Vendor Specific Information in VSC for VFIO-PCI
device by clearing pdev->cmask[] offsets. Config space check is still enforced
for 3 byte VSC header. If cmask[] is not set for an offset, then qemu skips
config space check for that offset.

Signed-off-by: Vinayak Kale <vkale@nvidia.com>
---
Version History
v2->v3:
    - Config space check skipped only for Vendor Specific Info in VSC, check is
      still enforced for 3 byte VSC header.
    - Updated commit description with live migration failure scenario.
v1->v2:
    - Limited scope of change to vfio-pci devices instead of all pci devices.

 hw/vfio/pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7fe06715c..1026cdba18 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2132,6 +2132,27 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
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
+    /*
+     * Exempt config space check for Vendor Specific Information during restore/load.
+     * Config space check is still enforced for 3 byte VSC header.
+     */
+    if (size > 3) {
+        memset(pdev->cmask + pos + 3, 0, size - 3);
+    }
+
+    return pos;
+}
+
 static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -2199,6 +2220,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
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


