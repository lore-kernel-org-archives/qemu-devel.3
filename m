Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF847606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AxBjbg6y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXu8-0005NK-AG; Mon, 09 Nov 2026 17:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtt-0005Fj-NW
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:43 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtp-0003ux-TE
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:41 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8a058315c79so696132b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263496; x=1794868296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qffBcw2XnFNxd/1mYXvqBIjMdDc+fw6jbgfRGioxHxs=;
 b=AxBjbg6yXw+Eqcm0eljY5Icz8dSlTyw6Ef0yBNGEENcK/BuyTDD48gXYS6KNbgschR
 oJmbx44i3vWKe8MH0DGwK88Z/2yRYyPtTcGgmMEgMTiquHiyqXJkSrFXJNpiszgkukr1
 dUVaLieIKPpbUWylm5Sx/cnj0T+qy6xQtc54C7gZ0WHovMQ2yQW0+0bZXooERGWyJ6U1
 ZtOHvz8NDR9AAyI+bhp/XKfjCo1R3qYggrV1dPwlEwpUe5zu5EniaKaw8qLwrhdfi5Xs
 cemdq3hyrlsu08B4lIes0JIXRMUqiuATI3u2nqkObMM9hrtih4mzXCL3IaIjAIoReW6P
 NPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263496; x=1794868296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qffBcw2XnFNxd/1mYXvqBIjMdDc+fw6jbgfRGioxHxs=;
 b=NsWXohtIIEgX3KOOEWYE8kskVWLBR9nfzA/+/Mt5/e8rvcvpoRo9pM/HQ/S6/z801u
 TZqEhV83MmOmdIK4dzlOGgDobbo73wPoC4YXgHixwc8rdYpi3TUDoPm1he1I86dMlqBW
 1JiDFnP8PIdZqJgdCf+4Q0OoC1JjtvkgCfBXU+EZlNWSdW3Iw4xc4LK8Alvc2A1tUKeA
 sR0PEYr9Tf9QpCmQkK8LRe1i0UP5Nz4CJZd/s8v2yyKZylxDecTuFsk9bKwDA2H7pbHg
 1jgk1+ISFgTTDzCN3M198tFtHRgwPTgMfSt3veQyGT9yVeJq+qORW+3gkpMRqzMabu/c
 isTg==
X-Gm-Message-State: APuU4Z/9G1MBaHy+hUEyOWmhkev9p2+A3bG7CEofId51gF59gqpyQ/6b
 INWl5iF0gJGTzz7dozrSAut9oyY5y0bqkoHPQQUgccHfHSfndg82rGSk8i9IB8oNAZHx2QT9K9z
 KEE0R
X-Gm-Gg: AYBFou3vsjpfLJLvyr7mHryKqMCvdIB+c/GnyVSbFP8YV2tsDU+tuRQ4cWFk86Doevs
 3N+hzPjzfOjfxyH8yVBQWDrqfzmEsSFdF9MuB+W+tkaNqKBqVC/UwtfLPa2OCy4cKIgpvKRcH4e
 ftww8GP+QzBwseO62ykytjtuIzr0BnRddQ2KiTJZCyQsVS/QxLyfsm4DmG15Fp0notkGA8JSUyl
 kIQRUrIxnJEU3z4DDB26oIYE/Rov12ShjTjNfOgG9u1aU4UlkzBTDh1thcck2+hGPQXJNKzSZpE
 5hLSM/vuIh/1zb8eGF/7WLNBwciOzmmy4M4oxHUjKB2hGoQBm76lbIBuE4OiJ/mcJjfkJgR8k5J
 fnrNmfm7iMqiPzMQdJhCbDKTZerZYkE/RSeeD7CkWKKe10ZxQZsZJVzGOZMe8nzUlb8Qd2xMvXj
 jcRCQ4hC/wyPp03G0LCW9t+0vXBiLF8spRon23+SZg098gMrkLv13I8Gskyfdp6D0YQ3fbEbF6a
 G1wufc6P1rL0vMFyu3C5m+cETNlVGCgu+rdRJu64FQLlvUqiqvuvHncuFMYjjmovuN/nKLsMmmm
 y3c94cUKHQY0AafgE8RUXwb4PwarK2S++tB1DXyfBR6zZ7rdF2uEdA==
X-Received: by 2002:a05:6a21:320b:b0:3e0:c346:734c with SMTP id
 adf61e73a8af0-3f190e9a4admr544580637.89.1794263496430; 
 Mon, 09 Nov 2026 14:31:36 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:35 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 12/23] target/arm/cpu: Set number of PMU counters in KVM
Date: Mon,  9 Nov 2026 16:30:59 -0600
Message-ID: <20261109223110.1619504-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a "num-pmu-counters" CPU parameter to configure the number of
counters that KVM presents to the guest. This is needed for Realm VMs,
whose parameters include the number of PMU counters and influence the
Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/arm-qmp-cmds.c |  2 +-
 target/arm/cpu.h          |  3 +++
 target/arm/cpu64.c        | 41 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 34 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 1c2f31db0d30..635ac2168b58 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -77,7 +77,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
-    "num-breakpoints", "num-watchpoints",
+    "num-breakpoints", "num-watchpoints", "num-pmu-counters",
     NULL
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dfabcfc5eda1..f36a9678a8cb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1207,6 +1207,7 @@ struct ArchCPU {
     /* Override the default configuration, only for RME vCPUs */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2166,6 +2167,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 /* If adding a feature bit which corresponds to a Linux ELF
  * HWCAP bit, remember to update the feature-bit-to-hwcap
  * mapping in linux-user/elfload.c:get_elf_hwcap().
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a34de3d2947c..42383cb22431 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -764,12 +764,53 @@ static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
     cpu->num_bps = val;
 }
 
+static void arm_cpu_get_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        val = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+    } else {
+        val = cpu->num_pmu_ctrs;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_ctrs = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val > max_ctrs) {
+        error_setg(errp, "invalid number of PMU counters");
+        return;
+    }
+
+    cpu->num_pmu_ctrs = val;
+}
+
 static void aarch64_add_kvm_writable_properties(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     object_property_add(obj, "num-breakpoints", "uint8", &uint8_type_info,
                         arm_cpu_get_num_bps, arm_cpu_set_num_bps, NULL, NULL);
     object_property_add(obj, "num-watchpoints", "uint8", &uint8_type_info,
                         arm_cpu_get_num_wps, arm_cpu_set_num_wps, NULL, NULL);
+
+    cpu->num_pmu_ctrs = -1;
+    object_property_add(obj, "num-pmu-counters", "uint8", &uint8_type_info,
+                        arm_cpu_get_num_pmu_ctrs, arm_cpu_set_num_pmu_ctrs,
+                        NULL, NULL);
 }
 #endif /* CONFIG_KVM */
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c8a821d7fab6..572d0e294b1c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1025,9 +1025,43 @@ static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
     }
 }
 
+#define KVM_REG_ARM_PMCR_EL0            ARM64_SYS_REG(3, 3, 9, 12, 0)
+
+static void kvm_arm_configure_pmcr(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        return;
+    }
+
+    newval = FIELD_DP64(cpu->isar.reset_pmcr_el0, PMCR, N, cpu->num_pmu_ctrs);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded, since older versions of KVM ignore it.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_PMCR_EL0");
+    }
+}
+
 static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
 {
     kvm_arm_configure_aa64dfr0(cpu);
+    kvm_arm_configure_pmcr(cpu);
 }
 
 /**
-- 
2.53.0


