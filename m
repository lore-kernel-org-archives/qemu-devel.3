Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D07AC531DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serJ5-0007G8-Qk; Fri, 16 Aug 2024 03:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ4-00079J-1h
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:30 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ0-00041o-9y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:29 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c3ebba7fbbso1386581a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723793005; x=1724397805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ek2SH+eIGTE6kXSOvmjvmBjlH+328ULsNPwNMVHdkKo=;
 b=d3d/SGShkXUefdLSt0+gzNOudjjOguduOiflw0+b4mU8BXXVZ5UY4HPBXN20KtD7FE
 BVlXyk1SlwlY6vFKtpAGx/lGK3+lWIOmcz2OEQvQowUPeOkklSSODd4vnjL10o7zJ0lr
 yNsycirNjbLXVVSl2nk8/JeQBlCNE1q+3aBkJvptAUtb1WETQDor8cLzCi8FIt2ubWtq
 p1K+BJiySDwqp9oAbNQLhqlaTFZJq1xaJWK3FHrn4/uREjBLdavlzyk1vacoyrffkt6P
 r1XfI2kJKPdSEOxR469kSTQtjudOp0bgXhnR/mbTGJH6E905Yic2seFoNPgb4b6zETCz
 PHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793005; x=1724397805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ek2SH+eIGTE6kXSOvmjvmBjlH+328ULsNPwNMVHdkKo=;
 b=CLzgc3yIiBAwOUjFV0YI1HKdBdcRGIVZnUnn58nwoUfz8WIp59/4FaMsLgG8ebXQQJ
 45Fbq9FKrpE8ZSoIBE54F2vdq+e2dM69zN5SJ2ug9NhoqWe0FLB5rfprkHTI1xs4kCM0
 Er4NWEIHer3XDPon0nfJK6WlyfhEfaddDa35BdsEH6ExlbFR9QZXTpQrtBFl25nHo4t6
 LijODobx26rp24PzB+Yw3HDju+oJBQ+O5xioANQCaIDM41hQhOWnhGsaYMWGImYzfdyE
 Z4Jep8lXbE3E0SqYBOLQdH9bnuOViyZ3kqF4swRk/MAC57Ix8g8TG7r1Gc4aTGVAtxv2
 pgsA==
X-Gm-Message-State: AOJu0Yz/k5wPPVVRAIilaPwIwgnIokBUEdyACGjQo9ZzMujR313be/Cv
 o0J9V5xAY+1wui2TSeLSInMGEb4zE4MD1OQNYwMYKeWx2x1e4JmajtPzJGIhyWPbr8jae1QEQ+U
 ZLyI=
X-Google-Smtp-Source: AGHT+IFPr4Z67P959ODzh1IOqFW0139YPDL0ZJHpy9CtKHLLJJ/bvoox5y4QSKrufw1xwodPhrsOmA==
X-Received: by 2002:a05:6a21:392:b0:1be:c6f8:c530 with SMTP id
 adf61e73a8af0-1c904fc9f79mr2892997637.26.1723793004727; 
 Fri, 16 Aug 2024 00:23:24 -0700 (PDT)
Received: from stoup.. (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f037588esm20195525ad.171.2024.08.16.00.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:23:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: chauser@pullman.com
Subject: [PATCH v3 3/6] target/sparc: Populate sparc32 FQ when raising fp
 exception
Date: Fri, 16 Aug 2024 17:23:08 +1000
Message-ID: <20240816072311.353234-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816072311.353234-1-richard.henderson@linaro.org>
References: <20240816072311.353234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

From: Carl Hauser <chauser@pullman.com>

Implement a single instruction floating point queue,
populated while delivering an fp exception.

Signed-off-by: Carl Hauser <chauser@pullman.com>
[rth: Split from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/int32_helper.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 6b7d65b031..fb6f3799c8 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -21,10 +21,10 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "trace.h"
+#include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "sysemu/runstate.h"
 
-
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
     [TT_ILL_INSN] = "Illegal Instruction",
@@ -116,22 +116,9 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 
         qemu_log("%6d: %s (v=%02x)\n", count, name, intno);
         log_cpu_state(cs, 0);
-#if 0
-        {
-            int i;
-            uint8_t *ptr;
-
-            qemu_log("       code=");
-            ptr = (uint8_t *)env->pc;
-            for (i = 0; i < 16; i++) {
-                qemu_log(" %02x", ldub(ptr + i));
-            }
-            qemu_log("\n");
-        }
-#endif
         count++;
     }
-#if !defined(CONFIG_USER_ONLY)
+#ifndef CONFIG_USER_ONLY
     if (env->psret == 0) {
         if (cs->exception_index == 0x80 &&
             env->def.features & CPU_FEATURE_TA0_SHUTDOWN) {
@@ -143,6 +130,21 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         }
         return;
     }
+    if (intno == TT_FP_EXCP) {
+        env->fsr_qne = FSR_QNE;
+        env->fq.s.addr = env->pc;
+        env->fq.s.insn = cpu_ldl_code(env, env->pc);
+        /*
+         * The sparc32 fpu has three states related to exception handling.
+         * The FPop that signals an exception transitions from fp_execute
+         * to fp_exception_pending.  A subsequent FPop transitions from
+         * fp_exception_pending to fp_exception, which forces the trap.
+         * We do not model the fp_exception_pending state, but we do need
+         * to advance pc/npc to mimic the delayed trap delivery.
+         */
+        env->pc = env->npc;
+        env->npc = env->npc + 4;
+    }
 #endif
     env->psret = 0;
     cwp = cpu_cwp_dec(env, env->cwp - 1);
-- 
2.43.0


