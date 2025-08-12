Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AC9CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsmT-0003VW-Oc; Tue, 12 Aug 2025 13:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ulsmM-0003UQ-PT
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:27:20 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ulsmF-0003JX-QS
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:27:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bed310fa1so4948103b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019625; x=1755624425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=embRryYeQhQDioX2+pvo4ABUk00N28+mDWN9zPMYAVA=;
 b=swvgwwv4E0eMGwbGZvsm0IZe/MYF0E+0wn19VycVVM63iYu2o/Z8b6EHMmEnu6ukAc
 3qygYCoJGlOlLlA+Myh31eWbPe19+o4xz5ynOMe7CghDBrGC/3hUS5NW0RpEty1elwxw
 3mVA5EhZjZWQr3zD+p3mDD9kZ4cWJ8RRj8fnpQ3m6rXkt0bqiCSLSD3pb+F5IBpyPQNE
 KVgj1Oigf3eJg6ciBCNA3wSDY+42otpTXKtA1H2gTrTZLy5B4Q48mN4EHFMse+qoKRTS
 OhMJarvSDsGkNpwLcyaDWbBizf6Ey3BXodBQHejUCRCGQ4wf1Gk6oZ7VyOLA9Ymn0hRF
 nOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019625; x=1755624425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=embRryYeQhQDioX2+pvo4ABUk00N28+mDWN9zPMYAVA=;
 b=RaXSIwbpcLUJEdYl/S9YYdkiIW1dmzhlT6gDsjZ2Swra6mLu1zlz5jcHIyZmOikNE9
 xPXsPOQMpnlvGTCYAnYszbhwFcw9sCrUYh/LqTXxJhGXZ+oLQDzDj8yQmbJ1+zhYaYl9
 E5K8aIigZsWyobNar8WIKq5t00Ds2kzFlgRB8pqVUkU8eO4PhbMm1zvwoMr+PuUF3dea
 KW1OUtgt1YnSzvH1gWHgSmbacS1dNX1BBJY+F8nh7t3hKaCzRFpup5oNimRIKFFhRSZA
 ACVaLYveLJac4/bp1b2LQdjn70qxWqAprjAX/hqaxhiQyb3GLczwmM4BlSA08kJgKvJ6
 OnsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVELVPyycNq3nHeNKUu6cMDI2yPMJWSZY69zI1D96cptQPbV/W1+UBn+aFnzVeKEhZvtWffEQWK/7tr@nongnu.org
X-Gm-Message-State: AOJu0YxPwIc8HXh5Gdi3pL1yJ6t7fS0Ak4OipRsC+TQg2yIetD+/qi+Y
 TO5slDrdfNCrQEBztepk2JSwMEsu2JlsoEdGXs3u0t5WCldbLrwVjd6EQVRjXvcT/Ds=
X-Gm-Gg: ASbGncsxovmCXXRTutZZNdSUsS+5ZnKXlMMd0WlcRO/mK/6XSuenErkd371U8wXhB2r
 2ie6TZaFMQVMnoQauz8i14eb689kV/nk0XMmRcUSXQu0IraN5Vfk6HyKGLy3m5XTFBPC+MdXlHc
 oiVPZ4wG2SLQCapxUAbHj7lo7lNEkPZPIUBr1UqItFdh/i+fybnETjJ1n+qV52QqOFpc4FPxeIq
 4/mhT7N0WHX6mjVtchwhPESDkT6lyhhWrmqi0n1kX4J/8soU27XWHCkjg4elcx/39ZJD+6HiWTq
 D/6G7RDDfGk/5iGZKE6Y1JNCUP9vgm7hgxhNR7zXWCwi/NeYKe/kP59+md17fgIhuTh9ud+WRRH
 1WnejFl/HmS7uLTABykllgpyeY8W3OL4RoRE=
X-Google-Smtp-Source: AGHT+IED0GTnLWMRrqxom56II30N7PQ+deFgpbhTCElrAV9znqPB5iY7rwJvEnUJUDPBrDwrFX5T8Q==
X-Received: by 2002:a05:6a00:3c94:b0:76b:fab4:6456 with SMTP id
 d2e1a72fcca58-76e1fe6147bmr516550b3a.21.1755019624609; 
 Tue, 12 Aug 2025 10:27:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8fa10sm29914204b3a.52.2025.08.12.10.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 10:27:04 -0700 (PDT)
