Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A75AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH7n-0001Lb-N1; Mon, 14 Jul 2025 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzj-0000v0-8M
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzh-0001rM-0A
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1zRIxJCsznxtyS9znCCBC+gfuFhyW4LFEi/wN9lZzI=;
 b=LwmFHHh93oLxLfEXV7g8BNfFSCqyky+X0ieJz42PdVMw0de57/eRjaMR1wjNEEsFRGukc+
 kVWFxn+6jvn/OsdIq3c7fESGd9p/nsemqQEDWlgVDydbVx7M3mek3UIfGOzfudwXR82Cvr
 vSKIcZbXcllgkVeAOhrhTZGYonLKorc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-D4ws0uBNNtSb-bKSiBo8PA-1; Mon, 14 Jul 2025 07:05:11 -0400
X-MC-Unique: D4ws0uBNNtSb-bKSiBo8PA-1
X-Mimecast-MFC-AGG-ID: D4ws0uBNNtSb-bKSiBo8PA_1752491110
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b604541741so499930f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491109; x=1753095909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1zRIxJCsznxtyS9znCCBC+gfuFhyW4LFEi/wN9lZzI=;
 b=OVJqEpc8pi2pZJSlcRtYCKbzhEMuiNa+qar+QusrJ+mqS4Ez2HiczNq64Fy05Gs2cE
 Y8r9JABT8omFmT9PL/FrEy4mx+cRfY0Wy/g8a5HuhxhDoxXSYOu8y4uYVCJI6lzTJDrw
 UxYKgZRhggzsiyOHIbV1p3oDa+qnhZ5Qj+auDEg3KF8zFB+UkEP23+AMrp8gCifblA++
 nuEo2cY9fHFrOGwntrojh/HTBNTYuHZDVGlJFZTozORP20D6rBhfWY4XsGx9E4jOOGdS
 6/JNqdeuuwVofhnUIAqutr59asfUVr7fgfTRqBKg5XZFzTq4rC1P8AcD8Clhi+FMYgIu
 1VAg==
X-Gm-Message-State: AOJu0YzNoiIdDDWnOwxFQw3XjHoaHmRVKxohWMiaE8BeW4KxsP9Fl1Z1
 v+H9POFhcb7BWzdHv91sQZHdWCEY3EXua1X4TvbFf2O7DBlrzr+Lhh8PW9f6QRXc6FRRCkx0XKF
 gJklIA3GJsIQQyEDjfqjHa/eYHU3aWE67A5mmBrUHIPKzwpTm9PlOTSL4mOxEGLBeIgP8GTVqS7
 Iwz74sbE3UqvHxz2ZOvJoRy47daLvHQgjr53BctfdY
X-Gm-Gg: ASbGncuBVFJEKvPNZTh/XEOtG2PejxUfXG1hrmvlShsNo4TjYoENAvb3DFwZz9wfMG0
 nk4hnpUvDjjlivev0MOtbe4iR+FF2fWsul0cvXJciPK9XaxAfTScZQ+5FkEonOoP+7o+1nBY6g4
 4M6s7aHVuj8qlJWbKbZ7YPbag6ajBe0tD2+I6EKVw3UD/OHhHljBZ44691U56AIOhQ8nJAXC0vE
 SKteBnNaKlyvo2sRuGy8oEp7oyfmEzNZ0/X7GmVrN98lVtW7ZK/2ZCCKpf0zdW2gvxcbuGptXDi
 KIIkERfaU6ghUHgrwmXZKXKuLGuNPg8xJaxNI0cquEM=
X-Received: by 2002:a05:6000:2dc7:b0:3a6:e6c3:6d95 with SMTP id
 ffacd0b85a97d-3b5f2e30860mr8304245f8f.41.1752491109278; 
 Mon, 14 Jul 2025 04:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw8JV9OsS+X6Cp+i2tew61q3Am7jsfxCLTvrOc4Qi7cUeLlpTVSA4jFdk5nvAtjnf0aCkPlw==
X-Received: by 2002:a05:6000:2dc7:b0:3a6:e6c3:6d95 with SMTP id
 ffacd0b85a97d-3b5f2e30860mr8304204f8f.41.1752491108625; 
 Mon, 14 Jul 2025 04:05:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1a2bsm12330348f8f.14.2025.07.14.04.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 22/77] sev: Update launch_update_data functions to use Error
 handling
Date: Mon, 14 Jul 2025 13:03:11 +0200
Message-ID: <20250714110406.117772-23-pbonzini@redhat.com>
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

The class function and implementations for updating launch data return
a code in case of error. In some cases an error message is generated and
in other cases, just the error return value is used.

