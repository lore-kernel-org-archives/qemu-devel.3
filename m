Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1CACF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK74-0007qo-21; Mon, 26 Jan 2026 05:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK60-0007Fh-PY; Mon, 26 Jan 2026 05:45:31 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5z-0005Xp-7n; Mon, 26 Jan 2026 05:45:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwop5/tiSDAVgR+1/LHWuWQyyWFrTrvYrya5RJ6b5w1IK1MjaXl1KwDehfVjraigzr8EMyAVxkrYsRqclD0/5C+u5LghIDBiquu79ZfX8Ee0LQSMQO6HrMcobkl6MTtgNEVOW8pJpK4cgh2mBNqH2Cnwoepve7UyEqoHalOkJ7R1KS9MF7JIm72YEvL3cqC6jYYdyQIc2GpQ7KrPkEhL2B2AJsd3KT/Rv+ZRjCoEZIAEmYio5KpcR885ICVuK5l+4Aw5MPPb8VGzUyJlgcjMOVxcABks3FbFtpfRV0ooHTEbGqL5puR+VoTrym6dCJt2+jEFZhSOjT+QxESe2LIXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfL78QxawWk1kmmyGUPbMSftSkIGNd2UokE738ZQNM0=;
 b=g369MvMSYbdoj5a2fs1l5iz1H7nA+0qY1HDTQuxLX4JhLFkm7uh128JuNGXkjh2apzjx+hDp8yCdf/m2ngHsI7CMj7KcuxfBqc1XxsOJaWsHjeDoZ0tZ8w0wfSXzaCLK4n9T0UPUg0VGXS6xAHqN755ZZvzLBgPusH1ehJ492zC/DGmRKR50hqdYPO3G6VDnWU15UHRQIEIxUO0BxmKmLJpyMNLLW/9hNPJfdl+pB5iCfOfjGgEz6gYe4JpqpRJHWXEtthNAZaHHNjdvbtQDlfJ28ide6K9hO4P7ym5EMqKzl9biy0NTy71Ncj/ts2j/4EnJk3OfMUP0vBs4ToOfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfL78QxawWk1kmmyGUPbMSftSkIGNd2UokE738ZQNM0=;
 b=WvfyvHLNaRrTA5LgwQmRmkdazd7pI3ZCENIcpK+zZA3fOx3Qcspe9HBjxrbhujSE42AGYR3lXoKesEJ1ZUIEpy5CvOtKUohhVPGeJj+Soc4See1E56ytgsBmO5s6B8CRCVuzxk+UDmSb6lvB+6K/Ze9E2EPXKIabHRwqi2Kjh2ZTMHxU8fpLKLNqOQUqWDpYZlumrtOOPSXZ+iw9LcZ0apfJO0DwOUQn4FdBbBkD35YP3vpvRS+/XHnLkmmWwOqkRGPXFi035pn3/x3A4eVci8I8M/XsbQoei5k68bn3S9n01T0KluWU9VoUY9kW8GSuv4HqrOVQZo2FwC7xWGsFWA==
