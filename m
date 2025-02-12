Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3DCC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 05:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti5Yx-0002vG-9O; Wed, 12 Feb 2025 00:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1ti5Yu-0002uP-JM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:45:28 -0500
Received: from mail-mw2nam04on20629.outbound.protection.outlook.com
 ([2a01:111:f403:240a::629]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1ti5Ys-0006FP-0A
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:45:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=expzhBttVsQQIipceyT8eRlseZb4PQhSBVWm48EsGHQfUXMtjnYmCWT0n+8S75YHWbzmBJYin7Kdi89+QlMAwm2iZiEmmfCDeHdGx3UP4yVKVYew+Kea0dlGoGh34yLgMQ/YgBbn/AyGPJ7Zq2bH2f3HnhSsFgmhZPZwIxkCtM68LG6fRwspXOw4vWewR2r3iCY93uLvqBS7+OW19EjHX9FEoRdz0siNFNaRh7/CYnK9Wmx3ssXmy5LzLa/nuLJN4ljQN6mzEFmGAi4pT9S4Q8aJJTF5tGvjr6h8L70h7LeQoUiUvQxdCk5dS5C4d74RYwuBHM7euZxu6iooHzN19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RhJQDi7jleDDG60R0UjT0MrrWRl62cjGQy5TUJnGjY=;
 b=VdXTIcKiykEZM1/JDSFqer5kXFVLlOjkGeUt+vXXTBsIxwekrEdVtjsuT3W5hSBWVZK2XGuxkMN+akDRarn4/yS0NimqKTE3WPKT0p9Dy2raK1yYubUL3uUJLTIBe0wCpJB10jw4iVLFtuGe9aujTj4rmBBz3Mwz+JvAnMXCI31bn4VE7Pss7fDbdJIAaoxigiDjCjvTnSjy50lh9UqrhESZm9rvmRiqUELoHWzXnFYYrriGiQakmZT+RKkgFW7uxOTTR498tSpKSeURCcuPjC758JD3CTv0FKx7yYJG2180s5cSPR1hzSA8tFE2HsI+hk1kSAYYBx91lhyc4yO0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RhJQDi7jleDDG60R0UjT0MrrWRl62cjGQy5TUJnGjY=;
 b=01vtTi7XBNp12cIxA12RCJyP0w8E9tuZLa5P+lP9VEUjRUvd3tlasGmTM74Z1NM8E+NUbdLWuWUhMveebu+EeqJIw+icBsHTpD305lJdHxWuTfjxpM4l3DjRLlPawOtiE+9uezGUzH4FHRisMtYoZ1B7YjZM4rMlMDzoNkepQIE=
Received: from SA0PR11CA0182.namprd11.prod.outlook.com (2603:10b6:806:1bc::7)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Wed, 12 Feb 2025 05:45:16 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::a2) by SA0PR11CA0182.outlook.office365.com
 (2603:10b6:806:1bc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 05:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 05:45:16 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:45:11 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 1/2] hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu
 device to allow full control over the PCI device creation
