Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9F5106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vvj-0007fh-E7; Fri, 13 Mar 2026 02:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvh-0007WI-LV
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:25 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvf-00076g-Hx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:25 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439c5b40f60so1520168f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383001; x=1773987801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4Xxn2Q6fozeNQOh+Qr255ExGcJN7U/Zck3EiJ/5xgw=;
 b=iBQNkmTyOh5MYGV7+iONExtMzyyPKDeOdgpmzkHrD0RDjI0IphNzbdxPu8hTH8m8x5
 glF39SbiYmziA6hAMT7upNRD1M/ONkNNrUNBKoJvCFMcfM6Eu5x6fp5v0sJaN6pwn7Rg
 pmDKtJPGMwWEdUB/PXNCUsktVgY7fUqeIlX+2ww5Op/01Urt7c2ZCU2S4gVnxj4zrVTA
 IAH6lAXwD7FWq1bUox0tHSp34/PlMwNVV1meW/ZJZlpknZy6N35AYneJ20T2sFWlDi4W
 YciYcVfq9pc1j3we1qpgcZnyBwzdGzdVpAFZSvDGeMdO+d4CnQWjuVQYxYTcNzIpzqCz
 o47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383001; x=1773987801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z4Xxn2Q6fozeNQOh+Qr255ExGcJN7U/Zck3EiJ/5xgw=;
 b=LNXK1kzn0o4iMxK0jiJlUfTnGFAKjRXC1O4RWN+kZECxxhOyYgM0hyP8Ed94X1sMDv
 PneEEUwqOS/vQGQBFixBKktJBjckob06rXqOhCMlZDuadwngL5Dc7Cpaqy7KFbcDPR2o
 9/IYFz09w4BL4lojcPxo60BP1ACICq7nvu3y2pbwGdNTlqLnZD/oudg4a3yMicaHJkGt
 IChgbQcsYf8nV1pMvmqa/MS1D5ehMuRF6hBEcJqDfgO1o4Ddj8UDWqN7lNuDNAZ/9Qce
 92vNI182+eG27xfej6qppaSHsLgb5Tzf1rka6q4lfYVJE+bxPJ9jnyGBRNpQo+FSXwXh
 lBFw==
X-Gm-Message-State: AOJu0Yxj9b5XQy3XP3g+q1DuLmUBtis7ptgb2YDmyorBaWWOvtQ1OnNL
 1KFzc+JoJyk0poXP9RZrTrFV+8BohBMFEhj409qKOjTj1FsJcO3zjJTBBarouykM7Vm5ci+pa+f
 4HfBWt5U=
X-Gm-Gg: ATEYQzwE5x9IMTDtR2dCoOWZf4x6d2sGCy+CRlGd5msPIWB9QZy5AwLpGV1xBLSEAdH
 4rqrzDTOs4ufHmQBSf8/E4XKqID7SOk+Y96fLpuy0Al7TExaEWaxJ8cgdnds6xmJk1nVzd/+b0b
 V3DVXh9B2OjFSswX/YyRk7xeGSmj80IPK4983SJlTOvfC0DMXc8G6w7xbkzssEK4onc4jKfoQEv
 0pDU0Szu1+67DR+5IJ1natKaSpXQflCqv+bz4BZpSHpgn4kqS7gPG6YTPX1O/s+tqCTBiM8v0KO
 2EoG+YWNS8sT+kq242WEzZm344RXllDXa4erRRLj+Uilji+Fpq55OIwoZNFJro0Ii4YmIwsT9GV
 hyuzshkA1NnXpXhrwNfSYS2qbgcWM/GqlceiiIChz5RiH1FxkIp4BpQb6mxQmRzycpFY3gRgfx5
 2rd/AJ/WkUiJU5FSAe18Va9Tq4KS5A2EYYN2lJQWlBgT2cUxItgXaTzQ6v1cnbLaIiX81NYc9nE
 RNdEA==
X-Received: by 2002:a05:6000:24c4:b0:430:f985:a7b2 with SMTP id
 ffacd0b85a97d-43a04dce49fmr3862271f8f.51.1773383000645; 
 Thu, 12 Mar 2026 23:23:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2273d9sm16715877f8f.34.2026.03.12.23.23.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:23:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 21/38] hw/arm: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:37 +0100
Message-ID: <20260313062055.2188-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
index 068108e49b8..b83e3c99ea5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -25,7 +25,7 @@
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


