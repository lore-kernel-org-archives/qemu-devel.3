Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA8CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 19:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOBA-0008Em-N1; Thu, 21 Mar 2024 15:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnOB8-0008EX-W0
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:34:19 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnOB7-0007sC-H0
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:34:18 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a46cc947929so196853366b.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711049656; x=1711654456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UuLiWJJ79Im/ksRjkUzs9CIiAy7gBls6u2Y47cBS3t0=;
 b=HQqCcEWxm4KOPkHwaVr6f53EawQqFnE/oImgBuJiGlYJl6Yku9csS2pcN28oaQ5HAo
 4ydOOgj6hRmkaPTZxJbjO43tYOwqXLw2ZJWp+pBqlyK/fI53WspC39Gaij2uGWYEqX91
 hu7vwPzepAU2RfdVWeQDCxnIiGTVg8xgJkXeR8HCu8V/h0DocgmFP9m8fZ3ukd2rECFC
 ic2HjhDBoVhndoLl4i9I3TeReZBd1xgHfQp70jSSVtKqDcmNsBcU0cNkGXkqQ6oX9IAi
 jG8NK0P+tShPveq0QxABoXblmJttEcZzb8q63spxlmnnJ7d8MC7soCNx05uPwbQT+JbU
 SmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711049656; x=1711654456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UuLiWJJ79Im/ksRjkUzs9CIiAy7gBls6u2Y47cBS3t0=;
 b=Wkc52CmSkrmt6hpS6wQ+Rs4OA1T3BMPkXGiKcxLmuoWJ6fwcvmO1C0tqpkiSHgFtXe
 4cAv+xax9x8h3sUsIK+OJmzn3GxtydGxMqJvhBrVp8mQjvG8KcvVa3X0q0tZQ7zWeYth
 5uqo1Jx2cvbEuLlCZKXdoid+ePw9PBUe8kPDelCgLbHJ94YpX4/HkipDHIHTIKvpNZfS
 qlYjDjGj9CJhujn+qkLeVpr6PsDAamW5t6jethDsN7LXSLd33XfaaxOfma3+Uw/9A9Hj
 LlhMWX9Hyw1U87BQKV8mRwmLIk/nuJIOfTuEyjBsUdXadqVAHvg41aYiGVMCLvYYNzVo
 b4+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvxZpJagreFVzW2Q525A0H+sXaM8tD+LR6ZClvbUl5FfYMq8KJ9S0uSj9LXII7n+4fbiFDfhiTwjYfjslTTNlY7459ejY=
X-Gm-Message-State: AOJu0YxwNKrfAHDvUKy3ByJW45W2VtuoeV1hkS8hGF+t6UfVQ03ReXlx
 dQOcxS75EWedWfxySke4ZbSLtj/qqK8A7Xvt8O6hHZvR1//JNah+qErELRmIyNE=
X-Google-Smtp-Source: AGHT+IGPsJ4lADkzvG9d46uH2sTF5VQ5Li95Rkxpp3sr8h5SMgeJbqAleS/lyifHvS9bm1CrdRlfYw==
X-Received: by 2002:a17:906:1391:b0:a47:62f:c0a7 with SMTP id
 f17-20020a170906139100b00a47062fc0a7mr274176ejc.13.1711049655591; 
 Thu, 21 Mar 2024 12:34:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a170906481100b00a44936527b5sm238494ejq.99.2024.03.21.12.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 12:34:15 -0700 (PDT)
Message-ID: <ff49230b-0ab0-4a40-b499-4f072d883f75@linaro.org>
Date: Thu, 21 Mar 2024 20:34:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hppa: Fix B,GATE for wide mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, svens@stackframe.org
References: <20240321192813.371526-1-richard.henderson@linaro.org>
 <20240321192813.371526-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240321192813.371526-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 21/3/24 20:28, Richard Henderson wrote:
> Do not clobber the high bits of the address by using a 32-bit deposit.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 1766a63001..f875d76a23 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3880,7 +3880,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
>           }
>           /* No change for non-gateway pages or for priv decrease.  */
>           if (type >= 4 && type - 4 < ctx->privilege) {
> -            dest = deposit32(dest, 0, 2, type - 4);
> +            dest = deposit64(dest, 0, 2, type - 4);
>           }
>       } else {
>           dest &= -4;  /* priv = 0 */

Fixes: 43e056522f ("target/hppa: Implement B,GATE insn")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


