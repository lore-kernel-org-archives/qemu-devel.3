Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D46606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 16:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL1WQ-0001EQ-Dw; Sun, 25 Oct 2026 12:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WD-0001Ak-MX; Sun, 25 Oct 2026 12:56:26 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WA-0004bv-WC; Sun, 25 Oct 2026 12:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=k94iJaeSsSRm8FaYi0lIVSaPO/XFfV5WPcs6sqL9u7I=; b=GM5JX70NpMWIkKYxVmKgJAfgDh
 rX5BOxg07eQNTbF/bA/bYUwATKHAG6EhF3Xo5kb5mRa9Xz6hBM1SINHPeODDYHoEaKoNEt1Ohi4bl
 VjYLS6/QtSoTc2fru3IqYMZijuIjXvByyg4vfF22UoO9cmpW5l2ILOwd+ci9fzVmTX/SWzzYOVdcC
 Qg4PFbw0ZoC1BV7HOuySUfjY75WCYu0VLYqVxO/9E0y3WJnHeFHN7E/Rc49mpLrZ7CFnMUIxziPRB
 TbVe6mIG1dVmZRmZ2c4U7zEsna/LvVWDGav3waPY4py/c0Y4sYeG4hVRh8FzchP1iIJT5XL3QwPWB
 BiR1Rwmw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kQ-0Y; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-1F; Sun, 25 Oct 2026 17:56:06 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:19 +0100
Subject: [PATCH v2 03/31] target/rx: drop plugin interrupt callbacks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-3-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=3960;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=S0MkFymflqF0u/ShII9jk+rsgwRMkgo/70J71P1ST0k=;
 b=2koeTZBhQnVxMmofp2US6ReRMkEPZReZQUIOX2LG0xUJzHmusATcqwQKhYJtRjUxE3g1+6fCY
 I9TT2GSccLgBUnX2GhSWZxeewpGlsZaJAUQ+JcK2NuZCqYnCrEPHptP
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drop the qemu_plugin_vcpu_interrupt_cb()/qemu_plugin_vcpu_exception_cb()
calls from interrupt delivery, and test both interrupt lines once up
front so the FIR/HARD/exception dispatch does not repeat the checks.

Note: this removes plugin notifications for RX interrupts and
exceptions; drop this patch if they should stay.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/helper.c | 53 ++++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index cb06f31a2f..87d3267802 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -22,7 +22,6 @@
 #include "exec/log.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "hw/core/irq.h"
-#include "qemu/plugin.h"
 
 const char *rx_exception_name(int excp)
 {
@@ -72,11 +71,13 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
     env->psw_c = FIELD_EX32(psw, PSW, C);
 }
 
+#define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
     CPURXState *env = cpu_env(cs);
+    bool fir = cpu_test_interrupt(cs, CPU_INTERRUPT_FIR);
+    bool hard = cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
     uint32_t save_psw;
-    uint64_t last_pc = env->pc;
 
     env->in_sleep = 0;
 
@@ -88,26 +89,27 @@ void rx_cpu_do_interrupt(CPUState *cs)
     save_psw = rx_cpu_pack_psw(env);
     env->psw_pm = env->psw_i = env->psw_u = 0;
 
-    if (cpu_test_interrupt(cs, CPU_INTERRUPT_FIR)) {
-        env->bpc = env->pc;
-        env->bpsw = save_psw;
-        env->pc = env->fintv;
-        env->psw_ipl = 15;
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
-        qemu_set_irq(env->ack, env->ack_irq);
-        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
-        qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
-    } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
-        env->isp -= 4;
-        cpu_stl_le_data(env, env->isp, save_psw);
-        env->isp -= 4;
-        cpu_stl_le_data(env, env->isp, env->pc);
-        env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
-        env->psw_ipl = env->ack_ipl;
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        qemu_set_irq(env->ack, env->ack_irq);
-        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
-        qemu_log_mask(CPU_LOG_INT, "interrupt 0x%02x raised\n", env->ack_irq);
+    if (fir || hard) {
+        if (fir) {
+            env->bpc = env->pc;
+            env->bpsw = save_psw;
+            env->pc = env->fintv;
+            env->psw_ipl = 15;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
+            qemu_set_irq(env->ack, env->ack_irq);
+            qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
+        } else {
+            env->isp -= 4;
+            cpu_stl_le_data(env, env->isp, save_psw);
+            env->isp -= 4;
+            cpu_stl_le_data(env, env->isp, env->pc);
+            env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
+            env->psw_ipl = env->ack_ipl;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+            qemu_set_irq(env->ack, env->ack_irq);
+            qemu_log_mask(CPU_LOG_INT,
+                          "interrupt 0x%02x raised\n", env->ack_irq);
+        }
     } else {
         uint32_t vec = cs->exception_index;
 
@@ -123,13 +125,6 @@ void rx_cpu_do_interrupt(CPUState *cs)
             env->pc = cpu_ldl_le_data(env, env->extb + vec * 4);
         }
 
-        if (vec == RX_EXCP_NMI) {
-            /* Non-maskable interrupt */
-            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
-        } else {
-            qemu_plugin_vcpu_exception_cb(cs, last_pc);
-        }
-
         qemu_log_mask(CPU_LOG_INT, "exception 0x%02x [%s] raised\n",
                       (vec & 0xff), rx_exception_name(vec));
     }

-- 
2.53.0


