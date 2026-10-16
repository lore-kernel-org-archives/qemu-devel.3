Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C0FCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeJX-00034Z-KM; Fri, 16 Oct 2026 05:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHeJJ-0002lY-UR
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:33:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xHeJG-0005no-Mb
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:33:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8917c712f32so2968588b3a.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792143184; x=1792747984; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XZVXOzc0+QDUSt2U/vLeHsTlzwDxNo1VqQyjXGN4axg=;
 b=l1tyywZ7r+PSUr0DVoP0+oGql51JRWhpNg2lP28uuOx+YSU7wW8F41BwyIpixGhCWF
 8TVdrzTx3fxutejjn1Ld7GGSAZQF2f2qHKnVdYPWr2P32JeRewJ0h3HptuC6tPi7F05U
 +hTbR7NxiPdWvZFf9joe5ZblSIJHssWzRCfXc0/iUv/qxPBs3iZA/vDTA/6+7yln094F
 lqr5i0ROFQv61YAt6qSEUHEx/InyAyfkVcHRNlNjzB4za9RVJxcoEIooJqV4IXlkiIyO
 tVlloj2mYZVZgcJge5ToJjLZxq/lON0L4OQ78vl7sW/t/cd+0pFP3avIuflqo6fJ0Z51
 gsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792143184; x=1792747984;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XZVXOzc0+QDUSt2U/vLeHsTlzwDxNo1VqQyjXGN4axg=;
 b=dAqgv1k8RdaEsThzi47RAN5UgUgNVVPFvAHPq8s7ze3FVS95qsUzZNCj7udwQxtUIs
 +Ai5yWnbKXyFKUy0KHRCfwAqHNJFyDX/aKvZ554hZdvLz9P6JjQV9nAyD+enqXT+c63o
 vRknZfopK8T3TFcI/LIX1DTTdSmE4//6eN3pUd1Iij1j3pWNq76D0U9yl3LkRWw68UGO
 PnLj5Fm4j3BN0F1426giCq71GuElQpXpsd8rfv4hZ8KHIj3YBY7tgbGMyEw02Nmc8O90
 Ng3USBpVHwPDryhwc9GI0cL4OiMRagahBMXPjrGRrPc23wpeNlk+9ueAn+URHJ0ZpHHb
 Hk8Q==
X-Gm-Message-State: AFq9FYLyr+2x9syMpvZnIvuEQT8R47LmOT6AXWlwQOUsI0emOJ9kO6pB
 dNrCb+4VELOD7jct1KPJtood3+93cNCORwgZESdRil9vDwvLLDfgpGmO
X-Gm-Gg: AYBFou2NfG8xNNngw6+nPuDWbNYpg/UNMfpOkrrCxgMBOy4zLtNvvyo2GlRD/sDya9J
 ICapsh6QTSRSWB7cdhGG9ciTra3MxIU5UR97NzJEmgUFPehAu+4OD4gpZq2oDugogIKfvmjDE8C
 tZndXJf4gyY6TRm423ukZKosvf1hGjCenVrbhfXZqhQWGEwn0L4ks1zOMjQ8rYJETogTEUnyviT
 PRLbinZI7JY1UKPw+IutVDQUDsOiblntNMUU/1UPpQOGxKEBnLaQPxpcvblJiRI0nau11AKKLJh
 9AzN/33pQZXYQvRvq69WmuYCy/hoOcp9iRyLgBfnsyW9mgUd04GFhWCab484P0/PgrcogJzVjDM
 Ywk6t2xoLhYCPcfo0YqbPW7XnclKMewQbIYeHKF4Fj875yNNYwoKsrnRR+Y/nW276E3jx1pvYbS
 KxlJwWCAMP32SBVdU2KflasN4jgEfViGHFkcas1UtdcVQea5wbnJ2GOcTARWCzNeKY2orX9/6MA
 TYwLkdauGG6m/E=
X-Received: by 2002:a05:6a00:856:b0:886:b762:8bfd with SMTP id
 d2e1a72fcca58-897c7cd10efmr19120029b3a.51.1792143184413; 
 Fri, 16 Oct 2026 02:33:04 -0700 (PDT)
