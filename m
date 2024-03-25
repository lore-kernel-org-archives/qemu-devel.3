Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE58BC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolp1-0002VW-Df; Mon, 25 Mar 2024 11:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rolow-0002QT-Jr
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:01:09 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rolou-0004t0-KE
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:01:06 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d49f7e5c2cso60141641fa.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711378863; x=1711983663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Uns4qRLM+EtfDyudRgUkK0bRRrqHa1Jc/kPFwBrqj4=;
 b=qhyOoNfn0GcvtORehpVy9DAMqRYl1Aax2lvHvzLkX54GJtnr1ucNzGpodRR4AYrH+o
 4+NpoxH5zCmRSWAQXgei49NzIOh1FX68fIM2pRbzjuv31RT6xJ3R7eki/RWi/XkFj9qq
 QQQPvztw+0hNBdaqulDaKEqcuC7TajfqloX3qktrOK+/IlRGcRhF6saBqzoxe9wnBhLr
 iERnYA+TcOZMb5VpVfo6EyPYZAwpDBL0kVRIe1wW1FAQ05uOnZ74Q5RqG1aqFoApfqXR
 AA+M2r7GGBByhbY25g/VLmCII+YAAZccrmIrWNwOFWJdO0+Ji+Y8IFkIwRDOQ/LAeYsX
 3tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711378863; x=1711983663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Uns4qRLM+EtfDyudRgUkK0bRRrqHa1Jc/kPFwBrqj4=;
 b=l+k1hbONZ7a30fW+5XvcDHoIwmCAdy66RZCZeeuomqkUVCI394xC/aEZvEPawquy1g
 O8l7vXzdAafMUQawHB7tGLB/4JuH+wmWnT6TEgw+IuOrjifkFE+VKMp3/3HM+JnnEdgH
 anAaB5EBXmaJEE2Xd1wP7yj0by3QhhCjhr4rgLB+j9WhLOuMXYlaPQh0stR439579CzR
 zXso12IfrIP+4t0ciqbfNPYsopWvwzbNo4mSKDS/RHFCEueqShpPxWePDyWx0ZxHZN7E
 XREnGGmFrbyv3sXlwEUlHbeKwLOydpqfaTqLypXxm4uPXNp7/3OJ2KbPWTQz6ey2Stch
 ykjA==
X-Gm-Message-State: AOJu0YyuBXYH9+s7OshPpTf+61ERPiauwHWdyU1X9OjZdc3sU2L/LJo1
 9PatAanezIhzQjWfFqzd6d77jB+OKanleOzYOOhPASPGLtcN40IdURJVt6xoS5A=
X-Google-Smtp-Source: AGHT+IHRZqt9FSAgRQiSpjVtPPhy1AtOYp7Bk94wlwjxoHBomK6wD3HTj/XCgwPEBXIagCIx5rpxzQ==
X-Received: by 2002:a2e:98c2:0:b0:2d6:9481:b38 with SMTP id
 s2-20020a2e98c2000000b002d694810b38mr5000140ljj.20.1711378862716; 
 Mon, 25 Mar 2024 08:01:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a05600c45d300b00414112a6159sm8603607wmo.44.2024.03.25.08.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 08:01:02 -0700 (PDT)
Message-ID: <c951c51c-3811-4997-b27d-deb8515b1539@linaro.org>
Date: Mon, 25 Mar 2024 16:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2 2/8] hw/clock: Pass optional &bool argument to
 clock_set()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?In=C3=A8s_Varhol?=
 <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20240325133259.57235-1-philmd@linaro.org>
 <20240325133259.57235-3-philmd@linaro.org>
 <CAFEAcA9aM8J+0RjYnvr8Xr8Q2j3w_TgxHO-gPDn8MaAcAUDynw@mail.gmail.com>
 <e3806179-47ed-4952-a7b6-c256a2aad197@linaro.org>
 <CAFEAcA_yyWKo7E1Vz2zQXnjetYWEXtt6mUyg+t4mJXt+nsKBgA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_yyWKo7E1Vz2zQXnjetYWEXtt6mUyg+t4mJXt+nsKBgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 25/3/24 15:44, Peter Maydell wrote:
> On Mon, 25 Mar 2024 at 14:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 25/3/24 14:47, Peter Maydell wrote:
>>> On Mon, 25 Mar 2024 at 13:33, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> Currently clock_set() returns whether the clock has
>>>> been changed or not. In order to combine this information
>>>> with other clock calls, pass an optional boolean and do
>>>> not return anything.  The single caller ignores the return
>>>> value, have it use NULL.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    include/hw/clock.h       | 22 ++++++++++++++++------
>>>>    hw/core/clock.c          |  8 +++++---
>>>>    hw/misc/bcm2835_cprman.c |  2 +-
>>>>    hw/misc/zynq_slcr.c      |  4 ++--
>>>>    4 files changed, 24 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/include/hw/clock.h b/include/hw/clock.h
>>>> index bb12117f67..474bbc07fe 100644
>>>> --- a/include/hw/clock.h
>>>> +++ b/include/hw/clock.h
>>>> @@ -180,21 +180,28 @@ static inline bool clock_has_source(const Clock *clk)
>>>>     * clock_set:
>>>>     * @clk: the clock to initialize.
>>>>     * @value: the clock's value, 0 means unclocked
>>>> + * @changed: set to true if the clock is changed, ignored if set to NULL.
>>>>     *
>>>>     * Set the local cached period value of @clk to @value.
>>>> - *
>>>> - * @return: true if the clock is changed.
>>>>     */
>>>> -bool clock_set(Clock *clk, uint64_t value);
>>>> +void clock_set(Clock *clk, uint64_t period, bool *changed);
>>>
>>> What's wrong with using the return value? Generally
>>> returning a value via passing in a pointer is much
>>> clunkier in C than using the return value, so we only
>>> do it if we have to (e.g. the return value is already
>>> being used for something else, or we need to return
>>> more than one thing at once).
>>
>> Then I'd rather remove (by inlining) the clock_update*() methods,
>> to have explicit calls to clock_propagate(), after multiple
>> clock_set*() calls.
> 
> You mean, so that we handle "set the clock period" and
> "set the mul/div" the same way, by just setting them and making
> it always the caller's responsibility to call clock_propagate() ?

Yes, for consistency, to have the clock_set* family behaving
the same way.

> Would you keep the bool return for clock_set and clock_set_mul_div
> to tell the caller whether a clock_propagate() call is needed ?

Yes (sorry for not being clearer). The API change would be
less invasive, possibly acceptable during the freeze.

> 
> thanks
> -- PMM


