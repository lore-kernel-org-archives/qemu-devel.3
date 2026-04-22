Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DADFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdj7-0005Kj-Sw; Wed, 22 Apr 2026 15:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdiP-0005Dn-0F
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdiJ-00006z-Hc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso61274915e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887897; x=1777492697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ve74Rl3/4sEoFhoxNUOiwE83jUTM3vJjwpNSz44ndVU=;
 b=NhhEvYJNx15GAl4iYl64X36PTJxoiJ67jC1qpDc9rWHstTodnfmRH6Qd+SOFTjNe2C
 wXUzfTEv22GsnHvJZKCpaklXywqU0NWH7G8tMYHdWJW6Ut+J4ta2x972S3Q5XdCswJJb
 nV7EECope/Ucd/xYA1WAKZjA0RC7DEzvfii9KZXmrTAzOHNjsmY8h7LtCi9ukxEFTcvj
 niU1L0tv/a/cJkhGhVq68Kmir+B0qTzaHquuxkddAueNMaHtUDg8YlOK1dREt0EmhzX9
 UlWdyfK+am+BtstuWGFS7eh2H9VsyHFNkH/MlCGVZJP1zLGN7JvEcBMrohy2jFeVZjbh
 jviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887897; x=1777492697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ve74Rl3/4sEoFhoxNUOiwE83jUTM3vJjwpNSz44ndVU=;
 b=Fztxg4V5udTHynJVPL+uJOsI1ch5+4NbFoqbeHEq7v4ISex+4vJDtSrPxKZ3C8lghJ
 Y3yacTXowjOShuqb4BSn4kMrP0XM5cPJeUq1QAFmHEYXgskJ31FzjPCiTCwsf5Yl2LEc
 BJSp0KiujP4ZLysU7qgCeIm8BmAwmVJaOIa3Tg+s2BKIym54xx0NL/90a2jlSZRYHlSL
 53NzM+Re9cSvyFOFLoD+XTdw8NOuUxBCpiLh0ZFQSFZZ2Dbr9R01GiT6SdevNRryjfg9
 F9HMF7X33CqnhFhMd7ApezN6bghZ15HD3WvEXT396K1rxHBhtw/7d6kbef02ZTGCa6wp
 3SXA==
X-Gm-Message-State: AOJu0YxAxHBNfU38Th0TcMvRY6QESWNwN/jVkzBfhO4DPgoAJ8qf7Kw6
 8Y6NXMRHB8Z+fIjLev+UQa53luv/zr3d3pGv/gn3f4ryU+dOuNlmbWYuQxLzxIskdzAHAjanEGJ
 vmgCLT1c=
X-Gm-Gg: AeBDietghynuUsZgnuiS+ZScPCphmsY4BkFJLPD0S2pbqaYr3bqfPysVpJ3E+0nOhk0
 UVyPJGOcn3N1x62G99VSphA19URuL7Xv8BhyGyIt0OhOlAgWcqQ8ij3lxufnFkf/aOSHB9ZsqI8
 bQtCLwokvl31DGnAaSZ5kBf07Alg7+FVKjZXsK26TnWpWXsID4h5Y/pAvcp3d3n+4Mb0WvNf3z8
 TcXuM6WQdqqd8FZv8XkwcHCZEAy8ixFWhX8dxkqIHSb/1mboZ8NHPYAbNSEAzReKV/QPdeWjHs8
 m/Z+Smc/msxopqKBXR7mHHd/hTk1GK548vVWRijFxJ3XmRSp7hj6EPeDygw4KmJvwdknHVbrdgT
 /bsoW3qO3+FTxUM9KBSYQpJDphNfYUCxwFaT24IDFGnc5m5ocZ2n2yjQefrXhHX3yzgloXu9++i
 fDybGDuRjW8Y7TC43KeTaw/JdClK1av+QShS9kg2Tpm6AMBj+2NtHWigQYa2qFWgWzh3YjdYSf6
 pvvMKf5Huc=
