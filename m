Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF00AD358F7
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 10:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPHX-00034v-9O; Thu, 29 Jan 2026 05:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vlPHT-00033k-HC
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:29:44 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vlPHR-0000v6-CD
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 05:29:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4HZVIae0BJQmzBp08zyXLy8UQ5zy5ncb1UmUGZOg7XGBXpY7V9hiQIoly2W1ZWpPFStP2kCtH2LbWI0U8871VQRbbvH7WSzQEwi0/orBbru5HyBqFVmw3VVKGFYGSWYooswLMcbRN31ntF+3zm0w5OFNuRvh2012UQTYisIBFcv2+apsYBaLLAB7UKsaKuBiK1zrsVfViLbmMzy7X+PnNU3FnbYz8uAKYAeBFPxF197W+ShFloMREqnZb1nMfrQVLEDzkU62dNXfFuyJRFpHGFNUVahSdcQAHaY59mfXHAQZnFPRdQq89NLQ7BygiLqZ+sA/PcOf0TpYtTQeOKKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcZw5jVqJCzHw+KDUdQkGoJYNkq7OMNeDidxE08BQR8=;
 b=gXb5ohCFt0I5gBBO1HPIe65rGNSEyn/f0spsEISDxLiBERDlZSJOC+3UDoyyrGHeUiR9uF83fqFJVrMxpbsSisb450TuoHkuqexj4XvEG8Zcb9uiv64JeC/hGC9Xkz7iKn6YfrUQMfg9j5RIlzMU1A9rLuyQZKWM+ZGzd1fHMbZgUdqI18t33mNMndx02af3cPQbMjn9XY42+GabSSib55LOxRRJTbghryBWUUB6SIqJtmOU0PtdDsHFjvSftP9OKWomoLxEG9O4NNl/dApDpHs2QTP1qXan+AD0vIWFhTW5crj+ACf2fy6CEJgg7H618N3+4Clt9AJ9iBo9lnskMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcZw5jVqJCzHw+KDUdQkGoJYNkq7OMNeDidxE08BQR8=;
 b=LzzKz5wGRbxdFBa1NbI1+8s+EVQ56iwVu9d2kEG3fc4AM8VgC4nrRdD3fGFwhXmLJpN5zA4Ds4i4spyXBbyEu2DM39uf1Wm9g60ww9Dqqg7SkQ7Uv516RSQSwf8eVH723XMQV25/+ZYv3JupuriNGWds8wCYbsslmShX3BRRw5A=
Received: from SN1PR12CA0076.namprd12.prod.outlook.com (2603:10b6:802:20::47)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:29:34 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::39) by SN1PR12CA0076.outlook.office365.com
 (2603:10b6:802:20::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 10:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:29:33 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 04:29:30 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v2 3/3] amd_iommu: Generate XT interrupts when xt support is
 enabled
