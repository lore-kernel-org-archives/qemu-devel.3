Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FBBC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 22:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tihj9-00026s-6w; Thu, 13 Feb 2025 17:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tihj6-00025v-Hc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 17:30:32 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tihj5-0005lK-1C
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 17:30:32 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e565708beso923519a34.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 14:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1739485829; x=1740090629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fsLzMJqnb4yKx9rHFU7tGtigQcp5lBmTrQX4pTlf2b4=;
 b=Cs5RhOoJFtoAwhT2EBbS8PHc2oVBkSH29qaGHeJZyZwojTHO/R2Dp6u9ZfU96u4Oye
 LRozBnntshrsBm2SeFX5ke6G9MBRsC4FHYCIZoFNXhzAGnI3KZen9mgzc88dM6J/qbZk
 MGFfb3DQupHu4pRy+k3a98dNkkPHqQBYa8PhE4bnHo9GHFXdumrLP+aohxT7Xt2qh0Hb
 n/+EhhFz57bjm4dj4+7FZgcPrQUNlej+KGEEDnI85xHDp10q/MlvljbGbIU1bghOaz5U
 gMafUptc9hHnR9Y/uo/Dxo+9lYGJLFp0tsvZoiSkkbbSL+WiGD/aJdH+GanT19kNpIVB
 L7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485829; x=1740090629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fsLzMJqnb4yKx9rHFU7tGtigQcp5lBmTrQX4pTlf2b4=;
 b=Xne1P6o9pjx9lhhzENF8JzVkmXgEDDlkZYfcx/SA6oUhLtjIxwJ0V/02bXsmfH5v4T
 aF5lgzRrt+6ubdSzJH+T1k2hivXLIN5cIpwdpHZ3YSRrxNDDwdhcSpAUOh00r37OxfRu
 7VjL73ydEggAOEgPDBe9W1Tc+SwzxTqx8/1cwVJfyXYp57A5Fqp4+EMp2yOtCorBHoZS
 xFa9SYTH7tM0PfUU9rXrkZe1iYfzDVl/1gSvVB01Za8xO/gJiNsVb8+ojhzRnuatfWic
 7ORXZzvzBVDgt/jhEVzM+DLlxcI/5WyFFsNUfgQQWR3VtSjEYsNaU/AL/5qevgjcFzaK
 kgbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBbTvy5UW7IG2MrJyH6KPbl7zDjWQpx+u38Wvbw5jY5v2dpG9NBxQjg7hbxk/r1cPZ23wssfBntj4f@nongnu.org
X-Gm-Message-State: AOJu0YxF+OGIcfQ4djxjbUJDEW1Hrw14RMoVw3Ja/X4qwI+/5UqeRnO4
 Y3Up/4adr0BZrQRzR60Mp2FPz5jIN1yMw6u5Fa3CBaapiGstPEktvnFu9yMP81s=
X-Gm-Gg: ASbGnctc6vbsC5Rdh9Ln6QiCvCaP3yh/zdIEj3MJmOLtIUJkhWJhsfTKSbwV4Rh7Er0
 tq90BH+v2F52Ok0BAikWXQMBoIb5tTchObWeRviDKxwAVejPlPgvfpvecgryAK7bSNTr3t+Tv1n
 DjhgbGrlAX2UiYfwWo80Bqf/Zxo121K9xw50W9HGRLvRcTQE5yprs6WtdHkzk5H2WGykhwdLBII
 ZDv0hmH1FXtAOrkpT3DPOdGgTFHpgHKXa9OE+8TISaNc5Vo/913WosSnJWzLRXYBVH1tSr2aQFx
 3OPW3snZS3sNNT7vwvWO4jdl8yqOmqE2E2jkcDXUoSAKG1j0YOWuKRtq1tMiib+w
X-Google-Smtp-Source: AGHT+IE2qkmiAxa3HFKR1v4qcn8yRNnQ4P88Hv/vYS2Jlq+mRl+HbpXrlOYa/NOpjhAlbWWxdEBN3g==
X-Received: by 2002:a05:6830:3389:b0:726:fca9:bb2 with SMTP id
 46e09a7af769-726fca90f09mr2992350a34.16.1739485829444; 
 Thu, 13 Feb 2025 14:30:29 -0800 (PST)
Received: from [192.168.68.110] (201-68-240-180.dsl.telesp.net.br.
 [201.68.240.180]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fcb16fafccsm912096eaf.22.2025.02.13.14.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 14:30:28 -0800 (PST)
Message-ID: <9c5f803a-59cb-4e30-9971-34e39114de13@ventanamicro.com>
Date: Thu, 13 Feb 2025 19:30:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: remove warnings about Smdbltrp/Smrnmi
 being disabled
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250213145640.117275-1-cleger@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250213145640.117275-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32d.google.com
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



On 2/13/25 11:56 AM, Clément Léger wrote:
> As raised by Richard Henderson, these warnings are displayed in user
> only as well. Since they aren't really useful for the end-user, remove
> them and add a "TODO" note in the leading comments.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> 
> v2:
>   - Remove Tommy bouncing mail from the recipient list
>   - Entirely remove warnings and add "TODO" in the leading comments
> 
>   target/riscv/tcg/tcg-cpu.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 0a137281de..94bfafd7db 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1432,22 +1432,20 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>       }
>   
>       /*
> -     * ext_smrnmi requires OpenSBI changes that our current
> +     * TODO: ext_smrnmi requires OpenSBI changes that our current
>        * image does not have. Disable it for now.
>        */
>       if (cpu->cfg.ext_smrnmi) {
>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
> -        qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
>       }
>   
>       /*
> -     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup to
> -     * avoid generating a double trap. OpenSBI does not currently support it,
> +     * TODO: ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup
> +     * to avoid generating a double trap. OpenSBI does not currently support it,
>        * disable it for now.
>        */
>       if (cpu->cfg.ext_smdbltrp) {
>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
> -        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
>       }
>   }
>   


