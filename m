Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF70C25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAY8I-0000Q2-Rl; Fri, 24 May 2024 12:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAY8I-0000Pj-84
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:51:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAY8E-00042X-1M
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:51:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so1015210b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716569460; x=1717174260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3CD7uiH67rGFY43H5uR4ucaXvq9C61N3rMy+y3L7tcI=;
 b=CUVu55SVVCD1p7sBhFmrk0XcQCAnQN+3MwmpU+jJmPp65seLmv24An10GWj+8UJkuy
 OYjUpLiM59EvwfywtWtfIb91x0RKcXfJ7vm/R2uBMxIipiRGOTYMRW8J4gLqS9i7DtOc
 3f/dIydU+k9WhAepEcILeyvkhWMh6QRydKDjY/9Q3qwtlkkN8Vj6RyzQI1mUKNgrbOUh
 QuUzaD8A09s+fyISmTpvhY0pMUvbgsmg5Ud7/duU3SSQbtYR5/Hdge14f4i0nHZQU36N
 2t/FSx4C+Uy1hf03uMpbOO80R+iXreV5EzdSNasAnShGGiROs3psJhG8maAQrMafDms1
 30YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716569460; x=1717174260;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3CD7uiH67rGFY43H5uR4ucaXvq9C61N3rMy+y3L7tcI=;
 b=AivE7hkaQ3D5ACC2MswhSNdIMvV7BcPzxyAFsh+PL6b9Qb/Sy7LOURQ76/Fx1neXyy
 n0sBCTPAnQBGLv+CqiCfBNnoP6nehWdrY3HuluCd5HbaCd2Imw4r9DQ/ZBFFqv8p3RRo
 Wbtvnpl9xuG/Y7rW3YXWnoyofswp58kG2OYOJ+NFj4eeqJkm9HDKU8+C/jXHs6KAUKm1
 Z3PDNkiDZxuSrpBJyljqo4I5j3UtFhdbc12GQxGMBTLpnQcPBpJx3vMkIM1+fFmVH2+4
 LrprWLS7yHo4mSxuiku2r+TRV0VcvU4qLAc2pwPBA1roOlm17t8Ckq6wBm5CDf9FpiQ3
 F+wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkHD3wdVD3VQzdfYh26DPzBd/KUEpvU5S/L856fTovLRrAeKX4IRhiPq3kneUk5SUuoQ9CPwGqmKJFASexr/NHBZrxuCU=
X-Gm-Message-State: AOJu0YyEiufrOgr/77w4kW1vZJBJQ54DM/lLYajQUyyDq8SKzsxwZOIL
 yw4e4sn3Ovr5gNygGV4lq/kzGfXkKn2nXY6bcMqnszt3TZeviugPY/vXRjoXdes=
X-Google-Smtp-Source: AGHT+IF2s5UBpXYLmn/j5diEgG4ybkvzGsPLAk9iBbrsZ2uU70+kfeK8PkQ2DLv15bnlxR0fRu8g1Q==
X-Received: by 2002:a05:6a20:da8d:b0:1af:cc84:f7ec with SMTP id
 adf61e73a8af0-1b212d5ad0amr3379308637.4.1716569460302; 
 Fri, 24 May 2024 09:51:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682273c44absm1383814a12.88.2024.05.24.09.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 09:50:59 -0700 (PDT)
Message-ID: <d41e0504-aa75-4d88-93c4-a30843ea3942@linaro.org>
Date: Fri, 24 May 2024 09:50:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: always go through gen_eob*()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240524153323.1267511-2-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524153323.1267511-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/24/24 08:33, Paolo Bonzini wrote:
> Using DISAS_NORETURN does not process any of HF_INHIBIT_IRQ_MASK,
> HF_RF_MASK or HF_TF_MASK.  Never use it, instead there is
> DISAS_EOB_ONLY.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 18 ++++++++++++------
>   target/i386/tcg/emit.c.inc  |  4 ++--
>   2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index ebcff8766cf..df10e7d8a6a 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1406,7 +1406,7 @@ static void gen_exception(DisasContext *s, int trapno)
>       gen_update_cc_op(s);
>       gen_update_eip_cur(s);
>       gen_helper_raise_exception(tcg_env, tcg_constant_i32(trapno));
> -    s->base.is_jmp = DISAS_NORETURN;
> +    s->base.is_jmp = DISAS_EOB_ONLY;

