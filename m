Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD8ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmlT-00049C-4M; Fri, 31 Oct 2025 06:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlR-00041w-3o; Fri, 31 Oct 2025 06:53:49 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlF-0002wN-LC; Fri, 31 Oct 2025 06:53:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHiFlbZgXuT0woIvwFzBBGv0GCEq8ItyemhST0EIltCkydYNmZght0HHwB4okFagTatEc/iij35Xpx9r5neOfoq6pNlyJvNu/vlwLUhL43yEWvoN9Arp1MYbFnvIPlM5q9U9qLSvhgBFN+uSLnlOvcnrJH/WgErVTXnmYft4KVfXj7tK9c1J1NposNSOV85GBPrj0UOJcaS9JRixZ0qO0CB9DiHmyehIUo0rOaaE6u1+EZ5HUqRJZMKVaf3pAtaonY01toQzJXVEDV8qDaStVwW1oJrgFWSlFbO6xHjxogC7Xg6ER+s1HZU9XgRyMPnJvnLEJugxGXCVHNqerYUWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMuHvEIZbTyChcsvhpbyemVmRBIGh3P6ZLZg4RJKXgc=;
 b=gnqQ6oO6slxVYcb4RhYNHbHz/PyXgFU8xpGBWLpwJNs/RaLYW/lp394a9wNj1GaU9QtszOFgwVPbDKi5yTKS4pjfP+K7xoUIaCA8TPwTLmS0RJRbEqYhei7p0PaN4DOeOsHTx/iOHNuhsCQZDZB0wL99V4nrwf0PI5tqd/1rEp+8W23XAXm2ebTTB3VzX1l4DAq9FOc9QvTXcussGL65sokjVMo0lXB6+mKGA4rhdsRCU8CN0BmWRA3WvNkhVA/QTCBKo1/5/2EADH3FUE0E+GCWP+OV9yFG4AeJx6t9bwhE3poTHUMOhgUmhS3zxXh7whPIrMv2hB8YjR7r0Ibsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMuHvEIZbTyChcsvhpbyemVmRBIGh3P6ZLZg4RJKXgc=;
 b=sowgPTUgfyEypDkogOmajIeJaIjXMYs14RMgeW3ykVKcKJBTYhAtI+f/nj1pXonufSW8WyL3azbP06YQzpFKKDGax3IF+a8OLW3kKLlpy6qAhdLe289kKYlNvmO15KXBNyLmVh4Ue7oUBG1fhIMyz7yV8mgT3wno4jjR+0VxorcJdBENPxluLu8mVYcYYpb4+rlxJsGoEcT4dXQODQRW7tccxyg8C5bZyNqKTRsZegyz9N7RtF4VtWrnrm63pnNyMgWAqRNfEVVQbD8uLIe90Upzo3vFd+iCMr1e/3ZzU6420Jk7NtL4Z5YsX20yU1cCqvZfeZpX/EwtChNAuW8ZAA==
Received: from BY5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:1e0::32)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:53:29 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::e5) by BY5PR03CA0022.outlook.office365.com
 (2603:10b6:a03:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 03:53:12 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:09 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 08/32] hw/pci/pci: Add optional supports_address_space()
 callback
