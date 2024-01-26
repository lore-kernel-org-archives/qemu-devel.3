Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0195C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHM-0002SV-MK; Fri, 26 Jan 2024 09:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHJ-0002N7-MN
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:57 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHH-0007y0-7F
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:57 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-337d99f9cdfso591105f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279634; x=1706884434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kT4FU7BdZDSw/ALIzrvXiPFzXH+nnZjgGXux5dvXWzU=;
 b=c7Xl2/sNXTUtr1/4+SKNJ6fPqdR7fKXe1KPPGRGnkSvGrAduSUkdjkOWBXMJBw0UNd
 CKDATmOMCVAQ8w0dIxcYbkgiBCf1vr49gq5WkdeMrvOhl36c95wLvYw/NQQuUPt8kxAl
 NTpMv0dS/GJz0aZCRKlcgi+doM5QY4rQTIYclszcJaVJILsdlRzlAgVZSj0pGNjYTV+U
 Dl2Q7/dqF7FMLr/edBKkSXIDiZwpiBoF6nmzMd2cCmmOgAOHVu7+Gu3M9eQIgkevtRd8
 v7+TgqXuXACGHN8NkPpOK67lTxjcuooEMP8mSsbQmZqmFhwYUe4ldvT/pAVnQ0p+ZxT8
 zRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279634; x=1706884434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kT4FU7BdZDSw/ALIzrvXiPFzXH+nnZjgGXux5dvXWzU=;
 b=a9/4HAllDQzUPhMPfHfZkVnHywReeJHWnMCvSzEDJpowf9xWMVb+Rb3r3F0ljRNdTP
 gToGLSBUralLyRl2/9rG9Oq86EWR5wN5MhLMiWsxv2T0HGNS6tqDyN0BrOW9DAN7yL32
 6obERsjvm0+h5/iwxIJKRTZI/WbL+LHInmstFsulpH05QHthCBFYk6pvQlQLBnF3oLmw
 fgtIhXe8rFQ6NL/G21pQdCRrA3/9OQ+NfUzOn1SeSe4xR8hJAqri67xVDaS96rEYrLwQ
 FOyalFo/d67LxpZL/uIoleCKmue+qg2wqkYruuOgtgwFEBUnJWv7deIE1DxGAMoNUbRU
 YMOg==
X-Gm-Message-State: AOJu0Yz17LTbkzs4lGr5IdDdMX0SOJY6q3EoP+iYTXIkqFmn2qh7F35T
 Yk2Q0Sle9hGRFpHC0A6yacmXE1vLQ5QjjbD0cIijRUEopb8A4IbuixhCOEPr9Sx9NySHFTVgGdL
 2
X-Google-Smtp-Source: AGHT+IEkiTHfQG3tdDenazw7FYn1Siu3aWSas6UF2onyIPEg4QzLqYcqHoKj1TRFblQSKARMa4oJjg==
X-Received: by 2002:adf:f103:0:b0:337:bfa5:221a with SMTP id
 r3-20020adff103000000b00337bfa5221amr981373wro.107.1706279633775; 
 Fri, 26 Jan 2024 06:33:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/36] target/arm: Move ARM_CPU_IRQ/FIQ definitions to
 'cpu-qom.h' header
Date: Fri, 26 Jan 2024 14:33:31 +0000
Message-Id: <20240126143341.2101237-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The ARM_CPU_IRQ/FIQ definitions are used to index the GPIO
IRQ created calling qdev_init_gpio_in() in ARMCPU instance_init()
handler. To allow non-ARM code to raise interrupt on ARM cores,
move they to 'target/arm/cpu-qom.h' which is non-ARM specific and
can be included by any hw/ file.

