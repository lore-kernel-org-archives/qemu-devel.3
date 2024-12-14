Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAF5E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 10:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMOzl-0000Bl-AA; Sat, 14 Dec 2024 05:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMOzi-0000BI-Sp; Sat, 14 Dec 2024 05:03:30 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMOzg-0007Og-68; Sat, 14 Dec 2024 05:03:30 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Y9MGb11sJz4wvd;
 Sat, 14 Dec 2024 21:03:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y9MGM29XHz4w2R;
 Sat, 14 Dec 2024 21:03:07 +1100 (AEDT)
Message-ID: <aaf239fd-fa97-42b2-b3f5-dea0033079e2@kaod.org>
Date: Sat, 14 Dec 2024 11:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/71] hw/arm: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Tyrone Ting
 <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Eric Auger <eric.auger@redhat.com>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:MPS2 / MPS3" <qemu-arm@nongnu.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-20-richard.henderson@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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
In-Reply-To: <20241213190750.2513964-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=YvF0=TH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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

On 12/13/24 20:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/armsse.c            | 8 ++++----
>   hw/arm/armv7m.c            | 4 ++--
>   hw/arm/aspeed_soc_common.c | 2 +-
>   hw/arm/bcm2836.c           | 2 +-
>   hw/arm/fsl-imx25.c         | 2 +-
>   hw/arm/fsl-imx6.c          | 2 +-
>   hw/arm/fsl-imx6ul.c        | 2 +-
>   hw/arm/fsl-imx7.c          | 2 +-
>   hw/arm/integratorcp.c      | 2 +-
>   hw/arm/msf2-soc.c          | 2 +-
>   hw/arm/npcm7xx.c           | 2 +-
>   hw/arm/nrf51_soc.c         | 2 +-
>   hw/arm/smmu-common.c       | 2 +-
>   hw/arm/smmuv3.c            | 2 +-
>   hw/arm/stellaris.c         | 2 +-
>   hw/arm/strongarm.c         | 2 +-
>   hw/arm/xlnx-versal.c       | 2 +-
>   hw/arm/xlnx-zynqmp.c       | 2 +-
>   18 files changed, 22 insertions(+), 22 deletions(-)

