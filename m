Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97217C5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 11:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wt1yX-0002wo-Fb; Sun, 09 Aug 2026 07:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wswuD-00080s-I6
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 02:21:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <0860734llx@gmail.com>)
 id 1wswu8-0005sZ-Sa
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 02:21:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ccf2360620so6724955ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786256463; x=1786861263; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qVDk2zGgv/BF+zKrivF/jjO6NcwKvKV9JKjA9yM7X2M=;
 b=hox8WBeiLTil0zrYwubU+PTZRs7JeeFTgsCE4r3EUO6R5DAhhCPVTdwCuBJsf4YoEQ
 QfTFbZdqVdh3Qxoq+AdpnKXtn1cx+2FKGu4HB6DznWP+facDScQO8Q0DxTqc+CP7T7l+
 Dffc9tY4OY9KaZEbBqdK6t4Go2wX33CPG0m07+UVRDW9i5p0cE74l2OBBOoJHe5EfD33
 PQBaZe1jj6mNb8YF6eU+aIkaqwFEx96scL5DRUfAc48ZvKB4Zr56nkc8c1xVjC346spl
 aieBnFxUwyQwTg3IUnPwtggo45raxZB8SgybvGYd7dM1h0KWezEBA0ALPUBPs8P0X+hu
 +RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786256463; x=1786861263;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qVDk2zGgv/BF+zKrivF/jjO6NcwKvKV9JKjA9yM7X2M=;
 b=MNVJijFnHReLf3M4N4qP4eDuhDWNdJ5kYK2G7df0GeksFxLn4TJViekEgBRxntN7v5
 7mJDrqHMD17O0RPXDruN16q4kU8OAfOgdOSDOzy/MQClgohzqwrY2Woh0h2hprMYJvWb
 Z4UtI68zsplvCrENDKe8th49UnQ4wIYAWrwP2i9+6p/iy8LPuiNwZtPyXoiEQ/khid4Q
 xt5PPjDveOwKx4Q2kj/mInOit81PA2U/OhH6TlqI11Yh0g0E8KrU4r2Lyg0hpkavIM0c
 oR92NBmzqCHdIwDAlTy7XAF6FUKI3kONQHEcVPRJ/gdv1V/wuJpvtUpMaSVF6EhmipsB
 mYcw==
X-Gm-Message-State: AOJu0YyuzIxlQoSz/PFNJ3EGfk7iONoqAbyYXnr6hIcpgKT1XDoQWGc8
 9jE3tMD7xqtoVwoVo3xlPJk6XRjM6bMPWHebxeG757WLbekedHFev+myBhLZ8VRSZAWVrA==
X-Gm-Gg: AR+sD10KOb4iFdN99YVBLlcno7Bpf34f8zLapBLVlR1ta/m5Qz2TTTAQtF/9G6nj/Go
 vfvfaBAIvoGlsPCbZkPXn3UB230SfsWjKw9kk2/CN7uIEUq64DCyQPvrd1NeHnMyepRmB1znkZR
 hD6HvO5KV/wCCGY3FstL0E7WHd8mBvW4YB2l9cg316plZtrpOXHc131q0nYKFXgkVNHQI5Q4ToC
 2nipeJwsGQ9yDJGFgsQpJR96toDq+7jcEL0EdZXJC3JJD997H65PMdz8qgBmTHQVAkaAKfzzYMB
 h70+kaDopjseRuluKOwKEsNemM6K/JR74Iu0keR8P0L3wmyPBauXFO2Mrjv/6c3TEnfAvJsN02K
 OMprnZNBIm6wbgVofCqvvj9K08Vrx+r4CQKiONLz8uSSEXSwtaWOZbryoOLg2KamMEJOUF6ftqB
 jp2ggy9ZdV1gzWYUP8tVGjs5GxrRJEms813AamzEmzsKF5yeBWv4ijB03KFLGsY0Bj5p5fVRgNy
 +qFlhXznjq/w5IJ4C1mFugd6B2eQXlpUA==
X-Received: by 2002:a17:903:32c6:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2d106650dcbmr225290815ad.0.1786256463197; 
 Sat, 08 Aug 2026 23:21:03 -0700 (PDT)
