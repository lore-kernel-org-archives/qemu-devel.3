Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E41C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqYPN-0001W2-0k; Fri, 07 Mar 2025 09:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqYPF-0001RE-9V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:10:31 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqYPB-0006kw-OS
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:10:28 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso1495653f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 06:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741356623; x=1741961423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lK/YR21uNxnbpA1t6NNGYWPPNM55eBnWH14xjT7Am/0=;
 b=zUWqFtEbPXDYweIgU+Ly8BNDj1kC7SYXbBGgIAobSp3+51tTnzWupra3pRiNeB59Bd
 GltHwOW//7mEp3kTykEgI9dykvP3LFZMxLvwrNcbSxTulXSusFY8j4v7dwNOzxDCs8Rd
 PyLqCfWMMv2jUQKjHPg9LFVkzcCJgeKlVHQiluagCvjTtsuocUTPvHlR+Lff6tpAluBw
 W/jNPO41tGKOaSJEWZHfyXvAyhy5hzj8TC+g08BLj3PV0CpT3SNtvFCZrBbBLZI4TClu
 7CBgEctW7G8JyqNl7o52xM5GX1wEiwSz+Q6SAhBA/Qxlqe+PWk2zBnSrqclTq9upQYUW
 JUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741356623; x=1741961423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lK/YR21uNxnbpA1t6NNGYWPPNM55eBnWH14xjT7Am/0=;
 b=al1kwMBdHC0kXxkLI04LcmSJmu/guZ930qo2IITIFzxTO6iLIFhbmIJlEBopr4cF/J
 rGAp3THuos9OUzxTX/XIyBTdqs61mObD7Fb5vZiF6cKkuiL1fmc4r57/iLB7Hbrbo/Iw
 I06n1gnzV3ipAJ1HDOh3B7Vz7NRKVD4gYaTz7he2HOSTOIAiH4THhnX4UaHFsKHA5ZjF
 X0e9FFjCBNiU0JwzlDpJaLzf+P5+ss1uZEFsKtJ7ODHpJDT9/QOv7X7mJQVRaSyStNv0
 NM6OCF04+FDOOLMO4z1HTm5oTPBZw3QIePCPTtjJ1Cp/PI1dDzl/XnxCeQM9WKYls4/8
 jO6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4o/YuQlB99SvcV5hgSuZoglRBSs6u8JTpDK3lH9JD/q6H8FiHpFP8wWI+HBzmlhM52Dhn5/vBOsCJ@nongnu.org
X-Gm-Message-State: AOJu0YxA+glEaa5aMW06+z7UwLopoEQOexIWxEb7GHPRHbm4W67/1DN/
 JUo484OVFnTBu+MyaXf3MTpP8qG2Llt5gYXYpmyvdMne4TTKwabISFOH2OfI69I=
X-Gm-Gg: ASbGncsWB/QWMlzW6kLKF6eQ4CYZLS9AbMXs3R0PZ2UwJ/DxKNHaC/TmsbpR8hVOuuV
 yEgPXSjBo6rnzZo2lb+Mj6ak+R4SrBMAvgN6MHzR98TSEdwlinsJawZ1h1xXGhLcyhDtYnBGsV3
 iF3mK4ouUVEj/NNNsJZo8Qs/fhvSevO1Bx0iaD+eIYORkIf6xiL6FmrLyx6+3Wkwx0UfxXm2P5h
 b+n3fiFsnH8OTt31/F7ffJr5ruJ/8FL362tAdD0r1x5lGzU7RK0zl48VFapy3Wxh+igdYV3Qm5J
 CMNTFbCqzBqwsNzMihTQrNI9AwogvquCQxTUyXBRCvkI6pZ69Fuc13iP3fzecihOFvZQ8qZbrGC
 bqV5DDi7THgP3
X-Google-Smtp-Source: AGHT+IEpJtGg9EqR3JlWbacrlSAJLNFzJcCFn5nHsfTfvnAjusfi8nWo2F72PLolOUVc3gUIgDO8SQ==
X-Received: by 2002:a5d:6d04:0:b0:391:13ef:1af5 with SMTP id
 ffacd0b85a97d-39132dc5171mr2431628f8f.48.1741356623313; 
 Fri, 07 Mar 2025 06:10:23 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e3099sm5584298f8f.69.2025.03.07.06.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 06:10:22 -0800 (PST)
Message-ID: <84151f43-d952-4515-aee5-04f339baa546@linaro.org>
Date: Fri, 7 Mar 2025 15:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ppc/amigaone: Add default environment
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <cover.1740673173.git.balaton@eik.bme.hu>
 <4d63f88191612329e0ca8102c7c0d4fc626dc372.1740673173.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4d63f88191612329e0ca8102c7c0d4fc626dc372.1740673173.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Zoltan,

Minor review comments in case you respin (not blocking).

On 27/2/25 17:39, BALATON Zoltan wrote:
> Initialise empty NVRAM with default values. This also enables IDE UDMA
> mode in AmigaOS that is faster but has to be enabled in environment
> due to problems with real hardware but that does not affect emulation
> so we can use faster defaults here.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 849c9fc6e0..5c5585d39a 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -52,6 +52,28 @@ static const char dummy_fw[] = {
>   #define NVRAM_ADDR 0xfd0e0000
>   #define NVRAM_SIZE (4 * KiB)
>   
> +static char default_env[] =

'const'

> +    "baudrate=115200\0"
> +    "stdout=vga\0"
> +    "stdin=ps2kbd\0"
> +    "bootcmd=boota; menu; run menuboot_cmd\0"
> +    "boot1=ide\0"
> +    "boot2=cdrom\0"
> +    "boota_timeout=3\0"
> +    "ide_doreset=on\0"
> +    "pci_irqa=9\0"
> +    "pci_irqa_select=level\0"
> +    "pci_irqb=10\0"
> +    "pci_irqb_select=level\0"
> +    "pci_irqc=11\0"
> +    "pci_irqc_select=level\0"
> +    "pci_irqd=7\0"
> +    "pci_irqd_select=level\0"
> +    "a1ide_irq=1111\0"
> +    "a1ide_xfer=FFFF\0";
> +#define CRC32_DEFAULT_ENV 0xb5548481
> +#define CRC32_ALL_ZEROS   0x603b0489

> +
>   #define TYPE_A1_NVRAM "a1-nvram"
>   OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
>   
> @@ -94,7 +116,7 @@ static void nvram_realize(DeviceState *dev, Error **errp)
>   {
>       A1NVRAMState *s = A1_NVRAM(dev);
>       void *p;
> -    uint32_t *c;
> +    uint32_t crc, *c;
>   
>       memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
>                                     NVRAM_SIZE, &error_fatal);
> @@ -113,12 +135,25 @@ static void nvram_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>       }
> +    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
> +    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set default */
> +        *c = cpu_to_be32(CRC32_DEFAULT_ENV);

Prefer the ld/st API over cpu_to/from:

            stl_be_p(c, CRC32_DEFAULT_ENV);

> +        /* Also copies terminating \0 as env is terminated by \0\0 */
> +        memcpy(p + 4, default_env, sizeof(default_env));
> +        if (s->blk) {
> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0);
> +        }
> +        return;
> +    }
>       if (*c == 0) {
>           *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>           if (s->blk) {
>               blk_pwrite(s->blk, 0, 4, p, 0);
>           }
>       }
> +    if (be32_to_cpu(*c) != crc) {

        if (ldl_be_p(c) != crc) {

> +        warn_report("NVRAM checksum mismatch");
> +    }
>   }


