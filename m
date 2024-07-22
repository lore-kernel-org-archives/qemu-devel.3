Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3552AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzEV-0001kh-4R; Mon, 22 Jul 2024 16:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVzET-0001ij-FS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:02:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVzER-0001Ml-LQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:02:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso22820195e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721678522; x=1722283322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DXgZG32sbZUUJvy0LLPw9dM3Lgo9p3e4NlYrhphNMnM=;
 b=BQjIMeQCWdAOYPTUmFgaoS6zeCk1RQzrjSdDBIaTbla4KUnazq1Ym2w72PQ5G4AURJ
 e208wfBZwP+kpmtBR00Pgy1r2Tcaod763Ik5eZWG8vUlpoN32GlgIkDQSQIRLQXN/1V5
 YFMX25v0zDzorX9qJliEohlo0xSnmCIB0nHXTx8hNS/bFxczSM5VDbN4UpHwprcoAzG0
 cIFZH/xgkfUQL2wY6APu7eZmHyaeAOXSnMxZgPVksojLXpW7pjPUKqv1pZ5IrT0mmtFy
 wkF78MC2jFZdSI8aKEhNz7UKExd1KNdgtUCF4EtQsIE+ZajvxSBNM4gfGTZvQGIwcxuq
 vqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721678522; x=1722283322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DXgZG32sbZUUJvy0LLPw9dM3Lgo9p3e4NlYrhphNMnM=;
 b=NklaquD6mH+BVtLmSmGzX/yo+3ZUB0ZH6g18F5dmeZPOH3D07EaoLSZgMULh5/+TqC
 10i22KxtMWNkFTctHqvJ2DlMTm/8O7rY/L589O5jZ66qD4CwqKlS/H9XOJoLY4Lnu2Hg
 T1d5lK1sC93TO1CFurq+Q+wvZ4A46ld3Ghbd10yie1yyq3DvoTWBZYt//ndlrUutlpki
 8xaW5zjW4PxwJI6+GcUrnKKi7McBegM3TXXiosKv2HsBEE7Fp/lmrLP05ne8x4RGuQFJ
 8y4dvHaJ1IdiNaINUQ6qT4sLPKmFb8fI9F037b5cPYQbdo7s8/ob0EUP3vqsueZR05uo
 oEoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsSNn1k00qwPBuJucZHTVxZ2mI3ju4sfCitAmGMy8ZI+k+Ir3F24VYXv4a4VTHJXBNa3TpjYiPDd8RJe6Hp4m/vWeNC5U=
X-Gm-Message-State: AOJu0YzJ32qPt+AfEY3RonYqj3IWWD2mvGfgbSJSc2V2BKW1uNWOsfbs
 KJhLQiWy6XRxk/jAXqI/ahpI3zAvG/x6+F48V9uIRcnuDfW+I3RVEHyzijR42zk=
X-Google-Smtp-Source: AGHT+IFHUueJSJxWFeqPr/ldGhcWIYfrh/b+4/wdhPTe9x9cwOreFxzqhRNcg9ciOQ8ryVGLOjK2oQ==
X-Received: by 2002:a5d:6e06:0:b0:366:dee6:a9ea with SMTP id
 ffacd0b85a97d-368740244d5mr6943432f8f.26.1721678521872; 
 Mon, 22 Jul 2024 13:02:01 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eba8csm9446016f8f.91.2024.07.22.13.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 13:02:01 -0700 (PDT)
Message-ID: <9a8c2997-b9be-43ed-8fb6-febd6b50024d@linaro.org>
Date: Mon, 22 Jul 2024 22:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if
 EL2 is not enabled
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240722172957.1041231-1-peter.maydell@linaro.org>
 <20240722172957.1041231-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722172957.1041231-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 22/7/24 19:29, Peter Maydell wrote:
> When determining the current vector length, the SMCR_EL2.LEN and
> SVCR_EL2.LEN settings should only be considered if EL2 is enabled
> (compare the pseudocode CurrentSVL and CurrentNSVL which call
> EL2Enabled()).
> 
> We were checking against ARM_FEATURE_EL2 rather than calling
> arm_is_el2_enabled(), which meant that we would look at
> SMCR_EL2/SVCR_EL2 when in Secure EL1 or Secure EL0 even if Secure EL2
> was not enabled.

Just curious, how did you notice?

> Use the correct check in sve_vqm1_for_el_sm().
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ce319572354..8fb4b474e83 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7232,7 +7232,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
>       if (el <= 1 && !el_is_in_host(env, el)) {
>           len = MIN(len, 0xf & (uint32_t)cr[1]);
>       }
> -    if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
> +    if (el <= 2 && arm_is_el2_enabled(env)) {
>           len = MIN(len, 0xf & (uint32_t)cr[2]);
>       }
>       if (arm_feature(env, ARM_FEATURE_EL3)) {