File list to include the new header generated using:

  $ git grep -wEl 'ARM_CPU_(\w*IRQ|FIQ)'

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-18-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-qom.h    | 6 ++++++
 target/arm/cpu.h        | 6 ------
 hw/arm/allwinner-a10.c  | 1 +
 hw/arm/allwinner-h3.c   | 1 +
 hw/arm/allwinner-r40.c  | 1 +
 hw/arm/armv7m.c         | 1 +
 hw/arm/aspeed_ast2400.c | 1 +
 hw/arm/aspeed_ast2600.c | 1 +
 hw/arm/bcm2836.c        | 1 +
 hw/arm/exynos4210.c     | 1 +
 hw/arm/fsl-imx25.c      | 1 +
 hw/arm/fsl-imx31.c      | 1 +
 hw/arm/fsl-imx6.c       | 1 +
 hw/arm/fsl-imx6ul.c     | 1 +
 hw/arm/fsl-imx7.c       | 1 +
 hw/arm/highbank.c       | 1 +
 hw/arm/integratorcp.c   | 1 +
 hw/arm/musicpal.c       | 1 +
 hw/arm/npcm7xx.c        | 1 +
 hw/arm/omap1.c          | 1 +
 hw/arm/omap2.c          | 1 +
 hw/arm/realview.c       | 1 +
 hw/arm/sbsa-ref.c       | 1 +
 hw/arm/strongarm.c      | 1 +
 hw/arm/versatilepb.c    | 1 +
 hw/arm/vexpress.c       | 1 +
 hw/arm/virt.c           | 1 +
 hw/arm/xilinx_zynq.c    | 1 +
 hw/arm/xlnx-versal.c    | 1 +
 hw/arm/xlnx-zynqmp.c    | 1 +
 target/arm/cpu.c        | 1 +
 31 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 77bbc1f13c9..8e032691dbf 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -36,6 +36,12 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