Received: from BL1PR13CA0222.namprd13.prod.outlook.com (2603:10b6:208:2bf::17)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 10:45:17 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::9) by BL1PR13CA0222.outlook.office365.com
 (2603:10b6:208:2bf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 10:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:45:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:05 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:01 -0800
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
Subject: [PATCH v9 08/37] hw/pci/pci: Add optional supports_address_space()
 callback
Date: Mon, 26 Jan 2026 10:43:05 +0000
Message-ID: <20260126104342.253965-9-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0f5ff6-431b-452a-5f19-08de5cc7fe79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CSfYdmFi9ImFE5TTuT0H0AhSbFMkdDowRUHphuB2u8iE/fDIFFNclTvlrZPt?=
 =?us-ascii?Q?lmCspY/oD6mGTauB4+pCtJb8Z8qhClmbH3IB4R42AbPDwkCgdp05Ds7Ds+Mo?=
 =?us-ascii?Q?WXkPyJi3zlI5+IomZy1f1XxUl05/xCCHEmu613cwrONEd8dfUc5XTkXe+M1x?=
 =?us-ascii?Q?ZUc6J1ZtbthGsObtcbtAeaJSlyRw2hjtNb1eUiPluDUZ90OabjUZoZRZI3BP?=
 =?us-ascii?Q?cpgHidwU25PXJqSLDN7iaJjt27/3p1vBkP9v4Pf9G3wS9Dl79q8yCYecHEzt?=
 =?us-ascii?Q?LRLWJKOXigJkwu+2haFhP4qT6oZQ/AtEvSdPOJuKmaxAJprQcwBXBaR0ce/1?=
 =?us-ascii?Q?MmdLbWui3kZUdIYZAHE1l9kea91K4u4RiHyOwpfRpRLi/azwrLPG0keu8MO+?=
 =?us-ascii?Q?6ahrLbhgVDqwHsHpazdf+NcZxWe6pLf52ENvMSsrfc3EUTYxhzQV0eDuOgrU?=
 =?us-ascii?Q?8GD7cpQTslQqCMIWhCRDMVErgE7x+2pIyl/hInEZNtaCux8BQ0WOFV0tKmhz?=
 =?us-ascii?Q?bNCShJZYgs+wc+B2+BkPcVvh5UFbLuRi63qRQVLlGox/dh7yHZoIf/IcTtyr?=
 =?us-ascii?Q?NfRzIjuN660DqzAdHYEQ6Hee/4K9LnOUwHWzoDSS2m8NHbvfFcEu5Sa+YDA2?=
 =?us-ascii?Q?hm44fW7JEnzf8aKiZYZUXfYbCoUCxbMHhTIpg+xOax0Si1/T8rnzU+CvEPwX?=
 =?us-ascii?Q?fxkjKd5ZQcbGwIL0uR5yAlwUImLuxjz9RgeT86RvDVe1ecktx7+DVemQLm+i?=
 =?us-ascii?Q?LVtMrQmR8CDGdl8aehrSKYTnzR0/x3PnDCBfCNFWnm0NdHQppOZXuS+UDCVw?=
 =?us-ascii?Q?uqZNr3oyV3XQkKsLjhcCcGfdLsOYcTFHPKY5V+0nZiiy1KYS7SvKQN32SbzE?=
 =?us-ascii?Q?pfLf0tr3f7Kc3rXOeNgJFDpypfTrRRSKozvwzJ3iRKOO76cHoJVH0YHTctmK?=
 =?us-ascii?Q?bKXDNwNqIBvJq278PlF2GyOh0sMvw5ZC05yloYjRwQw2OVXsJ3UKh0WpiLH9?=
 =?us-ascii?Q?sU0Ey4ldkdRUFS83WQP8T1lJlFCzSN+HFXC4rKim9mTrfjQyzgjs8O7Da9tC?=
 =?us-ascii?Q?+QZ6/6UioPfdi6LXK+UXGGgE8NzEN0JnRMI8DYJCWgznAALQMdGwnjRENqGD?=
 =?us-ascii?Q?BuFIvow5LxFgf+982XDm92pr7EZfm9sGQvjPUu6ub6g7cKHpOoMfhI/KXIQn?=
 =?us-ascii?Q?2VL/qSYD5vkQJOjwq8rrhPgT67nJK+1GSaYAgfq1N2iJQW2il93qpObpMWi6?=
 =?us-ascii?Q?ycvc0BCCHrZpq0/dJ5tmAjlgr4V85vRWLlfhaijDEwPU3AuxnjSlyPvaNQ+T?=
 =?us-ascii?Q?EVkzXwSEUs8CGooRUYA5qzNLCpYCW9J3UakKqFTqn29wXXi1omyzj53buH59?=
 =?us-ascii?Q?H0Qq9/LPyFTruVnIQwSH3B4Sr8COSY/CwchXvsazhKmLFP+H14rt6P8n0SDP?=
 =?us-ascii?Q?VWnhA9vNE5XLe1E0Dfc/4ShCCQX8hQR6YAPpGJSPgjIjfltTwFW7x3KTdbb3?=
 =?us-ascii?Q?G2GuGZMVHAXNQ1HlZgdBNew+eRCQhALTld9nM86QmcCLDn9QWF4rYpCYVjrm?=
 =?us-ascii?Q?bXsDhHYQM8BV7+wdOSFA31r5Oret1tuQ2m4vZ0y9FDhiHQ3iDr+jWMkY7+qA?=
 =?us-ascii?Q?KyiglBuDhGJO2Xe2CKz/AfSGr4Y8VglgGB7RjWxywkYh972NRxV/SX2hnsUD?=
 =?us-ascii?Q?R8eEUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:16.8975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0f5ff6-431b-452a-5f19-08de5cc7fe79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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


