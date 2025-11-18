Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CD4CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLH14-0006a1-I4; Tue, 18 Nov 2025 03:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLH12-0006Yq-N2
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:24:44 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLH10-0006lr-MX
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:24:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rw6ebZ/CZItt4yOvfycjUoSkvIqHIxTVjApnfdVIO1dunqM5qXYUfQkkydIHKaMospSNRFMYE1MZFuoyiIH16uUEwsr85b00Mom5KRuKbDCi8SAuWjEPbgzPNAMeP0CF1/aTwIDxTnJbK5pSy412vgC+F1alkDH0jzBtl54BB9Hof12Nz32y5VvXmJ3sEG3Gyc6anDBXrwuhbRLcYKqTGHZarhmiYKoaSo5ZkT/n9IMF2XM3JDxasctwjxG/sh14OUuL2WLcUltIolIdI/XuUoerCgBfnlHEhOxljooDatnwgD2ESh6Or9AVY7VmPr9OC4d+g+YlFAh7tEdDBhzSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVsTEDyPnE1RDa7yOxtsifQD+GFw5BWeI5ndKbqoCF8=;
 b=i+Oges5z9CcCtKvTJ397rhD1jTBHu1ElxIFRl387dWX/kuoCZ521jqaoMNy9vEzIt0AdUEOPGK0HgSQoz852G1UAwgO6MmxykZvdHAke4E+IfxVgUBqdB0OeMfwxTLlYxme4VPC5otAsPzb3re73J2LOHBlNAfeopGccKZnH3F8MjUsm8q+B7Z/2bsAo2fUOWB2DgqapOAAVCw3e/A7SrnjbgH0xKVN9Zn6jBs7/Ub0QjpEUzAo0A2kP9OG/TOgPp4Jd0U/Rcg+vyzIfJ5vUeeqv1WIYwk0YgPvR06ys69w3a/HL+Zu3KqLiUpyy9JrdvNG2afTLtveb0apaqqZFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVsTEDyPnE1RDa7yOxtsifQD+GFw5BWeI5ndKbqoCF8=;
 b=JjOhWTkvz8miDGVse0GQ26VxDxzP7yHAsq9Tm4r8Rn8s5vWlW2tcRfAISHVSDUImNThObRn6JF6LBzAlRcyNAg46JZsgsXXSrLesxbEZ87LjT/E8lmmjbxb+jhszY7DlAaAG4MA1oLMF93fvxxwTe+b0vqoppDbWEDyP+jgpRq4=
Received: from CYZPR17CA0001.namprd17.prod.outlook.com (2603:10b6:930:8c::27)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 08:24:35 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::3e) by CYZPR17CA0001.outlook.office365.com
 (2603:10b6:930:8c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 08:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 08:24:35 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 00:24:32 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 1/3] amd_iommu: Use switch case to determine mmio register name
