Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2710C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wX-0006nX-Of; Thu, 23 May 2024 11:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wO-0006UV-FM
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wK-0004r1-E7
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LmBfNyyXoE9mPmJvBFS5RdjaGUbXqRaJo1Z4d57ylYE=;
 b=CFZrqoxMbWXb4BAquYxbEXiig52KrhWu+ZkbzP0an1tDtxnHEFBcmpvN/YbI9QFn43TFpK
 HVqc5D0NrRk6PkU6fhxz31SG4DyvVhtdr7XKT7Ls2lfOdBrptG/qVR4vFKH+AFnz5P83bX
 2UIlY5/nkXVEPiZNZxuY9hBEsqhHAr8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-CZEAV-9MO8qsb031_kKxpg-1; Thu, 23 May 2024 11:01:04 -0400
X-MC-Unique: CZEAV-9MO8qsb031_kKxpg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59cbb6f266so145771466b.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476462; x=1717081262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LmBfNyyXoE9mPmJvBFS5RdjaGUbXqRaJo1Z4d57ylYE=;
 b=uzgwblDJUszhD61+Kt/xitmWo0R/LWwvTiIGje1lj8+VLfgtB8AQVUNvKYTv0CsKcI
 CzZC8kWvLDv+Xc5EiyfoSeRX/ZWe90KUyaN63PLb0wg5J5kJoHD480mMlPuA4cAscl9w
 2KCrncR5/7VMYbVMewsP/zhDZipNv2BluOA/fWs/C+QAvV2Ax3d864tNjKeo2n1/5/GQ
 WV3pajyN3TrOraeiSpUEg1nQl8648ek8KcmcHmDJ2udeH5v1iiKb7v7ov+m9eIHdqbbc
 yajoDvWtCgbgNDJ5raUOC7AFvxAPQAVHZvsRDIHhnUZZyRWgserPIZz2v+UE4L3zjdMQ
 QwVg==
X-Gm-Message-State: AOJu0Yw1RtUjBKAovPN3tFZozAAyurhXC+DTFv/rTfH07Qkvl0SkrAuV
 sOQ5bBjRtPg1Xd6JCfhnt/cYp1BBvQjGfscMkgU5jaAUponiCndOWfFLB0d5+IOHkC0PQQF4G/B
 KO1zjwGgMtG8xRH4PfMvyuXn96k7XtbovyomYtKigxddxN79Pc48Sl2WaDj/6jXDgpF+S9l/gPC
 oxDXPBso6OdNiTvEg2jDBRtOd6FGxqDeZ9wavp
X-Received: by 2002:a17:906:a1d4:b0:a59:a033:3e2 with SMTP id
 a640c23a62f3a-a622820b853mr492905866b.74.1716476462625; 
 Thu, 23 May 2024 08:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3yK90brmvquuNyKtI4pE51gWv7k6JKRubOEDQzN2Ma4zAumw8u1yib6lH4YBnDleNSyEwmw==
X-Received: by 2002:a17:906:a1d4:b0:a59:a033:3e2 with SMTP id
 a640c23a62f3a-a622820b853mr492903166b.74.1716476462152; 
 Thu, 23 May 2024 08:01:02 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5cedda22acsm1019491466b.137.2024.05.23.08.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 10/23] i386/cpu: Introduce bitmap to cache available CPU
 topology levels
Date: Thu, 23 May 2024 17:00:23 +0200
Message-ID: <20240523150036.1050011-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, QEMU checks the specify number of topology domains to detect
if there's extended topology levels (e.g., checking nr_dies).

With this bitmap, the extended CPU topology (the levels other than SMT,
core and package) could be easier to detect without touching the
topology details.

This is also in preparation for the follow-up to decouple CPUID[0x1F]
subleaf with specific topology level.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240424154929.1487382-10-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/topology.h | 23 +++++++++++++++++++++++
 target/i386/cpu.h          |  4 ++++
 hw/i386/x86-common.c       |  5 ++++-
 target/i386/cpu.c          | 18 +++++++++++++++---
 target/i386/kvm/kvm.c      |  3 ++-
 5 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index d4eeb7ab829..befeb92b0b1 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -60,6 +60,21 @@ typedef struct X86CPUTopoInfo {
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
+/*
+ * CPUTopoLevel is the general i386 topology hierarchical representation,
+ * ordered by increasing hierarchical relationship.
+ * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
+ * or AMD (CPUID[0x80000026]).
+ */
+enum CPUTopoLevel {
+    CPU_TOPO_LEVEL_INVALID,
+    CPU_TOPO_LEVEL_SMT,
+    CPU_TOPO_LEVEL_CORE,
+    CPU_TOPO_LEVEL_DIE,
+    CPU_TOPO_LEVEL_PACKAGE,
+    CPU_TOPO_LEVEL_MAX,
+};
+
 /* Return the bit width needed for 'count' IDs */
 static unsigned apicid_bitwidth_for_count(unsigned count)
 {
@@ -168,4 +183,12 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
     return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
+/*
+ * Check whether there's extended topology level (die)?
+ */
+static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
+{
+    return test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
+}
+
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ccf6811794e..9e7b9e918e9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
 #include "exec/cpu-defs.h"
+#include "hw/i386/topology.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/cpu-float.h"
 #include "qemu/timer.h"
@@ -1891,6 +1892,9 @@ typedef struct CPUArchState {
 
     /* Number of dies within this CPU package. */
     unsigned nr_dies;
+
+    /* Bitmap of available CPU topology levels for this CPU. */
+    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPO_LEVEL_MAX);
 } CPUX86State;
 
 struct kvm_msrs;
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 67b03c913a5..7d4f9b20f23 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -271,7 +271,10 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     init_topo_info(&topo_info, x86ms);
 
-    env->nr_dies = ms->smp.dies;
+    if (ms->smp.dies > 1) {
+        env->nr_dies = ms->smp.dies;
+        set_bit(CPU_TOPO_LEVEL_DIE, env->avail_cpu_topo);
+    }
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 363f5ee4bec..8419055006c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6442,7 +6442,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (topo_info.dies_per_pkg < 2) {
+        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -7275,7 +7275,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if ((env->nr_dies > 1) &&
+        if (x86_has_extended_topo(env->avail_cpu_topo) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
@@ -7798,13 +7798,25 @@ static void x86_cpu_post_initfn(Object *obj)
     accel_cpu_instance_init(CPU(obj));
 }
 
+static void x86_cpu_init_default_topo(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    env->nr_dies = 1;
+
+    /* SMT, core and package levels are set by default. */
+    set_bit(CPU_TOPO_LEVEL_SMT, env->avail_cpu_topo);
+    set_bit(CPU_TOPO_LEVEL_CORE, env->avail_cpu_topo);
+    set_bit(CPU_TOPO_LEVEL_PACKAGE, env->avail_cpu_topo);
+}
+
 static void x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu = X86_CPU(obj);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
     CPUX86State *env = &cpu->env;
 
-    env->nr_dies = 1;
+    x86_cpu_init_default_topo(cpu);
 
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index c5943605ee3..6c864e4611f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -51,6 +51,7 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/i386/topology.h"
 #include "hw/i386/x86-iommu.h"
 #include "hw/i386/e820_memory_layout.h"
 
@@ -1791,7 +1792,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
             break;
         }
         case 0x1f:
-            if (env->nr_dies < 2) {
+            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
                 cpuid_i--;
                 break;
             }
-- 
2.45.1


