Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9C4E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4T-0004d8-2r; Fri, 10 Jan 2025 13:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2Y-0000OG-Pm
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2W-0001Bc-JC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQJ66dju737femJRsMpPCtvgIC+UUMnbAS70jNpxfeo=;
 b=cVkrRV3MqMvYCsBr2ISH2ECpYj+fDoJfnsc9ZrwYZfteqW32+Yd015SU0gdzYExCHDh60z
 cXmEtA2Q/vHT7bl4cg+/s4at6GRuiIczkh5zQVTyKVdPaoQ5cCDxW0Pt5eHtCYsERIxVkX
 ghJh4thNUsLoRjdwtX63B/HpXodcMKI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-QFQTHwO4OwOTvLVjgjifTA-1; Fri, 10 Jan 2025 13:47:21 -0500
X-MC-Unique: QFQTHwO4OwOTvLVjgjifTA-1
X-Mimecast-MFC-AGG-ID: QFQTHwO4OwOTvLVjgjifTA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa680e17f6dso173624666b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534839; x=1737139639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQJ66dju737femJRsMpPCtvgIC+UUMnbAS70jNpxfeo=;
 b=r6CJOfZryFy4ZokqhF+Jqm7bwWODWyCLvvpnzp647Ofs6a5n/bwd5jXFc7LvboFFVS
 Q0ZQ5dc/hwD9s9Prl13ZOx8PsqpWdnAZTXX7+ojKnHHgONpSnqdIaG9uvF5GaiSlD1A5
 R3G28q4pXhzAooAPov+rfwt3yvY7gf9CtCXmFPlV6xCsJT9Hu4xiEv4YABloIJHOHsHX
 N0GjGMqpxjYd0AngxLsp0cOxNmDuJtUFHQ/Pkg9ITxlozIW3UgDh3j4sn5r0vY/ksO+H
 N6fv2ZrhHG1jmNzFPL0DE7ysUnF70/ZfFLtwa1GbgNKKFXzL16x49iQQS+ASnBcJtZ0v
 ehDg==
X-Gm-Message-State: AOJu0YyN9s3K17AujH8df74j0/ryDsnAg265VLbI5ElBfhCa9cjZY8+G
 msYaZYLvjApyluRTDtcINxg6HXq+9jnfM08MDT1hUDx2DubiSqsa1WCTZ8MugbHGq/sCS0M5bJi
 aT4jU+Y4fTI1Csp1pU7VLYsJPbJTbCzPGj0RfJhnruO4CStaxbstbEyzpne4kkb3xZofGZXO4g+
 RDstIW50UBnJIWyjQXN7QsMVsbsGfVYUCBtCBiP0w=
X-Gm-Gg: ASbGncv95U/Hecb90niLbOf26Vry4Xm5hbQHDR7LjR8adXSdIb8MHtTeuz+yHIZU5tp
 bDhzlHTXCBUjLq06F3LpV1iM2vwGLoPwWHJ2hBqVtRa0x+j7OEgoamZSaM1Me8m+XV5GIm4MD0V
 YFZNKYT3+9y26PRmlX0IMFGyMWHqD7f2eXJRrYE56twUlc8Pz2mLADB6XA0Cvft8tBKXY0ROIoJ
 dTAEDt3IzzxjC5zTyEV+a2RuhFsvUnJDgjPE8BcPu8bbIdJEruH96zrCO4=
X-Received: by 2002:a05:6402:2548:b0:5d4:2ef7:1c with SMTP id
 4fb4d7f45d1cf-5d972e639e4mr25747704a12.24.1736534839122; 
 Fri, 10 Jan 2025 10:47:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWmpI1umUMUwPRgZY6i1mxDThPk3FoW637c1jJtDAv45Lh1mt1m9Uz1B+TozVgFeYi2tgeJw==
X-Received: by 2002:a05:6402:2548:b0:5d4:2ef7:1c with SMTP id
 4fb4d7f45d1cf-5d972e639e4mr25747657a12.24.1736534838679; 
 Fri, 10 Jan 2025 10:47:18 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99083fbd7sm1910629a12.73.2025.01.10.10.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PULL 25/38] target/i386/kvm: Clean up return values of MSR filter
 related functions
