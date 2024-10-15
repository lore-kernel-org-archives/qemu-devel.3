Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEB0CFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jn8-0002xf-HR; Tue, 15 Oct 2024 11:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmw-00025r-FJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:48 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmu-00017g-Ol
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:46 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5eb54257e5eso194527eaf.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007323; x=1729612123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIJ9Az3wLYpKYtaTDQQbceKa5J8Ss6VqLkd1zjwnLbI=;
 b=Dl0sV07MnpbFdj8vm2OAemLOT6gnAMbJxjDjNp5StN81k/4Pk1qwtDkOtU5/n9xj3x
 2LdaOIE4+zYM0at/2DuDeEdB7SH8Bwk1BV9x3xD1eYg/79ESmn3zodifaN5I39gGLQHZ
 OFIa/tvtnUgwk9Fd+fl0jj44LmZjcVyO2X1arHitg9h5RtyFugPRaEWFqFSPj+JqwhhM
 TqGXdQE1i6Efv6HuXbqpm5odjLMUTR8adGDBGeq5E287JLhDpP0vwKAfJqpXAX4kNAYy
 shNTZCd93AjheqckeCOH6mQivzfWYJV+hXjaRCeV01TG+qrTIG6frLVEg7NqyN+N+zzx
 kELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007323; x=1729612123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIJ9Az3wLYpKYtaTDQQbceKa5J8Ss6VqLkd1zjwnLbI=;
 b=tEhi230ihWLYcIAANKIBcgJilnsB99NLInwtT3e3Q+vloY2El+lp5oQDPG+cWmnLLN
 EtPBrW6+xAz1Z9pXTqDP3KtbLdXLr2NPzvcAOSiH09HREcFm5x0ppU7A7a9Sd0JquBiv
 n5uRxgVheDLKA7MrlFpm/jyXCFe9zYOfXo4MCfEnMl+Mv+rdd4+ZbERD3lVMmpUFY7iI
 i98JrPlya68tXITO0D3HxkzXaWyqfhZBFtYIBBNgyOUkZSS8YoL6pkmvMd3SlIrQySa/
 Q/G7vncqJDPjZ+Y+tHlgkg1YCLXrRy+cda0Ml1l8MRSdCPtoOuS7JxfXYEVzqMXBvvF6
 Q8cg==
X-Gm-Message-State: AOJu0Yz+gyxSYS68PLtvW+YVrgliUR/EbY7s2HKYum5Mwjj1UcqXLmwc
 EzzDj0veZdtTCVqdKJ2MxRzI5ervIBmRvWw5PtdsS12x1phW4d9nJJpQHIlTSS8HGk3m6R7FopZ
 c
X-Google-Smtp-Source: AGHT+IEfpWbm8xp6NkMeVg1ikdNGVjj9PshjLQusHYWC6O0n3kU2fMRJu4kJgQK/LCSVr3XcWCKPqw==
X-Received: by 2002:a05:6358:60ce:b0:1be:bb29:95a0 with SMTP id
 e5c5f4694b2df-1c32bad6770mr810017855d.13.1729007322866; 
 Tue, 15 Oct 2024 08:48:42 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c7068afsm1516866a12.57.2024.10.15.08.48.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:48:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 33/33] hw/mips: Have mips_cpu_create_with_clock() take an
 endianness argument
Date: Tue, 15 Oct 2024 12:44:42 -0300
Message-ID: <20241015154443.71763-34-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=philmd@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

mips_cpu_create_with_clock() creates a vCPU. Pass it the vCPU
endianness requested by argument. Update the board call sites.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-17-philmd@linaro.org>
---
 target/mips/cpu.h        | 4 +++-
 hw/mips/fuloong2e.c      | 2 +-
 hw/mips/jazz.c           | 3 ++-
 hw/mips/loongson3_virt.c | 2 +-
 hw/mips/malta.c          | 3 ++-
 hw/mips/mipssim.c        | 3 ++-
 target/mips/cpu.c        | 5 ++++-
 7 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 070e11fe0da..a4a46ebbe98 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1376,12 +1376,14 @@ static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
  * mips_cpu_create_with_clock:
  * @typename: a MIPS CPU type.
  * @cpu_refclk: this cpu input clock (an output clock of another device)
+ * @is_big_endian: whether this CPU is configured in big endianness
  *
  * Instantiates a MIPS CPU, set the input clock of the CPU to @cpu_refclk,
  * then realizes the CPU.
  *
  * Returns: A #CPUState or %NULL if an error occurred.
  */
-MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk);
+MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
+                                    bool is_big_endian);
 
 #endif /* MIPS_CPU_H */
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 6e4303ba473..7fd8296ccb6 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -229,7 +229,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     clock_set_hz(cpuclk, 533080000); /* ~533 MHz */
 
     /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 33ce51fb09c..0e43c9f0bac 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -212,7 +212,8 @@ static void mips_jazz_init(MachineState *machine,
                          * ext_clk[jazz_model].pll_mult);
 
     /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk,
+                                     TARGET_BIG_ENDIAN);
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index a2db98665df..f3b6326cc59 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -567,7 +567,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         int ip;
 
         /* init CPUs */
-        cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+        cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 964d3592da7..198da5ba3d4 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1034,7 +1034,8 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
     int i;
 
     for (i = 0; i < ms->smp.cpus; i++) {
-        cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk);
+        cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk,
+                                         TARGET_BIG_ENDIAN);
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index a07732d3dc5..5f4835a38de 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -160,7 +160,8 @@ mips_mipssim_init(MachineState *machine)
 #endif
 
     /* Init CPUs. */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk,
+                                     TARGET_BIG_ENDIAN);
     env = &cpu->env;
 
     reset_info = g_new0(ResetData, 1);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 04bf4b11db2..9724e71a5e0 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -643,12 +643,15 @@ static void mips_cpu_register_types(void)
 type_init(mips_cpu_register_types)
 
 /* Could be used by generic CPU object */
-MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
+MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
+                                    bool is_big_endian)
 {
     DeviceState *cpu;
 
     cpu = DEVICE(object_new(cpu_type));
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
+    object_property_set_bool(OBJECT(cpu), "big-endian", is_big_endian,
+                             &error_abort);
     qdev_realize(cpu, NULL, &error_abort);
 
     return MIPS_CPU(cpu);
-- 
2.45.2


