Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956ED606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=toXlBgQ4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWA-0006Ei-L4; Sun, 25 Oct 2026 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVw-0006AE-PC
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVu-0003g3-OZ
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso938231f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912769; x=1793517569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p7SyB9XCW1x5SpP4mvFr/V1Hya9Z9kBpo3OqfqhJR2k=;
 b=toXlBgQ4jm+Y80H1onOH7X7YYoqcNgQ/VCeicrEe6/VWJlXD2HLql6OWhhp0zeB6+i
 E2RyXQA1CdC+v9R4blUqSXIrgTJXHsJhcBJP3JkWuYgrnI3QhiHUt3Jo4ilh78j8DcOD
 0N24o4heiWCBTlRg0Yf61eA/hiCKbmkreDnoDQiTy4ceo2l5mRWtTf3b+5Vm3etDdp/+
 ZYVWOjZ8Qz8+YDlB5AHGVNP2pfXXzJVgdcqMu+aCwOsTngoZDyixw1LQLI+NMF2QXZZ/
 ma5rXF2OThNXdqFJc9czt3BsnUBXLxEobDkiLgvN1CitbjdmrC1LTNjBO7XPNRiXwySj
 xDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912769; x=1793517569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p7SyB9XCW1x5SpP4mvFr/V1Hya9Z9kBpo3OqfqhJR2k=;
 b=LRMjpGJckQkgkW3TSVep9eDT1A2GyCzZmYnw5HVF3MW/WCQViSc9QhUkri5sfxkNja
 Dm5FB+BeccgjDYRZFdJTtx7Kxcx3bL7CquXz8UG86mdSxXqPbpKkluTgSYZOwoHGr4cM
 Xoh+jGD9ewQCVLPP3khG0gDpVqi+rnsvGFRHe9h0GgiIzgEmxGbFgt8CLV7LPe+ei1Hp
 DHBCVOlLN55NV0ccMYkicSZrIIL7WcAbrry/4PsKNeLvmSPNseakR0rDbRHqQ5XkyZro
 fOx4IDTWpXnt/HCd5FKfPOSierAjTcPF+gu9OraGT6tqia9C8UsC0M+ZDjnkTGUeu+Z9
 OQqA==
X-Gm-Message-State: AFq9FYJRaWqk7ppPAEaHiKCNWeMuLTbx9vNlS0rw6DjkNhgk/oiyy53y
 85+1MsBev8lyfr7EdnVmp5Dcjh4ha49wl/W7lO4jdCiKBZrTJIup1JZs9egTz3Wu2wZEu6Pd9AC
 5pWXIwd8=
X-Gm-Gg: AYBFou24F8mKCfQ530eqQcj6G9KzIopQeUtI6hMJFFEUTecZsP0OvnCYs5RCsXu9+KG
 ZLunSR5qqn1UrmI1QqPKBdUGnhPbtygsoejVTk7QEUWB8caK5AHisIfQyP5m52tnOTDUcsJGHQU
 j2zFfHP6WBLuRWsb0AnvscsAi4Ypf1UzsY+WJEgmCyaLSsjWXd22uLEAbMNJo2iAaTtFmU6i5bO
 sic8CL3RcgnijlVU80Pp8DY8lsELl4uGbyNnSh7zLvVNKghghd2rW6w7NdZvitB1LfdlaPD5dCi
 z2owoiQOo05jvqeEVwssGlNjviXYabI4ewTvjD8wx1OEfe63ohlmJxBTV1iUJrXt8yFIJS+6OXd
 /A61+XBh00agFz3+4dg+7AoJgsB22x87nmY0YT8O0A8l1rsXw2HylkbXXW6OYw+/ejFobGe20c1
 NFhbx54PvlkJaB/LVBPcGpHRvz1eV1V35u0y6s9Ka3rG4QWAFx4LZEVWhFuLOnZv4tYhvbENahW
 JrJi0dDp1mtH8BWXKJBHGsK4BQJtyvuYXCQA8VDh7iR82YKPFDwHIRQ7g==
X-Received: by 2002:a5d:5d10:0:b0:48b:1a0:5630 with SMTP id
 ffacd0b85a97d-48e3eb9e397mr5419978f8f.41.1792912769001; 
 Sun, 25 Oct 2026 00:19:29 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 007/100] tcg: Generic expansion of tcg_gen_mov_*
Date: Sun, 25 Oct 2026 08:17:42 +0100
Message-ID: <20261025071915.1123867-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

