Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5EBE87843
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIX2-0003fD-56; Tue, 03 Feb 2026 10:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIX0-0003er-Io
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:41:34 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIWy-0007Le-IT
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:41:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8kCgaq51AuEAA61bW3eDN119fJyCZ7wM808JEZXi4VDWlmV5BqG9yN0Vamr/KWfDIFi4+CvieBlsKHTSpNn3RCenei+HSyj7X9oYn2BlVF+KrkVUjH/GwzuH62avNsJr6sQACyQqTBwG6jRdsy2r62+33fGmm8E377dKWe1TAYlCgKCWYjdsQs+uZu8boSgKqwDuz+VSIa5qDyq9aiWVdm9m5OVdKaV5+piAMugcSg8YdtHGkNSBUlF6qhfISEg3HaUsuFRm9XsjoFmsMnM/N1Q4Q54+gJCW9Tx9JW4iuseOCpxCLv/FvPOnQzZa3IDkTxK14+Yl8pzdn+QrbbHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK0uj5uL5hCVEIoa/i282agID3NaS0NERB4FS9Oh6gw=;
 b=RHoGOVOobsoChkTq53eQuM5eSsuVl5QuiIM9v9gbDhiZXVLwHj4iwykjL1B/Q3fJC/XfZA9tyqsk7LWHitB3Uue0QZAuRj47EZ0zRYbbFD9ZiknatkL5WmPfzDb2BA3hekvNI5dTt8ZRXQxrXQsDqUdwxl9UMEUouuEDYjszMDfMIPIM4mHH3fNluQDZhGjgpgZWRtdFv0jaXXZLkdy4qnN6cRYywhykgp/5m8EygvKQEImzQlycx/RulfGCqyjDKfxlIiAKMlWnHdLJZdttrdtSWi/mrTEV7Xq4kvD6/HmgzbET5Hs8rxK8FU4HYC9RZm9mlx/pDcC0fXbT8tFttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK0uj5uL5hCVEIoa/i282agID3NaS0NERB4FS9Oh6gw=;
 b=FTqPr9J5OaTvBgRiTQ0iAFIwoRSe1EQRaxytFR6NxZeqVxVEsO+Opa4gyz/0RgKpipCI6LH4Vyag2tJw7IDRSOtKVIPS8LNN+aZXXCd4rim/4+lp6ww+yA4kfnRR4cdqw3Chux95XsltMCgCW2H0VjJf57MnnFszcOrz/T/K88E=