Date: Tue, 18 Nov 2025 13:54:01 +0530
Message-ID: <20251118082403.3455-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118082403.3455-1-sarunkod@amd.com>
References: <20251118082403.3455-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 71046995-089c-4b0c-3f74-08de267be83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UTfIcRTIEVPraEk/n/Ef7W37hFE5OcIqqY5MzBf8ZF7Rb5spxuU2QOtw3MtE?=
 =?us-ascii?Q?gw3gfXywM7NQfWSOw/Tzlv7Vh5ehULWJWfl0qeWFg8tpHHOX0n006ETu05fo?=
 =?us-ascii?Q?7rMBXYkubcGnRIlc3Nr7icyASujAGV3xs56zqRoGT6M3Fv4BQEI1Dsxrn7at?=
 =?us-ascii?Q?U4ddND5WhMHEkpym1E3l1iWPliU4KSfSQ4bmSar+FYemamtws1veJSbskblH?=
 =?us-ascii?Q?BCfheMBzE9dKNHOeoRM6I8JeKkkKdy0cFHBtjr6ozFPUcnqSZeaXoW1CP68Z?=
 =?us-ascii?Q?GpFJ7U+b/0NdxSC/CJe5ycff0skiIsmrlgzKEc0Cq7/L5WtQ5Mgl1qdn0w4E?=
 =?us-ascii?Q?lTQePBthfe0UXK62X8aeSwJU8sbqF6iX4+UnmTZ+e8RS/CAm8PYWmNFAJS6e?=
 =?us-ascii?Q?xvPrzysCwulkfr3nK293tIfxWODW9188/I2X68bUR60deBUWoPYwVJekonMY?=
 =?us-ascii?Q?4A8JtN8Wg1R5HWOvOZde5A0CrMoV3HOHftutXaJJ2aG5ro3z5jdTpeHkCcbf?=
 =?us-ascii?Q?4lkFeFxW1JJEezBjG/s2N35ocTRKjs1yPHGBMJDy/xgDro2SaBghidhmGy98?=
 =?us-ascii?Q?JS3P0tXcrEmV1Vn/47wF017yX5Z6DPAXbgdeEV4bq6s02k9AMwg67uVrk0NR?=
 =?us-ascii?Q?pLS5pM92Jiu5BUGg500/4YP8xVBXAgmxAmANqJsa5BSdFTyWiyxHp6TJ1u41?=
 =?us-ascii?Q?QWS10tkmqdzHxvUI3Zo0+q1ArCWLYQ25+7Urw5W7ZrZi5ed9cOT2Yp9vNlhF?=
 =?us-ascii?Q?OZRH1KAkjL5vYAOQMDLg9ky6schU0In7hx35bWvW81mmTMK2LjULICoO/z/A?=
 =?us-ascii?Q?1bZGXmStxWeqYVDCwRiXyWURX7pWsaUjd5wFUqTW0VIryb6v+d5FaxPGA9pI?=
 =?us-ascii?Q?mnxYXUi6r8sDYbVzGGWgbb38DORD7ThT98l/ppSVsAWmvYcKDcctE1EU2YlY?=
 =?us-ascii?Q?ytjjfl7liTlE86yNMF7PfP+YBSLtjlI9gioWZDi6whDYkMluY2mxdVH+lAgc?=
 =?us-ascii?Q?ZSfzjxtGhwgiOPEjPFuYq5bbIIfduuNIwYWn0ifZp+dueNtFt6FK6XXYg6hE?=
 =?us-ascii?Q?Ax6a1s24pxZuw7QeJq9banQHRQv5GcTSP2AjY7PO7QWU47ZJ/nc2QhsInN/5?=
 =?us-ascii?Q?mYE5938gIvemPkhiCqoCPVU6XO1G26tqoaqkPicd7NyFwOtWBvxmkEHp4Y87?=
 =?us-ascii?Q?n5H7T48o3WEprcyt+d4BAkXERtnh5rae3pQJS+JUxbLS+D+cpBmauyMGJtPX?=
 =?us-ascii?Q?YoNCETau7eVYawBnwN1h7m447WpbUTZMEFZWSwKuCLCX177YMQ0G96GYAXzH?=
 =?us-ascii?Q?sn9Xv/V+hy5j9PrnqUBoAw7j8NoFQIlxV9IF2Sd2JN4YCeOZpub87qtgS7X1?=
 =?us-ascii?Q?Zo3XBXpu3MIqM+xvStqTEiuMQDsmI4vVtcWgopoDHeBGevSdwp6ZuZQb0eJ2?=
 =?us-ascii?Q?r+JvblQvi7Q4uUscYcqszClW9z3rXEvR1C8MjDEyRLd1pgRpEZGxvyFBp36j?=
 =?us-ascii?Q?KNd5sLCktw2h4mpXiGxB6nu+zphWgOQhOgkkT7C+uLF24NW1vwmNpnV7YnD4?=
 =?us-ascii?Q?HN2SqT/VcLJG/FMh7c4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:24:35.1518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71046995-089c-4b0c-3f74-08de267be83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

This makes it easier to add new MMIO registers for tracing and removes
the unnecessary complexity introduced by amdvi_mmio_(low/high) array.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 76 +++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d689a06eca46..a9ee7150ef17 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -35,28 +35,13 @@
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
+#define MMIO_REG_TO_STRING(mmio_reg, name) {\
+    case mmio_reg: \
+        name = #mmio_reg; \
+        break; \
+}
+
+#define MMIO_NAME_SIZE 50
 
 struct AMDVIAddressSpace {
     PCIBus *bus;                /* PCIBus (for bus number)              */
@@ -1484,31 +1469,48 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
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
+static inline void amdvi_mmio_get_name(hwaddr addr,
+                                       char mmio_name[MMIO_NAME_SIZE])
+{
+    const char *name = NULL;
+
+    switch (addr) {
+    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD, name)
+    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL, name)
+    default:
+        name = "UNHANDLED";
     }
 
-    return index;
+    strncpy(mmio_name, name, MMIO_NAME_SIZE);
 }
 
 static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
 {
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
+    char mmio_name[MMIO_NAME_SIZE];
+
+    amdvi_mmio_get_name(addr, mmio_name);
+    trace_amdvi_mmio_read(mmio_name, addr, size, addr & ~0x07);
 }
 
 static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
 {
-    uint8_t index = amdvi_mmio_get_index(addr);
-    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
-                           addr & ~0x07);
+    char mmio_name[MMIO_NAME_SIZE];
+
+    amdvi_mmio_get_name(addr, mmio_name);
+    trace_amdvi_mmio_write(mmio_name, addr, size, val, addr & ~0x07);
 }
 
 static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.34.1


