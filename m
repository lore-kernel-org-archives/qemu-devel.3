Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFF1CD1296
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglZ-0006DA-HN; Fri, 05 Apr 2024 06:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglU-0006Bv-SV
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:45 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglT-0004pr-3C
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:44 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5a50880ce2aso1152569eaf.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312741; x=1712917541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gRnORP5tdE9/lL+Q019gMHhCwR/8xBUigSwS4zxh6g=;
 b=i4o2DKaYsLdJmY76dnMKgAvC7QsxqWX0JuP9LE3GSzqtcj2PwV11/2tboUPECMZ4GX
 nxTDO2ND/O3EW9QWShkOttAdXmV4EVG0zEi0IyWAryY27zCg1U+JJ0zXppBmdrRf7xte
 gWyTE51iytejPtbLURCh/PLCYt7TGjUfdEb/1ksQyyB3LNCB03nCZt7oRX/LgmY+F7+S
 3tQh8OLkr2B76AnvGEe7PCfRgMkK1OYfnb8GtTn8s9TOq2fNEpXckYMqXcD3ry9iPm8q
 kODjPKl11cj5m70YsbacXgy3DAVj9yVJNA/+0Gu/v1VWnXnSaOvOxLSdSql2rMUWw8gy
 deBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312741; x=1712917541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1gRnORP5tdE9/lL+Q019gMHhCwR/8xBUigSwS4zxh6g=;
 b=lanVVxnAufH/+/PrANhTBG4uaP25yRe6oZJtOXhFPbDkYQyFxMnpdnYz1+jV+OqUs8
 Yl7S/hoXsNVbnnOIeY3aUf9Hi6n+6vQ79R1iSUbasWbFqtVNXNPrO7cJSKlcWyEQ9kH+
 mR4Q9BlEMjR+vrE7Un8NYEYGzZAyXiCdpxm36WpXh4CZDkgpITRGho+mzCPLPEVB6Ad2
 gbQm9nmfZntrbui+krzwh4SdbuerVbk5F6P0GqO6mXNj2MVf7wfrT8tAvRNk96fiMbe7
 JPJibR9OfEqt8Abj7VAjNeQVLhagq27JbbscGK/Au0S0XJSvY99StTNmAHt03ULycNIy
 1Y9Q==
X-Gm-Message-State: AOJu0Yy6j0lXufq18DZoN1UVj3J8+mx4tKHo2VC8NZQGGHq/r/ygIacC
 67qdaOgzfFR4+usYTmvGV/ZqTfUV0nbGHwVKA6b3Jv+ySzkJtqxZ+99xym0B64a/bBF4c0fdZuW
 v
X-Google-Smtp-Source: AGHT+IGt5pSOFYGE9nTRme6Ys0H9UHLEmERpw0dpQw+I+aJVr/gC3fjwOCjDoytaAeg7sDvhwm0wTA==
X-Received: by 2002:a05:6359:5144:b0:183:f3d1:e0ef with SMTP id
 oc4-20020a056359514400b00183f3d1e0efmr1181690rwb.14.1712312740667; 
 Fri, 05 Apr 2024 03:25:40 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 30/32] target/rx: Use translator_ld*
Date: Fri,  5 Apr 2024 00:24:57 -1000
Message-Id: <20240405102459.462551-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/translate.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 92fb2b43ad..9b81cf20b3 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
@@ -75,10 +74,10 @@ static TCGv_i64 cpu_acc;
 
 /* decoder helper */
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
-                           int i, int n)
+                                  int i, int n)
 {
     while (++i <= n) {
-        uint8_t b = cpu_ldub_code(ctx->env, ctx->base.pc_next++);
+        uint8_t b = translator_ldub(ctx->env, &ctx->base, ctx->base.pc_next++);
         insn |= b << (32 - i * 8);
     }
     return insn;
@@ -90,22 +89,24 @@ static uint32_t li(DisasContext *ctx, int sz)
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
 
-    tcg_debug_assert(sz < 4);
     switch (sz) {
     case 1:
         ctx->base.pc_next += 1;
-        return cpu_ldsb_code(env, addr);
+        return (int8_t)translator_ldub(env, &ctx->base, addr);
     case 2:
         ctx->base.pc_next += 2;
-        return cpu_ldsw_code(env, addr);
+        return (int16_t)translator_lduw(env, &ctx->base, addr);
     case 3:
         ctx->base.pc_next += 3;
-        tmp = cpu_ldsb_code(env, addr + 2) << 16;
-        tmp |= cpu_lduw_code(env, addr) & 0xffff;
+        tmp = (int8_t)translator_ldub(env, &ctx->base, addr + 2);
+        tmp <<= 16;
+        tmp |= translator_lduw(env, &ctx->base, addr);
         return tmp;
     case 0:
         ctx->base.pc_next += 4;
-        return cpu_ldl_code(env, addr);
+        return translator_ldl(env, &ctx->base, addr);
+    default:
+        g_assert_not_reached();
     }
     return 0;
 }
@@ -190,22 +191,22 @@ static inline TCGv rx_index_addr(DisasContext *ctx, TCGv mem,
 {
     uint32_t dsp;
 
-    tcg_debug_assert(ld < 3);
     switch (ld) {
     case 0:
         return cpu_regs[reg];
     case 1:
-        dsp = cpu_ldub_code(ctx->env, ctx->base.pc_next) << size;
+        dsp = translator_ldub(ctx->env, &ctx->base, ctx->base.pc_next) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 1;
         return mem;
     case 2:
-        dsp = cpu_lduw_code(ctx->env, ctx->base.pc_next) << size;
+        dsp = translator_lduw(ctx->env, &ctx->base, ctx->base.pc_next) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 2;
         return mem;
+    default:
+        g_assert_not_reached();
     }
-    return NULL;
 }
 
 static inline MemOp mi_to_mop(unsigned mi)
-- 
2.34.1


