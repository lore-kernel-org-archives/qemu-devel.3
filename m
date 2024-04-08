Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A92CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtphW-00085H-HQ; Mon, 08 Apr 2024 10:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mfoTZggKChYE8AEFw1w2AA270.yA8C08G-z0H079A929G.AD2@flex--smostafa.bounces.google.com>)
 id 1rtpgy-0007GF-2N
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:54 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mfoTZggKChYE8AEFw1w2AA270.yA8C08G-z0H079A929G.AD2@flex--smostafa.bounces.google.com>)
 id 1rtpgj-0001PJ-MV
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:47 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-610b96c8ca2so73370057b3.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585369; x=1713190169; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=AMd8YNfC7PIDLuxaX4315ka/K6CHfBg/CUvv3sbGflM=;
 b=TRywDM2wK6BTL1rXN20MEg6kfmDOY1dhWq9UZou/nC0tq3F0uIVyM1oqc18xrVJiZU
 twQccS1skSS4KCSpCL7NxubcXW97G6AKOsWOyu8K3m8cKN0dNlUa9ocqKbUT8/HxuUnC
 2Q7yccapwwKuV1rcY0sE+X6hwoybaHIbYaf0Rcq7QFyDRKLnEy6TN8lBIKGNg+8XaG1p
 q2f3TqgOEJB90i7hNRHLo/fx/6zeUEyCcQWqFrLQpMD25Yysshn+lCmZ73rKENtJz2Ag
 YDaeS5GcZKLUy4IUjO1VyDAn1sQZSX0q2OkQpmDioHgNAmIqXpXgF+sLwpu9RDe5KONE
 BipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585369; x=1713190169;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AMd8YNfC7PIDLuxaX4315ka/K6CHfBg/CUvv3sbGflM=;
 b=wN2ZEMFAJQrJ3bch4n2O9QG2CCjxKy9usC9kp4y8Kl9W0TnplHjH9x1RbpO8ERYeDR
 xXU/CbUlhoyNKpNrZDtc+pMYHPsFLmBSly1+Rma0SWwH/ek5ecUJykbiLeaSQD6oYjxP
 l606OTOOLGnTMVnXQII2ZuS03zFy47TAUE3ZQ0Yh70krvZ+FKKbVeIFpj93+4yZWu69y
 WeIc3FPt2t3Qzk4Q2dtOvwnVnsBH7Tq+F+4cYrjWQmW3ZVlqqIExgOnFR6o/WGKYvdGU
 E2GssmbERWortVVXSk8FHR1EBZDPI4JwCVsWvNKK0ZY+RRUgXST9KeQb9SkPq6/hjLQ8
 hPXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj31/elqVwITACEw+s2A6mtfNZ5HONULPdSEd0FNSSSzOXFRRgZQByYMYxaod1Y0/EWWhHudo0KZJCnSr7ZD7FqW5ZFCg=
X-Gm-Message-State: AOJu0YzcNIaac+mJ32rKKK2Cv+doHQEStP2+lTMfbdV/yCDy1x1ASoiA
 ZMMdQQC/48YF4YWpZ3XqKm8gyALm/8iiTygYeIsJkLtaRgTwX2/N/TqeKLlzFUR5/JCjQiMUoR7
 DGUZK/EJnHQ==
X-Google-Smtp-Source: AGHT+IGluNUcEdGNO/MW02ClIEjM8uOtannDp473rPxeJGa/ejn0j6js4csqJlN5iWXZrJXEDWT/oAQWrex+Lw==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a0d:d54a:0:b0:615:165b:8dde with SMTP id
 x71-20020a0dd54a000000b00615165b8ddemr2605640ywd.10.1712585369753; Mon, 08
 Apr 2024 07:09:29 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:18 +0000
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240408140818.3799590-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-14-smostafa@google.com>
Subject: [RFC PATCH v2 13/13] hw/arm/virt: Set SMMU OAS based on CPU PARANGE
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3mfoTZggKChYE8AEFw1w2AA270.yA8C08G-z0H079A929G.AD2@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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
2.44.0.478.gd926399ef9-goog


