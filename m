Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E714C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwn40-0006o1-8N; Tue, 16 Apr 2024 13:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwn3z-0006lm-4y
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 13:57:47 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwn3x-0002zf-FW
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 13:57:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ed0e9ccca1so4308965b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713290264; x=1713895064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9j5Aa5kQHfNkiS7J85/SNg8RYloSJgTx37Iq1bH2Ipw=;
 b=Aaf3GUN3nWc23CxqzbHeRU/PO6f5+XO0VRLXfiarAWrfH52xXXcFg7SPWKqc2vE4Ir
 qUFxs2dQxVrYNgxDEuSVf/VSzj5LaJJxLEV1O/eIknXGwFMK+rEwVcPUKfLpaDjTitgH
 A3NDOwFwTrtHSCU2HGuOHQjX6nh0Iuojh7d782sEoK8VFCBsLjV75YyAb3itJGj8j1iQ
 rumwsEL0eBLb1b74QCsXoQuxkRN+lZ04OvUbhX3gekjwUEIrr6s6rfcpYpaMf+zoBOG5
 NqQ++e6+OqyeHqV73qSFpjC26MIBqHpwhtEFXwcla7WFzvgs+0WVVbgAufGsnWGk2Hjc
 FF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713290264; x=1713895064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9j5Aa5kQHfNkiS7J85/SNg8RYloSJgTx37Iq1bH2Ipw=;
 b=BxJSf2EX/6Q3C+X43Cz47htMnLhJ2sajs7oXBgz2Pe8L1wHzLdvRWSk4c09DwiVOQM
 K+9Ib33k9uSgDXQgkJWMLLT0GPiFOR2AkY0wUfpw5zKB8kX/oP08HNqZVhLx6cmZzwtS
 q1JW+UXWp4baQrV6YXdLctu04wKAGY/rq/pUpm7Yo7e9vknM0CMNeV5ljcjSAJYCJHXq
 FsGf070aUpxF2x2Sbso9oZCXyjIbZ+1KXjM6Ee9hXahR2uwIzkUsXOsN+7CKQkPn+UUn
 ZVkizVNZHr4AM5l4Gwke2QeX/Bb5uckmZUhn+8IVezV6xKCVqH9hUPj/qn4804GMG6k7
 UTnw==
X-Gm-Message-State: AOJu0YwDaDLj/7p45Pz04e56TGk2CVRxG7zFF3EhUbvZLiF+mDobhvzx
 SlbJYTD5Ierne8aNfLDciidXojBFtRlpB3lP5TZWTyylYgJpzBpL2GkYB50oAeXghUGUF7WkXdx
 w
X-Google-Smtp-Source: AGHT+IEw7fGVVDbnE2QtoQNHpxtkRIMApR+GQpgwXWkCn6ULO1AExtZkcbDbjYyBhgtEC/hCntbugQ==
X-Received: by 2002:a17:90b:4f82:b0:2a5:3343:28bb with SMTP id
 qe2-20020a17090b4f8200b002a5334328bbmr11184247pjb.20.1713290263876; 
 Tue, 16 Apr 2024 10:57:43 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a17090a461700b002a04eef22c5sm9006219pjg.44.2024.04.16.10.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 10:57:43 -0700 (PDT)
Message-ID: <be3dd6e4-2e9f-4a75-a744-327fb5f8e262@linaro.org>
Date: Tue, 16 Apr 2024 10:57:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] target/ppc: Make divw[u] handler method decodetree
 compatible.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416063927.99428-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/15/24 23:39, Chinmay Rath wrote:
> The handler methods for divw[u] instructions internally use Rc(ctx->opcode),
> for extraction of Rc field of instructions, which poses a problem if we move
> the above said instructions to decodetree, as the ctx->opcode field is not
> popluated in decodetree. Hence, making it decodetree compatible, so that the
> mentioned insns can be safely move to decodetree specs.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/translate.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
> +                                     TCGv arg1, TCGv arg2, bool sign,
> +                                     bool compute_ov, bool compute_rc0)

Could drop the inline at the same time.
Let the compiler decide.


r~

