Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C42FE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSbC-00058A-Pu; Thu, 02 Jan 2025 16:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSbB-00057O-Dv
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:19:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSb9-0001SJ-HH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:19:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso85274775e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852758; x=1736457558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i1ZcgPnc2DbftHTzEgtZO7UVTGqA9C9MsQudp7PLdI8=;
 b=TuEWCv3y56qW9uhV5PreJEgZmLYN4jJ9SUXYvMDNCNfC84KQyJ6LzA0i7VxYeKuWyr
 yuvbjzgMHmK/60EBdmuYkLI5yZysGSBPjVf55Afgdyn63rho1D7Poeg7NAQqkNJi+BCN
 yONsS9u859VgzSBLpIkGAd6PFDFcx8yFWe7WIy01+kOYftRMC1D8O2k1Hn20ORMzaP9e
 DkrDsQPpS04QStveGK9ywq/1wLNFCNLE1EF4OdTw2C6NjUB7b85JhW6GudjyzVrMLMPS
 NjrfalY76DL58QJoBLlUlo2UMBjoQIJ62FU5W+d5TFXH59FxJx1pKVL8f9Iv1KO5o0JI
 KsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852758; x=1736457558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1ZcgPnc2DbftHTzEgtZO7UVTGqA9C9MsQudp7PLdI8=;
 b=X7dkbw8L04v94bLROhMkeKF5o3Ugr/iQPE613VNvGh6P5MqI4PknYy8t5hVBBkCPWr
 aC26R58akzSdHt2zpG2EFCO1PssF5ku7KEJOgbqEaQfS6CAwtTLEnR96Ssi9JiOvLK30
 rkQHVfH/3ELHyAlJRFjyd1oLMmPSeAAf5nOCZlRTtCl0rjJ18G8bb+V+gCLNg9dmcPpo
 BphfQ4DyBmrIK9tvh/kcgUw2UUvYiVM99ZwyPZxmMsScRETKsCyL5Mq8GQ8m7mQ8gebd
 Inc+PD8A337llrMzoZDwzq4HivblsH0NmexQU63MRTsuWhkSvB+6O+nw0hcY786B+ChS
 4HOw==
X-Gm-Message-State: AOJu0Yxne8Klo4EIm7i8K8d/14c1mzoWgS5Fqq6C6QBb7HUflAU/6MjL
 c+/6ROn35areU84deoVYqLufrhEz9sVlFJHYf9lgwJ0XBPIWMDRdi8LVFp4nG2M=
X-Gm-Gg: ASbGncvMuSPZowTkdLyetRhNboTdCQV5G1nZnzG1gLoMwhXu2a6wIZ1NWmZB4D9E1d6
 zVYi9f93GX/xLNOJs8wIWhzaHD93QfTXjcUOOcO0siaWqEqZONWj93Pv+0GwfQEt4z6hVXgVpzb
 zg+JJ+Dnyr84+ZX6/CPb8HUE/c9pWvM0Um4MkK/MXgJg7KsPR9uuR6ylfcWvA7cPrDQHdbY4Z6/
 dp+SxePPquiAnpiua1qt5mztMt889w/Lu7ROmXx7glxV9Eant93UYIInCX2fXAJz4fRWq7QCbCZ
 Nn5IbXZvDVqHL80ylu3NfWon
X-Google-Smtp-Source: AGHT+IEZ3+i6JbwCFZItJtgvGo+xwad4DZQMFlGg2JpYjGMylJbdplD/8wvlJGUXgGVRGQOQupm0DA==
X-Received: by 2002:a05:6000:144f:b0:385:f271:a22c with SMTP id
 ffacd0b85a97d-38a2240e20bmr42894032f8f.59.1735852758161; 
 Thu, 02 Jan 2025 13:19:18 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c846ca4sm39720331f8f.43.2025.01.02.13.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 13:19:17 -0800 (PST)
Message-ID: <eadd6b9b-3832-434a-a0c5-1b42e1ab6d08@linaro.org>
Date: Thu, 2 Jan 2025 22:19:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/29] hw/misc/ivshmem-flat: Add ivshmem-flat device
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241231202228.28819-1-philmd@linaro.org>
 <20241231202228.28819-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241231202228.28819-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Gustavo,

On 31/12/24 21:22, Philippe Mathieu-Daudé wrote:
> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Add a new device, ivshmem-flat, which is similar to the ivshmem PCI but
> does not require a PCI bus. It's meant to be used on machines like those
> with Cortex-M MCUs, which usually lack a PCI/PCIe bus, e.g. lm3s6965evb
> and mps2-an385.
> 
> The device currently only supports the sysbus bus.
> 
> The new device, just like the ivshmem PCI device, supports both peer
> notification via hardware interrupts and shared memory.
> 
> The device shared memory size can be set using the 'shmem-size' option
> and it defaults to 4 MiB, which is the default size of shmem allocated
> by the ivshmem server.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1134
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> [PMD: Rebased updating Property and using DEFINE_TYPES macro]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20241216141818.111255-2-gustavo.romero@linaro.org>
> ---
>   docs/system/device-emulation.rst     |   1 +
>   docs/system/devices/ivshmem-flat.rst |  33 ++
>   include/hw/misc/ivshmem-flat.h       |  85 +++++
>   hw/misc/ivshmem-flat.c               | 459 +++++++++++++++++++++++++++
>   hw/misc/Kconfig                      |   5 +
>   hw/misc/meson.build                  |   2 +
>   hw/misc/trace-events                 |  16 +
>   7 files changed, 601 insertions(+)
>   create mode 100644 docs/system/devices/ivshmem-flat.rst
>   create mode 100644 include/hw/misc/ivshmem-flat.h
>   create mode 100644 hw/misc/ivshmem-flat.c


> diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
> new file mode 100644
> index 00000000000..33fc9425d20
> --- /dev/null
> +++ b/hw/misc/ivshmem-flat.c
> @@ -0,0 +1,459 @@
> +/*
> + * Inter-VM Shared Memory Flat Device
> + *
> + * SPDX-FileCopyrightText: 2023 Linaro Ltd.
> + * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties-system.h"
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"
> +#include "exec/address-spaces.h"
> +#include "trace.h"
> +
> +#include "hw/misc/ivshmem-flat.h"
> +
> +static int64_t ivshmem_flat_recv_msg(IvshmemFTState *s, int *pfd)
> +{
> +    int64_t msg;
> +    int n, ret;
> +
> +    n = 0;
> +    do {
> +        ret = qemu_chr_fe_read_all(&s->server_chr, (uint8_t *)&msg + n,
> +                                   sizeof(msg) - n);

Coverity reported:

 >>>     CID 1586089:  Insecure data handling  (INTEGER_OVERFLOW)
 >>>     "8UL - n", which might have underflowed, is passed to 
"qemu_chr_fe_read_all(&s->server_chr, (uint8_t *)&msg + n, 8UL - n)".

Could you have a look?

> +        if (ret < 0) {
> +            if (ret == -EINTR) {
> +                continue;

Also as a future cleanup consider using the RETRY_ON_EINTR macro.

> +            }
> +            exit(1);
> +        }
> +        n += ret;
> +    } while (n < sizeof(msg));
> +
> +    if (pfd) {
> +        *pfd = qemu_chr_fe_get_msgfd(&s->server_chr);
> +    }
> +    return le64_to_cpu(msg);
> +}

Thanks!

Phil.

