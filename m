Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D6606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PMybKzay
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrmY-00071X-2R; Fri, 30 Oct 2026 14:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlx-0006tI-9a
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:19 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlt-0004p9-74
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:16 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b0d63f60bcso9408557b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386571; x=1793991371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BSf4yzgKqdfUtkbrvtphNnKJMg2rwq5r2CRGhdXxOZc=;
 b=PMybKzayJqHOK3Mu02+iSdJO0NITScXcfv+M/r2yk/9Rcxt5yx/3rGbnHOF45Fp/4w
 Oh6jSQXwABFDcbhV6hTWYQENODC+kl8c819E73roLFYG5Mk464et6FaUvy6muptnvoSC
 HUT2U7ZjRmswPjZbmMNo6vYo9I6ZBSK+9YBs/Lo8WBYU5m+nMqy0o5t55eFhB2nmaMb4
 f6glBnKud9fRUw7ly38KlkNpMrLgoF/j0jArQyfMIAP3Khut/QJEojayyc0lJVmRr5Kd
 C0mC1oNH/UgGl7C4O2eptX5z+a9jGZo5RBNCxTOYQ08DNbUHVOcRPeWujpYhsHDGDZ65
 cMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386571; x=1793991371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BSf4yzgKqdfUtkbrvtphNnKJMg2rwq5r2CRGhdXxOZc=;
 b=Kw5j6+8ouMyUr8T4l9inBHD8R4/h0RMvGi4R3I19M7OR8pzh7NkD5nOHPBN7Ya2mWY
 wxg+QmPcok49PjUw00CRq5hefmzMkNQquP90I4lysMWHYGKewS2JE7+cMA5BIZSZmmrZ
 uiBm00C2KVcID8VmyecQYvpXLpVT+eicH3BTcqy1x1FlgnoVWTUv8aQy5YoVAYkz0GJg
 QHfI/n2rUPwPxxeMGB59VeE6ULP8zhKLFWxnCtXDJ6yg4539bvSrh15aa20TDsZHDQlc
 gyLWuVwXUUUQN6SGXqVy69B1p+bLPSxItlxevhj45ke5wkaxL/WFmj7JuZG5EZZzLvbb
 l9Ag==
X-Gm-Message-State: AFq9FYIcStZ7oYpxPZLYVJ0QyHDe767qlUL16e72SM6YCrz3B0AAWkz3
 pHiUum4YWU/JiHtZfmn8PVdLnyBiKjF12q3GnSbKr6fvAC0eN8dmGA44/pq9ZJ31AMAmwwNhxPu
 oMK2q
X-Gm-Gg: AYBFou2FjiDMylpwAewfwP4vw/kr6LqCIAsYZB+UtMYvlvXeHEOHg7rjJEzvzNsCVYx
 zcDBIensLe4woDZmB5OcoLWCua5IDXCfXKdV/1qIpr2Iv3kY2S47rjvKi+0PxHy9om0FodyFyrA
 bL8M6mgk68SfdB5adWAUp3Dlha+fl3odezCZocuzsNH4OvBkP83nYSBZlePvr/IqiFsuQYKsVs8
 5ntcMdQb3uL/ST6Errn5a7QHnzDh+f9t6puRqQ4qcvVEbGse2HAzP+7+r3kPDTpYYWoJcInh95q
 13cRbd144h0DbYpe6RhB7tyj7DuKC191tNk6YXUevOtJkwM3p4ZoBOfrGw9mi7l5yVrJnh5Wbue
 XJLaZIAJFcbO4OAhY3mZ8ZG0D2rGynZPl9u4zjR6SAzziBN/EpzFg1czt0XXWVyKz/ekf4gcjNb
 xPHeOZyQfwDyVC1l9Ld3ojxOZdmU1TSu/lyAaI57YsESmnTAauR6xCX/nT4M6gw605/k0qjzwug
 40EurmqxWZ1IByZkCyn8yDSyC95JZn36ogtq2p+lr9FEgWP0opRtTm/LOIcHEncsvTKWlDgjjfl
 epD4MMK9kkjs1je861aWXOE77SL3UmIu9hU=
X-Received: by 2002:a05:690c:4003:b0:8b0:ad62:19aa with SMTP id
 00721157ae682-8b2b671babcmr16965717b3.33.1793386571087; 
 Fri, 30 Oct 2026 11:56:11 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 11/14] tcg/x86_64: Implement INDEX_op_goto_jc
Date: Fri, 30 Oct 2026 13:55:48 -0500
Message-ID: <20261030185551.193092-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1132.google.com
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

