Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57902606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=juYNF36W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTcJe-0000lL-Th; Wed, 18 Nov 2026 04:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXvB-0000W5-1A
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:09:25 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXv8-0002P4-Qt
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:09:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwi+zKTtgDwoP89ttkkOgaBftRtPP+oREdGiUkUvAbdXyNQt/bhRNHCQ5A0ssEcXKnOU4qd8o3+GbBKHDHt409exb/n0H8nENM1Iy0/kUDKAiNH4zgKCUErdvnYtNNdfq1UTFHELty336ghTnY2+oDIsdVXoWspe9MvjxdjkxnIEreWXS0Nkjbp4+HbuUDgCiQj9mPfkTNY2bZXAbSGo5Yd4DmL4PxGSqTmAPEabw2JEFUIr3PdU6BCSnlR0npZw2pq25gCxMUmbCc6C8bz6FQnrEL2wo9bOFUJ4Xu2QWeN5BuWk5c4Oe0JPN4KoVH4180cUT+hYCXJzovafI3gl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2qqx5RzpYNhkW5OftBeQwXJyLjGp7FhkbV1wqGsMzY=;
 b=NYI7eAXdfXb5mMEfCymqItQudGXVGMbKqORgmqOOxMZmAvlFKp89h8gKc2A1bi/D+9CHcQLi8gnF/hXrWf2H2D7MpDanpjUUSqXvIoHm7VfHzZPyD9hPybzLmeLrJcJRLTKIr7cbDRH0B/0taHLa/97vYFVxWR8WkfBxyQ424QJBwf4+MDSw0mnWLfMTwbvvEhMMGKbHNhBHdyVks7By8q7kEqX4NmokuMMsiG4G4aBl3X0rCpQqBXfymbIb2nlf8qpDhtWCVeXw9q7PVQpZOckeEBd5jEqbZRkaFVMuFJ3tz46pi8MxFTVLLIOPi/nPu8EEWgQRFW2K0d/RZBrPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2qqx5RzpYNhkW5OftBeQwXJyLjGp7FhkbV1wqGsMzY=;
 b=juYNF36WstDUlLY2pI2/eJcsdosGYE3lChtYTlyOfre1CRYJY5P8xJPq+G6/8yzfGlki73Sfm3oJPFlxVsqWDy3ILwALqf/+eo8JTj4WV2HLs11KLpMNyqmRE7wOiA9GgZfMu9SY2C8ZUEcdcZ3pv0vCh5j4I5QOzyv5Ify53A4=
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:09:15 +0000
Received: from PH7PEPF00000008.namprd04.prod.outlook.com
 (2603:10b6:303:b8:cafe::5f) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 05:09:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000008.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:09:15 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:09:11 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>, <sarunkod@amd.com>
CC: <richard.henderson@linaro.org>, <mst@redhat.com>, <farosas@suse.de>,
 <lvivier@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 2/4] hw/i386: amd-iommu: add FCH stub at 00:14.0
Date: Wed, 18 Nov 2026 05:08:29 +0000
Message-ID: <e016b5eb6e1de48746fbd34efdbbfcf871517a39.1794484966.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794484966.git.Ankit.Soni@amd.com>
References: <cover.1794484966.git.Ankit.Soni@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000008:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f7a032-5fb8-488f-730f-08df45321752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|22082099003|18002099003|261009223027099003|13003099007|11063799006|56012099006|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261021121427099003|261026121527099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: g5UiZuWmwbDpuy72exBnOE8U2SzbuycCMDvT4iGcBY3bHLFS+GsasgF+EnvVRYvDz3VZyegbG9FJu2vVJ+X5A6ccKjMAbPn2kD41ag7OfqFrgql5icyrbvIDcSsSgLmaLqSS/p//Z4yIiQMZz9YRnIt3AHiaowuTEkalf4//0ENzIcACmpJ6a9cFFczm/7k0UmU7vian745mwcBL2BzyNPp4ep4pfdArQsVW+hfNdYegurA6xEnXtVNMQl8pg+qFYpf7M3hJl0+7IaJOSmkxoW2yKBCzX9lerA0w9gaMAaJuXAuxTza6Y7WuFcl3sEoL8jaJ9FXaCQhH2SHInDGl1WxAw0Nn4TSaZ6IhnfygCN1dsyzsKEOiQrhyEbJ8mUDpalGpBwtd6vb0wt2l5FuYSTU8/yIJRKKKsvUV4aBwyhNlg5hTI+I3z7LlgrgbKRTofJLWBG+vRA/KLoT/4Z/fHHtg1ypAZtM8YQJhkFgwNb1MjQ2ZUL4/QLYMEcYRgwOZ81NvC9TJePbtaPV86F50qUCn4OBoGa2lyZnoRFX5MtrdGtzHYUPhs6L7A85cdob8XTX0z9B3m+wRQ4c4eeDbU6LMgVJEL094xMPNR9SMbbJCpEBeUVd3mxT1BAWnFMw/EE8dFBnV9LbzqCPY9H0dQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F5QmO5lR5utwK+PPQ+Lb+iJpEEKi0JVfHRpfYel0+QQJclbjvhv3AQfmab6KrMTX3nlyw4CQgQG4rHTB4sCvYWCWg6X9qKOz9TqJnJigBwMF+DBQUKSw/reER/QoBQm2RA1HY+ICxOf1Fp5TiVEixSQatMyoj23RrLqs7JyXoA0qbWVTyFLZTOMEGaAl3dEgjbDJzhXbwVvWL3CG52HMWBPudN3XcXp/8JPIVZklILz83rLkhX+11wX6To7ScUzIOiCUMG8qASUCmkMO/2IOPba8o4ffCp+sf79lUrjnakGuEtf2dab9B+j5B/uMkgElxLN2MM/LdfpaYzAISitjvAkvxLG9uTwEs6KNYSD+uAO/gj832qFYfMlihUi+Ouqalca2jo9O4di2O/xqDqkznSy1JR4BK3u2Tq4rOGTRqQzIT306N6ROdaiZQ2igR07/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:09:15.1059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f7a032-5fb8-488f-730f-08df45321752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000008.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=Ankit.Soni@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Nov 2026 04:50:53 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU IVRS type 0x48 names 00:14.0 as the southbridge IOAPIC SID.
q35 puts the ICH9 southbridge at 00:1f.x, and the PCI class at
00:14.0 is empty.