Received: from JaminLin-PC.aspeed.com ([118.99.183.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f56c8ba58sm846686b3a.18.2026.10.16.02.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:33:03 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:32:58 +0800
From: Jamin Lin <jaminlin1207@gmail.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Patrick Leis <venture@google.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 48/50] hw/arm: minerva: add Facebook BMC machine
Message-ID: <atHvSjOrggEyJeaN@JaminLin-PC.aspeed.com>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
 <20261015-bmc-minerva-v3-48-7d50c8a108e5@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-bmc-minerva-v3-48-7d50c8a108e5@free.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jaminlin1207@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 15, 2026 at 11:28:35AM +0200, Emmanuel Blot via wrote:
> Add a machine for the Facebook Minerva Chassis Management Module (BMC),
> an AST2600-based board modelled from its device tree
> (aspeed-bmc-facebook-minerva.dts).
> 
> The board uses INA230 and INA238 power monitors, TMP75 temperature
> sensors, PCA9555 IO expanders, PCA9545 and PCA9548 I2C muxes, AT24C
> EEPROMs and a DS1339 RTC.
> 
> Every device the Minerva device tree describes and QEMU already models
> is instantiated. The remaining ones (LTC4287, XDP710, MAX31790, PCF8563
> and IPMB) have no QEMU model and are left documented as comments.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  docs/system/arm/aspeed.rst      |   1 +
>  hw/arm/aspeed_ast2600_minerva.c | 180 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/meson.build              |   1 +
>  3 files changed, 182 insertions(+)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index f38f33cbe1..bbd3d9cdf4 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -36,6 +36,7 @@ AST2600 SoC based machines :
>  - ``catalina-bmc``         Facebook Catalina BMC
>  - ``sanmiguel-bmc``        Facebook SanMiguel BMC
>  - ``anacapa-bmc``          Facebook Anacapa BMC
> +- ``minerva-bmc``          Facebook Minerva BMC
>  - ``gb200nvl-bmc``         Nvidia GB200nvl BMC
>  
>  Supported devices
> diff --git a/hw/arm/aspeed_ast2600_minerva.c b/hw/arm/aspeed_ast2600_minerva.c
> new file mode 100644
> index 0000000000..93abc64770
> --- /dev/null
> +++ b/hw/arm/aspeed_ast2600_minerva.c
> @@ -0,0 +1,180 @@
> +/*
> + * Facebook Minerva Chassis Management Module
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/aspeed.h"
> +#include "hw/arm/aspeed_soc.h"
> +#include "hw/i2c/i2c_mux_pca954x.h"
> +#include "hw/gpio/pca9552.h"
> +#include "hw/nvram/eeprom_at24c.h"
> +#include "hw/rtc/ds1338.h"
> +#include "hw/sensor/ina230.h"
> +#include "hw/sensor/ina238.h"
> +#include "hw/sensor/tmp105.h"
> +
> +/*
> + * Minerva hardware values.
> + */
> +#define MINERVA_BMC_HW_STRAP1 0x00002002
> +#define MINERVA_BMC_HW_STRAP2 0x00000800
> +#define MINERVA_BMC_RAM_SIZE (2 * GiB)
> +
> +/*
> + * Fan Controller Board (FCB).  The Minerva BMC device tree describes six
> + * identical FCBs, each hanging off one channel of the PCA9548 on i2c2.
> + */
> +static void minerva_fcb_i2c_init(I2CBus *bus)
> +{
> +    /* eeprom@50 - atmel,24c128 */
> +    at24c_eeprom_init(bus, 0x50, 16 * KiB);
> +    /* pwm@5e - maxim,max31790 (no model) */
> +    /* power-sensor@40/41/44/45 - ti,ina238 */
> +    i2c_slave_create_simple(bus, TYPE_INA238, 0x40);
> +    i2c_slave_create_simple(bus, TYPE_INA238, 0x41);
> +    i2c_slave_create_simple(bus, TYPE_INA238, 0x44);
> +    i2c_slave_create_simple(bus, TYPE_INA238, 0x45);
> +    /* temperature-sensor@4b - tmp75 */
> +    i2c_slave_create_simple(bus, TYPE_TMP75, 0x4b);
> +    /* gpio@11/12/13/17 - pca9555 */
> +    i2c_slave_create_simple(bus, TYPE_PCA9555, 0x11);
> +    i2c_slave_create_simple(bus, TYPE_PCA9555, 0x12);
> +    i2c_slave_create_simple(bus, TYPE_PCA9555, 0x13);
> +    i2c_slave_create_simple(bus, TYPE_PCA9555, 0x17);
> +}
> +
> +static void minerva_pca9545_eeprom_init(I2CBus *bus, uint8_t addr,
> +                                        unsigned neeprom)
> +{
> +    I2CSlave *i2c_mux = i2c_slave_create_simple(bus, TYPE_PCA9545, addr);
> +
> +    for (unsigned idx = 0; idx < neeprom; idx++) {
> +        at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, idx), 0x50, 8 * KiB);
> +    }
> +}
> +
> +static void minerva_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    /* Reference: aspeed-bmc-facebook-minerva.dts */
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
> +    /* power-monitor@40/41 - ti,ina230 */
> +    i2c_slave_create_simple(i2c[0], TYPE_INA230, 0x40);
> +    i2c_slave_create_simple(i2c[0], TYPE_INA230, 0x41);
> +    /* power-monitor@44 - lltc,ltc4287 (no model) */
> +    /* power-monitor@43 - infineon,xdp710 (no model) */
> +    /* leds_gpio: gpio@19 - pca9555 */
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9555, 0x19);
> +    /* gpio@11/12/13 - pca9555 */
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9555, 0x11);
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9555, 0x12);
> +    i2c_slave_create_simple(i2c[0], TYPE_PCA9555, 0x13);
> +
> +    /* &i2c1 */
> +    /* temperature-sensor@4b/4f - tmp75 */
> +    i2c_slave_create_simple(i2c[1], TYPE_TMP75, 0x4b);
> +    i2c_slave_create_simple(i2c[1], TYPE_TMP75, 0x4f);
> +    /* eeprom@54 - atmel,24c128 */
> +    at24c_eeprom_init(i2c[1], 0x54, 16 * KiB);
> +
> +    /* &i2c2 */
> +    /* i2c-mux@77 (PCA9548) - six Fan Controller Boards */
> +    i2c_mux = i2c_slave_create_simple(i2c[2], TYPE_PCA9548, 0x77);
> +    /* FCB 1 - imux16 (channel 1) */
> +    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 1));
> +    /* FCB 2 - imux17 (channel 0) */
> +    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 0));
> +    /* FCB 3 - imux18 (channel 3) */
> +    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 3));
> +    /* FCB 4 - imux19 (channel 2) */
> +    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 2));
> +    /* FCB 5 - imux20 (channel 4) */
> +    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 4));
> +    /* FCB 6 - imux21 (channel 5) */
> +    minerva_fcb_i2c_init(pca954x_i2c_get_bus(i2c_mux, 5));
> +    /* imux22/imux23 (channels 6/7) - empty */
> +
> +    /* &i2c3 */
> +    /* i2c-mux@72 (PCA9545) - imux24-27, eeprom@50 on each channel */
> +    minerva_pca9545_eeprom_init(i2c[3], 0x72, 4);
> +
> +    /* &i2c4 */
> +    /* i2c-mux@72 (PCA9545) - imux28-31, eeprom@50 on each channel */
> +    minerva_pca9545_eeprom_init(i2c[4], 0x72, 4);
> +
> +    /* &i2c5 */
> +    /* i2c-mux@72 (PCA9545) - imux32-35, eeprom@50 on each channel */
> +    minerva_pca9545_eeprom_init(i2c[5], 0x72, 4);
> +
> +    /* &i2c6 */
> +    /* i2c-mux@72 (PCA9545) - imux36-39, eeprom@50 on each channel */
> +    minerva_pca9545_eeprom_init(i2c[6], 0x72, 4);
> +
> +    /* &i2c7 - empty */
> +    /* &i2c8 - empty */
> +
> +    /* &i2c9 */
> +    /* eeprom@50 - atmel,24c64 */
> +    at24c_eeprom_init(i2c[9], 0x50, 8 * KiB);
> +    /* rtc@51 - nxp,pcf8563 (no model) */
> +    /* rtc@68 - dallas,ds1339 */
> +    i2c_slave_create_simple(i2c[9], TYPE_DS1339, 0x68);
> +
> +    /* &i2c12 */
> +    /* i2c-mux@70 (PCA9545) - imux40-42 eeprom@50, imux43 empty */
> +    minerva_pca9545_eeprom_init(i2c[12], 0x70, 3);
> +
> +    /* &i2c13 */
> +    /* i2c-mux@70 (PCA9545) - imux44-46 eeprom@50, imux47 empty */
> +    minerva_pca9545_eeprom_init(i2c[13], 0x70, 3);
> +
> +    /* &i2c14 */
> +    /* ipmb@10 - ipmb-dev (no model) */
> +
> +    /* &i2c15 */
> +    /* eeprom@50 - atmel,24c128 */
> +    at24c_eeprom_init(i2c[15], 0x50, 16 * KiB);
> +    /* eeprom@56 - atmel,24c64 */
> +    at24c_eeprom_init(i2c[15], 0x56, 8 * KiB);
> +}
> +
> +static void aspeed_machine_minerva_class_init(ObjectClass *oc,
> +                                              const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       = "Facebook Minerva BMC (Cortex-A7)";
> +    amc->soc_name  = "ast2600-a3";
> +    amc->hw_strap1 = MINERVA_BMC_HW_STRAP1;
> +    amc->hw_strap2 = MINERVA_BMC_HW_STRAP2;
> +    amc->fmc_model = "mx66l1g45g";
> +    amc->spi_model = NULL;
> +    amc->num_cs    = 2;
> +    amc->macs_mask = ASPEED_MAC3_ON;
> +    amc->i2c_init  = minerva_bmc_i2c_init;
> +    mc->default_ram_size = MINERVA_BMC_RAM_SIZE;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +
> +static const TypeInfo aspeed_ast2600_minerva_types[] = {
> +    {
> +        .name          = MACHINE_TYPE_NAME("minerva-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_minerva_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(aspeed_ast2600_minerva_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index bcc068de04..a9e8270b85 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -63,6 +63,7 @@ arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>    'aspeed_ast2600_fby35.c',
>    'aspeed_ast2600_fuji.c',
>    'aspeed_ast2600_gb200nvl.c',
> +  'aspeed_ast2600_minerva.c',
>    'aspeed_ast2600_rainier.c',
>    'aspeed_ast2600_sanmiguel.c',
>    'aspeed_ast10x0.c',
> 
> -- 
> 2.53.0-Meta
> 
> 
Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>

