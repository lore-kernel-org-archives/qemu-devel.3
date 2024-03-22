Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32D5C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjf9-0003K0-6a; Fri, 22 Mar 2024 14:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjew-0003HJ-9E
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjeu-0003TZ-1o
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711132227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lX1ZpNOz/f8WGgxXm5qvIzLIxCNZvJIgxvAaNK4StQY=;
 b=ApX5z5Y4JRAay0FeBijJ1PcH+Tr2zhAMkHnAF50tBg1GhX4N4GQDufJxwjqLIoDg9BsyaS
 K/pGiDEEYdsZJ4zhyC39s1PxhyQBQn0QtCldGcVCfkGCDk2nRqjSQ5ZouxfL1HtxE1LwWN
 2/wGdPKjT8oKOhPddep5iu/dM05yC5M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-F6pkCUMvM8aaYJuZ9laMdA-1; Fri, 22 Mar 2024 14:30:25 -0400
X-MC-Unique: F6pkCUMvM8aaYJuZ9laMdA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-568a3be9127so1530494a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711132223; x=1711737023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lX1ZpNOz/f8WGgxXm5qvIzLIxCNZvJIgxvAaNK4StQY=;
 b=XwZ6zNASzuACE2qdVw5Kvj86FKjXBILA07wmK14tosctD92Rj7IVgksH2E0E+928bl
 RZOpOQBZiM+qW0vZgjQ0lTz3fXxItCOQtrYyCMnS7/HRUit5uU4iHh6KjRHmqmelLScx
 97+FUqK9j1M4IsTOjk4YDBpRSMCBDKzBCCVAdT/Kjgf8ApOiIiK6zOETIF1iaJzV+H3/
 UjDHEOYy5HcCYsJeKedPsgH6TFQAwt/r9AVJ2U6IIVklsjS8V8SdUcLJJWJo9vZ0XHU0
 ARcSo4opbYUz3CGiq2UV7qWZ6CXKheM6CAYDcKL6BCI10b6QJUGKyOGnt7z+W9Ld43cO
 yJIA==
X-Gm-Message-State: AOJu0YxbpCKe6px0I574/6qp2SMj7lhe+TvfevXLHTahp4f/Q6usAN1p
 tlttY/TcWdYpU5ZyuLLMqkt8tAriWM2oIDYyMkg0C9KqK45VIFOM+fu9DG7oveo2V4QM79p1X35
 rJjFk/9sdgew3iwx7KBZfOFr76wJ1vCpi0JcuQJU80waZfm9H6reh0qd9MHghTz1YAH8EWnuG/1
 TMt7FyVHssyo2df9RylCM5QSM24TMEtpv0bK90
X-Received: by 2002:a50:f694:0:b0:568:b43c:d75d with SMTP id
 d20-20020a50f694000000b00568b43cd75dmr205469edn.25.1711132223247; 
 Fri, 22 Mar 2024 11:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFva2n8gs4mlw09ih+0NxIUShp/zYcv4aD+lolFMqEYmJ1kbg5s/KIgkmJ8AJ5htEKeOdxdXg==
X-Received: by 2002:a50:f694:0:b0:568:b43c:d75d with SMTP id
 d20-20020a50f694000000b00568b43cd75dmr205454edn.25.1711132222824; 
 Fri, 22 Mar 2024 11:30:22 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 df15-20020a05640230af00b00568d6a20717sm87664edb.52.2024.03.22.11.30.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:30:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] kvm: use configs/ definition to conditionalize debug support
Date: Fri, 22 Mar 2024 19:30:20 +0100
Message-ID: <20240322183020.1230736-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

If an architecture adds support for KVM_CAP_SET_GUEST_DEBUG but QEMU does not
have the necessary code, QEMU will fail to build after updating kernel headers.
Avoid this by using a #define in config-target.h instead of KVM_CAP_SET_GUEST_DEBUG.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/aarch64-softmmu.mak |  1 +
 configs/targets/i386-softmmu.mak    |  1 +
 configs/targets/ppc-softmmu.mak     |  1 +
 configs/targets/ppc64-softmmu.mak   |  1 +
 configs/targets/s390x-softmmu.mak   |  1 +
 configs/targets/x86_64-softmmu.mak  |  1 +
 include/sysemu/kvm.h                |  2 +-
 include/sysemu/kvm_int.h            |  2 +-
 accel/kvm/kvm-accel-ops.c           |  4 ++--
 accel/kvm/kvm-all.c                 | 10 +++++-----
 10 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index b4338e95680..83c22391a69 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,5 +1,6 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
 TARGET_NEED_FDT=y
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 6b3c99fc86c..d61b5076134 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_NEED_FDT=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 774440108f7..f3ea9c98f75 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
 TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index ddf0c39617f..1db8d8381d0 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -2,5 +2,6 @@ TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
 TARGET_NEED_FDT=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 70d2f9f0ba0..b22218aacc8 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 197817c9434..c5f882e5ba1 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_NEED_FDT=y
+TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 698f1640fe2..e4bdc1ff914 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -224,7 +224,7 @@ void kvm_flush_coalesced_mmio_buffer(void);
  * calling down to kvm_arch_update_guest_debug after the generic
  * fields have been set.
  */
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
 #else
 static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index a5a3fee4119..3f3d13f8166 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -80,7 +80,7 @@ struct KVMState
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
     int max_nested_state_len;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 74e3c5785b5..94c828ac8da 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -85,7 +85,7 @@ static bool kvm_cpus_are_resettable(void)
     return !kvm_enabled() || !kvm_state->guest_state_protected;
 }
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 static int kvm_update_guest_debug_ops(CPUState *cpu)
 {
     return kvm_update_guest_debug(cpu, 0);
@@ -104,7 +104,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, void *data)
     ops->synchronize_state = kvm_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
     ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index afd7f992e39..a7517bd6494 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
     s->sigmask_len = 8;
     accel_blocker_init();
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
 #endif
     QLIST_INIT(&s->kvm_parked_vcpus);
@@ -2617,7 +2617,7 @@ static int kvm_init(MachineState *ms)
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
 #endif
@@ -2626,7 +2626,7 @@ static int kvm_init(MachineState *ms)
     if (kvm_has_guest_debug) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
-#if defined KVM_CAP_SET_GUEST_DEBUG2
+#if defined TARGET_KVM_HAVE_GUEST_DEBUG
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
@@ -3309,7 +3309,7 @@ bool kvm_arm_supports_user_irq(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
 }
 
-#ifdef KVM_CAP_SET_GUEST_DEBUG
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct kvm_sw_breakpoint *bp;
@@ -3469,7 +3469,7 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
-#endif /* !KVM_CAP_SET_GUEST_DEBUG */
+#endif /* !TARGET_KVM_HAVE_GUEST_DEBUG */
 
 static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
-- 
2.44.0