Received: from localhost.localdomain ([159.75.12.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccac6d7sm21805265ad.6.2026.08.08.23.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 23:21:02 -0700 (PDT)
From: Simon Law <0860734llx@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH 1/4] hw/misc: model K230 CMU registers
Date: Sun,  9 Aug 2026 14:20:41 +0800
Message-ID: <20260809-feat-k230-cmu-v1-1-8792982c446c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
References: <20260809-feat-k230-cmu-v1-0-8792982c446c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=0860734llx@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 09 Aug 2026 07:45:49 -0400
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

Signed-off-by: Simon Law <0860734llx@gmail.com>
---
 MAINTAINERS                |   4 +
 hw/misc/Kconfig            |   3 +
 hw/misc/k230_cmu.c         | 881 +++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build        |   1 +
 hw/misc/trace-events       |   9 +
 hw/riscv/Kconfig           |   1 +
 include/hw/misc/k230_cmu.h |  58 +++
 7 files changed, 957 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..d46e90cdc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1820,14 +1820,18 @@ F: hw/riscv/xiangshan_kmh.c
 F: include/hw/riscv/xiangshan_kmh.h
 
 K230 Machines
+M: Simon Law <0860734llx@gmail.com>
 M: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
+F: hw/misc/k230_cmu.c
 F: hw/watchdog/k230_wdt.c
+F: include/hw/misc/k230_cmu.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: tests/qtest/k230-cmu-test.c
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..58a0421e84 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -101,6 +101,9 @@ config FSL_IMX8MP_ANALOG
 config FSL_IMX8MP_CCM
     bool
 
+config K230_CMU
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/k230_cmu.c b/hw/misc/k230_cmu.c
new file mode 100644
index 0000000000..6af19d2a06
--- /dev/null
+++ b/hw/misc/k230_cmu.c
@@ -0,0 +1,881 @@
+/*
+ * Kendryte K230 Clock Management Unit
+ *
+ * Copyright (c) 2026 Simon Law <0860734llx@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Emulates the K230 PLL and system-clock register protocol.  It models
+ * software-visible reset values, masks, write strobes, and PLL lock state,
+ * but does not provide cycle-accurate clocks or propagate QEMU Clock signals.
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/registerfields.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+
+#include "hw/misc/k230_cmu.h"
+#include "trace.h"
+
+REG32(CMU_CFG0, 0x00)
+    FIELD(CMU_CFG0, PLL_OUT_DIV, 24, 4)
+    FIELD(CMU_CFG0, PLL_REF_DIV, 16, 6)
+    FIELD(CMU_CFG0, PLL_FB_DIV, 0, 13)
+
+REG32(CMU_CFG1, 0x04)
+    FIELD(CMU_CFG1, PLL_BYPASS, 19, 1)
+    FIELD(CMU_CFG1, PLL_TEST, 18, 1)
+    FIELD(CMU_CFG1, PLL_ENSAT, 17, 1)
+    FIELD(CMU_CFG1, PLL_FASTEN, 16, 1)
+    FIELD(CMU_CFG1, PLL_BWADJ, 0, 12)
+
+REG32(CMU_CTL, 0x08)
+    FIELD(CMU_CTL, PLL_LOCK_TIM, 4, 8)
+    FIELD(CMU_CTL, PLL_CLK_OE, 2, 1)
+    FIELD(CMU_CTL, PLL_INIT, 1, 1)
+    FIELD(CMU_CTL, PLL_PWRDWN, 0, 1)
+
+REG32(CMU_STAT, 0x0c)
+    FIELD(CMU_STAT, PLL_FSM_STAT, 4, 2)
+    FIELD(CMU_STAT, PLL_RESERVED, 3, 1)
+    FIELD(CMU_STAT, PLL_FB_SLIP, 2, 1)
+    FIELD(CMU_STAT, PLL_REF_SLIP, 1, 1)
+    FIELD(CMU_STAT, PLL_LOCK, 0, 1)
+
+#define PLL_CFG0_RW_MASK       (R_CMU_CFG0_PLL_OUT_DIV_MASK | \
+                                R_CMU_CFG0_PLL_REF_DIV_MASK | \
+                                R_CMU_CFG0_PLL_FB_DIV_MASK)
+#define PLL_CFG1_RW_MASK       (R_CMU_CFG1_PLL_BYPASS_MASK | \
+                                R_CMU_CFG1_PLL_TEST_MASK | \
+                                R_CMU_CFG1_PLL_ENSAT_MASK | \
+                                R_CMU_CFG1_PLL_FASTEN_MASK | \
+                                R_CMU_CFG1_PLL_BWADJ_MASK)
+#define PLL_CTL_RW_MASK        (R_CMU_CTL_PLL_LOCK_TIM_MASK | \
+                                R_CMU_CTL_PLL_CLK_OE_MASK)
+#define PLL_CTL_W1T_MASK       (R_CMU_CTL_PLL_INIT_MASK | \
+                                R_CMU_CTL_PLL_PWRDWN_MASK)
+#define PLL_CTL_LOW_MASK       (PLL_CTL_RW_MASK | PLL_CTL_W1T_MASK)
+#define PLL_STAT_RO_MASK       (R_CMU_STAT_PLL_FSM_STAT_MASK | \
+                                R_CMU_STAT_PLL_RESERVED_MASK | \
+                                R_CMU_STAT_PLL_FB_SLIP_MASK | \
+                                R_CMU_STAT_PLL_REF_SLIP_MASK | \
+                                R_CMU_STAT_PLL_LOCK_MASK)
+
+REG32(SYSCLK_CPU0_CLK_CFG, 0x000)
+    FIELD(SYSCLK_CPU0_CLK_CFG, CORE_CLK_ROOT_GDIV_UPD, 31, 1)
+    FIELD(SYSCLK_CPU0_CLK_CFG, PCLK_DIV, 15, 3)
+    FIELD(SYSCLK_CPU0_CLK_CFG, TDI_PCLK_EN, 14, 1)
+    /* FIXME: SDK get_leaf_en() reads bit 7 for this gate; */
+    /* TRM says bit 13. */
+    FIELD(SYSCLK_CPU0_CLK_CFG, PCLK_ENABLE, 13, 1)
+    FIELD(SYSCLK_CPU0_CLK_CFG, PLICLK_DIV, 10, 3)
+    FIELD(SYSCLK_CPU0_CLK_CFG, PLICLK_ENABLE, 9, 1)
+    FIELD(SYSCLK_CPU0_CLK_CFG, ACLK_DIV, 6, 3)
+    FIELD(SYSCLK_CPU0_CLK_CFG, CORE_CLK_ROOT_DIV, 1, 4)
+    FIELD(SYSCLK_CPU0_CLK_CFG, CORE_CLK_ENABLE, 0, 1)
+REG32(SYSCLK_CPU1_CLK_CFG, 0x004)
+    FIELD(SYSCLK_CPU1_CLK_CFG, CORE_CLK_DIV_UPD, 31, 1)
+    FIELD(SYSCLK_CPU1_CLK_CFG, PCLK_ENABLE, 19, 1)
+    FIELD(SYSCLK_CPU1_CLK_CFG, PLICLK_DIV, 16, 3)
+    FIELD(SYSCLK_CPU1_CLK_CFG, PLICLK_ENABLE, 15, 1)
+    FIELD(SYSCLK_CPU1_CLK_CFG, ACLK_DIV, 12, 3)
+    FIELD(SYSCLK_CPU1_CLK_CFG, CORE_CLK_ROOT_DIV, 3, 3)
+    FIELD(SYSCLK_CPU1_CLK_CFG, CORE_CLK_SEL, 1, 2)
+    FIELD(SYSCLK_CPU1_CLK_CFG, CORE_CLK_ENABLE, 0, 1)
+REG32(SYSCLK_AI_CLK_CFG, 0x008)
+    FIELD(SYSCLK_AI_CLK_CFG, CLK_DIV_UPD, 31, 1)
+    FIELD(SYSCLK_AI_CLK_CFG, ACLK_ENABLE, 10, 1)
+    FIELD(SYSCLK_AI_CLK_CFG, CLK_CDIV, 3, 3)
+    FIELD(SYSCLK_AI_CLK_CFG, CLK_SEL, 2, 1)
+    FIELD(SYSCLK_AI_CLK_CFG, CLK_ENABLE, 0, 1)
+REG32(SYSCLK_VPU_CLK_CFG, 0x00c)
+    FIELD(SYSCLK_VPU_CLK_CFG, CLK_GDIV_UPD, 31, 1)
+    FIELD(SYSCLK_VPU_CLK_CFG, CFGCLK_ROOT_DIV, 11, 4)
+    FIELD(SYSCLK_VPU_CLK_CFG, CFGCLK_ENABLE, 10, 1)
+    FIELD(SYSCLK_VPU_CLK_CFG, ACLK_ROOT_DIV, 6, 4)
+    FIELD(SYSCLK_VPU_CLK_CFG, ACLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_VPU_CLK_CFG, CLK_DIV, 1, 4)
+    FIELD(SYSCLK_VPU_CLK_CFG, CLK_EN, 0, 1)
+REG32(SYSCLK_PMU_CLK_CFG, 0x010)
+    FIELD(SYSCLK_PMU_CLK_CFG, CLK_EN, 0, 1)
+REG32(SYSCLK_HS_CLKEN_CFG, 0x018)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI2_ACLK_ENABLE, 30, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI1_ACLK_ENABLE, 29, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, QSPI_ACLK_ENABLE, 28, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI0_ACLK_ENABLE, 27, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI2_CLK_ENABLE, 26, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI1_CLK_ENABLE, 25, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI0_CLK_ENABLE, 24, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, USB_REFCLK_SEL, 23, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, USB1_REFCLK_ENABLE, 22, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, USB0_REFCLK_ENABLE, 21, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_TMCLK_ENABLE, 20, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_CCLK_ENABLE, 19, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_BCLK_ENABLE, 18, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_ACLK_ENABLE, 17, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_TMCLK_ENABLE, 16, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_CCLK_ENABLE, 15, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_BCLK_ENABLE, 14, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_ACLK_ENABLE, 13, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD_TMCLK_ENABLE, 12, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD_CCLK_ENABLE, 11, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD_BCLK_ENABLE, 10, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD_ACLK_ENABLE, 9, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI2_HCLK_ENABLE, 8, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI1_HCLK_ENABLE, 7, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SSI0_HCLK_ENABLE, 6, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, USB1_HCLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, USB0_HCLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD1_HCLK_ENABLE, 3, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, SD0_HCLK_ENABLE, 2, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, HCLK_HIGH_ENABLE, 1, 1)
+    FIELD(SYSCLK_HS_CLKEN_CFG, HCLK_ENABLE, 0, 1)
+REG32(SYSCLK_HS_SDCLK_CFG, 0x01c)
+    FIELD(SYSCLK_HS_SDCLK_CFG, ACLK_ROOT_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_HS_SDCLK_CFG, TMCLK_DIV, 15, 5)
+    /* FIXME: SDK get_leaf_rate() uses ACLK_ROOT_DIV for SD CCLK, */
+    /* not bits 14:12. */
+    FIELD(SYSCLK_HS_SDCLK_CFG, CCLK_DIV, 12, 3)
+    FIELD(SYSCLK_HS_SDCLK_CFG, BCLK_DIV, 9, 3)
+    FIELD(SYSCLK_HS_SDCLK_CFG, ACLK_ROOT_DIV, 6, 3)
+    FIELD(SYSCLK_HS_SDCLK_CFG, HCLK_DIV, 3, 3)
+    FIELD(SYSCLK_HS_SDCLK_CFG, HCLK_HIGH_ROOT_DIV, 0, 3)
+REG32(SYSCLK_HS_SPI_CFG, 0x020)
+    FIELD(SYSCLK_HS_SPI_CFG, SSI0_ACLK_ROOT_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_HS_SPI_CFG, SSI0_CLK_SEL, 18, 1)
+    FIELD(SYSCLK_HS_SPI_CFG, USB_REFCLK_50M_DIV, 15, 3)
+    FIELD(SYSCLK_HS_SPI_CFG, QSPI_ACLK_ROOT_DIV, 12, 3)
+    FIELD(SYSCLK_HS_SPI_CFG, SSI0_ACLK_DIV, 9, 3)
+    FIELD(SYSCLK_HS_SPI_CFG, SSI2_CLK_DIV, 6, 3)
+    FIELD(SYSCLK_HS_SPI_CFG, SSI1_CLK_DIV, 3, 3)
+REG32(SYSCLK_LS_CLKEN_CFG0, 0x024)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, PDM_CLK_ENABLE, 31, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, CODEC_MCLK_DAC_ENABLE, 30, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, CODEC_MCLK_ADC_ENABLE, 29, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, AUD_DEV_CLK_ENABLE, 28, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, GPIO_DBCLK_ENABLE, 27, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, ADC_CLK_ENABLE, 26, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C4_CLK_ENABLE, 25, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C3_CLK_ENABLE, 24, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C2_CLK_ENABLE, 23, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C1_CLK_ENABLE, 22, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C0_CLK_ENABLE, 21, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART4_CLK_ENABLE, 20, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART3_CLK_ENABLE, 19, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART2_CLK_ENABLE, 18, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART1_CLK_ENABLE, 17, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART0_CLK_ENABLE, 16, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, ADC_PCLK_ENABLE, 15, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, CODEC_PCLK_ENABLE, 14, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, AUD_DEV_PCLK_ENABLE, 13, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, PWM_PCLK_ENABLE, 12, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, GPIO_PCLK_ENABLE, 11, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C4_PCLK_ENABLE, 10, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C3_PCLK_ENABLE, 9, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C2_PCLK_ENABLE, 8, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C1_PCLK_ENABLE, 7, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, I2C0_PCLK_ENABLE, 6, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART4_PCLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART3_PCLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART2_PCLK_ENABLE, 3, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART1_PCLK_ENABLE, 2, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, UART0_PCLK_ENABLE, 1, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG0, PCLK_ENABLE, 0, 1)
+REG32(SYSCLK_LS_CLKEN_CFG1, 0x028)
+    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK3_PCLK_ENABLE, 7, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK2_PCLK_ENABLE, 6, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK1_PCLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK0_PCLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK3_CO_ENABLE, 3, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK2_CO_ENABLE, 2, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK1_CO_ENABLE, 1, 1)
+    FIELD(SYSCLK_LS_CLKEN_CFG1, JAMLINK0_CO_ENABLE, 0, 1)
+REG32(SYSCLK_UART_I2C_CLKDIV_CFG, 0x02c)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C0_CLK_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C4_CLK_DIV, 27, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C3_CLK_DIV, 24, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C2_CLK_DIV, 21, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C1_CLK_DIV, 18, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, I2C0_CLK_DIV, 15, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART4_SCLK_DIV, 12, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART3_SCLK_DIV, 9, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART2_SCLK_DIV, 6, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART1_SCLK_DIV, 3, 3)
+    FIELD(SYSCLK_UART_I2C_CLKDIV_CFG, UART0_SCLK_DIV, 0, 3)
+REG32(SYSCLK_LS_CLKDIV_CFG, 0x030)
+    FIELD(SYSCLK_LS_CLKDIV_CFG, JAMLINK_CO_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_LS_CLKDIV_CFG, JAMLINK_CO_DIV, 23, 8)
+    FIELD(SYSCLK_LS_CLKDIV_CFG, GPIO_DBCLK_DIV, 13, 10)
+    FIELD(SYSCLK_LS_CLKDIV_CFG, ADC_CLK_DIV, 3, 10)
+    FIELD(SYSCLK_LS_CLKDIV_CFG, PCLK_DIV, 0, 3)
+/*
+ * SDK sysctl_clk_t marks offsets 0x034..0x044 reserved; the TRM defines
+ * these registers, so the TRM layout is authoritative for the v1 model.
+ */
+REG32(SYSCLK_AUDIO_CLKDIV_CFG, 0x034)
+    FIELD(SYSCLK_AUDIO_CLKDIV_CFG, AUD_DEV_CLK_FDIV_UPD, 31, 1)
+    FIELD(SYSCLK_AUDIO_CLKDIV_CFG, AUDIO_CLK_STEP, 16, 15)
+    FIELD(SYSCLK_AUDIO_CLKDIV_CFG, AUDIO_CLK_SUM, 0, 16)
+REG32(SYSCLK_CODEC_ADC_MCLKDIV_CFG, 0x038)
+    FIELD(SYSCLK_CODEC_ADC_MCLKDIV_CFG, MCLK_ADC_FDIV_UPD, 31, 1)
+    FIELD(SYSCLK_CODEC_ADC_MCLKDIV_CFG, MCLK_ADC_STEP, 14, 13)
+    FIELD(SYSCLK_CODEC_ADC_MCLKDIV_CFG, MCLK_ADC_SUM, 0, 14)
+REG32(SYSCLK_CODEC_DAC_MCLKDIV_CFG, 0x03c)
+    FIELD(SYSCLK_CODEC_DAC_MCLKDIV_CFG, MCLK_DAC_FDIV_UPD, 31, 1)
+    FIELD(SYSCLK_CODEC_DAC_MCLKDIV_CFG, MCLK_DAC_STEP, 14, 13)
+    FIELD(SYSCLK_CODEC_DAC_MCLKDIV_CFG, MCLK_DAC_SUM, 0, 14)
+REG32(SYSCLK_PDM_CLKDIV_CFG0, 0x040)
+    FIELD(SYSCLK_PDM_CLKDIV_CFG0, CLK_SUM, 0, 17)
+REG32(SYSCLK_PDM_CLKDIV_CFG1, 0x044)
+    FIELD(SYSCLK_PDM_CLKDIV_CFG1, CLK_FDIV_UPD, 31, 1)
+    FIELD(SYSCLK_PDM_CLKDIV_CFG1, CLK_STEP, 0, 16)
+REG32(SYSCLK_SYSCTL_CLKEN_CFG, 0x050)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, HDI_CLK_ENABLE, 21, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, IOMUX_PCLK_ENABLE, 20, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, STC_CLK_EN, 19, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER5_CLK_ENABLE, 18, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER4_CLK_ENABLE, 17, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER3_CLK_ENABLE, 16, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER2_CLK_ENABLE, 15, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER1_CLK_ENABLE, 14, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER0_CLK_ENABLE, 13, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER5_CLK_SEL, 12, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER4_CLK_SEL, 11, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER3_CLK_SEL, 10, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER2_CLK_SEL, 9, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER1_CLK_SEL, 8, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER0_CLK_SEL, 7, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, WDT1_CLK_ENABLE, 6, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, WDT0_CLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, MAILBOX_PCLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, TIMER_PCLK_ENABLE, 3, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, WDT1_PCLK_ENABLE, 2, 1)
+    FIELD(SYSCLK_SYSCTL_CLKEN_CFG, WDT0_PCLK_ENABLE, 1, 1)
+REG32(SYSCLK_TIMER_CLK_CFG, 0x054)
+    FIELD(SYSCLK_TIMER_CLK_CFG, CLK0_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_TIMER_CLK_CFG, CLK5_DIV, 15, 3)
+    FIELD(SYSCLK_TIMER_CLK_CFG, CLK4_DIV, 12, 3)
+    FIELD(SYSCLK_TIMER_CLK_CFG, CLK3_DIV, 9, 3)
+    FIELD(SYSCLK_TIMER_CLK_CFG, CLK2_DIV, 6, 3)
+    FIELD(SYSCLK_TIMER_CLK_CFG, CLK1_DIV, 3, 3)
+    FIELD(SYSCLK_TIMER_CLK_CFG, CLK0_DIV, 0, 3)
+REG32(SYSCLK_SYSCTL_CLK_DIV_CFG, 0x058)
+    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, PCLK_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, HDI_CLK_DIV, 28, 3)
+    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, TS_CLK_DIV, 20, 8)
+    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, STC_CLK_DIV, 15, 5)
+    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, WDT1_CLK_DIV, 9, 6)
+    FIELD(SYSCLK_SYSCTL_CLK_DIV_CFG, WDT0_CLK_DIV, 3, 6)
+REG32(SYSCLK_SHRM_CLK_CFG, 0x05c)
+    FIELD(SYSCLK_SHRM_CLK_CFG, PCLK_ROOT_DIV_UPD, 31, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, PCLK_ROOT_DIV, 18, 3)
+    FIELD(SYSCLK_SHRM_CLK_CFG, SRAM_CLK_SEL, 14, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, AXIM_BRIDGE_CLK_EN, 13, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, AXIM_CLK_EN, 12, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, AXIS_CLK_EN, 11, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, SRAM_ACLK_ENABLE, 10, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, NONAI2D_ACLK_ENABLE, 9, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, NONAI2D_PCLK_ENABLE, 8, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, DECOMPRESS_ACLK_ENABLE, 7, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, DECOMPRESS_PCLK_ENABLE, 6, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, GSDMA_ACLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, GSDMA_PCLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, PERI_DMA_ACLK_ENABLE, 3, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, PERI_DMA_PCLK_ENABLE, 2, 1)
+    FIELD(SYSCLK_SHRM_CLK_CFG, PCLK_ENABLE, 0, 1)
+REG32(SYSCLK_DDR_CLK_CFG, 0x060)
+    FIELD(SYSCLK_DDR_CLK_CFG, CORE_CLK_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, PCLK_DIV, 14, 4)
+    FIELD(SYSCLK_DDR_CLK_CFG, CORE_CLK_DIV, 10, 4)
+    FIELD(SYSCLK_DDR_CLK_CFG, PCLK_ENABLE, 9, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, BYPASSPCLK_ENABLE, 8, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, AXI4CLK_ENABLE, 7, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, AXI3CLK_ENABLE, 6, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, AXI2CLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, AXI1CLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, AXI0CLK_ENABLE, 3, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, CLK_ENABLE, 2, 1)
+    FIELD(SYSCLK_DDR_CLK_CFG, CLK_SEL, 0, 2)
+/*
+ * SDK sysctl_clk_t marks offsets 0x064..0x078 reserved; the TRM defines
+ * these registers, so the TRM layout is authoritative for the v1 model.
+ */
+REG32(SYSCLK_ISP_CLKEN_CFG, 0x064)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, DW_ACLK_ENABLE, 19, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, DW_HCLK_ENABLE, 18, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, MCM_CLK_ENABLE, 17, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, VSE_CLK_ENABLE, 16, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, DWE_CLK_ENABLE, 15, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, ACLK_ENABLE, 14, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, HCLK_ENABLE, 13, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CLK_ENABLE, 12, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI2_PCLK_ENABLE, 11, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI1_PCLK_ENABLE, 10, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI0_PCLK_ENABLE, 9, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI2_PIXELCLK_ENABLE, 8, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI1_PIXELCLK_ENABLE, 7, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CSI0_PIXELCLK_ENABLE, 6, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, DPHY_PCLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CFG2_CLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CFG1_CLK_ENABLE, 3, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CFG0_CLK_ENABLE, 2, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, PCLK_ENABLE, 1, 1)
+    FIELD(SYSCLK_ISP_CLKEN_CFG, CSIPHY_CFGCLK_ENABLE, 0, 1)
+REG32(SYSCLK_ISP_CLKDIV_CFG, 0x068)
+    FIELD(SYSCLK_ISP_CLKDIV_CFG, CFG_CLK_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_ISP_CLKDIV_CFG, CLK_SEL, 29, 1)
+    FIELD(SYSCLK_ISP_CLKDIV_CFG, CLK_DIV, 26, 3)
+    FIELD(SYSCLK_ISP_CLKDIV_CFG, PCLK_DIV, 23, 3)
+    FIELD(SYSCLK_ISP_CLKDIV_CFG, CSI2_PIXEL_CLK_DIV, 17, 6)
+    FIELD(SYSCLK_ISP_CLKDIV_CFG, CSI1_PIXEL_CLK_DIV, 11, 6)
+    FIELD(SYSCLK_ISP_CLKDIV_CFG, CSI0_PIXEL_CLK_DIV, 5, 6)
+    FIELD(SYSCLK_ISP_CLKDIV_CFG, CFG_CLK_DIV, 0, 5)
+REG32(SYSCLK_MCLK_CFG, 0x06c)
+    FIELD(SYSCLK_MCLK_CFG, MCLK0_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_MCLK_CFG, MCLK2_DIV, 19, 5)
+    FIELD(SYSCLK_MCLK_CFG, MCLK2_SEL, 17, 2)
+    FIELD(SYSCLK_MCLK_CFG, MCLK1_DIV, 12, 5)
+    FIELD(SYSCLK_MCLK_CFG, MCLK1_SEL, 10, 2)
+    FIELD(SYSCLK_MCLK_CFG, MCLK0_DIV, 5, 5)
+    FIELD(SYSCLK_MCLK_CFG, MCLK0_SEL, 3, 2)
+    FIELD(SYSCLK_MCLK_CFG, MCLK2_ENABLE, 2, 1)
+    FIELD(SYSCLK_MCLK_CFG, MCLK1_ENABLE, 1, 1)
+    FIELD(SYSCLK_MCLK_CFG, MCLK0_ENABLE, 0, 1)
+REG32(SYSCLK_DPU_CLK_CFG, 0x070)
+    FIELD(SYSCLK_DPU_CLK_CFG, CLK_DIV_UPD, 31, 1)
+    FIELD(SYSCLK_DPU_CLK_CFG, PCLK_DIV, 7, 3)
+    FIELD(SYSCLK_DPU_CLK_CFG, CLK_DIV, 3, 4)
+    FIELD(SYSCLK_DPU_CLK_CFG, PCLK_ENABLE, 2, 1)
+    FIELD(SYSCLK_DPU_CLK_CFG, ACLK_ENABLE, 1, 1)
+    FIELD(SYSCLK_DPU_CLK_CFG, CLK_ENABLE, 0, 1)
+REG32(SYSCLK_VO_CLK_CFG, 0x074)
+    FIELD(SYSCLK_VO_CLK_CFG, ACLK_GPU_EN, 12, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, ACLK_VO_EN, 11, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, HCLK_GPU_EN, 10, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, PCLK_DSI_PHY_EN, 9, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, PCLK_DSI_ENABLE, 8, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, PCLK_VO_ENABLE, 7, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, CLK_GPU_ENABLE, 6, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, CLKEXT_ENABLE, 5, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, CFGCLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, REFCLK_ENABLE, 3, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, DPIPCLK_ENABLE, 2, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, ACLK_ENABLE, 1, 1)
+    FIELD(SYSCLK_VO_CLK_CFG, HCLK_ENABLE, 0, 1)
+REG32(SYSCLK_DISP_CLK_DIV, 0x078)
+    FIELD(SYSCLK_DISP_CLK_DIV, HCLK_ROOT_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_DISP_CLK_DIV, CLK_GPU_DIV, 20, 4)
+    FIELD(SYSCLK_DISP_CLK_DIV, CLKEXT_DIV, 16, 4)
+    FIELD(SYSCLK_DISP_CLK_DIV, CFGCLK_DIV, 11, 5)
+    FIELD(SYSCLK_DISP_CLK_DIV, DPIPCLK_DIV, 3, 8)
+    FIELD(SYSCLK_DISP_CLK_DIV, HCLK_ROOT_DIV, 0, 3)
+REG32(SYSCLK_SEC_CLK_DIV, 0x080)
+    FIELD(SYSCLK_SEC_CLK_DIV, PCLK_DIV_UPD, 31, 1)
+    FIELD(SYSCLK_SEC_CLK_DIV, ACLK_DIV, 11, 3)
+    FIELD(SYSCLK_SEC_CLK_DIV, FIXCLK_DIV, 6, 5)
+    FIELD(SYSCLK_SEC_CLK_DIV, FIXCLK_ENABLE, 5, 1)
+    FIELD(SYSCLK_SEC_CLK_DIV, ACLK_ENABLE, 4, 1)
+    FIELD(SYSCLK_SEC_CLK_DIV, PCLK_DIV, 1, 3)
+    FIELD(SYSCLK_SEC_CLK_DIV, PCLK_ENABLE, 0, 1)
+REG32(SYSCLK_USB_TEST_CLK_DIV, 0x100)
+    FIELD(SYSCLK_USB_TEST_CLK_DIV, CLK480_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_USB_TEST_CLK_DIV, CLK100_DIV, 4, 3)
+    FIELD(SYSCLK_USB_TEST_CLK_DIV, CLK480_DIV, 1, 3)
+    FIELD(SYSCLK_USB_TEST_CLK_DIV, TEST_CLK_ENABLE, 0, 1)
+REG32(SYSCLK_DPHY_TEST_CLK_DIV, 0x104)
+    FIELD(SYSCLK_DPHY_TEST_CLK_DIV, TEST_CLK_CDIV_UPD, 31, 1)
+    FIELD(SYSCLK_DPHY_TEST_CLK_DIV, TEST_CLK_DIV, 1, 4)
+    FIELD(SYSCLK_DPHY_TEST_CLK_DIV, TEST_CLK_ENABLE, 0, 1)
+/*
+ * The TRM v0.3.1 sysclk summary ends at 0x104. Linux and the SDK both
+ * access SPI2AXI_CLK_DIV at 0x108, so v1 preserves this software ABI
+ * exception.
+ */
+REG32(SYSCLK_SPI2AXI_CLK_DIV, 0x108)
+    FIELD(SYSCLK_SPI2AXI_CLK_DIV, CLK_DIV_UPD, 31, 1)
+    FIELD(SYSCLK_SPI2AXI_CLK_DIV, CLK_DIV, 1, 3)
+    FIELD(SYSCLK_SPI2AXI_CLK_DIV, CLK_ENABLE, 0, 1)
+
+typedef struct K230PllRegDesc {
+    hwaddr offset;
+    const char *name;
+    uint32_t reset[K230_PLL_COUNT];
+    uint32_t rw_mask;
+    uint32_t ro_mask;
+    uint32_t w1t_mask;
+    uint8_t write_enable_shift;
+    uint32_t write_enable_mask;
+} K230PllRegDesc;
+
+typedef struct K230SysclkRegDesc {
+    hwaddr offset;
+    const char *name;
+    uint32_t reset;
+    uint32_t rw_mask;
+    uint32_t w1t_mask;
+} K230SysclkRegDesc;
+
+static const K230PllRegDesc k230_pll_regs[] = {
+    {
+        .offset = A_CMU_CFG0,
+        .name = "PLLx_CFG0",
+        .reset = {
+            0x0102018f, 0x00000062, 0x00070378, 0x0102018f,
+        },
+        .rw_mask = PLL_CFG0_RW_MASK,
+    },
+    {
+        .offset = A_CMU_CFG1,
+        .name = "PLLx_CFG1",
+        .reset = {
+            0x000200c7, 0x00020031, 0x000201bb, 0x000200c7,
+        },
+        .rw_mask = PLL_CFG1_RW_MASK,
+    },
+    {
+        .offset = A_CMU_CTL,
+        .name = "PLLx_CTL",
+        .reset = {
+            0x00000034, 0x00000034, 0x00000034, 0x00000074,
+        },
+        .rw_mask = PLL_CTL_RW_MASK,
+        .w1t_mask = PLL_CTL_W1T_MASK,
+        .write_enable_shift = 16,
+        .write_enable_mask = PLL_CTL_LOW_MASK,
+    },
+    {
+        .offset = A_CMU_STAT,
+        .name = "PLLx_STAT",
+        .reset = {
+            0x00000021, 0x00000021, 0x00000021, 0x00000021,
+        },
+        .ro_mask = PLL_STAT_RO_MASK,
+    },
+};
+
+#define SYSCLK_REG(_reg, _name, _reset, _rw, _w1t) \
+    { .offset = A_ ## _reg, .name = _name, .reset = _reset, \
+      .rw_mask = (_rw), .w1t_mask = (_w1t) }
+
+static const K230SysclkRegDesc k230_sysclk_regs[] = {
+    SYSCLK_REG(SYSCLK_CPU0_CLK_CFG, "CPU0_CLK_CFG", 0x0000e65f,
+               0x0003ffdf, R_SYSCLK_CPU0_CLK_CFG_CORE_CLK_ROOT_GDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_CPU1_CLK_CFG, "CPU1_CLK_CFG", 0x0009900d,
+               0x000f803f, R_SYSCLK_CPU1_CLK_CFG_CORE_CLK_DIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_AI_CLK_CFG, "AI_CLK_CFG", 0x0000043d,
+               0x0000043d, R_SYSCLK_AI_CLK_CFG_CLK_DIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_VPU_CLK_CFG, "VPU_CLK_CFG", 0x00000c7f,
+               0x00007fff, R_SYSCLK_VPU_CLK_CFG_CLK_GDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_PMU_CLK_CFG, "PMU_CLK_CFG", 0x00000001,
+               0x00000001, 0),
+    SYSCLK_REG(SYSCLK_HS_CLKEN_CFG, "HS_CLKEN_CFG", 0x7f7fffff,
+               0x7fffffff, 0),
+    SYSCLK_REG(SYSCLK_HS_SDCLK_CFG, "HS_SDCLK_CFG", 0x000b9248,
+               0x000fffff, R_SYSCLK_HS_SDCLK_CFG_ACLK_ROOT_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_HS_SPI_CFG, "HS_SPI_CFG", 0x00039048,
+               0x0007fff8, R_SYSCLK_HS_SPI_CFG_SSI0_ACLK_ROOT_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_LS_CLKEN_CFG0, "LS_CLKEN_CFG0", 0xffffffff,
+               0xffffffff, 0),
+    SYSCLK_REG(SYSCLK_LS_CLKEN_CFG1, "LS_CLKEN_CFG1", 0x000000ff,
+               0x000000ff, 0),
+    SYSCLK_REG(SYSCLK_UART_I2C_CLKDIV_CFG, "UART_I2C_CLKDIV_CFG",
+               0x1b6d9249, 0x3fffffff,
+               R_SYSCLK_UART_I2C_CLKDIV_CFG_I2C0_CLK_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_LS_CLKDIV_CFG, "LS_CLKDIV_CFG", 0x01dda0c3,
+               0x7fffffff, R_SYSCLK_LS_CLKDIV_CFG_JAMLINK_CO_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_AUDIO_CLKDIV_CFG, "AUDIO_CLKDIV_CFG", 0x01b9f424,
+               0x7fffffff, R_SYSCLK_AUDIO_CLKDIV_CFG_AUD_DEV_CLK_FDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_CODEC_ADC_MCLKDIV_CFG, "CODEC_ADC_MCLKDIV_CFG",
+               0x006e7d09, 0x07ffffff,
+               R_SYSCLK_CODEC_ADC_MCLKDIV_CFG_MCLK_ADC_FDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_CODEC_DAC_MCLKDIV_CFG, "CODEC_DAC_MCLKDIV_CFG",
+               0x006e7d09, 0x07ffffff,
+               R_SYSCLK_CODEC_DAC_MCLKDIV_CFG_MCLK_DAC_FDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_PDM_CLKDIV_CFG0, "PDM_CLKDIV_CFG0", 0x0000f424,
+               0x0001ffff, 0),
+    SYSCLK_REG(SYSCLK_PDM_CLKDIV_CFG1, "PDM_CLKDIV_CFG1", 0x000001b9,
+               0x0000ffff, R_SYSCLK_PDM_CLKDIV_CFG1_CLK_FDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_SYSCTL_CLKEN_CFG, "SYSCTL_CLKEN_CFG", 0x003ffffe,
+               0x003ffffe, 0),
+    SYSCLK_REG(SYSCLK_TIMER_CLK_CFG, "TIMER_CLK_CFG", 0x0003ffff,
+               0x0003ffff, R_SYSCLK_TIMER_CLK_CFG_CLK0_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_SYSCTL_CLK_DIV_CFG, "SYSCTL_CLK_DIV_CFG", 0x1efabef9,
+               0x7ffffff8, R_SYSCLK_SYSCTL_CLK_DIV_CFG_PCLK_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_SHRM_CLK_CFG, "SHRM_CLK_CFG", 0x000c7ffd,
+               0x001c7ffd, R_SYSCLK_SHRM_CLK_CFG_PCLK_ROOT_DIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_DDR_CLK_CFG, "DDR_CLK_CFG", 0x000043fd,
+               0x0003ffff, R_SYSCLK_DDR_CLK_CFG_CORE_CLK_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_ISP_CLKEN_CFG, "ISP_CLKEN_CFG", 0x000fffff,
+               0x000fffff, 0),
+    SYSCLK_REG(SYSCLK_ISP_CLKDIV_CFG, "ISP_CLKDIV_CFG", 0x00820835,
+               0x3fffffff, R_SYSCLK_ISP_CLKDIV_CFG_CFG_CLK_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_MCLK_CFG, "MCLK_CFG", 0x003a74ef,
+               0x00ffffff, R_SYSCLK_MCLK_CFG_MCLK0_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_DPU_CLK_CFG, "DPU_CLK_CFG", 0x000001ff,
+               0x000003ff, R_SYSCLK_DPU_CLK_CFG_CLK_DIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_VO_CLK_CFG, "VO_CLK_CFG", 0x00001fff,
+               0x00001fff, 0),
+    SYSCLK_REG(SYSCLK_DISP_CLK_DIV, "DISP_CLK_DIV", 0x0000a83b,
+               0x00ffffff, R_SYSCLK_DISP_CLK_DIV_HCLK_ROOT_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_SEC_CLK_DIV, "SEC_CLK_DIV", 0x000002f3,
+               0x00003fff, R_SYSCLK_SEC_CLK_DIV_PCLK_DIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_USB_TEST_CLK_DIV, "USB_TEST_CLK_DIV", 0x00000039,
+               0x0000007f, R_SYSCLK_USB_TEST_CLK_DIV_CLK480_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_DPHY_TEST_CLK_DIV, "DPHY_TEST_CLK_DIV", 0x00000009,
+               0x0000001f,
+               R_SYSCLK_DPHY_TEST_CLK_DIV_TEST_CLK_CDIV_UPD_MASK),
+    SYSCLK_REG(SYSCLK_SPI2AXI_CLK_DIV, "SPI2AXI_CLK_DIV", 0x00000007,
+               0x0000000f,
+               R_SYSCLK_SPI2AXI_CLK_DIV_CLK_DIV_UPD_MASK),
+};
+
+#undef SYSCLK_REG
+
+static const K230PllRegDesc *k230_pll_desc(hwaddr addr,
+                                            unsigned *pll_index)
+{
+    unsigned index = addr / K230_PLL_STRIDE;
+    hwaddr offset = addr % K230_PLL_STRIDE;
+
+    if (index >= K230_PLL_COUNT) {
+        return NULL;
+    }
+
+    for (unsigned i = 0; i < ARRAY_SIZE(k230_pll_regs); i++) {
+        if (k230_pll_regs[i].offset == offset) {
+            *pll_index = index;
+            return &k230_pll_regs[i];
+        }
+    }
+
+    return NULL;
+}
+
+static uint32_t k230_pll_value(const K230PllState *pll, hwaddr offset)
+{
+    switch (offset) {
+    case A_CMU_CFG0:
+        return pll->cfg0;
+    case A_CMU_CFG1:
+        return pll->cfg1;
+    case A_CMU_CTL:
+        return pll->ctl & PLL_CTL_RW_MASK;
+    case A_CMU_STAT:
+        return pll->stat & PLL_STAT_RO_MASK;
+    default:
+        return 0;
+    }
+}
+
+static uint32_t *k230_pll_storage(K230PllState *pll, hwaddr offset)
+{
+    switch (offset) {
+    case A_CMU_CFG0:
+        return &pll->cfg0;
+    case A_CMU_CFG1:
+        return &pll->cfg1;
+    case A_CMU_CTL:
+        return &pll->ctl;
+    default:
+        return NULL;
+    }
+}
+
+static uint32_t k230_merge_rw(uint32_t old_value, uint32_t write_value,
+                              uint32_t rw_mask)
+{
+    return (old_value & ~rw_mask) | (write_value & rw_mask);
+}
+
+static void k230_cmu_log_undefined_access(const char *region, bool write,
+                                           hwaddr addr, uint32_t value)
+{
+    if (write) {
+        trace_k230_cmu_undefined_write(region, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to undefined %s offset 0x%" PRIx64
+                      " (value 0x%08" PRIx32 ")\n",
+                      TYPE_K230_CMU, region, addr, value);
+    } else {
+        trace_k230_cmu_undefined_read(region, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from undefined %s offset 0x%" PRIx64 "\n",
+                      TYPE_K230_CMU, region, addr);
+    }
+}
+
+static uint64_t k230_pll_read(void *opaque, hwaddr addr, unsigned size)
+{
+    K230CmuState *s = K230_CMU(opaque);
+    unsigned index;
+    const K230PllRegDesc *desc;
+    uint32_t value;
+
+    if (size != sizeof(uint32_t)) {
+        return 0;
+    }
+
+    desc = k230_pll_desc(addr, &index);
+    if (!desc) {
+        k230_cmu_log_undefined_access("PLL", false, addr, 0);
+        return 0;
+    }
+
+    value = k230_pll_value(&s->pll[index], desc->offset);
+    trace_k230_cmu_pll_read(index, desc->offset, value);
+    return value;
+}
+
+static void k230_pll_write(void *opaque, hwaddr addr, uint64_t value,
+                            unsigned size)
+{
+    K230CmuState *s = K230_CMU(opaque);
+    unsigned index;
+    const K230PllRegDesc *desc;
+    K230PllState *pll;
+    uint32_t *storage;
+    uint32_t write_value = value;
+    uint32_t old_value;
+    uint32_t new_value;
+
+    if (size != sizeof(uint32_t)) {
+        return;
+    }
+
+    desc = k230_pll_desc(addr, &index);
+    if (!desc) {
+        k230_cmu_log_undefined_access("PLL", true, addr, write_value);
+        return;
+    }
+
+    pll = &s->pll[index];
+    old_value = k230_pll_value(pll, desc->offset);
+
+    if (desc->offset == A_CMU_STAT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only PLL%u STAT\n",
+                      TYPE_K230_CMU, index);
+        return;
+    }
+
+    if (desc->offset == A_CMU_CTL) {
+        uint32_t low = write_value & 0xffff;
+        uint32_t enabled = (write_value >> desc->write_enable_shift) &
+                           desc->write_enable_mask;
+        uint32_t old_status = pll->stat;
+        bool powerdown = (enabled & BIT(0)) && (low & BIT(0));
+        bool init = (enabled & BIT(1)) && (low & BIT(1));
+
+        pll->ctl = k230_merge_rw(pll->ctl, low,
+                                 enabled & desc->rw_mask);
+
+        if (powerdown && init) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: PLL%u CTL powerdown/init conflict\n",
+                          TYPE_K230_CMU, index);
+        }
+
+        if (powerdown) {
+            pll->stat = 0;
+        }
+        if (init) {
+            pll->stat = 0x00000021;
+        }
+        if (old_status != pll->stat) {
+            trace_k230_cmu_pll_status(index, old_status, pll->stat);
+        }
+        new_value = k230_pll_value(pll, desc->offset);
+        trace_k230_cmu_pll_write(index, desc->offset, write_value,
+                                  old_value, new_value);
+        return;
+    }
+
+    storage = k230_pll_storage(pll, desc->offset);
+    if (!storage) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: PLL%u %s has no writable storage\n",
+                      TYPE_K230_CMU, index, desc->name);
+        return;
+    }
+    *storage = k230_merge_rw(*storage, write_value, desc->rw_mask);
+    new_value = k230_pll_value(pll, desc->offset);
+    trace_k230_cmu_pll_write(index, desc->offset, write_value,
+                              old_value, new_value);
+}
+
+static const K230SysclkRegDesc *k230_sysclk_desc(hwaddr addr,
+                                                  unsigned *index)
+{
+    for (unsigned i = 0; i < ARRAY_SIZE(k230_sysclk_regs); i++) {
+        if (k230_sysclk_regs[i].offset == addr) {
+            *index = i;
+            return &k230_sysclk_regs[i];
+        }
+    }
+
+    return NULL;
+}
+
+static uint64_t k230_sysclk_read(void *opaque, hwaddr addr, unsigned size)
+{
+    K230CmuState *s = K230_CMU(opaque);
+    unsigned index;
+    uint32_t value;
+
+    if (size != sizeof(uint32_t)) {
+        return 0;
+    }
+
+    if (!k230_sysclk_desc(addr, &index)) {
+        k230_cmu_log_undefined_access("sysclk", false, addr, 0);
+        return 0;
+    }
+
+    value = s->sysclk[index];
+    trace_k230_cmu_sysclk_read(addr, value);
+    return value;
+}
+
+static void k230_sysclk_write(void *opaque, hwaddr addr, uint64_t value,
+                              unsigned size)
+{
+    K230CmuState *s = K230_CMU(opaque);
+    const K230SysclkRegDesc *desc;
+    unsigned index;
+    uint32_t old_value;
+    uint32_t new_value;
+
+    if (size != sizeof(uint32_t)) {
+        return;
+    }
+
+    desc = k230_sysclk_desc(addr, &index);
+    if (!desc) {
+        k230_cmu_log_undefined_access("sysclk", true, addr, value);
+        return;
+    }
+
+    old_value = s->sysclk[index];
+    new_value = k230_merge_rw(old_value, value, desc->rw_mask);
+    s->sysclk[index] = new_value;
+    trace_k230_cmu_sysclk_write(addr, value, old_value, new_value);
+}
+
+static const MemoryRegionOps k230_pll_ops = {
+    .read = k230_pll_read,
+    .write = k230_pll_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static const MemoryRegionOps k230_sysclk_ops = {
+    .read = k230_sysclk_read,
+    .write = k230_sysclk_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_cmu_reset_hold(Object *obj, ResetType type)
+{
+    K230CmuState *s = K230_CMU(obj);
+
+    for (unsigned index = 0; index < K230_PLL_COUNT; index++) {
+        s->pll[index].cfg0 = k230_pll_regs[0].reset[index];
+        s->pll[index].cfg1 = k230_pll_regs[1].reset[index];
+        s->pll[index].ctl = k230_pll_regs[2].reset[index];
+        s->pll[index].stat = k230_pll_regs[3].reset[index];
+    }
+
+    for (unsigned index = 0; index < ARRAY_SIZE(k230_sysclk_regs); index++) {
+        s->sysclk[index] = k230_sysclk_regs[index].reset;
+    }
+}
+
+static void k230_cmu_init(Object *obj)
+{
+    K230CmuState *s = K230_CMU(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->pll_mmio, obj, &k230_pll_ops, s,
+                          "k230-cmu-pll", K230_CMU_SIZE);
+    memory_region_init_io(&s->sysclk_mmio, obj, &k230_sysclk_ops, s,
+                          "k230-cmu-sysclk", K230_SYSCLK_SIZE);
+    sysbus_init_mmio(sbd, &s->pll_mmio);
+    sysbus_init_mmio(sbd, &s->sysclk_mmio);
+}
+
+static const VMStateDescription vmstate_k230_pll = {
+    .name = "riscv.k230.cmu/pll",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(cfg0, K230PllState),
+        VMSTATE_UINT32(cfg1, K230PllState),
+        VMSTATE_UINT32(ctl, K230PllState),
+        VMSTATE_UINT32(stat, K230PllState),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static const VMStateDescription vmstate_k230_cmu = {
+    .name = TYPE_K230_CMU,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(pll, K230CmuState, K230_PLL_COUNT, 1,
+                             vmstate_k230_pll, K230PllState),
+        VMSTATE_UINT32_ARRAY(sysclk, K230CmuState, K230_SYSCLK_REG_COUNT),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void k230_cmu_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    rc->phases.hold = k230_cmu_reset_hold;
+    dc->vmsd = &vmstate_k230_cmu;
+}
+
+static const TypeInfo k230_cmu_info = {
+    .name = TYPE_K230_CMU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230CmuState),
+    .instance_init = k230_cmu_init,
+    .class_init = k230_cmu_class_init,
+};
+
+static void k230_cmu_register_types(void)
+{
+    type_register_static(&k230_cmu_info);
+}
+
+type_init(k230_cmu_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..5f1c9c439d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -28,6 +28,7 @@ system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
 
 # RISC-V devices
+system_ss.add(when: 'CONFIG_K230_CMU', if_true: files('k230_cmu.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c9a868b3ef..bcedea6954 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -66,6 +66,15 @@ ecc_mem_readl_ecr1(uint32_t ret) "Read event count 2 0x%08x"
 ecc_diag_mem_writeb(uint64_t addr, uint32_t val) "Write diagnostic %"PRId64" = 0x%02x"
 ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= 0x%02x"
 
+# k230_cmu.c
+k230_cmu_pll_read(unsigned int pll, uint64_t offset, uint32_t value) "PLL%u read offset=0x%"PRIx64" value=0x%08"PRIx32
+k230_cmu_pll_write(unsigned int pll, uint64_t offset, uint32_t value, uint32_t old_value, uint32_t new_value) "PLL%u write offset=0x%"PRIx64" value=0x%08"PRIx32" old=0x%08"PRIx32" new=0x%08"PRIx32
+k230_cmu_pll_status(unsigned int pll, uint32_t old_status, uint32_t new_status) "PLL%u status old=0x%08"PRIx32" new=0x%08"PRIx32
+k230_cmu_sysclk_read(uint64_t offset, uint32_t value) "sysclk read offset=0x%"PRIx64" value=0x%08"PRIx32
+k230_cmu_sysclk_write(uint64_t offset, uint32_t value, uint32_t old_value, uint32_t new_value) "sysclk write offset=0x%"PRIx64" value=0x%08"PRIx32" old=0x%08"PRIx32" new=0x%08"PRIx32
+k230_cmu_undefined_read(const char *region, uint64_t offset) "%s undefined read offset=0x%"PRIx64
+k230_cmu_undefined_write(const char *region, uint64_t offset, uint32_t value) "%s undefined write offset=0x%"PRIx64" value=0x%08"PRIx32
+
 # empty_slot.c
 empty_slot_write(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "wr addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..d2e365fd70 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -161,4 +161,5 @@ config K230
     select RISCV_IMSIC
     select SERIAL_MM
     select UNIMP
+    select K230_CMU
     select K230_WDT
diff --git a/include/hw/misc/k230_cmu.h b/include/hw/misc/k230_cmu.h
new file mode 100644
index 0000000000..e373ec0aa0
--- /dev/null
+++ b/include/hw/misc/k230_cmu.h
@@ -0,0 +1,58 @@
+/*
+ * Kendryte K230 Clock Management Unit
+ *
+ * Copyright (c) 2026 Simon Law <0860734llx@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Defines the K230 PLL and system-clock register protocol model.  It keeps
+ * software-visible register state but does not provide cycle-accurate clocks
+ * or propagate QEMU Clock signals.
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ *
+ */
+
+#ifndef HW_MISC_K230_CMU_H
+#define HW_MISC_K230_CMU_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_K230_CMU "riscv.k230.cmu"
+OBJECT_DECLARE_SIMPLE_TYPE(K230CmuState, K230_CMU)
+
+#define K230_PLL_COUNT        4
+#define K230_PLL_STRIDE       0x10
+#define K230_SYSCLK_REG_COUNT 32
+
+#define K230_CMU_BASE_ADDR  0x91102000
+#define K230_CMU_SIZE       0x40
+
+#define K230_SYSCLK_BASE_ADDR 0x91100000
+#define K230_SYSCLK_SIZE      0x1000
+
+typedef struct K230PllState {
+    uint32_t cfg0;
+    uint32_t cfg1;
+    uint32_t ctl;
+    uint32_t stat;
+} K230PllState;
+
+typedef struct K230CmuState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion pll_mmio;
+    MemoryRegion sysclk_mmio;
+
+    /* Properties */
+    K230PllState pll[K230_PLL_COUNT];
+    uint32_t sysclk[K230_SYSCLK_REG_COUNT];
+} K230CmuState;
+
+#endif /* HW_MISC_K230_CMU_H */

-- 
2.43.0

