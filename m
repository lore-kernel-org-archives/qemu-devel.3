Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05557CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0Z3-0003XG-KT; Fri, 26 Jun 2026 03:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wd0Yo-0003VC-SX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:01:12 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wd0Yk-0002B7-Sh
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:01:10 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1947943542;
 Fri, 26 Jun 2026 07:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5BD1F000E9;
 Fri, 26 Jun 2026 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782457265;
 bh=szeRotyvEimU18kXIlP85IQIiHwJrKX00wBfdsC3Kt8=;
 h=From:To:Cc:Subject:Date;
 b=WfUyjmKv5QNyk2sqpRpJn1120FWgRifkg3yZyFipsmPEr9hXDlElNJr8ia5guM+w8
 1y2e/AiwAJtNL8qAYugEspOwwMpLn6Y9FwY3Dy/AIGZ4H13q1+p2gxg1ZxlnAs5Nvu
 mfJzPj55YNoKjDARXhTiGPeZR8sG1xl98V0LAmBqgd61HO2MG8W2jnEP2ZRq7lMNoP
 aaW3f8cFRSp4EWyv3G2vT3/NbUn16MyKo7915lbYuTbNtAP026azjUyMVGO7M38oeF
 3fuoNYoRfQUsTW6E6EOGkoJ0agPCxtsOqMws+qXAUsddzlmF03TLJqgRTJI2VdjaQL
 pNtTpeR3qd03A==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] target/i386: SEV: Remove use of __func__
Date: Fri, 26 Jun 2026 12:30:10 +0530
Message-ID: <20260626070010.1955433-1-naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Remove all usages of __func__ in target/i386/sev.c to align with the
general QEMU preference, and replace those with "SEV:" prefix.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
This depends on and needs to be applied on top of the Qemu VMSA features 
support patchset:
http://lore.kernel.org/r/cover.1779281646.git.naveen@kernel.org

- Naveen


 target/i386/sev.c | 156 +++++++++++++++++++++-------------------------
 1 file changed, 70 insertions(+), 86 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 851ae77517ac..1cafec2e2988 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -367,8 +367,8 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
     trace_kvm_memcrypt_register_region(host, max_size);
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
     if (r) {
-        error_report("%s: failed to register region (%p+%#zx) error '%s'",
-                     __func__, host, max_size, strerror(errno));
+        error_report("SEV: Failed to register region (%p+%#zx) error '%s'",
+                     host, max_size, strerror(errno));
         exit(1);
     }
 }
@@ -397,8 +397,8 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size,
     trace_kvm_memcrypt_unregister_region(host, max_size);
     r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range);
     if (r) {
-        error_report("%s: failed to unregister region (%p+%#zx)",
-                     __func__, host, max_size);
+        error_report("SEV: Failed to unregister region (%p+%#zx)",
+                     host, max_size);
     }
 }
 
@@ -522,44 +522,39 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
 {
     if (sev_features && !sev_es_enabled()) {
         error_setg(errp,
-                   "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
-                   __func__);
+                   "SEV: SEV features require either SEV-ES or SEV-SNP to be enabled");
         return -1;
     }
 
     if (sev_features & ~sev_common->supported_sev_features) {
         error_setg(errp,
-                   "%s: VMSA contains unsupported sev_features: %lX, "
+                   "SEV: VMSA contains unsupported sev_features: %lX, "
                    "supported features: %lX",
-                   __func__, sev_features, sev_common->supported_sev_features);
+                   sev_features, sev_common->supported_sev_features);
         return -1;
     }
 
     if (sev_snp_enabled()) {
         if (!(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
             error_setg(errp,
-                       "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
-                       __func__);
+                       "SEV: SEV_SNP is enabled but is not enabled in VMSA sev_features");
             return -1;
         }
         if (SEV_SNP_GUEST(sev_common)->tsc_khz &&
             !(sev_features & SVM_SEV_FEAT_SECURE_TSC)) {
             error_setg(errp,
-                       "%s: TSC frequency can only be set if Secure TSC is enabled",
-                       __func__);
+                       "SEV: TSC frequency can only be set if Secure TSC is enabled");
             return -1;
         }
     } else {
         if (sev_features && sev_es_enabled()) {
             error_setg(errp,
-                       "%s: SEV features are not supported with SEV-ES at this time",
-                       __func__);
+                       "SEV: SEV features are not supported with SEV-ES at this time");
             return -1;
         }
         if (sev_features & SVM_SEV_FEAT_SNP_ACTIVE) {
             error_setg(errp,
-                       "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
-                       __func__);
+                       "SEV: SEV_SNP is not enabled but is enabled in VMSA sev_features");
             return -1;
         }
     }
