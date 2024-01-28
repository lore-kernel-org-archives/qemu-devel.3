Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ADEC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx1L-0006AX-IR; Sat, 27 Jan 2024 23:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx1D-0005tV-OY
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:44 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx1C-0004Rz-29
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:43 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-290a55f3feaso1323687a91.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706417021; x=1707021821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/uaC3GU2r5ag1NYLRtG0R3ws3tDO6FtLPMPWrHI/7I=;
 b=CNxCRIliyLjf9CoTLwX8GO3Z5MEGmw2wP9TOXBqMoZJvkvuPG5BrD8DqkFD7tj6wxV
 crEeyLOqppnVh25HGOyRofwxwjLWS29OLgmVaSjmPzfG4m70ell9QEmSr0FJt1576bh2
 V4FQQbKSDEhh1TdLetpbtDXeuDVIwl4q+kO2lghBxV3SAT+YicVhF1Mq5ue82jD7K6ff
 VR28ARbIlVdycaIN4QXEcRarhYyCR/z7DlnXma6eUyIZ/r5EGnNjqEGVppmY5zA+WdTF
 SBocA01VF4oZBWZ6PJLOEPR6JJl+PgUtmHasFcMX73+ciECgRJQMkSXtK1a5vLK4oVUD
 9iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706417021; x=1707021821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/uaC3GU2r5ag1NYLRtG0R3ws3tDO6FtLPMPWrHI/7I=;
 b=DVHTb3EIOCqVmqVT9yq109Khg4TNpWt/xplFd7gmJFbSbf72KoMHmkAUAob2IiiTrz
 pi+Lgz99pKlVrYr6iRML3AZ64o9tZiqDkcaSqx8YDcWhgQoBVoKV2+jC490UoaCUYPme
 yKms9X4p79rC4Bzl1WWCcuvl3A4Agn9EnNkCaY9JBUadkzddMsJJj1IjQWtuqPqrHts1
 WWl+KsQbRPG1ECyV/YB93FpXoyjelwXwa2s/kTKxTYW9mcxAkhGxO3N2x1uzC6bojeSM
 B5NotKpWujgkNFg0ILcqrgoWtWZkU+XGOcF9oJRKIDcLQiijxYAWvfhB7EYP0iaas/lA
 B82g==
X-Gm-Message-State: AOJu0Yyw11y5BrnlFoOy0dAJFLDG0X4TvH0HCNYDs4vYAg6/gqZseAfw
 hVJWI72ZFbANgFjIa55+ZRuDNAVdo0+gH2BmGm05dghLGopgGxzrvVux9qll+2b8iB5bpa7qR0V
 H483uLA==
X-Google-Smtp-Source: AGHT+IH6+V9twuxV00uYp9p82Ezc0zV35qoKn2bXtI0imI19KZLlgZmXOaMB0zBw8WMknq4OZWR3Kg==
X-Received: by 2002:a17:902:ec85:b0:1d7:79c5:8f5a with SMTP id
 x5-20020a170902ec8500b001d779c58f5amr3414450plg.134.1706417020940; 
 Sat, 27 Jan 2024 20:43:40 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 33/33] target/i386: Extract x86_cpu_exec_halt() from accel/tcg/
Date: Sun, 28 Jan 2024 14:42:13 +1000
Message-Id: <20240128044213.316480-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move this x86-specific code out of the generic accel/tcg/.

Reported-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124101639.30056-10-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index 82627b12b8..977576ca14 100644
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
@@ -666,15 +663,6 @@ static inline bool cpu_handle_halt(CPUState *cpu)
     if (cpu->halted) {
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-#if defined(TARGET_I386)
-        if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            bql_lock();
-            apic_poll_irq(x86_cpu->apic_state);
-            cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
-            bql_unlock();
-        }
-#endif /* TARGET_I386 */
         if (tcg_ops->cpu_exec_halt) {
             tcg_ops->cpu_exec_halt(cpu);
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
index 5bdcf45199..cca19cd40e 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -119,6 +119,7 @@ static const TCGCPUOps x86_tcg_ops = {
 #else
     .tlb_fill = x86_cpu_tlb_fill,
     .do_interrupt = x86_cpu_do_interrupt,
+    .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
-- 
2.34.1


