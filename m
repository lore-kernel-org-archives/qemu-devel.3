Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41D7CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umybV-0001Qn-4N; Fri, 15 Aug 2025 13:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umybT-0001Pt-0Y
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:52:35 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umybR-0006Yd-6o
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:52:34 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e9321ed5e5eso1436290276.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755280352; x=1755885152; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fi7shiYLvJG0+/qUk2deweHPZvlFGqQeZ4n9FR5jQNU=;
 b=TgBzBiQwqlJOla2G5Nb/Hx1/Aeg8vhgLpo0vZ68/UMMKKrtaEgYEszpCVIlmzut/Nc
 2I6cW4IJ59rktyrbogbe+RLdKMV0lUvmuaD00I8V6m4F0z+wP9ps0FaUZvXdatSuHxpx
 TZaN2u20dMe4r/exesyAEXKjzRMVU05rq990D/x0Y7uXHXtp4BYT7NWDlThzQyf5P0xo
 rsGkcAbuNVmFIaCl3jTDvt6+4tJNbtq7Q5WFK1imdl5lMVd4LJmWJpla7fGk4ZvdwSpA
 Z5c+uSRfQuLGXrZMS4cOTmJ4rf4bhsbStKdyxTBFS90a7HgMr6FYaAzUt6VYsayJEoG3
 d91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755280352; x=1755885152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fi7shiYLvJG0+/qUk2deweHPZvlFGqQeZ4n9FR5jQNU=;
 b=ehKpjbr27IPPFV9cYsRs7vjlBYvBC5GxljSHOV3tD3Eg4qFyl1tCgZ+LaAt7pctmul
 xvHlUyiz433UGOqCao3wH3cyIhsktqVKT5uUyy1jaGe2hkSIX63TSKhxrudwx48gL/ql
 INiYKtWMRLjWUSAhxFI4n4C7qN6UTR7SP8v9E6dd/9GHVKMewoO9AChkQDI7JhFrfJ2N
 6rc+tRe3SnYcO4njDHlWwAuXlEyr1wf4zksq5qWdcE2ByhibRj031hNf/WtaFSPpl8JM
 psLAt3CfD8lIzYyDjDiuj0+A+Rf84oAT9pfrX0CpR5MX85eesy2cMOU4iSSqkdbeDWuX
 J8/Q==
X-Gm-Message-State: AOJu0YwPpTo9Q6Cz7Vqnad29WDKa+N6tbItfP5597WeqVzolkHHR5YcH
 exEGcqB4b4/oIEjMrcsx72IoRW57ibU4e7sxMTVx04xTPFUPJ1mxuI38HMo66VDMGzpSvGjrJHR
 oicy0a/SQxg3MMah9vPwEJyfLEZ1JgyViNzowlvRkCQ==
X-Gm-Gg: ASbGncvQQuwa/d2T8Z70deda6iH7IO38E5+k2V0PURnJ9pOMy1ZiWXiI4VWz5oqn8If
 R7ndh/N7A/1WJw8XXWrzFI7WHBmcTpL9/acZYO7cuMPLhplNDZIjAhfJO56KM5vsPpU/4T/1VL9
 Dll7FqIsVyu5E0lF3prIJsv4XcQrcJBpZf60xUYh4fy6AgdIyeQOhcwe/k7NxmAzyi6YAJ/xwaw
 3sKFh8yk4Sujv/MOss=
X-Google-Smtp-Source: AGHT+IFjpl6m1jaIeHTjlF56vf6akmXx7NzDGQ74+Z6jKG/7KN881ftEHOTe6qYrzyWWrD2mdeJGNKSivbStXQ1FRoc=
X-Received: by 2002:a05:6902:2304:b0:e8f:e24f:b80e with SMTP id
 3f1490d57ef6-e93323c3a84mr3943233276.11.1755280351604; Fri, 15 Aug 2025
 10:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
 <20250721201134.13270-3-fanyihao@rt-thread.org>
In-Reply-To: <20250721201134.13270-3-fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 18:52:19 +0100
X-Gm-Features: Ac12FXxq-hLO9e9NM3tVNqpznv2BSycgPK4I8QXflJSo2Jm7nbSEymDoYyIOUL8
Message-ID: <CAFEAcA_BGuq5Eqwz6sX7STzsgY1jVOQ=hFyb6gQBvdT3vpTuQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Add the STM32F4spark Machine
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 21 Jul 2025 at 21:11, <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> Add the STM32F4spark machine model using the STM32F407 SoC.
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
> ---
>  MAINTAINERS           |  7 +++++++
>  hw/arm/Kconfig        |  6 ++++++
>  hw/arm/meson.build    |  1 +
>  hw/arm/stm32f4spark.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+)
>  create mode 100644 hw/arm/stm32f4spark.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2744639a8b..0dc7c7bf60 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1030,6 +1030,13 @@ S: Maintained
>  F: hw/arm/stm32vldiscovery.c
>  F: docs/system/arm/stm32.rst
>
> +STM32F4SPARK
> +M: yanl1229 <yanl1229@rt-thread.org>
> +M: Yihao Fan <fanyihao@rt-thread.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/stm32f4spark.c
> +
>  Versatile Express
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4b2f71e6e1..3706a65286 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -234,6 +234,12 @@ config STM32VLDISCOVERY
>      depends on TCG && ARM
>      select STM32F100_SOC
>
> +config STM32F4SPARK
> +    bool
> +    default y
> +    depends on TCG && ARM
> +    select STM32F407_SOC
> +
>  config STRONGARM
>      bool
>      select PXA2XX_TIMER
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 31621060ba..ec63ed7373 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -17,6 +17,7 @@ arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
>  arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
>  arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
>  arm_common_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
> +arm_common_ss.add(when: 'CONFIG_STM32F4SPARK', if_true: files('stm32f4spark.c'))
>  arm_common_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
>  arm_common_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
>
> diff --git a/hw/arm/stm32f4spark.c b/hw/arm/stm32f4spark.c
> new file mode 100644
> index 0000000000..e1d656a3f9
> --- /dev/null
> +++ b/hw/arm/stm32f4spark.c
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

Generally files should have something more than just the SPDX
tag in their opening comment. Usually that is a statement
of what the file contains. This is also a good place to put
a URL to the datasheet/reference manual/etc for the hardware
being modelled.

Otherwise this patch looks OK.

-- PMM

