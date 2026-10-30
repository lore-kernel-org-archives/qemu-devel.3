Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07161606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KrexsZNh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrlm-0006ru-5R; Fri, 30 Oct 2026 14:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlg-0006qw-7D
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:00 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrld-0004n5-Jc
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:55:59 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso9412407b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386556; x=1793991356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CARmoio7bFJMgAwfHhr6lkrU83o62HGa9/lgyZJ+P9Q=;
 b=KrexsZNhKw1eAg126XxVwslTgXvX1/nPNeSCn6yV81Jipi6NIkDN4QT70W9iv1D7b3
 IOGYRzdDHfj/BYXGsBipUz7+QRHZdtChk512wDU+2bMFIk/OhiCT4yf8682mnfUqrEWi
 gllmoM3KCWQ1iRRr5C5YrGcUp12tdTd9R2JgNlGoOd0ILk9mdUTloC3B9KwPnytZTEq7
 fFdSFNNUSNICXsGkxG6LAip7M6cQACXICDHo2i7zYkjSEGYODCrzxWkiB5r8U4Z0mHwX
 eEXpo7NVFZGaB5Hm5TDI5eHdrRYtNLnOzICXdnghJdvEJGoMsRIg/SmNJZNdfa8L5jZk
 iEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386556; x=1793991356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CARmoio7bFJMgAwfHhr6lkrU83o62HGa9/lgyZJ+P9Q=;
 b=Lk7nUcQjDIXUK3PvfNKntQ2gSDSsMRXWSWIq92j9xhaeBHH1rZQ/PejQwoipa9A1Ar
 Sd0XAEVW/g12Zw5hX4HVY7QJPWFNU7junwYouKQ4Ouq23YsNILg5iZzH9aetBB2uxSSr
 vaqrqq1gpZ5jIrLSayiM38kTDUm9P4juTy0nSU1dAYB6SgYXsHZFVwzFtL8n36H4jPkS
 IhADk8z44AyuOdj8aMRvsLRjlwUojPqyDL8/iGSyEUwUUUTzsJ1SsSHFQhRY5eFDAvAD
 QCIsNn0BgZMfTOHkUyVHL4hcQlo47D8qW2ByIUo9l8xylhklc3q7d7Z8BYUiBe0DAVDA
 5Yow==
X-Gm-Message-State: AFq9FYLYV4pX0eXGU1hR0DcBUpVPJPTXk5n3NftgjsDFiYVHyqKb5/fM
 tz3Ce8xUOqL290RvzLWiR1nfCv7f2ad4kySjGcC5ylLmBPexao0ru2KzOce6og6r1c5Lt7BXIEQ
 +/3ig
X-Gm-Gg: AYBFou1QkWINraP4KshgqwY2+444kuH3tbloELwVUEDQ6xn5UCgQvUblfl7zHvPV58B
 EXlGvXFno93DBkevJrIrd8AHuQZsAsdOxja6zysCMC5BUFKDx9WZdPfPoONoaS7crEKJDS5gjGE
 /ArkmS4tUB9kDhwSZLyt3isE7h7X7bly4jWWGAdyabMbYicfQoDyFEkFuyUg954bp3TbYhDYGNk
 e18mv+nDlojEoNvjzFPAruIy9et7qlc2hW52CVQnV66bLWSizwT77JZxC3BV8rYWg809wsVJde0
 Rnk14wkCqxHjnIOlCe+EM2wVeMlYC5XuGFEbWdVQi6f6IvFZ71A/E15+4isfznFXoIpp2DCn6xm
 nu0BBT6h5/P0IAy5tFNFB/ROstbNYb7xYCx4bef5Yh9Hp/8jcgVZnKDB0gla8MvSFabOKVtNiHf
 0Rb3TgBZYbqSXD4qRk1zD9fkKXmqM8X4I8aimiSXSUpOR3ty7noTw5hvqrgVjCaRFdHNjGkD/Kc
 JU7qvX8EAuxwFE7736MW9dsMJkA9+GJPOglRnImQi6BIZfu31BVflWHVGO9+ZEKSi1FIX4x/4fd
 WaTnUEyEz0cSIvtye9uaysKK1Kd7lp0m0ReOWFwGRkCdS5HdxEILiB37
