Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EBCC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma13-0005a7-3X; Tue, 19 Mar 2024 10:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0u-0005Xp-MR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0o-00073R-A1
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710856817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybGTeJ15j23uaLcwCaC0bXlA3wGJbYUuGHTm8RBxdns=;
 b=iGfNVoIfBpR+eRJ7rsVnu6Kbrp7Barq+gPQNJtBCWbuH/VsZo7kTPzHV5KoxGPk3798A3e
 NXcOv47I5BGDNvPoehvN1IAYrLA1QoBVNnELeiFitMY8x5qrxnHp36pjr84+nMYsKr/w2L
 poGVbSUuKCJ4pzS6QLiqxVBeEcgHUMI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-zuXoGTXQPPy0CbiujsQqAA-1; Tue, 19 Mar 2024 10:00:15 -0400
X-MC-Unique: zuXoGTXQPPy0CbiujsQqAA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a45acc7f07cso303408266b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856813; x=1711461613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybGTeJ15j23uaLcwCaC0bXlA3wGJbYUuGHTm8RBxdns=;
 b=Y5l3p1Y2RZ65/mxC8O4WC48JAkHm0ERAlGvi4jOyv+pHVp0acSexREwKgCvB44GH/c
 SiXPFUnn5CD6H86DA/UGQnbOOLUeTVjNi5m+SIDOiUnPIXW5i0nzQJDFg2nRNRyxWTi0
 BZAcddpZdDwiP2xbfoVEeIyM20y1bY48Vcv7sCd7jlXbdtEnhFS3TnM5TwMtC2WUuRsw
 7TTg61SO4Kaldl5B82tyRzRA2zZCkRUfEajwH5skAGQFf+0CTT4Xpj11MAOSqLOqBqry
 kMYXo/0SeN+yr1qhLl70RnMqylmyqsHAneyd3XzegfTagwWZI9U3SZCumtevLc+b7iyw
 z9XQ==
X-Gm-Message-State: AOJu0YyTCc3o7nZEoWjqlFOT4oCBXlDsE/CM3T7b/MsDWPYkMLMA/5OG
 M7GZIzjKoXCGvagCLYoQYgm8rN8+Cbn4BafvxGGwUBctLwTDLdlc3L9apbSXErCJFMdwGvxIGh4
 PguLTK2axBC/t5DKJ/TZbN5Hj93EIfQHisTrsC30YfzL45x/grHF/UDCBE9PoOARtJ9R8DCPJpU
 lg2Ahv0BCYleHCO1Cl/V7WLIqHs8JFpdmTV/9N
X-Received: by 2002:a17:906:7b8f:b0:a46:50ca:b318 with SMTP id
 s15-20020a1709067b8f00b00a4650cab318mr11240796ejo.16.1710856813133; 
 Tue, 19 Mar 2024 07:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0cC7iQZ9u0nmdR+Lw1DaLOjSPaVr4H6zryhkPlWX/fvjSRyZL+b1xgxKAYoHCmglzMp9OJQ==
X-Received: by 2002:a17:906:7b8f:b0:a46:50ca:b318 with SMTP id
 s15-20020a1709067b8f00b00a4650cab318mr11240765ejo.16.1710856812351; 
 Tue, 19 Mar 2024 07:00:12 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170906390500b00a46d6e51a6fsm1136218eje.63.2024.03.19.07.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:00:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com
Subject: [PATCH 3/7] KVM: track whether guest state is encrypted
Date: Tue, 19 Mar 2024 14:59:56 +0100
Message-ID: <20240319140000.1014247-4-pbonzini@redhat.com>
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

So far, KVM has allowed KVM_GET/SET_* ioctls to execute even if the
guest state is encrypted, in which case they do nothing.  For the new
API using VM types, instead, the ioctls will fail which is a safer and
more robust approach.

The new API will be the only one available for SEV-SNP and TDX, but it
is also usable for SEV and SEV-ES.  In preparation for that, require
architecture-specific KVM code to communicate the point at which guest
state is protected (which must be after kvm_cpu_synchronize_post_init(),
though that might change in the future in order to suppor migration).
From that point, skip reading registers so that cpu->vcpu_dirty is
never true: if it ever becomes true, kvm_arch_put_registers() will
fail miserably.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h     |  2 ++
 include/sysemu/kvm_int.h |  1 +
 accel/kvm/kvm-all.c      | 14 ++++++++++++--
 target/i386/sev.c        |  1 +
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fad9a7e8ff3..302e8f6f1e5 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -539,6 +539,8 @@ bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
 
+void kvm_mark_guest_state_protected(void);
+
 /**
  * kvm_hwpoisoned_mem - indicate if there is any hwpoisoned page
  * reported for the VM.
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 882e37e12c5..3496be7997a 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -87,6 +87,7 @@ struct KVMState
     bool kernel_irqchip_required;
     OnOffAuto kernel_irqchip_split;
     bool sync_mmu;
+    bool guest_state_protected;
     uint64_t manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
      * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a8cecd040eb..05fa3533c66 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2698,7 +2698,7 @@ bool kvm_cpu_check_are_resettable(void)
 
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
         int ret = kvm_arch_get_registers(cpu);
         if (ret) {
             error_report("Failed to get registers: %s", strerror(-ret));
@@ -2712,7 +2712,7 @@ static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 
 void kvm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->vcpu_dirty) {
+    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
         run_on_cpu(cpu, do_kvm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -2747,6 +2747,11 @@ static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 
 void kvm_cpu_synchronize_post_init(CPUState *cpu)
 {
+    /*
+     * This runs before the machine_init_done notifiers, and is the last
+     * opportunity to synchronize the state of confidential guests.
+     */
+    assert(!kvm_state->guest_state_protected);
     run_on_cpu(cpu, do_kvm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
@@ -4094,3 +4099,8 @@ void query_stats_schemas_cb(StatsSchemaList **result, Error **errp)
         query_stats_schema_vcpu(first_cpu, &stats_args);
     }
 }
+
+void kvm_mark_guest_state_protected(void)
+{
+    kvm_state->guest_state_protected = true;
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index b8f79d34d19..c49a8fd55eb 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -755,6 +755,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
         if (ret) {
             exit(1);
         }
+        kvm_mark_guest_state_protected();
     }
 
     /* query the measurement blob length */
-- 
2.44.0


