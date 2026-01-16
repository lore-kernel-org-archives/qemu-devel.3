Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62C8C982F2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgp2E-0001NL-Bm; Fri, 16 Jan 2026 13:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vgp2B-0001Mg-Tf
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:58:59 -0500
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vgp29-0000os-U1
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:58:59 -0500
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2ae38f81be1so3085231eec.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768589936; x=1769194736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dD58qFARsmRZnxnaDRYrSzPzDgK5Gv7y7VJTnAnFWYs=;
 b=y9UN1yahFXHQOejksSkFvjB20+mVBtgbpCz/eicy7PM9pB2/s7i6Tom6UevjqIkG/f
 i5wfZvO/7o6pqjb88/0V/ywDsaqto+91besTuMSwat7KGnKJe81OhEu0xAZrAacUmyqH
 i/PoBiyDxrBI3TutwoRSBvVpJCqq+C6ITUbeePkRw+IDzGdnCGB7sRAdZeL4oP+ti1hi
 8KJEBBG3KC4+Vv5JaDe2TXpwqMp65GjIOIL3+RPugsaJrwQ/jS3XO9n48rca2sYpP9DQ
 ZyaQ9XKxk+Us5+MzTOmpDQKKc9k9mkB5K3SbnZzau/B3Wno0kWjPW8Hc/yOWTSfNC9tV
 h0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768589936; x=1769194736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dD58qFARsmRZnxnaDRYrSzPzDgK5Gv7y7VJTnAnFWYs=;
 b=BA1zzD41DJuSIVL+GefaboTp43OZx3wnLXSDgUeFsBhUmTuEZKImT6/Lsa05ioQH2D
 T0f6xJm4Rgxt5TTUR0A1pW8ekRxfeWeYBDTvH6XRjHhxTK8ZVwUOp8znlofTBiIaGZko
 rhlM/E2+wtvM6Ij6OHccbYonVWVXgOdpawu+yuJsiAFK3n92ZO1wDiv6zupJx9qzXnud
 ZmsGOEAG5vUCP3zQYxl+wO35pkRyhocl/gNgtJi+s7TPJt402uriABScFrAdY47d8FPv
 WDfHMne6qUMLLyiG5W5jBSNW+DBZDS/nllTPoAi8+SgGSo4RP1LWwDyQTzPeRVKyP1wv
 qpKw==
X-Gm-Message-State: AOJu0YykuCmr9fkq/kFhRhokQ6LHL5wcLaL/5YJg1TaPZl3+cT9GvX/W
 FjD0Z8k2yL/+WCTYLmIRk0Z1TX0eqnovda8SzQPYmASCsoD4rImOYvd+5ZIdJxxehXZG2XkYHaj
 P0pQ1
X-Gm-Gg: AY/fxX6eWEDoe1pPbtNKzBMO9YUl65c4w6yHV9O6o5bZkaZSzoEF90dgGBQrihE3cKS
 XVHsOo3oWkGBacRMKuOxWssIn2NV6E4YPz/SwGDcHEf0egbSHzGYsx6N5BarDjYVcx8j9/CBMlk
 tRIZ533rxy+IjizNmuFJj94LCX0rQa/Swws6r+IUMhEBYGNjr2OnW3h/uPc4ugPRz0aY3oXw2Ap
 yOSuLh092jQQxHCE1zzj+LNW5zkYAzfx08V+hRgJZVvcgOsgpDahfODueMA/3ehgNI/CMSN4zDC
 g0AZV1Iuz3xhKJK1A933POX4Ovyc3dgA9W5bVsuXEoQLyyHHcL2v03GeDKzaLtb4zQjkb118wr6
 pPWDnJ2vKK75vtrjb5bimiRM/8RXfTl4HAycaXzO4GzQ0bb3ovyjVyDp2CHiGx7jzBh1sFqvLhU
 IlPzJi5d2Y8ZGVZg==
X-Received: by 2002:a05:7301:1687:b0:2ae:5b32:774 with SMTP id
 5a478bee46e88-2b6b46d2a6bmr4090451eec.7.1768589934626; 
 Fri, 16 Jan 2026 10:58:54 -0800 (PST)
Received: from gromero0.. ([191.8.214.17]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6c2de1f29sm1524126eec.15.2026.01.16.10.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:58:54 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v4 4/4] cpus: Allocate maximum number of ASes supported by the
 arch
Date: Fri, 16 Jan 2026 15:58:14 -0300
Message-Id: <20260116185814.108560-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116185814.108560-1-gustavo.romero@linaro.org>
References: <20260116185814.108560-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=gustavo.romero@linaro.org; helo=mail-dy1-x1334.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Instead of computing the number of address spaces used for a given
architecture, machine, and CPU configuration, simplify the code by
always allocating the maximum number of CPUAddressSpaces supported
by the architecture.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/core/cpu-common.c             |  1 -
 hw/core/cpu-system.c             |  2 +-
 include/exec/cpu-common.h        |  4 ----
 include/hw/core/cpu.h            |  7 +++++--
 system/cpus.c                    |  1 -
 system/physmem.c                 |  8 ++++----
 target/arm/cpu.c                 | 11 +----------
 target/i386/cpu.c                |  1 +
 target/i386/kvm/kvm-cpu.c        |  1 -
 target/i386/tcg/system/tcg-cpu.c |  1 -
 10 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 6d54c12a77..e314f916f8 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -310,7 +310,6 @@ static void cpu_common_initfn(Object *obj)
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     cpu->as = NULL;
-    cpu->num_ases = 0;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_threads = 1;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 48c8ddf4b1..4a91c3e8ec 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -86,7 +86,7 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
 
     if (cpu->cc->sysemu_ops->asidx_from_attrs) {
         ret = cpu->cc->sysemu_ops->asidx_from_attrs(cpu, attrs);
-        assert(ret < cpu->num_ases && ret >= 0);
+        assert(ret <= cpu->cc->max_as && ret >= 0);
     }
     return ret;
 }
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b2e02c60d4..1eb2873460 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -51,10 +51,6 @@ void tcg_iommu_free_notifier_list(CPUState *cpu);
  * The target-specific code which registers ASes is responsible
  * for defining what semantics address space 0, 1, 2, etc have.
  *
