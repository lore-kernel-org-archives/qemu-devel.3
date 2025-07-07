Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5660C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 08:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYhGg-0006EF-N4; Mon, 07 Jul 2025 04:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYhGe-0006Cx-Cj
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYhGc-0002We-Mh
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751877120;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgXvvyjR+4D05P4w8bP5FzwbXRioeu/Bwc1AJUs2C+w=;
 b=gaqOfDHkhbmmw+jsmRztNu832+Ymp3/Iz9tu96h+BF0/RRSGiVM6sTSLvWU/aJO3vfOZEy
 qsl8l4iHRGBoeOxPmt9JyAzEAZPxDJ1z+IkvAHkHm64QjKFm2FQo0K/DIAnJkt/e2meXoL
 UzNVg1e48ji0EPhC7AF4EDz/7hSsv1g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Fheufk_yO3ef4Qjt7hlUEg-1; Mon, 07 Jul 2025 04:31:59 -0400
X-MC-Unique: Fheufk_yO3ef4Qjt7hlUEg-1
X-Mimecast-MFC-AGG-ID: Fheufk_yO3ef4Qjt7hlUEg_1751877118
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so1776427f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 01:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751877118; x=1752481918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jgXvvyjR+4D05P4w8bP5FzwbXRioeu/Bwc1AJUs2C+w=;
 b=Hb66sYnUj49xk8jY2gw01nL1KKhO1rqZhuAO/iI5gpYIWUZkocCxeNAG/r39hjKO4X
 iNWe4NUVSxP5ZBA/TkrL+i4yDpUVqAFjhfk6NbZOcCBZHSMn5acn9G8Wc2nNVGU2BT0h
 H2uxjyrEPh2gPlP9eTFXVxAYRNTVQIBvZgNGHlc0PfNEHMIXxjMrqzpxNGJO1MT9X0O5
 T113r7FP51CoLTPkMZ3Ul2ZmuhlQR29zDRfIM5EeoyJHlfICVIRsHMXPwnNq64uXKT2a
 rSh/BLy09cDMyEM8VrxQ6KnAi/WYio6yX2DSonVUECC1Fs80XSgt4gP/UVRwPYcjblnz
 s+uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBcswLK/5yRgug9z6KUzORnjylllKvC2LYtSO/ojjbRXTIGwTbPwtsJnYpVf/TG3cKGOwlPbQbW1/l@nongnu.org
X-Gm-Message-State: AOJu0Yyqauv0scdN+4W3pvwQowoTh1wv4Arus20Q5ihyHOERGUVa2/Na
 LE7A1LM9u7APGl0zkyR0Zs1peIw4XKaTpn6JuqPsKq8WuobEa+PiyAO5uX1KOlhQ+jSp4uJn3tw
 qVkUsCHPY2ReUpwMcEgntEF5jzFejmPvqxEkyejXZr1uAPDtLmn30wnkc
X-Gm-Gg: ASbGncv16p1h6zpbsBPR0eyGMiRKfidjdsKfl8qnnbNcvr+Em+8gvdwPaqkBJG48hmS
 k1KVK1+rn26jborKwyfzBrNQt4iI5VU9faBXCcQ5B0DMppv+8VG63gqkM7gfWD0M6dFDLys5BBa
 OfBtSOsd3f1wTBLDrBx2YpN2F6yKFmHJEowXLd3dFblJ4NLpZatnyKyS+lTQhKffrF2lEjlfxq1
 u9JTbiEgU0NBrXy3AHsh92UFfd99CwHlUaXxgOfDRUWj0747sbVCtsSh6/FUdzr8XKdBiAdGraE
 zsqnJzcLv8F05H6XO/5VdnBvpPkcrELvd35EE41VxOFmQo45OQODAMZnL+8sUbLYUSLEhw==
X-Received: by 2002:a05:6000:481c:b0:3a4:d64a:3df6 with SMTP id
 ffacd0b85a97d-3b49700c535mr8401051f8f.3.1751877118136; 
 Mon, 07 Jul 2025 01:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpYMCjiAJZbppgeTo3UaDEz8wahEHHMGoJND/KY7TYox65AQ2t1+TwoSLbD0yIP3OJYyYQ8g==
X-Received: by 2002:a05:6000:481c:b0:3a4:d64a:3df6 with SMTP id
 ffacd0b85a97d-3b49700c535mr8401019f8f.3.1751877117661; 
 Mon, 07 Jul 2025 01:31:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b16865c2sm103959195e9.19.2025.07.07.01.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 01:31:56 -0700 (PDT)
Message-ID: <d174bfd7-aac2-46ec-9cf4-8999b6340614@redhat.com>
Date: Mon, 7 Jul 2025 10:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] target/arm: Enable feature ARM_FEATURE_EL2 if EL2
 is supported
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com,
 hi@alyssa.is
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-4-eric.auger@redhat.com>
 <CAFEAcA_4AAprfa_TV48rwbxx7ndjbFYy74ykQQ8s=Ej-nBe4EA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_4AAprfa_TV48rwbxx7ndjbFYy74ykQQ8s=Ej-nBe4EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 7/4/25 2:14 PM, Peter Maydell wrote:
> On Wed, 2 Jul 2025 at 17:31, Eric Auger <eric.auger@redhat.com> wrote:
>> From: Haibo Xu <haibo.xu@linaro.org>
>>
>> KVM_CAP_ARM_EL2 must be supported by the cpu to enable ARM_FEATURE_EL2.
>> In case the host does support NV, expose the feature.
>>
>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> ---
>> v2 -> v3:
>> - check pmu->has_el2 on kvm_arch_init_vcpu() when setting
>>   KVM_ARM_VCPU_HAS_EL2 feature (Peter)
>>
>> v1 -> v2:
>> - remove isar_feature_aa64_aa32_el2 modif in target/arm/cpu.h
>>   [Richard] and use el2_supported in kvm_arch_init_vcpu
>> ---
>>  target/arm/kvm.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index e5708e54ae..46e5f19637 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -250,6 +250,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>       */
>>      int fdarray[3];
>>      bool sve_supported;
>> +    bool el2_supported;
>>      bool pmu_supported = false;
>>      uint64_t features = 0;
>>      int err;
>> @@ -269,6 +270,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
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
>> @@ -422,6 +431,10 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>      features |= 1ULL << ARM_FEATURE_AARCH64;
>>      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>>
>> +    if (el2_supported) {
>> +        features |= 1ULL << ARM_FEATURE_EL2;
>> +    }
>> +
>>      ahcf->features = features;
>>
>>      return true;
>> @@ -1887,6 +1900,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>          cpu->kvm_init_features[0] |= (1 << KVM_ARM_VCPU_PTRAUTH_ADDRESS |
>>                                        1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
>>      }
>> +    if (cpu->has_el2 && kvm_arm_el2_supported()) {
>> +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
>> +    }
>>
>>      /* Do KVM_ARM_VCPU_INIT ioctl */
>>      ret = kvm_arm_vcpu_init(cpu);
>> --
> How does this interact with creating an aarch32 VM with
> "-cpu host,aarch64=off" ?  Looking at the kernel, it will
> fail vcpu_init if you ask for a vcpu with both EL1_32BIT
> and HAS_EL2. I guess since the virt board will only request
> HAS_EL2 if you say virtualization=on this is fine. Do we
> give a sensible error message if the user tries
>  -accel kvm -M virt,virtualization=on -cpu host,aarch64=off   ?
Not yet. I will add one.

Thanks!

Eric
>
> -- PMM
>


