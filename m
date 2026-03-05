Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5129CF3092A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy62n-0005lz-8I; Thu, 05 Mar 2026 05:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vy62k-0005li-3W
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:34:58 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vy62g-0002xH-JG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:34:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyMgONxKR6+d8D3qcA+by4CHdJKJO/94jgG30wdCedc3rHmqGNTkeY6/41E9RNwDS8sGychEdatX25cqT7KQ3ZZ+gL38O/z19hNBA24VbMPIQVoBExtQispU5t5TqE4HhVP+SDkM2s5iblCDxKG++b0ZWFqEd5i6HIhimADNI4zj9rLpqr98WkkAPSe7VQkrqI0uEAAl36pYhU9MGqnc1fZWCeZHAGRDA1yILKRuUSXJ4kX4Y1coxefeaZsotT1WLKwbMtntNyqaAP1WqAB0Xf6G3Fu5m2/yknI2mLQubIB6Ohwmh9nsGPDfwLtVAo++heuPO/iIKFbf5l4vhQLTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdOqrAzTPKREC9DxK9x7b6I24wRILdAitArhgeDr+DE=;
 b=CyfAxjnXsNbdN6IGtnLclSPCwYJCjRCQ8r21xq/2ybaCCLl5/3oPe7Vf3VsfaMRHphw+oWsLzqC7UR4u5sewXg5mmkCFuBVQh2HHiRmahxKwrr8TrPTeJUTf8jTHbrWQaLW5NRx6ttzR0kGhyt2DmIE6NuxlUY5x+PmK0Ict4/IdbYRNQ8CwbXnuAMhTrZbrAEsQRP5ul0Z9LLCcCE6vGCrMVk42C3m7pT9I+GLJQhstYPntEudEYdUbzWXzIUiVeee6QnhpCOGPNkzxgyV/ZD/aeudaqtISuExvAv27wnBXFE2AODkB0vq7QvUfqpB2n3XKPOguMXfs6CZRffOx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdOqrAzTPKREC9DxK9x7b6I24wRILdAitArhgeDr+DE=;
 b=nvttNXpQVBhL8fKq5WVwj78Px/pAdzLKkHuWEiG62QKbUYYTyMezv1J5D92BbL5RZSboq/Y7yx6u6DmrjOW/CV9R2lU0iWKfZBC636xOPQMboFIraL7eSDYqNfWhbBRCkUcGiQhAvsmZji2PP32yakmr46G4HywIlMogO0BXlP6rZL431QXqyOBVtR40aKKcDpFP1+vpWtCSlfrWVTnOqaISYbTo0rGnfCT+f42DvxuYeKAOjfgqFbo37GTVvTVDj5PDES4enmMzXWk1n2sxmymtGYLsP9uLOWMxwNUW/tsVtfji1I1BaPxBz7c1vq1GR9uWU4gal1hNmP05uSiycg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by BY1PR18MB6111.namprd18.prod.outlook.com (2603:10b6:a03:4b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:34:20 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 10:34:20 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 1/1] hw/gpio: Add Cadence GPIO model
