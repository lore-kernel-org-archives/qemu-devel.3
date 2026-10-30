Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411F606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fk3LcVEO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrnR-0008Id-Ii; Fri, 30 Oct 2026 14:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrm0-0006uN-UK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:21 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlw-0004pR-R5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:20 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b05bf699easo11198277b3.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386574; x=1793991374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKaovmZvoy42vyhXFWLgIndq++j7MuMZxApm2MP9S5U=;
 b=fk3LcVEO3UhyCTtpJdlVsO9AdPIB7eCaj28YUU5XN6dj2A4yTb3KwP+hb69EQvqSyw
 KMCKGEdo0Ji9Ures5dxvAGinOWb3Nx4qYuVDSAQJzvYHYotUHlPf1+w4CKQRM/OLpZrt
 curSeJ6hB9kObJSscdNNZOAfKXZ5m6jss6TqhXnr50x9m9CAGKb9LPsKck0UFtGA7KHJ
 YMeAOojxIss391JpjZAhD+Ve0HqS7xSP7Qc51shxQufWLWDOU7xAnAeWQ/OFO2t1o2pD
 Ehky8Rsm3JphBLEfqPjBexfixhc1GQU+zypMBd4hZqodort/vtHmqahg3QWDGh01j0DY
 HRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386574; x=1793991374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PKaovmZvoy42vyhXFWLgIndq++j7MuMZxApm2MP9S5U=;
 b=bfDJU8ZqJrTOERnH33C6H75ubBF4Z1PyvIyuBVSoTqR1DX23SIxwmCchIZuDROpKeG
 otvh1hNLBugouijbM3LVqm8iL79AkvmdwkWBhxOsRyLdBvlM9TZ12+8b1t34tm6dpwY+
 xMCdfEMpt9pOCYBGTG1M/m/77gCoYOWMX4kI2NNNT9vfsfzY6NFTzn0x2b0gxt5vUy+A
 a7NEExplYL79LpIkQTDB1UgTWw29ruSibl8msTKO1Dix1ckdqNbX7A408hrWtKpls0VM
 hwrrUcYE4L56WD7qqsj3ltgpaqn5d6SreIu8tRb84otFQqhGT5cqbCk3M6o4X88rEM/E
 kMaQ==
X-Gm-Message-State: AFq9FYKN1virF9ElerePYfIyvjMnzx57ezU18XAIyReJh1kyyjvXLqy2
 YF+DqDmMXjPjgZY1yO4j3QPcYMWscrfSq8/b7JHkDStvRVM85guvKsm6yr8YCGvnY6fPEOVtLnp
 9OJIe
X-Gm-Gg: AYBFou2cebS8a8upmylRUbi2RnE1GgxM05koC9mRvO0pKkz615MLU314UNP/szcuaI4
 r9vKjTVMNjlHMAeoK2RwXI066UU4W5BYIzxFHZx+kwoXa0g7GDqAKeEVCK0J5VLepni8J6Q0CsX
 rSj0muWn+NiRCojTTGUY7O6VUrFfFV3mMxoGR8qu6NI1c6svIT4A8eL+NlIu3xcI/KfkrY2Sn10
 kzm9XlD29tNapEuAZOmwWUEqATbFsWKhRi3g5h2jmliBJclgN2w8noXJ25G3bbdjLR5AJPcCHhA
 n5lJSJp8euGLzMLU02KnS0iNghB0iOACUoMgAhoFByVkup0hvThATvF2lq8+gVsA1EDcLj6Lxuj
 mYcS2OsMGC/vlAV9a1brlwJjKzEcyEL3M598jiQqEnwEAz1JtdrX+SipSqs/veVADWCQbRjRSJs
 3J+xyTlhZBRSmmjsBi6uJuCNiEo+gSLkIghkK7hYss9LAHCDMZhqm4AVPeQU+VCyM/n1Jm/q9L6
 UsI6iz9EhFvhcFo73CuoIbzuQgDQgRVNVud6gCMGzNPgbpoJBAuMh6zKcqjM2wxGJ5fez64RT+m
 7KOxgyx/P4qiZbpBP1/xfAYeP49UBNdeCF4=
X-Received: by 2002:a05:690c:ec3:b0:8ae:8607:e6cc with SMTP id
 00721157ae682-8b2b65b261bmr19140547b3.2.1793386574006; 
 Fri, 30 Oct 2026 11:56:14 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 13/14] tcg/s390x: Implement INDEX_op_goto_jc
