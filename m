Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0C6C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjoK-0002BW-FG; Wed, 07 Aug 2024 12:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbjoD-00029s-0t
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:46:45 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbjo7-0006oG-6l
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:46:42 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f16767830dso281141fa.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723049197; x=1723653997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MptXPEUbxo0SiBnOhDSOAF/gMJykpLxFXw+RPbjYJNE=;
 b=aZ1fQbm92AOpFfg0D5iXOxt4Hr5Gpkz5jLxm1ZWxodTnvZVuvwVznQyNWJeIvsU3uq
 G2IlyCmqLMOk6LrCVcR0aTpb3MbDetNz+/oBpESD6ZjVO5oi3Q//TolStw6WI1cALfDA
 lvd+7NH4Z+RnjVPvUY5ST4xddnw+stV2Jaj94C/DVPDlI1Qb72Af2LFu/bmFgZeUG5lL
 TcPeTFydNasCxTXdPAc/01z+PZGEpPhw+cPzk6ZnhjiKimHxxGVebPMd/NyBT3vZIEAW
 e8AEHvOhaolhg0W6X3P2uXHuSKELrCTsmNd02XYpOsQsQrSs4cJfu06kSE+T/Bz3vOWS
 9oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723049197; x=1723653997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MptXPEUbxo0SiBnOhDSOAF/gMJykpLxFXw+RPbjYJNE=;
 b=PKjQmF4D35k/vYaiXIMN99eJIK+kyfLOPxcZN9ih5heiM9Nf6MgakYFvEA05KFSdI6
 htCpCcC8rVeZMIAexJ4tOaLtKO21sk5m8NHnkOYra9KAPIziIs8InKlETWxdFVyiFOG3
 lU2eNUW3oWhjNMAMeYwrGiqMhBRODUn1VLDkj6bpDXC/i4caNxkzRCRSsw0JYSAiMT01
 82Jq3vbxb8J8u7y7DgtqFMWQH89bxlD+F6V6gBTCVTvZ0wK2N/E4XM1067Qtz+87j6JA
 Z3lQun3UV1AqOT1LGg2dZ5YdXfS4b7v+G8j4/8iY7eWvqdRUOrqOHtCVx5+niwxv51fD
 ty0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMQMNRLU9Xk+PlNc6JDy6nTBXjGwn5Yo7GePpm0szXj1r8YXKCQLX7bPIy8VidGHKGZu+h3mN1vK2F6nJxfGPdYvp/sZE=
X-Gm-Message-State: AOJu0Yxezygnsf014sczwiYX9n0tEb+jA1C78Tm5y83JzJGq2+ACDxuK
 vDN7vfCBhbQCN515GZrrfb5vza+A2xqc/fLpf/1SRzy1+bXJZao+th+by6nZSpM=
X-Google-Smtp-Source: AGHT+IFMcL38s6QzG+/rqPJHgP7F+uUVG+K35RBOqKRIoPebYqKZu15cuD3naGR+orwxMtX7lv9gmQ==
X-Received: by 2002:a2e:9606:0:b0:2f0:3cff:30ce with SMTP id
 38308e7fff4ca-2f15a9f0284mr126860591fa.0.1723049196414; 
 Wed, 07 Aug 2024 09:46:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290598e5adsm37925515e9.25.2024.08.07.09.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 09:46:35 -0700 (PDT)
Message-ID: <44328324-af73-4439-9d2b-d414e0e13dd7@linaro.org>
Date: Wed, 7 Aug 2024 18:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] tcg/ppc: Sync tcg_out_test and constraints
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-ppc <qemu-ppc@nongnu.org>
References: <20240807040843.7882-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240807040843.7882-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/8/24 06:08, Richard Henderson wrote:
> Ensure the code structure is the same for matching constraints
> and emitting code, lest we allow constants that cannot be
> trivially tested.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ad788aebbab ("tcg/ppc: Support TCG_COND_TST{EQ,NE}")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2487
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 7f3829beeb..3553a47ba9 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -325,9 +325,11 @@ static bool tcg_target_const_match(int64_t sval, int ct,
>               if ((uval & ~0xffff) == 0 || (uval & ~0xffff0000ull) == 0) {
>                   return 1;
>               }
> -            if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32
> -                ? mask_operand(uval, &mb, &me)
> -                : mask64_operand(uval << clz64(uval), &mb, &me)) {
> +            if (uval == (uint32_t)uval && mask_operand(uval, &mb, &me)) {
> +                return 1;
> +            }
> +            if (TCG_TARGET_REG_BITS == 64 &&
> +                mask64_operand(uval << clz64(uval), &mb, &me)) {
>                   return 1;
>               }
>               return 0;
> @@ -1749,8 +1751,6 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
>   
>       if (type == TCG_TYPE_I32) {
>           arg2 = (uint32_t)arg2;
> -    } else if (arg2 == (uint32_t)arg2) {
> -        type = TCG_TYPE_I32;
>       }
>   
>       if ((arg2 & ~0xffff) == 0) {
> @@ -1761,12 +1761,11 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
>           tcg_out32(s, ANDIS | SAI(arg1, dest, arg2 >> 16));
>           return;
>       }
> -    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
> -        if (mask_operand(arg2, &mb, &me)) {
> -            tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
> -            return;
> -        }
> -    } else {
> +    if (arg2 == (uint32_t)arg2 && mask_operand(arg2, &mb, &me)) {
> +        tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
> +        return;
> +    }
> +    if (TCG_TARGET_REG_BITS == 64) {
>           int sh = clz64(arg2);
>           if (mask64_operand(arg2 << sh, &mb, &me)) {
>               tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);

Preferably having someone from PPC also reviewing this,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


