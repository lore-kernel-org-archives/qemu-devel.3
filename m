Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EDDC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 12:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZk5-00011r-0b; Fri, 08 Mar 2024 07:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riZk2-000119-Js
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 07:54:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riZk0-0001pp-P2
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 07:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709902463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jtRBFJUdIRC3wS8+YuI0DyUIpHNFcGxsYtRbLdi1zas=;
 b=htSB40I+aU/c4RjrkBMz/bHSFis2cNBMyGwdSvFAvXvTqK9tdb05WLv5Jzm8WK+BvGKRPJ
 ZtC6qOqzeBQHymSoYPy1I+QKbfSTZkqfRbVp2VEyuEVZJY2uUcdlyy1dUeV335GrVTZ1mN
 OIplsabPvbCqOW++xBn2Ox6S1mw5FWg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-LxOOWA37Nlql5dkln93Xlw-1; Fri, 08 Mar 2024 07:54:22 -0500
X-MC-Unique: LxOOWA37Nlql5dkln93Xlw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78834107f50so131216085a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 04:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709902461; x=1710507261;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtRBFJUdIRC3wS8+YuI0DyUIpHNFcGxsYtRbLdi1zas=;
 b=lTwao+gjwX1aWTzUHlTQntBHH3OVbtIFYIsmHn9QiK+2prye1SpFrG1xBGSBc2WeGw
 DgBgNEUX7Svgy0JIORExeTYHeTIgivO6NcYR8bkBabhV7+VgxeNDsRfdBlKw77PX7Sf5
 /wKf1lmt5vbtuBPxVyI/LPts1QxaMw4EUYIdbj1+iOlG+SMXK4+D7mnX1lfIyIMlN3BX
 dYkDFgt8hg/TSjkaR3folCGQ4b5uLfcnSr3pzY89xNuRdawEILajGaC6XEeYeJLZQ5HC
 46JzQN8n0C1jXhOYzMv8ni+5gheqfdqrqiSOR1nter4VI+twOMGfcqx/U4u4J0jaw93V
 JHUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2wTTybXYXYXP15nu0a3kwTOHSc5YDYVA+y18K7acX0lTPYnsbo575RZ74VWhs8GTCQLdNk5zpvADvimSGj35nUX94ePc=
X-Gm-Message-State: AOJu0YxTZTh16pIPNWKNuKrS0voymqXJpUSsRE8Z5eN0vtt/g0101vBd
 kWugJRGJ89AvI7l4fFWYM2G68IDPfi0ZQqsowaJy7pB1RvJmr7Sz+ykNYMM37p9hXiO1GpVByLe
 QtY2yRod9sXcpR8ZpVCydQDixxiEw1qwCTq2iqDd05DJgswjV3j5Y
X-Received: by 2002:a05:620a:91a:b0:788:51eb:6e1b with SMTP id
 v26-20020a05620a091a00b0078851eb6e1bmr1649604qkv.24.1709902461422; 
 Fri, 08 Mar 2024 04:54:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAHwmxS0uUsemEErvJwJWZI0HcqqDy6pNXh6TfJJTn48eyHMmcibNTXTXHIzFYFgzKt2OEZg==
X-Received: by 2002:a05:620a:91a:b0:788:51eb:6e1b with SMTP id
 v26-20020a05620a091a00b0078851eb6e1bmr1649589qkv.24.1709902461103; 
 Fri, 08 Mar 2024 04:54:21 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 vq5-20020a05620a558500b00788242166dbsm5728290qkn.133.2024.03.08.04.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 04:54:20 -0800 (PST)
Message-ID: <f952b2d2-90cb-4427-a726-ab126ade8e71@redhat.com>
Date: Fri, 8 Mar 2024 13:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/arm/tcg/m_helper.c: Include the full
 helpers only with CONFIG_ARM_V7M
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240129081835.137726-1-thuth@redhat.com>
 <20240129081835.137726-3-thuth@redhat.com>
 <CAFEAcA-yL8BAdtkF2xaWJOeFPUWRoBbuvPSEeorwjyei3oFjDQ@mail.gmail.com>
 <d0ed3f33-b641-4e46-bfaa-f21fbcecbeb8@redhat.com>
 <CAFEAcA-ye_3AqCkNS1acJ7GPzLEf=WCmjN3WXe9eRWB1x3y=7g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-ye_3AqCkNS1acJ7GPzLEf=WCmjN3WXe9eRWB1x3y=7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04/03/2024 16.22, Peter Maydell wrote:
> On Thu, 1 Feb 2024 at 19:12, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 01/02/2024 15.19, Peter Maydell wrote:
>>> On Mon, 29 Jan 2024 at 08:18, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> If CONFIG_ARM_V7M is not set, we don't want to include the full-fledged
>>>> helper functions that require additional functions for linking. The
>>>> reduced set of the linux-user functions works fine as stubs in this
>>>> case, so change the #ifdef statement accordingly.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    target/arm/tcg/m_helper.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
>>>> index d1f1e02acc..a5a6e96fc3 100644
>>>> --- a/target/arm/tcg/m_helper.c
>>>> +++ b/target/arm/tcg/m_helper.c
>>>> @@ -22,6 +22,7 @@
>>>>    #endif
>>>>    #if !defined(CONFIG_USER_ONLY)
>>>>    #include "hw/intc/armv7m_nvic.h"
>>>> +#include CONFIG_DEVICES
>>>>    #endif
>>>>
>>>>    static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
>>>> @@ -69,7 +70,7 @@ uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure)
>>>>        return value;
>>>>    }
>>>>
>>>> -#ifdef CONFIG_USER_ONLY
>>>> +#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_ARM_V7M)
>>>
>>> This looks a bit odd. If we don't have CONFIG_ARM_V7M
>>> why are we compiling this file at all?
>>
>> We'll get failures during linking otherwise. target/arm/helper.h still
>> defines code that requires the v7m_* helper functions:
>>
>> /usr/bin/ld: libqemu-arm-softmmu.fa.p/target_arm_tcg_translate.c.o:
>> qemu/target/arm/helper.h:76: undefined reference to `helper_v7m_vlldm'
>> /usr/bin/ld: libqemu-arm-softmmu.fa.p/target_arm_tcg_translate.c.o:
>> qemu/target/arm/helper.h:75: undefined reference to `helper_v7m_vlstm'
>> /usr/bin/ld: libqemu-arm-softmmu.fa.p/target_arm_tcg_translate.c.o:
>> qemu/target/arm/helper.h:73: undefined reference to
>> `helper_v7m_preserve_fp_state'
>>
>> etc.
> 
> OK, but what we want in that case is either (a) avoid referring
> to the functions if we're not building for V7M (as you say,
> may be awkward) or else (b) stub versions of the functions that
> abort() if called. We don't really want the linux-user versions
> of the functions.
> 
> Does having an m-helper_stub.c which we build if not CONFIG_ARM_V7M
> and having m_helper.c only built with CONFIG_ARM_V7M look
> feasible?

I gave it a try, but then we end up again with the problem that I already 
mentioned in the discussion about patch 1: CONFIG_ARM_V7M is not set for the 
linux-user binaries, so m_helper.c would not get included there anymore and 
we end up with lots of link failures.

So if you don't like the current shape, I guess this needs a little bit more 
pondering 'til it gets acceptable.

But could you maybe at least pick up the first patch already? ... since it's 
a patch with lots of code movement in it, this is quite ugly to rebase it 
each time someone touches some lines of code in that area...

  Thomas


