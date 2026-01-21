Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9A6C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicRL-0000QG-7O; Wed, 21 Jan 2026 12:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRF-0008UW-8Q; Wed, 21 Jan 2026 12:56:17 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicRB-00016U-E2; Wed, 21 Jan 2026 12:56:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNbCWfsT8QUyjil6NHXFsxywF7VgE09PHSmlsi6iCX43FxnC+VXDqfNlHCIqIIT5Jg+hU4FCgN9k6Lvnz9JdIdYJqn2A7bOjBjN8TEoXf6KAkZvfWSkgknNhcrW1eBruRsGpGmcU3EcIPzKqIshpokvneJplzBsp3NAtA+QoLYc1wizfdaMhtAg7zKh6iHeWKQNyEC39r3+WRl/eyAbc6YgyCzlZM6xL6YwZhLFDD4ME01LEYH1G0xAQPaJFta3AbYfQL5P94lT1G/hxL6GWDoGWyepG7Qf1IGCTbgZgln0PqOVjsc7NZgruW0D0kvfJzxX6bzjIDZEeN4dH/n0g0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfL78QxawWk1kmmyGUPbMSftSkIGNd2UokE738ZQNM0=;
 b=IYD1GoVkt9M5YICwlTUocB3A+E6yCPiNAXjmYUYkSalXpBhZEsrd9yO+v5poQA/wIP65u1I6bjNh/5vQlILM2ghMlgLNJd4iSteRvXviaTGm7yJWPI/IpViHrrHCseC+EBKk88YRAX36TTkJ+CfRqxdyatglzJBHW1NqCBed0Tq1R1WJAo+vyOGjd4eNHYSM35HiNvGXwRLhuQv50rAkEAdE8IRFslGQqer+Bv2x0jWavHFPb7Jn0EJZagZdjQSmhN0dLQdgJJVObCk2REtwdKR41VCU4y0Q/KLtW5HTySoIkCsq8NQoCWX4nabnYrEmzpwBfnTL2GtGKQo32YPRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfL78QxawWk1kmmyGUPbMSftSkIGNd2UokE738ZQNM0=;
 b=XJJubi2SNn7DUHwPKIZdC1g0CknifFq3JqGQkyDT6AJAFedDkbzuqNMJYNH0GqIZMW9Cv1lG6bWlxjNQv69PiUlQhCLxHq6KYWOWvyI0Ht+aUvEno+KqTdCbGBfNeTgLROyKkov5E0S5+zhnttiAVlSUB61tmP4Tc9d8yw3PcG1tN0Lj3H1jDQC2eO8or63eQdch7ksSwVX82IEBdfCRUN6lepm4qp8zX895Qt6KpivaXcyE+8dCg0zGF79igEPBzmvubD/+5Z+VW5DgM+O+DlqT4zYP9FZvg+HCHxEn3EL898fXubYSsFDeRtvwDtJejUSUOaRI+afpeBtQZjAZpQ==
