Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2487C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 09:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgL33-0004lz-IO; Tue, 20 Aug 2024 05:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgL30-0004ip-5n
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 05:21:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgL2x-00036V-SZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 05:21:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20203988f37so36303245ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724145658; x=1724750458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HdDGhAKBeL1QRH3eUcTtKffAapBIiS9F6jCqefsIPts=;
 b=ROjh6gYNVbjhyF68YV1CxiacothmGb398wFuF9osc7w1OWcwVjmjNQrF6UYjFQ5/DO
 euRmj0+nv/NGyTnZrTSOXN3goh4aobh0unZkS9LmTnYVlua5XDZsw8+EOVvzG/pkGu7C
 iAkHRJ2T/hcqkb4l+t27/L6yiYkYieSly7OGGXCrmsVeGAQ768Wnj82M3im9mcHaobiL
 d7uZ3is5YDM7synk2vIY+EW0uz2uQ6QlMnIXJC8C56eeiVtj8ogEHpVQzRgHfrVMWPOE
 ko0BYek9krwS46EpHPKFGkweCG9UWgjgVzX/vqD0hLnVHp6o3CPzBHW4hy37YEZymN0h
 aeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724145658; x=1724750458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HdDGhAKBeL1QRH3eUcTtKffAapBIiS9F6jCqefsIPts=;
 b=hD0EmHXPCg8qwtAtVzwKz9D/qepr8P66qkrIMxlOYhBz9BZCCnMNo173dvCwCL/8h0
 VtJuEsm1+pxSHnsnm/7Ib42XYyj904buF1IQbHHz1xdwomnFTMQZhncpVTM3OXUl9Ypc
 gyLpWut/f8tF4Fda1vtvQx7eKQcT04Jf9rHITR8q+Gdrx4eeULXerj+USFzN0fdf0Wo1
 ICjzt2iE6wEs4ysY8FeZa9wQcrZrLzQ+oZQSfH5tWnIz4wuoE4Q/8SJAs3GpyEB30b8L
 oqOtToef0HV+VkGDxInCK3fun1n+b60d12ofs2ujrsxrwIh45dddWVHheEto89JEaRxj
 munw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKaDPuTDWiKtKRgb/re+Ehgrt3Ten4fjao28OGIB5Ct7SZ3lzl1Incy9UmTK+ohk7c2cllJmtSZRY1@nongnu.org
X-Gm-Message-State: AOJu0YzAcaj72eKzqHzuwBwLZfW4g5DrMlpJ4eb/kH++XZbRyw9ROnzE
 sGkMwEmNuyLCsvlCXEEcFPdYw7RqaGDHWei0jgwPdKVSM0Ry6Xtu+eBBUUDyHng=
X-Google-Smtp-Source: AGHT+IExzIGSNwCsRT56rBt6n3QTEXDYIMwHpFcGobBcSwHaeC7yotnwRxw7pLMMwYJUYB6TACF0Rg==
X-Received: by 2002:a17:902:ec86:b0:202:45a7:84d1 with SMTP id
 d9443c01a7336-20245a78820mr69495135ad.52.1724145657628; 
 Tue, 20 Aug 2024 02:20:57 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02faa77sm74244905ad.58.2024.08.20.02.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 02:20:57 -0700 (PDT)
Message-ID: <c0afdd87-71c1-4b02-a2fb-5c9349205d8f@linaro.org>
Date: Tue, 20 Aug 2024 19:20:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/15] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240820000129.3522346-1-debug@rivosinc.com>
 <20240820000129.3522346-12-debug@rivosinc.com>
 <ZsRHPDG/GkyhdrQi@debug.ba.rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZsRHPDG/GkyhdrQi@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/20/24 17:35, Deepak Gupta wrote:
>> +    /* If shadow stack instruction initiated this access, treat it as store */
>> +    if (mmu_idx & MMU_IDX_SS_WRITE) {
>> +        access_type = MMU_DATA_STORE;
>> +    }
>> +
> 
> I think I forgot to address this. Do you still want me to fix this up like you
> had suggested?

Yes, this still needs fixing.


> IIRC, you mentioned to use TARGET_INSN_START_EXTRA_WORDS=2. Honestly I don't know
> what it means and how its used. Based on git grep and some readup, are you expecting 
> something
> along the below lines?
> 
> 
> """
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index fee31b8037..dfd2efa941 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -47,7 +47,7 @@ typedef struct CPUArchState CPURISCVState;
>    * RISC-V-specific extra insn start words:
>    * 1: Original instruction opcode
>    */
> -#define TARGET_INSN_START_EXTRA_WORDS 1
> +#define TARGET_INSN_START_EXTRA_WORDS 2
> 
>   #define RV(x) ((target_ulong)1 << (x - 'A'))
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index f74a1216b1..b266177e46 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1271,6 +1271,11 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong 
> address,
>   {
>       CPUState *cs = env_cpu(env);
> 
> +     if (!pmp_violation &&
> +         tcg_ctx->gen_insn_data[TARGET_INSN_START_EXTRA_WORDS-1] & 1) {
> +         tcg_ctx->gen_insn_data[TARGET_INSN_START_EXTRA_WORDS-1] &= ~1;
> +         access_type = MMU_DATA_STORE;
> +     }

The first thing to understand is that the unwind data is stored by the compiler and 
recovered by the unwinder.

The unwind data is exposed to the target via one of two methods:

(1) TCGCPUOps.restore_state_to_opc, i.e. riscv_restore_state_to_opc.
     The data[] argument contains the extra words.

     With this method, the extra words are restored to env and are
     available in a later call to riscv_cpu_do_interrupt.
     Compare env->bins from the first extra word, which is used exactly so.

     This is probably the easiest and best option.
     You'd promote LOAD* to STORE_AMO* while dispatching the interrupt.

(2) cpu_unwind_state_data()

     With this method, you have immediate access to the extra words,
     and don't need to store them anywhere else.

     This is supposed to be used when we are *not* going to raise
     an exception, merely look something up and continue execution.
     Otherwise, we'd be performing the unwind operation twice,
     and it's not cheap.

So, tcg_ctx->gen_insn_data[] is not something you'd ever touch,
and this is the wrong spot to do anything.


r~