Use comparisons vs memory, short branches, and
an indirect memory jump.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                   |  1 +
 tcg/x86_64/tcg-target.c.inc | 77 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 671cf8fd0e..24eee302eb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -61,6 +61,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "user/guest-base.h"
 #endif
+#include "../accel/tcg/tb-hash.h"
 
 /* Forward declarations for functions declared in tcg-target.c.inc and
    used here. */
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 04c83fbe6b..d21fc2e9c7 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -1532,6 +1532,12 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
     return jz;
 }
 
+static void tgen_cmp_mem_reg(TCGContext *s, int rexw, TCGReg reg,
+                             TCGReg base, intptr_t ofs)
+{
+    tcg_out_modrm_offset(s, OPC_CMP_GvEv | rexw, reg, base, ofs);
+}
+
 static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *label, bool small)
@@ -3374,8 +3380,77 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static void tgen_goto_jc_cmp_part(TCGContext *s, TCGArg val, bool const_val,
+                                  TCGReg scratch, const TranslationBlock *tb,
+                                  TCGReg base, ptrdiff_t ofs)
+{
+    if (!const_val) {
+        /* cmpq ofs(base), %val */
+        tgen_cmp_mem_reg(s, P_REXW, val, base, ofs);
+    } else if (val == (int8_t)val) {
+        tcg_out_modrm_offset(s, OPC_ARITH_EvIb | P_REXW, ARITH_CMP, base, ofs);
+        tcg_out8(s, val);
+    } else if (val == (int32_t)val) {
+        tcg_out_modrm_offset(s, OPC_ARITH_EvIz | P_REXW, ARITH_CMP, base, ofs);
+        tcg_out32(s, val);
+    } else {
+        uintptr_t tb_slot = (uintptr_t)tb + ofs;
+
+        tcg_out_ld(s, TCG_TYPE_I64, scratch, base, ofs);
+        /*
+         * Compare the value vs a rip-relative reference.
+         * If the value is unchanged from the current TB,
+         * we can reuse that.  Otherwise drop it in the pool.
+         */
+        if (val == *(uint64_t *)tb_slot) {
+            tcg_out_modrm_sib_offset(s, OPC_CMP_GvEv | P_REXW, scratch,
+                                     TCG_REG_NONE, TCG_REG_NONE, 0, tb_slot);
+        } else {
+            tcg_out_modrm_pool(s, OPC_CMP_GvEv | P_REXW, scratch);
+            new_pool_label(s, val, R_386_PC32, s->code_ptr - 4, -4);
+        }
+    }
+}
+
+static void tgen_goto_jc(TCGContext *s, TCGReg ptr, TCGReg pc,
+                         TCGArg cs, bool const_cs, TCGArg fl, bool const_fl,
+                         TCGLabel *label)
+{
+    const TranslationBlock *tb = s->gen_tb;
+    unsigned free = (ALL_GENERAL_REGS & ~s->reserved_regs & ~(1 << ptr)
+                     & ~(const_fl ? 0 : 1 << fl));
+    TCGReg scratch = ctz32(free);
+
+    /* ptr is CPUJumpCache */
+
+    /* Validate pc match */
+    tgen_cmp_mem_reg(s, P_REXW, pc, ptr, offsetof(CPUJumpCache, array[0].pc));
+    tcg_out_jxx(s, JCC_JNE, label, true);
+
+    /* Load and validate tb non-null */
+    tcg_out_ld(s, TCG_TYPE_PTR, ptr, ptr, offsetof(CPUJumpCache, array[0].tb));
+    tcg_out_brcond(s, P_REXW, TCG_COND_EQ, ptr, 0, true, label, true);
+
+    /* ptr is now TranslationBlock */
+
+    /* Validate cs_base match */
+    tgen_goto_jc_cmp_part(s, cs, const_cs, scratch, tb, ptr,
+                          offsetof(TranslationBlock, cs_base));
+    tcg_out_jxx(s, JCC_JNE, label, true);
+
+    /* Validate cflags:flags match */
+    tgen_goto_jc_cmp_part(s, fl, const_fl, scratch, tb, ptr,
+                          offsetof(TranslationBlock, flags));
+    tcg_out_jxx(s, JCC_JNE, label, true);
+
+    /* Jump to tb */
+    tcg_out_modrm_offset(s, OPC_GRP5, EXT5_JMPN_Ev,
+                         ptr, offsetof(TranslationBlock, tc.ptr));
+}
+
 static const TCGOutOpGotoJC outop_goto_jc = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O0_I4(r, r, ri, ri),
+    .out = tgen_goto_jc,
 };
 
 static int const umin_insn[4] = {
-- 
2.53.0


