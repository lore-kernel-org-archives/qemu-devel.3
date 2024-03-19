Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25950C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma13-0005aH-Fh; Tue, 19 Mar 2024 10:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0w-0005Xu-BK
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0u-00073b-6f
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710856820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9emNvMsIIrDiUDK+01y8v3rcLTpyWzmX6fC/BcZW0w=;
 b=NprqL/MhFDMmb4Gab7TrJ1JYPeeZgJko3Os12ESBjhKNgGlbvofk1jNmxYmzfen6/30NUD
 37xB1JxSKCOYtWSS92YID6cjRFL1s3MWVtqTlMxFzaG1KyrKURYTlr8aVN3mH1J8pHZq5G
 cXR09FuRI3xjuyyfbZSvq62w542yfA0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-1uSN7iH6PBCmI5IL6NoLDw-1; Tue, 19 Mar 2024 10:00:18 -0400
X-MC-Unique: 1uSN7iH6PBCmI5IL6NoLDw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-558aafe9bf2so4514890a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856816; x=1711461616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9emNvMsIIrDiUDK+01y8v3rcLTpyWzmX6fC/BcZW0w=;
 b=P064JhnnI0iDMFH/tcwBnvXXZ2Wmg6mjgWR2LysdL2GVKzbFXpiqGxwu1hyy8p+IZ/
 RhHrxJnFzpOngl0SSG2631mxTtppRtErr/kqWEW6oYqLgQ9nO0Ks5ZE4pVrfa1s830Ae
 oYjbfCpiNie1SXk5yKZEF+I3S0kM0R1CBt1rXJ7KofWfZw9eQlE2qrdNBwraUTIESKpt
 nHJZODbDmNnm2J42bA4SR3dRXs7UA2yTHSqTQEW5Ai5D3LnX7Se9m9L9JElNRvnS+kjB
 HJmaZXyBFwlleV8DY2mt6Sd8Kzdjv+2Xntc4Fw84PXLSETJLI4DJvbCPGMP8lQP7VDTm
 kmgw==
X-Gm-Message-State: AOJu0YyNzA1sYvXc7qOdj7im/OpnrAwdZkCiESzspbP/fjOpV2HB2/MK
 RtXWQRvERiAhmscuWGK5LK7phW4H7BhSZRqkkcZv4L9whvGA6W1KVOxnJx7wBhdQ6SoBmJtjpKK
 E7AM+Ly47u5BGF3BEqzktXWNuTz7frr76uHUjMYx8eS//qSmvNfYYPtT8PbOWxJkp5P74hON4MF
 PbzGHFzo+MPywZ+9zVP43kAStLfGmHxXqN7RUo
X-Received: by 2002:a05:6402:2423:b0:568:941c:2f0a with SMTP id
 t35-20020a056402242300b00568941c2f0amr11810469eda.15.1710856815867; 
 Tue, 19 Mar 2024 07:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrQWLj6Vx6qYTqYbBUXs7GYzDJr+HnTv1wVxuL6CXkI2qErj9U5PHEO1/66nCkmYwu66SdYw==
X-Received: by 2002:a05:6402:2423:b0:568:941c:2f0a with SMTP id
 t35-20020a056402242300b00568941c2f0amr11810457eda.15.1710856815605; 
 Tue, 19 Mar 2024 07:00:15 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a056402194600b0056b98d7ba00sm668935edz.90.2024.03.19.07.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:00:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com
Subject: [PATCH 4/7] KVM: remove kvm_arch_cpu_check_are_resettable
Date: Tue, 19 Mar 2024 14:59:57 +0100
Message-ID: <20240319140000.1014247-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319140000.1014247-1-pbonzini@redhat.com>
References: <20240319140000.1014247-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Board reset requires writing a fresh CPU state.  As far as KVM is
concerned, the only thing that blocks reset is that CPU state is
encrypted; therefore, kvm_cpus_are_resettable() can simply check
if that is the case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h       | 10 ----------
 accel/kvm/kvm-accel-ops.c  |  2 +-
 accel/kvm/kvm-all.c        |  5 -----
 target/arm/kvm.c           |  5 -----
 target/i386/kvm/kvm.c      |  5 -----
 target/loongarch/kvm/kvm.c |  5 -----
 target/mips/kvm.c          |  5 -----
 target/ppc/kvm.c           |  5 -----
 target/riscv/kvm/kvm-cpu.c |  5 -----
 target/s390x/kvm/kvm.c     |  5 -----
 10 files changed, 1 insertion(+), 51 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 302e8f6f1e5..54f4d83a370 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -525,16 +525,6 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 /* Notify resamplefd for EOI of specific interrupts. */
 void kvm_resample_fd_notify(int gsi);
 
-/**
- * kvm_cpu_check_are_resettable - return whether CPUs can be reset
- *
- * Returns: true: CPUs are resettable
- *          false: CPUs are not resettable
- */
-bool kvm_cpu_check_are_resettable(void);
-
-bool kvm_arch_cpu_check_are_resettable(void);
-
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index b3c946dc4b4..74e3c5785b5 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -82,7 +82,7 @@ static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
 
 static bool kvm_cpus_are_resettable(void)
 {
-    return !kvm_enabled() || kvm_cpu_check_are_resettable();
+    return !kvm_enabled() || !kvm_state->guest_state_protected;
 }
 
 #ifdef KVM_CAP_SET_GUEST_DEBUG
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 05fa3533c66..a05dea23133 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2691,11 +2691,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
     s->coalesced_flush_in_progress = false;
 }
 
-bool kvm_cpu_check_are_resettable(void)
-{
-    return kvm_arch_cpu_check_are_resettable();
-}
-
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ab85d628a8b..21ebbf3b8f8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1598,11 +1598,6 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     return (data - 32) & 0xffff;
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 static void kvm_arch_get_eager_split_size(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de10155b37a..0ec69109a2b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5614,11 +5614,6 @@ bool kvm_has_waitpkg(void)
     return has_msr_umwait;
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return !sev_es_enabled();
-}
-
 #define ARCH_REQ_XCOMP_GUEST_PERM       0x1025
 
 void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask)
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d630cc39cb2..8224d943331 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -733,11 +733,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
     return true;
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 6c52e59f55d..a631ab544f5 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1273,11 +1273,6 @@ int kvm_arch_get_default_type(MachineState *machine)
     return -1;
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8231feb2d45..63930d4a77d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2956,11 +2956,6 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
     }
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cda7d78a778..135d87dc3f5 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1466,11 +1466,6 @@ void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
     }
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 static int aia_mode;
 
 static const char *kvm_aia_mode_str(uint64_t mode)
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4ce809c5d46..4dcd757cdcc 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2622,11 +2622,6 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
     kvm_s390_vcpu_interrupt(cpu, &irq);
 }
 
-bool kvm_arch_cpu_check_are_resettable(void)
-{
-    return true;
-}
-
 int kvm_s390_get_zpci_op(void)
 {
     return cap_zpci_op;
-- 
2.44.0


