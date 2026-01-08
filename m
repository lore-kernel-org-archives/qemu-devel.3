Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F73D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdx93-00037b-BH; Thu, 08 Jan 2026 16:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx8p-00031N-Jg
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:02:00 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx8o-0003hJ-3D
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:01:59 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34ca40c1213so2038428a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906110; x=1768510910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GGmxV/5Qa55deBgDojJv8pCX1TKDjKFWYxHAedy1HSM=;
 b=TwUG2g28Ft2uj8/qI53igj/cpAIJ3AYV5df/RpFfIKhJAGBmNBG990Zm9myL+mO/4Y
 t9ZV9OxUEb4YLACrg7YVSblTbKLim99jE9ITEIQFFkoiyMKu+wIS0vJl9mU+UklEEwDh
 i07r56fMLL21BsUSpwuICCQop1f7MkI9rsoX/fYeQn8iE29zE2vA/JFPsUEZ9V2aT9/Q
 Ur/RtWKrCqfFvx+0mtB/ujHIan3nCfUxbHq5gCt1da1+VGdsBEilHrZ79GVF47/snnfS
 pNM5hFN/TnmvHuKk+/ePMBwunepYH4pd6bwynoSbSCN2lf9JqBU0XGUeFlSOtVESMr7I
 JNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906110; x=1768510910;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GGmxV/5Qa55deBgDojJv8pCX1TKDjKFWYxHAedy1HSM=;
 b=cdyq89pMTxjMh9hb8EuS8WZUnCnsEn032uLyX/pVhmbyWngABZew85jv+/5gm2xO48
 kOR2Zzrh5R8ljHR9RUvCdyAWALFxeDYRMbMukggot5x70fBVhn9k0LxbdYJgLRkPmYvW
 rNaj/gWG7EtiE+2XYIspLzndy/7w2k3/lZHZrmpt904qLkh8BudVQFarcOqa76T+/x2K
 Zs2KUA+SHJ8cbSgQHtv+yeMkCfYXjAdlYBG/gCLZmoX/7N+oLONAtmc3Efyjj6+LZ3k+
 gHE/u9UTxgLPi3mfyMQ2ZjQP1aOjfEbMVPIZjsfI16emR7mciowoNML+zbzUou72ltz3
 Co4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKwt2Q6AlMg40fMYUMBvLMkJAd0ItZZRIzV0hvOXC3VXsYBZpY1VZL1YBBZpJdMmKHuwA0kLz8oa/d@nongnu.org
X-Gm-Message-State: AOJu0Yx/o9FhxhQDPqG9cm3LQeeqlhN880r8n9cRWZz1LGVyVKnDzULz
 dg4Q4eDnSB1+gy259lhWE+j5sCh/Odd/MJyoPnN1cQcghdnq1SkzmsvJCXf+cAtCHZQ=
X-Gm-Gg: AY/fxX4IfRLRXHnWm2vBDaiIFjRLI4vu/eBUV255XHyqRfIpI17iZu0wz+XpAMj6ZKP
 vlJ6ykIX0ymq18qn9g9vINdziOg7gj/R38WgOzuvo5120/+WgG9zi7HtaJbXAYUqChFguDPb0DF
 jCTQfpl7B/1NdEscKt2JE9EXaubTPrtkLQL4dh7qyWvWlPWxNTQ5taGgj3On2Je/prxwwwSxcip
 v8J3vL8lwgZuVTkEVUeKYDinP1qaEobDj9f8z+hHagcpwDFUTcV9rtpcoZ3aR3NY1lmAAsLA4ws
 ts+9TFcugJvYdj0oxnCOZFjKvRnSGO12BpM8d8piClSxCAAvwsIrP+4iKLzjVsefATDfMNCxq4O
 5Aqg507kCzh028v0KArMAJni3vZRLg5tVvtkm9pDRGJahER33VjSAjRw2b8DgDVOsDYp5NgAkzv
 c4OLHrcnW6ERX/tr/FmL0E3vyXvaCz+pOLZxwRaImJDjjRmEoa3wbDO7GQ
X-Google-Smtp-Source: AGHT+IECHGl6FwBjAv6Ffe2Ig5+VlB8c/OGSGJ1y2zp7KP/v0UW9yGbovjuQb7JNKjOX5TyGTZtllA==
X-Received: by 2002:a17:90a:e706:b0:34c:c866:81ec with SMTP id
 98e67ed59e1d1-34f68cc292cmr6326946a91.36.1767906110272; 
 Thu, 08 Jan 2026 13:01:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fb64b3esm8637904a91.10.2026.01.08.13.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:01:49 -0800 (PST)
Message-ID: <434a0dc7-75fd-4fdb-b30f-b38c52e28e98@linaro.org>
Date: Thu, 8 Jan 2026 13:01:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/50] include/tcg: Drop TCG_TARGET_REG_BITS tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-32-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op.h  |  9 +++------
>   include/tcg/tcg-opc.h |  5 +----
>   include/tcg/tcg.h     | 27 ++-------------------------
>   3 files changed, 6 insertions(+), 35 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

