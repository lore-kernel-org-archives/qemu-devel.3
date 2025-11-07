Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6C1CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMYc-0006iE-SV; Fri, 07 Nov 2025 08:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHMYP-0006hM-6W
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:31:02 -0500
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHMYL-0001wh-HT
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:31:00 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.133])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d30Lj4Jhdz5xh1;
 Fri,  7 Nov 2025 13:30:53 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 7 Nov
 2025 14:30:52 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004557385e5-4126-42f3-9cb2-af94f6754a79,
 22B515FCB2325FA901564F8AB94FB8FB00D14EB6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a9d81752-a4a2-49d6-b348-25e868c3c606@kaod.org>
Date: Fri, 7 Nov 2025 14:30:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] hw/arm/aspeed: Integrate AST1700 device into
 AST27X0
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-5-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251105035859.3709907-5-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: d695b1af-b76a-49fc-ae78-f344b6a9e195
X-Ovh-Tracer-Id: 17621740920599186354
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFxBbdDdYtXSp6FdXmhPYyGXejcmlZdxJR/Ap2rVrDUKHUAlq9Knb9it/R2AG+cVQYkrLuSbXR2m66sh8NFxFXj19jjx1srufeu2dAWHWTVW/nJlw+1G2LicAV5+q+4uFKli3kJPy/ASNRVpweTb8CL7tWJobNtp7bPsdojliHoJki+MY6iLRhuIBK131cWvMXVMdVIEMVkBb9pbu8XfvpeIGnpsdVt4G6t2Jg/4+4eC9q4ow9rMGuL79PKpqEzeStNi4r8z6In6P0xzVeNb1EmRXyhW4GxA7WQ5C6WqMVM4fELgz6euv6R1omKf5dqOKs8nscbXp/BUWECEyo9OcMzhiXrXUrOk4gBb+cgzDBdsyLzUw35TAdwyCIVyk/53LN76oO8yo6REEqQJ8skhgcR8yW36XOG7BCR+tLURA0HD2cFst2x1cXD80PJzOwJmrWt5ID+xWiG6F8Qt4Ge4MQbXly8Phn7jVg33Jo7kJ+C3XQLyjXHTWtVIDsojs/It/RCMDLzlTmcnfl7epqgP+V59yfS5eE6145mBF1bePhrFTEmp8dPCb2kWXnwFEmoJGEB+UmCSgwNBt6k4b9rKfW2AIyrNmG/lVzekX8xQfEATejy+7OKEF6Fz1cQnhAQNy0aXHT87tWGplIbWo4nQnRzZhK0LWt2gxLLCfDeEoBHfQ
DKIM-Signature: a=rsa-sha256; bh=CA28Io2furVLZjQgwfT1jNfHTZhIT3b8T1YVnVFPgog=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762522254; v=1;
 b=GQBxYemhH923h9GjT24yre39CsQ+cTZxvV35ea0A4Ah3ugfjspb4sHph/QPs2FUV1Z/18Pkr
 8xkie9Gy1JIpjW21OkzCihpvLlgmUtiBLHcF9TWjc0LnxDJYasPyxAz3parvd6FTVWkWyp82TBu
 cF3lh44S1TqMeVBsnksGNRzZ85YWGBlZODG5zMNlD3HQukE6v7gE1BRS9Kkc/UU24/cxHz8DaxU
 nY37RUDq5hyyuxKz4zVfsDyQl1QdKhJvHOBzNs3Dtjyv7H+DnRxYjN+NAt8yiqfXA9rttbZndGT
 s28XJ+wKa18CTMBZBPx0iceYxiBVaLyzTFzHFcBHHX/3g==
Received-SPF: pass client-ip=46.105.37.156; envelope-from=clg@kaod.org;
 helo=8.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/5/25 04:58, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Connect the AST1700 device as a child of the AST27X0 model to reflect
