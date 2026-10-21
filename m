Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB0606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U80oMZFi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8H-00038O-3U; Wed, 21 Oct 2026 10:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX88-00035r-2m
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX86-0001Vl-52
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so6088855e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592240; x=1793197040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F8Uoc8BG54HZ9ylLpbaQAyxtzPuJAch/tsab8I1NM4Q=;
 b=U80oMZFiTO73S0JEDA4pv2Tm1W0fPGitdRmJdb4YP5K5Sn/Lc20lCgS3ZZDrYs54Rr
 0J2BbtwCE1OG/I7rNr3Z0UPlG4/Q7NVOl7cl2YHnuqUc/2CykcGYgWXPBZR169bnkct7
 rV5KV1e2C71qsq9O2JAQehb7PVPrBrGJX0nUoQy5S7kG71DreTt7pzL+tm3QWleUfWJg
 bbNqhkayE/hw78PIKYwDVH1S/OebQyevf7bzO3+ZCtAx/1qZqbbKPoG5vYDaGdXynHIa
 +skGc99mWsMtmRgHJ1PMRNlzUAtyDopPpfe8RrRPrpDqXFhUhj9N1Y53WvxZLe+PUECi
 0HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592240; x=1793197040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F8Uoc8BG54HZ9ylLpbaQAyxtzPuJAch/tsab8I1NM4Q=;
 b=A1gP0WTrWHGsJAj/tOcHOR9nqXb1rBTJPiEBtWg9Th7Cs3TEBY3FfVtvumLDUXtrvZ
 Z6YRfYxYB8IOPfIy9NtF3+RBblQn1Y905Dr1xgnbRANNzS5IxNgqtPdhmfageFPdA0yY
 qVVosZbyHsIND9oQm+QCzSK3eEC534Xx19w5vOW6Y0XV1W5I+95n82P/28ATkai6/WBF
 uftBL+jPMx+kn4INBcq0DZnt7fHQCWF/H4t99bu7p3/V3su+EjZTlvqivGYmlOAzs952
 elo+g04AMkpjCAfUlbLt89U/SVCjaKPDJ2ZeocfDnVQor5xOaY4XbX2BKPk6nvkzvb/L
 3rFA==
X-Gm-Message-State: AFq9FYJ8s2SA/weIYgoeOJcqdGS67J+VY0bGlWptLZ1YlYe/RhtX+cS2
 YR5NcNr0H3t5Cw+c1jMmCAq3nmwI8gGOsH87Wwsa9+EwqfhAsmPVWgRJ/fnTrupXLRhR3QLKdv2
 pI/L05kY=
X-Gm-Gg: AYBFou3Pypm6/AuZrQVvMyO0mhB5eKKPOCx3cw0GBFAD62UKQ+moV/iOtUDa7KEF08I
 r/+BgEDp1cZ/qanva+SZ/zU+TYYFKFCw/LBKz8E6Tn+2cZWdjJNSNIyN+aiyffefnZ2amOPzgH+
 zxVrl97jWP5LO9lcc4sBfcQ8znsn8ZzUJOvFt6nb3hcIruKb+K6wDP/UDeUxkeqz2gCe2ZQyWC8
 N5EJDjGmO6Rj186bJrI/tTmpR1X8X3t/Qk/EB39b4A5tvsnXvxoEKncMdhYC5XJlqNFc8O8ZY1r
 r20do+tYn6c0J1SLr2axcbCZIxG1A+zkZxbOqHf6Q9UIz6Eeq8UmCei9f1RugRdyTRrUgTApxtQ
 IxL8FgOfDKoJanS/ASwMyamtytcNUwkqZJCqbYF15RXXLmpcTUCX0H4fEk0PA4+p5xPt/IrHw2G
 0GOl/TirR/h8b+n1GLiLV6ONFvZFRy01dntEI/r/vqzOfsYbKg7iVH8yvslnC2xqNxsUjNIrk+P
 pbagyaiOcP3dVcVOtXtNCSRZqslezNL6BTqzuLj+cbe4X4aFKj42VOpIf4QFQzO+Wu0M4bEUHyv
 58UUAlCNCeVT1pvzZj8Gl9TZd/YY2Nu+qOrNQeSCr3dT2VLX
X-Received: by 2002:a05:600c:8a0c:20b0:4a2:1a:a11f with SMTP id
 5b1f17b1804b1-4a2001aa37cmr27168875e9.7.1792592240450; 
 Wed, 21 Oct 2026 07:17:20 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 010/100] tcg: Generic expansion of tcg_gen_add_*
Date: Wed, 21 Oct 2026 16:15:22 +0200
Message-ID: <20261021141652.363109-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