X-Received: by 2002:a05:600c:5295:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-488fb77d0fdmr336901515e9.17.1776887896816; 
 Wed, 22 Apr 2026 12:58:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c318636sm267001395e9.7.2026.04.22.12.58.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/48] hw/arm: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:02 +0200
Message-ID: <20260422195746.88865-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-22-philmd@linaro.org>
---
 include/hw/arm/digic.h           | 2 +-
 include/hw/arm/fsl-imx6.h        | 2 +-
 include/hw/arm/fsl-imx6ul.h      | 2 +-
 include/hw/arm/fsl-imx7.h        | 2 +-
 include/hw/arm/fsl-imx8mp.h      | 2 +-
 hw/arm/boot.c                    | 2 +-
 hw/arm/exynos4210.c              | 2 +-
 hw/arm/mps3r.c                   | 2 +-
 hw/arm/omap1.c                   | 2 +-
 hw/arm/realview.c                | 2 +-
 hw/arm/smmuv3.c                  | 2 +-
 hw/intc/arm_gicv3_cpuif.c        | 2 +-
 hw/intc/arm_gicv3_cpuif_common.c | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/digic.h b/include/hw/arm/digic.h
index 8f2735c284f..646802806e0 100644
--- a/include/hw/arm/digic.h
+++ b/include/hw/arm/digic.h
@@ -18,7 +18,7 @@
 #ifndef HW_ARM_DIGIC_H
 #define HW_ARM_DIGIC_H
 
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "hw/timer/digic-timer.h"
 #include "hw/char/digic-uart.h"
 #include "qom/object.h"
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index bb866994dff..cddd100dd6e 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -35,7 +35,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/core/or-irq.h"
 #include "system/memory.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "qom/object.h"
 
 #define TYPE_FSL_IMX6 "fsl-imx6"
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 4e3209b25b2..f8f9c249a23 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -34,7 +34,7 @@
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "system/memory.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 710831c8bf5..a573e0dd4f8 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -37,7 +37,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
 #include "hw/core/or-irq.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 4b367b754c6..3b6183ed1d6 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -9,7 +9,7 @@
 #ifndef FSL_IMX8MP_H
 #define FSL_IMX8MP_H
 
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/i2c/imx_i2c.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c97d4c4e118..780b6be6371 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -14,7 +14,7 @@
 #include <libfdt.h>
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "exec/tswap.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 25c385ba1f5..5efe95030c0 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/tswap.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/core/irq.h"
 #include "system/blockdev.h"
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 2d64a198c42..caad820d3bc 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "qobject/qlist.h"
 #include "system/address-spaces.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/core/or-irq.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 47d0f0d7362..980959166d3 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "system/address-spaces.h"
 #include "exec/cpu-common.h"
 #include "hw/core/hw-error.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index c9558be4d45..7e8acd34acd 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7fead1c3cff..5570a13c8a6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -26,7 +26,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev.h"
 #include "hw/pci/pci.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "exec/target_page.h"
 #include "trace.h"
 #include "qemu/log.h"
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index eaf1e512ede..fcb3922fa0f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -19,7 +19,7 @@
 #include "trace.h"
 #include "gicv3_internal.h"
 #include "hw/core/irq.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 #include "target/arm/cpregs.h"
 #include "target/arm/cpu-features.h"
 #include "target/arm/internals.h"
diff --git a/hw/intc/arm_gicv3_cpuif_common.c b/hw/intc/arm_gicv3_cpuif_common.c
index ff1239f65db..e03085592e4 100644
--- a/hw/intc/arm_gicv3_cpuif_common.c
+++ b/hw/intc/arm_gicv3_cpuif_common.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "gicv3_internal.h"
-#include "cpu.h"
+#include "target/arm/cpu.h"
 
 void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
 {
-- 
2.53.0


