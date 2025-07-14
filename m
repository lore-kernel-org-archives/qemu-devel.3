Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8274C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHLi-0006hb-5C; Mon, 14 Jul 2025 07:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0A-0001GI-QH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH07-0001vv-2z
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZMuD6ZbchMZbKYlrDnV3xYP+ib1rv/vIs10rW+CJTk=;
 b=P8s2vYZNijc2keCfHlBBjKQii40jNPwklbVkDytEQUEdhxYO6XW+Wv3sOZ/bqoZclh5KJJ
 xNy10fY5SQ+mM2hPFFg0mDx+0jH6Em3rhMHQEULJOvOidTjSTUsZiWSdsohZpMiTUtu/LC
 9WS4eaLQjuSZ9hT2iwlYmGQJJZVGIdE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-dUG1amopMbKUp08sRBCpgw-1; Mon, 14 Jul 2025 07:05:37 -0400
X-MC-Unique: dUG1amopMbKUp08sRBCpgw-1
X-Mimecast-MFC-AGG-ID: dUG1amopMbKUp08sRBCpgw_1752491136
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45600d19a2aso15968095e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491135; x=1753095935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZMuD6ZbchMZbKYlrDnV3xYP+ib1rv/vIs10rW+CJTk=;
 b=Gztg3YQlkHBGXOBFksp7ZNv8FRcMv2U8FIIG3EMDQfC5tdpzFwtL5ZwrhIuFg6RD7D
 nRMQN5F5lb9TaC+4da6GE6TCcGuRnAr06k7xgBtlA3RFUncvdfEzaoO4uFw4k53n0Io8
 jKfeL1CMiZGrz59q/8e4j9yyKXtZhD5V4frZrNVxMjA9GBjLehBUMhn5WVkkQ1mUQ3zF
 k1atGtEaid7aqxJ/vf582YEQe42RkKJDHyQBS2gddHOgS0syQ2N2tILidEl/ovM1XHLZ
 53gmf4LfI3VyKiQ4IC50KgPBsK5RI7r8AH0G/mIeyk7mNSq/lg70n6wkhuK/g4nX8q3C
 RVyQ==
X-Gm-Message-State: AOJu0YwJOt/05ehtSrvy7+9SJLr1rPB+DeLQzNz+bGXgbDjR991wPd8+
 lX3qfQd1IbEtqZetMOczkvNeH2j08a6xo11AfTbAHEwKRAee2L95vdJ1tuMXnPRPuXuSwtNcVJC
 EAzAYzguEQNV8sB/w1HFo88K0SpBAY2zK3Hi9JsnyE3WUhOh5JcZE0Xx6OpmmA+rtPnd1AyUnVK
 GH8J03lRbQs92iVEjEGOW3w4mx8vf5DKwbZVooPs1s
X-Gm-Gg: ASbGncsHxY+R6sMn7zyukrwLaud3boG+qOWuzeHCw+6FUXODrPN8tq2SJyHtmyJZmYa
 pxHMeBJWGiLmObsQgcOTKqkfEBKtYCUxf6yTKjMChPKCl4PUHtIk1rcoLU3ynqP/lw2eCZqPt9T
 AgYoTwRhKUiaYMi+/IYJvk7inWHE/+0mSNn/7EqcWe8sE1XCXTouD54i+sld6PP8NbFzfaN3jSI
 Vro0wpL3DTsBsP/P6PIBFURH5KNUp7eHAYSSl/SP+bEpIgcjrwIDCIwvNEhHZAKX2vHwYENdGFE
 17DQS9HfxpZfnn/TKBpiIqbXOTzWTDq6JUssYOrRRMg=
X-Received: by 2002:a05:600c:a316:b0:442:f97b:87e with SMTP id
 5b1f17b1804b1-4550ef7b064mr84821335e9.6.1752491134986; 
 Mon, 14 Jul 2025 04:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbuRw3NXbI1Lrpv2yqFFnXG1wLw1fZ9YemZaOj62kw26eBTq/ZRhJvVGIrzSOquwb4LiXyjw==
