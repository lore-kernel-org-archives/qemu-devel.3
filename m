Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1FFD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 19:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf1YD-0006iK-9j; Sun, 11 Jan 2026 14:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1YB-0006hB-NL; Sun, 11 Jan 2026 14:56:35 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vf1YA-0003sZ-2v; Sun, 11 Jan 2026 14:56:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meS1rYey2KbTjXdBKJ8NOc0+6bxDV/c0dSFEZFO1phT8f5QdtoDqD5UEHtYzHzwddYtaKFySeeEvmKDuzOFYXWg+e4+8xDy5E3VifVhvmcIWrhxyLP/ZyH7/LH+Ms6nNIU3sjUf8YI47zoDVI+LDzHOy/jCSo0afu3+6YwzpKSE9Ee7eTuFMSXInUvHOXDlDNyRnMKh/0cSaeE+DFAfgwyiOikcogBb8v+cb88Jjp+n+NYakRj4IWOezRh/jJgpy1C8FItMycgDaPWcFtIl1aFRxhhjlw/zxw/MzoCxEdMWryC3zMdexKi0zJT8LF/y8mlro2AGa02R+B13nqEsb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWRWiBiscOcx30MRfbB+oHfSjqk1NlyTp4sZm1/Tk8o=;
 b=E7zBbFMJ8YbcQ24XqKm6s06Yikj5lQozpqtnI/ipjZGTSIIvnaTAzVkltYpoXRDbWCprlLScMcmfI4IFJMLgGN8enHcxkP+CFN/bJiEpv0vtHOU9JYHpBWoAc/QsbIBFK2RZlcnW9S9lB1aTSt9dUonUS6n5lMIuU7vF4T33YqonWx0minZZnBT45KvavFlrY546RUCMGBrM62kKFFUw9NgxCe19sceLb4lmsBIZW+UX6dL/uJZVGqKsWxS133zWeA8QOzJxDp55Kcmj0ilNcQz+5MI6RX6m5Sl+1c5EmmTTYyDAfUrPfMoFsF3sJnSZoq3+tW1xgjOUSiAsy2izPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWRWiBiscOcx30MRfbB+oHfSjqk1NlyTp4sZm1/Tk8o=;
 b=q3UQA4R82EBac5E5iOTlZi47YH+tzhX5HIUytJHfxvXZ20/K7I11XokehCj/ME1HEtA/tOLKnRdJi9bQFg1w+usf70hsyK9TFDzq967J2NBZ9Y26zQAOqG8Q0+F2qUDITrxRUKeZC+AIMok2ZrogHzGfYGGOuMFjnZ3Ip/mYaqT9lJYwrQ9B08KIsYi8jdmQXCLaB0CrLpV6XsAGJptA4X0EOM/9dE5LP7oUqqaW9V6/F1YgT7DOZI1rgclj1KUzUPRBlVP477FwfQ0VE7r6IvOpLdpcTe5zv2bjXLMW+Fa7ZzZxXtz7hlYOn+s6YxHrRrEonf3FHCs/+ejN+4pBDQ==
Received: from SA0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:806:130::32)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 19:56:26 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::25) by SA0PR13CA0027.outlook.office365.com
 (2603:10b6:806:130::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.2 via Frontend Transport; Sun,
 11 Jan 2026 19:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 19:56:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 11:56:15 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 07/36] hw/pci/pci: Add optional supports_address_space()
 callback
