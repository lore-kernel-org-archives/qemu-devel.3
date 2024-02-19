Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF8CC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5X-0008RA-B3; Mon, 19 Feb 2024 03:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5R-0007kQ-VY; Mon, 19 Feb 2024 03:33:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5N-0002jK-Jd; Mon, 19 Feb 2024 03:33:17 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d944e8f367so33568795ad.0; 
 Mon, 19 Feb 2024 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331588; x=1708936388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cj2GXCYeb41VUqeJDMhLER/F3DyOo9GZz37Ujh30ois=;
 b=nDce5jbzf/361UNViCV/ZKZO6f9ayJATvkGzstYS1QRz3C/lrgnJyhbRd3OBfnUVM5
 zXN3VFhaliBBsKLCseBQzNGak0b1PvV+fFYPtXX3ABSfUcyMzuJ7hwbjIjDkMbp8amjn
 UqXf1THV5hPPJEF5U+h09tvymnEZfS9VIrI3OHKV5Taho2X8+cJDMDv9sa4NErQx6HkH
 v6FG7Lk/9TM8kl3GqUcEH7ISD6A4tBErrtHl/stto/RhM6RW12QNceGKQ3ByBF2y5TIj
 atM3iq+8cx0Tn1dQpk7Rdsele8UFArl5GbmZ/JQogYADyzje0hiU+fsAyqpphEwoV3a5
 JgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331588; x=1708936388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cj2GXCYeb41VUqeJDMhLER/F3DyOo9GZz37Ujh30ois=;
 b=MXPG+FPZskBRi1okiFQNbNx6BU9lpe1sRQT0wbOV6cO3YBJNiSf6ULzzsZjhYHcp2T
 R4T11K5ZL/oqNpZuMiqZV3neUYUFAXNiC9X7oi+T0G9ZrtlBIryDGYalv0/2ZcL/7BwA
 pCC+YjY/fWxQUaxg9DMI92qHdPDYgFOuQbLurcJL7NUrw8h3OAz+2FBoKsYCviDnrZ4J
 r7kW+A9H+9IqUoT/a8ZrW4h3ubEOSKjSk01s1oNQ0jTty14fac25weEZGDIMu3CwhDtw
 Vb6ROmS9cQgJMpbtC8IW4Td4juVdZKEBnTYaJSKLIzfQ1difjt+5aa81cL3rMpY0YVY1
 WSPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnm9Jk/ppoZmUHoUyfwUq6qT5x1dvZTGNvvnWqxw/519aeBVvzVGlsPka182JW1+X6CCHgFFvlmP/mBe5cKsRUrZqA
X-Gm-Message-State: AOJu0Yx2/qxtnA8pNCQ+aGM85SxiCnZdBKagT2zLfN9De2sGVSz0UY+N
 50h8Uo/uREY+3Jxv8M705p78118VDrRWBn1PwxtpHgTVQN+b22pbDaNp8T51
X-Google-Smtp-Source: AGHT+IEkWhm7x2OKSjwxpI+6yHkV9a1LBNf83u7E5xoTqgn9QHtEh/j0E6Y885HGCpc6O+s/yNzJwg==
X-Received: by 2002:a17:902:ea0e:b0:1db:f371:dca3 with SMTP id
 s14-20020a170902ea0e00b001dbf371dca3mr1809726plg.48.1708331587886; 
 Mon, 19 Feb 2024 00:33:07 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:33:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 43/49] target/ppc: Add SMT support to time facilities
Date: Mon, 19 Feb 2024 18:29:32 +1000
Message-ID: <20240219082938.238302-44-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

The TB, VTB, PURR, HDEC SPRs are per-LPAR registers, and the TFMR is a
per-core register. Add the necessary SMT synchronisation and value
sharing.

