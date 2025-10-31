Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DCACCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwh-0004Y5-U2; Fri, 31 Oct 2025 14:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwZ-0004SA-MM
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwJ-0006DA-Hh
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-474975af41dso19434965e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935606; x=1762540406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EtLB+ZJuZimYKJnmKMi+iGzTZfn8He8nFmy5E1ucho8=;
 b=Pw0X+4pLNbiEOEvD8CyjuIJArAf7dRxSA3Pk2P4i7SN+IRn98O/0ZzdezELDT8YzFn
 N1JLFA7ZXraSG+aXW/PjY2fph0SfXY5E6Y4ncSCYGnBYigvI3Ki9JeMc8bz+GqJlpEDZ
 WMXZWOys3KSZXxjp28jhZKPQPyY71Lp8a49uazGascc3bJgij2AB/laVykk0rYoLtYS8
 CHCIqZZLBrRhSRGV903Odk8tLG0/teEmlDYEPv6gy3QKhRFqFo5AzIsAfytpO+C3xE8v
 xbNYG0co0Sg4OJ1VtG9AJaA10A7v6ekDU6jLsmHMN8JHR2PP4L2k5vOPDMtElHnfqqq7
 a2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935606; x=1762540406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtLB+ZJuZimYKJnmKMi+iGzTZfn8He8nFmy5E1ucho8=;
 b=DiV/3jNYvwRMiaJXnto/JDxK2JPLtn7Z2VSaYoK69QTf5IWVQjBQmpDqbHPa9vxyRz
 gK4XqTN1SuzCTWx5gBeS3RgY95pv8+Yv+bTLW7bQXkyjkb0MKO6rz6FCKyf3oD6cArAA
 JhTiID+08rQNHxHKvNz2I2FW8AuRu18LmjcrqdwUG//g0D2tPlTIIdKQZleZ3agNOT8k
 exz4iEIkLymcWAlSTjkftOoQAVP0Svl+5sd9FS4wkU8JqN47hsXL3Mfr+hI9uRRnIka4
 0ED3A6jNyBrXJLvj7qcuof1PDWTsfKr4jR6doLhYTX9vgeL5JS7AjkNGDtKT5ZuW5mzd
 pmDQ==
X-Gm-Message-State: AOJu0YwAh/fwG2kjSp4kStIdPjtinnGKE5A8v60g+aTy1sF6qWpSfWNf
 5hFBMWJe1cNBQI+8dYHvuSFwsSikXPiWDp8fgiCeMWAhDpnnTMYXtpcXoxj9Wflg193IFtBv2d1
 jlIFL
X-Gm-Gg: ASbGncvEo7R1e/hES8xnmwVLRhuRQRK9gswH1MZx6Nj9Bwn0ezvnQxeJleOR8OPgPsM
 MuD+siF3pzq2UPkzOCh9J6QGqsWZVCPxHJUteGQsCuH3xo4FYakhlrXBy+Uv9YW/wIT1E6MgHsO
 kzQMUUwrzW1TALw8etvFTSvUPqjsgv6lhDiCzObEuCF4OEcy7ih49iYblFOULeNmCcEMe5sgz7t
 WVqkwHOMYTAYcM1V0tAM9pkz/SsY8bPqKiLa5vDEA+K39e2PoUpp9VITWuF5HvtedzS/flO9IYW
 fjIH67fTei1ncL9GRRXt0EOdqegVJ/MI0WVCsIGn/zNWAeMzgXiSFhwQfVPVWjj+k9EW7RL7Pom
 gIRKsVcciAqnhA1chjxmFVfUoWQmT2Tj6zscJMHYsVV9J5+/7g9hFIBrhmkUDwDsNTRtzzzQTIf
 7jH0YWBA==
