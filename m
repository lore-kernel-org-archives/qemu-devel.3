Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB18EB2713
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu7Y-0005pA-1j; Tue, 10 Feb 2026 15:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7W-0005oN-Kd
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:14:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7U-0007nn-MY
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:14:02 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aaecf9c325so1268015ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754439; x=1771359239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srp3JrZ1BiVLkmTdSaWF+Z7j3MJg4Rv2VkDUwj+jfYE=;
 b=bMely8esPODz/3NyocJ44bVdYRxn6zcNDGS2EyC8IGmbK5bYdwBjTy0WSRx5MwLTB/
 9B2W3tP1L+Ltu5/G/CnpcGlnbhIwx103bLHkBEJyf6y/01d73x2RJ3tEZGDH4IIZ3Lei
 pSygoyR8EmH/pJPOcjOZSQW39wjPo6zVZKqjp0c0Z2w6DJA2ljxgyFf4ecpW3EpnFkKY
 +GdIhgqeg/4tHjiwYtoqIofotBeh+AI+utT7DEetJTT+DlLahGIw5TWfTSxYdaQ7w/EC
 yaq+FJL85nVrA5SWwCf7KDYYahRKaDBeu6Z5iSHfoMeKVtnDkhr54omT0hllTmDQwyCo
 pZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754439; x=1771359239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=srp3JrZ1BiVLkmTdSaWF+Z7j3MJg4Rv2VkDUwj+jfYE=;
 b=IyPWoJswgB2FsNDAs645fLXS3izmBeN4KaN80Yx2CDkrjiYSPtyNbEMZE2H84ww8cT
 xeHSNkpoixjccf2/A9SC7gxC5qd0GzVO2Fr+rKCEAm32/64lBWqoFaGB2oWtHhswPhzB
 IbBu837roO5xpeu+3zB/ZqgDj7VfwGa1M7U+ANPu14VQI6NAcz2vnCQEdYrPm4o2tram
 qw+E2Opf71uHrGK3yGKoWeonub9xx54rFD8UAKfJkoRE8cNc3b4sn5ng05DMJbZZo4m5
 r2NNTR2LeXZSPKFPOnjVAxniVNfUPSa0XdjJrm9cn57HOVgMF1lMGQaO+vPMebggqgtS
 tpUw==
X-Gm-Message-State: AOJu0YyAhBVnqVWQywOii6cme1aUr69rDXx3hlR9CRlm0cfIKeTWjMEF
 JvWzZGLO5o0Vt+knwrlwEyNUQCv1b1tHMYLDyuzn9m3cHZZ17pHSJdWYMvonvbyscD0vTse/YXQ
 rdqg9
X-Gm-Gg: AZuq6aJPSl/olV48WzM4EyNFTmMhVaNgKOIMicPpThDQVxvxwSJU8Pq3e+1Knuuenrv
 Ej1KVS0njcQ4LCAW+3Xj/mTLl9Vd+DDUrZbcH1OPyOqlfGV5CUwOBRZ4xDQ+CqCJGQ+icKFFSEj
 ZF77b3Yq2o7/p1vv4YeUtCuGT9Uw6qOn8Px5S4hQ55pHVAk5Kh8mT1m2EmFq/0gSNNcGRZMkp5v
 ayNJdT/MnbpGq2uE3FJwPsasKCJQy6hRxlAVaC2lVo1mu6ewBcnZG7tT48pJJNWGsmi4zBmeGB0
 hIfxe9g97AnmZA+vAnCfEFBjmWW9sAr+9nRatVXVoc8A6S2cC1AjcBGcdA9iJTa9OPj7QTCNtDN
 U0q+cZDRi7uwaMBPvz9GEfVjs6rWWhruQA4cZwAuUbrbdwqlGzxz0mS8L9VbBZogJdGOhWcAcvo
 Wmzi+07xgoCgL04DFebaGdWdwadMO2e9iM7Zl76OVnMCNnY5BtG4y7Sft5Uz7iRxBGLCVu8YrFA
 fSb
X-Received: by 2002:a17:902:e74b:b0:2aa:e4f2:f076 with SMTP id
 d9443c01a7336-2ab1007a93emr39343155ad.8.1770754439108; 
 Tue, 10 Feb 2026 12:13:59 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb5e3e8csm13930031a12.21.2026.02.10.12.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:13:58 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 philmd@linaro.org, anjo@rev.ng, brian.cain@oss.qualcomm.com
Subject: [PATCH 4/4] contrib/plugins/uftrace: add riscv64 support
Date: Tue, 10 Feb 2026 12:13:44 -0800
Message-ID: <20260210201344.1403613-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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