Message-ID: <2cb0e32f-6660-4fcd-8a37-52cdeaf9dc19@linaro.org>
Date: Tue, 12 Aug 2025 10:27:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
 <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
 <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
 <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/11/25 3:34 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 10/8/25 18:59, Tao Tang wrote:
>> On 2025/8/7 05:55, Pierrick Bouvier wrote:
>>> On 8/6/25 8:11 AM, Tao Tang wrote:
>>>> This patch enables the secure command queue, providing a dedicated
>>>> interface for secure software to issue commands to the SMMU. Based on
>>>> the SMMU_S_CMDQ_BASE configuration, the SMMU now fetches command
>>>> entries directly from the Secure PA space so that we need to pass the
>>>> memory transaction attributes when reading the command queue.
>>>>
>>>> This provides a parallel command mechanism to the non-secure world.
>>>>
>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>> ---
>>>>    hw/arm/smmuv3-internal.h |  8 ++++--
>>>>    hw/arm/smmuv3.c          | 55 +++++++++++++++++++++++++---------------
>>>>    hw/arm/trace-events      |  2 +-
>>>>    3 files changed, 41 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>>> index 1a8b1cb204..5b2ca00832 100644
>>>> --- a/hw/arm/smmuv3-internal.h
>>>> +++ b/hw/arm/smmuv3-internal.h
>>>> @@ -319,9 +319,13 @@ static inline void queue_cons_incr(SMMUQueue *q)
>>>>        q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
>>>>    }
>>>>    -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
>>>> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, bool is_secure)
>>>>    {
>>>> -    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>>>> +    if (is_secure) {
>>>> +        return FIELD_EX32(s->secure_cr[0], S_CR0, CMDQEN);
>>>> +    } else {
>>>> +        return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>>>> +    }
>>>>    }
> 
> 
>>> This looks like a reasonable and readable approach to support secure
>>> and non secure accesses.
>>
>> Hi Pierrick,
>>
>> Thank you so much for taking the time to review and for the very
>> positive feedback.
>>
>> I'm very relieved to hear you find the approach "reasonable and
>> readable". I was hoping that explicitly passing the parameter was the
>> right way to avoid issues with global state or code duplication, and
>> your confirmation is the best encouragement I could ask for.
> 
> An alternative (also suggested in patch #1) is to use index for banked
> registers.
> 
> For example we use M_REG_NS with Cortex-M cores (target/arm/cpu-qom.h):
> 
>       /* For M profile, some registers are banked secure vs non-secure;
>        * these are represented as a 2-element array where the first
>        * element is the non-secure copy and the second is the secure copy.
>        * When the CPU does not have implement the security extension then
>        * only the first element is used.
>        * This means that the copy for the current security state can be
>        * accessed via env->registerfield[env->v7m.secure] (whether the
>        * security extension is implemented or not).
>        */
>       enum {
>           M_REG_NS = 0,
>           M_REG_S = 1,
>           M_REG_NUM_BANKS = 2,
>       };
> 
> And generally for address spaces (target/arm/cpu.h):
> 
>       typedef enum ARMASIdx {
>           ARMASIdx_NS = 0,
>           ARMASIdx_S = 1,
>           ARMASIdx_TagNS = 2,
>           ARMASIdx_TagS = 3,
>       } ARMASIdx;
> 
> (not sure this one is appropriate here).
> 

This could be useful, especially to not duplicate register definitions.

However, for now, we only have two indexes (secure vs non-secure) and 
it's not clear if we'll need something more than that in a close future.
I think the current approach (a simple bool) is quite readable, and the 
boilerplate is limited, especially versus changing all existing code to 
support the new Idx approach.
As well, it can always be refactored easily later, when we'll need it.

That said, I will let the maintainers decide which approach they want to 
see implemented, to avoid Tao jumping between different people opinions.

Regards,
Pierrick

