Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE12E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4m-0005a5-8t; Fri, 10 Jan 2025 13:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2w-0000yU-LW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2u-0001EQ-BF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6QSpBB0Gnj+6e3q85vSXCFs8g+WJlM85mplVWUJQJk=;
 b=B88DgoH+8FYpAqnJjnqRQU7NErwv1JvzpwwXZF9poZz3AWYXTxGn+2lmWNfXZv+0xudxgI
 2lizk3ykq9bnss/+zPfIYQ6RVplOYt9TRCrK5JM6/qVess3c6CjJPlcKN4ZfA1wThXez7o
 H2EvDqCCoK8offO28jsmw2NptBzGEOc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-NwG7qLR7OEOr42ukQpKWCg-1; Fri, 10 Jan 2025 13:47:46 -0500
X-MC-Unique: NwG7qLR7OEOr42ukQpKWCg-1
X-Mimecast-MFC-AGG-ID: NwG7qLR7OEOr42ukQpKWCg
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d3f4cbbbbcso2451147a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534864; x=1737139664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6QSpBB0Gnj+6e3q85vSXCFs8g+WJlM85mplVWUJQJk=;
 b=Ep9jkCqngzu31kZJFiaTvdN8RbBV6MCKWSCMjN+WKntRxY7jfr3nsFWe23iuiCwPcz
 Ed2YkVqt5TavLo4n43gI/YnbJ9SdxjhAIYZPkBL90uwPG+Nw3yQtSlJD67eFnWWfQOAb
 jl95jpRHDdohjW3osPRSY863vF1AJE9KV1R5NdOlwM5i6KeHCse0aUH6Wuu30GpWziNr
 GZf1p+BJ6p8Y0KhrWXn3vzdq4eiV3ImnBLMDP3YPovkwz/84pC2uvcBHPCg7fG08eZjH
 Hm9q+7gn/hlgLL6tFzz1AnI60XwrnGCydGbJgQBMNxC8hg5F3oSf44cIvup4n3tFY9PD
 /L3g==
X-Gm-Message-State: AOJu0Yy/AcOxRfl2FAMTUE+aR03n648YoJT6AMW3OYiXFpizXuOR9KjT
 4g+5zV76z+F8bcIcMbHET6Zdu3ekLrndpr9Yfpb6XaRQKsx6IcH2UfenOJ2fdRA3AWfZn5L9k8D
 X6kyrCuH7ZG5KXzt1co853RoXm3bS9Jv1Jvcoxs1GacQSeh1oRl1bFdG+7L8SyCtRZvuip5gRkC
 WNFUelra5e4F+jYPNlVgjIEpW7eXYeDVSZAXxeXKs=
X-Gm-Gg: ASbGncscKiopJBOdpNSGeZmiH20F5zHhrCO6PzBOMliUEoZjfXRkNvJmX61nujAxt0/
 ro1gdK2yNkfZVywvczLlW5nNEKaqFYqXbdZrUJJK9b59tL7kFLjHVO7agO8S81eTVboMmIt35oX
 Hu2klAbQTU7eRJ77f6HyWAzvRVla1iT1S7Rkw+ojn2IS0kIn3xDCEelRhIeaiBWLUh5UMH0ESII
 PgBq0cxIkN1a1I/DhTa7LcP/uzDGRMDYx+M8KNCc9Tp5gJdmtpgL81eL1A=
X-Received: by 2002:a05:6402:3888:b0:5d1:2377:5ae2 with SMTP id
 4fb4d7f45d1cf-5d972dfb857mr10928611a12.7.1736534864387; 
 Fri, 10 Jan 2025 10:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH59bT2K+fXcTLzJEC5GaAJkmIOn2LgxaSF5XsO3TeGo8e62Cz92AB4QIzZk7XgaWvCKHichA==
X-Received: by 2002:a05:6402:3888:b0:5d1:2377:5ae2 with SMTP id
 4fb4d7f45d1cf-5d972dfb857mr10928593a12.7.1736534863869; 
 Fri, 10 Jan 2025 10:47:43 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c2d58sm1912386a12.39.2025.01.10.10.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 34/38] i386/cpu: Track a X86CPUTopoInfo directly in CPUX86State
Date: Fri, 10 Jan 2025 19:46:15 +0100
Message-ID: <20250110184620.408302-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The name of nr_modules/nr_dies are ambiguous and they mislead people.

The purpose of them is to record and form the topology information. So
just maintain a X86CPUTopoInfo member in CPUX86State instead. Then
nr_modules and nr_dies can be dropped.

As the benefit, x86 can switch to use information in
CPUX86State::topo_info and get rid of the nr_cores and nr_threads in
CPUState. This helps remove the dependency on qemu_init_vcpu(), so that
x86 can get and use topology info earlier in x86_cpu_realizefn(); drop
the comment that highlighted the depedency.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-7-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h        |  6 +----
 hw/i386/x86-common.c     | 12 ++++------
 target/i386/cpu-system.c |  6 ++---
 target/i386/cpu.c        | 51 +++++++++++++++++-----------------------
 4 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e8c46d877e0..b26e25ba15e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2068,11 +2068,7 @@ typedef struct CPUArchState {
 
     TPRAccess tpr_access_type;
 
-    /* Number of dies within this CPU package. */
-    unsigned nr_dies;
-
-    /* Number of modules within one die. */
-    unsigned nr_modules;
+    X86CPUTopoInfo topo_info;
 
     /* Bitmap of available CPU topology levels for this CPU. */
     DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 5b0629f9ad3..d5a44af2433 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -248,7 +248,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
     X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-    X86CPUTopoInfo topo_info;
+    X86CPUTopoInfo *topo_info = &env->topo_info;
 
     if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -267,15 +267,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         }
     }
 
