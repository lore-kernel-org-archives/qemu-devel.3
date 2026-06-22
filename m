Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE7FCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbXnS-000547-VK; Mon, 22 Jun 2026 02:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmp-0004rA-7e
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:36 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbXmm-0006cz-8U
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 02:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZljEtRmcB3G+sN1LbZ0J47OQsPk5OP53Uj0Jp3pNv11JN4fk0ELp+stGk6NzpYRss9J35eJs+qFD+KgR7JPqafCRwbKR2c8lhDMgQDb4bdTJS62I8UUVVjRn/g/2ZvOilUKMcVnCyAQrO3nbH6wbiZOi0A5oQdlbYXEGlOD0h+qNreNmPqtO4wp1VmqB9hhb1PZrLTWDb4OV44vkyXRaPUoKSy/NHVca0QqA2kexbJO08k+493zwBdPoi5TNDzEQsEE65Rjf87coEsG2Tdd63VI2AdAkfyxVH/kNH2v13HRYHXsD5VR4z1bH4h7B2cp8GcG7R3sno8eKxts44VoN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG1ansV0CUtjHs6A6pOD9+gFy1I9aWqswt4hrJSt0x8=;
 b=vKpUamTfX/AW9ygtqVx7T+973H6dIWHEBMCtg7W3jX4cokwBClkTVg8OR1Y9sM5xot69tJ+G7Ju85CjRUEyrQV1wHiNL7g0yecuTjseQV96gGUAgGPcmuXQx8j2nw2lF1UodtisYOcFOyx6SqtdyH8i0XJhnPljpHmQRthhOKX5f/vYkYsbu4RyEayRUjcoAJEby5+V2sHqU6vz80q11MpXRjxCPrww7MAgfgdQt+9Q6gg5238KOVtJ7AJP7ruMLh/tuwujSEQBZherAt6WqcMQm0g/h1Z4iciuw3tXYCRl0lKnForBr/1SMeJShMK/3QlC9FU4NdIVmGwBTvH1Gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG1ansV0CUtjHs6A6pOD9+gFy1I9aWqswt4hrJSt0x8=;
 b=tf3h5CGxQMsDFQoimU1aR6IBCcGgxoKRG6fu3AvqTuUSrF1qinRaaRYFBrjhRd6hzQoIEvyvwZGf9OuW6oGxXkcVQKttHIHkeY3SC1tRklZ8PC4XBRf7a5XGQJTWscpjLXNhbGnaJk8J3OQVgGtAbiNgnicXA9fyue88kcXm7mny0YEERWFteb+CZupyU5+4NnRiSKeMmsTF5UukYa5y8a47m9EWOHt1Ox5NL0mD0RkKWQYJgl8E2wS8DLlDuSYnYG9pk8WWFLKSj5++g2msLamLey4F3jZsPEPIWbbTLrkWFm2NuETXmYCNa0mC1+PPM4XRZ2EaYd88PQbc/N3eSA==