The TFMR can only drive the timebase state machine via thread 0 of the
core, which is almost certainly not right, but it is enough for skiboot
and certain other proprietary firmware.

Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/timebase_helper.c | 105 ++++++++++++++++++++++++++++++++---
 target/ppc/translate.c       |  42 +++++++++++++-
 2 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index b8b9afe0b6..39d397416e 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -60,19 +60,55 @@ target_ulong helper_load_purr(CPUPPCState *env)
 
 void helper_store_purr(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_purr(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_purr(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_purr(cenv, val);
+    }
 }
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
 void helper_store_tbl(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_tbl(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_tbl(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_tbl(cenv, val);
+    }
 }
 
 void helper_store_tbu(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_tbu(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_tbu(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_tbu(cenv, val);
+    }
 }
 
 void helper_store_atbl(CPUPPCState *env, target_ulong val)
@@ -102,17 +138,53 @@ target_ulong helper_load_hdecr(CPUPPCState *env)
 
 void helper_store_hdecr(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_hdecr(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_hdecr(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_hdecr(cenv, val);
+    }
 }
 
 void helper_store_vtb(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_vtb(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_vtb(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_vtb(cenv, val);
+    }
 }
 
 void helper_store_tbu40(CPUPPCState *env, target_ulong val)
 {
-    cpu_ppc_store_tbu40(env, val);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (nr_threads == 1 || !(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        cpu_ppc_store_tbu40(env, val);
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cpu_ppc_store_tbu40(cenv, val);
+    }
 }
 
 target_ulong helper_load_40x_pit(CPUPPCState *env)
@@ -211,6 +283,21 @@ static uint64_t tfmr_new_tb_state(uint64_t tfmr, unsigned int tbst)
     return tfmr;
 }
 
+static void write_tfmr(CPUPPCState *env, target_ulong val)
+{
+    CPUState *cs = env_cpu(env);
+
+    if (cs->nr_threads == 1) {
+        env->spr[SPR_TFMR] = val;
+    } else {
+        CPUState *ccs;
+        THREAD_SIBLING_FOREACH(cs, ccs) {
+            CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+            cenv->spr[SPR_TFMR] = val;
+        }
+    }
+}
+
 static void tb_state_machine_step(CPUPPCState *env)
 {
     uint64_t tfmr = env->spr[SPR_TFMR];
@@ -224,7 +311,7 @@ static void tb_state_machine_step(CPUPPCState *env)
         env->pnv_tod_tbst.tb_sync_pulse_timer--;
     } else {
         tfmr |= TFMR_TB_SYNC_OCCURED;
-        env->spr[SPR_TFMR] = tfmr;
+        write_tfmr(env, tfmr);
     }
 
     if (env->pnv_tod_tbst.tb_state_timer) {
@@ -262,7 +349,7 @@ static void tb_state_machine_step(CPUPPCState *env)
         }
     }
 
-    env->spr[SPR_TFMR] = tfmr;
+    write_tfmr(env, tfmr);
 }
 
 target_ulong helper_load_tfmr(CPUPPCState *env)
@@ -357,7 +444,7 @@ void helper_store_tfmr(CPUPPCState *env, target_ulong val)
     }
 
 out:
-    env->spr[SPR_TFMR] = tfmr;
+    write_tfmr(env, tfmr);
 }
 #endif
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 049f636927..28fc7791af 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -247,13 +247,24 @@ static inline bool gen_serialize(DisasContext *ctx)
     return true;
 }
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64)
+static inline bool gen_serialize_core(DisasContext *ctx)
+{
+    if (ctx->flags & POWERPC_FLAG_SMT) {
+        return gen_serialize(ctx);
+    }
+    return true;
+}
+#endif
+
 static inline bool gen_serialize_core_lpar(DisasContext *ctx)
 {
+#if defined(TARGET_PPC64)
     if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
         return gen_serialize(ctx);
     }
-
+#endif
     return true;
 }
 #endif
@@ -667,12 +678,20 @@ void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
 #if !defined(CONFIG_USER_ONLY)
 void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
+
     translator_io_start(&ctx->base);
     gen_helper_store_tbl(tcg_env, cpu_gpr[gprn]);
 }
 
 void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
+
     translator_io_start(&ctx->base);
     gen_helper_store_tbu(tcg_env, cpu_gpr[gprn]);
 }
@@ -696,6 +715,9 @@ void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 
 void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
     translator_io_start(&ctx->base);
     gen_helper_store_purr(tcg_env, cpu_gpr[gprn]);
 }
@@ -709,6 +731,9 @@ void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 
 void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
     translator_io_start(&ctx->base);
     gen_helper_store_hdecr(tcg_env, cpu_gpr[gprn]);
 }
@@ -721,12 +746,18 @@ void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
 
 void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
     translator_io_start(&ctx->base);
     gen_helper_store_vtb(tcg_env, cpu_gpr[gprn]);
 }
 
 void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core_lpar(ctx)) {
+        return;
+    }
     translator_io_start(&ctx->base);
     gen_helper_store_tbu40(tcg_env, cpu_gpr[gprn]);
 }
@@ -1220,11 +1251,18 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
 
 void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn)
 {
+    /* Reading TFMR can cause it to be updated, so serialize threads here too */
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
     gen_helper_load_tfmr(cpu_gpr[gprn], tcg_env);
 }
 
 void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
     gen_helper_store_tfmr(tcg_env, cpu_gpr[gprn]);
 }
 
-- 
2.42.0