For the aspeed part,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 58ed504b2b..1cd6b4a4b2 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -72,12 +72,12 @@ struct ARMSSEInfo {
>       bool has_cpu_pwrctrl;
>       bool has_sse_counter;
>       bool has_tcms;
> -    Property *props;
> +    const Property *props;
>       const ARMSSEDeviceInfo *devinfo;
>       const bool *irq_is_common;
>   };
>   
> -static Property iotkit_properties[] = {
> +static const Property iotkit_properties[] = {
>       DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
>       DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
> @@ -90,7 +90,7 @@ static Property iotkit_properties[] = {
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> -static Property sse200_properties[] = {
> +static const Property sse200_properties[] = {
>       DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
>       DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
> @@ -107,7 +107,7 @@ static Property sse200_properties[] = {
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> -static Property sse300_properties[] = {
> +static const Property sse300_properties[] = {
>       DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
>       DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 7c68525a9e..e20f719c9b 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -538,7 +538,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> -static Property armv7m_properties[] = {
> +static const Property armv7m_properties[] = {
>       DEFINE_PROP_STRING("cpu-type", ARMv7MState, cpu_type),
>       DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
> @@ -631,7 +631,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename,
>       qemu_register_reset(armv7m_reset, cpu);
>   }
>   
> -static Property bitband_properties[] = {
> +static const Property bitband_properties[] = {
>       DEFINE_PROP_UINT32("base", BitBandState, base, 0),
>       DEFINE_PROP_LINK("source-memory", BitBandState, source_memory,
>                        TYPE_MEMORY_REGION, MemoryRegion *),
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index a5ff33c46d..4221cacd51 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -139,7 +139,7 @@ static bool aspeed_soc_boot_from_emmc(AspeedSoCState *s)
>       return false;
>   }
>   
> -static Property aspeed_soc_properties[] = {
> +static const Property aspeed_soc_properties[] = {
>       DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
>       DEFINE_PROP_LINK("memory", AspeedSoCState, memory, TYPE_MEMORY_REGION,
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 40a379bc36..95e16806fa 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -18,7 +18,7 @@
>   #include "target/arm/cpu-qom.h"
>   #include "target/arm/gtimer.h"
>   
> -static Property bcm2836_enabled_cores_property =
> +static const Property bcm2836_enabled_cores_property =
>       DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
>   
>   static void bcm283x_base_init(Object *obj)
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 5ed87edfe4..48763b03fe 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -309,7 +309,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>                                   &s->iram_alias);
>   }
>   
> -static Property fsl_imx25_properties[] = {
> +static const Property fsl_imx25_properties[] = {
>       DEFINE_PROP_UINT32("fec-phy-num", FslIMX25State, phy_num, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index 85748cb233..236d15bc9c 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -481,7 +481,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>                                   &s->ocram_alias);
>   }
>   
> -static Property fsl_imx6_properties[] = {
> +static const Property fsl_imx6_properties[] = {
>       DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 19f443570b..1e0bbbb5d7 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -718,7 +718,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>                                   FSL_IMX6UL_OCRAM_ALIAS_ADDR, &s->ocram_alias);
>   }
>   
> -static Property fsl_imx6ul_properties[] = {
> +static const Property fsl_imx6ul_properties[] = {
>       DEFINE_PROP_UINT32("fec1-phy-num", FslIMX6ULState, phy_num[0], 0),
>       DEFINE_PROP_UINT32("fec2-phy-num", FslIMX6ULState, phy_num[1], 1),
>       DEFINE_PROP_BOOL("fec1-phy-connected", FslIMX6ULState, phy_connected[0],
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 9f2ef34555..0310c15b0c 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -736,7 +736,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>                                   &s->caam);
>   }
>   
> -static Property fsl_imx7_properties[] = {
> +static const Property fsl_imx7_properties[] = {
>       DEFINE_PROP_UINT32("fec1-phy-num", FslIMX7State, phy_num[0], 0),
>       DEFINE_PROP_UINT32("fec2-phy-num", FslIMX7State, phy_num[1], 1),
>       DEFINE_PROP_BOOL("fec1-phy-connected", FslIMX7State, phy_connected[0],
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index feb0dd63df..ee6c7e0c0d 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -694,7 +694,7 @@ static void integratorcp_machine_init(MachineClass *mc)
>   
>   DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
>   
> -static Property core_properties[] = {
> +static const Property core_properties[] = {
>       DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index c4999ebce3..5d7c3f2e5a 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -222,7 +222,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
>       create_unimplemented_device("usb", 0x40043000, 0x1000);
>   }
>   
> -static Property m2sxxx_soc_properties[] = {
> +static const Property m2sxxx_soc_properties[] = {
>       /*
>        * part name specifies the type of SmartFusion2 device variant(this
>        * property is for information purpose only.
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index af04c4b7ec..2960b63b59 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -810,7 +810,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>       create_unimplemented_device("npcm7xx.spix",         0xfb001000,   4 * KiB);
>   }
>   
> -static Property npcm7xx_properties[] = {
> +static const Property npcm7xx_properties[] = {
>       DEFINE_PROP_LINK("dram-mr", NPCM7xxState, dram, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index ac53441630..43fac8a8db 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -208,7 +208,7 @@ static void nrf51_soc_init(Object *obj)
>       s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
>   }
>   
> -static Property nrf51_soc_properties[] = {
> +static const Property nrf51_soc_properties[] = {
>       DEFINE_PROP_LINK("memory", NRF51State, board_memory, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
>       DEFINE_PROP_UINT32("sram-size", NRF51State, sram_size, NRF51822_SRAM_SIZE),
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3f82728758..6baa9d0fc3 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -934,7 +934,7 @@ static void smmu_base_reset_hold(Object *obj, ResetType type)
>       g_hash_table_remove_all(s->iotlb);
>   }
>   
> -static Property smmu_dev_properties[] = {
> +static const Property smmu_dev_properties[] = {
>       DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
>       DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
>                        TYPE_PCI_BUS, PCIBus *),
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 6e847e8773..026838f9ac 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1976,7 +1976,7 @@ static const VMStateDescription vmstate_smmuv3 = {
>       }
>   };
>   
> -static Property smmuv3_properties[] = {
> +static const Property smmuv3_properties[] = {
>       /*
>        * Stages of translation advertised.
>        * "1": Stage 1
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 376746251e..7fc13d96c9 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -438,7 +438,7 @@ static const VMStateDescription vmstate_stellaris_sys = {
>       }
>   };
>   
> -static Property stellaris_sys_properties[] = {
> +static const Property stellaris_sys_properties[] = {
>       DEFINE_PROP_UINT32("user0", ssys_state, user0, 0),
>       DEFINE_PROP_UINT32("user1", ssys_state, user1, 0),
>       DEFINE_PROP_UINT32("did0", ssys_state, did0, 0),
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index 612115ab5b..4c4ff21e80 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -1332,7 +1332,7 @@ static const VMStateDescription vmstate_strongarm_uart_regs = {
>       },
>   };
>   
> -static Property strongarm_uart_properties[] = {
> +static const Property strongarm_uart_properties[] = {
>       DEFINE_PROP_CHR("chardev", StrongARMUARTState, chr),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 3a1e2e29f1..3adbe7b1fb 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -968,7 +968,7 @@ static void versal_init(Object *obj)
>                                "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
>   }
>   
> -static Property versal_properties[] = {
> +static const Property versal_properties[] = {
>       DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
>       DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index ab2d50e31b..1082c62c30 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -857,7 +857,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> -static Property xlnx_zynqmp_props[] = {
> +static const Property xlnx_zynqmp_props[] = {
>       DEFINE_PROP_STRING("boot-cpu", XlnxZynqMPState, boot_cpu),
>       DEFINE_PROP_BOOL("secure", XlnxZynqMPState, secure, false),
>       DEFINE_PROP_BOOL("virtualization", XlnxZynqMPState, virt, false),


