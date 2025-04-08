Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA76C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E7I-0004bc-S7; Tue, 08 Apr 2025 14:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7H-0004bH-MR
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7C-0004FY-PN
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so41267685e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138564; x=1744743364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlcZi+8rtV1kSz292TgUOQ9wapPONbfOMzllPxUmecE=;
 b=kGK64M4wXfqtCi/ic0X0ieV2uPfX7j6Sb05H/LR9iDzNZDAqYKx8uOTgk17tukink0
 fQU/sf0UGmY+2Z9dtGPm6UQUZtB2lHGaUIHAR+hchA+5/3WxZTaeM883MNFXX9e1MjzN
 XeOC5fF8QHRvBIouQVOi97/wBSLvi8MM3SlAf6e1QucB93wTXeWfLp4P4Y/e78WJs1M8
 h6M2SUeEiYfqCwWTfGf1Np6zJ+9tQJjQV3LqNP4tEEn9DZ0unYo3moRA2qUppRc/y+XA
 ICZaKFibItoKw+AVfmRN+Khsc2QEl97NNXWidaqd8hSILlTYIo0Hg2DUHVt+9cqXe8c3
 lRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138564; x=1744743364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlcZi+8rtV1kSz292TgUOQ9wapPONbfOMzllPxUmecE=;
 b=PTPXTLnPHpGap1zxGnWSl0k1FBL51vYj2EBBbpfVLce6bOzI0IEK0R2OaooHIuXtEs
 nwQotyBV0qhxIEubTf9hXqBVub38clW6EeuvLLgeJ1vy8/a9I2x56QN6NzvKTCN6WOyA
 xH3CJXHSUK3Btgkh2+iYGp2rj11yvcguzw00hZ3s5pr1+1Bhrd3s8CRXRl6B2rVkoh3I
 OOBV8Vp6JheCb8kSJbrr+xrQU3zLZHbsRtufSMkWcVZvQbtger5e0FK7rHVcNpCF1ipJ
 PE8B3thQ9F1xtaQPBVhQfwsUcZfyeTL5jMduM1uj4pROIWTsU4e1g8ZuHQB2DLJ/DxG4
 I1vA==
X-Gm-Message-State: AOJu0YzSIcaU1Qz/f65Tdi+dWfEXgCNMYbMVB03no/+iJgCTg2YOKt+c
 Oa4HNUMyDj7yYKrDMiIwpVXRAFZ/TmVtu5dN8euTZlSQmw/ZSU5apnMmlJS5L9WO1fdkWRU/Fd+
 w8gE=
X-Gm-Gg: ASbGncs2jnsN+0SQLRox0Y3BqXDIViZYk72XCbrWKxfzGBsqBV8nDMtgdvDKtJXbA8D
 RRRC4OiTUAZ9IVMy+EUoRfo0OrEysUVai6gzi6Hlh4Un1Zaizv9BbOyiNju2UdRZ6AuLVq4Gx4/
 x2Fp64OnQkVQ0ZhvDo+DvCaWUmPcJjiFLkXjXlQSZEyhuj1ze94Ol+CGb4Hi39OW5kejDaSiux9
 +Z0euypXkegOTuC5ut+eJKKNCopN6SDKet5hhskJ8pO8qwOkSjkcYe8McKZ/oxLcRQcJ1I8aVll
 SuXIDk3Olz7xim/jc641CgB0db6SZCi7KGthD+dAbnV0rSvGOl3EsY8wNOtP9XTX3SzQsCm76hU
 m7y4epOwMMGGQqcriIsQ=
X-Google-Smtp-Source: AGHT+IGq24kcHZgqINDMuBeiG6fTbqbOg8pXcDHDRQvuZjhxd6v9FwMtZ14NAp9jAXlTeALTdMUwhQ==
X-Received: by 2002:a05:600c:c08:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-43f1ed4b44cmr1946615e9.26.1744138564254; 
 Tue, 08 Apr 2025 11:56:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b816csm15760639f8f.57.2025.04.08.11.56.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:56:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/8] hw/arm/imx8mp-evk: Remove unimplemented cpu-idle-states
 properties from devicetree
Date: Tue,  8 Apr 2025 20:55:35 +0200
Message-ID: <20250408185538.85538-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408185538.85538-1-philmd@linaro.org>
References: <20250408185538.85538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

The cpu-idle-states property causes a hard boot hang. Rather than documenting
the workaround, perform the removal from the devicetree automatically.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
[Bernhard: split patch, update documentation, adapt commit message]
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20250405214900.7114-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst | 12 ++----------
 hw/arm/imx8mp-evk.c            | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 00527b0cbed..b2f7d29ade5 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -35,7 +35,7 @@ Direct Linux Kernel Boot
 
 Probably the easiest way to get started with a whole Linux system on the machine
 is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
-of writing and involves three steps. First run the following commands in the
+of writing and involves two steps. First run the following commands in the
 toplevel directory of the Buildroot source tree:
 
 .. code-block:: bash
@@ -50,14 +50,6 @@ it and resize the SD card image to a power of two:
 
   $ qemu-img resize sdcard.img 256M
 
-Finally, the device tree needs to be patched with the following commands which
-will remove the ``cpu-idle-states`` properties from CPU nodes:
-
-.. code-block:: bash
-
-  $ dtc imx8mp-evk.dtb | sed '/cpu-idle-states/d' > imx8mp-evk-patched.dts
-  $ dtc imx8mp-evk-patched.dts -o imx8mp-evk-patched.dtb
-
 Now that everything is prepared the machine can be started as follows:
 
 .. code-block:: bash
@@ -65,6 +57,6 @@ Now that everything is prepared the machine can be started as follows:
   $ qemu-system-aarch64 -M imx8mp-evk -smp 4 -m 3G \
       -display none -serial null -serial stdio \
       -kernel Image \
-      -dtb imx8mp-evk-patched.dtb \
+      -dtb imx8mp-evk.dtb \
       -append "root=/dev/mmcblk2p2" \
       -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index f17d5db466d..3bbf2bfbea3 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -15,6 +15,19 @@
 #include "system/qtest.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include <libfdt.h>
+
+static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+    int offset;
+
+    /* Remove cpu-idle-states property from CPU nodes */
+    offset = fdt_node_offset_by_compatible(fdt, -1, "arm,cortex-a53");
+    while (offset >= 0) {
+        fdt_nop_property(fdt, offset, "cpu-idle-states");
+        offset = fdt_node_offset_by_compatible(fdt, offset, "arm,cortex-a53");
+    }
+}
 
 static void imx8mp_evk_init(MachineState *machine)
 {
@@ -32,6 +45,7 @@ static void imx8mp_evk_init(MachineState *machine)
         .board_id = -1,
         .ram_size = machine->ram_size,
         .psci_conduit = QEMU_PSCI_CONDUIT_SMC,
+        .modify_dtb = imx8mp_evk_modify_dtb,
     };
 
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
-- 
2.47.1


