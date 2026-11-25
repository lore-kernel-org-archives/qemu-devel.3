Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C63606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ymIFqGTA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW0nn-0000pl-6b; Tue, 24 Nov 2026 19:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xW0nh-0000oJ-Ev
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 19:23:53 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xW0nc-0006D6-4c
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 19:23:50 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8a0880a46e7so3086291b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795566226; x=1796171026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xIz1Qt0xtC7y1bdWzIoFnlZg+2FBPCmGOypRt3tMjV8=;
 b=ymIFqGTAhQJ+mcC9FzDdTGPwSl8UJCAtNeQZ+88vyLoQ4WTIaW6/dw4JTaRhk45LZF
 p6IIk9DhH54HEFdRYyu+fa/wbZSpzlHMRk4MII/p/VgOTs46RoqTN3ki2ubs52WuZhOk
 puekJkDm4cu1LcF1GaBLfarBO1qYE4k4GE7gNgzcjhSwsBuuv1quXn4eB+eK14pe9tDk
 q/L5cNlTDvLhpUJVrGsXdf6FBwQJKgbjs33WHxeJ5LcRu+QQHG6wFwl/1XQJRc2zfPz/
 3aF4vBehLRovlbun1+eic6ry6KS36g4C2NIM1t4ID+oOXh1PycEaDV3YPYxYHx0cPrH+
 pYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795566226; x=1796171026;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xIz1Qt0xtC7y1bdWzIoFnlZg+2FBPCmGOypRt3tMjV8=;
 b=oVswCtzDKyQZbEpqQoyl9peR0YH0njaF7RJxu+jHOJQlKmyUldMGB3c42vn7Of41V4
 b4Fd3VPAMZ3u2xml5t4cY3AF7zLwg0WAkObGKQbjN6FEPilu6cqbtNkqCK6nWSBTHjHN
 syOGChTKEL2bndDyVJW+2r8Eivo17J7Ogkwg112bovLRntwycipkVzY+lnEfPAMkCvVY
 wARYiZjQy9TcVtXmWf118rfPStz0PicEawf6xdOyC4AwCB16OwJNvRjTjEdJYh4fgdob
 ysbr9Rh/iYu9G6P8phsTqtY6rwS9wulROlznfecoAPS94M+5lNnnlDmBIMnadanW3S2Z
 Y4tw==
X-Forwarded-Encrypted: i=1;
 AL+hErGUc7q+VEGc7g5Jn8NpjHKT4B7W8kDiBMqe6tdjs0cqpedtIDgyzXTlNtl/0MHwOItj3kA+MCcKBFuy@nongnu.org
X-Gm-Message-State: APuU4Z+RvMj6n3hiox79qh05oMpjuPNk0P5o+LvuUuroqYu9+sYtueWF
 sl0zXIk3kzufJxOEJ61tNTZNuGAQXniGC2H8Vq5XqirzYYKTT1+lv3fyiLr1uf96bxY=
X-Gm-Gg: AZFdTZcKuoLMMk0FjDmOO8VOYzGsRedj+GEZshH8rJF259AIe3YAlqa6OcPpuK2IbDu
 VCJPKfZv0Q/iAynHi7BnnHtX5sjVsAMGrpIXrLjs7HH4LAOdf7WqUkYudnWIQWgo9ycNe0pBjMG
 xhSfdKy3kkTGNZTz11qpj+naauyiD3LVIcny+os6fkZU0bfCf9Xp/TzKLfA9VnChGOGE8Mr6GfV
 m+gb1T5g7lpOOmr32HNxppqiD6qJhvB8AGfg2auZJvpf7e0fjBofHr2GSW2kLKXff8pU2zujxY+
 uLTDJYbloyLNzRmxRHheetFoWiNvg4/NEtItkqM8uKA26uEeqbF3evr1fCjbbV7RjTG+nsM3J9Y
 kQdklpscLm5LQFOx8AO6rFCgjrJLSdwSG2j5dg/P3Kb+wTTPZdFvnlJHBNO7uZ6S0pnKn5IvAko
 7vzZZpgfKqE9/yxYqacLYkyKyexhs4ohkUbJAPh7/GoGoKyzQR1vcC6UfpP3f4PTNdaCoeyuuti
 3YaoKx/CCLYeGhuOFFweWJ7M42YuILke8mq0esg22OCFwb6/y+/jzIsDUJlGrM0sZOFEFOBbgb0
 bqpblokeFDg8CGtzclqScNLDZ+86NSqbK+cWeI1HYq5i
X-Received: by 2002:a05:6a00:891:b0:8a0:465d:38ba with SMTP id
 d2e1a72fcca58-8c7dd9d67d6mr11438891b3a.24.1795566225734; 
 Tue, 24 Nov 2026 16:23:45 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87343f571sm7663945b3a.34.2026.11.24.16.23.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 16:23:45 -0800 (PST)
Message-ID: <dedd71fe-044a-43e0-a968-b1ca0566d0e7@linaro.org>
Date: Tue, 24 Nov 2026 16:23:42 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261124182722.78535-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 10:27, Philippe Mathieu-Daudé wrote:
> A ROM device changes its contents with direct stores while in MMIO
> mode. TCG does not see these stores, so translated blocks built from
> the old contents survive the switch back to ROMD mode and the guest
> executes stale code.
> 
> Make memory_region_rom_device_set_romd() drop the TBs of the whole
> region on both transitions: before leaving ROMD mode (if currently
> in it), and after entering ROMD mode, for TBs another vCPU built
> before its TLB was flushed.
> 
> Measured with a guest that repeatedly leaves and re-enters read-array
> mode on a pflash, once with no code cached from the flash, and once
> with a function in the flash called after every read-array transition.
> The flush is almost free where code isn't cached in flash, and costs
> about one retranslation per cycle when it is.
> 
> The pflash models are the only callers of this function. Other ROM
> devices (nrf51_nvm, amigaone) flush from their own write callbacks.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Elliot Berman <eberman@anduril.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/system/memory.h |  3 +++
>   system/memory.c         | 14 +++++++++++++-
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 027ca81bd2e1..8dbe37e60ad5 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1959,6 +1959,9 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
>    * device is mapped to guest memory and satisfies read access directly.
>    * When in MMIO mode, reads are forwarded to the #MemoryRegion.read function.
>    * Writes are always handled by the #MemoryRegion.write function.
> + * Switching to MMIO mode when currently in ROMD mode, and switching to ROMD
> + * mode, both drop the translated blocks of the whole region, so the device
> + * may modify its contents while in MMIO mode.
>    *
>    * @mr: the memory region to be updated
>    * @romd_mode: %true to put the region into ROMD mode
> diff --git a/system/memory.c b/system/memory.c
> index 56c5dd6c8abd..f01470993914 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2249,7 +2249,8 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile)
>       }
>   }
>   
> -void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
> +static void memory_region_rom_device_set_romd_mode(MemoryRegion *mr,
> +                                                   bool romd_mode)
>   {
>       if (mr->romd_mode != romd_mode) {

Surely push all of the new stuff below into/below this test,
where nothing happens if mode doesn't change.


r~

>           memory_region_transaction_begin();
> @@ -2259,6 +2260,17 @@ void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
>       }
>   }
>   
> +void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
> +{
> +    if (romd_mode) {
> +        memory_region_rom_device_set_romd_mode(mr, true);
> +        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
> +    } else if (memory_region_is_romd(mr)) {
> +        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
> +        memory_region_rom_device_set_romd_mode(mr, false);
> +    }
> +}
> +
>   void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
>                                  hwaddr size, unsigned client)
>   {


