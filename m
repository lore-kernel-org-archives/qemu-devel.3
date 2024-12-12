Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB4EE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkxj-0000Nv-AV; Thu, 12 Dec 2024 10:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkwq-0007g9-Qe
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:17:54 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkwo-0004Lm-5z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:17:52 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so511224f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734016668; x=1734621468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9AYsj8wbPLwB1vnTIpQLmzJvuDr7STJmaU6AE1rjjV0=;
 b=PWH6qi22C6ArAc8kwAz3x8kBWtIFMrZNxFK+nqNr6ACc480U0UiQ4OMuI1iJMs2u8/
 +VleO++9AxMwleIO46n+bQ4oPEt/yWloO13DsaxCOtDcDuf97WIU5D+qQD0ejefm8gPC
 CDEPV+zGf71l6y5C36TZryL5DFKbVMAKfAmSWv3JIJLJYS6W8cmJs7wUuYzkW7SuVjs8
 jEn2jzUDBQVI8XNaN7si83M62xdJGALSW4qoA6VT7YETXGwesNfeXqA12BDbY/NFkgFg
 z4y/LjZewD+lI2Nvo4UYaOHSsV0i+rtuQ/TE7raSgInB7IO+6ttMQ5tC7R2gi12vQlea
 Y45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734016668; x=1734621468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9AYsj8wbPLwB1vnTIpQLmzJvuDr7STJmaU6AE1rjjV0=;
 b=OHvUzGo0y2UcxQ0KaD1dTUrrVyqLunmPQXRpUA9tYIH5d7v6vzueMElXnDOTzwBALQ
 CV3BElzp61tkaYV878N+3h3JPRXmYPxeBvqjUDpcI6k5wE8OefwgV4KLd3cdurs05tri
 LdVgIoHa+W+1IlIDlx12lb0lZkfr3e8p0nLqtFjV+6tJCulhGZy099ug3FCB/TP+J7Hu
 p9IwB22iUP8G5FFVHyilMRvS0fCFwvxUEOCqSd21+rzhQMX1JwiUPAwgMZW0iiAirtFe
 HWgMNRGLm078+VgMSCalLaewL2auTOwwt5JF/H55VpAo+z0RUGSkigZk35wf8Z5KiqJK
 JSCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjv4VvLHu5zJmwp7JCfR1ooDeE0+mJwFDumygpmKMHgI6Uhn8hHqXZpT9Si5qqa5DC3b4wsy7aN8Ao@nongnu.org
X-Gm-Message-State: AOJu0YwfaspO5n4NgD4pXutwh5K0b5ejXjsble0HpnegLZrO5SsZ9Ds5
 ZbbX0bjzasPAELau5TN7Nn16eSgnklNcGRnJy9kySPwCOGkhr8Fegk+x8CkqP3dmeBfaJ12UZcZ
 M
X-Gm-Gg: ASbGnctgmRRCUTkzDyK0Ua+4ugHopshDaXioNP5DFdv5i/RG7CUk9B7xuWOau5IB/O3
 HvAWiGUV92prU+t0t4KaypGRz3peaGp6DWyRKQY9msPTube2iwrwfpqWZ42JalUtI7xPWS/SIz6
 X7euq4vwf9G+qPLOgL+Xe8YKJyfgeeLNZdIurxPTMst9NHqBZn8Kn7b+wPFQLOqQ/Nm1qS5id6n
 woVNl2+ckbCPRl8ymD1czxRhnMoogGxX3BdA5z715hTs29pqP8TB42n7rGrMnStBUryE7tHSXq2
 iK8xuZGNCiKe2UOy8j2mArzU
X-Google-Smtp-Source: AGHT+IHZbPYPYsfRw/BzqJAocJOLXCcbIY7t32tEx3fx/pgiDGkGfxo6JxZS/PyV05pGDZq5Al/aPQ==
X-Received: by 2002:a5d:5f85:0:b0:385:faec:d945 with SMTP id
 ffacd0b85a97d-387887cdcbbmr2776726f8f.9.1734016668209; 
 Thu, 12 Dec 2024 07:17:48 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514dc3sm4245319f8f.67.2024.12.12.07.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:17:47 -0800 (PST)
Message-ID: <ad7c3026-e307-4ae0-a985-c447ffa68aa0@linaro.org>
Date: Thu, 12 Dec 2024 16:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qemu/atomic: Rename atomic128-cas.h headers using
 .h.inc suffix
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241212141018.59428-1-philmd@linaro.org>
 <20241212141018.59428-2-philmd@linaro.org>
 <ee831fff-eb0a-4e56-8eee-99222e55d707@linaro.org>
 <8c52c730-cc87-466f-b36e-270d738b86f1@linaro.org>
 <5e8c7bd6-4afa-45bd-af79-3e03b9e6075a@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5e8c7bd6-4afa-45bd-af79-3e03b9e6075a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 12/12/24 16:11, Richard Henderson wrote:
> On 12/12/24 09:09, Philippe Mathieu-Daudé wrote:
>> On 12/12/24 16:02, Richard Henderson wrote:
>>> On 12/12/24 08:10, Philippe Mathieu-Daudé wrote:
>>>> Since commit 139c1837db ("meson: rename included C source files
>>>> to .c.inc"), QEMU standard procedure for included C files is to
>>>> use *.c.inc.
>>>>
>>>> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
>>>> about includes") this is documented in the Coding Style:
>>>>
>>>>    If you do use template header files they should be named with
>>>>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>>>>    being included for expansion.
>>>>
>>>> Therefore rename 'atomic128-cas.h' as 'atomic128-cas.h.inc'.
>>>
>>> But these are not templates, nor included multiple times, so...
>>> I don't get it.
>> I wanted to avoid including "qemu/atomic.h" in each of them due to:
>>
>>      host/include/generic/host/atomic128-cas.h:23:11: error: call to 
>> undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do 
>> not support implicit function declarations [-Wimplicit-function- 
>> declaration]
>>         23 |     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
>>            |           ^
>>      1 error generated.
> 
> And why would you ever have that?

To have "not template" headers self-contained; but I'm fine discarding
these 2 patches and keeping the last one of this series.


