Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AC606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DZkK6X7D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsak-00023o-2Z; Sun, 25 Oct 2026 03:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZh-0006ZT-2O
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZe-000479-MW
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so13149445e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913001; x=1793517801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lz7qzdTcDUaaiVQHVNoMdmd71gLDQwPa+pypesmQrds=;
 b=DZkK6X7D17pHP85HVvkmF9jFyFqNbHAl3/+4shFWLdVuAwRD6S/K2mcdJSkUTxmhgH
 QMT5yFKc/6CmRTqMJA/gyL0a/59Xer77bdAnTpztHs/hKNNmcxSl2hAsG+hQ7mQyQGi8
 vI445ZJILSAVc3LVWuu3qhprVex4kQuHd9Pw5jolfumgaauH7WXSiZd3/O6Lpt42MJn3
 TsffJAf+psX60Mp0nIua1lLJodj6un1YVTv88IQjKkEVcqhic0paLPU+X0qB1XaJmfgn
 bKx8UqaSrP9iTrSk5L1Lw9k+5ZEt+ohH3hj1trMN39sZxkH+1BR5QOyeqmMh3GXVXgIA
 oN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913001; x=1793517801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lz7qzdTcDUaaiVQHVNoMdmd71gLDQwPa+pypesmQrds=;
 b=slkJ8q7Ujh2BI0Evq2bnmrcA6cEEkMgZjMegxxCEpdtkiVlIzAujpaF/ZkRE2K/yoG
 49siZO66QPrXgAC9dUO0cv2EsiUegysJhoI5ZI+oMjjJ6dyudJ3xCE18TPvwkyDemNsO
 RXDpQEGzoGUJaLGSTDMrrMWZe/FMUEqyDAK1LMA3hEqPbsquuaO9/IqvH+TQioUG/9E1
 bT5Ygg9n4nvSceMpjTJ5vXfu2NHJuEMTJnJVKaMH3Pf19Wkn6cNvBeCqDlFmDNvZmD4W
 gAvSCYJ4hT6PIhQGG7lQo/g7YbpNRVWIAxpI+ztIo2U80ur7pKHYZATjSYnE01bfd+ZG
 4/Mg==
X-Gm-Message-State: AFq9FYJb8o+jQJ+wjL94ICw6eQvza++72rBgGYca1OJ2UDRcoaY2sjen
 eNgHg4pxO8zer/66L25TwgWHBY3Gx26azhBuRlHJLmuJGLfl/dgktKtMAVCqO6bNZcqvm3oatDG
 4B0FSVio=
X-Gm-Gg: AYBFou1ECiuvS1YE2NewjMeNT4UMYlDs9fzJzPo3lA2R1c9Zdgc+Hr+Ci0tFdYUHxIs
 06nZGcSO6B3bZ6wsCu2D+sonNX/iY+oGRFh57k2x+yNUy+506vpnBtdowX45/kcskivwclgJZnQ
 Gkycbbd5CtpEy90Skx+rm3bsoeP5LgdOoQzZ9NnmDdKxc6VF41W0zDTB0QhFlIDLGoST7s/EhCn
 qnOQB/ZzdOkh1rVOBFj4Z/GUHqKnxydtzPFkWGLIjw29b5ZiG5k5fvl81HCF2oDfkH/MEoittsz
 uHl3n9RUZRnvjXzQBDvOwH+iY+GWv6I5cbd0uxqWPnvTg1ilx8+DMuv67Wyb5+rlnv0zMS/T9D6
 Ku5Lwh3TQPSHkxAGg5aURxIjG8ObkFiavMuyR15R0brhRKK2F2bfGaxlZbJG5Gaq88VwJ8ClAD4
 lIUSL/QAeJmwpXVAGcaw89ZlgsWLnFmoA2pc4f5fUygmNICQc0UK+51fI4jidvqFNZl7TIYryfq
 zJbCF5Gioi7QLdWfRqlco7xOsbNb2jzL7E/AbIQLmfJ2ZT8KxZTe21AvaE=
X-Received: by 2002:a05:600c:3b93:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4a35ac96004mr65238695e9.12.1792913001235; 
 Sun, 25 Oct 2026 00:23:21 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 061/100] tcg: Generic expansion of tcg_gen_deposit_*
Date: Sun, 25 Oct 2026 08:18:36 +0100
Message-ID: <20261025071915.1123867-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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
 include/tcg/tcg-op-common.h  |  7 ++---
 tcg/tcg-internal.h           | 10 +++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 55 ++++++++++++++++--------------------
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d20ac150e4..7cb1a4de52 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5, T6);
 
@@ -125,12 +127,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -180,8 +181,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index a0edf11292..13c4be5a5c 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -126,6 +126,13 @@ static inline void tcg_gen_op_ttti(TCGOpcode opc, TCGType type, TCGTemp *t0,
     tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
 }
 
+static inline void tcg_gen_op_tttii(TCGOpcode opc, TCGType type,
+                                    TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                                    TCGArg a3, TCGArg a4)
+{
+    tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3, a4);
+}
+
 static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                                     TCGTemp *t3, TCGTemp *t4)
@@ -166,6 +173,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
@@ -181,6 +190,7 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 static inline void tcg_gen_extrh(TCGTemp *dst, TCGTemp *src)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 9b88373ff2..95885d28d8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
+DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 536095683f..62c2186d0c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -296,6 +296,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
                      glue(C_,T3)(c), glue(C_,T4)(d)); }
 
+#define DEF5(NAME, T1, T2, T3, T4, T5)                                  \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d, T5 e)   \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
+                     glue(C_,T3)(c), glue(C_,T4)(d), glue(C_,T5)(e)); }
+
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6)                              \
     void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f) \
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
@@ -307,6 +312,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_int64_t
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_unsigned
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -336,11 +342,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_int64_t
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_unsigned
 
 #undef DEF1
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 /*
@@ -539,6 +547,23 @@ void tcg_gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+void tcg_gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
+                     TCGTemp *src2, unsigned ofs, unsigned len)
+{
+    unsigned width = tcg_type_bits(type);
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (len == width) {
+        tcg_gen_mov(type, dst, src2);
+    } else {
+        tcg_gen_op_tttii(INDEX_op_deposit, type, dst, src1, src2, ofs, len);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -919,21 +944,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    if (len == 32) {
-        tcg_gen_mov_i32(ret, arg2);
-    } else {
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-    }
-}
-
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len)
 {
@@ -1681,21 +1691,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    if (len == 64) {
-        tcg_gen_mov_i64(ret, arg2);
-    } else {
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-    }
-}
-
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


