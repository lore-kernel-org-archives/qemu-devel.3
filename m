Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4245D68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8a-0002EQ-6i; Fri, 15 Nov 2024 10:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8Y-0002E4-Pq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:30 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8W-00047L-Te
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:30 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so17181895e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684087; x=1732288887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yp1aCpXr3wZU6pqXqUnr6GbiNobZzfh44qbynt7h1+g=;
 b=N2Wl7E5jXDQ0SsfJQ2oD+rd1jHzKElM9eihLlNQ9lls7CGnsnXf9219rjfKFVSiKLd
 DGYWaQwr6X4rt2vvK2eTyt5Mn/UL0EucdVF4lV6dkrVAwxNe0XGNjAZxf0UF9VkHaFH1
 GcNuzIiPkGPCwjBqyhLr8uoahJuHt5jZMegzkSSb5q+waBZ+bulOQRtAMT7uZUJGugn2
 ABMdHk2iqRHrFcDL8t7FMKL/O+aQK9laCdkd2Xod+SUMxLwU/9Z/w1G9gfVe3Dzr961W
 Aqm/23SC/Ylf5bhFYSs3cBdCx+uqwdIIJCWPBDVtKJ9NfAGSShFkYRZk12ZwfGLXGnT7
 UDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684087; x=1732288887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yp1aCpXr3wZU6pqXqUnr6GbiNobZzfh44qbynt7h1+g=;
 b=rHd2xdZqgw5Ygsk8oqQaWNxJohD5IQ/kxnX/+BJ4CMHRRr5E4SDXcMn4XEk6jB0VtE
 VKQva2OlTxuaG1qtWEz2R9MBUM7EJP2yhfPBdqz7B+8UypppQ8DECjjIRCFM1hdFNff/
 4KIdLLAmlYRCpD5tFhlVUEPjwLQ9pfKuXW+nQlM1O49EhuV7twzc/Q5oz+P2unk7/uN6
 fHwoDCYIfDtB/KLCSfkDCmOEaL2l/RdlQzofYNoGgZXgIRVaKTUoktiPCWfOUfs7b65K
 uOkUfwL01gAI16f8n1RdKE8SMlCf2JTRUPL11wlpQYObzrtbbV4XTi2YAQioV7nFiaGR
 YOIQ==
X-Gm-Message-State: AOJu0YyYiE/OPfSI50f37rj/iCGNTMte/tbdqljFYxbja6LMSeUo4AiX
 Acq6hbnCDVm0aYlgoAJO/qMDYqRmYl1KnYUEFEZMejkwfBP4tK4Q4BGiFcbI4RJPoJMI2JDEBAe
 B
X-Google-Smtp-Source: AGHT+IFhFoquZWowIOxNx0Ov4CvVfco7sFdbAGelYS7jLuKzzw2hgKb8CAmPZ0GVe6KqbVkhrJIUOg==
X-Received: by 2002:a05:6000:1868:b0:37e:f1ed:67e8 with SMTP id
 ffacd0b85a97d-38225a21d77mr2952048f8f.35.1731684087066; 
 Fri, 15 Nov 2024 07:21:27 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382224253f6sm3301155f8f.111.2024.11.15.07.21.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/10] accel/tcg: Remove cpu_unwind_state_data() unused
 CPUState argument
Date: Fri, 15 Nov 2024 16:20:49 +0100
Message-ID: <20241115152053.66442-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/translate-all.h | 3 +--
 accel/tcg/translate-all.c    | 2 +-
 target/i386/helper.c         | 3 ++-
 target/openrisc/sys_helper.c | 7 +++----
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
index f06cfedd52..9303318953 100644
--- a/include/exec/translate-all.h
+++ b/include/exec/translate-all.h
@@ -23,7 +23,6 @@
 
 /**
  * cpu_unwind_state_data:
- * @cpu: the cpu context
  * @host_pc: the host pc within the translation
  * @data: output data
  *
@@ -32,7 +31,7 @@
  * function returns false; otherwise @data is loaded.
  * This is the same unwind info as given to restore_state_to_opc.
  */
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
+bool cpu_unwind_state_data(uintptr_t host_pc, uint64_t *data);
 
 /* translate-all.c */
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fdf6d8ac19..8d5530e341 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -243,7 +243,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
     return false;
 }
 
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
+bool cpu_unwind_state_data(uintptr_t host_pc, uint64_t *data)
 {
     if (in_code_gen_buffer((const void *)(host_pc - tcg_splitwx_diff))) {
         TranslationBlock *tb = tcg_tb_lookup(host_pc);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 01a268a30b..b848936441 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -29,6 +29,7 @@
 #endif
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
+#include "exec/translate-all.h"
 #include "tcg/insn-start-words.h"
 #endif
 
@@ -526,7 +527,7 @@ static inline target_ulong get_memio_eip(CPUX86State *env)
     uint64_t data[TARGET_INSN_START_WORDS];
     CPUState *cs = env_cpu(env);
 
-    if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
+    if (!cpu_unwind_state_data(cs->mem_io_pc, data)) {
         return env->eip;
     }
 
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 77567afba4..67e1f53fca 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/translate-all.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
 #ifndef CONFIG_USER_ONLY
@@ -219,7 +219,6 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 #ifndef CONFIG_USER_ONLY
     uint64_t data[TARGET_INSN_START_WORDS];
     MachineState *ms = MACHINE(qdev_get_machine());
-    CPUState *cs = env_cpu(env);
     int idx;
 #endif
 
@@ -260,7 +259,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
         return env->evbar;
 
     case TO_SPR(0, 16): /* NPC (equals PC) */
-        if (cpu_unwind_state_data(cs, GETPC(), data)) {
+        if (cpu_unwind_state_data(GETPC(), data)) {
             return data[0];
         }
         return env->pc;
@@ -269,7 +268,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
         return cpu_get_sr(env);
 
     case TO_SPR(0, 18): /* PPC */
-        if (cpu_unwind_state_data(cs, GETPC(), data)) {
+        if (cpu_unwind_state_data(GETPC(), data)) {
             if (data[1] & 2) {
                 return data[0] - 4;
             }
-- 
2.45.2


