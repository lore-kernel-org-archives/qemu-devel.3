Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDE4D46601
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQcm-00020v-SV; Thu, 15 Jan 2026 11:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vgQcl-0001xD-8j
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:55:07 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vgQci-00059R-7w
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:55:06 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-88a2d21427dso8484806d6.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768496103; x=1769100903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLRhVGOdg5V/uv5uiMv/GNaUiAjC9NuVJPhnG/IPl04=;
 b=Gt7E0d4ehwMew1QR+pf1PrlJML+y+6A6prqi6M7OAExbI9CcO+BBnqxm6wm4nFFgl4
 Ng3aIBkr8g2f2sRO5RMlh6kiQzpP60hLDQ2r1hcaNqr/KL3Du8geDie+ptFvdHNxE4zW
 fw5WFOxb0R0Xim/evdNjSI2ELR0+pOEGoeFPt8wBwZmgHA261xBJwOJRk7vksVO8qier
 QXFQy9TbdGOhvoAsqmn4icJd4dmsXsINDzeAaMNmaCUuUR8LjfBo2ANnCDdI5MgBokY3
 OhsU9M59AmdgwGdl9fhXYoeFbvbYsClIzwBcpQD01OdwMPFE+zvmZ/CnuAp22h/nQn3G
 VkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768496103; x=1769100903;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SLRhVGOdg5V/uv5uiMv/GNaUiAjC9NuVJPhnG/IPl04=;
 b=N38leNHWnGBPfb38uvBgcoJt1Ud0/rAQkUHcXUtl0+K435N8yRZ814nMiNsg0N/fTp
 ddQIJYa1Q9sZZJGUUsEXVVr1NUCLwynWvU++KAUBIw6uIa2ZqrHH0YVGvygpIU8wYjbS
 VOwtgkt0JpOv4Q5YE9jn3Hs5kUJ5yEZHigWpIYy2tGMaOFgrS6ev4iz8B9H2vvZejLfp
 OLH1TahFEXEhKGK+DQIFZvRNj9r6vTVsE8+voEDm8EVJ7LgCRlnkHTTTNzWb0VKTxsrK
 WjaA2Et3/5tKscTwDbtUdul4xz9TyDHE6TAMz59xQtKUiPO+nzDHH1DuAyZW5Y0y4eUu
 zzUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsieDTulYVdzPL7XGS3104v+YGW+XNmv6CmZGXV3PLtfHP86h5tMN6ONWA/4ad1zoe07U1QeRDu4bY@nongnu.org
X-Gm-Message-State: AOJu0YznOJp3gRW5ZAhTrjngZI1Xy80BlnBU+8g6a58+P/x5zui0HOvZ
 GWz9WNLkr+VDcWCUzQttwhCttpAL2aE3ryYvtrBJJ2j5Ku5Jihvpn3LDhV/wuFGQbto=
X-Gm-Gg: AY/fxX7LNIC1hZGJaTiKM3gBEBs4EoI5noVcMFX/6votWSE9aVpraBN1HM91SKStGuu
 6nV2ud1H2wULXvff+fWNy9rzxMEHCtBSaWwUGTFBbAUKsKuE6qesJz5pgmCEAS/LVJNzM67Qv4N
 bJj230BOcXWW0Jr2uu90gcLAKRqvrAwLORG7MBAbIftxj4SFdlmTY+KykZtTkAeZy4WrmaVBc5M
 bAxUFbwQ4HPpfIFsIgzqhBt7rOrlS6j1m46vdH5XO4tBJlQW3v/n7JRAUr72PXhJWoHun5crVnS
 6HWDTZu5fzPNHnwMxdtmVg6/39naQ6wtfincyq0UEaCC/zg+IrGSGTASfifIJbU5vqGiePEazDM
 Uk3zeSz+hfD3HStTtULrSChxT98VH6xzRs+4TvYq7ecwwdulqISPaZLBaRxoBg6J1K0KIQUbLWp
 M3rXsBFMsx9jJ6a9U4U4BH1YcKtVZYc4vM+76hPwIs
X-Received: by 2002:ad4:5c63:0:b0:890:60f:f8ed with SMTP id
 6a1803df08f44-8942dcf6fa7mr883566d6.19.1768496103072; 
 Thu, 15 Jan 2026 08:55:03 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770e2a8fsm204938456d6.16.2026.01.15.08.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 08:55:02 -0800 (PST)
Message-ID: <66870d68-0d48-4c78-aa51-37c24a82baee@ventanamicro.com>
Date: Thu, 15 Jan 2026 13:54:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/riscv/boot: Provide a simple halting payload
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260109131657.396794-1-joel@jms.id.au>
 <20260109131657.396794-5-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260109131657.396794-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/9/2026 10:16 AM, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> OpenSBI hangs before any console output if the domain init code sees the
> next stage is not in an executable region.
> 
> If no kernel payload is provided to QEMU, the next stage address is
> NULL, and the riscv virt machine memory map ends up covering the 0
> address with the catch all S-mode RWX region and so OpenSBI prints
> console messages and does not hang until the next stage boot.
> 
> The TT Atlantis address map has RAM starting at 0 and it loads OpenSBI
> there, so it is M-mode and not accessible by S-mode, tripping the early
> check and hang.

Please note that these patches were split from the main Atlantis series, 
meaning this patch can land upstream earlier than the main Atlantis 
board work. In this context, saying "The TT Atlantis address map has RAM 
starting at 0" makes no sense because there's no Atlantis board in QEMU.

I suggest adding something like:

"The soon to be added Tenstorrent Atlantis board address map ..."

To make it clear that, as far as this commit goes, we're talking about a 
board that will be added in future.


With this commit msg nit:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


Thanks,

Daniel



> 
> Add a helper to set up a simple payload that gets OpenSBI messages
> to console.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/riscv/boot.h |  2 ++
>   hw/riscv/boot.c         | 21 +++++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index fb90bf12399e..d1d7258a2179 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -78,6 +78,8 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
>                                  hwaddr rom_base, hwaddr rom_size,
>                                  uint64_t kernel_entry,
>                                  uint64_t fdt_load_addr);
> +void riscv_setup_halting_payload(MachineState *machine,
> +                                 RISCVBootInfo *info, hwaddr addr);
>   void riscv_rom_copy_firmware_info(MachineState *machine,
>                                     RISCVHartArrayState *harts,
>                                     hwaddr rom_base,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 3ea95c175c14..fc8a39a8d913 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -518,6 +518,27 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
>                                    kernel_entry);
>   }
>   
> +/* Simple payload so OpenSBI does not hang early with no output */
> +void riscv_setup_halting_payload(MachineState *machine,
> +                                 RISCVBootInfo *info, hwaddr addr)
> +{
> +    int i;
> +    uint32_t payload_vec[] = {
> +        0x10500073,                     /* 1: wfi           */
> +        0xffdff06f,                     /* j       1b       */
> +    };
> +    /* copy in the payload vector in little_endian byte order */
> +    for (i = 0; i < ARRAY_SIZE(payload_vec); i++) {
> +        payload_vec[i] = cpu_to_le32(payload_vec[i]);
> +    }
> +    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
> +                          addr, &address_space_memory);
> +
> +    info->kernel_size = sizeof(payload_vec);
> +    info->image_low_addr = addr;
> +    info->image_high_addr = info->image_low_addr + info->kernel_size;
> +}
> +
>   void riscv_setup_direct_kernel(hwaddr kernel_addr, hwaddr fdt_addr)
>   {
>       CPUState *cs;


