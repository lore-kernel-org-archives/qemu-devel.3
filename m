Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EABC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1W-0008I7-HO; Wed, 01 Jul 2026 06:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1U-00089m-OS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:28 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1S-0004PZ-8F
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:28 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-139f3eaaa49so487913c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901104; x=1783505904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZs8xCvcYpAj0njqISvDgTB4k3lfKCWL1Ml9/oahnQs=;
 b=OcX1hfxev5zAHuyWEL5tzBLROBbY+90kCsqymuO5fsQbfnkiN0pcfJKbcqHO/cWwSW
 Z5O3wGBrn8IbXrEM1cH/MobYyZ8RHS+2i49M6BXPP8IUmeLVZ9OBcB54GDsigJKpEKuC
 EUZIG4D2F+4g58TvziP4Cp96uew2KvduAsceYkYTf84U8TGMxUrWnSkx9qR8AehkZRDN
 AU4aA4hVOwbkuLoLlOjMg4SWiZJBkWLOCuJdgYo0y6RUTTeZoPHhtm6iITwXioj7LJAO
 73fy9Ywu20zS7NFt1W3EI5QW1nAvT6yMXIz8sLWS4ARKtdHwQ5XzZCQazpAicwTJHTmX
 BUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901104; x=1783505904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hZs8xCvcYpAj0njqISvDgTB4k3lfKCWL1Ml9/oahnQs=;
 b=PgRC/uWGcrUs4FZLo2eApKoNPCmTO84lE4nnhp2OPZrBiliBzTwasrgYONOJ+fdGZ0
 OMKeBSnL3aDqQoIE48VhRGl1+Kx0pofFxPsed+Hbd93Vwb6xncsuXGWJM858WRDAwUi6
 O/lqyf8RYyEQZGxkDj9l7iVTMykYWXB/eTV9XBp8MWUkJXnzZKpHEHN1EFlApICDcx0L
 FX0uXJq8eGzEJg/oeLaO2TdO9CTAP7pmLGKY3+7zjJTlG1tlSZmYxm1wS6lR9gXacHul
 xbuDmXtdA2ANW0upFBTIw8E4uGyI84LCLMA8BlypPqw8tc3ut/+FReg/ShNhRDGcDbhk
 SeNQ==
X-Gm-Message-State: AOJu0YyEuJB+KSZGqOT2+19IacKaXpV3WUccOOzQNSy4l5u8QfRWybCv
 id0VchdTjuNQmSXfHQB+Shn/3Bp6nENnpI9uXaJCAhzalFHJSeegFa9FPWqLGw==
X-Gm-Gg: AfdE7ckV2R3ZADjs7q9Wj45gaixwDHhnOJi+Sq/PniRkEqA7BuF2NITKY8P1IEyzzTQ
 VnGXwji+10JlLSr5UFTMGIxpWMTHsUezbbSr8+qdTaC19DLzFg4B6fMvkrDQE8r0n0Wetudfiuv
 Pca/0+90ByoRU59ioD1w1ewJssyrc5gWwWBWaIccF3N3eG2ne+/6AZN8gFT0lHd43g+z2Op1MbX
 RIgt4lQUZJjP1Jidsur2NYTUsD5D2fcpHM2QX+XfopAFBH8pyJoVi/w/rwF70ikpnBIJ/e1HPR8
 BN6xd7NHUHMOj1iWqVUwqrzU3/zxUN8Z4bf9eF+H5UTU4887FMy8CdK+sPk0/m00OQp+8Lpl1dH
 qrZVRCHifxGx4cqerVLxIZEvKC05j7qV/q3ZeF2UY5359RYUeDvgWKmkfq50ZkC8zKF7t/pHfRS
 hgNMcF3zq5FTpw/TQ/870RxGTRRPHvzg8=
X-Received: by 2002:a05:7022:48:b0:138:3613:db8 with SMTP id
 a92af1059eb24-13b36d6f2e7mr1007922c88.3.1782901103983; 
 Wed, 01 Jul 2026 03:18:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/39] target/riscv: dynamic alloc of debug trigger arrays
Date: Wed,  1 Jul 2026 20:17:18 +1000
Message-ID: <20260701101752.2522962-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The debug trigger facility consists of a set of arrays: tdata1-3,
cpu_breakpoint, cpu_watchpoint and itrigger_timer.  All of them are
static allocated with RV_MAX_TRIGGERS (2).  This means that all RISC-V
cpus will have 2 triggers per hart.

The RISC-V Server Ref demands at least 11 triggers per hart, and several
CPUs in the wild works with 4+ triggers.  We need more flexibility, ergo
we need to parametrize the amount of triggers and make it configurable.

Before doing that we need to handle a situation faced in a previous
attempt [1].  We were unable to set the tdataN array length in
vmstate_debug, meaning that we would always migrate RV_MAX_TRIGGERS
regardless of the actual amount of triggers in play. To fix that we need
to change the tdata arrays from static to dynamic, allowing us to use
VMSTATE_VARRAY_UINT32().  This also means that, in contrast with [1], we
have the opportunity to turn all trigger arrays into dynamic allocation
and reduce the amount of stuff being carried by CPURISCVState, or in
other words, we can carry just what we're using instead of a static max
value.

All the forementioned trigger facility arrays are now dynamic.  They are
allocated and freed during realize/unrealize, and their size is
expressed by env->num_triggers.  All relevant code is changed to use
env->num_triggers instead of the RV_MAX_TRIGGERS to loop through each
array.

This will make it easier for the next patch to parametrize
env->num_triggers.

