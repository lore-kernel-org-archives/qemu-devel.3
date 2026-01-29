Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BD3D358F7
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 10:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPGy-0002wE-Fo; Thu, 29 Jan 2026 05:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vlPGu-0002vh-Df
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:29:08 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vlPGr-0000cl-FA
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:29:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIyiRvOtRlwjyJmXXTgh2nhjRFO47QfRKIJBKbuA5wA6pVsYHKj/AmBJ59aAgWmi7/221B7Q8paBMmR4my1tLNdwxX/ZrboRzt79Q1VnQrdt8PHgV9mhPQfRyiK/dL9K1iAQfIJvapB0eHFbQ6EaVgo3Y8SOc/2JhWIXqVjTP1eCGCPC/PcCUTltaa0Di/zY3/V9JBeM/ThrVj+/9THu6LDNurpcRgDkAa2WVUilxe0GLRMPMPB2AOLW3fXi8mnp8vRyDiV2zIet2kkOMUnQTq1uyePsu4YOWoomcoUtLMDJLjCegOuEhpC0a9fnJ4VUsIdF8KWZaqW7bxE7/0ICJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoItmWmZ+WtBN1W1XXZXnEkKeDyXEybGW5HPOL09QWg=;
 b=JYX0igf5cMwFXbPizxeK0OgzUy4JoC76w2NKn1kBW+MdNg/COjD2VQW/7MFsdA68c6nzGhI8Q4NikeAssPawEoa83KlJ5yzA1hNXgvbPniQTeQQ5jjrxMUROVYjke4Jmvv0YIQjyekjqhQ7Wd6an2ncm03IYk20zTOG63pmI9qCQN70gBbuqYuqcL2VuFyOxRWF+lRzxY/c7/GexQ3TwPZUsVaW9SuzNqXZypXmIqaW9Jdj8HHEAYxYxEInt4yphmIFomRGPhmmzEiJ/VFzD/EiiFNtfkuVnYmFKVPaAgKPwyRUnhHdhk6jpsDgLA6jmvkWHuaRcyS6KTQJcathFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoItmWmZ+WtBN1W1XXZXnEkKeDyXEybGW5HPOL09QWg=;
 b=ihXL9iWthKTcVF7b6XaQQ7qnDVjuecVObMeOV6pR4rFvcVQja+NuEttWuyOsXv4pypHKwxL/fllF43FZr3mnePc7/lnsSW6G4uXNrn/kWbVDdk6vIqN0HW+TzC/JGxBAQzEM0lj0YHbsObVFTbMMSKin1mzH9ECgHaSuzpVBHsg=
Received: from PH7P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::34)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:28:58 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::87) by PH7P223CA0003.outlook.office365.com
 (2603:10b6:510:338::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 10:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:28:57 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 04:28:54 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v2 1/3] amd_iommu: Use switch case to determine mmio register
 name
