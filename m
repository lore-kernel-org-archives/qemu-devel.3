Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F1AD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1ax-0004YU-I5; Sun, 11 Jan 2026 14:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aP-0002vk-1d; Sun, 11 Jan 2026 14:58:56 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1aN-0004Dt-KT; Sun, 11 Jan 2026 14:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3kGyTabrQ1avQkPT/5re6CTRqkHmdoeGn+J1RmraLFk9MbDoJdQQYAR/5a6WB+dvxpE8HVFVJ3hUOHK45uW94hyq8Ru6WU69In5SfAeEp0Y5O+8XFFUmMY5Aw4dhgKZiZdEmh58LmOekGCRIPRSr03NazmGxanMtugyzT8nPdHdvMuDhwhewOGxTm5bTEgfc7RVcR2I3+sgKwny49ixe7v2WWzA0cN8vlt9sbJN3qEjfNi9+Jg3hdvnC9RYzYg5rVBAbOoQKTlyZN7RE7gQ0OOh93Hg6Dwy7lBhqBFWl3RaFB5Sq/G5X5ZryZR9h6zphSVeCw0Z+wmeSZIxdELWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwqmb7I0riwyoaOE/7FLxiIbpBtk7tjJMy9YY2W4Qr0=;
 b=HQsOo+x2NQOB39tCYIc/b1CugMTNEDxg1Dvda8Qfoq/dVILjt83AO4+kzSV/oCgVFvcovm1XYXvPlI1UyRx3sD/EZCCiWtaWB/Z5HRHj62xvW34Xx7VcAjRKkNBuCBmhSLPmtqAhHyXok/buYw3t3kt+GYCJzfH9YoIn/K8Em9a1yzNwk1hdJnm41hDDhyei7KmELyPVL4EqVfVxyBUQAvJNSNuV4V7hA/ioTjx5Mg1cI+K95CKRxJ2YBqAa3z1G9YmaQ6Bcs4JQxQL8Xvh2UnWLX95PfajIM9X0ev8NwUz7jmDaS7GLn8a5dA6lXC0dWTRtGiGkHplB2JpTXuhIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwqmb7I0riwyoaOE/7FLxiIbpBtk7tjJMy9YY2W4Qr0=;
 b=K7mZngSTBrFsdDTaS8FciLmgvozYq4yGNfoSGFXnL8/K/WIjrqtyYoZt2QZR96egvXg4qUXb0XrFTQen+AkjecQkK3Uh5OocTzAR5jhNsoAKi+rJ5FjRv8LDDzdcy8FCOtqX2rdibwTv/pmX4dz1T1Zk7QD2pPw/+DpWlOJCCFD6Ffot8M5AbNFmUQWHijwa3s362kIAJz1uxAMHuOBu5d9/7etavKlWtAYHmQRYVh3gMs3oPcCh+JOIYVqlTzDSbCNRrAOBH0e6tDnZLUHd56B2ioSbx7oGqpcF3xmh4MeOcpWCcJARG+G7XXeQvNkkpTXiFvlUvVawzJjWHihc/w==
Received: from PH0PR07CA0081.namprd07.prod.outlook.com (2603:10b6:510:f::26)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:58:45 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::ec) by PH0PR07CA0081.outlook.office365.com
 (2603:10b6:510:f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 19:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:58:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:36 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:58:31 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v7 32/36] backends/iommufd: Add get_pasid_info() callback
