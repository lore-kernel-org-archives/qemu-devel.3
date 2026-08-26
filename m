Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966D8C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8Lx-0005Dj-1x; Wed, 26 Aug 2026 03:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lu-000568-SO; Wed, 26 Aug 2026 03:47:18 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wz8Lt-0001ZR-A0; Wed, 26 Aug 2026 03:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9FUO9y9E2K2x3gjLp3PjWUUGukpQvIlhg2YOAmAbXYfN0UyKt43r+zDSlWh+qaB/UjUqZ6M3v+TvVwIuKnYENvrMZDB426NtWnngZrIiJDeX+hewo0/6MLVqq5WbthwGyrLorf7ND+5Pqik0ZfST9Xd0lg3i/suP0Ic2CGGvpOQYuBS3aCBnL0VF0T05tT5jDpYAUIcDuLmVxj9Uwcw41LOcLXcniBfTGdbz5ShnBomWNyrZZ1Ki7sRLD2w1CMGgHmwIgmHlMp7wllu1sn8u/e90tL3c2A7erRqJU1hMjIzZ0WTNnnVLsNtasynY16fN5u2nLBZI8+3JVHHid/+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8nCE9KWLYwydIsoUeawkHA1OS5qF+x9/GgKpKeoJJ8=;
 b=P9DJ6uAqrjuIPJbl/AYBzsckaaOXwNdUwRImpSDf4GEBGZwLYcjjY3LsVd9PqmFoBJL331MlM+Fb9MpgIR/ZnRvWQQ1QVyk31F7bYSTrJ8dGmS+eX/DtMRG0Bp2eVkXQnGqfbq3X/gf+hn80ygo64IcgTYvgjBPDL7px3n8deaRryNBcFVbNDNNL9/6WXuQ7TX/0U1Dy+5aJ8Z/urtrNpwrN2p+z+G4D7GbboYZFX+KOocbdpO/MrSfFh+gw67DRgJcYblYfUwODI0qMLcQ9prCt3tOCcT/uOnpXMjQn/qTlt/VzPIEmyNZ5fPPKruoeAW5icwe9wwtgTU2QJ2qGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8nCE9KWLYwydIsoUeawkHA1OS5qF+x9/GgKpKeoJJ8=;
 b=k4onWHtl35extCwS+ujGuEOezMmjq2kGmdAKmGgjUdPc5G3ibVW1weYo67UCe7kbucjZIrfBvP+Ev/SdLZ4zEZJ4AIuk9KSqmGWfGzMYBfjgEiRYkIwAppiAqWLB78UwdflA0mKp9RyG061PXuIPxI3uTkQRlJ7VuQ3Lae9S7IzFiZnCRIhSNrO1KhYcvWy+VY+2h34OSzb0zw3AhX+Y8LDCGcIrkGTn2BZzOY8EMD8sMb2VQiQvz36UvDae0DjSNDtzWepWqw3RmdeNm6zNaW7OZUPf5eelW+pHiY4ZggCvHXAeScNiEHqAD9Vn/RH+5anJy95yZkYusSIUAdGWCQ==
Received: from SA1PR02CA0002.namprd02.prod.outlook.com (2603:10b6:806:2cf::6)
 by DM4PR18MB4367.namprd18.prod.outlook.com (2603:10b6:5:39f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Wed, 26 Aug
 2026 07:47:11 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::7e) by SA1PR02CA0002.outlook.office365.com
 (2603:10b6:806:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 07:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Wed, 26 Aug 2026 07:47:11 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id C0E4C4186B51;
 Wed, 26 Aug 2026 00:47:10 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v4 4/8] hw/char/cadence_uart: Reserve MMIO with dynamic size
