Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165E6D1D48A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKTA-0005J4-6r; Fri, 09 Jan 2026 16:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veKSk-00059y-4X
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:56:09 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veKSi-0002JA-A9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:56:05 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34f634dbfd6so3160197a91.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767995763; x=1768600563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WSWn3Ja9IeFXdlijC2lcdso25jSTdWTtI8ox/a2k3LQ=;
 b=z0zOA4aXNBt+1idZMbFn54OlLkYaGHX8rqg52GbZ9qrPHMv0S/kDp/XV8fG9S1YCtm
 99bBY1qjFG2p9LzDaqP9nL5Rcl1cKEt0xtZ1hzpnT9L9N8Fbu3w9kw18RVnHbI/zLMcO
 vBDc+XlTitTfhuasZHTUmYLs9/bYubh8gEo2GXKdqLZQyYeR2ayIrCF5OMa6XgwYOw3n
 g7C90bO6UbXe3LFt5GnTdEXsomHry3iYh5Aj6t4z5vZXsXDaeuZlcBdkoQRDp2THh4gJ
 I+HEGEUamMfRlMgqCMrtUFhB3BKSay/sQ4lzQoUUoLFLNvw9VjXW+xKZGRW/H5xikwhP
 fMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767995763; x=1768600563;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WSWn3Ja9IeFXdlijC2lcdso25jSTdWTtI8ox/a2k3LQ=;
 b=D8HwSH8XH8qMu1PNto83NEpaIwfPijC/Ky5L7Npy4xnlWOkCjN0G32kLS5jkg3J4lz
 xEUhdovC5JBt9giB3aKS5uSmLLHnKO7IUf0ejY0SydEMB7FCauLG2xLhrX9Ol45dgRyu
 iyaEXlm2fIDt3jFrg394jv7BCT/St4oHvaEFsKxIYlphTAo3DTwbMZ8rD8o/aIwyOOE9
 CVyHnFn5bILwlhbkHTL77P5qNVWzKpnrFhaC1lanYo9jxDABykQOd/Ux7anFBO1KiPel
 9MlwcIkn/9b+8VkffFftcGGdbDj/UvwwZJdXXU6ZJH2JlSgf7jzpcSwQnLHpCSUGJgro
 KFXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaou8TbMvgVSjGnf907N459fJvvSrv1dWPimGRiVh6QhFMs1IG/gOCnkgsKFUR0aiZbZuc98syh9U/@nongnu.org
X-Gm-Message-State: AOJu0YzmmjtYIFoo5NO+Onvm+QIFJJd9xxhRke9bwj50v4FKtiyVipDC
 RI8ULVqdLyaJKmQe0MNns/tN2fxzeEqHqaMWwCYPg0LAFHW1T5Uxuue/pcxwcRpIrCU=
X-Gm-Gg: AY/fxX5CWVpTV1eEnyKTAoA9ksD5KDbLToOwOldh4un5trytP5XU4nL+55uVM3ryMBB
 tABrmzdUPn1kA1gXvEykOaD/5dNcyy1nup+MAyu4fhKjpvghSQarS7mkbIM1+ARM9SW6FKNfCM2
 6MMj74rROIVZY4gBb6I9HP+Jrc517Ak+i+WVJhUqSoCOI0U5M9cSLjb7DZd7403eg79ykQmyfWD
 UnX1fbTnlDBPGKtXknMpqPUpH5svSIkvjkVHGbcUQdMHUCgIr/hYsKVmwa42v9jmvJK6JYXShPp
 2zNqp0vFO0SXmJ9tr29ReAS7N5RdM45mRejW9MAOgdxS9yO8I4EkbVUbf854MLEpnqVpjv65j53
 HBWqSrNe/jikGx5uiNuUICVC+8Ob1Vh1IhWRV6+PRpEhbxO4idhB/lw1XZQheRFu5pG6qJmZDlk
 jQaWVkH2a+M1opXerFivFKZGhKQW4WoXrPSbRbvmlkuzDxMw+Fy0phxRX/
X-Google-Smtp-Source: AGHT+IEi8L7BdPcxYOmsBgU/cuqGkhqgroibaPIeOHeg8Dhd2lNMbee003v2FjmQQUZyc/4JwDhIDQ==
X-Received: by 2002:a17:90b:2711:b0:34f:62e7:4cfd with SMTP id
 98e67ed59e1d1-34f68cbe5e1mr10412776a91.24.1767995762662; 
 Fri, 09 Jan 2026 13:56:02 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f7c4141sm11489842a91.6.2026.01.09.13.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:56:02 -0800 (PST)
Message-ID: <010c658b-6c96-49bc-807e-67139a7dc198@linaro.org>
Date: Fri, 9 Jan 2026 13:56:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/29] include/tcg/tcg-op.h: eradicate
 TARGET_INSN_START_EXTRA_WORDS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-14-pierrick.bouvier@linaro.org>
 <70ef91e3-1022-4ff6-a671-5f08f3268aa0@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <70ef91e3-1022-4ff6-a671-5f08f3268aa0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 1/9/26 1:51 PM, Richard Henderson wrote:
> On 1/9/26 16:31, Pierrick Bouvier wrote:
>> We simply define the 3 variants and call the correct one per arch.
>> Since all arch have a single call site (in translate.c), this is as
>> good documentation as having a single define.
>>
>> The notable exception is target/arm, which has two different translate
>> files for 32/64 bits. Since it's the only one, we accept to have two
>> call sites for this.
>>
>> This is much simpler and safer than trying to define a common functions
>> with variadic or unused parameters. The only risk is calling two
>> different variants for a single arch, but as mentioned in first
>> paragraph, there is no real reason for this to happen.
>>
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> ---
>>    include/tcg/tcg-op.h             | 16 ++++++----------
>>    target/alpha/cpu-param.h         |  2 --
>>    target/arm/cpu-param.h           |  7 -------
>>    target/avr/cpu-param.h           |  2 --
>>    target/hexagon/cpu-param.h       |  2 --
>>    target/hppa/cpu-param.h          |  2 --
>>    target/i386/cpu-param.h          |  2 --
>>    target/loongarch/cpu-param.h     |  2 --
>>    target/m68k/cpu-param.h          |  2 --
>>    target/microblaze/cpu-param.h    |  2 --
>>    target/mips/cpu-param.h          |  2 --
>>    target/openrisc/cpu-param.h      |  2 --
>>    target/ppc/cpu-param.h           |  2 --
>>    target/riscv/cpu-param.h         |  7 -------
>>    target/rx/cpu-param.h            |  2 --
>>    target/s390x/cpu-param.h         |  2 --
>>    target/sh4/cpu-param.h           |  2 --
>>    target/sparc/cpu-param.h         |  2 --
>>    target/tricore/cpu-param.h       |  2 --
>>    target/xtensa/cpu-param.h        |  2 --
>>    target/alpha/translate.c         |  4 ++--
>>    target/arm/tcg/translate-a64.c   |  2 +-
>>    target/arm/tcg/translate.c       |  2 +-
>>    target/avr/translate.c           |  2 +-
>>    target/hexagon/translate.c       |  2 +-
>>    target/hppa/translate.c          |  2 +-
>>    target/i386/tcg/translate.c      |  2 +-
>>    target/loongarch/tcg/translate.c |  2 +-
>>    target/m68k/translate.c          |  2 +-
>>    target/microblaze/translate.c    |  2 +-
>>    target/mips/tcg/translate.c      |  4 ++--
>>    target/openrisc/translate.c      |  4 ++--
>>    target/ppc/translate.c           |  2 +-
>>    target/riscv/translate.c         |  2 +-
>>    target/rx/translate.c            |  2 +-
>>    target/s390x/tcg/translate.c     |  2 +-
>>    target/sh4/translate.c           |  4 ++--
>>    target/sparc/translate.c         |  2 +-
>>    target/tricore/translate.c       |  2 +-
>>    target/xtensa/translate.c        |  2 +-
>>    40 files changed, 30 insertions(+), 82 deletions(-)
>>
>> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
>> index f3fe2d9386a..bf76749d1c5 100644
>> --- a/include/tcg/tcg-op.h
>> +++ b/include/tcg/tcg-op.h
>> @@ -28,8 +28,7 @@
>>    # error Mismatch with insn-start-words.h
>>    #endif
>>    
>> -#if TARGET_INSN_START_EXTRA_WORDS == 0
>> -static inline void tcg_gen_insn_start(uint64_t pc)
>> +static inline void tcg_gen_insn_start0(uint64_t pc)
>>    {
>>        TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>>                                INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
>> @@ -37,8 +36,8 @@ static inline void tcg_gen_insn_start(uint64_t pc)
>>        tcg_set_insn_start_param(op, 1, 0);
>>        tcg_set_insn_start_param(op, 2, 0);
>>    }
>> -#elif TARGET_INSN_START_EXTRA_WORDS == 1
>> -static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
>> +
>> +static inline void tcg_gen_insn_start1(uint64_t pc, uint64_t a1)
>>    {
>>        TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>>                                INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
>> @@ -46,9 +45,9 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
>>        tcg_set_insn_start_param(op, 1, a1);
>>        tcg_set_insn_start_param(op, 2, 0);
>>    }
>> -#elif TARGET_INSN_START_EXTRA_WORDS == 2
>> -static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
>> -                                      uint64_t a2)
>> +
>> +static inline void tcg_gen_insn_start2(uint64_t pc, uint64_t a1,
>> +                                       uint64_t a2)
>>    {
>>        TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>>                                INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
>> @@ -56,9 +55,6 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
>>        tcg_set_insn_start_param(op, 1, a1);
>>        tcg_set_insn_start_param(op, 2, a2);
>>    }
>> -#else
>> -#error Unhandled TARGET_INSN_START_EXTRA_WORDS value
>> -#endif
>>    
> 
> Eh.  If you're going to change anything here, we might as well force the targets to supply
> zeros for the unused parameters and move the last 3-argument tcg_gen_insn_start to
> tcg-op-common.h.
>

Ok, back to having a constant and check it at runtime then...

> 
> r~


