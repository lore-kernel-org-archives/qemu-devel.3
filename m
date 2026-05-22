Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C93CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXoz-0002In-Tt; Fri, 22 May 2026 17:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXou-0001nd-F2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:54:18 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXop-0006AC-43
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:54:16 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-365cae89bf5so3446152a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779486849; x=1780091649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/R81TVSwmDYjxKtvhxMVlGgr5OEqIeUvZ2cmCJDkv9w=;
 b=tZtqvY/QumSj4w2CvKKMe2kAkOEgl2RuwY4CYq4wuTaqMm/sCyRpGkbrmQrn8f7Vup
 NG1mXO2BG6KRPkbyYCLh6nb+REdQj6noYTD6n7b9ROJfwjlMkNNwb9KbleITWY4Ou01U
 lCY5BO0oas/Zn2SRUirYO2MhjoZVWwIvoCGlVUakEmJIsVatxuhD7eloOlewUifd7obn
 ot+0MVTKb4NnyylQZt7eTotfG8TfOMcOHwftSrxSdHcAYq8+HXEPQZgZLrFQVl4l7A8t
 baEOgAE6ao9Rf0h9Jsdz5UCSpTlLY76fTTNC8mg4Om+soavubwHP5itus4jIWywjlAHG
 O8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779486849; x=1780091649;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/R81TVSwmDYjxKtvhxMVlGgr5OEqIeUvZ2cmCJDkv9w=;
 b=T6B8CJKL2B+pEZ+C08shoAMn7b8yOlADY1LfrUYD6eZdtMzaAqpwoX0z/LiwYIt11V
 6GIM1fhngWfxYP7qNol6nS0ZKpPWupWamvmnr5iAvLFr+ROQKwt/mnfSkqszq54PnQVE
 HSDKCQX/pP8AR0GpGTUsJzfoyKaVJPUJAq+i4ifm6NxZizC1iRF1KOcf78EVM7uLULoE
 5JBqFz0iBG2Fq6iWtbWUwt0xzVUSechvZLmOZvcr6fYSdIRFtRS3kzFoyJh+T3lL39CU
 seE3SJ27KQkn+6ZIOTKrT1uszCVYaDBUP3keVIowh0bZFNWiWvtIgteIwlSjXrJd4aE3
 sajw==
X-Gm-Message-State: AOJu0YxNwQaLVTk4+elsmOms7M7jmetXmyy5JXbvKFeH2CCfKwi+DRiW
 JYYsf1EFvDlx+sHGoDOXZTjeUWrJupnmMdHckXYDCeIZ6TwVFwjlfFywU9lo440Db+x4USBpbYG
 I4Zyg
X-Gm-Gg: Acq92OFyu77J55LMCSfW+0PnIg3Co35Z/1m3JEZaqSrve49XVb7mbia7W2OsDtklCEv
 iObobLXfcQpNHiK27m0R0ilEws31+akuwtdni6j96voo0CTRls0GGeRP9Q2SDn9koZsEnzzTe4F
 wMY883oC18EUDMYcOnwmpdlXBTrT4EWww50qiqbm8BVzQ910HgI94wHgbdo16dKW3spV2LaIaoV
 88rz57YJA5ZpFziX4x4ga62rWwtfdQ/Az9MDgGQwQpzMMa56HP4Z1G5Sf9Hpk1S0085miQfMIyi
 Xbb2OLNzP8CBDpIdAIm1Omc9X6OyIEznebu5TSIj+2yM2QqARLwYqGRZI36iAEC5d/pnNI5dzsv
 g4YctfopwMx0ZSA6C+EiAymFdPrqcGdF6zheFkCS7Ha7eLF/+2orD5dkSVaLb3mRTQ1xpUY/TWg
 tUwTJzyBRxBZjg6OMz/mIVNvVvulwnql3m4Zkq6EIj
X-Received: by 2002:a17:90b:2e4b:b0:36a:1ed8:6fe6 with SMTP id
 98e67ed59e1d1-36a67654aaamr5044623a91.24.1779486849167; 
 Fri, 22 May 2026 14:54:09 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a721c7baasm3804797a91.9.2026.05.22.14.54.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 14:54:08 -0700 (PDT)
Message-ID: <948e2653-5b41-4660-936f-8247e172a882@linaro.org>
Date: Fri, 22 May 2026 14:54:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/arm: Set correct fp flags for FLOGB when
 FPCR.AH = 1
To: qemu-devel@nongnu.org
References: <20260521122913.1565011-1-peter.maydell@linaro.org>
 <20260521122913.1565011-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521122913.1565011-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 5/21/26 05:29, Peter Maydell wrote:
> Our implementation of the FLOGB insn does the operations entirely
> in the helper function, without needing to use fpu functions.
> This means it needs to handle all the fp status flags itself.
> We aren't setting float_flag_input_denormal_used when we
> use (i.e. do not flush to zero) an input denormal, which means
> that FPCR.IDC isn't set when it should be for FPCR.AH=1.
> We missed this when we added float_flag_input_denormal_used
> and made the fpu/ code set it.
> 
> Add the missing float_raise().
> 
> Cc:qemu-stable@nongnu.org
> Fixes: d38a57a3f ("target/arm: Enable FEAT_AFP for '-cpu max'")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/sve_helper.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

