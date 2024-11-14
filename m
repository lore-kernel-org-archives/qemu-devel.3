Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828D4D6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf0h-0003Dg-EG; Thu, 14 Nov 2024 13:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBez5-0001PD-Vc
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:32 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeyr-0008LJ-8a
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:17 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so955102a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610452; x=1732215252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=naHRC0G10HYV/LAot+bVKo5JuJC7HStS24DE1rq9+UY=;
 b=RErgNxEUrHjCRkxwr8r92p5IQgyVDdgfgmUM11ofUxxYI6yhMzzaH8oXRgPmIbwtb6
 WXuF4+clFMwizi6qrJmmBgkixoymk8fxaysv/oRHJo+w19DBeR+Uxev3fOIkB+o8uXIe
 nqMdCHhLjrRnWgPyfujiy1KFGA2nGqslw6NRt4IadCy+HOlFx9kBGYc32gpWQ5Nw6qCk
 D3urUMsUemSTtRApShFhOyi4GUsEzPhC/SuvJaE9e+BbWwYt1t/E27rBLZZUG71zrfYU
 J3uJdPuFrT2XeIR/NXGj9YdGCYqrA2rK1ncdfZ/4WjKrEVSBKAzBMyk5qgIf5QC4l3uU
 FIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610452; x=1732215252;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=naHRC0G10HYV/LAot+bVKo5JuJC7HStS24DE1rq9+UY=;
 b=ekggdqI4oyqdLIRiF0S42gc86YmgTSGIjmZeUAbLtxEtUThVA6gpF8Y52u+yiYD3jx
 CivBs/ldh++RORhkXT0Ztpp39eiTogKc4hJFRaAkMAnQVCMYhZoryJ65V0Z8Z0CLnUH9
 gxC5yED4aOzDjIC+99biOtcDMyHCRns4t3dzRm2ZD4VAbwzDk2dI0gQTWpgraH28UdMR
 9q1KnfFlVXSFhYyijAqYO/dH/MVPH2AHsD0q3N4WDAildifrWsUJgmuRvuAD0mIcwRV0
 SsXksuiBZd90JSqjQs1b9lK1ZB1Bfo2x1eos+QCNdvbJ4t9VXzaB00Ip51d99lOmfj1B
 nspA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULXtlgUYncoQhOqIT8/Ckyj5aDBEvnd/koqAYcDy9SCjZNfhPp0IDQcMDkdj4THIokaeTq3nZa3j/9@nongnu.org
X-Gm-Message-State: AOJu0Yw2svU9LhsjD10tk5QTcvyHms69pfLv4RK0mDL3rFJ8oZj1jDNp
 t+rAsUeoNppNx954Mn7idQHsrKcGkMhyS/gh79fvh0zYUhZ8nKbdzDti0dCmE5lHNdQ91ZI5BaV
 wpQptug==
X-Google-Smtp-Source: AGHT+IHnZM3cYM7EW6vHOcfPCjFmTHr19fkiJKehtWL9xyQ/gZEAYFuf8ygUnLv2bzh/E3c0hHpRhg==
X-Received: by 2002:a05:6a20:7f93:b0:1db:eb5b:be50 with SMTP id
 adf61e73a8af0-1dc832e4455mr4926515637.4.1731610451730; 
 Thu, 14 Nov 2024 10:54:11 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:54:11 -0800 (PST)
Message-ID: <b5acf40f-7a5e-4fbe-81f1-5b1aa23d84cd@linaro.org>
Date: Thu, 14 Nov 2024 10:54:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 45/54] target/rx: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-46-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/rx/cpu.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 65a74ce720..c83a582141 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -161,16 +161,19 @@ static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
>       info->print_insn = print_insn_rx;
>   }
>   
> -static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> -                            MMUAccessType access_type, int mmu_idx,
> -                            bool probe, uintptr_t retaddr)
> +static bool rx_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
> +                                  vaddr addr, MMUAccessType access_type,
> +                                  int mmu_idx, MemOp memop, int size,
> +                                  bool probe, uintptr_t retaddr)
>   {
> -    uint32_t address, physical, prot;
> +    /* TODO: alignment faults not currently handled. */
>   
>       /* Linear mapping */
> -    address = physical = addr & TARGET_PAGE_MASK;
> -    prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> -    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
> +    memset(out, 0, sizeof(*out));
> +    out->phys_addr = addr;
> +    out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +    out->lg_page_size = TARGET_PAGE_BITS;
> +    out->attrs = MEMTXATTRS_UNSPECIFIED;
>       return true;
>   }
>   
> @@ -195,7 +198,7 @@ static const TCGCPUOps rx_tcg_ops = {
>       .initialize = rx_translate_init,
>       .synchronize_from_tb = rx_cpu_synchronize_from_tb,
>       .restore_state_to_opc = rx_restore_state_to_opc,
> -    .tlb_fill = rx_cpu_tlb_fill,
> +    .tlb_fill_align = rx_cpu_tlb_fill_align,
>   
>   #ifndef CONFIG_USER_ONLY
>       .cpu_exec_interrupt = rx_cpu_exec_interrupt,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


