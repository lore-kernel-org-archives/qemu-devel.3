Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD4606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G29zavw6;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=muJQu+UX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMMb9-0004zS-Pu; Thu, 29 Oct 2026 05:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMb8-0004yU-NZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMb6-00079R-WC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793266739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0E+nBUT05eTM3l1EiviXbl6+Mza2XfiLiD9Gk2HdqHo=;
 b=G29zavw6WTrc/z4YtuYgoPgMhWo5EoKpieMS/X9gLupmjcyRPsYUdQLA6y4WF3Ar2GkWFg
 txw7J8StpdFpROvKnpTGuQcYvgZ/3yeJ76l7xPTVAps9sKzKzp4BkYbQjtAM2fbe7ugu33
 5bSaYGQrOHCM8GS53iAjHg3A/t4oTH0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-iypSlKf5OZawDNJiSSQhUA-1; Thu, 29 Oct 2026 05:38:49 -0400
X-MC-Unique: iypSlKf5OZawDNJiSSQhUA-1
X-Mimecast-MFC-AGG-ID: iypSlKf5OZawDNJiSSQhUA_1793266728
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a027f2e364so14295545e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793266728; x=1793871528; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0E+nBUT05eTM3l1EiviXbl6+Mza2XfiLiD9Gk2HdqHo=;
 b=muJQu+UXQtHOsBd1jPrbiU87q10i7i0IPvZNfPbxchgRLQHPTa51T9xVH+mgsQLZ2s
 9FQdlaeicv8qQOcVAti/ludZ1zaHrM8unwajeZULnr88iyZMsDWFv8mD1U4w0PHrTB8W
 eMPNXAKblcGLj9y5HM2r2oWm20gjRi2AAr0fuKP3APe2dHjQ0BGlz9I1MN4xIdZLRxoY
 ZnnqoXqeEZoFrbj0QtsU7WX41dsSWeg+YWlRS17eB1Ht1f2m5X3ByBbtNfXkvjdIcDFv
 qYruy/gs3z64kAeb5AlV4zTBNtaVsHfxY6BCdp0vKyvzLzpqrqmFBq0shRqLTk6jIMCH
 TpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793266728; x=1793871528;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0E+nBUT05eTM3l1EiviXbl6+Mza2XfiLiD9Gk2HdqHo=;
 b=l963ASwhHSI1p2do0Za/QGfd8lDonj+gH4Kjh1BKdeB1PrbjvyKggTd4ZzE3rc+td3
 d5VoxbfY0p0C88A3dgBcBQLmZsIGs7+kYhJIDTrEhH1wqaz0jrefHUFUWQtxOSGDoamF
 6o+NZxrKc2tWknRVTbX0qvB3tFbj8McBONB5xxUu2XOLV4IgTcDCnL19cOVr4KbZgL8w
 1cG7FpAnQzmT0AYKxLSOqBiDeBcnm+/2g8OmnFMuEVjS6WrM2A5LvZmgPH1tkDPB+ItT
 DB259BRFduUZbp/DsJ4jSPVR6Cw4Y5TYQImGeETtPnD+/MGAIedcpmfxAYFARAVwVJJB
 CHxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxG6wEjIUiCP1LN+LBMbxP1Wu5MPNzGey7A1Wr9PgV9dc2pcINmwRUjIFZrIFGgqnW0VB/Q1Bv8qG7s@nongnu.org
X-Gm-Message-State: AFq9FYLXHG2Ls1vXZ8ogW/qem3CF8Y/TLv41kTOS3RHlJVi4+bkQASeg
 5okKCXyakUDVlwR+4yadwb3VHGPuglMiLxUDr8NFWDAfcwN6pDkZzuO87af3xmkRH6nkPoXElv4
 aXhcmCVPtWVu26pS+vl3mtxnGXGDGNuBSUL5J9yFJVpk26MHa5e0csXVf
X-Gm-Gg: AYBFou3IAuShur97BZO4QY0Pb23Q60/DJRpBIoPLXwqN6JaaeFbHFcNOqyds/lZ6dx5
 5XTkcZrzRpMysENZ8aPcRcUJ2TYwp43JdMe2F1pv4B17d2zF5/tEvzTp+T8Cv6g7PqJrRe8dYDq
 MSMhRRHLu0I6vZqy3QRabz2oVDGnAcxIQra4Yy30mozgdBke++y1kftpQvkzeuO4RhbYtcm7h1b
 WDbRchiIvcen7mOFMmpr1fidL1I1vMpupahVehruktwSERblIjjZirxWkARu1qdsxjuDfH5o3v3
 GmouLIzWAl2lMbREW9ZbsFN/7p3jY7bqAbglUlHj8A/idYXpTjWXnP2zT08QBI90QUzBGWK9ynm
 YsV3fUbz8U0JVxbVdZrNzCyqNjcQh3Qfpug==
