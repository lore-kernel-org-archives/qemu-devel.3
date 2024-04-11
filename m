Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDE2CD1299
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 07:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rup9e-0001E6-1i; Thu, 11 Apr 2024 03:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9c-0001DZ-08
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:28 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9a-0000jt-Hr
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:27 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-22a1e72f683so3938514fac.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712821643; x=1713426443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3uoVmxFW1D+yrPkblnfSvt3uFldsl6nq0TzcxpHo/uw=;
 b=zsy2gGz5Kb9CKfadzPbY3+GeI3FgRE0fPd53Mz0vWblQ5sW5UDvF4gDhckUlCwK4jF
 QrIQqZKzwRjLuWUa6KiDcksxOIsYk6xyQxRvUOcj4sEP79z77NgJv39xVV7pRkCRgX3N
 xlGZ8KDjikVWAiZYFwhaC2zIBCBSJXCUUHWJACE141uUZQsPh6Tb3DBjRBdUcP/gosdn
 5Ux7GlF0+vrjqBpT2TCHNjmSkEffeBWmdIXnNcc6RPsjxDf93v3FXpwf2pIA8cMoSJMz
 5L6A6FrZq4e1z1HoyOcVPQcvtbiJI0xV+YwNehHTbAgpEpLihFmlM+VsDZNul9ExrZTn
 QCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712821643; x=1713426443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3uoVmxFW1D+yrPkblnfSvt3uFldsl6nq0TzcxpHo/uw=;
 b=L201U/uXk1wdFp91O+yioMJh0N6SHwAwSDpyqn01FL7aoRvDtiDY7BBkIonrpv9lJj
 fjNaRtfU/rTKwPmkmCXJvx2tynI8wbmHzwUbpZQj3tjTfez4THt/NeIgbzNt9WCr/P5X
 0txbi2V4s+EhhSt7gm3dfhEHx6I2tiyOkAorq1sY8/xaOYqd3X1I2f+OoCG+nEKewzyY
 +l7ecydHBpFWHIyU23J1OiRkQZngu0IcTaRP8kJ/FfMR0m98zKWgEcZZ4t4Yhi/JIOAV
 Hd/gFt2YztI3e9vTvPFwvSvQ9LhDtQUC6EQVLBTdz7xTjmYwcHEy5YWMk+O4p6fnOTPW
 mpOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJNOTPiQUza4vo+wKgf1Kp/+jHWXqQrxluSAh1YdNiMwthnu1xb06eYT5JWa9feiHpxlOI8Y88Oj4iBp7yK17MHQfoUGw=
X-Gm-Message-State: AOJu0YxE5fEwemtGFXCt9UZgabSC9D33veocJVHP2u08rHi1IH0YmfyM
 jcrkv6jtVRx6OWDz9LWgVv/ls2Lehv2LUDMgZMe3h+akiIgoR70s9VODxStEwuo=
X-Google-Smtp-Source: AGHT+IG0Rt8ZpWKkyr/E5aNnvT2Mp82DI1V2NrXGDaEVQI59ReUr5a8GSSzuQx0LcEInbNV2HgHolA==
X-Received: by 2002:a05:6870:aa09:b0:22e:cee9:c239 with SMTP id
 gv9-20020a056870aa0900b0022ecee9c239mr5034151oab.7.1712821642959; 
 Thu, 11 Apr 2024 00:47:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a656a82000000b005dbd0facb4dsm493803pgu.61.2024.04.11.00.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 00:47:22 -0700 (PDT)
Message-ID: <b8b9862d-006c-4455-9420-c98620dad239@linaro.org>
Date: Wed, 10 Apr 2024 16:57:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 08/19] target/i386: allow instructions with more
 than one immediate
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-9-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/9/24 06:43, Paolo Bonzini wrote:
> While keeping decode->immediate for convenience and for 4-operand instructions,
> store the immediate in X86DecodedOp as well.  This enables instructions
> with more than one immediate such as ENTER.  It can also be used for far
> calls and jumps.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     | 17 ++++++++++++-----
>   target/i386/tcg/decode-new.c.inc |  2 +-
>   target/i386/tcg/emit.c.inc       |  4 +++-
>   3 files changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    assert (op->unit == X86_OP_MMX || op->unit == X86_OP_SSE);

Extra space before (.


r~