This small refactor adds an 'Error **errp' parameter to all functions
which consistently set an error condition if a non-zero value is
returned.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/d59721f7b99cfc87aab71f8f551937e98e983615.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 68 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1a12f0671cc..a84f5f5d28a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -122,7 +122,8 @@ struct SevCommonStateClass {
                                        Error **errp);
     int (*launch_start)(SevCommonState *sev_common);
     void (*launch_finish)(SevCommonState *sev_common);
-    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, size_t len);
+    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa,
+                              uint8_t *ptr, size_t len, Error **errp);
     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
 };
 
@@ -970,9 +971,8 @@ sev_snp_adjust_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32
     return value;
 }
 
-static int
-sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
-                       uint8_t *addr, size_t len)
+static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                                  uint8_t *addr, size_t len, Error **errp)
 {
     int ret, fw_error;
     struct kvm_sev_launch_update_data update;
@@ -987,8 +987,8 @@ sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
-        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_setg(errp, "%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'", __func__,
+                   ret, fw_error, fw_error_to_str(fw_error));
     }
 
     return ret;
@@ -1116,8 +1116,8 @@ sev_launch_finish(SevCommonState *sev_common)
     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
-static int
-snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
+static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
+                                  int type, Error **errp)
 {
     SevLaunchUpdateData *data;
 
@@ -1132,23 +1132,21 @@ snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
     return 0;
 }
 
-static int
-sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
-                           uint8_t *ptr, size_t len)
+static int sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                                      uint8_t *ptr, size_t len, Error **errp)
 {
-       int ret = snp_launch_update_data(gpa, ptr, len,
-                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
-       return ret;
+    return snp_launch_update_data(gpa, ptr, len,
+                                     KVM_SEV_SNP_PAGE_TYPE_NORMAL, errp);
 }
 
 static int
 sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
-                        const KvmCpuidInfo *kvm_cpuid_info)
+                        const KvmCpuidInfo *kvm_cpuid_info, Error **errp)
 {
     size_t i;
 
     if (kvm_cpuid_info->cpuid.nent > SNP_CPUID_FUNCTION_MAXCOUNT) {
-        error_report("SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
+        error_setg(errp, "SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
                      kvm_cpuid_info->cpuid.nent, SNP_CPUID_FUNCTION_MAXCOUNT);
         return -1;
     }
@@ -1190,8 +1188,8 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
     return 0;
 }
 
-static int
-snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
+static int snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva,
+                                   size_t cpuid_len, Error **errp)
 {
     KvmCpuidInfo kvm_cpuid_info = {0};
     SnpCpuidInfo snp_cpuid_info;
@@ -1208,26 +1206,25 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
     } while (ret == -E2BIG);
 
     if (ret) {
-        error_report("SEV-SNP: unable to query CPUID values for CPU: '%s'",
-                     strerror(-ret));
-        return 1;
+        error_setg(errp, "SEV-SNP: unable to query CPUID values for CPU: '%s'",
+                   strerror(-ret));
+        return -1;
     }
 
-    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
-    if (ret) {
-        error_report("SEV-SNP: failed to generate CPUID table information");
-        return 1;
+    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info, errp);
+    if (ret < 0) {
+        return -1;
     }
 
     memcpy(hva, &snp_cpuid_info, sizeof(snp_cpuid_info));
 
     return snp_launch_update_data(cpuid_addr, hva, cpuid_len,
-                                  KVM_SEV_SNP_PAGE_TYPE_CPUID);
+                                  KVM_SEV_SNP_PAGE_TYPE_CPUID, errp);
 }
 
-static int
-snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
-                                void *hva, uint32_t len)
+static int snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp,
+                                           uint32_t addr, void *hva,
+                                           uint32_t len, Error **errp)
 {
     int type = KVM_SEV_SNP_PAGE_TYPE_ZERO;
     if (sev_snp->parent_obj.kernel_hashes) {
@@ -1239,7 +1236,7 @@ snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
                sizeof(*sev_snp->kernel_hashes_data));
         type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
     }
-    return snp_launch_update_data(addr, hva, len, type);
+    return snp_launch_update_data(addr, hva, len, type, errp);
 }
 
 static int
@@ -1277,12 +1274,14 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
         }
 
         if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
-            ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
+            ret = snp_launch_update_cpuid(desc->base, hva, desc->len,
+                                          &error_fatal);
         } else if (desc->type == SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
             ret = snp_launch_update_kernel_hashes(sev_snp, desc->base, hva,
-                                                  desc->len);
+                                                  desc->len, &error_fatal);
         } else {
-            ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+            ret = snp_launch_update_data(desc->base, hva, desc->len, type,
+                                         &error_fatal);
         }
 
         if (ret) {
@@ -1615,9 +1614,8 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
         int ret;
 
-        ret = klass->launch_update_data(sev_common, gpa, ptr, len);
+        ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
         if (ret < 0) {
-            error_setg(errp, "SEV: Failed to encrypt pflash rom");
             return ret;
         }
     }
-- 
2.50.0


