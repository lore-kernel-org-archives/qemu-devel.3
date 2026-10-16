Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67219CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeKs-0003wD-Rl; Fri, 16 Oct 2026 05:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHeKJ-0003cU-Qk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:34:16 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHeKH-00067a-CV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:34:11 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3a0aaa0fd13so4702431a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792143248; x=1792748048; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jSCN7m5mEjvWZPuN+0La91R0EowYhqilZw+/IzNsOzQ=;
 b=FXAJUBxQL8c1YFnhuEpNTwdD/bmhCmNuCf0AUjGmPHqL136Kqpri3PuNQTxZ3IyfUf
 O5G/1/ZfOGh8EfkNS+rbORE/Rbf4Kb9aPm2GgX+VTe7COB6KaJG5ATETw7zVyrqu9zq4
 CyN+baDcbRh14UFwrVfc6SGIOKUlMNJcQ8gHahmd4h/R+PjiuSks83GcoEBwLo4QSu1q
 y5905SXZ1onUJXC46w85ngxaDaqJ/3jyyJnK/hBSUI8uiHEs/H5Qhx3DZiUzk9b00lwq
 oJpkWZ+Z0uN677Oc4ZGHx13krg5cte64RNHrRD+LswXHECsXsESyFqBAjp90raz1zEkl
 3H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792143248; x=1792748048;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jSCN7m5mEjvWZPuN+0La91R0EowYhqilZw+/IzNsOzQ=;
 b=XfLeBIoU08xPfHzXZdNKAE8L14doN4iqZEQc/1n1Un7N5L8oeO8mRZNTxSpccJFh3Y
 tAQK6ymy+OS/GzuPT0eoo9dnz3pe3OPkIhldKUgy/YaOWvRtagqBieq8nI5EYYPGQYfF
 qN9W0anU+th69HCZ4knMYCrLYDdbJYzfcBIItzWoOQHOo/iH9VpIQCeO/gVnbpGA0el4
 JEvv+ok+8jmsY0q1YXfzF3t6P2mq9cmQa+Yz4QzQJPI8y900Z4Z4FMXX42fjf2HAtuy2
 jeVH5IraYPpNmOHpdke4wFJEx5qlfZPOxzwY6Sd6yYe11/qDm3Av3A8DvU1c1yqZMwVI
 EsBw==
X-Gm-Message-State: AFq9FYJQBSI6TDOW1d6W5N304VNeWEuaT8zgKtaXR0kzty93DnDnjq+7
 r9T8PNlGPLfR1A8x93LZWIrrYZ3BoXIzU1ZbhaVQMzYlsOyeqqrAP5gh
X-Gm-Gg: AYBFou1RBReVWY8TWBGdGl0+I5MPG7NVJCql2gUnRkiDQyW+9GYLR9CNZKBb+OvxXTt
 yRXIHVRQVye7h5zEP7xs6Xa5Tr0Q6WlCZPRp8ZrZRDxaC1T0T7dXRJUcTb7n87X6vtqsjSwFUuJ
 efw+HB/n36kalMFnvxQHQjmFQYgRU2FBmLlxReksaNh3RmB4UGkPWl28zpPtce8WJNR/SJkoQrh
 w/lubhQPa756Aq2z+b125AMVKdetPGhUmUa3lIVaJ+Awops3Z1gb0XfE8km1lrmTt8CyVogP23V
 s0ruj1NoiI/faYQ1yjsZqhZZv9MI7VbZfBeUuTtkD1DV62wqbaVx0cSnOF6hOGgyj/3e8xfzGdk
 MGogNjH6FbZ/0rjtOo/JSczaGfKcis2OfVavhFJVOI/UkgzE3nu6/tAi1LuTsO+RafdhZ7moqYe
 Roap2CDUVT4FTdxy6jIheaoa5I85IYFEVzSPo1OQcNpYZnFCrB8GsewttQ08pZoU7VAbdTxlDdf
 D9gAB0SXYJrSB8=
X-Received: by 2002:a17:90b:28ce:b0:3ac:c03a:38b0 with SMTP id
 98e67ed59e1d1-3acc03aa056mr2074275a91.8.1792143247746; 
 Fri, 16 Oct 2026 02:34:07 -0700 (PDT)
