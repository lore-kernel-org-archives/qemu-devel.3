Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F2DD59F53
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jit-0003KT-IB; Wed, 06 Nov 2024 12:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jim-0003JO-T5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:21:34 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jij-0001rC-8A
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:21:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so607075e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730913687; x=1731518487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=juxsBPEVQ7aJzVU1ViBW3YUAQIK381nlBN01eCGHgHI=;
 b=xMidAm2fEdccZd7hNfMNAaPsk4fA8Ptt9dL+Vj0Rfq0S7ORtEeOB+X0uTN7zS0j28N
 coelC3lu0tg7pOh1ar/8fH9XrhSm4gNAJoJdGjY98gP82EUFZ1wJuHavc9Bz1Nt42GOP
 jingVo1fOpjKkto9MKDYzkNMiFdcHXdYKrbO2hh53qKbqcZDDNB0YlBikaLDm/Ku4hXP
 IkT4GWusSU5ifnGGBOfIYHdVrboeGq4C1tKV6JGcIHnKzh2BZzOL75nZoKztRgpfYWwC
 i/GUrxCJxmSeDyVcBNkLw7UI1zKtJhjh+Un0mRxoI33VPoSN1ltexFN7bavbLG7Qjd8U
 r+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730913687; x=1731518487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=juxsBPEVQ7aJzVU1ViBW3YUAQIK381nlBN01eCGHgHI=;
 b=qpYpIjteL/VnwWF9+C2TTOdvqJa0bhXLUCTyb4sZrtk0y9BKL0Za0uIOIltZWFBKk8
 BJ+n/gUMbE8YN7rCqyO13fjIQIeUM2AowdGnIOT+wqWtMlKFMf0nvDb+w8i9t4gfpQvt
 CCj8ZPT9uqnmIyXW/v2RW8MJbQQcF+PpiizIUQQ8Cw2hh5PMfKHkh/i2GQOYhCtQHQyg
 r+L3noB1CT2qN+P6T64fIqfAFvEkGMyvs1Tth9KFjMzjrpVbrkonPi44qtRoYx/xn9mG
 42oscmyLmlNq932R44DI2UnRvZSIW/iom5EzDXEHt89+uI5Q1Sa+Oeek2oG7XS4akCTT
 lbdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4km77U+U7AkfAFMkGqNqqDlb3YUWiO61mh3vtpNURyItrawVRVqnvD4QY5nSogZZN4AjeiylRLD+v@nongnu.org
X-Gm-Message-State: AOJu0YzR8HpHynZkwdevhk/S8yqbo/GvzgqsV/dNfkCSlw8yzZmwvODP
 Sua+3sOm57h1cnQPnNYLsZh5mKUJM+DxfKr2KwuBRMrO5zOmFxCCYc9cYa/T4ZM=
X-Google-Smtp-Source: AGHT+IERYbDP5tsuTCHF49iiVNQyH0DoPmXKOJU4VrJp5X+x+IKa1j5PtgMtOiP1DDK3/IjC/vLm1w==
X-Received: by 2002:a05:6000:1867:b0:37d:5318:bf0a with SMTP id
 ffacd0b85a97d-381c7a46489mr22480173f8f.1.1730913687058; 
 Wed, 06 Nov 2024 09:21:27 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116c13asm19577647f8f.109.2024.11.06.09.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:21:26 -0800 (PST)
Message-ID: <c233a6b5-bfea-4d5e-9b1f-5bc3a467e17d@linaro.org>
Date: Wed, 6 Nov 2024 09:21:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Bump timeouts of functional tests
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241106170946.990731-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241106170946.990731-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/6/24 09:09, Thomas Huth wrote:
> When building QEMU with "--enable-debug" and running the tests
> in parallel with "make -j$(nproc) check-functional", many tests are
> still timing out due to our conservative timeout settings. Bump
> the timeouts of the problematic tests and also increase the default
> timeout to 90 seconds (from 60 seconds) to be on the safe side.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index d5296bff8b..3561f987a6 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -11,24 +11,26 @@ endif
>   
>   # Timeouts for individual tests that can be slow e.g. with debugging enabled
>   test_timeouts = {
> -  'aarch64_raspi4' : 120,
> +  'aarch64_raspi4' : 480,
>     'aarch64_sbsaref' : 600,
> -  'aarch64_virt' : 360,
> -  'acpi_bits' : 240,
> +  'aarch64_virt' : 720,
> +  'acpi_bits' : 420,
>     'arm_aspeed' : 600,
> -  'arm_bpim2u' : 360,
> +  'arm_bpim2u' : 500,
> +  'arm_collie' : 180,
>     'arm_orangepi' : 540,
>     'arm_raspi2' : 120,
> -  'arm_tuxrun' : 120,
> +  'arm_tuxrun' : 240,
>     'arm_sx1' : 360,
>     'mips_malta' : 120,
>     'netdev_ethtool' : 180,
>     'ppc_40p' : 240,
>     'ppc64_hv' : 1000,
> -  'ppc64_powernv' : 240,
> -  'ppc64_pseries' : 240,
> -  'ppc64_tuxrun' : 240,
> -  's390x_ccw_virtio' : 240,
> +  'ppc64_powernv' : 480,
> +  'ppc64_pseries' : 480,
> +  'ppc64_tuxrun' : 420,
> +  'riscv64_tuxrun' : 120,
> +  's390x_ccw_virtio' : 420,
>   }
>   
>   tests_generic_system = [
> @@ -273,8 +275,8 @@ foreach speed : ['quick', 'thorough']
>              env: test_env,
>              args: [testpath],
>              protocol: 'tap',
> -           timeout: test_timeouts.get(test, 60),
> -           priority: test_timeouts.get(test, 60),
> +           timeout: test_timeouts.get(test, 90),
> +           priority: test_timeouts.get(test, 90),
>              suite: suites)
>       endforeach
>     endforeach

I noticed by --enable-debug in configure is a combination of enabling 
checks (enable-debug-tcg + graph + mutex), and deactivating optimizations.

Would it be worth keeping the optimizations and runtime checks instead? 
This way, there would be no more "timeout" issue.

I'm not sure which added value we get from O0, except for debugging 
locally QEMU.

