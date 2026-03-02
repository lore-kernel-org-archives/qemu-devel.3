Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59607E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1pr-0008J1-Ks; Mon, 02 Mar 2026 06:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vx1po-00082s-NS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:53:13 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vx1pk-0007aj-Qa
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:53:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmwQRJbjs2nZC5OVUXzf1Y6Be7f3k7qWxvwZdnCFE9LlGqgi34gh2doOlN4VnRmQYfhIUaDTYq1xMBuoEVZPJY3bu9OBTpIU2mmiwGKRfLKbBjfAEnnABbfXT8iRJMLxMxhiI9Jvsc1ixFFMIZzGhs6pwsIL0dK7VFkZKpwgMbWDYsB/CgArIGeVhrOsJUlruA6iV5FrLyAeh95V5wg6rV1HDLewpGHElV6jBFFTRa/F5AqXDQN5x0HrkC3/B22Ph73QrlzWy9an+oKGvnXXtP2Fdn8FZo+win/bjTRMkRrsiCTBN4WSkGGmkDSjDKuwHfxj2/BTwMmiPURWMGr2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K4X8291VcgGQ40ridxq7+359YQdCKrPsM99gPAND1c=;
 b=MQ42nIqtHwT/FeWEy5cUuov79dwb1QkVqEPPSALAyal/QmJAWArc/GykhrvkYxo6vSc8FFUNmXQnRJeU1/hgsazLPBINpBh4j/NRFvyFhgw0mJBR+jG56D5ORRooPtu7942pMWb7qwiGyJyCBa6F+XeXAjOMrN2nLw6v8c38GNK6XfkPpF9oYRaX5LswwUaRkW/ESNOA+5k9e5MdNiCz3oSAFl2G6SxWgyQvp5VwCc2FE/pSmrUFNzwSvq6J89JupFwT5gou+YnNnbb+q14m5SryAAG+YEE+TkEr0pXDHMgSG8TjI15gAJt1stc3CcjdgmPVzkJkIqQaRxmim4AEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K4X8291VcgGQ40ridxq7+359YQdCKrPsM99gPAND1c=;
 b=Ux2A3zt0l6LuTBQwtfbcCTfFBH00Jpnt2/aREijMl9T6faRe/8xalgZz52tahchKSF8m4O45NIYLEU5Fq/SJ7i3B3Nhsmj2sCAr2p3IVa+4zOrV3wmAHm5qii7cP8i983gAS3egkLij3/xC6SfGUCtrDBdybfC+eW8hQjLY6LOc=
Received: from IA4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::9)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 11:52:59 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:559:cafe::a1) by IA4P221CA0006.outlook.office365.com
 (2603:10b6:208:559::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 11:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:52:58 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 05:52:55 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <clement.mathieu--drif@eviden.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v3 3/3] amd_iommu: Generate XT interrupts when xt support is
 enabled
Date: Mon, 2 Mar 2026 17:21:30 +0530
Message-ID: <20260302115130.5903-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302115130.5903-1-sarunkod@amd.com>
References: <20260302115130.5903-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d20271-82db-43d5-24c0-08de78524005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: XQ2BQaj0p53vCA6hR7tJdNmKrKa874XQfYYO/6wPFV6jIUsRnZKVt22puaW04UAKS8y299ktDHyrtBLQGB5gYWRwRoFzVejYH3LxMNuI5oAkPePqx/e92Cw+S9DVRXmHtl0ZHttbjkSEV+TU+Coyh+xs+w1GdM6fGVhoDB1koQpHGvXWaXZpTmZYhrFg4AeTwqfNa1Hz31SRdMXIW3r9KhV1xw1ltvKNVF77zD4g+sN44RXqwsH0QX1Bd3LBn0r5KdDqnEy6sHmWKLE7SQ4QsHyxmFEty4mwP3HY6X3k5rTz48S+Ngu6tjzbjXC7/bQo0+FgnDjSh310IpKq6UJuhcFAObdyzzcnUp0xFNrv7lcIbGMi1V0HiDPhElsrrDD+CGSRlnk9Ut/tXunbOfRvVhSMZIroMXjWongp83QFViTlsSHRCbbvTlybaYQ8FF8XgRg1hvMBHP3+DJOV+Hef3hw6HyfgGhrH85Uzy2zJPTD0svYYv86veR3w5LiywhvirBX68rNi0eaoYcPNhPgakc0HlNYC5MJUfZqY8E6OmTiMYM1IAtRSC5UqUFPlwHeIfPa+hDKKiJQ7flar+N8y6jGLZTToAAebIO1QFPN3erAcihr9UZ2Yb6sVLXJfdWt5AR70B6dkKU3MmlclRJa81IzKYJIUBxjlG1wOy8lH4TtWzBUhGYC6JE95Q8bxR57ZecVgdwpsuj9iJEGhxiDGMMayQTUGLsyQDhi/lEHYCxyMLTIGPtjwMvrTQ5f2cQUAAKBbdMLnxUZsk9G1AfxYw6jIM0fn0q4Mm34Eok53EOdgt9M8CAkQPQMidGkkKjuGdm7K0CnlF0nmAI0PCq6xVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZP8/ZLPGoPAv8AM7KRFGYTmwn3SHOeTKnbvBmiAH1fi+x8laf9PlwmyWDgZNOgBvoTBZ+t5tPNLe1gHq1qSXv0ZfnE7/7xJ7pAlUo33ETM2LtGBEk3PU3vElrL7KQRzmgR/mYyxYQwXBI/mEilvvdeUKKtkmc4YH/Hyts1clgurgDkFvcCXE2T5BiJvz/xCMVB9BQPgTgo5NUi5rqyw6ccI1lzre49Sc1v1YFluhSnZkecdJMbuDWZgIax77NfuI7m9jlNJKD3ZNnnoD534KYMVeLLoQzLgBSVbv4937MuVCGHqsAg2pPjFd6bIi46j7sJAoGZg1e+1vE8PfYnaF+fvh9CRCAFjTuGF7jl4TPUhQ/ZS3Gx67OpDJp8AfP0qr7rDgR5kKCWIozvsQU5T/35XRai33Xu6f771n2qPy6AYka8ttlGauHXFd2KeRoVeO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:52:58.9484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d20271-82db-43d5-24c0-08de78524005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
vIOMMU cannot generate event log interrupts when the guest has enabled
xt mode.

