Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A6C36002
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOTK-0000bB-Rd; Thu, 20 Mar 2025 18:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOSI-0006Er-7T
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:33:38 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOS9-0007Ug-Iv
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:33:36 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso3072015a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742510004; x=1743114804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PZu2KwJ2XiVn9tMo2CthGmPy5uTtRVG6Vndh7sjpEhc=;
 b=J8avrWHv6lm6uqbUhqdsB714QiJXi+crku3tQqxPOmWyxb9Y6qa7X208K6ntWdsI6t
 qLQzvUmPwSf50GnLPEqJWuZR+k+EyI3jbEZI4drU4JfBsLy/kky1Ik+jsDuHlWRUvl7S
 ofgwTvllhtb/BZJQl8Buk7siXhZSzoEllGcny4p85DgXMPONbavSX7OaY2fQzqVQVNhM
 9jOzmg8me3+gbjm2XyTJuuXPvb5r4mobUztBHX+tgD6u5VqKYHMCLcsNZ7aXc8QQNlNW
 Nf9YJyWo/EQfWQj4CFFcbI7htqTPewNpP5WAkPgmkpCpLeuKMTU8mfdf9+cgjFxNXt7O
 NTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742510004; x=1743114804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZu2KwJ2XiVn9tMo2CthGmPy5uTtRVG6Vndh7sjpEhc=;
 b=RxfNEC6YdPpe2yCQ3fhTAbjqWaXeECoXgBNyeeRZX+YxZ/msC+w6Csl+/zUgAimvIg
 pdsWNXInw4512wmS+dHaMyOg/EQ7iGo458H+m4dsqUcSxfathaNAVJNVQzERd/GVmFEP
 8trpOKXyroMkWUAYwRW0VB6HszLskzPEAHK0TZXm7k5wn0I+yT65fOnqCL26QXkTu7BD
 /pQJrICRrx2ynFxtOz1o4d24U2q/sj5qipzc/JPJZ1NgcWaX9taTRc60774WpDegmvia
 heYaLnjId/0J9rWzoQiUe7VAZWQbfEaDVHv9EaedXEMc8KqetI0gv2C8x3zSjf7gsOod
 pA6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmE6i/exAI9zjWddgpPzCGWUAuHb/ReN6kBN4lXSPqPEde0FNbcQmjMXRMDqfaS7A5pbHV7aA/stY+@nongnu.org
X-Gm-Message-State: AOJu0YzpPpoFj3smhF2Bwo9crn+GwNm40LWLuSU5yOiz6dGC5VTIJLkJ
 bRsSjG4go7ljXnfrtq62HE7LiIsN9OiFAPo2yE4HAgusCpYGRtiX+eNQ7r6Ko+0=
X-Gm-Gg: ASbGncvBcY2x9qnY62J00RA087iGQxj3pKQZFdhrkxYXB11pn6vX0iasLHv3M7kDZ64
 ZzZ8Pe0Cqt381jG9ARbHYWbnK+Ifn6M9PjYjP1zCquIWSo+/mI5zuJc3t+6DHPlDZseWA2ugrHx
 JO7FUM9UoXLY/K+T23m/XHgKkkuCe+Bd+Q/NtwAlTuMzKZd7X6wjYe0YFFFsVakgOzhUBUVpB2z
 50i8QX2zcZalm+DhLE8Ti+zAnzY21CjcJeiOeJxNhay5d+dhRSEutEy2c/JXbiQULKi1tholq8w
 cqQLITiD0kdwquQ+BALMf84RJCSeJc7LojHIgxzAmuV+l+WdySndWUlEZA==
X-Google-Smtp-Source: AGHT+IHIa4za95fbTcAsuqrH4oxOm7u8W+XZRFXS30ZT+XBM/2+l8hS/9q+wHYzOGpQrPA3LNCRzpg==
X-Received: by 2002:a17:90b:1f86:b0:2fa:1c09:3cee with SMTP id
 98e67ed59e1d1-301d42f1c29mr8136150a91.9.1742510004099; 
 Thu, 20 Mar 2025 15:33:24 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a479c1sm429096a12.70.2025.03.20.15.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 15:33:23 -0700 (PDT)
