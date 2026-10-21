Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB3606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kGhnQUb2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDr-00021T-Nq; Wed, 21 Oct 2026 10:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD4-0001LK-Hn
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD2-00027t-6R
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so6146705e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592546; x=1793197346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EMDenfZrO7/al5kOmjhJOJeDmJxVvzsKFfaRTQmqtxs=;
 b=kGhnQUb2p5sUbBPbJiHu1G6HYr7ioxxd90y/n3UMKy4fgmc/Xuk+vEgp0bA4lojjVV
 HTIfQjsKESCc+PXMlGN5u94ziSwK13hdrA3JXN/evHY3Cj6kz2vLHNciTMvo5l1jLu36
 X6wrk5GhdEKuByBp9QtDnHnUGEMhX4gktAP3E6+Y6nRbMSWPYCIfmtFTJAyLilK0P6Mo
 UsL/1Dn72NUD7kTLUKscl6ORzmEalr+5HKe9cu2+ELOszjnGT1aTN7uS9j3pBqzJvjAH
 P+U7hxDRhvDjBM4Lp/kH/o327gmG5peCI1PK3v5Dg7QxekvMk3LgXKq3A0PX7nbmy/fa
 RDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592546; x=1793197346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EMDenfZrO7/al5kOmjhJOJeDmJxVvzsKFfaRTQmqtxs=;
 b=fXjxH7jfbmRaiWoU3wS5pZANy0FWRFRwSukY139RzYDaEt+Jz4E/V8MarWVsSps5sQ
 izDLsBtRFkyKDZo6rDL/ap1YdpRXXw4cnV7yhZPWFsxF8e7UXkMV01leHm0YRTb/QaC9
 B98vqqjRPL2gBvYcUOGzhYOYvGo8liGZHFY32tz2ih4v5pnqCfRnyeMcb7VnDu37e7HN
 Ut88EK6dOEFf2yTV1kBXFS1+T1sK8RRCMI1e95nVb19u70hE4MIcPdi/oxQZj8HxBh8U
 vGZ9pDW8jAekrc76/820DF9ttR0m6ITOdoyW4tXLGPMYIQaduf7pepBpRVGnetven1xV
 RUXg==
X-Gm-Message-State: AFq9FYIIISjGlPg24g62LL+v+nzZDKKdBQdJYQVdVBccVH/zSS4VTXRp
 1jd5bpmiN+T2r2BiAo7eBHBV/4Tz0iMcO7VmMcr5kft3hKc2HrD48RvfsgJ9OnTU8KdD8KtwEWN
 Ngf7vJRc=
X-Gm-Gg: AYBFou1AozQYMdRuOX8H1DZNWgz/8dl5AgACZmqsGGZkwk2xjgo+Fo2rKTde28POLy4
 esejiUHXJVaIcy6qAQGcGsqe0UPDjdEp/FwLHoGg0V00h44ecLUN+BSwQugK8nmSHf5lQ8wzXt1
 kmiowfYcmeM7E+finjYANq3aFU5FHUyV5wRz7VcrOvODpqCbUnNmAVD6hcN51EYRpc1R9DpeGVA
 65zypgEO7iRr8CGUYpqnG5x76Kj7Y2ltJzJ9jA3ugSbw+luFe6i52RA9yV0t43g0cGvb3/VYEDO
 9ChxL9qJOCtMeMgMFdvuWQGV/wYDyKQarICRQV2tvVF4+LigmV80gsSWAwf1/3G0nVpfYM99Qlx
 BdU+AxqGKhVisG8HbVW9362nkh3qjfcsqucZ+7mBFze349ycL/5m/+XgfMVa9L0TtKHQJcMXY0a
 tzKHKzG91KzgTe7YykjKW+cEtLJqe6XoaJkS5q9nPRVb7ZTC8SV1HtvFVZgPmpr7HMfXqXoG7Ls
 uWGuE/2ByQuVCA2COtaJyQvCkWGP0gtzR2Tyj3RF4Gig065+AsRTs0G35OFbpIlpxaqGzBNnrGt
 i7IU9halDAZA07K2xHTOC8N7ItY=
X-Received: by 2002:a05:600d:640f:20b0:4a2:a9:ed56 with SMTP id
 5b1f17b1804b1-4a200a9f170mr24762615e9.8.1792592545643; 
 Wed, 21 Oct 2026 07:22:25 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 047/100] tcg: Generic expansion of tcg_gen_movcond_*
Date: Wed, 21 Oct 2026 16:15:59 +0200
Message-ID: <20261021141652.363109-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
 include/tcg/tcg-op-common.h  |  7 ++---
 tcg/tcg-internal.h           | 11 +++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 58 +++++++++++-------------------------
 4 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index fad2933425..9988e9f66b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4);
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5, T6);
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -123,6 +125,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF6
 
 /* 32 bit ops */
 
@@ -146,8 +149,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
-                         TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -209,8 +210,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
-                         TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 0de8516447..cd5028104a 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -134,6 +134,14 @@ static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
                 temp_arg(t3), temp_arg(t4));
 }
 
+static inline void tcg_gen_op_ttttti(TCGOpcode opc, TCGType type,
+                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                                     TCGTemp *t3, TCGTemp *t4, TCGArg a5)
+{
+    tcg_gen_op6(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                temp_arg(t3), temp_arg(t4), a5);
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
@@ -158,6 +166,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4);
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -171,5 +181,6 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF6
 
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 846b781c83..a1c1e9b918 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6be1141c08..ed7dd8c7c1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -225,22 +225,6 @@ static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4, a5);
 }
 
-static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                 TCGv_i32 a3, TCGv_i32 a4,
-                                 TCGv_i32 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
-}
-
-static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                 TCGv_i64 a3, TCGv_i64 a4,
-                                 TCGv_i64 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -312,6 +296,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
                      glue(C_,T3)(c), glue(C_,T4)(d)); }
 
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6)                              \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f) \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
+                     glue(C_,T4)(d), glue(C_,T5)(e), glue(C_,T6)(f)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
@@ -352,6 +341,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF6
 
 /*
  * Generic expansions for templated operations.
@@ -487,6 +477,18 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+void tcg_gen_movcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                     TCGTemp *c1, TCGTemp *c2, TCGTemp *v1, TCGTemp *v2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_mov(type, dst, v1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_mov(type, dst, v2);
+    } else {
+        tcg_gen_op_ttttti(INDEX_op_movcond, type, dst, c1, c2, v1, v2, cond);
+    }
+}
+
 void tcg_gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
@@ -1035,18 +1037,6 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
     }
 }
 
-void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
-                         TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_mov_i32(ret, v1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_mov_i32(ret, v2);
-    } else {
-        tcg_gen_op6i_i32(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
-    }
-}
-
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1960,18 +1950,6 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
     }
 }
 
-void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
-                         TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_mov_i64(ret, v1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_mov_i64(ret, v2);
-    } else {
-        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
-    }
-}
-
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