Introduce a new flag "intcapxten" which is set when guest writes control
register [IntCapXTEn] (bit 51) and use vector and destination field in
the XT MMIO register (0x170) to support XT mode.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c  | 47 ++++++++++++++++++++++++++++++++++++++------
 hw/i386/amd_iommu.h  | 17 ++++++++++++++++
 hw/i386/trace-events |  1 +
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4a86e62a3b92..bd24fdee7cfe 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -192,18 +192,38 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
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
@@ -1482,6 +1502,7 @@ const char *amdvi_mmio_get_name(hwaddr addr)
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_XT_GEN_INTR);
 #undef MMIO_REG_TO_STRING
     default:
         return "UNHANDLED";
@@ -1525,6 +1546,15 @@ static void amdvi_handle_control_write(AMDVIState *s)
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
     s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
               s->ga_enabled;
+    /*
+     * IntCapXTEn controls whether IOMMU-originated interrupts are sent based
+     * on the information in XT IOMMU Interrupt Control Registers rather than
+     * the IOMMU’s MSI capability registers. Therefore it requires IOMMU
+     * x2APIC support capabilities (i.e. XTSup=1), but it is independent of
+     * whether a driver chooses to enable x2APIC mode for interrupt remapping
+     * (i.e. XTEn=1).
+     */
+    s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xtsup;
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -1732,6 +1762,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     case AMDVI_MMIO_STATUS:
         amdvi_mmio_reg_write(s, size, val, addr);
         break;
+    case AMDVI_MMIO_XT_GEN_INTR:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
     }
 }
 
@@ -2382,6 +2415,7 @@ static void amdvi_init(AMDVIState *s)
     s->enabled = false;
     s->cmdbuf_enabled = false;
     s->xten = false;
+    s->intcapxten = false;
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
@@ -2452,6 +2486,7 @@ static const VMStateDescription vmstate_xt = {
        .minimum_version_id = 1,
        .fields = (VMStateField[]) {
            VMSTATE_BOOL(xten, AMDVIState),
+           VMSTATE_BOOL(intcapxten, AMDVIState),
            VMSTATE_END_OF_LIST()
        }
 };
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index d39019b216af..72139bb0c70b 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -53,6 +53,7 @@
 #define AMDVI_MMIO_EXCL_BASE          0x0020
 #define AMDVI_MMIO_EXCL_LIMIT         0x0028
 #define AMDVI_MMIO_EXT_FEATURES       0x0030
+#define AMDVI_MMIO_XT_GEN_INTR        0x0170
 #define AMDVI_MMIO_COMMAND_HEAD       0x2000
 #define AMDVI_MMIO_COMMAND_TAIL       0x2008
 #define AMDVI_MMIO_EVENT_HEAD         0x2010
@@ -103,6 +104,7 @@
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
 #define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
+#define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -339,6 +341,20 @@ struct irte_ga {
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
 
@@ -417,6 +433,7 @@ struct AMDVIState {
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


