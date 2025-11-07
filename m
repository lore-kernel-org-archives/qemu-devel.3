Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182C0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHMCe-0005zt-Vy; Fri, 07 Nov 2025 08:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHMCc-0005zd-VF
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:08:30 -0500
Received: from 6.mo552.mail-out.ovh.net ([188.165.49.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHMCa-0003pO-MV
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:08:30 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.178])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d2zrp0935z6PgJ;
 Fri,  7 Nov 2025 13:08:26 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 7 Nov
 2025 14:08:25 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004049ce4fe-3185-4661-b4f8-67b931c64e90,
 22B515FCB2325FA901564F8AB94FB8FB00D14EB6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <570ec70e-1f00-4649-9cd4-fa3e8acab251@kaod.org>
Date: Fri, 7 Nov 2025 14:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] hw/arm/aspeed: Attach LTPI controller to AST27X0
 platform
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-3-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251105035859.3709907-3-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: afa33f2e-cf31-48c0-bae3-e81f14c57ea4
X-Ovh-Tracer-Id: 17242312649889516466
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG2jesCy/e0YJf+nF+KVlQAUyehFIVAJHV6oee6jvD6ttuy+gSweyOaKFyprWp63/tEXdO3fXlDSgLFLGLaLCG1ugbR3+2zZGS39ccfUOJIoimqnpbCMgB6x85Jh+o8TdcGFCCi4kbnhzApNb4NSL0tM0zqMWWzUx1fkZgqt8Rd+YVDIjpL9TUFjfAk01rGa3ao4S3XraGTKc943KJIYvDaOVKHIG0S4u73sIBaDCbGRb0OOlXlaP499w3b/dGqopA+3xc5NSsQqEzm4IDiRBpr+Fb4O0EYctI1EM0VEKgn5e+AEu6EnWuUTN/q7Un9YQgcVhknWrh3GIkTNggobketraraB8JvHcRlA0zaC69BjuT2YQgMM/l0vaaRUuK4/fvco8Gin4fvervsYQANr8QgzfaxdWkQSkA/cmUjvV+z3oBelKRIYh4Tz6u8Rrgfrhpqvhhwl5PpcCTB1XBD4nench3i3/yLnDYvcN8EEa2LciabFYHbvyEXu3eGrtZgPpqzphoZRaCd0kSR3cmGqO+Gwqb9/jsG6jAMOxWB5WR3k2p6inAU/zg+FGmc1DCSGMDZyrkAjEAJSjppUmN9ktaPd+zEexgzOmAyMXUGFRUS980RrmxZV4DSTkILMDc9LIVpvSrhjDRAAoKz8qehTdeu62bBIv2Cn7yFkXHmNIszCw
DKIM-Signature: a=rsa-sha256; bh=7vbg/C8jBpBYvX2Q3L7xOhADtcKPUXy86OCDeBblRx8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762520906; v=1;
 b=gz3sV43AKEjSbJ7jnIQXnF9xsNp7o+nLyjx5Ja0UKQLueQJVLUWaJ8FlAhVd4h75ewm64Yye
 yHib/dByvvz4s5q0E3eIxFUV7YSRWjBKQ8SwS5o4JnC7GmXGy5ur5BDUHzrkoL04vneVFqx9Dun
 b6Oifch0yxGxI/V8wEPh9gXY6S/irarf582aap7lYsa2hpqazdAITDg4914qPeTzkP5gitRlTk4
 IzZMdPkWslrWcAKhSXJqTKnG4XDxt3Tp9YMsrHoLnSrHI16+8pjFXFoP6GRfsEJpEA7mtGZygP4
 +PzKpIj8t+e0aad/GW6EaM2VaRmcVncQ1mnkZCLJrzZsw==
Received-SPF: pass client-ip=188.165.49.222; envelope-from=clg@kaod.org;
 helo=6.mo552.mail-out.ovh.net
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
> Connect the LTPI controller device (representing the AST1700 I/O
> expander) to the AST27X0 SoC model. This patch sets up the memory
> mapping and device registration according to the AST2700 SoC design,
> where the LTPI controller is exposed at fixed MMIO regions.
> 
> This change only handles device instantiation and integration,
> without implementing the controller's internal logic.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h |  5 +++++
>   hw/arm/aspeed_ast27x0.c     | 18 ++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 4b8e599f1a..bae60d85ea 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -42,6 +42,7 @@
>   #include "hw/fsi/aspeed_apb2opb.h"
>   #include "hw/char/serial-mm.h"
>   #include "hw/intc/arm_gicv3.h"
> +#include "hw/misc/aspeed_ltpi.h"
>   
>   #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
>   
> @@ -53,6 +54,7 @@
>   #define ASPEED_UARTS_NUM 13
>   #define ASPEED_JTAG_NUM  2
>   #define ASPEED_PCIE_NUM  3
> +#define ASPEED_IOEXP_NUM 2
>   
>   struct AspeedSoCState {
>       DeviceState parent;
> @@ -110,6 +112,7 @@ struct AspeedSoCState {
>       UnimplementedDeviceState ltpi;
>       UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>       AspeedAPB2OPBState fsi[2];
> +    AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
>   };
>   
>   #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -275,6 +278,8 @@ enum {
>       ASPEED_GIC_REDIST,
>       ASPEED_DEV_IPC0,
>       ASPEED_DEV_IPC1,
> +    ASPEED_DEV_LTPI_CTRL1,
> +    ASPEED_DEV_LTPI_CTRL2,
>   };
>   
>   const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index c484bcd4e2..c0d8639bde 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -86,6 +86,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_UART10]    =  0x14C33900,
>       [ASPEED_DEV_UART11]    =  0x14C33A00,
>       [ASPEED_DEV_UART12]    =  0x14C33B00,
> +    [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
> +    [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
>       [ASPEED_DEV_WDT]       =  0x14C37000,
>       [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
>       [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
> @@ -543,6 +545,10 @@ static void aspeed_soc_ast2700_init(Object *obj)
>           object_property_set_int(OBJECT(&s->pcie[i]), "id", i, &error_abort);
>       }
>   
> +    for (i = 0; i < ASPEED_IOEXP_NUM; i++) {
> +        object_initialize_child(obj, "ltpi-ctrl[*]",
> +                                &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
> +    }
>       object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "ltpi", &s->ltpi,
> @@ -688,6 +694,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       g_autofree char *name = NULL;
>       qemu_irq irq;
>       int uart;
> +    AspeedLTPIState *ltpi_ctrl;
> +    hwaddr ltpi_base;

These 2 variable declarations could be moved under the loop introduced
below.


Thanks,

C.


>   
>       /* Default boot region (SPI memory or ROMs) */
>       memory_region_init(&s->spi_boot_container, OBJECT(s),
> @@ -1021,6 +1029,16 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    /* LTPI controller */
> +    for (i = 0; i < ASPEED_IOEXP_NUM; i++) {
> +        ltpi_ctrl = ASPEED_LTPI(&s->ltpi_ctrl[i]);
> +        ltpi_base = sc->memmap[ASPEED_DEV_LTPI_CTRL1 + i];
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(ltpi_ctrl), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
> +    }
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
>                                     "aspeed.dpmcu",
>                                     sc->memmap[ASPEED_DEV_DPMCU],