This is wrong, because we exit via exception, right here.
Anything you add afterward is unreachable.

>   }
>   
>   /* Generate #UD for the current instruction.  The assumption here is that
> @@ -2191,7 +2191,7 @@ static void gen_interrupt(DisasContext *s, uint8_t intno)
>       gen_update_eip_cur(s);
>       gen_helper_raise_interrupt(tcg_env, tcg_constant_i32(intno),
>                                  cur_insn_len_i32(s));
> -    s->base.is_jmp = DISAS_NORETURN;
> +    s->base.is_jmp = DISAS_EOB_ONLY;

Likewise.

>   }
>   
>   static void gen_set_hflag(DisasContext *s, uint32_t mask)
> @@ -2354,7 +2354,7 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
>               tcg_gen_movi_tl(cpu_eip, new_eip);
>           }
>           tcg_gen_exit_tb(s->base.tb, tb_num);
> -        s->base.is_jmp = DISAS_NORETURN;
> +        s->base.is_jmp = DISAS_EOB_ONLY;

This is wrong because exit_tb exits, and anything you add after is unreachable.
I think you simply want to remove the exit_tb call as well, but there may be more cleanup 
possible in the wider context; I haven't checked.

>       } else {
>           if (!(tb_cflags(s->base.tb) & CF_PCREL)) {
>               tcg_gen_movi_tl(cpu_eip, new_eip);
> @@ -3520,7 +3520,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
>           gen_update_cc_op(s);
>           gen_update_eip_cur(s);
>           gen_helper_rdpmc(tcg_env);
> -        s->base.is_jmp = DISAS_NORETURN;
> +        s->base.is_jmp = DISAS_EOB_ONLY;

This is wrong because helper_rdpmc is noreturn, always raising an exception.


> @@ -3690,7 +3690,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
>               gen_update_cc_op(s);
>               gen_update_eip_cur(s);
>               gen_helper_mwait(tcg_env, cur_insn_len_i32(s));
> -            s->base.is_jmp = DISAS_NORETURN;
> +            s->base.is_jmp = DISAS_EOB_ONLY;

Likewise.

> @@ -3769,7 +3769,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
>               gen_helper_vmrun(tcg_env, tcg_constant_i32(s->aflag - 1),
>                                cur_insn_len_i32(s));
>               tcg_gen_exit_tb(NULL, 0);
> -            s->base.is_jmp = DISAS_NORETURN;
> +            s->base.is_jmp = DISAS_EOB_ONLY;

Calls exit_tb, which is probably bogus here and EOB_ONLY is correct.
But I'd need to look deeper into what vmrun does.

>       switch (dc->base.is_jmp) {
>       case DISAS_NORETURN:
> +	/*
> +	 * Nothing to do, gen_eob*() was already called.  DISAS_NORETURN is
> +	 * never set explicitly except in gen_eob_worker(), because that is
> +	 * where HF_INHIBIT_IRQ_MASK, HF_RF_MASK and HF_TF_MASK are handled.
> +	 */

Comment is wrong because exceptions *should* set NORETURN.
All of the masks are irrelevant to #gp or #ud etc.


> @@ -1642,7 +1642,7 @@ static void gen_HLT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
>       gen_update_cc_op(s);
>       gen_update_eip_cur(s);
>       gen_helper_hlt(tcg_env, cur_insn_len_i32(s));
> -    s->base.is_jmp = DISAS_NORETURN;
> +    s->base.is_jmp = DISAS_EOB_ONLY;

noreturn.

> @@ -4022,7 +4022,7 @@ static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
>               gen_update_cc_op(s);
>               gen_update_eip_cur(s);
>               gen_helper_pause(tcg_env, cur_insn_len_i32(s));
> -            s->base.is_jmp = DISAS_NORETURN;
> +            s->base.is_jmp = DISAS_EOB_ONLY;

noreturn.


r~

