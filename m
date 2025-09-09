Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13E6CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzVO-0005ag-Nh; Tue, 09 Sep 2025 10:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerome.forissier@linaro.org>)
 id 1uvzVJ-0005Zj-8g
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:39:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerome.forissier@linaro.org>)
 id 1uvzVE-0003U3-4v
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:39:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45dec1ae562so12769405e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757428759; x=1758033559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D+hI/HTeE6T9bnFZcpaoejgi8UDfuHpktfSSLv5Ddu4=;
 b=BuP3UGefvsLAh8EXdfIHVNFHEL4bxASpHguY4YF7dOmeGUpJ0gklcmOHsqkQpX9yv6
 UwTCso+pQu/WLM6ckwOg43njnnq1AmFoWi1OJ/+Lhxqu+HxeBJx+FNHjamBw1Lxa208I
 5Yj8By0yx7XT4+uOtGWLi73V5PC3H5AC82laAuKXl2vv+bLHDoT14fnw/baqfELZJ0BI
 fXC2YeyJOEwQ7+ELUomv+QQ5YiE5ceHlP0VYoW1d1NbtHhUb8GIBMekaeOIv6CQGCmD9
 VYxP6rU9A0Ag6/Lj2Tr7NWmSxjQsYet3ijgNge+q4LsTQ7rjVq2m+0QUJCZ9yaayrjUn
 1DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757428759; x=1758033559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D+hI/HTeE6T9bnFZcpaoejgi8UDfuHpktfSSLv5Ddu4=;
 b=ICKOsc/YOFaYqj++1MtCKXkyZwoMh2LKSSFe4fKoEDGr4mFbol0RXPa/dLTxSfGnkg
 Yda2FNTHRlCiPTqGrdfCqgyrzO+Pq4j8CQBpHym0hwcbJe3bpaMnkf0kPMkTFm6HRrjS
 3Qv/Pjtlsrrh9FY1oEObfVPwYdFDUACDslF48pBBjtvwanyBrsyrAbzDSd1Wh+TfW71G
 UgbMf+6TQOzVfHpkx2R4DMNkW4sA3qlhVDUtc22W/WNSX0lCJQpOZzowpnR8b9WrebFj
 75Ou9GgqHSti6/kQNgdUeB6MpYSRB/AOfYIz9P0h+bVWROu1ssFWeoj94EzUYxrCHB8c
 1d+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFSQRxlDbU14Skm5EtEsWLEgBMxaZ6VeC1xghJAKdfQoT72YhUgvXOPjzGNbv6IYmKl6gt70n0KctF@nongnu.org
X-Gm-Message-State: AOJu0Yxh83InnG9RdaYf6kusxS1JGg7cE4Fvf5VWyYW6zzKTSV6GYeyN
 1vERe9ti+XLx19MLsqLdXGLLDMk6Bn2Tj1T8ZD3Y2y30qARsU1f1uiuV2Uti7ibiDXk=
X-Gm-Gg: ASbGncv5g0TbVTp1yW3FjwWKer4wg9yZR248MtKupxTKxlwDrjRKYAYwcMscRsU+qvV
 +pX6crd4itgOo/+rRrXR2614O5eVRNwlsDta18khvNwOJK5t9MJvsrdIPDm1bKMeTbG2hAo8a/8
 bQZqLGG4NBsWIhXBKGDgato22ZgHkNrbIeFTe00yRLvhnetjVTzXBJa+dVDoR1l56+wGP5C8Kad
 m2sF9m1PLLh/woZPzrMpT5lYDbi8vcFhVTQksFbiClxVPNyADs5HpYTSryUBFhPn49b7qBcGJUT
 YJysBbBdRHcc0ZLvq5tOP+NUaihBnoGUzzslciGFmrAaceOiyRFWdnhY+2PkhBELY7afruZNoWJ
 kGh0eIHRUIRumkR7tlUJshS/XIOcUltvyA2Sbt6NySOXnuvoQOvuHKA==
X-Google-Smtp-Source: AGHT+IER1rf3Ut5SAYRyjosxW02iz3IEChupBYyb84VjPyJRJaE183mlvyzrXZ3kFtoSHzUEw2MAFw==
X-Received: by 2002:a05:6000:400f:b0:3dc:eb5:501e with SMTP id
 ffacd0b85a97d-3e63736fc36mr9550436f8f.18.1757428759159; 
 Tue, 09 Sep 2025 07:39:19 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45decf8759esm42932805e9.23.2025.09.09.07.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 07:39:18 -0700 (PDT)
Message-ID: <2c361c29-3bb7-4027-8b6e-eaf5c866d117@linaro.org>
Date: Tue, 9 Sep 2025 16:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/sd/sdcard: Handle RPMB MAC field
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <8ea56ae040ef1037e44fc864c159e2f96f23f059.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <8ea56ae040ef1037e44fc864c159e2f96f23f059.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jerome.forissier@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Jan,

On 8/24/25 09:18, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Implement correct setting of the MAC field when passing RPMB frames back
> to the guest. Also check the MAC on authenticated write requests.
> 
> As this depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256, only
> register the eMMC class if that is available.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/sd/sd.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)

I tested this series successfully on top of QEMU v10.1.0 with OP-TEE ('master'
branch, arm64 build), the u-boot 'next' branch, Linux v6.14 and mmc-utils 1.0.
So feel free to add:

Tested-by: Jerome Forissier <jerome.forissier@linaro.org>

Many thanks for your work. It will be valuable in the OP-TEE CI.

Regards,
-- 
Jerome

