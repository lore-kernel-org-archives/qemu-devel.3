Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A67CF9C69
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssgdn-00043G-Ie; Mon, 23 Sep 2024 06:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssgdk-00040B-6P; Mon, 23 Sep 2024 06:50:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssgdi-0007a8-I7; Mon, 23 Sep 2024 06:49:59 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1EEA4E601B;
 Mon, 23 Sep 2024 12:49:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fsTviGT3kRrN; Mon, 23 Sep 2024 12:49:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AE0194E600E; Mon, 23 Sep 2024 12:49:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB835746F60;
 Mon, 23 Sep 2024 12:49:53 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:49:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 11/23] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
In-Reply-To: <20240923093016.66437-12-shentey@gmail.com>
Message-ID: <424c5118-c638-4e83-9796-8858b7fba78b@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-12-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 23 Sep 2024, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/i2c/mpc_i2c.c | 20 ++++++++------------
> 1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
> index 3d79c15653..16f4309ea9 100644
> --- a/hw/i2c/mpc_i2c.c
> +++ b/hw/i2c/mpc_i2c.c
> @@ -20,7 +20,6 @@
> #include "qemu/osdep.h"
> #include "hw/i2c/i2c.h"
> #include "hw/irq.h"
> -#include "qemu/module.h"
> #include "hw/sysbus.h"
> #include "migration/vmstate.h"
> #include "qom/object.h"
> @@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
>     dc->desc = "MPC I2C Controller";
> }
>
> -static const TypeInfo mpc_i2c_type_info = {
> -    .name          = TYPE_MPC_I2C,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(MPCI2CState),
> -    .class_init    = mpc_i2c_class_init,
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_MPC_I2C,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(MPCI2CState),
> +        .class_init    = mpc_i2c_class_init,
> +    },
> };
>
> -static void mpc_i2c_register_types(void)
> -{
> -    type_register_static(&mpc_i2c_type_info);
> -}
> -
> -type_init(mpc_i2c_register_types)
> +DEFINE_TYPES(types)

What's the advantage of this when we have a single device? For these 
devices this looks like just code churn to me.

Regards,
BALATON Zoltan

