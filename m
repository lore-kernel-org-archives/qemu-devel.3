Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC76E748FC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 22:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAqd-0005ay-Mi; Tue, 23 Dec 2025 17:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vYAqc-0005a7-Ik
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:27:18 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vYAqa-0007Ov-76
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:27:18 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so47903555ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766528835; x=1767133635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJYfQlBYDXhbhN9E1l5HO05rbwBk+2rXeM5gYl5pVHM=;
 b=VVjBoMfu2M6sWrLfaxgyaH2lOzOGxVcj3/JI06dhEvOefvDmsep4eqJ82RUXldmYbc
 4nAn+PztNGBqJ2uj7zIxzbCh442hRLUrOSmGjhRuzvCxAcs7nnXv9cUsdZpfHQMGhh87
 GQZzbjUhIMMSApJMKalAJE3NhzLf7VpEGLBmhEFn3z1k/OqhIt3Y6qMSsLKAobN5N5PZ
 m9ymURNGvHjZ/LaQqH/5c+sj2IcyddDaC3EsX0+UDJO3+vxtbd9gCr1ErNTnQgutPtYv
 CUfTfqI60Fm4BJWNOf/YV3VJEcd2DIHRpot2oenpXevL6Jitv2RZY0Cld23vMrORJ/CY
 hqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766528835; x=1767133635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJYfQlBYDXhbhN9E1l5HO05rbwBk+2rXeM5gYl5pVHM=;
 b=KGGpgx95f3Li93C5FwkNDRau+CwANeF0kO/Kv5twffPL4/rYj3yvNSVmi5WW4PYVcq
 VPpzSZmsg5IW6MQD6oE44JS+HyUV0rkKjaNo8MeKOpvnGJX546LNwj5CAgleKQQgS1/m
 hzbY+J/uQOGIFAKeZJqn53WNWs8nRCS7T3BIalwIJdS3OpVkmdVsHdaLEsxqdbYYvhXg
 y5zciE61/tV7yAPhqO5vL/v6wrahlnJnuOU0cTPGA08kuyk2hQ4w/vIcg6QjhUErpqRP
 AusR/EKDT+QiHAKikjXP1AjoTkV37knarqJx4yClewd98HSnzQ+2yGC5UvT1zQc55INK
 YoUA==
X-Gm-Message-State: AOJu0YwDpcxapFKr6IJ10maQiOBrDwOIcqae4DfvX7rPLKW9WD4+jDe3
 sWY0gaM79Zmt3kEZmebypCdhpTIrP/PvBhgUhElTxnhEe8g8bqGtUOChb1prjPDLLPBKmHVE77y
 KYnV5glE=
X-Gm-Gg: AY/fxX4oHgu6p7NHzRd3tGeqobGmaMbK0m+xrRQD0kPhE6Bl6eILC2/Mw17i4qj+wZs
 0Wy2x/MUZsSZy277bXF/KWi59isVRvHKiJBp1o/Z+Hx3XkwHCqkaz+RxAklwGkkn/9Df1grjovA
 gR5QVORm1EXAFeIGOyko8MWad2V+oMazvgXGvmHLSK3FEBdAfWTzlXyXvZZqQEvw8jiwseVoV3D
 DsmxWsiGXz/VzVSN5fueNXKY/zxzMzK2qwxneTT8n5ttXOpKg3IpUyo0ArER0bEwKlmlG22cmcT
 LB6yPorwVzmkhnSkmUmTmA+x27xA+oreGeePLe9cxTEwNel50fcl2Ur6fVw2CM0LdPA5Ap+CKXU
 5I/GxT+I0eFByiy1YBglm/JrVuRA6IwMsr1qcu68rMTkaXACxHZjxA/ed2uVoSlJ3BRq/a6nWyo
 mIhF+DiTGFlNwo1EHt
X-Google-Smtp-Source: AGHT+IGWeHoGP9jfgKazqGkN9JN4cL1iZYDdWtOjtdaiGDCaOmCjShsfpwBmejsbAkyB36K6/60lmQ==
X-Received: by 2002:a05:7022:503:b0:11d:f440:b760 with SMTP id
 a92af1059eb24-121722dd441mr15022063c88.23.1766528834451; 
 Tue, 23 Dec 2025 14:27:14 -0800 (PST)
Received: from gromero0.. ([179.93.129.179]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217243bbe3sm62803123c88.0.2025.12.23.14.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 14:27:14 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 4/4] cpus: Define total number of address spaces in CPUClass
Date: Tue, 23 Dec 2025 19:26:49 -0300
Message-Id: <20251223222649.187935-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223222649.187935-1-gustavo.romero@linaro.org>
References: <20251223222649.187935-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x644.google.com
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

