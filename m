Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77782CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOP1-00067w-5P; Mon, 27 Oct 2025 10:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDOOx-00066x-DK
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:40:51 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDOOt-0007x3-Kx
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:40:51 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63e1b52b452so5027883d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761576045; x=1762180845; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Trod9v55k6w6Mk9dF7UXohUyL601Ds22d68awWQOuWc=;
 b=xPj0BCRTlKz5iLBBq2vUeF3041QSiri5MlkPlb7BY/oREqnmBnPxlZh0Q7LiRN3+u3
 VtssEfDYtVU1T8JgzzsN+lUCAd2QrUIST+TeE8v0AbEaTlzZJYEfE1MjtvzE4VX/OFuC
 z6DTitTBXBzv327/3R597dsBP3YAYiqPsaSsH8wVsB9X+KGmRu/DqHrSjOpGDjvF/8TW
 AZUI3jlYcb0rWyjmogYMs2sD6ndTbXWSwqEMuWXh9oVQP7J27/bVvAyuw3TBkUREW73g
 9pNyC9C+1GIgVJ/QETfSR/Sw9lH3K/S7B6lZ0WFqe+ghc0DKHHubU7dJ2U6o6vJAM4g3
 zW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761576045; x=1762180845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Trod9v55k6w6Mk9dF7UXohUyL601Ds22d68awWQOuWc=;
 b=doARFW8xMEyY+5pVpJQcFbn4cyw8aLVmb3Fq8fCR/ssNXssG4S/scvjENuHUyDupTZ
 TWCo9ki/Q2hhmhO5zjFsXFt/OBvmdYfoHondRfMw0v+75ZYpykkn+54iuAW/ecURo8BS
 HduM+umjqEjKRjyEUl2pUs5OJJNpunocU/TKLae4nPw4lKFyitclmVk5LsYiQiqxN7bQ
 twNTh5H5bogc2QZT7Jv59yOemC7qoIsrZVqFSwletQ3GTiCskB+T4t5fyOGH2sKMH0nn
 ZiW6Rd3FggH8l7gZr57alx9AVqHG8AQI+l4hpDSyGTckYeuWlnt9gWcHvgD9d6Le9nFC
 mZdQ==
X-Gm-Message-State: AOJu0Yytn5bGUHuUZtL0mxFvT2QjSE0bBRGFZXJ3RbDkGbULn8nuDueP
 crlu2PhmrOyKsgAifU4PmVKU9RDBuoBQrAfiFaUjbbodSMFpUa4hA5QybBD1YV1YDcoMwwfo0kJ
 DCeYZHotrS1DQsDb3H+5nQsBzm/STbRTe9SBg3Ka21w==
X-Gm-Gg: ASbGnct4APRGdJqdIpWtJJ2f98yhthQqZmV75U45IlFN27BF8mouLaM+pUVnPx82zc8
 WZ8daXHqyzw1Hm6AJ8ojDk/9rBzUj4ZytXxQYa+IgnXwilxD3sLuuR+P11FsRefDOxKkx5GNaX9
 3E4MQYk1LkFJa+beveqqHx76uXz+cByaH7t4RGHaMi4ZJUxDyroqK6R2+XzzabzDBLALdWZtUcZ
 2sO960F8/pajtULX8WTb1eF3NIcepFFK+7vbVy6O63+aRSNL2FG+2MCf5VHog==
X-Google-Smtp-Source: AGHT+IGj9374Ut/ieMSHqhTdieWODgaqXopd3qHFsnXgVQXAk5h8o40BF9RyoC2xXq/egWYvaWwK3FoXTRO3Oqj6mzg=
X-Received: by 2002:a05:690e:1652:b0:63d:bfd0:5032 with SMTP id
 956f58d0204a3-63f6ba7683dmr206769d50.51.1761576044683; Mon, 27 Oct 2025
 07:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251026105320.5591-1-fanyihao@rt-thread.org>
In-Reply-To: <20251026105320.5591-1-fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 14:40:33 +0000
X-Gm-Features: AWmQ_bn-agDSKLx-cyEdJCkoKz7gNbMVXF6eWh43e5HWmZCyXQSyGuLukIcPRTk
Message-ID: <CAFEAcA8LqGY3sU4wjogDAs9F5OY_ePWwcUZ74p=1=zFcTFWb=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] hw/arm Add STM32F4 support and PWR device model
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Sun, 26 Oct 2025 at 10:53, <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> This patch series introduces basic support for the STM32F407 SoC and
> a new STM32F4spark machine in QEMU, along with a PWR device model.
>
> In addition, I have modified the header file referenced by the RCC
> driver to STM32RCC in accordance with the suggestions.
>
> This series includes:
> - A new SoC model (STM32F407) with initial integration.
> - A board model called STM32F4spark to instantiate and test the SoC.
> - A PWR device implementation for STM32F4xx family.
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
> ---
>
> Yihao Fan (3):
>   hw/arm: Add support for the STM32F407 SoC
>   hw/arm: Add support for the STM32F407-RT-SPARk board
>   hw/arm/stm32f407: Add PWR device to stm32f407 SoC
>
>  MAINTAINERS                            |  14 ++
>  docs/system/arm/STM32F407-RT-SPARK.rst |  41 +++++
>  docs/system/arm/stm32.rst              |   2 +
>  docs/system/target-arm.rst             |   1 +
>  hw/arm/Kconfig                         |  13 ++
>  hw/arm/meson.build                     |   2 +
>  hw/arm/stm32f407_soc.c                 | 217 +++++++++++++++++++++++++
>  hw/arm/stm32f4spark.c                  |  56 +++++++
>  hw/misc/Kconfig                        |   3 +
>  hw/misc/meson.build                    |   1 +
>  hw/misc/stm32f4xx_pwr.c                | 111 +++++++++++++
>  include/hw/arm/stm32f407_soc.h         |  77 +++++++++
>  include/hw/misc/stm32f4xx_pwr.h        |  40 +++++
>  13 files changed, 578 insertions(+)
>  create mode 100644 docs/system/arm/STM32F407-RT-SPARK.rst
>  create mode 100644 hw/arm/stm32f407_soc.c
>  create mode 100644 hw/arm/stm32f4spark.c
>  create mode 100644 hw/misc/stm32f4xx_pwr.c
>  create mode 100644 include/hw/arm/stm32f407_soc.h
>  create mode 100644 include/hw/misc/stm32f4xx_pwr.h

Thanks for sending this; I have some review comments,
but they're mostly fairly minor.

Please can you include a functional test under
tests/functional/arm/ which runs the new board model
with some kind of guest image to check that it can
successfully run code ?

thanks
-- PMM

