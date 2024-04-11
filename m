Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65182CD129C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 07:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rup9j-0001Ef-Of; Thu, 11 Apr 2024 03:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9f-0001EM-GA
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:31 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9e-0000k9-0W
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:31 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5aa27dba8a1so2638936eaf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712821648; x=1713426448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3T5/AILhEQStoOlRYJVmo5r/Tn2I0lzJRWJxOdGHW6o=;
 b=y34vuEt8brINS8m2q3yObY0gXuszU3S6E50WlyZ+j7Up70JthsWAiG0JWHzNwNidzA
 bEuSbiKT4L5ZdDKzDDRwdH9e4WAxtrXp4QAXoXh5qcSPws0JQlshPA8NS8xfjermfmeD
 58FeE49XQzYNt1x2ysACJA2ADO8bUAbk/5h/kz9E+dd5nwq/7Wv8mscQyarclq5udJxX
 HdP0Ocwgr5G2B7lcQ3+Bm7NTIXZyNbLU1w5latFRtHQ8c2fAxv92lAxB2nyh3u+3OMOP
 VpwIwRCIeK8eGno+dywvO/Cmghm9rZw5vrqwoYg28LK/FlOkvzyksL+vL73a+rFv9Xsb
 n/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712821648; x=1713426448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3T5/AILhEQStoOlRYJVmo5r/Tn2I0lzJRWJxOdGHW6o=;
 b=APG5yTS/+ZGBCuldL4XW7XEq9mdHuXkQuF9h7cU0I4UrBnpJMJktW7uSTg8rl0JH0t
 mq6EAQ3/5BbLWijMBp3SJkZGP9bHF7IDInj0VcfTff7y+zZ6hrB+fI5kQNs7RACCW3El
 SPy5oz856pIQOr0E1NrQd2q1ucSRjriBY3A+6+sCjlCKJlBv/n+pvqDjPeQYK4hS3reK
 WH/jST/t9NOJaJ+GFVdphWt/c8xpCmlcZHBH3S8e9Vx/Ms0wulxyHCTNrrdUpkiuw/8Y
 axyJ4HaEvq3FYU3Dg41L4Mpum8lBYMG3VzHPC9pIksgNr7xZ81YtDkjKSaupTCss4Tok
 USgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV170l+52wzTRU8Wa+lJYIMEZoddhHJAiIys/U2C8HApczRUmgRUpzzv0Ay35+JivC1oMqiS63HU6CfdKZgeITHpYcSRmE=
X-Gm-Message-State: AOJu0YzUE7ngO8hQYj6Wwl7KtiP+JyEnJqVgiOHZ5hg36wKfmikYNhnP
 eH4BWIon2SNtY6aOgaPDYGyKTH4G5SRvTp+O9r4pZjE3Ox8RbIDsJqglrRh/B24=
X-Google-Smtp-Source: AGHT+IGPfqt18yxyxmkhTUYf76LuSqQN7gZz1U83dNGYBijqhSZ5yemPpDCUwS2KT52ZwFtCneU7bg==
X-Received: by 2002:a05:6358:ed0c:b0:186:1908:4c4f with SMTP id
 hy12-20020a056358ed0c00b0018619084c4fmr5209257rwb.13.1712821648518; 
 Thu, 11 Apr 2024 00:47:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a656a82000000b005dbd0facb4dsm493803pgu.61.2024.04.11.00.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 00:47:27 -0700 (PDT)
Message-ID: <f211d5d7-9d0f-455a-97c5-d2c09d600bcb@linaro.org>
Date: Wed, 10 Apr 2024 18:12:35 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/9/24 06:43, Paolo Bonzini wrote:
> +static void gen_ARPL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +    TCGLabel *label1 = gen_new_label();
> +    TCGv rpl_adj = tcg_temp_new();
> +    TCGv flags = tcg_temp_new();
> +
> +    gen_mov_eflags(s, flags);
> +    tcg_gen_andi_tl(flags, flags, ~CC_Z);
> +
> +    /* Compute dest[rpl] - src[rpl], adjust if result <0.  */
> +    tcg_gen_andi_tl(rpl_adj, s->T0, 3);
> +    tcg_gen_andi_tl(s->T1, s->T1, 3);
> +    tcg_gen_sub_tl(rpl_adj, rpl_adj, s->T1);
> +
> +    tcg_gen_brcondi_tl(TCG_COND_LT, rpl_adj, 0, label1);

Comment is right, but branch condition is wrong.

I think this might be better as:

     /* SRC = DST with SRC[RPL] */
     tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 0, 2);
     /* Z flag set if DST < SRC */
     tcg_gen_setcond_tl(TCG_COND_LTU, tmp, s->T0, s->T1);
     /* Install Z */
     tcg_gen_deposit_tl(flags, flags, tmp, ctz(CC_Z), 1);
     /* DST with maximum RPL */
     tcg_gen_umax_tl(s->T0, s->T0, s->T1);


> +    case MO_32:
> +#ifdef TARGET_X86_64
> +        /*
> +         * This could also use the same algorithm as MO_16.  It produces fewer
> +         * TCG ops and better code if flags are needed, but it requires a 64-bit
> +         * multiply even if they are not (and thus the high part of the multiply
> +         * is dead).
> +         */

Is 64-bit multiply ever slower these days?
My intuition says "slow" multiply is at least a decade out of date.

> +        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
> +        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);

Avoid s->tmp*, especially in new code.

> +        tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
> +                          s->tmp2_i32, s->tmp3_i32);
> +        tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
> +
> +        cc_src_rhs = tcg_temp_new();
> +        tcg_gen_extu_i32_tl(cc_src_rhs, s->tmp3_i32);
> +        /* Compare the high part to the sign bit of the truncated result */
> +        tcg_gen_negsetcondi_i32(TCG_COND_LT, s->tmp2_i32, s->tmp2_i32, 0);

This seems like something the optimizer should handle, but doesn't.
I'd write this as

     tcg_gen_sari_i32(tmp, tmp, 31);
or
     tcg_gen_sextract_i32(tmp, tmp, 31, 1);

which I know will expand to the same thing.

> +    case MO_64:
> +#endif
> +        cc_src_rhs = tcg_temp_new();
> +        tcg_gen_muls2_tl(s->T0, cc_src_rhs, s->T0, s->T1);
> +        /* Compare the high part to the sign bit of the truncated result */
> +        tcg_gen_negsetcondi_tl(TCG_COND_LT, s->T1, s->T0, 0);

Similarly.


r~

