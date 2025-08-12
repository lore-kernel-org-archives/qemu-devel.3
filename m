Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1533C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulonn-0008U7-5q; Tue, 12 Aug 2025 09:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulone-0008St-5G
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:12:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulonZ-0006TN-NI
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:12:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b780bdda21so4472872f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755004327; x=1755609127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s+T1o+BuKY1aL4wGs8K90IzOvRryXHMAwn0GWBFxrs4=;
 b=lcD6YQbynIrrKX90aAf0DlwsgaH1m0Yq5WvX5aGmxBEQApuQZ6cgrH/veutFvsCqRC
 oFuLD8GM6YzxyYghGztXxAtyW2q697Ck9h/GLTkq0F05ujBMlrL1HlzI4+X/LIJ/wW9W
 fJN0JHtLhgzp5Y1wsVL8F00eHvT8mkJXqdR8fLOifEInz+y2n0A18Ea0jHz/wnuEublY
 /fDgFGAAYKLshOJNvngLOoj0yMOgR3S9cJhlKjmGGkOIfb58ZhMiw4Wv+LF+RoLxhJA1
 jQWmUqLwaYw4caOAbwU6fmuD5tuyEhATZDS72V6erQ6H1MH0OrZH/HZqP8ll1Yx1etg1
 2Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755004327; x=1755609127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s+T1o+BuKY1aL4wGs8K90IzOvRryXHMAwn0GWBFxrs4=;
 b=uad2ncyHG24BXLllFAC7U4DTrhm8V18xt8LwU1TTxkSoLlzO8xZdCMz1GNHs+trssT
 3bn5i69ChRUJtPktPY4P8DrY3i5OmR/GTwmewdHGHe0RutJpok9/oXqa0Qr8Gm7CjqeE
 737zjc79LBrU2pOv8a7dy49tbs3rG1eHj9MMFXCSr/Z1dW4H/FLVjAr+CTdBnl5ZuauK
 xegLbDi7WMl5PMLSS4eQAg68sqWAqt0kMe/GPCnkoBTFGJhuRlIEXZexSNQSSu3s2C61
 hhnEMPPynT2uYL2dAao8stj9Ws+7LyWK84SFJzEHHVNIlcRpyLpzDFf3PzAtEQgKqF5I
 XrLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5WQNUQQjVEwHRyD/WtBlLLNLrDYdM2NQZzzGkhs4U1NzQpB1WCpKn5enibZvwTQ+nGoI4p5i2YK2I@nongnu.org
X-Gm-Message-State: AOJu0Ywm8ejC1DJJ2ouEAVAb91uxj2TF2QI1X//KWj4Nu2DQf2ICw09e
 8QM61Lzg9SjiriU3qUncbiMEbVwZGlwd8bW4rqqAmYkWsauRoFTbHSPyHtF+eOwl3uPWhAnzO79
 V+cdY
X-Gm-Gg: ASbGncvflHo53s+ZVxUw27uIRaAWFHLuGQnHk2eqY+4+W7zOuLY4FxaFkv0sox5lbMN
 M6b+adgoHMYZuJ9jdpJs3bsj2Gzbe5xDiZFRcA9/jZ99W6Ti54yeAN1H9RaEMpWXA4jnaZMBr3T
 UCJzlkw+EcCaBmbXT2teSu7C2TyC1CgRlLdXYuuXKGbJt3RQZDXmQzPKoFPhEblKab2BdoSellc
 lhR353rxV/wJJg+oePZnAuormxjsCHBCUUcoRsMrszRs5GNF+Xk0P+x/7atucH/R9k4cRpGsgvK
 w0BciXtCcoAln/X0JNO8BlvdI24XRxR3gg+DvKuQ33qPPtF8O074m71ucf39bXz7pA9N3jnVrCv
 lkkQGKOX6d/i9U78az3NB4ExQmd1Gv8Y8lY9UiwPkDM0vPrIYjIzepHSfhrWhIOZiAg==
