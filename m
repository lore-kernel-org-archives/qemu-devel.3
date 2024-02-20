Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F8CC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 04:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcHbi-0001gF-DZ; Mon, 19 Feb 2024 23:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHbh-0001fz-1i; Mon, 19 Feb 2024 23:19:49 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHbe-0006HU-Tv; Mon, 19 Feb 2024 23:19:48 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-299c5a23f40so783712a91.3; 
 Mon, 19 Feb 2024 20:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708402785; x=1709007585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VI3mZsuAcYBxmb29DQFvybJDPmtONoM1V8I3PUnaIk4=;
 b=FloeIvI4qVhsNGd6Dg+NW6OeEu8pPvxhNE3gj0bqhLUqnzjhzRHsnsL5Zp5lb2GhC+
 G348vICS5h6LuaNE9rsidUgwMeNlbHECufJcI7miStVaP7MyfjTE/YuPedFclc5WwPUg
 49MiIlWhvhZPyP59yceNuNQLxfvoHhGiKSGZcY+LYo9/UFn2K5GLKtYfn3gflQTmeK64
 jRYMKLdyiISWQzzll777/zIj8HHxvKUUMc2hrgq7QEtUwrwT2KytbIC/86VcUyiP2Eej
 x7VP2VjwdGzkKWDatoiewKNDii/HNaw6kIqiCDq2GJMo+43/OZJNxJwYhjhAX375Yw6R
 GMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708402785; x=1709007585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VI3mZsuAcYBxmb29DQFvybJDPmtONoM1V8I3PUnaIk4=;
 b=GZJPnTfRgsf4fhXbr4dCN4haxHvXLgoOOQc4AWx3oDlpYni9//n93Vw96Z4/rh54Dz
 FPcqnA0mCXdV4NlLYYgUJHL16Hmfo19qtdofK54yBXCB6lM/fDug6LEs0ai7w4sOph97
 HtzZ9997hQfJCrCtd2irh7Y/pwLmnFNP1T4AO0UjE2ICL2SHJ2u+khLsmN3I2B8rhajd
 MHC8MgE5Qfxlwz5DXGoa5/qhWb2Rs9+vaN90xTNc3N9oonWYMs3ofsGlT1sz8Kdnw8A8
 zLhKaJ+pOW8iOskLNV+IHU4h7k8dDucFVLcb8zyZaRnGbMRG5ZYW8kYbuv2sONIf1CxZ
 G5SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCpVA7r58hTdDNch2/qQH9u7tMFtAeWJjTBuzrBorJcSBCIR9IA/bjlRRTUt8e3s4GlvdZ5zqmUr5cMPWqw8zRHaca3dE=
X-Gm-Message-State: AOJu0YyUBep99agpg2T9F76DkbhI/axccSIdn2x9Qz4JtLVdg1NgsLbe
 Wf6e1ME0tED/ZF9UFi6OCrvGRmU8HEqeXLEMN4h8+jY5kOWBmjcwCVHlbEPe
X-Google-Smtp-Source: AGHT+IGfgMoTY6FGpctUejyNDl+lPM+ltp5B+xkwCrkpChOXpwQKQM6HMAi72oJnRhFPIPApjLGtvQ==
X-Received: by 2002:a17:90a:7883:b0:298:b08e:ec35 with SMTP id
 x3-20020a17090a788300b00298b08eec35mr9343098pjk.47.1708402780735; 
 Mon, 19 Feb 2024 20:19:40 -0800 (PST)
Received: from wheely.local0.net (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 pl6-20020a17090b268600b00297138f0496sm6232621pjb.31.2024.02.19.20.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 20:19:40 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 3/3] target/ppc: Implement reservation protection for
 larx/stcx
Date: Tue, 20 Feb 2024 14:19:22 +1000
Message-ID: <20240220041922.373029-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220041922.373029-1-npiggin@gmail.com>
References: <20240220041922.373029-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use the generic llsc protection feature to implement real reservation
protection for larx/stcx.

This is more complicated and quite a bit slower than the cmpxchg
pseudo-reservation, so it's questionable whether it should be merged
or ever made the default.

It could possibly be sped up more by tuning heuristics for managing
the dirty bitmap -- being a bit more lazy about that could reduce
the heavyweight bitmap cleaning and dirtying operations.

Not sure if there are other better approaches to this. One thing I
have tried to implement the reservation-granule (i.e., stcx. to
succeed for an address that differs from the one that established
the reservation) is to first fail the stcx. if it detects an
address mismatch, but then set a flag to say try the mismatched
mode next time. Next larx encountered will load and save memory
contents for the entire reservation granule, then stcx. verifies
the granule. This works to some degree with better performance
on code that doesn't behave this way, but it still misses things,
not only ABA but also stores that modify values not subject to the
stcx. on the first pass in case that stcx. address *does* match
larx. So I consider that even more of a hack and not really suitable
for upstream.

