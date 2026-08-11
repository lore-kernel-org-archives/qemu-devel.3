Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B095C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXB-0005Ng-DP; Tue, 11 Aug 2026 00:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX7-0005JK-Vo
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:14 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX6-0002lp-5R
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:13 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso2360185a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424171; x=1787028971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/XYnAyPP0quszx820lwYmi+QJGN/BwMqpyB8ehS5Z8w=;
 b=hZYY40aLETOkzlRpeXW4glW8ok9GW5hIu402kfBXpvawXP2EEat45wWkYWZlSlRNoG
 vo92Alx+wpfS/jUzj/5GIk1g0qL8VGyX+5RxNYRpQqQlN6MtVa17msVvVctGtgWU51Ku
 Fp7uZe+dge8XCWLAPnvaMgOxt0qyzGr4pc8/AoiJ+KGwjQR5jysN8EUBcElLWNkkLcM6
 YUlwWh5/XUztPwgFzpRCvPDItnPEunXyhUgcwOW223PzhaHJkqUG7A/HEuYUjbxdW6O4
 yApyulZaH3GgOD4oYuyYgpNWoIlMEi4kZvN99lzpuG7hscLGrvoItoACDLtfAgIZqCoC
 4XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424171; x=1787028971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/XYnAyPP0quszx820lwYmi+QJGN/BwMqpyB8ehS5Z8w=;
 b=n32TgD0iyf+ewQWRoHLrAh19+79QJv4pIII4zC3bUXOi3GmTZI40Ff6YoSrkTfE6VS
 7Q27Sb8QP45k2lMjnmE8JWCMYmVqQUH9zy05SWzWxJ9T/NZRjM94B+LzPOgQBz+E9GWh
 vtO5aM6J/RU0VTMIFITCtvsGSOL/TvbL7smyBZOSyXXWzOQk8ExdZj4ZDFsVbnbYc0oJ
 v3Vxw/H74wC8M5GOwnwULre+xdNaor+lx6J6tSDc/FTL/novMZuPt9m9SL+n1wHYtLPU
 ei1eBwj+G7Ui6MXpDLiLfb5JKA40i22W/N2IsT/iOTOusuK0p3VspgazE0vx8Z7rQO2T
 OK+A==
X-Gm-Message-State: AOJu0YwNIC/TLgTtHIJaTnUEikYbvREvOpUvjLGnRk0jC6tCHkt/7AZJ
 blZTgz2y4Rw2U5bJgXuCEsmLfTl58X0KalqFu7ByUiViIcSql6sgU3+mc2DeQr4LjHqNsp4JBMD
 MbwjK
X-Gm-Gg: AR+sD11b3n4Wx75oj9xUy24xis9YI00MOgijndy9ExfHmjYFyi8OxWR2gLhosSonKmI
 yU9n4yneG7J/U2LK5dCWnBGNOg1yDaf65oANPMvkrkCnoLXSuF/N+Rz9AiGxxZlTYUgYbSbGvll
 QuLd5nADfWZTjumxxRH6rWIDMsdilytEdsy479Q7MCtvopGb5JX0LJTRt/AWRfzJfbW3Wuf4wWU
 mOx4XDobvf8b9HFEz/kiJ0f8JzApC38SXcz8kufNrEVBPM+HAFr69I4JwaSO9wz6TjaPociB7Et
 jDF8ywuZjFexOPwuNfXGrugHR8Qwh6vnl9YATNTciFhXEVvIFcu4UMpxhMON2FA1Z5Fl5c6X9jP
 xIHaEb+zR1egyjqXcnHQ1xMWRHe9WqVgc4HNx8eujok4Mckzm6F3ntxXOrY+X/bE0ZavEemtZGM
 +nJmur8nwiNgngMqV39ClnCCwzo6XJIeu7x4FwiolVAZB7jUt9a9hzSSUG6QV8axkqYm5zn1SLl
 /kXuEJ/QvYcJ/TDvSlI
