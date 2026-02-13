Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302ADEEA86E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqhH1-0003nc-FQ; Thu, 12 Feb 2026 19:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhH0-0003nE-EV
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:06 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGy-0000ql-LJ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:06 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8249aca0affso245633b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770943383; x=1771548183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rk8/s27IDHW4parj5IMaohWkfowsvr1X/ujkaJmQXGs=;
 b=QTQQUpyCx7XFkMYYlrmheYp8Iyak49B2o0kI9PsfqCIEJ1jTexZePGFLjSSKLGt4bC
 SnWn4MscJHOn7k3EXi3PkeXpoEuLAdOzSgZD2pW9iLqVkwveEqYjJbE41BWgB3g679Pm
 Xt2hoLzlSiItE0AYnejgT0hoTpgaUzYoWb8qoMeHVytmBdD7xStjcuYvaejR9ttCpnD5
 kH4kTQ2oLMyYn1WTFwSXBpOZhuHQP1+aR2di48dLG6mW41KdlPo8OZpQXaAMs4V0Pm3Q
 rpMQPykSkjix7M08hCSRkS6yFzJMvZv+MI2qreZiQZ4wfLLoK+7RyJ18MIOLYbJ1J2RG
 67aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770943383; x=1771548183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rk8/s27IDHW4parj5IMaohWkfowsvr1X/ujkaJmQXGs=;
 b=n1tK4PCGSBDUAnd4iC06n9SSBYd2Imq/w/hvLEd8EtYDJpfqFfXU5fSGbFFV4wm8lj
 Zbihaj1eSYnzLraNhm3ZVrE/3BYiMkZDlLpZFg0/h7754USJeMy2m4S81etCoSXMTp8o
 RJNBQ6Z1ZY/526vTwfNxzmfvOQq5I0E11Um4yZ9IyNb/EJ42BvlB7Zkw45ndul73ZuLT
 MIEGCgU/gz3uneVvTu3JAYrvYCOEZ5P+0/7BXZnSmy2px+48jHAMONTdWuQjl9T5i3WO
 XJI3aVBacrToTsTvtaWy8t5+EMatnROPukNqTrDmyJMKl4gFiu9znZ435lhlSQrid6xA
 hzNA==
X-Gm-Message-State: AOJu0Yy0WcDaSRRUUsEDFuPizYTsO7x3IaROJgSMz1xgrcw2pHOmclU6
 iNJMLWkby4mgRqUDIVzusWpEQa5oKQItVeY0lRaRcnaVh5wp8tgudrldOrvmFn7DR5akJmKtdiL
 UKWCj
X-Gm-Gg: AZuq6aIam5QCnY/M48PZ9ypq21KKT9I4G5KgHHZI+V9yKpdcGhS22cDOuVYzXF+Bpdq
 gtYeRvSk5WyC1gJX5n1A24eBOPGz9YtIaS3BQtnT+/IkVedfmD5lLOm6L/h8SMraRmXM0Qr0NA1
 lQrewESeqzZ7kcI9C++i+0BtHISVoZz5mtHlWNIIFri6btvnx3OWNRCoTq/xXlWCwANuztgQYKX
 Xw0gKSXgKYJHZEbfMpjkhoxvNdU3CkK2eU1cgIZLjf3ev1oNixqSjlSabnqtYQd+axKlVjyFxvp
 XXYVKhfyZEVAmkRH81bjWe1WAKsq+Kxgod86Y73NfPdYAL/gR/Q4KqRSzkvPlzvT+8v3y/tSt7b
 A1DhuG8kpF7SDoQ4WBg7SVJspr87vM1URABdfNGHTWiJo2re/B8tQSN4c2JDvEuoGUVf5zuaX+g
 bZTTenjmUXiR02/32d+bptA7SSNxzlRnxTGTnFLmivJt+d+Y5oJp57O8lyIpbvfTZu9B99WX/fh
 TUg
X-Received: by 2002:a05:6a00:4515:b0:81f:4dfe:ddd5 with SMTP id
 d2e1a72fcca58-824c94458eamr301360b3a.4.1770943383053; 
 Thu, 12 Feb 2026 16:43:03 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a431f2sm504326b3a.22.2026.02.12.16.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 16:43:02 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 4/4] contrib/plugins/uftrace: add riscv64 support
Date: Thu, 12 Feb 2026 16:42:54 -0800
Message-ID: <20260213004254.493059-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
References: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260210201344.1403613-5-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst  | 10 +++--
 contrib/plugins/uftrace.c | 87 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index f547e118eef..76c6ea92ca9 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -836,8 +836,8 @@ Uftrace
 This plugin generates a binary trace compatible with
 `uftrace <https://github.com/namhyung/uftrace>`_.
 
-Plugin supports aarch64 and x64, and works in user and system mode, allowing to
-trace a system boot, which is not something possible usually.
+Plugin supports aarch64, x64 and riscv64, and works in user and system mode,
+allowing to trace a system boot, which is not something possible usually.
 
 In user mode, the memory mapping is directly copied from ``/proc/self/maps`` at
 the end of execution. Uftrace should be able to retrieve symbols by itself,