Date: Wed, 12 Feb 2025 05:44:49 +0000
Message-ID: <20250212054450.578449-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
References: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c593410-ba34-408b-89e0-08dd4b286d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1hueGV1cGE2a1cxWFhOWXE5eTVzU2trMm43QWhwRCs2S2pKTllBbTYyME1k?=
 =?utf-8?B?OGJGdFZva0hVaVVkbWtzU2wzR0hJSE1jdnJNVnUvUXJQaTh6cENoandDWmpK?=
 =?utf-8?B?MG4vcDJhOTIwanNzQWRUam9Reno5QTVqZEt5S3I4WWEvNFd6MnBVaW1qMmxC?=
 =?utf-8?B?YjNVU3pOZERobU02SFdMV2FRdnlnTGx5Tnhhb3pKSmFEeWZ1Q3l1YUtHVUZz?=
 =?utf-8?B?aFJ1eTBLTU9lQjRWNzZoNmExZk1qcStZTWU1dzJWREtEUjhTdFZRZUkzdHd2?=
 =?utf-8?B?SUdKV0Z0SzdXbDd6TzVIZzRVb3dXVGVKQTZKR0RqQkNJNE1LekJ0UHJQVEox?=
 =?utf-8?B?ZzBXbW1FZ2pWa2U3bzdQdE0rVGF1dlUxR2YyMnNQeGxOdmkvaXBDa0lZOFV6?=
 =?utf-8?B?KzlGZkFHdGRDZ0JFekdESFNCYlFpVTNIZ05YTGJ2ZjNyajlkdFNkbitWSms5?=
 =?utf-8?B?enhTMFVDNnRYMTRvMmRvOGh1VlhZYnEvSUZRcVFJcnJWKzBEb2pKV0t1em9s?=
 =?utf-8?B?QitqRStadW5jb3R2TWI2cDRKdHFranZyMFRZUjZNK2JsbWRtcWR2Mk9JTUtY?=
 =?utf-8?B?ZHZsczUvN3AwWHZUMEZCL2VrNkdDZ3l5b29UZFB4TSs5TWJNb0VBQ2d1bkxQ?=
 =?utf-8?B?cDFwdFcraUI3OHBGaU9HSEZPZDI2Q3MxUlpKSW1GbmhES2VtOVEvUkVxY21G?=
 =?utf-8?B?UXBLK3RES2R3OFllYStJUGplZ05JZnJvTHBxV0tKbUVjajRQQlVwbXhQeTlv?=
 =?utf-8?B?RlFNUkMxS3RNdS9tR205a1FKVHZ3Z0xwanJNVUJ2dzlRR20xR2U4d1dMak9T?=
 =?utf-8?B?L2dodVdqV1dYRnRpUnppL3d5VkpsVEF5RzdCQ3N2TEZyRVg2NFBHZ3ZKK3Ra?=
 =?utf-8?B?M3BncGpjS2V6bG02K2w1QUFOUHMvVm9ONm5tZ3B5cFdiblhvWWM2Sk5LbTFD?=
 =?utf-8?B?RHdsQ2oxL21wYmJrSVR1eHNxa0swR0tlaUU4a2dwVFhiY3EyaDhFL3hxM3Mr?=
 =?utf-8?B?Wm9JNjYvdi81UE8rVmJjK21JWHBsOUpiQVhYdCtFSkd5b2xiemIwN2NzZlln?=
 =?utf-8?B?SHlpL0JxU001NzYwdmxSNDZpZmhzNDc3aTl3ZTRmRzhkMlBLbnJqcHA3enVC?=
 =?utf-8?B?ek9USVBkS3p4eVJUR2NUQ21menpmOVlVSUFwaXVTc1M0WndpRlZVVHRobHlw?=
 =?utf-8?B?Z1dHeThhT1FUdklJRWc1UmYwekdZV2I4TzN2K2VJa1NLWVp6LzRxZ2V2RUh4?=
 =?utf-8?B?Z0ZZWGhRMWFrakkwWm1jL2JsS0JWblRLak1PNisvUE9VdjBJTEYrV1FwVnhN?=
 =?utf-8?B?eDV1R0hqc0FPakdaRUpOekFLRXgxUGxvQStmbWRXa1p3bmNSSG4zM0pHL3JZ?=
 =?utf-8?B?dy9aWnhCcGhJbU0rVmticmxnNzFSRUlxcWl0Zi9DbDJZUlRlek10clBrQ3ZO?=
 =?utf-8?B?TDRDK3lzbkh0TTEwd0xHR0dqNFJzbWVOWEZjY3RtbHZFNFNlTS9JL2l1dlJw?=
 =?utf-8?B?WFA2bmdnT1MxUlRSemlTL05NdXhHSy9tQjRPOXBnWEV0Ynh4UzhGRFphQ0dP?=
 =?utf-8?B?dWROOUhOQW04eGJhd3ZjMDFwUjVjZkdSa0tLbytwZzlkUnlhWFk0QlVKVndG?=
 =?utf-8?B?eWtZZmhxSk8weDJQR0NYUXBZdHZ6YXJNRWtlY0FwVVNSMDVTejZDK04wbXNL?=
 =?utf-8?B?SU9Ia09aQ2RCQVkrWExHSTUrOExsb2FXbkpvSnpzNnJma2p1NnhIaEhiRXRB?=
 =?utf-8?B?MVpCSVliYkk2dk8vUm9hVVdBektVQkxYSFNocUtRbkt1OEVZdkRQdVVWcmYv?=
 =?utf-8?B?RnhZU29pSkxBL3lBVUVnQjRSc3NrWnBnMlNGK2szU1cySnZHQUUycWtDZDJS?=
 =?utf-8?B?MGhUT2FYU3VmdE9qQ2YxU1crdnlBVGxvTGJJeEZtVW5XSFpMczEwaEtva0VT?=
 =?utf-8?B?Z05GUWRHR0Z0Y282OUFPWlZLVDlEZmlXQlJtQ3RtSFIzZTJ3MnNSL3pKcDZL?=
 =?utf-8?Q?94juybHrQSQSXiFgaa3lAArgCLyFbI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:45:16.2236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c593410-ba34-408b-89e0-08dd4b286d6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