Message-ID: <de1824e0-3ceb-4286-b47a-f118cda3495b@linaro.org>
Date: Thu, 20 Mar 2025 15:33:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] load_aout: replace bswap_needed with big_endian
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20250320124313.819222-1-pbonzini@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250320124313.819222-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 3/20/25 05:43, Paolo Bonzini wrote:
> Targets know whether they are big-endian more than they know if
> the endianness is different from the host: the former is mostly
> a constant, at least in machine creation code, while the latter
> has to be computed with TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN or
> something like that.
> 
> load_aout, however, takes a "bswap_needed" argument.  Replace
> it with a "big_endian" argument; even though all users are
> big-endian, it is cheap enough to keep the optional swapping
> functionality even for little-endian boards.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/loader.h   | 2 +-
>   hw/core/loader.c      | 4 ++--
>   hw/ppc/mac_newworld.c | 7 +------
>   hw/ppc/mac_oldworld.c | 7 +------
>   hw/sparc/sun4m.c      | 9 +--------
>   hw/sparc64/sun4u.c    | 9 +--------
>   6 files changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 784a93d6c17..d280dc33e96 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -190,7 +190,7 @@ ssize_t load_elf(const char *filename,
>   void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
>   
>   ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
> -                  int bswap_needed, hwaddr target_page_size);
> +                  bool big_endian, hwaddr target_page_size);
>   
>   #define LOAD_UIMAGE_LOADADDR_INVALID (-1)
>   
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index ce6ff1b52e3..2e35f0aa905 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -226,7 +226,7 @@ static void bswap_ahdr(struct exec *e)
>   
>   
>   ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
> -                  int bswap_needed, hwaddr target_page_size)
> +                  bool big_endian, hwaddr target_page_size)
>   {
>       int fd;
>       ssize_t size, ret;
> @@ -241,7 +241,7 @@ ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
>       if (size < 0)
>           goto fail;
>   
> -    if (bswap_needed) {
> +    if (big_endian != HOST_BIG_ENDIAN) {
>           bswap_ahdr(&e);
>       }
>   
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index cb3dc3ab482..2d5309d6f55 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -197,11 +197,6 @@ static void ppc_core99_init(MachineState *machine)
>       }
>   
>       if (machine->kernel_filename) {
> -        int bswap_needed = 0;
> -
> -#ifdef BSWAP_NEEDED
> -        bswap_needed = 1;
> -#endif
>           kernel_base = KERNEL_LOAD_ADDR;
>           kernel_size = load_elf(machine->kernel_filename, NULL,
>                                  translate_kernel_address, NULL, NULL, NULL,
> @@ -209,7 +204,7 @@ static void ppc_core99_init(MachineState *machine)
>           if (kernel_size < 0) {
>               kernel_size = load_aout(machine->kernel_filename, kernel_base,
>                                       machine->ram_size - kernel_base,
> -                                    bswap_needed, TARGET_PAGE_SIZE);
> +                                    true, TARGET_PAGE_SIZE);
>           }
>           if (kernel_size < 0) {
>               kernel_size = load_image_targphys(machine->kernel_filename,
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 0dbcea035c3..b5814690f5a 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -153,11 +153,6 @@ static void ppc_heathrow_init(MachineState *machine)
>       }
>   
>       if (machine->kernel_filename) {
> -        int bswap_needed = 0;
> -
> -#ifdef BSWAP_NEEDED
> -        bswap_needed = 1;
> -#endif
>           kernel_base = KERNEL_LOAD_ADDR;
>           kernel_size = load_elf(machine->kernel_filename, NULL,
>                                  translate_kernel_address, NULL, NULL, NULL,
> @@ -165,7 +160,7 @@ static void ppc_heathrow_init(MachineState *machine)
>           if (kernel_size < 0) {
>               kernel_size = load_aout(machine->kernel_filename, kernel_base,
>                                       machine->ram_size - kernel_base,
> -                                    bswap_needed, TARGET_PAGE_SIZE);
> +                                    true, TARGET_PAGE_SIZE);
>           }
>           if (kernel_size < 0) {
>               kernel_size = load_image_targphys(machine->kernel_filename,
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index a48d3622c5a..5aaafb40dac 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -233,20 +233,13 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
>   
>       kernel_size = 0;
>       if (linux_boot) {
> -        int bswap_needed;
> -
> -#ifdef BSWAP_NEEDED
> -        bswap_needed = 1;
> -#else
> -        bswap_needed = 0;
> -#endif
>           kernel_size = load_elf(kernel_filename, NULL,
>                                  translate_kernel_address, NULL,
>                                  NULL, NULL, NULL, NULL,
>                                  ELFDATA2MSB, EM_SPARC, 0, 0);
>           if (kernel_size < 0)
>               kernel_size = load_aout(kernel_filename, KERNEL_LOAD_ADDR,
> -                                    RAM_size - KERNEL_LOAD_ADDR, bswap_needed,
> +                                    RAM_size - KERNEL_LOAD_ADDR, true,
>                                       TARGET_PAGE_SIZE);
>           if (kernel_size < 0)
>               kernel_size = load_image_targphys(kernel_filename,
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 8ab5cf0461f..d3cb7270ff5 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -168,13 +168,6 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
>   
>       kernel_size = 0;
>       if (linux_boot) {
> -        int bswap_needed;
> -
> -#ifdef BSWAP_NEEDED
> -        bswap_needed = 1;
> -#else
> -        bswap_needed = 0;
> -#endif
>           kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, kernel_entry,
>                                  kernel_addr, &kernel_top, NULL,
>                                  ELFDATA2MSB, EM_SPARCV9, 0, 0);
> @@ -182,7 +175,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
>               *kernel_addr = KERNEL_LOAD_ADDR;
>               *kernel_entry = KERNEL_LOAD_ADDR;
>               kernel_size = load_aout(kernel_filename, KERNEL_LOAD_ADDR,
> -                                    RAM_size - KERNEL_LOAD_ADDR, bswap_needed,
> +                                    RAM_size - KERNEL_LOAD_ADDR, true,
>                                       TARGET_PAGE_SIZE);
>           }
>           if (kernel_size < 0) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

The rest of BSWAP_NEEDED removal was done here:
https://lore.kernel.org/qemu-devel/20250320223002.2915728-2-pierrick.bouvier@linaro.org

Feel free to combine it with this patch.

Regards,
Pierrick