X-Received: by 2002:a05:690c:d88:b0:8b0:ac83:de9d with SMTP id
 00721157ae682-8b2b6749586mr19919017b3.38.1793386556306; 
 Fri, 30 Oct 2026 11:55:56 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:55:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 01/14] tcg: add tcg_gen_goto_jc{3}_{i32,i64,tl}
Date: Fri, 30 Oct 2026 13:55:38 -0500
Message-ID: <20261030185551.193092-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112b.google.com
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

From: Matt Turner <mattst88@gmail.com>

At translation time the caller often already has the destination PC
in a temp and knows the flags, cflags and cs_base any destination it
may reach has to match because they are the same as the ones as the
current block being generated.  But the promise that the flags are
known (or unchanged) is subtle.

So add new entry points with new semantics and --enable-debug-tcg
checks against get_tb_cpu_state() at run time.

Signed-off-by: Matt Turner <mattst88@gmail.com>
[rth: Split out target changes; add jc3 variant; expand via tcg-op-def.h.inc]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  4 ++++
 include/tcg/tcg-op-common.h  | 29 +++++++++++++++++++++++++++++
 include/tcg/tcg-op.h         |  4 ++++
 tcg/tcg-internal.h           |  2 ++
 include/tcg/tcg-op-def.h.inc |  2 ++
 accel/tcg/cpu-exec.c         | 27 +++++++++++++++++++++++++++
 tcg/tcg-op.c                 | 35 +++++++++++++++++++++++++++++++++++
 7 files changed, 103 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 003c963bc7..b1755aae25 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -12,6 +12,10 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
 
+#ifdef CONFIG_DEBUG_TCG
+DEF_HELPER_FLAGS_4(goto_jc_check, TCG_CALL_NO_WG, void, env, i64, i64, i32)
+#endif
+
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
 #ifndef IN_HELPER_PROTO
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f80a895685..b16cee7860 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,35 @@ void tcg_gen_goto_tb(unsigned idx);
  */
 void tcg_gen_lookup_and_goto_ptr(void);
 
+/**
+ * tcg_gen_goto_jc3_i32() - dispatch to the destination TB via the jump cache
+ * tcg_gen_goto_jc3_i64() - dispatch to the destination TB via the jump cache
+ * @pc: temp holding the destination guest PC
+ * @cs_base: temp holding the destination guest cs_base
+ * @flags: the destination guest flags
+ *
+ * The contract is that the values provided inline are exactly the
+ * cpu state that would be returned by TCGCPUOps::get_tb_cpu_state.
+ * --enable-debug-tcg checks the contract at runtime.
+ *
+ * Using those values, the lookup may be done inline.
+ *
+ * Actually declared and defined via tcg-op-def.h.inc.
+ */
+
+/**
+ * tcg_gen_goto_jc_i32() - dispatch to the destination TB via the jump cache
+ * tcg_gen_goto_jc_i64() - dispatch to the destination TB via the jump cache
+ * @pc: temp holding the destination guest PC
+ *
+ * Similar, but cs_base and flags are taken from the current TB.
+ *
+ * Thus the contract is that no cpu state changes have occurred
+ * that affect the translation block flags.
+ *
+ * Actually declared and defined via tcg-op-def.h.inc.
+ */
+
 void tcg_gen_plugin_cb(unsigned from);
 QEMU_ARG_NONNULL
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a7d001c959..02732652b8 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -175,6 +175,8 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i64
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i64
+#define tcg_gen_goto_jc_tl tcg_gen_goto_jc_i64
+#define tcg_gen_goto_jc3_tl tcg_gen_goto_jc3_i64
 #define dup_const_tl dup_const
 #else
 #define tcg_gen_movi_tl tcg_gen_movi_i32
