Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B3AC71159
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 05:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS8AA-0006M9-2N; Thu, 19 Jun 2025 01:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0/7f=ZC=kaod.org=clg@ozlabs.org>)
 id 1uS8A7-0006LO-KV; Thu, 19 Jun 2025 01:50:11 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0/7f=ZC=kaod.org=clg@ozlabs.org>)
 id 1uS8A4-0007nY-EY; Thu, 19 Jun 2025 01:50:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bN8ny1JRgz4xDb;
 Thu, 19 Jun 2025 15:49:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bN8nq3M06z4wj2;
 Thu, 19 Jun 2025 15:49:50 +1000 (AEST)
Message-ID: <77c90f31-801f-48e7-b35c-db202a022769@kaod.org>
Date: Thu, 19 Jun 2025 07:49:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/aspeed: add Catalina machine type
To: Patrick Williams <patrick@stwcx.xyz>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250619034338.2678536-1-patrick@stwcx.xyz>
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
In-Reply-To: <20250619034338.2678536-1-patrick@stwcx.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=0/7f=ZC=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.067, RCVD_IN_DNSWL_MED=-2.3,
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

Hello Patrick,

On 6/19/25 05:43, Patrick Williams wrote:
> Add the 'catalina-bmc' machine type based on the kernel DTS[1] as of
> 6.16-rc2.  The i2c model is as complete as the current QEMU models
> support, but in some cases I substituted devices that are close enough
> for present functionality.  Strap registers are were verified with
> hardware.

The change looks good.

> This has been tested with an openbmc image built from [2].
> 
> [1]: https://github.com/torvalds/linux/blob/v6.16-rc2/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
> [2]: https://github.com/openbmc/openbmc/commit/5bc73ec261f981d5e586bda5ac78eb0cbd5f92b0

Could you please also provide a functional test using this build ?
(same question for fuji-bmc and fby35-bmc if still possible)

Thanks,

C.


