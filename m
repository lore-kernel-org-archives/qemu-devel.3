Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1940ED6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeyA-0007tV-7e; Thu, 14 Nov 2024 13:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBey7-0007t4-S8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:27 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBey6-0007Ry-6b
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:53:27 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72467c35ddeso887018b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610405; x=1732215205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zUc5/WEBaYxt3sXfI0EhAtp04rS1XcSHu3NsL7DuhGc=;
 b=lLguEIf678/gCna6zqwsu5fbTVOnijOg56QnWeQTOH6sK4NKXqk9RIa2VmaLN6RG5Y
 TnTzN/jOkLjgKoZ6X7mi1Ze9zL5Ov5aVqCfNq3V0TCpxcE3w37OwRqTr/RpwyYQ28nGC
 8eONcAyn6vsNGL6x4AKWJOpGS2aTpSR6SYk7lO6wPGe8v9BDUcFo78ZAZv+UW68TielS
 vrCaPTufIhuy9fUR0A+AA/YS60vYYhcBqee63olr3pReqqGFaBWjeQUx3EI8l+WxtrEj
 zmUq5XN9nODZwWzPgk8n3tt0iiHtev5EAQhgC5PJoKRFrnTRbfWQQXS4WGY8ObxBg5qa
 Mb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610405; x=1732215205;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zUc5/WEBaYxt3sXfI0EhAtp04rS1XcSHu3NsL7DuhGc=;
 b=rpAT4GwoypSnspLUQEquw29dYOKqhN4SmqKqz5TKkK35wvrhuTFg6REVCgqH6YZbQb
 ZhnmCK363KBaqCecBgVv2g+c5v2/Osj5qy17FGneUEmACXfnLAkXRZx+JeApjnr0YprN
 FqduBVCqRGwkp0n8Cx+N2VPVJYaXSOsGXAcq3z6AQVkSC12vAmHaCVGACEYqRt5pCXzt
 EUcBL+GCt3i6pK5kEhMaAp+7v642RPMKe7LNvJkPAnnS1zUvf5RgfZG7BAGn+Lh9S3Bg
 oVooHMGztKmtOoQJ61B/40FLvV0HrKjWWW6142HjiapYYIU1/T9ydnh3/cESmu4W7M7U
 a8Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2YSZjDqqWQzefeq7Y3Ow00K5+AetgltkvwPt49RGvgB7WBhtUXulpj5nJBQ8yV5nvPjuOIWCByJ76@nongnu.org
X-Gm-Message-State: AOJu0YwNEJSZTw/c12khMd7C97+O81hGoigiT90Cn/lW/pZ+i71jIJp6
 4DWNBy9AG0u4Gx9uizy6+laj0yw1FRlwivzeaSYd4ZcZGl5LjU+lYh/RseaYD1s=
X-Google-Smtp-Source: AGHT+IHefL9fO44R1ZFzwRMALK7u4mCzFrHuHDiw/8vdRkFR7tr61yENU227XUDM8iAlQo4Hs3uGiQ==
X-Received: by 2002:a05:6a00:4fd5:b0:71e:7f08:492c with SMTP id
 d2e1a72fcca58-72475f97182mr247130b3a.1.1731610404741; 
 Thu, 14 Nov 2024 10:53:24 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5cfabdsm1587559b3a.13.2024.11.14.10.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:53:24 -0800 (PST)
Message-ID: <4178784a-1c8f-4596-8d08-c80188ec7ca5@linaro.org>
Date: Thu, 14 Nov 2024 10:53:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/54] target/avr: Convert to TCGCPUOps.tlb_fill_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-36-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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
>   target/avr/cpu.h    |  7 ++++---
>   target/avr/cpu.c    |  2 +-
>   target/avr/helper.c | 19 ++++++++++++-------
>   3 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index 4725535102..cdd3bcd418 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -23,6 +23,7 @@
>   
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> +#include "exec/memop.h"
>   
>   #ifdef CONFIG_USER_ONLY
>   #error "AVR 8-bit does not support user mode"
> @@ -238,9 +239,9 @@ static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
>       env->sregI = (sreg >> 7) & 0x01;
>   }
>   
> -bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                      MMUAccessType access_type, int mmu_idx,
> -                      bool probe, uintptr_t retaddr);
> +bool avr_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
> +                            MMUAccessType access_type, int mmu_idx,
> +                            MemOp memop, int size, bool probe, uintptr_t ra);
>   
>   #include "exec/cpu-all.h"
>   
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 3132842d56..a7fe869396 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -211,7 +211,7 @@ static const TCGCPUOps avr_tcg_ops = {
>       .restore_state_to_opc = avr_restore_state_to_opc,
>       .cpu_exec_interrupt = avr_cpu_exec_interrupt,
>       .cpu_exec_halt = avr_cpu_has_work,
> -    .tlb_fill = avr_cpu_tlb_fill,
> +    .tlb_fill_align = avr_cpu_tlb_fill_align,
>       .do_interrupt = avr_cpu_do_interrupt,
>   };
>   
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 345708a1b3..a18f11aa9f 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -104,11 +104,11 @@ hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>       return addr; /* I assume 1:1 address correspondence */
>   }
>   
> -bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                      MMUAccessType access_type, int mmu_idx,
> -                      bool probe, uintptr_t retaddr)
> +bool avr_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
> +                            MMUAccessType access_type, int mmu_idx,
> +                            MemOp memop, int size, bool probe, uintptr_t ra)
>   {
> -    int prot, page_size = TARGET_PAGE_SIZE;
> +    int prot, lg_page_size = TARGET_PAGE_BITS;
>       uint32_t paddr;
>   
>       address &= TARGET_PAGE_MASK;
> @@ -141,15 +141,20 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                * to force tlb_fill to be called for the next access.
>                */
>               if (probe) {
> -                page_size = 1;
> +                lg_page_size = 0;
>               } else {
>                   cpu_env(cs)->fullacc = 1;
> -                cpu_loop_exit_restore(cs, retaddr);
> +                cpu_loop_exit_restore(cs, ra);
>               }
>           }
>       }
>   
> -    tlb_set_page(cs, address, paddr, prot, mmu_idx, page_size);
> +    memset(out, 0, sizeof(*out));
> +    out->phys_addr = paddr;
> +    out->prot = prot;
> +    out->attrs = MEMTXATTRS_UNSPECIFIED;
> +    out->lg_page_size = lg_page_size;
> +
>       return true;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


