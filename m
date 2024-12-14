Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DDDE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 10:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMP0W-0001Oe-NE; Sat, 14 Dec 2024 05:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMP0U-0001HL-LP; Sat, 14 Dec 2024 05:04:18 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMP0R-0008PE-46; Sat, 14 Dec 2024 05:04:18 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Y9MHW35k6z4wyw;
 Sat, 14 Dec 2024 21:04:07 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y9MHB4NGwz4wy9;
 Sat, 14 Dec 2024 21:03:50 +1100 (AEDT)
Message-ID: <a62b3cc6-32bb-4730-b4d5-edb8fb0a37cb@kaod.org>
Date: Sat, 14 Dec 2024 11:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/71] hw/misc: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Tyrone Ting
 <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Samuel Tardieu <sam@rfc1149.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:ARM cores" <qemu-arm@nongnu.org>,
 "open list:New World (mac99)" <qemu-ppc@nongnu.org>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-45-richard.henderson@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241213190750.2513964-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=YvF0=TH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/13/24 20:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/misc/a9scu.c                  | 2 +-
>   hw/misc/allwinner-h3-dramc.c     | 2 +-
>   hw/misc/allwinner-r40-dramc.c    | 2 +-
>   hw/misc/allwinner-sid.c          | 2 +-
>   hw/misc/applesmc.c               | 2 +-
>   hw/misc/arm11scu.c               | 2 +-
>   hw/misc/arm_l2x0.c               | 2 +-
>   hw/misc/arm_sysctl.c             | 2 +-
>   hw/misc/armsse-cpuid.c           | 2 +-
>   hw/misc/aspeed_hace.c            | 2 +-
>   hw/misc/aspeed_i3c.c             | 2 +-
>   hw/misc/aspeed_lpc.c             | 2 +-
>   hw/misc/aspeed_sbc.c             | 2 +-
>   hw/misc/aspeed_scu.c             | 2 +-
>   hw/misc/aspeed_sdmc.c            | 2 +-
>   hw/misc/bcm2835_cprman.c         | 2 +-
>   hw/misc/bcm2835_property.c       | 2 +-
>   hw/misc/debugexit.c              | 2 +-
>   hw/misc/eccmemctl.c              | 2 +-
>   hw/misc/empty_slot.c             | 2 +-
>   hw/misc/iotkit-secctl.c          | 2 +-
>   hw/misc/iotkit-sysctl.c          | 2 +-
>   hw/misc/iotkit-sysinfo.c         | 2 +-
>   hw/misc/ivshmem.c                | 4 ++--
>   hw/misc/led.c                    | 2 +-
>   hw/misc/mac_via.c                | 2 +-
>   hw/misc/macio/cuda.c             | 2 +-
>   hw/misc/macio/macio.c            | 4 ++--
>   hw/misc/macio/pmu.c              | 2 +-
>   hw/misc/mips_cmgcr.c             | 2 +-
>   hw/misc/mips_cpc.c               | 2 +-
>   hw/misc/mips_itu.c               | 2 +-
>   hw/misc/mos6522.c                | 2 +-
>   hw/misc/mps2-fpgaio.c            | 2 +-
>   hw/misc/mps2-scc.c               | 2 +-
>   hw/misc/msf2-sysreg.c            | 2 +-
>   hw/misc/npcm7xx_gcr.c            | 2 +-
>   hw/misc/nrf51_rng.c              | 2 +-
>   hw/misc/pci-testdev.c            | 2 +-
>   hw/misc/pvpanic-isa.c            | 2 +-
>   hw/misc/pvpanic-pci.c            | 2 +-
>   hw/misc/sifive_e_aon.c           | 2 +-
>   hw/misc/sifive_u_otp.c           | 2 +-
>   hw/misc/stm32l4x5_rcc.c          | 2 +-
>   hw/misc/tz-mpc.c                 | 2 +-
>   hw/misc/tz-msc.c                 | 2 +-
>   hw/misc/tz-ppc.c                 | 2 +-
>   hw/misc/unimp.c                  | 2 +-
>   hw/misc/xlnx-versal-cframe-reg.c | 4 ++--
>   hw/misc/xlnx-versal-cfu.c        | 4 ++--
>   hw/misc/xlnx-versal-xramc.c      | 2 +-
>   hw/misc/zynq_slcr.c              | 2 +-
>   52 files changed, 56 insertions(+), 56 deletions(-)



