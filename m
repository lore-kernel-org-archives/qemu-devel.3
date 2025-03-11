Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DD4C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts287-0001wO-RV; Tue, 11 Mar 2025 12:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts22w-0004bf-92
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:38 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts22o-0005qm-DT
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912c09bea5so4760005f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741708882; x=1742313682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5bTxtXaZ8OvnQwJsXnxYAuIVZke0nDI0BltRhNRW6A=;
 b=YpRUuA3lbgyHq1oOpFDyIlxOs7n3EXKzP2WrJq2GwA/xl35m/JyXubMpWOlAON1Mw/
 rmF8NgwOTgJ1NXyzzE37XBgsc1jX6I1AWNhnG29onFudcVVelGlidkYCG+m0sbavNDSh
 SPJ/VCMXsJrVDUvUW02h4u0EMqOOkEvCgZxDmIf+xSAWVhXy5iGw6db/NQfLKeK9aZ65
 5RBavGs8aiLyEqWKPvPKsJQB8XuCJ5ya8gHr0As+yGYBoQZvg0TMn2dLZrvBEsEg0O6z
 xXiBuliDQmgEhJHmBwkaiekC8YWcqEG2elMZLCT6iC/dFFqWBfHovfaDbd/vL0Da8gUm
 YT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708882; x=1742313682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5bTxtXaZ8OvnQwJsXnxYAuIVZke0nDI0BltRhNRW6A=;
 b=BveHFiGtY2abQYbJRTFfFnfGWuRxuTjZY+TH0lxsLp8tlCurqhcF6HUKj2/XMoq4bg
 0oZf4ITI9APmNiy/fOkHwYUmJTFmYuP+VxrX8fNJ0a9halUJWlxdUlhdP0X126A2miO3
 MvqPkV+F7ToMjDfgNcDtJosvQrnJLJ5r/ixK/E5nFQgH1oVbdQOqD5cKlM57xbWs5S/z
 mC3c6sJZpNj3+f3N9WKVIcAurLJm0epeX41/dHhDAkvcETi8X3iF+ZOOjSKfyM8uY3eN
 kM3EsX2p4M1AiG2vkOu7WyxxDSC8Q7hpK3ZXnta1J+hMELggR3mpKy/SCXnBhQ/ROOm+
 a/Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1RV3rz8s1WfhtPgLWZgNmsXG8IcGlSKFUwPkMQycye/pZzhp9EOrko0LZOP7bBXw2j3Ay5JH6npcb@nongnu.org
X-Gm-Message-State: AOJu0Ywc/T8nzV6rYHR/GsIB7CL34dKJZW2C/akEGJgXjbrGNSVXaPFG
 1YtIyRF7Im5PycvxpBx0aVELmw8cV2PrwLPsvdfD+/roTmam223wwJpVKOnVAsg=
X-Gm-Gg: ASbGncstEbL7n8XtW33K7Mo1aF8T8RSFZbayaPYsT/3KOBI5CDUk5BevnyaQLzAHOg5
 BOSkxA3Xr+ctNhNCi8hSYLlkAOpP2HiBBzGFUelo13OfmGSJetxXMck4WgvweaI3YfcD6u3lw1p
 aofR/T6oTBJCmU1tl5RV3fXaA0LD5np2DxQ2Y19MlQosaVGIs+i8rOPPtFfpTe7O6ntMlLCrDBM
 lUd0HFjW1PqvlbdzUaRx1OhJhAJW1NveIM6S0TnVkdJNMP7ZMz3z/yIpiX1nqc1/3Xjeo6Wgqzj
 Iy55/XUgSe2iUU5KqRuLDT9vAqziitQcAd+U/kEC5XuyorMHF2KZgqNifEuBPuLI0KTSwiBeapr
 ZJ5qNuB0Jt/Ik
X-Google-Smtp-Source: AGHT+IEjvOpEIldroznvHw7cEdYvmp6lfzGXyGcGDOAEG/Opt2iXecXIbpKV9mwarxy4Kr9JX+WPxw==
X-Received: by 2002:a5d:64c9:0:b0:391:4835:d89f with SMTP id
 ffacd0b85a97d-39263ceba32mr4573713f8f.8.1741708881769; 
 Tue, 11 Mar 2025 09:01:21 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79adsm18309357f8f.7.2025.03.11.09.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 09:01:21 -0700 (PDT)
Message-ID: <efa9ef1e-6a3a-44e0-9732-762c1bfb4857@linaro.org>
Date: Tue, 11 Mar 2025 17:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
To: cminyard@mvista.com
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-19-shentey@gmail.com>
 <77E3F57E-95D0-4E2F-838E-5E0334651349@gmail.com>
 <1FBD5091-2221-4815-85CB-D98BE4F6EA72@gmail.com>
 <F2594DA2-F703-4F82-B07F-2D665329E1CF@gmail.com>
 <fa40fbaa-df39-40e4-8845-fd516df10b41@linaro.org>
 <Z9BbfyNSPBkH-gaf@mail.minyard.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z9BbfyNSPBkH-gaf@mail.minyard.net>
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

On 11/3/25 16:49, Corey Minyard wrote:
> On Tue, Mar 11, 2025 at 10:20:03AM +0100, Philippe Mathieu-Daudé wrote:
>> On 11/3/25 08:34, Bernhard Beschow wrote:
>>>
>>>
>>> Am 7. März 2025 19:18:34 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>>>
>>>>
>>>> Am 4. März 2025 18:53:10 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>>>>
>>>>>
>>>>> Am 23. Februar 2025 11:47:08 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>>>>> The implementation just allows Linux to determine date and time.
>>>>>>
>>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>>> ---
>>>>>> MAINTAINERS                |   2 +
>>>>>> hw/rtc/rs5c372.c           | 236 +++++++++++++++++++++++++++++++++++++
>>>>>> tests/qtest/rs5c372-test.c |  43 +++++++
>>>>>> hw/rtc/Kconfig             |   5 +
>>>>>> hw/rtc/meson.build         |   1 +
>>>>>> hw/rtc/trace-events        |   4 +
>>>>>> tests/qtest/meson.build    |   1 +
>>>>>> 7 files changed, 292 insertions(+)
>>>>>> create mode 100644 hw/rtc/rs5c372.c
>>>>>> create mode 100644 tests/qtest/rs5c372-test.c
>>>>>
>>>>> Ping for just this patch. I'd like to have it merged for 10.0.
>>>>
>>>> Ping^2 -- just few days left before soft freeze.
>>>
>>> Last ping before the freeze
>>>
>>> It would really be nice to have this device model in 10.0 since this would allow me to use upstream QEMU.
>>
>> Apparently I2C maintainer wasn't Cc'ed (now is):
>>
>>    Corey Minyard <cminyard@mvista.com> (maintainer:I2C and SMBus)
>>
>> At a glance patch LGTM, so:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Well, it's fairly hard to read this way :-).  But this looks good.  My
> only comment is on:
> 
>>>>> +#define NVRAM_SIZE 0x10
>>>>> +
>>>>> +/* Flags definitions */
>>>>> +#define SECONDS_CH 0x80
>>>>> +#define HOURS_PM   0x20
>>>>> +#define CTRL2_24   0x20
> 
> Those are fairly generic names; when I see things like that I worry
> about conflicting with other generic names that might come into an
> include later.  Not a huge deal, though.
> 
> Acked-by: Corey Minyard <cminyard@mvista.com>

Thank you! Patch queued via my hw-misc tree then.

Regards,

Phil.