X-Received: by 2002:a05:600c:a316:b0:442:f97b:87e with SMTP id
 5b1f17b1804b1-4550ef7b064mr84821015e9.6.1752491134392; 
 Mon, 14 Jul 2025 04:05:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f844c2dsm57345885e9.0.2025.07.14.04.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Liam Merwick <liam.merwick@oracle.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 32/77] sev: Provide sev_features flags from IGVM VMSA to
 KVM_SEV_INIT2
Date: Mon, 14 Jul 2025 13:03:21 +0200
Message-ID: <20250714110406.117772-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

IGVM files can contain an initial VMSA that should be applied to each
vcpu as part of the initial guest state. The sev_features flags are
provided as part of the VMSA structure. However, KVM only allows
sev_features to be set during initialization and not as the guest is
being prepared for launch.

This patch queries KVM for the supported set of sev_features flags and
processes the VP context entries in the IGVM file during kvm_init to
determine any sev_features flags set in the IGVM file. These are then
provided in the call to KVM_SEV_INIT2 to ensure the guest state
matches that specified in the IGVM file.

The igvm process() function is modified to allow a partial processing
of the file during initialization, with only the IGVM_VHT_VP_CONTEXT
fields being processed. This means the function is called twice,
firstly to extract the sev_features then secondly to actually
configure the guest.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/b2f986aae04e1da2aee530c9be22a54c0c59a560.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/igvm.h           |   2 +-
 include/system/igvm-cfg.h |   5 +-
 backends/igvm.c           |  17 +++-
 hw/i386/pc_piix.c         |   2 +-
 hw/i386/pc_q35.c          |   2 +-
 target/i386/sev.c         | 161 +++++++++++++++++++++++++++++++++-----
 6 files changed, 163 insertions(+), 26 deletions(-)

diff --git a/backends/igvm.h b/backends/igvm.h
index db02ea91651..a4abab043a1 100644
--- a/backends/igvm.h
+++ b/backends/igvm.h
@@ -17,6 +17,6 @@
 #include "qapi/error.h"
 
 int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
-                      Error **errp);
+                      bool onlyVpContext, Error **errp);
 
 #endif
diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
index 321b3196f09..944f23a814d 100644
--- a/include/system/igvm-cfg.h
+++ b/include/system/igvm-cfg.h
@@ -31,11 +31,14 @@ typedef struct IgvmCfgClass {
     /*
      * If an IGVM filename has been specified then process the IGVM file.
      * Performs a no-op if no filename has been specified.
+     * If onlyVpContext is true then only the IGVM_VHT_VP_CONTEXT entries
+     * in the IGVM file will be processed, allowing information about the
+     * CPU state to be determined before processing the entire file.
      *
      * Returns 0 for ok and -1 on error.
      */
     int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
-                   Error **errp);
+                   bool onlyVpContext, Error **errp);
 
 } IgvmCfgClass;
 
diff --git a/backends/igvm.c b/backends/igvm.c
index b568f06c769..9ad41582ee5 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -880,7 +880,7 @@ static IgvmHandle qigvm_file_init(char *filename, Error **errp)
 }
 
 int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