Date: Thu, 29 Jan 2026 15:58:14 +0530
Message-ID: <20260129102814.4488-4-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 69329c15-8f8e-4df2-a6cf-08de5f214b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zXdMrkDqBCKxX0K6+08BV62TOShXgmmJ4tE+nQf6sVn39Z8iWLa7B9arA3Cy?=
 =?us-ascii?Q?aD3nN/PJQe28vUsaw+DRVylZnpJEycoCCYjS0K6ND8O3V2/tItCI1RCVAJn5?=
 =?us-ascii?Q?LdC/oZ6Cn1vcgFbmINg3a2pSo7eQKSJVtHbLk6apzQ+Fus7N7TtFVzeYBOIN?=
 =?us-ascii?Q?A+aBJnw2Z6an2HQrqwRI71NtpW2wU9/qpjjofTowYA1ghhAcLqUQZsHFKLkN?=
 =?us-ascii?Q?b/uZjIVY/eM+Oj/KjsWch+ONrvRRgmgpChaFLaJhQObthub//a/lB87RSZ+0?=
 =?us-ascii?Q?xPS2cls0xZufivGIV9CmJs16dqhR0fCa9rN1BEwZvnFgqH3UxEoPaj9AKFEr?=
 =?us-ascii?Q?EIHokilXR4bKLf2XL82IgGhM258WRjouAan7boCf5jVcw6lE3y0w8xo12JCY?=
 =?us-ascii?Q?ruTpYYyoeTIXbVGh4dCscP1SE+XfQxze2VPj3fRxun6ZzJdpB1RBuyoxTv8h?=
 =?us-ascii?Q?cTWKPydit8SN4nSyusMnDaXPZ28Li3CcH6FU/C3cgFolnBfM8dK7b4qJtj5K?=
 =?us-ascii?Q?ao1ZDcrU5BwmiyojlhG+nxG4V3RQIJduOhXqYloHwWqNpgL/uUmppoqTwbQz?=
 =?us-ascii?Q?EEMDngR0z1+MQkxF4uSHYsgsAbet3Q2hzs37lb0EOcZW8T0IjqSKDCHzYVxx?=
 =?us-ascii?Q?C/w0413gtOeI6llWSSYYbMVoTRBYBmDhxRrXfhjZaYLghc1GkbVRqvMVkqJG?=
 =?us-ascii?Q?d+cHjMLJANpqlig6WMwRmLt9hoZVl58e6O07twxrt2BxZEhBWf6VNJitDlN3?=
 =?us-ascii?Q?ZagykG3Fu4xBwMyUJK6Hr6/rvep6KAOgJITYQNHItwjjzQOUDI5u6ur2bB+/?=
 =?us-ascii?Q?JcYuZN9aixvoOAafjgOg9/OA00IVBoj+Ph7g7nbLauXbIvoU5elRceK9MUJn?=
 =?us-ascii?Q?JbW/FcNEmM/imkLTXg396wvRwW9wGn5HRkNF9PSmuQX/c9fZvm/Q1Ajtd9Rn?=
 =?us-ascii?Q?qgUyS5snviJUoak95Ok8536PHjXrlvTvyXN+SOSD6ccN3Ilpy+H2VpHJEKmq?=
 =?us-ascii?Q?GLm43Wc8sUyEnCptMnr87gcAu5//K6H5F8g/AKwRHA5FJrsAeTUojgOqrGJH?=
 =?us-ascii?Q?Lv8uwQURIIvd+QrRCxPu1DoUtKh1y7lJv8cPVKTX71MbNRSWm2HrKUQQht1B?=
 =?us-ascii?Q?6+zznL/xsR2orjkG06SPMyjMojtCfw7xSW1xta6dumQTzpzyEVPvPdfsPKfG?=
 =?us-ascii?Q?hv1YWAQcIpezibRkn1v4YJ7SdslxE+LFnVv6PeKggNcdzAntTrxbxFzocyeS?=
 =?us-ascii?Q?TxlSUa1kkTk6nKmDA/yYi/VrOt8DfDhuU28f3XD+KDtNB5dyD49WoalyB+CD?=
 =?us-ascii?Q?eDc+8EROztc8YslLGMqqHK96JS+nPIBvB03432iYtfKEOOEg7bAK9oHiOc57?=
 =?us-ascii?Q?rx/SYjiDJ1XdxOLW6aKVeWANeLlvjrD+/ovK3QVvqMj/FoON8QhC1hBOlNFn?=
 =?us-ascii?Q?4XnicTUUv2Puktq7wwUBfKsAHMaP31HdDpEUACuE7Nd3mGeD+zOkYK/j9rOK?=
 =?us-ascii?Q?mFUSbcWZqa9f4oMqSypP2yhZrOiwnGc4snIIjgE0J6l6R6Qard33B0683Xjw?=
 =?us-ascii?Q?07YPceln5X7DRhLmj9K9Q4pQfgwEifcCL7p4ZQE2RfPHp6dZatwjbfmlL2Lm?=
 =?us-ascii?Q?ey90LfGjlyLNfWr+3yfXSpOPh0ReyrdqJyYPflIMk15Z2Yw6o6L4yY/CesvR?=
 =?us-ascii?Q?/b+xXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:29:33.7033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69329c15-8f8e-4df2-a6cf-08de5f214b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU itself are
sent based on the programming in XT IOMMU Interrupt Control Registers in MMIO
0x170-0x180 instead of the programming in the IOMMU's MSI capability registers.
The guest programs these registers with appropriate vector and destination
ID instead of writing to PCI MSI capability.

Current AMD vIOMMU is capable of generating interrupts only through PCI
MSI capability and does not care about xt mode. Because of this AMD
vIOMMU cannot generate event log interrupts using XT event log register
(0x170) when the guest has enabled xt mode.

Introduce a new flag "intcapxten" which is set when guest writes control
register [IntCapXTEn] (bit 51) and use vector and destination field in
the XT MMIO register (0x170) to support XT mode.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c  | 43 +++++++++++++++++++++++++++++++++++++------
 hw/i386/amd_iommu.h  | 17 +++++++++++++++++
 hw/i386/trace-events |  1 +
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 850d3920a76d..742ef5d42561 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -194,18 +194,38 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
    amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) & val);
 }
 
