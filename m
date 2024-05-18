Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8625DC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQz-0006id-4i; Sat, 18 May 2024 05:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQw-0006eJ-Ap; Sat, 18 May 2024 05:32:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQu-00061i-JL; Sat, 18 May 2024 05:32:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1eb24e3a2d9so36213225ad.1; 
 Sat, 18 May 2024 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024770; x=1716629570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8QF/oLC6NmyofkxjWqVCUa8PVY6JxCh60BGtrwFLcw=;
 b=WCeajGZvR9aZm1Vwx7ytV9j6EMRoOZJNK3eUaeRn97MZZoNkCD9IxjMZ5OdOTUtzl/
 PcF5ovDBr6M7zjhFPV89vbLfsIZojCBH6G/687G+dCRxxEENAf7Dp7XdUlOu7p8Aanm4
 N+SyGL3Z+pt8W56a3NIfFZRtWpWIm/rFelOgu4+mxKGPIIaI0TtXT00Jr+RBidtVvRGO
 WR5X3QuzoEeyS54/SnJss9gcLFoX5mNARk7hJIsGrdv4ewlsTFP0D1qml79RXiTUZGJ9
 oabjS61wq/be0jbhTct1vi2d+RX1p4LbYoXYk13YctnyYBYGYyObLzm0lao911IikwX/
 QbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024770; x=1716629570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8QF/oLC6NmyofkxjWqVCUa8PVY6JxCh60BGtrwFLcw=;
 b=KOUXRKEera9fJq9VwfMncN+lsHQPU7KAk7VtTpObjhVoRaAOs+Biavff5B9EM7G95M
 z+p0t9FUwMOdcsfy+OE750myk6LGSyBV2hnNqaBc0VBzEEbodY7xi6MLuiabkBAYUYxr
 VfCq0lhcrjMYLT1tBXQ9pnZNibJiiGZJ5xNkdL5vCf10ukU4QSMT1wu7ewHz0tpIOuq1
 2Y93e/z0buajpJABza+7EY5CSNVG+4awkGwMrVA3fkPPeBweSwFSaWW3lBdCSkq/TBs7
 Dt9hbW8/rskqxhTk3pfPPJGbEASJ2mf3lod2tGojDl2vgj/l/XTFWQ4iCv88/28e47eH
 rg+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfukoICUX0xV9Jjqu+oZ/kI0wXDwl3FfRzDwR78cO6uMYX48RpJ+Xjk0mD+GmBvaJjbhkZf9Y99hvqQFGcgf+H5n9ZZUU=
X-Gm-Message-State: AOJu0Yw89ZIhsSVKzMtDwtLKEaJS2A03jQtzHIaASA7lQFzixRYg0s9i
 dB+UVZrIr6Q5mhGxH/enSAm07vZI8vq+raLbqbcWQ26CM4GylTRL8P60cg==
X-Google-Smtp-Source: AGHT+IG5YMaSmejSbroAdU8Ten3CleojMt9+rpa+dp/t3YK6haE8xDd9pwFOPW1kl+FERYfo+SAMAQ==
X-Received: by 2002:a17:90a:f983:b0:2b3:28be:ede3 with SMTP id
 98e67ed59e1d1-2b6cd1e4f2amr21380473a91.47.1716024770376; 
 Sat, 18 May 2024 02:32:50 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 13/14] target/ppc: Implement SPRC/SPRD SPRs
Date: Sat, 18 May 2024 19:31:55 +1000
Message-ID: <20240518093157.407144-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This implements the POWER SPRC/SPRD SPRs, and SCRATCH0-7 registers that
can be accessed via these indirect SPRs.

