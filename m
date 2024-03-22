Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1304C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnheG-0007qG-BE; Fri, 22 Mar 2024 12:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhe0-0007py-Js
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:21:24 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhdy-0002Fg-3E
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:21:23 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56be2220f7bso1020041a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711124480; x=1711729280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rMhJ1iAzlXYrGjQfcKV79irbPCrGV9GOT4bz+JgNQG8=;
 b=LqHYCzXaE22do7rI16pc02cXn9PdQneToTQcU2zur/Jpdv5cDqWARnbMAJJg0lINOA
 1Gv2/QFc8yC4p+Lv6z+G7VZILRPwdxKduY5dNc0HFsdv3NiAv+ut6Sjg+EY98MAW8I/w
 oPa6cjlhvtUCpD8UO9Ow+edwQaHxaddLBmeVP6Vn0FaHN/qc74ei/5ZdBBX8HBlOIvr1
 PMJbp2Pm237Vws8lnq1NmmyzMYzVc8YPmCmVhV1edhfC9bml+oIQQXMSCrYsmF05WCOz
 tV2xTVY+VguIIfakCgrnN3o4NWsP9eGkzSDv/SLzG/6uAHsAuuwMTkucbGM98ZtNFkxa
 u+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124480; x=1711729280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMhJ1iAzlXYrGjQfcKV79irbPCrGV9GOT4bz+JgNQG8=;
 b=a4t5tcNInOshKL9ZkKUCzoFU8Sfh0ahqZaycbG6/tbpnsuQkBtPn2mkEndO36l55sH
 AoHG2q5upIXwjDakLVkpPfU5phTBSCbThasMy0Eal2PK3qtZl6AwHWvBwVbeZWGFqGy9
 4fx7zRZ807d8HKj7OH/EPCTaq0tve1a8sqynl5LgcP4gzHUjqdOVBCpbi49mUmAyAu//
 79DDVQ1tS3pfMSTmET7UXW8yT1OI5xHSNIMOqdpbbAUMjEqS/cqxHfe4MKAasA8gnBVZ
 QrUQM1wkGHpE0yY3x5C2Xm24fzWCTIaSjWXFz0ftvAhYHPetyNhKwsDzC3wZbizxfga5
 ihuA==
X-Gm-Message-State: AOJu0YyzCSQe41ShJ9w7BVt/9Qus2t+q2gx6Y751vY4Q0E4NrVoFssso
 NaNeD2hsAd6G1eDlLG1tmqABBJ1fbkz6g2ZyOLHR6SshfGl7cK8x3qF+znKikaU0gc86ABJmuVo
 Y/81uYrvrFfcB+oGO2ZrXp6YE763Wul9pgy91IYwFszI76lP6
X-Google-Smtp-Source: AGHT+IEVK2Ccx1OS4kmmqUSDxpoiWCQYrAKTG7n1m+Irb8/q5hqzJEezPsxH/LQ3AOHy/WEM/Esx60nowrLEc/3vdx0=
X-Received: by 2002:a50:d748:0:b0:56b:d9b6:3911 with SMTP id
 i8-20020a50d748000000b0056bd9b63911mr1851462edj.35.1711124480510; Fri, 22 Mar
 2024 09:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240320202100.820228-1-balbi@kernel.org>
 <20240320202100.820228-3-balbi@kernel.org>
In-Reply-To: <20240320202100.820228-3-balbi@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 16:21:09 +0000
Message-ID: <CAFEAcA9OCbP8FVS4HhZ2XtxTy=WCxMHinJVvqWOVfTw1oGfeNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/arm: Add nucleo-g071rb board
To: Felipe Balbi <balbi@kernel.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 20 Mar 2024 at 20:21, Felipe Balbi <balbi@kernel.org> wrote:
>
> This board is based around STM32G071RB SoC, a Cortex-M0 based
> device. More information can be found at:
>
> https://www.st.com/en/product/nucleo-g071rb.html

Could you put this URL in a comment in the source file too, please?

>
> Signed-off-by: Felipe Balbi <balbi@kernel.org>
> ---
>
> Changes since v1:
>
>     - Convert tabs to spaces (checkpatch.pl)
>
>  MAINTAINERS            |  6 ++++
>  hw/arm/Kconfig         |  6 ++++
>  hw/arm/meson.build     |  1 +
>  hw/arm/nucleo-g071rb.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 hw/arm/nucleo-g071rb.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bce2eb3ad70b..052ce4dcfb97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1116,6 +1116,12 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/netduinoplus2.c
>
> +Nucleo G071RB
> +M: Felipe Balbi <balbi@kernel.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/nucleo-g071rb.c
> +
>  Olimex STM32 H405
>  M: Felipe Balbi <balbi@kernel.org>
>  L: qemu-arm@nongnu.org
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 28a46d2b1ad3..5938bb8208a1 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -310,6 +310,12 @@ config STM32VLDISCOVERY
>      depends on TCG && ARM
>      select STM32F100_SOC
>
> +config NUCLEO_G071RB
> +    bool
> +    default y
> +    depends on TCG && ARM
> +    select STM32G000_SOC
> +
>  config STRONGARM
>      bool
>      select PXA2XX
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 9c4137a988e1..580c2d55fc3f 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -18,6 +18,7 @@ arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
>  arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
>  arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
>  arm_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
> +arm_ss.add(when: 'CONFIG_NUCLEO_G071RB', if_true: files('nucleo-g071rb.c'))
>  arm_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
>  arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
>
> diff --git a/hw/arm/nucleo-g071rb.c b/hw/arm/nucleo-g071rb.c
> new file mode 100644
> index 000000000000..580b52bacf2c
> --- /dev/null
> +++ b/hw/arm/nucleo-g071rb.c
> @@ -0,0 +1,70 @@
> +/*
> + * ST Nucleo G071RB
> + *
> + * Copyright (c) 2024 Felipe Balbi <felipe@balbi.sh>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
> +#include "qemu/error-report.h"
> +#include "hw/arm/stm32g000_soc.h"
> +#include "hw/arm/boot.h"
> +
> +/* nucleo_g071rb implementation is derived from olimex-stm32-h405.c */
> +
> +/* Main SYSCLK frequency in Hz (48MHz) */
> +#define SYSCLK_FRQ 48000000ULL
> +
> +static void nucleo_g071rb_init(MachineState *machine)
> +{
> +    DeviceState *dev;
> +    Clock *sysclk;
> +
> +    /* This clock doesn't need migration because it is fixed-frequency */
> +    sysclk = clock_new(OBJECT(machine), "SYSCLK");
> +    clock_set_hz(sysclk, SYSCLK_FRQ);
> +
> +    dev = qdev_new(TYPE_STM32G000_SOC);
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
> +    qdev_connect_clock_in(dev, "sysclk", sysclk);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu),
> +                       machine->kernel_filename,
> +                       0, FLASH_SIZE);
> +}
> +
> +static void nucleo_g071rb_machine_init(MachineClass *mc)
> +{
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-m0"),
> +        NULL
> +    };
> +
> +    mc->desc = "ST Nucleo-G071RB (Cortex-M0)";
> +    mc->init = nucleo_g071rb_init;
> +    mc->valid_cpu_types = valid_cpu_types;
> +}

Like the olimex code, the SoC here allocates the SRAM in the
SoC instantiation, so I think we should set
mc->default_ram_size = 0 the same way that code does.

Otherwise this looks good.

thanks
-- PMM