For the aspeed part,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.
> 
> diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
> index a40d5072de..e2d73edde8 100644
> --- a/hw/misc/a9scu.c
> +++ b/hw/misc/a9scu.c
> @@ -123,7 +123,7 @@ static const VMStateDescription vmstate_a9_scu = {
>       }
>   };
>   
> -static Property a9_scu_properties[] = {
> +static const Property a9_scu_properties[] = {
>       DEFINE_PROP_UINT32("num-cpu", A9SCUState, num_cpu, 1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
> index eeab0dc5d2..247bf62c43 100644
> --- a/hw/misc/allwinner-h3-dramc.c
> +++ b/hw/misc/allwinner-h3-dramc.c
> @@ -314,7 +314,7 @@ static void allwinner_h3_dramc_init(Object *obj)
>       sysbus_init_mmio(sbd, &s->dramphy_iomem);
>   }
>   
> -static Property allwinner_h3_dramc_properties[] = {
> +static const Property allwinner_h3_dramc_properties[] = {
>       DEFINE_PROP_UINT64("ram-addr", AwH3DramCtlState, ram_addr, 0x0),
>       DEFINE_PROP_UINT32("ram-size", AwH3DramCtlState, ram_size, 256 * MiB),
>       DEFINE_PROP_END_OF_LIST()
> diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
> index 3ae4890037..a51284ff91 100644
> --- a/hw/misc/allwinner-r40-dramc.c
> +++ b/hw/misc/allwinner-r40-dramc.c
> @@ -464,7 +464,7 @@ static void allwinner_r40_dramc_init(Object *obj)
>       sysbus_init_mmio(sbd, &s->dramphy_iomem);
>   }
>   
> -static Property allwinner_r40_dramc_properties[] = {
> +static const Property allwinner_r40_dramc_properties[] = {
>       DEFINE_PROP_UINT64("ram-addr", AwR40DramCtlState, ram_addr, 0x0),
>       DEFINE_PROP_UINT32("ram-size", AwR40DramCtlState, ram_size, 256), /* MiB */
>       DEFINE_PROP_END_OF_LIST()
> diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
> index 19ff17d24a..3a09dca111 100644
> --- a/hw/misc/allwinner-sid.c
> +++ b/hw/misc/allwinner-sid.c
> @@ -127,7 +127,7 @@ static void allwinner_sid_init(Object *obj)
>       sysbus_init_mmio(sbd, &s->iomem);
>   }
>   
> -static Property allwinner_sid_properties[] = {
> +static const Property allwinner_sid_properties[] = {
>       DEFINE_PROP_UUID_NODEFAULT("identifier", AwSidState, identifier),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 5b766277d6..9d0e273e33 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -350,7 +350,7 @@ static void applesmc_unrealize(DeviceState *dev)
>       }
>   }
>   
> -static Property applesmc_isa_properties[] = {
> +static const Property applesmc_isa_properties[] = {
>       DEFINE_PROP_UINT32(APPLESMC_PROP_IO_BASE, AppleSMCState, iobase,
>                          APPLESMC_DEFAULT_IOBASE),
>       DEFINE_PROP_STRING("osk", AppleSMCState, osk),
> diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
> index 17c36a0545..37feed9da7 100644
> --- a/hw/misc/arm11scu.c
> +++ b/hw/misc/arm11scu.c
> @@ -75,7 +75,7 @@ static void arm11_scu_init(Object *obj)
>       sysbus_init_mmio(sbd, &s->iomem);
>   }
>   
> -static Property arm11_scu_properties[] = {
> +static const Property arm11_scu_properties[] = {
>       DEFINE_PROP_UINT32("num-cpu", ARM11SCUState, num_cpu, 1),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
> index 1902ebd3bc..9c209f13b0 100644
> --- a/hw/misc/arm_l2x0.c
> +++ b/hw/misc/arm_l2x0.c
> @@ -173,7 +173,7 @@ static void l2x0_priv_init(Object *obj)
>       sysbus_init_mmio(dev, &s->iomem);
>   }
>   
> -static Property l2x0_properties[] = {
> +static const Property l2x0_properties[] = {
>       DEFINE_PROP_UINT32("cache-type", L2x0State, cache_type, 0x1c100100),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
> index 9c4dce350a..69e379fa10 100644
> --- a/hw/misc/arm_sysctl.c
> +++ b/hw/misc/arm_sysctl.c
> @@ -623,7 +623,7 @@ static void arm_sysctl_finalize(Object *obj)
>       g_free(s->db_clock_reset);
>   }
>   
> -static Property arm_sysctl_properties[] = {
> +static const Property arm_sysctl_properties[] = {
>       DEFINE_PROP_UINT32("sys_id", arm_sysctl_state, sys_id, 0),
>       DEFINE_PROP_UINT32("proc_id", arm_sysctl_state, proc_id, 0),
>       /* Daughterboard power supply voltages (as reported via SYS_CFG) */
> diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
> index e785a09051..b05bcdcabc 100644
> --- a/hw/misc/armsse-cpuid.c
> +++ b/hw/misc/armsse-cpuid.c
> @@ -92,7 +92,7 @@ static const MemoryRegionOps armsse_cpuid_ops = {
>       .valid.max_access_size = 4,
>   };
>   
> -static Property armsse_cpuid_props[] = {
> +static const Property armsse_cpuid_props[] = {
>       DEFINE_PROP_UINT32("CPUID", ARMSSECPUID, cpuid, 0),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index bc1d66ad80..5cefbadf9a 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -436,7 +436,7 @@ static void aspeed_hace_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(sbd, &s->iomem);
>   }
>   
> -static Property aspeed_hace_properties[] = {
> +static const Property aspeed_hace_properties[] = {
>       DEFINE_PROP_LINK("dram", AspeedHACEState, dram_mr,
>                        TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
> index 371ee7dba8..7f5a389864 100644
> --- a/hw/misc/aspeed_i3c.c
> +++ b/hw/misc/aspeed_i3c.c
> @@ -323,7 +323,7 @@ static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
>   
>   }
>   
> -static Property aspeed_i3c_device_properties[] = {
> +static const Property aspeed_i3c_device_properties[] = {
>       DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
> index f2d4ca6f43..bb9066b0f0 100644
> --- a/hw/misc/aspeed_lpc.c
> +++ b/hw/misc/aspeed_lpc.c
> @@ -454,7 +454,7 @@ static const VMStateDescription vmstate_aspeed_lpc = {
>       }
>   };
>   
> -static Property aspeed_lpc_properties[] = {
> +static const Property aspeed_lpc_properties[] = {
>       DEFINE_PROP_UINT32("hicr7", AspeedLPCState, hicr7, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index f5eb2a0e37..b97cf51fa1 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -136,7 +136,7 @@ static const VMStateDescription vmstate_aspeed_sbc = {
>       }
>   };
>   
> -static Property aspeed_sbc_properties[] = {
> +static const Property aspeed_sbc_properties[] = {
>       DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
>       DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 2c919349cf..ac33b8d6cb 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -602,7 +602,7 @@ static const VMStateDescription vmstate_aspeed_scu = {
>       }
>   };
>   
> -static Property aspeed_scu_properties[] = {
> +static const Property aspeed_scu_properties[] = {
>       DEFINE_PROP_UINT32("silicon-rev", AspeedSCUState, silicon_rev, 0),
>       DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),
>       DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 4bc9faf691..4980080f74 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -294,7 +294,7 @@ static const VMStateDescription vmstate_aspeed_sdmc = {
>       }
>   };
>   
> -static Property aspeed_sdmc_properties[] = {
> +static const Property aspeed_sdmc_properties[] = {
>       DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
>       DEFINE_PROP_BOOL("unlocked", AspeedSDMCState, unlocked, false),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index 63e1045abf..1a20cd0bc8 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -778,7 +778,7 @@ static const VMStateDescription cprman_vmstate = {
>       }
>   };
>   
> -static Property cprman_properties[] = {
> +static const Property cprman_properties[] = {
>       DEFINE_PROP_UINT32("xosc-freq-hz", BCM2835CprmanState, xosc_freq, 19200000),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index 8ca3128f29..09a6f2c6e3 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -551,7 +551,7 @@ static void bcm2835_property_realize(DeviceState *dev, Error **errp)
>       bcm2835_property_reset(dev);
>   }
>   
> -static Property bcm2835_property_props[] = {
> +static const Property bcm2835_property_props[] = {
>       DEFINE_PROP_UINT32("board-rev", BCM2835PropertyState, board_rev, 0),
>       DEFINE_PROP_STRING("command-line", BCM2835PropertyState, command_line),
>       DEFINE_PROP_END_OF_LIST()
> diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
> index c5c562fd93..639a8cc3e3 100644
> --- a/hw/misc/debugexit.c
> +++ b/hw/misc/debugexit.c
> @@ -56,7 +56,7 @@ static void debug_exit_realizefn(DeviceState *d, Error **errp)
>                                   isa->iobase, &isa->io);
>   }
>   
> -static Property debug_exit_properties[] = {
> +static const Property debug_exit_properties[] = {
>       DEFINE_PROP_UINT32("iobase", ISADebugExitState, iobase, 0x501),
>       DEFINE_PROP_UINT32("iosize", ISADebugExitState, iosize, 0x02),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
> index 0f68fbe1b6..4fc88bd4e5 100644
> --- a/hw/misc/eccmemctl.c
> +++ b/hw/misc/eccmemctl.c
> @@ -325,7 +325,7 @@ static void ecc_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> -static Property ecc_properties[] = {
> +static const Property ecc_properties[] = {
>       DEFINE_PROP_UINT32("version", ECCState, version, -1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
> index 37b0ddfb02..79572c5be0 100644
> --- a/hw/misc/empty_slot.c
> +++ b/hw/misc/empty_slot.c
> @@ -79,7 +79,7 @@ static void empty_slot_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>   }
>   
> -static Property empty_slot_properties[] = {
> +static const Property empty_slot_properties[] = {
>       DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
>       DEFINE_PROP_STRING("name", EmptySlot, name),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
> index 6e22f2aad6..abb6a963ca 100644
> --- a/hw/misc/iotkit-secctl.c
> +++ b/hw/misc/iotkit-secctl.c
> @@ -814,7 +814,7 @@ static const VMStateDescription iotkit_secctl_vmstate = {
>       },
>   };
>   
> -static Property iotkit_secctl_props[] = {
> +static const Property iotkit_secctl_props[] = {
>       DEFINE_PROP_UINT32("sse-version", IoTKitSecCtl, sse_version, 0),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
> index c1b357e6b7..23b49d7dff 100644
> --- a/hw/misc/iotkit-sysctl.c
> +++ b/hw/misc/iotkit-sysctl.c
> @@ -835,7 +835,7 @@ static const VMStateDescription iotkit_sysctl_vmstate = {
>       }
>   };
>   
> -static Property iotkit_sysctl_props[] = {
> +static const Property iotkit_sysctl_props[] = {
>       DEFINE_PROP_UINT32("sse-version", IoTKitSysCtl, sse_version, 0),
>       DEFINE_PROP_UINT32("CPUWAIT_RST", IoTKitSysCtl, cpuwait_rst, 0),
>       DEFINE_PROP_UINT32("INITSVTOR0_RST", IoTKitSysCtl, initsvtor0_rst,
> diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
> index aaa9305b2e..7d4eea6bfb 100644
> --- a/hw/misc/iotkit-sysinfo.c
> +++ b/hw/misc/iotkit-sysinfo.c
> @@ -131,7 +131,7 @@ static const MemoryRegionOps iotkit_sysinfo_ops = {
>       .valid.max_access_size = 4,
>   };
>   
> -static Property iotkit_sysinfo_props[] = {
> +static const Property iotkit_sysinfo_props[] = {
>       DEFINE_PROP_UINT32("SYS_VERSION", IoTKitSysInfo, sys_version, 0),
>       DEFINE_PROP_UINT32("SYS_CONFIG", IoTKitSysInfo, sys_config, 0),
>       DEFINE_PROP_UINT32("sse-version", IoTKitSysInfo, sse_version, 0),
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 5ce3fc0949..6d735ec29f 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1022,7 +1022,7 @@ static const VMStateDescription ivshmem_plain_vmsd = {
>       },
>   };
>   
> -static Property ivshmem_plain_properties[] = {
> +static const Property ivshmem_plain_properties[] = {
>       DEFINE_PROP_ON_OFF_AUTO("master", IVShmemState, master, ON_OFF_AUTO_OFF),
>       DEFINE_PROP_LINK("memdev", IVShmemState, hostmem, TYPE_MEMORY_BACKEND,
>                        HostMemoryBackend *),
> @@ -1077,7 +1077,7 @@ static const VMStateDescription ivshmem_doorbell_vmsd = {
>       },
>   };
>   
> -static Property ivshmem_doorbell_properties[] = {
> +static const Property ivshmem_doorbell_properties[] = {
>       DEFINE_PROP_CHR("chardev", IVShmemState, server_chr),
>       DEFINE_PROP_UINT32("vectors", IVShmemState, vectors, 1),
>       DEFINE_PROP_BIT("ioeventfd", IVShmemState, features, IVSHMEM_IOEVENTFD,
> diff --git a/hw/misc/led.c b/hw/misc/led.c
> index 4bb6ce8d29..76efdbc3f1 100644
> --- a/hw/misc/led.c
> +++ b/hw/misc/led.c
> @@ -101,7 +101,7 @@ static void led_realize(DeviceState *dev, Error **errp)
>       qdev_init_gpio_in(DEVICE(s), led_set_state_gpio_handler, 1);
>   }
>   
> -static Property led_properties[] = {
> +static const Property led_properties[] = {
>       DEFINE_PROP_STRING("color", LEDState, color),
>       DEFINE_PROP_STRING("description", LEDState, description),
>       DEFINE_PROP_BOOL("gpio-active-high", LEDState, gpio_active_high, true),
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index af2b2b1af3..a376a2b8a0 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -1322,7 +1322,7 @@ static const VMStateDescription vmstate_q800_via1 = {
>       }
>   };
>   
> -static Property mos6522_q800_via1_properties[] = {
> +static const Property mos6522_q800_via1_properties[] = {
>       DEFINE_PROP_DRIVE("drive", MOS6522Q800VIA1State, blk),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 1db7ebf3e2..cfc8afd1dc 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -554,7 +554,7 @@ static void cuda_init(Object *obj)
>                 DEVICE(obj), "adb.0");
>   }
>   
> -static Property cuda_properties[] = {
> +static const Property cuda_properties[] = {
>       DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, 0),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 3f449f91c0..7e3d5aa977 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -405,7 +405,7 @@ static const VMStateDescription vmstate_macio_newworld = {
>       }
>   };
>   
> -static Property macio_newworld_properties[] = {
> +static const Property macio_newworld_properties[] = {
>       DEFINE_PROP_BOOL("has-pmu", NewWorldMacIOState, has_pmu, false),
>       DEFINE_PROP_BOOL("has-adb", NewWorldMacIOState, has_adb, false),
>       DEFINE_PROP_END_OF_LIST()
> @@ -422,7 +422,7 @@ static void macio_newworld_class_init(ObjectClass *oc, void *data)
>       device_class_set_props(dc, macio_newworld_properties);
>   }
>   
> -static Property macio_properties[] = {
> +static const Property macio_properties[] = {
>       DEFINE_PROP_UINT64("frequency", MacIOState, frequency, 0),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> index 4b451e0af3..64bf44f67f 100644
> --- a/hw/misc/macio/pmu.c
> +++ b/hw/misc/macio/pmu.c
> @@ -760,7 +760,7 @@ static void pmu_init(Object *obj)
>       sysbus_init_mmio(d, &s->mem);
>   }
>   
> -static Property pmu_properties[] = {
> +static const Property pmu_properties[] = {
>       DEFINE_PROP_BOOL("has-adb", PMUState, has_adb, true),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
> index 04256aacdc..80ca224f76 100644
> --- a/hw/misc/mips_cmgcr.c
> +++ b/hw/misc/mips_cmgcr.c
> @@ -211,7 +211,7 @@ static const VMStateDescription vmstate_mips_gcr = {
>       },
>   };
>   
> -static Property mips_gcr_properties[] = {
> +static const Property mips_gcr_properties[] = {
>       DEFINE_PROP_UINT32("num-vp", MIPSGCRState, num_vps, 1),
>       DEFINE_PROP_INT32("gcr-rev", MIPSGCRState, gcr_rev, 0x800),
>       DEFINE_PROP_UINT64("gcr-base", MIPSGCRState, gcr_base, GCR_BASE_ADDR),
> diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
> index 2f7fb8167f..86ff0f7ad8 100644
> --- a/hw/misc/mips_cpc.c
> +++ b/hw/misc/mips_cpc.c
> @@ -163,7 +163,7 @@ static const VMStateDescription vmstate_mips_cpc = {
>       },
>   };
>   
> -static Property mips_cpc_properties[] = {
> +static const Property mips_cpc_properties[] = {
>       DEFINE_PROP_UINT32("num-vp", MIPSCPCState, num_vp, 0x1),
>       DEFINE_PROP_UINT64("vp-start-running", MIPSCPCState, vp_start_running, 0x1),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
> index c5214c8b30..d84a7dbf15 100644
> --- a/hw/misc/mips_itu.c
> +++ b/hw/misc/mips_itu.c
> @@ -533,7 +533,7 @@ static void mips_itu_reset(DeviceState *dev)
>       itc_reset_cells(s);
>   }
>   
> -static Property mips_itu_properties[] = {
> +static const Property mips_itu_properties[] = {
>       DEFINE_PROP_UINT32("num-fifo", MIPSITUState, num_fifo,
>                         ITC_FIFO_NUM_MAX),
>       DEFINE_PROP_UINT32("num-semaphores", MIPSITUState, num_semaphores,
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index 515f62e687..0225a5869b 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -696,7 +696,7 @@ static void mos6522_finalize(Object *obj)
>       timer_free(s->timers[1].timer);
>   }
>   
> -static Property mos6522_properties[] = {
> +static const Property mos6522_properties[] = {
>       DEFINE_PROP_UINT64("frequency", MOS6522State, frequency, 0),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
> index 20359254ba..2e8d1c721c 100644
> --- a/hw/misc/mps2-fpgaio.c
> +++ b/hw/misc/mps2-fpgaio.c
> @@ -319,7 +319,7 @@ static const VMStateDescription mps2_fpgaio_vmstate = {
>       },
>   };
>   
> -static Property mps2_fpgaio_properties[] = {
> +static const Property mps2_fpgaio_properties[] = {
>       /* Frequency of the prescale counter */
>       DEFINE_PROP_UINT32("prescale-clk", MPS2FPGAIO, prescale_clk, 20000000),
>       /* Number of LEDs controlled by LED0 register */
> diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
> index d45ff77bd6..f378b75571 100644
> --- a/hw/misc/mps2-scc.c
> +++ b/hw/misc/mps2-scc.c
> @@ -456,7 +456,7 @@ static const VMStateDescription mps2_scc_vmstate = {
>       }
>   };
>   
> -static Property mps2_scc_properties[] = {
> +static const Property mps2_scc_properties[] = {
>       /* Values for various read-only ID registers (which are specific
>        * to the board model or FPGA image)
>        */
> diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
> index b8dde198c6..0d7a713c76 100644
> --- a/hw/misc/msf2-sysreg.c
> +++ b/hw/misc/msf2-sysreg.c
> @@ -118,7 +118,7 @@ static const VMStateDescription vmstate_msf2_sysreg = {
>       }
>   };
>   
> -static Property msf2_sysreg_properties[] = {
> +static const Property msf2_sysreg_properties[] = {
>       /* default divisors in Libero GUI */
>       DEFINE_PROP_UINT8("apb0divisor", MSF2SysregState, apb0div, 2),
>       DEFINE_PROP_UINT8("apb1divisor", MSF2SysregState, apb1div, 2),
> diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
> index c4c4e246d7..17aeaf22cb 100644
> --- a/hw/misc/npcm7xx_gcr.c
> +++ b/hw/misc/npcm7xx_gcr.c
> @@ -229,7 +229,7 @@ static const VMStateDescription vmstate_npcm7xx_gcr = {
>       },
>   };
>   
> -static Property npcm7xx_gcr_properties[] = {
> +static const Property npcm7xx_gcr_properties[] = {
>       DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr, 0),
>       DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
> index 2d67f3f766..2b550a6bca 100644
> --- a/hw/misc/nrf51_rng.c
> +++ b/hw/misc/nrf51_rng.c
> @@ -219,7 +219,7 @@ static void nrf51_rng_reset(DeviceState *dev)
>   }
>   
>   
> -static Property nrf51_rng_properties[] = {
> +static const Property nrf51_rng_properties[] = {
>       DEFINE_PROP_UINT16("period_unfiltered_us", NRF51RNGState,
>               period_unfiltered_us, 167),
>       DEFINE_PROP_UINT16("period_filtered_us", NRF51RNGState,
> diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
> index 0b5f236a20..7927397a23 100644
> --- a/hw/misc/pci-testdev.c
> +++ b/hw/misc/pci-testdev.c
> @@ -319,7 +319,7 @@ static void qdev_pci_testdev_reset(DeviceState *dev)
>       pci_testdev_reset(d);
>   }
>   
> -static Property pci_testdev_properties[] = {
> +static const Property pci_testdev_properties[] = {
>       DEFINE_PROP_SIZE("membar", PCITestDevState, membar_size, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
> index 9a923b7869..824a2e4528 100644
> --- a/hw/misc/pvpanic-isa.c
> +++ b/hw/misc/pvpanic-isa.c
> @@ -98,7 +98,7 @@ static void build_pvpanic_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
>       aml_append(scope, dev);
>   }
>   
> -static Property pvpanic_isa_properties[] = {
> +static const Property pvpanic_isa_properties[] = {
>       DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x505),
>       DEFINE_PROP_UINT8("events", PVPanicISAState, pvpanic.events,
>                         PVPANIC_EVENTS),
> diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
> index 106d03ccd6..1c3eafc137 100644
> --- a/hw/misc/pvpanic-pci.c
> +++ b/hw/misc/pvpanic-pci.c
> @@ -53,7 +53,7 @@ static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
>       pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &ps->mr);
>   }
>   
> -static Property pvpanic_pci_properties[] = {
> +static const Property pvpanic_pci_properties[] = {
>       DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events,
>                         PVPANIC_EVENTS),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
> index f819fc10e6..c48429b131 100644
> --- a/hw/misc/sifive_e_aon.c
> +++ b/hw/misc/sifive_e_aon.c
> @@ -289,7 +289,7 @@ static void sifive_e_aon_init(Object *obj)
>       sysbus_init_irq(sbd, &r->wdog_irq);
>   }
>   
> -static Property sifive_e_aon_properties[] = {
> +static const Property sifive_e_aon_properties[] = {
>       DEFINE_PROP_UINT64("wdogclk-frequency", SiFiveEAONState, wdogclk_freq,
>                          SIFIVE_E_LFCLK_DEFAULT_FREQ),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
> index 8965f5c22a..32cd8e8dfb 100644
> --- a/hw/misc/sifive_u_otp.c
> +++ b/hw/misc/sifive_u_otp.c
> @@ -194,7 +194,7 @@ static const MemoryRegionOps sifive_u_otp_ops = {
>       }
>   };
>   
> -static Property sifive_u_otp_properties[] = {
> +static const Property sifive_u_otp_properties[] = {
>       DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
>       DEFINE_PROP_DRIVE("drive", SiFiveUOTPState, blk),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> index 59d428fa66..b61241d195 100644
> --- a/hw/misc/stm32l4x5_rcc.c
> +++ b/hw/misc/stm32l4x5_rcc.c
> @@ -1426,7 +1426,7 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, Error **errp)
>       clock_update(s->gnd, 0);
>   }
>   
> -static Property stm32l4x5_rcc_properties[] = {
> +static const Property stm32l4x5_rcc_properties[] = {
>       DEFINE_PROP_UINT64("hse_frequency", Stm32l4x5RccState,
>           hse_frequency, HSE_DEFAULT_FRQ),
>       DEFINE_PROP_UINT64("sai1_extclk_frequency", Stm32l4x5RccState,
> diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
> index 66a46a7b9f..b06eb9f119 100644
> --- a/hw/misc/tz-mpc.c
> +++ b/hw/misc/tz-mpc.c
> @@ -587,7 +587,7 @@ static const VMStateDescription tz_mpc_vmstate = {
>       }
>   };
>   
> -static Property tz_mpc_properties[] = {
> +static const Property tz_mpc_properties[] = {
>       DEFINE_PROP_LINK("downstream", TZMPC, downstream,
>                        TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
> index 82ccaa014a..96413a502d 100644
> --- a/hw/misc/tz-msc.c
> +++ b/hw/misc/tz-msc.c
> @@ -278,7 +278,7 @@ static const VMStateDescription tz_msc_vmstate = {
>       }
>   };
>   
> -static Property tz_msc_properties[] = {
> +static const Property tz_msc_properties[] = {
>       DEFINE_PROP_LINK("downstream", TZMSC, downstream,
>                        TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_LINK("idau", TZMSC, idau,
> diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
> index 922dcf7f63..1943d8d165 100644
> --- a/hw/misc/tz-ppc.c
> +++ b/hw/misc/tz-ppc.c
> @@ -305,7 +305,7 @@ static const VMStateDescription tz_ppc_vmstate = {
>       DEFINE_PROP_LINK("port[" #N "]", TZPPC, port[N].downstream, \
>                        TYPE_MEMORY_REGION, MemoryRegion *)
>   
> -static Property tz_ppc_properties[] = {
> +static const Property tz_ppc_properties[] = {
>       DEFINE_PROP_UINT32("NONSEC_MASK", TZPPC, nonsec_mask, 0),
>       DEFINE_PORT(0),
>       DEFINE_PORT(1),
> diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
> index 6cfc5727f0..62e1153627 100644
> --- a/hw/misc/unimp.c
> +++ b/hw/misc/unimp.c
> @@ -70,7 +70,7 @@ static void unimp_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
>   }
>   
> -static Property unimp_properties[] = {
> +static const Property unimp_properties[] = {
>       DEFINE_PROP_UINT64("size", UnimplementedDeviceState, size, 0),
>       DEFINE_PROP_STRING("name", UnimplementedDeviceState, name),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
> index 3fc838bd54..8281a9baff 100644
> --- a/hw/misc/xlnx-versal-cframe-reg.c
> +++ b/hw/misc/xlnx-versal-cframe-reg.c
> @@ -720,7 +720,7 @@ static const VMStateDescription vmstate_cframe_reg = {
>       }
>   };
>   
> -static Property cframe_regs_props[] = {
> +static const Property cframe_regs_props[] = {
>       DEFINE_PROP_LINK("cfu-fdro", XlnxVersalCFrameReg, cfg.cfu_fdro,
>                        TYPE_XLNX_CFI_IF, XlnxCfiIf *),
>       DEFINE_PROP_UINT32("blktype0-frames", XlnxVersalCFrameReg,
> @@ -771,7 +771,7 @@ static const VMStateDescription vmstate_cframe_bcast_reg = {
>       }
>   };
>   
> -static Property cframe_bcast_regs_props[] = {
> +static const Property cframe_bcast_regs_props[] = {
>       DEFINE_PROP_LINK("cframe0", XlnxVersalCFrameBcastReg, cfg.cframe[0],
>                        TYPE_XLNX_CFI_IF, XlnxCfiIf *),
>       DEFINE_PROP_LINK("cframe1", XlnxVersalCFrameBcastReg, cfg.cframe[1],
> diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
> index 94f85814c8..7cfdabdb8e 100644
> --- a/hw/misc/xlnx-versal-cfu.c
> +++ b/hw/misc/xlnx-versal-cfu.c
> @@ -426,7 +426,7 @@ static void cfu_fdro_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt)
>       }
>   }
>   
> -static Property cfu_props[] = {
> +static const Property cfu_props[] = {
>           DEFINE_PROP_LINK("cframe0", XlnxVersalCFUAPB, cfg.cframe[0],
>                            TYPE_XLNX_CFI_IF, XlnxCfiIf *),
>           DEFINE_PROP_LINK("cframe1", XlnxVersalCFUAPB, cfg.cframe[1],
> @@ -460,7 +460,7 @@ static Property cfu_props[] = {
>           DEFINE_PROP_END_OF_LIST(),
>   };
>   
> -static Property cfu_sfr_props[] = {
> +static const Property cfu_sfr_props[] = {
>           DEFINE_PROP_LINK("cfu", XlnxVersalCFUSFR, cfg.cfu,
>                            TYPE_XLNX_VERSAL_CFU_APB, XlnxVersalCFUAPB *),
>           DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
> index ad839ce7e9..a06b9fbc05 100644
> --- a/hw/misc/xlnx-versal-xramc.c
> +++ b/hw/misc/xlnx-versal-xramc.c
> @@ -218,7 +218,7 @@ static const VMStateDescription vmstate_xram_ctrl = {
>       }
>   };
>   
> -static Property xram_ctrl_properties[] = {
> +static const Property xram_ctrl_properties[] = {
>       DEFINE_PROP_UINT64("size", XlnxXramCtrl, cfg.size, 1 * MiB),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index ad814c3a79..ffa14ecb84 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -623,7 +623,7 @@ static const VMStateDescription vmstate_zynq_slcr = {
>       }
>   };
>   
> -static Property zynq_slcr_props[] = {
> +static const Property zynq_slcr_props[] = {
>       DEFINE_PROP_UINT8("boot-mode", ZynqSLCRState, boot_mode, 1),
>       DEFINE_PROP_END_OF_LIST(),
>   };


