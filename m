Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3C2FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcl2-0006Av-Rc; Wed, 06 May 2026 09:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcl1-00060J-BL
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcky-0008AG-Jr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488d2079582so67253995e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075862; x=1778680662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qB5su2eFZnP8oQgJ5Fgov2Yx3AulDJhKn7UhrfmzMqc=;
 b=SQvIuGqmuES3BaQKPRvoUp9HiwEbial4DwYu0rHOZyT2GvNfdJa5/1n60R9hJepfQT
 ZW5ELtWUxDzD4GvnlD9fT+5e9yJ/QbcYmHgXk0ldVm8HTfOLSDxd67/k2/jDKCSeFkya
 BWB8P09/fB89d/z1Oz4w4rFIbE/KjG06KSfbC60Oyfs4n3sOUMHHlo2Al+UhRCuVfawJ
 6zYcB/gqZSdcpQqt8RQ52DXGzgP/bRCUdkx+0nmdeFyMj5jZGYcmkTPczP/WlogzQiiZ
 OiNcEMKRp45/G+jASmuCQgBXSJy1+fu6GB/GedQFRFLrMbHxivSlyTFlUElNCDD0i6aS
 Quuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075862; x=1778680662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qB5su2eFZnP8oQgJ5Fgov2Yx3AulDJhKn7UhrfmzMqc=;
 b=V+ObDglT4JcYqmmT5uUuXcgDOvs60d5UlBhFrqbeH8ZiFOjCv+Zc9KGcfMDKj9nCQR
 UFYh82Y6BrAOi54KjNChFir+QsLuUMOISY3UaCxvVmZf4RSWy51YuQFaVqNxQCRLWYye
 KjBtztA221qf5RxwgPj354C3YNB7niEkSBYsDZEsbJ2OgWnG5iDYYracXIQKSMoLZJVT
 HnXi6C3+XD441IKdVttF2ZSIImT1Y8VcPIeBJ0K9gb0Gb/ePbiReQICUHUzZWWgrCnin
 lXbCeTcQ0jmyrgM3gNydSEKlDTBRe29JEj/ElyXWa0YQPS4WaropbpOraWdNQENXox5z
 VqhQ==
X-Gm-Message-State: AOJu0Yyust+JrloC6VW5mmDJ0CvYH4GsYJisr3/t9skDCtK7tXSIo/pB
 GILNUe3m5n7MUgH0rQvvX2V3H/GcgcMhHAp6PUXeYqTqXWkghPtY/tmwZSVN1uTqKHwutCVrnNw
 2XNEjdlE=
X-Gm-Gg: AeBDievQQUJWAMCQPKfpKZOj0720KGOSJzGo0FDji6pMs5BIw0qHADSgo0q5U+DNTMW
 aASys3sSA9VXjkAljKUpL2J4V56AUA/lpZkqtSinAiaq+o0vzIB/EUjInskus4OOhGsFno5oGis
 /TdsRhh8dJUJdranyXv6NAY7Ed572ccd9UG7fPXqBqP3/IQhMP7BI2wpJoEO4E73iNXS7cugLLJ
 vuWtnffV0RRozDMKdAbyYPkl2bpG56fyGiFkcEfW8pvnrXxebmZ3rS3W9TM60b2lMRL7mQyIaqw
 41iAGQ7QBwQTsK8+Km+Usl1roq9Mnd4S4dqebEjehDgxY73ZTASKiUqIHwouvZFGEWi5XKvJ9rM
 /PqwG9tdJ0OMwoNPHcfRynWWIuyl3gHmzoztnipxDSujcVpakcY2ASvJ5cHPFVTBaY2K3Jm3JHz
 js7rsX47cLY+ZhShpINdd0tQbWqyZ5T92Id0BQSU/SShqEJRQFfKIy3M5bSqfnKYnlISBDWZNU/
 DgX9xNxLoU=
X-Received: by 2002:a05:600c:4343:b0:48a:563c:c8c5 with SMTP id
 5b1f17b1804b1-48e51e15662mr31878585e9.8.1778075861834; 
 Wed, 06 May 2026 06:57:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5313b023sm28071305e9.5.2026.05.06.06.57.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:57:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 018/110] target/mips: Move count_clock to MIPSCPU struct
