Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6871CC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Yf-0001UL-5g; Mon, 19 Feb 2024 09:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4Yd-0001Tu-CH
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:23:47 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4YY-0001yK-Go
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:23:47 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d23a22233fso12484871fa.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708352620; x=1708957420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mnDDTtlItDfPp9YM6wZ4fhPF4cOhRwX1C0WTfTez+m0=;
 b=BH/tJhZoxIo9JlaWpo2O1XaIKCSYOs929dQ8KZUw0T1pmvti+6xaCIzlyyYlf/n+8I
 xr2t29Ne38e4SkZwuZjaozFXEsbyEdgj76DW+xiWSvFlXuJzsIWzTdUrIm9ofkH1peTE
 Y/68clNNvCMmsWnwL0to1i2cU8y9lwl+c0PNdsF4aVrXZ3M79FSMo6y/qs0Ewtpj7NkE
 xzWWUncaBmQlYm5CtpQgyRf1+wdlYwGSfC8LTtgdD3inFKSS7qVq1QauNlcLHBsKI89m
 CZE4nVfpiDqVVZJk8MJkSdYr44OUX48XAKyg/v+yH/UU5cSFCJ2lplt9PkQgMJi39W8P
 RvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708352620; x=1708957420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mnDDTtlItDfPp9YM6wZ4fhPF4cOhRwX1C0WTfTez+m0=;
 b=RMzUN8QHPHZlZzOsNSAW7bwd59LTOmJlIhMi/UoOyK+Rdtq3HPoNGIrpsSksEL0LZY
 11G/uEm+zJCgTdwl0h3KvUggnaZJFxV7X5K+7bHxFRcZmo1CyLWrZH/oO6MLIbYS5xKO
 HM5pS+8mBjQI4Py+8/c/byyhk3k4jjbY0XNu3gb8P767ByJ98JWYpS41tcCIEhm1V7Mi
 IsosYUA5nxVAUvDgYm6xBxU7lU7FWAa0clrRZxVnjJr7idK12WOiqsi2Sv/NP+zgwGFd
 uyNiYgpjS4L5BG9ZGeS8PHKuAFiW9B+HbTeI1OIn7t9ggpdxT0MAUXpuzcmLgyd1O5oe
 /DmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwYkIntonRr6qKW6KJ07k4QyFf7eMWJeV+51SQNtPxabpaUulFqAdXZynEy5yGYUJzXsnP+VKctVdnrq1CWJlNefuYmuc=
X-Gm-Message-State: AOJu0YxkOOqGG2jJ4djcC1cF6Dmi6Yu6cZ1IBpqdXGsTJk4CmOIuuwp0
 NhEsq0CUqJFwa4ZNinwMWedtcsz3kSS7T8rTyEIE2LmhfELz9u5rSR4hnBXGmJQ=
X-Google-Smtp-Source: AGHT+IEqpZ5zb0feebO8red8/Sw1NYW1UodRBiH/bxq1MisB1DILduX4ZjniHvxcNj577PKlT0HjAQ==
X-Received: by 2002:a2e:8546:0:b0:2d2:4474:2e69 with SMTP id
 u6-20020a2e8546000000b002d244742e69mr100766ljj.9.1708352620437; 
 Mon, 19 Feb 2024 06:23:40 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a05600c45c600b00412696bd7d9sm1590167wmo.41.2024.02.19.06.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 06:23:39 -0800 (PST)
Message-ID: <ff91fafa-1f6d-442f-adf5-f7a6e108cea7@linaro.org>
Date: Mon, 19 Feb 2024 15:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0a31f410-415d-474b-bcea-9cb18f41aeb2@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 19/2/24 14:33, Mark Cave-Ayland wrote:
> On 19/02/2024 13:05, Peter Maydell wrote:
> 
>> On Mon, 19 Feb 2024 at 12:49, Mark Cave-Ayland
>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>
>>> On 19/02/2024 12:00, BALATON Zoltan wrote:
>>>> For new people trying to contribute to QEMU QDev is overwhelming so 
>>>> having some way
>>>> to need less of it to do simple things would help them to get started.
>>>
>>> It depends what how you define "simple": for QEMU developers most 
>>> people search for
>>> similar examples in the codebase and copy/paste them. I'd much rather 
>>> have a slightly
>>> longer, but consistent API for setting properties rather than coming 
>>> up with many
>>> special case wrappers that need to be maintained just to keep the 
>>> line count down for
>>> "simplicity".
>>>
>>> I think that Phil's approach here is the best one for now, 
>>> particularly given that it
>>> allows us to take another step towards heterogeneous machines. As the 
>>> work in this
>>> area matures it might be that we can consider other approaches, but 
>>> that's not a
>>> decision that can be made right now and so shouldn't be a reason to 
>>> block this change.
>>
>> Mmm. It's unfortunate that we're working with C, so we're a bit limited
>> in what tools we have to try to make a better and lower-boilerplate
>> interface for the "create, configure, realize and wire up devices" task.
>> (I think you could do much better in a higher level language...)
>> sysbus_create_simple() was handy at the time, but it doesn't work so
>> well for more complicated SoC-based boards. It's noticeable that
>> if you look at the code that uses it, it's almost entirely the older
>> and less maintained board models, especially those which don't actually
>> model an SoC and just have the board code create all the devices.
> 
> Yeah I was thinking that you'd use the DSL (e.g. YAML templates or 
> similar) to provide some of the boilerplating around common actions, 
> rather than the C API itself. Even better, once everything has been 
> moved to use a DSL then the C API shouldn't really matter so much as it 
> is no longer directly exposed to the user.

Something similar was discussed with Markus and Manos. Although the
first step we noticed is to unify the QDev API -- making it verbose --
to figure what we need to expose in the DSL. Doing it the other way
(starting a DSL and trying to adapt it to all QEMU models) seemed a
waste of time. At least for our current human resources.

