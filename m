Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E32606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w4/GJcBC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWD-0006Fm-Gp; Sun, 25 Oct 2026 03:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVz-0006BO-MH
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVx-0003gS-Jd
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so15506145e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912772; x=1793517572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a1TUo9qtmEVQqwZjc8n3v6YOomQxSzlPZ5ww+oFejZ0=;
 b=w4/GJcBC5iKOw3Wb48mIv/zdX3yR6mZo+mKqWo7UhF77Hi3Fo5zJuYCWAdrJHGnLCB
 6UdxCVH3j+T1rIOufT0lntd5uqas0H4TbrOodwPjXylTEwnkmabkaS3fg0RWuEdMewzK
 drgqUdHrlwhtn6jgSIjWz+EV9Cfr3LcOql4U0WQjc1xFWqrgzXRBRyIHUIEHGMaLqlT7
 ckqreO0nNwYnBdf934FOkN6B6erAq2W4Q21h9NhWWEfzIFwxMlKlCdEQoytUfYcfg7Gl
 sD9NbWyWUB5IEB8ueY+PgYDEZCnIbRLfCahKAW+nFk8gETrkWIn3ARXHZWrhjqv6sqkO
 dQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912772; x=1793517572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a1TUo9qtmEVQqwZjc8n3v6YOomQxSzlPZ5ww+oFejZ0=;
 b=BALW47KulKDj3Pg4UjujNAo4bpLgcp6Qy5osP19iNH3dBYmSZgdvRNCr2V0u4a1qE6
 LjQnpMNdjnAUrZWMQp0Fvm4/F/8+Km90nEUbDnpnZm5NpjtpYzCRU6QBEBBxokz4Zcy6
 zGAe0APTqsIerVPjACB6L7/sI0bxpOUTdXWDO/g7p2SzAnxVOlhACVwVJZpk8gFh9dN5
 6Gh7xRK59F7+A9HHvcqmDAW+EDtrLLvM4SwuRBW0+KD9avkPBTwR31DPDi/mNiPNw3nA
 kuL6oQ1NhEjBqA26NlQwX6f5V/mDoPuScvKFQRHOGBXWq44+5KLHMPMe3XK2vuN8jC7V
 x9BQ==
X-Gm-Message-State: AFq9FYIf5KQ9//ywQWzWXzsPJBuBwGBcmIJRHRznrQ4P7yVfndsmznr5
 MhmEb9O7u7BvolNRqwg5fBnjMOQwlvB0ah3/fsU+CrMfm2gqPVbPGy+X0aVB6IVEMom4A6/83MF
 a3wfZN40=
X-Gm-Gg: AYBFou1mrPzCqb/qcWaWLqJYb8phlhugfNV7z8zZu61UlKRKPoHpADxX0aHDgAib3vd
 7d0vAST01D4/V4lS/iTdEQINZi5sNURGqCtYM/o1rGR4aa76z9MUZsYyC//hKj0oIGxtt2KlwTs
 2OuPfZy2MFwjJI0kyvfHIWu4F9lNQurPAXj+wr1heuw5zLDSOCgaDzor1mTjSfYCJHkUvMK9pA1
 InYHmcK9s2ASFpsI9UbfdTBP6rlGxgUdvpVDinPG00bS9WhqQak7kH6HLbnWt5sJsyZYGnoOw4s
 gB3CMvZRfJZ4lbK+Sy9ISxG6/OfHg2kuT+7sssQUgL//9ignQUBCoLPmkVJgEHsQOEIQTuxj4lA
 1aXt5DdErhx8n3OHl78e6E5TbP6KTrSW/dzvCmuVerJTDL0yvLbprfyOEulHcHVqD8qjX8YcEpI
 DXWYVuKt5bLjxjYpH9xUaF8CK5ogmUakTWWGeV11KeiNgpBLiOgF74t3/5I8DNdVHaRCIHxibV7
 HfGMDMVah5mykV7SYmpzA0W4QIKWxX/ylzaScVxJsP4iUdC/pWuz6DATA==
X-Received: by 2002:a05:600c:3e14:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a35ae8806amr62979375e9.8.1792912772101; 
 Sun, 25 Oct 2026 00:19:32 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 010/100] tcg: Generic expansion of tcg_gen_add_*
Date: Sun, 25 Oct 2026 08:17:45 +0100
Message-ID: <20261025071915.1123867-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  | 11 ++++-------
 tcg/tcg-internal.h           |  9 +++++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 26 ++++++++++++++++----------
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6168af878a..879cc85bc9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -96,6 +96,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3);
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -117,6 +119,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /* 32 bit ops */
 
@@ -210,7 +213,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +317,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -542,11 +543,7 @@ static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
 }
 
 QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
-
-static inline void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
-{
-    glue(tcg_gen_add_,PTR)((NAT)r, (NAT)a, (NAT)b);
-}
+QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
 
 static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
 {
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index ed1f5f20f8..0da1a9c440 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -108,6 +108,12 @@ static inline void tcg_gen_op_tt(TCGOpcode opc, TCGType type,
     tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
 }
 
+static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
+                                  TCGTemp *t0, TCGTemp *t1, TCGTemp *t2)
+{
+    tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
@@ -128,6 +134,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1);
 #define DEF2(NAME, T1, T2) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2);
+#define DEF3(NAME, T1, T2, T3) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -139,5 +147,6 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8c61a75cd0..73b1ec3d05 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
+DEF3(add, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ffddb3c19d..83ecbaae8b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -317,6 +317,10 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b)                     \
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
 
+#define DEF3(NAME, T1, T2, T3)                                          \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c)               \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
@@ -351,6 +355,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 #undef DEF1
 #undef DEF2
+#undef DEF3
 
 /*
  * Generic expansions for templated operations.
@@ -358,6 +363,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -377,11 +387,6 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* some cases can be optimized here */
@@ -1489,11 +1494,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
-}
-
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
@@ -2759,6 +2759,12 @@ void tcg_gen_lookup_and_goto_ptr(void)
 
 /* Host pointer operations */
 
+void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
+{
+    tcg_gen_add(TCG_TYPE_PTR, tcgv_ptr_temp(r),
+                tcgv_ptr_temp(a), tcgv_ptr_temp(b));
+}
+
 void tcg_gen_discard_ptr(TCGv_ptr s)
 {
     tcg_gen_discard(TCG_TYPE_PTR, tcgv_ptr_temp(s));
-- 
2.53.0


