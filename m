Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0A0D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoh-00070F-92; Tue, 13 Jan 2026 23:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoY-0006uj-S1
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:04 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoW-00049I-5h
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:02 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-29f30233d8aso54326605ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366139; x=1768970939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pI2YqBsnmZnjxYYwvL4iB2ONG36VVpDA3n68JruGryM=;
 b=abRdofVmVKXKlOAH+H3rddHi0+R2+ro2Z/8BJPrtWD205NIixLio/3L8IIGwhCV5/w
 2Sba4UXqKF2AS7GoPSIBm23zOV+ENN/BphHhUJUt98m2XE4rmvdZMVVd2/TDc65rAg1C
 WZpKv45vgOeyxQBUzhdOm64nrW4yOlgNbsFaW++3DB4n1YEJ1JIGI0Ns0yJCQAmoq452
 vBXSD3c1aag0lyKDHYSXNqPsoWLe7BtdkEaZm0yxXETeVNr5QLzg+8cKDsfZcKwXHPCe
 Y1HS7ei/eKtaNGqB+xGHUtgMHmdlIOCoN7oMMpjsG+K5AeMtWasQgcnI0GHVUrT6iHls
 GtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366139; x=1768970939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pI2YqBsnmZnjxYYwvL4iB2ONG36VVpDA3n68JruGryM=;
 b=gHbalBOeXaSUJbtI2Dt/5iIpLBLJdIIGGMn8LMWgvpMPZbg3MWEmUUDM7bXrGYZaeQ
 7aYzn0FfINlminwuQfn+5tx/J+P9Lz3xV11zy8NI5EJbEIJUv6Ps59ObgLViHO2ry4Cy
 b/MWJRH0tTzPept2sMnZRc0vr3kj6IPXzbUljeHvIpMaPCqPddRLL8mnrGKrWhWX8gP4
 +gWKp8WF3ZCP26ZpzWnrwO9qyWRfyJRdKkIaR94+VOSju8DFDPUszvVXPa0X2HESLYlK
 dDdWnzNY4bdwIFRlPnOmvKdldrKtNBvBQqIvmljkuDP177GnYXsTtLT8e5I16bVFQLDs
 xvzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrzMfR+qDwnqYcOXGcJKvgDeOIyD7I7Xhz/8QGMIN+xcbrLqREmsvVuK8nGAQ3vrpOYDx2otreBinJ@nongnu.org
X-Gm-Message-State: AOJu0YwsshWhT+PUPisT/+Ms7eSFasqQpp9zow4GaaHwDEFbhhBVb8+R
 w67Jiviq6aIYBB/OlKL0yJT4BTTYeY1ThW3CbsaF6oRAxRI1P0NUSdPW
X-Gm-Gg: AY/fxX4toCA+rK65+vx1Ujs4CfjabKlnUkgn36n3Qfd392TbEs8ypthcmMVIg1B15cl
 FeWvPbcDMonSAl6didmlPlze4EmKkqC5NonLAfIeUInJZ4mdt2d08wDe2ptazYIYbGewJIVdEa3
 ZE4I4tmTVddnmZTnZtbf6VRO53qA5z50mY+JTjX9cr7xajdoI8nGQCJLPN8DBfxFh1y5u94Xhph
 bmuKB1sArkiJV8WsUkCGlO8TS1Pw4TizcrHhyk4BQhwJH/YWYubapQDLDMi3war074Qzgo3RLkL
 kx3Cwse8S69IWSe/x1mSVsL4et0VAcTAXsqDHSHUKjjhQr7WzhNcXKieK/bdVz+mE1fxk6k9DqE
 DzpQovcfsxkwezuOKi0sh4UGAGtElbOriMjq9XvvcDvGrtmFvHCt0tmxj9rLEbt5a/xpwKVnGIf
 3WOUlO/zWRC7i0ihyXeeqrGgbAsFCwvVm8gtr1RpL24IbLqItnU2iklkxERvs=
X-Received: by 2002:a17:902:f70f:b0:2a0:ccdb:218d with SMTP id
 d9443c01a7336-2a599db93aamr14773215ad.17.1768366138837; 
 Tue, 13 Jan 2026 20:48:58 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 19/25] target/riscv/debug: Add new debug state format
