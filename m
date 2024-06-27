Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFF2C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoY6-0001wJ-NY; Thu, 27 Jun 2024 08:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sMoY4-0001wB-S2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sMoY2-0001Bg-V3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0uiEn3o+B6SVZl38Y2WCys9sSApz2THSbMXnoBBN4U=;
 b=NCQuYF7wFvFwaUVgtNd0iAOL+nqyXCcnq3EDv+vR3U14teFm4GaFr+hlvNFJZSdDASDj7d
 YpIQEdvZ+/7tk3GXKFZwQjFWb4+DQqMcXzWvG9ZXy6a2WqNMyo6jlUy+WRqgxf9eXeDYp9
 WOeij1D2Qx9KYuEecbz9gm0308sQrJg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-jAsn8WdWMkeM4sKPEUGFvA-1; Thu, 27 Jun 2024 08:48:17 -0400
X-MC-Unique: jAsn8WdWMkeM4sKPEUGFvA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57c6e28b151so895595a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492495; x=1720097295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0uiEn3o+B6SVZl38Y2WCys9sSApz2THSbMXnoBBN4U=;
 b=cJLW2T2vtCegEbPnR+HYtu7brQqx8CgOt3hHFnD3Bw2tfQQzH4qoSWhzGwFsSjIPTl
 BFFFAYRAxbZvc9POPZx2b6lRe8YdD1NWNc4sIne/TKTBx8j711lyDq67OPr6FhipWdfY
 WWv3yQaobCj3CcCFlsIZcFwXoiDs7dJkhiOQcaZ3gQb+VN1F1afq7GEngmA/4pfC8qqZ
 8PyvJFHMk/AMrt++ff1beXpzaPIAZeoF/3KVzN6swr8ypIa7EsGeoUr96g7V9s9BBkGH
 KO9oENNXniv7pp4nFgcF4IeGpkiDKxW9d8KdFZqZ6xRn1Oxyrpnl6rKTDdtoFpqH1VWH
 106Q==
X-Gm-Message-State: AOJu0Yzvootg970Gp88MBo5VRoTJZ1EEV+/kDatxyQmbGn+Iq9Np3004
 yjP+uFPENUbMAoje4hgwWmrxwu0AUR5CqHKyh6FzPN5kYUY9LbDY1L6uotGoEtxiEgc4ZgR378P
 MLW7mAZV5Qmc+j98TTVdaMTM0sExOO2aAvqtK190cG0UQ23mg3q2Q
X-Received: by 2002:a50:9555:0:b0:57d:4cbc:cb59 with SMTP id
 4fb4d7f45d1cf-57d4cbccbf9mr9504884a12.25.1719492494757; 
 Thu, 27 Jun 2024 05:48:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlo2vEJVbsp8Jn6sqkl/k5/AeuTvTSeEzt1pRxu5HIc5mYyE92BXUZ/wU2WCuKLzoiROd2JQ==
X-Received: by 2002:a50:9555:0:b0:57d:4cbc:cb59 with SMTP id
 4fb4d7f45d1cf-57d4cbccbf9mr9504854a12.25.1719492494084; 
 Thu, 27 Jun 2024 05:48:14 -0700 (PDT)
Received: from sgarzare-redhat (83.0.40.93.internetdsl.tpnet.pl. [83.0.40.93])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-584d0c9dbf1sm833687a12.19.2024.06.27.05.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:48:13 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:48:07 +0200
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
Subject: Re: [PATCH v3 06/15] sev: Update launch_update_data functions to use
 Error handling
Message-ID: <bzb476tm3o7wtv6onru7uvhgs4y53yx3minxsbrgkwnflkfjn2@5avs7xnn5no5>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <cac4ababee3bfed7658a501d5d5810379ac90512.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cac4ababee3bfed7658a501d5d5810379ac90512.1718979106.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

