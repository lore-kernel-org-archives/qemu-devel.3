Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F92C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thsw1-0004IW-Ta; Tue, 11 Feb 2025 11:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thsvz-0004ID-CM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:16:27 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thsvw-0001ca-Qd
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:16:27 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21f4a4fbb35so79099905ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739290583; x=1739895383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ERff0xWZfxlF/0xWLRDxv5LxieGRps4Aa07IyWuMxE=;
 b=LsctmACEdY9ZAO9PI3zE1wQXyljcK6EoHePC7ycZFcShq0lf7J3qfgK+NbfF41jLQs
 AvWIJulB6ImvisTYxeFoiuMwaq86ma/QBrlen/je3E9UlWDVYme/6/p64zbVJyoqVUd+
 76ei0A3aK1vdS0kIOWpJQSbpYiPaObas/XuWcOgk6tXfK9J9H2Domol5v6/bfy2Hg8+U
 IkxzR1wTcQ3G/nweQkpky+zmS6vEtEia29ExZ5a1/9kRfV+Hzz8neQ1O2Z00k08BXi6M
 360Pm6AxnJwi5/S0sZH7+Pn+nop/+qXfuzAD7xnA17toeucRVJeABqJ2TIrrF2kjdRd2
 74cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739290583; x=1739895383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ERff0xWZfxlF/0xWLRDxv5LxieGRps4Aa07IyWuMxE=;
 b=M3TvOEZNXVgEoiD4zxYv5MgBLE25lkpp9RiKwaubnFChr6WZuG2XIGGhr9v8v/uWZ4
 9pOx1Kzcaq09qDDy8N00x3xQwYzMfTQZ+923VSnXrplqqXe3xi+GSc4j/euRgmRTm5+6
 NXWEfuMZnyeESZBvAOIFOY7+zQoiOhf6/B8IeNz80hMI2vNb4Xf8zsuQgCDZsj03Q6rT
 xktSTJcQ3Pwh31WbWHPSAWFj45HKQeBJrEhNlxIm45uZQvPJgfqdgn2N06/qFb24eMVi
 6R21dw2RpweGyEhmlRQGw9WIv0TJkLegubgubQ0d+jPHpIeOAdg+xSykB8WbWZaHrlBv
 83dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ0jyBUoys0ahm6co4P8dRYzIraQ2YnautcocOxl2zv7ertHaQBcfdXuqh4xP1o73GsNpwbmiYR4dH@nongnu.org
X-Gm-Message-State: AOJu0YwusjlVExgR/FcR6TlsMGJKzLQsvok2yXn6mXi6GvTfdikTA8Hm
 TML7pJuhNBVUlUfZ5Zz3EaDgVhkfL5iO+9XWRwjN5sGiKDWvxzyBVLX5p9xvDNo=
X-Gm-Gg: ASbGncvxUj4TKgsMg691Y5IRmey95WnjjUWxMme3pqiLwa9ZzKOM6cCVHpKx/V1m8Hc
 2utsIw0EO6Ims65oSvPSSaeo6P7AIrhYLLljEM/q++r3xQiehHSSOLBJuWiqhKWKRMR5/leqMPS
 Frw7JGJnBWS9mDIhs5lWkRim8oQqoLzur8HRNj454hWxVAiGPzFcrpuveyBRl3O0wGlWPVjsnQx
 jE4lbCItMn7Ksiob/+p1OLvH8KT6ZO+Qg7USlQnY7tA5snPwyqKvicWlkl6x2ixAquzuzXeHBG6
 GokLQqKprr1R61gBZ2aA4jBRmaeoqMTE7S4n91fEwq1Vxsmz8pEqNRQ=
X-Google-Smtp-Source: AGHT+IHxJfypVXZA3ee7yn4gX6zhuNH5TNStgv2z0DlNg8bAl9gJaNVyn03Vm+dOC2FgUE4MKcLKPw==
X-Received: by 2002:a17:902:f68c:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-21fb6c026b3mr53496605ad.3.1739290582820; 
 Tue, 11 Feb 2025 08:16:22 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f36535f0fsm98349075ad.56.2025.02.11.08.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 08:16:22 -0800 (PST)
Message-ID: <782799f1-1ec6-4ac3-aa55-6a2a769fcaf3@linaro.org>
Date: Tue, 11 Feb 2025 08:16:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: Don't corrupt error_code with unknown
 softfloat flags
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250211130626.3940412-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250211130626.3940412-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/11/25 05:06, Peter Maydell wrote:
> In do_cvttq() we set env->error_code with what is supposed to be a
> set of FPCR exception bit values.  However, if the set of float
> exception flags we get back from softfloat for the conversion
> includes a flag which is not one of the three we expect here
> (invalid_cvti, invalid, inexact) then we will fall through the
> if-ladder and set env->error_code to the unconverted softfloat
> exception_flag value.  This will then cause us to take a spurious
> exception.
> 
> This is harmless now, but when we add new floating point exception
> flags to softfloat it will cause problems.  Add an else clause to the
> if-ladder to make it ignore any float exception flags it doesn't care
> about.
> 
> Specifically, without this fix, 'make check-tcg' will fail for Alpha
> when the commit adding float_flag_input_denormal_used lands.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I guess I forgot to run a 'make check-tcg' for all targets until
> I was getting around to queuing the FEAT_AFP series :-/
> 
>   target/alpha/fpu_helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
> index 63d9e9ce39c..f810a9b6a47 100644
> --- a/target/alpha/fpu_helper.c
> +++ b/target/alpha/fpu_helper.c
> @@ -476,6 +476,8 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
>               exc = FPCR_INV;
>           } else if (exc & float_flag_inexact) {
>               exc = FPCR_INE;
> +        } else {
> +            exc = 0;
>           }
>       }
>       env->error_code = exc;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And I think there's a case for
Fixes: aa3bad5b59e7 ("target/alpha: Use float64_to_int64_modulo for CVTTQ")


r~

