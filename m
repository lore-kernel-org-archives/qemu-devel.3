Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0889CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbo8-0000ns-P3; Tue, 19 Mar 2024 11:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmbnx-0000n1-QK
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:55:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmbnu-0007XS-Rv
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:55:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6c8823519so5471418b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863705; x=1711468505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dmHEBA8QcY2fpx29aRlpOnZzWTrQF89Vi0dhXnvMufg=;
 b=rp2KiSZA5wEpU8Eyr2bdFoDn4G2pj7xpwFicF+hcweMMZKMyxpU/TzrkuomA+wmxA6
 EtYG0I+mTN4VPGTopz0BkxfWdRizU6nnjrL5NQnYJazLEfmHsdYidMsH0hPR32YTCVJQ
 zExvajyW38d1D8uXJ9t+e5H7mac9+iV04NuKeDUnEx8TVtJ5dUMy16+gkjAzXsF+CLSg
 h59Em0J3p2njuEd4j2xs2E0PyLQob38gu0+in/lQWdZAmf9EcuWtToWEHGXA7NNs/MAQ
 0G5JcQxC7BVHmko7LesPD44+Ome53wAYN4TEGMnjRbVyfxZQlwLiXccR82Gi2eVvUE5t
 0/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863705; x=1711468505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dmHEBA8QcY2fpx29aRlpOnZzWTrQF89Vi0dhXnvMufg=;
 b=PVdqN6oYAm9PV3q04FwoxzTUT0mHVHp4h/NsPnKphalB15d7p2lRbwheG5OtMEUdGQ
 6ufp+a3Gh+6OBR5Ur41llyDUDWhL/D0Bk+1ZjzljvfKhEvNxUz6IyN1Clt4M4tp+AHJb
 lAQI4cLhOD4bTnrtuF4JReXhBhWgUATzVmpdLsWqXHAedwgcR9apyI5ypvpk8CkUkpec
 BMlZGbEewXDiZJm0OMlYvT3sB6S5WyF/JL97+o3uzRbBL6xMMuIwFFFLbUPGS+GGhJug
 k7gx3KegN2n6LunXAMkzlbSPNpXFAp8g2o1W6Mp6aGO8Q6Zf8BQMZAahKWVmjkvEqk72
 NO5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwQKw4SAGaL9t8IEW/kgzfO/coI8lOKSeRYp2A6OCaSosKqo4H0g7iapZXfucXqQTfBMXu1LwPsXFThSW5tw91d6q3vKA=
X-Gm-Message-State: AOJu0Yy0F/vJiXQi2c0mMc+4m03NksUEifg8KbLNfgpJyErsNAzCYFbk
 WDNGckn2aSspJUXtKUlhg4uEsWRzlhZdB1GDm5tqe7vpoWpx9qjOXPlApWgtTeshgSoLu57+jx1
 O
X-Google-Smtp-Source: AGHT+IEd398cE0x7IDbxdmMDDNOMCX4hneLvsWLBf861hxkLrlzwbaUDpFZL2k7VftnMwbCvRQbVFQ==
X-Received: by 2002:a05:6a00:1a88:b0:6e6:9560:f95c with SMTP id
 e8-20020a056a001a8800b006e69560f95cmr3797166pfv.13.1710863705197; 
 Tue, 19 Mar 2024 08:55:05 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y125-20020a62ce83000000b006e6b2ba1577sm10309422pfg.138.2024.03.19.08.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 08:55:04 -0700 (PDT)
Message-ID: <91ebe7ec-c01f-403e-abda-95b364c5ee2e@linaro.org>
Date: Tue, 19 Mar 2024 05:55:01 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/loongarch: Fix qemu-loongarch64 hang when
 executing 'll.d $t0, $t0, 0'
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@linaro.org, maobibo@loongson.cn, lixing@loongson.cn
References: <20240319063202.1313243-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240319063202.1313243-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/18/24 20:32, Song Gao wrote:
> On gen_ll, if a->imm is 0, The value of t0 should be src1.
> 
> Links: https://www.openwall.com/lists/musl/2024/03/12/4
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> index 80c2e286fd..fab951a892 100644
> --- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> @@ -7,7 +7,13 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>   {
>       TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
> -    TCGv t0 = make_address_i(ctx, src1, a->imm);
> +    TCGv t0 = tcg_temp_new();
> +
> +    if (a->imm) {
> +        t0 = make_address_i(ctx, src1, a->imm);
> +    } else {
> +        tcg_gen_mov_tl(t0, src1);
> +    }
>   
>       tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
>       tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));

This is definitely wrong, since you're ignoring va32.

But I see the problem with make_address_x returning src1 when addend == NULL, because the 
load to destination may clobber src1.

I suggest always using a new destination instead:

     TCGv src1 = gpr_src(...);
     TCGv t0 = make_address_i(...);
     TCGv t1 = tcg_temp_new();

     tcg_gen_qemu_ld_i64(t1, t0, ...);
     tcg_gen_st_tl(t0, ... lladdr);
     gen_set_gpr(a->rd, t1, EXT_NONE);


r~

