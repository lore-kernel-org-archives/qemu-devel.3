Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9735C48286
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHM-0002S8-Dg; Fri, 26 Jan 2024 09:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHI-0002LT-Kz
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHG-0007xc-Fa
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33ade052953so335741f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279633; x=1706884433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KENK9Mpj18OXyJdvgmdqz6uWTQ8A1jTnhGCoNoZ/oAs=;
 b=XbPhYnoP+Ejo6jE+cWN6QxOCsVRITxzn3oDn5Pa4tTAwxzPiwbbxnilbbs3LTU4pLF
 jgn8mLZZJqlJuw+DtDp+CuV9uKBKLfYuPbpF8kv4NTC5Mt4akEiBXFO8Y/82fBG99oJ8
 Fia9R3WboZR+7bqmRQQswq2j871HUlv6gDGAlzxOs1Kv+cDGuVq99jWAh7hWykE04S3y
 K+9r+vn+VWpgK2p+H9yKfl8G9RyIsjRegUDPtc9EIWHB6VR1zs3ge0h4vxVGhrFIFeDR
 NxN8O3PuWXbdv8VDaNejGI/R7yfJIcZDGfNIhPonTzlUiIWoSvPLQWkRTpIvhjQIAnnV
 P9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279633; x=1706884433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KENK9Mpj18OXyJdvgmdqz6uWTQ8A1jTnhGCoNoZ/oAs=;
 b=NXZq9Aqfd4G++AlwHnBeu0NN7JyBJ1b6iTxO04UkKa3XwXCGSnIc8J3pBR6+lrsXcW
 A9GXn+odU4RxWyN7Uqxg3SlNNDfi/GdUZNhp5tiA3eQtPpumDrKtlQRaBsZ7BhPnarwn
 5Gn9Wv+QxLI9qYIPiXeoPDEN6KKz18nqxzeVrpYvqf4Cz0f8meCZ1tqSDLkAbb8f6CiZ
 lzSfNOhzK1/2O9/HPFF5AwZ34OANfRm7+jtdNtL9MzKT7jYHx6pRMBH7ucpDnaqPX6f8
 F2DU8pYQX/q6tKeL7Hnqc62ASwB+mkLSDYEDR+YC1nru7FGZi+FuDrQenaq9r9bqSo90
 P/bg==
X-Gm-Message-State: AOJu0YwUx4yDDUXZ9qaxBaae8bC1dux70zyYz+8bN7gbaoPaeFDNU6Se
 xUDVkSZh/HIa9kI3fxOOqvhfaUSj+oIdpPWlo2uCY1UQ86zoH4li6tl9mYmM6cWBX5QB6z+Tbac
 e
X-Google-Smtp-Source: AGHT+IFXln4FmTTuxM+HvVjtzdcSWwL2GgAhRb+NQLPYwq8EGSh5L1X9xug/j/ZMTYSosH50/fJlXA==
X-Received: by 2002:a5d:6204:0:b0:337:6f4e:3833 with SMTP id
 y4-20020a5d6204000000b003376f4e3833mr1004795wru.12.1706279632960; 
 Fri, 26 Jan 2024 06:33:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/36] target/arm: Expose M-profile register bank index
 definitions
Date: Fri, 26 Jan 2024 14:33:29 +0000
Message-Id: <20240126143341.2101237-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The ARMv7M QDev container accesses the QDev SysTickState
by its secure/non-secure bank index. In order to make
the "hw/intc/armv7m_nvic.h" header target-agnostic in
the next commit, first move the M-profile bank index
definitions to "target/arm/cpu-qom.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-16-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-qom.h | 15 +++++++++++++++
 target/arm/cpu.h     | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index f795994135f..77bbc1f13c9 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -36,4 +36,19 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
+/* For M profile, some registers are banked secure vs non-secure;
+ * these are represented as a 2-element array where the first element
+ * is the non-secure copy and the second is the secure copy.
+ * When the CPU does not have implement the security extension then
+ * only the first element is used.
+ * This means that the copy for the current security state can be
+ * accessed via env->registerfield[env->v7m.secure] (whether the security
+ * extension is implemented or not).
+ */
+enum {
+    M_REG_NS = 0,
+    M_REG_S = 1,
+    M_REG_NUM_BANKS = 2,
+};
+
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 41659d0ef15..d6a79482adb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -73,21 +73,6 @@
 #define ARMV7M_EXCP_PENDSV  14
 #define ARMV7M_EXCP_SYSTICK 15
 
-/* For M profile, some registers are banked secure vs non-secure;
- * these are represented as a 2-element array where the first element
- * is the non-secure copy and the second is the secure copy.
- * When the CPU does not have implement the security extension then
- * only the first element is used.
- * This means that the copy for the current security state can be
- * accessed via env->registerfield[env->v7m.secure] (whether the security
- * extension is implemented or not).
- */
-enum {
-    M_REG_NS = 0,
-    M_REG_S = 1,
-    M_REG_NUM_BANKS = 2,
-};
-
 /* ARM-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
 #define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
-- 
2.34.1


