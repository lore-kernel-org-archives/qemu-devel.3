Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A809FC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWYf-0001tT-T5; Tue, 20 Feb 2024 15:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWYa-0001sR-MQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:17:36 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWYY-0007Tz-Nq
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:17:36 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e435542d41so1611486b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708460250; x=1709065050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iHQGu7tLrvRj+uItTa8NOCbMhg6/m//HmY9+pDqTuxs=;
 b=xd2IztiQdyCfixBkYl2O08I4q6iHb+p1iKjgl7GBwpBmtdyZlf2pqLBFUo6MErssA1
 es3rBwSKuhr9Kn4iCWvSmXVWrfx8eQjYnPnAZur9Df+59os3HynttQOHqVjHasLRqyl0
 Tf25qoD8NLarwkHJS7ApczATF2RAWlW/Woz1SHiBAlrXala5qf8yXkDOHAyn+2ZEJuKm
 eYkRxo/VIOnLWzVUYzXUYcUUBssG4Nz7tx5Zmoq7d8D6w9LHjl69hoWTQuQbqGhI2hz+
 WwtsxqsMFnT+QACB5USMXgs/yL82eYxwOlCkf4eYna4sKbK3b3C7+YfrCZD8gTCGMo76
 HcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708460250; x=1709065050;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iHQGu7tLrvRj+uItTa8NOCbMhg6/m//HmY9+pDqTuxs=;
 b=AL0U7ovOOZj/Y6YCBs7FbZsILZj1i1z4hJ8vP+zkGqr0tvWgSEqQ8UoDW0UMe9wbtb
 4Zv6dExA/qe8QLmlJCtqjx1kuR3DEsmMPCyzZaH2RjhZz8lCuT8soce/SoDwTwP0GetK
 RIxPzqQKzQa7N20W6WXpWA7G/4/SzP+x0uCjrrAt8FMdtYgLh2Oc3EdQ036gWRWYe9NM
 qUoaTKNZVvrjwL8v3u+qT2jM+6XcEYSALZzsjxsfKGKNNoNMpmzjAESXq9rmp6Dy8Or8
 El2GKqzQXmIw7FQ8irYiNFJqAPALXOZXj58YpCFlbcUZNNmS3R74K6g2Nh73uymhoDsa
 fI9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVifAfEf7UJehLfaFmc2+P8d1zGodxP/rzFmj3aPDhFiynZ8MJF6zOeaQDruu6xQexkjSgPXmVKKoJjP9qFfcV45TzdE3M=
X-Gm-Message-State: AOJu0Yx43vILH+UR7zJb9hkXetGkKwf2qR726ldXV8bO7dzsqUi6yjfo
 HgwedFv72EgI8aEtFcSXEPnBFk0jVNXlNt5Pc+fUbAaf5lLCL8gNtTD8LzhUlwY=
X-Google-Smtp-Source: AGHT+IFdiXn5IFRaUZnLHqeyhUQmh67lP33GbvXqg9ago4haI4InEe4s1FYv88XKTtjqi79sxgaq3w==
X-Received: by 2002:a05:6a20:af13:b0:19e:a574:9b10 with SMTP id
 dr19-20020a056a20af1300b0019ea5749b10mr11930603pzb.33.1708460250582; 
 Tue, 20 Feb 2024 12:17:30 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 c11-20020a62e80b000000b006e39d08cb3asm6209712pfi.167.2024.02.20.12.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:17:30 -0800 (PST)
Message-ID: <32df58bf-cf71-4825-8b56-67108c81944d@linaro.org>
Date: Tue, 20 Feb 2024 10:17:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] trans_rvv.c.inc: mark_vs_dirty() before stores
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
 <20240220192607.141880-2-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220192607.141880-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 2/20/24 09:26, Daniel Henrique Barboza wrote:
> While discussing a problem with how we're (not) setting vstart_eq_zero
> Richard had the following to say w.r.t the conditional mark_vs_dirty()
> calls on load/store functions [1]:
> 
> "I think it's required to have stores set dirty unconditionally, before
> the operation.
> 
> Consider a store that traps on the 2nd element, leaving vstart = 2, and
> exiting to the main loop via exception. The exception enters the kernel
> page fault handler. The kernel may need to fault in the page for the
> process, and in the meantime task switch.
> 
> If vs dirty is not already set, the kernel won't know to save vector
> state on task switch."
> 
> Do a mark_vs_dirty() before store operations. Keep the mark_vs_dirty()
> call at the end for loads - the function is a no-op if mstatus_vs is
> already set to EXT_STATUS_DIRTY so there's no hurt in store functions
> calling it twice.
> 
> [1] https://lore.kernel.org/qemu-riscv/72c7503b-0f43-44b8-aa82-fbafed2aac0c@linaro.org/
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 29 +++++++++++++++----------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 9e101ab434..2065e9064e 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -636,12 +636,13 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>       tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
>   
> -    fn(dest, mask, base, tcg_env, desc);
> -
> -    if (!is_store) {
> +    if (is_store) {
>           mark_vs_dirty(s);
>       }
>   
> +    fn(dest, mask, base, tcg_env, desc);
> +
> +    mark_vs_dirty(s);

You misunderstood here, I think.
Both loads and stores need to set dirty early, before any exit via exception path.

I see that I did say only stores in the quoted mail, but I believe that was merely in 
reference to stores not setting dirty *at all* beforehand.


r~

