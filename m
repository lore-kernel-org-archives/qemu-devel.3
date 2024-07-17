Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66BBC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1Uh-0002RH-KJ; Wed, 17 Jul 2024 06:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Ue-00028E-8k
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:02:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Ua-0000bN-I8
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:02:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-427b9dcbb09so14629885e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721210555; x=1721815355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TsrYKh5Zg8n6P6g9dpI45osLWcbwS9f12XYwFuWiSzQ=;
 b=htEnB7s2V7+zTzBXMIO2GZwgAg3rqjOewVel0cp/bKJ7ggm8vthlwiU44P6ibaTVID
 p72X3aUsVz/9x5FZgPJTUBv8ioecbALJ0jOuhfHD7qRmHY+bI+IYieU2V2bl6x1X2VN/
 UanFIEvWUp2558yQRniDx00hn9cKyDqTkPAxX7icvsVMpBSaTsxY3/7WVFbxkvUtPAlK
 KKauXeqkjkXAbTsIQayVEgJcwrYue3gjG2nQ5gNP5oZGWap8bnLjDse2Nlw6mdVhdnF8
 BwOuZCSJEcCwdm8V6MhUDIrZSWn6qnNSLReBsS7XXDAi28+aE+Tvl2kvn83kjKeB7b5p
 BWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210555; x=1721815355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TsrYKh5Zg8n6P6g9dpI45osLWcbwS9f12XYwFuWiSzQ=;
 b=P7VdzmfeN6XaWNTOk7YQlouxOCGaqBBr05Plt4iJmwz7Bu6ItxdEpYYLTV7UQ7tlwz
 f1fpNRvwIUj2yn6dOTLITka25Dm969C48e7TiMq5YHxTrkVIvFaFIWTy9AimRHDFbP/b
 IiToT98+/ihE8dy+2VLRLZHgc+ft4CIjqAOJmhigOTdUejryCiWlCx+/jGaBjnln7GKw
 ZuxOCltbxL3ker2YkqMtdhEOFFNfW9uV4nGt1cEdYAyvMF1Lc2Es65qfzNIRDYLG2OIH
 JiUj5WZeH7Sv/rURwziAfrj4P5811myIbjy65UB9PIVdKEXk1TXw1CSwcte1bPh6r5OQ
 9SYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNOOmHUXb4fYGlfWLwjiwF2nLgSZooqC89ZfUx8mLsajWg0ZhlruHkV0EuOdrmQGNXsUgW7wVpTSt3R4l0U7sI/JyRnpk=
X-Gm-Message-State: AOJu0YyUyupav5PflIYLDLH+/R9/Z7LarTroA+DrzsJvHDoOUOK4cNRX
 Zvev5ThAWdszxZYeYGZwuTNo8oc5oIP5CcHqG0Ih1Xk+a/KHz+3HYPTNpjpeXpo=
X-Google-Smtp-Source: AGHT+IHvBaHP8TqB5wQKyMWm3DKzjsD5RqNrE9xHTRPR1mUdXyjq52Gtj7bh/CL8Kc8eq1Bn5OStXg==
X-Received: by 2002:a05:600c:450d:b0:426:6157:7ad3 with SMTP id
 5b1f17b1804b1-427c2cd0c64mr8198125e9.19.1721210554734; 
 Wed, 17 Jul 2024 03:02:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc32esm200739325e9.35.2024.07.17.03.02.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:02:34 -0700 (PDT)
Message-ID: <c3b1870a-6939-4470-92be-c9a4ba0c98b4@linaro.org>
Date: Wed, 17 Jul 2024 12:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] target/arm: Push tcg_rnd into
 handle_shri_with_rndacc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240717060903.205098-1-richard.henderson@linaro.org>
 <20240717060903.205098-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717060903.205098-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/7/24 08:09, Richard Henderson wrote:
> We always pass the same value for round; compute it
> within common code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 32 ++++++--------------------------
>   1 file changed, 6 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


