Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5C8CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgY5-0003eU-BL; Tue, 12 May 2026 02:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXJ-00034K-QH
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgX5-0005RC-Lm
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso47365335e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567033; x=1779171833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Im0G5QYLnVALsKaDdPLc9NnFP+w2XFubzxqVhJMKNvE=;
 b=EOK2N+YFY9Mb/VKp1bkBjoJJarQXAfMP3+YxCpzFQhR/5cz/26NC//TyTuEqMHa+xs
 Bnsb9My3bhCV3pHW1GywIIs5yyGi8keOMmL0wyJT/c+f4VUytmr/ZPIn6bfUh9HXhNPZ
 hfi6WYrakh9t0vPJe0HxaIL6ZG99e9G4IRMPx2yAZSqHLMH/a/NIgE25Rn1bqv0yveEc
 3FOdHcCN3qIQN5Myo7AbhB5V9xOHTli4OJZRdf4x0r0LMOLjmv4CB35LMsgyGmH/ZfO8
 B16MpxB8aC5tLbPkQOy888lkoFyE4IzBzokv9131f0CTR4ttss7EA7OMx8IDQEZZ+NrZ
 l0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567033; x=1779171833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Im0G5QYLnVALsKaDdPLc9NnFP+w2XFubzxqVhJMKNvE=;
 b=XcKwt3nx5VCyN2JF6fRRGEOtu4WPBly7wUjfenXsWuPQeF+UswM2eHf1E79lKhGIwm
 6904VLhDZC5Rrw2jvEeBDyBnEU6cCtkmS5lXNzz5q12mF6U6pASDYmDdUAkj+34J53hN
 MtsrJtJCb1ifw6j6mF7u8NocTWOkIbxyWTUPCkFHa8dlj6tOf5uNN4o51w5LnNrceVRV
 R3aqnsh6gjTsO0sGBRv1Uhv7g+hqqMi0mxIP8aYHCCpnJd1dTdj234K6HRKTXOM2xEj1
 hh8jfTwVG1hsrrtGF8+L1TPkCqICsFhdVMIGdMOdsVqsFyriKJYz/X+yISdcFsg+bac4
 npqA==
X-Gm-Message-State: AOJu0Yx8RRtcQBl03oo7epLh/SyxWylbbZF1Oi2iKxoIjHBryTBA92us
 7Aojj/lX9reLDiVFmymSTvlnKf5+ehh0bL75TAR+P2tjxsq4mXtGc1OfY8k9fpFjcar3UVPxmRm
 2HO8mLSY=
X-Gm-Gg: Acq92OFv6WL+l3ObB3a+Qsn/lVAZE+y9jVln3AgIxwd6cAAdgh5rtLencnClt/WLcuq
 2URNwqVcuX8ohgRQ+PqRW5lF+se3/XzHIMbbxCoKo/E73CABgiRQPUPN1MSBZs9SmoJywVq4uaq
 aR5ubqvPFR/48fiPTpqhga19YSzvnpxEKwbXevsHJQ/nXKSUz+IlxMPDwBKBI90SFGkOKYsmGXH
 jM5FsX0xIsdrBhtURrYBUY2mANOShdnyYVwk8DLg8j08j4YaCl9bnRXiRYBTHyYnCYgX2VkJ8O0
 nh2C8dztQAvZkBw6JtOg4a0gGErB/gNYtDQQutlsoVRq2HlSSWFJMTD8e3HO8Cjrmvbm/jivTPL
 Jb227qvXUf0vbQgdyKZnLFFW5yjxutYqj3VOVs0JRjRbRNNHKuJNqxqXiCYUsnj3dkAGdygsxmC
 M3uNH4nb7v0+qTCSIdj+OsGA2m8IqzojDMbAFyw5ZTMJkw11KEuyJcV2owl0x++u7oyryLXo1J
X-Received: by 2002:a05:600c:528e:b0:48e:7f1c:8778 with SMTP id
 5b1f17b1804b1-48e8fe721bcmr23810825e9.17.1778567032337; 
 Mon, 11 May 2026 23:23:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f4389a6sm10318725e9.22.2026.05.11.23.23.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/41] target: Rename get_phys_page_debug to get_phys_addr_debug