X-Received: by 2002:a17:90a:e184:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-392ec2f720bmr782116a91.1.1786424170575; 
 Mon, 10 Aug 2026 21:56:10 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/16] target/arm: Use generic tcg_gen_revbit*
Date: Mon, 10 Aug 2026 21:55:53 -0700
Message-ID: <20260811045605.1246543-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 1 -
 target/arm/tcg/helper-defs.h     | 1 -
 target/arm/tcg/helper-a64.c      | 5 -----
 target/arm/tcg/op_helper.c       | 5 -----
 target/arm/tcg/translate-a64.c   | 4 ++--
 target/arm/tcg/translate.c       | 2 +-
 6 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 0e56e00f45..12f58c6a44 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -18,7 +18,6 @@
  */
 DEF_HELPER_FLAGS_2(udiv64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sdiv64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(msr_i_spsel, void, env, i32)
 DEF_HELPER_2(msr_i_daifset, void, env, i32)
 DEF_HELPER_2(msr_i_daifclear, void, env, i32)
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 0077aeb4e2..42376af2c6 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -10,7 +10,6 @@ DEF_HELPER_3(add_usaturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_usaturate, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_RWG, s32, env, s32, s32)
 DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_1(rbit, TCG_CALL_NO_RWG_SE, i32, i32)
 
 #define PAS_OP(pfx)  \
     DEF_HELPER_3(pfx ## add8, i32, i32, i32, ptr) \
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 05ab9ab6d3..9d805231a0 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -69,11 +69,6 @@ int64_t HELPER(sdiv64)(int64_t num, int64_t den)
     return num / den;
 }
 
-uint64_t HELPER(rbit64)(uint64_t x)
-{
-    return revbit64(x);
-}
-
 void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
 {
     update_spsel(env, imm);
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c4433be2ed..857e897a48 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -172,11 +172,6 @@ uint32_t HELPER(udiv)(CPUARMState *env, uint32_t num, uint32_t den)
     return num / den;
 }
 
-uint32_t HELPER(rbit)(uint32_t x)
-{
-    return revbit32(x);
-}
-
 uint32_t HELPER(add_setq)(CPUARMState *env, uint32_t a, uint32_t b)
 {
     uint32_t res = a + b;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1780490065..4f9a93950b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8963,7 +8963,7 @@ static void gen_wrap2_i32(TCGv_i64 d, TCGv_i64 n, NeonGenOneOpFn fn)
 
 static void gen_rbit32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    gen_wrap2_i32(tcg_rd, tcg_rn, gen_helper_rbit);
+    tcg_gen_revbit32_i64(tcg_rd, tcg_rn, TCG_BSWAP_OZ);
 }
 
 static void gen_rev16_xx(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 mask)
@@ -8998,7 +8998,7 @@ static void gen_rev32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
     tcg_gen_rotri_i64(tcg_rd, tcg_rd, 32);
 }
 
-TRANS(RBIT, gen_rr, a->rd, a->rn, a->sf ? gen_helper_rbit64 : gen_rbit32)
+TRANS(RBIT, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_revbit64_i64 : gen_rbit32)
 TRANS(REV16, gen_rr, a->rd, a->rn, a->sf ? gen_rev16_64 : gen_rev16_32)
 TRANS(REV32, gen_rr, a->rd, a->rn, a->sf ? gen_rev32 : gen_rev_32)
 TRANS(REV64, gen_rr, a->rd, a->rn, tcg_gen_bswap64_i64)
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 055f3c5b40..1770428d3c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4835,7 +4835,7 @@ static bool trans_RBIT(DisasContext *s, arg_rr *a)
     if (!ENABLE_ARCH_6T2) {
         return false;
     }
-    return op_rr(s, a, gen_helper_rbit);
+    return op_rr(s, a, tcg_gen_revbit32_i32);
 }
 
 /*
-- 
2.43.0


