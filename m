Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894E4CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23dR-0006u7-SR; Fri, 26 Sep 2025 04:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23dL-0006oa-1S; Fri, 26 Sep 2025 04:16:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23dC-0001og-Qv; Fri, 26 Sep 2025 04:16:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5FFBA157D74;
 Fri, 26 Sep 2025 11:10:34 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6E9C4290C58;
 Fri, 26 Sep 2025 11:10:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 44/60] target/i386: Define enum X86ASIdx for x86's
 address spaces
Date: Fri, 26 Sep 2025 11:10:12 +0300
Message-ID: <20250926081031.2214971-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Define X86ASIdx as enum, like ARM's ARMASIdx, so that it's clear index 0
is for memory and index 1 is for SMM.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-By: Kirill Martynov <stdcalllevi@yandex-team.ru>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250730095253.1833411-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 591f817d819f5511fd9001dc863a326d23088811)
(Mjt: pick this change for completness with the previous one)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f977fc49a7..e0be7a7406 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2574,6 +2574,11 @@ static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
 
+typedef enum X86ASIdx {
+    X86ASIdx_MEM = 0,
+    X86ASIdx_SMM = 1,
+} X86ASIdx;
+
 #ifndef CONFIG_USER_ONLY
 static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 1dc1ba9b48..9c25b55839 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -99,7 +99,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * initialized at register_smram_listener() after machine init done.
      */
     cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
-    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
+    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
 
     return true;
 }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 47fb5c673c..5621200be0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2728,10 +2728,10 @@ static void register_smram_listener(Notifier *n, void *unused)
 
     address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
     kvm_memory_listener_register(kvm_state, &smram_listener,
-                                 &smram_address_space, 1, "kvm-smram");
+                                 &smram_address_space, X86ASIdx_SMM, "kvm-smram");
 
     CPU_FOREACH(cpu) {
-        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
+        cpu_address_space_init(cpu, X86ASIdx_SMM, "cpu-smm", &smram_as_root);
     }
 }
 
diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
index 0538a4fd51..7255862c24 100644
--- a/target/i386/tcg/system/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -74,8 +74,8 @@ bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     memory_region_set_enabled(cpu->cpu_as_mem, true);
 
     cs->num_ases = 2;
-    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
-    cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_as_root);
+    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
+    cpu_address_space_init(cs, X86ASIdx_SMM, "cpu-smm", cpu->cpu_as_root);
 
     /* ... SMRAM with higher priority, linked from /machine/smram.  */
     cpu->machine_done.notify = tcg_cpu_machine_done;
-- 
2.47.3