Received: from BN9PR03CA0874.namprd03.prod.outlook.com (2603:10b6:408:13c::9)
 by SN7PR18MB5293.namprd18.prod.outlook.com (2603:10b6:806:2e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 06:05:13 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::66) by BN9PR03CA0874.outlook.office365.com
 (2603:10b6:408:13c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 06:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.0
 via Frontend Transport; Mon, 22 Jun 2026 06:05:13 +0000
Received: from axiado.com (unknown [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id B9FF040BFE13;
 Sun, 21 Jun 2026 23:02:27 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v6 7/8] hw/gpio: Add Cadence GPIO controller
Date: Sun, 21 Jun 2026 23:05:05 -0700
Message-Id: <20260622060507.83195-8-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622060507.83195-1-kchiu@axiado.com>
References: <20260622060507.83195-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SN7PR18MB5293:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19a8fa17-70aa-4dda-c86e-08ded0243975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: fPso6mVzqes6fmMKnINUOpNOpsz6nvTpi0L6nyT5DhzA/6cevGRJw6TL+W5BGo8JZllYnUGpqw0Ol6ItPq4yB5/K8Q4Vmbe09jDvqdfAXThXW8o+fNSQ7KyR44leTSzfquixPXaxBtjqjyMHiTnO9NiuU2TqtWwsbqfNYvfmNdRPF4CyamqkaRTEK3q73LTwUf9RWhe6NLA23kffoiFpX/TLH61XMYvEXOo+VtFxOOiFHwunI8LXPfR+KSZDp100JQqFX+vR1MdScGYPqjhl3eRwMr/nI10lX2er9bzvrSI9IcvrKtMSd7FYHI0sKhy8HCpB+kiiQtN0as8xPLeaGZWAmnD4HR0rb2AKfdvlSD8EfI+aJtlEZfV51MIZKWvQWG2XNxLxbEidGM01AL83RkN6SCssoPgdnOTGvImxdgo1Zu16jvf3gqhtlHA5bGh3j0+EOhJ+/TqqgEoJKiC8fe4lhtybkSRVhg79A5kipITellsJ/FtvAt1O29/5i8RLm3rXiHoo7S/D345NZvwUIJaRfjt1RPqQuaQo/JkGdrDB+mtD7jcktLq96SITBjeKXXie06LthL07SIvX630Rj3k6yWnxaCAPNHvQ4q+kPRaJvdEGKdv9nDSxUi9Zrail0kDW43+4qmQObfr6S/hZNCV4/DSI6SaIULBx04fO/i3yDtGOAm3a15pssXqAoP3mWCnq2rz61hVCs3hr7Bc2jA==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(3023799007)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p+sfeDA+UAH3Qsqde9dHdZkPJ1dvfL0O6ySAZDq0MYPzgj0PnEzZwv0Wc3jK2ruWbBgBqGh3R9/I+iGU1p8+kHlikXGsnAsANmRyWTXHofqqXRqRATTZXECWQXxWJJkRQ2Tde82pdJE25PAMIJ+eAHH0JQlz/K/4aO9tgm4iRF0eQCKAc0IdhNw6vJFoam7BumQkTxx6XKTB9uhB7oNq5rS1NCeV3puz0TAX8M4yggYo8ciLCQ05N6gJHs4gWJ8C41++35LHmo3OMueWc5xP9+P6Vv9uAMbkwY2RXSFNrWNz4PcvWa9ApipAkXJhuXlia9xFwzLDD9fzYpIFbNBESsJ5kmXKMO3KWg+wNuf1QeMMGgIJkaxpt3wok2KWs/VoWc+lj3nLXnoW5cfyqXrgfCV29RE/BAMkRuv5XgWxfy9HkhSkudtmjskWzTrXSMBp
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:05:13.2853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a8fa17-70aa-4dda-c86e-08ded0243975
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5293
Received-SPF: pass client-ip=2a01:111:f403:c101::7;
 envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch add a new model for Cadence GPIO controller which
supports 32 pins and interrupts for level-triggered/edge-triggered type on
input pins.

Also define new trace functions for analysis purpose and new configuration to
enable this model.

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 292 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 include/hw/gpio/cadence_gpio.h |  55 +++++++
 5 files changed, 356 insertions(+)
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 include/hw/gpio/cadence_gpio.h

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index a209294c20c..fcc7c70bd50 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -30,3 +30,6 @@ config PCF8574
 
 config ZAURUS_SCOOP
     bool
+
+config CADENCE_GPIO
+    bool
diff --git a/hw/gpio/cadence_gpio.c b/hw/gpio/cadence_gpio.c
new file mode 100644
index 00000000000..ce8256b381b
--- /dev/null
+++ b/hw/gpio/cadence_gpio.c
@@ -0,0 +1,292 @@
+/*
+ * Cadence GPIO emulation.
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/gpio/cadence_gpio.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+static void cdns_gpio_update_irq(CadenceGPIOState *s)
+{
+    qemu_set_irq(s->irq, s->isr ? 1 : 0);
+}
+
+static void cdns_gpio_update_isr_with_inpvr(CadenceGPIOState *s, uint32_t new)
+{
+    uint32_t new_isr = 0;
+    uint32_t any_edges, rising_edges, falling_edges, deassert_mask;
+
+    /*
+     * If ITR is set, this is level triggered:
+     * set corresponding ISR bits when IVR matches new inpvr value.
+     */
+    new_isr |= s->itr & ~(s->ivr ^ new);
+
+    /*
+     * If ITR is not set, this is edge-triggered:
+     * If IOAR bit is set, trigger on any edge;
+     * otherwise trigger on rising edge if IVR is set,
+     * trigger on falling edge if IVR bit is 0.
+     */
+    any_edges = s->ioar & (s->inpvr ^ new);
+    rising_edges = s->ivr & ~s->inpvr & new;
+    falling_edges = ~s->ivr & s->inpvr & ~new;
+    new_isr |= ~s->itr & (any_edges | rising_edges | falling_edges);
+
+    /*
+     * In bypass mode or if this isn't an input pin, the corresponding ISR
+     * bit is forced to zero.
+     */
+    deassert_mask = s->bmr | ~s->dmr | s->imr;
+
+    new_isr &= ~deassert_mask;
+    s->isr = new_isr;
+
+    cdns_gpio_update_irq(s);
+}
+
+static void cdns_gpio_update_isr(CadenceGPIOState *s)
+{
+    cdns_gpio_update_isr_with_inpvr(s, s->inpvr);
+}
+
+static void cdns_gpio_set(void *opaque, int line, int level)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(opaque);
+    uint32_t new_inpvr = deposit32(s->inpvr, line, 1, level ? 1 : 0);
+
+    trace_cdns_gpio_set(DEVICE(s)->canonical_path, line, level);
+
+    cdns_gpio_update_isr_with_inpvr(s, new_inpvr);
+
+    /* Sync INPVR with new value */
+    s->inpvr = new_inpvr;
+}
+
+static inline void cdns_gpio_update_output_irq(CadenceGPIOState *s)
+{
+    uint32_t is_output = ~s->bmr & ~s->dmr & s->oer;
+
+    for (int i = 0; i < CDNS_GPIO_NUM; i++) {
+        if (extract32(is_output, i, 1)) {
+            /* Forward the output value to corresponding irq */
+            qemu_set_irq(s->output[i], extract32(s->ovr, i, 1));
+        }
+    }
+}
+
+static uint64_t cdns_gpio_read(void *opaque, hwaddr offset, unsigned size)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(opaque);
+    uint32_t reg_value = 0x0;
+
+    switch (offset) {
+    case CDNS_GPIO_BYPASS_MODE:
+        reg_value = s->bmr;
+        break;
+
+    case CDNS_GPIO_DIRECTION_MODE:
+        reg_value = s->dmr;
+        break;
+
+    case CDNS_GPIO_OUTPUT_EN:
+        reg_value = s->oer;
+        break;
+
+    case CDNS_GPIO_OUTPUT_VALUE:
+        reg_value = s->ovr;
+        break;
+
+    case CDNS_GPIO_INPUT_VALUE:
+        reg_value = s->inpvr;
+        break;
+
+    case CDNS_GPIO_IRQ_MASK:
+        reg_value = s->imr;
+        break;
+
+    case CDNS_GPIO_IRQ_STATUS:
+        reg_value = s->isr;
+        break;
+
+    case CDNS_GPIO_IRQ_TYPE:
+        reg_value = s->itr;
+        break;
+
+    case CDNS_GPIO_IRQ_VALUE:
+        reg_value = s->ivr;
+        break;
+
+    case CDNS_GPIO_IRQ_ANY_EDGE:
+        reg_value = s->ioar;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_CADENCE_GPIO, __func__, offset);
+        break;
+    }
+
+    trace_cdns_gpio_read(DEVICE(s)->canonical_path, offset, reg_value);
+
+    return reg_value;
+}
+
+static void cdns_gpio_write(void *opaque, hwaddr offset, uint64_t value,
+                            unsigned size)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(opaque);
+
+    trace_cdns_gpio_write(DEVICE(s)->canonical_path, offset, value);
+
+    switch (offset) {
+    case CDNS_GPIO_BYPASS_MODE:
+        s->bmr = value;
+        cdns_gpio_update_output_irq(s);
+        cdns_gpio_update_isr(s);
+        break;
+
+    case CDNS_GPIO_DIRECTION_MODE:
+        s->dmr = value;
+        cdns_gpio_update_output_irq(s);
+        cdns_gpio_update_isr(s);
+        break;
+
+    case CDNS_GPIO_OUTPUT_EN:
+        s->oer = value;
+        cdns_gpio_update_output_irq(s);
+        break;
+
+    case CDNS_GPIO_OUTPUT_VALUE:
+        s->ovr = value;
+        cdns_gpio_update_output_irq(s);
+        break;
+
+    case CDNS_GPIO_IRQ_EN:
+        s->imr &= ~value;
+        cdns_gpio_update_isr(s);
+        break;
+
+    case CDNS_GPIO_IRQ_DIS:
+        s->imr |= value;
+        cdns_gpio_update_isr(s);
+        break;
+
+    case CDNS_GPIO_IRQ_TYPE:
+        s->itr = value;
+        break;
+
+    case CDNS_GPIO_IRQ_VALUE:
+        s->ivr = value;
+        break;
+
+    case CDNS_GPIO_IRQ_ANY_EDGE:
+        s->ioar = value;
+        break;
+
+    case CDNS_GPIO_INPUT_VALUE:
+    case CDNS_GPIO_IRQ_MASK:
+    case CDNS_GPIO_IRQ_STATUS:
+        /* Read-Only */
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_CADENCE_GPIO, __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps cdns_gpio_ops = {
+    .read = cdns_gpio_read,
+    .write = cdns_gpio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static const VMStateDescription vmstate_cdns_gpio = {
+    .name = TYPE_CADENCE_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(bmr, CadenceGPIOState),
+        VMSTATE_UINT32(dmr, CadenceGPIOState),
+        VMSTATE_UINT32(oer, CadenceGPIOState),
+        VMSTATE_UINT32(ovr, CadenceGPIOState),
+        VMSTATE_UINT32(inpvr, CadenceGPIOState),
+        VMSTATE_UINT32(imr, CadenceGPIOState),
+        VMSTATE_UINT32(isr, CadenceGPIOState),
+        VMSTATE_UINT32(itr, CadenceGPIOState),
+        VMSTATE_UINT32(ivr, CadenceGPIOState),
+        VMSTATE_UINT32(ioar, CadenceGPIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void cdns_gpio_reset(DeviceState *dev)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(dev);
+
+    s->bmr      = 0;
+    s->dmr      = 0;
+    s->oer      = 0;
+    s->ovr      = 0;
+    s->inpvr    = 0;
+    s->imr      = 0xffffffff;
+    s->isr      = 0;
+    s->itr      = 0;
+    s->ivr      = 0;
+    s->ioar     = 0;
+}
+
+static void cdns_gpio_init(Object *obj)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(obj);
+
+    memory_region_init_io(&s->iomem, obj, &cdns_gpio_ops, s,
+                          TYPE_CADENCE_GPIO, CDNS_GPIO_REG_SIZE);
+
+    qdev_init_gpio_in(DEVICE(s), cdns_gpio_set, CDNS_GPIO_NUM);
+    qdev_init_gpio_out(DEVICE(s), s->output, CDNS_GPIO_NUM);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void cdns_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, cdns_gpio_reset);
+    dc->vmsd = &vmstate_cdns_gpio;
+    dc->desc = "Cadence GPIO controller";
+}
+
+static const TypeInfo cdns_gpio_info = {
+    .name = TYPE_CADENCE_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CadenceGPIOState),
+    .instance_init = cdns_gpio_init,
+    .class_init = cdns_gpio_class_init,
+};
+
+static void cdns_gpio_register_types(void)
+{
+    type_register_static(&cdns_gpio_info);
+}
+
+type_init(cdns_gpio_register_types)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 6a67ee958fa..0555f44b6a7 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -19,3 +19,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_CADENCE_GPIO', if_true: files('cadence_gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index cea896b28f6..80ca783a039 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -46,3 +46,8 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s addr: 0x%" PRIx64 " "
 stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_idr) "GPIO%s from: 0x%x to: 0x%x"
 stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "GPIO%s disconnected pins: 0x%x levels: 0x%x"