+/* Meanings of the ARMCPU object's four inbound GPIO lines */
+#define ARM_CPU_IRQ 0
+#define ARM_CPU_FIQ 1
+#define ARM_CPU_VIRQ 2
+#define ARM_CPU_VFIQ 3
+
 /* For M profile, some registers are banked secure vs non-secure;
  * these are represented as a 2-element array where the first element
  * is the non-secure copy and the second is the secure copy.
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d6a79482adb..e8df41d642e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -93,12 +93,6 @@
 #define offsetofhigh32(S, M) (offsetof(S, M) + sizeof(uint32_t))
 #endif
 
-/* Meanings of the ARMCPU object's four inbound GPIO lines */
-#define ARM_CPU_IRQ 0
-#define ARM_CPU_FIQ 1
-#define ARM_CPU_VIRQ 2
-#define ARM_CPU_VFIQ 3
-
 /* ARM-specific extra insn start words:
  * 1: Conditional execution bits
  * 2: Partial exception syndrome for data aborts
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 0135632996c..581dd45edf0 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -26,6 +26,7 @@
 #include "hw/boards.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/loader.h"
+#include "target/arm/cpu-qom.h"
 
 #define AW_A10_SRAM_A_BASE      0x00000000
 #define AW_A10_DRAMC_BASE       0x01c01000
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index f05afddf7e0..2d684b5287b 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -30,6 +30,7 @@
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
+#include "target/arm/cpu-qom.h"
 
 /* Memory map */
 const hwaddr allwinner_h3_memmap[] = {
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index a28e5b3886a..79976b0b54d 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/misc/allwinner-r40-dramc.h"
+#include "target/arm/cpu-qom.h"
 
 /* Memory map */
 const hwaddr allwinner_r40_memmap[] = {
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index edcd8adc748..7c68525a9e6 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -23,6 +23,7 @@
 #include "target/arm/idau.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-features.h"
+#include "target/arm/cpu-qom.h"
 #include "migration/vmstate.h"
 
 /* Bitbanded IO.  Each word corresponds to a single bit.  */
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 0baa2ff96e4..ad76035528f 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -21,6 +21,7 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
+#include "target/arm/cpu-qom.h"
 
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
 
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 3a9a303ab8b..386a88d4e0f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -16,6 +16,7 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
+#include "target/arm/cpu-qom.h"
 
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
 #define ASPEED_SOC_DPMCU_SIZE       0x00040000
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index b0674a22a6c..58a78780d2b 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -15,6 +15,7 @@
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
+#include "target/arm/cpu-qom.h"
 
 struct BCM283XClass {
     /*< private >*/
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index af511a153dd..6c428d8eeb4 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -36,6 +36,7 @@
 #include "hw/arm/exynos4210.h"
 #include "hw/sd/sdhci.h"
 #include "hw/usb/hcd-ehci.h"
+#include "target/arm/cpu-qom.h"
 
 #define EXYNOS4210_CHIPID_ADDR         0x10000000
 
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 9d2fb75a689..4a49507ef19 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/qdev-properties.h"
 #include "chardev/char.h"
+#include "target/arm/cpu-qom.h"
 
 #define IMX25_ESDHC_CAPABILITIES     0x07e20000
 
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index c0584e4dfcd..4b8d9b8e4fe 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -26,6 +26,7 @@
 #include "exec/address-spaces.h"
 #include "hw/qdev-properties.h"
 #include "chardev/char.h"
+#include "target/arm/cpu-qom.h"
 
 static void fsl_imx31_init(Object *obj)
 {
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index af2e982b052..42f90588251 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -29,6 +29,7 @@
 #include "chardev/char.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "target/arm/cpu-qom.h"
 
 #define IMX6_ESDHC_CAPABILITIES     0x057834b4
 
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index e37b69a5e16..486a009deb8 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -25,6 +25,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "target/arm/cpu-qom.h"
 
 #define NAME_SIZE 20
 
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 474cfdc87c6..57281094918 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -26,6 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "target/arm/cpu-qom.h"
 
 #define NAME_SIZE 20
 
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index c21e18d08fd..e6e27d69af5 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -36,6 +36,7 @@
 #include "qemu/log.h"
 #include "qom/object.h"
 #include "cpu.h"
+#include "target/arm/cpu-qom.h"
 
 #define SMP_BOOT_ADDR           0x100
 #define SMP_BOOT_REG            0x40
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 1830e1d7850..5600616a4dd 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -28,6 +28,7 @@
 #include "hw/sd/sd.h"
 #include "qom/object.h"
 #include "audio/audio.h"
+#include "target/arm/cpu-qom.h"
 
 #define TYPE_INTEGRATOR_CM "integrator_core"
 OBJECT_DECLARE_SIMPLE_TYPE(IntegratorCMState, INTEGRATOR_CM)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 6987472871e..a2d25139e20 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -39,6 +39,7 @@
 #include "hw/net/mv88w8618_eth.h"
 #include "audio/audio.h"
 #include "qemu/error-report.h"
+#include "target/arm/cpu-qom.h"
 
 #define MP_MISC_BASE            0x80002000
 #define MP_MISC_SIZE            0x00001000
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 7fb0a233b2d..e3243a520d8 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"
+#include "target/arm/cpu-qom.h"
 
 /*
  * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index d5438156ee9..86ee336e599 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -40,6 +40,7 @@
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
 #include "qemu/bcd.h"
+#include "target/arm/cpu-qom.h"
 
 static inline void omap_log_badwidth(const char *funcname, hwaddr addr, int sz)
 {
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index f170728e7ec..f159fb73ea9 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -39,6 +39,7 @@
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "audio/audio.h"
+#include "target/arm/cpu-qom.h"
 
 /* Enhanced Audio Controller (CODEC only) */
 struct omap_eac_s {
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 132217b2edd..566deff9ced 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -30,6 +30,7 @@
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
 #include "audio/audio.h"
+#include "target/arm/cpu-qom.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index b8857d1e9e4..d6081bfc41f 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -50,6 +50,7 @@
 #include "net/net.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object.h"
+#include "target/arm/cpu-qom.h"
 
 #define RAMLIMIT_GB 8192
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index fef3638acaa..75637869cba 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -46,6 +46,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qom/object.h"
+#include "target/arm/cpu-qom.h"
 
 //#define DEBUG
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 4b2257787b2..15b5ed0cedc 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -27,6 +27,7 @@
 #include "hw/sd/sd.h"
 #include "qom/object.h"
 #include "audio/audio.h"
+#include "target/arm/cpu-qom.h"
 
 #define VERSATILE_FLASH_ADDR 0x34000000
 #define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index fd981f4c33e..49dbcdcbf0c 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -46,6 +46,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 #include "audio/audio.h"
+#include "target/arm/cpu-qom.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1e0df6ea3ad..64802446cb1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -73,6 +73,7 @@
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
+#include "target/arm/cpu-qom.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
 #include "hw/mem/pc-dimm.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index d4c817ecdc0..5809fc32af9 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -38,6 +38,7 @@
 #include "sysemu/reset.h"
 #include "qom/object.h"
 #include "exec/tswap.h"
+#include "target/arm/cpu-qom.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9600551c442..87fdb39d430 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -23,6 +23,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
+#include "target/arm/cpu-qom.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 5905a330151..38cb34942f8 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -25,6 +25,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "kvm_arm.h"
+#include "target/arm/cpu-qom.h"
 
 #define GIC_NUM_SPI_INTR 160
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 04296f2928f..4807a4fea0d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -48,6 +48,7 @@
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
 #include "cpregs.h"
+#include "target/arm/cpu-qom.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.34.1


