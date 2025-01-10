Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5B9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJmM-0004Xn-QM; Fri, 10 Jan 2025 13:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWJmA-0004Wi-Aw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:30:32 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWJm7-0007vn-MJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:30:29 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216281bc30fso47011895ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736533826; x=1737138626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tUepOYp6Lw8jtWDrVv48Ktbx9HnTAIj/haIhxO/CZRE=;
 b=DKYPzUZP6QLtA4a/6kk6nxmEjGTBNQWVnMJ2V3nQjzY3W6N39WDkVMm1MF0Ipt4EKg
 krtXAccvz2bVe4hEDNr/6//gTaMjQ8HQl6rO/KhHrd77xI8OrCqMVXLRCohLaw13b7zv
 w1k/LutcABp132wa9z7sO3wN2nAxRYgbR2ssoEUH5cYQ22suEoGkHk923P5WduNhtxaW
 vACAMObT+C4C2y9lpRZYN4ePC64bzLCnxeqLprqMm8qdfg8A+lVpAB4kAzQRVErQish4
 tqsyCq8KpLODNUd3baohoeUyEP1FVsqIJbhPoiy6x9abm6nt+zdJF394Zvz+mQdIp50j
 LD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736533826; x=1737138626;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tUepOYp6Lw8jtWDrVv48Ktbx9HnTAIj/haIhxO/CZRE=;
 b=KqLg2oexxlCabEAcxznxAAPQJRTZIE6Yrm4LkSGr0ryIXJYcOZKXE3pqzkUjTKQ50/
 TB+nh9tJwLvUkAfSSEabzEg4R3OPrUUs0Vyc5SFe/xrH8uWznIIO4kLz6rrZJHB7wx4P
 p6tJuBk7mcDuNEQ0l4dieHgYoC8PjbcEHVkv8J0LUY9L8/4fHpqw0Ht4Zd8EoH+RBTmf
 gf9VvVbUWHICrSFom8/t7iqbqQ2nB0oVUAvz+pGsHhTDHGR0plDNHDTeJleWqGPaGRKz
 k0A0Z1jq9KcaHChARwX7IySXnRX7IvK3oJLAmaw5/rGU5zBFW1gXMdpWL1BbHCb9MKu0
 AFRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyTeKez2WYXLbA4HYPVTn6NZlDat7f7z3xSpbtxKpPqv0Wx/vpcFU3hNQWcjsVO1HIaNpHvY/C/gYt@nongnu.org
X-Gm-Message-State: AOJu0Yx5t2z1L+fBEMD2U6zADXEIpSf3TY0ZxePokTCQ3rNVQxaAYp3n
 sesrb5BHGcH64zUv4GUUntTVvRcwTzXN/Q8gxY7/8f4d6qUySZtC1U/Qn/Wi+sc=
X-Gm-Gg: ASbGncugu0aQb6vdJP0LTK3zi6W534xGw4ave3xx0OqK24l7iOnWZ1/YJTTGgk1v25S
 7jYOp1oBm+ja7UgY2FUz5XtM9yeU8s5FPFOzTXvzO67MHvN2wnKttthzoSOTnoDDM9lyWyTrcXw
 95hKgkym102nLn59BSPBXbBf4RXXRJmcWpwvZBy9IHBJDq3b6N6+f4jiRUGEtJQmRYyiULCvTvP
 1jTc8eWq/b9tMYT1zlt7SRn/A9bZ71dVwjzbbXUvOlKq67fr95nubRf+G/XFugNF0QuZLwFvfXJ
 MxlnAQ4OdF7Bvj1Q8Fq4pRwSlAvnwHI=
X-Google-Smtp-Source: AGHT+IHATVZ9ll8CRq4VEx8jiURPjLJWChsen40V8je1Njg0BAGMvAl3cujDgX39W1hBcDWv0pBIlQ==
X-Received: by 2002:a05:6a00:1255:b0:726:54f1:d133 with SMTP id
 d2e1a72fcca58-72d21f4be75mr15443462b3a.12.1736533826054; 
 Fri, 10 Jan 2025 10:30:26 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4054942dsm1804165b3a.21.2025.01.10.10.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 10:30:25 -0800 (PST)
Message-ID: <d4ba9559-3d6d-4abb-abfb-7de8b143578e@linaro.org>
Date: Fri, 10 Jan 2025 10:30:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/rx/rx-gdbsim: Remove uses of &first_cpu
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250110180442.82687-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250110180442.82687-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/10/25 10:04, Philippe Mathieu-Daudé wrote:
> rx_gdbsim_init() has access to the single CPU via:
> 
>    RxGdbSimMachineState {
>      RX62NState {
>        RXCPU cpu;
>        ...
>      } mcu;
>    } s;
> 
> Directly use that instead of the &first_cpu global.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> ---
>   hw/rx/rx-gdbsim.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
> index 02fdbdf824b..88c8f12c101 100644
> --- a/hw/rx/rx-gdbsim.c
> +++ b/hw/rx/rx-gdbsim.c
> @@ -127,7 +127,7 @@ static void rx_gdbsim_init(MachineState *machine)
>            * the latter half of the SDRAM space.
>            */
>           kernel_offset = machine->ram_size / 2;
> -        rx_load_image(RX_CPU(first_cpu), kernel_filename,
> +        rx_load_image(&s->mcu.cpu, kernel_filename,
>                         SDRAM_BASE + kernel_offset, kernel_offset);
>           if (dtb_filename) {
>               ram_addr_t dtb_offset;
> @@ -153,7 +153,7 @@ static void rx_gdbsim_init(MachineState *machine)
>               qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
>                                   rom_ptr(SDRAM_BASE + dtb_offset, dtb_size));
>               /* Set dtb address to R1 */
> -            RX_CPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
> +            s->mcu.cpu.env.regs[1] = SDRAM_BASE + dtb_offset;
>           }
>       }
>   }


