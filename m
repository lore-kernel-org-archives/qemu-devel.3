Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761AFC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twltw-0001wD-1a; Mon, 24 Mar 2025 13:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twltn-0001t4-Bt
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:47:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twltk-00016h-RQ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:47:42 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227a8cdd241so13077775ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742838459; x=1743443259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EDzwtCdUAeOHNPXPCKQ1021LXsxHvlwMGYJyE6wHhRw=;
 b=pqxQ8htAnmLnzeY+Sw/YudD9qzvKm2xcPu/lE5kXwriolyt9lE9OPR8D97N/+jRMnC
 +HcGY0V3X6srCWLpBp+rGI9pN98X8V7Km10HUZgJakheLOmEQDOJ+cpyFI6g34WGze/6
 YNSS+NVLIKYJk+JAHdXS1hk9ET/mgvc2aXgiy4mOBz0BRHQ2YjbKQ5Y1Qwwyq3cRLZDY
 KnVhRWqa2zaE1vlPrqnDrje2e75ZOoILaWVsm7kvuqUj2G1j0Jx18732w1rZgjIgcLOK
 +ixmkk4cfj6duMuNAarqJQE1rSuNDqf/cQr1/cHUQzdTnLmiwVdQC+O3NDnhoHQdF/PH
 k50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742838459; x=1743443259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDzwtCdUAeOHNPXPCKQ1021LXsxHvlwMGYJyE6wHhRw=;
 b=tcIRsVFlyPPmo0dgikSrGSs0hrdF1WdtDfYpgZpKq/3gqJPQxAWOjo+sf9SdZSg+b7
 VHCrDYnxxy3QEzYEfEgDUrLgb/hFWCr6uNF7I24Bu83+/GQOni3mOFuSGwplewykjP02
 X7aSPFDR2FzDPbasfOOJUzTgSqXGeLkhfNQvMcZsF6njELDwzh5kkIxpEcTq0KtBEfZl
 0rp8KHUsDzGu9AzN5SpMZxPnPhaudvFcOOgHhCGVLLEBR7scxX5GYXjDL0x+LAFsJ08v
 dhO+ntC2X7cigqN/dUSf35Uw3gyRTT4lHWaOKOfGAez4thxSk/7Nwys0saTUsIMwzufF
 USSQ==
X-Gm-Message-State: AOJu0YyKMweiZ0KbhWoQ3a1JoFfRWxdMinWFDD2L2petxdU/zZZc+iWB
 LTz2IhGoxiuG+WO0KthVqrXM6MiYtF6D0Fc6JGFts2RuWDtP7tpfsS0sQk/broVHBzwi409wOaA
 le8A=
X-Gm-Gg: ASbGnctHI8j+hj+ap1NiSSjOmmm5ru8pp14vy/tmZTmFTW+AMC7QA95gTRO4+UlJ9sv
 EYD2AXpHayeI35T1JfjNrfI0jw0rDRCKtlqiP5YN2K0ubVQ27LB6Rdvi7aWQhKWPs4DHMVrp0Q/
 sHhayJVstTyLTebir9ilX8db3vKVs60WydVik1kMhM2Swrv6c1oryog1tyBGUlWCJEdV5LEnjH9
 leEUHdzNYxJZKzV2acC/O0aJLB45s5yHs2w1XAO4S6GG3BjQcUlNshXz5LUy5uQaxUFoRGOW2Yl
 FQ1B/zTFBzxwbhjU81/ZIzhyKj3WG1vUBB14hAcgz4ohfzqSsscpn6Gyxw==
X-Google-Smtp-Source: AGHT+IG5ww6KBOdbg75GCX1p8Q+QiL+1m7SkeRWxq20Vu/vkfsmlCGmppyzztmkuKozlvOGXAF+2XA==
X-Received: by 2002:a17:902:d489:b0:224:13a4:d61d with SMTP id
 d9443c01a7336-22780d80143mr167355605ad.23.1742838458561; 
 Mon, 24 Mar 2025 10:47:38 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f45a06sm74322995ad.69.2025.03.24.10.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 10:47:38 -0700 (PDT)
Message-ID: <b28bf347-aa8e-405e-8009-025aaf61a984@linaro.org>
Date: Mon, 24 Mar 2025 10:47:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/build-environment: enhance MSYS2 instructions
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250305213853.3685771-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250305213853.3685771-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/5/25 13:38, Pierrick Bouvier wrote:
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

Gentle ping on this trivial change for doc.

Thanks,
Pierrick

