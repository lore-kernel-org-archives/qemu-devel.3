Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4929E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtKN-0002sP-78; Mon, 06 Jan 2025 15:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtKK-0002qF-PC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtKH-0003cP-BD
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:52 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso14193128f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736193828; x=1736798628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQTkKmwN0la/zq4/AmggU7ruV8aWhlAE2m8oe1Or7Yc=;
 b=LBR/DXZRmSrzf6cNzKaXGzcg5zmJ7W8SRehar81uDGTmoZKgNXjqnmSMUvumBQrO/R
 sVm4d7K+uRJjwivKq2IARdDmn+wrFhIjdwM8eX+M7eS7FVh90eudcFo+XWw5sLQ4khZW
 l6uv2wKASPzPy8Y3GDGJWO7s+AMhfhJoMNBfBvjIZIzfQIeUa2lk/ELfjUUugXE4MvBv
 3I7akvh9HzQTjLA5UXgX1O1MJUioU0NdS8924IenP/Icii1RQqDOGKBEvlX1KXI/sPZi
 ySEmN++NXtqf69DxjGpM382IhL8wTQ7CXTAAQ+j3RoQdKltV5Y8HaG4w77Rj9rpilhsG
 Gubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736193828; x=1736798628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQTkKmwN0la/zq4/AmggU7ruV8aWhlAE2m8oe1Or7Yc=;
 b=cepJNaGUr6jx/FWifNIkbWGKbX0iVrHIQR+5CK5PyRHqxg+Y8c4037gZrngcVFNBpD
 +oUcbHyvtLz3SOqnnE2k+xyvKc0TEobPwut7Zt30pxZCbL4iH4AViK+rAXN5BYpw2otT
 7CAsavC6PXIWpwx0O9GXA7TF5VYX6l5slGBgya4nobsN7tdQQiI56twwe7JGdXO0lWFm
 L3BmontxAQD+spaKJ8QGjYTkE0+hKKq7rq3MVX6rmEZ2wV85g4buNC5jSXk+qIhCw7Uw
 on9uYoQ9PpFnVzb5smud8DyWfWgXddsHGoCgRI6XfWgAKRtFbEhQ4u4jI6PWjsCs8hyf
 kGrw==
X-Gm-Message-State: AOJu0Yxf9p+4Hyl/FxB6Q5u87IhjDD2XdPR7X61503LgMvssSw0ZnMqx
 YdNNstYR7n3zDlQoO1/pHnpZDKPXtxRbngdWnJFD3RXTPmvfUim0nrAwUrInHiLKMZvQzbqd9FJ
 oyfo=
X-Gm-Gg: ASbGncszjujSgWa67lJgRVVe/jxZ/TL3ZNIQtNDbjkZNmubaDjfxirJbg7MTitLSyvM
 S0kiEu2NO73gcwDqxMimYIde8J3LoSxrmT7hkt5Pa5lhgQRG9H/8Zoyvb7BB6HROg+W0rUbIMpm
 TVFr0AzjttOZokyy3TChidq6A6n6RgST18APY4W8UASm+wHo7369zE71DvIwyYb3QHSb/goeMQt
 AOBGOqmKHIALkBqNVy9nnC4ba6sywc1WSRA031pLxcs4JkROJYhPmXJbRM++Y3PTnwRYyffoiIr
 0fugErAFYzOQ3HbHlC17oD1uqdpzoZY=
X-Google-Smtp-Source: AGHT+IHDE/cbM5Uz3mC6dPWI+SKnpmJxnVL7+eC7vPChMfg/0MfF0CSgk918tvS7UmQNdLQuffdZDw==
X-Received: by 2002:a5d:6c64:0:b0:385:f6f4:f8e with SMTP id
 ffacd0b85a97d-38a223ff1cemr40988273f8f.50.1736193825978; 
 Mon, 06 Jan 2025 12:03:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436723cb159sm525092965e9.16.2025.01.06.12.03.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 12:03:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 7/7] accel/kvm: Use CPU_FOREACH_KVM()
Date: Mon,  6 Jan 2025 21:02:58 +0100
Message-ID: <20250106200258.37008-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106200258.37008-1-philmd@linaro.org>
References: <20250106200258.37008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Only iterate over KVM vCPUs when running KVM specific code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm_int.h         |  3 +++
 accel/kvm/kvm-all.c              | 14 +++++++-------
 hw/i386/kvm/clock.c              |  3 ++-
 hw/intc/spapr_xive_kvm.c         |  5 +++--
 hw/intc/xics_kvm.c               |  5 +++--
 target/i386/kvm/kvm.c            |  4 ++--
 target/i386/kvm/xen-emu.c        |  2 +-
 target/s390x/kvm/kvm.c           |  2 +-
 target/s390x/kvm/stsi-topology.c |  3 ++-
 9 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 4de6106869b..0ef4c336b18 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -13,6 +13,7 @@
 #include "qapi/qapi-types-common.h"
 #include "qemu/accel.h"
 #include "qemu/queue.h"
+#include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "hw/boards.h"
 #include "hw/i386/topology.h"
@@ -168,6 +169,8 @@ struct KVMState
     char *device;
 };
 
+#define CPU_FOREACH_KVM(cpu) CPU_FOREACH_HWACCEL(cpu)
+
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id, const char *name);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790433c..9b26b286865 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -872,7 +872,7 @@ static uint64_t kvm_dirty_ring_reap_locked(KVMState *s, CPUState* cpu)
     if (cpu) {
         total = kvm_dirty_ring_reap_one(s, cpu);
     } else {
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_KVM(cpu) {
             total += kvm_dirty_ring_reap_one(s, cpu);
         }
     }
