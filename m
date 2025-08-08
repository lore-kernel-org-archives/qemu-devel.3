Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB85C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTSg-0001oV-KK; Fri, 08 Aug 2025 16:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ukTSb-0001lq-92; Fri, 08 Aug 2025 16:13:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ukTSX-0007F5-Ph; Fri, 08 Aug 2025 16:13:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76bdc73f363so2507565b3a.3; 
 Fri, 08 Aug 2025 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754683979; x=1755288779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=CqcAcp9Y/0mTvAESsvSkuGhtwb6vFv5pOqiTj6z4VsE=;
 b=Vz5PfLOXr+Mw2rVjO5SRfeBCuJvdyBTHHCfCNh7EuidxelBRCEVSDfHFJwObsgzT7H
 AaD7M4EvXkPPu8AnV5Uj6ZoZRpP9cadaolwvutRBaW4jn1URCYKPsspWOFYw5odcw+OH
 6TmKfK6ZLv+jxSqLkcY/9+gTKIHUEwdt+lhk8eWDismUfdLMNfR9DCVHoDylWa4OFoZz
 cst1EuJPMNgV6gyyXfI+AtxTX4xONkXlUSlXM6Kz1ekKReaRfN0cHut6Jj0JDI2Sq1cn
 llPDIvLPmTXByWUiWrSTObZz2LCSUO6m5e0BE2ZxpQs63OY0NDOoD0IZCluw8ARAQ7An
 /gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754683979; x=1755288779;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqcAcp9Y/0mTvAESsvSkuGhtwb6vFv5pOqiTj6z4VsE=;
 b=cZIwje6VAbyXuEtTEaiWYd2g3uhYqJtUYowmaZRwg4TDL0P1TT6QtG+uGUrMUt3f+G
 LirJnnJfzhqf4JHj9IvPE51VFZjaywjnagJGIt+xr9hBCAARhVHWxCAPRtNjmR6OB4me
 DkrwfmAF8eBgxOuPxin25kCmCJizgPX5K1Y6uKlYNS16A7MUIsoWgOiyOM/9pRQhSPkf
 VTbcgKb7KMMuq2u0NyTSACuKWu/y6AdUL0tjY4pZvIHwOlVbPEZDOCH5uRbNuhySYnAJ
 27g7IgD7xTN5MLVQBu4KaUnQ0AKmUh3SL8bqlUx2n0s7nk2S97V6N3zoW1bmD/gCDaZE
 IF7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6tLOsGsB5g/h1N2xF/HufdX2yAenvze7J6KxR1f5tSeHs2VKUDRZ5rxUg96Pqztn3RysPEpreT2/Q@nongnu.org,
 AJvYcCXBgZEwmeZANcJlYuHbENrgopL+IsR6mz06DHLAsNTMj/+ZgSw+OVok3zXTHVmbtyjry5GiltYFwXwMiA==@nongnu.org
X-Gm-Message-State: AOJu0YxicHZuGgje4zLEsuhHX2LAlLPpZTSfZZNOiIjM4HVlDEpgXMd/
 bMnxxR5hlODW9OyHNh/4cHUaCT2WZpI0SXJtgkZjtZOxgAu3DBx4t/nq
X-Gm-Gg: ASbGncu9tB93WwT8nmeG4H8zbBjLYZwlQtW4Z59nzHudFuTPG0RLtNVJ5MIP/bJUs77
 l6wngqh6tfZk0JJ2UCgmkOjuqnrP6yj8oYw0tWlXH8vaEJOnObIdqGK0AEQWJHiBhhqbGy0vZqU
 zvU35DR/lbUYVHzxYdiu0WNNP73SiKcVjRUKZR29EjhWBkK6Ur/UOsMHPsRjE/dvuvLn4Gx+53I
 oU9QfbSsMdHDHLF3TnX80qIfKJAhXcEYDCQc9WF1LWkdzgO/neZ5LygYF74qhYiYFCO8Zj71dns
 dj6+KbaagmiA8YbvM7SQWHL8GUfvTSkmeVFd0EM1pRc/VWlXvUr2IElI/iUUW9EWguelidN9MWr
 DgeloGMn60jSQLvO7BlT1bo81GmG8cc9jGVu73uBtSWemLf48jrGGg0MTmi4hT1HgjdhyBQg=
X-Google-Smtp-Source: AGHT+IFZrYuorYr8pRsvCRUbo8gPJbJE9DamwhzJ9b1qixJ6BI8ISA4EC9Pde5fTFHJWMcFVsnpACg==
X-Received: by 2002:a05:6a00:4b53:b0:76a:d724:d6fe with SMTP id
 d2e1a72fcca58-76c46176c9bmr6215107b3a.11.1754683978381; 
 Fri, 08 Aug 2025 13:12:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd4893sm21000034b3a.107.2025.08.08.13.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 13:12:57 -0700 (PDT)
Message-ID: <6466150c-c4aa-41a0-b362-7d47b92fddb7@roeck-us.net>
Date: Fri, 8 Aug 2025 13:12:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/2] hw/sd/ssi-sd: Return noise (dummy byte) when
 no card connected
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-block@nongnu.org
References: <20250808135115.77310-1-philmd@linaro.org>
 <20250808135115.77310-2-philmd@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250808135115.77310-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x429.google.com
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

On 8/8/25 06:51, Philippe Mathieu-Daudé wrote:
> Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
> code") exposed a bug in the SPI adapter: if no SD card is plugged,
> we shouldn't return any particular packet response, but the noise
> shifted on the MISO line. Return the dummy byte, otherwise we get:
> 
>    qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>   hw/sd/ssi-sd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 594dead19ee..3aacbd03871 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -89,6 +89,10 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
>       SDRequest request;
>       uint8_t longresp[5];
>   
> +    if (!sdbus_get_inserted(&s->sdbus)) {
> +        return SSI_DUMMY;
> +    }
> +
>       /*
>        * Special case: allow CMD12 (STOP TRANSMISSION) while reading data.
>        *


