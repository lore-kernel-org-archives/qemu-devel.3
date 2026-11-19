Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05560A260A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256 header.s=selector1 header.b=MPm+T0gD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwN8-0004RL-HG; Thu, 19 Nov 2026 02:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLW-00030I-N0; Thu, 19 Nov 2026 02:14:15 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1xTwLO-0004JU-Nu; Thu, 19 Nov 2026 02:14:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjDYi8j7tS72lFrBk2M5Xa1bw9O7J/IOGMwJT110TYO39gtY4oP4p1FTmC9E5h9hXOtrOSe8CQhtTe4GDHCG45KBPA/pofL3frJ9Eo7bhjbdynKmjp5H893xwEg/CG7wfN9j5yhSjaFLb3rhFZpIik4yG30KdMobbDuNSF1Z7W/rbLd8OpwjNOdOepIQHiljOZcvPjaKmEmviT+FdH2z3Csv6ejijOog7fWxpetnJQzlpo69cflKrGQaWH1R3BfS0o2IYKO9KbDevkq7NHsgh7e7nr1r9o/ngfmDDio209imgwDialpWJCvVBI7fryt0VEA6seu8u1JP+sPjg9UA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr5hYE2MjitqgHGyHACZ4oJHYEBw/77lhlXXYK5XfZY=;
 b=vx6qX4e13ztd19lbgzeMEsPcp3fLbcEEOEz1dDSFlpg41AnN2do5s8FprxNpQ95J5zF+F/+8+g4Rw46v/O6yrdoGS3ls6OqbZ5IND6bdsmHzx/lKc8MWdduK83TOo1y/8+TmPK8pOUPhShmY2/HRFaQU4N6nYEXxaA5N3YuKbCQ0zfoNylOdlCc/X4/7Mze5oDf4J5K6s9wmAbkY9f+I59ZGczNvRYI8b0Q19pd3kt44YybxQ5GzbBTUhPT67RmxR+iPcwqverQU4owDcfL106as9yW8pH5DJZ/WiubSZiILRhjZA2M161JKXf6qVBeS74KimJlgQnxoJmH3LbRGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr5hYE2MjitqgHGyHACZ4oJHYEBw/77lhlXXYK5XfZY=;
 b=MPm+T0gDsCg3bECBPvqY4nmLphPctc7tPKQySUamNG+Vz3iA7NUxVoRvCPWtC92j9yOLIxyfL0l7P6wTf7PMBhJ9e7Et4JlVGPEJ5Rb632dPHIJxT8sK/l84dbRL7y4TjBXiKGXG/sR14ZAFTSXsm/m8F/R/syrKao7S7qCXRvSeV119zqQpQOmQMSqddXoqFGMGrk/+wQtzUrU2mcDciOKq7Yz33Elv/zqAmPAibAPoidjub9yEaurp10epmqouRt1lojK6WT41q6q5jRZ3PxsHizgc3uIokPLB8ctTPUkO03spVhZRXlK2rOQtHI9I/8RbsxJ5AuvF71OfdP+klw==
Received: from CY5PR15CA0217.namprd15.prod.outlook.com (2603:10b6:930:88::6)
 by DS1PR18MB6361.namprd18.prod.outlook.com (2603:10b6:8:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:14:00 +0000
Received: from CY8PEPF0000005A.namprd21.prod.outlook.com
 (2603:10b6:930:88:cafe::8) by CY5PR15CA0217.outlook.office365.com
 (2603:10b6:930:88::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 07:14:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY8PEPF0000005A.mail.protection.outlook.com (10.167.247.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Thu, 19 Nov 2026 07:13:59 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 17D444186B59;
 Wed, 18 Nov 2026 23:13:59 -0800 (PST)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, mark.caveayland@nutanix.com,
 philmd@oss.qualcomm.com, 163wangjack@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v8 02/13] hw/char/cadence_uart: Add BXRS register definition
Date: Wed, 18 Nov 2026 23:13:42 -0800
Message-Id: <20261119071355.3520249-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071355.3520249-1-kchiu@axiado.com>
References: <20261119071355.3520249-1-kchiu@axiado.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005A:EE_|DS1PR18MB6361:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a42771b3-7b55-4bb9-f2ba-08df460caf19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|6133799003|3023799007|261021123027099003|56012099006|261102123227099003|261021121427099003|261009223027099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 7mtR8J4CogUjlzwBfdUU90FMvZvRzpWYyb2O5zypulWrFU/MLnyL6UyI/ByRvttBUgFg7ummTDZ23l2VCSx8pK9e9eT41KTjAJhcpI6GVrdVbipHf71rwVa31GqMBRHd1YgqilhSlFnaDCOdzVFClE8sLnEQjYVN3LqFoQULOdfw1Zf2dOJYTGk3pr/uuqHUgPrp0eJUSaKHD8m0avn28sbWifnPJgKzazHbtf8QtVEytKUsaYTcFK5GWLQC46EXfnltimA965hAF3B1yRr1YLN+IY+Al8aOjVPvLFFHwltk9wdzkHf4+bK3bp4zRga2oGSXS8nglT9hRjbdHmxnInupuR9lvLVJLKbVdNORgJCsCWMDmc0DWVeT+H/dIygotv0Wumc/0n+uUK3Lj4tQI1IxVPeYs/+HInKYp092k/vBxezeg8G+1rHL+r0nTUH4BfQKZWp8U53YawMRySC8MOrNv8HCiHkgLcgQSAbiI9gDmU6YHeEfOOm4WcK5wcw2HAor2eAIItlMB2w/RfE5IWo6MzV+kLLOjrFOymkD1Wj002vYye3+gQRXsIG7uU0zKdlKoFCany3OFIjGbUF7Zc8icR4vWUk/PytbDNrn3ZnNNfABmPxFUjOM851SRruZ1cS7MuODSNFSmrEukBRClSlLa4IjC6TqvFt0VxdXIHiFjZrfnrwbdky7Y1R8T2/v0ds9sErWmbfUUCdCdDoshg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(3023799007)(261021123027099003)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003)(10067099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B/8qkP9FPtz6Tis1jG+HGBsLp99HsWIm2zIFlNwrb4MihVs5QeE1ZfAp1CrWCTFjRliYX0FpcBXYIbisyHLqUlKgUboLAOwLq4Szh7g8Wkl7e8Hf5CreR7KmJBCifDGTPOU9H/dNt3C/NDBAtXIqpzj/94YX++XFzQe4AKriHwysORi2bxSqikAvgwVe1w2TBCGp77/C1TL5YsjvHK89AmE1nh8oY4rfFGjRMnSTrzyP1l003685CwRb1X+814dI2382LdUR3I8q+UCRnKJ0ZD/Si0TjUB2jiq4gj/Es2n2WqWQE85Ps810pWRGm/Nn9cA78anI7pMfJDAQNUMn5iOBiaCodLyyKA+Bwp90DDCKHlDtG5sXQuWPvvJSkZM1OTlTHGf3/hrq4ep+uAVaDrkAMkoZSDQXxmMCZTMNSfNoyuJRgi3bRnq/Drn8D7xrp
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:13:59.9513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42771b3-7b55-4bb9-f2ba-08df460caf19
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6361
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