Date: Fri, 31 Oct 2025 10:49:41 +0000
Message-ID: <20251031105005.24618-9-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a339825-faa5-43b8-b70b-08de186bb915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y9WHv7v5iGceC08Y0Nmqynub7hl3aMK1TgNrT+yF7D/Ye427oLwJzcZmwkM+?=
 =?us-ascii?Q?A8+xzqPf98/UICph2huPUNwmdf/L6WZcyL/uveAfy7Y4Ywi9Hbw+69rD6YBa?=
 =?us-ascii?Q?WGNkdhyhrLKChJSTogAvVq9KN9ov+Dm7s46q0sI9a+A2wdLyuRGss1+zZzen?=
 =?us-ascii?Q?y7D6kEoMLNUsohy1/QpJ/7dtl0eCbG0H+u+nRhhzYUIguZ4w9guEOADUAsnD?=
 =?us-ascii?Q?wKRVdrSrVyg/r8QIjidPwtCFnKQ+5xXefR4Kmj6DKTb01TnMqh5QsOZEmxOp?=
 =?us-ascii?Q?gIdCdHopsvfg8XvDD3zJpv2GNfPMqYKy2ZOQvgsZmBPoS6yDgyGwAhOVAOa4?=
 =?us-ascii?Q?RMilddtWxOooPGbKTrFh04rUzf6XlWxQMsnkMqpRORFBT9A44S5RW59cyQFv?=
 =?us-ascii?Q?OktVRGUeozWCNMwtOys2fXoylAzUj4tq9geuFZpsuwnoWNwGduOWerUobDO7?=
 =?us-ascii?Q?F4+OVFXMciiPan58ahviV6yA0GJYcYBgrUKVmyMCc15h678kM3M1Y7ye/sgU?=
 =?us-ascii?Q?8Vrg4LB136sxrurYX4iCV9DXwakE9TSsnzq6ECR4xYzGbFRBm/bbgKlKGem+?=
 =?us-ascii?Q?g0JGOclV9JwPHQob0Vub5QyIw4zpxTISzge1Jtji3xFLsrL0UV9pN0EqALTJ?=
 =?us-ascii?Q?lXsFXnogSnmHTY21co9XOZzElaklqdCpeBr5TF/v4Ki534HP+/ysJm6+Y6E6?=
 =?us-ascii?Q?qz0gRXzsmBHsCpHRWkT1vjX/h28tnTHewwYB2nnV3SV2jJSZWhuEQMKJbQYE?=
 =?us-ascii?Q?wAlcwwWIp+FeBHQibBsO92PERkh+FwvwlaSt8uXGB44vhV82sVmXoyJseN43?=
 =?us-ascii?Q?qBeJ8s/JotXrrUL7Onp3XVJHjjZpYW5NdBNwNcoCo4MNL/ZJpHjOE+39aNKH?=
 =?us-ascii?Q?4bWvTBVhydIv/3DUWCuE8TvuTl4xNKFBu9wi8GYREEOooV89WXcoo9Tux8P6?=
 =?us-ascii?Q?tpaw/O0mD4VoOSoHk7y8QuaJkFJF7v0bHls+oU9o7cu+34v1SZHHuYU8TiFO?=
 =?us-ascii?Q?2BRQMwRsyRHXkyo2HxLO2/yKsUOWcQzq1Lfec+D3hwYfZibNn/Fq6ExetW0l?=
 =?us-ascii?Q?uQB/6srf7bnhqO/KX0+PjhtLTAlJN0F/scMru3mEZPZLjDD1CA0FRebEeTPT?=
 =?us-ascii?Q?p33b02MsbQ6YU3NqHzr+znA5Xs9bnomOONfVGmHOzCmoMEsyW+FDR/3WBbAq?=
 =?us-ascii?Q?q0s/i5PL7uYPWtDSU6g7zkcPfccpB+bhnLtcFHgpoH9zfaWCjiRsVy2ReHO4?=
 =?us-ascii?Q?DNxGRGkZQa6GgSymFkD8/jUAfP70P+lm5Bo3xRnPNzy9v3CH9g+2BBIDv50f?=
 =?us-ascii?Q?qEaoSrt9zSnmOEOo/QJyF8VOYdRIlwXUhA/xSMWRUO41g09r6BEAm6cHEDUD?=
 =?us-ascii?Q?SSH7xYRXn2y7yOH/uqcHJN4LJehlqO8dvR2Dn+afkOmHHEuayz3xMSV13BFw?=
 =?us-ascii?Q?jiZ6PhoIXVSczncigF4o7PdgDRAeB/4R2zhkH0b7u2zMwdxo6OWrj2Kn1Ewj?=
 =?us-ascii?Q?rB+ttyGEjQ0powqlmrANt1c9Y/P8JsZuSJRRCa+lXIs/abGTddEcl5j8CATE?=
 =?us-ascii?Q?UlbhA1k+h8CMN0O7pfk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:27.7591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a339825-faa5-43b8-b70b-08de186bb915
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.399, SPF_HELO_NONE=0.001,
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
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 20 ++++++++++++++++++++
 include/hw/pci/pci.h | 17 +++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 9693d7f10c..fa9cf5dab2 100644
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
@@ -1413,6 +1428,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
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
index cf99b5bb68..dfeba8c9bd 100644
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