Date: Thu, 29 Jan 2026 15:58:12 +0530
Message-ID: <20260129102814.4488-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129102814.4488-1-sarunkod@amd.com>
References: <20260129102814.4488-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e8d7bb-3c7c-40be-8e58-08de5f2135da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3p4UWZh6OMgyhlsMXlgpxBnNEte0InsoB0iIEWEfOs1f3G+aEPtSLEVf64yS?=
 =?us-ascii?Q?SUfV6DwIVSmq9qfGw1ctymJONZ8tyljjHfD4G3dxgqgYNHvQ/65at54bJXET?=
 =?us-ascii?Q?dwpj+vSqEIshRc9ENtQrHAlgo+AHNQdMH1nb+vnlRhJICAe0b7hehUCnz8/Q?=
 =?us-ascii?Q?8+5HLAsQJo/02f9iAwX/VlyFuHIW9AEMvOiK72R4+nUtecxbA8auhGRvI4d1?=
 =?us-ascii?Q?U+0jjFl0t+0o+U2JnFl1u3MsYewHUZJDKLR18VEjsfT794vD1gsQVRKkaC24?=
 =?us-ascii?Q?jIqUc2gT266p3Gw/uGCYUTKN4LEqtENNNlFPE8HIh+xpimwof8nr4HKRrSS/?=
 =?us-ascii?Q?L/NnDZJNBInFnQczNSULKDg8WNSOxUA3bEmM+4Jm0Cgq13QQCxKoqlJyqCti?=
 =?us-ascii?Q?qgLfb4eR98nzNx/x/l6eypSwems4VoeSGuU1t3cSPtx2xk5vHK10KvBew8W1?=
 =?us-ascii?Q?Pno/zFV0XJCGcoDPbiyLopYc6MOtCL9TPSL/JHKmcRt4RHMVHuNca3C0Y84k?=
 =?us-ascii?Q?R7U2E/TiNYeWS+klACR1kWlRkLCZhDvBM3+mjI5r10O44GfvkT8rnBPxWl4Z?=
 =?us-ascii?Q?8cPIhjlnlJNo3Mls2XgQ1cCNlklWnKv3Bs6hYVEFz7cqfInmvcJepMkhIQmL?=
 =?us-ascii?Q?NDk7OVKTTwr6t5Xto+cF0uYNY2TBhJxkVJogyAogUFGk3k0dXnDbrU9haXAp?=
 =?us-ascii?Q?UkAjc3ygnGCgRzL1UJQI9JY8jBDlTjDBb0Rxeow0IL3KCQI/wVnpg4MA927v?=
 =?us-ascii?Q?1rCsRSQ4jy2nMoCjdo8m1P1le3po59Uo+hGRv38OuATt4R28B2KF+URMH3T4?=
 =?us-ascii?Q?PQVuo1U+CTdM3e30SfB4tZFr4xpBKWI9tJJFv9fFK176+Pts1iSzhxf81Ixq?=
 =?us-ascii?Q?ge5KUpFiaPNWkA5NygGGp1h7ggVoEpT1zyazb7yAIbMJnAFukBcxzmP1DSr1?=
 =?us-ascii?Q?v2HG1B9WXqBuaCNAUmO7p4vQUaS4RXTaEbhqdQL9Vy8/V09jxJbAtNoqVFcI?=
 =?us-ascii?Q?3LOLS38DLqFR3Ly24L4KjIVF4mVaxPFzIPT8yPff9EaJb8TTny+YPqti539i?=
 =?us-ascii?Q?dLoD9hQ7WB8hxi+kTCM6UxQjvszF42LQVa6VgJS9uWCnVztAU5kYUnvDHqay?=
 =?us-ascii?Q?DcIU9dgVZXWWlPgibBt8Dlw57DIQWuByT4+Q8QeUzjpmUL06xrzMdTZRbQoM?=
 =?us-ascii?Q?7zlBpo6OK820vafHURQBjNTPyY49N4hAjCGRjsZEJ3b8UrYcb15++7/gdNB1?=
 =?us-ascii?Q?wVWSWo40ED6JOGF85F2GpJK+LYsCjEqWJeaGe4kKFuMXkWXY4Mo8y+jh5nRY?=
 =?us-ascii?Q?+/CM1XezG4+iJlm3AtK9lCJJVJP+B4TUIUuaxHnQhybCMoKfuZ4/66ZHKe6M?=
 =?us-ascii?Q?+xVn1hVDJyV8/RDzeXdSM4tj3rMmCnRsJakSqeIUYU6wbNOPFYMym0sRSDR9?=
 =?us-ascii?Q?b4xj7nlVsE3DYViHPbKEbA/i3+NMHk9cmKCeWDbmMC9BEWXs8aU3OzHLzVr9?=
 =?us-ascii?Q?+UYYQj6Th3AjfyqND74IQdWk1RF2IQRaEYCBFVZgIS8PKJenc2MJgJ62fGzs?=
 =?us-ascii?Q?DCxIyvUb+2sxh6sP4kMOyr3LTLjB8AK79IsZgWtfX+hv0spMQ487wa3TLlGr?=
 =?us-ascii?Q?93xyaz9oMMf8blLOTguQTkf4F9idG/iWdNtucuIOAyBqfjSISgIZhxCno4kY?=
 =?us-ascii?Q?Arxbhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:28:57.4861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8d7bb-3c7c-40be-8e58-08de5f2135da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This makes it easier to add new MMIO registers for tracing and removes
the unnecessary complexity introduced by amdvi_mmio_(low/high) array.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 65 +++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2bc..62175cc366ac 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -35,28 +35,7 @@
 #include "kvm/kvm_i386.h"
 #include "qemu/iova-tree.h"
 
-/* used AMD-Vi MMIO registers */
-const char *amdvi_mmio_low[] = {
-    "AMDVI_MMIO_DEVTAB_BASE",
-    "AMDVI_MMIO_CMDBUF_BASE",
-    "AMDVI_MMIO_EVTLOG_BASE",
-    "AMDVI_MMIO_CONTROL",
-    "AMDVI_MMIO_EXCL_BASE",
-    "AMDVI_MMIO_EXCL_LIMIT",
-    "AMDVI_MMIO_EXT_FEATURES",
-    "AMDVI_MMIO_PPR_BASE",
-    "UNHANDLED"
-};
-const char *amdvi_mmio_high[] = {
-    "AMDVI_MMIO_COMMAND_HEAD",
-    "AMDVI_MMIO_COMMAND_TAIL",
-    "AMDVI_MMIO_EVTLOG_HEAD",
-    "AMDVI_MMIO_EVTLOG_TAIL",
-    "AMDVI_MMIO_STATUS",
-    "AMDVI_MMIO_PPR_HEAD",
-    "AMDVI_MMIO_PPR_TAIL",
-    "UNHANDLED"
-};
+#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
 
 struct AMDVIAddressSpace {
     PCIBus *bus;                /* PCIBus (for bus number)              */
@@ -1484,31 +1463,41 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
     }
 }
 
-static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
-{
-    uint8_t index = (addr & ~0x2000) / 8;
-
-    if ((addr & 0x2000)) {
-        /* high table */
-        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
-    } else {
-        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
+static inline
+const char *amdvi_mmio_get_name(hwaddr addr)
+{
+    /* Return MMIO names as string literals */
+    switch (addr) {
+    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
+    default:
+        return "UNHANDLED";
     }
-
-    return index;
 }
 
 static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
 {
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
+    const char *mmio_name = amdvi_mmio_get_name(addr);
+    trace_amdvi_mmio_read(mmio_name, addr, size, addr & ~0x07);
 }
 
 static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
 {
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
-                           addr & ~0x07);
+    const char *mmio_name = amdvi_mmio_get_name(addr);
+    trace_amdvi_mmio_write(mmio_name, addr, size, val, addr & ~0x07);
 }
 
 static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.34.1