The Linux driver takes the SID from IVRS and reads PCI class at
that address [1]. SMBus or ISA bridge there means a valid FCH.
Any other class, including an empty slot (0xffff), fails.
QEMU leaves that SID empty, so the guest fails the check and
interrupt remapping stays off. Linux does that because a wrong
SID with remapping left on panics the timer at boot [2].

When amd-iommu is realized, create an SMBus-class PCI stub at
00:14.0 with no BARs. Use vendor/device 1022:790b, the FCH SMBus
at 00:14.0 on AMD hardware. Do that before AMDVI-PCI auto-assign.
If 00:14.0 is already occupied, realize fails.

Leave ICH9 at 00:1f.x. q35 still needs it for ISA, ACPI, and
GSI. Replacing it with an FCH would be a new machine type.

[1] https://git.kernel.org/linus/16f52863b2ec
    ("iommu/amd: Dynamically verify Southbridge IOAPIC via PCI
    config space")
[2] https://git.kernel.org/linus/c2ff5cf5294b
    ("iommu/amd: Work around wrong IOAPIC device-id in IVRS
    table")

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2d5c7b5cdf6b..d0787a13d335 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2725,6 +2725,22 @@ out:
     return bus;
 }
 
+/*
+ * IVRS names 00:14.0 as the southbridge IOAPIC SID. That is an FCH
+ * function on AMD. q35 still has ICH9 LPC/SMBus at 00:1f.x for ISA
+ * and ACPI.
+ *
+ * Guest software treats this SID as the southbridge IOAPIC only when
+ * PCI class is SMBus or ISA bridge. Put an SMBus-class stub here with
+ * AMD FCH SMBus ids and no BARs.
+ */
+static bool amdvi_realize_fch_stub(PCIBus *bus, Error **errp)
+{
+    PCIDevice *stub = pci_new(PCI_DEVFN(0x14, 0), TYPE_AMDVI_FCH_STUB);
+
+    return pci_realize_and_unref(stub, bus, errp);
+}
+
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 {
     DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
@@ -2734,6 +2750,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *iommu_bus;
 
+    /*
+     * Claim 00:14.0 before AMDVI-PCI is realized. That PCI function
+     * is auto-assigned; fixed DEVFN devices, then auto-assign.
+     */
+    if (!amdvi_realize_fch_stub(pcms->pcibus, errp)) {
+        return;
+    }
+
     if (s->pci_id) {
         PCIDevice *pdev = NULL;
         int ret = pci_qdev_find_device(s->pci_id, &pdev);
@@ -2876,6 +2900,33 @@ static const TypeInfo amdvi_pci = {
     },
 };
 
+static void amdvi_fch_stub_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->vendor_id = PCI_VENDOR_ID_AMD;
+    k->device_id = 0x790b; /* FCH SMBus at 00:14.0 */
+    k->class_id = PCI_CLASS_SERIAL_SMBUS;
+    k->revision = 0;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "AMD FCH identity stub at 00:14.0";
+    dc->user_creatable = false;
+    dc->vmsd = &vmstate_pci_device;
+}
+
+static const TypeInfo amdvi_fch_stub = {
+    .name = TYPE_AMDVI_FCH_STUB,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIDevice),
+    .class_init = amdvi_fch_stub_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
 static void amdvi_iommu_memory_region_class_init(ObjectClass *klass,
                                                  const void *data)
 {
@@ -2895,6 +2946,7 @@ static const TypeInfo amdvi_iommu_memory_region_info = {
 static void amdvi_register_types(void)
 {
     type_register_static(&amdvi_pci);
+    type_register_static(&amdvi_fch_stub);
     type_register_static(&amdvi_sysbus);
     type_register_static(&amdvi_iommu_memory_region_info);
 }
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 948d8611b154..871a4c4aca6d 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -312,6 +312,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 #define TYPE_AMD_IOMMU_PCI "AMDVI-PCI"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIPCIState, AMD_IOMMU_PCI)
 
+#define TYPE_AMDVI_FCH_STUB "amdvi-fch-stub"
+
 #define TYPE_AMD_IOMMU_MEMORY_REGION "amd-iommu-iommu-memory-region"
 
 typedef struct AMDVIAddressSpace AMDVIAddressSpace;
-- 
2.43.0


