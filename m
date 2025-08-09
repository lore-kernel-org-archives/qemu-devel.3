Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99768C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 16:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukmJy-0000c8-1r; Sat, 09 Aug 2025 12:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ukmJr-0000Y0-Hq
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 12:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ukmJo-00012z-Gr
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 12:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754756475;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIb/1x9wab93LRAYun4ef/Ot7rHxyE1dkyauGVJlBog=;
 b=OvLUCI11hMN+MzFM2oaMb7rgl0Q7ibonbfKIeKCX6HjIs8BqlMfr0oGmJk1SsBbZqBzYon
 lgQ2NlxEqCT0oNdhonwNL/pxN4DcIs3MbxGf1TY39Kmis5eFzS2jzOEacqx9/m4K68SbXa
 OJx5t8L5w+6lSbLrjse6JZOJJovfGko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-poPF5hOPO2eIcA3mXikOSw-1; Sat, 09 Aug 2025 12:21:14 -0400
X-MC-Unique: poPF5hOPO2eIcA3mXikOSw-1
X-Mimecast-MFC-AGG-ID: poPF5hOPO2eIcA3mXikOSw_1754756473
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-459de8f00cfso12423315e9.2
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 09:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754756473; x=1755361273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rIb/1x9wab93LRAYun4ef/Ot7rHxyE1dkyauGVJlBog=;
 b=VcyC1wbGpRytLrfg2VHNJlmdBphpdNgAvttKfkhmWxj+7S7q/dlJ7TCA4XNum2mzYg
 WP1Dx8VMEfT+Okx6kBhROfc0h1oNKMsE428lLF9+bzqu92KsxzJ+9pA/JTNMSyL9OgSB
 SzvqfK4MMLJZNo8CTE73dwxJQB4pkbUz/J3ZuK7GYlFIAnQLFrcsNeKLg7lImiLYc5tD
 nCJw5lyqZ/sayI/Wu2K703h0imtaDMsxT42+B4r8pv6UcmIpR7gBMTUH25L1amBThmQT
 zVPJ/4MksheW4AET99M4HniUeTms224VWYAL0c3WhrESbpCtdClpOKjmF904bALG7UKP
 afcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU05NjcFdMHbgos5S08dPpyPGzt7W+UbwZaygrI2ozSnkgKsNc4nQepCvOLizRgj9mF4uOUaXhJpSmA@nongnu.org
X-Gm-Message-State: AOJu0YwwkcjBkFas+31NbCbmwWqR1Y2y6zz1UFeGwttqxFGQTsH7NEwb
 SiW1RuOzQSqUMjXKQxJLXUEkaS6+Yb5pPGRCQGcBIyVoUFVQY54vQj+RfiBs5FQSNnOCcinQL3d
 30c5PrnliCZ+rnJQnshiM/H95iv5XpYUStSTLmX9yPAtQsYj7fcSQ7Eti
X-Gm-Gg: ASbGncuWLMNDRMq5bxwcgsLPzfFO/rkeu1BWXsTtweO78itOP79c/zjnTjkvjCthRXb
 ivWFZwXi94Ccu4eghGovytfXQqfVK7ExAvuefzzXxKIlJ0mZ0pDtI3RyVDC7dpMGd4/jTAbnyZN
 u3XhwnUdocRVLRiKgJIdKjIky8rvd7twK07BVOi+MTGoMCer2894iIe2AR9bAeHu+6FOm8hjht/
 TOSfFj9q7PMq5wg8NfQwqS3UbW69AAvB3jga5LNCPW/xk5Ki/CZQwEvgLB32Nz+XP4oMcFy810b
 MTD255CWLBKo3Axnh1gO3uhhKVuKmYmuNM6CU5N3tbO/2AcYEdsnNytm41AMtDRIXNdDSilj8rM
 pTr7ttBfvycM=
X-Received: by 2002:a05:600c:4451:b0:456:285b:db29 with SMTP id
 5b1f17b1804b1-459f4f43b3fmr56081255e9.29.1754756472821; 
 Sat, 09 Aug 2025 09:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh6Pdlzjr/YrQmyHXyHDs5AqT3UN7gNZwT+k3XU97Hxufb1cq2Hq/ChRdYwKZiX0ZkIJf5Ag==
X-Received: by 2002:a05:600c:4451:b0:456:285b:db29 with SMTP id
 5b1f17b1804b1-459f4f43b3fmr56081035e9.29.1754756472449; 
 Sat, 09 Aug 2025 09:21:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586ad64sm179096065e9.20.2025.08.09.09.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 09:21:11 -0700 (PDT)
