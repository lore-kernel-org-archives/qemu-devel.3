Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE99C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTex-0004md-1T; Tue, 23 Jan 2024 22:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTet-0004mM-5X
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:10:35 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTer-0001Xt-Kr
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:10:34 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3569304a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706065832; x=1706670632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6P2BP0eE5eMuhSDxc+iXRrkOVzVRy1Wgfp7mNKcWmFM=;
 b=h7aj/SJ9V53RHAJun0Tv5SxXWDK+UaZWLmwRE6BAagQaXLqbsQmz/sdJbi2Ys0Regs
 hfsUmQ79PSnjdX1ZJbkpeZbBQ2ulEE6q+QH62x46RM2gKrTJmqct3kfv/nRJ64V8YBcb
 AOj2FQXmchKDMbyu11daXnzaZSGKKf+0LZI32XikO7Vd+QruIaTL+oyTlcM5cHPHasX1
 S20ejwQXWx1T4xeRbfda7JkQwcqR+nx5dt1wQDimB8cNYk4yI8mbhbN/8jhSo5HABIdC
 5ZHUNNtWCdgvordiOBnZj9ovlnPdc7grPwtJXNBq0yjmICRYODqBX3t7jnvLCCNnKQrs
 UV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706065832; x=1706670632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6P2BP0eE5eMuhSDxc+iXRrkOVzVRy1Wgfp7mNKcWmFM=;
 b=Saaw57VR5klP3dQgzu+MZO2+bONZESus188TykuGQAUutK1RDiI/9Ad9jxFJdFx4EN
 1SOmCdK93ekvokQsoQjyG02lDPRDTokPc/85ZYLH5FniiMFKzL9xTS2qoUS+NNwfHy8M
 p8mEcPxaIHlZ66ydc11+75LGVaMas6cMQgFlHKMv8U9AAmGxK8OaG7ZmUsLJqjaZCtab
 6u11TY8gYrjYik1J9mMiGtRhYs+eNLyUSj7k0n/KKx46aRIkWaq9fk5Erbpd3Zqd6LW5
 kExvCnpBazytpONqgKRhWfw3FpSc7Et362AJFeYoOHIctIkDXJT9IcMFHoiMEB8vZrYf
 Nl3Q==
X-Gm-Message-State: AOJu0YzHUXg82H3cyDpB+iakwhTLTgkaekjhUhr13i0G80sbvNhOmdIu
 AUpf8/5KAo5NippqfhQ4I24yQqO+TfwiuNFzWs2hX2mHJeJIxw6Em+sQrNhGNir0gZEjG4hHwdk
 3
X-Google-Smtp-Source: AGHT+IEoTbAW7JN3prI98zsnakdgBGtC9i3uU3RCPI+e/ywFEcI3ZzMvkvLXZC/FIAWfIaVox6wSww==
X-Received: by 2002:a05:6a20:96cb:b0:19a:54df:b77f with SMTP id
 hq11-20020a056a2096cb00b0019a54dfb77fmr245409pzc.60.1706065832002; 
 Tue, 23 Jan 2024 19:10:32 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 lc9-20020a056a004f4900b006db105027basm12360986pfb.50.2024.01.23.19.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:10:31 -0800 (PST)
Message-ID: <9f97f7b3-1f64-42a8-a7c6-a429246c1277@linaro.org>
Date: Wed, 24 Jan 2024 13:10:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 29/34] accel/tcg: Make tb-maint.c target indpendent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-30-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-30-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Uses target_has_precise_smc() and target_phys_addr_space_bits() to turn
> ifdefs into runtime branches.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/tb-maint.c | 47 +++++++++++++++++++++++---------------------
>   1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index b194f8f065..fdc3a30d0d 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -148,14 +148,6 @@ static PageForEachNext foreach_tb_next(PageForEachNext tb,
>   }
>   
>   #else
> -/*
> - * In system mode we want L1_MAP to be based on ram offsets.
> - */
> -#if HOST_LONG_BITS < TARGET_PHYS_ADDR_SPACE_BITS
> -# define L1_MAP_ADDR_SPACE_BITS  HOST_LONG_BITS
> -#else
> -# define L1_MAP_ADDR_SPACE_BITS  TARGET_PHYS_ADDR_SPACE_BITS
> -#endif

I'm not keen on this.  We can make this target independent in several ways:

(1) Use fixed constants that cover all 64 phys addr bits,
(2) Use a different data structure entirely (e.g. IntervalTree).

Preserving the existing data structure, using variables, seems like a poor choice.

> @@ -1045,14 +1048,15 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
>       TranslationBlock *tb;
>       PageForEachNext n;
>       tb_page_addr_t last;
> +    const bool has_precise_smc = target_has_precise_smc();
>   
>       /*
>        * Without precise smc semantics, or when outside of a TB,
>        * we can skip to invalidate.
>        */
> -#ifndef TARGET_HAS_PRECISE_SMC
> -    pc = 0;
> -#endif
> +    if (!has_precise_smc) {
> +        pc = 0;
> +    }

Ok to this part.  Split it out.


r~

