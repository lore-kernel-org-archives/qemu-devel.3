Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A76AC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 06:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA0cD-0004RB-2w; Wed, 30 Apr 2025 02:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA0cA-0004QO-W0
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:08:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA0c9-0002dR-8B
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:08:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso48382865e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 23:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745993291; x=1746598091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rSasN2qvfne7cnvgn4lGh5pVBMg2PxpSK1Y0mTKtEu8=;
 b=xA+7fICKXq4hjsS2r/YKrxfCIUGq9SBV9m4BCLHrr9LFp2Pnpx77prVxEM1Ok0MZuJ
 oJfllLPqel3jYRHGmzLfFPJ3CYDNjpYHZ5lPJc2dvV45KzLWY5wFLtw+lOcmw1/QYhqf
 GbszuYUn4Fp2bCX/deolivrwgv5noX7rsCg8VCTSANF5VgpPmT/IWh3uJk6MspA71K/N
 RL0g9xKwaRMPd/rXhwFRAoKec0YQ9Yi1rkTanXsqvVMencTpnCdTz/3UT2Whb1l7GC3/
 UzChVozAmaRkaDvws9kU+dXp2W86Lr0ioeluSCnhr3VcIj4vtB5C5LMY3lcpoQVkkysT
 /s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745993291; x=1746598091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSasN2qvfne7cnvgn4lGh5pVBMg2PxpSK1Y0mTKtEu8=;
 b=oHNVS9AyDSROkDgOjAfQq7rXNCDOCniLdIC+JYLcvuzMWjDnDdWUXkKAmmvUuRB6re
 7siy98huTCgdSr93mTOg7gloWwY3zB/jMgv62Efp7kkfAubSEYwLhTfUOXrEluPHy2Yj
 0FbIv6jTpwPulT+qaRo0IH3ws/KO8SngrPuydkaXsyQhXwUeZWij7b7NSQGA9sl5r+Kg
 m1+hBi06E1Vt4FeA6BqF7iKbUU4+JIUTV2VpG70A20/vUKJl1NdCuknifXJbu3y9TxdO
 D02fcR4+xk4b4Y7ZghnzzegbuKGTOQU/rGJVhhzCsIwnXUH1kKe/sp4Jt047Yypc3yiB
 Eujg==
X-Gm-Message-State: AOJu0YxH2vVzG2tQdNTEHSSV2FoR3PbG04FIqHWZ/KiLiwSXBQIGL/ta
 WG/LPTRmOuAlIv99Utx+Oaz2ZHOX9bufFL/8FlmAww+Aje7jo1kYKk3X6Z+M4UTwLyfmKFltflQ
 +
X-Gm-Gg: ASbGnctOOH68mUUbXBkr/dyDUJrHSnnhoOATNoZpGVVbh38sk15aVXmtBpN5+GbiPbH
 CBafgpYNh8/p9h3/WMfn/hUdqZQSwQ3RNdIaHzVf685HnMs913m3SR93QkMLCdJEoqKLmAsRz6b
 As8OFzpfmjvwNyaPsyivdWjlUvyG31me3jroWbeIzmlf5gBY6I9IU5lqn5bzk6eqtJF+DErlwTc
 vHE4j5P5mh6EF0bBy6WbZRuqvPNBfFEoF8wJUC2YLfLBqKGZs7e1Ftc4xPfSf8qxEK3kLtvHHGZ
 kD0GbJQsQufbGA31/jzZmblXoBfcL8l+ZcAorE+V34719mcM7v05AkyTrDwwu6rwINkoVDUwOhM
 PIVwng+qa
X-Google-Smtp-Source: AGHT+IHYmZXRBUbT+lccOGhElxssVlDpwS2bQieP60mt+K+2l6KN+WEnfMLGvN1bTfIOOsLGhLTXEA==
X-Received: by 2002:a05:600c:4ec6:b0:43c:f61e:6ea8 with SMTP id
 5b1f17b1804b1-441b2635046mr8742475e9.2.1745993291433; 
 Tue, 29 Apr 2025 23:08:11 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441ad870ae0sm26811145e9.2.2025.04.29.23.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 23:08:10 -0700 (PDT)
Message-ID: <e88f9bfe-1d8e-4571-81d0-55d750a2da9e@linaro.org>
Date: Wed, 30 Apr 2025 08:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/arm/kvm_arm: copy definitions from kvm
 headers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-6-pierrick.bouvier@linaro.org>
 <87msbz45y6.fsf@draig.linaro.org>
 <d455055c-a13b-4e00-b921-5ede2be08e89@linaro.org>
 <b044596b-46a0-47ca-a1f0-61160c59efc9@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b044596b-46a0-47ca-a1f0-61160c59efc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/4/25 00:02, Pierrick Bouvier wrote:
> On 4/29/25 2:14 PM, Pierrick Bouvier wrote:
>> On 4/29/25 3:28 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>
>>>> "linux/kvm.h" is not included for code compiled without
>>>> COMPILING_PER_TARGET, and headers are different depending architecture
>>>> (arm, arm64).
>>>> Thus we need to manually expose some definitions that will
>>>> be used by target/arm, ensuring they are the same for arm amd aarch64.
>>>>
>>>> As well, we must but prudent to not redefine things if code is already
>>>> including linux/kvm.h, thus the #ifndef COMPILING_PER_TARGET guard.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    target/arm/kvm_arm.h | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>>>> index c8ddf8beb2e..eedd081064c 100644
>>>> --- a/target/arm/kvm_arm.h
>>>> +++ b/target/arm/kvm_arm.h
>>>> @@ -16,6 +16,21 @@
>>>>    #define KVM_ARM_VGIC_V2   (1 << 0)
>>>>    #define KVM_ARM_VGIC_V3   (1 << 1)
>>>> +#ifndef COMPILING_PER_TARGET
>>>> +
>>>> +/* we copy those definitions from asm-arm and asm-aarch64, as they 
>>>> are the same
>>>> + * for both architectures */
>>>> +#define KVM_ARM_IRQ_CPU_IRQ 0
>>>> +#define KVM_ARM_IRQ_CPU_FIQ 1
>>>> +#define KVM_ARM_IRQ_TYPE_CPU 0
>>>> +typedef unsigned int __u32;
>>>> +struct kvm_vcpu_init {
>>>> +    __u32 target;
>>>> +    __u32 features[7];
>>>> +};
>>>> +
>>>> +#endif /* COMPILING_PER_TARGET */
>>>> +
>>>
>>> I'm not keen on the duplication. It seems to be the only reason we have
>>> struct kvm_vcpu_init is for kvm_arm_create_scratch_host_vcpu() where the
>>> only *external* user passes in a NULL.
>>>
>>
>> I'm not keen about it either, so thanks for pointing it.
>>
>>> If kvm_arm_create_scratch_host_vcpu() is made internal static to
>>> target/arm/kvm.c which will should always include the real linux headers
>>> you just need a QMP helper.
>>>
>>
>> Yes, sounds like the good approach! Thanks.
>>
> 
> Alas this function is used in target/arm/arm-qmp-cmds.c, and if we move 
> the code using it, it pulls QAPI, which is target dependent at this time.
> 
> Since struct kvm_vcpu_init is only used by pointer, I could workaround 
> this by doing a simple forward declaration in kvm_arm.h.

Correct, great!


