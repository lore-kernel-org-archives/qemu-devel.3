Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9441E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHWM-0005bs-B6; Fri, 10 Jan 2025 11:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHWH-0005R5-VI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:05:58 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHWF-0004vs-2X
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:05:57 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso2270673f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736525153; x=1737129953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w4HO32OyKgE9d8qEFBdltfZE1NtRQ8nlFnmeJTnk3IQ=;
 b=aCW7AyQ5BcWFG3yiEueEteDb3P5liJriNabw/VbuO0ifF6M/Ja2E3xaPsYJ6wNt/ru
 LQpoMELAF0OXpaOO7uFdCcXSx5UYEXJjQUVIpV+VQk4dCj+Edtc6KTgcCK1UQgi3IFTy
 tn+nuwdrjbQ0SKWATk393n8MPfkOKKMInHFtX5k94GUN+8wDesLHw0wkN5sTKwjN3yZA
 8yCg1J68KNZVjfwwIfdh/CloFGLI4VKf0h7Q1PHyvKZl93K9LkvEsh6AxD68AwXvqJZA
 hZZZ66Y8UQLvxyYXQzEyn5KzIeSnd5Zqfs/AVtfVyqIJ5ZSyTAhAQGeFoKrgeYzHARKu
 +gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525153; x=1737129953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w4HO32OyKgE9d8qEFBdltfZE1NtRQ8nlFnmeJTnk3IQ=;
 b=nl3qyPpfk6XZYT7zrh6O6IecjsufoOkDwG2jcL9561mMNt+fz5zHkql4EXi3hgCzik
 NJevmf4ftQQlWHRHW1RsRMA5sF0MBloaTENVdrm+jyUTNMeJBwr7HknQp3xHKUkh73Um
 ysuIdWT7vQ6O7AH0rbkSbgtIw4nLbrDRCksmXzlfNPks8xQ8FOKO+WrlGQnZ59OnxaCO
 92vWym48WBu+RggK5lhHj5QQh8WdT1gGFQcipti2ivw9OVRFs/Ma9Cd71hVR0KwuzhdY
 eTE4vcZYczCaAdYlckaPzs1PgMX19NQBkQl8LUGb9nmIoO9ytxuvLFoMHuKZH5JD2xzn
 eVnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnV9Fvllli4S3RXYQItHnekHEEC0/gVmTojm0QRSr5oHyFIZpErV0y1s2Q2EH2WJG5PHrxUD+PtNg1@nongnu.org
X-Gm-Message-State: AOJu0Yxt14Q8A9oe7iHcUKCFBozFksN6ODZuQHs6u1Uj5BWAkYaxiuFH
 enXNEAlg2l0KHa0KpxOQOwao4V9VUoEnAXq4sodcTIbB7zhyhOB3qIQ9QSP4XKw=
X-Gm-Gg: ASbGncuxD4kf5epjThIArXDC/7vwhI7/GD/OBwJkSwlrw4mb4OrrGlBmthE4Ph5sUvz
 ZuYmlA4m6xjY5to3GuQFvu/MFIOkvajYQUFx2sEYL3TKTlH7FFut70b82BC8D+bd3vHY5xOKPMv
 6XoIqJMLF8Qnpenw8PmaA8cJwKJssdnfAw4b+CqjxAU7LylYyULr9V5XkG6zv/7Z+jjHINkTC7z
 dIe6CO5CyFAC0Ze50G45BAEk92sQ81xyP7YFt8QrrcpH4VHOLNwwN/UTi6A3vU08PYb7OnC4K3o
 JT38AS4jUKQVwcNgbpFvXOlr
X-Google-Smtp-Source: AGHT+IHeP2IWTj1CjGTz4xVtOz4BdCIW23IB5fLeNVi4cHCSdJx4XiSQKPHXQWk3evJsfy6oBoiODw==
X-Received: by 2002:a5d:47c9:0:b0:385:f66a:4271 with SMTP id
 ffacd0b85a97d-38a872fbcefmr9128638f8f.4.1736525152832; 
 Fri, 10 Jan 2025 08:05:52 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8124sm4832170f8f.81.2025.01.10.08.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 08:05:52 -0800 (PST)
Message-ID: <84effbe4-085b-4e6c-9fc9-5d44cba49c82@linaro.org>
Date: Fri, 10 Jan 2025 17:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ppc/ppc405: Remove boards
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-3-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110141800.1587589-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 10/1/25 15:17, Cédric Le Goater wrote:
> The ref405ep machine is the only PPC 405 machine. Drop all support by
> removing the SoC and associated devices as-well as the machine.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS                     |    6 -
>   docs/about/deprecated.rst       |    8 -
>   docs/about/removed-features.rst |    7 +
>   docs/system/ppc/embedded.rst    |    1 -
>   hw/ppc/ppc405.h                 |  186 -----
>   hw/ppc/ppc405_boards.c          |  520 -------------
>   hw/ppc/ppc405_uc.c              | 1216 -------------------------------
>   hw/ppc/Kconfig                  |    9 -
>   hw/ppc/meson.build              |    3 -
>   9 files changed, 7 insertions(+), 1949 deletions(-)
>   delete mode 100644 hw/ppc/ppc405.h
>   delete mode 100644 hw/ppc/ppc405_boards.c
>   delete mode 100644 hw/ppc/ppc405_uc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2101b5121756..dc48ec4ac081 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1387,12 +1387,6 @@ F: hw/openrisc/openrisc_sim.c
>   
>   PowerPC Machines
>   ----------------
> -405 (ref405ep)
> -L: qemu-ppc@nongnu.org
> -S: Orphan
> -F: hw/ppc/ppc405*
> -F: tests/functional/test_ppc_405.py

Ah here we go :) This line belong to the previous patch (nitpicking...)


