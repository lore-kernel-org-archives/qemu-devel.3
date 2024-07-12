Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60594C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEd7-0007nf-0X; Fri, 12 Jul 2024 07:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSEd3-0007mP-Rw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:39:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSEd1-0005DR-TY
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:39:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42679f33fefso12693085e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720784392; x=1721389192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qzrqy4xZtYfOCZcOV4JdoM5syuVE4DAO9tvUdp9cVHA=;
 b=w0slXDEpXU6/yHnnFD9Ae34I7kRZ9rUcNlwLder9gokw2NwnJoMzYg2JjtLNrxI3qW
 elQnAqDr5ct/OiG96Z7sW0PkSRWhssqGo7w/S2Tb6D4IlXSgxF+bX44nIQqdDK8UF72H
 ROHo8V+us08uyKaPO0+gyhFPh3I4UMXRdbp4Jy5RY4rhgS2FoNHuO57bhkq0DpjStHnQ
 jsJhg5nBhWJLdZKdHhWPTh1NkZMO+q3b67nrZCZqPT7sgsGxCqW9MLwj0bhfGieQZIRL
 LhiXFzxDIFTXreRarSuhl448DJQa3hygzqkgmHdoRYu9mI7s6WUxjo70TpaHdKNvJHrQ
 QFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720784392; x=1721389192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qzrqy4xZtYfOCZcOV4JdoM5syuVE4DAO9tvUdp9cVHA=;
 b=iz3qKw/0w8PnYJ2zBpLQwTZ5A02yaXMaWJAeB61Us9Rm5icQsxPRgxdp7fLyQExpEc
 O3Se/7MfcWsVE3/v8a9hIknnz+720IiDmrPs3lZXvRhz6hpWEGJFDSstcdQVnxiqAWgb
 Asqovr8g4pchm6Ps9rFg4u8Dc4SY0W2QjPiOMWcwl5rSe38YvFa0sv/9l2h4XKfx/per
 KckL3McoWNH7aTRjiZoBmdTmdK4ZH7SvW2zBrSdY6VTP37xLEnf4jdNDgztCftkdOn+r
 6VEgGrDLhPPSj6dtV9tayuNqWHhKSS1TBEQTjBWTW/83rMP2qFB6O52SgC79Moqslirc
 /jAA==
X-Gm-Message-State: AOJu0YzZowLVa+dJ+0vMbhjdzC/Vg0hYV16fU3qJiLBvXN4lg6qrhVLW
 t/RQp5DWmeiyt0Q/LJ8Lhjrqa06TgqpoawACCSJ1quTy5x7cmMgfUU2hsd+SNtyInItijrqUw8b
 LlGo=
X-Google-Smtp-Source: AGHT+IGpqoYbfIXqjJNI9xo7Z/buUB7yPUmn8JVqr0vMBp5ioTwY6+MJMn59oTngs6NUpYz19jsGfw==
X-Received: by 2002:a05:600c:5748:b0:426:597c:7d58 with SMTP id
 5b1f17b1804b1-426708fabf5mr70773865e9.39.1720784392160; 
 Fri, 12 Jul 2024 04:39:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23999csm21271065e9.8.2024.07.12.04.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 04:39:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH] accel/tcg: Make cpu_exec_interrupt hook mandatory
Date: Fri, 12 Jul 2024 12:39:49 +0100
Message-Id: <20240712113949.4146855-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The TCGCPUOps::cpu_exec_interrupt hook is currently not mandatory; if
it is left NULL then we treat it as if it had returned false. However
since pretty much every architecture needs to handle interrupts,
almost every target we have provides the hook. The one exception is
Tricore, which doesn't currently implement the architectural
interrupt handling.

Add a "do nothing" implementation of cpu_exec_hook for Tricore,
assert on startup that the CPU does provide the hook, and remove
the runtime NULL check before calling it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/cpu-exec.c | 4 ++--
 target/tricore/cpu.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 245fd6327da..9010dad0738 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -857,8 +857,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         else {
             const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-            if (tcg_ops->cpu_exec_interrupt &&
-                tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
+            if (tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
                 if (!tcg_ops->need_replay_interrupt ||
                     tcg_ops->need_replay_interrupt(interrupt_request)) {
                     replay_interrupt();
@@ -1080,6 +1079,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         /* Check mandatory TCGCPUOps handlers */
 #ifndef CONFIG_USER_ONLY
         assert(cpu->cc->tcg_ops->cpu_exec_halt);
+        assert(cpu->cc->tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
         cpu->cc->tcg_ops->initialize();
         tcg_target_initialized = true;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 4d9c0368f2b..1a261715907 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -155,6 +155,11 @@ static void tc37x_initfn(Object *obj)
     set_feature(&cpu->env, TRICORE_FEATURE_162);
 }
 
+static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    /* Interrupts are not implemented */
+    return false;
+}
 
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -169,6 +174,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .tlb_fill = tricore_cpu_tlb_fill,
+    .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
 };
 
-- 
2.34.1