Date: Sun, 11 Jan 2026 19:52:53 +0000
Message-ID: <20260111195508.106943-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 340d758a-1396-4a21-505f-08de514b8122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7jtTCVJorQ8d0ACEpda3X/iAgZdPiUmSxeZJlvoYsFLRra/j72nj0AtPLy3T?=
 =?us-ascii?Q?pKbi+v3xVP4FUOScadkpcHY+srukZfJuF+eRdhomSLCfkCUgfVon4bGhgWnl?=
 =?us-ascii?Q?tjbDOmuXQIXRMz5o4UzGAixGv7xXtz0DUKtR6LiHolPqWIGLSXvKle3MYRog?=
 =?us-ascii?Q?vWw4D48Dv+/IYsiaPkx3GkQs74diTYDlsUViEHR31p/tRZmnZIiG2G4aJC1m?=
 =?us-ascii?Q?by5RWf2pxV5TW34QpiLzgp+PHih02685/MERtKXJxURRnTUDQj6RJ3KpG1wa?=
 =?us-ascii?Q?xIIJTLjB21UTj8ikiLbvsTjtXSKKeO+b9SI9/GJy7XPEye45WUEmRvINAMl5?=
 =?us-ascii?Q?fWNKcX4bLadIyF23jFh6MO2SQEQGAEF3Yioe+lk9Ui0DKypzGm803Vn1HP1X?=
 =?us-ascii?Q?sB8221RqqLcszzvXfMzTzIOCycEznazOzy2l9f9BEYba1suUGE3qFvlF2pDt?=
 =?us-ascii?Q?H5tBByWnx+Qb7+mnNlJfhJA5VTki9PPO1bHH9EvzuEHj/3aNrDjYt7PvKzWr?=
 =?us-ascii?Q?+/ssdpawz7wum0jfGJL+4DnC9kfTo/MG/SS3bRkamnc30C2oNJjCJSCL/j+F?=
 =?us-ascii?Q?S9grQTEaHY2GIfG59E89f2r3gIXR0AbcQG7bPuYrx6Ps+TavTMzGxg7ZdJXq?=
 =?us-ascii?Q?Wt0njZxOxpxoqK6DHyt42KB6EMxfc8VurUYu+arW8N2fcWCgXNyMZqsC8eum?=
 =?us-ascii?Q?jLeUhMRHb9iN0ZKiRPI0Jaa/zEVy/T/4h6gWYwI2KNxG3PtxsyYzW7EvnDvf?=
 =?us-ascii?Q?8QiJVwIcnHTjEFi/bF+YLEeReuFn1wh4J1Vbzw1twNVWGbgtCYpLtFOBZOdH?=
 =?us-ascii?Q?piFQ3M0CkuWdWWsGgdF9E2YMoo2sfQ4i7qQnXptR17MOSF61K9+T8ChbS1ox?=
 =?us-ascii?Q?3KucKEpLMtnc1qIOHAKXGI9Nx+WChmOm4uBz8kCt6v0IkLMPpJK8MBEwQwVG?=
 =?us-ascii?Q?ku5avjoAhbdYCEaYvzm7eQAtai3MaX50oH/hANkBl9XkZ/IhcpR0lcncnMTX?=
 =?us-ascii?Q?ZgrejsFygRq+rQ8DMiDykNlhGmO7meKS8grxIxsVaZ8xEcDkkgYOhMeNWOTR?=
 =?us-ascii?Q?PeuXRSVE0uP4iZI/mVwbLAhOhZ0rknkYSX6zcRHuHBF3+E+N5uQv7LGAFGJ1?=
 =?us-ascii?Q?pm48OutbYEodcnsK62/rXgs0K+DX9bAwBqP4J/FT25XcVKTZd17wgxGoapKA?=
 =?us-ascii?Q?24/2VmGRpUaX+ZL1Pwj7rbe5zIoZHLRuWfobBXPAqM9aB8qdO6Bz40YS+caU?=
 =?us-ascii?Q?iX1876n6sJMmY9NEbotUlG5XrzfxBNPH0QGoRhQgvAn8UtMFbcmhAMFTVij+?=
 =?us-ascii?Q?ADjp8qLCxJj6bfbMcqCxEflVrE9JOepEsJpF986wwwar1CCcc5UM9tzq46de?=
 =?us-ascii?Q?WvikltG7mNA2hDNcHSrtW6cVY7Hs4lfHF3H4nGOUCxmjuv8LkruBHR6JsciS?=
 =?us-ascii?Q?jn2isnXxKI1xq4T2r1yv5FtNK7JatQHaWEf7a7ltAQwKRmubCy1GImkJWzZD?=
 =?us-ascii?Q?84BEmvuyW6/14Sfig7zuU99D5wwWJntDMcqWlcq7z+NEoRL8YdzrSn8OTBBv?=
 =?us-ascii?Q?tyLL0GYKodvh9GZ3P/o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 19:56:26.2673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340d758a-1396-4a21-505f-08de514b8122
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

Introduce an optional supports_address_space() callback in PCIIOMMUOps to
allow a vIOMMU implementation to reject devices that should not be attached
to it.

Currently, get_address_space() is the first and mandatory callback into the
vIOMMU layer, which always returns an address space. For certain setups, such
as hardware accelerated vIOMMUs (e.g. ARM SMMUv3 with accel=on), attaching
emulated endpoint devices is undesirable as it may impact the behavior or
performance of VFIO passthrough devices, for example, by triggering
unnecessary invalidations on the host IOMMU.

The new callback allows a vIOMMU to check and reject unsupported devices
early during PCI device registration.

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 20 ++++++++++++++++++++
 include/hw/pci/pci.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a852694cc9..95b29a690e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -135,6 +135,21 @@ static void pci_set_master(PCIDevice *d, bool enable)
     d->is_master = enable; /* cache the status */
 }
 
+static bool
+pci_device_supports_iommu_address_space(PCIDevice *dev, Error **errp)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->supports_address_space) {
+        return iommu_bus->iommu_ops->supports_address_space(bus,
+                                iommu_bus->iommu_opaque, devfn, errp);
+    }
+    return true;
+}
+
 static void pci_init_bus_master(PCIDevice *pci_dev)
 {
     AddressSpace *dma_as = pci_device_iommu_address_space(pci_dev);
@@ -1424,6 +1439,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pci_dev->config_write = config_write;
     bus->devices[devfn] = pci_dev;
     pci_dev->version_id = 2; /* Current pci device vmstate version */
+    if (!pci_device_supports_iommu_address_space(pci_dev, errp)) {
+        do_pci_unregister_device(pci_dev);
+        bus->devices[devfn] = NULL;
+        return NULL;
+    }
     if (phase_check(PHASE_MACHINE_READY)) {
         pci_init_bus_master(pci_dev);
     }
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 868817cc05..efe9547185 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -417,6 +417,25 @@ typedef struct IOMMUPRINotifier {
  * framework for a set of devices on a PCI bus.
  */
 typedef struct PCIIOMMUOps {
+    /**
+     * @supports_address_space: Optional pre-check to determine whether a PCI
+     * device can be associated with an IOMMU. If this callback returns true,
+     * the IOMMU accepts the device association and get_address_space() can be
+     * called to obtain the address_space to be used.
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number.
+     *
+     * @errp: pass an Error out only when return false
+     *
+     * Returns: true if the device can be associated with an IOMMU, false
+     * otherwise with errp set.
+     */
+    bool (*supports_address_space)(PCIBus *bus, void *opaque, int devfn,
+                                   Error **errp);
     /**
      * @get_address_space: get the address space for a set of devices
      * on a PCI bus.
-- 
2.43.0


