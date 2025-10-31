Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9A8CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmmM-0005Jr-Qo; Fri, 31 Oct 2025 06:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmlr-0004b4-Qp; Fri, 31 Oct 2025 06:54:17 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmli-0002yy-9E; Fri, 31 Oct 2025 06:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs1gboZww9FGS4VEjue3CSQPokMzKHPIUUaYgBmL2zyU+yA9AZ9Xrc6ZODWJ0FN7ss4qImEWYr2ldanaR4BMGbe9Q+A5/A0XZvecThLskI4u5Uou1w7PLKX0XoCT89chVbURNcnEC2aUMlOXCL9d5NWQMX/wEHR7/viqPVDl0AISVa1Ip1YfRN/44jDosQ5mOZhML6z7BLJ+Xho53iczH7XxQEZ0tbtYeQSLQTMGaWJ7h22E9QnFX3i7ASEWlmbICSw78EFRVDAbINTJuuU5ULxIpcRXEAgr6h/1h7v7qjXh3nFkCDJp/vXxO0CGab6xIlfr9/CcaIS0iMRmYFRNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smYXMaMzV9bIOVuceCDG+5tnSQaxMYi5596VHdCrtaI=;
 b=VFVnMG23sROz9WX05K2w8dn5i2DrsCw8BGwz1285U+P8XfML9jZpTC+AIaBtW0LRtn6yuNCjSzLn3ZXsRGAOB9ISOYufihmNShQm9JN6sQU/L0pa5WHEMyrRZd3Y6jRS6yGtHpgzywAke2N9Sx24Vlazf8djoZ3OwZG9iMGvD/CJgiEr1n+zaRxgHHlaPqRs4PCvoGXyobqkYh0DWQuf98jaYU1PVy39JGHJvQOstp6/aD4poSHYzilslX5b4rHJgBToaZW++RpWX7gBJf4eit4ZA24WbE5jAQcN8mZeiO5QMOC+DtFTIyuQGM0xLmre728cqhSqyA83YQgqn9Plrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smYXMaMzV9bIOVuceCDG+5tnSQaxMYi5596VHdCrtaI=;
 b=c+VzCBRFPY3I5FYuomH3S4fey2rcy59baFs1n+/rC9V9Gmn51Rc3I8wh3IxNANkl+K4CBPcspGY1jWaNwf6B1oDAWGvgOiWpYtNn39lFPN052t00Hm49TW7i3otmWO2S6sc5SeFI+FoBMcFA2uz2Rs5PofhsH7ukFdPotCzTAM5ldMOz+YeFZf49VC1DJD4Cpn6e1Wq8yhWfDzykWg0Sk1ahkr+c+Q5zJKXOKfPNlxUKrngAAkzr2WpQFkvcqM0m19cV05gCDs4bzbAG5L7oTIDZ9DYPdW9vQ8TxakttpFhuCS7/2cR9RPoHylhUgRPKGgD4oBVxdhwfAzG3A9/UzA==
