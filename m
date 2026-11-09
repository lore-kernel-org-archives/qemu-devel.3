Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B29606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wXT/BurU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXuD-0005T5-Ss; Mon, 09 Nov 2026 17:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtr-0005EO-8e
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:41 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXto-0003uZ-Bf
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:38 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8a052aff9e9so1055592b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263495; x=1794868295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CyA3SEtVAYsvKr4mkOVI+9l6CkCv7zCE6lbG/JjjfMo=;
 b=wXT/BurU+AICvMGdoNZSiLyLuQOdPVns3xIfiWKUSVCXlvSxk4Q2cDfv+Gu9f4vOQP
 gKf+crwrV1FpGKZMwbZK7BL6PCKT3cekAPrMFS7Di+QUYmJ66bolzxKeXOax2ZJ+0VJI
 y0aw3AmQol1dk+Dt1E4wbpN+Kp6vZUevGULxCa0CdTNroEzTKA/XeO55emTqqwMmMulh
 AcaWvQbFbVjhaaljHlp75iC4/F0Vt67lco6n41ImqR7GUoAa0NNMh5azSXbiYcyObzb6
 LVLLbUucfnQxgnCj9kkT6qblruZi/Uld7GqVXB0o0W3V7F8qZJ5abMcoUCXHoOhpsLnx
 voSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263495; x=1794868295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CyA3SEtVAYsvKr4mkOVI+9l6CkCv7zCE6lbG/JjjfMo=;
 b=Mx48SRzzOvnVpWRXIW292HyIFYg+EiLXZ1/FNnOM3bVj3OaQZE+NaORCH8kbSzmieE
 1+5uBL2OVKy+kmeCNdKOKP5JcNydUygqEEZWpijZ/TYBN4I/uJNgU1+txYUwps8wu6B2
 oYZBwQF0JBryLYS3P44or+/tR19HGvNEOZWZX1+PevkhUq//3QozRPPdP84ZhXo47q4v
 nG6LaipSxi1ualUJ9mmV2xXY3zI0TPf41okC8hGTauRp4ITtGAMtQBbzWY+pR5RuN+1J
 itLR4Vw8b8KwQOATQAaYAvJbY1GuWRBaL5iBtxb6QT0kB28MaGlp3JIWJIFQdeAWBE9R
 KjmA==
X-Gm-Message-State: APuU4Z8Df68KItxh6139PzlZpZ8WjiwKh0Qfq/PIE5QMa7bXWRsL40NO
 lm2zi4hTg/wr2ckGIaGg1PcvoSgArD4Tk0+P6g+ivkTWHhLW+XG9ZrskRFuctvQYVwthHbGA0YE
 vr7XI
X-Gm-Gg: AYBFou1S3Wdna1VHatr2ax7ORm6xwgJ0eiiydYju6dE3bdRZ20kinQ5AUZOsXjGgO5Q
 w0WbgeiwjghnC6yhizWAYNvTFw2kAC8EfP8UlDPyD06DmLX1Pjgn96ZcPkNjbjrOsSTRuYtpCyg
 5JtYtDjiLmson0EK6uvATIv97T7gwyHUUQO7lQl+YjIrsXGaSgJP+c369aIu0Z9dxZX7J2+gV9H
 KGgaToTJsMP199ETIeGqYhQ2ijSqysEZF3diDWxgV2uqqk2zTyAhhCvOv9TF0vgFONf4gBzA8nh
 2mvkms4syKSZlQJCHvUAzlMVe84jm3NPpkmHrBaQDNNMJblZdU8HB2G2cTNQEYpgx8LFTLygdFi
 z4rsDPYMNbVMtxtvMhtsSO0sHgd1qFV+Par+8uLjQaFyWf8xbdQALfFOaEh2R3islm0SHyRNsUk
 XFG/GGYtuHvicqMAPBpGWVOg2zO3ie3BB7XuO8ntR7k/S7sKs93KzvPwXgcRlxfUupnsCv5PEkw
 569Xb1Hlwx0pAsXG10ZXgfpaQ9Z9Rd1CpwZeMORlQS2uZ6/EBgEU60KaAo0MTMvGbmXD5jItZIB
 EznNU6k0fjI+7mOZX29s2WrVcJLtlFQkIL8+h+4Mku7WmM7Jixoq1LE7udlTQVECvf82tD2xqL4
 =
X-Received: by 2002:aa7:9315:0:b0:8b5:9654:d331 with SMTP id
 d2e1a72fcca58-8ba7fab49a4mr1110386b3a.0.1794263494909; 
 Mon, 09 Nov 2026 14:31:34 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:34 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 11/23] target/arm/cpu: Set number of breakpoints and
 watchpoints in KVM
Date: Mon,  9 Nov 2026 16:30:58 -0600
Message-ID: <20261109223110.1619504-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x431.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add "num-breakpoints" and "num-watchpoints" CPU parameters to configure
the debug features that KVM presents to the guest. The KVM vCPU
configuration is modified by calling SET_ONE_REG on the ID register.

