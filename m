Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2488FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzggS-0005NA-9O; Wed, 24 Apr 2024 13:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzggJ-0005ID-7a
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzggG-0005aI-IJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:45:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b21ed19f5so735275e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713980714; x=1714585514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffMjM79d07wntpDOb5AXkdSL7inATxjs1KjISEI2gk0=;
 b=WY2fiU1Gq9sVpZTr+OknAg6ndnCEak4gpIrUBLHJYveYu8iUVtRh3MqNvwHU2NObnE
 5I85uiAI1l4ga3JOBFafaIrJnfY/RzqaqZKI6JmKWH3it0mDJgT22yJ9WX0n04N1VYD8
 SCE25QPhTOW1/MOb1mRijXVkZJc1PUmhlPiSoDHY0d7ESM42mgwZaQ+WeVd2VBh0B5L/
 PmRo0Oh4wWMwLPTwtM2APr1pXXBLlezyFKtYF0HXOrlDAf4XJA6SNuDKOPpe7xTa9AHd
 82A/csHqPPaza7LRcw+GcUJX4folRBTQLq4cakiEFaO5q0adY2wL5ApWIKmw3gvKIq0G
 CpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980714; x=1714585514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ffMjM79d07wntpDOb5AXkdSL7inATxjs1KjISEI2gk0=;
 b=lvLgW9q03PEQRxpmVQqfD1z4YxsOVFcdQqE7nTNDDV1WzeYNc0OkdyBw2OggUvxnkL
 cYuVF7BTVUyI+t1/Aid1FAGPRDYGEwQSaBIdaX2crj5gVdrJXE+Lbm+YCvHJ+AxpMYZQ
 X6h2T4LgQUKbat3cQgmE7Wi+fCmGk1zQzVY5VL7az43HefpBfy3VzHfAeiapFt6Wg0uP
 RPPmpb3Xkcv4abE5lPqvAGE752TjFHyD5UhFYtWQMqL3HAKpK7zaetrwCm8O0NfU6gUO
 QssKzJx0qCvKjGfqCz4ZDwWdiM2aPs0HC7bpX+5spQiUEnbJ1YEhmCruSATFw7KI+KBl
 b2Iw==
X-Gm-Message-State: AOJu0Yy/rorSMOWV9BnGNJxllTAcJ3c3jKdakHHqakTiImc3AKS6s0zF
 7jyVC3qlMAmFJuvWD3BXtShMVosp9QaD2LH8ouGgZCBgvbkvbM0G+sBlWKvXA6QKfDEAIKbt1D2
 E
X-Google-Smtp-Source: AGHT+IGIuupV0ql2YgJ9a9tFdXWbz3g5lJuRfnNv+s6aZvUhtifGGGmwysAJoP2/nfLW80diZwgsaA==
X-Received: by 2002:a05:600c:198b:b0:416:605b:5868 with SMTP id
 t11-20020a05600c198b00b00416605b5868mr2399343wmq.35.1713980714392; 
 Wed, 24 Apr 2024 10:45:14 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a5d6445000000b0034659d971a6sm17637310wrw.26.2024.04.24.10.45.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 10:45:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] accel/whpx: Use accel-specific per-vcpu @dirty field
Date: Wed, 24 Apr 2024 19:45:04 +0200
Message-ID: <20240424174506.326-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424174506.326-1-philmd@linaro.org>
References: <20240424174506.326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

WHPX has a specific use of the CPUState::vcpu_dirty field
(CPUState::vcpu_dirty is not used by common code).
To make this field accel-specific, add and use a new
@dirty variable in the AccelCPUState structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 31eec7048c..b08e644517 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -237,6 +237,7 @@ struct AccelCPUState {
     uint64_t tpr;
     uint64_t apic_base;
     bool interruption_pending;
+    bool dirty;
 
     /* Must be the last field as it may have a tail */
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
@@ -839,7 +840,7 @@ static HRESULT CALLBACK whpx_emu_setreg_callback(
      * The emulator just successfully wrote the register state. We clear the
      * dirty state so we avoid the double write on resume of the VP.
      */
-    cpu->vcpu_dirty = false;
+    cpu->accel->dirty = false;
 
     return hr;
 }
@@ -1394,7 +1395,7 @@ static int whpx_last_vcpu_stopping(CPUState *cpu)
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-    if (cpu->vcpu_dirty) {
+    if (cpu->accel->dirty) {
         /* The CPU registers have been modified by other parts of QEMU. */
         return cpu_env(cpu)->eip;
     } else if (exit_context_valid) {
@@ -1713,9 +1714,9 @@ static int whpx_vcpu_run(CPUState *cpu)
     }
 
     do {
-        if (cpu->vcpu_dirty) {
+        if (cpu->accel->dirty) {
             whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
-            cpu->vcpu_dirty = false;
+            cpu->accel->dirty = false;
         }
 
         if (exclusive_step_mode == WHPX_STEP_NONE) {
@@ -2063,9 +2064,9 @@ static int whpx_vcpu_run(CPUState *cpu)
 
 static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->accel->dirty) {
         whpx_get_registers(cpu);
-        cpu->vcpu_dirty = true;
+        cpu->accel->dirty = true;
     }
 }
 
@@ -2073,20 +2074,20 @@ static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
     whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
-    cpu->vcpu_dirty = false;
+    cpu->accel->dirty = false;
 }
 
 static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
     whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
-    cpu->vcpu_dirty = false;
+    cpu->accel->dirty = false;
 }
 
 static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    cpu->vcpu_dirty = true;
+    cpu->accel->dirty = true;
 }
 
 /*
@@ -2095,7 +2096,7 @@ static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
 
 void whpx_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->accel->dirty) {
         run_on_cpu(cpu, do_whpx_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -2235,7 +2236,7 @@ int whpx_init_vcpu(CPUState *cpu)
     }
 
     vcpu->interruptable = true;
-    cpu->vcpu_dirty = true;
+    cpu->accel->dirty = true;
     cpu->accel = vcpu;
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
-- 
2.41.0


