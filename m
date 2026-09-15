Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE6FC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdW-0005Wd-NB; Tue, 15 Sep 2026 13:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdT-0005SP-0h
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:59 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdR-0003Xf-7O
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:58 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so701925e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492076; x=1790096876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GJ41tkN+lvV5QjsjeUYBWj7BsbqyOir9g2RDv+4MWtk=;
 b=D7qnoyJNG1FAGjfwkYEAi0bGJDgniAchtJBN3eeAiMPncGpnpwFtD87g6+vM1vLj1P
 QMLnDGh6IUt8Y8Lp7OxKK/vPmSjvGPLSFLAvNo3pZ8pexh3rcbtnNaCIxVe6aXJkwf1B
 yI+53VKDNRhKjpTkFaura3+12lei91C8rX+WP9IKW3DtR1o5hdaNAj21X5veZrpIvTzM
 lqRghQxYyujb9idS6ytbFds+WvQGL4gh9yi8hx7z6GU3/23eImCCm2xoj9Iub8aiqUol
 ZGNsdCKyMtuVxt3ZACXWiyHWfyLDtkw/kbE85tr5uzctpP95RE5inby5EOp4kWLs4pHd
 pcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492076; x=1790096876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GJ41tkN+lvV5QjsjeUYBWj7BsbqyOir9g2RDv+4MWtk=;
 b=DsVKgipGivXeYVMHOTvwRJVe4+iax4z1xRSkZK6IxN7vO17slXwdQ5i8XTHHdn31rS
 c98oMrVQF5vawJjhWInlTEJASwozII6oWLP4eUOu9OlfhnhL1pK3X34MFaRsnU0xFcpw
 zUBnNaS4OGb89xTr7dP/NQC2BcOIuzox1DD4f9zqvz5xYsnQ1Gc2PIdfqGgYDYpZEg9I
 eUhg6lVpOiok2C2NYLw1KvrrJtcUiVuMYLZb4vWaZuT7M5sd5W0HsDBnIe8C/QaQoSNf
 k6ytMOKPAQfZJMS8nKxVrBvghTwRsuU3AcLEPogDohL41/v9miR+fQwBKLfe/2dI52tR
 G8wQ==
X-Gm-Message-State: AFuF++lIs0pu5FuMS/obl3+DNTc2GMgcTKU/zIOQ9EGQE3kREEcK0dA7
 7xCpFX0JjJGDUvoODj2yUzgkg0iMKrpNRbzgvdFi9rIlXaLHBFmucuDDXJZQpqGh6WWKfd+hRFM
 gPxobACU=
X-Gm-Gg: AYBFou17SU8LaW2S0fEM3FkbHUcJcj+2HLK/wRN0jHyNi16Z7nGroBZvFZLg4ifj9NG
 oXtGxOGbXLgCIFgGCJFEb81+ucWhhMDXVHJbadmIcAeM1Z7PvzN/+iICtkiuOlhA3ATp4tADjuI
 uWmkgUOlo2btbUD3SrENq3CdqRt0OvXcvmL+x1LFPAR2gxEtw3MyOcSVoyP4ehIxybcVCw4olwT
 gwkmiG7z6DVPizkgP567PZ8elZPFlRRQcmuMNjDr+k4rp8lsHGpNH0hFsj/CI4NvtT4/iLZGSHq
 FmAgEr0/xVchfqJ9oZWUMBoJ2iu7ThhLSqjGJzd4liro+R/14XJMK/6qNs6Rqydbd0cj2BEEXRu
 Gl98L2Qn+4X7q+9N6O0Fi4XF8THf9DtTnNG/0Ed08oFTE2wAxgDITqSz1GbBlmsHOq6cu2pQzRP
 BTo11ujnH83BRJdW3msyrs0IlQt11v2FleyGGEjbTvzHIQhYbuX0J5FJcVraIcHVM57e7diki8+
 vz+oaJ+hD04Px+2TgwnQmhuzTefbsoiXNr2/LPBsHVN9CMEmJSrRk7PF3biz6Ds7S6z2LHbcGBe
 EZu4/Q==