Received: from DS7PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:3b8::10)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:41:25 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:3b8:cafe::ec) by DS7PR03CA0005.outlook.office365.com
 (2603:10b6:5:3b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 15:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 15:41:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 09:41:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 09:41:24 -0600
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:41:22 -0800
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <Nikola.Prica@amd.com>,
 <Dejan.Andjelkovic@amd.com>, Manojlo Pekovic <mpekovic@amd.com>
Subject: [PATCH 2/2] vfio/pci: Support multifunction atomic ops capability
Date: Tue, 3 Feb 2026 16:41:12 +0100
Message-ID: <20260203154112.1668-3-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260203154112.1668-1-manojlo.pekovic@amd.com>
References: <20260203154112.1668-1-manojlo.pekovic@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: manojlo.pekovic@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: a31c28a7-8ed6-436e-8641-08de633ab02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LVo3dAgQ1Q5HibUKWHl6j56MZblAilMCMDP3WPh8x+g1WC3xGm363T+aNVfi?=
 =?us-ascii?Q?gfHkPxeWIn+yn5sRRZNXy8bxq9Whmns7AWOKUeuezt5t3qBr8GlXvXZ0JLoM?=
 =?us-ascii?Q?/Y9B6yxws/2LSmWZgzf9WZFb0vcJCmZhaslQygOBE2QC4R7n2/66D4Ho/CvO?=
 =?us-ascii?Q?AcscJbeP6a/5nywSNE7DNn0mr4pHL2td867rbHY8XHF5ucsnRTq08CCHaJAo?=
 =?us-ascii?Q?WMnVXhi4gDOp6tBZsfickI2P3zNdenyL5rp2ixQPGeTl9ANJK2oq3bJBkcmI?=
 =?us-ascii?Q?/Vmtqp+GOx8A1qFX102fRbjVZmi6++3ThDOTvGX2D8GtGH075sSNCAGC+5Zz?=
 =?us-ascii?Q?VkbquxeV+rOl0WVMHyRTvk3orw+wE0TpM+KKlHsTKE+hWxPmfZflo3Dughup?=
 =?us-ascii?Q?2iL1RbUdoJ6RxMBvdrilo7gQjpkFm0vsy4eOtC573a8FII1i4iregpVjMUHi?=
 =?us-ascii?Q?jQ3aXC2PGnvp8b9ag8jChLjJOrc82rIS7ZX6fRdH6UGBVsbQSGUCYlIwZyyr?=
 =?us-ascii?Q?UzNGO0AMibaSkw6qeKzHHyKGJxEJ4fw4Z0Lbr9BJ1+1RN3T+bsFaAOzYdA3U?=
 =?us-ascii?Q?4ZaduzoLAj/Lyhs6/tCYKY32xt+Tqbo23vUBc+UpC879UB4ZK5vln1WE61ZS?=
 =?us-ascii?Q?vabMyIcWFaM26JZ/3IN0IAXbuWeHWh/xJGI/CvmFnbhEuZcJW6VuaX++MQpr?=
 =?us-ascii?Q?YhcovFYm6cZnrLvpXZhpp2OriUvMrS1T3sSbSJvQWq8LoWT4/dS80tr8zBO0?=
 =?us-ascii?Q?KVtDfC/IZpMx+ibc7XQPu4hrwSizxU5H0jnUchCjWVv2V6QzWEnGq1fS328L?=
 =?us-ascii?Q?hdgKYZTc3HW9U/C7Cdr/mVicuLej3/t8DjHwfkcEEDz96Kc9W/khSbIIOen2?=
 =?us-ascii?Q?w3VNmSoySyZH1iZGI1Os8+D6DngwzvbjiZL/hyD1QnJ9q4fWcxytLkJIRi0u?=
 =?us-ascii?Q?msztGuqkkMGp6hsXr31Ux+ixY+XW5Kmzl4PJd9Ea9BhcThzO56sWtMaIPqzH?=
 =?us-ascii?Q?aeynlVeHDRZlGWYl53N1uavFBqa9zcKW1vOJzhXC4PYtUOwPbO5b88Jgux+C?=
 =?us-ascii?Q?QDyJADcIamZZaHyZPQmcdWgMZMAqR7ogAabBdmARNW5OoBXc8aFZu3pmK+2l?=
 =?us-ascii?Q?4ptiHNp6Ro33ibQZEOHAAal5whhL+wgrzFuSvPAV0ZjHGrPgostMju92DOUm?=
 =?us-ascii?Q?RRzFQKsqpEP/uuK8MSig/N5frmXUnKewkYQszhff2Gzzfuw9bQ+uttuabgh+?=
 =?us-ascii?Q?56Bvp9SgQTBuHA+jE2qxh1K5zr08VEvrOEZGZOCbSzLJyF0zvuAJsGKd1fpe?=
 =?us-ascii?Q?605IhPLCfPbMmyYPr4tYRNyR9gsUg6nlROWDO+VCnr9MicUMzPBgxdHWbQyv?=
 =?us-ascii?Q?5ciYBaSPSP2Ez2Wn91g9TxlOFbrRWAo+GvbHi7IoGmPK7j5i4Xn/eMBrVyvR?=
 =?us-ascii?Q?0jtlT1kyMilc06OC90eczVznRZCINBm2VWn7wbIkaAZIkyBIJyBot37uviIa?=
 =?us-ascii?Q?UFznVYH3KCRfE6Uyxf2HyevHXKagbW02zGJFwa+lRRJiVxkt7tqEnfXmbe/l?=
 =?us-ascii?Q?vnhOfbVhRdThtspgFwOMdIVVR5efHrYiWNww2HL5TVTXXdswFi3n/xd6WxFJ?=
 =?us-ascii?Q?gZGeeLusZlePoHEv4q3UonS8abnwIDAcCNHwcKzym3WPPdx4g+CTrVoRDOSm?=
 =?us-ascii?Q?AD2AKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f6/x8OBcKsfDg7IoWdGAh+z1Tv51fqgM95/XRAZrz9YONyysmjcyEXSSMc0vNdOYoSk3L2X840HRH/J1KZwokLq+dfxpuIyhEsrVfdjAo8fj/DyK5iQGH1CfV8GuUw8ifTrdPgI4AvRSjwmUeZ5lwZAL3xwm9FFpntz0pZpaxMiG82JLAj5kXT7UOg/jcXkN/YeDbULRBPKHQyzMSYAbseFQA+5l8nGLAG8bnGUA+rVkP4tSgdyOGKr5zE5rM7AiT3Rye7l0c36kcW6heTya2MFwdOoGVsC2zVNf4+XPxrjcW/7UkjpNCDPia/PHWwDhk4Hn62u5TOgdTg7WYzsEslk158VrrStKh3NJOREczxalAQVqErqknRdgakoe2n2pkVf7nF7wkfe3EwhsTEqY+3hhsMm1szs9pHunbou3Nvk2h5/0gSuR43D8O8szg+CI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:41:24.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31c28a7-8ed6-436e-8641-08de633ab02c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Manojlo Pekovic <mpekovic@amd.com>

Extend PCIe Atomic Ops completer support to multifunction vfio-pci
devices by calculating the common subset of atomic capabilities across
all functions.

For multifunction devices, we now:
1. Calculate the intersection of atomic capabilities across all functions
2. Only enable capabilities that ALL functions with atomic support share
3. Functions without atomic support are skipped (not penalized)

During vfio_realize(), other functions in a multifunction device may not
be realized yet, making it impossible to enumerate all functions. We
defer atomic ops configuration to machine_done time for multifunction
devices, ensuring all functions are realized before calculating common
capabilities.

Signed-off-by: Manojlo Pekovic <mpekovic@amd.com>
---
 hw/vfio/pci.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.h |   1 +
 2 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6a6c8f1807..89f171f431 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1931,6 +1931,67 @@ static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
     return mask;
 }
 
