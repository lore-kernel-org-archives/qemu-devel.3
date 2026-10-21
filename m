Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16943606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PWVPmdmJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXI7-0007dG-Cu; Wed, 21 Oct 2026 10:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGj-0006ci-LT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGh-0002ZA-4N
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so5322635e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592773; x=1793197573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o/TKoctSg28XLrCj+toi2ceQi0fuBAXew0AgX0srAY4=;
 b=PWVPmdmJ1rITNoHWtGS/Lf9Luij1tUYIQG5FW7z4xsxYcyBSJq94+tJ1nuWJ7BbsnP
 oQFIoqLVHl9M5pmgSDi/w2/t8bpPq05mLa3vmdiD6i9KlgCIZMZrzbimecxfWPRGzJ1Q
 SJCYhSyDivVkpoyybDspjcCozplIuIdDfSC1bI4rOykv9cWDP6UkFuBYxuz2kAOFSV03
 4zzh7abdTt70EXCGva8hzTaK/DH54R9uI+MajMFA/SvNmN8oKjSyFRBzbd6HYkdzsbFW
 DLMmhWObKoEkJuZIttwEwWemc35rNXFxIzIuBZ7sSjbkRRPISBBr+epMoJcChgLmLupd
 hr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592773; x=1793197573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o/TKoctSg28XLrCj+toi2ceQi0fuBAXew0AgX0srAY4=;
 b=SqlLpgj6HW2viaEG2PAt3znE6vea5QkWuvNLKeglR72lPkN238vSBO/qN5OGPE5Os7
 5AQvOgpKvIBK2FGA/9JZyJrGUBVihPLfstTc6aIhp6mpLzIZnnXdMJ3qTIyMceUlVgxy
 PiFfvE3RAGJKpQNKnwWLqPhXrUaDBz50Jaqj7JddoY72We6iVQhgnWQlGax1PU87rrzp
 QUJ9dRnOCMZuahgWIEu8cmH3VOUsJ47eGZb8qXzQY9UORpu1rv20xlBu465Hb9E0fhPB
 yz/ew9QFxUYyQlUz1tj4FZuk4dz4ENluEMsZTR8F9P2GVSchAx5MzkAOdlM1w2hCNZOw
 OKLQ==
X-Gm-Message-State: AFq9FYJIackY0Eg5aXrP9e5niHmQ8191JmtC6WSUl3eMZVujri/5H4Gz
 5RQ+wEedXlwtD1Imu7Y6xfmOphNMs0M9vlAiQ1Kx0aqmXNawLyrN3muNI3fJ06xxLhgsK30wqYd
 JzOc9ha8=
X-Gm-Gg: AYBFou3TV/dvWxk4v9E3j71Zaoq96Y1pezu8TGuZEV0XF2aRMxuZJ0Zg8u6bJl1BO6T
 nUehKtBVpyRQnO6JnGl4ff67nepcBPkuclBgn0hS28ovJXMyQqv3/HtzlYvttyY+ZW29SJAL2Fx
 +ihCDGcAjdmytXpR78LGpoPQeIg3vWPNgk4cwGgb+gysTkzDVYcB+JxFYCeEckRhkpBVJFOjkwC
 xCi5so8TQjZpVSgH6sp4dul6qZxdIlCzx8/j5zgsJq98y34JC0Ja/7oz6DQpMxyN3OrTkU0OlEy
 ckhBHNM6pPMDRy51V4OI2Lh/CcKXa+kYMeGlk533Fvpw9AcJA/HQ2a+3O35m3WqCgeYCP8InixP
 vmYDxjh6OHUYvTO4B4G+LrvLbfRA/x5Tg4oL562Lf8upug7AyGeGkZi4046ThxkALOqhKrf4T/1
 MR9qwEDk93mXoybql1etbu48LxTui6Pwp+qwOOXcWdNtMJ6zf5timGIXR2/HW9HdrBhyfpyHKxo
 2p0EwhzpKLEgmV0lbVAU7/XWiXXIQBbPsU/2wA4Qp7CZx31ncl4QpYA+Lq6vigWgFP8HcPQz4Fa
 VWPtEc8OHDO/bqXKsgZjIiBv2aI=
X-Received: by 2002:a05:600c:c04f:b0:4a1:d45a:3ae9 with SMTP id
 5b1f17b1804b1-4a1f53d18cdmr85730475e9.15.1792592773052; 
 Wed, 21 Oct 2026 07:26:13 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 092/100] tcg: Generic expansion of tcg_gen_st_*
Date: Wed, 21 Oct 2026 16:16:44 +0200
Message-ID: <20261021141652.363109-93-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  | 20 +-------------------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d0d508ced6..469b925fe0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
@@ -166,7 +165,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
 
@@ -352,24 +350,11 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-#if UINTPTR_MAX == UINT32_MAX
-# define PTR  i32
-# define NAT  TCGv_i32
-#else
-# define PTR  i64
-# define NAT  TCGv_i64
-#endif
-
 TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
 QEMU_ARG_NONNULL void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
-
-static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
-{
-    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
-}
-
+QEMU_ARG_NONNULL void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
 QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
 QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
@@ -382,7 +367,4 @@ QEMU_ARG_NONNULL void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
 QEMU_ARG_NONNULL void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
 QEMU_ARG_NONNULL void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
 
-#undef PTR
-#undef NAT
-
 #endif /* TCG_TCG_OP_COMMON_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 98a07a70f0..514967f91d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -70,6 +70,7 @@ DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
 DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
+DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f1c33afc02..68e31fe5ca 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1251,6 +1251,11 @@ void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_st(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st, type, dst, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1412,12 +1417,6 @@ void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
 }
 
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset);
-}
-
-
 /* 64-bit ops */
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
@@ -1445,11 +1444,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
 }
 
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
@@ -1852,6 +1846,11 @@ void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     tcg_gen_ld(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), o);
 }
 
+void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    tcg_gen_st(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), o);
+}
+
 void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
 {
     tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_i64_temp(a));
-- 
2.53.0


