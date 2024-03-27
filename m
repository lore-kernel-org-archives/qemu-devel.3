Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC1AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSf9-0005T2-AR; Wed, 27 Mar 2024 08:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpSf0-0005Sd-BQ
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:45:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpSey-0003kj-0f
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:45:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-341cf77b86dso2739653f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711543538; x=1712148338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pa5EiqMwGUZ2Wsz0mjSLipmSKLiWlzOkBtw7p7J9RWc=;
 b=vkxck0I1o17a3W+1pnfHN9RkpscjRE66gIDhHoO/XynwuUJBoOipNHULrHMpeFvcOE
 ytudMpEbV6Wvzh8UO4BFCNyx3YPmwSjmTJmb15S/LzNQrVxqq0FRQbQ2O70CY6kXk5VI
 TIHmIfVf2fJmmUT90adyVboMc3ULN/hZngWBt7igU7aX+i2xTLgW9nMmoeQ6NEf4HQre
 YToOX1Wl0V7fNL1mGkdt4q+p1bHDnA75QdBqN6X563qZ8S+GFZTEbVYMaCx+miMgMB/Q
 c3NnoxgTvCFxLooMzHCU1QdMM+QPhUqUS2fyw9lbr5mJxzTec3LsAXhMssiVzTKWFQ0r
 aC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711543538; x=1712148338;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pa5EiqMwGUZ2Wsz0mjSLipmSKLiWlzOkBtw7p7J9RWc=;
 b=rwDKtX4qs68FrZR0Nghh2OFDBp0eVU2WhDVldVpxmTKTtz/nm4c/rid7FPSKh4Pz94
 5q7iIhFwVZBU046W9jcACMZChkon5n0ecgrWEtP5zlvsWyUQ1iY8jCg1DzTIfZ3GXQYz
 rDJ9pyuQeK56H8ux0uL3XyipVMl/zso5Jv2NFhsd/iH+WdvzzvhtKJjR7BBtMU+wpbxA
 +KhZ9kXL8lUGkUUGFYbOFBDtnyRC1QCqDaEK9KBNCS7pg1HdIWKyyXspdRRIk5hogM+z
 rgSYAXIZbz3u3ObXLhO2kDLEmVLUrYP1Q0qr2kxv1rzWq2mX4+UoJGOC5rWB55wa/7ZJ
 rGzw==
X-Gm-Message-State: AOJu0YyElob5fUlpVIp5+5OStDW3ZCB75TKJeA6lZV4x3Er7llwtsR/v
 sTlDW1mLd5R5gQiLc+LheIm2lLwv5tP8bRjU6HyvmjJ/QZJ7wAIfYLkt1OCR5tlNtP9jiOBRQW9
 R
X-Google-Smtp-Source: AGHT+IFPQsPI7fwmoFwAW33cPEx+wWBMxsaLTKKMetgTmaxukDGbVlhSzhcV8lUyMHiAmCWYtdSuPg==
X-Received: by 2002:a5d:5088:0:b0:33e:7f51:c2fb with SMTP id
 a8-20020a5d5088000000b0033e7f51c2fbmr2444688wrt.41.1711543537884; 
 Wed, 27 Mar 2024 05:45:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 bq23-20020a5d5a17000000b00341d9e8cc62sm3659044wrb.100.2024.03.27.05.45.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 05:45:37 -0700 (PDT)
