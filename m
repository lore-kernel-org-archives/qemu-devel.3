Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE665606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sGjAUiJl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKseM-0002XR-Dl; Sun, 25 Oct 2026 03:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd0-0008SL-OY
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscy-0004b6-TF
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso5472695e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913207; x=1793518007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KN8qZ+dS3yZL1ELqH4DH18iCI67HzoxiBdFKlV+N3N8=;
 b=sGjAUiJl1MXDppANa68EsHMCfr40rZEiuW6gYWeE6AxvPZekvsZQEWlUGUD7UH99Ap
 80pFTaOTS3JatxyOSx9LizhCC+C79riEf5oU6WMQh1FZFuKg0xa4WGD4M+Lbkjfg1gZF
 vrjQh1i9Wqhu/JHQ8tFGKTSnSO56uQ2VAL5herJqvjxVTg4OkXNUXaXGylnaNOsQ0P6l
 FrHcdETKyR4EfY3+LzuyJ5bLQ2/5oAiE8w+2Vtw+qPeNZ9MUQk4+Bmk7wCIelMlm1s8X
 4xSSpqhroMeUD0fg2oUAbxy6Gt9x4Gll49SsryNeis7Oznbw9kHFeD/JYIdgRrreNyeC
 uijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913207; x=1793518007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KN8qZ+dS3yZL1ELqH4DH18iCI67HzoxiBdFKlV+N3N8=;
 b=L9RDF/TGLWQNgEzckGWpC9jAWrYkyRug6GJhkkmKuKRgbuku1fHa3DFDY44aImH+g3
 z5FicR0nSwayBv/1mKG3pmoA5THEGrnwa3Z+K8jjzUVEjMlDceuEIqPiSiTQZiGLhe2N
 ISKN0q/Yn1lTd5EzzEmtaDthe6VzE+x0n/4qmxjJ2My7Sp0wnOl4lWLaLaueGSAIp2/x
 2X/fN8jpKIegiD0Ct49n+kRbNutFc3vqlu5crvEw/jIklnVMMHPx+R6B5kfkWxukTtI/
 a5rLcpihHdzV9z5ngiFb20kcp8xBxe/iasIOXVgko3w6WtCP1vD7orTCwwqFZumk1Ynp
 IXIg==
X-Gm-Message-State: AFq9FYJieNZqjTr03H/Z14HvgXkbidka+bz9D/t8BJmiAFZoq0repvMn
 bBWCy+ctZBtraBQ4SoXpOc9K7av2Zwmj4c/y5piNZsX3t5S9g8sN2WW7MceE/p1xiQqiLw7i37P
 /QQzbxf4=
X-Gm-Gg: AYBFou3dycGGj64dhtukC6MX5182bbllzuNk/j+NMfFFYi0bZnwXh3MHlRu4utNEuce
 G2rMrylkRLRJl9OlRCMEM6WmjAJUGImeHzNwyeajgtqJjkBRh21XxK8Z1svuXyHBYhHK9ofck6L
 s9NITgcw3UYY0+mu8XHoKJXASDOl4cV3BOBsdugFEaTW30VFryMMEKazxBva9DQLg/qD2aKWr42
 U9P3AwNMaVBb7lxmQCTUjN9QIObNKrOZdmFUFOurpPJVBTePuiNBrukntAgaNa9dHxnOnF4Kaix
 EvFW203brtb87YdZSwyub5SuBYcYQx+8oWaXW2zJZvPyIHVQBCt/om/vgsVyqCV3+4an5d5Lb5J
 w3qxZxN8b1lKYiPXmJSCJzKKrrGrOnRM76dkortjhsgMKcMzXfVZJADHrCuldFO95cZ/qEab7bI
 Xd8ZCWvvt2opEteg3BtyiVDTZUGQ8LLXDdPQAFnHGmbeGIpESKfUMGSguUOwbHo3DJVBpYJDsyE
 TEjvmNrnuGWLA7nAApnkM8in7aPzv69XQHsB3gG9laoWHNfmwk6bmpXR9c=
X-Received: by 2002:a05:600c:8587:b0:4a3:5d5d:48d9 with SMTP id
 5b1f17b1804b1-4a35d5d4a4fmr35909105e9.35.1792913207468; 
 Sun, 25 Oct 2026 00:26:47 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 087/100] tcg: Generic expansion of tcg_gen_ld_*
Date: Sun, 25 Oct 2026 08:19:02 +0100
Message-ID: <20261025071915.1123867-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  7 +------
 tcg/tcg-internal.h           |  6 ++++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 24 ++++++++++++++----------
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3a577beef4..697de0e1f0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -144,7 +144,6 @@ void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
@@ -176,7 +175,6 @@ void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
@@ -374,10 +372,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
-static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
-{
-    glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
-}
+QEMU_ARG_NONNULL void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 
 static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
 {
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d6ea11d8fc..bfd34905ee 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -191,13 +191,15 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
-#define TCGV  TCGTemp *
-#define TINT  int64_t
+#define TCGV      TCGTemp *
+#define TINT      int64_t
+#define TCGv_ptr  TCGTemp *
 
 #include "tcg/tcg-op-def.h.inc"
 
 #undef TINT
 #undef TCGV
+#undef TCGv_ptr
 
 #undef DEF1
 #undef DEF2
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ab1bf25929..6284358a13 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -31,6 +31,7 @@ DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
+DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 15a7d49baf..4f33caa735 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -240,11 +240,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
+#define C_TCGv_ptr      tcgv_ptr_temp
 #define C_int32_t
 #define C_int64_t
 #define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_tcg_target_long
 #define C_unsigned
 
 #define TCGV  glue(TCGv,TExt)
@@ -271,11 +273,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef C_TCGv_i32
 #undef C_TCGv_i64
+#undef C_TCGv_ptr
 #undef C_int32_t
 #undef C_int64_t
 #undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_tcg_target_long
 #undef C_unsigned
 
 #undef DEF1
@@ -766,6 +770,11 @@ void tcg_gen_extract2(TCGType type, TCGTemp *dst, TCGTemp *lo, TCGTemp *hi,
     }
 }
 
+void tcg_gen_ld(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_ld, type, dst, base, ofs);
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1390,11 +1399,6 @@ void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld16s, ret, arg2, offset);
 }
 
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
@@ -1443,11 +1447,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset);
-}
-
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
@@ -1865,6 +1864,11 @@ void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
     tcg_gen_movi(TCG_TYPE_PTR, tcgv_ptr_temp(d), s);
 }
 
+void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    tcg_gen_ld(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), o);
+}
+
 void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
 {
     tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_i64_temp(a));
-- 
2.53.0


