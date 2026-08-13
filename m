Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0EAC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVAP-0006QS-P7; Thu, 13 Aug 2026 09:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAG-0006QA-QZ; Thu, 13 Aug 2026 09:08:10 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>)
 id 1wuVAD-0005OG-PT; Thu, 13 Aug 2026 09:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ3zz8COpSaXbDADo20o1GOSwzg3sXC/UzkwiygpIR+N2jn6fYfY2bPHoPQiITX0OIwy8GcTITLEK731ebA8ZSiy1/HLyyLWHYK6IbYOTw+1wBiXoxfsDazOxF3Sthk+bg3CqZ21lmJDwzXiZNaN6AH/MhVAN5py6f8Ib4sWh/3tOqOhlvPv+R5lvgClp4mkU/CSJ1ogVJ/1phy62hkKJTWWnN1OxVWd+AeZO8Funv+LYOddYfGcJm3Xaq3ZYrkZuswO2ty2WtmQkY6uapBbku76qHQH+S3p+2SCvqfaLoXemdHJU2fhZ4/fhFIpVJC+U9mxXXb+sQb1udD8ZcnWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC+x8/TcY0zFvTkZExyU1AAEl7ZGuZ9LXF6GjqTkB98=;
 b=RjqawORGcJlqyXj6QCXC4o0BkkSbR265a/rSy4oZ0G9LdIpSvG621Ffqd1Bo035rdCVEXhwIIxi3sLPClsLRBhMaKt1ts4L2bQN3520Dubn7OcogIz8t3arD/wnxeBKZ4b8qUhxeliosBGP17QybXL9n6itjrRnaDTJMRvOgUlLqpA0DCXFRA6YZ0klmi5rzKHvUgXSJeFA3L+EaDtepqbQXzZL73dS/zVdGZQj0k7vjmUhEDvdm5qC5Hj0ITQEPjnlycrR5Mgajjdn7FyyWjcFKN6HO6yoalN5cxqS/Uky1JLwur5dgjgJcSY3ymjl0dq3Cb7Lfw/Ihq/QA8JDkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC+x8/TcY0zFvTkZExyU1AAEl7ZGuZ9LXF6GjqTkB98=;
 b=flG9rTnRMV5DzdhwAHHrqpFZjsZE/pZQh5yRB7H6FuZ8ynw1eaU+ozaCJMEEzMIXnUewW+/iVORAYoUUn14CVVkPjMRuXibw0HRvgQ91h21BBwtNp21+W9cLZH40pxU2vUrcesdCMlnz2Ax+Rv8jpwFZzZWB7+hsqzwd+P5k+Tt7Pag/GGOURnfc4EtDK9d29hpTgABVdty/ax0l4GTIvFuKKmQGeM4e/d5VmXlI8qdizB03+E9OljHvngR5WEljKv6HF68NICrygoXQ4PIrQZ7HkugyYwOtuYA/u1VUe0NydM8rSwYJhhkfnsnoDpyyXq3+yrgrtutK6tfd1gMxgQ==
Received: from DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 13:07:52 +0000
Received: from BN9PR03CA0615.namprd03.prod.outlook.com (2603:10b6:408:106::20)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:07:51 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::9f) by BN9PR03CA0615.outlook.office365.com
 (2603:10b6:408:106::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 13:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 13:07:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 06:07:28 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 06:07:15 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
 <mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 06/10] hw/vfio/pci: Bind a CXL device to its fixed memory
 window
