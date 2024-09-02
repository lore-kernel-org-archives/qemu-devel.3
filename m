Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DB0CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl7rd-0006xA-Gs; Mon, 02 Sep 2024 10:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7ra-0006wL-Ix
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl7rX-0004J5-Ke
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725286618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=02UA9YW9s0YSDyZl1FmIRfzYVimlGgQjDJCE8p1ZoSU=;
 b=GyWRSs/j/S/LNHIvIc2x9iQ2z0JCBXl2VCxLRhduK1g4zdY2r3rViIh58VK6M/0gtKNlgF
 rF6pPxmjs+i2UqA5Gdu0X4GgGkcsOlxr4nnKdBWVObCg6xbtd/OV3wWIO/326kEoCP3niG
 VisCG8U28j59SfTtKBVXjGxKzE+wbHg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-DIcRfm7XMBee7f3DHm4JiA-1; Mon, 02 Sep 2024 10:16:57 -0400
X-MC-Unique: DIcRfm7XMBee7f3DHm4JiA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42c7aa6c13cso17332935e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 07:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725286616; x=1725891416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02UA9YW9s0YSDyZl1FmIRfzYVimlGgQjDJCE8p1ZoSU=;
 b=oiZoL+yClQIGk4tcR50P+a81o0GYPRDNPjhyUYEbccxadjYqrUMXavJnnCXXXyAU1P
 j6a4A+gu6GMvpJmoN6MGP+hipfJFPjL0hevaT4gR5ooa46VKgK/OYeza6iaHehsB0IDp
 clEQ77on65TFyxiYQp+RsWEwGji4nPYKVlWX/J4A1dJZE8yBd9EBu3yhtAjrIOzB1VGA
 c9HDDB3eHhVvMsltMnpyaNtTOmGMg6b+eO/qvHxszBRXWF99Vgg7ArgW1qwgc6TU+ISB
 xhxDYwj9itFbj8yv/FhvlSuBkgpuCdpq7WRjA7y+xjnltqSyHGKVFvOM6v+rxy8RQPyh
 FNMA==
X-Gm-Message-State: AOJu0YwwUyPgLyMT8AdLsLrDoGdhv2IcDgZRiA4BKzMKpirX00jVmgO9
 VhfBngWgZUJyKLnw2Nb1fhUV9VFHv6PYjhtIh9T6NT5+YDm5EhXr50evhzU928roTVXOLSAEDVU
 q6QfczRF1GYI+vc7TrptiGwsegcECaUr1/X8H0SjypO41sZYZJ8QO
X-Received: by 2002:a05:600c:5489:b0:428:fb96:e94a with SMTP id
 5b1f17b1804b1-42bbb205603mr73920395e9.9.1725286615873; 
 Mon, 02 Sep 2024 07:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIJ0EF+rIQny35jyjmXeWKP3FBb0E6cKSlfeZkGFa93twH034U5ZxI/HeImmNnwEVdiKA5BA==
X-Received: by 2002:a05:600c:5489:b0:428:fb96:e94a with SMTP id
 5b1f17b1804b1-42bbb205603mr73919965e9.9.1725286614845; 
 Mon, 02 Sep 2024 07:16:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c71140bbsm4338172f8f.110.2024.09.02.07.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 07:16:53 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:16:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 06/16] sev: Update launch_update_data functions to use
 Error handling