-    init_topo_info(&topo_info, x86ms);
+    init_topo_info(topo_info, x86ms);
 
     if (ms->smp.modules > 1) {
-        env->nr_modules = ms->smp.modules;
         set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
     }
 
     if (ms->smp.dies > 1) {
-        env->nr_dies = ms->smp.dies;
         set_bit(CPU_TOPOLOGY_LEVEL_DIE, env->avail_cpu_topo);
     }
 
@@ -346,12 +344,12 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.module_id = cpu->module_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = x86_apicid_from_topo_ids(topo_info, &topo_ids);
     }
 
     cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
     if (!cpu_slot) {
-        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+        x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
 
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, module: %u, core: %u, thread: %u]"
@@ -374,7 +372,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index eb38cca68ff..b56a2821af2 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -312,11 +312,11 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 
 uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
 {
-    CPUState *cs = CPU(cpu);
+    CPUX86State *env = &cpu->env;
     uint64_t val;
 
-    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
-    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+    val = x86_threads_per_pkg(&env->topo_info);  /* thread count, bits 15..0 */
+    val |= x86_cores_per_pkg(&env->topo_info) << 16; /* core count, bits 31..16 */
 
     return val;
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a58c719e90c..1797bd8c071 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6496,15 +6496,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     CPUState *cs = env_cpu(env);
     uint32_t limit;
     uint32_t signature[3];
-    X86CPUTopoInfo topo_info;
+    X86CPUTopoInfo *topo_info = &env->topo_info;
     uint32_t threads_per_pkg;
 
-    topo_info.dies_per_pkg = env->nr_dies;
-    topo_info.modules_per_die = env->nr_modules;
-    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
-    topo_info.threads_per_core = cs->nr_threads;
-
-    threads_per_pkg = x86_threads_per_pkg(&topo_info);
+    threads_per_pkg = x86_threads_per_pkg(topo_info);
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
@@ -6581,12 +6576,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 *eax &= ~0xFC000000;
-                *eax |= max_core_ids_in_package(&topo_info) << 26;
+                *eax |= max_core_ids_in_package(topo_info) << 26;
                 if (host_vcpus_per_cache > threads_per_pkg) {
                     *eax &= ~0x3FFC000;
 
                     /* Share the cache at package level. */
-                    *eax |= max_thread_ids_for_cache(&topo_info,
+                    *eax |= max_thread_ids_for_cache(topo_info,
                                 CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
                 }
             }
@@ -6598,7 +6593,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             switch (count) {
             case 0: /* L1 dcache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    &topo_info,
+                                    topo_info,
                                     eax, ebx, ecx, edx);
                 if (!cpu->l1_cache_per_core) {
                     *eax &= ~MAKE_64BIT_MASK(14, 12);
@@ -6606,7 +6601,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 break;
             case 1: /* L1 icache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    &topo_info,
+                                    topo_info,
                                     eax, ebx, ecx, edx);
                 if (!cpu->l1_cache_per_core) {
                     *eax &= ~MAKE_64BIT_MASK(14, 12);
@@ -6614,13 +6609,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 break;
             case 2: /* L2 cache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
-                                    &topo_info,
+                                    topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        &topo_info,
+                                        topo_info,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -6703,12 +6698,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
         switch (count) {
         case 0:
-            *eax = apicid_core_offset(&topo_info);
-            *ebx = topo_info.threads_per_core;
+            *eax = apicid_core_offset(topo_info);
+            *ebx = topo_info->threads_per_core;
             *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
             break;
         case 1:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = apicid_pkg_offset(topo_info);
             *ebx = threads_per_pkg;
             *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
             break;
@@ -6734,7 +6729,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
 
-        encode_topo_cpuid1f(env, count, &topo_info, eax, ebx, ecx, edx);
+        encode_topo_cpuid1f(env, count, topo_info, eax, ebx, ecx, edx);
         break;
     case 0xD: {
         /* Processor Extended State */
@@ -7037,7 +7032,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * thread ID within a package".
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
-            *ecx = (apicid_pkg_offset(&topo_info) << 12) |
+            *ecx = (apicid_pkg_offset(topo_info) << 12) |
                    (threads_per_pkg - 1);
         } else {
             *ecx = 0;
@@ -7066,19 +7061,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         switch (count) {
         case 0: /* L1 dcache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax = *ebx = *ecx = *edx = 0;
@@ -7090,7 +7085,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001E:
         if (cpu->core_id <= 255) {
-            encode_topo_cpuid8000001e(cpu, &topo_info, eax, ebx, ecx, edx);
+            encode_topo_cpuid8000001e(cpu, topo_info, eax, ebx, ecx, edx);
         } else {
             *eax = 0;
             *ebx = 0;
@@ -7997,17 +7992,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
      * based on inputs (sockets,cores,threads), it is still better to give
      * users a warning.
-     *
-     * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
-     * cs->nr_threads hasn't be populated yet and the checking is incorrect.
      */
     if (IS_AMD_CPU(env) &&
         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
-        cs->nr_threads > 1) {
+        env->topo_info.threads_per_core > 1) {
             warn_report_once("This family of AMD CPU doesn't support "
                              "hyperthreading(%d). Please configure -smp "
                              "options properly or try enabling topoext "
-                             "feature.", cs->nr_threads);
+                             "feature.", env->topo_info.threads_per_core);
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -8168,8 +8160,7 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
-    env->nr_modules = 1;
-    env->nr_dies = 1;
+    env->topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
 
     /* thread, core and socket levels are set by default. */
     set_bit(CPU_TOPOLOGY_LEVEL_THREAD, env->avail_cpu_topo);
-- 
2.47.1