X-Received: by 2002:a05:600c:3b1f:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49e822123f2mr29265555e9.9.1789492075897; 
 Tue, 15 Sep 2026 10:07:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] target/arm: enforce Armv6-M NVIC limits
Date: Tue, 15 Sep 2026 18:07:31 +0100
Message-ID: <20260915170735.425445-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x11.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

Armv6-M supports no more than 32 external interrupts. Its ICTR and Active
Bit Register locations are reserved, and Cortex-M0 implements two priority
bits.

Reject Armv6-M NVIC configurations with more than 32 external interrupts.
Add a check-tcg test that verifies the reserved register behavior and
priority masking on the microbit machine.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c                   |  5 ++
 tests/tcg/arm/system/meson.build        |  6 +++
 tests/tcg/arm/system/test-armv6m-nvic.S | 70 +++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 tests/tcg/arm/system/test-armv6m-nvic.S

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a7651f831eb..b1d27dfb32d 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2728,6 +2728,11 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7) && s->num_irq > 32) {
+        error_setg(errp, "Armv6-M NVIC cannot exceed 32 external IRQs");
+        return;
+    }
+
     qdev_init_gpio_in(dev, set_irq_level, s->num_irq);
 
     /* include space for internal exception vectors */
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 4c77b9c3d62..52869976704 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -39,6 +39,12 @@ tests += {
                '-T', files('test-armv6m-undef.ld')],
     'qemu_args': ['-M', 'microbit', qemu_base_args],
   },
+  'test-armv6m-nvic.S': {
+    'cflags': ['-mcpu=cortex-m0', '-mfloat-abi=soft', '-nostdlib',
+               '-Wl,--build-id=none',
+               '-T', files('test-armv6m-undef.ld')],
+    'qemu_args': ['-M', 'microbit', qemu_base_args],
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
diff --git a/tests/tcg/arm/system/test-armv6m-nvic.S b/tests/tcg/arm/system/test-armv6m-nvic.S
new file mode 100644
index 00000000000..ecb29eaa3d2
--- /dev/null
+++ b/tests/tcg/arm/system/test-armv6m-nvic.S
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test Armv6-M NVIC register behavior. */
+
+.syntax unified
+.cpu cortex-m0
+.thumb
+
+#define SRAM_BASE 0x20000000
+#define SRAM_SIZE (16 * 1024)
+
+#define NVIC_ICTR  0xe000e004
+#define NVIC_IABR0 0xe000e300
+#define NVIC_IPR0  0xe000e400
+
+#define semihosting_call bkpt 0xab
+#define SYS_EXIT 0x18
+
+vector_table:
+    .word SRAM_BASE + SRAM_SIZE
+    .word reset + 1
+    .word 0
+    .word failure + 1
+    .rept 44
+    .word 0
+    .endr
+
+.equ exc_reset_thumb, reset + 1
+.global exc_reset_thumb
+reset:
+    /* ICTR is reserved and reads as zero on Armv6-M. */
+    ldr r0, =NVIC_ICTR
+    ldr r1, [r0]
+    cmp r1, 0
+    bne failure
+
+    /* The Active Bit Register is reserved and behaves as RAZ/WI. */
+    ldr r0, =NVIC_IABR0
+    movs r1, 1
+    str r1, [r0]
+    ldr r1, [r0]
+    cmp r1, 0
+    bne failure
+
+    /* Cortex-M0 implements the two most significant priority bits. */
+    ldr r0, =NVIC_IPR0
+    movs r1, 0xff
+    strb r1, [r0]
+    ldrb r1, [r0]
+    cmp r1, 0xc0
+    bne failure
+
+success:
+    movs r0, 1
+    b exit
+
+failure:
+    movs r0, 0
+
+exit:
+    movs r1, 0
+    cmp r0, 1
+    bne 1f
+    ldr r1, ADP_Stopped_ApplicationExit
+1:
+    movs r0, SYS_EXIT
+    semihosting_call
+
+.align 2
+ADP_Stopped_ApplicationExit:
+    .word 0x20026
-- 
2.43.0


