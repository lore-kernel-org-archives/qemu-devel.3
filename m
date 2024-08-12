Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5743C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdR2z-0003Vx-1A; Mon, 12 Aug 2024 05:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdR2w-0003Uo-Um
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:08:59 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdR2v-0000eb-5C
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:08:58 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3db16b2c1d2so3178564b6e.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723453735; x=1724058535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PPkWO2U2YY9pYbqoMJ9TGLq7xG+IjvI3t+ESc6gEFQQ=;
 b=DwcRw4vQhyngQ2EhU6qPyzPxzUnNR4d4wKQhEmQPaf8cO+ylPNmCBOtlSdeVIdus1k
 kwKhiVaRRWeqRSLskEVysSt5rTgDo2yPZldPClDoO7htBEqm19yxK340f8Fo3ovuplq1
 piXbNDjLEyoFqg7PU9mgw6nWKvkoYiWAbMVLfVdyMQCroNXYZ52QSB5gyDFuimx7VumR
 JYSBE9CgyJllwAE5ksIJYomIpPQEMe6LJXo0JZA3aPX7Fsq6FsA0T8H6ju/Rh0Cu6CTx
 prwU/MWalXR6Fo2GsrMCZxB3wtX59rz/rX/MKjRUKHcBepYMSGNvbkF+uVtqf2S9X753
 euZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723453735; x=1724058535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPkWO2U2YY9pYbqoMJ9TGLq7xG+IjvI3t+ESc6gEFQQ=;
 b=sDz79RLO6mmDUDKA+/+xe3yHmCd6WcUz1250WOAYFwOGKENi8264EIalibT3WHQf9s
 evAkeOb4aBNG9+za0VxTywiSIpRTmIYuBlJ6dJEAq+LM+rrud0v06BNEseN8lL5FYRsS
 +2BqW3J44/3xgZ83x24heY137SdcqX4fOVBmC1fN/mqVlMjkmeqgtJht8fFv9zpOlfRn
 ZTyg9NeqC55Ej1v+Ez9zPy/Df+/trrNMQsGvJsJVRO14wqKk7Evm1Ex8BtXmZ+GP0xw7
 pmXyHzXVQnUid/JKWzNXb1fPnNNu2yip+HIthn5uq+Z26cjaRmB6ZkZkH6A5sQgL6n8g
 xUkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmonpQUtWht/XfqR/uHf5KWrt0iAUQC0hQ7BWsjrFX9pqZQa4W2rYvIcwaljMDVjSslCBCP2cphKeKQz30pkyjO6qXCe8=
X-Gm-Message-State: AOJu0Yxa0n4DlbmnZgO/OTlqcc+lV9UFjQMkHQF155CDkBGgD3IUv0al
 u3IJuNbSD8oxuhni42PV6uMeNjixmZgSbswPSy99IUlAMxuXzu2d5HySm7nfxIE=
X-Google-Smtp-Source: AGHT+IFRuGrk1owzangikXIzijqoSNOiOBR7HRkb+5LEpQ0qo3z1xGYH2dt2NbVP2iDdZiAupqpfaA==
X-Received: by 2002:a05:6808:30a5:b0:3da:ae19:ef0 with SMTP id
 5614622812f47-3dc417059e8mr12509783b6e.49.1723453735417; 
 Mon, 12 Aug 2024 02:08:55 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a4378bsm3555156b3a.125.2024.08.12.02.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 02:08:54 -0700 (PDT)
Message-ID: <653ae871-1fda-428c-98f3-0f7e6bb28f15@linaro.org>
Date: Mon, 12 Aug 2024 19:08:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/ppc: Make divd[u] handler method decodetree
 compatible
To: Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20240812085841.1583-1-iii@linux.ibm.com>
 <20240812085841.1583-3-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240812085841.1583-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 8/12/24 18:53, Ilya Leoshkevich wrote:
> This is like commit 86e6202a57b1 ("target/ppc: Make divw[u] handler
> method decodetree compatible."), but for gen_op_arith_divd().
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/ppc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 02c810e8848..5a352cdad1b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1823,7 +1823,7 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret,
>           tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>       }
>   
> -    if (unlikely(Rc(ctx->opcode) != 0)) {
> +    if (unlikely(compute_rc0)) {
>           gen_set_Rc0(ctx, ret);
>       }
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

