Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA607C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaKI-0004Cw-7S; Wed, 24 Jan 2024 05:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaKD-0003hF-3T
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:41 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaKB-0003t0-DX
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:40 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a30b3a9e9c6so209303566b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091458; x=1706696258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpEb2PEYPX2zoYAlv9rul3UN8M152eCIu+XSN9MDjH0=;
 b=O2fAohS+Poviqif5YxxMHRgGtHn0QJ8/pStftmB1hYL/k8NoETwOMrKYCN+kpgNACQ
 6jxyU+tSqtmphUGc4H5GPB+TSXri8rbsJEhg+/R7y6HgKCns9Ygn/jYelcD8Tf+zR3QH
 T1M2O10H/zZWMbuYtJH5bL/KpRJKo87umqaf59fKtTSLIyOb/gB5HyhkEXGnF7KwHdMa
 a5dprPWuPgJhHhU6qD9cfhPLx7Vfv73Mud6QolgeA1Zypo30l0WGKKUGYW2xpaI3G2xJ
 4+AzqystCX7wW6xlvAXfLnnMoIuWf0a14QD2nXHF8+QbRYZRSAu8sygFFt7IPLj2YXiP
 E2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091458; x=1706696258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpEb2PEYPX2zoYAlv9rul3UN8M152eCIu+XSN9MDjH0=;
 b=wbUma8ZPw5pOYWqRaoSVmX512CMTQEv7T7XslM1CrgJ/NbY5DsKH834wwwj7jJLgvk
 6IEFPXei5fLn6jp33YnvkFA3dk7PjlhYe0mUkGYpsB5uuuTzUMFsykfNj1uHuABK3XQa
 QwmV+FrTa2k8JUUJZJF2OxOkj2ydAvhcwoLd6PRZUSJesYeV5lAGObxfcO2CbBuV29yD
 soi9GVjKdddQ0t5nweSlCMistWwl+QX3OGzOIkcJxrZK9JfmAo8SlByjqAeZfCgIfsI/
 Py1wDq+E7EwR0PNcXAHcftM4jiTZeEvlZqNYV4aX7MvzWy8RRulXfoB6ep52wJKrjJy9
 gSDg==
X-Gm-Message-State: AOJu0YxqVlBOufCepcfo0xBuROHViHpy7p9TZ/9LtO1exFyhG7xQdFg4
 JK3eRURi4cZ1Hnmcdx0rRk5++bJ1HuQdiQXIHCKMm7QwdnOPDuj7zzXiiuuPipo=
X-Google-Smtp-Source: AGHT+IGAX8mq8S4UC+lQnwqIxhDW1uaxnZ4vzpUfX7QVDiewYICyao4JkcpFe58Lpc4HfYtSOkPReg==
X-Received: by 2002:a17:906:c50:b0:a30:8497:4db2 with SMTP id
 t16-20020a1709060c5000b00a3084974db2mr325628ejf.201.1706091457794; 
 Wed, 24 Jan 2024 02:17:37 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 tj4-20020a170907c24400b00a311082cd00sm599770ejc.37.2024.01.24.02.17.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:17:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 9/9] target/i386: Extract x86_cpu_exec_halt() from accel/tcg/
Date: Wed, 24 Jan 2024 11:16:39 +0100
Message-ID: <20240124101639.30056-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Move this x86-specific code out of the generic accel/tcg/.

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 accel/tcg/cpu-exec.c                | 12 ------------
 target/i386/tcg/sysemu/seg_helper.c | 13 +++++++++++++
 target/i386/tcg/tcg-cpu.c           |  1 +
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 253b1f561e..effc2c1c98 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+void x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 390a9644da..7662f4973d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -30,9 +30,6 @@
 #include "qemu/rcu.h"
 #include "exec/log.h"
 #include "qemu/main-loop.h"
-#if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
-#include "hw/i386/apic.h"
-#endif
 #include "sysemu/cpus.h"
 #include "exec/cpu-all.h"
 #include "sysemu/cpu-timers.h"
@@ -672,15 +669,6 @@ static inline bool cpu_handle_halt(CPUClass *cc, CPUState *cpu)
 {
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
-#if defined(TARGET_I386)
-        if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            bql_lock();
-            apic_poll_irq(x86_cpu->apic_state);
-            cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
-            bql_unlock();
-        }
-#endif /* TARGET_I386 */
         if (cc->tcg_ops->cpu_exec_halt) {
             cc->tcg_ops->cpu_exec_halt(cpu);
         }
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index e6f42282bb..2db8083748 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
@@ -127,6 +128,18 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
+void x86_cpu_exec_halt(CPUState *cpu)
+{
+    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+        X86CPU *x86_cpu = X86_CPU(cpu);
+
+        bql_lock();
+        apic_poll_irq(x86_cpu->apic_state);
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
+        bql_unlock();
+    }
+}
+
 bool x86_need_replay_interrupt(int interrupt_request)
 {
     /*
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 255d56d4c3..3028b57c97 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -119,6 +119,7 @@ static const struct TCGCPUOps x86_tcg_ops = {
 #else
     .tlb_fill = x86_cpu_tlb_fill,
     .do_interrupt = x86_cpu_do_interrupt,
+    .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
-- 
2.41.0