Begin sharing code in the expansion of operations
for various TCG types.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  | 34 +++++++++++++---
 tcg/tcg-internal.h           | 23 +++++++++++
 include/tcg/tcg-op-def.h.inc |  4 ++
 tcg/tcg-op.c                 | 76 +++++++++++++++++++++++++++++-------
 4 files changed, 117 insertions(+), 20 deletions(-)
 create mode 100644 include/tcg/tcg-op-def.h.inc

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9b321f959c..deec10159a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -88,6 +88,33 @@ void tcg_gen_lookup_and_goto_ptr(void);
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
+/*
+ * Construct operations from templates.
+ */
+
+#define DEF2(NAME, T1, T2) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2);
+
+#define TCGV  glue(TCGv,TExt)
+#define TExt  _i32
+#define TINT  int32_t
+
+#include "tcg-op-def.h.inc"
+
+#undef TExt
+#undef TINT
+
+#define TExt  _i64
+#define TINT  int64_t
+
+#include "tcg-op-def.h.inc"
+
+#undef TExt
+#undef TINT
+#undef TCGV
+
+#undef DEF2
+
 /* 32 bit ops */
 
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
@@ -172,7 +199,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_discard_i32(TCGv_i32 arg);
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -294,7 +320,6 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 void tcg_gen_discard_i64(TCGv_i64 arg);
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
@@ -533,10 +558,7 @@ static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
     glue(tcg_gen_addi_,PTR)((NAT)r, (NAT)a, b);
 }
 
-static inline void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
-{
-    glue(tcg_gen_mov_,PTR)((NAT)d, (NAT)s);
-}
+QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
 
 static inline void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
 {
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d480d10878..3568157ebb 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -102,6 +102,12 @@ void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
+static inline void tcg_gen_op_tt(TCGOpcode opc, TCGType type,
+                                 TCGTemp *t0, TCGTemp *t1)
+{
+    tcg_gen_op2(opc, type, temp_arg(t0), temp_arg(t1));
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
@@ -114,4 +120,21 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
  */
 bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 
+/*
+ * Declarations of templated TCGv_i32 and TCGv_i64 operations.
+ */
+
+#define DEF2(NAME, T1, T2) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2);
+
+#define TCGV  TCGTemp *
+#define TINT  int64_t
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TINT
+#undef TCGV
+
+#undef DEF2
+
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
new file mode 100644
index 0000000000..c76e83396a
--- /dev/null
+++ b/include/tcg/tcg-op-def.h.inc
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: MIT */
+/* Templated TCGv_i32 and TCGv_i64 operations */
+
+DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2c88f4f7ca..4b8dfba8a9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -315,6 +315,61 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, 0, tcgv_i64_arg(addr), meminfo);
 }
 
+/*
+ * Templated TCGv_i32 and TCGv_i64 operations.
+ */
+
+#define DEF2(NAME, T1, T2)                                              \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b)                     \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b)); }
+
+#define C_TCGv_i32      tcgv_i32_temp
+#define C_TCGv_i64      tcgv_i64_temp
+#define C_int32_t
+#define C_int64_t
+
+#define TCGV  glue(TCGv,TExt)
+#define TExt  _i32
+#define TINT  int32_t
+#define TYPE  TCG_TYPE_I32
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TExt
+#undef TINT
+#undef TYPE
+
+#define TExt  _i64
+#define TINT  int64_t
+#define TYPE  TCG_TYPE_I64
+
+#include "tcg/tcg-op-def.h.inc"
+
+#undef TExt
+#undef TINT
+#undef TCGV
+#undef TYPE
+
+#undef C_TCGv_i32
+#undef C_TCGv_i64
+#undef C_int32_t
+#undef C_int64_t
+
+#undef DEF2
+
+/*
+ * Generic expansions for templated operations.
+ * We have used compiler type checks to ensure all TCGTemp
+ * are of the proper type.
+ */
+
+void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (src != dst) {
+        tcg_gen_op_tt(INDEX_op_mov, type, dst, src);
+    }
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -322,13 +377,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i32(INDEX_op_mov, ret, arg);
-    }
-}
-
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
 {
     tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
@@ -1396,13 +1444,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (ret != arg) {
-        tcg_gen_op2_i64(INDEX_op_mov, ret, arg);
-    }
-}
-
 void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 {
     tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
@@ -2730,3 +2771,10 @@ void tcg_gen_lookup_and_goto_ptr(void)
     tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
     tcg_temp_free_ptr(ptr);
 }
+
+/* Host pointer operations */
+
+void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
+{
+    tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(d), tcgv_ptr_temp(s));
+}
-- 
2.53.0


