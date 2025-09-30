Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C607CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bS2-0005Oz-S1; Tue, 30 Sep 2025 10:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v3bS1-0005ON-5A
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:35:33 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v3bRu-0006x7-Sg
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:35:32 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2680cf68265so50249405ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759242919; x=1759847719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=2u8eSA36ng4yrCKlXQwBgi/qV5B7zVo1ZXCuMZim9EI=;
 b=XSynVO/ZP2qIni6uptqSIjlEXkoA7/uikRM533oktmcqLfM1tnbYOjEbOYd5DFqSre
 qH1BOrfrvfkfhgJ1KUVjISqvFMi8GBZd4AbxoDnDg07MyYDuwHFD0+Gmcvat8rPZYOj0
 5QIoSoZ+9zhFAuEJVKNVppLnsDOy1M5fsZT570+ZdTMDfV6WQ+6Fu6gYUy+tO6A7ejge
 OCmmjzbLjBzfTzJIKCfNMYmljmnWg8V+vDVXj6dx/Eb2a24Pb7LOai6lEOxoBbptdd13
 H3i1gvWLVsjwF/hVBPS6RCFVwHZyf0fGL6KansN+ijwK6sNYEKzQ1ZnFPkhLlHN3XtXl
 c6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759242919; x=1759847719;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2u8eSA36ng4yrCKlXQwBgi/qV5B7zVo1ZXCuMZim9EI=;
 b=n4E/eHAnjCeEJJaOVF2v3kwkcyyUuvfJxcJEvXO6jM9SzbmCbRQVORY805LFf7j7O6
 l+YIQGNdA2+d37c1i63S6riik4othhggqbRzh0eMhLuoeQuVwCwxUQ6nYni2cZsXUKKB
 rlA3wNuwpAuiLhhJ4vTPAfsv/GYcgEI9GZGPcwCNAABDX/luXGeonwXpKfQpQmS3rHC8
 l01ikNifMgb4Suy+fHgWdv8aHsEGt8CtafIvFScsv2jAhnOadTKLvCao6P3RlOWEr4aC
 dgcr2ZvobVzcOqkzgJSjVc+4pwObHTw/1rdl2UcHzDdw5gI8X0XhK7G3PeMq3uvWP0nw
 7Hvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbjVGdlESVSiTRTiqOcFuTdpQKvJ7/NG10LyCozQ67RJkc6HyCAJDPECXnzbFwX+bRAWLp88ZapVsy@nongnu.org
X-Gm-Message-State: AOJu0Yz16qlz4BLSR6/d1CaKMz8hmclLH1C2c1beqputSYnyZppd1/Fv
 aY0E1Fiy1N1iki0Ybf3hHAyPR6Zy/sSXSV8N/GIs7zJ7jjvD4WsSQfbi
X-Gm-Gg: ASbGncuw4nFx7HdXAa1lKXl28kDTHqilo3DkrajLdZtFp6qQ9HTf/QITCGsp+NBmHyo
 i4Je1PWtNejOMf2OgI8lciwT2DaReQO9kxpSBEX0dVnAJ9Gb49eMQia9krAw5eEXoYprF+S2sWc
 AQpm7s48RdOyL3hb2C9HTMDK7FJvJ4mdq4L4FdTW+LJ3dIkh1Hrmdy/PclnTXZeNcx1IslGA4gW
 S66ma4NWHTc1Jomqc5sv5VxCRn9pFxctnTtLD4Sxs6kSHLcetYw00rEBU8BMj0RDFxBwjhvek9d
 36zwrgsKQGrGTXIsDEXIdVcUAohfRvNayQEox8D3hoZb6ifZDIibOWyuHVvUIOPgEHvKPEG+Fm5
 bj1Epi7Y63yqwwcmLfa0yZ40+gs3dHd9q8fGDe0pRlZJTVjpYTrfQ1XYO0UxE4TzqdIKz/cR+Wq
 9/Ku9sFUBrFJco929zEVLXh4dvbcG/lA==
X-Google-Smtp-Source: AGHT+IHmL0tt8wwwPkGHPBtjywQ+GSkVcdbD1ZJd5qC6SgXRm3aAIxUksBuUPS6hX89RQGVgHbqjDA==
X-Received: by 2002:a17:902:f64f:b0:273:7d52:e510 with SMTP id
 d9443c01a7336-27ed4ab37admr252040565ad.58.1759242919135; 
 Tue, 30 Sep 2025 07:35:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm13832585a12.9.2025.09.30.07.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 07:35:18 -0700 (PDT)
Message-ID: <69494307-46ce-41b7-b8ee-c7e0aa462566@roeck-us.net>
Date: Tue, 30 Sep 2025 07:35:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Add Supermicro X11 SPI machine type
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20221025165109.1226001-1-linux@roeck-us.net>
 <dbea5c97-071e-4d7c-a022-8cd5d9cf6171@kaod.org>
 <e6ad0500-29b5-422f-a584-34d33a5e9a0a@roeck-us.net>
 <e493e89d-d161-4c5b-abf2-053034aa82b4@kaod.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <e493e89d-d161-4c5b-abf2-053034aa82b4@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/30/25 04:13, Cédric Le Goater wrote:
> On 9/30/25 12:08, Guenter Roeck wrote:
>> On 9/29/25 22:55, Cédric Le Goater wrote:
>>> On 10/25/22 18:51, Guenter Roeck wrote:
>>>> supermicrox11-bmc is configured with ast2400-a1 SoC. This does not match
>>>> the Supermicro documentation for X11 BMCs, and it does not match the
>>>> devicetree file in the Linux kernel.
>>>>
>>>> As it turns out, some Supermicro X11 motherboards use AST2400 SoCs,
>>>> while others use AST2500.
>>>>
>>>> Introduce new machine type supermicrox11-spi-bmc with AST2500 SoC
>>>> to match the devicetree description in the Linux kernel. Hardware
>>>> configuration details for this machine type are guesswork and taken
>>>> from defaults as well as from the Linux kernel devicetree file.
>>>>
>>>> The new machine type was tested with aspeed-bmc-supermicro-x11spi.dts
>>>> from the Linux kernel and with Linux versions 6.0.3 and 6.1-rc2.
>>>> Linux booted successfully from initrd and from both SPI interfaces.
>>>> Ethernet interfaces were confirmed to be operational.
>>>>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> Hello Guenter
>>>
>>> Would it be possible to contribute a functional test for this
>>> machine ?
>>>
>>> Since this machine contributes little to the Aspeed models,
>>> its value lies in the firmware it can run to exercise the
>>> models. Without functional tests, I plan to schedule the
>>> removal in the QEMU 10.2 cycle.
>>>
>>
>> I use it to test the Linux kernel. Nor worth enough to spend more time on.
>> Just drop it; I'll drop the respective test runs.
> Can the FW be downloaded ?
> 

I have no idea. I only test the Linux kernel (more specifically, the Linux kernel
drivers). I already have to work around issues with the board that because the
Linux kernel no longer supports the Macronix flash on that board as emulated
by qemu. My patch to let me specify the flash model for aspeed boards in qemu
was rejected. So I already have to carry a downstream qemu change to support it.
Obviously no one else uses/tests it, or they would have reported that problem.
So you might as well drop it.

The flash problem is also seen with ast2600-evb, making me wonder if that board
could/should be dropped as well.

Guenter


