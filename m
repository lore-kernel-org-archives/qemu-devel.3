Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A58BD66BB2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 21:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVyxO-0000A6-DS; Wed, 17 Dec 2025 16:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxJ-0008Tw-S4
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:11 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxG-0004ch-OC
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:08 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so5105738b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 13:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766006465; x=1766611265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vW3yF4FTRUZh5FCldFHo0wmFnTNC+Anm6XgXXn1BVVU=;
 b=yiTbWMmN5Q1LhAFXtT/YtxQFbYI4oGW8xUYSYmQWGuAP4qolW9DBgPn6iFs3bvPSA2
 AwFx1gAEVtXPDc88UWfyOclmqOTyUpf1z7LftsWKowLQvPn08iZZO/ncCQIv+qfMve3n
 srO9ENMCpnUmQAUWyiRE01JXDPz87K4ly7dJkMzHoB9/RGuH204daMWkbSN023sAkf91
 +NeABE7pYj7xkjA1deQxr0PX/lRQSfpX2M739uduViXPdK81+GTXl1ElHnJVdKHa5C2y
 PUqmk7xE7iqJbNlFfCpQQFjOmEzW7nabP6UeHXRyMnfxdujjcRqaj1cIHbM0Ftkc3fT2
 XCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766006465; x=1766611265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vW3yF4FTRUZh5FCldFHo0wmFnTNC+Anm6XgXXn1BVVU=;
 b=bVNS1dY/QLibyXy+495xxa81inn/cOa3tHOqn+HsSquFYPb884QuNCd5uzvwSRvsNk
 M3mk3jsOS7Q2a+dEpPKK8GXpcnFqTH3VPsSLcu46A1F/b109f95DNDHkz1STyGXieKdl
 RJUWdg7sMIg+1HA2wfJmacx0XcMwZzRV8AZBUUk7nVYTrmoo+C4PoT/hmlKcyV/PbFM7
 k68K5vy0rOVKu/vqVf3CfrxhOmobGK26TniNVrze6XCoO6Ed1SC4ADIXmJzZKcK69KZ9
 ixRMGYzT5P18XfOm4UzGvd+QH3KKKpFKISZqmDmqjX94c7vdYqQtyR1zMFIBzWYllvOg
 ZEiA==
X-Gm-Message-State: AOJu0YxLOYyzq2+1EeXxnKXUsbm3vwKr7CQY/SzWkyDMQAVABHf3E+lJ
 PqCj/t0tC26PHj3aQ9wFr5IXEPc6pvM35fiMNc1QnvUJrg+e8v/dlK6i/hvKRagxib0/WET0Uuw
 v8rOT
X-Gm-Gg: AY/fxX7s7kjfbtKxadmQCSTLKAl6ck3k8OuZstBYAceikTmaiuN1aRdI9SDmyp72Uqb
 4EPm+jGjmBqFYyx0YjKiOMHJj0T1CWkt1QQdi3PJJi/a4tspSKA84ppxPHdlvKHhoUw3GomvpTM
 jACbDjQ3stKj88qpl7vUSqY4uKxPf6Qb8y92Zt/TlLtmL0tXw/1ZaTVH9CfIDQFXxs9LARikGCJ
 ukHXr4L/KPhaMnPX94r1ldGQo/PGLHMlKqHepCZgRleBjBcFLk0rgOnR99giTzzQuOpirXUMmEr
 LlDYVGVxi33pKfsg0CG6aa6Q7i6+ITDBM6qMVcrrll19TzR3mzpuWlnUAHfQ7AjTzY8EY+ITkmX
 ujFJrWYuhOHS2VjGA1Tb0HIy98atGKVOh3JY5X7zvF2zM0Kf8bFmnJH/2bSQ55v9k2qnPZxdWq1
 P15hx+cLDncVEdA+Q=
X-Google-Smtp-Source: AGHT+IFKBgwJTEJ3iwBtGK7Fb7UZbh4PwkpG6DfYZPCkq/yhN1ytfbfPxplCVcnnfl9fuYwcE7L+kA==
X-Received: by 2002:a05:7022:150b:b0:11a:23fb:16e2 with SMTP id
 a92af1059eb24-11f34bde2e9mr14045006c88.9.1766006464838; 
 Wed, 17 Dec 2025 13:21:04 -0800 (PST)
Received: from gromero0.. ([191.8.216.160]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12061ef3383sm1852476c88.0.2025.12.17.13.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 13:21:04 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 4/6] system/physmem: Rename cpu_address_space_init
Date: Wed, 17 Dec 2025 18:20:16 -0300
Message-Id: <20251217212018.93320-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217212018.93320-1-gustavo.romero@linaro.org>
References: <20251217212018.93320-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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

Rename cpu_address_space_init to cpu_address_space_add in preparation
for the forthcoming addition of a new cpu_address_space_init.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 include/exec/cpu-common.h          |  6 +++---
 stubs/cpu-destroy-address-spaces.c |  2 +-
 system/cpus.c                      |  2 +-
 system/physmem.c                   |  4 ++--
 target/arm/cpu.c                   | 16 ++++++++--------
 target/arm/cpu.h                   |  2 +-
 target/i386/kvm/kvm-cpu.c          |  2 +-
 target/i386/kvm/kvm.c              |  4 ++--
 target/i386/tcg/system/tcg-cpu.c   |  4 ++--
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e0be4ee2b8..126f645354 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -102,7 +102,7 @@ size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
 
 /**
- * cpu_address_space_init:
+ * cpu_address_space_add:
  * @cpu: CPU to add this address space to
  * @asidx: integer index of this address space
  * @prefix: prefix to be used as name of address space
@@ -120,8 +120,8 @@ size_t qemu_ram_pagesize_largest(void);
  *
  * Note that with KVM only one address space is supported.
  */
