Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF00606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DNAIrSBt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAP-0006xd-3C; Wed, 21 Oct 2026 10:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9s-0005EC-SK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9p-0001h3-A7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so5745475e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592347; x=1793197147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYOOEWRqgzUZ6psMDflWvao+lbexWrZ1QLXLi3Y3B5Q=;
 b=DNAIrSBtULtX6zPywTZp0BVYyKGlaSXHItMKuHSIpHy0syntLIHSM0+W+cwySGykmB
 uGARqY7Bz21AVY1DuijeGgvoDRnGlV9RqWQs+wD4inZwML6Amlo1wP60KPLD9UUifWeC
 yzFQee6kiPxNylTqSBMwpemz0I1Vz/9wgwonxVm5K7gYa55ctQaoIvGMVQNk2asPa3ie
 gjVIEBeSqhVXtP6w8v/SedX2awvDwtXTxxD4h6W+aBcpT4GPe6Iy7dobwO+izCS3Rw56
 2IAnsHHMuB95MIz1UPRMVofZpd8rfeNQ8V7J2gsjqepfcBlvSOBCXz3QYeTop9XAJLh8
 /h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592347; x=1793197147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HYOOEWRqgzUZ6psMDflWvao+lbexWrZ1QLXLi3Y3B5Q=;
 b=D/2JumbIhd79fRDXyyw0IbLgPUmvSGwbkEnVj4U3GP5vl5KyKu7E5E6J1y9ujF5F21
 nBVn09LSbbFxWPFfkVQXdxFg9IzW4KxnkfujRu6GVJfSAWwJV7L9v6Nak04PGyQBurtT
 MmiYU4bL+Tt65lV60t6cbffMjpT/yZH2AUzZhhTrUnF+yjA+WD4BUDK5LeOHMQpxH/VI
 a4al/xTmK4e8ZZkW2/lKsHlBu5mU2lxdW42Ow1r8UQVDqWrW1uYkB37jyAcvIF+LBxd2
 qvo2cFJATg4rT0hmSyHq3pO2EJbw1WjRv5xU6R04/NmCkyIaa7PcGoxLNmkF7238rzu9
 CVkg==
X-Gm-Message-State: AFq9FYKBG7I8yT0epusc/cBst1a5OdxmZLwtJ1/5ffh3mKij6KeBQJss
 89i991uA7BwuK9/vwO8qdBoKwOZXOKfqbpJK8Z/XTvC3aZ01kRo8UiY2h6z10C5PfVbWLZ1bZ/Z
 ZZo7TMS4=
X-Gm-Gg: AYBFou0XrFBnD2RU8W3MWZSb5WSkFr4h8NZjmArNrtVuRjMav8v70+ZPwG6VysnELUm
 z7fRGX8PHQnBuQ+jeYJJCIFm5i1yzOXJR3MbXTndEF5PbBtxLeygswb1LIfNL7i5KyvyjCOlvOy
 om+z+zcRSTRbt/fkm3RsP7fv+/Lfgj/EUI4qyvbk26Lsa2moWeDWjrmbqLdRprBQPynL2UHCTGt
 peCmc6R7Unrt3P0qcog1N0xj/JHKS3V0V1VWQFJ3/teTVha126ekNyIH0Qs7ENkCICczZNb+mTA
 95SFYq2RN+SW0ldeuqr3ql1VEWJEDOojRsUc7VyV3pqXxEpTrpZuuI6uZJ482weMtXwbmxpO8m/
 ZXlEVvjb6gbcWGi4j1miGqbcmc0WPqonDkFD0419sZE+39WpW5U9AtDTeC32JtzuXLbQPKK1hLt
 +Y3jUFZKhvFty6g6eMxLP8ZAKNDQxlUbbr686pBUUklWoEXfpGC9mM1xMMbBOCcCS4B4V3Ar/q3
 CnUysalTwFuM62a6/bOqYvzY1Jex8xIgnOrMY4ioqkEBAc+iU0DnxYzHspuOP1PU4HW1LSxlHMd
 VIW5AQC77hPGxszMBIfVrUzTdK8h
X-Received: by 2002:a05:600c:b90:b0:4a1:d307:b526 with SMTP id
 5b1f17b1804b1-4a1fd72a9ffmr46651305e9.0.1792592347507; 
 Wed, 21 Oct 2026 07:19:07 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 032/100] tcg: Generic expansion of tcg_gen_div_*
Date: Wed, 21 Oct 2026 16:15:44 +0200
Message-ID: <20261021141652.363109-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 tcg/tcg-internal.h           |  8 +++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 42 ++++++++++++------------------------
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index df6563af9b..b0c5a1f5cf 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -205,7 +204,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 76c8f026a6..6b65228241 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -120,6 +120,14 @@ static inline TCGOp *tcg_gen_op_ttii(TCGOpcode opc, TCGType type, TCGTemp *t0,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
+                                    TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                                    TCGTemp *t3, TCGTemp *t4)
+{
+    tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                temp_arg(t3), temp_arg(t4));
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8c9d3d99c4..778854286c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
+DEF3(div, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 09e417b760..8854006022 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,20 @@ void tcg_gen_discard(TCGType type, TCGTemp *src)
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
 }
 
+void tcg_gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_divs, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_sari(type, tmp, src1, tcg_type_bits(type) - 1);
+        tcg_gen_op_ttttt(INDEX_op_divs2, type, dst, tmp, src1, tmp, src2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -609,20 +623,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
@@ -1537,20 +1537,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-- 
2.53.0


