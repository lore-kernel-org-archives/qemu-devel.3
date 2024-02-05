Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A9AC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 13:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWytm-00071f-Bw; Mon, 05 Feb 2024 08:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWytk-00070o-MZ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:20:32 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWyti-0000zH-9T
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:20:32 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a30e445602cso1121527066b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707139227; x=1707744027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMFog3VK/EdPKpm1Du87+mdNAZmskRVnC3K69Cf1OQ0=;
 b=sO5NLLdN616BlGOK0vm6cyyFK+2F+oFLd3mk/fS0Vf82fZxM65oikSCHC368fw3E/Y
 AYxyiRVoz0QxP8GLk24KyEz8Id6L9vt9UhkNyI0OEchE5HwXx8haFbw49rOzJ4S0ObZw
 vOFjvydILKGSToe3jW9serZMyrsYqOOnYsU0Wt0AfF4G0kTMLK5edT44XQ9AMwXOJI21
 Ld4F+878asTDDvOOjuYcUm6wLB8zaYwovd//PRyfzg+iH7STQgkB++L+IG6dLrs+hVFt
 4iGxmZw0ScK4HxLk+1ntep/hqAef+ohdicXFMMCexwihTCw5yY7Wb6MEO+U71N6to+Q4
 0Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707139227; x=1707744027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rMFog3VK/EdPKpm1Du87+mdNAZmskRVnC3K69Cf1OQ0=;
 b=XdD6diMV46t0fqBrANRdYrMVpFnI9FKlpMmB92IT8qQtUkyUn/rT7U+/lRJlVUn5qN
 ulAyDrDxBd0eWDVW8O/lz0Ki+7Gm1u8emibl8Pbv4ZRu0aekYGjjR7ihNLl6mDNk7RWK
 p0iL9z0xblfKHDh4wTwEqkQWjWW9j/ut8oZGEfjnr5ofxdaUdQbaBBZpZAKEtddvujoE
 SONvA/hlW+DVgJv8rCHDohrUOvuke9PibRM1RqpuV1T654B76TCgnA0YPlpwvbLgkDLb
 r0NPAkeUlVRRgaNTnVaI1iRPLAktAuqY7+i1ajvVzaRYvZwVcXCLFMN1a3uplsjSk1v7
 imRg==
X-Gm-Message-State: AOJu0YzfD58Z/Rfvp0Kib4hKIquoTz/zU9qEIsB+rVhWOmtvehzBmjtG
 QXl+Ii1hTSfs4Z86dWoWfgm/6ZOyuYbdW5io3CjidFWwSwstLpsC7+gNUCDsNcc=
X-Google-Smtp-Source: AGHT+IEbRZsQdNjzPXtm9NZhl5l/SAlVzSspYZALHkHsrWasRR3Bj3BP2Sve7qRYW9B0W+fNRXgkfA==
X-Received: by 2002:a17:906:379a:b0:a36:6570:655 with SMTP id
 n26-20020a170906379a00b00a3665700655mr5871394ejc.14.1707139227358; 
 Mon, 05 Feb 2024 05:20:27 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUtKezGxD/aMbI5VKBN3WI5/TucpdISM+q+grpyTcYGGrmMnfpPE0nODWUPE8DHgYPIi5wQCzKVVsIcRk08yBz7WdPvzhKtW2jmvI60YAszM4eSGREq7MJt8j09utxPj2dnhKmcIM5QiQdQzKPtKHPI54/TUv1QW0o+TsnwyW9aZCDL/G17+myrxjjx3JgtKZxfNBmFhV5bn5pVc9bTWKP79M4yQVBC9MjkDSu+SFtt
Received: from [192.168.197.175] ([92.88.170.125])
 by smtp.gmail.com with ESMTPSA id
 fj6-20020a1709069c8600b00a371eced193sm3809761ejc.49.2024.02.05.05.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 05:20:26 -0800 (PST)
Message-ID: <46d14718-2b2c-45aa-aa12-854a2704383b@linaro.org>
Date: Mon, 5 Feb 2024 14:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 2/2] aspeed: fix hardcode boot address 0
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240205091415.935686-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Jamin,

On 5/2/24 10:14, Jamin Lin via wrote:
> In the previous design of QEMU model for ASPEED SOCs, it set the boot
> address at 0 which was the hardcode setting for ast10x0, ast2600,
> ast2500 and ast2400.
> 
> According to the design of ast2700, it has bootmcu which is used for
> executing SPL and initialize DRAM,

Out of curiosity, what architecture is this MCU?

> then, CPUs(cortex-a35)
> execute u-boot, kernel and rofs. QEMU will only support CPU(coretax-a35)
> parts and the boot address is "0x400000000" for ast2700.

OK, but I don't get how you get from here ...

> Therefore, fixed hardcode boot address 0.

... to here.

> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 218b81298e..82a92e8142 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -289,12 +289,14 @@ static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
>                                       uint64_t rom_size)
>   {
>       AspeedSoCState *soc = bmc->soc;
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
>   
>       memory_region_init_rom(&bmc->boot_rom, NULL, "aspeed.boot_rom", rom_size,
>                              &error_abort);
>       memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
>                                           &bmc->boot_rom, 1);
> -    write_boot_rom(blk, ASPEED_SOC_SPI_BOOT_ADDR, rom_size, &error_abort);
> +    write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT],
> +                   rom_size, &error_abort);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }
>   
>   void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,


