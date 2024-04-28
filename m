Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756C2C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 19:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19kI-0003WE-EY; Sun, 28 Apr 2024 14:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19kH-0003T3-3Z
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:59:29 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19kF-0006lj-2J
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:59:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so3432912b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714330765; x=1714935565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e0DpQvoNvjFycWcD3fFiCnwfqIoeVDjM6d0vNRCPICE=;
 b=oMwy//xRfK89iRXVFBwLkwrK4+4dYrPqsDgv4+kuKC1IeerUXJhoAJa6ZbVQMAnpcO
 EME9dOApI1PKKXe+mETSaoDDcObdqXnMMlyMqBlx0fgkAT2jkMeTF4pJkAsTIAlCs2ic
 gS7qkyzogjyMjZRCmx1Q3LlrxATxg9B4FqaY19iXS1frcd7KFrKN7l9soghmg5Yq2K0b
 PCLDktaru0qeDEfkXzyAWLFeDay9ZZ2JW/6Uy5EUYKDXVhom/oUwDE+r6igrRvUTjT29
 hO0pjQwDzMzXASC9HT7m8N8qt2FKDhf0KXAR0VWjPlZS/aFEvZxIElSgdgQLoem0bo0k
 QB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714330765; x=1714935565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0DpQvoNvjFycWcD3fFiCnwfqIoeVDjM6d0vNRCPICE=;
 b=Jy6IOgtyeZByZb7+Iw4HoEb71yKVgWyvKWCaV7UVG7HW58KUPfbBgfw+PKOPevWIyK
 TCeVziSOJrvr4w0Ge09Jv8uL3VDpwXdfGZAUANq0VSjzOBOYBNr6Z44NznAk7Nnu4eS8
 +KATUYDJEomWS5gvfNQRij8vBQU+c8L4yIRKYln/293OHhI/a/AuKyVR0ZIvuJcTPPFH
 hvxeXoZlpPV0mk/EhPkUP4G8iNgMT1l5eyQLfOHfsuf/mxPGNzBjVpkM7VM1b4SLCqO4
 w6nOBLvZmm+P3RqLx9GuboeFWTuD7snTjQkdEuIQw4jJCTVKdHwD0hoQZUVm+SJ8o4Cm
 pFVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVraA69nqlHxE7QZ4OBw6qfLk4qvSak93K2Qbo9owztW8ne1o2tDX49IRoRmeVqt6pWc5vlmhb1vgqPRK790g/vgD5sRD4=
X-Gm-Message-State: AOJu0Yz8KZ+hXlov0Kombx3f90ZmuHQQVfTpytze1fxT5FET4dKPT/J0
 CmSf5db3nbaMQIg185FBNCxPnbwHVayQgLjsiQOTTCsoOxrJ0Equuop7rYb29r+zavfmpVrXZSt
 O
X-Google-Smtp-Source: AGHT+IEP97iVEGeGGFmUqVcmi5pSLJIFKumhE52H5uFPpLtDLATPUzD2z5yJ4N566+KpvUy9BZOCVw==
X-Received: by 2002:a05:6a00:9a8:b0:6ea:d149:c4e with SMTP id
 u40-20020a056a0009a800b006ead1490c4emr9077741pfg.14.1714330765335; 
 Sun, 28 Apr 2024 11:59:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 81-20020a630254000000b005f80080586asm15496004pgc.93.2024.04.28.11.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:59:24 -0700 (PDT)
Message-ID: <dd6d6a05-386f-4555-a3d7-d4f769fff81b@linaro.org>
Date: Sun, 28 Apr 2024 11:59:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/17] hw/loongarch: Add load initrd
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
References: <20240428085117.2422473-1-gaosong@loongson.cn>
 <20240428085117.2422473-3-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428085117.2422473-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/28/24 01:51, Song Gao wrote:
> we load initrd ramdisk after kernel_high address
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Message-Id: <20240426091551.2397867-3-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 9feed17db3..a9522d6912 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -22,7 +22,8 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>   
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
> -    uint64_t kernel_entry, kernel_low, kernel_high;
> +    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
> +    ram_addr_t initrd_offset;
>       ssize_t kernel_size;
>   
>       kernel_size = load_elf(info->kernel_filename, NULL,
> @@ -37,6 +38,32 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>                        load_elf_strerror(kernel_size));
>           exit(1);
>       }
> +
> +    if (info->initrd_filename) {
> +        initrd_size = get_image_size(info->initrd_filename);
> +        if (initrd_size > 0) {
> +            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
> +
> +            if (initrd_offset + initrd_size > info->ram_size) {
> +                error_report("memory too small for initial ram disk '%s'",
> +                             info->initrd_filename);
> +                exit(1);
> +            }
> +
> +            initrd_size = load_image_targphys(info->initrd_filename, initrd_offset,
> +                                              info->ram_size - initrd_offset);
> +        }
> +
> +        if (initrd_size == (target_ulong)-1) {
> +            error_report("could not load initial ram disk '%s'",
> +                         info->initrd_filename);
> +            exit(1);
> +        }
> +    } else {
> +        error_report("Need initrd!");
> +        exit(1);
> +    }
> +
>       return kernel_entry;
>   }
>   

This doesn't simply allow initrd, it requires an initrd.
This causes make check-tcg to fail:

>   TEST    interrupt on loongarch64
> qemu-system-loongarch64: Need initrd!

https://gitlab.com/qemu-project/qemu/-/jobs/6733983794


r~

