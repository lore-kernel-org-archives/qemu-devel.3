Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2005E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 10:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMP21-0003QN-4a; Sat, 14 Dec 2024 05:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMP1x-0003Jo-Pa; Sat, 14 Dec 2024 05:05:49 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMP1v-0001TW-7l; Sat, 14 Dec 2024 05:05:49 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Y9MKH6kxTz4x0G;
 Sat, 14 Dec 2024 21:05:39 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y9MK21vkQz4wbx;
 Sat, 14 Dec 2024 21:05:25 +1100 (AEDT)
Message-ID: <af9fef2b-f79b-4ba9-a810-ca58ebc98d3f@kaod.org>
Date: Sat, 14 Dec 2024 11:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 60/71] hw/timer: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Michael Rolnik <mrolnik@gmail.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:ARM cores" <qemu-arm@nongnu.org>,
 "open list:OpenTitan" <qemu-riscv@nongnu.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-65-richard.henderson@linaro.org>
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
In-Reply-To: <20241213190750.2513964-65-richard.henderson@linaro.org>
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
>   hw/timer/a9gtimer.c          | 2 +-
>   hw/timer/allwinner-a10-pit.c | 2 +-
>   hw/timer/arm_mptimer.c       | 2 +-
>   hw/timer/arm_timer.c         | 2 +-
>   hw/timer/aspeed_timer.c      | 2 +-
>   hw/timer/avr_timer16.c       | 2 +-
>   hw/timer/grlib_gptimer.c     | 2 +-
>   hw/timer/hpet.c              | 2 +-
>   hw/timer/i8254_common.c      | 2 +-
>   hw/timer/ibex_timer.c        | 2 +-
>   hw/timer/mss-timer.c         | 2 +-
>   hw/timer/nrf51_timer.c       | 2 +-
>   hw/timer/pxa2xx_timer.c      | 2 +-
>   hw/timer/renesas_cmt.c       | 2 +-
>   hw/timer/renesas_tmr.c       | 2 +-
>   hw/timer/sifive_pwm.c        | 2 +-
>   hw/timer/slavio_timer.c      | 2 +-
>   hw/timer/sse-timer.c         | 2 +-
>   hw/timer/stm32f2xx_timer.c   | 2 +-
>   hw/timer/xilinx_timer.c      | 2 +-
>   20 files changed, 20 insertions(+), 20 deletions(-)


