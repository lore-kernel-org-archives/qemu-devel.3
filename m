Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E941CF8855
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4du-0005is-PG; Thu, 20 Nov 2025 08:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4dt-0005ig-SE; Thu, 20 Nov 2025 08:24:09 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ds-0002D1-AQ; Thu, 20 Nov 2025 08:24:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSxJrSUTUayb38B7i6Kiti7VWB92GqCNgFpJoPX8MJJKZwPGPYfRiuGzNchjVywDeWeZooCUuw4b3i7oLiqOeVmecNafg9CPpNTTHEKYvKzTe2D8CflXpgxKfOhptp4FruOa7wVaRWnatlXNfa7HO06Qn5r+Au9F/dyjarm5Mutni6GWCBM1RdWMoKsq62+vr/qcofWTBR+9qSqo5xRt+NW/V4oYNlq3NRCC4el1lf82CJmY5l1VAexDTAjz4xIHlUpnu5h++PpdpYHWEV9jX3bUuXKHQY6JbH5f91ypuirdas/R6piZ2Wn0iC40DinVyvO1Yns/967tfbh58JJAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG03UdMUbSM+5ObpKiWgCDs7YhmvpVYTZ1UsN2Tyk08=;
 b=Ni6s+S7msLm6lDXJVkncFtAW2hh6iXmqhuh0vaTKxnUZfdtIIVP8yjPaV4uK6e5SUoisS3xdxkfyPgKXsJ+ThssCgRkx72MnhFqgzt55QduT+1oqbYTlg2wdHQr0q8ErPpJLXh02w3XJv6vwldx0FefRuMBQQ7k9y8etm+T7aIhvipMWoHM4FcyX1sU+K1JYPISvLn27yluCDxAL9i9w4X8DdRhHFpwow7PFjhoHSRwp7jOy+MhNsXYGpj/6o+RL11Q97MJdfTkY50yHwvmHC/tNN8ioJWr5lojcZeyxdu2hSNZ9N2bVGFLZJw1hqwnaKiY2nCmXSxk81aA3Njqtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG03UdMUbSM+5ObpKiWgCDs7YhmvpVYTZ1UsN2Tyk08=;
 b=OmkXL2cQUJKrwJPbuwfdcpcMPozDQLQAgh6DfCPJNxpdJLm5ugdEJzONC7injOEdrYHTMjbLNfzqvUCuRe26WHyvUIlcMMlladFClFWOn0bNc5rY1sW74qj6DIm9aTLyhmjv+eA6wlC0wKzPeaqTHwmivkQFRXO2YBpvbepl4v/pL1BzkK8Nfukmpd7QE0SMXF4+fsNCN0Huzjgsr8SyQfUoh9VRkZ5Y82kB7k+moodeCbXVtzjbx/DcGzbJa4/PCAHT6199xWRbimdF3sQEA/grVaa/nefxFWvjT8X/mlnWOYXG8qqlF7O/+veYddgRyTGJ26jHQI+ar70+vNe6Sg==
Received: from CH3P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::8)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:24:00 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::52) by CH3P220CA0015.outlook.office365.com
 (2603:10b6:610:1e8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:24:00 +0000
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
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:23:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:46 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:23:42 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 08/33] hw/pci/pci: Add optional supports_address_space()
 callback