Date: Thu,  5 Mar 2026 02:34:00 -0800
Message-Id: <20260305103400.1574217-2-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305103400.1574217-1-kchiu@axiado.com>
References: <20260305103400.1574217-1-kchiu@axiado.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|BY1PR18MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c57d21-8548-4fb8-3857-08de7aa2c261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|13003099007|38350700014; 
X-Microsoft-Antispam-Message-Info: VX2WhyUIdpc1bTgbLLnbitV2KgP6cIINgS0HCQYIvS397h7AMk4mcpy5qOq3zpY12JrvcwTAi2al4GiCCIbmYBNwN/Wf3zxbqKOex8TPJmHyEMUIotGdKHdvhZsUa8RcAmawyXTJCk5MqrP5rS1TMcwx29cFt0xcvc1Um+tFaFEpdu7ciXlUqjeppvSQmucQs22c4bALiqgBwaFsoo/IucyDGExWzcBMkWhPRZW6KOGDJ99NEfO1vXM2yq5QArwT2uEtb8sO+HqDM3iYepjXyJ6MtJeZj5MzLCM0bWNpVreH837lw5XlQejpwmNPmmeSvigHrlAL9qlmXQMTMAQf/iBdobgxHispMkBfzeZ4RbNGn+HPvDKOfc9qR0Chg+1dbl0J9MhT0JGgp4yWQLttQsSQ1A40OZOvuP0XS3/Y+T8GRm22lgZInz+gaD9vIE6nCZy92Q7bsjbXvbQTYnoDZzi494VwmSPemOj10xuT/4uyUiBlZHfM/OzCKhuu8VRCt9+q7MFw+okdid5LN0u3L0nT8BpWHhzwG6TOO0vCOR5amzZ1MXpys9X9yAMa5ImicezSYohzbutQ9acdh/1pm/hmfQPbKoyn0/4bNkZsLe41u/CUE8FtumYvqqLpXcdayE5FFMaNXNRNppUmz50bG2DDt5chWgGI6EwWjmwWiQHo+nxulmAUkgWZIG6Ij7XMDxjsd4iscNoiD9SnVBa694WBfyeRKjVLm6YjKFbPlE2a5yCVHvOZlOB/r3F3RMlmUHzOxyAsKNPTDoyRUL93YCWaidOiMW0CgfdtCYi5xbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(13003099007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pwXR9tPssv5y2yU9qx5XiyMzd+0ZSf4IeWGqXhHOFVRD/T1j5VCQw6HDQ4k0?=
 =?us-ascii?Q?QgvCqu3ih1iMJs8iKIuWM/wpT3IoR9pP0UF1oRVPtGr9cwQ1l1Dx6p5dcW9/?=
 =?us-ascii?Q?qxyrPmt1A8VoeF1vTsmYx7BBhOxT2fStX25UdkocEu+fp2YnktZ0N2+aOy0l?=
 =?us-ascii?Q?IhaNpwnMZH716sidpMjrgk3coLgAL6a3tNuoqQ7vNeoF5xx6xnxZRw7+7i4l?=
 =?us-ascii?Q?vmwS4n/ItgTI3i0Bw5f6qqMW1M5tT3EwLOelioKqDNeEYSJXg9IQuEIklKTY?=
 =?us-ascii?Q?U1E/uVKhZ5Pcua03zgVTgjK6hkuygnoEO2gH32GzOzyFFnPNYGA0BEy9Qshu?=
 =?us-ascii?Q?jcdvNfBeWYTDCdhhxxJKkJCAr3tazgcC26C/XfRj332WZJbLfLgMCAOjSjjV?=
 =?us-ascii?Q?2VABUQVW5Ef8hjj/QhPJXbUarinBV/rK1KBTAbO/XLWcfcrb7ogf2ja/xxwI?=
 =?us-ascii?Q?1U+HVOTB4ovcSZEwrOVhTQb2RlFCmEFlGuLLlpWhxjgf3IZEJ8zUUE/kg7c/?=
 =?us-ascii?Q?BcBlSaseJxX5MwYXxhCVoMyjMqs5Dk6LKpa0TurmHeaxfdtVohRk85SO87lR?=
 =?us-ascii?Q?vz/bgYe8bs08ZjzodfgUa3oSrbxLH7SjFC0+Gxnrr9rGL1AEheqdN9yFjNA1?=
 =?us-ascii?Q?Ua8K8C8RYhPRZ13iAaw4322VGhbfMtYnb/lC9RTxS7lrrHVWNkxX8EUqBOsN?=
 =?us-ascii?Q?HW84AX1zNyn9IxFU30f4kSswO754Pd7hF/TN4ZCVtZQ7e6VblwijiZj4InaD?=
 =?us-ascii?Q?IBPQMAFZKlLjKbzTJ9Wd4H5rbwwjSItqkcUdZAp1NARIQ+Mq1huzpyurYVGM?=
 =?us-ascii?Q?hqAI0EDrMVbKiLF90F1D3ue4VgVbrJDlTyt6nsdAU1BUtVrzzunCfklQiUNb?=
 =?us-ascii?Q?nhdqbpocsa0imfPDohlkmOOYd9scwsvOTbC23oCpXCQOoDeYEkta/dTyVd1f?=
 =?us-ascii?Q?dMvqv/YopE3l2ERjDBheYl7ZBPGxdP+lemV66fGb8k1JiPwiMePyJnAcwdf8?=
 =?us-ascii?Q?RZhxAXgVASoTwFx3WEYazsAQGNiNsSHfVzdFDKQUH4mM5RtI6lkFayB+X0Ox?=
 =?us-ascii?Q?5rRRBIG9gGNWE6VglegGpOLObn1p7+6Az+ikYIX6Za8mMRBYyhC9746owQLf?=
 =?us-ascii?Q?ZrZTMzS5Bh5qPj70epc8z8aygpelVK8E2l9EHHu6zFXOnDH1eTWTreDdgEeZ?=
 =?us-ascii?Q?PkttP3TOUd5JRJmo/OAHaEeWvrdTDdL86peXlPOrH4BsgMPK+KIGq6NAE7pI?=
 =?us-ascii?Q?BdhektPdqtUq3MHo3edZKWYlUaX6UQiFRUX0TqFaKbLa9xXCZudoYc/N/GQq?=
 =?us-ascii?Q?o0ny8uicDzpszlrwnkpo1t5ze54oEtCn/Gn4Pa2ryVx9hYk1KAAs3pvd7VIH?=
 =?us-ascii?Q?9pEr7mpKEwjC3XqnlcAUNV6W3THpq+zINzExYzD813RllzrCegojy9Htz9we?=
 =?us-ascii?Q?Hlo8a41Hxye89sCz2q7V8qfCNvzTK+u55ntwnea/JcKgtKH4TPaxSQ3V/Mz+?=
 =?us-ascii?Q?/oCaXL43qXYAjtNw84qXpe+CsnVqtiVAmue30UfeO2oTJYvPkrZDKPSY1Ehh?=
 =?us-ascii?Q?0/g3hIPmKuhbWvYSrSKL+Sp1g1fn7GUd/C5al8JnkeRLc0VGeeywFMDalDDj?=
 =?us-ascii?Q?gHS1VSAhpDKNLD4YAgCfAT9cb2mbkAao9dXLj5Voz4JDma3RLa7GfVxr9sJh?=
 =?us-ascii?Q?Jms0NF5uAf4y6Ej0iFp3fAsxknewsaIdCe0mpHKKZVw/Ve5PTnmeO8QV7zia?=
 =?us-ascii?Q?7gLxjI1Rng=3D=3D?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c57d21-8548-4fb8-3857-08de7aa2c261
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:34:19.9892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C49tyAGhqxlhzt+2UfsrLkL1Iwrgg0gtdAdBkNy0Bc1Hhs/s7ZnyyViEGwyLClloDP3XCDdGu0XUkksNdXyNYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6111
Received-SPF: pass client-ip=2a01:111:f403:c111::9;
 envelope-from=kchiu@axiado.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

A new device model for Cadence GPIO controller which supports 32 pins.
This controller supports level-triggered or edge-triggered interrupt on each
input pin.

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 312 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 include/hw/gpio/cadence_gpio.h |  66 +++++++
 5 files changed, 387 insertions(+)
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
index 0000000000..5b5d12577d
--- /dev/null
+++ b/hw/gpio/cadence_gpio.c
@@ -0,0 +1,312 @@
+/*
+ * Cadence GPIO emulation.
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/irq.h"
+#include "hw/gpio/cadence_gpio.h"
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
+    /* Deassert in bypass mode or not input pin or masked */
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
+    uint32_t new = level ? 1: 0;
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
+        /* Forward the output value to corresponding pin */
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
index 0000000000..528a8920c2
--- /dev/null
+++ b/include/hw/gpio/cadence_gpio.h
@@ -0,0 +1,66 @@
+/*
+ * Cadence GPIO registers definition.
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
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


