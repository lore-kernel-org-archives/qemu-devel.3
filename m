Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E0BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrA-00058D-UI; Thu, 30 Apr 2026 05:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqy-0004nC-OR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqk-0002Wr-0Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:38 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so83343f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541904; x=1778146704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ds0o8rL5bie8S049mYZ4UPlqu2fJMRXXMXyB9gO7cas=;
 b=N36Nnu5fRETEAFGMy+i7tFEPdPKP1DlFkNqdjSbh6gHGmF9/Nz1cjVhThc0Mj85CoR
 4rOrwe+nmA3pcbS/HKZotoetnzA9WIxM+DKP8cqPip/bFF+4eYKnGwmgcDdG0GrvIeIE
 3uR6o+R+MmlY7nKH8rcjUaBQt0awzYaOHx9mR8M6dWhNM8E4AE3hMC5MHazr1fPkX3Pj
 amthh3xSFHagK3AvOdMr+hk+mpK0xy3CijFWWxZkk/caqzlDhbVmZokuj17rBRwP0njw
 QZ+PBD2W8kjtbJXdbESqu70Ll/+kfnvAX/an3wHAi/rpZYCTKew6GVvC85qZeA1i8wdR
 uRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541904; x=1778146704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ds0o8rL5bie8S049mYZ4UPlqu2fJMRXXMXyB9gO7cas=;
 b=JCH/fv1BpB34RE0mC0Vvb7bxbQqLtmNbAVeLznZNMaPS7QQ2O1BY6a6hU3UaDf5KJW
 XtuLVqab/enbC3tFrEPZJ2Kybk5japRpeViRmRIyFCGkOSbfLpUd9puBkS742f41uakM
 jqJ9vyUURekLu9Wsjio42dE9kpBGdvLb8Yu1zC1fR2wDlFUV/LlpV4QpnKPcQAoG8Y0C
 WLz3lfcXiuyCswyNtqRi8N7M+flm8AtpUgiseeMyQF7pczkkBFu2bH3NRLyffTkY7iUF
 O0YswI5LIqCpXlJUSm4KhZiPRa8H9/KW1FVbWP+awpNqZ5w1wJ+xUNFm21N0YJFmThcJ
 IuTg==
X-Gm-Message-State: AOJu0YwzsQ5UfWlHmNbzrqC/LoxFtUnbX/M3NOwsWEImdhdwlX1XXNkL
 A5ZEpuobyLE9eJDyvepojUfejLZ000yGw/Q1kFY2UGGSfwrl6bUtZyjCo6oL01EBymdB5ZX+VWv
 8s1W0
X-Gm-Gg: AeBDiesHuq3f/Cd4qvsoQcXiJMnYKDITeCQ9FGjLRz6qqsSRecLgwu7puVr3Tb7rKC3
 +yOQKIkoehCEwj/dK9Ih1tIjizx5u9dd1/iBBuZQA2Xt87l8gRR3n7fMRZ6SshLlslqMRm+rrko
 w/EH/ug47qX39TimL/1TnnUjwXBxvRdNJh3k6ZvaEhlWKEaNggG22YifqaTEP6eM8gDFUfrSfhX
 wIBdGMfEXBlkufbaI6hCM/RaAD2grpR2owu9a27twyD3l9VKslC/q8ZE4sMZVxB/V4c6Q50N5YK
 iA/rS0+JlaoTMztoQIr0xYqlxKmgN2WPHbeG4COFTn/8kjJesOC8mBRNk1Tm9pzdQ1QiNlhw7ML
 KpTaHMh/Vt8xN9CTdKxNhsPASXxdbrkla9Q4vZrQTM6bJCgK0vsWA6ALRDewtZjmtL3iykBKM7a
 NlPVaBI3Q1zLgPAM+0msAdm0/QrhyJJe8NSc94A3YhV8bGFvP49gkSkWxboxwe5BeHV6q3iAv5i
 oNi/6zCnLmPiUOLtUvW03umiyojT8zQ4WXH62Vdsw==
X-Received: by 2002:a5d:64c9:0:b0:441:377f:82a7 with SMTP id
 ffacd0b85a97d-4493ef4447bmr3466123f8f.32.1777541903657; 
 Thu, 30 Apr 2026 02:38:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 09/25] target: Rename get_phys_page_debug to
 get_phys_addr_debug
Date: Thu, 30 Apr 2026 10:37:54 +0100
Message-ID: <20260430093810.2762539-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Now that we have ensured that all implementations of the get_phys_page_debug
method handle a non-page-aligned input and return the corresponding
non-page-aligned output, the name of the method is somewhat misleading.
Rename it to get_phys_addr_debug.

