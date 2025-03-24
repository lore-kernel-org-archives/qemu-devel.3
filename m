Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06CAC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmwV-0008Nc-69; Mon, 24 Mar 2025 14:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmwT-0008NK-T9
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:54:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmwS-0000xV-2x
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:54:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso51099745e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842470; x=1743447270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QhniJqJiM+UzT+FGHLzZBxft2LbeuB3hSKSZ8RUvv0c=;
 b=hEbAsvFhgUhAWELy+wNigCe786FrH/iBPh3vH6C4t+cfS9CwefBrNtinJf5ORsS/1K
 J3a09krCm1DAxklzAxKbkSxht0RLBLZgAisYRkmemRTR6P0GqSYm9h5fYsrqxdhtEFPZ
 O8HTMeMv+5jI49yr87O1IWXhvtmCnSWo+GFZbKjWeCRAT/I2yRn9K8umsqJ0SIa8Qea4
 YMf1nKd4EYfOY0//W7SCDie0nxnlH5bsri4yRaHDiZFzz4g2lhP9JVwLaMRSxB/oEHTJ
 6x/FPyM9NIShZwVuCH06Amtdb05ERFNwNnaNm3QqJc7WPoNu6sIbVzj1WhLquxrODGWT
 38Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842470; x=1743447270;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QhniJqJiM+UzT+FGHLzZBxft2LbeuB3hSKSZ8RUvv0c=;
 b=jkd+0qs+PL1YPd84riUtEHhdZ79KnWP2oCtywlneLNxBt6Q4pc9iX5JXLc/Nx/arOv
 Fop+RRFWvJVUq7NdifJa0rizOP9ekDcwksAV0hjtkw5+sfNDks9xhJE6abDtQS7X9sFj
 SVYsNX3DIKoqsMd5K4n+RY3huaY4GpRqm9np+htJix94QXSwX7UCqb725KKc4xJ30Nmu
 JaRaPsqCqfIRVBLsQ5cwo3CyXRWA9ClWyJDhxAVVMLwMqxv/MW4ARiXEMDo77OQMr9Z9
 q+LTpnNlwZyVIFmcUwsSj9MggWxkyXvLi6M6gd9QCPo8pTzAJn9xABFSrXv330WwaexD
 G1iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoSJoOsIVmG/tOAalNSl7JATsYoXjuwK1iP6jSnH4MjGTKBnviBpI4r5foQ0Om2uI50ZaZzulFIlBf@nongnu.org
X-Gm-Message-State: AOJu0YzgOkciBuTdAHVCWHhiE+vtdCDwDr87qH1EszBksuv9yjRg50RL
 kBRHRDF4bRZdTJlV6+h1D7kDwsHsZyKSoIpDtwbeYSKZFZrToAbMqWfJ6uPRWho=
X-Gm-Gg: ASbGncuOStfbIW2E2thURkAnpTT3Gumlsex9NPVfoLC7cpNHF5Q+ZScgnAsZbFzTaD2
 ntnVMWmNPYRMWk2KEpi4EHG4i4jIMGJiLRbjQt3x+tUOR8iFatuUsW/kNHYApgaQkdzU+gO9WP7
 P1rzTxI2w2HU5Re0uhSq+YlL0Q2dqKAzAjO3lNYzzoWOVofZCSd2Wi+nFZS024EaKvwtBrSLLwY
 0SZzYkh4SLVYxZGAl1h2yIGFKpceA+rCVd5yjgg2pPYqclqwN2/p/WMFd7PpaiBAHkNKENfqFYK
 yDfA+5XE5QxzisLPupNXV8nem+AOZ6cgm6G1LHDNXuzOHrhkv4/WDAmoxTDjiF2zO6Q9aUuVctJ
 nviJRiR21fbsZrylUBA==
X-Google-Smtp-Source: AGHT+IG7COj5eyHM+UMi8BRxHQAcGWI6FDjKs5OEV11Ei6Ja93pyWUMcviitr77BTUio5hoOvu0lrw==
X-Received: by 2002:a05:600c:1d92:b0:43c:fdbe:4398 with SMTP id
 5b1f17b1804b1-43d509e3881mr135210055e9.6.1742842469816; 
 Mon, 24 Mar 2025 11:54:29 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55c3dsm179939015e9.23.2025.03.24.11.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 11:54:28 -0700 (PDT)
Message-ID: <12eed6b9-ed87-43e1-b40a-2ebdd20b4dfa@linaro.org>
Date: Mon, 24 Mar 2025 19:54:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/build-environment: enhance MSYS2 instructions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>, Stefan Weil <sw@weilnetz.de>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250305213853.3685771-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250305213853.3685771-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Cc'ing Stefan and Yonggang

On 5/3/25 22:38, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/devel/build-environment.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
> index f133ef2e012..661f6ea8504 100644
> --- a/docs/devel/build-environment.rst
> +++ b/docs/devel/build-environment.rst
> @@ -97,11 +97,11 @@ build QEMU in MSYS2 itself.
>   
>   ::
>   
> -    pacman -S wget
> +    pacman -S wget base-devel git
>       wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/heads/master/mingw-w64-qemu/PKGBUILD
>       # Some packages may be missing for your environment, installation will still
>       # be done though.
> -    makepkg -s PKGBUILD || true
> +    makepkg --syncdeps --nobuild PKGBUILD || true
>   
>   Build on windows-aarch64
>   ++++++++++++++++++++++++