Define upfront in CPUClass the total number of address spaces a CPU can
use rather than allocating it on-demand in cpu_address_space_init() by
allocating it in cpu_exec_initfn() and always releasing it in
cpu_common_finalize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/core/cpu-common.c      |  2 +-
 hw/core/cpu-system.c      |  6 ------
 include/hw/core/cpu.h     |  3 +++
 system/cpus.c             |  7 ++++---
 system/physmem.c          | 22 ++++++++++++++++------
 target/arm/cpu.c          |  1 +
 target/i386/cpu.c         |  1 +
 target/i386/kvm/kvm-cpu.c |  1 -
 8 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8c306c89e4..2921d07506 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -309,7 +309,6 @@ static void cpu_common_initfn(Object *obj)
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     cpu->as = NULL;
-    cpu->num_ases = 0;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_threads = 1;
@@ -359,6 +358,7 @@ static void cpu_common_finalize(Object *obj)
     qemu_cond_destroy(cpu->halt_cond);
     g_free(cpu->halt_cond);
     g_free(cpu->thread);
+    g_free(cpu->cpu_ases);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index f601a083d1..b6a290b648 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -188,12 +188,6 @@ void cpu_exec_class_post_init(CPUClass *cc)
     g_assert(cc->sysemu_ops->has_work);
 }
 
-void cpu_exec_initfn(CPUState *cpu)
-{
-    cpu->memory = get_system_memory();
-    object_ref(OBJECT(cpu->memory));
-}
-
 static int cpu_common_post_load(void *opaque, int version_id)
 {
     if (tcg_enabled()) {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9615051774..f88a5729e7 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -145,6 +145,7 @@ struct SysemuCPUOps;
  * address before attempting to match it against watchpoints.
  * @deprecation_note: If this CPUClass is deprecated, this field provides
  *                    related information.
+ * @num_ases: Total number of address spaces usable by the architecture.
  *
  * Represents a CPU family or model.
  */
@@ -195,6 +196,8 @@ struct CPUClass {
     int reset_dump_flags;
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
+    /* Total number of address spaces. */
+    unsigned num_ases;
 };
 
 /*
diff --git a/system/cpus.c b/system/cpus.c
index ef2d2f241f..638e558153 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -715,10 +715,11 @@ void qemu_init_vcpu(CPUState *cpu)
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
     if (!cpu->as) {
-        /* If the target cpu hasn't set up any address spaces itself,
-         * give it the default one.
+        /*
+         * If the target has not set up the address space 0 (main memory),
+         * set it. Address space 0 is special and has an alias kept in
+         * cpu->as. If address space 0 is set up cpu->as is always != NULL.
          */
-        cpu->num_ases = 1;
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..c06bd5ce06 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -775,6 +775,22 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 
 #endif /* CONFIG_TCG */
 
+void cpu_exec_initfn(CPUState *cpu)
+{
+
+    /*
+     * If the total number of address spaces for CPUs is not defined explicitly
+     * by the arch the default is 1 address space.
+     */
+    unsigned num_ases = cpu->cc->num_ases ? cpu->cc->num_ases : 1;
+
+    cpu->cpu_ases = g_new0(CPUAddressSpace, num_ases);
+    cpu->num_ases = num_ases;
+
+    cpu->memory = get_system_memory();
+    object_ref(OBJECT(cpu->memory));
+}
+
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
 {
@@ -795,10 +811,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
         cpu->as = as;
     }
 
-    if (!cpu->cpu_ases) {
-        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
-    }
-
     newas = &cpu->cpu_ases[asidx];
     newas->cpu = cpu;
     newas->as = as;
@@ -831,8 +843,6 @@ void cpu_destroy_address_spaces(CPUState *cpu)
         }
         g_clear_pointer(&cpuas->as, address_space_destroy_free);
     }
-
-    g_clear_pointer(&cpu->cpu_ases, g_free);
 }
 
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1640b20b4d..cd73991f9f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2391,6 +2391,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
+    cc->num_ases = ARMASIdx_COUNT;
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_arch_name = arm_gdb_arch_name;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6417775786..5f6fc176fd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10106,6 +10106,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     cc->get_arch_id = x86_cpu_get_arch_id;
 
 #ifndef CONFIG_USER_ONLY
+    cc->num_ases = X86ASIdx_COUNT;
     cc->sysemu_ops = &i386_sysemu_ops;
 #endif /* !CONFIG_USER_ONLY */
 #ifdef CONFIG_TCG
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c25b55839..855edd164d 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -98,7 +98,6 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * Only initialize address space 0 here, the second one for SMM is
      * initialized at register_smram_listener() after machine init done.
      */
-    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
     cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
 
     return true;
-- 
2.34.1