Received: from JaminLin-PC.aspeed.com ([118.99.183.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd65497df08sm770600a12.6.2026.10.16.02.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:34:07 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:34:02 +0800
From: Jamin Lin <jaminlin1207@gmail.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 21/22] hw/arm: clemente: add Facebook Clemente BMC machine
Message-ID: <atHviuRVtIVythCk@JaminLin-PC.aspeed.com>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
 <20261015-bmc-clemente-v1-21-bf591886b5b6@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-bmc-clemente-v1-21-bf591886b5b6@free.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=jaminlin1207@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 15, 2026 at 01:57:59PM +0200, Emmanuel Blot via qemu development wrote:
> Add the 'clemente-bmc' machine type, an AST2600-based BMC, modelled
> from its device tree (aspeed-bmc-facebook-clemente.dts).
> 
> The board uses TMP75, TMP1075, LM75B and TMP421 temperature sensors,
> PCA9535, PCA9554 and PCA9555 IO expanders, PCA9546 and PCA9548 I2C
> muxes, AT24C EEPROMs and a DS1338 RTC.
> 
> Every device the Clemente device tree describes and QEMU already models
> is instantiated. The remaining ones (LM5066I power monitors, MAX31790
> fan controllers, MAX1363 ADCs, RAA228004 voltage regulators, the
> SLB9670 SPI TPM, SSIF-BMC and MCTP) have no QEMU model and are left
> documented as comments.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  docs/system/arm/aspeed.rst       |   1 +
>  hw/arm/aspeed_ast2600_clemente.c | 232 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/meson.build               |   1 +
>  3 files changed, 234 insertions(+)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index bbd3d9cdf4..db0035189b 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -34,6 +34,7 @@ AST2600 SoC based machines :
>  - ``bletchley-bmc``        Facebook Bletchley BMC
>  - ``fby35-bmc``            Facebook fby35 BMC
>  - ``catalina-bmc``         Facebook Catalina BMC
> +- ``clemente-bmc``         Facebook Clemente BMC
>  - ``sanmiguel-bmc``        Facebook SanMiguel BMC
>  - ``anacapa-bmc``          Facebook Anacapa BMC
>  - ``minerva-bmc``          Facebook Minerva BMC
> diff --git a/hw/arm/aspeed_ast2600_clemente.c b/hw/arm/aspeed_ast2600_clemente.c
> new file mode 100644
> index 0000000000..bf5a13bc49
> --- /dev/null
> +++ b/hw/arm/aspeed_ast2600_clemente.c
> @@ -0,0 +1,232 @@
> +/*
> + * Facebook Clemente BMC
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Current limitations: the following devices from the device tree have no
> + * QEMU model and are therefore not emulated:
> + *   - ti,lm5066i power monitors
> + *   - maxim,max31790 fan controllers
> + *   - maxim,max1363 ADCs (leak sensors)
> + *   - renesas,raa228004 voltage regulators
> + *   - infineon,slb9670 TPM (SPI)
> + *   - ssif-bmc SSIF interface
> + *   - mctp-i2c-controller MCTP endpoints
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/aspeed.h"
> +#include "hw/arm/aspeed_soc.h"
> +#include "hw/i2c/i2c_mux_pca954x.h"
> +#include "hw/gpio/pca9552.h"
> +#include "hw/gpio/pca9554.h"
> +#include "hw/nvram/eeprom_at24c.h"
> +#include "hw/rtc/ds1338.h"
> +#include "hw/sensor/tmp105.h"
> +#include "hw/sensor/tmp421.h"
> +
> +/* Clemente hardware values. */
> +#define CLEMENTE_BMC_HW_STRAP1 0x00002002
> +#define CLEMENTE_BMC_HW_STRAP2 0x00000800
> +#define CLEMENTE_BMC_RAM_SIZE (2 * GiB)
> +
> +/*
> + * E1.S backplane hanging off a PCA9546 channel: an FRU EEPROM plus a
> + * second PCA9546 fronting per-drive NVMe SSD FRU EEPROMs.
> + */
> +static void clemente_e1s_backplane_init(I2CBus *bus)
> +{
> +    /* eeprom@56 - atmel,24c128 */
> +    at24c_eeprom_init(bus, 0x56, 16 * KiB);
> +
> +    /* i2c-mux@74 - PCA9546 */
> +    I2CSlave *mux = i2c_slave_create_simple(bus, TYPE_PCA9546, 0x74);
> +    /* eeprom@53 - atmel,24c02, channels 0 and 2 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(mux, 0), 0x53, 256);
> +    at24c_eeprom_init(pca954x_i2c_get_bus(mux, 2), 0x53, 256);
> +}
> +
> +/*
> + * IO Mezzanine hanging off a PCA9546 channel: an I/O expander plus the
> + * mezzanine and OSFP FRU EEPROMs.
> + */
> +static void clemente_io_mezz_init(I2CBus *bus, uint8_t exp_addr)
> +{
> +    /* gpio@20/21 - nxp,pca9535 */
> +    i2c_slave_create_simple(bus, TYPE_PCA9535, exp_addr);
> +    /* eeprom@50 - atmel,24c64 (mezzanine FRU) */
> +    at24c_eeprom_init(bus, 0x50, 8 * KiB);
> +    /* eeprom@52 - atmel,24c128 (OSFP FRU) */
> +    at24c_eeprom_init(bus, 0x52, 16 * KiB);
> +}
> +
> +static void clemente_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    /* Reference: aspeed-bmc-facebook-clemente.dts */
> +
> +    AspeedSoCState *soc = bmc->soc;
> +    I2CBus *i2c[16] = {};
> +    I2CSlave *i2c_mux;
> +
> +    for (unsigned idx = 0; idx < ARRAY_SIZE(i2c); idx++) {
> +        i2c[idx] = aspeed_i2c_get_bus(&soc->i2c, idx);
> +    }
> +
> +    /* &i2c0 */
> +    /* i2c-mux@71 (PCA9546) */
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
> +    /* channel 1 - HDD FRU eeprom@56 and E1.S backplane */
> +    clemente_e1s_backplane_init(pca954x_i2c_get_bus(i2c_mux, 1));
> +
> +    /* i2c-mux@72 (PCA9546) */
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
> +    /* channel 1 - IO Mezz 0 (io_expander7 @20) */
> +    clemente_io_mezz_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x20);
> +
> +    /* i2c-mux@73 (PCA9546) - channels empty */
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
> +
> +    /* i2c-mux@75 (PCA9546) */
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
> +    /* channel 1 - HDD FRU eeprom@56 and E1.S backplane */
> +    clemente_e1s_backplane_init(pca954x_i2c_get_bus(i2c_mux, 1));
> +
> +    /* i2c-mux@76 (PCA9546) */
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
> +    /* channel 1 - IO Mezz 1 (io_expander8 @21) */
> +    clemente_io_mezz_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x21);
> +
> +    /* i2c-mux@77 (PCA9546) */
> +    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x77);
> +    /* channel 1 - boot drive FRU eeprom@53 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x53, 256);
> +
> +    /* &i2c1 */
> +    /* power-monitor@12/14 - ti,lm5066i (no model) */
> +    /* fan-controller@20/23/2c/2f - maxim,max31790 (no model) */
> +    /* adc@34/35 - maxim,max1363 (no model) */
> +    /* temperature-sensor@4e - ti,tmp1075 */
> +    i2c_slave_create_simple(i2c[1], TYPE_TMP1075, 0x4e);
> +    /* eeprom@50 - atmel,24c02 (PDB FRU) */
> +    at24c_eeprom_init(i2c[1], 0x50, 256);
> +    /* vrm@60/61 - renesas,raa228004 (no model) */
> +    /* i2c-mux@70 (PCA9548) - interposer */
> +    i2c_mux = i2c_slave_create_simple(i2c[1], TYPE_PCA9548, 0x70);
> +    /* channel 5 - interposer */
> +    /* temperature-sensor@4f - ti,tmp75 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
> +    /* eeprom@54 - atmel,24c64 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB);
> +    /* channel 6 - io_expander5 gpio@27 - nxp,pca9554 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
> +                            TYPE_PCA9554, 0x27);
> +    /* channel 7 - FIO */
> +    /* temperature-sensor@4b - ti,tmp75 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
> +    /* eeprom@51 - atmel,24c64 */
> +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 7), 0x51, 8 * KiB);
> +
> +    /* &i2c2 */
> +    /* gpio@20/21/27 - nxp,pca9555 */
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x20);
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x21);
> +    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x27);
> +    /* eeprom@50/51 - atmel,24c64 (module aux) */
> +    at24c_eeprom_init(i2c[2], 0x50, 8 * KiB);
> +    at24c_eeprom_init(i2c[2], 0x51, 8 * KiB);
> +
> +    /* &i2c3 - empty */
> +    /* &i2c4 - empty */
> +    /* &i2c5 - empty */
> +
> +    /* &i2c6 */
> +    /* gpio@21 - nxp,pca9555 */
> +    i2c_slave_create_simple(i2c[6], TYPE_PCA9555, 0x21);
> +    /* rtc@6f - nuvoton,nct3018y */
> +    i2c_slave_create_simple(i2c[6], TYPE_DS1338, 0x6f);
> +
> +    /* &i2c7 - empty */
> +    /* &i2c8 - empty */
> +
> +    /* &i2c9 */
> +    /* temperature-sensor@4b - national,lm75b */
> +    i2c_slave_create_simple(i2c[9], TYPE_LM75B, 0x4b);
> +    /* gpio@4f - nxp,pca9555 */
> +    i2c_slave_create_simple(i2c[9], TYPE_PCA9555, 0x4f);
> +    /* eeprom@50 - atmel,24c64 (SCM FRU) */
> +    at24c_eeprom_init(i2c[9], 0x50, 8 * KiB);
> +    /* eeprom@56 - atmel,24c64 (BSM FRU) */
> +    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
> +
> +    /* &i2c10 */
> +    /* mctp@10 - mctp-i2c-controller (no model) */
> +    /* temperature-sensor@1f - ti,tmp421 (OCP NIC0) */
> +    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x1f);
> +    /* eeprom@50 - atmel,24c64 (OCP NIC0 FRU) */
> +    at24c_eeprom_init(i2c[10], 0x50, 8 * KiB);
> +
> +    /* &i2c11 */
> +    /* ssif-bmc@10 - ssif-bmc (no model) */
> +
> +    /* &i2c12 */
> +    /* eeprom@50 - atmel,24c64 (HPM 1 FRU) */
> +    at24c_eeprom_init(i2c[12], 0x50, 8 * KiB);
> +    /* eeprom@54/55 - atmel,24c02 (CBC 2/3 FRU) */
> +    at24c_eeprom_init(i2c[12], 0x54, 256);
> +    at24c_eeprom_init(i2c[12], 0x55, 256);
> +
> +    /* &i2c13 */
> +    /* eeprom@50 - atmel,24c64 (HPM FRU) */
> +    at24c_eeprom_init(i2c[13], 0x50, 8 * KiB);
> +    /* eeprom@54/55 - atmel,24c02 (CBC 0/1 FRU) */
> +    at24c_eeprom_init(i2c[13], 0x54, 256);
> +    at24c_eeprom_init(i2c[13], 0x55, 256);
> +    /* eeprom@57 - atmel,24c02 (HMC FRU) */
> +    at24c_eeprom_init(i2c[13], 0x57, 256);
> +
> +    /* &i2c14 */
> +    /* gpio@10/11/12/13/14 - nxp,pca9555 (PDB CPLD) */
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x10);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x11);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x12);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x13);
> +    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x14);
> +
> +    /* &i2c15 */
> +    /* mctp@10 - mctp-i2c-controller (no model) */
> +    /* temperature-sensor@1f - ti,tmp421 (OCP NIC1) */
> +    i2c_slave_create_simple(i2c[15], TYPE_TMP421, 0x1f);
> +    /* eeprom@52 - atmel,24c64 (OCP NIC1 FRU) */
> +    at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
> +}
> +
> +static void aspeed_machine_clemente_class_init(ObjectClass *oc,
> +                                               const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Facebook Clemente BMC (Cortex-A7)";
> +    amc->soc_name  = "ast2600-a3";
> +    amc->hw_strap1 = CLEMENTE_BMC_HW_STRAP1;
> +    amc->hw_strap2 = CLEMENTE_BMC_HW_STRAP2;
> +    amc->fmc_model = "mx66l1g45g";
> +    amc->spi_model = NULL;
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
> +    amc->i2c_init  = clemente_bmc_i2c_init;
> +    mc->default_ram_size = CLEMENTE_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +
> +static const TypeInfo aspeed_ast2600_clemente_types[] = {
> +    {
> +        .name          = MACHINE_TYPE_NAME("clemente-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_clemente_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(aspeed_ast2600_clemente_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index a9e8270b85..4189de2aaa 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -59,6 +59,7 @@ arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>    'aspeed_ast2600_anacapa.c',
>    'aspeed_ast2600_bletchley.c',
>    'aspeed_ast2600_catalina.c',
> +  'aspeed_ast2600_clemente.c',
>    'aspeed_ast2600_evb.c',
>    'aspeed_ast2600_fby35.c',
>    'aspeed_ast2600_fuji.c',
> 
> -- 
> 2.53.0-Meta
> 
> 
Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>