@@ -299,6 +301,8 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i32
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i32_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i32
+#define tcg_gen_goto_jc_tl tcg_gen_goto_jc_i32
+#define tcg_gen_goto_jc3_tl tcg_gen_goto_jc3_i32
 
 #define dup_const_tl(VECE, C)                                      \
     (__builtin_constant_p(VECE)                                    \
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index da1b9c9bab..ae0a19a2f7 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -196,12 +196,14 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #define TCGV      TCGTemp *
 #define TINT      int64_t
 #define TCGv_ptr  TCGTemp *
+#define TCGv_i64  TCGTemp *
 
 #include "tcg/tcg-op-def.h.inc"
 
 #undef TINT
 #undef TCGV
 #undef TCGv_ptr
+#undef TCGv_i64
 
 #undef DEF1
 #undef DEF2
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c9caab2138..accff4a781 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -32,6 +32,8 @@ DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
+DEF1(goto_jc, TCGV)
+DEF3(goto_jc3, TCGV, TCGv_i64, unsigned)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4497701486..cf690e0e11 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -407,6 +407,33 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     return tb->tc.ptr;
 }
 
+#ifdef CONFIG_DEBUG_TCG
+/**
+ * helper_goto_jc_check: check the contract of tcg_gen_goto_jc_*()
+ * @env: current cpu state
+ * @pc: the destination pc the caller passed at translation time
+ * @cs_base: the cs_base the dispatching block was translated with
+ * @flags: the flags the dispatching block was translated with
+ *
+ * A goto_jc looks the destination up on the caller's @pc with the flags and
+ * cs_base of the block doing the dispatching, so all three have to be what
+ * get_tb_cpu_state() reports by the time the dispatch runs.  That is a
+ * property of the translator, not of the generated code, so check it here
+ * rather than leaving a target that gets it wrong to be debugged as a block
+ * running with someone else's flags.
+ */
+void HELPER(goto_jc_check)(CPUArchState *env, uint64_t pc, uint64_t cs_base,
+                           uint32_t flags)
+{
+    CPUState *cpu = env_cpu(env);
+    TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
+
+    assert(s.pc == pc);
+    assert(s.flags == flags);
+    assert(s.cs_base == cs_base);
+}
+#endif
+
 /* Return the current PC from CPU, which may be cached in TB. */
 static vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
 {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fced3811c2..4f3cd9f082 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1854,6 +1854,41 @@ void tcg_gen_lookup_and_goto_ptr(void)
     tcg_temp_free_ptr(ptr);
 }
 
+void tcg_gen_goto_jc3(TCGType type, TCGTemp *pc,
+                      TCGTemp *cs_base, unsigned flags)
+{
+    /*
+     * Widen @pc to i64 because the jump cache is keyed on a vaddr;
+     * for a 32-bit guest PC that is its zero extension.
+     * Note that cs_base is target-specific, not a vaddr, and always 64-bit.
+     */
+    if (type == TCG_TYPE_I32) {
+        TCGTemp *pc64 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        tcg_gen_extu(pc64, pc);
+        pc = pc64;
+    }
+
+#ifdef CONFIG_DEBUG_TCG
+    /*
+     * The caller has asserted that no flags-affecting cpu state changes
+     * happened between this TB and the destination.  Check it.
+     */
+    gen_helper_goto_jc_check(tcg_env, temp_tcgv_i64(pc),
+                             temp_tcgv_i64(cs_base),
+                             tcg_constant_i32(flags));
+#endif
+
+    tcg_gen_lookup_and_goto_ptr();
+}
+
+void tcg_gen_goto_jc(TCGType type, TCGTemp *pc)
+{
+    const TranslationBlock *tb = tcg_ctx->gen_tb;
+    TCGTemp *cs_base = tcg_constant_internal(TCG_TYPE_I64, tb->cs_base);
+
+    tcg_gen_goto_jc3(type, pc, cs_base, tb->flags);
+}
+
 /* Host pointer operations */
 
 void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
-- 
2.53.0


