Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BC8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 06:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwyjB-0008Mj-JM; Wed, 17 Apr 2024 02:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=26d5=LW=kaod.org=clg@ozlabs.org>)
 id 1rwyj8-0008Lq-FE; Wed, 17 Apr 2024 02:25:02 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=26d5=LW=kaod.org=clg@ozlabs.org>)
 id 1rwyj4-0003m6-I9; Wed, 17 Apr 2024 02:25:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VK9qj56lPz4x3C;
 Wed, 17 Apr 2024 16:24:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VK9qc699gz4x1V;
 Wed, 17 Apr 2024 16:24:44 +1000 (AEST)
Message-ID: <4513c447-2ef3-4547-875b-5500067b44eb@kaod.org>
Date: Wed, 17 Apr 2024 08:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/i2c: Fix checkpatch line over 80 chars warnings
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
References: <20240416184722.28334-1-philmd@linaro.org>
 <20240416184722.28334-3-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240416184722.28334-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=26d5=LW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

Hello,

On 4/16/24 20:47, Philippe Mathieu-Daudé wrote:
> We are going to modify these lines, fix their style
> in order to avoid checkpatch.pl warnings:
> 
>    WARNING: line over 80 characters
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i2c/i2c.h            |  11 ++-
>   include/hw/nvram/eeprom_at24c.h |   6 +-
>   hw/arm/aspeed.c                 | 140 +++++++++++++++++++-------------
>   hw/nvram/eeprom_at24c.c         |   6 +-
>   4 files changed, 98 insertions(+), 65 deletions(-)
> 
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index c18a69e4b6..a1b3f4d179 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -31,7 +31,10 @@ struct I2CSlaveClass {
>       /* Master to slave. Returns non-zero for a NAK, 0 for success. */
>       int (*send)(I2CSlave *s, uint8_t data);
>   
> -    /* Master to slave (asynchronous). Receiving slave must call i2c_ack(). */
> +    /*
> +     * Master to slave (asynchronous).
> +     * Receiving slave must call i2c_ack().
> +     */
>       void (*send_async)(I2CSlave *s, uint8_t data);
>   
>       /*
> @@ -83,7 +86,8 @@ struct I2CPendingMaster {
>   };
>   
>   typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;
> -typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster) I2CPendingMasters;
> +typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster)
> +            I2CPendingMasters;
>   
>   struct I2CBus {
>       BusState qbus;
> @@ -176,7 +180,8 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>    * Create the device state structure, initialize it, put it on the
>    * specified @bus, and drop the reference to it (the device is realized).
>    */
> -I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
> +I2CSlave *i2c_slave_create_simple(I2CBus *bus,
> +                                  const char *name, uint8_t addr);
>   
>   /**
>    * Realize and drop a reference an I2C slave device
> diff --git a/include/hw/nvram/eeprom_at24c.h b/include/hw/nvram/eeprom_at24c.h
> index acb9857b2a..9d29f0a69a 100644
> --- a/include/hw/nvram/eeprom_at24c.h
> +++ b/include/hw/nvram/eeprom_at24c.h
> @@ -33,7 +33,9 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_size);
>    * @bus, and drop the reference to it (the device is realized). Copies the data
>    * from @init_rom to the beginning of the EEPROM memory buffer.
>    */
> -I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
> -                                const uint8_t *init_rom, uint32_t init_rom_size);
> +I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,
> +                                uint8_t address, uint32_t rom_size,
> +                                const uint8_t *init_rom,
> +                                uint32_t init_rom_size);
>   
>   #endif
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 93ca87fda2..8279ad748a 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -649,18 +649,23 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>           qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
>                                 qdev_get_gpio_in(DEVICE(led), 0));
>       }
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +                            "dps310", 0x76);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +                            "max31785", 0x52);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +                            "tmp423", 0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +                            "tmp423", 0x4c);
>   
>       /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
> -                     0x4a);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            TYPE_TMP105, 0x4a);
>   
>       /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
>        * good enough */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +                            "ds1338", 0x32);

If the definitions were on a single line, they would be more
readable IMHO. So I would do the opposit change ...

An alternate solution could be to define an array of devices
at the machine class level, something like
   struct i2c_device [
           const char *type;
           uint8_t bus;
           uint8_t addr;
   } devices[] = { ... };


Thanks,

C.


