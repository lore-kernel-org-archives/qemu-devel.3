Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8F606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aYk3ap9N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8f-0003Qz-3U; Wed, 21 Oct 2026 10:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX89-00035z-Am
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX86-0001Vt-WA
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so6399055e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592241; x=1793197041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ct2zoPInzKpmglNnDsLZA2W7lEIiCZqkXb4+qIpugTc=;
 b=aYk3ap9NsCbr+x9SUMXj0CBwe4JvuCOQ+/fcHibwZissIlif5Bn1WQuIR2WDEm91nl
 SWzPfuqZAiJd8tm28+MaFzNm39Gct9vkGYnm0bMsQ0Qm4g08lA0DBt5E775jgccpu+Gb
 lrXBlsamvOo+AiVYPetJyZiTr9r1FP9k8h5JbL8oxw1bQPmaYFZvuOwOKDNEA3YtE/rH
 iBZyfyc7uqv3QfODj1bvi7/wP//23kisngPZUu/KJxMag7ncAcsS+RUFzJVpAOp/6TXA
 msCiv1nDTPr9VH2UoKT83peX6Iq7iNKqJYSoRSxeOEe3cbPh6E3Onv6VEiIUPdhSnRWZ
 v7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592241; x=1793197041;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ct2zoPInzKpmglNnDsLZA2W7lEIiCZqkXb4+qIpugTc=;
 b=P4lUwt3+N/1aR4f8aHht3W8WHZ4MEFSz4rbCCJkfbXoDS1nX6kjdZlLbSCGiwB08fQ
 t6MSwxcsScr7JNxNTERSvdQXDc0CTd6jFwrlNty6jN2YbD46qqGSsy5KIsHNuVwygm2+
 4lFMlyrgI0N2IRNP0KoWzl5kNI+bfS1XR7jMp9r9eZf9hUuaRz1kwNfMr9dimfUZ6+U2
 gyfdLcEpZPMu1jlCVe1k4OI6YDBVUAcI6KekxmFvhkEsZ/eowUeXV9HLCFc66K6j8hSy
 K44YMIB53vHbmQ/B7SvQ504TZGMKD2qz+HcGXAxmx4HmHNVnSQv5t8nmOz0zh23O0oyf
 Ij4w==
X-Gm-Message-State: AFq9FYKjIv648Ng6DQw18J1FSsI1XOvPy42A7MOCmXLzbi/IqzoeCPP6
 CUbnQfB2z8anOYcwsEnG+xK8KRdyqXB5bNCGHzYUg+u+DdVHTuswAJ8pgH+UAQ+M/csJquUKM5z
 SYQMwj+8=
X-Gm-Gg: AYBFou09J1G1/3zBWkbwPZCmYhzMjSFB3W5vloOxgXtfo+AXfC99AKrivcNuL+4Z558
 VSbaORHFVIapS2IWRr6DedsOWyhYOB9u5Sg/+WArAw2l6/pQ+2bZpZ7X9AwPWlz6PoW8fjlRQHA
 NPTuIGbt8NyOSCE2y/L1rbH5YFWkYuFSDCsCTFo0+Y6cJeMZAh6EU+7gLYv7tChWZyItyX/xIRZ
 OQHE7CiINUUbXqwB9QOc4HTU4zv5qCKX/X97IiHfklFop203kQHG468FgdKj4gU+/Y0od6Vdj0/
 ELHQLxeUPmhXkpnd/aH9R5pAmk/SU+6+6r0MgecF+BZMak9JwrSzq0YMtf/xnnIKypb+r5fYznM
 Lo7oO0LOy/jK0vbJswm6GuyPZ95dwJPJNkQjN+xjajUFZ6X5VuVz2tx2ryy76B+qB7EG5xw75hT
 wkCaYb0zrn19hJFVOBqyJYNZRCcQPz2nMaIMmaQ9xIWX+nFwInAVLPrxsnf/QQeU1O1Kx7qCV5Q
 SzpEuUbMeRkzmoPlT4HXp3SHlEbO0Uw8X6PzzylMyEMpznMo1YUHMXn2Y3sh6mzX2jJjT+/8jyK
 svk5LIJxGQPlmMwLFyWOHHLvMQc=
X-Received: by 2002:a05:600c:4743:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a1fdd19ca7mr43698495e9.20.1792592241358; 
 Wed, 21 Oct 2026 07:17:21 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 011/100] tcg: Generic expansion of tcg_gen_addi_*
Date: Wed, 21 Oct 2026 16:15:23 +0200
Message-ID: <20261021141652.363109-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  9 +--------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 34 ++++++++++++++--------------------
 3 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 879cc85bc9..61eced5ad1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -226,7 +225,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
@@ -544,12 +542,7 @@ static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
 
 QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
 QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
-
-static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
-{
-    glue(tcg_gen_addi_,PTR)((NAT)r, (NAT)a, b);
-}
-
+QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
 QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
 QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 73b1ec3d05..faa83a09b2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -2,6 +2,7 @@
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
 DEF3(add, TCGV, TCGV, TCGV)
+DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 83ecbaae8b..9544688daf 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -368,6 +368,15 @@ void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
 }
 
+void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_add(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -387,16 +396,6 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
@@ -1534,16 +1533,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
     if (arg1 == 0) {
@@ -2765,6 +2754,11 @@ void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
                 tcgv_ptr_temp(a), tcgv_ptr_temp(b));
 }
 
+void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
+{
+    tcg_gen_addi(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), b);
+}
+
 void tcg_gen_discard_ptr(TCGv_ptr s)
 {
     tcg_gen_discard(TCG_TYPE_PTR, tcgv_ptr_temp(s));
-- 
2.53.0


