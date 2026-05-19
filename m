Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28946CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOXh-0004PT-24; Tue, 19 May 2026 13:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wPOXc-0004OV-Qd
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:47:41 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wPOXa-0008Ci-My
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:47:40 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7bd4c61765dso35165837b3.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779212857; x=1779817657; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CuaKqvJ9IUSHTW7695Wl5mbVN3/zEF6m+YZoF3wB+YE=;
 b=o3kI7QK2Cem1/K5ksTAbocMumNDd2Yae8Xodo1UZM4eeaRO7mwAze5mZWgezLPNuHe
 BbMmvhqjlty+bnjQznNqVeeeG4FXukLni94E+FlMMKwShLYHptEG4kuK1jWA07nEiu7c
 /lR76oS3eZtQYnXQCg+RgCNeUiylPRqvM0TJkkeTdmBB8KbEvUzCtlFx4e7TMtAfiLp1
 WyaKF78sXlTYheDBQIBh+/hRFJZftqJTl3VzCk8694wSb09J7VLkM/MDMGgJuUK+ao7H
 giMhkW5DqRyA+Qg+Ws9YbCgasH2N8zA7OqKxfCrqOBmp9K38GrU/xtRUVgsalRn0vbNs
 apDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779212857; x=1779817657;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CuaKqvJ9IUSHTW7695Wl5mbVN3/zEF6m+YZoF3wB+YE=;
 b=jXw+OQxWkOp9l8IrOcfA6CSSD6bqnkHYjpLoa/x8SIlg9uDmRyYFaMbk9hy4FesUSC
 saQLLuXlDRQr7BYiOvwKKbueRbos5cQio70AfONVUde9pbhxO1mTGKlP5o7IXilAHpmS
 qXOrN19kSsZKmFzPFiLjsEEqgVgm2X4CWVKVYjyGUmvTh++uvCHVEzS7B8YNLDzltrei
 oLOljd2FjoP8MrSS48bMonKg6UdX+O0CDpV0k3DWf63pTWGWfMOhU613dZNhU3Hh/K9A
 GJLTZkTNurjeF6JG8tqeUD+1aZv4BZR0trTtr/IY0EoV9t6EKaEXV9WwF5IlVihQWXV2
 RHzQ==
X-Gm-Message-State: AOJu0Yxe5rDHy6LFbANb6gY7IgpZFu7v223DOvBfu8bM9Kb4psxSZ9js
 E0us7dbxuQ+jd74pVwwELJ1F4kjDOp0WhaZGfHq9HV3Riw9ZV+IE9iIG
X-Gm-Gg: Acq92OELOgfquels8/yv4ODx0gOMUKfUVXKBWgkwm6+f1GURENxcf/NcFcH8oIQiCg/
 YhjNmnJEVjUnn5OznvlROM2dUdW3RAJ2A3TxHVPgm12nXWzVelxB+2XbH/0F6VIa9Cxj791yD5g
 zXDIasDpHhAxEvCBnJIQXZBWNJnNm5PhP1gSwu//ZP/5W9U1MUKL/pe/CkTmRLQTvFoTd+v/kgr
 iJr2bK4G7SFVET4lC63DwNTsmyCrCvfocJe5YmxRI9jARGQEKr3tbhqYY37pu0cpckYQph6eGcq
 9uCKkdRILfjQ1WUnKZ2Dzq9O5Rt/tbFJbbCkKqmeaOWA9l80XcmbjV8tJZ3zPqiN9UULImYwgm1
 fM2faaBIv67Dowo2FLypvzQrvV1LRyM/5HOBCpJYn/p+j9jx0H8UBTfBBiZ01jjlES8edtAGY7t
 MkAPcCbAh8vvU2c8DrKwmffA==
X-Received: by 2002:a05:690e:250e:10b0:651:e0cd:5874 with SMTP id
 956f58d0204a3-65e22898cd3mr16868467d50.47.1779212856422; 
 Tue, 19 May 2026 10:47:36 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:e::])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65e0dbd1031sm8165450d50.20.2026.05.19.10.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 10:47:35 -0700 (PDT)
Date: Tue, 19 May 2026 10:47:33 -0700
From: William de Abreu Pinho <williamdapinho@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 2/3] hw/arm/aspeed: add anacapa-bmc machine
Message-ID: <agyiNQqL4G2m5xxL@devvm32988.lla0.facebook.com>
References: <20260519-add-anacapa-machine-v2-0-47027867d76a@gmail.com>
 <20260519-add-anacapa-machine-v2-2-47027867d76a@gmail.com>
 <523acab2-a196-4d02-a3a1-0407dffdf41b@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <523acab2-a196-4d02-a3a1-0407dffdf41b@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=williamdapinho@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, May 19, 2026 at 05:15:45PM +0200, Cédric Le Goater wrote:
