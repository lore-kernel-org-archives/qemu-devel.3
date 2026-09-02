Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9177FC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i6x-0000g9-4L; Wed, 02 Sep 2026 06:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i6u-0000dm-JO; Wed, 02 Sep 2026 06:22:28 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x1i6s-0006fp-DR; Wed, 02 Sep 2026 06:22:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ8FPz+NDePx+MVJMVBar5CDUlQYc4pOSPaIsPn1j6JVq07Db755K1O1a+9JouAbOgGu0ReQObVsL/TwG3CDp2TqPEEPF51SnFroTfbvg0c+WcRlOAgw1dTr7KOw7Khy5J1SX0pLHwOlAKk6YFIm+Aq3pbV2NwXLqbTSiJFC8jF/tZLD6ggf9189EgJwcf6KMKXZ/mYBVa36grCz9ABlqIPKloM3C8oOHLqp3WFbNQCq1Y2/yeCQBO2oYEjg4u6e4GjSfHu02FCh+RaiCynkKMXhVP63a2v6HpwprWKF7Su65PxHnM/t0q3rrk4D8Y/iA56zuofdbu5ZerZS2kVoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr5hYE2MjitqgHGyHACZ4oJHYEBw/77lhlXXYK5XfZY=;
 b=S2Nx0JzbpniitJclAOXap/VsZDuuCj/sw6CgmX5n29C9bkfaSP0rOJ6qSaZjWvD8so2LLZgeMeVYrY5pfOdb4JbRqjI2nQBYvrZXoXHpyIrhEwPnT9HGYPllkNi/ZFM5LSdiJ6arOq7iCeCEErXwwby4PcSsumOVvaNLveYicsDwGDJSrg5EiPdgYTWaR06zIsMtFKI5cWgmRhunUlqikTyEE9SBow+2lYc+PJEe1pW3HFDgoSLvAu9VN/raNET3/YKkOJrU/plj9aIMTacGNsfnuL7soH8kVC6eoO0p5/oJCY+1F0NKXnRiwPVbVBzI9y8SDQkW923Q2IpKT8WUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr5hYE2MjitqgHGyHACZ4oJHYEBw/77lhlXXYK5XfZY=;
 b=MywQnNmmHOuPRh5Kg2t1ysUQqBPfWimubkN6OAnYeApmSUzgUET7MIp72U9ugQWI8ORxxe+WhLOGHwnsSnXpVT+FNcs9+yiN1T9zNgpQGE7jk6nOWVdhMN9Gw9Uav+yhOp4GO0cP8gKNvnONkyfqCE/IVuPU10zvZEYhU4RbiiahKXrE/nYfRlkvwfHEj8rdc2fiXHi0ShMIrNSjjXpJ/ZE2f3jz09I3MQj3Ie+szkaA8iJAMS+x/pNKUCvNJrBgZlEUXD/Wryblas2qOAgg8wWni44l8zoZ/+GbPo6gV7pmAhxLNU/gpJf/dzC5eBbjkh0+boP1fbQGbg4mVXaa0w==
Received: from PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::16)
 by LV3PR18MB6176.namprd18.prod.outlook.com (2603:10b6:408:27a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:21 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::9a) by PH8P221CA0064.outlook.office365.com
 (2603:10b6:510:349::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 10:22:20 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 5E90A4186B53;
 Wed,  2 Sep 2026 03:22:20 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v5 02/13] hw/char/cadence_uart: Add BXRS register definition
Date: Wed,  2 Sep 2026 03:22:16 -0700
Message-Id: <20260902102216.3039230-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|LV3PR18MB6176:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c9e12f99-1a43-4554-2e68-08df08dc12be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|6133799003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: bwMRns9Bh0e6CCBNd/c2cQmHDFqkMoYSdfb8DsfmNU8oSxHuHjeNs/Sk1HPIocrOrt4t5b0pPTFf7atJzQQu9Vm5VfJM2mJeG+rGq/Fkq6PzbiOhQDfVaTXkpfzx2fNm7YS47OU7PYNqebl7ys3+3nX6gL9jrcfzjwGWIqzg29UDCrrRtvdFNC+Un7J1if+jtQOsGgb6+3y0InVHJ9YWbXxyXehnxIp1OGIJd+PlU6t/D2b6dxWWwR0z2S9pZ0qyWMKbpojJsJcZgfdDv7yiPwDs0HPVYhg/Y6bzTSOENmSKz4sHsgRYHrP89BOOcK7sRMXE6UOcozCWJ/IWuAHMChc7kV5NSRtPM1IIYla5rk76wA2Y+sPXEVnMDGqMhytlS3g0l5FC7Trl2fwCCTDuIyS9puiEnyqWL36DzoB7jSktd4znHUVR8I6TadK1lsEqX14iCE9vzfLCOYJaH8FvBxX6UfAYAYPY5WWobwHAX6t2n8NQ0CiQ54y0P2ykPDrHlMwNYlQ4KG0gP5e6PuUzD78vkdPacHkluwvpn7oB73Xm3hCPFiUli0N0mjKP8U/se4yxvkWXYxIYHdCWIRjV632jwRA3aMSh7eIK9Ev9yZjRKLovRdQbwTu2s5xx0DbbyHcfCHr2FTfAhclkFHHAgA+tzqnJD8v1YGlb1I5SziZXnkj6guOzh/GuJvqCUdWy88pEdqTPtLATAaddu4JP+A==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pnYU/NdH9aW+g21NnGiAo9iXCpOkaEa9/oOTVud2QQ4F8XxXdx2n8AhZfGRCNMJhFxg7KHlkTsBfTVV2PHBXIBykILj7DGchZcAxvXTFbkAZmzvzxx9v0H+daBeG80SJjbogInjDdsurSPC/G03Wmh/hEoZRgbz+UNDMyB5uOK2nPcBB3FJFX+P6d5IWrCpUal/Fg/w1LyAOzSs/xi3TzaqQB6kbP3Pm4aD/UKNpDS+J3qo2TXjGX9bkrTVprYl/VyMevDkKwhPCX593n//p6Yy/9IrygG+x8VktnKk0FRqdGNX6Dspt9KeS/TUH462dMRg/P7HY44eG4Fk8EzlOPKZum1hLuk5w6i9lBMOo7PfUTg6rd2UkXqN6xjBSmMx9TsU8JTaRCSpmlFv0GPOG8cDPhOeeRZRHYylWSTMBS7QrNd9esmodYojgwXCD2g2L
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:20.8942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e12f99-1a43-4554-2e68-08df08dc12be
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6176
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=kchiu@axiado.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The RXBS (RX FIFO Byte Status) register at 0x48 is only exposed to
the guest when the brk_support property is set, so the accessible size
should be CADENCE_UART_R_MAX_BRK in that case and CADENCE_UART_R_MAX
otherwise.

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/char/cadence_uart.c         | 15 ++++++++++++---
 include/hw/char/cadence_uart.h |  4 +++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 8e23a378c4..8746a96619 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -120,6 +120,13 @@
 #define R_PMIN     (0x3C/4)
 #define R_PWID     (0x40/4)
 #define R_TTRIG    (0x44/4)