-                       Error **errp)
+                       bool onlyVpContext, Error **errp)
 {
     int32_t header_count;
     QIgvmParameterData *parameter;
@@ -924,11 +924,22 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
          ctx.current_header_index++) {
         IgvmVariableHeaderType type = igvm_get_header_type(
             ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
-        if (qigvm_handler(&ctx, type, errp) < 0) {
-            goto cleanup_parameters;
+        if (!onlyVpContext || (type == IGVM_VHT_VP_CONTEXT)) {
+            if (qigvm_handler(&ctx, type, errp) < 0) {
+                goto cleanup_parameters;
+            }
         }
     }
 
+    /*
+     * If only processing the VP context then we don't need to process
+     * any more of the file.
+     */
+    if (onlyVpContext) {
+        retval = 0;
+        goto cleanup_parameters;
+    }
+
     header_count =
         igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
     if (header_count < 0) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3184ea1b378..a3285fbc645 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -371,7 +371,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     /* Apply guest state from IGVM if supplied */
     if (x86ms->igvm) {
         if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
             g_assert_not_reached();
         }
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6990e1c6695..cf871cfdad8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -330,7 +330,7 @@ static void pc_q35_init(MachineState *machine)
     /* Apply guest state from IGVM if supplied */
     if (x86ms->igvm) {
         if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
             g_assert_not_reached();
         }
     }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 3e5722ba657..1057b8ab2c6 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -118,6 +118,8 @@ struct SevCommonState {
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
     bool kernel_hashes;
+    uint64_t sev_features;
+    uint64_t supported_sev_features;
 
     /* runtime state */
     uint8_t api_major;
@@ -485,7 +487,40 @@ static void sev_apply_cpu_context(CPUState *cpu)
     }
 }
 
-static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
+static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
+                              Error **errp)
+{
+    /*
+     * Ensure SEV_FEATURES is configured for correct SEV hardware and that
+     * the requested features are supported. If SEV-SNP is enabled then
+     * that feature must be enabled, otherwise it must be cleared.
+     */
+    if (sev_snp_enabled() && !(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
+        error_setg(
+            errp,
+            "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
+            __func__);
+        return -1;
+    } else if (!sev_snp_enabled() &&
+               (sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
+        error_setg(
+            errp,
+            "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
+            __func__);
+        return -1;
+    }
+    if (sev_features & ~sev_common->supported_sev_features) {
+        error_setg(errp,
+                   "%s: VMSA contains unsupported sev_features: %lX, "
+                   "supported features: %lX",
+                   __func__, sev_features, sev_common->supported_sev_features);
+        return -1;
+    }
+    return 0;
+}
+
+static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
+                                const struct sev_es_save_area *vmsa,
                                 Error **errp)
 {
     struct sev_es_save_area vmsa_check;
@@ -551,24 +586,10 @@ static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
     vmsa_check.x87_fcw = 0;
     vmsa_check.mxcsr = 0;
 
-    if (sev_snp_enabled()) {
-        if (vmsa_check.sev_features != SVM_SEV_FEAT_SNP_ACTIVE) {
-            error_setg(errp,
-                       "%s: sev_features in the VMSA contains an unsupported "
-                       "value. For SEV-SNP, sev_features must be set to %x.",
-                       __func__, SVM_SEV_FEAT_SNP_ACTIVE);
-            return -1;
-        }
-        vmsa_check.sev_features = 0;
-    } else {
-        if (vmsa_check.sev_features != 0) {
-            error_setg(errp,
-                       "%s: sev_features in the VMSA contains an unsupported "
-                       "value. For SEV-ES and SEV, sev_features must be "
-                       "set to 0.", __func__);
-            return -1;
-        }
+    if (check_sev_features(sev_common, vmsa_check.sev_features, errp) < 0) {
+        return -1;
     }
+    vmsa_check.sev_features = 0;
 
     if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
         error_setg(errp,
@@ -1722,6 +1743,39 @@ static int sev_snp_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_SNP_VM;
 }
 
+static int sev_init_supported_features(ConfidentialGuestSupport *cgs,
+                                       SevCommonState *sev_common, Error **errp)
+{
+    X86ConfidentialGuestClass *x86_klass =
+                               X86_CONFIDENTIAL_GUEST_GET_CLASS(cgs);
+    /*
+     * Older kernels do not support query or setting of sev_features. In this
+     * case the set of supported features must be zero to match the settings
+     * in the kernel.
+     */
+    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) ==
+        KVM_X86_DEFAULT_VM) {
+        sev_common->supported_sev_features = 0;
+        return 0;
+    }
+
+    /* Query KVM for the supported set of sev_features */
+    struct kvm_device_attr attr = {
+        .group = KVM_X86_GRP_SEV,
+        .attr = KVM_X86_SEV_VMSA_FEATURES,
+        .addr = (unsigned long)&sev_common->supported_sev_features,
+    };
+    if (kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr) < 0) {
+        error_setg(errp, "%s: failed to query supported sev_features",
+                   __func__);
+        return -1;
+    }
+    if (sev_snp_enabled()) {
+        sev_common->supported_sev_features |= SVM_SEV_FEAT_SNP_ACTIVE;
+    }
+    return 0;
+}
+
 static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     char *devname;