At the very least, this seems to have flushed out another bug in
the cpu memory dirty bitmap code, since it hammers it much harder
than typical users and simple test cases can be constructed that
make failures obvious (lost updates, lost mutual exclusion, etc).
so it hasn't been all for nothing even if it is a bad design :)
---
 target/ppc/cpu-param.h  |   4 ++
 target/ppc/helper.h     |   2 +
 target/ppc/cpu_init.c   |   4 ++
 target/ppc/mem_helper.c | 132 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/translate.c  | 128 ++++++++------------------------------
 5 files changed, 168 insertions(+), 102 deletions(-)

diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 0a0416e0a8..355b4e2fdd 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -8,6 +8,10 @@
 #ifndef PPC_CPU_PARAM_H
 #define PPC_CPU_PARAM_H
 
+#ifndef TARGET_HAS_LLSC_PROT /* XXX: hack */
+#define TARGET_HAS_LLSC_PROT 1
+#endif
+
 #ifdef TARGET_PPC64
 # define TARGET_LONG_BITS 64
 /*
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee1e7..e996b9f530 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -818,4 +818,6 @@ DEF_HELPER_4(DSCLI, void, env, fprp, fprp, i32)
 DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
+DEF_HELPER_4(larx, void, env, tl, tl, tl)
+DEF_HELPER_4(stcx, void, env, tl, tl, tl)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9931372a08..5fc14830ab 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6831,6 +6831,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
         goto unrealize;
     }
     init_ppc_proc(cpu);
+    if (tcg_enabled()) {
+        cs->llsc_prot_block_size = env->dcache_line_size;
+        printf("Reservation granule size %d\n", cs->llsc_prot_block_size);
+    }
 
     ppc_gdb_init(cs, pcc);
     qemu_init_vcpu(cs);
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index ea7e8443a8..fe2c7576c8 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -24,11 +24,21 @@
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
+#include "exec/cputlb.h"
 #include "internal.h"
 #include "qemu/atomic128.h"
 
 /* #define DEBUG_OP */
 
+static inline int DEF_MEMOP(const CPUPPCState *env, int op)
+{
+    if (FIELD_EX64(env->msr, MSR, LE)) {
+        return op | MO_LE;
+    } else {
+        return op | MO_BE;
+    }
+}
+
 static inline bool needs_byteswap(const CPUPPCState *env)
 {
 #if TARGET_BIG_ENDIAN
@@ -528,3 +538,125 @@ void helper_tbegin(CPUPPCState *env)
     env->spr[SPR_TFHAR] = env->nip + 4;
     env->crf[0] = 0xB; /* 0b1010 = transaction failure */
 }