Date: Wed,  6 May 2026 15:53:50 +0200
Message-ID: <20260506135524.20617-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The count_clock pointer is not something we can do a shallow copy of,
as linux-user cpu_copy() does, and although it is a system-mode piece
of state we unconditionally create it, so it is present also in
user-mode.

There isn't any need to keep this in the env struct rather than the
CPU struct, so move it to avoid possible memory leaks or
double-usage. This also puts it next to the other Clocks that this
CPU has.

I haven't seen any sanitizer reports about this field, so this is
averting a possible problem rather than correcting an observed one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260317175031.3035740-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h              |  2 +-
 target/mips/cpu.c              |  4 ++--
 target/mips/system/cp0_timer.c | 12 ++++++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index efb6a6df4cd..cbb9b3e1b1c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1188,7 +1188,6 @@ typedef struct CPUArchState {
 
     const mips_def_t *cpu_model;
     QEMUTimer *timer; /* Internal timer */
-    Clock *count_clock; /* CP0_Count clock */
     target_ulong exception_base; /* ExceptionBase input to the core */
 } CPUMIPSState;
 
@@ -1206,6 +1205,7 @@ struct ArchCPU {
     CPUMIPSState env;
 
     Clock *clock;
+    Clock *count_clock; /* CP0_Count clock */
     Clock *count_div; /* Divider for CP0_Count clock */
 
     CPUMIPSMVPContext *mvp;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0663cda0036..f803d477632 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -449,7 +449,7 @@ static void mips_cp0_period_set(MIPSCPU *cpu)
 
     clock_set_mul_div(cpu->count_div, env->cpu_model->CCRes, 1);
     clock_set_source(cpu->count_div, cpu->clock);
-    clock_set_source(env->count_clock, cpu->count_div);
+    clock_set_source(cpu->count_clock, cpu->count_div);
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -520,7 +520,7 @@ static void mips_cpu_initfn(Object *obj)
 
     cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
     cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
-    env->count_clock = clock_new(OBJECT(obj), "clk-count");
+    cpu->count_clock = clock_new(OBJECT(obj), "clk-count");
     env->cpu_model = mcc->cpu_def;
 }
 
diff --git a/target/mips/system/cp0_timer.c b/target/mips/system/cp0_timer.c
index afa163c3196..634c2a66bbd 100644
--- a/target/mips/system/cp0_timer.c
+++ b/target/mips/system/cp0_timer.c
@@ -29,14 +29,16 @@
 /* MIPS R4K timer */
 static uint32_t cpu_mips_get_count_val(CPUMIPSState *env)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     int64_t now_ns;
     now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     return env->CP0_Count +
-            (uint32_t)clock_ns_to_ticks(env->count_clock, now_ns);
+            (uint32_t)clock_ns_to_ticks(cpu->count_clock, now_ns);
 }
 
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
+    MIPSCPU *cpu = env_archcpu(env);
     uint64_t now_ns, next_ns;
     uint32_t wait;
 
@@ -46,7 +48,7 @@ static void cpu_mips_timer_update(CPUMIPSState *env)
     if (!wait) {
         wait = UINT32_MAX;
     }
-    next_ns = now_ns + clock_ticks_to_ns(env->count_clock, wait);
+    next_ns = now_ns + clock_ticks_to_ns(cpu->count_clock, wait);
     timer_mod(env->timer, next_ns);
 }
 
@@ -85,11 +87,12 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
      * So env->timer may be NULL, which is also the case with KVM enabled so
      * treat timer as disabled in that case.
      */
+    MIPSCPU *cpu = env_archcpu(env);
     if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer) {
         env->CP0_Count = count;
     } else {
         /* Store new count register */
-        env->CP0_Count = count - (uint32_t)clock_ns_to_ticks(env->count_clock,
+        env->CP0_Count = count - (uint32_t)clock_ns_to_ticks(cpu->count_clock,
                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         /* Update timer timer */
         cpu_mips_timer_update(env);
@@ -116,7 +119,8 @@ void cpu_mips_start_count(CPUMIPSState *env)
 void cpu_mips_stop_count(CPUMIPSState *env)
 {
     /* Store the current value */
-    env->CP0_Count += (uint32_t)clock_ns_to_ticks(env->count_clock,
+    MIPSCPU *cpu = env_archcpu(env);
+    env->CP0_Count += (uint32_t)clock_ns_to_ticks(cpu->count_clock,
                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
 }
 
-- 
2.53.0