@@ -582,8 +577,8 @@ static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
      */
     if (gpa != KVM_VMSA_GPA) {
         error_setg(errp,
-                "%s: The VMSA GPA must be %lX but is specified as %lX",
-                __func__, KVM_VMSA_GPA, gpa);
+                "SEV: The VMSA GPA must be %lX but is specified as %lX",
+                KVM_VMSA_GPA, gpa);
         return -1;
     }
 
@@ -638,11 +633,10 @@ static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
 
     if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
         error_setg(errp,
-                "%s: The VMSA contains fields that are not "
+                "SEV: The VMSA contains fields that are not "
                 "synchronized with KVM. Continuing would result in "
                 "either unpredictable guest behavior, or a "
-                "mismatched launch measurement.",
-                __func__);
+                "mismatched launch measurement.");
         return -1;
     }
     return 0;
@@ -1119,8 +1113,8 @@ sev_snp_launch_start(SevCommonState *sev_common)
             rc = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, sev_snp_guest->tsc_khz);
         }
         if (rc < 0) {
-            error_report("%s: Unable to set Secure TSC frequency to %u kHz ret=%d",
-                         __func__, sev_snp_guest->tsc_khz, rc);
+            error_report("SEV: Unable to set Secure TSC frequency to %u kHz ret=%d",
+                         sev_snp_guest->tsc_khz, rc);
             return 1;
         }
     }
@@ -1128,8 +1122,8 @@ sev_snp_launch_start(SevCommonState *sev_common)
     rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
                    start, &fw_error);
     if (rc < 0) {
-        error_report("%s: SNP_LAUNCH_START ret=%d fw_error=%d '%s'",
-                __func__, rc, fw_error, fw_error_to_str(fw_error));
+        error_report("SEV: SNP_LAUNCH_START ret=%d fw_error=%d '%s'",
+                     rc, fw_error, fw_error_to_str(fw_error));
         return 1;
     }
 
@@ -1171,8 +1165,8 @@ sev_launch_start(SevCommonState *sev_common)
     trace_kvm_sev_launch_start(start.policy, session, dh_cert);
     rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_START, &start, &fw_error);
     if (rc < 0) {
-        error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_report("SEV: LAUNCH_START ret=%d fw_error=%d '%s'",
+                     ret, fw_error, fw_error_to_str(fw_error));
         goto out;
     }
 
@@ -1345,7 +1339,7 @@ static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
-        error_setg(errp, "%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'", __func__,
+        error_setg(errp, "SEV: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
                    ret, fw_error, fw_error_to_str(fw_error));
     }
 
@@ -1370,8 +1364,8 @@ sev_launch_update_vmsa(SevGuestState *sev_guest)
     ret = sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA,
                     NULL, &fw_error);
     if (ret) {
-        error_report("%s: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_report("SEV: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
+                     ret, fw_error, fw_error_to_str(fw_error));
     }
 
     return ret;
@@ -1403,8 +1397,8 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     &measurement, &error);
     if (!measurement.len) {
-        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(errno));
+        error_report("SEV: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(errno));
         return;
     }
 
@@ -1415,8 +1409,8 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     &measurement, &error);
     if (ret) {
-        error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(errno));
+        error_report("SEV: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(errno));
         return;
     }
 
@@ -1471,8 +1465,8 @@ sev_launch_finish(SevCommonState *sev_common)
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_FINISH, 0,
                     &error);
     if (ret) {
-        error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
-                     __func__, ret, error, fw_error_to_str(error));
+        error_report("SEV: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
+                     ret, error, fw_error_to_str(error));
         exit(1);
     }
 
@@ -1631,8 +1625,8 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
 
         hva = gpa2hva(&mr, desc->base, desc->len, NULL);
         if (!hva) {
-            error_report("%s: Failed to get HVA for GPA 0x%x sz 0x%x",
-                         __func__, desc->base, desc->len);
+            error_report("SEV: Failed to get HVA for GPA 0x%x sz 0x%x",
+                         desc->base, desc->len);
             exit(1);
         }
 
@@ -1648,8 +1642,8 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
         }
 
         if (ret) {
-            error_report("%s: Failed to add metadata page gpa 0x%x+%x type %d",
-                         __func__, desc->base, desc->len, desc->type);
+            error_report("SEV: Failed to add metadata page gpa 0x%x+%x type %d",
+                         desc->base, desc->len, desc->type);
             exit(1);
         }
     }