SCRATCH registers only provide storage, but they are used by firmware
for low level crash and progress data, so this implementation logs
writes to the registers to help with analysis.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |  7 +++--
 target/ppc/helper.h      |  3 ++
 target/ppc/spr_common.h  |  3 ++
 target/ppc/cpu_init.c    | 10 ++++++
 target/ppc/misc_helper.c | 66 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/translate.c   | 18 +++++++++++
 6 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a014efc23a..8e15a9ccbb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1264,6 +1264,9 @@ struct CPUArchState {
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
     struct CPUWatchpoint *dawr0_watchpoint;
+
+    /* POWER CPU regs/state */
+    target_ulong scratch[8]; /* SCRATCH registers (shared across core) */
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
@@ -1806,9 +1809,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_SPRG2             (0x112)
 #define SPR_SPRG3             (0x113)
 #define SPR_SPRG4             (0x114)
-#define SPR_SCOMC             (0x114)
+#define SPR_POWER_SPRC        (0x114)
 #define SPR_SPRG5             (0x115)
-#define SPR_SCOMD             (0x115)
+#define SPR_POWER_SPRD        (0x115)
 #define SPR_SPRG6             (0x116)
 #define SPR_SPRG7             (0x117)
 #define SPR_ASR               (0x118)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 09d50f9b76..57bf8354e7 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -730,6 +730,9 @@ DEF_HELPER_2(book3s_msgsndp, void, env, tl)
 DEF_HELPER_2(book3s_msgclrp, void, env, tl)
 DEF_HELPER_1(load_tfmr, tl, env)
 DEF_HELPER_2(store_tfmr, void, env, tl)
+DEF_HELPER_FLAGS_2(store_sprc, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_1(load_sprd, TCG_CALL_NO_RWG_SE, tl, env)
+DEF_HELPER_FLAGS_2(store_sprd, TCG_CALL_NO_RWG, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 85f73b860b..01aff449bc 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -207,6 +207,9 @@ void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
 void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
+void spr_write_sprc(DisasContext *ctx, int sprn, int gprn);
+void spr_read_sprd(DisasContext *ctx, int sprn, int gprn);
+void spr_write_sprd(DisasContext *ctx, int sprn, int gprn);
 #endif
 
 void register_low_BATs(CPUPPCState *env);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 4591a68cc5..0c1837fe76 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5794,6 +5794,16 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
+    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_sprc,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_sprd, &spr_write_sprd,
+                 0x00000000);
 #endif
 }
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a67930d031..fa47be2298 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -307,6 +307,72 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
     }
     bql_unlock();
 }
+
+/* Indirect SCOM (SPRC/SPRD) access to SCRATCH0-7 are implemented. */
+void helper_store_sprc(CPUPPCState *env, target_ulong val)
+{
+    if (val & ~0x3f8ULL) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid SPRC register value "
+                      TARGET_FMT_lx"\n", val);
+        return;
+    }
+    env->spr[SPR_POWER_SPRC] = val;
+}
+
+target_ulong helper_load_sprd(CPUPPCState *env)
+{
+    target_ulong sprc = env->spr[SPR_POWER_SPRC];
+
+    switch (sprc & 0x3c0) {
+    case 0: /* SCRATCH0-7 */
+        return env->scratch[(sprc >> 3) & 0x7];
+    default:
+        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+    return 0;
+}
+
+static void do_store_scratch(CPUPPCState *env, int nr, target_ulong val)
+{
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    /*
+     * Log stores to SCRATCH, because some firmware uses these for debugging
+     * and logging, but they would normally be read by the BMC, which is
+     * not implemented in QEMU yet. This gives a way to get at the information.
+     * Could also dump these upon checkstop.
+     */
+    qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
+
+    if (nr_threads == 1) {
+        env->scratch[nr] = val;
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cenv->scratch[nr] = val;
+    }
+}
+
+void helper_store_sprd(CPUPPCState *env, target_ulong val)
+{
+    target_ulong sprc = env->spr[SPR_POWER_SPRC];
+
+    switch (sprc & 0x3c0) {
+    case 0: /* SCRATCH0-7 */
+        do_store_scratch(env, (sprc >> 3) & 0x7, val);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+}
 #endif /* defined(TARGET_PPC64) */
 
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 60a7afb086..8e944c4416 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1363,6 +1363,24 @@ void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_tfmr(tcg_env, cpu_gpr[gprn]);
 }
 
+void spr_write_sprc(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_sprc(tcg_env, cpu_gpr[gprn]);
+}
+
+void spr_read_sprd(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_helper_load_sprd(cpu_gpr[gprn], tcg_env);
+}
+
+void spr_write_sprd(DisasContext *ctx, int sprn, int gprn)
+{
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+    gen_helper_store_sprd(tcg_env, cpu_gpr[gprn]);
+}
+
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
-- 
2.43.0