Received-SPF: permerror client-ip=2a01:111:f403:240a::629;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Current amd-iommu model internally creates an AMDVI-PCI device. Here is
a snippet from info qtree:

  bus: main-system-bus
    type System
    dev: amd-iommu, id ""
      xtsup = false
      pci-id = ""
      intremap = "on"
      device-iotlb = false
      pt = true
    ...
    dev: q35-pcihost, id ""
      MCFG = -1 (0xffffffffffffffff)
      pci-hole64-size = 34359738368 (32 GiB)
      below-4g-mem-size = 134217728 (128 MiB)
      above-4g-mem-size = 0 (0 B)
      smm-ranges = true
      x-pci-hole64-fix = true
      x-config-reg-migration-enabled = true
      bypass-iommu = false
      bus: pcie.0
        type PCIE
        dev: AMDVI-PCI, id ""
          addr = 01.0
          romfile = ""
          romsize = 4294967295 (0xffffffff)
          rombar = -1 (0xffffffffffffffff)
          multifunction = false
          x-pcie-lnksta-dllla = true
          x-pcie-extcap-init = true
          failover_pair_id = ""
          acpi-index = 0 (0x0)
          x-pcie-err-unc-mask = true
          x-pcie-ari-nextfn-1 = false
          x-max-bounce-buffer-size = 4096 (4 KiB)
          x-pcie-ext-tag = true
          busnr = 0 (0x0)
          class Class 0806, addr 00:01.0, pci id 1022:0000 (sub 1af4:1100)

This prohibits users from specifying the PCI topology for the amd-iommu device,
which becomes a problem when trying to support VM migration since it does not
guarantee the same enumeration of AMD IOMMU device.

Therfore, decouple the AMDVI-PCI from amd-iommu device and introduce pci-id
parameter to link between the two devices.

For example:
  -device AMDVI-PCI,id=iommupci0,bus=pcie.0,addr=0x05 \
  -device amd-iommu,intremap=on,pt=on,xtsup=on,pci-id=iommupci0 \

For backward-compatibility, internally create the AMDVI-PCI device if not
specified on the CLI.

Co-developed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/acpi-build.c |  8 +++----
 hw/i386/amd_iommu.c  | 53 +++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h  |  3 ++-
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 53b7306b43..e70eeaf577 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2333,10 +2333,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(&s->pci), "addr",
+                              object_property_get_int(OBJECT(s->pci), "addr",
                                                       &error_abort), 2);
     /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
+    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
     build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
@@ -2368,10 +2368,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(&s->pci), "addr",
+                              object_property_get_int(OBJECT(s->pci), "addr",
                                                       &error_abort), 2);
     /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
