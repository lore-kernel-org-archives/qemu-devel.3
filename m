Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9B5C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyV1-0002J0-Mz; Tue, 30 Jul 2024 21:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyUz-00024K-AZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:51:29 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyUx-0001J0-3Q
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:51:29 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db23a60850so2721317b6e.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722390685; x=1722995485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YodfNcbGtvoXcJeB7WPuIo6K9jXYBdtCULtnjlba9pw=;
 b=RLDz/S65If3gNkCmzCdzjXTVr3vQ0y/7A9OU1QOys8Lt8JTd6Q2/5F6F/+Jrjhcic/
 cx+uT5b8j9cCkTiYzXAucimBQ01X2zdwaBlZDId1IGVO/O4ak/Q/bQion2y6egAHTkd0
 Qphl/xwEYdUCGIpEatcqMPK0nP/rHJAOV7IDVzYJtI3mA9D/XvFNu+FDqLnyz/TTF6Ru
 KMgmHUTxr6MdG4GOV21AzUHTxum+xAhjWWFLmQxiEfTDGVEyscrCDwrxF4uXLD4LyZMf
 +I+eZ7mSo60Ff7S33qrClic7cphy2AC1fYiA4HrEtD6tFOLB+Cdu1qsYgqgcyx+9xJWp
 EfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722390685; x=1722995485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YodfNcbGtvoXcJeB7WPuIo6K9jXYBdtCULtnjlba9pw=;
 b=p4XdMcmlVTUb5MvGPADM3iaCpOQOxTUDCseDl6wqda4Dey6MUrA1L826KLUezWqApo
 QM8zPcLBS+t/8In6zRDmJ8OyHLzgg7CRp4MxNAaoOdtHmNN01wpSgds1PkpdTJHLjxfv
 c3ZuNBrJFV1oHJrY0mf8u7u5zhctvWktu+5UmmwmI9aXOF4r5gp6u8NSQ3oFvpQJY1/J
 rL4C3GqSfNOGf4lri6lXPM9KfhVVSCFL9YlP5xggdZ10aAbPPNclx6guAMAW6OyoFgLk
 CHwACKIQb0dAbLKvGKltIRX1Kui7T9yx2Z0ddnQtRSyVcJ3xjoAlNlkUcmztm1UGdS+3
 yKqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYpPi5bxxd99h3cN40wtYs7ePPyEGe6x3UbZM/Ulnf2JsqqCbKAhIpy9tPHdCRfo4ak4QnZ5EvY9srR6dOrUjumTRcwh8=
X-Gm-Message-State: AOJu0YyCY925OLpzYNBni8ibCcIEHooJOxrTvGBAC5YKRX4a5vGjrsAK
 tpTydyLcT36vcmpdG1TF6PtLtKxh+zesrzKTo2Q8rWDyngBoEx9Qqb2GCnOboUA=
X-Google-Smtp-Source: AGHT+IEta2/sogBQ8lm5ohg65nXUi1qsW9zueQ0ORLLLhEl+0ozJmyP0ZTZYfstBz4Zj85WDRX9I8Q==
X-Received: by 2002:a05:6808:23c7:b0:3d9:ddce:ed31 with SMTP id
 5614622812f47-3db23d381e7mr14964860b6e.45.1722390685657; 
 Tue, 30 Jul 2024 18:51:25 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f9fbd763sm9523977a12.61.2024.07.30.18.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:51:25 -0700 (PDT)
Message-ID: <a7723de4-b4bb-4f69-87b7-39e5e682def8@linaro.org>
Date: Wed, 31 Jul 2024 11:51:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] target/arm: Enable FEAT_EBF16 in the "max" CPU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730160306.2959745-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 7/31/24 02:03, Peter Maydell wrote:
> Now that we've implemented the required behaviour for FEAT_EBF16, we
> can enable it for the "max" CPU type, list it in our documentation,
> and delete a TODO comment about it being missing.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst  | 1 +
>   target/arm/tcg/cpu64.c         | 4 ++--
>   target/arm/tcg/translate-sme.c | 1 -
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