@@ -1802,6 +1856,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    if (sev_init_supported_features(cgs, sev_common, errp) < 0) {
+        return -1;
+    }
+
     trace_kvm_sev_init();
     switch (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common))) {
     case KVM_X86_DEFAULT_VM:
@@ -1813,6 +1871,40 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     case KVM_X86_SEV_ES_VM:
     case KVM_X86_SNP_VM: {
         struct kvm_sev_init args = { 0 };
+        MachineState *machine = MACHINE(qdev_get_machine());
+        X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
+
+        /*
+         * If configuration is provided via an IGVM file then the IGVM file
+         * might contain configuration of the initial vcpu context. For SEV
+         * the vcpu context includes the sev_features which should be applied
+         * to the vcpu.
+         *
+         * KVM does not synchronize sev_features from CPU state. Instead it
+         * requires sev_features to be provided as part of this initialization
+         * call which is subsequently automatically applied to the VMSA of
+         * each vcpu.
+         *
+         * The IGVM file is normally processed after initialization. Therefore
+         * we need to pre-process it here to extract sev_features in order to
+         * provide it to KVM_SEV_INIT2. Each cgs_* function that is called by
+         * the IGVM processor detects this pre-process by observing the state
+         * as SEV_STATE_UNINIT.
+         */
+        if (x86machine->igvm) {
+            if (IGVM_CFG_GET_CLASS(x86machine->igvm)
+                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
+                -1) {
+                return -1;
+            }
+            /*
+             * KVM maintains a bitmask of allowed sev_features. This does not
+             * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
+             * itself. Therefore we need to clear this flag.
+             */
+            args.vmsa_features = sev_common->sev_features &
+                                 ~SVM_SEV_FEAT_SNP_ACTIVE;
+        }
 
         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
         break;
@@ -2416,6 +2508,24 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        if ((cpu_index == 0) && (memory_type == CGS_PAGE_TYPE_VMSA)) {
+            const struct sev_es_save_area *sa =
+                (const struct sev_es_save_area *)ptr;
+            if (len < sizeof(*sa)) {
+                error_setg(errp, "%s: invalid VMSA length encountered",
+                           __func__);
+                return -1;
+            }
+            if (check_sev_features(sev_common, sa->sev_features, errp) < 0) {
+                return -1;
+            }
+            sev_common->sev_features = sa->sev_features;
+        }
+        return 0;
+    }
+
     if (!sev_enabled()) {
         error_setg(errp, "%s: attempt to configure guest memory, but SEV "
                      "is not enabled", __func__);
@@ -2435,7 +2545,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
                        __func__);
             return -1;
         }
-        if (check_vmsa_supported(gpa, (const struct sev_es_save_area *)ptr,
+        if (check_vmsa_supported(sev_common, gpa,
+                                 (const struct sev_es_save_area *)ptr,
                                  errp) < 0) {
             return -1;
         }
@@ -2492,6 +2603,12 @@ static int cgs_get_mem_map_entry(int index,
     struct e820_entry *table;
     int num_entries;
 
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 1;
+    }
+
     num_entries = e820_get_table(&table);
     if ((index < 0) || (index >= num_entries)) {
         return 1;
@@ -2523,6 +2640,12 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                                 uint32_t policy_data1_size, void *policy_data2,
                                 uint32_t policy_data2_size, Error **errp)
 {
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (sev_common->state == SEV_STATE_UNINIT) {
+        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
+        return 0;
+    }
+
     if (policy_type != GUEST_POLICY_SEV) {
         error_setg(errp, "%s: Invalid guest policy type provided for SEV: %d",
         __func__, policy_type);
-- 
2.50.0


