Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122A7D6ACF5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 13:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWDhN-0004Eo-R0; Thu, 18 Dec 2025 08:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vWDh9-0004Bx-1f
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:05:27 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vWDh4-0005l8-Pi
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:05:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso1848675ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1766063118; x=1766667918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+z3bj/CCe8/ojw0XLLJsv4AL1RajFu6OXf7HgcOqwYk=;
 b=oMkCqVvmmGON4QONl9wbLyRa2NBUXfsn67a6N3zIYwfCa3lSn8WHVedHyfKpQ/bh/S
 5AjK3l2rMgNvBccvLrhKnySVL+aXRv1OoWkpVd9QALLYNot7qXbUNEzIo3lRJ0GNAYyu
 9KLhGgqByMQII+VK9qNdEO86iLVxqvdZXApNIsh6zIy7yMUUItOh4vM0hCJOVWGFtq2q
 6qoq3lwJC4GMXzAtV3erFYtksz/CF4DPXMzI/ZN26u4uuUOqlfSgBTPsvlNJnLwfjY5z
 27GH8wsxinOoeuh/VsQhWn20SrmNnR3/3Rs1SwEevkbpNrKyL/t3RRhv6eZqhK3MoWUX
 Jlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766063118; x=1766667918;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+z3bj/CCe8/ojw0XLLJsv4AL1RajFu6OXf7HgcOqwYk=;
 b=IsqL+iO/FMh502NN6e8wIXK/g2uxI0gUU542TM0O+4F7PCIXaLgTghMW26BqqUibZe
 1MS9h7IKrfF5tNTThP2mLweXC69lfGVN+Qmr55jtiRQXHb3YWAz0K+iGtVFb+8hSW8ee
 h0k5nG4ctT+cwHLloAtFKqaSDG7rkSN+ca0xZgaoUoyrZitppfC8QP4ncWFEgv98xlv0
 Yxd1iOUfqn/LGDtuZloPAe4K69fgq7/F9rj+G5tBlc2VHIPVx98qsoPDdM3A3ggrJ41C
 3cFt8hXQC2tmKGP2K+qGB6uyethk/4Y9E5PRM1ZRqEndkI1fxrtK6TCv1Tfu5d4o6D98
 rzMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPlWgirA9srkyJXv0O2yYVtQ49fb/4YkTWmrTrKbXpT8FPk5WLm3yKqtf2tb4ssiMvbgDMrJ38NEKq@nongnu.org
X-Gm-Message-State: AOJu0Yx8rLRdSuhc+gr3OMXyUSP51toHz8ZDJpfgDrJRYI1PI7JIDMPY
 HRNozvnE1fXDkqftOHw7SsNqDneAMLms0oMEqgQ8QYiOGsB3jKzXKtxVJpAdHPaGRyQ=
X-Gm-Gg: AY/fxX67P6U/ygUZ4E8IsWyfjYgxvqpsqxUPLrC1OGiMALTCTr3UbXQPFGyovNByn6T
 8BpTep1dTu7bgaocYGGWfN+GpGlNbCytXmUUri9V2dPZoXFM/JCrzA/d+qzJIaSNZpAPAokUDFw
 cELxUKpKKwjHiVdPB7t82JO9RLpHLsz5JM6FUeXW8RxCePpK2ksQdMT9j72DmQnZ+fTMK3i9DoK
 j88EY8SXSkH5ACZF4VNjK7a01jif/gI0Z8jHe1u0zpijT8pSHl3Uqn44b9T9YwQgZYWUsUw9F2V
 eELU55Vv/fXUvVa9YjY56+AM/Cd7vgmcOwcGilFUYQ8pdfkJev53e26CTI6/dAeUJ0sjJkZpo6t
 LJs4Ef1mOesXZSt7lGcNReG0y7aeap65eHAzhwwTDHQWViMPQxBRjKrLxej/7yctf6/B5h1eWKD
 O7wX8lJbRqYuPQdj52Q9mIeoHU
X-Google-Smtp-Source: AGHT+IG/efVD5kFXwm8H7Wxm2n0l/snwf23MtRwJjESsd9BeYAY00Tf3pWtswvJucKaR3vsm+R1zVA==
X-Received: by 2002:a17:903:2451:b0:2a0:ea4c:51ed with SMTP id
 d9443c01a7336-2a0ea4c52b0mr132365235ad.28.1766063118308; 
 Thu, 18 Dec 2025 05:05:18 -0800 (PST)