Message-ID: <7aad7197-21f3-4c0e-931c-2eb4febdf94a@linaro.org>
Date: Wed, 27 Mar 2024 13:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/nios2: Remove machines and system emulation
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 devel@lists.libvirt.org, Marek Vasut <marex@denx.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240327123554.3633-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240327123554.3633-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 27/3/24 13:35, Philippe Mathieu-Daudé wrote:
> Remove the Nios II machines and the system emulation code
> (deprecated since v8.2 in commit 9997771bc1 "target/nios2:
> Deprecate the Nios II architecture").
> 
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                               |   4 -
>   docs/about/deprecated.rst                 |   5 -
>   docs/about/emulation.rst                  |   3 -
>   docs/about/removed-features.rst           |   5 +
>   docs/system/replay.rst                    |   2 +-
>   configs/devices/nios2-softmmu/default.mak |   6 -
>   configs/targets/nios2-softmmu.mak         |   2 -
>   qapi/machine.json                         |   2 +-
>   hw/nios2/boot.h                           |  10 -
>   include/hw/intc/nios2_vic.h               |  66 ----
>   include/sysemu/arch_init.h                |   1 -
>   target/nios2/cpu-param.h                  |   6 +-
>   target/nios2/cpu.h                        |  42 ---
>   target/nios2/helper.h                     |   9 -
>   target/nios2/mmu.h                        |  52 ---
>   hw/intc/nios2_vic.c                       | 313 ------------------
>   hw/nios2/10m50_devboard.c                 | 181 -----------
>   hw/nios2/boot.c                           | 234 --------------
>   hw/nios2/generic_nommu.c                  | 101 ------
>   target/nios2/cpu.c                        | 160 +---------
>   target/nios2/helper.c                     | 371 ----------------------
>   target/nios2/mmu.c                        | 216 -------------
>   target/nios2/monitor.c                    |  35 --
>   target/nios2/nios2-semi.c                 | 230 --------------
>   target/nios2/op_helper.c                  |  45 ---
>   target/nios2/translate.c                  | 254 +--------------
>   tests/qtest/machine-none-test.c           |   1 -
>   .gitlab-ci.d/buildtest.yml                |   4 +-
>   .gitlab-ci.d/crossbuilds.yml              |   2 +-
>   hw/Kconfig                                |   1 -
>   hw/intc/Kconfig                           |   3 -
>   hw/intc/meson.build                       |   1 -
>   hw/meson.build                            |   1 -
>   hw/nios2/Kconfig                          |  13 -
>   hw/nios2/meson.build                      |   6 -
>   qemu-options.hx                           |   8 +-
>   scripts/coverity-scan/COMPONENTS.md       |   2 +-
>   target/nios2/meson.build                  |   9 -
>   tests/avocado/boot_linux_console.py       |   8 -
>   tests/avocado/replay_kernel.py            |  11 -
>   tests/tcg/nios2/Makefile.softmmu-target   |  32 --
>   tests/tcg/nios2/test-shadow-1.S           |  40 ---
>   42 files changed, 24 insertions(+), 2473 deletions(-)
>   delete mode 100644 configs/devices/nios2-softmmu/default.mak
>   delete mode 100644 configs/targets/nios2-softmmu.mak
>   delete mode 100644 hw/nios2/boot.h
>   delete mode 100644 include/hw/intc/nios2_vic.h
>   delete mode 100644 target/nios2/mmu.h
>   delete mode 100644 hw/intc/nios2_vic.c
>   delete mode 100644 hw/nios2/10m50_devboard.c
>   delete mode 100644 hw/nios2/boot.c
>   delete mode 100644 hw/nios2/generic_nommu.c
>   delete mode 100644 target/nios2/helper.c
>   delete mode 100644 target/nios2/mmu.c
>   delete mode 100644 target/nios2/monitor.c
>   delete mode 100644 target/nios2/nios2-semi.c
>   delete mode 100644 hw/nios2/Kconfig
>   delete mode 100644 hw/nios2/meson.build
>   delete mode 100644 tests/tcg/nios2/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/nios2/test-shadow-1.S


> diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
> deleted file mode 100644
> index 4748ae27b6..0000000000
> --- a/hw/nios2/Kconfig
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -config NIOS2_10M50
> -    bool
> -    select NIOS2
> -    select SERIAL
> -    select ALTERA_TIMER

I forgot to mention I deliberately chose to keep the Altera
timer model in the tree, since it looks like a re-usable
IP component.


