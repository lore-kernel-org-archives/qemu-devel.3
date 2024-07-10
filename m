Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39ACC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0T-0000Sn-15; Tue, 09 Jul 2024 23:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0R-0000LE-8q
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:35 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0G-0003lV-OV
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:34 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d927fb8b82so2166275b6e.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582103; x=1721186903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8lyWWwevJiV+pRf9putmfcP/De9rht1hhWDZkZc1aM=;
 b=hNCu3azfJUIi6cKZJY126QpkTDT3eBA0M8MXNZZLRBKWIytHLJ7FIwSTmEpie7st0C
 k1VtmE/C6thVdckFU4inLuWnYalaNoKI0pZPT/95uD/Dx5NjJwkVAG+TXzy5aIN21tmk
 ly5ZdR25FHh+cCO82T2nnYEbVbdxOrm3cLZ1rAe6h3QwwUywV4fTwkkhOEkWnpFcxRVr
 /Kc28TFtkh9Z5M0TrfaA5EuvharlE/mvuWtCUmXISGqD/0iFqo/Utu4byhHkj5UBuMb8
 ahEEiydCx9lcWt8TEzN/G89qE/lJTSx+ofIJvFqs7V5GQ+MDi5UpqYrB0Umo+mv9pbAG
 mQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582103; x=1721186903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8lyWWwevJiV+pRf9putmfcP/De9rht1hhWDZkZc1aM=;
 b=HXxIh7i0VZ96nhXJ8v6mLddcg74MnujbdLgKM8p+nR2SMGyGaiArXeIiqDoSS9UJih
 VaCCNtoF6Su5yZtQfLVTV6fA2yBUQaLfUCt17+K5nrN9CP+mypcur6I8KtA3ccsRjXVY
 oRrOJz/DhtCX8IbavKoPt1LsRtKaNbzEw1i44K5qjeCUyNjWQ+agyPluJLeEPG8ieagb
 Cweme4+1i7TX9fbBSXWvRhCelFvvVwT9tze3ZbjajGj4bwQnBjDuT+xtpdVMB80SWhq9
 fmiSs0VmC7nFdSFnunC6YoQ+XKDJ1ijaXihEESRq0A0Qo2znHytsoAjFHAgc7pYx+5iD
 vu/g==
X-Gm-Message-State: AOJu0YxGpEc/gGRO6d8AxiSoDwUx1q/Ys+BuNsQkDSxa2RbELVjKY/S+
 GFFfJj0WR7lmhQrVl1nRA+5mqIVsm9x2qVcSXHH6Z1jPKDrdk4na2st7vDCohxVpP2Cvo4xhkhn
 38yQ=
X-Google-Smtp-Source: AGHT+IGnU8yKcEFzCot1hBGSlLqCnILfq/iHunEVPQYa7Vu6iWFAZkPaaQGO20wUDxocWETrDIQ/5w==
X-Received: by 2002:a05:6808:1887:b0:3d9:33d0:cc40 with SMTP id
 5614622812f47-3d93bedd7fcmr4876091b6e.9.1720582103254; 
 Tue, 09 Jul 2024 20:28:23 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 07/13] target/ppc: Split out helper_dbczl for 970
Date: Tue,  9 Jul 2024 20:28:08 -0700
Message-ID: <20240710032814.104643-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We can determine at translation time whether the insn is or
is not dbczl.  We must retain a runtime check against the
HID5 register, but we can move that to a separate function
that never affects other ppc models.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  7 +++++--
 target/ppc/mem_helper.c | 34 +++++++++++++++++++++-------------
 target/ppc/translate.c  | 24 ++++++++++++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 76b8f25c77..afc56855ff 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -46,8 +46,11 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(lsw, void, env, tl, i32, i32)
 DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
-DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, i32)
-DEF_HELPER_FLAGS_3(dcbzep, TCG_CALL_NO_WG, void, env, tl, i32)
+DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
+#ifdef TARGET_PPC64
+DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
+#endif
 DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 5067919ff8..d4957efd6e 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -296,26 +296,34 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     }
 }
 
-void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
+void helper_dcbz(CPUPPCState *env, target_ulong addr)
 {
-    int dcbz_size = env->dcache_line_size;
-
-#if defined(TARGET_PPC64)
-    /* Check for dcbz vs dcbzl on 970 */
-    if (env->excp_model == POWERPC_EXCP_970 &&
-        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
-        dcbz_size = 32;
-    }
-#endif
-
-    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+    dcbz_common(env, addr, env->dcache_line_size,
+                ppc_env_mmu_index(env, false), GETPC());
 }
 
-void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
+void helper_dcbzep(CPUPPCState *env, target_ulong addr)
 {
     dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
 }
 
+#ifdef TARGET_PPC64
+void helper_dcbzl(CPUPPCState *env, target_ulong addr)
+{
+    int dcbz_size = env->dcache_line_size;
+
+    /*
+     * The translator checked for POWERPC_EXCP_970.
+     * All that's left is to check HID5.
+     */
+    if (((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
+        dcbz_size = 32;
+    }
+
+    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+}
+#endif
+
 void helper_icbi(CPUPPCState *env, target_ulong addr)
 {
     addr &= ~(env->dcache_line_size - 1);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0bc16d7251..2664c94522 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -200,6 +200,7 @@ struct DisasContext {
     uint32_t flags;
     uint64_t insns_flags;
     uint64_t insns_flags2;
+    powerpc_excp_t excp_model;
 };
 
 #define DISAS_EXIT         DISAS_TARGET_0  /* exit to main loop, pc updated */
@@ -4445,27 +4446,29 @@ static void gen_dcblc(DisasContext *ctx)
 /* dcbz */
 static void gen_dcbz(DisasContext *ctx)
 {
-    TCGv tcgv_addr;
-    TCGv_i32 tcgv_op;
+    TCGv tcgv_addr = tcg_temp_new();
 
     gen_set_access_type(ctx, ACCESS_CACHE);
-    tcgv_addr = tcg_temp_new();
-    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbz(tcg_env, tcgv_addr, tcgv_op);
+
+#ifdef TARGET_PPC64
+    if (ctx->excp_model == POWERPC_EXCP_970 && !(ctx->opcode & 0x00200000)) {
+        gen_helper_dcbzl(tcg_env, tcgv_addr);
+        return;
+    }
+#endif
+
+    gen_helper_dcbz(tcg_env, tcgv_addr);
 }
 
 /* dcbzep */
 static void gen_dcbzep(DisasContext *ctx)
 {
-    TCGv tcgv_addr;
-    TCGv_i32 tcgv_op;
+    TCGv tcgv_addr = tcg_temp_new();
 
     gen_set_access_type(ctx, ACCESS_CACHE);
-    tcgv_addr = tcg_temp_new();
-    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbzep(tcg_env, tcgv_addr, tcgv_op);
+    gen_helper_dcbzep(tcg_env, tcgv_addr);
 }
 
 /* dst / dstt */
@@ -6480,6 +6483,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->hv = (hflags >> HFLAGS_HV) & 1;
     ctx->insns_flags = env->insns_flags;
     ctx->insns_flags2 = env->insns_flags2;
+    ctx->excp_model = env->excp_model;
     ctx->access_type = -1;
     ctx->need_access_type = !mmu_is_64bit(env->mmu_model);
     ctx->le_mode = (hflags >> HFLAGS_LE) & 1;
-- 
2.43.0