@@ -1678,7 +1672,7 @@ sev_snp_launch_finish(SevCommonState *sev_common)
          */
         metadata = pc_system_get_ovmf_sev_metadata_ptr();
         if (metadata == NULL) {
-            error_report("%s: Failed to locate SEV metadata header", __func__);
+            error_report("SEV: SNP_LAUNCH_FINISH failed to locate SEV metadata header");
             exit(1);
         }
 
@@ -1816,8 +1810,7 @@ static int sev_init_supported_features(ConfidentialGuestSupport *cgs,
         .addr = (unsigned long)&sev_common->supported_sev_features,
     };
     if (kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr) < 0) {
-        error_setg(errp, "%s: failed to query supported sev_features",
-                   __func__);
+        error_setg(errp, "SEV: failed to query supported sev_features");
         return -1;
     }
     if (sev_snp_enabled()) {
@@ -1855,8 +1848,8 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      * comparison against the host value accomplishes that.
      */
     if (host_cbitpos != sev_common->cbitpos) {
-        error_setg(errp, "%s: cbitpos check failed, host '%d' requested '%d'",
-                   __func__, host_cbitpos, sev_common->cbitpos);
+        error_setg(errp, "SEV: cbitpos check failed, host '%d' requested '%d'",
+                   host_cbitpos, sev_common->cbitpos);
         return -1;
     }
 
@@ -1867,9 +1860,9 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      */
     if (sev_common->reduced_phys_bits < 1 ||
         sev_common->reduced_phys_bits > 63) {
-        error_setg(errp, "%s: reduced_phys_bits check failed,"
+        error_setg(errp, "SEV: reduced_phys_bits check failed,"
                    " it should be in the range of 1 to 63, requested '%d'",
-                   __func__, sev_common->reduced_phys_bits);
+                   sev_common->reduced_phys_bits);
         return -1;
     }
 
@@ -1885,8 +1878,8 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     ret = sev_platform_ioctl(sev_common->sev_fd, SEV_PLATFORM_STATUS, &status,
                              &fw_error);
     if (ret) {
-        error_setg(errp, "%s: failed to get platform status ret=%d "
-                   "fw_error='%d: %s'", __func__, ret, fw_error,
+        error_setg(errp, "SEV: failed to get platform status ret=%d "
+                   "fw_error='%d: %s'", ret, fw_error,
                    fw_error_to_str(fw_error));
         return -1;
     }
@@ -1896,17 +1889,15 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     if (sev_es_enabled()) {
         if (!kvm_kernel_irqchip_allowed()) {
-            error_setg(errp, "%s: SEV-ES guests require in-kernel irqchip"
-                       "support", __func__);
+            error_setg(errp, "SEV: SEV-ES guests require in-kernel irqchip support");
             return -1;
         }
     }
 
     if (sev_es_enabled() && !sev_snp_enabled()) {
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
-            error_setg(errp, "%s: guest policy requires SEV-ES, but "
-                         "host SEV-ES support unavailable",
-                         __func__);
+            error_setg(errp, "SEV: guest policy requires SEV-ES, but "
+                             "host SEV-ES support unavailable");
             return -1;
         }
     }
@@ -1953,8 +1944,8 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
              */
             if (sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE) {
                 error_setg(errp,
-                           "%s: SEV features 0x%lx can't be specified when using IGVM files",
-                           __func__, sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE);
+                           "SEV: SEV features 0x%lx can't be specified when using IGVM files",
+                           sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE);
                 return -1;
             }
             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
@@ -1978,21 +1969,20 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         break;
     }
     default:
-        error_setg(errp, "%s: host kernel does not support the requested SEV configuration.",
-                   __func__);
+        error_setg(errp, "SEV: host kernel does not support the requested SEV configuration.");
         return -1;
     }
 
     if (ret) {
-        error_setg(errp, "%s: failed to initialize ret=%d fw_error=%d '%s'",
-                   __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_setg(errp, "SEV: failed to initialize ret=%d fw_error=%d '%s'",
+                   ret, fw_error, fw_error_to_str(fw_error));
         return -1;
     }
 
     ret = klass->launch_start(sev_common);
 
     if (ret) {
-        error_setg(errp, "%s: failed to create encryption context", __func__);
+        error_setg(errp, "SEV: failed to create encryption context");
         return -1;
     }
 
@@ -2020,7 +2010,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      */
     ret = ram_block_discard_disable(true);
     if (ret) {
-        error_setg(errp, "%s: cannot disable RAM discard", __func__);
+        error_setg(errp, "SEV: cannot disable RAM discard");
         return -1;
     }
 
@@ -2624,8 +2614,7 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
             const struct sev_es_save_area *sa =
                 (const struct sev_es_save_area *)ptr;
             if (len < sizeof(*sa)) {
-                error_setg(errp, "%s: invalid VMSA length encountered",
-                           __func__);
+                error_setg(errp, "SEV: invalid VMSA length encountered");
                 return -1;
             }
             sev_common->sev_features = sa->sev_features;
@@ -2634,8 +2623,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     }
 
     if (!sev_enabled()) {
-        error_setg(errp, "%s: attempt to configure guest memory, but SEV "
-                     "is not enabled", __func__);
+        error_setg(errp, "SEV: attempt to configure guest memory, but SEV "
+                         "is not enabled");
         return -1;
     }
 