[1] https://lore.kernel.org/qemu-devel/94c772b0-5231-40e4-9cab-6ac39b9e4d45@oss.qualcomm.com/

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260617131710.1855353-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 18 +++++++++++------
 target/riscv/debug.h   |  1 +
 target/riscv/cpu.c     |  6 ++++++
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
 target/riscv/machine.c | 16 ++++++++++-----
 6 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 16e9f87b83..af246a56ed 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -467,12 +467,18 @@ struct CPUArchState {
     /* trigger module */
     uint16_t mcontext;
     uint8_t trigger_cur;
-    uint64_t tdata1[RV_MAX_TRIGGERS];
-    uint64_t tdata2[RV_MAX_TRIGGERS];
-    uint64_t tdata3[RV_MAX_TRIGGERS];
-    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
-    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
-    QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
+    /*
+     * num_triggers is the length of tdata1, tdata2, tdata3,
+     * cpu_breakpoint, cpu_watchpoint and itrigger_timer
+     * arrays.
+     */
+    uint32_t num_triggers;
+    uint64_t *tdata1;
+    uint64_t *tdata2;
+    uint64_t *tdata3;
+    struct CPUBreakpoint **cpu_breakpoint;
+    struct CPUWatchpoint **cpu_watchpoint;
+    QEMUTimer **itrigger_timer;
     int64_t last_icount;
     bool itrigger_enabled;
 
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 55a3ac72e6..a25d099b37 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -148,6 +148,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 void riscv_trigger_realize(CPURISCVState *env);
+void riscv_trigger_unrealize(CPURISCVState *env);
 void riscv_trigger_reset_hold(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b47e2b41c8..e7318fe9f9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1012,7 +1012,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 static void riscv_cpu_unrealize(DeviceState *dev)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *cpu = RISCV_CPU(dev);
 
+    if (cpu->cfg.debug) {
+        riscv_trigger_unrealize(&cpu->env);
+    }
+#endif
     mcc->parent_unrealize(dev);
 }
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index dd790d5bef..a60a796725 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5441,7 +5441,7 @@ static RISCVException read_tdata(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     /* return 0 in tdata1 to end the trigger enumeration */
-    if (env->trigger_cur >= RV_MAX_TRIGGERS && csrno == CSR_TDATA1) {
+    if (env->trigger_cur >= env->num_triggers && csrno == CSR_TDATA1) {
         *val = 0;
         return RISCV_EXCP_NONE;
     }
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 30d39ee5cd..9a4910c431 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -172,7 +172,7 @@ target_ulong tselect_csr_read(CPURISCVState *env)
 
 void tselect_csr_write(CPURISCVState *env, target_ulong val)
 {
-    if (val < RV_MAX_TRIGGERS) {
+    if (val < env->num_triggers) {
         env->trigger_cur = val;
     }
 }
@@ -701,7 +701,7 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
 bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -721,7 +721,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
 void helper_itrigger_match(CPURISCVState *env)
 {
     int count;
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -750,7 +750,7 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
     int64_t last_icount = env->last_icount, current_icount;
     current_icount = env->last_icount = icount_get_raw();
 
-    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (int i = 0; i < env->num_triggers; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
@@ -950,7 +950,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
     int i;
 
     QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        for (i = 0; i < env->num_triggers; i++) {
             trigger_type = get_trigger_type(env, i);
 
             if (!trigger_common_match(env, trigger_type, i)) {
@@ -996,7 +996,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     int flags;
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < env->num_triggers; i++) {
         trigger_type = get_trigger_type(env, i);
 
         if (!trigger_common_match(env, trigger_type, i)) {
@@ -1049,19 +1049,49 @@ void riscv_trigger_realize(CPURISCVState *env)
 {
     int i;
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    /*
+     * Alloc env->tdata1/2/3, cpu_breakpoint, cpu_watchpoint and
+     * itrigger_timer dynamically.  This is overkill now
+     * given that they could be static arrays with RV_MAX_TRIGGERS
+     * but we'll parametrize the trigger number later, i.e. the
+     * array length won't be static.
+     */
+    env->num_triggers = RV_MAX_TRIGGERS;
+    env->tdata1 = g_new0(uint64_t, env->num_triggers);
+    env->tdata2 = g_new0(uint64_t, env->num_triggers);
+    env->tdata3 = g_new0(uint64_t, env->num_triggers);
+    env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
+    env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
+    env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
+
+    for (i = 0; i < env->num_triggers; i++) {
         env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                               riscv_itrigger_timer_cb, env);
     }
 }
 
+void riscv_trigger_unrealize(CPURISCVState *env)
+{
+    g_free(env->tdata1);
+    g_free(env->tdata2);
+    g_free(env->tdata3);
+
+    g_free(env->cpu_breakpoint);
+    g_free(env->cpu_watchpoint);
+
+    for (int i = 0; i < env->num_triggers; i++) {
+        timer_del(env->itrigger_timer[i]);
+    }
+    g_free(env->itrigger_timer);
+}
+
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
     target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
     int i;
 
     /* init to type 2 triggers */
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+    for (i = 0; i < env->num_triggers; i++) {
         /*
          * type = TRIGGER_TYPE_AD_MATCH
          * dmode = 0 (both debug and M-mode can write tdata)
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 6e70b145a5..ba96ceceef 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -240,16 +240,22 @@ static int debug_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_debug = {
     .name = "cpu/debug",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .needed = debug_needed,
     .post_load = debug_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(env.mcontext, RISCVCPU),
         VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
-        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_VARRAY_UINT32(env.tdata1, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_UINT32(env.tdata2, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
+                              env.num_triggers, 0,
+                              vmstate_info_uint64, uint64_t),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.54.0