+
+void helper_larx(CPUPPCState *env, target_ulong addr, target_ulong size,
+                 target_ulong reg)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t raddr = GETPC();
+    int mmu_idx = cpu_mmu_index(cs, false);
+    uint64_t val;
+    void *host;
+
+    if (addr & (size - 1)) {
+	ppc_cpu_do_unaligned_access(cs, addr, MMU_DATA_LOAD, mmu_idx, raddr);
+    }
+
+    env->access_type = ACCESS_RES;
+    host = probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, raddr);
+    if (host) {
+        cpu_set_llsc_prot(cs, qemu_ram_addr_from_host_nofail(host));
+    } else {
+        /* XXX: fault? */
+        g_assert_not_reached();
+    }
+
+    if (unlikely(size == 16)) {
+        Int128 val16;
+        val16 = cpu_ld16_mmu(env, addr,
+                     make_memop_idx(DEF_MEMOP(env, MO_128 | MO_ALIGN), mmu_idx),
+                     raddr);
+        env->gpr[reg] = int128_gethi(val16);
+        env->gpr[reg + 1] = int128_getlo(val16);
+        return;
+    }
+
+    switch (size) {
+    case 1:
+        val = ldub_p(host);
+        break;
+    case 2:
+        val = FIELD_EX64(env->msr, MSR, LE) ? lduw_le_p(host) : lduw_be_p(host);
+        break;
+    case 4:
+        val = FIELD_EX64(env->msr, MSR, LE) ? ldl_le_p(host) : ldl_be_p(host);
+        break;
+    case 8:
+        val = FIELD_EX64(env->msr, MSR, LE) ? ldq_le_p(host) : ldq_be_p(host);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    env->gpr[reg] = val;
+}
+
+void helper_stcx(CPUPPCState *env, target_ulong addr, target_ulong size,
+                 target_ulong reg)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t raddr = GETPC();
+    int mmu_idx = cpu_mmu_index(cs, false);
+    uint64_t val;
+    void *host;
+    CPUTLBEntryFull *full;
+    int flags;
+
+    if (addr & (size - 1)) {
+	ppc_cpu_do_unaligned_access(cs, addr, MMU_DATA_STORE, mmu_idx, raddr);
+    }
+
+    env->access_type = ACCESS_RES;
+
+again:
+    if (!cpu_resolve_llsc_begin(cs)) {
+        goto fail;
+    }
+
+    flags = probe_access_full(env, addr, size, MMU_DATA_STORE,
+                              mmu_idx, true, &host, &full, raddr);
+    if (unlikely(flags & TLB_INVALID_MASK)) {
+        cpu_resolve_llsc_abort(cs);
+        host = probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, raddr);
+        g_assert(host);
+        goto again;
+    }
+
+    if (!cpu_resolve_llsc_check(cs, qemu_ram_addr_from_host_nofail(host))) {
+        goto fail;
+    }
+
+    if (unlikely(size == 16)) {
+        Int128 val16 = int128_make128(env->gpr[reg + 1], env->gpr[reg]);
+        cpu_st16_mmu(env, addr, val16,
+                    make_memop_idx(DEF_MEMOP(env, MO_128 | MO_ALIGN), mmu_idx),
+                    raddr);
+	goto success;
+    }
+
+    val = env->gpr[reg];
+    switch (size) {
+    case 1:
+        stb_p(host, val);
+        break;
+    case 2:
+        FIELD_EX64(env->msr, MSR, LE) ? stw_le_p(host, val) : stw_be_p(host, val);
+        break;
+    case 4:
+        FIELD_EX64(env->msr, MSR, LE) ? stl_le_p(host, val) : stl_be_p(host, val);
+        break;
+    case 8:
+        FIELD_EX64(env->msr, MSR, LE) ? stq_le_p(host, val) : stq_be_p(host, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+success:
+    cpu_resolve_llsc_success(cs);
+
+    env->crf[0] = xer_so | CRF_EQ; /* stcx pass */
+    return;
+
+fail:
+    env->crf[0] = xer_so; /* stcx fail */
+}
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 049f636927..a2d002eb89 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3570,31 +3570,27 @@ static void gen_isync(DisasContext *ctx)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-#define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))
-
-static void gen_load_locked(DisasContext *ctx, MemOp memop)
+static void gen_load_locked(DisasContext *ctx, int size)
 {
-    TCGv gpr = cpu_gpr[rD(ctx->opcode)];
-    TCGv t0 = tcg_temp_new();
+    int rd = rD(ctx->opcode);
+    TCGv EA = tcg_temp_new();
 
-    gen_set_access_type(ctx, ACCESS_RES);
-    gen_addr_reg_index(ctx, t0);
-    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
-    tcg_gen_mov_tl(cpu_reserve, t0);
-    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
-    tcg_gen_mov_tl(cpu_reserve_val, gpr);
+    gen_addr_reg_index(ctx, EA);
+    gen_helper_larx(tcg_env, EA, tcg_constant_tl(size), tcg_constant_tl(rd));
 }
 
-#define LARX(name, memop)                  \
+#define LARX(name, size)                   \
 static void gen_##name(DisasContext *ctx)  \
 {                                          \
-    gen_load_locked(ctx, memop);           \
+    gen_load_locked(ctx, size);            \
 }
 
 /* lwarx */
-LARX(lbarx, DEF_MEMOP(MO_UB))
-LARX(lharx, DEF_MEMOP(MO_UW))
-LARX(lwarx, DEF_MEMOP(MO_UL))
+LARX(lbarx, 1)
+LARX(lharx, 2)
+LARX(lwarx, 4)
+
+#define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))
 
 static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
                                       TCGv EA, TCGCond cond, int addend)
@@ -3802,59 +3798,36 @@ static void gen_stdat(DisasContext *ctx)
 }
 #endif
 
-static void gen_conditional_store(DisasContext *ctx, MemOp memop)
+static void gen_conditional_store(DisasContext *ctx, int size)
 {
-    TCGLabel *lfail;
-    TCGv EA;
-    TCGv cr0;
-    TCGv t0;
     int rs = rS(ctx->opcode);
+    TCGv EA = tcg_temp_new();
 
-    lfail = gen_new_label();
-    EA = tcg_temp_new();
-    cr0 = tcg_temp_new();
-    t0 = tcg_temp_new();
-
-    tcg_gen_mov_tl(cr0, cpu_so);
-    gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, EA);
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), lfail);
-
-    tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
-                              cpu_gpr[rs], ctx->mem_idx,
-                              DEF_MEMOP(memop) | MO_ALIGN);
-    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
-    tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(cr0, cr0, t0);
-
-    gen_set_label(lfail);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
-    tcg_gen_movi_tl(cpu_reserve, -1);
+    gen_helper_stcx(tcg_env, EA, tcg_constant_tl(size), tcg_constant_tl(rs));
 }
 