+static void vfio_pci_machine_done(Notifier *notifier, void *data);
+
+/*
+ * This function iterates through all possible functions (0-7)
+ * at the same slot and returns the intersection of their capabilities.
+ *
+ * Returns: Bitmask of atomic capabilities supported by functions on slot
+ *          (PCI_EXP_DEVCAP2_ATOMIC_COMP32/64/128), or 0 if:
+ *          - Mixed device types found (vfio-pci + emulated)
+ *          - No common capabilities exist
+ */
+static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice *vdev,
+                                                    PCIBus *bus)
+{
+    PCIDevice *func_dev;
+    VFIOPCIDevice *func_vdev;
+    int slot = PCI_SLOT(vdev->pdev.devfn);
+    int target_devfn;
+    uint32_t func_cap;
+    uint32_t common_mask = PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+
+    /* Iterate through all possible functions at this slot */
+    for (int fn = 0; fn < PCI_FUNC_MAX; fn++) {
+        target_devfn = PCI_DEVFN(slot, fn);
+        func_dev = pci_find_device(bus, pci_bus_num(bus), target_devfn);
+
+        if (!func_dev) {
+            continue;
+        }
+
+        /*
+         * We can only calculate atomic caps for vfio-pci devices. If we
+         * encounter a mixed multifunction device (e.g., vfio-pci function 0
+         * + emulated e1000 function 1), we cannot safely determine the atomic
+         * capabilities. Taking the conservative approach: disable all atomic
+         * ops for mixed configurations.
+         */
+
+        func_vdev = (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_dev),
+                                                        TYPE_VFIO_PCI);
+        if (!func_vdev) {
+            return 0;
+        }
+
+        /*
+         * A function with no atomic completer support simply cannot
+         * receive and execute atomic operations.
+         * This does NOT mean other functions in the same multifunction
+         * device should be prevented from supporting atomics.
+         */
+        func_cap = vfio_get_atomic_cap(func_vdev);
+        if (func_cap != 0) {
+            common_mask &= func_cap;
+        }
+    }
+
+    return common_mask;
+}
+
 static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
 {
     PCIBus *bus = pci_get_bus(&vdev->pdev);
@@ -1948,8 +2009,7 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
         pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
         pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
-        vdev->pdev.devfn ||
-        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        vdev->pdev.devfn) {
         return;
     }
 