- * Before the first call to this function, the caller must set
- * cpu->num_ases to the total number of address spaces it needs
- * to support.
- *
  * Note that with KVM only one address space is supported.
  */
 void cpu_address_space_init(CPUState *cpu, int asidx,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f6f17df9e6..61da2ea433 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -145,6 +145,9 @@ struct SysemuCPUOps;
  * address before attempting to match it against watchpoints.
  * @deprecation_note: If this CPUClass is deprecated, this field provides
  *                    related information.
+ * @max_as: Maximum valid index used to refer to the address spaces supported by
+ *          the architecture, i.e., to refer to CPUAddressSpaces in
+ *          CPUState::cpu_ases.
  *
  * Represents a CPU family or model.
  */
@@ -195,6 +198,8 @@ struct CPUClass {
     int reset_dump_flags;
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
+
+    int max_as;
 };
 
 /*
@@ -443,7 +448,6 @@ struct qemu_work_item;
  * @icount_extra: Instructions until next timer event.
  * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
  *            AddressSpaces this CPU has)
- * @num_ases: number of CPUAddressSpaces in @cpu_ases
  * @as: Pointer to the first AddressSpace, for the convenience of targets which
  *      only have a single AddressSpace
  * @gdb_regs: Additional GDB registers.
@@ -516,7 +520,6 @@ struct CPUState {
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     struct CPUAddressSpace *cpu_ases;
-    int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
 
diff --git a/system/cpus.c b/system/cpus.c
index 49deeb9468..bded87feb1 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -718,7 +718,6 @@ void qemu_init_vcpu(CPUState *cpu)
         /* If the target cpu hasn't set up any address spaces itself,
          * give it the default one.
          */
-        cpu->num_ases = 1;
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
diff --git a/system/physmem.c b/system/physmem.c
index 9a7aba9521..b0311f4531 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -786,8 +786,8 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     address_space_init(as, mr, as_name);
     g_free(as_name);
 
-    /* Target code should have set num_ases before calling us */
-    assert(asidx < cpu->num_ases);
+    /* Target code should have set max_as before calling us */
+    assert(asidx <= cpu->cc->max_as);
 
     if (asidx == 0) {
         /* address space 0 gets the convenience alias */
@@ -795,7 +795,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     }
 
     if (!cpu->cpu_ases) {
-        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
+        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->cc->max_as + 1);
     }
 
     newas = &cpu->cpu_ases[asidx];
@@ -819,7 +819,7 @@ void cpu_destroy_address_spaces(CPUState *cpu)
     /* convenience alias just points to some cpu_ases[n] */
     cpu->as = NULL;
 
-    for (asidx = 0; asidx < cpu->num_ases; asidx++) {
+    for (asidx = 0; asidx <= cpu->cc->max_as; asidx++) {
         cpuas = &cpu->cpu_ases[asidx];
         if (!cpuas->as) {
             /* This index was never initialized; no deinit needed */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9254e0d06c..aa9fe0ab9b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2148,16 +2148,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     unsigned int smp_cpus = ms->smp.cpus;
     bool has_secure = cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY);
 
-    /*
-     * We must set cs->num_ases to the final value before
-     * the first call to cpu_address_space_init.
-     */
-    if (cpu->tag_memory != NULL) {
-        cs->num_ases = 3 + has_secure;
-    } else {
-        cs->num_ases = 1 + has_secure;
-    }
-
     cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 
     if (has_secure) {
@@ -2391,6 +2381,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
+    cc->max_as = ARMASIdx_MAX;
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_arch_name = arm_gdb_arch_name;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37803cd724..2de235ca4b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10626,6 +10626,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     cc->get_arch_id = x86_cpu_get_arch_id;
 
 #ifndef CONFIG_USER_ONLY
+    cc->max_as = X86ASIdx_MAX;
     cc->sysemu_ops = &i386_sysemu_ops;
 #endif /* !CONFIG_USER_ONLY */
 #ifdef CONFIG_TCG
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 33a8c26bc2..c34d9f15c7 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -98,7 +98,6 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * Only initialize address space 0 here, the second one for SMM is
      * initialized at register_smram_listener() after machine init done.
      */
-    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
     cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
 
     return true;
diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
index 7255862c24..b74e025b3e 100644
--- a/target/i386/tcg/system/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -73,7 +73,6 @@ bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->cpu_as_mem, 0);
     memory_region_set_enabled(cpu->cpu_as_mem, true);
 
-    cs->num_ases = 2;
     cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
     cpu_address_space_init(cs, X86ASIdx_SMM, "cpu-smm", cpu->cpu_as_root);
 
-- 
2.34.1