-#define STCX(name, memop)                  \
+#define STCX(name, size)                   \
 static void gen_##name(DisasContext *ctx)  \
 {                                          \
-    gen_conditional_store(ctx, memop);     \
+    gen_conditional_store(ctx, size);      \
 }
 
-STCX(stbcx_, DEF_MEMOP(MO_UB))
-STCX(sthcx_, DEF_MEMOP(MO_UW))
-STCX(stwcx_, DEF_MEMOP(MO_UL))
+STCX(stbcx_, 1)
+STCX(sthcx_, 2)
+STCX(stwcx_, 4)
 
 #if defined(TARGET_PPC64)
 /* ldarx */
-LARX(ldarx, DEF_MEMOP(MO_UQ))
+LARX(ldarx, 8)
 /* stdcx. */
-STCX(stdcx_, DEF_MEMOP(MO_UQ))
+STCX(stdcx_, 8)
 
 /* lqarx */
 static void gen_lqarx(DisasContext *ctx)
 {
     int rd = rD(ctx->opcode);
-    TCGv EA, hi, lo;
-    TCGv_i128 t16;
+    TCGv EA;
 
     if (unlikely((rd & 1) || (rd == rA(ctx->opcode)) ||
                  (rd == rB(ctx->opcode)))) {
@@ -3862,74 +3835,25 @@ static void gen_lqarx(DisasContext *ctx)
         return;
     }
 
-    gen_set_access_type(ctx, ACCESS_RES);
     EA = tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
-
-    /* Note that the low part is always in RD+1, even in LE mode.  */
-    lo = cpu_gpr[rd + 1];
-    hi = cpu_gpr[rd];
-
-    t16 = tcg_temp_new_i128();
-    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
-    tcg_gen_extr_i128_i64(lo, hi, t16);
-
-    tcg_gen_mov_tl(cpu_reserve, EA);
-    tcg_gen_movi_tl(cpu_reserve_length, 16);
-    tcg_gen_st_tl(hi, tcg_env, offsetof(CPUPPCState, reserve_val));
-    tcg_gen_st_tl(lo, tcg_env, offsetof(CPUPPCState, reserve_val2));
+    gen_helper_larx(tcg_env, EA, tcg_constant_tl(16), tcg_constant_tl(rd));
 }
 
 /* stqcx. */
 static void gen_stqcx_(DisasContext *ctx)
 {
-    TCGLabel *lfail;
-    TCGv EA, t0, t1;
-    TCGv cr0;
-    TCGv_i128 cmp, val;
     int rs = rS(ctx->opcode);
+    TCGv EA;
 
     if (unlikely(rs & 1)) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
 
-    lfail = gen_new_label();
     EA = tcg_temp_new();
-    cr0 = tcg_temp_new();
-
-    tcg_gen_mov_tl(cr0, cpu_so);
-    gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, EA);
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lfail);
-
-    cmp = tcg_temp_new_i128();
-    val = tcg_temp_new_i128();
-
-    tcg_gen_concat_i64_i128(cmp, cpu_reserve_val2, cpu_reserve_val);
-
-    /* Note that the low part is always in RS+1, even in LE mode.  */
-    tcg_gen_concat_i64_i128(val, cpu_gpr[rs + 1], cpu_gpr[rs]);
-
-    tcg_gen_atomic_cmpxchg_i128(val, cpu_reserve, cmp, val, ctx->mem_idx,
-                                DEF_MEMOP(MO_128 | MO_ALIGN));
-
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    tcg_gen_extr_i128_i64(t1, t0, val);
-
-    tcg_gen_xor_tl(t1, t1, cpu_reserve_val2);
-    tcg_gen_xor_tl(t0, t0, cpu_reserve_val);
-    tcg_gen_or_tl(t0, t0, t1);
-
-    tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, 0);
-    tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(cr0, cr0, t0);
-
-    gen_set_label(lfail);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
-    tcg_gen_movi_tl(cpu_reserve, -1);
+    gen_helper_stcx(tcg_env, EA, tcg_constant_tl(16), tcg_constant_tl(rs));
 }
 #endif /* defined(TARGET_PPC64) */
 
-- 
2.42.0