> 
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> ---
>   hw/arm/Kconfig  |   1 +
>   hw/arm/aspeed.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 201 insertions(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f543d944c3..6ea86534d5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -532,6 +532,7 @@ config ASPEED_SOC
>       select I2C
>       select DPS310
>       select PCA9552
> +    select PCA9554
>       select SERIAL_MM
>       select SMBUS_EEPROM
>       select PCA954X
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index d0b333646e..b0965ef8a0 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -19,6 +19,7 @@
>   #include "hw/i2c/i2c_mux_pca954x.h"
>   #include "hw/i2c/smbus_eeprom.h"
>   #include "hw/gpio/pca9552.h"
> +#include "hw/gpio/pca9554.h"
>   #include "hw/nvram/eeprom_at24c.h"
>   #include "hw/sensor/tmp105.h"
>   #include "hw/misc/led.h"
> @@ -1003,6 +1004,180 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
>   }
>   
>   #define TYPE_TMP421 "tmp421"
> +#define TYPE_DS1338 "ds1338"
> +
> +/* Catalina hardware value */
> +#define CATALINA_BMC_HW_STRAP1 0x00002002
> +#define CATALINA_BMC_HW_STRAP2 0x00000800
> +
> +#define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +
> +static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
> +
> +    AspeedSoCState *soc = bmc->soc;
> +    I2CBus *i2c[16] = {};
> +    I2CSlave *i2c_mux;
> +
> +    /* busses 0-15 are all used. */
> +    for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
> +        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
> +    }
> +
> +    /* &i2c0 */
> +    /* i2c-mux@71 (PCA9546) on i2c0 */
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
> +
> +    /* i2c-mux@72 (PCA9546) on i2c0 */
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
> +
> +    /* i2c0mux1ch1 */
> +    /* io_expander7 - pca9535@20 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> +                            TYPE_PCA9552, 0x20);
> +    /* eeprom@50 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
> +
> +    /* i2c-mux@73 (PCA9546) on i2c0 */
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
> +
> +    /* i2c-mux@75 (PCA9546) on i2c0 */
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
> +
> +    /* i2c-mux@76 (PCA9546) on i2c0 */
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
> +
> +    /* i2c0mux4ch1 */
> +    /* io_expander8 - pca9535@21 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> +                            TYPE_PCA9552, 0x21);
> +    /* eeprom@50 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
> +
> +    /* i2c-mux@77 (PCA9546) on i2c0 */
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x77);
> +
> +
> +    /* &i2c1 */
> +    /* i2c-mux@70 (PCA9548) on i2c1 */
> +    i2c_mux = i2c_slave_create_simple(i2c[1], TYPE_PCA9548, 0x70);
> +    /* i2c1mux0ch0 */
> +    /* ina238@41 - no model */
> +    /* ina238@42 - no model */
> +    /* ina238@44 - no model */
> +    /* i2c1mux0ch1 */
> +    /* ina238@41 - no model */
> +    /* ina238@43 - no model */
> +    /* i2c1mux0ch4 */
> +    /* ltc4287@42 - no model */
> +    /* ltc4287@43 - no model */
> +
> +    /* i2c1mux0ch5 */
> +    /* eeprom@54 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB);
> +    /* tpm75@4f */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
> +
> +    /* i2c1mux0ch6 */
> +    /* io_expander5 - pca9554@27 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
> +                            TYPE_PCA9554, 0x27);
> +    /* io_expander6 - pca9555@25 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
> +                            TYPE_PCA9552, 0x25);
> +    /* eeprom@51 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB);
> +
> +    /* i2c1mux0ch7 */
> +    /* eeprom@53 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 7), 0x53, 8 * KiB);
> +    /* temperature-sensor@4b - tmp75 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
> +
> +    /* &i2c2 */
> +    /* io_expander0 - pca9555@20 */
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
> +    /* io_expander0 - pca9555@21 */
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
> +    /* io_expander0 - pca9555@27 */
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x27);
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
> +    /* eeprom@51 */
> +    at24c_eeprom_init(i2c[2], 0x51, 8 * KiB);
> +
> +    /* &i2c5 */
> +    /* i2c-mux@70 (PCA9548) on i2c5 */
> +    i2c_mux = i2c_slave_create_simple(i2c[5], TYPE_PCA9548, 0x70);
> +    /* i2c5mux0ch6 */
> +    /* eeprom@52 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB);
> +    /* i2c5mux0ch7 */
> +    /* ina230@40 - no model */
> +    /* ina230@41 - no model */
> +    /* ina230@44 - no model */
> +    /* ina230@45 - no model */
> +
> +    /* &i2c6 */
> +    /* io_expander3 - pca9555@21 */
> +    i2c_slave_create_simple(i2c[6], TYPE_PCA9552, 0x21);
> +    /* rtc@6f - nct3018y */
> +    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
> +
> +    /* &i2c9 */
> +    /* io_expander4 - pca9555@4f */
> +    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x4f);
> +    /* temperature-sensor@4b - tpm75 */
> +    i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[9], 0x50, 8 * KiB);
> +    /* eeprom@56 */
> +    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
> +
> +    /* &i2c10 */
> +    /* temperature-sensor@1f - tpm421 */
> +    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x1f);
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[10], 0x50, 8 * KiB);
> +
> +    /* &i2c11 */
> +    /* ssif-bmc@10 - no model */
> +
> +    /* &i2c12 */
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[12], 0x50, 8 * KiB);
> +
> +    /* &i2c13 */
> +    /* eeprom@50 */
> +    at24c_eeprom_init(i2c[13], 0x50, 8 * KiB);
> +    /* eeprom@54 */
> +    at24c_eeprom_init(i2c[13], 0x54, 256);
> +    /* eeprom@55 */
> +    at24c_eeprom_init(i2c[13], 0x55, 256);
> +    /* eeprom@57 */
> +    at24c_eeprom_init(i2c[13], 0x57, 256);
> +
> +    /* &i2c14 */
> +    /* io_expander9 - pca9555@10 */
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x10);
> +    /* io_expander10 - pca9555@11 */
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x11);
> +    /* io_expander11 - pca9555@12 */
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x12);
> +    /* io_expander12 - pca9555@13 */
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x13);
> +    /* io_expander13 - pca9555@14 */
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x14);
> +    /* io_expander14 - pca9555@15 */
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x15);
> +
> +    /* &i2c15 */
> +    /* temperature-sensor@1f - tmp421 */
> +    i2c_slave_create_simple(i2c[15], TYPE_TMP421, 0x1f);
> +    /* eeprom@52 */
> +    at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
> +}
>   
>   static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
>   {
> @@ -1585,6 +1760,27 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
> +static void aspeed_machine_catalina_class_init(ObjectClass *oc,
> +                                               const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Facebook Catalina BMC (Cortex-A7)";
> +    amc->soc_name  = "ast2600-a3";
> +    amc->hw_strap1 = CATALINA_BMC_HW_STRAP1;
> +    amc->hw_strap2 = CATALINA_BMC_HW_STRAP2;
> +    amc->fmc_model = "w25q01jvq";
> +    amc->spi_model = NULL;
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC2_ON;
> +    amc->i2c_init  = catalina_bmc_i2c_init;
> +    mc->auto_create_sdcard = true;
> +    mc->default_ram_size = CATALINA_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +    aspeed_machine_ast2600_class_emmc_init(oc);
> +}
> +
>   static void fby35_reset(MachineState *state, ResetType type)
>   {
>       AspeedMachineState *bmc = ASPEED_MACHINE(state);
> @@ -1877,6 +2073,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_bletchley_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("catalina-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_catalina_class_init,
>       }, {
>           .name          = MACHINE_TYPE_NAME("fby35-bmc"),
>           .parent        = MACHINE_TYPE_NAME("ast2600-evb"),


