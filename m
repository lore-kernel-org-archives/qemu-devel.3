Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64400C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 00:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGqk-0007qB-2s; Tue, 25 Jun 2024 20:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGqR-0007mw-NQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:49:07 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMGpy-0008Nq-H9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIHMQY+oc9UPETFdJMzr7ijr+JemxvnxtGxQxph1fVJSM4+PPtUAyWvdVvCwfi6yAgR/47k0t5haG60DtsYaWNVfBqVo6Cc+hRWlQmmTz4uKPmnVHRLEJP0xCFDaONh747KqNC/a6zPqcth8UAk39UpO5lhS1YnwHpF41+3anY9H9lmAivt52IC7ZdBSfypXBr1vbf7XTUZXAxVCRoKiluqNihnlGEtVCH9EpQDE+C8SvsHs/OkoBT0APLetlgHOnpy2TPvszjlpLEtQXWp6DUP92oIsXiCqU3cl6cIXsJJXaFLE0VAAl+krDGrL05QeoJ65pFsV79H5C6N8sVJtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKGAh2ATfoLK95hp8Z/cu4KOvl4dtRq0vlHJL2bcDTM=;
 b=lofQvF7JGhQvjMuZ4+cwDKaNGIaqlY43WqQfkxHcBqzopNt3bC04ZNGRuwHQgKhOIMTo3DkANFZ1QFO+E3lr3pAYso3ufJDtj7SyEK60TAyVWHNwb5gtyx6tTMSdO64+T/2E6eJ18NB9P+ndjCFWSz42K8qQtYMLqqsgM/TeA7SMjulf1bqUfimqRMoX3tkBqb9hWA7OCXIlMwaPy+JqZ3h8IDbLnNHwymfwzcPVynjiAGJPeyvkMRdohEWnnjDGOvwUtoVI7FMRizyufKd7fNOjsAv2I2+hxRzTJqtVd/eZPyH+hSXck/CiY+OGlCeLMT1cf8SAwTqvlkEusHpnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKGAh2ATfoLK95hp8Z/cu4KOvl4dtRq0vlHJL2bcDTM=;
 b=lqj4sI4yuN3WSvwZCvp9c5DEXS3/E5J2JU3Z1J0EWnRGQDvD4IGEM4AedW7rwpBRe65VAOxOlZSfVz/pPDdL3XHV9bLZahQti9zapX3OCgjNmsJT8Eku7SueiqP9KsBJWnjsXVbvb4DuMFyzeEt/5Src1BzcgFpxPZgZdyGlGrL+dndgGA40gdschMUdO4GIvuCReR5vejHjKIqwAtdxtmAWaOeSoEfPHDJF0dmrPkIKiYCYBDZEKBZLtyziHNCfnLuhA08baVN89auH9fJKiSAUKbTTwBBLHishr8KwhlDmkpbkzKCL1GNOJnPyyNKNiJ9sUaxtMPSJRBVFw5VEMA==
Received: from BN9PR03CA0936.namprd03.prod.outlook.com (2603:10b6:408:108::11)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 00:29:39 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::88) by BN9PR03CA0936.outlook.office365.com
 (2603:10b6:408:108::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 06/10] hw/arm/virt: Assign vfio-pci devices to nested
 SMMUs
