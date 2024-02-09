Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9F5C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQE5-00020v-AJ; Fri, 09 Feb 2024 07:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQE2-00020n-8J
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:43:26 -0500
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQDz-0003TI-D0
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:43:25 -0500
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7c029beb8c9so30349639f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707482601; x=1708087401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6wI2J8v58lBM1zgUvL+fbf68Z50wTZA0SsSnD0qTVoY=;
 b=M4RGmBItT9uhpg1x5N4xfdd0Fg+xR+1db6fez3JeqMoHIYj2NCi9UgIFDEWOMDKYuz
 UQxevY3XiPZUSlZqxEKvs2IuStK223O6+vWZxiiYZs8UsrmJHnXvC/Rfqs08PNq2A2Iv
 LsH0SxonCzbXeuNnps25+29PB0yfQMB/gghmsYBTiaqiOIwqr2BqYwNHP+lAyQI9sPuC
 o2q0yN2dUKehOMMxOj8sT9Fdxl/hTbXPZobpx55ad89usTE75NpQgyvfYepPCKNJP61d
 QIfyobR4KA2ANg5OB2aWFLGWVtnSSKFxhxuQkYDCEa7pCUhSMrpRz3Dtq4rQzIQOwxcs
 90sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707482601; x=1708087401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6wI2J8v58lBM1zgUvL+fbf68Z50wTZA0SsSnD0qTVoY=;
 b=C0y4gGZHvWNyy8NgfI6J+q1ydXOTq7blbio+Z+zcpfxY5EjibbVcbP881aA1M3qpGL
 n3uY96Goubh1P/xCmOb6NvDTwH5XhSvAv0bM0Xe6x7msS/bxp4a2Bgo6WB0niyWVrNEM
 7tJQJGP6TO8nulO3L42ZgdlcOv9ehGayGepH1DEc6VFNnkn8DtgY6aBwYH1Kd4wCfDD8
 SRAWp7PSjMqTxvj61g04VvJ5M8ZLnqWWRAUK2ExPcQg9NVXaVqMvARm4Id9UVd8UO/RW
 /+e7fMdLNSorlzbKV+i3RL0wJ2QaxI6zMa77Nl4A2YwPUcHMg371dKmT4p55ssluDv5p
 jt9w==
X-Gm-Message-State: AOJu0YxHVI+BIETjzbe8nY9naE89H+5lTS3y1FsaQhgsTidaF8ra39dg
 1Q0mL8EqR220AfD6kgn2QASWzQoH65pXtt64Mcu4LkS+UtTWPSA3/Dkm6q2AOWU=
X-Google-Smtp-Source: AGHT+IE9LHyS/SZFmdQa6pExRpe7o7ZSN0eBwEuJVwMhZ1/YV/JRwFqx6aTGLEbLoD2jR5y/ARn0nA==
X-Received: by 2002:a05:6602:1b99:b0:7c3:fb51:3cfa with SMTP id
 dq25-20020a0566021b9900b007c3fb513cfamr1797568iob.11.1707482601493; 
 Fri, 09 Feb 2024 04:43:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXLgRVjCeTcGek5EpYMKvr9xGRGHfFHRReKyKdMt+iZS7MnT5+6OwPQkzXVbJZFRV+rCLRqerOxB7kI8GW6bq41QQ==
Received: from [192.168.69.100] ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 hh26-20020a0566021d1a00b007bed4940d91sm384058iob.15.2024.02.09.04.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 04:43:21 -0800 (PST)
Message-ID: <3a305e01-8ab6-47b3-b498-54253bc6cd61@linaro.org>
Date: Fri, 9 Feb 2024 13:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/mips/Kconfig: Remove ISA dependencies from
 MIPSsim board
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, shentey@gmail.com
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-4-pbonzini@redhat.com>
 <078c8c89-f468-43d1-9ca6-4c485f09c9ba@linaro.org>
 <CABgObfb+EdNzqqDiAtzf5B9YPhe+p1cf94KKzCd2fgLCKFAbmQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfb+EdNzqqDiAtzf5B9YPhe+p1cf94KKzCd2fgLCKFAbmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2c.google.com
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

On 8/2/24 09:11, Paolo Bonzini wrote:
> On Wed, Feb 7, 2024 at 7:58 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>> @@ -6,8 +6,7 @@ config MALTA
>>>
>>>    config MIPSSIM
>>>        bool
>>> -    select ISA_BUS
>>> -    select SERIAL_ISA
>>> +    select SERIAL
>>
>> Hmm there is an ISA bus which can be exposed with:
>>
>> -- >8 --
>> diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
>> index 16af31648e..a1a4688861 100644
>> --- a/hw/mips/mipssim.c
>> +++ b/hw/mips/mipssim.c
>> @@ -209,8 +209,9 @@ mips_mipssim_init(MachineState *machine)
>>        /* Register 64 KB of ISA IO space at 0x1fd00000. */
>>        memory_region_init_alias(isa, NULL, "isa_mmio",
>>                                 get_system_io(), 0, 0x00010000);
>>        memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);
>> +    isa_bus_new(NULL, get_system_memory(), get_system_io(), &error_abort);
> 
> Quoting you from
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg08752.html,
> "there is an ISA MMIO space mapped at 0x1fd00000, however this is not
> a real ISA bus (no ISA IRQ)".
> 
> If mipssim cannot support "-device isa-serial" as a replacement for
> "-serial", there's no reason for it to expose the bus. In the end,
> -device support is the main thing that an ISA bus provides over
> sysbus, and if it cannot work due to the missing interrupts, I think
> this patch is correct.
> 
> I can add a comment:
> 
> diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
> index 01e323904d9..47b37b454e7 100644
> --- a/hw/mips/mipssim.c
> +++ b/hw/mips/mipssim.c
> @@ -204,7 +204,11 @@ mips_mipssim_init(MachineState *machine)
>       cpu_mips_irq_init_cpu(cpu);
>       cpu_mips_clock_init(cpu);
> 
> -    /* Register 64 KB of ISA IO space at 0x1fd00000. */
> +    /*
> +     * Register 64 KB of ISA IO space at 0x1fd00000.  But without interrupts
> +     * (except for the hardcoded serial port interrupt) -device cannot work,
> +     * so do not expose the ISA bus to the user.
> +     */

Yes, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       memory_region_init_alias(isa, NULL, "isa_mmio",
>                                get_system_io(), 0, 0x00010000);
>       memory_region_add_subregion(get_system_memory(), 0x1fd00000, isa);
> 
> Paolo
> 
>>        /*
>>         * A single 16450 sits at offset 0x3f8. It is attached to
>>         * MIPS CPU INT2, which is interrupt 4.
>> ---
>>
> 