Received: from [192.168.68.110] ([179.193.8.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d193e748sm25798425ad.96.2025.12.18.05.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 05:05:17 -0800 (PST)
Message-ID: <477a8f96-de1b-404f-b754-012e6ac32430@ventanamicro.com>
Date: Thu, 18 Dec 2025 10:05:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
References: <20251217063955.1037737-1-frank.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251217063955.1037737-1-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 12/17/25 3:39 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Use designated initializers to initialize riscv_excp_names[] and
> riscv_intr_names[] so that we don't have to explicitly add "reserved"
> items.

You also added entries that were missing before in both arrays (sw_check,
hw_error, semihost, counter_overflow ...). Not sure if it's worth sending a
v2 just to amend the commit msg though.

> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
>   1 file changed, 45 insertions(+), 44 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index aa58ba8b99a..ee859093f78 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -305,60 +305,61 @@ const char * const riscv_rvv_regnames[] = {
>   };
>   
>   static const char * const riscv_excp_names[] = {
> -    "misaligned_fetch",
> -    "fault_fetch",
> -    "illegal_instruction",
> -    "breakpoint",
> -    "misaligned_load",
> -    "fault_load",
> -    "misaligned_store",
> -    "fault_store",
> -    "user_ecall",
> -    "supervisor_ecall",
> -    "hypervisor_ecall",
> -    "machine_ecall",
> -    "exec_page_fault",
> -    "load_page_fault",
> -    "reserved",
> -    "store_page_fault",
> -    "double_trap",
> -    "reserved",
> -    "reserved",
> -    "reserved",
> -    "guest_exec_page_fault",
> -    "guest_load_page_fault",
> -    "reserved",
> -    "guest_store_page_fault",
> +    [RISCV_EXCP_INST_ADDR_MIS] = "misaligned_fetch",
> +    [RISCV_EXCP_INST_ACCESS_FAULT] = "fault_fetch",
> +    [RISCV_EXCP_ILLEGAL_INST] = "illegal_instruction",
> +    [RISCV_EXCP_BREAKPOINT] = "breakpoint",
> +    [RISCV_EXCP_LOAD_ADDR_MIS] = "misaligned_load",
> +    [RISCV_EXCP_LOAD_ACCESS_FAULT] = "fault_load",
> +    [RISCV_EXCP_STORE_AMO_ADDR_MIS] = "misaligned_store",
> +    [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] = "fault_store",
> +    [RISCV_EXCP_U_ECALL] = "user_ecall",
> +    [RISCV_EXCP_S_ECALL] = "supervisor_ecall",
> +    [RISCV_EXCP_VS_ECALL] = "hypervisor_ecall",
> +    [RISCV_EXCP_M_ECALL] = "machine_ecall",
> +    [RISCV_EXCP_INST_PAGE_FAULT] = "exec_page_fault",
> +    [RISCV_EXCP_LOAD_PAGE_FAULT] = "load_page_fault",
> +    [RISCV_EXCP_STORE_PAGE_FAULT] = "store_page_fault",
> +    [RISCV_EXCP_DOUBLE_TRAP] = "double_trap",
> +    [RISCV_EXCP_SW_CHECK] = "sw_check",
> +    [RISCV_EXCP_HW_ERR] = "hw_error",
> +    [RISCV_EXCP_INST_GUEST_PAGE_FAULT] = "guest_exec_page_fault",
> +    [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] = "guest_load_page_fault",
> +    [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] = "virt_illegal_instruction",
> +    [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] = "guest_store_page_fault",
> +    [RISCV_EXCP_SEMIHOST] = "semihost",
>   };
>   
>   static const char * const riscv_intr_names[] = {
> -    "u_software",
> -    "s_software",
> -    "vs_software",
> -    "m_software",
> -    "u_timer",
> -    "s_timer",
> -    "vs_timer",
> -    "m_timer",
> -    "u_external",
> -    "s_external",
> -    "vs_external",
> -    "m_external",
> -    "reserved",
> -    "reserved",
> -    "reserved",
> -    "reserved"
> +    [IRQ_U_SOFT] = "u_software",
> +    [IRQ_S_SOFT] = "s_software",
> +    [IRQ_VS_SOFT] = "vs_software",
> +    [IRQ_M_SOFT] = "m_software",
> +    [IRQ_U_TIMER] = "u_timer",
> +    [IRQ_S_TIMER] = "s_timer",
> +    [IRQ_VS_TIMER] = "vs_timer",
> +    [IRQ_M_TIMER] = "m_timer",
> +    [IRQ_U_EXT] = "u_external",
> +    [IRQ_S_EXT] = "s_external",
> +    [IRQ_VS_EXT] = "vs_external",
> +    [IRQ_M_EXT] = "m_external",
> +    [IRQ_S_GEXT] = "s_guest_external",
> +    [IRQ_PMU_OVF] = "counter_overflow",
>   };
>   
>   const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
>   {
>       if (async) {
> -        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
> -               riscv_intr_names[cause] : "(unknown)";
> +        if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
> +            return riscv_intr_names[cause];
> +        }
>       } else {
> -        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
> -               riscv_excp_names[cause] : "(unknown)";
> +        if ((cause < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[cause]) {
> +            return riscv_excp_names[cause];
> +        }
>       }
> +
> +    return "(unknown)";
>   }
>   
>   void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)


