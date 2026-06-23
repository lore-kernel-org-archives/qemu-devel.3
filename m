Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBA7CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2AD-0006tx-Bb; Tue, 23 Jun 2026 10:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc2A9-0006ti-GU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 10:31:41 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc2A5-0007yC-7S
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 10:31:39 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so3165346a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782225095; x=1782829895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qqm37q4UTSmHnlWgd06HdkcZ0BjfTG4E2/mRRXe9wG8=;
 b=OhprcQnwYrPzFbks7qjYL9bFPkkSFTErdvmpFfLcbzUFF+TAwLmMylPNNQCAx7TrTg
 z2dKdy3P81xrI2RJ5oP1WouXk3scEK2zuXHP8tYY1Wa+goqbf1ZNcKHPtbdCP3cSrdLE
 E0UJxux1TknkWyO8LW6oeTyNo3MFR9bR6Nn9PwRnin4uEN/pHYEU+JaiBcWszpXc42VA
 EkcyUNaIIWis2vjg7QjExTSvkny0MB0ojaVQs/BRgbiFWab6VIcg6JK7TwSziqdCyRse
 sUqwK5FfAC6rVQ0h6MSWhT3k1zf0G3B2/sMM7dutH396x42PbGwLFgsBc3xLYzToIElm
 ZjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782225095; x=1782829895;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qqm37q4UTSmHnlWgd06HdkcZ0BjfTG4E2/mRRXe9wG8=;
 b=oIwoOz3w6lhoCI1Okk+Q9WKrrChdh6GRwNUhUI9Aj9mH1yzGpwU/lCLfAnjMGMp4XS
 1pEZQUiLTooJJkgGtIaeEV3IvoFftxv6uLeCBurWRAtB2Kt8Zq/aaXXhHYDXCNze6ziK
 J/0qilTUvPUavhHM0UHRod3GTyFHNMC2vRdVCpIrjiZmqIhdk6SV/eGxdqgsve2DAikh
 OhmaSXHsiwgo+vZA2lBAWduGvoCwabjbA+ZAhjPZMXQPMaloqmxPxap8i4C0JqtsVqEj
 sQy+BdbmuNAsf9YTt7HkTz+GfuLEKiQAU8D4uv00JPBG3evDezPPBFBuIqqqlWGXptdg
 43fg==
X-Gm-Message-State: AOJu0Yy9WU2dpOgu8li5EIimnMmtQ7JFrcms/OS1HsfCk+y5wovOVod4
 osG9VU1EAzpANSel1YM/ORS0ZdJNYSR6/ir3WrrBgXovuf/rko7Dk3HkXfTnH4ZEiQ/fTZRbcB0
 KcDYP
X-Gm-Gg: AfdE7ckC7KBHdnDd6qUg/zC9LWB/hthBbR7naKtfEbNk0IVPFKgqGHUM59PuNSujZDy
 kgAEHlpEtRDx1VVw1PA17/54Pl0yLeksXk67ZowU72yJNrKsI8sqlwcZKd+bI6DMxlZq7LSj612
 jmq0l9km1RoxF1F6WfFo+AQbhY3VhPAczAOtn9Y6er0HFjJKfImr2IIecSS1y5+dHQRO3/yqZur
 nxeB813D0mkNCqrl6vK7W9bvAyzN3Fx0katJvQUcW3OxClufb4bOXnpbkr70EIlAiQkD0q8RqIV
 ueMwfH/0ROhzWEr+pnO65BkDr0YWyrrWeY3Dp5fkukSeRTrJed5IKPyGLcjSrSj1h1i4mX4/wGp
 77Ez7EGtdf0OJuMmp5HS/PS0fIL9vh9EWpvDUSW4fOuHTURqtZulzv1KgjoBan1XSMPwUsMfvZS
 I1C3vaU59d5mtlLJPZyBSVl9Gu/YYEXck5a6M0vDrW8QUG5HD6Op57/unNeQ==
X-Received: by 2002:a17:902:f688:b0:2c1:f262:494d with SMTP id
 d9443c01a7336-2c718f622d4mr202678235ad.19.1782225094551; 
 Tue, 23 Jun 2026 07:31:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7c1ac80b1sm28575135ad.73.2026.06.23.07.31.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 07:31:34 -0700 (PDT)
Message-ID: <6e09de57-c45f-4a6e-aaec-9cf13c2646a2@linaro.org>
Date: Tue, 23 Jun 2026 07:31:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Generate illegal exception for inval.ir and
 w.inval in U-mode
To: qemu-devel@nongnu.org
References: <20260622224534.1923407-1-stephensportia@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260622224534.1923407-1-stephensportia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/22/26 15:45, stephensportia@gmail.com wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> According to the priv spec "Attempting to execute SFENCE.W.INVAL or
> SFENCE.INVAL.IR in U-mode raises an illegal-instruction exception." Fix
> the current implementation to generate exception.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3543
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
>   target/riscv/insn_trans/trans_svinval.c.inc | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
> index a06c3b214f..10cb9e32b6 100644
> --- a/target/riscv/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/insn_trans/trans_svinval.c.inc
> @@ -39,6 +39,12 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
>   {
>       REQUIRE_SVINVAL(ctx);
>       REQUIRE_EXT(ctx, RVS);
> +    if (ctx->priv == PRV_U) {
> +        /* Set the virtual exception if virt enabled */
> +        ctx->virt_inst_excp = ctx->virt_enabled;
> +        gen_exception_illegal(ctx);
> +        return false;
> +    }

If you generate code, such as raising an exception, never return false.

False means "this is not the instruction you are looking for, continue matching".

True means "this is the correct instruction", regardless if that instruction is illegal to 
be executed in the current context.


r~

