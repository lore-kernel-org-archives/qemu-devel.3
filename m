Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4DB10F287A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GRN-00047t-GY; Fri, 27 Mar 2026 19:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GRM-00047T-8u
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:18:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GRK-0005BN-Mr
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:18:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso25644215e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653485; x=1775258285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=42DWK7Uvm9wPSL+j8TxXgYd3LgAa9ZplJ7LttkR4FNM=;
 b=JBKSiz2OFPeRyjmVftTz4LupZXqXDra/RjFdrvfojm9YkxKagQLVdxayJkKXZ8DoyD
 rub5pZqn+o/OAmg5uJJX9G7nXhc4EpLW2LZg6txuC9S+ffRb58qP3jSMqCCLNg62G1ox
 iSdjltZXg0zWJeI3yu5HkeUXmn5PkXJQDJFp5jmOMGmmVuq5tdAOqQke+8ZTy+AeTDzM
 CMDjKBWBM1RyRDFcl77c2N8UdOaX/hil4mzXVtOmWUw1rwTAd0H2vjZeJ+iSZhjfoo4A
 jivnKLa49u1kWMXW8+3EnTvOAVGxwDQDAb7yh6+vlQBmmOqypjmZn0HSMNnBAMa6Rf6k
 azdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653485; x=1775258285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=42DWK7Uvm9wPSL+j8TxXgYd3LgAa9ZplJ7LttkR4FNM=;
 b=AICqfi16xaxEp/leOxxFczclhpjHVz9lQ1Ikvix3b/BjqjSEg+CR11upcnkIwsO/v1
 9OrIvsZoA61ua/ukrRkkJsNvzU46Z1W+PIlD4bO/Nra853+H2fx6tfJFHEFYYvd6TMVe
 O+fQkkKZNAx4CWp/dHTCWp9DjNGQlKYQ4DxlJcTDZMlo+ETVWdumhEk6syclrlWauDkI
 NIFbokL72u5kQ8HGnRc6MBLNKo+K5Uk7VLxNmGJhauPIT+t/K9LURloAbvlRALrE5WDO
 EiIEm5GlfpoMmCsJNFsXszJ6li0g4GjU1rVcqiyWgQSnLsPXtMvgSb6dLzcGo3D6i+pL
 lyJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS5zGAyMZxFzbEYqCvFRWfN0dSAS/Pcp7/vu80JuGIAXkTg7+EGBlG74bdHzgrNE3MJE+pH7kzidTt@nongnu.org
X-Gm-Message-State: AOJu0Yy5k/KIWy1huDvpwuDueE4LLq4fQTn4nCDpNoF3y2F6jQepQLRY
 +M/BN4fIQNWKDrvHQIIuX0PbvQvqJMNP4Z3wSOFZI0hSER4HnhcqEcrVICZnB6ldaDU=
X-Gm-Gg: ATEYQzwk1CAO4+y6t4H3MjDFeFuD1IYd0l0+FY5epJv8JtHImRFrjIgEa3/8uLKsR7l
 kUUJrxW28M3gfAO75UXd0nYco8jQxQD/F3B8q4P+wkBPfzsvrwiJ4Yp+ZdODi5HrDlr9Nu0ny5G
 SUnooaSgLaQk0FXtOC7gA9ofy5QcLM2OJtJWGlrs4nxGtTi/JuR+yEEcm52UPBOtCs6oiIx52mI
 HYEopejDDpxf/Sul+gzEWtkUEEgzXKcjGzn5prvLgi2z+VsIMYXgm2gnFuoSLsDPhezB19+9T64
 iRia3RT2e22P3RQX2Lr03R06fYGu5hmYaSI/8sn3z7vHiGTQ/kQCVOSQU3a8IfjjIMjyi6wT73R
 ugQl1aTkSL+08Vl8zAuv9kpyHGSXkd9ZrXyW5WH7YlYFfaYcsP/ne+NCOOnwyUNtsMBt7Ma7Z3i
 QkC2aZOAQ30EomtxP0BSwcQ1VbJ/j8BHOtgaDqWJmbJ70KRPXxgKixvnWwGfA6bg==
X-Received: by 2002:a05:600c:a207:b0:485:3038:72c2 with SMTP id
 5b1f17b1804b1-48722c15389mr74224545e9.17.1774653484903; 
 Fri, 27 Mar 2026 16:18:04 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e3602sm1360100f8f.4.2026.03.27.16.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:18:03 -0700 (PDT)
Message-ID: <f5b31bb6-f03d-424c-8879-a887f3f56ce8@linaro.org>
Date: Sat, 28 Mar 2026 00:18:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] target/arm/tcg/translate.h: remove TARGET_AARCH64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-5-pierrick.bouvier@linaro.org>
 <36d7e3d6-3907-484b-8a58-f05a9ef6cae4@linaro.org>
 <2737926f-7834-4e64-be9e-d58561e7f4ef@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2737926f-7834-4e64-be9e-d58561e7f4ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 27/3/26 19:31, Pierrick Bouvier wrote:
> On 3/27/26 10:26 AM, Philippe Mathieu-Daudé wrote:
>> On 27/3/26 17:50, Pierrick Bouvier wrote:
>>> We need to stub a64_translate_init and gen_a64_update_pc.
>>> At this point, we don't need to do anything for aarch64_translator_ops
>>> since it's just an external symbol.
>>>
>>> We can now include target/arm/tcg/translate.h from common code, since
>>> all target specific bits have been removed, or can be specialized with
>>> specific defines.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/tcg/translate.h | 10 ----------
>>>    target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
>>>    target/arm/tcg/meson.build |  1 +
>>>    3 files changed, 18 insertions(+), 10 deletions(-)
>>>    create mode 100644 target/arm/tcg/stubs32.c
>>
>>
>>> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
>>> index 5f591560551..3e96c77df73 100644
>>> --- a/target/arm/tcg/meson.build
>>> +++ b/target/arm/tcg/meson.build
>>> @@ -21,6 +21,7 @@ gen_a32 = [
>>>    arm_ss.add(gen_a32)
>>>    arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
>>> +arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
>>
>> Add via stub_ss[]?
> 
> Unfortunately, libqemuutil is declared before iterating on targets, so 
> stub_ss is not what you expect at this point.
> 
> stub_ss = stub_ss.apply({})
> It changes its type from source_set to source_configuration.
> Even if we used a new variable name, further changes to stub_ss would be 
> ignored.
> 
> I will write a patch for it, but it's definitely out of the scope of 
> this series, so I'll leave the current patch as it is for now.

Good you already thought about it :)