Date: Sun, 11 Jan 2026 19:53:18 +0000
Message-ID: <20260111195508.106943-33-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: b208e908-ff0f-4c43-8718-08de514bd3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TxqyCrHy8wnbn/o9g/JvjaybRhbNQGmqr+4k8VK0Z2ydK3bBtsAPKjDg1Rkp?=
 =?us-ascii?Q?d7q2RjbH9Xp8WUbyCwIEQMdrj8OHhzBb3eG18mAHL3l1T5D0Af410A8fH2VY?=
 =?us-ascii?Q?TjtQeI/6vMCsSbPtIcOj7JDzqykhn3xixVlvkv4Q3xvt8WINUxHouuBUjq+G?=
 =?us-ascii?Q?pm8j5WwI947jYFvcpOCUPPdvQCMFKbB2+9DUyd/xRaFgNPGIajwHxy/8ofS3?=
 =?us-ascii?Q?DCqdqcXO/uMJLTytmPyuXseQtOUt2XlvxXdPiOqMVCHesfLr3p06sO9cZM4n?=
 =?us-ascii?Q?DryL74xGmWweVpi1CLQAYok+8l2vZY3/k201pe1FqhgUtLONPRFduexL0LSW?=
 =?us-ascii?Q?qrzP2CJYN24NAS+w6kWIDI6j8X2Xab5ekaIu45Dsfm8YDQt/wnM4W1kazFzB?=
 =?us-ascii?Q?AXl1Ziw7342Cnz53SrAdsR7Gy8jqd3xUvi9poUQtYBr6ddDjLfyJ1QtmN9M3?=
 =?us-ascii?Q?dY1YPsDDPwdnEwcCTU5HQma+E8k3o3PF+VvXijOcJjkMKI6uSPR/yXFU6qhX?=
 =?us-ascii?Q?OlL2rEPLR6f7nMlJtROy2QOLGqZhinRe6dwtQMhBLUwR+y3E5lWbCUi/oYGi?=
 =?us-ascii?Q?5Al3wQRogdE9KP4UXutcDwAErltrz8zNVpi6KXKT0g6WiXbJ6Qa4Cro4LsAA?=
 =?us-ascii?Q?wAkIxMB4+LXeOI04aql2lHK7MgpDlH3R6eZu+4DYtWx0QwWXTFpPzqfp/ma2?=
 =?us-ascii?Q?8X0aUQm16H1BRAnaGtR+04iGF5BvsbwIY4lMLa63Xmm8nsIHMAa7yE3y5ABb?=
 =?us-ascii?Q?e2SYCHCYaZ8MI0lN/HpN/A0Luwy44eX/zmsK6qGQkSpbouwpXYgcmGHYFxSl?=
 =?us-ascii?Q?PpSL/wNt9POaITKi+AgG/pN6iCvSlZgPqTRBen+gxC5YAdYLqEYo5LuN26qy?=
 =?us-ascii?Q?yVvMoIrqBFSg8mDNma3hk0EdqhxmvJxbCdKpK25nt4uT0AkBOFjd0/JtCm2R?=
 =?us-ascii?Q?0T1iteaXF9gUtJrGQPEIo739LJ2wvWnaY1M6JJN3IpyEmAgSbEWcq9MiyAwo?=
 =?us-ascii?Q?2bZINEAUOM3nnZFKzFztVy7CXZuWPMkW3hQY1p0yZ8zJkkXg58u2KBjyHxMk?=
 =?us-ascii?Q?3hAIc5SArGjDvei0dF+jS9lF0BKxq34EoPKFQkqeNLRKoRRmOb+zsKZTUjW4?=
 =?us-ascii?Q?SdtSRO9nghZQN6JQxkNIqm6jGg9YmClzJ9YZa4vnmDjkIXC0lPbth4V/ILYQ?=
 =?us-ascii?Q?iQB/kgvltH2ceRqpEicv3l3DB+N0k05XjhYPptHfA7bmzvQv3AmmYQZ40EOW?=
 =?us-ascii?Q?IoXwXwEeiuJZG5zGZ6kEDalFnoRkGWKW5v8oqvz+lkYrq60PVFgab1lnIdAK?=
 =?us-ascii?Q?xssYCnzduUtSN1cHuhcIW+n7PYGkQxn1YYh3AQw9ICxPNeH/bKifqpWnfK4f?=
 =?us-ascii?Q?65LqlJHMPwtq4C+l1/z2UDIXKOlTFIDVd2eB8uDgI74CZwkmaoCR9bRYQ+NA?=
 =?us-ascii?Q?Fbw8z2hF/889W6Na0oibbF7WWfG7RPyPQEe/BeAhoFUx8/sSPAT5cntOiwR7?=
 =?us-ascii?Q?hcZaW0RTMUQyFg8RJYxgFO9RXO4oR+Qpxy4dXgh3WK7ldo9XSVqjv7SM9/cA?=
 =?us-ascii?Q?RH0Ej8Rdzslp5BdTX5k=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:58:45.2717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b208e908-ff0f-4c43-8718-08de514bd3fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The get_pasid_info callback retrieves PASID capability information
when the HostIOMMUDevice backend supports it. Currently, only the
Linux IOMMUFD backend provides this information.

This will be used by a subsequent patch to synthesize a PASID
capability for vfio-pci devices behind a vIOMMU that supports PASID.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 backends/iommufd.c                 | 17 +++++++++++++++++
 include/system/host_iommu_device.h | 15 +++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 6381f9664b..f1707eadc6 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -538,11 +538,28 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
+                                        PasidInfo *pasid_info)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    if (!caps->max_pasid_log2) {
+        return false;
+    }
+
+    g_assert(pasid_info);
+    pasid_info->exec_perm = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
+    pasid_info->priv_mod = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
+    pasid_info->max_pasid_log2 = caps->max_pasid_log2;
+    return true;
+}
+
 static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->get_cap = hiod_iommufd_get_cap;
+    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
 };
 
 static const TypeInfo types[] = {
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index bfb2b60478..4fbada638f 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -59,6 +59,12 @@ struct HostIOMMUDevice {
 #endif
 };
 
+typedef struct PasidInfo {
+    bool exec_perm;
+    bool priv_mod;
+    uint8_t max_pasid_log2;
+} PasidInfo;
+
 /**
  * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
  *
@@ -116,6 +122,15 @@ struct HostIOMMUDeviceClass {
      * @hiod: handle to the host IOMMU device
      */
     uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
+    /**
+     * @get_pasid_info: Return the PASID information associated with the Host
+     * IOMMU device.
+     *
+     * @pasid_info: If success, returns the PASID related information.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
 };
 
 /*
-- 
2.43.0


