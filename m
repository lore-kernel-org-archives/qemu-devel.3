Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6543AC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 12:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXgzf-0000hm-8P; Wed, 07 Feb 2024 07:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXgzY-0000a8-P4; Wed, 07 Feb 2024 07:25:29 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXgzT-0007v9-0m; Wed, 07 Feb 2024 07:25:26 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 165F34E6096;
 Wed,  7 Feb 2024 13:25:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id UCV4WmfofHJJ; Wed,  7 Feb 2024 13:25:06 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1E8C04E60D1; Wed,  7 Feb 2024 13:25:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 16A677456FE;
 Wed,  7 Feb 2024 13:25:06 +0100 (CET)
Date: Wed, 7 Feb 2024 13:25:06 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 2/4] hw/ppc/ppc4xx_pci: Extract PCI host definitions
 to hw/pci-host/ppc4xx.h
In-Reply-To: <20240207091254.1478-3-philmd@linaro.org>
Message-ID: <ff46ab77-1d1c-112d-cde0-4367427844a9@eik.bme.hu>
References: <20240207091254.1478-1-philmd@linaro.org>
 <20240207091254.1478-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1810067198-1707308706=:38665"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1810067198-1707308706=:38665
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 7 Feb 2024, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> Message-Id: <20231011132427.65001-3-philmd@linaro.org>
> ---
> MAINTAINERS                  |  1 +
> include/hw/pci-host/ppc4xx.h | 17 +++++++++++++++++
> include/hw/ppc/ppc4xx.h      |  5 -----
> hw/ppc/ppc440_bamboo.c       |  1 +
> hw/ppc/ppc440_pcix.c         |  2 +-
> hw/ppc/ppc440_uc.c           |  1 +
> hw/ppc/ppc4xx_pci.c          |  2 +-
> hw/ppc/sam460ex.c            |  1 +
> 8 files changed, 23 insertions(+), 7 deletions(-)
> create mode 100644 include/hw/pci-host/ppc4xx.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f9741b898..b288f0dc76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2068,6 +2068,7 @@ F: hw/ppc/ppc4xx*.c
> F: hw/ppc/ppc440_uc.c
> F: hw/ppc/ppc440.h
> F: hw/i2c/ppc4xx_i2c.c
> +F: include/hw/pci-host/ppc4xx.h
> F: include/hw/ppc/ppc4xx.h
> F: include/hw/i2c/ppc4xx_i2c.h
> F: hw/intc/ppc-uic.c
> diff --git a/include/hw/pci-host/ppc4xx.h b/include/hw/pci-host/ppc4xx.h
> new file mode 100644
> index 0000000000..dc36e1ea29
> --- /dev/null
> +++ b/include/hw/pci-host/ppc4xx.h
> @@ -0,0 +1,17 @@
> +/*
> + * QEMU PowerPC 4xx PCI-host definitions
> + *
> + * Copyright (c) 2007 Jocelyn Mayer
> + *
> + * SPDX-License-Identifier: MIT

Not that it matters much for simple definitions but these lines were added 
by me and I prefer GPLv2+.

Regards,
BALATON Zoltan

> + */
> +
> +#ifndef HW_PCIHOST_PPC4XX_H
> +#define HW_PCIHOST_PPC4XX_H
> +
> +#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
> +#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
> +#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
> +#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
> +
> +#endif
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index ea7740239b..1bd9b8821b 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -29,11 +29,6 @@
> #include "exec/memory.h"
> #include "hw/sysbus.h"
>
> -#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
> -#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
> -#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
> -#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
> -
> /*
>  * Generic DCR device
>  */
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index c75c3083e6..e18f57efce 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -24,6 +24,7 @@
> #include "elf.h"
> #include "hw/char/serial.h"
> #include "hw/ppc/ppc.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "sysemu/sysemu.h"
> #include "sysemu/reset.h"
> #include "hw/sysbus.h"
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index d84418cb7b..1926ae2a27 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -25,7 +25,7 @@
> #include "qemu/module.h"
> #include "qemu/units.h"
> #include "hw/irq.h"
> -#include "hw/ppc/ppc4xx.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "hw/pci/pci_device.h"
> #include "hw/pci/pci_host.h"
> #include "trace.h"
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 7d6ca70387..1312aa2080 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -14,6 +14,7 @@
> #include "qemu/log.h"
> #include "hw/irq.h"
> #include "hw/ppc/ppc4xx.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "hw/qdev-properties.h"
> #include "hw/pci/pci.h"
> #include "sysemu/reset.h"
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index e4101398c9..b6c6c8993c 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -24,7 +24,7 @@
> #include "qemu/osdep.h"
> #include "qemu/log.h"
> #include "hw/irq.h"
> -#include "hw/ppc/ppc4xx.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "migration/vmstate.h"
> #include "qemu/module.h"
> #include "sysemu/reset.h"
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 1e615b8d35..a28498f39c 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -25,6 +25,7 @@
> #include "elf.h"
> #include "exec/memory.h"
> #include "ppc440.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "hw/block/flash.h"
> #include "sysemu/sysemu.h"
> #include "sysemu/reset.h"
>
--3866299591-1810067198-1707308706=:38665--