Date: Fri, 10 Jan 2025 19:46:06 +0100
Message-ID: <20250110184620.408302-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Before commit 0cc42e63bb54 ("kvm/i386: refactor kvm_arch_init and split
it into smaller functions"), error_report() attempts to print the error
code from kvm_filter_msr(). However, printing error code does not work
due to kvm_filter_msr() returns bool instead int.

0cc42e63bb54 fixed the error by removing error code printing, but this
lost useful error messages. Bring it back by making kvm_filter_msr()
return int.

This also makes the function call chain processing clearer, allowing for
better handling of error result propagation from kvm_filter_msr() to
kvm_arch_init(), preparing for the subsequent cleanup work of error
handling in kvm_arch_init().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 87 ++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 17f23607ed0..097a040da30 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -108,8 +108,8 @@ typedef struct {
 } KVMMSRHandlers;
 
 static void kvm_init_msrs(X86CPU *cpu);
-static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                           QEMUWRMSRHandler *wrmsr);
+static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                          QEMUWRMSRHandler *wrmsr);
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -3150,17 +3150,21 @@ static int kvm_vm_enable_notify_vmexit(KVMState *s)
 
 static int kvm_vm_enable_userspace_msr(KVMState *s)
 {
-    int ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
-                                KVM_MSR_EXIT_REASON_FILTER);
+    int ret;
+
+    ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
+                            KVM_MSR_EXIT_REASON_FILTER);
     if (ret < 0) {
         error_report("Could not enable user space MSRs: %s",
                      strerror(-ret));
         exit(1);
     }
 
-    if (!kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
-                        kvm_rdmsr_core_thread_count, NULL)) {
-        error_report("Could not install MSR_CORE_THREAD_COUNT handler!");
+    ret = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
+                         kvm_rdmsr_core_thread_count, NULL);
+    if (ret < 0) {
+        error_report("Could not install MSR_CORE_THREAD_COUNT handler: %s",
+                     strerror(-ret));
         exit(1);
     }
 
@@ -3169,36 +3173,37 @@ static int kvm_vm_enable_userspace_msr(KVMState *s)
 
 static void kvm_vm_enable_energy_msrs(KVMState *s)
 {
-    bool r;
+    int ret;
+
     if (s->msr_energy.enable == true) {
-        r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
-                           kvm_rdmsr_rapl_power_unit, NULL);
-        if (!r) {
-            error_report("Could not install MSR_RAPL_POWER_UNIT \
-                                handler");
+        ret = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
+                             kvm_rdmsr_rapl_power_unit, NULL);
+        if (ret < 0) {
+            error_report("Could not install MSR_RAPL_POWER_UNIT handler: %s",
+                         strerror(-ret));
             exit(1);
         }
 
-        r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
-                           kvm_rdmsr_pkg_power_limit, NULL);
-        if (!r) {
-            error_report("Could not install MSR_PKG_POWER_LIMIT \
-                                handler");
+        ret = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
+                             kvm_rdmsr_pkg_power_limit, NULL);
+        if (ret < 0) {
+            error_report("Could not install MSR_PKG_POWER_LIMIT handler: %s",
+                         strerror(-ret));
             exit(1);
         }
 
-        r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
-                           kvm_rdmsr_pkg_power_info, NULL);
-        if (!r) {
-            error_report("Could not install MSR_PKG_POWER_INFO \
-                                handler");
+        ret = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
+                             kvm_rdmsr_pkg_power_info, NULL);
+        if (ret < 0) {
+            error_report("Could not install MSR_PKG_POWER_INFO handler: %s",
+                         strerror(-ret));
             exit(1);
         }
-        r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
-                           kvm_rdmsr_pkg_energy_status, NULL);
-        if (!r) {
-            error_report("Could not install MSR_PKG_ENERGY_STATUS \
-                                handler");
+        ret = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
+                             kvm_rdmsr_pkg_energy_status, NULL);
+        if (ret < 0) {
+            error_report("Could not install MSR_PKG_ENERGY_STATUS handler: %s",
+                         strerror(-ret));
             exit(1);
         }
     }
@@ -5841,13 +5846,13 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
     }
 }
 
-static bool kvm_install_msr_filters(KVMState *s)
+static int kvm_install_msr_filters(KVMState *s)
 {
     uint64_t zero = 0;
     struct kvm_msr_filter filter = {
         .flags = KVM_MSR_FILTER_DEFAULT_ALLOW,
     };
-    int r, i, j = 0;
+    int i, j = 0;
 
     for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
@@ -5871,18 +5876,13 @@ static bool kvm_install_msr_filters(KVMState *s)
         }
     }
 
-    r = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
-    if (r) {
-        return false;
-    }
-
-    return true;
+    return kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
 }
 
-static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                    QEMUWRMSRHandler *wrmsr)
+static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                          QEMUWRMSRHandler *wrmsr)
 {
-    int i;
+    int i, ret;
 
     for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
         if (!msr_handlers[i].msr) {
@@ -5892,16 +5892,17 @@ static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                 .wrmsr = wrmsr,
             };
 
-            if (!kvm_install_msr_filters(s)) {
+            ret = kvm_install_msr_filters(s);
+            if (ret) {
                 msr_handlers[i] = (KVMMSRHandlers) { };
-                return false;
+                return ret;
             }
 
-            return true;
+            return 0;
         }
     }
 
-    return false;
+    return -EINVAL;
 }
 
 static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
-- 
2.47.1


