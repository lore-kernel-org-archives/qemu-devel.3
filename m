Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2723EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hdw-00011H-5d; Sun, 28 Apr 2024 23:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GhMvZggKCjUjdfjkRWRXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--smostafa.bounces.google.com>)
 id 1s1Hdt-0000tN-4p
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:25 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GhMvZggKCjUjdfjkRWRXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--smostafa.bounces.google.com>)
 id 1s1Hdp-0004Fd-8x
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:23 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-3455cbdea2cso2056557f8f.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361115; x=1714965915; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mSI5Y10hDHs+a73zrNudbgCqM/hO+BV89BxjmLOp0r4=;
 b=wjNFlQ0XJnjjwkEhFmkNQgOYQ+mg1o/wLEK81kXaycD/eerG1CO7TLlW798GGGdHzC
 bmAo6bB5g0wPcdvlya08IesdtAYkdvVqyfqb5mvpukhnt5vCC3ZBPlj193AYFbIen5pS
 fof5oaZj8Ek+Wsn7MDEigBqGGjF1op4o+Sj0OTQXW93bNu0//UiN8Pazx3aNSG9Kv9DV
 54gcVosEZW5+nyFhSdzImWEMH6JVjJwEN5lkpUqD+TJ7a3sBWgLglTuRsyMPnBIm9N3w
 7b2RwKGvxoOHEAZFWV5FX92qbu6B2QDaqm6jpnLwNPZVKGoeNepv/U5aO1S2NauQ4mGY
 tfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361115; x=1714965915;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mSI5Y10hDHs+a73zrNudbgCqM/hO+BV89BxjmLOp0r4=;
 b=wlvDw4ff8K/Pq6GhI+kwdp26htkpCm91mgSYnoV5WsR8645OhrqL97ajojAzcg33AF
 7xzv9Iobr5KPnwL61xpAyjbIStO/Ueo3OerzTBhpji684tllWU6y9VvEop4OqFzkQ/Tz
 v+1BC6aJvtsTaR0UM3mOy6wYwWdGKdTNi4H07pRGzbaiqmlmXtx1s3GO9ijCgCeQYGGX
 FBSYxr8cignlFDVyo1wBlfVhTv9eltysHrgCjKvICM7NNGnFa7OEU8w3pjRD2c0ZRhIP
 NDJ8JJT3l79X99hbY7yEWwPiRUh1UrSndn770R94gPt+QFXy1N+6C5oBRP3+ANhniYe4
 5HVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyCH9j0Bd798VtOSdx+4jKFXV5MoekTHxFaDhAa0tvZXy3F+xSx8jMcu/89ksf6AL7GWEhkKKXEh56UmmRL0jBjvjM0LU=
X-Gm-Message-State: AOJu0Yyxl4eSFeu03DOIfmDD4rkSt7O5F7+F9IclFFsMMOb+I/1H3dTV
 Ya8J4TF97Ya1M/0d1M7o1rVVts5bh24dndMarKfMAiMkOXeb/ZnYuVs1WMBMGgnQtzTgeiVlF0s
 +5LL5kN9bDA==
X-Google-Smtp-Source: AGHT+IExBhRwz10DGXfUQGJFfnfxKNB9h91NRBBof8jWz4h5F6LHkq8/pmh/Hlht3yc3mRETmvyDUPo7tbxz9Q==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:adf:f64f:0:b0:34b:c3e:5e03 with SMTP id
 x15-20020adff64f000000b0034b0c3e5e03mr16372wrp.0.1714361114848; Sun, 28 Apr
 2024 20:25:14 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:24:02 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-19-smostafa@google.com>
Subject: [RFC PATCH v3 18/18] hw/arm/virt: Set SMMU OAS based on CPU PARANGE
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3GhMvZggKCjUjdfjkRWRXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x449.google.com
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

Use the new SMMU property to make the SMMU OAS match the CPU PARANGE.
That's according to SMMU manual ARM IHI 0070F.b:
    6.3.6 SMMU_IDR5, OAS must match the system physical address size.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/virt.c      | 14 ++++++++++++--
 target/arm/cpu.h   |  2 ++
 target/arm/cpu64.c |  5 +++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..f203b1f8e1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -252,6 +252,13 @@ static bool ns_el2_virt_timer_present(void)
         arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
 }
 
+/* We rely on CPU to define system OAS. */
+static int32_t get_system_oas(void)
+{
+    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
+    return cpu_arm_get_oas(cpu);
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -1384,7 +1391,7 @@ static void create_pcie_irq_map(const MachineState *ms,
 }
 
 static void create_smmu(const VirtMachineState *vms,
-                        PCIBus *bus)
+                        PCIBus *bus, int32_t oas)
 {
     char *node;
     const char compat[] = "arm,smmu-v3";
@@ -1404,6 +1411,9 @@ static void create_smmu(const VirtMachineState *vms,
 
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+
+    qdev_prop_set_uint64(dev, "oas", oas);
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -1578,7 +1588,7 @@ static void create_pcie(VirtMachineState *vms)
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
-            create_smmu(vms, vms->bus);
+            create_smmu(vms, vms->bus, get_system_oas());
             qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                    0x0, vms->iommu_phandle, 0x0, 0x10000);
             break;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 17efc5d565..68261ffbf9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3287,4 +3287,6 @@ static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
 }
 #endif
 
+int32_t cpu_arm_get_oas(ARMCPU *cpu);
+
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 985b1efe16..08da83c082 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -787,6 +787,11 @@ static const gchar *aarch64_gdb_arch_name(CPUState *cs)
     return "aarch64";
 }
 
+int32_t cpu_arm_get_oas(ARMCPU *cpu)
+{
+    return FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE);
+}
+
 static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
-- 
2.44.0.769.g3c40516874-goog


