Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F147EC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 14:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3GYg-0006Wk-MH; Sat, 04 May 2024 10:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3GYe-0006WR-46
 for qemu-devel@nongnu.org; Sat, 04 May 2024 10:40:12 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3GYb-0004hp-UO
 for qemu-devel@nongnu.org; Sat, 04 May 2024 10:40:11 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so323966a12.2
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714833607; x=1715438407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3abYyuzCxDBxbJef4RsC/15e4Zd0DhBeS+KCZvUhXw=;
 b=EylKdxYkNd+4n8vo3yx30oqdPmLO9IvR3WTnk6B1mNheNN7VndQhv+WsXZg0vNxAno
 JrC6Qx5yS8zPELclg6lGmVhRVntn9wCRXKVzG0Fgru5OekGBQMfrnxwPUIbrdM3SSmp4
 gj9ldLlCrTI8kBokOpYqA8vgRf0IuTEV1o3CQU03bvCHF4juVnlGnWPiaT4TxtLEt8bJ
 fW+UqEe5jnox+yDRbN93FzxPzSZPxlA8dmKGFr5XhuWlVx+n2nUD8sGi8yHEIKfk7UZL
 Wwwy1OBuxYc5Tyr2c8agyoGJntM5AhtPszufrCHEkn/bw1uekCGBz73PDhzMuJMpaQkd
 N2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714833607; x=1715438407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3abYyuzCxDBxbJef4RsC/15e4Zd0DhBeS+KCZvUhXw=;
 b=B0/oR/bDRRUhxiNc0dnelM2/rOsHN5eLypfwn0mYDtc/fJ11aoRThIoLxsDj1ADUTm
 K1vufJlnqOuwMwevHh1nUR18+OAUZLtdn3DzGyidA7gUQePbZcgOPAnzjmvMNUae+dRv
 7wHX74qd2kcHSgS7GWdo6hWH0MiqFiKspPX59c2wvDO5Q5TgOCgk31Mmm/9JqmmPEeDE
 LWjccio90fiHp0f7gyD7Ga+qHkZkooQlJC8RSUO2iegD+/tulTKGu+f+KJ819uhBAt3d
 cJxULi/ke10aUbCSxay5cWfW4ZYr+zk1AT6Ctlw12nlP9oSHb61ihKwBa3MmqHoKUUCG
 UQAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv+2wUaTKSnU3xR18Pye5U3VJL3J1/DUpzkocS/MNdZx7nj/DshnW/XbKe/xOHblltjle7R27JxIjill3mUY+Q602mRxw=
X-Gm-Message-State: AOJu0Yxr3pkY5bk/TCweI6YLNt7qmyLW4dx/BUUb7SdGOQAtOC2a/L7u
 /t3WALs/GEx4VmucnnWlOGK6rDts6m2FVMSTpPzjQoGIiGfh4Ehcwjqdyh7HaFw=
X-Google-Smtp-Source: AGHT+IFXYje3/cpN2J5lpAyXpOobD2u8kW8FgMEpahSNP/ptxzXBCVsHqDHzr6sZXa+BLcCvtuaivg==
X-Received: by 2002:a05:6a20:1a87:b0:1a7:c31:2695 with SMTP id
 ci7-20020a056a201a8700b001a70c312695mr4937635pzb.50.1714833607267; 
 Sat, 04 May 2024 07:40:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 bm6-20020a056a00320600b006ed0c9751d0sm4959348pfb.98.2024.05.04.07.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 May 2024 07:40:06 -0700 (PDT)
Message-ID: <e044216b-8191-4387-b8dd-8079df88c02d@linaro.org>
Date: Sat, 4 May 2024 07:40:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/alpha: Simplify gen_bcond_internal()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240503072014.24751-1-philmd@linaro.org>
 <20240503072014.24751-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240503072014.24751-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 5/3/24 00:20, Philippe Mathieu-Daudé wrote:
> Richard Henderson explained on IRC:
> 
>    bcond_internal() used to insist that both branch
>    destination and branch fallthrough are use_goto_tb;
>    if not, we'd use movcond to compute an indirect jump.
>    But it's perfectly fine for e.g. the branch fallthrough
>    to use_goto_tb, and the branch destination to use
>    an indirect branch.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
> [PMD: Split bigger patch, part 4/5]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 41151f002e..079bd5d3fd 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -461,23 +461,20 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
>       uint64_t dest = ctx->base.pc_next + disp;
>       TCGLabel *lab_true = gen_new_label();
>   
> -    if (use_goto_tb(ctx, dest)) {
> -        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
> -
> +    tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
> +    if (use_goto_tb(ctx, ctx->base.pc_next)) {
>           tcg_gen_goto_tb(0);
>           tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
>           tcg_gen_exit_tb(ctx->base.tb, 0);
> -
> -        gen_set_label(lab_true);
> +    }
> +    /* FALLTHRU */

fall through does not work.


> +    gen_set_label(lab_true);
> +    if (use_goto_tb(ctx, dest)) {
>           tcg_gen_goto_tb(1);
>           tcg_gen_movi_i64(cpu_pc, dest);
>           tcg_gen_exit_tb(ctx->base.tb, 1);
>       } else {
> -        TCGv_i64 i = tcg_constant_i64(imm);
> -        TCGv_i64 d = tcg_constant_i64(dest);
> -        TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
> -
> -        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
> +        tcg_gen_movi_i64(cpu_pc, dest);
>           tcg_gen_lookup_and_goto_ptr();
>       }

Need the whole else replicated above.


r~