X-Google-Smtp-Source: AGHT+IGJQrekMst5agAvii3jtEXmpYTMP3JRwhrQpws643hIIY1ZZ7V2UqwNXL5RV6+tAl4Lbg7PLQ==
X-Received: by 2002:a5d:64cd:0:b0:3b8:d1d9:70b0 with SMTP id
 ffacd0b85a97d-3b900b78c78mr12917805f8f.40.1755004327434; 
 Tue, 12 Aug 2025 06:12:07 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e04c7407sm34854953f8f.13.2025.08.12.06.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 06:12:06 -0700 (PDT)
Message-ID: <f19c25b0-ba6e-4644-acbb-fc79f920fd41@linaro.org>
Date: Tue, 12 Aug 2025 15:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/11] target/arm: Replace kvm_arm_pmu_supported by
 host_cpu_feature_supported
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-8-philmd@linaro.org>
 <8efcc809-f548-4383-b742-e435d622da73@linaro.org>
 <14d7d948-e840-4ae7-ae93-122755d6a421@linaro.org>
 <3d88ea9c-9cfe-4cd4-a282-2f467f2a502f@linaro.org>
 <cb6e02cc-1959-419a-bafa-5bb43818c159@linaro.org>
 <9fd617db-8ea4-49b5-98f7-0b949b02f26a@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9fd617db-8ea4-49b5-98f7-0b949b02f26a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/8/25 14:42, Richard Henderson wrote:
> On 8/12/25 17:33, Philippe Mathieu-Daudé wrote:
>>>>>> -    if (kvm_arm_pmu_supported()) {
>>>>>> +    if (host_cpu_feature_supported(ARM_FEATURE_PMU, false)) {
>>>>>
>>>>> Why is false correct here?  Alternately, in the next patch, why is 
>>>>> it correct to pass true for the EL2 test?
>>>>
>>>> I think I copied to KVM the HVF use, adapted on top of:
>>>> https://lore.kernel.org/qemu-devel/20250808070137.48716-12- 
>>>> mohamed@unpredictable.fr/
>>>>
>>>>>
>>>>> What is the purpose of the can_emulate parameter at all?
>>>>
>>>> When using split-accel on pre-M3, we might emulate EL2:
>>>>
>>>>         |   feat            |    can_emulate   |    retval
>>>>         +   ----            +      -----       +     ----
>>>  > M1/M2  |  ARM_FEATURE_EL2         false            false> M1/M2  | 
>>> ARM_FEATURE_EL2         true             true
>>>> M3/M4  |  ARM_FEATURE_EL2         any              true
>>>
>>> For example in hvf.c:
>>>
>>> static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>> {
>>>      ...
>>>      if (host_cpu_feature_supported(ARM_FEATURE_EL2, true)) {
>>>          ahcf->features |= 1ULL << ARM_FEATURE_EL2;
>>>      }
>>>
>>> and then only when split-accel is not enabled:
>>>
>>> hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
>>> {
>>>      ...
>>>      if (host_cpu_feature_supported(ARM_FEATURE_EL2, false)) {
>>>          ret = hv_vm_config_set_el2_enabled(config, true);
>>>          if (ret != HV_SUCCESS) {
>>>              goto cleanup;
>>>          }
>>>      }
>>>
>>
>> What I'm looking for:
>>
>> - Is this feature supported BY HW?
>>
>>    -> hw_init_feature
>>
>> - Is this feature supported BY SW?
>>
>>    -> sw_init_feature
>>
>> - Is this feature supported BY ANY?
>>
>>    -> do smth with feature
>>
>> With split-accel, this isn't specific to HVF/ARM.
>>
>> I can use a tri-state enum { ANY, HW, SW }.
> 
> My point, I guess, is:  tcg_enabled() appears to be the only correct 
> setting for can_emulate, and since that's the case, it's clearer to not 
> have the parameter and simply test can_emulate within any subroutines.

Got it!