This commit was produced with the commands

 sed -i -e 's/_cpu_get_phys_page_debug/_cpu_get_phys_addr_debug/g;s/\<get_phys_page_debug\>/get_phys_addr_debug/g' $(git grep -l get_phys_page_debug)
 sed -i -e 's/_cpu_get_phys_page_attrs_debug/_cpu_get_phys_addr_attrs_debug/g;s/\<get_phys_page_attrs_debug\>/get_phys_addr_attrs_debug/g' $(git grep -l get_phys_page_attrs_debug)

which catches all references to the method name itself plus
the functions which each target uses as the method implementation,
but (deliberately) not the cpu_phys_get_page_debug() and
cpu_phys_get_page_attrs_debug() wrapper functions or their callers.
(We'll deal with those in the next commit.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-9-peter.maydell@linaro.org
---
 hw/core/cpu-system.c             |  6 +++---
 include/hw/core/sysemu-cpu-ops.h | 10 +++++-----
 target/alpha/cpu.c               |  2 +-
 target/alpha/cpu.h               |  2 +-
 target/alpha/helper.c            |  2 +-
 target/arm/cpu.c                 |  2 +-
 target/arm/cpu.h                 |  2 +-
 target/arm/ptw.c                 |  2 +-
 target/avr/cpu.c                 |  2 +-
 target/avr/cpu.h                 |  2 +-
 target/avr/helper.c              |  2 +-
 target/hppa/cpu.c                |  2 +-
 target/hppa/cpu.h                |  2 +-
 target/hppa/mem_helper.c         |  2 +-
 target/i386/cpu.c                |  2 +-
 target/i386/cpu.h                |  2 +-
 target/i386/helper.c             |  2 +-
 target/i386/whpx/whpx-all.c      |  2 +-
 target/loongarch/cpu-mmu.h       |  2 +-
 target/loongarch/cpu.c           |  2 +-
 target/loongarch/cpu_helper.c    |  2 +-
 target/m68k/cpu.c                |  2 +-
 target/m68k/cpu.h                |  2 +-
 target/m68k/helper.c             |  2 +-
 target/microblaze/cpu.c          |  2 +-
 target/microblaze/cpu.h          |  2 +-
 target/microblaze/helper.c       |  2 +-
 target/mips/cpu.c                |  2 +-
 target/mips/internal.h           |  2 +-
 target/mips/system/physaddr.c    |  2 +-
 target/or1k/cpu.c                |  2 +-
 target/or1k/cpu.h                |  2 +-
 target/or1k/mmu.c                |  2 +-
 target/ppc/cpu.h                 |  2 +-
 target/ppc/cpu_init.c            |  2 +-
 target/ppc/mmu-hash32.c          |  2 +-
 target/ppc/mmu_common.c          |  2 +-
 target/riscv/cpu.c               |  2 +-
 target/riscv/cpu.h               |  2 +-
 target/riscv/cpu_helper.c        |  2 +-
 target/rx/cpu.c                  |  2 +-
 target/rx/cpu.h                  |  2 +-
 target/rx/helper.c               |  2 +-
 target/s390x/cpu-system.c        |  2 +-
 target/sh4/cpu.c                 |  2 +-
 target/sh4/cpu.h                 |  2 +-
 target/sh4/helper.c              |  2 +-
 target/sparc/cpu.c               |  2 +-
 target/sparc/cpu.h               |  2 +-
 target/sparc/mmu_helper.c        |  2 +-
 target/tricore/cpu.c             |  2 +-
 target/tricore/cpu.h             |  2 +-
 target/tricore/helper.c          |  2 +-
 target/xtensa/cpu.c              |  2 +-
 target/xtensa/cpu.h              |  2 +-
 target/xtensa/mmu_helper.c       |  2 +-
 56 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 273b9b7c22..93dc861083 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -60,13 +60,13 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
 {
     hwaddr paddr;
 
-    if (cpu->cc->sysemu_ops->get_phys_page_attrs_debug) {
-        paddr = cpu->cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr,
+    if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
+        paddr = cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
                                                                attrs);
     } else {
         /* Fallback for CPUs which don't implement the _attrs_ hook */
         *attrs = MEMTXATTRS_UNSPECIFIED;
-        paddr = cpu->cc->sysemu_ops->get_phys_page_debug(cpu, addr);
+        paddr = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
     }
     /* Indicate that this is a debug access. */
     attrs->debug = 1;
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 7b2d2d2610..a4fc330bea 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -30,17 +30,17 @@ typedef struct SysemuCPUOps {
      */
     bool (*get_paging_enabled)(const CPUState *cpu);
     /**
-     * @get_phys_page_debug: Callback for obtaining a physical address.
+     * @get_phys_addr_debug: Callback for obtaining a physical address.
      */
-    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
+    hwaddr (*get_phys_addr_debug)(CPUState *cpu, vaddr addr);
     /**
-     * @get_phys_page_attrs_debug: Callback for obtaining a physical address
+     * @get_phys_addr_attrs_debug: Callback for obtaining a physical address
      *       and the associated memory transaction attributes to use for the
      *       access.
      * CPUs which use memory transaction attributes should implement this
-     * instead of get_phys_page_debug.
+     * instead of get_phys_addr_debug.
      */
-    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
+    hwaddr (*get_phys_addr_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
     /**
      * @asidx_from_attrs: Callback to return the CPU AddressSpace to use for
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index ff053043a3..0c35067b20 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -242,7 +242,7 @@ static void alpha_cpu_initfn(Object *obj)
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
     .has_work = alpha_cpu_has_work,
-    .get_phys_page_debug = alpha_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = alpha_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index b530cd0088..d6981a6419 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -283,7 +283,7 @@ extern const VMStateDescription vmstate_alpha_cpu;
 
 void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index af6d7847d5..33fed0c746 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -295,7 +295,7 @@ static int get_physical_address(CPUAlphaState *env, vaddr addr,
     return ret;
 }
 
-hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     hwaddr phys;
     int prot, fail;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10feb639c4..9e6b4b1559 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2436,7 +2436,7 @@ static vaddr aarch64_untagged_addr(CPUState *cs, vaddr x)
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
     .has_work = arm_cpu_has_work,
-    .get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug,
+    .get_phys_addr_attrs_debug = arm_cpu_get_phys_addr_attrs_debug,
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index be14a47c35..b1563a4d43 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1233,7 +1233,7 @@ extern const VMStateDescription vmstate_arm_cpu;
 void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 
 typedef struct ARMGranuleProtectionConfig {
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7b993bb5b3..f5f624c7c3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3943,7 +3943,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
     return res.f.phys_addr;
 }
 
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
                                          MemTxAttrs *attrs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8579a7283b..3591219212 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -233,7 +233,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 static const struct SysemuCPUOps avr_sysemu_ops = {
     .has_work = avr_cpu_has_work,
-    .get_phys_page_debug = avr_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = avr_cpu_get_phys_addr_debug,
 };
 
 static const TCGCPUOps avr_tcg_ops = {
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 518e243d81..7ebdc7b953 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -178,7 +178,7 @@ extern const struct VMStateDescription vms_avr_cpu;
 
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr avr_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 365c8c60e1..f3be8483b2 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -107,7 +107,7 @@ void avr_cpu_do_interrupt(CPUState *cs)
     qemu_plugin_vcpu_interrupt_cb(cs, ret);
 }
 
-hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr avr_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     return addr; /* I assume 1:1 address correspondence */
 }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 92027d129a..6443122cf1 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -244,7 +244,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
     .has_work = hppa_cpu_has_work,
-    .get_phys_page_debug = hppa_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = hppa_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7d47afe8ef..8a859d27b0 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -389,7 +389,7 @@ int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 #ifndef CONFIG_USER_ONLY
 void hppa_ptlbe(CPUHPPAState *env);
-hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
+hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr);
 void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled);
 bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
                              MMUAccessType access_type, int mmu_idx,
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index ffbad8acfd..f507649226 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -345,7 +345,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     return ret;
 }
 
-hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr hppa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     hwaddr phys;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9d126600c0..cbd064ebb8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10692,7 +10692,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .has_work = x86_cpu_has_work,
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
-    .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
+    .get_phys_addr_attrs_debug = x86_cpu_get_phys_addr_attrs_debug,
     .asidx_from_attrs = x86_asidx_from_attrs,
     .get_crash_info = x86_cpu_get_crash_info,
     .write_elf32_note = x86_cpu_write_elf32_note,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a09d5de121..66bbb37cfc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2580,7 +2580,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env);
 #ifndef CONFIG_USER_ONLY
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
 
-hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 108b02396d..8cc73f619a 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -252,7 +252,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
                                          MemTxAttrs *attrs)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e56ae2b343..406ca0355c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -238,7 +238,7 @@ struct whpx_register_set {
  *          e. Let the affected CPU run in the exclusive mode.
  *          f. Restore the original handler and the exception exit bitmap.
  *        Note that handling all corner cases related to IDT/GDT is harder
- *        than it may seem. See x86_cpu_get_phys_page_attrs_debug() for a
+ *        than it may seem. See x86_cpu_get_phys_addr_attrs_debug() for a
  *        rough idea.
  *
  *     3. In order to properly support guest-level debugging in parallel with
diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 3286accc14..2d7ebb2d72 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -97,7 +97,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level);
-hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 uint64_t loongarch_palen_mask(CPULoongArchState *env);
 
 #endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e22568c84a..43ba414ac5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -832,7 +832,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
