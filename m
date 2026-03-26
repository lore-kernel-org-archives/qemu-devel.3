Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B0A109E52F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 00:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5YJo-0006dT-27; Wed, 25 Mar 2026 20:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5YJm-0006d3-Go
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 20:11:22 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5YJk-00057L-NZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 20:11:22 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35c0e7b751aso343292a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774483879; x=1775088679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s68ftR8+2vjyJAhYeTynwui41r/8c6MZ22NHW9oj+04=;
 b=CIuqEpV+q73Fo/EH+MgowNaM7919BOIWzOm5nMi85QEhDf7PHIqT+mJRzIIXyllgwV
 Q8enrPVh72bjN8DRgk7pJSSFET/IaOW7K+3Jkz0CZMTOt0puoFNeQ7zeiFp9xW+NXbrR
 pKOP9wkllo7C4bK+oQQ1Q/K90NLsJwcoiy/HhXBmwpIhKX5ZKeG/OuNfzqwM5EzGOxNN
 xZQrAB6JdxGgcuP2rORiVcKXEMNZr2BQIMA2dDc4TTnqPlSqXIl/ayww8tOKTRtwkIIz
 rHAhy0wJMepXPF0wgMCpmNZ4Ydn4nLUS+T/QjwvRg/v5NPbe7JLpMZObmsUji0X6KF+H
 2w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774483879; x=1775088679;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s68ftR8+2vjyJAhYeTynwui41r/8c6MZ22NHW9oj+04=;
 b=EDEUDtXsI2YQfFWHJqLAkmyVT0Nu3dGJ+eabHMXa8KJ31ieuOWwZ7N6HCJKgf5Ssnt
 ENeSS884Ha/WGpoVD57oBEfZR15K0/rU9DmuPLE+iLJYYAzLo0Ww+LJqVeT6pYjJhOS4
 AUHwkOwjTHnBQWGXj7JaAZgJGL20WBSC3GaD+A1i1VvmcbpoeKgLb6/tSwFBXKUdQE1j
 4vRh0iqQa46XIIyDkFD+K16xHWg/iwzah2pfnmjqXsDBs2yAiiDs7aBkxhuwfNHEz06I
 A4VbcA0XnoC5Fq1w5n9gYg6lkRyLouMafMfTSFRQlyitee3Hv4NPA755a4ufdtfgoQSq
 G/FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOap3Lozn4RdLpDGh+YMCWt1P2FyjzwnX3oXu08FSoVgKPqte4+kv1Qj5Zb/Z6UxdntD8B/h9WTJAf@nongnu.org
X-Gm-Message-State: AOJu0YxyeEd5Lqe6B2I7G/Zhbq4pgQeGZqen7SrtuJjFdswaa4L6sXEI
 1yjOaRC1v8T2IAPPq2brvZbkb777hO5wF1k6kG9xE+Rg0X82rph1roI8LlDQk31A5vIDidhDJHR
 aQnLfevk=
X-Gm-Gg: ATEYQzzx9exEEJaKFq4jnNV21wmRiXx1MlXTVKfqDyaqvwFQ+qHwHUqPaG1Frge014m
 eOS2eM9cB2gpGPnShrsTVGskTm59/iMnaHlFyN1D0svIDO8V7L0DCeAP13OkoDSdbIVcJEuwvm5
 TVGWSiSK1qt652THedO4bjUvA2GgKpS9rCY1/Y6Sy8pZwPuaAzZKG7iJlexoLlp3uZ1jj/3+YZI
 y/hhtwW4eipBWmc6yuHTRkVIRQ/yHyv3iMUxU/+23PqN6dx4/kJiPNfOKLtypxEBS0IPtUd2+D3
 bjD9aYJ2cBFSuP0xHgAVUUKGz3g+LT08qc8NuB6aMnAxtGkUNRiJvzQTKng+zCOkpjQY0YdnFmt
 rzesay3Jr0vLETVB4jg6KIOO96qTbynDvhVHx88cIY0gy2I5xEAr1wAQRTxTfjqmjjmIBHNh0Z2
 kbjw8KwCmaPKX1vZopHvg5PE+ZwGHbs3zCr+NGAKKzyA==
X-Received: by 2002:a17:90b:3dc6:b0:35b:e4f8:7b3c with SMTP id
 98e67ed59e1d1-35c0dc88437mr5721327a91.11.1774483878765; 
 Wed, 25 Mar 2026 17:11:18 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c031403e4sm7630987a91.6.2026.03.25.17.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 17:11:18 -0700 (PDT)
Message-ID: <dd439b70-37d1-412b-8d4c-a1ef7012cb66@linaro.org>
Date: Thu, 26 Mar 2026 10:11:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] hw/alpha/dp264: Fix block comment style problems
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-2-4375b00a85ff@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260310-qomify-alpha-v1-2-4375b00a85ff@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/11/26 08:31, Yodel Eldar wrote:
> Use leading "/*", internal "*", and trailing "*/" for block comments.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   hw/alpha/dp264.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 98219f0456..27fbcee637 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -26,12 +26,14 @@ static uint64_t cpu_alpha_superpage_to_phys(void *opaque, uint64_t addr)
>       return addr;
>   }
>   
> -/* Note that there are at least 3 viewpoints of IRQ numbers on Alpha systems.
> -    (0) The dev_irq_n lines into the cpu, which we totally ignore,
> -    (1) The DRIR lines in the typhoon chipset,
> -    (2) The "vector" aka mangled interrupt number reported by SRM PALcode,
> -    (3) The interrupt number assigned by the kernel.
> -   The following function is concerned with (1) only.  */
> +/*
> + * Note that there are at least 3 viewpoints of IRQ numbers on Alpha systems.
> + *  (0) The dev_irq_n lines into the cpu, which we totally ignore,
> + *  (1) The DRIR lines in the typhoon chipset,
> + *  (2) The "vector" aka mangled interrupt number reported by SRM PALcode,
> + *  (3) The interrupt number assigned by the kernel.
> + * The following function is concerned with (1) only.
> + */
>   
>   static int clipper_pci_map_irq(PCIDevice *d, int irq_num)
>   {
> @@ -132,9 +134,11 @@ static void clipper_init(MachineState *machine)
>       pci_dev = pci_create_simple(pci_bus, -1, "cmd646-ide");
>       pci_ide_create_devs(pci_dev);
>   
> -    /* Load PALcode.  Given that this is not "real" cpu palcode,
> -       but one explicitly written for the emulation, we might as
> -       well load it directly from and ELF image.  */
> +    /*
> +     * Load PALcode.  Given that this is not "real" cpu palcode,
> +     * but one explicitly written for the emulation, we might as
> +     * well load it directly from and ELF image.
> +     */
>       palcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
>                                         machine->firmware ?: "palcode-clipper");
>       if (palcode_filename == NULL) {
> 


