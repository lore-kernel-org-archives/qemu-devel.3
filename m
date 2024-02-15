Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E953DC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raffG-00021K-Pb; Thu, 15 Feb 2024 12:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raff0-0000xk-8B
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafey-0004N8-Al
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-410e820a4feso12932615e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018591; x=1708623391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVyl/58rQCis4JK+W1os3aYgimBCMkxnzrgucGCz82Q=;
 b=gZzwvrjp/+M9Mswrqv9I5l3P3SbtffO+JDg0KyOaGlEeFUlzI7B/G50nNwZShhVaAp
 XcbCT14G9fFVdfUMuYxAYyAucuG5TBitYh95SLP1lnKeiSxubnHUusi5oQfDhXJLr0bc
 qcVHBk0Nt4yStdSwwih4E/gyi/Ru5k/kuMJxunHd92Ms53rmML7BE43nB81+KUbnm3l9
 fJAq8PViRKgCZU/Cu7C/4B41F14BSGWksVsOCZA+bIcyngN7zJAiCp0WnnMWJyVDkEcy
 X9oId8VxiFcLaIyVCKfF1CkEOiHx+zjiJ/GqaENgSBQ0CE5oEVVDeRz8yUVUDjM4Hf57
 hY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018591; x=1708623391;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVyl/58rQCis4JK+W1os3aYgimBCMkxnzrgucGCz82Q=;
 b=o6oiNXiQC5Eg/I3Kuu+p5CxetEJsks5Sp3uKHu2R5iIpIqM0FLtD8edWlSZs4771tX
 ADRJLXv90Mi27jEWlb52F/j32ZCzmb86IEh7yViWXlI5qCuzuxTr6gX5NStEKNzUqtUH
 bDhnDiMBCIwTQZIG0lE0wozNfUIuUvZyfmvCWiRaFEmL3S8tGjIlvIhDEQbUtKplTblz
 sLamRrk0BUjMDIAnjqZkqPF/nTeskmAdvbUjKqcOQNAGBNA1SeqXnCJrAt6kKkpu+wtk
 N/ZtNTdUZESUZ/LqaTYywrlI9+xIm6j7xM9wR4XZHg9hrlrZ9khQoAKJuBYvUujyoplu
 TQ4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCiBv/3W+EmmG6EIqmGQ4VH4Oq9aBIFdLJ6WHMnNGHIDsgTdyoRkNmUgOydVqs+SynT2RQrjNRjHowGx0JDrttRcQDqhs=
X-Gm-Message-State: AOJu0Yyc5sT83fD+y6JxgbJ/3jmKUEATaAhPeH2jePUFEYTqgYzuVGNz
 g6ocEjutxJ4xZlWxNMNzCTVVjYyUV3SZQcsYyx3X6GuRLt70/GVICVuD88SqIck=
X-Google-Smtp-Source: AGHT+IGryKHGkQnS/d6VBpGqJkXdY4gxyERKQg+bXNkeXJqHhqwXjEgNqILKdBajrMgVhiLcvfykHw==
X-Received: by 2002:a5d:5046:0:b0:33c:f677:a637 with SMTP id
 h6-20020a5d5046000000b0033cf677a637mr2368460wrt.18.1708018590912; 
 Thu, 15 Feb 2024 09:36:30 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 bo24-20020a056000069800b0033b4796641asm2542149wrb.22.2024.02.15.09.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:36:30 -0800 (PST)
Message-ID: <9bca7833-66d4-4e5e-9913-94b9ed9734a2@linaro.org>
Date: Thu, 15 Feb 2024 18:36:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci/windows.yml: Don't install libusb or spice
 packages on 32-bit
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240215155009.2422335-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215155009.2422335-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 16:50, Peter Maydell wrote:
> When msys2 updated their libusb packages to libusb 1.0.27, they
> dropped support for building them for mingw32, leaving only mingw64
> packages.  This broke our CI job, as the 'pacman' package install now
> fails with:
> 
> error: target not found: mingw-w64-i686-libusb
> error: target not found: mingw-w64-i686-usbredir
> 
> (both these binary packages are from the libusb source package).
> 
> Similarly, spice is now 64-bit only:
> error: target not found: mingw-w64-i686-spice
> 
> Fix this by dropping these packages from the list we install for our
> msys2-32bit build.  We do this with a simple mechanism for the
> msys2-64bit and msys2-32bit jobs to specify a list of extra packages
> to install on top of the common ones we install for both jobs.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2160
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   .gitlab-ci.d/windows.yml | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

