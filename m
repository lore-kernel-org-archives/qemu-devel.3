Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B03C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9nHe-0000FX-PI; Thu, 24 Sep 2026 13:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3TF61agsKCjsZliqlkibtfpdlldib.Zljnbjr-absbiklkdkr.lod@flex--coltonlewis.bounces.google.com>)
 id 1x9nHd-0000FC-Ke
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 13:30:57 -0400
Received: from mail-oi1-x248.google.com ([2607:f8b0:4864:20::248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3TF61agsKCjsZliqlkibtfpdlldib.Zljnbjr-absbiklkdkr.lod@flex--coltonlewis.bounces.google.com>)
 id 1x9nHb-0003TR-5V
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 13:30:57 -0400
Received: by mail-oi1-x248.google.com with SMTP id
 5614622812f47-4c467e19391so234995b6e.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790271053; x=1790875853; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p9ajE4KB/2zz+KUwHLTVbTKktfg0s/rVmELPB+FKPIc=;
 b=edSeFvbHNvimreShQl/HP7gtAT8fPuxbHOvSFmNbzd38pQoJTl1pTRbMq9rzXS5IZt
 EAnjSzZ65MwY2VDdWaDoYSyewYltkK31qG1j1C0sBGOcejRJnLR2GhGRc8cvr3nwo5Vt
 HvrqWBMgVI9J7m6g+I7FHoR0epCFIM1aSIjKM+tujCUH8MAoBr2QftWarASF/4SWvHri
 B6MyxoVFNzKU/aT9J6O57U0TYo+IIrIPKLltsnWXNTXMPmO/+aOJ+JbO9zNnUH3LXa/F
 jJJ8/D0PrlPX10bnLgw4UqdHasc/O8vKdA0iK2gI8cKljIcIdQhaXXjSdYEIX8ZwcGjF
 wQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790271053; x=1790875853;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p9ajE4KB/2zz+KUwHLTVbTKktfg0s/rVmELPB+FKPIc=;
 b=qDgVYcPdX3aHKU1FzumsiaLloXt40jQLuKkbDfwpjmp4GKhGWVmO/5vHjv6+pydBdq
 I/emkq/cbPKiWIOB+J5a6AuJRj52l8cHe5BflL0ivnu/1XeA0AgDHW3203XZ4pN/3vsy
 6WAR0OiOFBWFoUbxdbkew37VVhwfej7iOhm5rIyZpAclVUWHpHWLGCJQNfuBSah8pxPj
 /qnTIq1+qTIv4WJuoqKlR9pl2B+GJYxsSCcYZVvHTuKYUfRpQthys4kBh/Nj8Ph3it+t
 4+n1hYrgKGNr2D9I23fgU6A8dd+nvVXyOK8VzrBWXaWMm8Qtv5PziO/TWr+PJeaUWBET
 nSMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyHdTLFHwyTeZEpNB8TwaMTRcU36nzph/Dj7L06PCqPhNjBMpZYv2VYZa8zjY1LR0x3t0gzSHrSiD9@nongnu.org
X-Gm-Message-State: AFuF++nVQ8Qown3Ay9oucfYieTx5vqlTmBMCcm4Q2sw9zPAZDxuo9VPG
 1LJQk9AahOAdmX4sbwc59Rj4D+cI7Q5tqLRS8O6lDoCGyqYlACgV/MSqJNoJVsCpdN+3o5EFV3g
 Ji/IJEy219y08MZZROBkpjMC1CQ==
X-Received: from ilbed8.prod.google.com ([2002:a05:6e02:4808:b0:50d:48ca:d970])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3c48:b0:4d6:93e2:5bc1 with SMTP id
 5614622812f47-4d72f2476f0mr2919401b6e.66.1790271052204; 
 Thu, 24 Sep 2026 10:30:52 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:30:51 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173051.2117637-1-coltonlewis@google.com>
Subject: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
From: Colton Lewis <coltonlewis@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvmarm@lists.linux.dev
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mingwei Zhang <mizhang@google.com>,
 kvm@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::248;
 envelope-from=3TF61agsKCjsZliqlkibtfpdlldib.Zljnbjr-absbiklkdkr.lod@flex--coltonlewis.bounces.google.com;
 helo=mail-oi1-x248.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add CPU properties to configure KVM ARM64 PMU counter partitioning:
- 'pmu-partition' (bool): enables KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION
- 'pmu-num-counters' (uint32): sets KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS

When 'pmu-partition=on' and 'pmu-num-counters=N' are passed via -cpu,
QEMU enables hardware PMU partitioning and reserves N general-purpose
event counters for the guest prior to calling KVM_ARM_VCPU_PMU_V3_INIT.

Note that this patch is an example to demonstrate the KVM ARM64 PMU
Partitioning uAPI [1]. That is why it aborts immediately if setting the
device attributes does not succeed.

[1] https://lore.kernel.org/kvmarm/20260924172928.2110956-1-coltonlewis@google.com/

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 target/arm/cpu.c | 20 ++++++++++++++++++++
 target/arm/cpu.h |  4 ++++
 target/arm/kvm.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f58a1db843..7538c6a24c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1359,6 +1359,20 @@ static bool arm_get_pmu(Object *obj, Error **errp)
     return cpu->has_pmu;
 }
 
