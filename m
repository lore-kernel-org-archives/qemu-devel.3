Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E27BC021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 01:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnT7J-0007kr-7l; Wed, 26 Feb 2025 20:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnT7F-0007jk-A3; Wed, 26 Feb 2025 20:55:09 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnT7D-0005mc-6A; Wed, 26 Feb 2025 20:55:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223480ea43aso9263275ad.1; 
 Wed, 26 Feb 2025 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740621305; x=1741226105; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/P+e23UNvTeLCd053K9HB8v564nTDca8A/b+i14AAjY=;
 b=W3K3vdrcJ0PsoTW/sm360q89XfOajBZ+JjSqTRgF9TATAisRFLzZDu8vS0D54HLhGD
 3+nmAD1gis/PM1DdexuZYsUdzc6D3YpmdLl6ukTz0g94iQDJ0cRXsNuSbvh/DDoBFM1u
 Ar7BXM9KyBNaa4GacHqsGrvaqFvOGsUq2zCz1k2mZr4QmdQdl2pQcUAyzNjoMOzKM9w0
 En1iKBh3BtUYv1Fy7O3tBDpjEqWgVa6vCXaGN2oVtpB42N62FY+dm7B2O1XSEr8rIrzk
 5CMyw5n3YEKj9DLArOSaeKxlRVce/KgCm2W7FMX3iw432u8u/ha76rS0x+jLheu67yfx
 JtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740621305; x=1741226105;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/P+e23UNvTeLCd053K9HB8v564nTDca8A/b+i14AAjY=;
 b=mxrAqd0L8SSu0/LRnSj+1hc5GZ9h0UB25riNbJo+Vi+QpCfNxueKsUxVpvMcJdS51v
 f2ayHGrOY/vmwIe4AVOThFv8lA9UsO8/+xTcryZZrt85dorkSFfLCfJ2vmYGnIbTRu2Q
 NQ7S5ucqz7VxuxVLvDaf3TLgVJEEt3menI/2ekKmY4tNtd9pRujsAVjZAHUY9FeaYG7x
 +MrJMwuLchII2OUt1VUg8V6o5BFa3UsA1jcV7SYElTmX8lulllp1z2yXBhU8pwy6xoTN
 bi7q1fkRFNMiqyH3bXe9Ammhqir82tgF9pmdWlaej2LPHvIkMB3n7joGw+mfTmjpKIkm
 niNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqeGg1BzpfRXLATzbWN/3tb1qRW3jhdXq+0K5VqhxVI871MEAmMXzrwJ97y+oXp+VVHUb1iES9vadH@nongnu.org
X-Gm-Message-State: AOJu0YwVwEy8ftWhvjFHi3iM19hw86uT2Z/XWirsE1C9JnPUrGuilU95
 NAj+L9tQW3ADLvdtUHZH8CYIYuYOJfbgH7dly1sqaw5TKyftdx9S
X-Gm-Gg: ASbGncvDeEVOTPjVBl8N1RpwUaQ1QxZVyI3ymh73oz2NXsBM5t3/iL5WATIEqBc2k5J
 WQ623GqMVtTk8ch1zJC7rHkuilpJLzHLVwUImV/I26EFTUJvV+GwTPvTOO+M2hy3WBp1hIijlDK
 88LGi2zkYi9cWiqmUvavWiuYV2Y5Ffcg/OLAOyATusLIAvMMcSBaAl0KzpcpXjMofOB/shXlDHk
 7k5EpnRkT2BgtYmdAKzqPMsc/k+4LC7Lf95MSD8BBgj2NA4hbZtX0st2VINN/zlPjB46OQGNXQF
 FjV4Z4xpnD57SPZUgw==
X-Google-Smtp-Source: AGHT+IGOjFf0qt6yKmst6hwiFTb4vC9zcaNbNlmpFUMPBHOjo86eCv8lClsWKWVetp4+mOb/401siw==
X-Received: by 2002:a05:6a00:4f88:b0:72a:8bb6:2963 with SMTP id
 d2e1a72fcca58-73426cf11e7mr32798938b3a.13.1740621304907; 
 Wed, 26 Feb 2025 17:55:04 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe2ad9csm304039b3a.7.2025.02.26.17.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 17:55:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:54:56 +1000