+    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
     build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6b13ce894b..0f552bafa0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -167,11 +167,11 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
 {
     MSIMessage msg = {};
     MemTxAttrs attrs = {
-        .requester_id = pci_requester_id(&s->pci.dev)
+        .requester_id = pci_requester_id(&s->pci->dev)
     };
 
-    if (msi_enabled(&s->pci.dev)) {
-        msg = msi_get_message(&s->pci.dev, 0);
+    if (msi_enabled(&s->pci->dev)) {
+        msg = msi_get_message(&s->pci->dev, 0);
         address_space_stl_le(&address_space_memory, msg.address, msg.data,
                              attrs, NULL);
     }
@@ -239,7 +239,7 @@ static void amdvi_page_fault(AMDVIState *s, uint16_t devid,
     info |= AMDVI_EVENT_IOPF_I | AMDVI_EVENT_IOPF;
     amdvi_encode_event(evt, devid, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /*
@@ -256,7 +256,7 @@ static void amdvi_log_devtab_error(AMDVIState *s, uint16_t devid,
 
     amdvi_encode_event(evt, devid, devtab, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /* log an event trying to access command buffer
@@ -269,7 +269,7 @@ static void amdvi_log_command_error(AMDVIState *s, hwaddr addr)
 
     amdvi_encode_event(evt, 0, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /* log an illegal command event
@@ -310,7 +310,7 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
     info |= AMDVI_EVENT_PAGE_TAB_HW_ERROR;
     amdvi_encode_event(evt, devid, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
              PCI_STATUS_SIG_TARGET_ABORT);
 }
 
@@ -1607,26 +1607,45 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 {
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
 
-    msi_reset(&s->pci.dev);
+    msi_reset(&s->pci->dev);
     amdvi_init(s);
 }
 
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 {
+    DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
     X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *bus = pcms->pcibus;
 
-    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
-                                     amdvi_uint64_equal, g_free, g_free);
+    if (s->pci_id) {
+        PCIDevice *pdev = NULL;
+        int ret = pci_qdev_find_device(s->pci_id, &pdev);
 
-    /* This device should take care of IOMMU PCI properties */
-    if (!qdev_realize(DEVICE(&s->pci), &bus->qbus, errp)) {
-        return;
+        if (ret) {
+            error_report("Cannot find PCI device '%s'", s->pci_id);
+            return;
+        }
+
+        if (!object_dynamic_cast(OBJECT(pdev), TYPE_AMD_IOMMU_PCI)) {
+            error_report("Device '%s' must be an AMDVI-PCI device type", s->pci_id);
+            return;
+        }
+
+        s->pci = AMD_IOMMU_PCI(pdev);
+    } else {
+        s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
+        /* This device should take care of IOMMU PCI properties */
+        if (!qdev_realize(DEVICE(s->pci), &bus->qbus, errp)) {
+            return;
+        }
     }
 
+    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
+                                     amdvi_uint64_equal, g_free, g_free);
+
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
 
@@ -1663,6 +1682,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 
 static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
+    DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
@@ -1670,12 +1690,6 @@ static const VMStateDescription vmstate_amdvi_sysbus = {
     .unmigratable = 1
 };
 
-static void amdvi_sysbus_instance_init(Object *klass)
-{
-    AMDVIState *s = AMD_IOMMU_DEVICE(klass);
-
-    object_initialize(&s->pci, sizeof(s->pci), TYPE_AMD_IOMMU_PCI);
-}
 
 static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
 {
@@ -1698,7 +1712,6 @@ static const TypeInfo amdvi_sysbus = {
     .name = TYPE_AMD_IOMMU_DEVICE,
     .parent = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(AMDVIState),
-    .instance_init = amdvi_sysbus_instance_init,
     .class_init = amdvi_sysbus_class_init
 };
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e0dac4d9a9..ece71ff0b6 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -315,7 +315,8 @@ struct AMDVIPCIState {
 
 struct AMDVIState {
     X86IOMMUState iommu;        /* IOMMU bus device             */
-    AMDVIPCIState pci;          /* IOMMU PCI device             */
+    AMDVIPCIState *pci;         /* IOMMU PCI device             */
+    char *pci_id;               /* ID of AMDVI-PCI device, if user created */
 
     uint32_t version;
 
-- 
2.34.1