@@ -872,7 +872,7 @@ Performance wise, overhead compared to normal tcg execution is around x5-x15.
     - Description
   * - trace-privilege-level=[on|off]
     - Generate separate traces for each privilege level (Exception Level +
-      Security State on aarch64, Rings on x64).
+      Security State on aarch64, Privilege levels on riscv64 and Rings on x64).
 
 .. list-table:: uftrace_symbols.py arguments
   :widths: 20 80
@@ -976,6 +976,10 @@ You can follow the exact same instructions for a x64 system, combining edk2,
 Linux, and Ubuntu, simply by switching to
 `x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
 
+You can follow the exact same instructions for a riscv64 system, combining
+opensbi, Linux, and Ubuntu, simply by switching to
+`riscv64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/riscv64>`_ branch.
+
 To build and run the system::
 
     # Install dependencies
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 21ac1402047..e3c65a1c930 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -99,6 +99,19 @@ typedef struct {
     struct qemu_plugin_register *reg_cr0;
 } X64Cpu;
 
+typedef struct {
+    struct qemu_plugin_register *reg_fp;
+    struct qemu_plugin_register *reg_priv;
+} Riscv64Cpu;
+
+typedef enum {
+    RISCV64_USER,
+    RISCV64_SUPERVISOR,
+    RISCV64_RESERVED,
+    RISCV64_MACHINE,
+    RISCV64_PRIVILEGE_LEVEL_MAX,
+} Riscv64PrivilegeLevel;
+
 typedef struct {
     uint64_t timestamp;
     uint64_t data;
@@ -681,6 +694,78 @@ static CpuOps x64_ops = {
     .does_insn_modify_frame_pointer = x64_does_insn_modify_frame_pointer,
 };
 
+static uint8_t riscv64_num_privilege_levels(void)
+{
+    return RISCV64_PRIVILEGE_LEVEL_MAX;
+}
+
+static const char *riscv64_get_privilege_level_name(uint8_t pl)
+{
+    switch (pl) {
+    case RISCV64_USER: return "User";
+    case RISCV64_SUPERVISOR: return "Supervisor";
+    case RISCV64_RESERVED: return "Unknown";
+    case RISCV64_MACHINE: return "Machine";
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint8_t riscv64_get_privilege_level(Cpu *cpu_)
+{
+    Riscv64Cpu *cpu = cpu_->arch;
+    return cpu_read_register64(cpu_, cpu->reg_priv);
+}
+
+static uint64_t riscv64_get_frame_pointer(Cpu *cpu_)
+{
+    Riscv64Cpu *cpu = cpu_->arch;
+    return cpu_read_register64(cpu_, cpu->reg_fp);
+}
+
+static uint64_t riscv64_get_next_frame_pointer(Cpu *cpu_, uint64_t fp)
+{
+    return cpu_read_memory64(cpu_, fp - 16);
+}
+
+static uint64_t riscv64_get_next_return_address(Cpu *cpu_, uint64_t fp)
+{
+    return cpu_read_memory64(cpu_, fp - 8);
+}
+
+static void riscv64_init(Cpu *cpu_)
+{
+    Riscv64Cpu *cpu = g_new0(Riscv64Cpu, 1);
+    cpu_->arch = cpu;
+    cpu->reg_fp = plugin_find_register("fp");
+    g_assert(cpu->reg_fp);
+    cpu->reg_priv = plugin_find_register("priv");
+    g_assert(cpu->reg_priv);
+}
+
+static void riscv64_end(Cpu *cpu)
+{
+    g_free(cpu->arch);
+}
+
+static bool riscv64_does_insn_modify_frame_pointer(const char *disas)
+{
+    /* fp is s0 in disassembly */
+    return strstr(disas, "s0");
+}
+
+static CpuOps riscv64_ops = {
+    .init = riscv64_init,
+    .end = riscv64_end,
+    .get_frame_pointer = riscv64_get_frame_pointer,
+    .get_next_frame_pointer = riscv64_get_next_frame_pointer,
+    .get_next_return_address = riscv64_get_next_return_address,
+    .get_privilege_level = riscv64_get_privilege_level,
+    .num_privilege_levels = riscv64_num_privilege_levels,
+    .get_privilege_level_name = riscv64_get_privilege_level_name,
+    .does_insn_modify_frame_pointer = riscv64_does_insn_modify_frame_pointer,
+};
+
 static void track_privilege_change(unsigned int cpu_index, void *udata)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
@@ -890,6 +975,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         arch_ops = aarch64_ops;
     } else if (!strcmp(info->target_name, "x86_64")) {
         arch_ops = x64_ops;
+    } else if (!strcmp(info->target_name, "riscv64")) {
+        arch_ops = riscv64_ops;
     } else {
         fprintf(stderr, "plugin uftrace: %s target is not supported\n",
                 info->target_name);
-- 
2.47.3


