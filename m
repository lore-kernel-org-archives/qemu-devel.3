Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48029D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoL-0005jI-6X; Tue, 13 Jan 2026 23:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoI-0005ar-PO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:47 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoG-0003zO-Q7
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:46 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a3e89aa5d0so64211925ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366123; x=1768970923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WIwTEEt83xmDiYrW0fSW8coAM7IrPEJt9OsUoCFXbQ=;
 b=JvpNHOhjxvtyQZpIpNbTn89fTNvNLetRp/dbxiqP4ZhSj+O5/NC3qrSsGtmpUxvHu1
 cpdx5n5G317kWh9tQJEBfCthOwRHsRE+kA+FWD6CKorCmPJsjVMY0rGzhe7I20JmrvuH
 wxt5XX4cjjTxpVi3fHsoGoYinttBYMmTy0AJ4ZnKr40C75N/4G6YOwxMVJt507crLAEi
 J5dq2n9Wba5yjeGZD9F55OCcX3b26NKXAlDIZGx4HA/XXkkf+10UKLQHIfSFaVNWF/R9
 VR+LbyR/4JaMKkFlPz6WkvnRo9lsALX2Dq3t6c7tJfIInYAyiDwqoStoInRtPGiXQXtf
 r0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366123; x=1768970923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1WIwTEEt83xmDiYrW0fSW8coAM7IrPEJt9OsUoCFXbQ=;
 b=AjKA7HEjX+toeWQIo+JRhShmNiOUmXaRgmpnDcMVNgX4mYF/1DNKlVM92vVzzcA2FC
 BXc5ZCK1zLm+VWGQe3K246hq76gv5P3u7w4CxsPzbSLpeWPAYfzlzLx6cy0kVkR/rs9M
 TABkA3K9WJQUov42603uRJjvF22FKMZDLu3beBkYHApfb9tyROIb0xsMH8lfrGg50oAI
 LdV9EEJ5MDzKmYZVU7B3mll7K1KAQYgPj6kOyw/tx/X0uBEYoLC4T1l7BbjHbBQCf6Ka
 cD6jUbpiCYmpssCqRrIkoNhezwwMHCPYrDJTjoqsch6gRdErrCH3x1D50LE5efnUQog2
 RSFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhVzpXivl70tFS6es5pU4v1K5qx6qz1+/TYsB6B7USFzRnx5m+RjR6d4AuZ+QJeY5bAinoPrA07n6V@nongnu.org
X-Gm-Message-State: AOJu0YyfeeakG0MxX8zI1kJd3tfF0j8gPQ324uHTROaMhxFTzZ0ADXHN
 qaPvlu5w/CtVqmC1Sni1F1rAiUb9yVkdTyfpH+hBNFAX0n//NLcXdsz4ZAo/zw==
X-Gm-Gg: AY/fxX4KI9F7//StN8GDcIcB8TbXb3d4XGmn0KhsVqg1j4HJp/ebvplMS17UkTBn4Za
 pxm/n4RPyyfbsjG0kTKUvZGpCUr/u/8I+qImpRgthL5chz+30EAYi2Z2V3NaIWpaM82PaVMXWMh
 trGFqfNSEomypj4HlBypPX4X6kbBR0VKnYL/T0ho5+eh8KO8v8EHG8pLRX7MVssIkaoUbBnMz2X
 MRaESBUQYOGr85XVJbLIYYLa+TvFWyClTO63xBVDVjmiYYIASKrF5t+MtuqQLdwb+7plF3TgBGX
 q8mcNhu3yILhBoICx8Oj+83e5gmFkgjPNIQ3iBKd+eszqaSyJG0w+/+7I9EFtXPg6S3Z0rnm3vs
 oOGrjtxu98kgEbh18l0XO82qsYaCkyetOMkv4/J6c6FxThU3EeWuARrKrOvInx3uVKEwUIx7c4Y
 Ru6lESbV4DpMceRbEGmXDS/6E9eO/+ayqRd9ynrufLM+VLGkLOUup8JGTwgGo=
