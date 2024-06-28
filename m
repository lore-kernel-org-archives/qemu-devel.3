Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE514C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNEDK-0003gB-C0; Fri, 28 Jun 2024 12:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNEDI-0003fk-T8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:12:41 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNEDH-0003FX-2E
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:12:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-706aab1b7ffso710379b3a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719591157; x=1720195957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+hsxvXqtrSDIgVBf0gClU+0HHZ86ZGBrtHH4Y5HH+hA=;
 b=V4ObzvItnQ3kxClxyXr9kHVpk4bkK7LfXtCJYoS74ZjyNW9AQG5PMHk9jn0fevB1Yc
 m1VmVVAGeFSVDaf7CYcj/831Bc2fvj0NRfSyJejNNFBDOrdH86HyNg4Kq+HigmwrkCPX
 5tCCuJY2URSr8CqbWNdg+XEVUIuh30KcBNg7KwW5VbLe7N9g5cCzFrbpKm0rY9flFetp
 rNAP46c9YbS4iGXaVRRAn01acByw9zLlXcPlFr1vdr1zwrf0wVSwYdzOyYM3eNbmMzEq
 S139fyksvxlSxcRIcO9iFxqibqRhxAZYHWa8Q42l81SR4dH1LIgk/1Qsh93WrQ17zH/Q
 Y9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719591157; x=1720195957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+hsxvXqtrSDIgVBf0gClU+0HHZ86ZGBrtHH4Y5HH+hA=;
 b=Fg/KMlcww8rNXcznyR4+bxBG5Vi5FghjYr1R9RVC5qu7HouGJmqycUc8EsNGdRVDPe
 ZUTU8XvZuU2MimBAsI3CHkNetnoFvVf/8SHP+0zEmKOg9BvjVuFXIaGNitd2VBM1wkSj
 86Pd7C3NUd76GlLjzspSDxal8RjfA1YUg7/VrsP6Z4pOvzsxd51KTMa0/rTwGVZgnF85
 9eLYyfyBzNPGSs5nN6GC4C/TfKYEWUwjfdYnf1v92l8P5UZ9kMebWP3s+nBp8sfMjhNm
 9E288NsXCsdCg2D8CXU8wpoQiQOBCjdwG9h3w8DJMq3oDjmzs+4al6tOlMrzIKRaRYsC
 Dqrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaNs5VAU3nLmIUp0TkZ5eb2AsXJWuzofkp/JxeTr5coRdrMLg6kpVN1WoVcdu9FAEEdf2xty+bIhIJlN9ssERDoFA9vck=
X-Gm-Message-State: AOJu0YzUec/wkCPu3PPnqI5/hknOkpSgPz1onac+D5cwZloRxLPni+Yb
 4Ee3iuWITFFIeYuX+g6Ob+eVEL6aTLx7PFaMTYWaiyy7DkGAMLLdnxnU24DF3+3bxqZD0O8ElMm
 x
X-Google-Smtp-Source: AGHT+IFekck5yapmyyQ5eD/ZzPk7pkq2lBDUXh60sp5dviG5msT56SB6Valoy7QkzdNZDb2CU5qYRw==
X-Received: by 2002:a05:6a00:bea:b0:705:b6d3:4f15 with SMTP id
 d2e1a72fcca58-706746b8feamr17435162b3a.25.1719591157068; 
 Fri, 28 Jun 2024 09:12:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080498a3besm1780819b3a.196.2024.06.28.09.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:12:36 -0700 (PDT)
Message-ID: <68a00e63-9743-4b7a-aae1-a86ea5b1918c@linaro.org>
Date: Fri, 28 Jun 2024 09:12:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/arm: Rename FPSR_MASK and FPCR_MASK and define
 them symbolically
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
 <20240628142347.1283015-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628142347.1283015-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/28/24 07:23, Peter Maydell wrote:
> Now that we store FPSR and FPCR separately, the FPSR_MASK and
> FPCR_MASK macros are slightly confusingly named and the comment
> describing them is out of date.  Rename them to FPSCR_FPSR_MASK and
> FPSCR_FPCR_MASK, document that they are the mask of which FPSCR bits
> are architecturally mapped to which AArch64 register, and define them
> symbolically rather than as hex values.  (This latter requires
> defining some extra macros for bits which we haven't previously
> defined.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h        | 41 ++++++++++++++++++++++++++++++++++-------
>   target/arm/machine.c    |  3 ++-
>   target/arm/vfp_helper.c |  7 ++++---
>   3 files changed, 40 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

