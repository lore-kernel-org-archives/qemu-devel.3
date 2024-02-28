Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C7EC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfSW3-0007Mw-Os; Wed, 28 Feb 2024 17:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfSW1-0007MP-Mi
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 17:35:05 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfSVw-0003Nq-BD
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 17:35:05 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e125818649so134415a34.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709159698; x=1709764498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gXfKz73T4t3plp2BISJ1mk6RTY5yTrE/U3VJK9m+K0s=;
 b=qNIO0sCNAMzdqIGrSn8Lg/I18bwuJTN0y+L7PJaN6vgVjl0P1p+RoDWWhwqhCgFjw3
 EUBKeChaobTqPmH4BwP/beiOtqfvw3tw6dNp8Y1UJwk+sVrqF32Jq7VyLM/cukacyhBQ
 qTV1K51cGCyaRw2Nv03M6pEIpMos6nL62WX1l42b6z3h6ue5yyciBV+ndHhz48YEXU/l
 wnTej6zvqLh1c2rUIw1dbuDXDWbiPTT+jqWxGLzlsJRAYC/PwALHZtZRd0416lKBEes6
 UB2M9DLLidIhQ0VAOvo/fRxa7vBXCmQTeO3f1nGTXikhqvG+cSFejY6aPeqk6JbInFzB
 pOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709159698; x=1709764498;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXfKz73T4t3plp2BISJ1mk6RTY5yTrE/U3VJK9m+K0s=;
 b=YS5YcQ2cESs8R9zHHxDCbwV9h3TLeuguv+Ho/lsjOPcjXeHrPp60A4WP032rf34e1F
 LTPN5bTieAaAdyvs8BdRVK+YZJSdyKHQ07AJFENEk/TtYLzvUgYWbe6voP48NNqr9E73
 qSVOQ4qXcC+i9FXhNj1airi4N7wA1znLB8R0fUVrUznarmOVEKdPtblPVOLZ83z4tn30
 6GmYO3lJroPIWIUfMJdjiEpfKGNL92E0boTrNfiP8S6tRaHIkUe2B0PhAE18fly+OX/I
 KaUNNxU4XY7X1xlm1OhCZTOTzUCtHvc1k3Pc86dn6tNF3l8TTBpKk5a2B6xMsAgkhhbx
 +BDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg2SyiDIzU6v0ZhhClH0e+OKF8IUFvUWB7T+44TRrIk/UWW5ErbcY4AiIkYVnojry35Anr/aszq6cW1XTN254FJRGTIZw=
X-Gm-Message-State: AOJu0YxvWo4Nxoasv110Gk54cUvN9lxqtkg5LHoS4BueJ+d6ontjJ7Av
 oMUMtSdSGYnY3giBCeDuTURRarrKXz2Z9S8ePVXpQLk2f9ar71QOEae6lJK0aFM=
X-Google-Smtp-Source: AGHT+IHbTuThLSsQIsP4nDSOgvqCNt6dGzB5KDHSAYX2pPkA0DNrt/ymxVfnBm4k29I1Pf0jGHJx2g==
X-Received: by 2002:a9d:748d:0:b0:6e4:8eb6:dcef with SMTP id
 t13-20020a9d748d000000b006e48eb6dcefmr274552otk.24.1709159698754; 
 Wed, 28 Feb 2024 14:34:58 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 m5-20020a62f205000000b006e56a599acfsm194422pfh.194.2024.02.28.14.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 14:34:58 -0800 (PST)
Message-ID: <e0ae5e5c-1876-4b4a-a297-5e314c8fe0ab@linaro.org>
Date: Wed, 28 Feb 2024 12:34:54 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386: use TSTEQ/TSTNE to check flags
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240228111151.287738-1-pbonzini@redhat.com>
 <20240228111151.287738-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240228111151.287738-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/28/24 01:11, Paolo Bonzini wrote:
> The new condition obviously come in handy when testing individual bits
> of EFLAGS, and they make it possible to remove the .mask field of
> CCPrepare.
> 
> Lowering to shift+and is done by the optimizer if necessary.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