For the aspeed part,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.
> 
> diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
> index 8091ec18c7..c0a91bab0c 100644
> --- a/hw/timer/a9gtimer.c
> +++ b/hw/timer/a9gtimer.c
> @@ -373,7 +373,7 @@ static const VMStateDescription vmstate_a9_gtimer = {
>       }
>   };
>   
> -static Property a9_gtimer_properties[] = {
> +static const Property a9_gtimer_properties[] = {
>       DEFINE_PROP_UINT32("num-cpu", A9GTimerState, num_cpu, 0),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
> index d488e9782b..2904ccfb42 100644
> --- a/hw/timer/allwinner-a10-pit.c
> +++ b/hw/timer/allwinner-a10-pit.c
> @@ -188,7 +188,7 @@ static const MemoryRegionOps a10_pit_ops = {
>       .endianness = DEVICE_NATIVE_ENDIAN,
>   };
>   
> -static Property a10_pit_properties[] = {
> +static const Property a10_pit_properties[] = {
>       DEFINE_PROP_UINT32("clk0-freq", AwA10PITState, clk_freq[0], 0),
>       DEFINE_PROP_UINT32("clk1-freq", AwA10PITState, clk_freq[1], 0),
>       DEFINE_PROP_UINT32("clk2-freq", AwA10PITState, clk_freq[2], 0),
> diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
> index defa30b46d..6244a7a84f 100644
> --- a/hw/timer/arm_mptimer.c
> +++ b/hw/timer/arm_mptimer.c
> @@ -300,7 +300,7 @@ static const VMStateDescription vmstate_arm_mptimer = {
>       }
>   };
>   
> -static Property arm_mptimer_properties[] = {
> +static const Property arm_mptimer_properties[] = {
>       DEFINE_PROP_UINT32("num-cpu", ARMMPTimerState, num_cpu, 0),
>       DEFINE_PROP_END_OF_LIST()
>   };
> diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
> index 0940e03f1d..dfa034296c 100644
> --- a/hw/timer/arm_timer.c
> +++ b/hw/timer/arm_timer.c
> @@ -387,7 +387,7 @@ static const TypeInfo icp_pit_info = {
>       .instance_init = icp_pit_init,
>   };
>   
> -static Property sp804_properties[] = {
> +static const Property sp804_properties[] = {
>       DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
>       DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index 149f7cc5a6..4c16b5016e 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -674,7 +674,7 @@ static const VMStateDescription vmstate_aspeed_timer_state = {
>       }
>   };
>   
> -static Property aspeed_timer_properties[] = {
> +static const Property aspeed_timer_properties[] = {
>       DEFINE_PROP_LINK("scu", AspeedTimerCtrlState, scu, TYPE_ASPEED_SCU,
>                        AspeedSCUState *),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
> index 421920054f..2e3ce83c43 100644
> --- a/hw/timer/avr_timer16.c
> +++ b/hw/timer/avr_timer16.c
> @@ -542,7 +542,7 @@ static const MemoryRegionOps avr_timer16_ifr_ops = {
>       .impl = {.max_access_size = 1}
>   };
>   
> -static Property avr_timer16_properties[] = {
> +static const Property avr_timer16_properties[] = {
>       DEFINE_PROP_UINT8("id", struct AVRTimer16State, id, 0),
>       DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
>                          cpu_freq_hz, 0),
> diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
> index 6ef08f25fd..a7428ed938 100644
> --- a/hw/timer/grlib_gptimer.c
> +++ b/hw/timer/grlib_gptimer.c
> @@ -403,7 +403,7 @@ static void grlib_gptimer_realize(DeviceState *dev, Error **errp)
>       sysbus_init_mmio(sbd, &unit->iomem);
>   }
>   
> -static Property grlib_gptimer_properties[] = {
> +static const Property grlib_gptimer_properties[] = {
>       DEFINE_PROP_UINT32("frequency", GPTimerUnit, freq_hz,   40000000),
>       DEFINE_PROP_UINT32("irq-line",  GPTimerUnit, irq_line,  8),
>       DEFINE_PROP_UINT32("nr-timers", GPTimerUnit, nr_timers, 2),
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 5399f1b2a3..46886c379e 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -745,7 +745,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
>       qdev_init_gpio_out(dev, &s->pit_enabled, 1);
>   }
>   
> -static Property hpet_device_properties[] = {
> +static const Property hpet_device_properties[] = {
>       DEFINE_PROP_UINT8("timers", HPETState, num_timers, HPET_MIN_TIMERS),
>       DEFINE_PROP_BIT("msi", HPETState, flags, HPET_MSI_SUPPORT, false),
>       DEFINE_PROP_UINT32(HPET_INTCAP, HPETState, intcap, 0),
> diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
> index 28fdabc321..953c1e11eb 100644
> --- a/hw/timer/i8254_common.c
> +++ b/hw/timer/i8254_common.c
> @@ -238,7 +238,7 @@ static const VMStateDescription vmstate_pit_common = {
>       }
>   };
>   
> -static Property pit_common_properties[] = {
> +static const Property pit_common_properties[] = {
>       DEFINE_PROP_UINT32("iobase", PITCommonState, iobase,  -1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
> index 2bdcff532d..fba4466a89 100644
> --- a/hw/timer/ibex_timer.c
> +++ b/hw/timer/ibex_timer.c
> @@ -263,7 +263,7 @@ static const VMStateDescription vmstate_ibex_timer = {
>       }
>   };
>   
> -static Property ibex_timer_properties[] = {
> +static const Property ibex_timer_properties[] = {
>       DEFINE_PROP_UINT32("timebase-freq", IbexTimerState, timebase_freq, 10000),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
> index b66aed56ea..e5c5cd6a84 100644
> --- a/hw/timer/mss-timer.c
> +++ b/hw/timer/mss-timer.c
> @@ -279,7 +279,7 @@ static const VMStateDescription vmstate_mss_timer = {
>       }
>   };
>   
> -static Property mss_timer_properties[] = {
> +static const Property mss_timer_properties[] = {
>       /* Libero GUI shows 100Mhz as default for clocks */
>       DEFINE_PROP_UINT32("clock-frequency", MSSTimerState, freq_hz,
>                         100 * 1000000),
> diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
> index 35b0e62d5b..48fccec1bf 100644
> --- a/hw/timer/nrf51_timer.c
> +++ b/hw/timer/nrf51_timer.c
> @@ -379,7 +379,7 @@ static const VMStateDescription vmstate_nrf51_timer = {
>       }
>   };
>   
> -static Property nrf51_timer_properties[] = {
> +static const Property nrf51_timer_properties[] = {
>       DEFINE_PROP_UINT8("id", NRF51TimerState, id, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
> index 3234bbb1f4..345145bfa8 100644
> --- a/hw/timer/pxa2xx_timer.c
> +++ b/hw/timer/pxa2xx_timer.c
> @@ -549,7 +549,7 @@ static const VMStateDescription vmstate_pxa2xx_timer_regs = {
>       }
>   };
>   
> -static Property pxa25x_timer_dev_properties[] = {
> +static const Property pxa25x_timer_dev_properties[] = {
>       DEFINE_PROP_UINT32("freq", PXA2xxTimerInfo, freq, PXA25X_FREQ),
>       DEFINE_PROP_BIT("tm4", PXA2xxTimerInfo, flags,
>                       PXA2XX_TIMER_HAVE_TM4, false),
> diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
> index cd59b08c87..6d451fa86b 100644
> --- a/hw/timer/renesas_cmt.c
> +++ b/hw/timer/renesas_cmt.c
> @@ -253,7 +253,7 @@ static const VMStateDescription vmstate_rcmt = {
>       }
>   };
>   
> -static Property rcmt_properties[] = {
> +static const Property rcmt_properties[] = {
>       DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
> index a93e075fcd..890f803cf8 100644
> --- a/hw/timer/renesas_tmr.c
> +++ b/hw/timer/renesas_tmr.c
> @@ -463,7 +463,7 @@ static const VMStateDescription vmstate_rtmr = {
>       }
>   };
>   
> -static Property rtmr_properties[] = {
> +static const Property rtmr_properties[] = {
>       DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
> index 4602fc1a61..042c89c67a 100644
> --- a/hw/timer/sifive_pwm.c
> +++ b/hw/timer/sifive_pwm.c
> @@ -404,7 +404,7 @@ static const VMStateDescription vmstate_sifive_pwm = {
>       }
>   };
>   
> -static Property sifive_pwm_properties[] = {
> +static const Property sifive_pwm_properties[] = {
>       /* 0.5Ghz per spec after FSBL */
>       DEFINE_PROP_UINT64("clock-frequency", struct SiFivePwmState,
>                          freq_hz, 500000000ULL),
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index 12cb3bac97..32991f4436 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -420,7 +420,7 @@ static void slavio_timer_init(Object *obj)
>       }
>   }
>   
> -static Property slavio_timer_properties[] = {
> +static const Property slavio_timer_properties[] = {
>       DEFINE_PROP_UINT32("num_cpus",  SLAVIO_TIMERState, num_cpus,  0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
> index 115b0138c8..6b7a67941c 100644
> --- a/hw/timer/sse-timer.c
> +++ b/hw/timer/sse-timer.c
> @@ -440,7 +440,7 @@ static const VMStateDescription sse_timer_vmstate = {
>       }
>   };
>   
> -static Property sse_timer_properties[] = {
> +static const Property sse_timer_properties[] = {
>       DEFINE_PROP_LINK("counter", SSETimer, counter, TYPE_SSE_COUNTER, SSECounter *),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index 16b47887a5..d9d745cd76 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -298,7 +298,7 @@ static const VMStateDescription vmstate_stm32f2xx_timer = {
>       }
>   };
>   
> -static Property stm32f2xx_timer_properties[] = {
> +static const Property stm32f2xx_timer_properties[] = {
>       DEFINE_PROP_UINT64("clock-frequency", struct STM32F2XXTimerState,
>                          freq_hz, 1000000000),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 32a9df69e0..7fe3e83baa 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -242,7 +242,7 @@ static void xilinx_timer_init(Object *obj)
>       sysbus_init_irq(SYS_BUS_DEVICE(obj), &t->irq);
>   }
>   
> -static Property xilinx_timer_properties[] = {
> +static const Property xilinx_timer_properties[] = {
>       DEFINE_PROP_UINT32("clock-frequency", XpsTimerState, freq_hz, 62 * 1000000),
>       DEFINE_PROP_UINT8("one-timer-only", XpsTimerState, one_timer_only, 0),
>       DEFINE_PROP_END_OF_LIST(),