Date: Fri, 30 Oct 2026 13:55:50 -0500
Message-ID: <20261030185551.193092-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1135.google.com
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

Use LGM to load multiple values at once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  1 +
 tcg/s390x/tcg-target-con-str.h |  1 +
 tcg/s390x/tcg-target.c.inc     | 60 +++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index f67fd7898e..b22614d718 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -18,6 +18,7 @@ C_O0_I2(r, ri)
 C_O0_I2(r, rC)
 C_O0_I2(v, r)
 C_O0_I3(o, m, r)
+C_O0_I4(r, h, hi, hi)
 C_O1_I1(r, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 636a38a168..e44b2a92d5 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -9,6 +9,7 @@
  * REGS(letter, register_mask)
  */
 REGS('r', ALL_GENERAL_REGS)
+REGS('h', 0xfff8) /* general regs other than r0-r2 */
 REGS('v', ALL_VECTOR_REGS)
 REGS('o', 0xaaaa) /* odd numbered general regs */
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 3b63383315..f31835da2b 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3202,8 +3202,66 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static void tgen_goto_jc_cmp_part(TCGContext *s, TCGReg reg,
+                                  TCGArg ref, bool const_ref,
+                                  const uint64_t *tb_slot, TCGLabel *l)
+{
+    if (!const_ref || ref == (int32_t)ref || ref == (uint32_t)ref) {
+        tgen_brcond(s, TCG_TYPE_I64, TCG_COND_NE, reg, ref, const_ref, l);
+    } else {
+        if (ref == *tb_slot) {
+            tcg_out_insn(s, RIL, CGRL, reg, tcg_pcrel_diff(s, tb_slot) >> 1);
+        } else {
+            tcg_out_insn(s, RIL, CGRL, reg, 0);
+            new_pool_label(s, ref, R_390_PC32DBL, s->code_ptr - 2, 2);
+        }
+        tgen_branch(s, S390_CC_NE, l);
+    }
+}
+
+static void tgen_goto_jc(TCGContext *s, TCGReg ptr, TCGReg pc,
+                         TCGArg cs, bool const_cs,
+                         TCGArg fl, bool const_fl, TCGLabel *label)
+{
+    const TranslationBlock *tb = tcg_splitwx_to_rx(s->gen_tb);
+
+    /*
+     * Note that pc, cs, fl are constrained to r3 or higher, r0 and r1
+     * are always reserved as scratch, this is the end of the translation
+     * block so r2 may now be clobbered, and the input ptr * is dead
+     * after the initial LMG.
+     */
+
+    /* ptr is CPUJumpCache */
+
+    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) !=
+                      offsetof(CPUJumpCache, array[0].tb) + 8);
+    /* lmg r1,r2,tb(ptr) */
+    tcg_out_insn(s, RXY, LMG, TCG_REG_R1, ptr, TCG_REG_R2,
+                 offsetof(CPUJumpCache, array[0].tb));
+
+    tgen_brcond(s, TCG_TYPE_I64, TCG_COND_NE, TCG_REG_R2, pc, false, label);
+    tgen_brcond(s, TCG_TYPE_PTR, TCG_COND_EQ, TCG_REG_R1, 0, true, label);
+
+    /* R1 is now TranslationBlock */
+
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) !=
+                      offsetof(TranslationBlock, cs_base) + 8);
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, tc.ptr) !=
+                      offsetof(TranslationBlock, cs_base) + 16);
+    /* lmg r0,r2,cs(r1) */
+    tcg_out_insn(s, RXY, LMG, TCG_REG_R0, TCG_REG_R1, TCG_REG_R2,
+                 offsetof(TranslationBlock, cs_base));
+
+    tgen_goto_jc_cmp_part(s, TCG_REG_R0, cs, const_cs, &tb->cs_base, label);
+    tgen_goto_jc_cmp_part(s, TCG_REG_R1, fl, const_fl,
+                          (const uint64_t *)&tb->flags, label);
+    tcg_out_goto_ptr(s, TCG_REG_R2);
+}
+
 static const TCGOutOpGotoJC outop_goto_jc = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O0_I4(r, h, hi, hi),
+    .out = tgen_goto_jc,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0