Received: from PH7P221CA0050.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::13)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 10:53:55 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::53) by PH7P221CA0050.outlook.office365.com
 (2603:10b6:510:33c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:53:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:53:41 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Date: Fri, 31 Oct 2025 10:49:48 +0000
Message-ID: <20251031105005.24618-16-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e008e3-5887-4ac1-5f8b-08de186bc964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWtoTURnTmxxbHdwYm9mbTFhNjZja2FrRTdQWlU2b2lKcVJpTktOYUxpUjkw?=
 =?utf-8?B?RDFyVDAyM1dXVkdUZUFEWk9qRkRRNng1QXNwUml4QVY1cjhlNkNQSTcwbXEr?=
 =?utf-8?B?OHNjV1MvMkNENGc1TzB1TXNvd1FkLy9QaVJFZXUvWGZLN1VwRnRMYTgwZVRG?=
 =?utf-8?B?ZXN5Y2VFdzJqZWwrNHpzV0hoYzEvQnNIdnBqRVVXWFNsdzZRK21pelg4ZmZi?=
 =?utf-8?B?Z3NzWjRmVXFBbkVYUHg2K3phMXcydklLT1FSOEZsbFpHUFZhNFhGeWdWd3Zq?=
 =?utf-8?B?djJ0VU94VDRwK2ZiRFFPQkdORHErOGRtNUc2RTJPb0IzNHhkelRWajk1SXBN?=
 =?utf-8?B?SVlJdFh2N2JSSmdDYmRtMk9RNExWa3VYbXA1SzYxSWtmalloYUprWmZVUW5t?=
 =?utf-8?B?OUtySnp6NVdjWS93dVNiSm4vUEp1alRKTTU2dGhXcThhbG9RNDViTW9jS2g5?=
 =?utf-8?B?eVo0Z2NZMUs3NEgzZGt5MGxJbStDazB5ZC82WGVoVWg5YWVMSmltaTk4MDlq?=
 =?utf-8?B?cks1NTg5dmRJTitHcEMyR0c5aEJ6TzJVRnBzT1hpSk10ZXB4UTBIRmZLMVJX?=
 =?utf-8?B?b2JFUzJVWTQrbk52RVRCTHRrNlhtN0U4cVVDVFlDQVM3MjRiSnRpYktEdG9w?=
 =?utf-8?B?eW84WjRJOGxZMFRNeWVMMDFXTE1BbWs2Y0Vlb0dnWlZjNXByUzYvRFpocVk5?=
 =?utf-8?B?RXY3eUp4Y0I4MDF6YkRaeXU4cnNSQnRhS3E3VDU0Q2FvdjhVaXZNZFNOTUhm?=
 =?utf-8?B?cGs1TnhHUnFWaFJhREwyWHVDNWZMbUhRWkdTMkZXL0hxOHk2K29EQmw5Sndn?=
 =?utf-8?B?enVoNzJ1b1lqR2xHamZBVXRCMyt1WXZpYm4vaE5CWXZZemFwZUVQRS81ejZ1?=
 =?utf-8?B?SHM4N1N3WnhPUnQrMCtpckEzWEM2NnE2MFFUTEVsYzhyMFNlNUZCSkV4T3Ju?=
 =?utf-8?B?UUZsUDNSbkJNR1V5Y1JIb095SjZkaUl4RXBmQWVWeDVVd0NDZkVjMEVJZ0Ey?=
 =?utf-8?B?ZllYT0ZmV2FEbjRiVVdiM09zWlVpNzdPdjBzenFHQytXeTVsckJvYy83ZWN0?=
 =?utf-8?B?SkIzdmlUblhNcXhVR0phQmd5WW9vZGo0ekhXZXBWU0Y0OUVUSW8zYmVhdWxZ?=
 =?utf-8?B?TnZZYUxWdkN5UVNJM0lJREFQYUdDenBMUnY2V0NGMWNqY2ZCdnJyZHBCQjBm?=
 =?utf-8?B?TmNKOGdpbU1YeFhzenNzdWRQdy96WjV1S01UdHpGdWpGdXNjQmtkNkdXV1JS?=
 =?utf-8?B?STdTU0JTdW5oSzVnV1Z4ZWljNGZ2a0pBQzIrYjJlU1JsOXRtVCtTSTJYeHVx?=
 =?utf-8?B?TEswKzFpZUFmTHl1MDJWaElrVGtwMVc3NlRFSnNldW9CM3BldlpjS1RTTjNn?=
 =?utf-8?B?Um1OYkZMMm1icFVEVHFJZCtEYk5rQkZENTN5TDdEcEdlZUo1emowRTZlUEFz?=
 =?utf-8?B?YkF5VTVxYk1JT2FtSXhVS1liWC84TXhScVFJTDZNWUZzSFFmN1pjRUNxY2xT?=
 =?utf-8?B?bmlKVldraHhjVEQ0RUpSdWZlRDZhaDZLMjNzVnRlMzRha213VVkxNUNmL1NR?=
 =?utf-8?B?bG5qdlJNSFM0dlRpYzRKVzBCbWZZWFhIRlAzaWFjN1VXbHJGU2dpWlBtK2U3?=
 =?utf-8?B?dk8vQVdRUEtSbjhXOWZ4SWpTdkQ0UDBRNWpBNG9vU0huN0ZUdnJxcFRDTkNU?=
 =?utf-8?B?T2xiVForWFpHaDZMd3NES0gyekZOWlNVMGdqVUNoSzl3WXVQSENiZHlGcy9I?=
 =?utf-8?B?UHFnUXRPL2VIcWVMcXJkUnhQSHY2VnpVcmprVTQ0UVRVZ0xFYVBWZDNVcXdl?=
 =?utf-8?B?QklrQ2R1MHVuYld2SUlsZUR3a1NIaGtxQmZKcndaSDRPUmtmb2lEMTZjZ0oz?=
 =?utf-8?B?ZlNCN1pScFFuLy9kQ2x1N2REZ1RsemdOLzBNaFovcGxtNVVVNHE1eVJJTWow?=
 =?utf-8?B?OFluLzBIenhJWW1HbFowckdCUFgzUGovWFNEbEJEcVdpU1hoSThYelBwTGVv?=
 =?utf-8?B?SjhrS0pSbmh1MjZtY1BPeERGU2phaEF2dTMwZWRnb2FFQTFzaDM4MUdYbXRL?=
 =?utf-8?B?emVVRVZjTUpOWUgrdXhRRmc1WlBRUW9tU0p4dVE1Tm1pOU9ERXd0RFE2VE0z?=
 =?utf-8?Q?JWMs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:53:55.1331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e008e3-5887-4ac1-5f8b-08de186bc964
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On ARM, devices behind an IOMMU have their MSI doorbell addresses
translated by the IOMMU. In nested mode, this translation happens in
two stages (gIOVA → gPA → ITS page).

In accelerated SMMUv3 mode, both stages are handled by hardware, so
get_address_space() returns the system address space so that VFIO
can setup stage-2 mappings for system address space.

However, QEMU/KVM also calls this callback when resolving
MSI doorbells:

  kvm_irqchip_add_msi_route()
    kvm_arch_fixup_msi_route()
      pci_device_iommu_address_space()
        get_address_space()

VFIO device in the guest with a SMMUv3 is programmed with a gIOVA for
MSI doorbell. This gIOVA can't be used to setup the MSI doorbell
directly. This needs to be translated to vITS gPA. In order to do the
doorbell transalation it needs IOMMU address space.

Add an optional get_msi_address_space() callback and use it in this
path to return the correct address space for such cases.

Cc: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/pci/pci.c         | 18 ++++++++++++++++++
 include/hw/pci/pci.h | 16 ++++++++++++++++
 target/arm/kvm.c     |  2 +-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fa9cf5dab2..1edd711247 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2982,6 +2982,24 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus) {
+        if (iommu_bus->iommu_ops->get_msi_address_space) {
+            return iommu_bus->iommu_ops->get_msi_address_space(bus,
+                                 iommu_bus->iommu_opaque, devfn);
+        }
+        return iommu_bus->iommu_ops->get_address_space(bus,
+                                 iommu_bus->iommu_opaque, devfn);
+    }
+    return &address_space_memory;
+}
+
 int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
                                   IOMMUNotify fn, void *opaque)
 {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index dfeba8c9bd..b731443c67 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -664,6 +664,21 @@ typedef struct PCIIOMMUOps {
                             uint32_t pasid, bool priv_req, bool exec_req,
                             hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
                             bool is_write);
+    /**
+     * @get_msi_address_space: get the address space for MSI doorbell address
+     * for devices
+     *
+     * Optional callback which returns a pointer to an #AddressSpace. This
+     * is required if MSI doorbell also gets translated through vIOMMU(eg: ARM)
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     */
+    AddressSpace * (*get_msi_address_space)(PCIBus *bus, void *opaque,
+                                            int devfn);
 } PCIIOMMUOps;
 
 bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
@@ -672,6 +687,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
+AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev);
 
 /**
  * pci_device_get_viommu_flags: get vIOMMU flags.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0d57081e69..0df41128d0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1611,7 +1611,7 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-    AddressSpace *as = pci_device_iommu_address_space(dev);
+    AddressSpace *as = pci_device_iommu_msi_address_space(dev);
     hwaddr xlat, len, doorbell_gpa;
     MemoryRegionSection mrs;
     MemoryRegion *mr;
-- 
2.43.0