+static bool arm_get_pmu_partition(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return cpu->kvm_pmu_partition;
+}
+
+static void arm_set_pmu_partition(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->kvm_pmu_partition = value;
+}
+
 static void arm_set_pmu(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1604,6 +1618,12 @@ static void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
         object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
+        object_property_add_bool(obj, "pmu-partition",
+                                 arm_get_pmu_partition,
+                                 arm_set_pmu_partition);
+        object_property_add_uint32_ptr(obj, "pmu-num-counters",
+                                       &cpu->kvm_pmu_nr_counters,
+                                       OBJ_PROP_FLAG_READWRITE);
     }
 
     /*
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba2..1320e76fd4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1004,6 +1004,10 @@ struct ArchCPU {
     bool has_el3;
     /* CPU has PMU (Performance Monitor Unit) */
     bool has_pmu;
+    /* CPU has PMU Partitioning enabled in KVM mode */
+    bool kvm_pmu_partition;
+    /* Number of PMU counters allocated to guest in KVM mode */
+    uint32_t kvm_pmu_nr_counters;
     /* CPU has VFP */
     bool has_vfp;
     /* CPU has 32 VFP registers */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd8..3aa8243278 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1846,6 +1846,10 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
     return true;
 }
 
+#ifndef KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION
+#define KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION 5
+#endif
+
 void kvm_arm_pmu_init(ARMCPU *cpu)
 {
     struct kvm_device_attr attr = {
@@ -1856,6 +1860,34 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
     if (!cpu->has_pmu) {
         return;
     }
+
+    if (cpu->kvm_pmu_partition) {
+        uint32_t partition = 1;
+        struct kvm_device_attr part_attr = {
+            .group = KVM_ARM_VCPU_PMU_V3_CTRL,
+            .attr = KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION,
+            .addr = (intptr_t)&partition,
+        };
+
+        if (!kvm_arm_set_device_attr(cpu, &part_attr, "PMU partition")) {
+            error_report("failed to enable KVM PMU partition");
+            abort();
+        }
+    }
+
+    if (cpu->kvm_pmu_nr_counters > 0) {
+        struct kvm_device_attr cnt_attr = {
+            .group = KVM_ARM_VCPU_PMU_V3_CTRL,
+            .attr = KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS,
+            .addr = (intptr_t)&cpu->kvm_pmu_nr_counters,
+        };
+
+        if (!kvm_arm_set_device_attr(cpu, &cnt_attr, "PMU nr_counters")) {
+            error_report("failed to set KVM PMU nr_counters");
+            abort();
+        }
+    }
+
     if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();

base-commit: 014b1f730c0faa08067f8e9b5829e62ea3d4b177
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