+
+# cadence_gpio.c
+cdns_gpio_read(const char *path, uint64_t offset, uint32_t value) "%s:reg[0x%04" PRIx64 "] -> 0x%" PRIx32
+cdns_gpio_write(const char *path, uint64_t offset, uint64_t value) "%s:reg[0x%04" PRIx64 "] <- 0x%04" PRIx64
+cdns_gpio_set(const char *path, int line, int level) "%s:[%d] <- %d"
diff --git a/include/hw/gpio/cadence_gpio.h b/include/hw/gpio/cadence_gpio.h
new file mode 100644
index 00000000000..ed3f77b894f
--- /dev/null
+++ b/include/hw/gpio/cadence_gpio.h
@@ -0,0 +1,55 @@
+/*
+ * Cadence GPIO registers definition.
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef CADENCE_GPIO_H
+#define CADENCE_GPIO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_CADENCE_GPIO "cadence_gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(CadenceGPIOState, CADENCE_GPIO)
+
+#define CDNS_GPIO_REG_SIZE      0x400
+#define CDNS_GPIO_NUM           32
+
+#define CDNS_GPIO_BYPASS_MODE           0x00
+#define CDNS_GPIO_DIRECTION_MODE        0x04
+#define CDNS_GPIO_OUTPUT_EN             0x08
+#define CDNS_GPIO_OUTPUT_VALUE          0x0c
+#define CDNS_GPIO_INPUT_VALUE           0x10
+#define CDNS_GPIO_IRQ_MASK              0x14
+#define CDNS_GPIO_IRQ_EN                0x18
+#define CDNS_GPIO_IRQ_DIS               0x1c
+#define CDNS_GPIO_IRQ_STATUS            0x20
+#define CDNS_GPIO_IRQ_TYPE              0x24
+#define CDNS_GPIO_IRQ_VALUE             0x28
+#define CDNS_GPIO_IRQ_ANY_EDGE          0x2c
+
+struct CadenceGPIOState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+
+    uint32_t bmr;
+    uint32_t dmr;
+    uint32_t oer;
+    uint32_t ovr;
+    uint32_t inpvr;
+    uint32_t imr;
+    uint32_t isr;
+    uint32_t itr;
+    uint32_t ivr;
+    uint32_t ioar;
+    qemu_irq irq;
+    qemu_irq output[CDNS_GPIO_NUM];
+};
+
+#endif /* CADENCE_GPIO_H */
-- 
2.34.1


