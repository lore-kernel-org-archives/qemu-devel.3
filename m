Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A800BC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 08:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTHf5-0004tI-6k; Fri, 26 Jan 2024 03:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTHf3-0004bS-7E; Fri, 26 Jan 2024 03:34:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTHf1-00088f-5q; Fri, 26 Jan 2024 03:34:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLrZZ4VJ7z4x5l;
 Fri, 26 Jan 2024 19:33:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLrZW0R2Nz4wxv;
 Fri, 26 Jan 2024 19:33:54 +1100 (AEDT)
Message-ID: <769b7e74-6660-46e1-ad7e-4bb3e92e58d1@kaod.org>
Date: Fri, 26 Jan 2024 09:33:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/11] hw/fsi: Introduce IBM's FSI Bus
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20240126034026.31068-1-ninad@linux.ibm.com>
 <20240126034026.31068-4-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240126034026.31068-4-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/26/24 04:40, Ninad Palsule wrote:
> This is a part of patchset where FSI bus is introduced.
> 
> The FSI bus is a simple bus where FSI master is attached.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> [ clg: - removed include/hw/fsi/engine-scratchpad.h and
>         	 hw/fsi/engine-scratchpad.c
>         - dropped FSI_SCRATCHPAD
>         - included FSIBus definition
>         - dropped hw/fsi/trace-events changes ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> ---
> v11:
>    - Split the patch.
> ---
>   include/hw/fsi/fsi.h | 19 +++++++++++++++++++
>   hw/fsi/fsi.c         | 22 ++++++++++++++++++++++
>   hw/fsi/meson.build   |  2 +-
>   3 files changed, 42 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/fsi/fsi.h
>   create mode 100644 hw/fsi/fsi.c
> 
> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
> new file mode 100644
> index 0000000000..50e8f5c888
> --- /dev/null
> +++ b/include/hw/fsi/fsi.h
> @@ -0,0 +1,19 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2024 IBM Corp.
> + *
> + * IBM Flexible Service Interface
> + */
> +#ifndef FSI_FSI_H
> +#define FSI_FSI_H
> +
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_FSI_BUS "fsi.bus"
> +OBJECT_DECLARE_SIMPLE_TYPE(FSIBus, FSI_BUS)
> +
> +typedef struct FSIBus {
> +    BusState bus;
> +} FSIBus;
> +
> +#endif /* FSI_FSI_H */
> diff --git a/hw/fsi/fsi.c b/hw/fsi/fsi.c
> new file mode 100644
> index 0000000000..60cb03f7a2
> --- /dev/null
> +++ b/hw/fsi/fsi.c
> @@ -0,0 +1,22 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2024 IBM Corp.
> + *
> + * IBM Flexible Service Interface
> + */
> +#include "qemu/osdep.h"
> +
> +#include "hw/fsi/fsi.h"
> +
> +static const TypeInfo fsi_bus_info = {
> +    .name = TYPE_FSI_BUS,
> +    .parent = TYPE_BUS,
> +    .instance_size = sizeof(FSIBus),
> +};
> +
> +static void fsi_bus_register_types(void)
> +{
> +    type_register_static(&fsi_bus_info);
> +}
> +
> +type_init(fsi_bus_register_types);
> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
> index 93ba19dd04..574f5f9289 100644
> --- a/hw/fsi/meson.build
> +++ b/hw/fsi/meson.build
> @@ -1 +1 @@
> -system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c'))
> +system_ss.add(when: 'CONFIG_FSI', if_true: files('lbus.c','fsi.c'))


