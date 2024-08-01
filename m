Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765B3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 21:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZdRG-0000ys-TW; Thu, 01 Aug 2024 17:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZdRA-0000y2-IU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 17:34:16 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZdR9-0006YY-2a
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 17:34:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d399da0b5so6436411b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722548053; x=1723152853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Agg+f3TAaoPVGYVcu4+Zv+v4vAFHFvy0lLGDVaB5LNg=;
 b=M4/KhANEhmnsZTEMLQNKy3/XzByZPBZBU8RKmcIVDG3rTqoUtaVdnYSv+YU7qwiX0P
 3j09jnvev7EWPiRUWecTQHnyKXUYv1SSylRkpj/taJl7IW3ZnpDl1voG8kAe0oJkieU6
 Jyp7wc/I2BqhyI8gYMKRLQvnoZGs4kOV1Lqr4gtXsF1pELdZjv0wmSq/u3iHW/hR9C1L
 gQcCzrDtmlktzrUZgslN6mJE3CQJzabRw9FYhR5Wd5ybdzgrhqIq4cr7LS9zjGZ/kWIX
 h8ZDDIcqP/YD7e/geOEVAV/Mo+lF3tksG7snF+OyZyIUWxUChojOze3mau3Q2D7PvUee
 YRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722548053; x=1723152853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Agg+f3TAaoPVGYVcu4+Zv+v4vAFHFvy0lLGDVaB5LNg=;
 b=Zq2hUu7jY79IHRDYrdmBh+sQE5tKFQMm8l4146RikDt3VIjdUgglEErWqEg64RwWHY
 9oGNQRWNElNEHuIqbdHqhJOVTtzJCXO24pwvPTXyRD80+Vui+ZPeIGJa5k5kmHKVF4K3
 aSEEfKrLn13iIGbx1YvtO7LAoXJxi+8Be6qv9QBAhoYLjiMj7xGiME94/E5D+vAkINaA
 VXX99PcKQwMIu9XQklo6judi1haKr8MJFVVYhg/V1opE090d91s14CBWol2Y+3u7tcjW
 MLJXoviPdQUweYi2a539tDwGfh5DkGnWPT+BLgYFo9uZpSQbYCrOB2RiKxJ0Aolt4XM0
 6OxQ==
X-Gm-Message-State: AOJu0Yz35Z4Hc0FCLDuhSJ8ltWMgK5Ra/wFKZ8FdYTZiOLdpAtRnOD5N
 A9IOBzj6YPhG+yyygxx4iISqkdHlCa3NDT7Qtzs/oaLy7s3zp6TRbppth8uV3rI=
X-Google-Smtp-Source: AGHT+IE7eAPaD/TKtbv1YJN7xrB3nP6lJaUPadgpE4rR2TS8+WQomYgjqHD4yW96cAs3j1+sgkcRsw==
X-Received: by 2002:a05:6a21:7896:b0:1c4:818c:299d with SMTP id
 adf61e73a8af0-1c699554699mr2518684637.11.1722548053029; 
 Thu, 01 Aug 2024 14:34:13 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ecdfee1sm265966b3a.136.2024.08.01.14.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 14:34:12 -0700 (PDT)
Message-ID: <81bf91ac-e449-4a05-946f-bfdb7164281a@linaro.org>
Date: Fri, 2 Aug 2024 07:34:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-devel@nongnu.org
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-6-debug@rivosinc.com>
 <ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org>
 <CAKC1njQJiNHT1b2jD009zsNeXrUZ9OG2S4VTeFmnAS4c_f-kAA@mail.gmail.com>
 <0cbb34e8-fa32-469a-a516-4f9ac91a6eff@linaro.org>
 <CAKC1njQqfOrzodxSYK93vQGb_g0oQA4EK7_q-zi4bW5pERvv2g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAKC1njQqfOrzodxSYK93vQGb_g0oQA4EK7_q-zi4bW5pERvv2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/2/24 03:05, Deepak Gupta wrote:
> On Thu, Aug 1, 2024 at 2:12 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 8/1/24 16:59, Deepak Gupta wrote:
>>> hmm... you've suggested below to use `aarch64_tr_translate_insn` and
>>> check if it's the first instruction.
>>> and put the check there.
>>> In that case I won't need FCFI_LP_EXPECTED TB flag.
>>> Then I would rather use it as FCFI_ENABLED TB flag.
>>
>> You will need both bits.
> 
> I was thinking of following logic and wanted to run by you to check if
> I am missing something
> obvious.
> 
> ---Recording fcfi_enabled in disascontext---
> Add a FCFI_ENABLED TB flag which gets set (or not set) in `cpu_get_tb_cpu_state`
> 
> And `riscv_tr_init_disas_context` does
> DisasContext->fcfi_enabled = extracts FCFI_ENABLED TB flag.
> 
> 
> ---Set elp on translation of indirect jump/call----
> translation for jalr (instruction which triggers elp state) does following
> 
> trans_jalr:
> if (DisasContext->fcfi_enabled)
>      env->elp = LP_EXPECTED
> 
> ---Check if first instruction is not a landing pad----
> In `riscv_tr_translate_insn`
> 
> if (first instruction of TB && env->elp) {

You can't access env->elp during translation like this.
That's why you need either

(1) the LP_EXPECTED bit in tb_flags as well, or
(2) a runtime test against elp.

>        if (`insn` is not a `lpad` (landing pad) encoding)
>           raise_exception();
> }
> 
> ---label check embedded in landing pad instruction---
> In `trans_lpad`
> 
> env->elp =  NO_LP_EXPECTED
> invoke a helper which will check embedded label value against value in
> ISA defined register (x7)

You don't need a helper for such a trivial operation.

   tcg_gen_extract_tl(tmp, get_gpr(ctx, 7, EXT_NONE), 12, 20);
   tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->imm, skip);
   generate_exception(...);


r~

