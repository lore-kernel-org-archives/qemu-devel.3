Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05731CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jGK-0006ov-FL; Thu, 25 Sep 2025 06:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jGI-0006lI-IN
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jG8-0003NJ-WA
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:31:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso687984f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796285; x=1759401085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HklLCn9E23Q33wTYeMm2Mv4+IKkn8uukZU2RkF5mMBk=;
 b=b/5G3FCf+1+lRoNf6oB9BpCoHaGLeF/DasAdq1rGr1Du0HB6YMuA7jpIlEYn1/8dv6
 mGXYfvoLj9vLFdM+qxuKN9WbRAyU7YSzb4OYUGj8S/TzviiFYD1TigN8I+VkoDz5qMtx
 33IC5bb4Xax0I7wGMGe0k7nfyq69FWYDIGO99iI2bE+mc79q23Tgb4LyPNJpbdhMI537
 3fVXOSKk46lDD45eiyqyuaDIg9ywZbZO57DtP7tS35vByN77u6dcmreS0MGrF62PKLZL
 DgslwaWezfie5Ap+l+dlfqXTRjmywiS500CZYB0TlBmFeFf8ELEsuYK7TtF3637LSFXr
 TyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796285; x=1759401085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HklLCn9E23Q33wTYeMm2Mv4+IKkn8uukZU2RkF5mMBk=;
 b=wE+7kYNnbli7o4i+AxVZY/tuzXCW1ks1/QjvektYKMurKw7zsb/FZTVLvk59m+VDXq
 u4TcryJrp7WVHV65GMXZ1gpbc79xYtyaqQMaROwhOpabV7VK63AR/XNc9Euzs/yfKz1T
 v/RhhCm22T58ctGHKO38LllISGhALdyKkjyF11k2AtICcNP8yRaW2g3c+5kYcQEtIiVE
 vFfrTO13ubobWmP7PTpyhiN2EuNsnCoIXtd5cDbd7RKkAzU6orcuHo7G6pPI8gRjT2Eo
 hgPz1B3t/y5fD/QuKl3g62+3Qz/EvdSwxnedfjwYGukrvDonIQEjK82MgwhiE1q/dHS6
 QGKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+ebb2GHW178sWi0PwP9oDyARJNnoU5+2kAGiG0/+1xGobIEVge6y6Bba5oySJInCPjkIb2CTQoBv@nongnu.org
X-Gm-Message-State: AOJu0YzTBdPQuyvsk0UCLvC03uwJvV4t1NoTqZEw/+KIprKVfIFEHdCk
 W9sNt9c+AMCZmnFaOB+2+UJCCOKvMvCdtUS7Q/U+/pFLjT1XmqBCSPWLTQRDfY68Tzg=
X-Gm-Gg: ASbGncsZ5uHKk6gHiIHPILrqF7XafIpzsuqH3SSqTyvHf+o647d+Y4YlsUAjSo/cr9Q
 /c9G64PFMEa8bRjq/9FIEpK1IPbYrbgGVyIpnAvWhDed25YO5TF8TROwvB87oRBCGABRJNSXsux
 mML2fTuB4Q8rqycZKU3WaYCwMx6H1fMO6Fzz+TJuH9aveFaKw30fSIPMpqngQr3ZvrG2g0oA9VE
 mz9NEtRLL2IfkRxnLUTixpprrYAJFtjrsZzVLK0CFC4AN2AVrqNrODi3NoKUCNqhuUhy6qqIPVG
 4PVr4ZRp+xWnbw+i0yPefT7YD4u9eqy5xofeVQHKDQc/sjyF2Cz8pWJ2gkPDGAKiOcBvZDRqQg2
 Fn5k7NLjbh0OeSTdnx7d/I8/ARdyk1C8Kg2MujoC6ve8DaaL7CFgPneGjnT7Av9tjmg==
X-Google-Smtp-Source: AGHT+IFcH9sov35xAOG8ya69GJvqn8wVkkAkuzzcQtWu8b2ggYJB7+WgfD5cSNFPJNpgxR3xFJpxWw==
X-Received: by 2002:a05:6000:381:b0:3e0:34f4:3225 with SMTP id
 ffacd0b85a97d-40e4ce4baeamr3004721f8f.45.1758796285429; 
 Thu, 25 Sep 2025 03:31:25 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9d26ef7sm2575241f8f.26.2025.09.25.03.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:31:23 -0700 (PDT)
Message-ID: <dfbdb7c1-392d-42a3-93f0-6319a4684992@linaro.org>
Date: Thu, 25 Sep 2025 12:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/36] target/arm/hvf: Remove hvf_sreg_match.key
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Use conversion functions instead of table lookup.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 35 +++++++++++++++++++----------------
>   1 file changed, 19 insertions(+), 16 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

