Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C439D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf0X-0002uh-QU; Thu, 14 Nov 2024 13:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBez5-0001PA-Ut
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:32 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeym-0008Ip-Qg
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:54:16 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso795054b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610447; x=1732215247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lAbgNVWmRsGLd77zEXVM2m8mbKdHv1npY7wMUjoJjRA=;
 b=c7GHfL0c6I4YaXBNVjPId2tSCDF1wuyrZV56N8flhzUcVF/8WcKJ9z0FWbPyrRrDB0
 MyIsRjGwCiVPeI4CkwWONrQ2tSTmPdK6q8QExiOc3HEVd2dzVbNBykf+YKXAteZhFMGi
 fdmiFiy/u3Tt6MAFJY5ISs4jZNmmscGRaHVPWoi+gCWYPk4ueTmZhonKSJAjGHUCuYMV
 pe7LmDhye8cdD+t06Uh1pi+5eZZY+qEx1nlsLa2DCeO8/wr1xVX6lAokXtqXgTdeTEV/
 62lWH7o/J13dhZv+3eLx9F4odZ3vnPytnhjsmuE9QcxdyzlT8cJosK7cKjIW2FIzb2w/
 mNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610447; x=1732215247;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lAbgNVWmRsGLd77zEXVM2m8mbKdHv1npY7wMUjoJjRA=;
 b=RzUtOMdxvyQxwtewaHiHGawSlDuIleU8aU+xdz/FUm9w3dDQwEJZC7AvXf9iYvfsJl
 ZBTeCbSz9Nn2AUsXe0m22m675eQ043j9XYiMJlUpH/JUFFONYrv+YxMCajN9k3Ggz2Ls
 WgpmHAgn7P/Xfe8GrW3NyGcMWSeJ41AUB4Dz9UuyTBtzwKxW+3camwGf6LS8pK6wN6yY
 qJwKkZAJtHURnB+wJttYlH/emAnmhc8vGLstbqyPEH6eVorWWLpiPgaeyyzP793+6llC
 vpCR3Sn1kazZ56/6BHx8iRS9xMLxoMrmp9bMN/Nck/ddz9lgJRfj0Ea9gXo4ulQaVgxV
 J5+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIXWhYLmUU8HZv+o+sbtC2Q5HND4+5Q4ELrBnw12oYCZSpmKcj08MwCh1p6pXjE1XmqN4j6UprpaQ9@nongnu.org
X-Gm-Message-State: AOJu0Yz160Sxi+Jf05WQfNLX22YeLgpIMraHkUoH6tENqxraDHU+sF/Y
 nKYOX+syXruDDJt90b/VVtBssoFzXzu/Y7f8keWAYumTpjcPZILXsz96gpDW3VTlLy/xMbn5Opr
 va5RNKw==
X-Google-Smtp-Source: AGHT+IHeTXLuUVn++MBiGjK5+0GZxmz9+rXd/PQfke1V373z2CD2GQwdQXDfPyGJqhYwm7LGSQ5dWg==
X-Received: by 2002:a05:6a00:b85:b0:71d:f2e3:a878 with SMTP id
 d2e1a72fcca58-72469c25370mr3404666b3a.5.1731610447357; 
 Thu, 14 Nov 2024 10:54:07 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ceda0sm1592394b3a.1.2024.11.14.10.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:54:06 -0800 (PST)
Message-ID: <3ae7c3e5-ec40-4d06-ab90-789fc9f7d82a@linaro.org>
Date: Thu, 14 Nov 2024 10:54:06 -0800
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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


