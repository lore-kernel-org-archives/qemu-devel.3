Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA0DCD11DB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMd-0004bm-LU; Mon, 25 Mar 2024 06:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wk4BZggKCpsNHJNO5A5BJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--smostafa.bounces.google.com>)
 id 1rohMc-0004ZO-9j
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:34 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wk4BZggKCpsNHJNO5A5BJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--smostafa.bounces.google.com>)
 id 1rohMa-0004m8-CY
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:34 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-3419f517aceso2042393f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361730; x=1711966530; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=fE8ZJCzy4GplxPwcR6hJO6pmto5bdl5CvCNCWCk7f9Y=;
 b=1LcEKQi/A64l1vtUEwICqSDYSYqUVP5AI3G4gPjdY7LI3w+mQJ77XjyR+2AdPDXC1O
 ZNPB/IeLKUuPAjcaEnmKHLaHkvXlcC96u6dgPQ8CwRZRjX8km+HizRpOFfZl2FtI7nTF
 N1EtpZfIIqsENkS66fNKtcodKiNNjz67bLDcGAf3gzJ6DCYtHJ7aLEdn1ZyJw7916K6l
 Swrb+isxrluvaTtTCzN8ACDbNanyDKH6x3PJTKGhrUwykd87NXe9/YO5d9WPEDAHsvXH
 Z5GNooTPB1AwdHOqnxR8jNQ7bWdnqMPp3lJiCasAJXoBK4L3NgGg9gSthuYTvwXkiceM
 t/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361730; x=1711966530;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fE8ZJCzy4GplxPwcR6hJO6pmto5bdl5CvCNCWCk7f9Y=;
 b=d73weB4xVO9OVzLUjtxac3OWpyOulWwgsSJPkwWy9oxcPRhmi2R+Kk8RRUlQ4CqY58
 lw7tlxRIxk9tFKJ3Jnj1u3EGYTPOBBQX4Ep+LmgpJbIWr27xotuuvKAPwbDRKmwFdOdi
 OqbpqOZBSjwSzXOtryw9GN3ijiE+TKYqJFwh3inAY/ZJTf7ldRMYUj0tWCsrcl7Lb+3R
 PePQIZF3t+tMZr7NHrtBZdyCpDGgXF72RxwwzXwlFMwcTf8jRBBdWVJEC+1ReT4am2/v
 XRzOdp8IEiqZXV7aWXll9FKC5KJqARFhMG+yW+voZrV2VM4BUgqjzlZRHEOq7zaHVoxs
 ronA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCTqvnuYVEjRzFOP3LBqZ8cq7Pc5JxdYC3LALpYrxO1SaEqXM7ZH8wZlXRdMLZSqVgdKbTZ680UZAb0wc/w5AEZrxXx7s=
X-Gm-Message-State: AOJu0Yxwl7xPnOF9Ai2wEQO9JwhoQS5sIunLofP4R2OSKJ4iRENhAnyF
 NsiAjh2R7BHTKpzwIwi5dGn1oKM7JBxZGywo69yLPpty3ww7lWYUZHylmrYl2L7Dx1u+NOyCZba
 dX628XFQmRw==
X-Google-Smtp-Source: AGHT+IFWK4VglR7yHn2s4Kh3H2ibwXZ5T+0ZQGFNsc+JQtSH3/q0iIZzDQFsGYmyPYdzaxETkEIAV/Z6AL1kTA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6000:cf:b0:33e:c2c5:6d78 with SMTP id
 q15-20020a05600000cf00b0033ec2c56d78mr15791wrx.5.1711361730758; Mon, 25 Mar
 2024 03:15:30 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:14:08 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-13-smostafa@google.com>
Subject: [RFC PATCH 12/12] hw/arm/virt: Set SMMU OAS based on CPU PARANGE
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3wk4BZggKCpsNHJNO5A5BJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x44a.google.com
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
index 0af1943697..599c0f752b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -235,6 +235,13 @@ static bool ns_el2_virt_timer_present(void)
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
@@ -1340,7 +1347,7 @@ static void create_pcie_irq_map(const MachineState *ms,
 }
 
 static void create_smmu(const VirtMachineState *vms,
-                        PCIBus *bus)
+                        PCIBus *bus, int32_t oas)
 {
     char *node;
     const char compat[] = "arm,smmu-v3";
@@ -1360,6 +1367,9 @@ static void create_smmu(const VirtMachineState *vms,
 
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
+
+    qdev_prop_set_uint64(dev, "oas", oas);
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
@@ -1534,7 +1544,7 @@ static void create_pcie(VirtMachineState *vms)
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
-            create_smmu(vms, vms->bus);
+            create_smmu(vms, vms->bus, get_system_oas());
             qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                    0x0, vms->iommu_phandle, 0x0, 0x10000);
             break;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a5b3d8f7da..14ef1a9d37 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3408,4 +3408,6 @@ static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
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
2.44.0.396.g6e790dbe36-goog


