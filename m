Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F9C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EIf-0000Ee-0Z; Wed, 15 May 2024 09:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EIa-0000EO-8Y
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:04:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EIX-0006F3-VX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:03:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42011507a4eso27400815e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715778236; x=1716383036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UT/FYAn4X3sqvpyen/+wNwBm6ZLyghzsof6+fF9dzLo=;
 b=dwN1HQ+HUPVF4l0rRacH4/qglKw8dCB+hQ6OGzKKHN/jDms2deEeD3bjvsNhSR+abd
 9pmHAGyu8FmhMJkGgUhin/CRcF51J2TL6uKfU++DWrwIoDwTEKayuPHhDlxJ99NjIdlo
 72qx6SosqXjafizPbBcuyLYMHJCNXmGwNBQPYfkmtat/w4wjrCHHJyUen41qSL/JdDtN
 /h815L7uKeQ4nNNeWNPR3wlIhc5qN4La5qh9arSu+GBMdf/TD2K9ZHiAWjpFNKNGekqH
 wIe5VT2kkfx2BhXl3o1Zojraurv0uQihMiT02HZsUX9Jt0PKieKrg251eGa9bY70ZuV8
 KDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715778236; x=1716383036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UT/FYAn4X3sqvpyen/+wNwBm6ZLyghzsof6+fF9dzLo=;
 b=K25S4bGUQs7RUn2MUFb5boWZGUozpi5OBKPHeg8J8WdSDCnC3rLfmqxxrYxYjoy+NL
 J26WBUuh/TowLXg8a2I+ILqG9LS0TSdHjNZ9tFCUJK0AuSOYDrCAPjS3IWTLdEoe9lkp
 TreaTaVyXCPXomm9rZUBf+ZUTqJbzQ2Ak8b0N7LJlNLX1GMZTBI6IeI3srMSuc5uxPQv
 5giHcFhIE57oZp/AqE38o8UTocD3gw4MNyvQ4igLutT9k39BWjBUSmI57SCcuLHA9btf
 nBMLDAh/HUvcJngJv2yyplxDmjtDlYIrh5GhQa8HiF/669CRVE3JO3DTcMIXR/jSVHVl
 HtrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV28OZ6VahEWNLRorQ01nIcY7cTPKri40Nk7VkHtGc6H7ly6MbGPwPW6la+CoMm4RQIHOuSwC/B3XDLI+VWuZXkKloumRg=
X-Gm-Message-State: AOJu0YzntA11t3XpWIF56K0I5Hog0gRYkcXeQosrktI0R8coCT2NwJ+w
 w8UmtU1Yfe03vItnAhzc4cANWk1Nx7ZWE4Ssw/0bgf0CGeQyu1vUF1EBjM19+PQ=
X-Google-Smtp-Source: AGHT+IHyzHkxQFKhNiVIrE9VI2IhqZdHBgmQ3knQ5iLq5Nm6zEcB/hbBK+29OJGawsWNXgYB7zia7Q==
X-Received: by 2002:a05:600c:5116:b0:418:d6f2:b0c1 with SMTP id
 5b1f17b1804b1-41feac59ddamr118950395e9.26.1715778236262; 
 Wed, 15 May 2024 06:03:56 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce9426sm229119445e9.25.2024.05.15.06.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 06:03:55 -0700 (PDT)
Message-ID: <f573e2e7-4b15-4cc5-a44c-8e5cf0a50102@linaro.org>
Date: Wed, 15 May 2024 15:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] risu: Allow use of ELF test files
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> By using elf files, we make it easier to disassemble
> the test file, to match comparison failures to code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   risu.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/risu.c b/risu.c
> index c28b4a5..e3845f6 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -24,6 +24,8 @@
>   #include <sys/mman.h>
>   #include <fcntl.h>
>   #include <string.h>
> +#include <elf.h>
> +#include <endian.h>
>   
>   #include "config.h"
>   #include "risu.h"
> @@ -371,6 +373,57 @@ static void load_image(const char *imgfile)
>       close(fd);

Maybe move the code here, doing 'addr = e32 | e64;', ...

>       image_start = addr;
>       image_start_address = (uintptr_t) addr;
> +
> +    /*
> +     * TODO: More complete parsing of ELF file, verify assumtion, namely:
> +     * Single PT_LOAD covering the ELF header, code and data.
> +     * For now, simply update image_start from the elf header.
> +     */
> +    if (memcmp(addr, ELFMAG, SELFMAG) == 0) {
> +        const unsigned char *e_ident = addr;
> +        bool swap, is_64;
> +
> +        switch (e_ident[EI_DATA]) {
> +        case ELFDATA2LSB:
> +            swap = __BYTE_ORDER != __LITTLE_ENDIAN;
> +            break;
> +        case ELFDATA2MSB:
> +            swap = __BYTE_ORDER == __LITTLE_ENDIAN;
> +            break;
> +        default:
> +            fprintf(stderr, "%s: Bad elf header: EI_DATA = %x\n",
> +                    imgfile, e_ident[EI_DATA]);
> +            exit(1);
> +        }
> +        switch (e_ident[EI_CLASS]) {
> +        case ELFCLASS32:
> +            is_64 = false;
> +            break;
> +        case ELFCLASS64:
> +            is_64 = true;
> +            break;
> +        default:
> +            fprintf(stderr, "%s: Bad elf header: EI_CLASS = %x\n",
> +                    imgfile, e_ident[EI_CLASS]);
> +            exit(1);
> +        }
> +
> +        if (is_64) {
> +            const Elf64_Ehdr *h64 = addr;
> +            Elf64_Addr e64 = h64->e_entry;
> +            if (swap) {
> +                e64 = __builtin_bswap64(e64);
> +            }
> +            image_start = addr + e64;
> +        } else {
> +            const Elf32_Ehdr *h32 = addr;
> +            Elf32_Addr e32 = h32->e_entry;
> +            if (swap) {
> +                e32 = __builtin_bswap32(e32);
> +            }
> +            image_start = addr + e32;
> +        }
> +    }

... otherwise image_start_address == &e_ident.

>   }
>   
>   static int master(void)


