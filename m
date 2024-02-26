Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1801C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reev0-0003KT-TR; Mon, 26 Feb 2024 12:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeuv-0003JB-Nh
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:37:32 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeus-0006zh-JN
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:37:29 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a3f3d0d2787so329818966b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708969045; x=1709573845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m77qrk6Qff2gXkBKjtrp1WyNIuR8YB6oHKyVJarj7i0=;
 b=o1ICMXDOt2fzNYRNRDmut/27sI77xq7sq5eOuHpOvm/RmRXrKxCLqWFBE2Ef7vQ0BT
 o8FVzs8bb/N7rYmCl38mwaRlFpBp7eSh2em8yFFCrSyceHHlvljX/2WfGQ0sqbm8RNAs
 2DlFXRdi79lmQ3btem/15ds/3EWyJKGGBbcpDO+FdBNT/c1OjUe9dwJvCQFiW1+fHdYi
 V7x3mMiLzz505Pz9F6bB+WmQu+jXf4hSui3necvlB3eWdIX9HdiL6COvroYU8zFIy5Lr
 YXHBOlGUR2oc5d6VfptE/FbdsG18s6vPzqkJL7N62KxAuz/2pzoLBGEo6aEh9jn980oF
 ByOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708969045; x=1709573845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m77qrk6Qff2gXkBKjtrp1WyNIuR8YB6oHKyVJarj7i0=;
 b=iE5rFsnPVcccAFc7narEEuEuu0R9HTKZhMOXvPcDdeIkBygp1IEQ+tGEmP0HZNmtdi
 Bb3lpsl/gnDMJX+Yd3Dx9qYKh6cTrMGMB4u25BiqR9DV/T+/uB8KsLHXV42Q2iIjdD4g
 ymZ7THKY+YOcIYIw6w11TyiiweSOHuSOFI3J3vHfI+7phhd2h/4Gn1S0A5BTk/2XZE7x
 sSwpxwZatJGhW2w2IckLT3I+jh75iNTYVLeT9XXZSQVT6l3c6CrsXJxdokIJlm/S0IMZ
 40aTHSsjyLk3HIuR7eajQaUCQ19ZnHjmN2Q4Cr6csMQnSrQIz6oKnoi/fF/DlXZQb9s6
 RUDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRQ3gzTG/0+DtlEAb5/ByZKjtBo9B3qJETHWEZJB9+O1M4oxxh/M+bVQPaVhFPDeXYTOKFJ/1oZq3xxmsP0SmK1wXykkg=
X-Gm-Message-State: AOJu0Yzm0hVzCwK4Q+C0Yv6oC1QT22OM9uJ41DrJYr75VkOaCYFXblzl
 Zjv/CDCs8tRnIZxd1EJf0ep4Yf0hCrS49m7E0iK+c1WTIHp9Edr/KuLUv31Cds8=
X-Google-Smtp-Source: AGHT+IFGXBzF4RsP0r6hOzWjx6NVz650C+MO/PSYTkFPWzBZc890v54JFq4zQgLJPt1QZPAaUVEEHQ==
X-Received: by 2002:a17:906:1b4a:b0:a43:4675:631b with SMTP id
 p10-20020a1709061b4a00b00a434675631bmr2299525ejg.49.1708969044848; 
 Mon, 26 Feb 2024 09:37:24 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a170906305900b00a3eb1b1896bsm2579408ejd.58.2024.02.26.09.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 09:37:24 -0800 (PST)
