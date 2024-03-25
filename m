Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B521C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 18:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropHj-0004nj-Oh; Mon, 25 Mar 2024 14:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ropHh-0004n2-SV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ropHg-0000sw-DV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 14:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711392179;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qq8q/Mm0zNrkMDJrUiYylqwQQwleQKmqYIx8eShQrIQ=;
 b=OL0Yxy09RXsCX9x2pSrObrhlQD1j4S1v/tYUjBM0iGU37F7M/BJ858yMtGFKTIrOKuh7c2
 phW+ap1RizQJzqgCRKMJVJO2jTaS3cx3GpfSd/h9K9Y5/zzKVRT3hGxMc5rMFriTewY2CL
 QJHBtp/iGOA7ZXhrPKgOt9Fyn7ovhsA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655--5tDER4cMViavY82i6oHMA-1; Mon, 25 Mar 2024 14:42:57 -0400
X-MC-Unique: -5tDER4cMViavY82i6oHMA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-789ffdbd375so951436185a.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 11:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711392177; x=1711996977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qq8q/Mm0zNrkMDJrUiYylqwQQwleQKmqYIx8eShQrIQ=;
 b=Ih9Zbl1Xj3UVIeOtOp1KBk2f9dZ28v4ayX0KbYkbAqkHe8Y5D2f9L/apGi5nu/G8k/
 VsDQv9JufqtsriY5suFpyWSRWOFGe/du3T1RH2flC722V1gS2hWiAZRbIM1An7iIoqZe
 RLRE/nEv6DNlnO5PuBR6Q/EaV9ig7WrSinUUzbUQ2DdI9OvhfkYoRIgZvgG+Zb/hsDNG
 VxMKqiq8CmDxax2Onsl+MCIlBhUjTcd8yU2CQEJYCoxMOoGZyUdj0FUOZWqEgzEpX4Z1
 +Aw0UVeLJilaBeOXb/LT2gzhqPTjSDD0/3HCH4zzF5LOU5f7yiDv3OwnGRwQlTtsBVr4
 66SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtW2bZDV5naMQW1Fa2EQ0qV4E5l4xdhjwpsQfoOSQSeN8fR9fzNIOk6FTdQcdzzHoOcaKCHxfEit0+s9+gMgrDfRDYNX8=
X-Gm-Message-State: AOJu0YwWwi2U4w4wgT6Ph+c5udEMTMuF3va1gAtx/prOhIJoeAmr0EEP
 p+oNoY5GURQrwdAk8xdol9ZgC/yvdDpZbyEnb7ThV4VK9xYCS4EgWw4N1YeRj5QyNEJWDGvWEmK
 hCBDGfSp1/caBWCNlOCYFhQ6JWd0sSdgFFfxGuNGGuyBi6CHaMR3C
X-Received: by 2002:ae9:f504:0:b0:78a:1ebf:12d with SMTP id
 o4-20020ae9f504000000b0078a1ebf012dmr11477599qkg.16.1711392177103; 
 Mon, 25 Mar 2024 11:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKhXM2QPX4H58pV7Jtq9OstdFQRlRadnEXgnuus4DST3mqZzZt0s8nYXRlWJJx7NfRRhdU7w==
X-Received: by 2002:ae9:f504:0:b0:78a:1ebf:12d with SMTP id
 o4-20020ae9f504000000b0078a1ebf012dmr11477569qkg.16.1711392176841; 
 Mon, 25 Mar 2024 11:42:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a05620a148f00b00789f3e53d04sm2342509qkj.126.2024.03.25.11.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 11:42:56 -0700 (PDT)
Message-ID: <4a5e2d39-6d98-4a79-a33c-e4f144d7fcdd@redhat.com>
Date: Mon, 25 Mar 2024 19:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 4/5] target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is
 supported
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org,
 maz@kernel.org, gkulkarni@amperecomputing.com
References: <20240209160039.677865-1-eric.auger@redhat.com>
 <20240209160039.677865-5-eric.auger@redhat.com>
 <CAFEAcA_y9uHa5cdtqgyneUSj=DzhDfrWc73xyr9x54tF5MedNg@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_y9uHa5cdtqgyneUSj=DzhDfrWc73xyr9x54tF5MedNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Peter,

On 3/5/24 17:49, Peter Maydell wrote:
> On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>> From: Haibo Xu <haibo.xu@linaro.org>
>>
>> KVM_CAP_ARM_EL2 must be supported by the cpu to enable ARM_FEATURE_EL2.
>> In case the host does support NV, expose the feature.
>>
>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - remove isar_feature_aa64_aa32_el2 modif in target/arm/cpu.h
>>   [Richard] and use el2_supported in kvm_arch_init_vcpu
>> ---
>>  target/arm/kvm.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 0996866afe..a08bc68a3f 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -238,6 +238,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>       */
>>      int fdarray[3];
>>      bool sve_supported;
>> +    bool el2_supported;
>>      bool pmu_supported = false;
>>      uint64_t features = 0;
>>      int err;
>> @@ -268,6 +269,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>          init.features[0] |= 1 << KVM_ARM_VCPU_SVE;
>>      }
>>
>> +    /*
>> +     * Ask for EL2 if supported.
>> +     */
>> +    el2_supported = kvm_arm_el2_supported();
>> +    if (el2_supported) {
>> +        init.features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
>> +    }
>> +
>>      /*
>>       * Ask for Pointer Authentication if supported, so that we get
>>       * the unsanitized field values for AA64ISAR1_EL1.
>> @@ -449,6 +458,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>      features |= 1ULL << ARM_FEATURE_PMU;
>>      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>>
>> +    if (el2_supported) {
>> +        features |= 1ULL << ARM_FEATURE_EL2;
>> +    }
>> +
>>      ahcf->features = features;
>>
>>      return true;
>> @@ -1912,6 +1925,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>          cpu->kvm_init_features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
>>                                        1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>>      }
>> +    if (kvm_arm_el2_supported()) {
>> +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
>> +    }
>>
>>      /* Do KVM_ARM_VCPU_INIT ioctl */
>>      ret = kvm_arm_vcpu_init(cpu);
> Am I reading this right that if the kernel supports FEAT_NV
> then we will always ask for a vCPU with that feature?
> Is that a good idea, or should we arrange to only do it if
> the user uses the 'virtualization=on' option to -M virt ?
> (Or does that happen already in some way I'm not seeing?)
yes you're right, if the host supports it, the feature is currently set
on the vcpu. I am not totaly clear under which conditions the features
shall be instantiated in the scratch VM and when the host passthrough
model shall be altered by machine option.  

Thanks

Eric 
>
> thanks
> -- PMM
>