Date: Thu, 13 Aug 2026 18:36:19 +0530
Message-ID: <20260813130623.2499506-7-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS4PR12MB9587:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3e3e00-516e-482b-dfd8-08def93be126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|82310400026|23010399003|1800799024|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: LZ6Gqbdk2UPg71Q0C09MMe8NOdFyzJV6irUaBnrZMXoLCHTJETwjJkrMnI6jxNb0K5pvJN/SYh7cjvZ/aTfKqRepg3M3piptUHBbmiq7tWj5HSbRRVg1PwPIfHutSpODL9suxR3L1HyftNRfyAZwCkkCBis4zGO2dFg2vCeLAxoztHyW2KqHNY4b1bxtV8Cqv4GQfFrYXyxhx5rLIHeLKDH7Yn3n3sEa5ZqwoXyQcVN/edKs1ZujkCygw+1dyONzVNL5qakVQzjsnZFLa2UTF8jRjckMMxu9PxceH53f5GO6ZDXDQEnH0wKb9aAzkyYWhZxUbxryXOCLdd8TyBuYibrIEQmY9kzCYR7sKZ4cDxg55KVjimJ6TTy12C5moQ3I/mdfGTAaadSg4vtH68ZB5XrHfipMI1Xs5ov5tnIriPT4ylvJlT+CU3wyRY+Mc3l4Ndj6YRdW1B9A+vkqxcpUWN8UXhVpV6rEJ/Cqh2jfWbCu8/3Wtjxq746JqqViV1YvRCvkBWKGgiL+lkiXA9FUjtnnxnWW4rqVTCSwUsZET+Ly1NfGr+hbl2l4qlogQJizToZRTfJbSctE40X3b+ysxy+dWGauLmPBlv+lxFUw4339wSMxUYONxkxTNgAtSiIlLg7+Xztww6i0SEQ+jRCR6Lf9rMtLv6PmPDlEY6mnDIiJ8ME3PbBl2pdrRnGGTXYi9zM35AL0iAun/340anD/Al1T2ISFkpr+kE+S+ZC+0LZUEh2ZbGPqYcS2msF551u/
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GdVCOAO2En2MhQFe83ZkzOQ3Ebh3H6Q+lKif2S0FQf8PYgyk7tsZSJ9RTJoFCDR2YQEUGszl76YaXVuG5Oc8Zkga0PJAB1KxMRMFRxxJMvSqHj39cZQgaLkJh6aV6l2l34QZdGoyFrYjsLK3388i8Rv1SaKpcFiC2ZuOjAZdlMtzAjk70zIpNa+CP+F4duwWuN0eLOuEc4CKwxIFiXCqBCNuq3Iq69ouHFQRnM9sNOTx86dP//c6iG8SWbi6c1vIxrldwV7FB45qkrNHSLyFdw7/Tm6vmpeXSCEUYwxJtj8NRY54X8g8DXvPJn/68s6EROlo+OJnF4B4I1pg75gR7jDVMb0luZtDputmIyT1Po+xdw70GuFE8fSOHHK4I+nxs3TNlGtkLiqZJ6cw+x7qdq8/nl2dNgEvdfg0OoEIlGWhdT1g66Tq8LG9cKpqp1JS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:50.7221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3e3e00-516e-482b-dfd8-08def93be126
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=mhonap@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Manish Honap <mhonap@nvidia.com>

The guest programs a GPA inside a CXL fixed memory window and QEMU maps
the HDM memory there, so the device must sit under exactly one
single-target CFMWS. Reject any ambiguous, interleaved, unsized, or
missing window rather than guess. Match windows by target name, since the
resolved target pointers are only filled in by a machine-done notifier
that may run after this one.

The CFMWS windows are placed at machine-init-done, so a cold-plugged
device can only be validated from that notifier, where a bad topology is
fatal to startup. Factor the check into a helper that reports through errp
so a later change can also validate a hotplugged device from realize.

The endpoint's HDM size is device information QEMU already reads from the
kernel region, not a value the caller should have to guess. Sizing the
window from the device is not yet possible because it is placed in the
guest PA map before this device is realized, so treat the device
geometry as the source of truth for the check: reject a window too small
to hold the endpoint and name the exact size to set, and warn on an
oversized window, since the padding becomes guest CEDT that migration
has to preserve.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/pci-bridge/pci_expander_bridge_stubs.c |   6 +
 hw/vfio/pci.c                             | 190 ++++++++++++++++++++++
 hw/vfio/pci.h                             |   3 +
 3 files changed, 199 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge_stubs.c b/hw/pci-bridge/pci_expander_bridge_stubs.c
index b35180311f..c44ad7fab6 100644
--- a/hw/pci-bridge/pci_expander_bridge_stubs.c
+++ b/hw/pci-bridge/pci_expander_bridge_stubs.c
@@ -10,5 +10,11 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_component.h"
 
 void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp) {};
