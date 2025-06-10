Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD6EC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27h-0002ej-FG; Tue, 10 Jun 2025 12:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uOz50-0007cU-0F; Tue, 10 Jun 2025 09:31:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uOz4u-0007Jo-6P; Tue, 10 Jun 2025 09:31:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso6262443b3a.0; 
 Tue, 10 Jun 2025 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749562304; x=1750167104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=D83ZMV/OBOhR5IdQ3mEto+N/zVJ/IBBID58sIy49/fg=;
 b=eVf8eTOero7AEbds9o1S42yYsMS1JfhDYmm0JkGfdKydhWEyIJqXQB033fw7H9NEVV
 IrSm0VvNDLifHeMY22Z+buv38TuUqlsh+08LkIKHsWGf3V/Fgxiknu/N34x0vvVCttlI
 SKCDZc1RYAge0XL2u6cl54rABs2oIg+aZ2Dxm7sz18YZPUoj7xn6OZ+Z8q5pZwagldBe
 IjjbcR6mYmR7mQuAyBrTvxoDW5bTeoENMukaAg7XWDUZYVkHR/hElXmvSlnWiRY1mlpS
 AoWObOKVNIoO7RZYNKB0fASNRkxSLZ/28TLp/QdAlBWTKPQzeCG/mPp3Ycu+maOshjR/
 zXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749562304; x=1750167104;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D83ZMV/OBOhR5IdQ3mEto+N/zVJ/IBBID58sIy49/fg=;
 b=DE8ar9nCTc7V8wmSMGshIKsGj08G83+QBc49V+kM3gKLXXcliaFRi3uCwPIpOcM/NN
 sLdMX/IFf8QLDeaVgTNh51ve12GBhW1Gv9xgcfncR7C2Tku89avcTEYN2xGQ3bSAtvvL
 CZ461+UM8eoJPRu+uTcvWP7zy4irW4WxI6nemKsSS7baxY4f9jAkOusCIZpwGQK90t+J
 jbWJ6gktzF367EYHYkPtHkoT8L6pvzIYbonCqJUrSgFdO8KAM4RxBIGgW1BiERnl+l/h
 aR7mqMy+pdS1pZXjQmRlevOE40i3ATVlHCEf/T6puDDv6d2kfuCXt5C/iImQpJikZpO2
 7SGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpeIXxadYh3YEQmgbsN/5ah23ZzmbsCeAlLWVPpzGGLpbaUZjdS6Q/CEzja3R8xCyIiCSfVtheWw==@nongnu.org,
 AJvYcCXH+GYoQbuTDUGRcdlGURxUa3F/vBGp1sQ9PG2K8gFBIP4U7XlSgW6DuPdK+RPcWfZYp/3txudzESBMqA==@nongnu.org
X-Gm-Message-State: AOJu0Yz3VHCzpBIQKcF6vl51+AMFeiB121LwIzoHvQNWDKp9UqknT/SF
 1LZVeETGBgwhdpTQMrYT72EcMhjhtj22t/D6K5aInaa4ge+FncpKebvp
X-Gm-Gg: ASbGnct9usGfbmW5dbgAFUZduC8pi/nRGudNcOzQ7D0YhQUsmqx8sNoQaUvK0txwhB8
 WhDEA85l0bxjLb1iG3rA21mghoCVkpa7/wzy/WBXaTu9jBbDuujgO1LA66WVY58IIpu9NflLiEZ
 j2aUcaamZ6AWWADCtAzj15RBg4sDbRoGo6ep4N7AKCAMmidrCiintj428LJH4tS9X+v6wz2dB+U
 ETWo4Xc9OB7sch8zIWZFwnZBTzm67t5hIj0uLHAR2vjanVvnIlCCRJ7z9nefDXXMDrVj6y8YpKi
 Y2XE2DnvU9BCjxt30kSo3ttwYtMABa6ZhwfaCziD6AOE/X86zpiLuIE/EhbFGJUj77LRqreNbcE
 XPftWg5DLeftmjTQYGzod5kWw1OcyzRSMDls=
X-Google-Smtp-Source: AGHT+IGweIfZUn9qdmOSst/pMG5twNd4JhYiKe65VhizR+bAFIRtmJFlFXGxFweKCkQs2E0fhYfRag==
X-Received: by 2002:a05:6a00:2e9a:b0:736:35d4:f03f with SMTP id
 d2e1a72fcca58-74827e7384dmr22632646b3a.6.1749562304001; 
 Tue, 10 Jun 2025 06:31:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b084806sm7631345b3a.102.2025.06.10.06.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 06:31:43 -0700 (PDT)
Message-ID: <50464a50-1ddc-410b-bc5b-ec68b895b797@roeck-us.net>
Date: Tue, 10 Jun 2025 06:31:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/npcm7xx_boards: Add support for specifying SPI
 flash model
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250610012851.1627715-1-linux@roeck-us.net>
 <CAFEAcA-aznHrcSk9xfmLHkpJTiabjd4oX2KnvC5TXkkLgW6n8A@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAFEAcA-aznHrcSk9xfmLHkpJTiabjd4oX2KnvC5TXkkLgW6n8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.065, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/10/25 01:42, Peter Maydell wrote:
> On Tue, 10 Jun 2025 at 02:28, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> In some situations it is desirable to be able to specify the flash type
>> connected to a board. For example, the target operating system may not
>> support the default flash type, its support may be broken, or the qemu
>> emulation is insufficient and the default flash is not detected.
>> On top of that, the ability to test various flash types improves
>> testability since a single emulated board can be used to test a variety
>> of flash chips with the controller supported by that board.
>>
>> The aspeed emulation supports an option to specify the flash type. Use
>> the same mechanism to configure the flash type for Nuvoton 7xx boards.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> I don't know if there is interest in this, but I figured I should at least
>> submit it. Background is that Macronix flash support is broken when running
>> upstream Linux v6.16-rc1, thanks to upstream Linux commit 947c86e481a027e
>> ("mtd: spi-nor: macronix: Drop the redundant flash info fields"). I needed
>> a workaround, and using a different flash model was the easiest solution.
> 
> I think the question I would have here is "is this the flash
> device the hardware actually has?". If QEMU's using the wrong
> flash type, we should fix that. If QEMU's modelling the right
> flash type and the kernel doesn't implement it, then that's
> a kernel bug and the right fix is to get the kernel to
> handle that flash type.
> 

That isn't the point. Yes, one is that qemu's emulation is broken, the other is
that I wanted to be able to test with other flash types anyway. I understand
that this 'violates' the idea of exactly emulating some hardware, but I want
to be able to use qemu beyond that.

Either case, I did some debugging: For flashes with sfdp data (mx25l25635e),
qemu returns bad sfdp data (at least with quanta-gsj), causing the kernel
(as of v6.16-rc1) to bail out. For other flashes (mx66u51235f) it returns
no sfdp data, but the upstream kernel now depends on it.

NP, I'll just carry the patch locally in my tree. As mentioned above, I wasn't
sure if there is interest in this patch, but I wanted to at least publish it.

Thanks,
Guenter