Date: Wed, 14 Jan 2026 14:46:52 +1000
Message-ID: <20260114044701.1173347-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Some Sdtrig implementations support more than 2 debug triggers,
but the Sdtrig vmstate is tied to 2 triggers. Extending this will
be a compatibility issue anyway, so move to a nicer layout and
provide state for all 32 architecturally possible triggers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/cpu.h         |  35 ++++++--
 target/riscv/csr.c         |   7 +-
 target/riscv/debug.c       | 167 +++++++++++++++++++++----------------
 target/riscv/debug.h       |   3 +-
 target/riscv/machine.c     |  31 ++++++-
 target/riscv/tcg/tcg-cpu.c |   3 +-
 6 files changed, 157 insertions(+), 89 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a718287d41..44ed1665e2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -194,6 +194,28 @@ FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, VEDIV, 8, 2)
 FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
 
+#ifndef CONFIG_USER_ONLY
+typedef struct SdtrigTrigger {
+    target_ulong tdata1;
+    target_ulong tdata2;
+    target_ulong tdata3;
+} SdtrigTrigger;
+
+typedef struct SdtrigState {
+    /* Architected state */
+    target_ulong trigger_cur; /* tselect */
+    SdtrigTrigger triggers[RV_MAX_SDTRIG_TRIGGERS];
+    target_ulong tcontrol;
+    target_ulong mcontext; /* hcontext */
+    target_ulong scontext;
+
+    /* QEMU state */
+    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_SDTRIG_TRIGGERS];
+    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_SDTRIG_TRIGGERS];
+    bool itrigger_enabled;
+} SdtrigState;
+#endif
+
 typedef struct PMUCTRState {
     /* Current value of a counter */
     uint64_t mhpmcounter_val;
@@ -443,14 +465,11 @@ struct CPUArchState {
     target_ulong mseccfg;
 
     /* trigger module */
-    target_ulong trigger_cur;
-    target_ulong tdata1[RV_MAX_TRIGGERS];
-    target_ulong tdata2[RV_MAX_TRIGGERS];
-    target_ulong tdata3[RV_MAX_TRIGGERS];
-    target_ulong mcontext;
-    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
-    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
-    bool itrigger_enabled;
+    SdtrigState sdtrig_state;
+    /* migration compat */
+    target_ulong old_tdata1[RV_DEFAULT_TRIGGERS];
+    target_ulong old_tdata2[RV_DEFAULT_TRIGGERS];
+    target_ulong old_tdata3[RV_DEFAULT_TRIGGERS];
 
     /* machine specific rdtime callback */
     uint64_t (*rdtime_fn)(void *);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 05c7ec8352..ec70a47d0b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5311,7 +5311,8 @@ static RISCVException read_tdata(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     /* return 0 in tdata1 to end the trigger enumeration */
-    if (env->trigger_cur >= RV_MAX_TRIGGERS && csrno == CSR_TDATA1) {
+    if (env->sdtrig_state.trigger_cur >= RV_MAX_SDTRIG_TRIGGERS &&
+        csrno == CSR_TDATA1) {
         *val = 0;
         return RISCV_EXCP_NONE;
     }
@@ -5345,7 +5346,7 @@ static RISCVException read_tinfo(CPURISCVState *env, int csrno,
 static RISCVException read_mcontext(CPURISCVState *env, int csrno,
                                     target_ulong *val)
 {
-    *val = env->mcontext;
+    *val = env->sdtrig_state.mcontext;
     return RISCV_EXCP_NONE;
 }
 
@@ -5363,7 +5364,7 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
         mask = rv32 ? MCONTEXT32 : MCONTEXT64;
     }
 
-    env->mcontext = val & mask;
+    env->sdtrig_state.mcontext = val & mask;
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 96b00193e2..22f7958a79 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -90,13 +90,15 @@ static inline target_ulong extract_trigger_type(CPURISCVState *env,
 static inline target_ulong get_trigger_type(CPURISCVState *env,
                                             target_ulong trigger_index)
 {
-    return extract_trigger_type(env, env->tdata1[trigger_index]);
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[trigger_index];
+    return extract_trigger_type(env, trigger->tdata1);
 }
 
 static trigger_action_t get_trigger_action(CPURISCVState *env,
                                            target_ulong trigger_index)
 {
-    target_ulong tdata1 = env->tdata1[trigger_index];
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[trigger_index];
+    target_ulong tdata1 = trigger->tdata1;
     int trigger_type = get_trigger_type(env, trigger_index);
     trigger_action_t action = DBG_ACTION_NONE;
 
@@ -155,7 +157,7 @@ static inline target_ulong build_tdata1(CPURISCVState *env,
 
 bool tdata_available(CPURISCVState *env, int tdata_index)
 {
-    int trigger_type = get_trigger_type(env, env->trigger_cur);
+    int trigger_type = get_trigger_type(env, env->sdtrig_state.trigger_cur);
 
     if (unlikely(tdata_index >= TDATA_NUM)) {
         return false;
@@ -166,13 +168,13 @@ bool tdata_available(CPURISCVState *env, int tdata_index)
 
 target_ulong tselect_csr_read(CPURISCVState *env)
 {
-    return env->trigger_cur;
+    return env->sdtrig_state.trigger_cur;
 }
 
 void tselect_csr_write(CPURISCVState *env, target_ulong val)
 {
-    if (val < RV_MAX_TRIGGERS) {
-        env->trigger_cur = val;
+    if (val < RV_DEFAULT_TRIGGERS) {
+        env->sdtrig_state.trigger_cur = val;
     }
 }
 
@@ -342,7 +344,8 @@ static bool icount_priv_match(CPURISCVState *env, target_ulong tdata1)
 static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
                                int trigger_index)
 {
-    target_ulong tdata1 = env->tdata1[trigger_index];
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[trigger_index];
+    target_ulong tdata1 = trigger->tdata1;
 
     switch (type) {
     case TRIGGER_TYPE_AD_MATCH:
@@ -371,7 +374,8 @@ static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
 static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
                                  int trigger_index)
 {
-    target_ulong textra = env->tdata3[trigger_index];
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[trigger_index];
+    target_ulong textra = trigger->tdata3;
     target_ulong mhvalue, mhselect;
 
     if (type < TRIGGER_TYPE_AD_MATCH || type > TRIGGER_TYPE_AD_MATCH6) {
@@ -399,7 +403,7 @@ static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
         break;
     case MHSELECT_MCONTEXT:
         /* Match if the low bits of mcontext/hcontext equal mhvalue. */
-        if (mhvalue != env->mcontext) {
+        if (mhvalue != env->sdtrig_state.mcontext) {
             return false;
         }
         break;
@@ -477,8 +481,9 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
 
 static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
 {
-    target_ulong ctrl = env->tdata1[index];
-    target_ulong addr = env->tdata2[index];
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
+    target_ulong ctrl = trigger->tdata1;
+    target_ulong addr = trigger->tdata2;
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
@@ -489,7 +494,8 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     }
 
     if (ctrl & TYPE2_EXEC) {
-        cpu_breakpoint_insert(cs, addr, flags, &env->cpu_breakpoint[index]);
+        cpu_breakpoint_insert(cs, addr, flags,
+                              &env->sdtrig_state.cpu_breakpoint[index]);
     }
 
     if (ctrl & TYPE2_LOAD) {
@@ -503,12 +509,12 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
         size = type2_breakpoint_size(env, ctrl);
         if (size != 0) {
             cpu_watchpoint_insert(cs, addr, size, flags,
-                                  &env->cpu_watchpoint[index]);
+                                  &env->sdtrig_state.cpu_watchpoint[index]);
         } else {
             def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
 
             cpu_watchpoint_insert(cs, addr, def_size, flags,
-                                  &env->cpu_watchpoint[index]);
+                                  &env->sdtrig_state.cpu_watchpoint[index]);
         }
     }
 }
@@ -517,29 +523,32 @@ static void type2_breakpoint_remove(CPURISCVState *env, target_ulong index)
 {
     CPUState *cs = env_cpu(env);
 
-    if (env->cpu_breakpoint[index]) {
-        cpu_breakpoint_remove_by_ref(cs, env->cpu_breakpoint[index]);
-        env->cpu_breakpoint[index] = NULL;
+    if (env->sdtrig_state.cpu_breakpoint[index]) {
+        cpu_breakpoint_remove_by_ref(cs,
+                                     env->sdtrig_state.cpu_breakpoint[index]);
+        env->sdtrig_state.cpu_breakpoint[index] = NULL;
     }
 
-    if (env->cpu_watchpoint[index]) {
-        cpu_watchpoint_remove_by_ref(cs, env->cpu_watchpoint[index]);
-        env->cpu_watchpoint[index] = NULL;
+    if (env->sdtrig_state.cpu_watchpoint[index]) {
+        cpu_watchpoint_remove_by_ref(cs,
+                                     env->sdtrig_state.cpu_watchpoint[index]);
+        env->sdtrig_state.cpu_watchpoint[index] = NULL;
     }
 }
 
 static void type2_reg_write(CPURISCVState *env, target_ulong index,
                             int tdata_index, target_ulong val)
 {
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
     switch (tdata_index) {
     case TDATA1:
-        env->tdata1[index] = type2_mcontrol_validate(env, val);
+        trigger->tdata1 = type2_mcontrol_validate(env, val);
         break;
     case TDATA2:
-        env->tdata2[index] = val;
+        trigger->tdata2 = val;
         break;
     case TDATA3:
-        env->tdata3[index] = textra_validate(env, val);
+        trigger->tdata3 = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -593,8 +602,9 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
 
 static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
 {
-    target_ulong ctrl = env->tdata1[index];
-    target_ulong addr = env->tdata2[index];
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
+    target_ulong ctrl = trigger->tdata1;
+    target_ulong addr = trigger->tdata2;
     bool enabled = type6_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
@@ -605,7 +615,8 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
     }
 
     if (ctrl & TYPE6_EXEC) {
-        cpu_breakpoint_insert(cs, addr, flags, &env->cpu_breakpoint[index]);
+        cpu_breakpoint_insert(cs, addr, flags,
+                              &env->sdtrig_state.cpu_breakpoint[index]);
     }
 
     if (ctrl & TYPE6_LOAD) {
@@ -620,10 +631,10 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
         size = extract32(ctrl, 16, 4);
         if (size != 0) {
             cpu_watchpoint_insert(cs, addr, size, flags,
-                                  &env->cpu_watchpoint[index]);
+                                  &env->sdtrig_state.cpu_watchpoint[index]);
         } else {
             cpu_watchpoint_insert(cs, addr, 8, flags,
-                                  &env->cpu_watchpoint[index]);
+                                  &env->sdtrig_state.cpu_watchpoint[index]);
         }
     }
 }
@@ -636,15 +647,16 @@ static void type6_breakpoint_remove(CPURISCVState *env, target_ulong index)
 static void type6_reg_write(CPURISCVState *env, target_ulong index,
                             int tdata_index, target_ulong val)
 {
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
     switch (tdata_index) {
     case TDATA1:
-        env->tdata1[index] = type6_mcontrol6_validate(env, val);
+        trigger->tdata1 = type6_mcontrol6_validate(env, val);
         break;
     case TDATA2:
-        env->tdata2[index] = val;
+        trigger->tdata2 = val;
         break;
     case TDATA3:
-        env->tdata3[index] = textra_validate(env, val);
+        trigger->tdata3 = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -656,21 +668,22 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
 static inline int
 itrigger_get_count(CPURISCVState *env, int index)
 {
-    return get_field(env->tdata1[index], ITRIGGER_COUNT);
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
+    return get_field(trigger->tdata1, ITRIGGER_COUNT);
 }
 
 static inline void
 itrigger_set_count(CPURISCVState *env, int index, int value)
 {
-    env->tdata1[index] = set_field(env->tdata1[index],
-                                   ITRIGGER_COUNT, value);
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
+    trigger->tdata1 = set_field(trigger->tdata1, ITRIGGER_COUNT, value);
 }
 
 static bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
 
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < RV_MAX_SDTRIG_TRIGGERS; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -697,9 +710,9 @@ void helper_itrigger_match(CPURISCVState *env)
     int count;
     bool enabled = false;
 
-    g_assert(env->itrigger_enabled);
+    g_assert(env->sdtrig_state.itrigger_enabled);
 
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < RV_MAX_SDTRIG_TRIGGERS; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -719,7 +732,7 @@ void helper_itrigger_match(CPURISCVState *env)
             enabled = true;
         }
     }
-    env->itrigger_enabled = enabled;
+    env->sdtrig_state.itrigger_enabled = enabled;
 }
 
 static target_ulong itrigger_validate(CPURISCVState *env,
@@ -745,16 +758,17 @@ static target_ulong itrigger_validate(CPURISCVState *env,
 static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
                                int tdata_index, target_ulong val)
 {
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
     switch (tdata_index) {
     case TDATA1:
-        env->tdata1[index] = itrigger_validate(env, val);
+        trigger->tdata1 = itrigger_validate(env, val);
         break;
     case TDATA2:
         qemu_log_mask(LOG_UNIMP,
                       "tdata2 is not supported for icount trigger\n");
         break;
     case TDATA3:
-        env->tdata3[index] = textra_validate(env, val);
+        trigger->tdata3 = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -764,19 +778,21 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
 static void anytype_reg_write(CPURISCVState *env, target_ulong index,
                               int tdata_index, target_ulong val)
 {
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
+
     /*
      * This should check the value is valid for at least one of the supported
      * trigger types.
      */
     switch (tdata_index) {
     case TDATA1:
-        env->tdata1[env->trigger_cur] = val;
+        trigger->tdata1 = val;
         break;
     case TDATA2:
-        env->tdata2[env->trigger_cur] = val;
+        trigger->tdata2 = val;
         break;
     case TDATA3:
-        env->tdata3[env->trigger_cur] = val;
+        trigger->tdata3 = val;
         break;
     default:
         g_assert_not_reached();
@@ -785,13 +801,16 @@ static void anytype_reg_write(CPURISCVState *env, target_ulong index,
 
 target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
 {
+    target_ulong index = env->sdtrig_state.trigger_cur;
+    SdtrigTrigger *trigger = &env->sdtrig_state.triggers[index];
+
     switch (tdata_index) {
     case TDATA1:
-        return env->tdata1[env->trigger_cur];
+        return trigger->tdata1;
     case TDATA2:
-        return env->tdata2[env->trigger_cur];
+        return trigger->tdata2;
     case TDATA3:
-        return env->tdata3[env->trigger_cur];
+        return trigger->tdata3;
     default:
         g_assert_not_reached();
     }
@@ -799,15 +818,16 @@ target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
 
 void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 {
-    int trigger_type = get_trigger_type(env, env->trigger_cur);
+    target_ulong index = env->sdtrig_state.trigger_cur;
+    int trigger_type = get_trigger_type(env, index);
     bool check_itrigger = false;
 
     switch (trigger_type) {
     case TRIGGER_TYPE_AD_MATCH:
-        type2_breakpoint_remove(env, env->trigger_cur);
+        type2_breakpoint_remove(env, index);
         break;
     case TRIGGER_TYPE_AD_MATCH6:
-        type6_breakpoint_remove(env, env->trigger_cur);
+        type6_breakpoint_remove(env, index);
         break;
     case TRIGGER_TYPE_INST_CNT:
         /*
@@ -831,17 +851,17 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 
     switch (trigger_type) {
     case TRIGGER_TYPE_AD_MATCH:
-        type2_reg_write(env, env->trigger_cur, tdata_index, val);
+        type2_reg_write(env, index, tdata_index, val);
         break;
     case TRIGGER_TYPE_AD_MATCH6:
-        type6_reg_write(env, env->trigger_cur, tdata_index, val);
+        type6_reg_write(env, index, tdata_index, val);
         break;
     case TRIGGER_TYPE_INST_CNT:
-        itrigger_reg_write(env, env->trigger_cur, tdata_index, val);
+        itrigger_reg_write(env, index, tdata_index, val);
         check_itrigger = true;
         break;
     case TRIGGER_TYPE_UNAVAIL:
-        anytype_reg_write(env, env->trigger_cur, tdata_index, val);
+        anytype_reg_write(env, index, tdata_index, val);
         break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
@@ -858,7 +878,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
     }
 
     if (check_itrigger) {
-        env->itrigger_enabled = riscv_itrigger_enabled(env);
+        env->sdtrig_state.itrigger_enabled = riscv_itrigger_enabled(env);
     }
 }
 
@@ -898,7 +918,8 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
     int i;
 
     QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        for (i = 0; i < RV_MAX_SDTRIG_TRIGGERS; i++) {
+            SdtrigTrigger *trigger = &env->sdtrig_state.triggers[i];
             trigger_type = get_trigger_type(env, i);
 
             switch (trigger_type) {
@@ -915,8 +936,8 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
 
             switch (trigger_type) {
             case TRIGGER_TYPE_AD_MATCH:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
+                ctrl = trigger->tdata1;
+                pc = trigger->tdata2;
 
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
                     if (do_trigger_action(env, i)) {
@@ -926,8 +947,8 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 }
                 break;
             case TRIGGER_TYPE_AD_MATCH6:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
+                ctrl = trigger->tdata1;
+                pc = trigger->tdata2;
 
                 if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
                     if (do_trigger_action(env, i)) {
@@ -955,7 +976,8 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     int flags;
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < RV_MAX_SDTRIG_TRIGGERS; i++) {
+        SdtrigTrigger *trigger = &env->sdtrig_state.triggers[i];
         trigger_type = get_trigger_type(env, i);
 
         switch (trigger_type) {
@@ -972,8 +994,8 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
         switch (trigger_type) {
         case TRIGGER_TYPE_AD_MATCH:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
+            ctrl = trigger->tdata1;
+            addr = trigger->tdata2;
             flags = 0;
 
             if (ctrl & TYPE2_LOAD) {
@@ -991,8 +1013,8 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
             break;
         case TRIGGER_TYPE_AD_MATCH6:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
+            ctrl = trigger->tdata1;
+            addr = trigger->tdata2;
             flags = 0;
 
             if (ctrl & TYPE6_LOAD) {
@@ -1019,12 +1041,12 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
 void riscv_cpu_debug_change_priv(CPURISCVState *env)
 {
-    env->itrigger_enabled = riscv_itrigger_enabled(env);
+    env->sdtrig_state.itrigger_enabled = riscv_itrigger_enabled(env);
 }
 
 void riscv_cpu_debug_post_load(CPURISCVState *env)
 {
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < RV_MAX_SDTRIG_TRIGGERS; i++) {
         int trigger_type = get_trigger_type(env, i);
 
         switch (trigger_type) {
@@ -1038,7 +1060,7 @@ void riscv_cpu_debug_post_load(CPURISCVState *env)
             break;
         }
     }
-    env->itrigger_enabled = riscv_itrigger_enabled(env);
+    env->sdtrig_state.itrigger_enabled = riscv_itrigger_enabled(env);
 }
 
 void riscv_trigger_reset_hold(CPURISCVState *env)
@@ -1047,7 +1069,8 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     int i;
 
     /* init to type 15 (unavailable) triggers */
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < RV_MAX_SDTRIG_TRIGGERS; i++) {
+        SdtrigTrigger *trigger = &env->sdtrig_state.triggers[i];
         int trigger_type = get_trigger_type(env, i);
 
         switch (trigger_type) {
@@ -1061,10 +1084,10 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
             break;
         }
 
-        env->tdata1[i] = tdata1;
-        env->tdata2[i] = 0;
-        env->tdata3[i] = 0;
+        trigger->tdata1 = tdata1;
+        trigger->tdata2 = 0;
+        trigger->tdata3 = 0;
     }
 
-    env->mcontext = 0;
+    env->sdtrig_state.mcontext = 0;
 }
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index bee42b8593..8a047c8073 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -24,7 +24,8 @@
 
 #include "exec/breakpoint.h"
 
-#define RV_MAX_TRIGGERS         2
+#define RV_MAX_SDTRIG_TRIGGERS        32
+#define RV_DEFAULT_TRIGGERS            2
 
 /* register index of tdata CSRs */
 enum {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bee1445a31..fdd5e8b67b 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -225,10 +225,32 @@ static bool debug_needed(void *opaque)
     return cpu->cfg.debug;
 }
 
+static int debug_pre_save(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+    int i;
+
+    for (i = 0; i < RV_DEFAULT_TRIGGERS; i++) {
+        env->old_tdata1[i] = env->sdtrig_state.triggers[i].tdata1;
+        env->old_tdata2[i] = env->sdtrig_state.triggers[i].tdata2;
+        env->old_tdata3[i] = env->sdtrig_state.triggers[i].tdata3;
+    }
+
+    return 0;
+}
+
 static int debug_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
+    int i;
+
+    for (i = 0; i < RV_DEFAULT_TRIGGERS; i++) {
+        env->sdtrig_state.triggers[i].tdata1 = env->old_tdata1[i];
+        env->sdtrig_state.triggers[i].tdata2 = env->old_tdata2[i];
+        env->sdtrig_state.triggers[i].tdata3 = env->old_tdata3[i];
+    }
 
     riscv_cpu_debug_post_load(env);
 
@@ -240,12 +262,13 @@ static const VMStateDescription vmstate_debug = {
     .version_id = 2,
     .minimum_version_id = 2,
     .needed = debug_needed,
+    .pre_save = debug_pre_save,
     .post_load = debug_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
-        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_UINTTL(env.sdtrig_state.trigger_cur, RISCVCPU),
+        VMSTATE_UINTTL_ARRAY(env.old_tdata1, RISCVCPU, RV_DEFAULT_TRIGGERS),
+        VMSTATE_UINTTL_ARRAY(env.old_tdata2, RISCVCPU, RV_DEFAULT_TRIGGERS),
+        VMSTATE_UINTTL_ARRAY(env.old_tdata3, RISCVCPU, RV_DEFAULT_TRIGGERS),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 677172ae2d..bcc8cfcece 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -178,7 +178,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     }
 
     if (cpu->cfg.debug) {
-        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
+        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER,
+                           env->sdtrig_state.itrigger_enabled);
     }
 #endif
 
-- 
2.51.0