@@ -2647,9 +2636,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     case CGS_PAGE_TYPE_VMSA:
         if (!sev_es_enabled()) {
             error_setg(errp,
-                       "%s: attempt to configure initial VMSA, but SEV-ES "
-                       "is not supported",
-                       __func__);
+                       "SEV: attempt to configure initial VMSA, but SEV-ES "
+                       "is not supported");
             return -1;
         }
         if (check_vmsa_supported(sev_common, gpa,
@@ -2670,9 +2658,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     case CGS_PAGE_TYPE_SECRETS:
         if (!sev_snp_enabled()) {
             error_setg(errp,
-                       "%s: attempt to configure secrets page, but SEV-SNP "
-                       "is not supported",
-                       __func__);
+                       "SEV: attempt to configure secrets page, but SEV-SNP "
+                       "is not supported");
             return -1;
         }
         return snp_launch_update_data(gpa, ptr, len,
@@ -2682,8 +2669,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
         if (kvm_convert_memory(gpa, len, true) < 0) {
             error_setg(
                 errp,
-                "%s: failed to configure required memory. gpa: %lX, type: %d",
-                __func__, gpa, memory_type);
+                "SEV: failed to configure required memory. gpa: %lX, type: %d",
+                gpa, memory_type);
             return -1;
         }
         return 0;
@@ -2691,14 +2678,13 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     case CGS_PAGE_TYPE_CPUID:
         if (!sev_snp_enabled()) {
             error_setg(errp,
-                       "%s: attempt to configure CPUID page, but SEV-SNP "
-                       "is not supported",
-                       __func__);
+                       "SEV: attempt to configure CPUID page, but SEV-SNP "
+                       "is not supported");
             return -1;
         }
         return snp_launch_update_cpuid(gpa, ptr, len, errp);
     }
-    error_setg(errp, "%s: failed to update guest. gpa: %lX, type: %d", __func__,
+    error_setg(errp, "SEV: failed to update guest. gpa: %lX, type: %d",
                gpa, memory_type);
     return -1;
 }
@@ -2754,8 +2740,8 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
     }
 
     if (policy_type != GUEST_POLICY_SEV) {
-        error_setg(errp, "%s: Invalid guest policy type provided for SEV: %d",
-        __func__, policy_type);
+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
+                   policy_type);
         return -1;
     }
     /*
@@ -2788,14 +2774,12 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                 (struct sev_snp_id_authentication *)policy_data2;
 
             if (policy_data1_size != KVM_SEV_SNP_ID_BLOCK_SIZE) {
-                error_setg(errp, "%s: Invalid SEV-SNP ID block: incorrect size",
-                           __func__);
+                error_setg(errp, "SEV: Invalid SEV-SNP ID block: incorrect size");
                 return -1;
             }
             if (policy_data2_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
                 error_setg(errp,
-                           "%s: Invalid SEV-SNP ID auth block: incorrect size",
-                           __func__);
+                           "SEV: Invalid SEV-SNP ID auth block: incorrect size");
                 return -1;
             }
             assert(policy_data1 != NULL);
@@ -2825,8 +2809,8 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
         SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
         /* Only the policy flags are supported for SEV and SEV-ES */
         if ((policy_data1_size > 0) || (policy_data2_size > 0) || !sev_guest) {
-            error_setg(errp, "%s: An ID block/ID auth block has been provided "
-                             "but SEV-SNP is not enabled", __func__);
+            error_setg(errp, "SEV: An ID block/ID auth block has been provided "
+                             "but SEV-SNP is not enabled");
             return -1;
         }
 

base-commit: 60533c6193ede6ce403e82d09d82ae2bc8fb423a
-- 2.54.0


