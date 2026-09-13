Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7136C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a87-0001BM-R4; Sat, 12 Sep 2026 22:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7e-0008SH-5p
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:15 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7a-000134-9f
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:13 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so755230a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267148; x=1789871948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Fiv8LIsEDD7zH42ivHIskY/SCOol07tiL2KK7VCAhhw=;
 b=ODsudtBJ1Y1O+O3hVwRbVQlxHSYnRjDC70RaqxpOEfzxEoEOxGCYk4AbWJbCKxGSc4
 TUu656WHCNPDne7J2fxV3snGSt7tf8RDXGyL5P028BkTEGRqYZN9oyYSxfwpkeegV5Ek
 q1hrN2Tj7RR0TO04rGUj2a1UB5QI8tvzY7iSHoVm9pjrwOTzcj1FhmONTNVKBIE2gjrZ
 tuRg4rdUmuFm7ONanjBNHjRmgh80RAYDhe5YUEiWg5EIeSy0WCfuHeTAy33IoJUJUpHB
 O2K+q8br+HSfmxLDt02a2ymUsdBHjMqjU5/h6yHQ1YiOJL465sAPD/ztIjNhT98tiIy9
 RTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267148; x=1789871948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Fiv8LIsEDD7zH42ivHIskY/SCOol07tiL2KK7VCAhhw=;
 b=VP6xh7EcMQiiG3SInnzHp2TE3bYYOz9E7++mbhnnquOYDPm7mEPxXRJUryxjAqJrDk
 CF8Oz/rRJ38XtxLuGtxOJTxhabzvuK8FX7Y6yVXra9zCf4Iiya5TltjPAsTWEwa523Ei
 0CdkCynuI4EUY7WAN74B++SGQxS75ZFUeRANKQ/phHIB5X6Al12EIelZNPvcZv41nWHe
 WynnOpXX7L5sT/zF2/uvTTa9sicxu/OB66kHJde0RV5xx7qLqJnaMs56qCD9kmRNsA2T
 j853FlDVxfr5gZfL2JtVZswJbX8Ho/b3nSKbz3qwjwRrOPp1qiiQxp6cgoNuGqoWeQhk
 fINg==
X-Gm-Message-State: AFuF++kNbxNXnNxTYUEBNsF+GyGJoGi/Ptux1eqUcOifK1S1U2JR02RG
 MOhH9cmUICZaedcH7SCSYh+sfm4jHZtXRdK3wLSRgpU+4JvhRp8vYojAfWfZsmxhdTzQqcBIld4
 NeVEYTUE=
X-Gm-Gg: AYBFou2gP6hVARj1lSUoYgfl6jXx/z3LXT38gaptMPb1B3XPmC9ozG4PKdmNZpjhFRc
 gFc5lGdxI/+TMFWoWYLo0/d0RuHOHHeDkFGGgnCcUZ+XNgCJtz8y3iVVaI3ZRGCQapXPkJwt3RW
 q7zoFEdIrynQyxwRnr6FWA/YNfGfyO0gM7JLLcZaBmpcf3WioVM2YFMe5QwbaQnUvD2q5sYSSwU
 /IxulNMeDQ28/ix6bAopGqjUAkLH7FAxlvEkzJv3v+9yFrNOGjCXfaipS6RTOFOEuDDb3msfYiY
 rMUwRKXcOqEzPkpGdi4XHrKsN19fP+zJLZbnexyfo/euS4ElybSJaTVrSFWdfSbkxDC+H88+PHp
 /2wHKDgABETsSq0JKrc+rQKHhvbCe3cKjckzTGyMCWb24UYnVDrapPixwhL6Lnda5qCqbce7OtV
 xKInQB5/trYsgHysEfKS0edOXZZa2bcGpj7h5Q+zzMxZJ4dfpyeaN5dpjX7xRPVhrb7Hxe3obng
 aZ8HKcL
X-Received: by 2002:a17:90b:586f:b0:398:9be6:f999 with SMTP id
 98e67ed59e1d1-39d9c386bacmr20610772a91.24.1789267148015; 
 Sat, 12 Sep 2026 19:39:08 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/86] tcg: Generic expansion of tcg_gen_muli_*
Date: Sat, 12 Sep 2026 16:37:36 -1000
Message-ID: <20260913023837.741866-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 33 +++++++++++----------------------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 80e6f77c379..fe3519305ef 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -208,7 +207,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b620a314480..8e97c1b37d8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
+DEF3(muli, TCGV, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0e6c21e9077..352b73148ea 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -468,6 +468,17 @@ static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
 }
 
+static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_movi(type, dst, 0);
+    } else if (is_power_of_2(src2)) {
+        gen_shli(type, dst, src1, ctz64(src2));
+    } else {
+        gen_mul(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -637,17 +648,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i32(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
-    } else {
-        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
@@ -1576,17 +1576,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 0) {
-        tcg_gen_movi_i64(ret, 0);
-    } else if (is_power_of_2(arg2)) {
-        tcg_gen_shli_i64(ret, arg1, ctz64(arg2));
-    } else {
-        tcg_gen_mul_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-- 
2.53.0


