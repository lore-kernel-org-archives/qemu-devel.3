Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D0AC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 10:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seB36-00027S-7E; Wed, 14 Aug 2024 06:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seB34-00026P-Ct
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:16:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seB31-0003Hl-Ap
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:16:10 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fec34f94abso56128035ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 03:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723630565; x=1724235365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YxWePeY049wtJy3phOWVYIBuofiYQ77fWQBu+Xk7HPw=;
 b=ITFyxT0kV950AIgmEoEAdIlbZ03QxiReKTfdrvz2d8IxT/xS1Vd5dRCSkBHTBe2Gdv
 melYc8awP+AgeS7Xma/H9bzYJfiBpnGbnXNzNduY1BY1eDgK876EMczYRFR4Ld7NmQW/
 /uWtV1TPzH/EeOurpSucdxdTekfk1s/1Spac44STzhsYna9v9diGjsfZfD/94EZZaoaY
 BMbuA/qVrdYFtUc9wAHGZXinvMCW2R0iM2tQ7u/N6xDumD/3uIoA1R1/1Gz7e26MmmsG
 DM6BAHvHzWcCTsa5C17eBvQqIzgwXTX6H1iYnQrjKqrycU8exyL6r7irczSKrhPhxMCb
 HJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723630565; x=1724235365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxWePeY049wtJy3phOWVYIBuofiYQ77fWQBu+Xk7HPw=;
 b=KXFMsdiD7/hqrn7g8Ydpg7kYGGDIOB8jLAcR2m/uzbC21btuFYXCu8UZp9LxedKRUg
 5wH7fWZpFcgpSUfGhPqi6a0XN/7rzpCGAL/IuSnujwAUJlz7bInlVhguivzzODhHCK3O
 sJ8ULQecBAdbXwNLdWXXvvdb3AVMU1XJvp7fxz4tNoZkkjW6NTKmSrQLlr4z40VLxesG
 Pu0vjXOVtI4wKCGxso7N9MMZe9EK8hhsB09kAWq19GS2BjEl1tm3fGbCQftu8VIAV/aw
 HX/WxxVCcW5N/ZMyM3/yMf4y6GNQQQzk9k4gExWjRszlxnzaL6NCo8eV2eaoOmb6YTOU
 3f1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMHXX7FoBxpd6zXevkes6ZTXrlnNmnK/AzZMvTrJEQ94CKQqUE165wDjj+FIUGuSqwWZgNBiQ4aR6RYYdyd2qJmZcsjMw=
X-Gm-Message-State: AOJu0YzWxb6Dxs69W6GTlZSoNiBUJUlmc2pUMFwHpFMVKlQUX7Ecc9id
 xk4nZoKXOhWBH1KKW+gG68BWuhHawTPQmDp1lv6Sc7n3Wf/5McBKIxXDi7+1Rsw=
X-Google-Smtp-Source: AGHT+IEG1RgQ4nGkeR1t8xUVdiu1nfEgVxHMlR9iSORqTXpKEU9TK6pjGAHaCpTRdSvVxw/oiT2f9Q==
X-Received: by 2002:a17:903:5ce:b0:1fd:6529:7436 with SMTP id
 d9443c01a7336-201d6397f3bmr19504955ad.8.1723630564991; 
 Wed, 14 Aug 2024 03:16:04 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd132895sm26691355ad.9.2024.08.14.03.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 03:16:04 -0700 (PDT)
Message-ID: <7eabd980-ec6c-4748-8ada-f9d6228ee2ef@linaro.org>
Date: Wed, 14 Aug 2024 20:15:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/15] tcg/riscv: Enable vector TCG host-native
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-16-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-16-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/13/24 21:34, LIU Zhiwei wrote:
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target.h | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index eb5129a976..fe6c50e49e 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -143,9 +143,13 @@ typedef enum {
>   #define TCG_TARGET_HAS_tst              0
>   
>   /* vector instructions */
> -#define TCG_TARGET_HAS_v64              0
> -#define TCG_TARGET_HAS_v128             0
> -#define TCG_TARGET_HAS_v256             0
> +extern int riscv_vlen;
> +#define have_rvv    ((cpuinfo & CPUINFO_ZVE64X) && \
> +                     (riscv_vlen >= 64))
> +
> +#define TCG_TARGET_HAS_v64              have_rvv
> +#define TCG_TARGET_HAS_v128             have_rvv
> +#define TCG_TARGET_HAS_v256             have_rvv

Can ELEN ever be less than 64 for riscv64?
I thought ELEN had to be at least XLEN.
Anyway, if ELEN >= 64, then VLEN must also be >= 64.

In any case, I think we should not set CPUINFO_ZVE64X if the vlen is too small.  We can 
initialize both values in util/cpuinfo-riscv.c, rather than initializing vlen in tcg.

> +static void riscv_get_vlenb(void){
> +    /* Get vlenb for Vector: csrrs %0, vlenb, zero. */
> +    asm volatile("csrrs %0, 0xc22, x0" : "=r"(riscv_vlen));
> +    riscv_vlen *= 8;
> +}

While this is an interesting and required datum, if ELEN < XLEN is possible, then perhaps

     asm("vsetvli %0, r0, e64" : "=r"(vl));

is a better probe, verifying that vl != 0, i.e. e64 is supported, and recording vlen as vl 
* 64, i.e. VLMAX.


r~

