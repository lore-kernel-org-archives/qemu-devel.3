Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABF2F47CD2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFg3-0006YP-RI; Thu, 05 Mar 2026 15:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg0-0006Xf-R6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:08 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFfy-00065f-6j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:08 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-89a0b376fedso23179776d6.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743924; x=1773348724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIW8iRVJbXYnMtx2eO2fTKP/5/Q0rQvPk/TKKnhRlp4=;
 b=D5h7UaYLjeNXJcGYynALOK1cs2dJQprMwrB3St+D0SIbDqGzL6PSmv7Pwsra5Wd3bg
 Zvct3Y5dsCTNQLDuDZcUfwSbx3weVtsz7oCrsw+jpujDpZhBvjQya0mGjg0G15pOvmbk
 ot2upSICfOt2qneH0TEUbZ+pmzCaG4QKGQstzOqVguAuoFOSBRBbvlDyvZohLS7L9VE6
 MAgtzfxN2CE+aKHOND1VwqayWcIro/SbCoIaHcOdTerhrXCLzyAJv7ueFP19dL3ktKKm
 9UrTggb38upr0n94O0pjYWSSfQnciTFqug3i6M6PnZXH4n70GI9D6qppFnVIh7zTE6sB
 8Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743924; x=1773348724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tIW8iRVJbXYnMtx2eO2fTKP/5/Q0rQvPk/TKKnhRlp4=;
 b=M0F9ZnQV0YL4WF7okuBUkr7evjk0CD6qKtsVLj69yPLUbBmKNpoRBu2FZwF7z9Gpx6
 UpAm74/+kt1T2QXdDU6MgYKi+9u8AzwIvAZjTCNWYfMMqCe1GcFyUGjoQqUhFl0fQVw+
 PetL8PzV5nvqN2c4gjFKIh67dgz8qIwi4GhM/cG60pFw94D8G0QHUkWpSbhy07ZYVJ3s
 5/IP7GpyFrfDj5hT1PVTlaHuZdaQTpCxaUpgNbhgepDlk0sZhGcx26+PNcgXtdYrm+GT
 Po2b4DHNoXmYkZJpAJozXtszocXqNc9rGZ0XZ3vNoz3BiL0XTjrSHiKHBCUTdorsaDmg
 ZQuQ==
X-Gm-Message-State: AOJu0Yxav8+vtREqTKfeNpz1QZ6Q3qpWwmg+P0RRC7l5xxeqfnxrxB5B
 L9QmrTuGMqr7PFkiZIVseUZ4CfSEe/k1COfuxtmJ/gyif5y4mz+mhpP+EC2etJojGC6HpQuLWvJ
 jw+wC
X-Gm-Gg: ATEYQzwANn0WY3fnOgprFhG4aeDB6F2gDno+q1B9cWgDb7Pxityi6Lfjl/RYX/wEQIb
 xnvYjrkWSKKMsGzJzvBFjRO+4fDnzNpOKtcr1A3vwPgAhTmV1DUgdlW25IYL13DLT0w7Ctt+5YZ
 GTRQDG8LY7EQTkrIcNb/fkbEQCtbAPjCssDy96sDsBbRpqkIVcEo0G5ws4nQFcznY0o6HZEt3hY
 ZDH9sDtVeXVRJkF+9w4rnWrME/KQ4XGjij7KY0a9lravUh0ZGS6TfbBvLPFaDrs4xiH0ofckEaQ
 H8SsUo4eU32Eqd18AlbBjzKkBPOHUhIdIcbBQ00teskBoOwjN09v2vkAgn6z5nDAfln1Nn/V3vE
 niu3XTxd0y1t3dBqjtcb4jN45ekG/r+tdvxKJ/EowCHjhSKZ9zPN1al2Bq30y974vAWXzodxzUJ
 3A/KbJeOL183be35km9RMzvwIzXZ1RBcUdaLgVqnKqsPOa5lhohdTXJiMyTPyuh5rVOYheOoh5t
 RWG
X-Received: by 2002:ad4:5c6a:0:b0:899:f2ba:9d81 with SMTP id
 6a1803df08f44-89a2df6417dmr20285596d6.24.1772743924324; 
 Thu, 05 Mar 2026 12:52:04 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:03 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 02/12] plugins: add flag to specify whether PC is rw
Date: Thu,  5 Mar 2026 12:51:42 -0800
Message-ID: <20260305205152.2121854-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf36.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

In addition to the flags specifying whether general-purpose registers
are read-write (rw) during a plugin callback, we add an additional flag
explicitly stating whether the PC is writable. This is in preparation of
a patch that allows to explicitly set the PC to divert control flow from
within a plugin callback, which is currently not possible.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-2-4c3adba52403@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 |  4 +++-
 plugins/core.c                | 29 ++++++++++++++++-------------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 17a834dca90..a6ec8e275d8 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -325,11 +325,14 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
+ * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
+ *                             regs and updates the PC
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
     QEMU_PLUGIN_CB_R_REGS,
     QEMU_PLUGIN_CB_RW_REGS,
+    QEMU_PLUGIN_CB_RW_REGS_PC,
 };
 
 enum qemu_plugin_mem_rw {
diff --git a/plugins/api.c b/plugins/api.c
index 04ca7da7f18..32eb086300d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -458,7 +458,9 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
-    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+    if (buf->len == 0 ||
+        (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
+         qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return false;
     }
 
diff --git a/plugins/core.c b/plugins/core.c
index d6173422e98..2324bbffa3d 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -119,7 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     struct qemu_plugin_cb *cb, *next;
     uint64_t to = cpu->cc->get_pc(cpu);
 
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
     if (cpu->cpu_index < plugin.num_vcpus) {
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -395,15 +395,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -425,15 +426,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -464,15 +466,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =
+        [0 ... 3].typemask =
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
@@ -553,7 +556,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -577,7 +580,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -605,7 +608,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
 
     clamp_syscall_arguments(&a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8);
 
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
 
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
@@ -626,7 +629,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -635,7 +638,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -906,6 +909,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
     } else if (flags & TCG_CALL_NO_WG) {
         return QEMU_PLUGIN_CB_R_REGS;
     } else {
-        return QEMU_PLUGIN_CB_RW_REGS;
+        return QEMU_PLUGIN_CB_RW_REGS_PC;
     }
 }
-- 
2.47.3