Date: Wed, 26 Aug 2026 00:46:30 -0700
Message-Id: <20260826074635.2850931-5-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826074635.2850931-1-kchiu@axiado.com>
References: <20260826074635.2850931-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DM4PR18MB4367:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d8d2936-5711-44d1-6104-08df03463cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|6133799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: etCQJeOfSXPaUnCpH7G2L9YB2X5GHmCbbIR0TnwVStaG+yXai8axcW1xFGXOuyRYiuMj6PNQrBKJalaATSbdu2jyIUBaBN0yzBY+PYc2sM6u+hqOAzrMVbLKLbmYRQpwqjqOcIsut6TgTTEG9KlmAm/SfyKxz+1NZAQF+cd9Ol+W+YT119UXXgHBDmFuUu5V4224Z3yP7fBo3pPQxoL3VkB0NXSXlVJhWjGd8m/JzO7hKiENNzfxNvW+avyxSqER0IKAx8EHLPcxy76x/mopT4amIkyFS8/zzSRlIaLsNsr0Dut9dLZExeKRFv04m1d3/aR9E0bTn8e2453BkDvXDq+MPuEFw3l5By8XsoynFd1i2xz8TV5E83Oi59IMSqyWwa+ZKs3wVEJz031yKKuDhVs3saXMs7lP91ZUooHeDVyrpmUqvEeqhQiB2kyDoyYBiuq9oTPY3RPnO0HdLHvM27fXp+0lAoLUEehB7F/8i4SqU5MoK29vRusaC6K89QTfoX7r4cgtcbwUxDXFTsrUx6KbhN/A6rwpil88j03HVzBz2iAcDjkvXPYDZMidPr8WHCg75xJ35GgQFGm6Iax0BkYD/tVGd+Atqe9b4mHM6AWTyrQEISeA7SbV8YQswPDsBnWsfv3vnAZCBTb2kQt6qT3XYIXH4kzXy/wUognoSmOXN/WeS6QwqxJuNohg7ZlKYHtY+mNG1fiMyrzfMOuXIA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2dIE6Xe1Tvtjw7E1ACIzvV6atdZcBMPvd+NlgNuC/S8x2ygGsB8R4r3ONpUj9OZKRtUrE6JAznDynl0LYHkTJRL7FzB70aSWFdHKyJ3oRuRCSEd7veopwJI5f0o4krynRx5EfgmvCHKKXGDkXoeZ0GkRWBX6dAXkS6Qes9yon4ioduhz+YuNP3B8LK1BgmgK+FPzr/zAoPbqaAgb4cddURB8/EIV025CQQ5J2B9n4w5PE+Rp3+GehrQnJZ9v27aTDAyhhnPI7i9zQbDOArPLkXIIXfPtLOHf5fpJ45Gj2AglZfJDTHJuYtesJNOM+uJqT+SM5qNvwnoBxY11OC90ivhUHSKeNAbkeNUBLI2ElQNxgQE2IWDtG4KQYfcrREf7xt76/zKb4G1nrQs0mCzbFT+nyNveWzsE5IB6p2s6rbJf9ssyN8xPxSSu99o7SjiP
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:47:11.3604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d2936-5711-44d1-6104-08df03463cef
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4367
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Candence UART model is reserving 4 KiB for registers statically
For other SoC models, the MMIO size may be not 4 KiB which would have
overlapping sysbus regions in QEMU

This patch adds a property which allows other models to revise the MMIO
size and it is 4 KiB by default

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/char/cadence_uart.c         | 8 ++++++--
 include/hw/char/cadence_uart.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index f57cad57a8..d83c71b877 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -541,6 +541,10 @@ static void cadence_uart_realize(DeviceState *dev, Error **errp)
 {
     CadenceUARTState *s = CADENCE_UART(dev);
 
+    memory_region_init_io(&s->iomem, OBJECT(dev), &uart_ops, s, "uart",
+                          s->mmio_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+
     s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                           fifo_trigger_update, s);
 
@@ -561,8 +565,6 @@ static void cadence_uart_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     CadenceUARTState *s = CADENCE_UART(obj);
 
-    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart", 0x1000);
-    sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
 
     s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
@@ -621,6 +623,8 @@ static const VMStateDescription vmstate_cadence_uart = {
 
 static const Property cadence_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", CadenceUARTState, chr),
+    DEFINE_PROP_SIZE("mmio-size", CadenceUARTState, mmio_size,
+                     CADENCE_UART_MMIO_SIZE),
 };
 
 static void cadence_uart_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index 0f97e19112..585b00badf 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -31,6 +31,8 @@
 
 #define CADENCE_UART_R_MAX (0x4C/4)
 
+#define CADENCE_UART_MMIO_SIZE      0x1000
+
 #define TYPE_CADENCE_UART "cadence_uart"
 OBJECT_DECLARE_SIMPLE_TYPE(CadenceUARTState, CADENCE_UART)
 
@@ -51,6 +53,7 @@ struct CadenceUARTState {
     qemu_irq irq;
     QEMUTimer *fifo_trigger_handle;
     Clock *refclk;
+    uint64_t mmio_size;
 };
 
 #endif
-- 
2.34.1