Date: Thu, 20 Nov 2025 13:21:48 +0000
Message-ID: <20251120132213.56581-9-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 30267a79-52a0-4007-1a25-08de283810ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UOrQOYmm/s36Ij8rpIY1iv39jbrX72hDUhWc/WpG9bE4WkYehXk/yLp+Ycfv?=
 =?us-ascii?Q?h5Ibir3PWE2lvd2KAzR4hbzxFwHYIWi4ssy1zIvy76xudkwUuWXkL5GuH9Nn?=
 =?us-ascii?Q?m7Iw3v7UmHLoOPue5IEXPsyMjxcT+Qmf5xm40/K/LQIBaD7EpTGOfhSeiDO1?=
 =?us-ascii?Q?sYgHIuX+FqgbtAl3/VrOhIWm6PTTVx1qs866pQcPZvvBN1acTmXccVmrB79k?=
 =?us-ascii?Q?ugavaQcqYcTmNSh35xAUEn9qQPcgKd5HGTHSnWdgX5UAVGbOxWaCg4IEAltp?=
 =?us-ascii?Q?8n5FGuFa/aFx85G1VbCx4MoI4vfKdYHwYz1y7uQwoD3scGcLCPwg9CvBLuza?=
 =?us-ascii?Q?sn2NZb0uK5ULOFyeE53M9vX9DpiiIUxtZH2VIS1YiQSEW4sGJkeVEnkD2p2+?=
 =?us-ascii?Q?UNm9wzQWZ1wWcEODr2oAX+UQVMK1ala3kMZkoBR0ToEo4I9IFK+0sfBwHslm?=
 =?us-ascii?Q?Lbb1lnd42AQE0cSy/RydWnApWM/KNq6Jr2vX812MTOQcTGZQ0oJ9tcUoPwDC?=
 =?us-ascii?Q?YhxAFufGJ/RbMbhTisyYa+dS+A2yROmBFSgH6XJHStE7bjk0Dvo4PJUxvToF?=
 =?us-ascii?Q?6eMRy3xoSLj8jziMDo4l9p3BDMZhycspDOLGwll/ChpHeh2V0dW9LFdrICOm?=
 =?us-ascii?Q?DxNjK/HaZYcXVn4Mcoc287odrGFSt3Ih4dVUXpr12iAQppzA1/h0+ob6Pd7s?=
 =?us-ascii?Q?qB42JXexQg/EhciqUXEDdB0it0RdTXqLibBAehwQXoZ0tAHMoyxb7wBepKLL?=
 =?us-ascii?Q?M/eNEebRVkrwhGGrxOi+H61mubj7ZKrhQY/5uP78mLnBhhGVbkmqjyoUJCk3?=
 =?us-ascii?Q?Jk02jbS8lhNr32LWVP0DBBxiTeKyN2QNzbhVmqoWQXwnSbbNXFWL5YTSLGSu?=
 =?us-ascii?Q?ArcpNf/7Jf+5taa/47KxOIel1YclEgXp79ck9P+1S4/IRD+YPU5qdR3pRuHa?=
 =?us-ascii?Q?VFDXMA0XU8anSPhpfiOPY7zty6RXX3Kyo8YUqDRCRPe91uuF0iV/LZxEzeQE?=
 =?us-ascii?Q?o6ZTNF68af5m2YKAemZ8GWFGhAZIJBoKH4EUAe5tDMqQ01hsIKXCk5taF7K5?=
 =?us-ascii?Q?0s9q6ZNx/jFUr+vclcVYWEECAr2Zq0H5/rtD3oEgC0Xo/KRWl2Cl+nlLwRTk?=
 =?us-ascii?Q?ZfOV0nKGeSRGRiEtjMkObafPJ6ldex9nJLjbwpteLsPYCDWtA+3PkqEbe1DO?=
 =?us-ascii?Q?JG4Q0Gn6MOPw2elNgvd4AM+KpelCltXKGldwR/g/ZF05GYoTQYiaPS25MEci?=
 =?us-ascii?Q?/8DsIj9+2SdmlGlVHyXOqPkATU0yUrtCrIQza6oXS2Xay2Px2M7ZLyTuIU8o?=
 =?us-ascii?Q?LIIiuHtsCiMzH2RwQ8IMsGQ3GYfaiBjq9cSNHnxt5YOu4qWEUsdXF6mhPwT2?=
 =?us-ascii?Q?rYFRRLpVhB/NXYmjK62ZSggUNi0y9Wyv9KfDhAcijVXhMglzMxJiPDDbFfpG?=
 =?us-ascii?Q?0LoPt/4LzfzTRMH+e6O5h4PGGYXGkw6Ec1uuXm8HOuJQuoO+Yx6l1WPuP2iC?=
 =?us-ascii?Q?9srAuzoTpmoEcdTNqMAA1/zotoe3rEecgUu8xlnCx+covitCdXCu1rFOzg6M?=
 =?us-ascii?Q?uRDq4nl+hiS3qFIU0q4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:23:59.8874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30267a79-52a0-4007-1a25-08de283810ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 20 ++++++++++++++++++++
 include/hw/pci/pci.h | 17 +++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index af32ab4adb..55647a6928 100644
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
index a3ca54859c..dd1c4483a2 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -417,6 +417,23 @@ typedef struct IOMMUPRINotifier {
  * framework for a set of devices on a PCI bus.
  */
 typedef struct PCIIOMMUOps {
+    /**
+     * @supports_address_space: Optional pre-check to determine if a PCI
+     * device can have an IOMMU address space.
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number.
+     *
+     * @errp: pass an Error out only when return false
+     *
+     * Returns: true if the device can be associated with an IOMMU address
+     * space, false otherwise with errp set.
+     */
+    bool (*supports_address_space)(PCIBus *bus, void *opaque, int devfn,
+                                   Error **errp);
     /**
      * @get_address_space: get the address space for a set of devices
      * on a PCI bus.
-- 
2.43.0


