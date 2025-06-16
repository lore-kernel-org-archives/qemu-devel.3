Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948C8C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 06:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR3ga-0005IC-Hf; Mon, 16 Jun 2025 02:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=g70R=Y7=kaod.org=clg@ozlabs.org>)
 id 1uR3fB-00054K-DO; Mon, 16 Jun 2025 02:49:49 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=g70R=Y7=kaod.org=clg@ozlabs.org>)
 id 1uR3f8-0006S2-2i; Mon, 16 Jun 2025 02:49:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bLLGG6JhCz4wcy;
 Mon, 16 Jun 2025 16:49:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bLLGB6Z74z4wbW;
 Mon, 16 Jun 2025 16:49:38 +1000 (AEST)
Message-ID: <23deafc7-d832-470b-8d8e-aea0125d756f@kaod.org>
Date: Mon, 16 Jun 2025 08:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] i3c: aspeed: Add I3C support
To: Joe Komlodi <komlodi@google.com>, qemu-devel@nongnu.org
Cc: venture@google.com, peter.maydell@linaro.org, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au,
 joel@jms.id.au, qemu-arm@nongnu.org, Jeremy Kerr <jk@codeconstruct.com.au>
References: <20250613000411.1516521-1-komlodi@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi

+ Jeremy

On 6/13/25 02:03, Joe Komlodi wrote:
> Hi all,
> 
> This series adds I3C bus support to QEMU and adds more functionality to the
> Aspeed I3C controller.
> 
> This implementation is a basic implementation that introduces IBIs
> (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't support
> multi-controller buses or HDR transfers.
> 
> First we add the I3C bus and controller model. With that added we extend
> the functionality of the Aspeed I3C controller so it can do transfers
> and handle IBIs.
> 
> Next, we add a mock I3C target. It's intended to be a very simple target
> just to verify that I3C is working on the guest. Internally, we've used it
> on Linux to verify that i3C devices can be probed and can send/receive data
> and IBIs.
> This target is sort of like an EEPROM, and it can also send IBIs upon
> reception of a user-defined magic number.> 
> Lastly we add  hotplugging support. The hotplugging doesn't do anything too
> complicated, it just adds the device attempting to hotplug to the bus. It
> is the device's responsibility to hot-join and go through the DAA process
> to participate on the bus.
> 
> Thanks,
> Joe
> 
> Joe Komlodi (19):
>    hw/misc/aspeed_i3c: Move to i3c directory
>    hw/i3c: Add bus support
>    hw/i3c: Split DesignWare I3C out of Aspeed I3C
>    hw/i3c/dw-i3c: Add more register fields
>    hw/i3c/aspeed_i3c: Add more register fields
>    hw/i3c/dw-i3c: Add more reset values
>    hw/i3c/aspeed_i3c: Add register RO field masks
>    hw/i3c/dw-i3c: Add register RO field masks
>    hw/i3c/dw-i3c: Treat more registers as read-as-zero
>    hw/i3c/dw-i3c: Use 32 bits on MMIO writes
>    hw/i3c/dw-i3c: Add IRQ MMIO behavior
>    hw/i3c/dw-i3c: Add data TX and RX
>    hw/i3c/dw-i3c: Add IBI handling
>    hw/i3c/dw-i3c: Add ctrl MMIO handling
>    hw/i3c/dw-i3c: Add controller resets
>    hw/i3c/aspeed: Add I3C bus get function
>    hw/i3c: Add Mock target
>    hw/arm/aspeed: Build with I3C_DEVICES
>    hw/i3c: Add hotplug support
> 
>   hw/Kconfig                            |    1 +
>   hw/arm/Kconfig                        |    3 +
>   hw/i3c/Kconfig                        |   15 +
>   hw/i3c/aspeed_i3c.c                   |  261 ++++
>   hw/i3c/core.c                         |  669 +++++++++
>   hw/i3c/dw-i3c.c                       | 1881 +++++++++++++++++++++++++
>   hw/i3c/meson.build                    |    6 +
>   hw/i3c/mock-i3c-target.c              |  311 ++++
>   hw/i3c/trace-events                   |   47 +
>   hw/i3c/trace.h                        |    2 +
>   hw/meson.build                        |    1 +
>   hw/misc/aspeed_i3c.c                  |  383 -----
>   hw/misc/meson.build                   |    1 -
>   hw/misc/trace-events                  |    6 -
>   include/hw/arm/aspeed_soc.h           |    2 +-
>   include/hw/{misc => i3c}/aspeed_i3c.h |   22 +-
>   include/hw/i3c/dw-i3c.h               |  201 +++
>   include/hw/i3c/i3c.h                  |  277 ++++
>   include/hw/i3c/mock-i3c-target.h      |   52 +
>   meson.build                           |    1 +
>   20 files changed, 3735 insertions(+), 407 deletions(-)
>   create mode 100644 hw/i3c/Kconfig
>   create mode 100644 hw/i3c/aspeed_i3c.c
>   create mode 100644 hw/i3c/core.c
>   create mode 100644 hw/i3c/dw-i3c.c
>   create mode 100644 hw/i3c/meson.build
>   create mode 100644 hw/i3c/mock-i3c-target.c
>   create mode 100644 hw/i3c/trace-events
>   create mode 100644 hw/i3c/trace.h
>   delete mode 100644 hw/misc/aspeed_i3c.c
>   rename include/hw/{misc => i3c}/aspeed_i3c.h (63%)
>   create mode 100644 include/hw/i3c/dw-i3c.h
>   create mode 100644 include/hw/i3c/i3c.h
>   create mode 100644 include/hw/i3c/mock-i3c-target.h
> 

This lacks a MAINTAINER.

Could you please provide functional tests ? some with a standard I2C
device attached to an I3C legacy bus too.

Are there any other stakeholders interested in the I3C to get feedback ?

Have there been any changes since:

   https://lore.kernel.org/qemu-devel/20230331010131.1412571-1-komlodi@google.com/

Thanks,

C.