On Fri, Jun 21, 2024 at 03:29:09PM GMT, Roy Hopkins wrote:
>The class function and implementations for updating launch data return
>a code in case of error. In some cases an error message is generated and
>in other cases, just the error return value is used.
>
>This small refactor adds an 'Error **errp' parameter to all functions
>which consistently set an error condition if a non-zero value is
>returned.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>---
> target/i386/sev.c | 67 +++++++++++++++++++++++++----------------------
> 1 file changed, 35 insertions(+), 32 deletions(-)
>
>diff --git a/target/i386/sev.c b/target/i386/sev.c
>index 30b83f1d77..1900c3d9b4 100644
>--- a/target/i386/sev.c
>+++ b/target/i386/sev.c
>@@ -121,7 +121,8 @@ struct SevCommonStateClass {
>                                        Error **errp);
>     int (*launch_start)(SevCommonState *sev_common);
>     void (*launch_finish)(SevCommonState *sev_common);
>-    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, uint64_t len);
>+    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa,
>+                              uint8_t *ptr, uint64_t len, Error **errp);
>     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
> };
>
>@@ -942,14 +943,17 @@ out:
>     return ret;
> }
>
>-static int
>-sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa, uint8_t *addr, uint64_t len)
>+static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>+                                  uint8_t *addr, uint64_t len, Error **errp)
> {
>     int ret, fw_error;
>     struct kvm_sev_launch_update_data update;
>
>     if (!addr || !len) {
>-        return 1;

Why were we returning 1 before? Was that a mistake?
Maybe we should mention it in the patch or fix it in another patch.

>+        error_setg(errp,
>+                   "%s: Invalid parameters provided for updating 
>launch data.",
>+                   __func__);
>+        return -1;
>     }
>
>     update.uaddr = (uintptr_t)addr;
>@@ -958,8 +962,8 @@ sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa, uint8_t *addr, ui
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
>@@ -1087,9 +1091,8 @@ sev_launch_finish(SevCommonState *sev_common)
>     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
> }
>
>-static int
>-snp_launch_update_data(uint64_t gpa, void *hva,
>-                       uint32_t len, int type)
>+static int snp_launch_update_data(uint64_t gpa, void *hva, uint32_t len,
>+                                  int type, Error **errp)
> {
>     SevLaunchUpdateData *data;
>
>@@ -1104,13 +1107,12 @@ snp_launch_update_data(uint64_t gpa, void *hva,
>     return 0;
> }
>
>-static int
>-sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>-                           uint8_t *ptr, uint64_t len)
>+static int sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>+                                      uint8_t *ptr, uint64_t len, Error **errp)
> {
>-       int ret = snp_launch_update_data(gpa, ptr, len,
>-                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
>-       return ret;
>+    int ret = snp_launch_update_data(gpa, ptr, len,
>+                                     KVM_SEV_SNP_PAGE_TYPE_NORMAL, errp);
>+    return ret;

Pre-existing, but while we're at it maybe we can remove ret.

> }
>
> static int
>@@ -1162,8 +1164,8 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
>     return 0;
> }
>
>-static int
>-snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
>+static int snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva,
>+                                   uint32_t cpuid_len, Error **errp)
> {
>     KvmCpuidInfo kvm_cpuid_info = {0};
>     SnpCpuidInfo snp_cpuid_info;
>@@ -1180,26 +1182,26 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
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
>     ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
>     if (ret) {
>-        error_report("SEV-SNP: failed to generate CPUID table information");
>-        return 1;
>+        error_setg(errp, "SEV-SNP: failed to generate CPUID table information");
>+        return -1;

Ditto for the 2 changes, although IIUC we never check the return value 
of snp_launch_update_cpuid().

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
>@@ -1211,7 +1213,7 @@ snp_launch_update_kernel_hashes(SevSnpGuestState 
>*sev_snp, uint32_t addr,
>                sizeof(*sev_snp->kernel_hashes_data));
>         type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
>     }
>-    return snp_launch_update_data(addr, hva, len, type);
>+    return snp_launch_update_data(addr, hva, len, type, errp);
> }
>
> static int
>@@ -1249,12 +1251,14 @@ snp_populate_metadata_pages(SevSnpGuestState 
>*sev_snp,
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
>@@ -1541,9 +1545,8 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
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


