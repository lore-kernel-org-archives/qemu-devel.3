Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD69C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyNA-0006do-1q; Tue, 30 Jul 2024 21:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyN8-0006cd-Pc
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:43:22 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyN7-0008KU-BG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:43:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fda7fa60a9so47307595ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722390200; x=1722995000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lLwu2gkiCoWTaWrY0d/KXhMgiZTSQZ/koPCoUhxmO8E=;
 b=nIVqICRBdWc4gUQkt8U5qdjgCkc8remnvmIniqAQHuWbVNjLldFYwEvPiRNdFzMdwB
 agAzOuTVsh9RJR8HEXMjJQ4WsbQKhqB9QQNJFSzDYPkgFx4rQjNx+L3tU5GSuH1M78QZ
 PUWZmJO+x1r1UDr4VjYtzt435Eqz50aV66U+cL/IzT2lUl4Eldzh7T6TtI4gsdAUYr13
 3Lw79vsQ+adMEoks2WAAhx9kmghfLjjXg7Yi3cHSWhWdAw/CGY2tWbQGzMEpuh9EqBn4
 L/tTBw8lYYn6fvwAyzMZoU1n1cn2vksG7DTeWFmEziQhZWEufLbVYCEPstoAvfBIcg2t
 tCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722390200; x=1722995000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lLwu2gkiCoWTaWrY0d/KXhMgiZTSQZ/koPCoUhxmO8E=;
 b=ZoOh6k/XI+nla11ETQzv4T/8ys5CjhWUD6hbyd3UtHkkbf/pau2F0OxzFtdU1ZmlOR
 mMlk3TkRHjW48RbRu9uw/xzMZbp7VT1bss7ointsuaPidahDQQC/G0+2hvyoJqCrpSmp
 Xf1KA1zhX2qPs1OY4C/3c03mU54kupjqUuDC+hXB768SLC6keBbNgKccTiSEFVGrF6SV
 yjTFEuy64sQtLqsd6HJ6/IrCavURCzRhahimx7avUmctjdPanrjrsVWgZFMEU5kZK+k1
 hBWRG7wgu1Fkn6Zs8l0W9bCIQSwnY0QWzh3gCORT4BhdmhEW6PJAMqLbehrTe7yB99g8
 cWdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgZgHvubcE0aMRE343Z01gTRNXZ7fVzmX4kC/eyW9QqXSE/nSxRjCWUDryWVNwXGgFP0ZGlK2HRAQBYswMy+RoBsuuiAA=
X-Gm-Message-State: AOJu0Yz0v088eCGBGWoZtp0r5V991GyzzjKaDnWQns+wiADslAyTEMY+
 YivO1FX9BMlhRT4M1i1H2UTaZu4NUbMFFws+ZrVJJhUtYH0iMp1bBfHh3qwr7R8=
X-Google-Smtp-Source: AGHT+IF88I9sn9AJIQdJlcUSklGySOcF1zUoBWHcBnFbgEBaQlqXopFOGl5yVS4iWMWyfZEjtvXb5A==
X-Received: by 2002:a17:902:d489:b0:1fc:6a81:c590 with SMTP id
 d9443c01a7336-1ff0482bea8mr170684255ad.27.1722390199553; 
 Tue, 30 Jul 2024 18:43:19 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fa468bsm108968505ad.255.2024.07.30.18.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:43:19 -0700 (PDT)
Message-ID: <f546e8f8-f688-4915-860e-b72e85aa9b62@linaro.org>
Date: Wed, 31 Jul 2024 11:43:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] target/arm: Prepare bfdotadd() callers for FEAT_EBF
 support
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730160306.2959745-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/31/24 02:03, Peter Maydell wrote:
> We use bfdotadd() in four callsites for various helper functions. Currently
> this all assumes that we have the FPCR.EBF=0 semantics. For FPCR.EBF=1
> we will need to:
>   * call a different routine to bfdotadd() because we need to do a
>     fused multiply-add rather than separate multiply and add steps
>   * use a different float_status that honours the FPCR rounding mode
>     and denormal-flushing fields
>   * pass in an extra float_status that has been set up to perform
>     round-to-odd rounding
> 
> To prepare for this, refactor all the callsites so that instead of
>     for (...) {
>         x = bfdotadd(...);
>     }
> 
> they are:
>     float_status fpst, fpst_odd;
>     if (is_ebf(env, &fpst, &fpst_odd)) {
>         for (...) {
>             x = bfdotadd_ebf(..., &fpst, &fpst_odd);
>         }
>     } else {
>         for (...) {
>             x = bfdotadd(..., &fpst);
>         }
>     }
> 
> For the moment the is_ebf() function always returns false, sets up
> fpst for EBF=0 semantics and never sets up fpst_odd; bfdotadd_ebf()
> will assert if called. We'll fill in the handling for EBF=1 in the
> next commit.
> 
> This change should be a zero-behaviour-change refactor.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/vec_internal.h |  37 ++++++++-
>   target/arm/tcg/sme_helper.c   |  74 ++++++++++++------
>   target/arm/tcg/vec_helper.c   | 141 +++++++++++++++++++++++++---------
>   3 files changed, 192 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