X-Google-Smtp-Source: AGHT+IEdBE8juyq4UD3OmdTXf+rfOn+Qn9kAidMhTq+owbaa+nOIikXsLTvgiajs5WHDj7rzD/G9SQ==
X-Received: by 2002:a05:600c:699a:b0:477:1326:7b4b with SMTP id
 5b1f17b1804b1-47730872322mr48377365e9.19.1761935606467; 
 Fri, 31 Oct 2025 11:33:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/38] accel/hvf: Rename hvf_put|get_registers ->
 hvf_arch_put|get_registers
Date: Fri, 31 Oct 2025 18:32:46 +0000
Message-ID: <20251031183310.3778349-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hvf_put_registers() and hvf_get_registers() are implemented per
target, rename them using the 'hvf_arch_' prefix following the
per target pattern.

Since they call hv_vcpu_set_reg() / hv_vcpu_get_reg(), mention
they must be called on the vCPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf_int.h  | 6 ++++--
 accel/hvf/hvf-accel-ops.c | 2 +-
 target/arm/hvf/hvf.c      | 8 +++++---
 target/i386/hvf/hvf.c     | 2 +-
 target/i386/hvf/x86hvf.c  | 4 ++--
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 32b32e1d024..8fce627b08c 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -74,12 +74,14 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
-int hvf_put_registers(CPUState *);
-int hvf_get_registers(CPUState *);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
 int hvf_arch_vcpu_exec(CPUState *);
+/* Must be called by the owning thread */
+int hvf_arch_put_registers(CPUState *);
+/* Must be called by the owning thread */
+int hvf_arch_get_registers(CPUState *);
 
 struct hvf_sw_breakpoint {
     vaddr pc;
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 005e2bd891a..3e5feecd8a7 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -81,7 +81,7 @@ hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-        hvf_get_registers(cpu);
+        hvf_arch_get_registers(cpu);
         cpu->vcpu_dirty = true;
     }
 }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9111c1d717b..f0a0e5d1a75 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -424,7 +424,7 @@ static const hv_sys_reg_t hvf_sreg_list[] = {
 
 #undef DEF_SYSREG
 
-int hvf_get_registers(CPUState *cpu)
+int hvf_arch_get_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -564,7 +564,7 @@ int hvf_get_registers(CPUState *cpu)
     return 0;
 }
 
-int hvf_put_registers(CPUState *cpu)
+int hvf_arch_put_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -692,11 +692,12 @@ int hvf_put_registers(CPUState *cpu)
 static void flush_cpu_state(CPUState *cpu)
 {
     if (cpu->vcpu_dirty) {
-        hvf_put_registers(cpu);
+        hvf_arch_put_registers(cpu);
         cpu->vcpu_dirty = false;
     }
 }
 
+/* Must be called by the owning thread */
 static void hvf_set_reg(CPUState *cpu, int rt, uint64_t val)
 {
     hv_return_t r;
@@ -709,6 +710,7 @@ static void hvf_set_reg(CPUState *cpu, int rt, uint64_t val)
     }
 }
 
+/* Must be called by the owning thread */
 static uint64_t hvf_get_reg(CPUState *cpu, int rt)
 {
     uint64_t val = 0;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index b2bf59cb483..76a58cb0350 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -734,7 +734,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
 
     do {
         if (cpu->vcpu_dirty) {
-            hvf_put_registers(cpu);
+            hvf_arch_put_registers(cpu);
             cpu->vcpu_dirty = false;
         }
 
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 3838c9f5a6f..bb480311b0f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -236,7 +236,7 @@ void hvf_get_msrs(CPUState *cs)
     env->tsc = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
 }
 
-int hvf_put_registers(CPUState *cs)
+int hvf_arch_put_registers(CPUState *cs)
 {
     X86CPU *x86cpu = X86_CPU(cs);
     CPUX86State *env = &x86cpu->env;
@@ -280,7 +280,7 @@ int hvf_put_registers(CPUState *cs)
     return 0;
 }
 
-int hvf_get_registers(CPUState *cs)
+int hvf_arch_get_registers(CPUState *cs)
 {
     X86CPU *x86cpu = X86_CPU(cs);
     CPUX86State *env = &x86cpu->env;
-- 
2.43.0