This is needed for Realm VMs, whose parameters include breakpoints and
watchpoints, and influence the Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/arm-qmp-cmds.c |  1 +
 target/arm/cpu.h          |  4 ++
 target/arm/cpu64.c        | 94 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 49 ++++++++++++++++++++
 4 files changed, 148 insertions(+)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 9d3a3d9aa472..1c2f31db0d30 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -77,6 +77,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
+    "num-breakpoints", "num-watchpoints",
     NULL
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b2f393f50184..dfabcfc5eda1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1203,6 +1203,10 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Override the default configuration, only for RME vCPUs */
+    uint8_t num_bps;
+    uint8_t num_wps;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0e5956e5fe6b..a34de3d2947c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -33,6 +33,7 @@
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
+#include "hw/core/boards.h"
 #include "whpx_arm.h"
 #include "qapi/visitor.h"
 #include "hw/core/qdev-properties.h"
@@ -680,6 +681,98 @@ void aarch64_add_pauth_properties(Object *obj)
     }
 }
 
+#if defined(CONFIG_KVM)
+static void arm_cpu_get_num_wps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    val = cpu->num_wps;
+    if (val == 0) {
+        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
+                         ID_AA64DFR0, WRPS) + 1;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_wps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_wps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
+                                 ID_AA64DFR0, WRPS) + 1;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (!MACHINE(qdev_get_machine())->cgs) {
+        error_setg(errp, "num-watchpoints option is only valid with "
+                   "condifential-guest-support");
+        return;
+    }
+
+    if (val < 2 || val > max_wps) {
+        error_setg(errp, "invalid number of watchpoints");
+        return;
+   }
+
+   cpu->num_wps = val;
+}
+
+static void arm_cpu_get_num_bps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    val = cpu->num_bps;
+    if (val == 0) {
+        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
+                         ID_AA64DFR0, BRPS) + 1;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_bps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
+                                 ID_AA64DFR0, BRPS) + 1;
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (!MACHINE(qdev_get_machine())->cgs) {
+        error_setg(errp, "num-breakpoints option is only valid with "
+                   "condifential-guest-support");
+        return;
+    }
+
+    if (val < 2 || val > max_bps) {
+        error_setg(errp, "invalid number of breakpoints");
+        return;
+    }
+
+    cpu->num_bps = val;
+}
+
+static void aarch64_add_kvm_writable_properties(Object *obj)
+{
+    object_property_add(obj, "num-breakpoints", "uint8", &uint8_type_info,
+                        arm_cpu_get_num_bps, arm_cpu_set_num_bps, NULL, NULL);
+    object_property_add(obj, "num-watchpoints", "uint8", &uint8_type_info,
+                        arm_cpu_get_num_wps, arm_cpu_set_num_wps, NULL, NULL);
+}
+#endif /* CONFIG_KVM */
+
 void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     uint64_t t;
@@ -829,6 +922,7 @@ void aarch64_host_initfn(Object *obj)
     kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+    aarch64_add_kvm_writable_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 80296e0a867c..c8a821d7fab6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -985,6 +985,51 @@ out:
     return ret;
 }
 
+#define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
+
+static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (!cpu->num_bps && !cpu->num_wps) {
+        return;
+    }
+
+    newval = cpu->isar.idregs[ID_AA64DFR0_EL1_IDX];
+    if (cpu->num_bps) {
+        uint64_t ctx_cmps = FIELD_EX64(newval, ID_AA64DFR0, CTX_CMPS);
+
+        /* CTX_CMPs is never greater than BRPs */
+        ctx_cmps = MIN(ctx_cmps, cpu->num_bps - 1);
+        newval = FIELD_DP64(newval, ID_AA64DFR0, BRPS, cpu->num_bps - 1);
+        newval = FIELD_DP64(newval, ID_AA64DFR0, CTX_CMPS, ctx_cmps);
+    }
+    if (cpu->num_wps) {
+        newval = FIELD_DP64(newval, ID_AA64DFR0, WRPS, cpu->num_wps - 1);
+    }
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_ID_AA64DFR0_EL1");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded. KVM does offer the writable mask for this
+     * register, but this way we also check if the value we wrote was sane.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &val);
+    if (ret || val != newval) {
+        error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
+    }
+}
+
+static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
+{
+    kvm_arm_configure_aa64dfr0(cpu);
+}
+
 /**
  * kvm_arm_cpreg_level:
  * @regidx: KVM register index
@@ -1201,6 +1246,10 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
         fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
         abort();
     }
+
+    /* Update KVM state before it's loaded to CPUState */
+    kvm_arm_configure_vcpu_regs(cpu);
+
     if (!write_kvmstate_to_list(cpu)) {
         fprintf(stderr, "write_kvmstate_to_list failed\n");
         abort();
-- 
2.53.0


