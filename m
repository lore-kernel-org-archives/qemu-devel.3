Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C35C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXhkP-0004x1-VL; Wed, 07 Feb 2024 08:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXhkL-0004wH-Bl
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:13:49 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXhkI-0003Qz-BU
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:13:49 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3A92F4E601E;
 Wed,  7 Feb 2024 14:13:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 7j5FS40lV5vx; Wed,  7 Feb 2024 14:13:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3F2CF4E6006; Wed,  7 Feb 2024 14:13:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3D88E7456B4;
 Wed,  7 Feb 2024 14:13:42 +0100 (CET)
Date: Wed, 7 Feb 2024 14:13:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, shentey@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v2 6/8] isa: extract FDC37M81X to a separate file
In-Reply-To: <20240207111411.115040-7-pbonzini@redhat.com>
Message-ID: <191a2c68-b488-0427-b926-f14bbe421144@eik.bme.hu>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-493588026-1707311622=:38665"
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

--3866299591-493588026-1707311622=:38665
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 7 Feb 2024, Paolo Bonzini wrote:
> isa-superio.c currently defines a SuperIO chip that is not used
> by any other user of the faile.  Extract the chip to a separate file.

Typo: faile -> file?

Regards,
BALATON Zoltan

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> hw/isa/fdc37m81x-superio.c | 32 ++++++++++++++++++++++++++++++++
> hw/isa/isa-superio.c       | 18 ------------------
> hw/isa/Kconfig             |  4 ++++
> hw/isa/meson.build         |  1 +
> hw/mips/Kconfig            |  2 +-
> 5 files changed, 38 insertions(+), 19 deletions(-)
> create mode 100644 hw/isa/fdc37m81x-superio.c
>
> diff --git a/hw/isa/fdc37m81x-superio.c b/hw/isa/fdc37m81x-superio.c
> new file mode 100644
> index 00000000000..55e91fbca17
> --- /dev/null
> +++ b/hw/isa/fdc37m81x-superio.c
> @@ -0,0 +1,32 @@
> +/*
> + * SMS FDC37M817 Super I/O
> + *
> + * Copyright (c) 2018 Philippe Mathieu-Daudé
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/isa/superio.h"
> +
> +static void fdc37m81x_class_init(ObjectClass *klass, void *data)
> +{
> +    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
> +
> +    sc->serial.count = 2; /* NS16C550A */
> +    sc->parallel.count = 1;
> +    sc->floppy.count = 1; /* SMSC 82077AA Compatible */
> +    sc->ide.count = 0;
> +}
> +
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_FDC37M81X_SUPERIO,
> +        .parent        = TYPE_ISA_SUPERIO,
> +        .class_init    = fdc37m81x_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(types)
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index 98d50844f71..a8c8c58ef7f 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -190,27 +190,9 @@ static const TypeInfo isa_superio_type_info = {
>     .instance_size = sizeof(ISASuperIODevice),
> };
>
> -/* SMS FDC37M817 Super I/O */
> -static void fdc37m81x_class_init(ObjectClass *klass, void *data)
> -{
> -    ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
> -
> -    sc->serial.count = 2; /* NS16C550A */
> -    sc->parallel.count = 1;
> -    sc->floppy.count = 1; /* SMSC 82077AA Compatible */
> -    sc->ide.count = 0;
> -}
> -
> -static const TypeInfo fdc37m81x_type_info = {
> -    .name          = TYPE_FDC37M81X_SUPERIO,
> -    .parent        = TYPE_ISA_SUPERIO,
> -    .class_init    = fdc37m81x_class_init,
> -};
> -
> static void isa_superio_register_types(void)
> {
>     type_register_static(&isa_superio_type_info);
> -    type_register_static(&fdc37m81x_type_info);
> }
>
> type_init(isa_superio_register_types)
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 5df3c09cd51..73c6470805c 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -23,6 +23,10 @@ config ISA_SUPERIO
>     # Some users of ISA_SUPERIO do not use it
>     #select IDE_ISA
>
> +config FDC37M81X
> +    bool
> +    select ISA_SUPERIO
> +
> config PC87312
>     bool
>     select ISA_SUPERIO
> diff --git a/hw/isa/meson.build b/hw/isa/meson.build
> index 2ab99ce0c6b..f650b395071 100644
> --- a/hw/isa/meson.build
> +++ b/hw/isa/meson.build
> @@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
> system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
> system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
> system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
> +system_ss.add(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-superio.c'))
> system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
> system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
>
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index afcfb2b8eca..e57db4f6412 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -1,7 +1,7 @@
> config MALTA
>     bool
> +    select FDC37M81X
>     select GT64120
> -    select ISA_SUPERIO
>     select PIIX
>
> config MIPSSIM
>
--3866299591-493588026-1707311622=:38665--

