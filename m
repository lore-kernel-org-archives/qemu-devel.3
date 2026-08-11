Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DE1C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteAm-0005hu-0I; Tue, 11 Aug 2026 00:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wteAi-0005hR-6u; Tue, 11 Aug 2026 00:33:04 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wteAf-0006xO-K0; Tue, 11 Aug 2026 00:33:03 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hJzJ867nMz66Y7;
 Tue, 11 Aug 2026 04:32:56 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 11 Aug 2026 04:32:56 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.159])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hJzJ815mVz5vVv; Tue, 11 Aug 2026 04:32:56 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id B58801B43EE1;
 Tue, 11 Aug 2026 04:32:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S00319ff1eca-f75a-43a1-a667-cadd0601d4ec,
 803E6BE66494CDF3CD1430A16CDAFD105E03C239) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <b5d12587-f88c-4bff-bf9f-540a3a532dd9@kaod.org>
Date: Tue, 11 Aug 2026 06:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] arm/aspeed: Wire AST2700 FSI controllers to
 APB-to-OPB bridges
To: Mikail Sadic <mikail.sadic@ibm.com>, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, ninad@linux.ibm.com, titusr@google.com,
 jeuk20.kim@samsung.com, philmd@mailo.com, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
 <20260810185748.1253-4-mikail.sadic@ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260810185748.1253-4-mikail.sadic@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11959308810787728515
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE2bUaQhuwKHyR8VGN+TqzW7BsGnZOuQ1wD1zEdZHXOAJbCrYUBNpu2USFn/v5PQYxqycKTk0NZYcFO8Enb9aDVSgTc3r55I4Np1OkEPSIezHKcwMQ5z8Bp/sCRQQrdomhCS6bqQ8f+nrT+o834zq7dlhPcC/12uLl4fnPstcK+uYDhMMac5cMpRD8wffsrx38vuXzrM8nCEwPm472cctnZAVNGI31mo0DRNHa9nofH/RMgb/SsEjLoFJkLM/U45UhxSh8blri3Q35WO6H/5beiF+ZYmzoLBjcb78rS7Gp8TIJLHxk6A68Tl3MEbIqvTfKM9j7F1bqlreoSz3fZMMQCj8lr1uBKJJVeE5R4QmDDbVMPvOTsuW/4sf9Ez8cwslgvdvmeIaP4dXjgE9JxF9VBwPVXLClPERH24NacMLzBAhBauLb5DTeLckhXYVAJBS60yM7VzYqSPmsGn1coVcZkcvjUJK5TewjN7OBhVVc5dH/WqKZ4H5aSGOdATqYRxEaVjEnYpQn83HMR9Q74g7rbjSnrAqmA7LRteLL16ydrJmNHImxfDhSeL1qb+v6RxWEyG5h8PDnX5Z14pYU5ImU3ry4AqsE+baRhkPiaRkXV/HB8RI82bY75aUveWEU67gmITEHh70Po1dVvGQ5kF9M09io3xIUkBWsrGQ8iDV+ejg
DKIM-Signature: a=rsa-sha256; bh=0DRnBFax2mUhLeon6GfWFLjdnixI+LBJAMNtZVasD4M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1786422778; v=1;
 b=EOVgPdY0TftmCtxz7D32U2uaz4JYE4KQrUGo2dEFp5AiyMyb1IbPwK4pR/dy38nEsfdnO9kG
 njiCMqZLG36AxPqi36wz+xbuocsJxAlkJnDKbFffJAgTgbSrAk0ClHMrFCtB+V8YRfTu0X938rj
 hqC4smLEu3gzGIfRQZSKiE+gdFPfp3ilABgVL0KwkqZAEEqnp7MQ/I+3Ud6JnQND1uydV1yDnhs
 1kExvl8TP9RW71QctoiPKTeSYFTBPB6N0Nr33yai2+cgYWcW215Ewj9ZBhIaUeKVMFie88HgK2b
 5LOqyDXagw+y45sYVdV5F5TaHggO6IRmqEU8zhmP8Ahpg==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/10/26 20:57, Mikail Sadic wrote:
> The AST2700 SoC exposes two FSI controllers behind APB-to-OPB bridges.
> Add the ASPEED_DEV_FSI1/FSI2 memory-map entries, instantiate both fsi[]
> APB-to-OPB bridges and map them during SoC realize, so the CFAM/CFAM-S
> devices on the FSI local buses become reachable from the SoC.
> 
> Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index dddd7d2106..b908d7d4ff 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -17,6 +17,7 @@
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
>   #include "hw/i2c/aspeed_i2c.h"
> +#include "hw/fsi/aspeed_apb2opb.h"
>   #include "net/net.h"
>   #include "system/qtest.h"
>   #include "system/system.h"
> @@ -98,6 +99,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
>       [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
>       [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
> +    [ASPEED_DEV_FSI1]      =  0x21800000,
> +    [ASPEED_DEV_FSI2]      =  0x23800000,
>       [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
>       [ASPEED_DEV_SDRAM]     =  0x400000000,
>   };
> @@ -559,6 +562,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                                sc->silicon_rev);
>       }
>   
> +    for (i = 0; i < ARRAY_SIZE(s->fsi); i++) {
> +        object_initialize_child(obj, "fsi[*]", &s->fsi[i],
> +                                TYPE_ASPEED_APB2OPB);
> +    }
> +
>       object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "iomem", &s->iomem,
> @@ -1132,6 +1140,16 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    /* FSI / OPB */
> +    for (i = 0; i < ARRAY_SIZE(s->fsi); i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsi[i]), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
> +                        sc->memmap[ASPEED_DEV_FSI1 + i]);
> +    }
> +
> +
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
>                                     "aspeed.dpmcu",
>                                     sc->memmap[ASPEED_DEV_DPMCU],

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


