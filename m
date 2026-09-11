Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF5BC79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tcA-0000AU-G4; Fri, 11 Sep 2026 01:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tc0-00008E-Ky; Fri, 11 Sep 2026 01:15:46 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4tby-0005iU-9w; Fri, 11 Sep 2026 01:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSWEBDckvhm3szjX3PY3P24/lSMPJ7Jzp/XcgMMmD0vhw0hxhSOmfAygs/PjIEoHpR88Z7Cwm8V9/b/MXU+xlA3k+n4nATFpgqwzBR0STvKO+QxtucEh6ZomqoPLMwNPVEow58xdRyo/zOUOyHH7XmrnQu6Wi01kzAoZzZfhlqf1v/Cciakzp7p6NCKbzuptwPwmDYzba8KSKiyVo1TG/AYMnPyqxKOWM/N1KVzEAvlnpG2D8N4PuCkHIhKI97Z8SFn27zyLK/JYbQcksn9YFKjAFZW0UcfEMToa8QdbhMC5tO/WNUfCNczxRgJZEJQnfU5KnWmrtB/y9CRYAdg3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr5hYE2MjitqgHGyHACZ4oJHYEBw/77lhlXXYK5XfZY=;
 b=MvwxhazcX9cfIieBE1aiuXi52qXuQNypNaWQTNOV6lr6pWBK7tkhSh0IvxKbbKPw5ob6jlQN71tBp3oONfQirsy0MZxS8jfVScEDJ39g9dFwzulXeVFQCcFgoQPOcMNWD/6n44SltYnbGsT+YZoUZAiLrmZB+3MFbkP6At42tNZShV1AeIoiTWCgAT//QRKQWeQGYvSZ3w7pnYUCbj5jvUCrydUHKMoxe3P+BaoRGIMJo4M8pS1tkzX2ftThkX0r0WIMXNQS9EgyOMLT88p1wiE1GHZWwXHL/o8bfCPUk443bsW7lvynwYNJDsb8x5kFA/Wn0vq8jAS8G+Z0hEJJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr5hYE2MjitqgHGyHACZ4oJHYEBw/77lhlXXYK5XfZY=;
 b=p0h3TwQMW7DjOsxmJQMQcOPWPcQAXSpS+NTYJOYE+1ZALtm0pBYOfqN+fdQzeyl7ETajSnm34BTLUGqDydQl0d+ZHWIqzbMq+8wIugVyLI5xEPxBSOCHcCaU5G9uBHUuwDaYw+1IpRlnyiAi82G4fo1zokYIln5BihqxM5jAVMPcq4S3Gqp9DHyrBmvB4hDNsItN2HKtYk+Qay0Wj0oTkIO/mj7QygzFCv1UJlfL0BFjxFpzx9Pg6O+a/cKClzkwk+NB5NEVP3Dnbiuhkedh4nQVmRPaFXw8kzT6SZw7B9xeXNdE+e2K0dcsSOYY+KBH6+UpJPThwXHYaUwBbC7iog==
Received: from PH0PR07CA0034.namprd07.prod.outlook.com (2603:10b6:510:e::9) by
 MN0PR18MB5920.namprd18.prod.outlook.com (2603:10b6:208:4a7::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Fri, 11 Sep 2026 05:15:35 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::7f) by PH0PR07CA0034.outlook.office365.com
 (2603:10b6:510:e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 05:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 05:15:34 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 62D4640BFE04;
 Thu, 10 Sep 2026 22:15:34 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: mark.caveayland@nutanix.com, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v7 02/13] hw/char/cadence_uart: Add BXRS register definition
Date: Thu, 10 Sep 2026 22:15:21 -0700
Message-Id: <20260911051532.2378501-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911051532.2378501-1-kchiu@axiado.com>
References: <20260911051532.2378501-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|MN0PR18MB5920:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e956deb-bf26-4482-7332-08df0fc3b5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|6133799003|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 88fxXlbJsmPQV53ZFhGVnH5USE58+oe8sD4t9k9OwlOK9etxa0rRwh4IA217OLS03LDZpwFHX76FF1npPnY11L5eDAMmcifWKl2Tl8CHSDQucwmZ1OnK1oJm4GCz1g28fs4rAOgDckEyCB0YORvVXTRacIjoa4bp5uWo5O1bI3OdvQF7ycUcOsWmMWq0+/juLUgKylFJMYWbgWm0EaEsiO/6eO2YwEt6kOohazL9UOekdtp4pZVWtMFjdS7oVQFepIPq1D//uLJA2EGR7tEAC+HqpOojfSv2/YDb6xrHBvjVbETQh0EFv4lmd5TObB9+kVyPI8MPosLECvGZ92+jDePoFFhwOh2WpqVFtr4O+Ye3kNjKJn0J6G4+4ytwUEJJutZl2VJuZuCTXEDBg9+dExCPRYT7bc4qFnKuS2y59RR8cdF3sN2KoJYMj+aI3k47stxz8zwb4l2SGJQ7LIwb/4bbhEUoi1FnDXbDsGRvlkkcGE1MJbmWrbgLEXOhy8xd6YaZpiDrFxxv9j2P/4gDjdBgV1p9R77iz/9osb6uVab6b6qvnFRUav6vmVQLKJ7w0IQ8qJGw12i8qmZNeOxANBy9vdz0qVL/2CZzy1d4l4mB47H8+Ys5zBo4iUSfFO/wdiCJzMQllKewgn9tKA8mFL+1qrNucaGx2/QYb4nuPvE4HbJ1wzW9/RuUzDXsCz7RMOdRgqNh81FVufSdqEe06w==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2CBS3OnSnzgMhxDo3QeEvddNW2NwPgY0mSZUynWe5jsEleCiXNYVqVKVMWayLC7OZiP46sjDtzCxGBxC44Dt3Qr9yh2ATf/3jShJqNU1A7zbCgdTYRuKdLTpmrNMUori3sSNiXkCBO1Chc3rWeYZZbjdCSIb34HKNE3wVhCjU57AwyVRgBdvWvbE9idx2V/pk5DuwksudRxoZbgMuqpAaevM+ViV28DAVAZu19ukunuBsqDGo3mgekcHu7b7JcRFAPwwFovGKxb1oN5yzuClBRGPIWfXU30fd5zghPBCkPzESFxY9T2ciB+8kkaCKVc9c3002Pclu30HtcmBmHEsENsCgDF+iHLoVRH0T4YW7FHH9xBJWK6UfAxae31BkPsvrVmnokxT85MYzVNHZ6sTniBQVMDeFO4xCx+/HHe7rrBceMXdWWQvHr+W5oXAHste
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:15:34.9313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e956deb-bf26-4482-7332-08df0fc3b5a7
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5920
Received-SPF: pass client-ip=2a01:111:f403:c105::1;
 envelope-from=kchiu@axiado.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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