Date: Tue, 12 May 2026 08:21:19 +0200
Message-ID: <20260512062142.67998-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Message-ID: <20260430093810.2762539-10-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 10 +++++-----
 target/alpha/cpu.h               |  2 +-
 target/arm/cpu.h                 |  2 +-
 target/avr/cpu.h                 |  2 +-
 target/hppa/cpu.h                |  2 +-
 target/i386/cpu.h                |  2 +-
 target/loongarch/cpu-mmu.h       |  2 +-
 target/m68k/cpu.h                |  2 +-
 target/microblaze/cpu.h          |  2 +-
 target/mips/internal.h           |  2 +-
 target/or1k/cpu.h                |  2 +-
 target/ppc/cpu.h                 |  2 +-
 target/riscv/cpu.h               |  2 +-
 target/rx/cpu.h                  |  2 +-
 target/sh4/cpu.h                 |  2 +-
 target/sparc/cpu.h               |  2 +-
 target/tricore/cpu.h             |  2 +-
 target/xtensa/cpu.h              |  2 +-
 hw/core/cpu-system.c             |  6 +++---
 target/alpha/cpu.c               |  2 +-
 target/alpha/helper.c            |  2 +-
 target/arm/cpu.c                 |  2 +-
 target/arm/ptw.c                 |  2 +-
 target/avr/cpu.c                 |  2 +-
 target/avr/helper.c              |  2 +-
 target/hppa/cpu.c                |  2 +-
 target/hppa/mem_helper.c         |  2 +-
 target/i386/cpu.c                |  2 +-
 target/i386/helper.c             |  2 +-
 target/i386/whpx/whpx-all.c      |  2 +-
 target/loongarch/cpu.c           |  2 +-
 target/loongarch/cpu_helper.c    |  2 +-
 target/m68k/cpu.c                |  2 +-
 target/m68k/helper.c             |  2 +-
 target/microblaze/cpu.c          |  2 +-
 target/microblaze/helper.c       |  2 +-
 target/mips/cpu.c                |  2 +-
 target/mips/system/physaddr.c    |  2 +-
 target/or1k/cpu.c                |  2 +-
 target/or1k/mmu.c                |  2 +-
 target/ppc/cpu_init.c            |  2 +-
 target/ppc/mmu-hash32.c          |  2 +-
 target/ppc/mmu_common.c          |  2 +-
 target/riscv/cpu.c               |  2 +-
 target/riscv/cpu_helper.c        |  2 +-
 target/rx/cpu.c                  |  2 +-
 target/rx/helper.c               |  2 +-
 target/s390x/cpu-system.c        |  2 +-
 target/sh4/cpu.c                 |  2 +-
 target/sh4/helper.c              |  2 +-
 target/sparc/cpu.c               |  2 +-
 target/sparc/mmu_helper.c        |  2 +-
 target/tricore/cpu.c             |  2 +-
 target/tricore/helper.c          |  2 +-
 target/xtensa/cpu.c              |  2 +-
 target/xtensa/mmu_helper.c       |  2 +-
 56 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 94e36ecdd18..1524d6f25bb 100644
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
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 2f611397782..378bd96d941 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -282,7 +282,7 @@ extern const VMStateDescription vmstate_alpha_cpu;
 
 void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a0a1d7fbe32..60f11379bfb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1260,7 +1260,7 @@ extern const VMStateDescription vmstate_arm_cpu;
 void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 
 typedef struct ARMGranuleProtectionConfig {
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 3da885c7ccb..a818db753b2 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -177,7 +177,7 @@ extern const struct VMStateDescription vms_avr_cpu;
 
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr avr_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 85f39401423..f453444d7f9 100644
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
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a836efd45ee..bdd4fff89d6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2581,7 +2581,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env);
 #ifndef CONFIG_USER_ONLY
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
 
-hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
 
diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 3286accc143..2d7ebb2d724 100644
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
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d7f508a9e80..7cf3791108c 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -185,7 +185,7 @@ struct M68kCPUClass {
 #ifndef CONFIG_USER_ONLY
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index ad5a4a8e7bf..068da605295 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -369,7 +369,7 @@ struct MicroBlazeCPUClass {
 #ifndef CONFIG_USER_ONLY
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
-hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
 #endif /* !CONFIG_USER_ONLY */
 G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 23e1ada1852..aab77b1b257 100644
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
diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index 5bb39b67519..fc4387ce7ae 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -296,7 +296,7 @@ void openrisc_translate_code(CPUState *cs, TranslationBlock *tb,
 int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
 #ifndef CONFIG_USER_ONLY
-hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
 bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                            MMUAccessType access_type, int mmu_idx,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index aba8109bbba..057c54bbb81 100644
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
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e42f3694089..fae839cade4 100644
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
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index b500b7a2474..64ba48a7329 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -136,7 +136,7 @@ struct RXCPUClass {
 const char *rx_crname(uint8_t cr);
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
-hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr rx_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index e36268b4256..4b0f3f6d97d 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -251,7 +251,7 @@ void sh4_translate_code(CPUState *cs, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc);
 
 #if !defined(CONFIG_USER_ONLY)
-hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr superh_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index ac0eb9f0faa..5f583ed9de2 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -580,7 +580,7 @@ struct SPARCCPUClass {
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_sparc_cpu;
 
-hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr sparc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif
 
 void sparc_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 604fb7792c6..12e497d2a7a 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -79,7 +79,7 @@ struct TriCoreCPUClass {
     ResettablePhases parent_phases;
 };
 
-hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr tricore_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 FIELD(PCXI, PCPN_13, 24, 8)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index dfd2ceab7cf..75cfeee6e30 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -590,7 +590,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr);
-hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr xtensa_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 bool xtensa_debug_check_breakpoint(CPUState *cs);
 #endif
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 273b9b7c223..93dc861083c 100644
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
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index ff053043a38..0c35067b202 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -242,7 +242,7 @@ static void alpha_cpu_initfn(Object *obj)
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
     .has_work = alpha_cpu_has_work,
-    .get_phys_page_debug = alpha_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = alpha_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index af6d7847d50..33fed0c746a 100644
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
index 330e9be4730..6e13873360d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2498,7 +2498,7 @@ static vaddr aarch64_untagged_addr(CPUState *cs, vaddr x)
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
     .has_work = arm_cpu_has_work,
-    .get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug,
+    .get_phys_addr_attrs_debug = arm_cpu_get_phys_addr_attrs_debug,
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 316e201cfe0..7dd3a7a3ede 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3963,7 +3963,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
     return res.f.phys_addr;
 }
 
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
                                          MemTxAttrs *attrs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8579a7283b1..35912192126 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -233,7 +233,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 static const struct SysemuCPUOps avr_sysemu_ops = {
     .has_work = avr_cpu_has_work,
-    .get_phys_page_debug = avr_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = avr_cpu_get_phys_addr_debug,
 };
 
 static const TCGCPUOps avr_tcg_ops = {
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 365c8c60e19..f3be8483b27 100644
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
index 92027d129a7..6443122cf1a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -244,7 +244,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
     .has_work = hppa_cpu_has_work,
-    .get_phys_page_debug = hppa_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = hppa_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index ffbad8acfd2..f5076492264 100644
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
index 97c66c22262..7248720a0eb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10877,7 +10877,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .has_work = x86_cpu_has_work,
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
-    .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
+    .get_phys_addr_attrs_debug = x86_cpu_get_phys_addr_attrs_debug,
     .asidx_from_attrs = x86_asidx_from_attrs,
     .get_crash_info = x86_cpu_get_crash_info,
     .write_elf32_note = x86_cpu_write_elf32_note,
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 108b02396de..8cc73f619a9 100644
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
index 9d0c391e36f..7943adb93fe 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -247,7 +247,7 @@ struct whpx_register_set {
  *          e. Let the affected CPU run in the exclusive mode.
  *          f. Restore the original handler and the exception exit bitmap.
  *        Note that handling all corner cases related to IDT/GDT is harder
- *        than it may seem. See x86_cpu_get_phys_page_attrs_debug() for a
+ *        than it may seem. See x86_cpu_get_phys_addr_attrs_debug() for a
  *        rough idea.
  *
  *     3. In order to properly support guest-level debugging in parallel with
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d8d106b07e5..8f277f76961 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -836,7 +836,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
-    .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
 };
 
 static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 4b7743c4f28..eb9684a4a16 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -359,7 +359,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
 }
 
-hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     CPULoongArchState *env = cpu_env(cs);
     MMUContext context;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f704a6af613..9ad3057d91c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -623,7 +623,7 @@ static const MonitorDef m68k_monitor_defs[] = {
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
-    .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = m68k_cpu_get_phys_addr_debug,
     .monitor_defs = m68k_monitor_defs,
 };
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bab1843892..2dd9ec1bdcb 100644
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
index 04d31536888..c6a456dd5ec 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -428,7 +428,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
     .has_work = mb_cpu_has_work,
-    .get_phys_page_attrs_debug = mb_cpu_get_phys_page_attrs_debug,
+    .get_phys_addr_attrs_debug = mb_cpu_get_phys_addr_attrs_debug,
 };
 #endif
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index da8abe063e7..f81c4f625b5 100644
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
index f803d477632..88bb59d506b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -545,7 +545,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mips_sysemu_ops = {
     .has_work = mips_cpu_has_work,
-    .get_phys_page_debug = mips_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = mips_cpu_get_phys_addr_debug,
     .legacy_vmsd = &vmstate_mips_cpu,
 };
 #endif
diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index b8e1a5ac98e..fbbbcf6e006 100644
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
index 3d1c22bf75d..ea29b2e01fa 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -247,7 +247,7 @@ static void openrisc_any_initfn(Object *obj)
 
 static const struct SysemuCPUOps openrisc_sysemu_ops = {
     .has_work = openrisc_cpu_has_work,
-    .get_phys_page_debug = openrisc_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = openrisc_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/or1k/mmu.c b/target/or1k/mmu.c
index 315debaf3e5..3ff288a1f94 100644
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
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 191f5726f69..d25f69f13ba 100644
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
index 08c9f63a132..cbed4fe50b6 100644
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
index a1345df7160..2499e619f85 100644
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
index a13727c0d4b..506a018d52b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2730,7 +2730,7 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
-    .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
     .monitor_get_register = riscv_monitor_get_register_legacy,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f786b1ebcd3..17305e1bb75 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1710,7 +1710,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
 
-hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index b5284199e6d..20b188c24cd 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -209,7 +209,7 @@ static void rx_cpu_init(Object *obj)
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
     .has_work = rx_cpu_has_work,
-    .get_phys_page_debug = rx_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = rx_cpu_get_phys_addr_debug,
 };
 
 static const TCGCPUOps rx_tcg_ops = {
diff --git a/target/rx/helper.c b/target/rx/helper.c
index daaeeec1b5c..0f99279bbaa 100644
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
index c9daa633c14..cc9685221ae 100644
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
index e2bde457618..40d5fde76df 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -278,7 +278,7 @@ static const VMStateDescription vmstate_sh_cpu = {
 
 static const struct SysemuCPUOps sh4_sysemu_ops = {
     .has_work = superh_cpu_has_work,
-    .get_phys_page_debug = superh_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = superh_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 5d6295618f5..b3ec7ce64d0 100644
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
index c6989229da6..3df199ada7b 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1013,7 +1013,7 @@ static const MonitorDef sparc64_monitor_defs[] = {
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
     .has_work = sparc_cpu_has_work,
-    .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = sparc_cpu_get_phys_addr_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
 #if defined(TARGET_SPARC64)
     .monitor_defs = sparc64_monitor_defs,
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 25f8a85fae4..34b212a7aa5 100644
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
index 04319e107ba..472c24ae32d 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -176,7 +176,7 @@ static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 static const struct SysemuCPUOps tricore_sysemu_ops = {
     .has_work = tricore_cpu_has_work,
-    .get_phys_page_debug = tricore_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = tricore_cpu_get_phys_addr_debug,
 };
 
 static const TCGCPUOps tricore_tcg_ops = {
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 7ee8c7fd699..ce1693622b7 100644
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
index 31429ec2f87..d6d42319e57 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -304,7 +304,7 @@ static const VMStateDescription vmstate_xtensa_cpu = {
 
 static const struct SysemuCPUOps xtensa_sysemu_ops = {
     .has_work = xtensa_cpu_has_work,
-    .get_phys_page_debug = xtensa_cpu_get_phys_page_debug,
+    .get_phys_addr_debug = xtensa_cpu_get_phys_addr_debug,
 };
 #endif
 
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 71330fc84b9..a126f6b6714 100644
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
2.53.0