> its role in DC-SCM 2.0 LTPI-based architectures. This patch wires
> the AST1700 device into the platform without introducing functional
> peripherals.
> 
> This forms the base for LTPI expander emulation in QEMU using
> AST27X0 as the host controller.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h      |  9 +++++++--
>   include/hw/misc/aspeed_ast1700.h |  1 +
>   hw/arm/aspeed_ast27x0.c          | 30 ++++++++++++++++++++++--------
>   hw/misc/aspeed_ast1700.c         |  6 ++++++
>   4 files changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index bae60d85ea..00cd8df038 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -43,6 +43,7 @@
>   #include "hw/char/serial-mm.h"
>   #include "hw/intc/arm_gicv3.h"
>   #include "hw/misc/aspeed_ltpi.h"
> +#include "hw/misc/aspeed_ast1700.h"
>   
>   #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
>   
> @@ -109,10 +110,10 @@ struct AspeedSoCState {
>       UnimplementedDeviceState espi;
>       UnimplementedDeviceState udc;
>       UnimplementedDeviceState sgpiom;
> -    UnimplementedDeviceState ltpi;
>       UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>       AspeedAPB2OPBState fsi[2];
>       AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
> +    AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
>   };
>   
>   #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -174,6 +175,7 @@ struct AspeedSoCClass {
>       int macs_num;
>       int uarts_num;
>       int uarts_base;
> +    int ioexp_num;
>       const int *irqmap;
>       const hwaddr *memmap;
>       uint32_t num_cpus;
> @@ -186,7 +188,8 @@ enum {
>       ASPEED_DEV_IOMEM,
>       ASPEED_DEV_IOMEM0,
>       ASPEED_DEV_IOMEM1,
> -    ASPEED_DEV_LTPI,
> +    ASPEED_DEV_LTPI_IO0,
> +    ASPEED_DEV_LTPI_IO1,
>       ASPEED_DEV_UART0,
>       ASPEED_DEV_UART1,
>       ASPEED_DEV_UART2,
> @@ -280,6 +283,8 @@ enum {
>       ASPEED_DEV_IPC1,
>       ASPEED_DEV_LTPI_CTRL1,
>       ASPEED_DEV_LTPI_CTRL2,
> +    ASPEED_DEV_IOEXP0_INTCIO,
> +    ASPEED_DEV_IOEXP1_INTCIO,

Please put the index number at the end of the enum definition.
These definitions are unused too. Please move in the next patch.

>   };
>   
>   const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
> index b7c666eef2..624ef61eda 100644
> --- a/include/hw/misc/aspeed_ast1700.h
> +++ b/include/hw/misc/aspeed_ast1700.h
> @@ -20,6 +20,7 @@
>   #include "hw/misc/unimp.h"
>   
>   #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
> +#define TYPE_ASPEED_AST1700_AST2700 "aspeed.ast1700-ast2700"
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
>   
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index c0d8639bde..054864467d 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -26,7 +26,6 @@
>   #define AST2700_SOC_IO_SIZE          0x00FE0000
>   #define AST2700_SOC_IOMEM_SIZE       0x01000000
>   #define AST2700_SOC_DPMCU_SIZE       0x00040000
> -#define AST2700_SOC_LTPI_SIZE        0x01000000
>   
>   static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_VBOOTROM]  =  0x00000000,
> @@ -89,11 +88,14 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
>       [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
>       [ASPEED_DEV_WDT]       =  0x14C37000,
> +    [ASPEED_DEV_LTPI_IO0]  =  0x30000000,
> +    [ASPEED_DEV_IOEXP0_INTCIO] = 0x30C18000,
> +    [ASPEED_DEV_LTPI_IO1]  =  0x50000000,
> +    [ASPEED_DEV_IOEXP1_INTCIO] = 0x50C18000,
>       [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
>       [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
>       [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
>       [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
> -    [ASPEED_DEV_LTPI]      =  0x300000000,
>       [ASPEED_DEV_SDRAM]     =  0x400000000,
>   };
>   
> @@ -549,10 +551,15 @@ static void aspeed_soc_ast2700_init(Object *obj)
>           object_initialize_child(obj, "ltpi-ctrl[*]",
>                                   &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
>       }
> +
> +    for (i = 0; i < sc->ioexp_num; i++) {
> +        /* AST1700 IOEXP */
> +        object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],
> +                                TYPE_ASPEED_AST1700_AST2700);
> +    }
> +
>       object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                               TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "ltpi", &s->ltpi,
> -                            TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "iomem", &s->iomem,
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "iomem0", &s->iomem0,
> @@ -1039,14 +1046,20 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           }
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
>       }
> +
> +    /* IO Expander */
> +    for (i = 0; i < sc->ioexp_num; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
> +                        sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
> +    }
> +
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
>                                     "aspeed.dpmcu",
>                                     sc->memmap[ASPEED_DEV_DPMCU],
>                                     AST2700_SOC_DPMCU_SIZE);
> -    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->ltpi),
> -                                  "aspeed.ltpi",
> -                                  sc->memmap[ASPEED_DEV_LTPI],
> -                                  AST2700_SOC_LTPI_SIZE);
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
>                                     "aspeed.io",
>                                     sc->memmap[ASPEED_DEV_IOMEM],
> @@ -1112,6 +1125,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
>       sc->macs_num     = 3;
>       sc->uarts_num    = 13;
>       sc->num_cpus     = 4;
> +    sc->ioexp_num    = 2;
>       sc->uarts_base   = ASPEED_DEV_UART0;
>       sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
>       sc->memmap       = aspeed_soc_ast2700_memmap;
> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
> index bb05e392f4..3125bec795 100644
> --- a/hw/misc/aspeed_ast1700.c
> +++ b/hw/misc/aspeed_ast1700.c
> @@ -48,10 +48,16 @@ static const TypeInfo aspeed_ast1700_info = {
>       .instance_init = aspeed_ast1700_instance_init,
>   };
>   
> +static const TypeInfo aspeed_ast1700_ast2700_info = {
> +    .name = TYPE_ASPEED_AST1700_AST2700,
> +    .parent = TYPE_ASPEED_AST1700,
> +};
> +

As discussed earlier, this type is not useful.


Thanks,

C.


>   
>   static void aspeed_ast1700_register_types(void)
>   {
>       type_register_static(&aspeed_ast1700_info);
> +    type_register_static(&aspeed_ast1700_ast2700_info);
>   }
>   
>   type_init(aspeed_ast1700_register_types);