Message-Id: <D82UR4MO7WG9.RGLCRWPS8I29@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH v5 3/4] hw/ssi/pnv_spi: Make bus names distinct for each
 controllers of a socket
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-4-chalapathi.v@linux.ibm.com>
In-Reply-To: <20250103161824.22469-4-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
> Create a spi buses with distict names on each socket so that responders
> are attached to correct SPI controllers.
>
> QOM tree on a 2 socket machine:
> (qemu) info qom-tree
> /machine (powernv10-machine)
>   /chip[0] (power10_v2.0-pnv-chip)
>     /pib_spic[0] (pnv-spi)
>       /chip0.pnv.spi.bus.0 (SSI)
>       /xscom-spi[0] (memory-region)
>   /chip[1] (power10_v2.0-pnv-chip)
>     /pib_spic[0] (pnv-spi)
>       /chip1.pnv.spi.bus.0 (SSI)
>       /xscom-spi[0] (memory-region)

Mechanics of the patch looks fine. I don't know about the name
though.

I think "pnv-spi-bus" is the right name for the bus. Using dots as
with chip0. makes it seem like each element is part of a topology.

Would chip0.pnv-spi-bus be better?

I don't suppose there is a good way to create an alias so existing
cmdline works and refers to the bus on chip0? Maybe the chip0 bus
could just not have the chip0. prefix?

Thanks,
Nick

>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ssi/pnv_spi.h           | 3 ++-
>  hw/ppc/pnv.c                       | 2 ++
>  hw/ssi/pnv_spi.c                   | 5 +++--
>  tests/qtest/pnv-spi-seeprom-test.c | 2 +-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
> index 9878d9a25f..7fc5da1f84 100644
> --- a/include/hw/ssi/pnv_spi.h
> +++ b/include/hw/ssi/pnv_spi.h
> @@ -31,7 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
>  #define PNV_SPI_REG_SIZE 8
>  #define PNV_SPI_REGS 7
> =20
> -#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
> +#define TYPE_PNV_SPI_BUS "pnv.spi.bus"
>  typedef struct PnvSpi {
>      SysBusDevice parent_obj;
> =20
> @@ -42,6 +42,7 @@ typedef struct PnvSpi {
>      Fifo8 rx_fifo;
>      /* SPI object number */
>      uint32_t        spic_num;
> +    uint32_t        chip_id;
>      uint8_t         transfer_len;
>      uint8_t         responder_select;
>      /* To verify if shift_n1 happens prior to shift_n2 */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 11fd477b71..ce23892fdf 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2226,6 +2226,8 @@ static void pnv_chip_power10_realize(DeviceState *d=
ev, Error **errp)
>          /* pib_spic[2] connected to 25csm04 which implements 1 byte tran=
sfer */
>          object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_=
len",
>                                  (i =3D=3D 2) ? 1 : 4, &error_fatal);
> +        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "chip-id",
> +                                chip->chip_id, &error_fatal);
>          if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
>                                          (&chip10->pib_spic[i])), errp)) =
{
>              return;
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index 87eac666bb..41beb559c6 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -1116,14 +1116,15 @@ static const MemoryRegionOps pnv_spi_xscom_ops =
=3D {
> =20
>  static const Property pnv_spi_properties[] =3D {
>      DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
> +    DEFINE_PROP_UINT32("chip-id", PnvSpi, chip_id, 0),
>      DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
>  };
> =20
>  static void pnv_spi_realize(DeviceState *dev, Error **errp)
>  {
>      PnvSpi *s =3D PNV_SPI(dev);
> -    g_autofree char *name =3D g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
> -                    s->spic_num);
> +    g_autofree char *name =3D g_strdup_printf("chip%d." TYPE_PNV_SPI_BUS=
 ".%d",
> +                    s->chip_id, s->spic_num);
>      s->ssi_bus =3D ssi_create_bus(dev, name);
>      s->cs_line =3D g_new0(qemu_irq, 1);
>      qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-see=
prom-test.c
> index 57f20af76e..ef1005a926 100644
> --- a/tests/qtest/pnv-spi-seeprom-test.c
> +++ b/tests/qtest/pnv-spi-seeprom-test.c
> @@ -92,7 +92,7 @@ static void test_spi_seeprom(const void *data)
>      qts =3D qtest_initf("-machine powernv10 -smp 2,cores=3D2,"
>                        "threads=3D1 -accel tcg,thread=3Dsingle -nographic=
 "
>                        "-blockdev node-name=3Dpib_spic2,driver=3Dfile,"
> -                      "filename=3D%s -device 25csm04,bus=3Dpnv-spi-bus.2=
,cs=3D0,"
> +                      "filename=3D%s -device 25csm04,bus=3Dchip0.pnv.spi=
.bus.2,cs=3D0,"


>                        "drive=3Dpib_spic2", tmp_path);
>      spi_seeprom_transaction(qts, chip);
>      qtest_quit(qts);


