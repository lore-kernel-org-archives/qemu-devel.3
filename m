Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7490DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJdz-0002MV-KR; Mon, 18 Mar 2024 16:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmJdu-0002LX-Sv
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:31:35 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmJds-0002O3-7r
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:31:34 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so3690849a12.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710793889; x=1711398689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kO0CUlmpmgpgJh9+JhtAcuSOUmI+kDjHnlfeXxl5TbA=;
 b=qxZDWzeWLRfhaKNQ55/Qae/0N4CQUo8kv9UBg5pTj0prWrssTQDD3fDWXsWTxyfGVj
 OOZDScQ6ActosdtDT+Cx3kTsAyDcw651Y+jw+x0EoQwaP33TLrTDqRuCIM+GXbQf22qw
 4JVMDm4RsuIK16pSph1QBS5MAkfWlxRokQpc4Gt/h++p664BX34+aaCc73ISRMqPjHzI
 dHxpqyEgG8v5l3QpFIh9tdIW24925wT4zmb1gzOqZqkNt+fJ09gV3FmaenAdUQHAJDwR
 BdfYclW9t7ilv1e0JHxkGGztywwRm09pBPtRxcHXKwJZoqipjvJczj5y2BPiyZk/f5pK
 mK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710793889; x=1711398689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kO0CUlmpmgpgJh9+JhtAcuSOUmI+kDjHnlfeXxl5TbA=;
 b=TWSsz4n7P94hHfk/2ABhx2RETiup4J+q5RqGwdmBXvw8hWVdPCOIGXzDssLVCPZIAY
 ENk0UnqDj8RP88XHcjbH3vCmO3Z50NUKLdovsMxX3/xM0yvsVnJZiPxZ+80WMv5U2WJI
 4it4OiXucLAftk4WaN9Tiw9c9tFOXjsiLSGyNGdmGXlzl6ko92pLMUGhPv+H+UnyikMQ
 jqsDB5pm7n32G4Iqu8y5/lQ7gWZoAEsmaW75dqYytPkP0A4PSZqzHhNTpwQIH4aKo1Zg
 3+cEdiifx/fH5EC5QvbLEPTj4BDzGrJrG/ZWBFDvzYk6RP3Ziv/98y7qjntg4HoAgeTJ
 g/6Q==
X-Gm-Message-State: AOJu0Yz8kmPDTsJcmyESTXV1Sk3X1afKCs7GJsNYJHY7I8w5ddcRqbhZ
 a4GygYoi7E8ttlAFVCUDic5KQKHWww8v3XGtWIYTHOJ7HwtlGvCfvGClsq+6YSM=
X-Google-Smtp-Source: AGHT+IGnKNUsKAZLmF5s7wo6PAlSgUTftdWHOehg/jqT7cAK4ifVMdZPl9pkumAcZ3ZP9I1eav18VA==
X-Received: by 2002:a17:90a:597:b0:29f:b882:d061 with SMTP id
 i23-20020a17090a059700b0029fb882d061mr721547pji.40.1710793888866; 
 Mon, 18 Mar 2024 13:31:28 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 p2-20020a17090a930200b0029c0cc16888sm8230466pjo.1.2024.03.18.13.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 13:31:28 -0700 (PDT)
Message-ID: <2065b6d5-9b2b-4b87-a49f-8e0711f3f2b0@linaro.org>
Date: Mon, 18 Mar 2024 10:31:24 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] target/hppa: ldcw,s uses static shift of 3
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-2-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240317221431.251515-2-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 3/17/24 12:14, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index eb2046c5ad..6a513d7d5c 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3085,7 +3085,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
>           dest = dest_gpr(ctx, a->t);
>       }
>   
> -    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
> +    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? 3 : 0,
>                a->disp, a->sp, a->m, MMU_DISABLED(ctx));
>   
>       /*

Whoops, broken since day one.

Fixes: 96d6407f363 ("target-hppa: Implement loads and stores")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

