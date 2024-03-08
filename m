Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D47C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riViF-0002NK-Sd; Fri, 08 Mar 2024 03:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riViC-0002M3-3b
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:36:16 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riViA-0003n8-89
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:36:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412ed3f1e3fso13453085e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709886972; x=1710491772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CMQzgGqQFOezr+/sDklK2CGJjshJivMIT7kaCrunZRs=;
 b=ayJxPwhwtvB2uBvt2Gq0slGi6CMHGzwOzdG2c2o9TK9++yNDt7wmlNo8QWsaSJipv4
 bqLtzqnt5w/mgaIS0a0NKjMaGRoXSjSBzGQun66XbLT41fEVuLalK93GgkzdPxqU9hDP
 VYWr6SVhBxi7yHElqAsW1VeDgh0ki5TbkSX7XAN2cbD417BnQ3dUYAhAdtnCpNEG1OOn
 zhPM59nWulenNrj4EKAMJV2el10be/vufVQQuShjJijY+urCrfkj04vsG/1X28nX/MBm
 i5lWY/hmtdIGVl88hA97E9tYjC5GB+16Hkmk8uLGZwrtGWj6yidQtuf7t6D+dziLUcqv
 L5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709886972; x=1710491772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CMQzgGqQFOezr+/sDklK2CGJjshJivMIT7kaCrunZRs=;
 b=CeHmk0bkUB9YlBeKLB5p8yq7ruMrbfxdH0edprjauEbg7ZF6WU7KdJ5iFzy5epB49g
 ygvPMZuzefyZGd7joXJMQlWGhaH4O2EQUry6mjUQeBVcSLDQ3fdHYb2BZ0aOW8OcjBvg
 Ie5QbciMZ1pS1rjE5xQgxqArmyd4tvRsHBm2L4NnKsGU4OyVkO8B9CTpQTjVuAlOIpoZ
 t7Q0/hdIiVS+n2IFBbIXX93KRvLiSsdASHKS2bucST65f5HE+L8zkhATHUx7amYJC2D1
 p/jKWNzwjjm8XYKWH59lqr2u30mdafWJSv+YGOAqn6L51Jghvw5aUVPmcXMUwCFlTisC
 9E5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOG9ecuyDZhaLzn1Iv7xoOT9FS1vczxPv0iRbmQIitsSgye5H99yZSLRvqzeDABFbaz682pqyJtsQW5XApad91Ada/pkg=
X-Gm-Message-State: AOJu0YxOPD9Zp3XtiNWLglYxUXNUDzwaxEbOq1VvM2wTO9WFALu6uG7i
 rwYhKD0FnJvu251OK12yUxgoPNJr+ybq8MyW54Tc9kF+SVF2iRNholIcAULAUcI=
X-Google-Smtp-Source: AGHT+IE/R0Nd/avD2MMc+jFSkNXS4TFjdQ6OthESonEB/oOGS0ZLZqx0k7DDD8GYeInbJwp2AflTbw==
X-Received: by 2002:a05:600c:1f15:b0:413:1921:8698 with SMTP id
 bd21-20020a05600c1f1500b0041319218698mr794944wmb.41.1709886972390; 
 Fri, 08 Mar 2024 00:36:12 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 bx10-20020a5d5b0a000000b0033df46f70dbsm23174476wrb.9.2024.03.08.00.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:36:12 -0800 (PST)
Message-ID: <1df3c991-ff91-47dd-a86e-3b2cf6918460@linaro.org>
Date: Fri, 8 Mar 2024 09:36:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/17] hw/loongarch: Init efi_initrd table
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maobibo@loongson.cn
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-8-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307164835.300412-8-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Song,

On 7/3/24 17:48, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-8-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 23 +++++++++++++++++++++--
>   include/hw/loongarch/boot.h |  9 +++++++++
>   2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 2896c1ea40..6126a37858 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -15,6 +15,9 @@
>   #include "sysemu/reset.h"
>   #include "sysemu/qtest.h"
>   
> +ram_addr_t initrd_offset;
> +uint64_t initrd_size;

Where is that used?

>   static const unsigned int slave_boot_code[] = {
>                     /* Configure reset ebase.         */
>       0x0400302c,   /* csrwr      $r12,0xc            */
> @@ -94,6 +97,21 @@ static void init_efi_boot_memmap(struct efi_system_table *systab,
>       }
>   }
>   
> +static void init_efi_initrd_table(struct efi_system_table *systab,
> +                                  void *p, void *start)
> +{
> +    efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;
> +    struct efi_initrd *initrd_table  = p;
> +
> +    /* efi_configuration_table 2 */
> +    guidcpy(&systab->tables[1].guid, &tbl_guid);
> +    systab->tables[1].table = (struct efi_configuration_table *)(p - start);
> +    systab->nr_tables = 2;
> +
> +    initrd_table->base = initrd_offset;
> +    initrd_table->size = initrd_size;
> +}
> +
>   static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>   {
>       void *bp_tables_start;
> @@ -117,6 +135,8 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>       init_efi_boot_memmap(systab, p, start);
>       p += ROUND_UP(sizeof(struct efi_boot_memmap) +
>                     sizeof(efi_memory_desc_t) * memmap_entries, 64);
> +    init_efi_initrd_table(systab, p, start);
> +    p += ROUND_UP(sizeof(struct efi_initrd), 64);
>   
>       systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
>   }
> @@ -138,8 +158,7 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>   
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
> -    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
> -    ram_addr_t initrd_offset;
> +    uint64_t kernel_entry, kernel_low, kernel_high;
>       ssize_t kernel_size;
>   
>       kernel_size = load_elf(info->kernel_filename, NULL,
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index f71c693f43..ddcb279874 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -30,6 +30,10 @@ typedef struct {
>           EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, \
>                    0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
>   
> +#define LINUX_EFI_INITRD_MEDIA_GUID \
> +        EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, \
> +                 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
> +
>   struct efi_config_table {
>       efi_guid_t guid;
>       uint64_t *ptr;
> @@ -83,6 +87,11 @@ struct efi_boot_memmap {
>       efi_memory_desc_t map[32];
>   };
>   
> +struct efi_initrd {
> +    uint64_t base;
> +    uint64_t size;
> +};
> +
>   struct loongarch_boot_info {
>       uint64_t ram_size;
>       const char *kernel_filename;


