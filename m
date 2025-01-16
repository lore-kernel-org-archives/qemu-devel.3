Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEDCC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRZZ-0006Ou-Ee; Thu, 16 Jan 2025 10:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRZC-0006JJ-D5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:13:54 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRZA-0003qh-Qn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:13:54 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21634338cfdso26610975ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737040431; x=1737645231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oz+Hk/DE2Y0V0bDQjT3Hy3VK1UNjFLaa73BU/NypY4E=;
 b=x5CQRRHK5e16/YYt07/YXTWYPBvqcLtHulwxBKZSqwD3U5dgxfvIOlYFUDVJT2GNRS
 p+9xeRSKsYoGpNjq10rYpI26KeFTPOES0Aj+FTVXWjbRnvgiwV8oGZpjsK9eUQ1OBweT
 dYYnLQd6GqogiIezGn6i+jkA4Lb5yxj3GH7AStvauYOQ1LKGjey2+1vJmPmeqUr9zcEH
 ODXojYQ33qicgB9CfSx7pNZMAjJj4QOhDOhhdz2UUOCCDMyxQM0C0vSpR5VYb7syjGnu
 z0estBuGRvgn/Qm2gFMLhAlDTpOUAitlqMhgnhYsQq5wlFllK25UA6gZrUJJYt8Tq14I
 kNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737040431; x=1737645231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oz+Hk/DE2Y0V0bDQjT3Hy3VK1UNjFLaa73BU/NypY4E=;
 b=nAVpB7cI2jSYJhGbLklUMggOVepQH5uEAmoy7+Uw6jP1rg3GPquQpL8epTHC6j3dTl
 HHlF8uMk8NZgUcLSNrgxQVN75fQtuOixAWN7WKP7XFJQLEMBdTqj1kZN8saJPX8+QlJN
 SssGRytnz8cOTvNCIdLl9F3fCFskKPIgacv5OyyC9bxGrTRsLcN12lOBcMn4MOOfs6Wr
 b2ls1FphRd8fekyo9d7WoHxZEt1Ml77iA1J3+sBY48DL4mZTpkVrxRYvm7gaM1lyHq2Z
 y8NOQ2fRUohluoVDf85mpfMuPxdqIxJG47iI+k9REgc7UyIwXkkHKkfbJ1J+9LsfSqyS
 YRug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsRoaOWvr0AJbBNVwZl8cbRpJWphQHUfJP/Cc8azMH0I57mzyx9yTQN0PvSxjbHmvaXedirWpboadM@nongnu.org
X-Gm-Message-State: AOJu0Yyg3sb0+02QqzZH8bPyE4tcupj8vL5nf0bkM/UHxnv0mOYtoGHU
 VToTS8q3P5E99LpUzynzmIv3iNKFD/232ufsPjY2d/sTtqC2Ht9+fVaM4pvn7lo=
X-Gm-Gg: ASbGncsy7T8k6favCKQN4+uebQytaZx1NQ1yFzmTZnmrhcy9LdSz8EUftBQKm6uyKOh
 QNJ2srxaIbLJTVP6OQ2Nfd0DeFGam7pqwBmHt65Q+rbptdnTPu4Rry0LtmO7RxDoG7rqLoY5Jz1
 Kvcft316FTqDfL6817c7/QWLueMd8295TdLt+B/5s3DodPAn19ucL5ZGwnbRYEmdNW7RJpQztYZ
 mNq3k3EiBmllqqXyWI1umAh7I4CnsW4YLA9OSTQOsP0IJND3VlcxpXHLXcHF87caxTbiQudqMek
 zRfyLr9OuU+COL5/Hm+U0/0=
X-Google-Smtp-Source: AGHT+IFDFh6L7Tf0enTgy8ibn+gWivlMh7HQ1TBOYMl7Wre4ln27m6UN9C775eYFoI6BHViedMM5AQ==
X-Received: by 2002:a05:6a00:4485:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-72d21ff51f5mr47353263b3a.21.1737040431061; 
 Thu, 16 Jan 2025 07:13:51 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab7f06e6sm141944b3a.34.2025.01.16.07.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:13:50 -0800 (PST)
Message-ID: <20419c86-b048-49a5-892a-74e91216e18e@linaro.org>
Date: Thu, 16 Jan 2025 07:13:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/x86_64/fma: Test some x86
 fused-multiply-add cases
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250116112536.4117889-1-peter.maydell@linaro.org>
 <20250116112536.4117889-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116112536.4117889-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/16/25 03:25, Peter Maydell wrote:
> Add a test case which tests some corner case behaviour of
> fused-multiply-add on x86:
>   * 0 * Inf + SNaN should raise Invalid
>   * 0 * Inf + QNaN shouldh not raise Invalid
>   * tininess should be detected after rounding
> 
> There is also one currently-disabled test case:
>   * flush-to-zero should be done after rounding
> 
> This is disabled because QEMU's emulation currently does this
> incorrectly (and so would fail the test).  The test case is kept in
> but disabled, as the justification for why the test running harness
> has support for testing both with and without FTZ set.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   tests/tcg/x86_64/fma.c           | 109 +++++++++++++++++++++++++++++++
>   tests/tcg/x86_64/Makefile.target |   1 +
>   2 files changed, 110 insertions(+)
>   create mode 100644 tests/tcg/x86_64/fma.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