-void cpu_address_space_init(CPUState *cpu, int asidx,
-                            const char *prefix, MemoryRegion *mr);
+void cpu_address_space_add(CPUState *cpu, int asidx,
+                           const char *prefix, MemoryRegion *mr);
 /**
  * cpu_destroy_address_spaces:
  * @cpu: CPU for which address spaces need to be destroyed
diff --git a/stubs/cpu-destroy-address-spaces.c b/stubs/cpu-destroy-address-spaces.c
index dc6813f5bd..a86e8d4db1 100644
--- a/stubs/cpu-destroy-address-spaces.c
+++ b/stubs/cpu-destroy-address-spaces.c
@@ -5,7 +5,7 @@
 
 /*
  * user-mode CPUs never create address spaces with
- * cpu_address_space_init(), so the cleanup function doesn't
+ * cpu_address_space_add(), so the cleanup function doesn't
  * need to do anything. We need this stub because cpu-common.c
  * is built-once so it can't #ifndef CONFIG_USER around the
  * call; the real function is in physmem.c which is system-only.
diff --git a/system/cpus.c b/system/cpus.c
index ef2d2f241f..fa9deafa29 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -719,7 +719,7 @@ void qemu_init_vcpu(CPUState *cpu)
          * give it the default one.
          */
         cpu->num_ases = 1;
-        cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
+        cpu_address_space_add(cpu, 0, "cpu-memory", cpu->memory);
     }
 
     /* accelerators all implement the AccelOpsClass */
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..4a0c1b74f1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -775,8 +775,8 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 
 #endif /* CONFIG_TCG */
 
-void cpu_address_space_init(CPUState *cpu, int asidx,
-                            const char *prefix, MemoryRegion *mr)
+void cpu_address_space_add(CPUState *cpu, int asidx,
+                           const char *prefix, MemoryRegion *mr)
 {
     CPUAddressSpace *newas;
     AddressSpace *as = g_new0(AddressSpace, 1);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1640b20b4d..1902c510f9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1681,7 +1681,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          *
          * Catch all the cases which might cause us to create more than one
          * address space for the CPU (otherwise we will assert() later in
-         * cpu_address_space_init()).
+         * cpu_address_space_add()).
          */
         if (arm_feature(env, ARM_FEATURE_M)) {
             error_setg(errp,
@@ -2158,22 +2158,22 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cs->num_ases = 1 + has_secure;
     }
 
-    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
+    cpu_address_space_add(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 
     if (has_secure) {
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
-        cpu_address_space_init(cs, ARMASIdx_S, "cpu-secure-memory",
-                               cpu->secure_memory);
+        cpu_address_space_add(cs, ARMASIdx_S, "cpu-secure-memory",
+                              cpu->secure_memory);
     }
 
     if (cpu->tag_memory != NULL) {
-        cpu_address_space_init(cs, ARMASIdx_TagNS, "cpu-tag-memory",
-                               cpu->tag_memory);
+        cpu_address_space_add(cs, ARMASIdx_TagNS, "cpu-tag-memory",
+                              cpu->tag_memory);
         if (has_secure) {
-            cpu_address_space_init(cs, ARMASIdx_TagS, "cpu-tag-memory",
-                                   cpu->secure_tag_memory);
+            cpu_address_space_add(cs, ARMASIdx_TagS, "cpu-tag-memory",
+                                  cpu->secure_tag_memory);
         }
     }
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 00f5af0fcd..f68552945e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2330,7 +2330,7 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 
 #define TYPE_ARM_HOST_CPU "host-" TYPE_ARM_CPU
 
-/* Indexes used when registering address spaces with cpu_address_space_init */
+/* Indexes used when registering address spaces with cpu_address_space_add */
 typedef enum ARMASIdx {
     ARMASIdx_NS = 0,
     ARMASIdx_S = 1,
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c25b55839..a6d94d0620 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -99,7 +99,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * initialized at register_smram_listener() after machine init done.
      */
     cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
-    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
+    cpu_address_space_add(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
 
     return true;
 }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c7981138..dcc7e5eeae 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2744,14 +2744,14 @@ static void register_smram_listener(Notifier *n, void *unused)
                                  &smram_address_space, X86ASIdx_SMM, "kvm-smram");
 
     CPU_FOREACH(cpu) {
-        cpu_address_space_init(cpu, X86ASIdx_SMM, "cpu-smm", &smram_as_root);
+        cpu_address_space_add(cpu, X86ASIdx_SMM, "cpu-smm", &smram_as_root);
     }
 }
 
 /* It should only be called in cpu's hotplug callback */
 void kvm_smm_cpu_address_space_init(X86CPU *cpu)
 {
-    cpu_address_space_init(CPU(cpu), X86ASIdx_SMM, "cpu-smm", &smram_as_root);
+    cpu_address_space_add(CPU(cpu), X86ASIdx_SMM, "cpu-smm", &smram_as_root);
 }
 
 static void *kvm_msr_energy_thread(void *data)
diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
index 7255862c24..231a4bdf55 100644
--- a/target/i386/tcg/system/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -74,8 +74,8 @@ bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     memory_region_set_enabled(cpu->cpu_as_mem, true);
 
     cs->num_ases = 2;
-    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
-    cpu_address_space_init(cs, X86ASIdx_SMM, "cpu-smm", cpu->cpu_as_root);
+    cpu_address_space_add(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
+    cpu_address_space_add(cs, X86ASIdx_SMM, "cpu-smm", cpu->cpu_as_root);
 
     /* ... SMRAM with higher priority, linked from /machine/smram.  */
     cpu->machine_done.notify = tcg_cpu_machine_done;
-- 
2.34.1