Message-ID: <5c29e11f-eac1-40a0-aec0-a80131f7de56@redhat.com>
Date: Sat, 9 Aug 2025 18:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 1/4] target/arm/kvm: Introduce helper to check
 target impl CPU support
Content-Language: en-US
To: Shameer Kolothum <shameerkolothum@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 berrange@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
 armbru@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, salil.mehta@huawei.com,
 yangjinqian1@huawei.com, shameerali.kolothum.thodi@huawei.com
References: <20250801074730.28329-1-shameerkolothum@gmail.com>
 <20250801074730.28329-2-shameerkolothum@gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250801074730.28329-2-shameerkolothum@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 8/1/25 9:47 AM, Shameer Kolothum wrote:
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>
> The helper function will try to set the SMCCC filters for KVM vendor
> hypercalls related to target implementation CPU support. It also
> checks the kernel support for writable implementation ID registers
> (MIDR/REVIDR/AIDR) and enables it.
>
> Subsequent patches for Target Impl CPU support will make use of this
> helper.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  target/arm/kvm.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h | 12 ++++++++
>  2 files changed, 84 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 3f41f99e23..eb04640b50 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2072,6 +2072,78 @@ bool kvm_arm_mte_supported(void)
>      return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
>  }
>  
> +static bool kvm_arm_set_vm_attr(struct kvm_device_attr *attr, const char *name)
> +{
> +    int err;
> +
> +    err = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, attr);
> +    if (err != 0) {
> +        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
> +        return false;
> +    }
> +
> +    err = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, attr);
> +    if (err != 0) {
> +        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
nit: base is _u32 in the kernel
> +{
> +    struct kvm_smccc_filter filter = {
> +        .base = func,
> +        .nr_functions = 1,
> +        .action = faction,
> +    };
> +    struct kvm_device_attr attr = {
> +        .group = KVM_ARM_VM_SMCCC_CTRL,
> +        .attr = KVM_ARM_VM_SMCCC_FILTER,
> +        .flags = 0,
> +        .addr = (uintptr_t)&filter,
> +    };
> +
> +    if (!kvm_arm_set_vm_attr(&attr, "SMCCC Filter")) {
> +        error_report("failed to set SMCCC filter in KVM Host");
maybe also output @func in the error msg
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +bool kvm_arm_target_impl_cpus_supported(void)
> +{
> +    if (!kvm_arm_set_smccc_filter(
> +        ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID,
> +        KVM_SMCCC_FILTER_FWD_TO_USER)) {
> +        error_report("ARM_SMCCC_KVM_FUNC_DISCOVER_IMPL_VER fwd filter "
> +                     "install failed");
> +        return false;
> +    }
> +
> +    if (!kvm_arm_set_smccc_filter(
> +        ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID,
> +        KVM_SMCCC_FILTER_FWD_TO_USER)) {
> +        error_report("ARM_SMCCC_KVM_FUNC_DISCOVER_IMPL_CPUS fwd filter "
> +                     "install failed");
> +        return false;
> +    }
> +
> +    if (!kvm_check_extension(kvm_state, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS)) {
> +        error_report("KVM_CAP_ARM_WRITABLE_IMP_ID_REGS not supported");
> +        return false;
> +    }
> +
> +    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS, 0)) {
> +        error_report("Failed to enable KVM_CAP_ARM_WRITABLE_IMP_ID_REGS cap");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
>  
>  uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index ba5de45f86..3cd6447901 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -207,6 +207,13 @@ bool kvm_arm_sve_supported(void);
>   */
>  bool kvm_arm_mte_supported(void);
>  
> +/**
> + * kvm_arm_target_impl_cpus_supported:
> + *
> + * Returns: true if KVM can enable target impl CPUs, and false otherwise.
> + */
> +bool kvm_arm_target_impl_cpus_supported(void);
> +
>  /**
>   * kvm_arm_get_max_vm_ipa_size:
>   * @ms: Machine state handle
> @@ -263,6 +270,11 @@ static inline bool kvm_arm_mte_supported(void)
>      return false;
>  }
>  
> +static inline bool kvm_arm_target_impl_cpus_supported(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvm_arm_get_writable_id_regs(ARMCPU *cpu, IdRegMap *idregmap)
>  {
>      return -ENOSYS;
Otherwise looks good to me.

Thanks

Eric