+static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
+{
+    union mmio_xt_intr xt_reg;
+    struct X86IOMMUIrq irq;
+
+    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
+
+    irq.vector = xt_reg.vector;
+    irq.delivery_mode = xt_reg.delivery_mode;
+    irq.dest_mode = xt_reg.destination_mode;
+    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
+    irq.trigger_mode = 0;
+    irq.redir_hint = 0;
+
+    x86_iommu_irq_to_msi_message(&irq, msg);
+}
+
 static void amdvi_generate_msi_interrupt(AMDVIState *s)
 {
     MSIMessage msg = {};
-    MemTxAttrs attrs = {
-        .requester_id = pci_requester_id(&s->pci->dev)
-    };
 
-    if (msi_enabled(&s->pci->dev)) {
+    if (s->intcapxten) {
+        trace_amdvi_generate_msi_interrupt("XT GEN");
+        amdvi_build_xt_msi_msg(s, &msg);
+    } else if (msi_enabled(&s->pci->dev)) {
+        trace_amdvi_generate_msi_interrupt("MSI");
         msg = msi_get_message(&s->pci->dev, 0);
-        address_space_stl_le(&address_space_memory, msg.address, msg.data,
-                             attrs, NULL);
+    } else {
+        trace_amdvi_generate_msi_interrupt("NO MSI");
+        return;
     }
+    apic_get_class(NULL)->send_msi(&msg);
 }
 
 static uint32_t get_next_eventlog_entry(AMDVIState *s)
@@ -1483,6 +1503,7 @@ const char *amdvi_mmio_get_name(hwaddr addr)
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_XT_GEN_INTR);
     default:
         return "UNHANDLED";
     }
@@ -1537,6 +1558,11 @@ static void amdvi_handle_control_write(AMDVIState *s)
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
     s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
               s->ga_enabled;
+    /*
+     * intcapxten does not depend on xten flag because IOMMU spec does not
+     * specify any dependency between these two flags
+     */
+    s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xtsup;
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -1743,6 +1769,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     case AMDVI_MMIO_STATUS:
         amdvi_mmio_reg_write(s, size, val, addr);
         break;
+    case AMDVI_MMIO_XT_GEN_INTR:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
     }
 }
 
@@ -2393,6 +2422,7 @@ static void amdvi_init(AMDVIState *s)
     s->enabled = false;
     s->cmdbuf_enabled = false;
     s->xten = false;
+    s->intcapxten = false;
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
@@ -2463,6 +2493,7 @@ static const VMStateDescription vmstate_xt = {
        .minimum_version_id = 1,
        .fields = (VMStateField[]) {
            VMSTATE_BOOL(xten, AMDVIState),
+           VMSTATE_BOOL(intcapxten, AMDVIState),
            VMSTATE_END_OF_LIST()
        }
 };
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e9401f3a5c27..886814770276 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -57,6 +57,7 @@
 #define AMDVI_MMIO_EXCL_BASE          0x0020
 #define AMDVI_MMIO_EXCL_LIMIT         0x0028
 #define AMDVI_MMIO_EXT_FEATURES       0x0030
+#define AMDVI_MMIO_XT_GEN_INTR        0x0170
 #define AMDVI_MMIO_COMMAND_HEAD       0x2000
 #define AMDVI_MMIO_COMMAND_TAIL       0x2008
 #define AMDVI_MMIO_EVENT_HEAD         0x2010
@@ -107,6 +108,7 @@
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
 #define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
+#define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -343,6 +345,20 @@ struct irte_ga {
   union irte_ga_hi hi;
 };
 
+union mmio_xt_intr {
+    uint64_t val;
+    struct {
+        uint64_t rsvd_1:2,
+                 destination_mode:1,
+                 rsvd_2:5,
+                 destination_lo:24,
+                 vector:8,
+                 delivery_mode:1,
+                 rsvd_3:15,
+                 destination_hi:8;
+    };
+};
+
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 
@@ -421,6 +437,7 @@ struct AMDVIState {
     bool ga_enabled;
     bool xtsup;     /* xtsup=on command line */
     bool xten;      /* guest controlled, x2apic mode enabled */
+    bool intcapxten; /* guest controlled, IOMMU x2apic interrupts enabled */
 
     /* DMA address translation */
     bool dma_remap;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 5fa5e93b68dc..a1dfade20f18 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -118,6 +118,7 @@ amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
 amdvi_ir_target_abort(const char *str) "%s"
 amdvi_ir_delivery_mode(const char *str) "%s"
 amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
+amdvi_generate_msi_interrupt(const char *str) "Mode: %s"
 
 # vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
-- 
2.34.1


