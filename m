Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DE2FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINXt-0007HU-CF; Thu, 30 Apr 2026 05:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINXn-0007Ge-Ko
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:18:52 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wINXl-0005d6-7I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:18:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB/L1Oz4gJ55akf6VrOu244fUS9FbZ4Sd0LiEZNZ4SQnC4W+kig+kDGDDYKeizx7YB5b0+Rn9Zl2rajBRwhsNQ0ZvB0DzWoVAPmC9SxWfUgZMmH51l1EidVE6zHQezVzjTjuuMWzppECkUA4PLi56xyuKvyVIz3EwOUBqX+oUlmdvhhIC243iTuY6vwFDOVrTf7vdw7oosEUz2denZyeXpfme98tRpcG3f+mSW2wB5j1iUI7WrBHykiFzJkcw2ca6/vwwKm6dryv3SuoxaiKIBogq/Z9sMEizMyh9Qxjia5Uf7o4CyZ3BAqicsezXxA2Bo7+FtAJ7fYB+lOIYS77Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQORqzmq212r6OC/ulsYXrIxCwa6X14bNYVIVwgQ1xM=;
 b=lW4SLsYjFjaAevwmJ2w0Wy2lGA9VwSAvtCe+F7ryZJIIosaI35C/V7nBkwtbr5ZnxhH1Akx/HvYZDqnvnmPoyWdIh9yhRuHBOj80TWdyokyQBVN/bgUF50QhH7KqTV1Hw7t4RlsPq2m3BtCvxm27ApBTXdTFwWH6dg0T2gsYfqM+KKRQDAv3KgvfVau8OznYn3VUTv4KS29mohnt79yV5DVh4+QNrIEbt86iaF6nW7ziLGbZ0WfsQxsO9qPtaB9sWFql8eNQP6jhkzhF8syc037LsYxLQOObT/t14A/bDSlb5cjdSLOco1/yPWzt6afN+UXQ8X6G7ORMZnFAckURww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQORqzmq212r6OC/ulsYXrIxCwa6X14bNYVIVwgQ1xM=;
 b=w+lPCXLWYBadQJO5t8sU/2y8JiSNCFlNHovN3uo6IkCok/rnFRNZ0zJLT30J/JzRGSAd05baCBN/tk18ox+KuI7peZcSkGpCVNfGLxNjGaWNGOGv3wBjKt7NGXS+LB6wSUwO+IkCpvF3QW4M9edD0cnUZNCqOlIBfw8w73Sk4jW8ffAuI3zIVevLhRUVJoSM0z9N2a4G6MLv5W8tOPG5PlOcqmLO0tmHyriFJDY2SG11p9INZmVf5B4IWPxdsdH0KERtlDUXWYtuJFa4Nu7XGZ9dXaYpoLOh1g7/9BfGDMxbX4CRt6A0wv0kFtD9g1NbWga1Rh9l7kCoYkRjdKigQw==
Received: from DS7PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:3b7::8) by
 EAYPR18MB988350.namprd18.prod.outlook.com (2603:10b6:303:2bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 09:18:42 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::78) by DS7PR03CA0093.outlook.office365.com
 (2603:10b6:5:3b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Thu,
 30 Apr 2026 09:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18 via
 Frontend Transport; Thu, 30 Apr 2026 09:18:42 +0000
Received: from axiado.com (vm-swbuild01.axiadoRD [10.4.1.181])
 by smtp.corp.axiado.com (Postfix) with ESMTP id 4E1D34186B5D;
 Thu, 30 Apr 2026 02:16:49 -0700 (PDT)
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v2 3/4] hw/gpio: Add Cadence GPIO controller
Date: Thu, 30 Apr 2026 02:18:31 -0700
Message-Id: <20260430091832.1846637-4-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430091832.1846637-1-kchiu@axiado.com>
References: <20260430091832.1846637-1-kchiu@axiado.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|EAYPR18MB988350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46fc2e3d-8da1-4d00-d5ce-08dea69978e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|34020700016|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dKC/tt8rE1BaBhXLR+juxEwoCz+1k0yJDxmXBWsXWQsP7ozF3czPmgkk6w+uoTMPMaGIrTGk5QEP+LXBZT4IGDB2sXQw9k/AnKTS6Il4xhHCYDFRqwQf/xTno4VWqZUZLJmsIB0jh9h1aIK5DzScQLULThLpfqDBbcc3jnZdCunXko21+q9Rg2fBGQKbVLtg5DGMd6weOVbnHVujwD4pLqRKl/7p0z4RngVTHTby6obw1STl9BQsIHjaHQoP0TjXNOZpxw96DfpdhFgXRc5Jz3eWGMaowpjID7QoXr6KznixplEK4uAn3cLAxsmJvuYKNhmzTa5rlZTU/rQsy6NUDj07Ey1OcX1rbJBIji79TrCbviPz8Ejw4YjNGP8ZHpC77Bd+oVF++0WbvQsoQQen8j3eHV+1jDcbW2iq9kh1VVe1QSSXOG3RjsJiDj4cZCbEkdAEYhpbfkFv+DXtRLfN6vM6zC6umQuzQkMUrXAVowz71hJbd2wFMjMcoJ7fb+QNaJD2Dv+zird22WPdGKurAvdBzTc4AM8mOEQl4D6I7Ty4vSujQq52GblKeDuS0coaFXGQOnxkoJK8dCy2aCxdpUwQZ26wYRAx3RsAY/aLX3NxFkA72gM+PaszIt2sM8MIiCVxVlX84Gh+0vjxLLeM8UW5CrUs6kgdSkAk07G7E7W2OUklNUHhDdIUwlKkKEicfnEBK+vTjUrQZMvoqhzw4cKv6Js8V1gPcVdEtKbGogWXx+2t973KtzfY7iRsozAvKPQmegy5azn6bQB0B3QVJg==
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(34020700016)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Li1zs6hkkb/oKNHtHHm17Zy7KsWMD0imhZDMWW0njFxiYc/qXakj3b34Ps5DepmMS1Oohhw33+7SC2+A5XYhTGXUTji+E8oTBP0/x9DqlTjUIozUtJuoYti/4BlKcDnvDybFsCgq2U2NtMtXjOS+XCfxLSaiuJiRre9mV+wIglMHwQ7guVvJw2Z9BgboMEXaSY/ILYFqR6NurPnS9VmyvMPzTty9cDJke+OfP5pg9O3iFXGnf7LmKWl38VCAHUfJZWIiBUB++KyAZV4inBL97Dlz8TCpaGLgS472WmSQhpGf+jG8/DCbomn6A0ydoLj8PcItNfQogPuBhaKo0OCj1ZrziKbFPItQAX9CRVBCn2n2w83gGuQBXVOWLD4hjrYF5nEU/qSxh7SeF+wqfcplbludIN5O6aOQh0r9UVKwI4M6fY+x9mZ461AJWRpbBMCW
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:18:42.0249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fc2e3d-8da1-4d00-d5ce-08dea69978e2
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR18MB988350
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=kchiu@axiado.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

