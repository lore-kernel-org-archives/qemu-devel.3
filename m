Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972A8C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKg-0002wE-B9; Wed, 16 Sep 2026 09:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK2-0001o0-UW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:12 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK0-0000X2-S0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:10 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-85d440939f0so7013597b3.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563907; x=1790168707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bcbj7XDvDJiqQ6c+Gh57SWm8p8v/ikVlu2ooEFzrzEw=;
 b=QRVwm0p74Z38AKVw42mJgcMaCWNz66bQMI2IGQGrEfVaINANdVpK4gp9TlQYmpR+e/
 lnonUWY8lMWubyXhkURX0Il+Nvq41aTQT/QfiqxaGGzxyASMK5JJIjGpJatp7wI8hNsf
 GgE1Mn67SGw8QKQXE/oIdH3bmz6tavUEiuWlcboMLFAZxHqGUzINJZVINIBg0Wa53Fl/
 oPJDiBADE+WZ8YV0qnMG/c1u8ywo3MdNd3vrk+dbHF/9clmxZv3B0Xi4opUVPQmLMf6r
 aApyTtxdcz74eqhzEU1poRJVsnjmjKcEvv+6TylHhi2i11SkpYozvIFzOoKd1JWHUPVL
 XX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563907; x=1790168707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bcbj7XDvDJiqQ6c+Gh57SWm8p8v/ikVlu2ooEFzrzEw=;
 b=bgXjBxiKPa1SBNScZ40W/Po5Hdh0Jgw7ftirkaP9nsJZV9qmiMufrPfwVbi4yYFBvJ
 reApCEvZJ8mK030uMPoXJiGzS3HyPMykas8EBW9EyuCkfsLD5B/UlyHlODGMFHjfyIX9
 8DsNP7NnEj7iW1nKX1QOH1a2tVb3+bqt+qiDx5x1eLwfhXEOXsCsuPQ0+8qrzjCsnfyq
 0ivkypRCxybvFtQIEzi0lKuqv+1ASEh7rrcI4svVOJJloSpDAKgXHJ0DMDoebuZbmILa
 OSMirSlhrHu0q7M/BmJjUxfdavrBvGh582+WYANXO0m6rcdYk5z7aPmxyBXEPaa/SA0f
 ymPQ==
X-Gm-Message-State: AFuF++n+tNO/TzLeEVuX6GcjrpEpRVwXAVrRIHLMxS1fF0KphNuMBqrS
 6dtsPPyxO053JBlgvRblKpIaNUo2K2G0YhBlWpaSXVbQUjRjiDusPI0iNr0rYcsrlXyNeDRkcXa
 w7rCAmUA=
X-Gm-Gg: AYBFou0J789N1x3puHn1pUVc7jbNdtA/KH79+TMA/mk4PSZTAIbvRm4mBIhof6HbwP/
 QaheaSOCrPOd/zj/BaJ9MgEtjiyS5N01A6obccz8ObWMHPhLwSmQ8OcCus02SEQs5sZqMNdX7lq
 3KLLuif0L77xgkpQXfry05cEX9KL+SMECTsMD23G36pdRdBFr9gLBHAS+/uQr1Eoqo2sJ5kG6gh
 Nl5KD5audX83H4Jrv/VjHFU6Q0NN+6TpK9OHmoZDZ1EIC28fsuTikX6UnsaX7HkCon00EmT/yTC
 CS95yHN6Q3p2wxpw/jTq3IyNaRagS4b5Pk+NC9xG7QfidKeBtdMHsep2raHiVkh9T1/msrtm7sx
 hrVmw0HQKcLyBwqHv/megwu2xLqP1E+cwHQB3GSJnlns4/sYE9+y8QWnc8dSRmy9t+ht6EKL4IR
 raatdE3gojh61+InYFVNiQeyugtjJV7iBXXUhAEgUn90+WLOOhEeH35xjtyUBbPMpjOL96lBRA/
 1DXY+0=
X-Received: by 2002:a05:690c:288:b0:88f:571:f746 with SMTP id
 00721157ae682-892267e8927mr7156797b3.65.1789563907449; 
 Wed, 16 Sep 2026 06:05:07 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 35/92] tcg: Generic expansion of tcg_gen_andc_*
Date: Wed, 16 Sep 2026 03:03:10 -1000
Message-ID: <20260916130409.3382710-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx2-x0f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 37 +++++++++++++-----------------------
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f0572df01cf..7517e8d9d9e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -201,7 +200,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cffbb4d08a8..b05a1782513 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@ DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
+DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 94cdf7a3c75..12837fc394b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -440,6 +440,19 @@ static void gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_andc, type, 0)) {
+        gen_op_ttt(INDEX_op_andc, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_not(type, tmp, src2);
+        gen_and(type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -717,18 +730,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_andc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_and_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
@@ -1776,18 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_andc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_and_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-- 
2.53.0


