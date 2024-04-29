Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F92C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1S4f-00064F-Dn; Mon, 29 Apr 2024 10:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1S4e-00063z-Ej
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:33:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1S4b-0003r9-Pl
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:33:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f26588dd5eso3824790b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714401220; x=1715006020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VbvqfBRwmsoiReUwHpaROZjn0tpsfsjaXn1C442smno=;
 b=uulMN1XeEt/p8UarvpbY0WdRdMsBUwH+eFQgChyqqG7Z4ron4wNkBe/Giy8w+YpkP0
 BYSPSlWGEJ0ZaghXUWC/AW3sIgYwHu32NJGACGqSmEvUydVc0/v2xLuJ39GNJB2aoN0F
 np5STQS4A0q6umFc6OIb0PbJ3EDA4K0RsIZ5RGjAOjH8PGmLgownAHsoMQvYYF8Khvbk
 cu2/a38I6DiiZLn7ptEk2JzFFgifnu8FPAGAYygeXprmOQ5sAld1J4spDqk3OdZIyiRB
 pAMNiQ+wqvFc9ObCKPaIC22t1KJfTnkFS5zaRK/33DJ2yGkV7vlKEoYU/vlCNoTQS+yn
 /7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714401220; x=1715006020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VbvqfBRwmsoiReUwHpaROZjn0tpsfsjaXn1C442smno=;
 b=Knw4RDMddnqc8YTToqKvVmgwvKXdFocmDfkfVtdstNAsujbsCmzcR4rUuD46Hcx0R0
 pRN7CmTwAVrdHNyYFPJBMbVfqPM6z9jQ0o5Bybp+OlwP9+oklMZvtiu2OM+UB7h+n/zw
 NOQGoKqFxoRvmtVaK3+KtZYPa02+zr2UhHPiSC69w6wpShjuWceunNezzacJZ7v8BMZG
 tB8U9gW/l89YLQZe6v+OaT/ecaEd+EEIvnCMNIJMbgTm/v3ukbYMxACSPm+slp4tPJO5
 0PenB0KxGg1azwO1ip8RYQwrVC2jwlO1wGDZC04MiOAY0GmqDIikSN1VzhZXhEDyuIe/
 SoXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXnjHRFkC2GhTPiOZInA1gSqr60xz+lCRvvrsHZwmeOfrp8hMsxB+BZmLsFdcXze9cCtWH6UfYTas2jzBPHqlggGdaLKE=
X-Gm-Message-State: AOJu0YyRog4KGsYbsB4nvQj1SkymVQfedWzQROd7LnvakBW0YYe6mbx4
 RRio9TKC18MCXru1FpuRjNFcR+uEkh+z42XnMp1xK5jsQJ5YHUkGDqQsJ+38BLc=
X-Google-Smtp-Source: AGHT+IHlTv4v4eaprp9gI9VBbvQU0W6V6KF51CIkQpNY14h0Q0nN3MF06gtuBhGOl+lvvODrRJlxLQ==
X-Received: by 2002:a05:6a00:398d:b0:6ec:e726:b6f5 with SMTP id
 fi13-20020a056a00398d00b006ece726b6f5mr12477677pfb.26.1714401219997; 
 Mon, 29 Apr 2024 07:33:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 z25-20020a637e19000000b005f80aced5f3sm15998388pgc.0.2024.04.29.07.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:33:39 -0700 (PDT)
Message-ID: <dc09a034-6357-433b-bb2a-ebd5d199cf95@linaro.org>
Date: Mon, 29 Apr 2024 07:33:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] accel/tcg: Update CPUNegativeOffsetState::can_do_io
 field documentation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> The @can_do_io field got moved from CPUState to
> CPUNegativeOffsetState in commit 464dacf609 ("accel/tcg:
> Move can_do_io to CPUNegativeOffsetState").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Oops,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