Message-ID: <c5d5f835-5b7f-46bb-8393-6d638cbad012@linaro.org>
Date: Mon, 26 Feb 2024 18:37:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-2-philmd@linaro.org>
 <bcfd3f9d-04e3-79c9-c15f-c3c8d7669bdb@eik.bme.hu>
 <2f8ec2e2-c4c7-48c3-9c3d-3e20bc3d6b9b@linaro.org>
 <b40fd79f-4d41-4e04-90c1-6f4b2fde811d@linaro.org>
 <00e2b898-3c5f-d19c-fddc-e657306e071f@eik.bme.hu>
 <2b9ea923-c4f9-4ee4-8ed2-ba9f62c15579@linaro.org>
 <6b5758d6-f464-2461-f9dd-71d2e15b610a@eik.bme.hu>
 <bc5929e4-1782-4719-8231-fe04a9719c40@ilande.co.uk>
 <CAFEAcA-Mvd4NVY2yDgNEdjZ_YPrN93PDZRyfCi7JyCjmPs4gAQ@mail.gmail.com>
 <0a31f410-415d-474b-bcea-9cb18f41aeb2@ilande.co.uk>
 <9ef2075b-b26b-41d2-a7d0-456cec3b104a@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9ef2075b-b26b-41d2-a7d0-456cec3b104a@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

On 19/2/24 15:05, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Mark Cave-Ayland wrote:
>> On 19/02/2024 13:05, Peter Maydell wrote:
>>> On Mon, 19 Feb 2024 at 12:49, Mark Cave-Ayland
>>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>>
>>>> On 19/02/2024 12:00, BALATON Zoltan wrote:
>>>>> For new people trying to contribute to QEMU QDev is overwhelming so 
>>>>> having some way
>>>>> to need less of it to do simple things would help them to get started.
>>>>
>>>> It depends what how you define "simple": for QEMU developers most 
>>>> people search for
>>>> similar examples in the codebase and copy/paste them. I'd much 
>>>> rather have a slightly
>>>> longer, but consistent API for setting properties rather than coming 
>>>> up with many
>>>> special case wrappers that need to be maintained just to keep the 
>>>> line count down for
>>>> "simplicity".
>>>>
>>>> I think that Phil's approach here is the best one for now, 
>>>> particularly given that it
>>>> allows us to take another step towards heterogeneous machines. As 
>>>> the work in this
>>>> area matures it might be that we can consider other approaches, but 
>>>> that's not a
>>>> decision that can be made right now and so shouldn't be a reason to 
>>>> block this change.
>>>
>>> Mmm. It's unfortunate that we're working with C, so we're a bit limited
>>> in what tools we have to try to make a better and lower-boilerplate
>>> interface for the "create, configure, realize and wire up devices" task.
>>> (I think you could do much better in a higher level language...)
>>> sysbus_create_simple() was handy at the time, but it doesn't work so
>>> well for more complicated SoC-based boards. It's noticeable that
>>> if you look at the code that uses it, it's almost entirely the older
>>> and less maintained board models, especially those which don't actually
>>> model an SoC and just have the board code create all the devices.
>>
>> Yeah I was thinking that you'd use the DSL (e.g. YAML templates or 
>> similar) to provide some of the boilerplating around common actions, 
>> rather than the C API itself. Even better, once everything has been 
>> moved to use a DSL then the C API shouldn't really matter so much as 
>> it is no longer directly exposed to the user.
> 
> That may be a few more releases away (although Philippe is doing an 
> excellent job with doing this all alone and as efficient as he is it 
> might be reached sooner). So I think board code will stay for a while 
> therefore if something can be done to keep it simple with not much work 
> then maybe that's worth considering. That's why I did not propose to 
> keep sysbus_create_simple and add properties to it because that might 
> need something like a properties array with values that's hard to 
> describe in C so it would be a bit more involved to implement and 
> defining such arrays would only make it a litle less cluttered. So just 
> keeping the parts that work for simple devices in sysbus_realize_simple 
> and also keep sysbus_create_simple where it's already used is probably 
> enough now rather than converting those to low level calls everywhere now.
> 
> Then we'll see how well the declarative machines will turn out and then 
> if we no longer need to write board code these wrappers could go away 
> then but for now it may be too early when we still have a lot of board 
> code to maintain.

I'll keep forward with this patch inlining sysbus_create_simple();
if we notice in few releases the DSL experiment is a failure, I don't
mind going back reverting it.

Regards,

Phil.