+#define R_RXBS     (0x48/4)
+
+/* Number of registers reachable by the guest, depending on brk_support */
+static inline unsigned int uart_r_max(const CadenceUARTState *s)
+{
+    return s->brk_support ? CADENCE_UART_R_MAX_BRK : CADENCE_UART_R_MAX;
+}
 
 
 static void uart_update_status(CadenceUARTState *s)
@@ -424,7 +431,7 @@ static MemTxResult uart_write(void *opaque, hwaddr offset,
 
     DB_PRINT(" offset:%x data:%08x\n", (unsigned)offset, (unsigned)value);
     offset >>= 2;
-    if (offset >= CADENCE_UART_R_MAX) {
+    if (offset >= uart_r_max(s)) {
         return MEMTX_DECODE_ERROR;
     }
     switch (offset) {
@@ -492,7 +499,7 @@ static MemTxResult uart_read(void *opaque, hwaddr offset,
     }
 
     offset >>= 2;
-    if (offset >= CADENCE_UART_R_MAX) {
+    if (offset >= uart_r_max(s)) {
         return MEMTX_DECODE_ERROR;
     }
     if (offset == R_TX_RX) {
@@ -523,6 +530,7 @@ static void cadence_uart_reset_init(Object *obj, ResetType type)
     s->r[R_BRGR] = 0x0000028B;
     s->r[R_BDIV] = 0x0000000F;
     s->r[R_TTRIG] = 0x00000020;
+    s->r[R_RXBS] = 0;
 }
 
 static void cadence_uart_reset_hold(Object *obj, ResetType type)
@@ -603,7 +611,7 @@ static const VMStateDescription vmstate_cadence_uart = {
     .pre_load = cadence_uart_pre_load,
     .post_load = cadence_uart_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX),
+        VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX_BRK),
         VMSTATE_UINT8_ARRAY(rx_fifo, CadenceUARTState,
                             CADENCE_UART_RX_FIFO_SIZE),
         VMSTATE_UINT8_ARRAY(tx_fifo, CadenceUARTState,
@@ -619,6 +627,7 @@ static const VMStateDescription vmstate_cadence_uart = {
 
 static const Property cadence_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", CadenceUARTState, chr),
+    DEFINE_PROP_BOOL("brk-support", CadenceUARTState, brk_support, false),
 };
 
 static void cadence_uart_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index 751a751248..1d5fc7f328 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -30,6 +30,7 @@
 #define CADENCE_UART_TX_FIFO_SIZE           16
 
 #define CADENCE_UART_R_MAX (0x48/4)
+#define CADENCE_UART_R_MAX_BRK (0x4C/4)
 
 #define TYPE_CADENCE_UART "cadence_uart"
 OBJECT_DECLARE_SIMPLE_TYPE(CadenceUARTState, CADENCE_UART)
@@ -40,7 +41,7 @@ struct CadenceUARTState {
 
     /*< public >*/
     MemoryRegion iomem;
-    uint32_t r[CADENCE_UART_R_MAX];
+    uint32_t r[CADENCE_UART_R_MAX_BRK];
     uint8_t rx_fifo[CADENCE_UART_RX_FIFO_SIZE];
     uint8_t tx_fifo[CADENCE_UART_TX_FIFO_SIZE];
     uint32_t rx_wpos;
@@ -51,6 +52,7 @@ struct CadenceUARTState {
     qemu_irq irq;
     QEMUTimer *fifo_trigger_handle;
     Clock *refclk;
+    bool brk_support;
 };
 
 #endif
-- 
2.34.1