Date: Tue, 25 Jun 2024 17:28:33 -0700
Message-ID: <67c6311756de2a6e827e3dd0563f939dcf334418.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: a3299bac-6fc8-43da-2099-08dc95771097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?71hlhyHHRosO4ciB93LxsiVk548v2TJavPB/gFRnm00Z7BuDmiDgLYGPF9XX?=
 =?us-ascii?Q?IFaivCcCf94MCiLIa3ePd8d+RB5L60haJ8eTVTOzulpn4omJvYj3QLaFLSe8?=
 =?us-ascii?Q?ypPWvXZ0C9N8Tfj0eZH0MuYSsFFJ1zXsC0QeAF0yZ0HY/wIN/sHxkAeEIMYB?=
 =?us-ascii?Q?X/ou68j23STxLxArnhd3o0PnPSOJhu1r1K3rCKgbVvtBevZptRKqZ+RokWkg?=
 =?us-ascii?Q?q/QO1knw/zX55j3kLzlF68NDHVtwkzpBVSV8O1F3Y6+GwEYQCF245ZCgeKWf?=
 =?us-ascii?Q?DHbkxq5YUZDk3VvTmHZ2BA3/wo8fFmJ/aGEY2brrejJMzeZou9YQ9/lsEPQK?=
 =?us-ascii?Q?0SHU+e7LWAh7I8Jh/gxeLftksalydSpjJX0wdSrvIflA7HyY3SPNWmzUBghH?=
 =?us-ascii?Q?YBi8K28DIUbnn4y0lsN69pn0nk5i8vvXC9oQn/ywRIq2zVVvVzsEHdygEvW0?=
 =?us-ascii?Q?FVaiH5Tvs1IepH6eN5Ja8X/uPSDyi0TfOij7zoKYUL9YYuUW1deUv/bsT/+M?=
 =?us-ascii?Q?4XQpOG2XxU9s4nfPtuhfQc5MzM11M/IQIyViV0HCY2ZOz1aSsE9a28Siy98G?=
 =?us-ascii?Q?rfvXHwud23af3KHyNlw60sw4AnQghY2jinYCOuDTGgEqt16Z5yGNYY564MIm?=
 =?us-ascii?Q?65lodXkxTuH8JPHo4Tfy4CBLmmqPWL9D7hS2jQurOlGb6PSp3IOYZyis/yF/?=
 =?us-ascii?Q?5VI/bdiewAytq6k33VzbDcy2dvbkudQpBQ+Z6b6LkYWvlyybYChwz/5gHZ/V?=
 =?us-ascii?Q?b7i8XdSn+Gv6gHevMprv3f9IUWndMXUDPtg/8sGudJ2PiGFyF6pBxYx9uDbr?=
 =?us-ascii?Q?mnb1Gwb7/MBS7hAIbXrgWyW3L0A+a/sT4PCJpksd2VFoQkVtQYC8r9yYXd4u?=
 =?us-ascii?Q?TRs8n5bvG+2d83foZ8RiSjVc7tuFiKXppSS16GGvmujL0Rx10o2guxh2WIgm?=
 =?us-ascii?Q?KPUljimkEpLjcCDbiLedBC0M1RoykT4aVt9aU+RlJD3nK9MCXz+V2dulgS3f?=
 =?us-ascii?Q?bo3MMNtaZDhJs1I9Xenh8Bpv+5KpRw//0OudKuvaNSYbeQ3HlVujI45IJxJD?=
 =?us-ascii?Q?baId1fwADc9wzZ/yj/4kbw17RSDV5t2dWtlmlS4CDSgDF1mbQ+UzvtdvZ4sG?=
 =?us-ascii?Q?g2LdPfb/+m78ZUyjUw5BRpbE68csU8LB4UKpf20dTnFYbhDwUO7GVt+AujY9?=
 =?us-ascii?Q?3z7T2I53t66saBCxMFUrzIJpkvH6CAI/dHJH1UPRWbLQTNXQyJIWr9cajlHp?=
 =?us-ascii?Q?AA8Hs8iPjnA6YYcsk3lhHzNAtJmYANr8j2TJfVBniC4oEh7XCmNKwDdIweof?=
 =?us-ascii?Q?hht66KXqFh/pTDYxtnTPp95EwnmGANR1m4dPP489yuYbmAnX+4EanoNAWVeg?=
 =?us-ascii?Q?m2rxVWBXTwSoPyi248BRauepeOnoFnEe7xo4purM/SHQlmNxkwbRGgEnUJgi?=
 =?us-ascii?Q?nLVQi+7eiANLlR2vkn1sr6wneetxq/DD?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:38.9723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3299bac-6fc8-43da-2099-08dc95771097
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
Received-SPF: softfail client-ip=2a01:111:f403:2415::601;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

With iommu=nested-smmuv3, there could be multiple nested SMMU instances in
the vms. A passthrough device must to look up for its iommu handler in its
sysfs node, and then link to the nested SMMU instance created for the same
iommu handler. This isn't easy to do.

Add an auto-assign piece after all vSMMU backed pxb buses are created. It
loops the existing input devices, and sets/replaces their pci bus numbers
with a newly created pcie-root-port to the pxb bus.

Note that this is not an ideal solution to handle hot plug device.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt.c         | 110 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  13 +++++
 2 files changed, 123 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a54332fca8..3610f53304 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -38,6 +38,7 @@
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
 #include "hw/block/flash.h"
+#include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
@@ -1491,6 +1492,112 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
                            bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