X-Received: by 2002:a05:600c:530d:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a966774cbemr103020515e9.22.1793266728053; 
 Thu, 29 Oct 2026 02:38:48 -0700 (PDT)
X-Received: by 2002:a05:600c:530d:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a966774cbemr103020065e9.22.1793266727697; 
 Thu, 29 Oct 2026 02:38:47 -0700 (PDT)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3c5bsm33929868f8f.9.2026.10.29.02.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:38:47 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:38:44 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn,
 harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, 
 farman@linux.ibm.com, cohuck@redhat.com, armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 5/9] target/arm/kvm: Pass an error handle to
 kvm_arm_create_scratch_host_vcpu
Message-ID: <4kr6kbmss3hfgrqngrahqbhk52cfr4kb2b5igvpknn3whbtfwr@anbbss4xhs6b>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-6-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029092307.281287-6-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric,

On Thu, Oct 29, 2026 at 10:20:17AM +0100, Eric Auger wrote:
> This allows to report a precise error message if any error occurs.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm_arm.h |  3 ++-
>  target/arm/kvm.c     | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index e7c40fb003..9c7e7f654a 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -105,6 +105,7 @@ struct kvm_vcpu_init;
>   * @init: filled in with the necessary values for creating a host
>   * vcpu. If NULL is provided, will not init the vCPU (though the cpufd
>   * will still be set up).
> + * @errp: Error handle
>   *
>   * Create a scratch vcpu in its own VM of the type preferred by the host
>   * kernel (as would be used for '-cpu host'), for purposes of probing it
> @@ -114,7 +115,7 @@ struct kvm_vcpu_init;
>   * false on failure (and fdarray and init are not valid).
>   */
>  bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
> -                                      struct kvm_vcpu_init *init);
> +                                      struct kvm_vcpu_init *init, Error **errp);
>  
>  /**
>   * kvm_arm_destroy_scratch_host_vcpu:
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 724bc08edf..28f199c03f 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -104,13 +104,14 @@ static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
>  }
>  
>  bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
> -                                      struct kvm_vcpu_init *init)
> +                                      struct kvm_vcpu_init *init, Error **errp)
>  {
>      int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
>      int max_vm_pa_size;
>  
>      kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
>      if (kvmfd < 0) {
> +        error_setg(errp, "Failed opening /dev/kvm");
>          goto err;
>      }
>      max_vm_pa_size = ioctl(kvmfd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_VM_IPA_SIZE);
> @@ -121,6 +122,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>          vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
>      } while (vmfd == -1 && errno == EINTR);
>      if (vmfd < 0) {
> +        error_setg(errp, "Failed creating the scratch VM");
>          goto err;
>      }
>  
> @@ -140,6 +142,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>  
>      cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
>      if (cpufd < 0) {
> +        error_setg(errp, "Failed creating the scratch VCPU");
>          goto err;
>      }
>  
> @@ -153,12 +156,14 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>  
>          ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
>          if (ret < 0) {
> +            error_setg(errp, "Failed getting the preferred target");
>              goto err;
>          }
>          init->target = preferred.target;
>      }
>      ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
>      if (ret < 0) {
> +        error_setg(errp, "Failed the init of the scratch vcpu");
>          goto err;
>      }
>  
> @@ -324,6 +329,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      bool el2_supported;
>      bool pmu_supported = false;
>      uint64_t features = 0;
> +    Error *local_err = NULL;
>      int err;
>  
>      ahcf->target = QEMU_KVM_ARM_TARGET_NONE;
> @@ -371,7 +377,8 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          features |= 1ULL << ARM_FEATURE_PMU;
>      }
>  
> -    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
> +    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init, &local_err)) {
> +        error_report_err(local_err);
>          return;
>      }
>  
> @@ -2653,8 +2660,10 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
>  void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
>  {
>      int fdarray[3];
> +    Error *local_err = NULL;
>  
> -    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
> +    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL, &local_err)) {
> +        error_report_err(local_err);
>          return;
>      }
>  
> -- 
> 2.53.0
> 
> 

Reviewed-by: Gustavo Romero <gromero@redhat.com>


Cheers,
Gustavo


