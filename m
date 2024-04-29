Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2C4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1UKl-0007NH-19; Mon, 29 Apr 2024 12:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1UKj-0007Jk-Fc
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 12:58:29 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1UKh-000453-T5
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 12:58:29 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso7980675a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714409906; x=1715014706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7wBmsNAc3hM0O3wxDRD+tV/PYp1bZfikWlYPgbcrHyQ=;
 b=epqQaV0PmiOuNaXoD2NFF1xZ4jjOJzA0KziLS0oh06HjztwSiNEkMPT01MW2nz4v3H
 Ria4Ak1FJOoHKMRchaiYUjndOlycy+ZchoxYIc/qj1FBz3uBX0r7RR1V2nbTmkfUBQCG
 WmVjMUvTf+mGihSn7+BvW7Fq99jeQ9lnuMT0xlJ9kXqqsbV8ZnbaOplD+MyW6bUy9Y1p
 lmYrCHVAI1P3FV5KlGIeEF+K7CYtLZMb6ONwLPz7b4oOgJpxcrrWKblQTCiL0EjrYNok
 9MeqUzUjI1GoUz/v2SmC/o9vwBShxnOOJfRpt61z4HHqeVGk8BXbYczNRdqqsr/GaA1O
 Uz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714409906; x=1715014706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wBmsNAc3hM0O3wxDRD+tV/PYp1bZfikWlYPgbcrHyQ=;
 b=c3pzUJBjMfczFfKdfhcqJwlDLVMNnCDhEFA9r8rpZobkYcDUHFsdnBiFIDEniSfuLA
 h81tn7GVN+H4e/3M2hbEtb9wK7n/gDpYYzU5FCaZNklHpgUfOIvEaN4C2p5OzRsL4psW
 8Zh9B4bpkIxA234ivfDOB25tex6fFzJjDQ3s7NGZL9g5kBZEaimXViUrEi6fxFPzIbWe
 IqdpHvgmbwHyGrS8/owjXuyQPF36Ou7nfhBuAPtUvXTvV2voWQhq7dTgXZaQA3z/mKa6
 y2Iy2Rgc26sSKLR9v2wq/7Nr/9PqcDxHVbatKeIg+zARpFepqWfjrpc+phYgtq0Wgx+A
 Cvsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGGwWpgwzJg66vWeN5adKgzO3Gd/xLOFIVAPsQYpei7D0DHx8e/Yx+fnqBRbHzN7aKC4JV5Vad/4uij1xcXAOE3T8niKI=
X-Gm-Message-State: AOJu0YwPfDLrIsfn51SYf2N7XJQBtqzwraSNkshpB7fAD3Whbnp46Pn/
 361KtzvD7WQzFQTn4fp76++uvS7LFgZJqSsewdRhIrjQ/rHHKMqGPC+dsgzAuoI=
X-Google-Smtp-Source: AGHT+IHn5UEM2THq+WBIIKzYldLSUuhXCVF0vMFMKt0dHR+gCr/r9EwXk7k8rxfp9aM1ruo91/JI5g==
X-Received: by 2002:a50:cdd8:0:b0:56d:c4eb:6328 with SMTP id
 h24-20020a50cdd8000000b0056dc4eb6328mr7358678edj.29.1714409906178; 
 Mon, 29 Apr 2024 09:58:26 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 a19-20020a50c313000000b005727de1ac2csm1783752edb.54.2024.04.29.09.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 09:58:25 -0700 (PDT)
Message-ID: <19885855-e0e9-4bb8-9155-a694ff9ea1df@linaro.org>
Date: Mon, 29 Apr 2024 18:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/alpha: Split out gen_goto_tb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424234436.995410-1-richard.henderson@linaro.org>
 <20240424234436.995410-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424234436.995410-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 25/4/24 01:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/translate.c | 61 ++++++++++++++--------------------------
>   1 file changed, 21 insertions(+), 40 deletions(-)


>   static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
>   {

>       /* Notice branch-to-next; used to initialize RA with the PC.  */
>       if (disp == 0) {
> -        return 0;

This is the single case in the code base of returning a non-DISAS_foo
as DisasJumpType :)

> +        return DISAS_NEXT;
>       }

>   }


