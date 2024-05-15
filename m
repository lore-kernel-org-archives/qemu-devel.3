Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21C5C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E4y-0005f1-Cm; Wed, 15 May 2024 08:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7E4t-0005e3-Fc
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:49:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7E4r-0008G5-Ma
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:49:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4201986d60aso19733965e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777386; x=1716382186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bxkJWXn4UifvuoUJNGrrUHorxs2wb6wm5taOuXtthuc=;
 b=CkugSKsAG8gI6nwXE7oFXUC9Zm5j3CeQKvwtq8R2cX8UlpKsRpGQdIlo3H0EfmSaup
 ErUTm8npSQGgsFRPtgQi08YalsfTe7Ig3H4aqakzSR5zr1/BLCOClgDnQQ466ZF98Abo
 Mn7U8fD4JeWAbBJ016rvLEHtnrgpStJp5nBiZZEfIq1vKGNct9YHwO60N6NnDWzFNAKT
 UkVmYwt6KZJkTeJRVZxKziF8/v41Y/8cl991HO1kWeRr6YOUF2GLCStrDuAvSwO8UjhE
 Og6yGz59P49V+oRHL8QHGLxzwmr66gmlOyr2VRnNxTZXrdIpNMCLEqO023nvM66RBT6o
 gssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777386; x=1716382186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxkJWXn4UifvuoUJNGrrUHorxs2wb6wm5taOuXtthuc=;
 b=FZ8OKrHMag6HTkykDgdEFBjPt+ITlOqnv9PML3rrJXnNZUKEJwkw+6JWyCFs8xtLiC
 +zf5mD7zzEgkTTSemwDbWY2x200h7OLMtjsA6rDkOpqoIEibS1kJWxEF3gMx8ktMkDj5
 V19ptS6hVce60woqHSFbbg+mXTNVyV5dcDz2N5QFGjWcUZGZ+qDVkmHwp4WTbAwWLiEC
 6rRsjXZQFMLqyeX5VsxrCEoEDfADXghBtt77Q4L02uu34yRg+m5710ZVea2EH8z6nbZ0
 7djDjWSBgJDh+7ySFd938I6EA+q0bQSpIcjIIL2EIUeZuBXiJW4p7oNacXOlCVsfWw6v
 CcRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXx7evQR8uh33JuXlXKOK5k/H+/L5IllCOqtFASXMUooNHKTjl6MR/wQXrcwfKSQERjiTuEuQSOaqqOAC25N4qrmy9VEY=
X-Gm-Message-State: AOJu0YzDlksm1IxR1ttNc42+ka9//ytsJ8gTFwP9Ny62eJzbSGvM6775
 RNWlaNGysRwt4nm4luja97bWUSvuwZGxlpUcO9cxOAGckQifjmh74KyZMliLi2k=
X-Google-Smtp-Source: AGHT+IFZUoB1vJbBw1ksuXhHminYzEplzFhyS8CQB1/camkRP9URUNwYBxfJZA3Ig/avZz/n9/HU9w==
X-Received: by 2002:a05:600c:45c5:b0:41b:a301:f2f9 with SMTP id
 5b1f17b1804b1-41fead6d069mr112009335e9.39.1715777386194; 
 Wed, 15 May 2024 05:49:46 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf08sm16397191f8f.96.2024.05.15.05.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:49:45 -0700 (PDT)
Message-ID: <42e47d17-1d49-43e8-abd6-76abdcb159dc@linaro.org>
Date: Wed, 15 May 2024 14:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: allow debug writes to MMIO regions
To: Perry Hung <perry@mosi.io>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 Andreas Rasmusson <andreas.rasmusson@gmail.com>
References: <20240513233305.2975295-1-perry@mosi.io>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513233305.2975295-1-perry@mosi.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Perry,

On 14/5/24 01:33, Perry Hung wrote:
> Writes from GDB to memory-mapped IO regions are currently silently
> dropped. cpu_memory_rw_debug() calls address_space_write_rom(), which
> calls address_space_write_rom_internal(), which ignores all non-ram/rom
> regions.
> 
> Add a check for MMIO regions and direct those to address_space_rw()
> instead.
> 

Reported-by: Andreas Rasmusson <andreas.rasmusson@gmail.com>
BugLink: https://bugs.launchpad.net/qemu/+bug/1625216

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/213
> Signed-off-by: Perry Hung <perry@mosi.io>
> ---
>   system/physmem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 342b7a8fd4..013cdd2ab1 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3508,7 +3508,10 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>           if (l > len)
>               l = len;
>           phys_addr += (addr & ~TARGET_PAGE_MASK);
> -        if (is_write) {
> +        if (cpu_physical_memory_is_io(phys_addr)) {
> +            res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs,
> +                                   buf, l, is_write);
> +        } else if (is_write) {
>               res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
>                                             attrs, buf, l);
>           } else {

I wonder if we shouldn't be safer with a preliminary patch
adding a 'can_do_io' boolean argument to cpu_memory_rw_debug()
(updating the call sites), then this patch would become:

     if (can_do_io && cpu_physical_memory_is_io(phys_addr)) {

One of my worries for example is if someone accidently insert
a breakpoint at a I/O address, the device might change its
state and return MEMTX_OK which is confusing.

Regards,

Phil.