> On 5/19/26 12:36, William de Abreu Pinho wrote:
> > Add the Facebook Anacapa BMC machine.  The I2C topology is based on the
> > Linux kernel device tree [1].  Hardware strap register values are taken
> > from real hardware.
> > 
> > A functional test is included using the OpenBMC image built from [2],
> > similar to the tests for bletchley-bmc and catalina-bmc.
> > 
> > [1]: https://github.com/torvalds/linux/blob/76b4ec8efdc3887cdbf730da2e55881fc1a18770/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> > [2]: https://github.com/openbmc/openbmc/commit/8e22df918eaaa5d83143471d24ef0eeb1c1e3c7c
> > 
> > Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
> > ---
> >   hw/arm/aspeed_ast2600_anacapa.c             | 153 ++++++++++++++++++++++++++++
> >   hw/arm/meson.build                          |   1 +
> >   tests/functional/arm/meson.build            |   2 +
> >   tests/functional/arm/test_aspeed_anacapa.py |  25 +++++
> >   4 files changed, 181 insertions(+)
> 
> I forgot to tell you to update docs/system/arm/aspeed.rst too.
> 
> With that,
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> > 
> > diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
> > new file mode 100644
> > index 0000000000..c24f00d44c
> > --- /dev/null
> > +++ b/hw/arm/aspeed_ast2600_anacapa.c
> > @@ -0,0 +1,153 @@
> > +/*
> > + * Facebook Anacapa
> > + *
> > + * Copyright (c) Meta Platforms, Inc. and affiliates.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "hw/arm/machines-qom.h"
> > +#include "hw/arm/aspeed.h"
> > +#include "hw/arm/aspeed_soc.h"
> > +#include "hw/i2c/i2c_mux_pca954x.h"
> > +#include "hw/gpio/pca9552.h"
> > +#include "hw/nvram/eeprom_at24c.h"
> > +
> > +/* Anacapa hardware value */
> > +#define ANACAPA_BMC_HW_STRAP1 0x00002002
> > +#define ANACAPA_BMC_HW_STRAP2 0x00000000
> > +#define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> > +
> > +static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
> > +{
> > +    /* Reference: aspeed-bmc-facebook-anacapa.dts */
> > +
> > +    AspeedSoCState *soc = bmc->soc;
> > +    I2CBus *i2c[16] = {};
> > +    I2CSlave *i2c_mux;
> > +
> > +    for (int i = 0; i < ARRAY_SIZE(i2c); i++) {
> > +        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
> > +    }
> 
Thanks for the suggestion.  I will introduce a helper in a
hw/arm/aspeed.c in a separate patch.
> 
> This seems to be a common pattern in the Aspeed machines to initialize
> an array of I2C. We could introduce an helper for it.
> 
> 
> Thanks,
> 
> C.
> 
> > +    /* &i2c0 */
> > +    /* eeprom@50 */
> > +    at24c_eeprom_init(i2c[0], 0x50, 256 * KiB);
> > +    /* i2c-mux@70 */
> > +    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x70);
> > +
> > +    /* &i2c1 */
> > +    /* eeprom@50 */
> > +    at24c_eeprom_init(i2c[1], 0x50, 256 * KiB);
> > +    /* i2c-mux@70 (PCA9546) — 4 channels, empty */
> > +    i2c_slave_create_simple(i2c[1], TYPE_PCA9546, 0x70);
> > +
> > +    /* &i2c4 */
> > +    /* i2c-mux@70 (PCA9548) */
> > +    i2c_slave_create_simple(i2c[4], TYPE_PCA9548, 0x70);
> > +
> > +    /* &i2c6 */
> > +    /* eeprom@50 */
> > +    at24c_eeprom_init(i2c[6], 0x50, 32 * KiB);
> > +
> > +    /* &i2c8 */
> > +    /* i2c-mux@72 (PCA9546) */
> > +    i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
> > +
> > +    /* i2c8mux ch0 */
> > +    /* adc128d818@1f — no model */
> > +    /* pca9555@22 */
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> > +                            TYPE_PCA9552, 0x22);
> > +    /* pca9555@24 */
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> > +                            TYPE_PCA9552, 0x24);
> > +    /* eeprom@50 */
> > +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB);
> > +
> > +    /* i2c8mux ch1 */
> > +    /* pca9555@22 */
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> > +                            TYPE_PCA9552, 0x22);
> > +    /* pca9555@24 */
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> > +                            TYPE_PCA9552, 0x24);
> > +    /* eeprom@50 */
> > +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB);
> > +
> > +    /* &i2c9 */
> > +    /* eeprom@50 */
> > +    at24c_eeprom_init(i2c[9], 0x50, 16 * KiB);
> > +    /* eeprom@56 */
> > +    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
> > +
> > +    /* &i2c10 */
> > +    /* i2c-mux@71 (PCA9548) */
> > +    i2c_mux = i2c_slave_create_simple(i2c[10], TYPE_PCA9548, 0x71);
> > +
> > +    /* i2c10mux ch5 */
> > +    /* pca9555@22*/
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> > +                            TYPE_PCA9552, 0x22);
> > +    /* eeprom@52 */
> > +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
> > +
> > +    /* &i2c11 */
> > +    /* i2c-mux@71 (PCA9548) */
> > +    i2c_mux = i2c_slave_create_simple(i2c[11], TYPE_PCA9548, 0x71);
> > +
> > +    /* i2c11mux ch0-ch4 — empty */
> > +
> > +    /* i2c11mux ch5 */
> > +    /* pca9555@22 */
> > +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
> > +                            TYPE_PCA9552, 0x22);
> > +    /* eeprom@52 */
> > +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
> > +
> > +    /* &i2c13 */
> > +    /* i2c-mux@70 (PCA9548) */
> > +    i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
> > +
> > +    /* i2c13mux ch3 */
> > +    /* adc128d818@1f - no model */
> > +
> > +    /* i2c13mux ch4 */
> > +    /* eeprom@51 */
> > +    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB);
> > +
> > +    /* i2c13mux ch7 */
> > +    /* nfc@28 — no model */
> > +}
> > +
> > +static void aspeed_machine_anacapa_class_init(ObjectClass *oc,
> > +                                               const void *data)
> > +{
> > +    MachineClass *mc = MACHINE_CLASS(oc);
> > +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> > +
> > +    mc->desc       = "Facebook Anacapa BMC (Cortex-A7)";
> > +    amc->soc_name  = "ast2600-a3";
> > +    amc->hw_strap1 = ANACAPA_BMC_HW_STRAP1;
> > +    amc->hw_strap2 = ANACAPA_BMC_HW_STRAP2;
> > +    amc->fmc_model = "mx66l1g45g";
> > +    amc->spi_model = NULL;
> > +    amc->num_cs    = 2;
> > +    amc->macs_mask = ASPEED_MAC2_ON;
> > +    amc->i2c_init  = anacapa_bmc_i2c_init;
> > +    mc->default_ram_size = ANACAPA_BMC_RAM_SIZE;
> > +    aspeed_machine_class_init_cpus_defaults(mc);
> > +}
> > +
> > +static const TypeInfo aspeed_ast2600_anacapa_types[] = {
> > +    {
> > +        .name          = MACHINE_TYPE_NAME("anacapa-bmc"),
> > +        .parent        = TYPE_ASPEED_MACHINE,
> > +        .class_init    = aspeed_machine_anacapa_class_init,
> > +        .interfaces    = arm_machine_interfaces,
> > +    }
> > +};
> > +
> > +DEFINE_TYPES(aspeed_ast2600_anacapa_types)
> > diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> > index 84b8ec5fb5..3de3dca8a9 100644
> > --- a/hw/arm/meson.build
> > +++ b/hw/arm/meson.build
> > @@ -56,6 +56,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
> >     'aspeed_ast2500_witherspoon.c',
> >     'aspeed_ast2500_yosemitev2.c',
> >     'aspeed_ast2600.c',
> > +  'aspeed_ast2600_anacapa.c',
> >     'aspeed_ast2600_bletchley.c',
> >     'aspeed_ast2600_catalina.c',
> >     'aspeed_ast2600_evb.c',
> > diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
> > index 2f538f29a2..959179a56f 100644
> > --- a/tests/functional/arm/meson.build
> > +++ b/tests/functional/arm/meson.build
> > @@ -12,6 +12,7 @@ test_arm_timeouts = {
> >     'aspeed_ast2600_sdk' : 720,
> >     'aspeed_ast2600_sdk_515' : 720,
> >     'aspeed_ast2600_sdk_otp' : 720,
> > +  'aspeed_anacapa' : 480,
> >     'aspeed_bletchley' : 480,
> >     'aspeed_catalina' : 480,
> >     'aspeed_gb200nvl_bmc' : 480,
> > @@ -45,6 +46,7 @@ tests_arm_system_thorough = [
> >     'aspeed_ast2600_sdk',
> >     'aspeed_ast2600_sdk_515',
> >     'aspeed_ast2600_sdk_otp',
> > +  'aspeed_anacapa',
> >     'aspeed_bletchley',
> >     'aspeed_catalina',
> >     'aspeed_gb200nvl_bmc',
> > diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
> > new file mode 100755
> > index 0000000000..27f8bd8b56
> > --- /dev/null
> > +++ b/tests/functional/arm/test_aspeed_anacapa.py
> > @@ -0,0 +1,25 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Functional test that boots the ASPEED machines
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +from qemu_test import Asset
> > +from aspeed import FacebookAspeedTest
> > +
> > +
> > +class AnacapaMachine(FacebookAspeedTest):
> > +
> > +    ASSET_ANACAPA_FLASH = Asset(
> > +        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
> > +        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
> > +
> > +    def test_arm_ast2600_anacapa_openbmc(self):
> > +        image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
> > +
> > +        self.do_test_arm_aspeed_openbmc('anacapa-bmc', image=image_path,
> > +                                        uboot='2019.04', cpu_id='0xf00',
> > +                                        soc='AST2600 rev A3')
> > +
> > +if __name__ == '__main__':
> > +    FacebookAspeedTest.main()
> > 
> 
> 