@@ -1962,6 +2022,25 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
         return;
     }
 
+    /*
+     * Single-function: All device info is available now, configure immediately
+     * Multifunction: Other functions may not be realized yet, defer to
+     *                machine_done time when all devices guaranteed to exist
+     */
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Register machine_done notifier if not already registered.
+         * The notifier will be called after all devices are realized, at which
+         * point we can safely enumerate all functions and calculate the common
+         * atomic capabilities.
+         */
+        if (!vdev->machine_done.notify) {
+            vdev->machine_done.notify = vfio_pci_machine_done;
+            qemu_add_machine_init_done_notifier(&vdev->machine_done);
+        }
+        return;  /* Actual work deferred to vfio_pci_machine_done() */
+    }
+
     mask = vfio_get_atomic_cap(vdev);
 
     if (!mask) {
@@ -1972,6 +2051,51 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     vdev->clear_parent_atomics_on_exit = true;
 }
 
+/*
+ * Called at machine_done time, after ALL devices are realized
+ * but before the VM starts running.
+ *
+ * For multifunction devices, we need to calculate atomic capabilities
+ * across all functions. During realize of function 0, the other functions
+ * (1-7) may not exist yet. By deferring to machine_done time, we ensure
+ * all functions are realized and can be safely enumerated.
+ */
+static void vfio_pci_machine_done(Notifier *notifier, void *data)
+{
+    VFIOPCIDevice *vdev = container_of(notifier, VFIOPCIDevice, machine_done);
+    PCIBus *bus = pci_get_bus(&vdev->pdev);
+    PCIDevice *parent = pci_bridge_get_device(bus);
+    uint32_t mask;
+    uint8_t *pos;
+
+    /*
+     * Sanity checks: Should always pass since vfio_pci_enable_rp_atomics()
+     * already validated these conditions before registering this notifier.
+     */
+    if (!parent || !parent->exp.exp_cap) {
+        return;
+    }
+
+    pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
+
+    /* Abort if there'a already an Atomic Ops configuration on the root port */
+
+    if (pci_get_long(pos) & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                             PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                             PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
+        return;
+    }
+
+    mask = vfio_get_multifunction_atomic_cap(vdev, bus);
+
+    if (!mask) {
+        return;
+    }
+
+    pci_long_test_and_set_mask(pos, mask);
+    vdev->clear_parent_atomics_on_exit = true;
+}
+
 static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
 {
     if (vdev->clear_parent_atomics_on_exit) {
@@ -3281,6 +3405,16 @@ static void vfio_exitfn(PCIDevice *pdev)
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    /*
+     * Remove machine_done notifier if it was registered.
+     * This happens for multifunction devices where function 0 registered
+     * a notifier to defer atomic ops configuration to machine_done time.
+     */
+    if (vdev->machine_done.notify) {
+        qemu_remove_machine_init_done_notifier(&vdev->machine_done);
+        vdev->machine_done.notify = NULL;
+    }
+
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ad090a229..9182ab0053 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -180,6 +180,7 @@ struct VFIOPCIDevice {
     bool skip_vsc_check;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
+    Notifier machine_done;
 };
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
-- 
2.43.0


