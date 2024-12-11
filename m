Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C55E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSy-0002FD-Hh; Wed, 11 Dec 2024 11:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSe-0001C9-3T
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSb-0007rr-Gn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:15 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so6283315e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934072; x=1734538872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IFPKx6cYxrOvlpHIeqyqWQFosyF9dmEm3zNoKTLP07g=;
 b=iCAD+7vpeNZ/9IrqtOG5bA6q2iOm009NOckFR+ZiYLY2vKwp2+XxDwJcFTAGMJMygt
 WdLWBHYjWqm1myyp+jjsuCRnl0FLmLYVfoBfly+qWHqXrlr2B8BEVQXOwTSgWyTKCac2
 J3yTjIUSy0huTinqHGJGu7/VHLbiCtk3VAHh7fV6LOwgqCMfHatmTck6fLJ5EJ1ZqE2E
 8xbHZNLnJ+cqYospH/3LFaB4YwEMy39d5lbdDYmev84noJQwDvmbZ63KL5TmWyn/DI1P
 /0JctsF1/opeOG+KfPbURehpE1uX6cfqsqyYTGhw0JHMjB4H+lQemgfHvioN/Trht2uL
 ur8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934072; x=1734538872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFPKx6cYxrOvlpHIeqyqWQFosyF9dmEm3zNoKTLP07g=;
 b=BpUm4WpUs45pBxdM8J9FiD5uWOjOX0WtjVmq+03yezd79yT+HSu7KIken2vVQvleTb
 Hm3JLWzZT+blgi5qMrTjWo0cxgGNcHj2q/TQkXgt63daHoiqz4rQf743fe/R2s+fJ4J/
 hMOLmZv8fCRFlmrw1cCaEP6mGZdl+3ZNr0+5S4IjR1LDl4z1uiwPD+DC6xzwF4oxbEg/
 o+UZ5zvvyC/VQkVregXWh57whxC2KvRsKIuZFp3FCyW3Mm9HVR84lgYaOzjes/QsblG/
 lelcZhSYEF9i0kZf2zftFMgfm7M/797RWbQCR3GGIUqwa386VnJgUXgOlh9djQ7Zp1Ls
 6kmA==
X-Gm-Message-State: AOJu0YxzHuaKIHa0A2udWgnc0HTdZRQWF4Jhj/9osk2Hcz8lQsXShA+V
 CCo/FZ/MAOyGWyrEdUwO+g6KYN3q+smuGAc4wVkkcYMxX8iNv7RgVz7FnuoHqAiBW9Y3xqxf+FA
 0
X-Gm-Gg: ASbGnctJ0VnefmLcd1Ft/zkLiTBKdK2zDQwmBgE3R/efg4ySY2UK8yvWV4uYWuiznJ+
 m+IXpEiyfSMQqRBmt4dNTOoSXTZe72aqr+vN2AuhwFeMPxTZOkGzUQ1r8i4EgkOSDevkAY6VoSN
 v3dI3we8jOFh5OlU0yqVKkdl3NFXqfEjzLmeE/iRPyZs2Olp8sWZMo4fcRibQzbyrSOlacqHowQ
 Zs8QpvytvxyUUknQlrcq6W3l/4/7zNkNCXfvXjczLAs2lFU4wPrX2DBaAV8
X-Google-Smtp-Source: AGHT+IFgALN1tr+hGo70Nn9IjutlVZg2DSV8/SNXwZN3p4s5bLCivPQIv+sT6nQ/dpQB2Hh/IR/CAQ==
X-Received: by 2002:a05:600c:1d2a:b0:434:ff25:19a0 with SMTP id
 5b1f17b1804b1-4362286c0eemr2809375e9.21.1733934071983; 
 Wed, 11 Dec 2024 08:21:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/72] target/hexagon: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:49 +0000
Message-Id: <20241211162004.2795499-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Set the default NaN pattern explicitly for hexagon.
Remove the ifdef from parts64_default_nan(); the only
remaining unconverted targets all use the default case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-52-peter.maydell@linaro.org
---
 target/hexagon/cpu.c           | 2 ++
 fpu/softfloat-specialize.c.inc | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 020038fc490..c9aa9408ec8 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -286,6 +286,8 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 
     set_default_nan_mode(1, &env->fp_status);
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
+    /* Default NaN value: sign bit set, all frac bits set */
+    set_float_default_nan_pattern(0b11111111, &env->fp_status);
 }
 
 static void hexagon_cpu_disas_set_info(CPUState *s, disassemble_info *info)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 06185237d0f..5954a6213b9 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -136,10 +136,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     uint8_t dnan_pattern = status->default_nan_pattern;
 
     if (dnan_pattern == 0) {
-#if defined(TARGET_HEXAGON)
-        /* Sign bit set, all frac bits set. */
-        dnan_pattern = 0b11111111;
-#else
         /*
          * This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
          * S390, SH4, TriCore, and Xtensa.  Our other supported targets
@@ -152,7 +148,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
             /* sign bit clear, set frac msb */
             dnan_pattern = 0b01000000;
         }
-#endif
     }
     assert(dnan_pattern != 0);
 
-- 
2.34.1