+static char *create_new_pcie_port(VirtNestedSmmu *nested_smmu, Error **errp)
+{
+    uint32_t port_nr = nested_smmu->pci_bus->qbus.num_children;
+    uint32_t chassis_nr = UINT8_MAX - nested_smmu->index;
+    uint32_t bus_nr = pci_bus_num(nested_smmu->pci_bus);
+    DeviceState *dev;
+    char *name_port;
+
+    /* Create a root port */
+    dev = qdev_new("pcie-root-port");
+    name_port = g_strdup_printf("smmu_bus0x%x_port%d", bus_nr, port_nr);
+
+    if (!qdev_set_id(dev, name_port, &error_fatal)) {
+        /* FIXME retry with a different port num? */
+        error_setg(errp, "Could not set pcie-root-port ID %s", name_port);
+        g_free(name_port);
+        g_free(dev);
+        return NULL;
+    }
+    qdev_prop_set_uint32(dev, "chassis", chassis_nr);
+    qdev_prop_set_uint32(dev, "slot", port_nr);
+    qdev_prop_set_uint64(dev, "io-reserve", 0);
+    qdev_realize_and_unref(dev, BUS(nested_smmu->pci_bus), &error_fatal);
+    return name_port;
+}
+
+static int assign_nested_smmu(void *opaque, QemuOpts *opts, Error **errp)
+{
+    VirtMachineState *vms = (VirtMachineState *)opaque;
+    const char *sysfsdev = qemu_opt_get(opts, "sysfsdev");
+    const char *iommufd = qemu_opt_get(opts, "iommufd");
+    const char *driver = qemu_opt_get(opts, "driver");
+    const char *host = qemu_opt_get(opts, "host");
+    const char *bus = qemu_opt_get(opts, "bus");
+    VirtNestedSmmu *nested_smmu;
+    char *link_iommu;
+    char *dir_iommu;
+    char *smmu_node;
+    char *name_port;
+    int ret = 0;
+
+    if (!iommufd || !driver) {
+        return 0;
+    }
+    if (!sysfsdev && !host) {
+        return 0;
+    }
+    if (strncmp(driver, TYPE_VFIO_PCI, strlen(TYPE_VFIO_PCI))) {
+        return 0;
+    }
+    /* If the device wants to attach to the default bus, do not reassign it */
+    if (bus && !strncmp(bus, "pcie.0", strlen(bus))) {
+        return 0;
+    }
+
+    if (sysfsdev) {
+        link_iommu = g_strdup_printf("%s/iommu", sysfsdev);
+    } else {
+        link_iommu = g_strdup_printf("/sys/bus/pci/devices/%s/iommu", host);
+    }
+
+    dir_iommu = realpath(link_iommu, NULL);
+    if (!dir_iommu) {
+        error_setg(errp, "Could not get the real path for iommu link: %s",
+                   link_iommu);
+        ret = -EINVAL;
+        goto free_link;
+    }
+
+    smmu_node = g_path_get_basename(dir_iommu);
+    if (!smmu_node) {
+        error_setg(errp, "Could not get SMMU node name for iommu at: %s",
+                   dir_iommu);
+        ret = -EINVAL;
+        goto free_dir;
+    }
+
+    nested_smmu = find_nested_smmu_by_sysfs(vms, smmu_node);
+    if (!nested_smmu) {
+        error_setg(errp, "Could not find any detected SMMU matching node: %s",
+                   smmu_node);
+        ret = -EINVAL;
+        goto free_node;
+    }
+
+    name_port = create_new_pcie_port(nested_smmu, errp);
+    if (!name_port) {
+        ret = -EBUSY;
+        goto free_node;
+    }
+
+    qemu_opt_set(opts, "bus", name_port, &error_fatal);
+    if (bus) {
+        error_report("overriding PCI bus %s to %s for device %s [%s]",
+                     bus, name_port, host, sysfsdev);
+    }
+
+free_node:
+    free(smmu_node);
+free_dir:
+    free(dir_iommu);
+free_link:
+    free(link_iommu);
+    return ret;
+}
+
 /*
  * FIXME this is used to reverse for hotplug devices, yet it could result in a
  * big waste of PCI bus numbners.
@@ -1669,6 +1776,9 @@ static void create_pcie(VirtMachineState *vms)
             qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map", 0x0,
                                    vms->nested_smmu_phandle[i], 0x0, 0x10000);
         }
+
+        qemu_opts_foreach(qemu_find_opts("device"),
+                          assign_nested_smmu, vms, &error_fatal);
     } else if (vms->iommu) {
         vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 0a3f1ab8b5..dfbc4bba3c 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -246,4 +246,17 @@ find_nested_smmu_by_index(VirtMachineState *vms, int index)
     return NULL;
 }
 
+static inline VirtNestedSmmu *
+find_nested_smmu_by_sysfs(VirtMachineState *vms, char *node)
+{
+    VirtNestedSmmu *nested_smmu;
+
+    QLIST_FOREACH(nested_smmu, &vms->nested_smmu_list, next) {
+        if (!strncmp(nested_smmu->smmu_node, node, strlen(node))) {
+            return nested_smmu;
+        }
+    }
+    return NULL;
+}
+
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.43.0