Message-ID: <dmg4mj5y656jxttomut3pbxhbtoryajmqiofbx7ukqf4ubd2rz@wkougffcg5j5>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <afc57824b0ea3b8f83e1c850ba976e37989ae9d0.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afc57824b0ea3b8f83e1c850ba976e37989ae9d0.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Aug 13, 2024 at 04:01:08PM GMT, Roy Hopkins wrote:
>The class function and implementations for updating launch data return
>a code in case of error. In some cases an error message is generated and
>in other cases, just the error return value is used.
>
>This small refactor adds an 'Error **errp' parameter to all functions
>which consistently set an error condition if a non-zero value is
>returned.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> target/i386/sev.c | 68 +++++++++++++++++++++++------------------------
> 1 file changed, 33 insertions(+), 35 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/target/i386/sev.c b/target/i386/sev.c
>index a0d271f898..fab6d1bfb4 100644
>--- a/target/i386/sev.c
>+++ b/target/i386/sev.c
>@@ -121,7 +121,8 @@ struct SevCommonStateClass {
>                                        Error **errp);
>     int (*launch_start)(SevCommonState *sev_common);
>     void (*launch_finish)(SevCommonState *sev_common);
>-    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, size_t len);
>+    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa,
>+                              uint8_t *ptr, size_t len, Error **errp);
>     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
> };
>
>@@ -977,9 +978,8 @@ sev_snp_mask_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t
>     return value;
> }
>
>-static int
>-sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>-                       uint8_t *addr, size_t len)
>+static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>+                                  uint8_t *addr, size_t len, Error **errp)
> {
>     int ret, fw_error;
>     struct kvm_sev_launch_update_data update;
>@@ -994,8 +994,8 @@ sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
>                     &update, &fw_error);
>     if (ret) {
>-        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
>-                __func__, ret, fw_error, fw_error_to_str(fw_error));
>+        error_setg(errp, "%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'", __func__,
>+                   ret, fw_error, fw_error_to_str(fw_error));
>     }
>
>     return ret;
>@@ -1123,8 +1123,8 @@ sev_launch_finish(SevCommonState *sev_common)
>     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
> }
>
>-static int
>-snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
>+static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
>+                                  int type, Error **errp)
> {
>     SevLaunchUpdateData *data;
>
>@@ -1139,23 +1139,21 @@ snp_launch_update_data(uint64_t gpa, void *hva, size_t len, int type)
>     return 0;
> }
>
>-static int
>-sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>-                           uint8_t *ptr, size_t len)
>+static int sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>+                                      uint8_t *ptr, size_t len, Error **errp)
> {
>-       int ret = snp_launch_update_data(gpa, ptr, len,
>-                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
>-       return ret;
>+    return snp_launch_update_data(gpa, ptr, len,
>+                                     KVM_SEV_SNP_PAGE_TYPE_NORMAL, errp);
> }
>
> static int
> sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
>-                        const KvmCpuidInfo *kvm_cpuid_info)
>+                        const KvmCpuidInfo *kvm_cpuid_info, Error **errp)
> {
>     size_t i;
>
>     if (kvm_cpuid_info->cpuid.nent > SNP_CPUID_FUNCTION_MAXCOUNT) {
>-        error_report("SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
>+        error_setg(errp, "SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
>                      kvm_cpuid_info->cpuid.nent, SNP_CPUID_FUNCTION_MAXCOUNT);
>         return -1;
>     }
>@@ -1197,8 +1195,8 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
>     return 0;
> }
>
>-static int
>-snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
>+static int snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva,
>+                                   size_t cpuid_len, Error **errp)
> {
>     KvmCpuidInfo kvm_cpuid_info = {0};
>     SnpCpuidInfo snp_cpuid_info;
>@@ -1215,26 +1213,25 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, size_t cpuid_len)
>     } while (ret == -E2BIG);
>
>     if (ret) {
>-        error_report("SEV-SNP: unable to query CPUID values for CPU: '%s'",
>-                     strerror(-ret));
>-        return 1;
>+        error_setg(errp, "SEV-SNP: unable to query CPUID values for CPU: '%s'",
>+                   strerror(-ret));
>+        return -1;
>     }
>
>-    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
>-    if (ret) {
>-        error_report("SEV-SNP: failed to generate CPUID table information");
>-        return 1;
>+    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info, errp);
>+    if (ret < 0) {
>+        return -1;
>     }
>
>     memcpy(hva, &snp_cpuid_info, sizeof(snp_cpuid_info));
>
>     return snp_launch_update_data(cpuid_addr, hva, cpuid_len,
>-                                  KVM_SEV_SNP_PAGE_TYPE_CPUID);
>+                                  KVM_SEV_SNP_PAGE_TYPE_CPUID, errp);
> }
>
>-static int
>-snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
>-                                void *hva, uint32_t len)
>+static int snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp,
>+                                           uint32_t addr, void *hva,
>+                                           uint32_t len, Error **errp)
> {
>     int type = KVM_SEV_SNP_PAGE_TYPE_ZERO;
>     if (sev_snp->parent_obj.kernel_hashes) {
>@@ -1246,7 +1243,7 @@ snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
>                sizeof(*sev_snp->kernel_hashes_data));
>         type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
>     }
>-    return snp_launch_update_data(addr, hva, len, type);
>+    return snp_launch_update_data(addr, hva, len, type, errp);
> }
>
> static int
>@@ -1284,12 +1281,14 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
>         }
>
>         if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
>-            ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
>+            ret = snp_launch_update_cpuid(desc->base, hva, desc->len,
>+                                          &error_fatal);
>         } else if (desc->type == SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
>             ret = snp_launch_update_kernel_hashes(sev_snp, desc->base, hva,
>-                                                  desc->len);
>+                                                  desc->len, &error_fatal);
>         } else {
>-            ret = snp_launch_update_data(desc->base, hva, desc->len, type);
>+            ret = snp_launch_update_data(desc->base, hva, desc->len, type,
>+                                         &error_fatal);
>         }
>
>         if (ret) {
>@@ -1622,9 +1621,8 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
>     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
>         int ret;
>
>-        ret = klass->launch_update_data(sev_common, gpa, ptr, len);
>+        ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
>         if (ret < 0) {
>-            error_setg(errp, "SEV: Failed to encrypt pflash rom");
>             return ret;
>         }
>     }
>-- 
>2.43.0
>