X-Received: by 2002:a17:902:ebc1:b0:2a0:9040:6377 with SMTP id
 d9443c01a7336-2a59bb73defmr10766625ad.18.1768366123477; 
 Tue, 13 Jan 2026 20:48:43 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:43 -0800 (PST)
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
Subject: [RFC PATCH 16/25] target/riscv/debug: Remove itrigger icount-enabled
 mode
Date: Wed, 14 Jan 2026 14:46:49 +1000
Message-ID: <20260114044701.1173347-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

When QEMU icount is enabled, the riscv icount trigger facility is
implemented cleverly using precise counting timers rather than
single-stepping TCG.

I found this possibly has some bugs, it is a bit complicated and
splits testing between icount and !icount, and icount enabled is
not the important case for performance. Therefore remove the
separate icount enabled path.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/cpu.c         |   6 --
 target/riscv/cpu.h         |   2 -
 target/riscv/cpu_helper.c  |   3 -
 target/riscv/debug.c       | 115 ++-----------------------------------
 target/riscv/debug.h       |   3 -
 target/riscv/tcg/tcg-cpu.c |   2 +-
 6 files changed, 5 insertions(+), 126 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ffd98e8eed..057e221808 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -942,12 +942,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     riscv_cpu_register_gdb_regs_for_features(cs);
 
