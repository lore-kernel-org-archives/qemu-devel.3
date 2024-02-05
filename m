Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE052C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 14:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWza0-0004Fw-9s; Mon, 05 Feb 2024 09:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWzZu-0004FJ-DT
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:04:06 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWzZr-0000Jd-SX
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:04:05 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso5379288a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 06:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707141842; x=1707746642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RhzBM03iuYGJapSmajdfOvxaccvCR3jZDmUfTcGvZoQ=;
 b=H+j/fl551/3zaS3CzjasbUAVlPf6QJbh4FWGlWiaLgwvL6i2JSpC1TYm9pfgyiZJmu
 rJUpRCIFK2HVHBXyHf+gsK+pkVJc7srp3AAo9n1BaELskn35aeKsH4upKZfnw2rP1H8B
 UR+GLspnn3MIxCd79GOYfliX99JOjd+nqGQ+D7zvxiFaw/7zaV4dh3aQ8cnaxxYO3jSN
 HRZtv9gFnjuHgglC04IBZrj9Jd8K2SA94jQ80BUducgDmkWTGaSdqnUpUhhnZik33/Gl
 Y+xRHzAXv+2dZYR+yhcWvCTVdXg/72+1EynVMib9l4aIvAaD69pAPh4d8p2lYzB3sOwT
 aOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707141842; x=1707746642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RhzBM03iuYGJapSmajdfOvxaccvCR3jZDmUfTcGvZoQ=;
 b=S+uJG05l9fCdvqqBnspW0TxUpU5X4cu5OqppQA8EAZghneuEjs+odYPOW5OJpAhecZ
 wDAcwbM8+68oaR8DHCS5aC4yyAbE/ZIH3JA293v5sxrZKSW3VXv81WjpA5veIVNIqj7d
 uPN9VdgefGn8TOIxN2f9JOKjW4PGa4NQJOQSp/CRA5mMaF5ORKwIM2pgGf8UVVFaT5sp
 8N8tCvH3GaKESIBjY41EBWyj3kCYjNKPjD5a5sGbZubqbhfscsFcl3po7dhEdMH1RZx2
 xLknB+JjMq+1INv6V07ofhB1Fe8IT8knmYpka+ConrWUE0jzTm7WBf5pEAQGMK7H0tom
 KigA==
X-Gm-Message-State: AOJu0YxZdCvSd1YeQUDos3lKy/02k5Is0vhQ6KIcjG8qture/uJJxOi4
 RMPVqJelAfOQcONTKGkqMCB2ckr/sPSA+3eAbGHKq4TyQ4ofTAZFuwPnUmv6K74=
X-Google-Smtp-Source: AGHT+IFy62wQxe7zvrthh0x/4ZNvYwDfZf2UClR8Aw8+8CKjWZ8RZzu4ITDWmInP0ugNhYbxl+VgXg==
X-Received: by 2002:a05:6402:5245:b0:560:5d7e:4061 with SMTP id
 t5-20020a056402524500b005605d7e4061mr2612761edd.29.1707141841944; 
 Mon, 05 Feb 2024 06:04:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXIWNZBuxzeRp7c2tz9tmaGe/oJUFBhTJE0rEJGvRcHB9joYcvYwGeoBGNIaLtRcnEP43cpq3pkb1d6ORIRBy6Yra9W/WTvbRHYrlHmySbr5wawbi6jj2h4AkAKes05GPigUExp8/QzeZe13YE9ngalhNIMouQ4Sn6/TaoE1y2VorYgVWtfsMm/HQcRp9177XHqv92QCP6aAfCW8DeDILMEZuYKGelrQBiCBSzqGVCO/NIyQhKLOV9HxTGOJoujtpNMb0IDnlPqzct3rZb/Aeq2Z+KTiwnj7ZUvfp5um6EnJuUHpivWVnbnXJzE1UOIHaxYVAtKZg==
Received: from [192.168.197.175] ([92.88.170.125])
 by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b005606b3d835fsm1002764edp.50.2024.02.05.06.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 06:04:01 -0800 (PST)
Message-ID: <f20a325e-7998-4065-b4ed-d43da7d4b5df@linaro.org>
Date: Mon, 5 Feb 2024 15:03:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add device DM163 (led driver, matrix colors shield &
 display)
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Hi Inès,

On 26/1/24 20:31, Inès Varhol wrote:
> This device implements the IM120417002 colors shield v1.1 for Arduino
> (which relies on the DM163 8x3-channel led driving logic) and features
> a simple display of an 8x8 RGB matrix.
> 
> This color shield can be plugged on the Arduino board (or the
> B-L475E-IOT01A board) to drive an 8x8 RGB led matrix.

Nice. Do you have an example? Or better, a test :)

> This RGB led matrix takes advantage of retinal persistance to
> seemingly display different colors in each row.
> 
> It'd be convenient to set the QEMU console's refresh rate
> in order to ensure that the delay before turning off rows
> (2 frames currently) isn't too short. However
> `dpy_ui_info_supported(s->console)` can't be used.

Cc'ing Marc-André Lureau.

> I saw that Kconfig configurable components aren't visible in C files,
> does that mean it's impossible to make the DM163 device optional when
> using the B-L475E-IOT01A board?

You could (but shouldn't) use for build-time:

   #include CONFIG_DEVICES

But better at run-time using [module_]object_class_by_name().

> Based-on: 20240123122505.516393-1-ines.varhol@telecom-paris.fr
> ([PATCH v3 0/3] Add device STM32L4x5 GPIO)
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> 
> Inès Varhol (3):
>    hw/display : Add device DM163
>    hw/arm : Connect DM163 to STM32L4x5
>    tests/qtest : Add testcase for DM163


