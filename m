Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C723C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FyG-000445-CZ; Wed, 09 Sep 2026 06:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4FyD-00040i-7S; Wed, 09 Sep 2026 06:56:01 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4Fy9-0004FX-Ls; Wed, 09 Sep 2026 06:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxArLQ/Fj3hMwLiI/GyexsiZ44j4geXyMtWdTtI9lht4uZJiw6zPWH9mPcaVVa06KK57aGgdg58m8yvFRB5jBlPyDO/KNk2B8aKRASitu1jSEa/MS6a4nriq6CbD8PpITyq30pDZX4xQqvJwd+bkqh6HTMHR49OkQDSmx8Jblk9P3xRpHoN4/WrG93yOMwMRBqRMi7H0NqGyaSuE91Gp8G/scG8EYswpat7nXzoKJPR3KuaK6mGYi9T1rf3mGieRXf/BFnTIIAy5XzDiwgVCJTC/aFYLemhCJT+ybpDQvAnr5BBC523NmIeBnxjdOOvletuetLxnQa40Zb95Wmatcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr5hYE2MjitqgHGyHACZ4oJHYEBw/77lhlXXYK5XfZY=;
 b=Jo/ZHPYCkVz3ur+EVPFvw7DJy6UWyzSBHVNdNUm2KoMedS4N+phvk8ArHWwYSf34rrTc6XQ17aKd7NWOYvi8stJhxE3gRFUsdxhQHRfmRn4AaTSAQPFdPxerI9BHgkjvqPyejVlZbo8qQWDBKo9YQtOFsn7UuHTZWp6Jc5UdzXI6O8nR7yTouTv/di2K8wWuu5K6P+lDipjYWdqiWAs8FSIw5UbkcA9Wn8CHGdYtxkoCHCKNi+TzyYyz8tTQO2zs3i+kEFa73DF4HZw1VrFML/t3z0KuL9/hoLzLuR3oDthzHcJpyg0OJum5wI9oTsYX/OJneBuI6pMwiHWyyw+5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr5hYE2MjitqgHGyHACZ4oJHYEBw/77lhlXXYK5XfZY=;
 b=YcSZm338EfrOh42nSjE9JnMAu6F+OxZS+CgK6WkhVFpC60r9WKUHNwrPWrylrQmjYNIzEQvTRff/5srdVopomBvNJ+Fe+IOEvUzAG5FVuHBMFeTitsLKbLZ+1LDFsZduvk/J5kVP3O1lInpIDeXuL2FrfgbIM+Z2EKF9+2JIn0KG8vH+ljjs/ypLI5IF7fu8XWI2UvYuBw3Wsdqpvvp3cYgMH0WZGHnmhU5XqWZcbSAvsElY93TuIEQINoyja7SBTEjsoD86pR8XSfb9TtK4kuJiEhyTMKOzg9MIZDiAn/d//ZjIwNPVUCxOVAUu+UGX7uV7+wlqC7dfEYWPIAOQBQ==
Received: from MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) by
 DS6PR18MB506175.namprd18.prod.outlook.com (2603:10b6:8:418::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:55:50 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::11) by MN2PR01CA0049.outlook.office365.com
 (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed, 9
 Sep 2026 10:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 10:55:48 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 35DD540BFE04;
 Wed,  9 Sep 2026 03:55:48 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: philmd@oss.qualcomm.com, 163wangjack@gmail.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 02/12] hw/char/cadence_uart: Add BXRS register definition
Date: Wed,  9 Sep 2026 03:55:29 -0700
Message-Id: <20260909105543.1478008-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909105543.1478008-1-kchiu@axiado.com>
References: <20260909105543.1478008-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|DS6PR18MB506175:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c84684a7-3007-496d-dc33-08df0e60e87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qtI6J0EZ73vhAgR7WvbRntH9wXAriAQq154Ycm41LN2J4Zy8D+gqLUiuaTniXRuZto76bk/SxlcM6LPBYB4+Yl4B2r0nJ0xkQkngwwGCN7kY8xecwXiwWexQBVOD+drQRAHFM2DoyRwvVKn+mprQXEKczfKmxRPt/ed+P9hX/fowvR0CGGb90gDeQL6LP5vsv41/J+tDz4+FKCINdxZC0Ar50LKiJ85XS3sViLlFKxweD6dXBm2o5Y/uRgLtensGAtKBdR8lHrJa4cukrtz9S03/10xLtXhlOFYF/8OKEBD2xho0/zu2tVBPPSjJ+d5ekAW66Qv0v1COReGKBG/7tgwRnSYPfDDcWZUvb6VmEDHd++elI5U2S2QXCZLjKmwAio/o7VjkYTumJmhSbRqNOjZPk/sfEdiI9y3w+QL1Jb/Si8zb9qBvlrQLctRlYnO1gdo4kEse5VwKjWLjt8o87ZSw+LmBdrbXHaYZE/Vcqlu/2Do5AXn4dyxfoMlZqVNDCXdRx51P4U6is/bbl5DNdlIlpIkeQVacO52N0iSrBi2Xu/6IREctpXGjUUTez1ldd2svuHnxwuSVQ8GoLEFkI93hlQnLpGRvA1EYOAyBnHb/bbrkjZJ8bp3twCW4UDblS2X3G9CeBHFbwWSvF+6IKAt8/CmIZ6ge+SXr8X11240ih2F2pP4hiKZVzUhH2bbY2OahCKMDGJ2RZXzd1wzjLA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FUWT6w0WXHNGE/lWhv0PkXk+GhVzUKVHmrKG9FYM6Qv69hkEUBk/ioajfFcEhnzIoFk2FKlflYnpn5yA21yZEiBc5ynyCQYOZQB8RitDMKzShOvzMwiwKB3lb59GcTeqiH2bqFQ8EbzLkwICq/5Cen7cgelz44yi6b0q3wjuQ+a+RCXF/ItWSDDTI0f+qS6g8r5Xtg6NdgptqehrkpZVpLB/1EG6cCRtCV500Om46iGySx5iZGXGT//oyjuOsyQgR+xLal/6It6/oeedS44gNcMWAunsHLLBXJuvzqmmPC/yabwu6VIN8caoPX9R2wi7t5ODl8g/Nj7WWm4fztysuj/EAuC/Ei8gkSelAwWaQ/lOBGEtlL99NQx67/12J0t54XRTOhA8axHw4JidrvGms2pYqDoJAJcDnVQATxQbeZw4CanYj9L6fj+5J1JyVL1S
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:55:48.8576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84684a7-3007-496d-dc33-08df0e60e87f
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR18MB506175
Received-SPF: pass client-ip=2a01:111:f403:c100::f;
 envelope-from=kchiu@axiado.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