-#ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
-        riscv_trigger_realize(&cpu->env);
-    }
-#endif
-
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..a718287d41 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -450,8 +450,6 @@ struct CPUArchState {
     target_ulong mcontext;
     struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
-    QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
-    int64_t last_icount;
     bool itrigger_enabled;
 
     /* machine specific rdtime callback */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e096da939b..55518cad86 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1036,9 +1036,6 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 
     if (newpriv != env->priv || env->virt_enabled != virt_en) {
         change = true;
-        if (icount_enabled()) {
-            riscv_itrigger_update_priv(env);
-        }
 
         riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
     }
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index a30b345b25..69e7037fac 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -30,8 +30,6 @@
 #include "trace.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
-#include "system/cpu-timers.h"
-#include "exec/icount.h"
 
 /*
  * The following M-mode trigger CSRs are implemented:
@@ -668,11 +666,6 @@ itrigger_set_count(CPURISCVState *env, int index, int value)
                                    ITRIGGER_COUNT, value);
 }
 
-static bool check_itrigger_priv(CPURISCVState *env, int index)
-{
-    return icount_priv_match(env, index);
-}
-
 static bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
@@ -729,62 +722,6 @@ void helper_itrigger_match(CPURISCVState *env)
     env->itrigger_enabled = enabled;
 }
 
-static void riscv_itrigger_update_count(CPURISCVState *env)
-{
-    int count, executed;
-    /*
-     * Record last icount, so that we can evaluate the executed instructions
-     * since last privilege mode change or timer expire.
-     */
-    int64_t last_icount = env->last_icount, current_icount;
-    current_icount = env->last_icount = icount_get_raw();
-
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
-        if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
-            continue;
-        }
-        count = itrigger_get_count(env, i);
-        if (!count) {
-            continue;
-        }
-        /*
-         * Only when privilege is changed or itrigger timer expires,
-         * the count field in itrigger tdata1 register is updated.
-         * And the count field in itrigger only contains remaining value.
-         */
-        if (check_itrigger_priv(env, i)) {
-            /*
-             * If itrigger enabled in this privilege mode, the number of
-             * executed instructions since last privilege change
-             * should be reduced from current itrigger count.
-             */
-            executed = current_icount - last_icount;
-            itrigger_set_count(env, i, count - executed);
-            if (count == executed) {
-                do_trigger_action(env, i);
-            }
-        } else {
-            /*
-             * If itrigger is not enabled in this privilege mode,
-             * the number of executed instructions will be discard and
-             * the count field in itrigger will not change.
-             */
-            timer_mod(env->itrigger_timer[i],
-                      current_icount + count);
-        }
-    }
-}
-
-static void riscv_itrigger_timer_cb(void *opaque)
-{
-    riscv_itrigger_update_count((CPURISCVState *)opaque);
-}
-
-void riscv_itrigger_update_priv(CPURISCVState *env)
-{
-    riscv_itrigger_update_count(env);
-}
-
 static target_ulong itrigger_validate(CPURISCVState *env,
                                       target_ulong ctrl)
 {
@@ -808,21 +745,9 @@ static target_ulong itrigger_validate(CPURISCVState *env,
 static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
                                int tdata_index, target_ulong val)
 {
-    target_ulong new_val;
-
     switch (tdata_index) {
     case TDATA1:
-        /* set timer for icount */
-        new_val = itrigger_validate(env, val);
-        if (new_val != env->tdata1[index]) {
-            env->tdata1[index] = new_val;
-            if (icount_enabled()) {
-                env->last_icount = icount_get_raw();
-                /* set the count to timer */
-                timer_mod(env->itrigger_timer[index],
-                          env->last_icount + itrigger_get_count(env, index));
-            }
-        }
+        env->tdata1[index] = itrigger_validate(env, val);
         break;
     case TDATA2:
         qemu_log_mask(LOG_UNIMP,
@@ -858,27 +783,10 @@ static void anytype_reg_write(CPURISCVState *env, target_ulong index,
     }
 }
 
-static int itrigger_get_adjust_count(CPURISCVState *env)
-{
-    int count = itrigger_get_count(env, env->trigger_cur), executed;
-    if ((count != 0) && check_itrigger_priv(env, env->trigger_cur)) {
-        executed = icount_get_raw() - env->last_icount;
-        count += executed;
-    }
-    return count;
-}
-
 target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
 {
-    int trigger_type;
     switch (tdata_index) {
     case TDATA1:
-        trigger_type = extract_trigger_type(env,
-                                            env->tdata1[env->trigger_cur]);
-        if ((trigger_type == TRIGGER_TYPE_INST_CNT) && icount_enabled()) {
-            return deposit64(env->tdata1[env->trigger_cur], 10, 14,
-                             itrigger_get_adjust_count(env));
-        }
         return env->tdata1[env->trigger_cur];
     case TDATA2:
         return env->tdata2[env->trigger_cur];
@@ -949,7 +857,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
         g_assert_not_reached();
     }
 
-    if (check_itrigger && !icount_enabled()) {
+    if (check_itrigger) {
         env->itrigger_enabled = riscv_itrigger_enabled(env);
     }
 }
@@ -1107,21 +1015,9 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
-void riscv_trigger_realize(CPURISCVState *env)
-{
-    int i;
-
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
-        env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                              riscv_itrigger_timer_cb, env);
-    }
-}
-
 void riscv_cpu_debug_change_priv(CPURISCVState *env)
 {
-    if (!icount_enabled()) {
-        env->itrigger_enabled = riscv_itrigger_enabled(env);
-    }
+    env->itrigger_enabled = riscv_itrigger_enabled(env);
 }
 
 void riscv_cpu_debug_post_load(CPURISCVState *env)
@@ -1140,9 +1036,7 @@ void riscv_cpu_debug_post_load(CPURISCVState *env)
             break;
         }
     }
-    if (!icount_enabled()) {
-        env->itrigger_enabled = riscv_itrigger_enabled(env);
-    }
+    env->itrigger_enabled = riscv_itrigger_enabled(env);
 }
 
 void riscv_trigger_reset_hold(CPURISCVState *env)
@@ -1181,7 +1075,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
         env->tdata1[i] = tdata1;
         env->tdata2[i] = 0;
         env->tdata3[i] = 0;
-        timer_del(env->itrigger_timer[i]);
     }
 
     env->mcontext = 0;
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 400c023943..bee42b8593 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -148,11 +148,8 @@ void riscv_cpu_debug_excp_handler(CPUState *cs);
 bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
-void riscv_trigger_realize(CPURISCVState *env);
 void riscv_trigger_reset_hold(CPURISCVState *env);
 
-void riscv_itrigger_update_priv(CPURISCVState *env);
-
 void riscv_cpu_debug_change_priv(CPURISCVState *env);
 void riscv_cpu_debug_post_load(CPURISCVState *env);
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..677172ae2d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -177,7 +177,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if (cpu->cfg.debug) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.51.0