@@ -935,7 +935,7 @@ static void kvm_cpu_synchronize_kick_all(void)
 {
     CPUState *cpu;
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_KVM(cpu) {
         run_on_cpu(cpu, do_kvm_cpu_synchronize_kick, RUN_ON_CPU_NULL);
     }
 }
@@ -3535,7 +3535,7 @@ int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
         }
     }
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_KVM(cpu) {
         err = kvm_update_guest_debug(cpu, 0);
         if (err) {
             return err;
@@ -3574,7 +3574,7 @@ int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
         }
     }
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_KVM(cpu) {
         err = kvm_update_guest_debug(cpu, 0);
         if (err) {
             return err;
@@ -3592,7 +3592,7 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
     QTAILQ_FOREACH_SAFE(bp, &s->kvm_sw_breakpoints, entry, next) {
         if (kvm_arch_remove_sw_breakpoint(cpu, bp) != 0) {
             /* Try harder to find a CPU that currently sees the breakpoint. */
-            CPU_FOREACH(tmpcpu) {
+            CPU_FOREACH_KVM(tmpcpu) {
                 if (kvm_arch_remove_sw_breakpoint(tmpcpu, bp) == 0) {
                     break;
                 }
@@ -3603,7 +3603,7 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
     }
     kvm_arch_remove_all_hw_breakpoints();
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_KVM(cpu) {
         kvm_update_guest_debug(cpu, 0);
     }
 }
@@ -4384,7 +4384,7 @@ static void query_stats_cb(StatsResultList **result, StatsTarget target,
         stats_args.result.stats = result;
         stats_args.names = names;
         stats_args.errp = errp;
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_KVM(cpu) {
             if (!apply_str_list_filter(cpu->parent_obj.canonical_path, targets)) {
                 continue;
             }
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 63be5088420..f2638cf2c22 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -17,6 +17,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "system/kvm.h"
+#include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "system/hw_accel.h"
 #include "kvm/kvm_i386.h"
@@ -196,7 +197,7 @@ static void kvmclock_vm_state_change(void *opaque, bool running,
         if (!cap_clock_ctrl) {
             return;
         }
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_KVM(cpu) {
             run_on_cpu(cpu, do_kvmclock_ctrl, RUN_ON_CPU_NULL);
         }
     } else {
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 26d30b41c15..08354f08512 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -14,6 +14,7 @@
 #include "target/ppc/cpu.h"
 #include "system/cpus.h"
 #include "system/kvm.h"
+#include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
@@ -678,7 +679,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
      * 'post_load' handler of XiveTCTX because the machine is not
      * necessarily connected to the KVM device at that time.
      */
-    CPU_FOREACH(cs) {
+    CPU_FOREACH_KVM(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
         ret = kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &local_err);
@@ -795,7 +796,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
         kvmppc_xive_change_state_handler, xive);
 
     /* Connect the presenters to the initial VCPUs of the machine */
-    CPU_FOREACH(cs) {
+    CPU_FOREACH_KVM(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
         ret = kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, errp);
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index ee72969f5f1..aed2ad44363 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "system/kvm.h"
+#include "system/kvm_int.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/xics.h"
@@ -418,7 +419,7 @@ int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers,
     kvm_gsi_direct_mapping = true;
 
     /* Create the presenters */
-    CPU_FOREACH(cs) {
+    CPU_FOREACH_KVM(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
         icp_kvm_realize(DEVICE(spapr_cpu_state(cpu)->icp), &local_err);
@@ -434,7 +435,7 @@ int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers,
     }
 
     /* Connect the presenters to the initial VCPUs of the machine */
-    CPU_FOREACH(cs) {
+    CPU_FOREACH_KVM(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         icp_set_kvm_state(spapr_cpu_state(cpu)->icp, &local_err);
         if (local_err) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2f66e63b880..437911d6c6a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -329,7 +329,7 @@ void kvm_synchronize_all_tsc(void)
     CPUState *cpu;
 
     if (kvm_enabled()) {
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_KVM(cpu) {
             run_on_cpu(cpu, do_kvm_synchronize_tsc, RUN_ON_CPU_NULL);
         }
     }
@@ -2847,7 +2847,7 @@ static void *kvm_msr_energy_thread(void *data)
          * Identify the vcpu threads
          * Calculate the number of vcpu per package
          */
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_KVM(cpu) {
             for (int i = 0; i < num_threads; i++) {
                 if (cpu->thread_id == thd_stat[i].thread_id) {
                     thd_stat[i].is_vcpu = true;
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index e81a2458812..36ae9c11252 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -1422,7 +1422,7 @@ int kvm_xen_soft_reset(void)
         return err;
     }
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_KVM(cpu) {
         async_run_on_cpu(cpu, do_vcpu_soft_reset, RUN_ON_CPU_NULL);
     }
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index db645a48133..a02e78ce807 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1559,7 +1559,7 @@ static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
         return;
     }
 
-    CPU_FOREACH(t) {
+    CPU_FOREACH_KVM(t) {
         run_on_cpu(t, s390_do_cpu_set_diag318,
                    RUN_ON_CPU_HOST_ULONG(diag318_info));
     }
diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
index c8d6389cd87..cf1a9b5d218 100644
--- a/target/s390x/kvm/stsi-topology.c
+++ b/target/s390x/kvm/stsi-topology.c
@@ -10,6 +10,7 @@
 #include "cpu.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/cpu-topology.h"
+#include "system/kvm_int.h"
 
 QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_LOW != 1);
 QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_MEDIUM != 2);
@@ -256,7 +257,7 @@ static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
 
     QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
 
-    CPU_FOREACH(cs) {
+    CPU_FOREACH_KVM(cs) {
         S390TopologyId id = s390_topology_from_cpu(S390_CPU(cs));
         S390TopologyEntry *entry = NULL, *tmp;
 
-- 
2.47.1