This patch add a new model for Cadence GPIO controller which
supports 32 pins and interrupts for level-triggered/edge-triggered type on
input pins.

Also define new trace functions for analysis purpose and new configuration to
enable this model.

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 301 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 include/hw/gpio/cadence_gpio.h |  55 ++++++
 5 files changed, 365 insertions(+)
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 include/hw/gpio/cadence_gpio.h

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index a209294c20..fcc7c70bd5 100644
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
index 0000000000..2410753abc
--- /dev/null
+++ b/hw/gpio/cadence_gpio.c
@@ -0,0 +1,301 @@
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
+static void cdns_gpio_update_isr_per_line(CadenceGPIOState *s, int line,
+                                          uint32_t new)
+{
+    uint32_t old = extract32(s->inpvr, line, 1);
+    uint32_t ivr = extract32(s->ivr, line, 1);
+
+    /* Deassert in bypass mode or not input pin */
+    if (extract32(s->bmr, line, 1) || !extract32(s->dmr, line, 1) ||
+        extract32(s->imr, line, 1)) {
+        s->isr = deposit32(s->isr, line, 1, 0);
+        return;
+    }
+
+    if (extract32(s->itr, line, 1)) {
+        /* Level-triggered */
+        if (ivr && new) {
+            /* High level */
+            s->isr = deposit32(s->isr, line, 1, 1);
+        }
+        if (!ivr && !new) {
+            /* Low level */
+            s->isr = deposit32(s->isr, line, 1, 1);
+        }
+    } else {
+        /* Edge-triggered */
+        if (extract32(s->ioar, line, 1) && (old != new)) {
+            /* On any edge */
+            s->isr = deposit32(s->isr, line, 1, 1);
+        } else {
+            if (ivr && !old && new) {
+                /* Rising edge */
+                s->isr = deposit32(s->isr, line, 1, 1);
+            }
+            if (!ivr && old && !new) {
+                /* Falling edge */
+                s->isr = deposit32(s->isr, line, 1, 1);
+            }
+        }
+    }
+}
+
+static void cdns_gpio_update_isr(CadenceGPIOState *s)
+{
+    for (int i = 0; i < CDNS_GPIO_NUM; i++) {
+        uint32_t level = extract32(s->inpvr, i, 1);
+        cdns_gpio_update_isr_per_line(s, i, level);
+    }
+}
+
+static void cdns_gpio_set(void *opaque, int line, int level)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(opaque);
+    uint32_t new = level ? 1 : 0;
+
+    trace_cdns_gpio_set(DEVICE(s)->canonical_path, line, level);
+
+    cdns_gpio_update_isr_per_line(s, line, new);
+
+    /* Sync INPVR with new value */
+    s->inpvr = deposit32(s->inpvr, line, 1, new);
+
+    cdns_gpio_update_irq(s);
+}
+
+static inline void cdns_gpio_update_output_irq(CadenceGPIOState *s)
+{
+    for (int i = 0; i < CDNS_GPIO_NUM; i++) {
+        /* Forward the output value to corresponding irq */
+        if (!extract32(s->bmr, i, 1) && !extract32(s->dmr, i, 1) &&
+            extract32(s->oer, i, 1) && s->output[i]) {
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
+        cdns_gpio_update_irq(s);
+        break;
+
+    case CDNS_GPIO_DIRECTION_MODE:
+        s->dmr = value;
+        cdns_gpio_update_output_irq(s);
+        cdns_gpio_update_isr(s);
+        cdns_gpio_update_irq(s);
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
+        cdns_gpio_update_irq(s);
+        break;
+
+    case CDNS_GPIO_IRQ_DIS:
+        s->imr |= value;
+        cdns_gpio_update_isr(s);
+        cdns_gpio_update_irq(s);
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
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
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
index 6a67ee958f..0555f44b6a 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -19,3 +19,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_CADENCE_GPIO', if_true: files('cadence_gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index cea896b28f..80ca783a03 100644
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
index 0000000000..ed3f77b894
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