Received: from MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::12)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 17:56:03 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::30) by MN0P220CA0022.outlook.office365.com
 (2603:10b6:208:52e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:37 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:31 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
Subject: [PATCH v8 08/37] hw/pci/pci: Add optional supports_address_space()
 callback
Date: Wed, 21 Jan 2026 17:52:13 +0000
Message-ID: <20260121175248.87649-9-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc25658-e056-461b-5536-08de591657ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?we39wEEL2fPy/fc34AJq524ifXZlmeUAhVLgjr0COCWgxKWvkvT8bbPavTmn?=
 =?us-ascii?Q?q11SfeXFtJSKEdmc3+ZLHm+ZvtYdxGTs9YxlJIP7P2T9LdPP0M/0AXrRjpVe?=
 =?us-ascii?Q?kU1sXwlxuhdtRecG/C/j2RjXbPno6XcrN9T/H4Aya4JSpDzZEXtbwtrLvvXd?=
 =?us-ascii?Q?0qq7X/nFjdN9A0lfa+YmLSlEP20AC4Z8FB3D5CqpDL5rVaKP4RP6I/cXnfNF?=
 =?us-ascii?Q?ACvL2vxiLrRNWxV+vgBdkpYEg5kiHDzYMVpDOqNrdfZ9WBmOPpLGBckMLWUZ?=
 =?us-ascii?Q?nE6HtP9Z2h8Mmq7AvSbDP0ZOi3GH85dJ6a2sRe6O/Zc3KLPT6GdS/SMDK/pt?=
 =?us-ascii?Q?LDihYytxguKp2g95kpB+opKrUjvqrWgJSxoujeGH8qWsa53+HE25ZGVNdSDD?=
 =?us-ascii?Q?E0BmiTwElEugNww4HO519d6AS2hA+UZ7gpNHvHfZsNuf/VrnoGv0jJRDeXJ9?=
 =?us-ascii?Q?V5GBAvMqwWXMeKIUrl4xl5sCVpSDtBXgFoTvbwfWMUqwIEfkhDGakExO8SS2?=
 =?us-ascii?Q?MMEQyu3ea8xxo3z2Mf97UJVOrq5TfTyb1ML9n83Bt1hJ+MywI8l5G9leuxot?=
 =?us-ascii?Q?oBgA5cIH8QlfC0FKHVVaIw8T3+R3XgWtQYjy62mszD44F0y4yahYnXO4lodY?=
 =?us-ascii?Q?/FoA/HLHJBMMcoxkBxmVTji9A7R2wUOXtWB6SLxKw88utP0dto/DdPuoQfKJ?=
 =?us-ascii?Q?jxgJ6fnt7MQtyf0pzbY4xTw0StgK+YuvtRdtcD0PTYuNeTqJy4RipieMQd/J?=
 =?us-ascii?Q?kF670liYXw8OGRBnN7fG2+iICZa7N53kGzBm/2PbOjBEncS2h2y0WMzLxy2U?=
 =?us-ascii?Q?SBKE2Kn3LbKSpwzSOxze2EQfQANgMdEhhAvPSRF3vg0Q3KwYkTx97DzTDfTv?=
 =?us-ascii?Q?+IaWk1+N6LJv0dDj9+oQe298frf0+LH0+aCpSQPA5f6cW0oad59jMDtGg1+2?=
 =?us-ascii?Q?MqSh1zRExToG0WNKXmLnzXdcdXX0nlpuKtCmTA6fu24wJfuXgK1y5cqKHRFV?=
 =?us-ascii?Q?QmmInlJ/2aYKS75u2LyBsKgpgnBJH4ONA+KOb/02CccU6/rDy5NYErAOEx5A?=
 =?us-ascii?Q?PA8GydYzBI4vU2iBGQc/KodlGfG104YgLV+SRJt3QdCPWQe+SaZlLsEDO4IZ?=
 =?us-ascii?Q?fS5Ld1oTMlSutNf7E4v1HKyKhs2p13debecsYcSpnPTPy6kI76BlmmVHYk9b?=
 =?us-ascii?Q?JI3QR+aeNmj+8tzoAVC9DYKcCJdPXvn8CMrsNRO3VimEho3S9qs6jXRlPQRj?=
 =?us-ascii?Q?E9VpYWtgPs8qjCkyeWQMA3YUY18+9Coo9BjdGOQQQ7NUtUOL4//ePe/bC01U?=
 =?us-ascii?Q?nlqMj00WGSb6nC8RHtIkbVDPfeJe3M55/nqJPQKfXjqmmZc21UoLiB/uPeSw?=
 =?us-ascii?Q?vXWbtMZq5oomUQExhr4EdiE82/7nOVARk8ZptjEB/Zs1TpAOGJ9FxK5n9Ccs?=
 =?us-ascii?Q?8htHG2wqFVGWAXpv0WSCgt9ZE9/i728KULA5U7AC5JOI8JoxVqK6mJbTv1g+?=
 =?us-ascii?Q?VoM3UyQA+xOEuLM5iUDUj9GwVvfZWZjt1b+23j3zQ+lXmyeLmSBN9wjCrg6d?=
 =?us-ascii?Q?1fp1w1t6jvc+wudfoSPSzTSs83mxTqhSsLmz91B1JLzyrTkwMC141sVeHWOy?=
 =?us-ascii?Q?sqDdjVbpqQOio+XOFll+nGFypnrUlr3sfJ5MFBEBZ48VYIP+PME4KgchdxQn?=
 =?us-ascii?Q?o9EOQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:03.0666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc25658-e056-461b-5536-08de591657ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 20 ++++++++++++++++++++
 include/hw/pci/pci.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 229ea7cfb1..101e745bd5 100644
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
index 6fd8984c99..ddb0c98e9f 100644
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