>       smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                             eeprom_buf);
> @@ -717,19 +722,20 @@ static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x50, 32768);
>   
>       /* The fp5280g2 expects a TMP112 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
> -                     0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
> -                     0x49);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> +                            TYPE_TMP105, 0x48);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> +                            TYPE_TMP105, 0x49);
>   
>       i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
>                        "pca9546", 0x70);
>       /* It expects a TMP112 but a TMP105 is compatible */
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), TYPE_TMP105,
> -                     0x4a);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> +                            TYPE_TMP105, 0x4a);
>   
>       /* It expects a ds3232 but a ds1338 is good enough */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "ds1338", 0x68);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +                            "ds1338", 0x68);
>   
>       /* It expects a pca9555 but a pca9552 is compatible */
>       create_pca9552(soc, 8, 0x30);
> @@ -745,12 +751,12 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>       create_pca9552(soc, 3, 0x61);
>   
>       /* The rainier expects a TMP275 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
> -                     0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
> -                     0x49);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
> -                     0x4a);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +                            TYPE_TMP105, 0x48);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +                            TYPE_TMP105, 0x49);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +                            TYPE_TMP105, 0x4a);
>       i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                                         "pca9546", 0x70);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
> @@ -758,10 +764,10 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
>       create_pca9552(soc, 4, 0x60);
>   
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
> -                     0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
> -                     0x49);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +                            TYPE_TMP105, 0x48);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +                            TYPE_TMP105, 0x49);
>       create_pca9552(soc, 5, 0x60);
>       create_pca9552(soc, 5, 0x61);
>       i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> @@ -769,12 +775,12 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
>   
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
> -                     0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
> -                     0x4a);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
> -                     0x4b);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +                            TYPE_TMP105, 0x48);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +                            TYPE_TMP105, 0x4a);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +                            TYPE_TMP105, 0x4b);
>       i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
>                                         "pca9546", 0x70);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
> @@ -788,18 +794,20 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>       create_pca9552(soc, 7, 0x33);
>       create_pca9552(soc, 7, 0x60);
>       create_pca9552(soc, 7, 0x61);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +                            "dps310", 0x76);
>       /* Bus 7: TODO si7021-a20@20 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
> -                     0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "max31785", 0x52);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +                            TYPE_TMP105, 0x48);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +                            "max31785", 0x52);
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
>   
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
> -                     0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
> -                     0x4a);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +                            TYPE_TMP105, 0x48);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +                            TYPE_TMP105, 0x4a);
>       at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
>                             64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
>       at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
> @@ -810,18 +818,22 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>       /* Bus 8: ucd90320@b */
>       /* Bus 8: ucd90320@c */
>   
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4d);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            "tmp423", 0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            "tmp423", 0x4d);
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
>   
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4d);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
> +                            "tmp423", 0x4c);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
> +                            "tmp423", 0x4d);
>       at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
>   
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
> -                     0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
> -                     0x49);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +                            TYPE_TMP105, 0x48);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +                            TYPE_TMP105, 0x49);
>       i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>                                         "pca9546", 0x70);
>       at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
> @@ -1012,7 +1024,8 @@ static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
>   {
>       AspeedSoCState *soc = bmc->soc;
>   
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15),
> +                            "tmp105", 0x4d);
>   }
>   
>   static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
> @@ -1028,23 +1041,34 @@ static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
>       /* I2C7 CPUVR MUX */
>       cpuvr_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                                           "pca9546", 0x70);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0), "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1), "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2), "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3), "pca9548", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0),
> +                            "pca9548", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1),
> +                            "pca9548", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2),
> +                            "pca9548", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3),
> +                            "pca9548", 0x72);
>   
>       /* I2C8 Thermal Diodes*/
>       therm_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
>                                           "pca9548", 0x70);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0), TYPE_LM75, 0x4C);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1), TYPE_LM75, 0x4C);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2), TYPE_LM75, 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3), TYPE_LM75, 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4), TYPE_LM75, 0x48);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0),
> +                            TYPE_LM75, 0x4C);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1),
> +                            TYPE_LM75, 0x4C);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2),
> +                            TYPE_LM75, 0x48);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3),
> +                            TYPE_LM75, 0x48);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4),
> +                            TYPE_LM75, 0x48);
>   
>       /* I2C9 Fan Controller (MAX31785) */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x52);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "max31785", 0x54);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            "max31785", 0x52);
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +                            "max31785", 0x54);
>   }
>   
>   static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index 3272068663..4db83d0dd6 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -148,8 +148,10 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_size)
>       return at24c_eeprom_init_rom(bus, address, rom_size, NULL, 0);
>   }
>   
> -I2CSlave *at24c_eeprom_init_rom(I2CBus *bus, uint8_t address, uint32_t rom_size,
> -                                const uint8_t *init_rom, uint32_t init_rom_size)
> +I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,
> +                                uint8_t address, uint32_t rom_size,
> +                                const uint8_t *init_rom,
> +                                uint32_t init_rom_size)
>   {
>       EEPROMState *s;
>   


