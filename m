Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91360C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mbA-0006FF-Fw; Tue, 30 Apr 2024 08:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mb9-0006Ey-4o
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:39 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mb6-0001m6-5h
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:37 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5724e69780bso6122112a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480113; x=1715084913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vs8/EwahA8HMee2TONOEQYHYQ4HWUqmabB9riV3Xfko=;
 b=ER0SWZOCgMyMM158Ts1gcX7wbA0x8jiQY0TIbphtFX9y7LFDbCHX4PtmLsdpqtZKF4
 BQ3t5A2CWCqYbEIHm4wRBeV50qlzL5M4JyOW7CpuW8BcOKrUO3bS05y40vBKvX2WZSoT
 8EL1II0m7LbrElb1gq5f8PaRxTnTTYzB1/G69+GBBUgYsqEA7EtXL8uH4VbV+kmZd7cs
 xOW7+3uUG86YwiljRJnEhPZZWrcguE7J1ahuUbDH9Z0LDIWNB3DltfDUgjUppgnm+pUP
 1yGV9+5gfrBj4CGYA7i1SkxTjEtA21i/Ya6rUtZz5J4YwRy3DBpUZyxAjT71C8fvxntd
 05vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480113; x=1715084913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vs8/EwahA8HMee2TONOEQYHYQ4HWUqmabB9riV3Xfko=;
 b=If9il+aJ+52WYMdVmU/dQ685IXRtpuw8Gv4A7ltL5oPcr1BtzTHF3oQTDq1DFSC515
 mpd26X0/HNN2ItD3JdJSBlSWUujPUMB0mso4DxLe/TJSFhYZ6Xd2fzZhD4+WYZ52/dph
 eA01IAnkoyYmgqS+Ml+qIZ0uvagOJJ39t/b2Qf0Ty3uetKcxpycvfsjO/Wzhv5uj2tmv
 NpJR2PCK5KNgaoTOAvHb4Se0MwkSQA+ubIPG0c/HwPueSR47zN2ffr+iqr6ZG9VSUGsc
 crOFMJ1pd9CQ9Rb4rXFTyky+3fT6nuojc7zYflqXioyrRIGGgK1+iMQmN6YbfvFn2frG
 UXUA==
X-Gm-Message-State: AOJu0Yye06MhZcN7DBVQ5S1R3nTtHzlgTXKtvSHdB7GeUXUcyIuBW2lZ
 fexbfYs72cmm0qTFc4ouu+bNwkm5IR1acy6dDz4S9lEi//tDM1RfNUp1X0CrgeTp8mJyby6WtJj
 8
X-Google-Smtp-Source: AGHT+IFsK2+13HtZRS6ctq+u+XyFgE0+bqmugd+oEdgd4bd3pgLryIzH9k72jTSxUOulsD9ArGWFWg==
X-Received: by 2002:a05:6402:3496:b0:572:8aab:441c with SMTP id
 v22-20020a056402349600b005728aab441cmr2988718edc.26.1714480113524; 
 Tue, 30 Apr 2024 05:28:33 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 c26-20020aa7c99a000000b00572405680e8sm5631919edt.21.2024.04.30.05.28.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/13] accel/tcg: Move @plugin_state from CPUState to TCG
 AccelCPUState
Date: Tue, 30 Apr 2024 14:27:58 +0200
Message-ID: <20240430122808.72025-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

@plugin_state is specific to TCG accelerator, move it to
its AccelCPUState.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240429213050.55177-5-philmd@linaro.org>
---
 accel/tcg/vcpu-state.h | 5 +++++
 include/hw/core/cpu.h  | 5 -----
 accel/tcg/plugin-gen.c | 4 +++-
 hw/core/cpu-common.c   | 3 ++-
 plugins/core.c         | 7 ++++---
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index e30368edae..35c2695a77 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -10,11 +10,16 @@
 
 /**
  * AccelCPUState: vCPU fields specific to TCG accelerator
+ * @plugin_state: per-CPU plugin state
  */
 struct AccelCPUState {
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
 #endif /* !CONFIG_USER_ONLY */
+
+#ifdef CONFIG_PLUGIN
+    CPUPluginState *plugin_state;
+#endif /* CONFIG_PLUGIN */
 };
 
 #ifdef CONFIG_USER_ONLY
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 571ef3e514..91e793e590 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -423,7 +423,6 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
- * @plugin_state: per-CPU plugin state
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
  *    CPU do_transaction_failed hook function.
@@ -514,10 +513,6 @@ struct CPUState {
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
 
-#ifdef CONFIG_PLUGIN
-    CPUPluginState *plugin_state;
-#endif
-
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index fd268c79b5..88d720d549 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -52,6 +52,7 @@
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
 #include "exec/helper-proto-common.h"
+#include "accel/tcg/vcpu-state.h"
 
 #define HELPER_H  "accel/tcg/plugin-helpers.h"
 #include "exec/helper-info.c.inc"
@@ -872,7 +873,8 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 {
     bool ret = false;
 
-    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_state->event_mask)) {
+    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS,
+                 cpu->accel->plugin_state->event_mask)) {
         struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
         int i;
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index f2826d0409..ea342213d6 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #ifdef CONFIG_PLUGIN
+#include "accel/tcg/vcpu-state.h"
 #include "qemu/plugin.h"
 #endif
 
@@ -215,7 +216,7 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
     /* Plugin initialization must wait until the cpu start executing code */
 #ifdef CONFIG_PLUGIN
     if (tcg_enabled()) {
-        cpu->plugin_state = qemu_plugin_create_vcpu_state();
+        cpu->accel->plugin_state = qemu_plugin_create_vcpu_state();
         async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
     }
 #endif
diff --git a/plugins/core.c b/plugins/core.c
index a097d02788..722224e5d8 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -28,6 +28,7 @@
 #include "exec/tb-flush.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
+#include "accel/tcg/vcpu-state.h"
 #include "plugin.h"
 
 struct qemu_plugin_cb {
@@ -55,7 +56,7 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
 
 static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
 {
-    bitmap_copy(cpu->plugin_state->event_mask,
+    bitmap_copy(cpu->accel->plugin_state->event_mask,
                 &data.host_ulong, QEMU_PLUGIN_EV_MAX);
     tcg_flush_jmp_cache(cpu);
 }
@@ -396,7 +397,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL;
 
-    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
+    if (!test_bit(ev, cpu->accel->plugin_state->event_mask)) {
         return;
     }
 
@@ -418,7 +419,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
 
-    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
+    if (!test_bit(ev, cpu->accel->plugin_state->event_mask)) {
         return;
     }
 
-- 
2.41.0