+
+bool cxl_get_hb_passthrough(PCIHostState *hb)
+{
+    return false;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 066333d52d..bf6f36d514 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -27,7 +27,12 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
+#include "hw/cxl/cxl_component.h"
+#include "system/system.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/vfio/vfio-cpr.h"
@@ -3652,6 +3657,187 @@ static bool vfio_cxl_check_topology(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+/*
+ * Count the CXL fixed memory windows that target this device's pxb-cxl and
+ * report the matched window's base, size and target count. Match on the target
+ * names: cxl_fmws_link_targets() resolves target_hbs[] only at machine_done,
+ * which may run after this, so the resolved pointers can still be NULL here.
+ */
+static int vfio_cxl_match_fmws(PXBCXLDev *pxb, hwaddr *base, uint64_t *size,
+                               int *nwindows, int *ntargets)
+{
+    GSList *list = cxl_fmws_get_all_sorted();
+    GSList *iter;
+    int matches = 0;
+
+    *nwindows = g_slist_length(list);
+    *base = 0;
+    *size = 0;
+    *ntargets = 0;
+
+    for (iter = list; iter; iter = iter->next) {
+        CXLFixedWindow *fw = CXL_FMW(iter->data);
+        int i;
+
+        for (i = 0; i < fw->num_targets; i++) {
+            bool ambiguous = false;
+            Object *t = object_resolve_path_type(fw->targets[i],
+                                                 TYPE_PXB_CXL_DEV, &ambiguous);
+
+            if (t && !ambiguous && PXB_CXL_DEV(t) == pxb) {
+                *base = fw->base;
+                *size = fw->size;
+                *ntargets = fw->num_targets;
+                matches++;
+                break;
+            }
+        }
+    }
+    g_slist_free(list);
+    return matches;
+}
+
+/*
+ * Fix the bounds of the device's memory window once the topology has settled.
+ * Exactly one single-target CFMWS, with an assigned base and room for the HDM
+ * memory, is required; anything else is a misconfiguration the guest cannot
+ * recover from, so reject it rather than guess a window. QEMU presents this
+ * window base as the decoder base to the guest, so the guest works purely in
+ * GPA; the host physical placement stays with the kernel.
+ *
+ * Returns false and sets errp on a bad topology so the caller can either fail a
+ * hotplug device_add or abort a cold boot.
+ */
+static bool vfio_cxl_do_bind_fmws(VFIOPCIDevice *vdev, Error **errp)
+{
+    VFIOCXL *cxl = &vdev->cxl;
+    const char *name = vdev->vbasedev.name;
+    int nwindows = 0, ntargets = 0, matches;
+    hwaddr base = 0;
+    uint64_t size = 0, need;
+    PXBCXLDev *pxb;
+
+    pxb = vfio_cxl_find_pxb(vdev, errp);
+    if (!pxb) {
+        return false;
+    }
+    /*
+     * The pxb-cxl enters HDM passthrough only with a single root port and no
+     * emulated decoders, but cxl->passthrough is set by pxb_cxl_dev_reset(),
+     * which runs at the system reset after machine init done, so it is not
+     * readable from a machine-init-done notifier yet. Check the same topology
+     * the reset keys on; hdm_for_passthrough was already rejected at realize by
+     * vfio_cxl_check_topology().
+     */
+    if (pcie_count_ds_ports(PCI_HOST_BRIDGE(pxb->cxl_host_bridge)->bus) != 1) {
+        error_setg(errp,
+                   "vfio-cxl: %s: pxb-cxl not in HDM passthrough mode "
+                   "(use a single cxl-rp)", name);
+        return false;
+    }
+
+    /*
+     * A PCIe root-port link is point to point, but QEMU only warns when a
+     * second endpoint is cold-plugged at a nonzero slot below the port. Both
+     * endpoints would match the same single-target CFMWS and map their HDM
+     * memory at the same base, aliasing one over the other. Require exactly one
+     * endpoint below the root port.
+     */
+    {
+        PCIBus *ep_bus = pci_get_bus(&vdev->parent_obj);
+        int slot, fn, nendpoints = 0;
+
+        for (slot = 0; slot < PCI_SLOT_MAX; slot++) {
+            for (fn = 0; fn < PCI_FUNC_MAX; fn++) {
+                if (ep_bus->devices[PCI_DEVFN(slot, fn)]) {
+                    nendpoints++;
+                    break;
+                }
+            }
+        }
+        if (nendpoints != 1) {
+            error_setg(errp,
+                       "vfio-cxl: %s: %d devices below the cxl-rp; a passed "
+                       "through CXL endpoint must be alone below its root port",
+                       name, nendpoints);
+            return false;
+        }
+    }
+
+    matches = vfio_cxl_match_fmws(pxb, &base, &size, &nwindows, &ntargets);
+    if (matches == 1 && ntargets == 1) {
+        if (!base) {
+            error_setg(errp,
+                       "vfio-cxl: %s: matched CFMWS has no base; reduce its "
+                       "size or grow the guest PA space", name);
+            return false;
+        }
+        /*
+         * QEMU reads the endpoint's HDM size from the kernel region, so the
+         * window size is really device information, not a value to make the
+         * caller guess. Sizing the CFMWS from the device the way firmware does
+         * is not possible here: the window is placed in the guest PA map by
+         * cxl_fmws_set_memmap() before this device is realized, so its size is
+         * fixed before dpa_size is known. Until a core change can size the
+         * window from the device, take the device geometry as the source of
+         * truth: reject a window too small to hold the endpoint, and warn when
+         * it is larger than needed, since the padding becomes guest CEDT that
+         * migration has to preserve.
+         */
+        need = ROUND_UP(cxl->dpa_size, 256 * MiB);
+        if (size < need) {
+            error_setg(errp,
+                       "vfio-cxl: %s: CFMWS size 0x%" PRIx64 " cannot hold the "
+                       "endpoint; set the cxl-fmw size to 0x%" PRIx64,
+                       name, size, need);
+            return false;
+        }
+        if (size > need) {
+            warn_report("vfio-cxl: %s: CFMWS size 0x%" PRIx64 " exceeds the "
+                        "endpoint's 0x%" PRIx64 "; set the cxl-fmw size to 0x%"
+                        PRIx64 " to keep the guest memory map stable across "
+                        "migration", name, size, cxl->dpa_size, need);
+        }
+        cxl->fmws_base = base;
+        cxl->fmws_size = size;
+        return true;
+    }
+
+    if (matches == 1) {
+        error_setg(errp,
+                   "vfio-cxl: %s: its CFMWS interleaves %d targets; use a "
+                   "single-target window", name, ntargets);
+    } else if (matches > 1) {
+        error_setg(errp,
+                   "vfio-cxl: %s: pxb-cxl is targeted by %d CFMWS; use one",
+                   name, matches);
+    } else {
+        error_setg(errp,
+                   "vfio-cxl: %s: no CFMWS targets this device (%d present)",
+                   name, nwindows);
+    }
+    return false;
+}
+
+/*
+ * Cold-plug path: the CFMWS windows are placed at machine init done, so the
+ * binding can only be validated from this notifier. The VM has not run yet, so
+ * a configuration error is fatal to startup. A hotplugged device is validated
+ * in realize instead (see vfio_cxl_setup), where the failure fails device_add
+ * without taking down the running VM.
+ */
+static void vfio_cxl_bind_fmws(Notifier *n, void *data)
+{
+    VFIOCXL *cxl = container_of(n, VFIOCXL, machine_done);
+    VFIOPCIDevice *vdev = container_of(cxl, VFIOPCIDevice, cxl);
+    Error *err = NULL;
+
+    if (!vfio_cxl_do_bind_fmws(vdev, &err)) {
+        error_report_err(err);
+        exit(1);
+    }
+}
+
 /*
  * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
  * and the trapped HDM decoder block (which BAR carries it and at what offset).
@@ -3735,6 +3921,9 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
+    cxl->machine_done.notify = vfio_cxl_bind_fmws;
+    qemu_add_machine_init_done_notifier(&cxl->machine_done);
+
     cxl->enabled = true;
 
     return true;
@@ -3747,6 +3936,7 @@ static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
     if (!cxl->enabled) {
         return;
     }
+    qemu_remove_machine_init_done_notifier(&cxl->machine_done);
     if (cxl->mem_region.mem) {
         vfio_region_exit(&cxl->mem_region);
         vfio_region_finalize(&cxl->mem_region);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 06d15e807d..6f184520bf 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -135,6 +135,9 @@ typedef struct VFIOCXL {
     uint64_t hdm_offset;             /* block offset within the component BAR */
     uint64_t dpa_size;               /* size of the HDM memory region */
     VFIORegion mem_region;           /* HDM memory, mapped at committed GPA */
+    Notifier machine_done;           /* CFMWS validated at machine_done */
+    hwaddr fmws_base;                /* base of the memory window */
+    uint64_t fmws_size;              /* size of that window */
 } VFIOCXL;
 
 struct VFIOPCIDevice {
-- 
2.25.1


