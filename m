Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3584C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RUo-0005nb-2y; Fri, 26 Apr 2024 15:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUN-0002tD-3c
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:08 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUI-0003P6-8n
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:06 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a55b3d57277so316891666b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160640; x=1714765440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBK1Qu77lYfBqxGndHp709YTz7kNkXLsmRyQsGRMcEU=;
 b=r2rxBUEsmBXhdcL/Cv8yQH7KGkdVJLiXZydeHpRiE14FVDY8tNzlf9ZlAwt4lpMida
 Ob7VFUj9omXu6R+RQKMw5LOpNZjgqI1TYAlQj83b/GKuFfwi9lHm+X9qHtH+mjZPjsqn
 61B+1tAhQCw08FBKSFHUQxSyaB86qJ8EYLIqw/jQJlocW/La4zJh5QGTeiKr6t9xopJm
 yG8Z9LBtIpwnfjABBoSZtJnEeK60Ia4RgxBUmSVZI01b2hp4YUZhHTpJPP12DtYcRSaf
 pEnGS0xp1H2MHtxGWN8e4MeYP/CteIZOMR8/6tNZUIChL0EMMVshS2/xXlxQRk/Gt0V+
 eisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160640; x=1714765440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBK1Qu77lYfBqxGndHp709YTz7kNkXLsmRyQsGRMcEU=;
 b=SRoGkjtTxlHEoAuE1bNoMe6BQuf0XWdKl/STGbt2OCVhQP7GLeZbYmttPoBcdmAi0T
 AFd4YXpZuEf0pk6ROtBDQ8ABL1fIfFoJ6iY6XTTW/WEpantqCxQqodcBwv5Nc+1JTHV9
 SgGSs+hz1fepxGQuyDYaC2q2KC+8o4ddP4IwP8WMI1hqPl09yD7zpN3So0QV3gLxtDPJ
 edBIQJiWUqM+ZUOhZIQRnDG3poTEaaBCarRAhWL8y1Ii2g4ZJk6biSi9Y31nl0y8Uima
 p5F0zAm9VwWBta6eMMPT3i3ixK4lox17rZfqkIi7ofya0Sci0D0ZngTu4GtrXsbh/QX6
 onag==
X-Gm-Message-State: AOJu0YwiH7+SC6euLMtWEwkcts6pNKHIkdVlU4OYS6EOh3QqTaxgnIK0
 OVu40OubqQwISEKMb2YC6DhAy7swxYOiezdlTyv7vmAb2p1XPxPVu2HFbZCgQayXqDwWwruYCkj
 bQRA=
X-Google-Smtp-Source: AGHT+IG2KejcaQxxNvwM4AvtvsuYlWilmTZn7IIFLKpackbvy2DNtb/SdsEvNp02xfuGaCIe/aYX6g==
X-Received: by 2002:a17:906:3506:b0:a55:90f0:bdf2 with SMTP id
 r6-20020a170906350600b00a5590f0bdf2mr2441257eja.32.1714160640241; 
 Fri, 26 Apr 2024 12:44:00 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 k25-20020a1709062a5900b00a55a06d7744sm7902411eje.73.2024.04.26.12.43.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:43:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PULL 20/38] accel/whpx: Use accel-specific per-vcpu @dirty field
Date: Fri, 26 Apr 2024 21:41:40 +0200
Message-ID: <20240426194200.43723-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424174506.326-2-philmd@linaro.org>
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


