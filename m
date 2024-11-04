Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918EBD1CA05
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85UP-0006hD-A5; Mon, 04 Nov 2024 17:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85UO-0006gy-52
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:24:00 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85UM-0003vj-KZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:23:59 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso43997845ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730759037; x=1731363837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fv7ajOqr02bT7rtx36Z4XydDDNO450yOywlk/R82D2A=;
 b=G31+2HzUuh+ZuZycHL/YCr0VJvtlsQkPR/DcJpsi+/FKSVfbZZ6XbUCBVi5ysjUHky
 gHXunYcI4A9KevhhxuM5oNQVsvU8EjHLIFlUSKKb58kheG7/ZZJS08GCRPuxX0pBxxzd
 gBE0sxPRC5QnlOet2KPw+pKcSnCcK63kSKV500QmTXafVxMfKu42qO2ueesuo5KaqeTI
 hkPZR46EEp9PBw5T95CmuBqPqmNTbKUUs/39l9kiSOT4AOzWcuysYT/aUfxdkrOeRiYs
 uwJSxjGF11ZXpNN3DnW8KpUieetQvSU8KapoxYNpUTLHMONqUrH4QkcxrZSL5F4H8VeH
 Zckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730759037; x=1731363837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fv7ajOqr02bT7rtx36Z4XydDDNO450yOywlk/R82D2A=;
 b=qdJc4BvNX4lBXJIn6pQnGGBuxS0ql+hY140PSIIWJXxqISXSg7NvISQR3tora6XTR7
 M18kjNKpt944mdCteyTGWetzBFHbNz+OLEY/rT/ynPtaf9lJbJBaFi/2BohbDThndhn+
 Ey6OjxYBnpUToIOOFP8Nul2iDvjMhkCAN2X6LoEJpBuf4sam0Hn3kKBnZcXLDa4vDXX4
 Xfe33JKHVx82LOnnIBHSEC19xSFcCxDqPcHhJ1s3mXLcEZfATn9a7TuYCzqfScelRo4v
 ZMSqBjd0X5mknDIp1PT5FT6N9MSIZSRrLduND4Z16ELXVXSvVRNsE8jPmE97UkFymU0S
 U+VA==
X-Gm-Message-State: AOJu0YxEXvgaeRgx+h5bVmUGtaqj+erDt8ihJe4o3ykwIISa6KrVKYoK
 ndiwHC5QvuuSUW9WTAmFOkzWINPpmboD5VKUJqTi4AW6i/gBc1vMixnyFkLaZQHwZFJX9YG8D7j
 IO5ltNA==
X-Google-Smtp-Source: AGHT+IHpC4XjssXJxGi9hRcQVfu3LMyHiCxDlBNzMBjQBiAPyU+sqb3yjnwja4aWI1DKQxTHXTkpfg==
X-Received: by 2002:a17:902:d543:b0:20c:7661:dcbf with SMTP id
 d9443c01a7336-210c6c95170mr389929905ad.55.1730759036886; 
 Mon, 04 Nov 2024 14:23:56 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105706891sm66442295ad.69.2024.11.04.14.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 14:23:56 -0800 (PST)
Message-ID: <508f34c0-c5fd-4f41-9aba-4c2735b12f5e@linaro.org>
Date: Mon, 4 Nov 2024 14:23:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: fix build error with clang
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/1/24 10:08, Pierrick Bouvier wrote:
> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
> 
> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
> 
>    187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> 
>        |                 ^
> 
> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
> 
>    217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
> 
>        | ^
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/riscv/riscv-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index feb650549ac..f738570bac2 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -184,7 +184,7 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
>   }
>   
>   /* Portable implementation of pext_u64, bit-mask extraction. */
> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> +static uint64_t pext_u64(uint64_t val, uint64_t ext)
>   {
>       uint64_t ret = 0;
>       uint64_t rot = 1;
> @@ -528,7 +528,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>       int cause;
>   
>       /* Interrupt File Number */
> -    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> +    intn = pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>       if (intn >= 256) {
>           /* Interrupt file number out of range */
>           res = MEMTX_ACCESS_ERROR;

Sent v2 with changes asked in this thread.

