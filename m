Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF7FC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGnK-0005cS-RH; Mon, 17 Jun 2024 14:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJGnJ-0005bU-9c
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:09:29 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJGnH-0005Kd-Ik
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:09:29 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3758fdbd2daso17396245ab.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718647765; x=1719252565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7dsu1XooSzrb6x0CJBujnOuFInarnMS9PJAttPcHzk0=;
 b=igpo4ucFJaVYhWsSwreXZghCj9d+XkqV0222AaqnDs0JXeb/uqsDX0rKswCVNPhu9x
 B3MA51SufKQYSZSPbbJib1im+R+WCakMLmAWyBbg6t3KInbGvg0BWDQVGJ94QYJBDCQz
 sPLWWlKJNL/zIAPGEBW2zqfQn5bXhabP/b5RByI+NyvQ0D9DGen2/XpMZFmOhzZjL+58
 NFPOyjlMLnF04/MaUCpnVS4MDessyWsKy0mjxg2DiFNNN5nwuI0u8pTOJPYF0OGMGdWo
 ZMdK0MBftCvC4xyh/BNY6J7nl0DQci8ZB+XFfYY8/dQsM2lgU006PSa3oxQWtxiTAJG/
 H4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718647765; x=1719252565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7dsu1XooSzrb6x0CJBujnOuFInarnMS9PJAttPcHzk0=;
 b=YmCGRbBau5vZpRZ26FF3ynRD/lPQVxhoPp7H2D7bHzTBzaSfaRaC33kk1M9BIOPlXS
 3Tr8fyEb5gpwRNSoy2ACOw+mMBMQxWQv929ZTqx6P+17IZw5fZToabkouQFFywd/i8+W
 elbg6yQu6G07DpMLeh66VoVel/iZpma0IHltYRdS3fRDtvvKb0fhRVxpYbteCDjp33Q4
 F52ZsL6fyJ7YB/Hztf+ZkxrH5pG7VwyrU/CI+r5C/ahFtY6lNuL8BRHoF1n8y3BUJga8
 iwpCi1p1ZcYgLPvMdXATZQhw0DnV9zi6GoFEV7mHASYp3pUokmTITwOb+OJu4AVXurNf
 XG6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEGGqnaG+KHBzgSDyxcSrotE5QRgax20bnvV6oMQYJNiFJLYb8LNp4dxmcu/NdMWHX702X3JxBmaTwug6wc8DNVwCUGA8=
X-Gm-Message-State: AOJu0YyePpgX8bNIgNogeJnq69YYYtIpnzZxGqayVT6iwOBvgZgOceA8
 MyTpl6GPKERnovjYIb6tct+tpMV+8YvQkKFJzvpXbMr+w7OrU9+hb6pK+Jjt9mE=
X-Google-Smtp-Source: AGHT+IFIQM0bue+8AMxi7pRfv9ua3GaW0BG2qQxhPH8mQrSLrSWwrAY0guWo6NXof9AQf4ntwGQ6bg==
X-Received: by 2002:a92:ca4a:0:b0:375:a50d:7f45 with SMTP id
 e9e14a558f8ab-375e0e149cdmr124863475ab.1.1718647764649; 
 Mon, 17 Jun 2024 11:09:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fee3baa908sm6856160a12.90.2024.06.17.11.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 11:09:24 -0700 (PDT)
Message-ID: <3afda005-7184-4378-be7d-5ffa0e1ca1dd@linaro.org>
Date: Mon, 17 Jun 2024 11:09:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Remove avail_64 in trans_srai_w()
To: Feiyang Chen <chris.chenfeiyang@gmail.com>, gaosong@loongson.cn
Cc: c@jia.je, qemu-devel@nongnu.org
References: <20240617130732.40183-1-chris.chenfeiyang@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617130732.40183-1-chris.chenfeiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
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

On 6/17/24 06:07, Feiyang Chen wrote:
> Since srai.w is a valid instruction on la32, simply remove the avail_64 check.
> 
> Fixes: c0c0461e3a06 ("target/loongarch: Add avail_64 to check la64-only instructions")
> Signed-off-by: Feiyang Chen <chris.chenfeiyang@gmail.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_shift.c.inc | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> index 2f4bd6ff28..8bcf341b22 100644
> --- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
> @@ -72,10 +72,6 @@ static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
>       TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_ZERO);
>   
> -    if (!avail_64(ctx)) {
> -        return false;
> -    }
> -
>       tcg_gen_sextract_tl(dest, src1, a->imm, 32 - a->imm);
>       gen_set_gpr(a->rd, dest, EXT_NONE);
>   

For the bug fix alone:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


I'm not sure why this trans function is handled specially.
I think this would be better as

static void gen_sari_w(TCGv dest, TCGv src1, target_long imm)
{
     tcg_gen_sextract_tl(dest, src1, imm, 32 - imm);
}

TRANS(sari_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)


r~