-    .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
 };
 
 static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 6044168766..181b931130 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -354,7 +354,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
 }
 
-hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     CPULoongArchState *env = cpu_env(cs);
     MMUContext context;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d849a4a90f..425efdf7cc 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -606,7 +606,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
-    .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = m68k_cpu_get_phys_addr_debug,
 };
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7911ab9de3..b181d5f981 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -186,7 +186,7 @@ struct M68kCPUClass {
 #ifndef CONFIG_USER_ONLY
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bab184389..2dd9ec1bdc 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -907,7 +907,7 @@ txfail:
     return -1;
 }
 
-hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     CPUM68KState *env = cpu_env(cs);
     hwaddr phys_addr;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index ec513ae82d..20fffccb60 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -428,7 +428,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
     .has_work = mb_cpu_has_work,
-    .get_phys_page_attrs_debug = mb_cpu_get_phys_page_attrs_debug,
+    .get_phys_addr_attrs_debug = mb_cpu_get_phys_addr_attrs_debug,
 };
 #endif
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 5a856edaaa..9f342ef618 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -370,7 +370,7 @@ struct MicroBlazeCPUClass {
 #ifndef CONFIG_USER_ONLY
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
-hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
 #endif /* !CONFIG_USER_ONLY */
 G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index da8abe063e..f81c4f625b 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -280,7 +280,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 5f88c077db..6ef18105b9 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -535,7 +535,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mips_sysemu_ops = {
     .has_work = mips_cpu_has_work,
-    .get_phys_page_debug = mips_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = mips_cpu_get_phys_addr_debug,
     .legacy_vmsd = &vmstate_mips_cpu,
 };
 #endif
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 28eb28936b..24bfa1903c 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -115,7 +115,7 @@ enum {
 int get_physical_address(CPUMIPSState *env, hwaddr *physical,
                          int *prot, target_ulong real_address,
                          MMUAccessType access_type, int mmu_idx);
-hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr mips_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
 typedef struct r4k_tlb_t r4k_tlb_t;
 struct r4k_tlb_t {
diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index b8e1a5ac98..fbbbcf6e00 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -228,7 +228,7 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
     return ret;
 }
 
-hwaddr mips_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr mips_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     CPUMIPSState *env = cpu_env(cs);
     hwaddr phys_addr;
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 3d1c22bf75..ea29b2e01f 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -247,7 +247,7 @@ static void openrisc_any_initfn(Object *obj)
 
 static const struct SysemuCPUOps openrisc_sysemu_ops = {
     .has_work = openrisc_cpu_has_work,
-    .get_phys_page_debug = openrisc_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = openrisc_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index c8e2827930..8f20b9a122 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -297,7 +297,7 @@ void openrisc_translate_code(CPUState *cs, TranslationBlock *tb,
 int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
 #ifndef CONFIG_USER_ONLY
-hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
 bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                            MMUAccessType access_type, int mmu_idx,
diff --git a/target/or1k/mmu.c b/target/or1k/mmu.c
index 315debaf3e..3ff288a1f9 100644
--- a/target/or1k/mmu.c
+++ b/target/or1k/mmu.c
@@ -138,7 +138,7 @@ bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     int prot, excp, sr = cpu->env.sr;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d637a50798..24a53ee2e1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1639,7 +1639,7 @@ void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 #ifndef CONFIG_USER_ONLY
-hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr ppc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif
 int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 191f5726f6..d25f69f13b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7477,7 +7477,7 @@ static void ppc_disas_set_info(const CPUState *cs, disassemble_info *info)
 
 static const struct SysemuCPUOps ppc_sysemu_ops = {
     .has_work = ppc_cpu_has_work,
-    .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = ppc_cpu_get_phys_addr_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
     .internal_is_big_endian = ppc_cpu_is_big_endian,
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 8b980a5aa9..43d581cadf 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -131,7 +131,7 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
     }
 
     /*
-     * From ppc_cpu_get_phys_page_debug, env->access_type is not set.
+     * From ppc_cpu_get_phys_addr_debug, env->access_type is not set.
      * Assume ACCESS_INT for that case.
      */
     switch (guest_visible ? env->access_type : ACCESS_INT) {
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index a1345df716..2499e619f8 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -848,7 +848,7 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     }
 }
 
-hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr ppc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     hwaddr raddr;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8ac935ac06..e5d8592ef2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2717,7 +2717,7 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
-    .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
     .legacy_vmsd = &vmstate_riscv_cpu,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..111afe19d1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -629,7 +629,7 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MMUAccessType access_type,
                                      int mmu_idx, MemTxAttrs attrs,
                                      MemTxResult response, uintptr_t retaddr);
-hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 475e9cfd57..584a3928a4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1657,7 +1657,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
 
-hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index b5284199e6..20b188c24c 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -209,7 +209,7 @@ static void rx_cpu_init(Object *obj)
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
     .has_work = rx_cpu_has_work,
-    .get_phys_page_debug = rx_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = rx_cpu_get_phys_addr_debug,
 };
 
 static const TCGCPUOps rx_tcg_ops = {
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index b3b1ecff5a..328521791b 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -137,7 +137,7 @@ struct RXCPUClass {
 const char *rx_crname(uint8_t cr);
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr rx_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/rx/helper.c b/target/rx/helper.c
index daaeeec1b5..0f99279bba 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -147,7 +147,7 @@ bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-hwaddr rx_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr rx_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     return addr;
 }
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index c133b0c262..1bd3721d10 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -176,7 +176,7 @@ void s390_cpu_finalize(Object *obj)
 
 static const struct SysemuCPUOps s390_sysemu_ops = {
     .has_work = s390_cpu_has_work,
-    .get_phys_page_debug = s390_cpu_get_phys_addr_debug,
+    .get_phys_addr_debug = s390_cpu_get_phys_addr_debug,
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
     .legacy_vmsd = &vmstate_s390_cpu,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index e2bde45761..40d5fde76d 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -278,7 +278,7 @@ static const VMStateDescription vmstate_sh_cpu = {
 
 static const struct SysemuCPUOps sh4_sysemu_ops = {
     .has_work = superh_cpu_has_work,
-    .get_phys_page_debug = superh_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = superh_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index b0759010c4..3743452190 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -252,7 +252,7 @@ void sh4_translate_code(CPUState *cs, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc);
 
 #if !defined(CONFIG_USER_ONLY)
-hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr superh_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr);
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 5d6295618f..b3ec7ce64d 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -435,7 +435,7 @@ static int get_physical_address(CPUSH4State *env, hwaddr* physical,
     return get_mmu_address(env, physical, prot, address, access_type);
 }
 
-hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr superh_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     hwaddr physical;
     int prot;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 7704610428..d198f6ba19 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -997,7 +997,7 @@ static const Property sparc_cpu_properties[] = {
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
     .has_work = sparc_cpu_has_work,
-    .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = sparc_cpu_get_phys_addr_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
 };
 #endif
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 0139732e4c..307b98b76c 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -580,7 +580,7 @@ struct SPARCCPUClass {
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_sparc_cpu;
 
-hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr sparc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif
 
 void sparc_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 25f8a85fae..34b212a7aa 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -902,7 +902,7 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 }
 #endif
 
-hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr sparc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     CPUSPARCState *env = cpu_env(cs);
     hwaddr phys_addr;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 04319e107b..472c24ae32 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -176,7 +176,7 @@ static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 static const struct SysemuCPUOps tricore_sysemu_ops = {
     .has_work = tricore_cpu_has_work,
-    .get_phys_page_debug = tricore_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = tricore_cpu_get_phys_addr_debug,
 };
 
 static const TCGCPUOps tricore_tcg_ops = {
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index ab46192e26..56241b491f 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -80,7 +80,7 @@ struct TriCoreCPUClass {
     ResettablePhases parent_phases;
 };
 
-hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 FIELD(PCXI, PCPN_13, 24, 8)
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 7ee8c7fd69..ce1693622b 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -46,7 +46,7 @@ static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
     return ret;
 }
 
-hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     TriCoreCPU *cpu = TRICORE_CPU(cs);
     hwaddr phys_addr;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index eebf40559b..8a22f1a08e 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -303,7 +303,7 @@ static const VMStateDescription vmstate_xtensa_cpu = {
 
 static const struct SysemuCPUOps xtensa_sysemu_ops = {
     .has_work = xtensa_cpu_has_work,
-    .get_phys_page_debug = xtensa_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = xtensa_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 2219292484..546a5e76a6 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -591,7 +591,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr);
-hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr xtensa_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 bool xtensa_debug_check_breakpoint(CPUState *cs);
 #endif
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 71330fc84b..a126f6b671 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -316,7 +316,7 @@ static void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
     }
 }
 
-hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr xtensa_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     uint32_t paddr;
-- 
2.43.0


