Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22273C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 06:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR3Yb-0003a4-2U; Mon, 16 Jun 2025 02:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=g70R=Y7=kaod.org=clg@ozlabs.org>)
 id 1uR3Y0-0003RA-TH; Mon, 16 Jun 2025 02:42:24 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=g70R=Y7=kaod.org=clg@ozlabs.org>)
 id 1uR3Xx-0005jL-Ph; Mon, 16 Jun 2025 02:42:24 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bLL5g4MqTz4wxx;
 Mon, 16 Jun 2025 16:42:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bLL5c1Q5Qz4wbd;
 Mon, 16 Jun 2025 16:42:11 +1000 (AEST)
Message-ID: <ab6caa9e-5017-4bf1-a50e-9337cda92959@kaod.org>
Date: Mon, 16 Jun 2025 08:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] hw/misc/aspeed_i3c: Move to i3c directory
To: Joe Komlodi <komlodi@google.com>, qemu-devel@nongnu.org
Cc: venture@google.com, peter.maydell@linaro.org, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au,
 joel@jms.id.au, qemu-arm@nongnu.org
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-2-komlodi@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250613000411.1516521-2-komlodi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=g70R=Y7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.097, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/13/25 02:03, Joe Komlodi wrote:
> Moves the Aspeed I3C model and traces into hw/i3c and creates I3C build
> files.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

> Reviewed-by: Patrick Venture <venture@google.com>
> Reviewed-by: Titus Rwantare <titusr@google.com>

Internal reviews are not of much value. It's better to send without
these tags and restart the assessment on the public mailing lists.


Thanks,

C.




> ---
>   hw/Kconfig                            | 1 +
>   hw/arm/Kconfig                        | 1 +
>   hw/i3c/Kconfig                        | 2 ++
>   hw/{misc => i3c}/aspeed_i3c.c         | 2 +-
>   hw/i3c/meson.build                    | 3 +++
>   hw/i3c/trace-events                   | 7 +++++++
>   hw/i3c/trace.h                        | 2 ++
>   hw/meson.build                        | 1 +
>   hw/misc/meson.build                   | 1 -
>   hw/misc/trace-events                  | 6 ------
>   include/hw/arm/aspeed_soc.h           | 2 +-
>   include/hw/{misc => i3c}/aspeed_i3c.h | 0
>   meson.build                           | 1 +
>   13 files changed, 20 insertions(+), 9 deletions(-)
>   create mode 100644 hw/i3c/Kconfig
>   rename hw/{misc => i3c}/aspeed_i3c.c (99%)
>   create mode 100644 hw/i3c/meson.build
>   create mode 100644 hw/i3c/trace-events
>   create mode 100644 hw/i3c/trace.h
>   rename include/hw/{misc => i3c}/aspeed_i3c.h (100%)
> 
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 9a86a6a28a..61b8b2a142 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -13,6 +13,7 @@ source fsi/Kconfig
>   source gpio/Kconfig
>   source hyperv/Kconfig
>   source i2c/Kconfig
> +source i3c/Kconfig
>   source ide/Kconfig
>   source input/Kconfig
>   source intc/Kconfig
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f543d944c3..427d0f0271 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -530,6 +530,7 @@ config ASPEED_SOC
>       select DS1338
>       select FTGMAC100
>       select I2C
> +    select I3C
>       select DPS310
>       select PCA9552
>       select SERIAL_MM
> diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
> new file mode 100644
> index 0000000000..e07fe445c6
> --- /dev/null
> +++ b/hw/i3c/Kconfig
> @@ -0,0 +1,2 @@
> +config I3C
> +    bool
> diff --git a/hw/misc/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
> similarity index 99%
> rename from hw/misc/aspeed_i3c.c
> rename to hw/i3c/aspeed_i3c.c
> index 3bef1c84dd..e56822f928 100644
> --- a/hw/misc/aspeed_i3c.c
> +++ b/hw/i3c/aspeed_i3c.c
> @@ -10,7 +10,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
> -#include "hw/misc/aspeed_i3c.h"
> +#include "hw/i3c/aspeed_i3c.h"
>   #include "hw/registerfields.h"
>   #include "hw/qdev-properties.h"
>   #include "qapi/error.h"
> diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
> new file mode 100644
> index 0000000000..ebf20325cb
> --- /dev/null
> +++ b/hw/i3c/meson.build
> @@ -0,0 +1,3 @@
> +i3c_ss = ss.source_set()
> +i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
> +system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
> diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
> new file mode 100644
> index 0000000000..3ead84eb45
> --- /dev/null
> +++ b/hw/i3c/trace-events
> @@ -0,0 +1,7 @@
> +# See docs/devel/tracing.rst for syntax documentation.
> +
> +# aspeed_i3c.c
> +aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
> +aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
> +aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
> +aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
> diff --git a/hw/i3c/trace.h b/hw/i3c/trace.h
> new file mode 100644
> index 0000000000..1e0c4eadf0
> --- /dev/null
> +++ b/hw/i3c/trace.h
> @@ -0,0 +1,2 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "trace/trace-hw_i3c.h"
> diff --git a/hw/meson.build b/hw/meson.build
> index b91f761fe0..31786f03d0 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -12,6 +12,7 @@ subdir('dma')
>   subdir('gpio')
>   subdir('hyperv')
>   subdir('i2c')
> +subdir('i3c')
>   subdir('ide')
>   subdir('input')
>   subdir('intc')
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 6d47de482c..4a41716625 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -130,7 +130,6 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
>   system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>     'aspeed_hace.c',
> -  'aspeed_i3c.c',
>     'aspeed_lpc.c',
>     'aspeed_scu.c',
>     'aspeed_sbc.c',
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index e3f64c0ff6..f70459b3b7 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -287,12 +287,6 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU wri
>   # aspeed_xdma.c
>   aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
>   
> -# aspeed_i3c.c
> -aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
> -aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
> -aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
> -aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
> -
>   # aspeed_sdmc.c
>   aspeed_sdmc_write(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
>   aspeed_sdmc_read(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: 0x%" PRIx64
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 217ef0eafd..07265f26cf 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -23,7 +23,7 @@
>   #include "hw/timer/aspeed_timer.h"
>   #include "hw/rtc/aspeed_rtc.h"
>   #include "hw/i2c/aspeed_i2c.h"
> -#include "hw/misc/aspeed_i3c.h"
> +#include "hw/i3c/aspeed_i3c.h"
>   #include "hw/ssi/aspeed_smc.h"
>   #include "hw/misc/aspeed_hace.h"
>   #include "hw/misc/aspeed_sbc.h"
> diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
> similarity index 100%
> rename from include/hw/misc/aspeed_i3c.h
> rename to include/hw/i3c/aspeed_i3c.h
> diff --git a/meson.build b/meson.build
> index 34729c2a3d..186effb84f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3651,6 +3651,7 @@ if have_system
>       'hw/fsi',
>       'hw/hyperv',
>       'hw/i2c',
> +    'hw/i3c',
>       'hw/i386',
>       'hw/i386/xen',
>       'hw/i386/kvm',


