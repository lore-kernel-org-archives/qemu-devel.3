Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3191D3CC88
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 23:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgA1m-0002Rn-FK; Wed, 14 Jan 2026 18:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vgA1j-0002OS-HM
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 18:11:47 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vgA1h-0007Xz-R1
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 18:11:47 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-501511aa012so207411cf.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 15:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768432303; cv=none;
 d=google.com; s=arc-20240605;
 b=IuDBdZKkdoHvUwC4legYe1+tgZrjlEkXQTa7Ka9RJEGalx18ygUsTDx0vuu6OJsQ1l
 TUouxkZXwIZ06dDBsv7saScEcwUintcEi5EkeODhifnwRSoVj9oflYMEWmFIJ6eMy7gI
 rrhnJg57gWXqoximHNetgXl3z9lMrCrL77t0E6sRzEMxNUdi9IblSlj8TrGVaJMpWV5T
 zCgRzUwsJmlWn8HDeNqw8GM4E7ThfrOWCWrQqziv7YaHhxf37HsetAVO5F8cJWQw6lCH
 2Pn0t/yRG1ncjIr4rRFjM9vnBaCoC/hTJc7MKZUFFHNyDu/43dVM/zTU9O/zpByh7O+u
 +1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AQ2Z09MXI0KxASX4FLCm0KMiDhuMYFm0OZRiGXJR+k4=;
 fh=zQzjFtO1mYef21+r8J01rhQc0O/JV8YMhZAettCphRg=;
 b=UCxJFhSo8ELb1RomRObeO0nPgNDcgGjVObq7ZVsPQC2Wy3TylUS/onbz1hvQYo2jMc
 x/62/TGrXa0HfQIdU2/RHVeh1XWwsQc8ql8s7pkrrHm4bHd+jtLk5ZjP3TQVOk2BAvCR
 NgSFmuiLJCAK1eI+2qYX/4xwigiGcHKJZsOBG2OsPCJ+Ou8nLmm5bw+ko7Zb8lCtY2hU
 1/ooSS8wGTchciIzFuy5jBAIj36+sooBaJ0lU9u1dBRbcBSCz4DWADl2sCgb/b+eZ3Gu
 RW8CX7XoN0HHbjrJqFv+o2a9RJPbdLwt/3tg4GpZhc++Gty+2U8GBv3o0N2eVzbgUoF7
 G6Jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1768432303; x=1769037103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQ2Z09MXI0KxASX4FLCm0KMiDhuMYFm0OZRiGXJR+k4=;
 b=SFfzOqkXL0VvfU3TRHg0FczVoLa0dihrWeYd8mNc2nbjIYWaVhZmwTIkwAPYtBkXHL
 5DaB99TiEV06nw+QB0v6as7Rz9kGQnCZy8d9GUP3f/wPCV37x6X779N28TXC5Y3oeQTV
 WYNlidx5B8ejGhTXOFSFOVRj7sPTDlRPB5LeATCJ4vwouwlR6Ii9Wf0b0KJ+mw4xnOTX
 1KjWDOrIoEUzCIvq+7CRiq/Ge3/sMY53mvJlp2QI+BNBFZo+oa5Xkli7pJPqRArHf2HZ
 ch++7QTaXz5Gg2+ApKsa9XCirae7An8V36/cH257XbnG5bKaBO3mNI/O5av40amiGQ7Y
 9m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768432303; x=1769037103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AQ2Z09MXI0KxASX4FLCm0KMiDhuMYFm0OZRiGXJR+k4=;
 b=HqudVUDQfWSnyv7rJPWerrV2FKRkKybNkKFYw8yqN3zi7ztrwtNW0KncqnZLrtCTJ3
 7fHhE+o6HWn0rieBSvaPDk00noaWcDn6Gq1frhgISiFS6aF4euJOgAX6FSMb9RpDnSQz
 V97ph9bJIZ306DtVUCBmAS0mK2PjML0r4Za5MseU00ON32XrRxaR0kBg6YQU2Wu/nrm+
 shIUkaA0KvhqwKWX0HJcmw2N4gAUTLMDd2qVqxp5D9vDiX1+FbORIhDOsq/idXmjfbvW
 2VVUVPaXTm3Dzntdr2SvvQ/UW6mkOQ1hxawZtlUDa/BUcDz6BgjMy1BdDvGwzOk0V2R4
 IcBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpMm+l+YircGvUyG0Z6LMYs1Osagm57JyoqohUr+Tp7aN7w1mqFTy6uWw69VH4wmj+zIhuCRJpPUHa@nongnu.org
X-Gm-Message-State: AOJu0Yyrn8qJViuCpctQeTzOq1ygkDFDjoLgexU323rwMMn4T3JYmkFY
 a0ApR+B5qjnYWeuqDZvpbE0ievO7lFuom0RzVgWHg0cfKzWXQn3KJpVQ2RprWY+028RHE6XiZyW
 n3WUx/mL7zHR4qD1W/t4ohZi8CdLrvDmiC6K/58N1
X-Gm-Gg: AY/fxX4gTk99SFbtXtxsqnLro3vwghLEVxFu/1OhEiGHiJcgJr/TB4zrUwyphZGB7Ju
 XRD9XoZWxTPY6K+Ch5CNadj32ZSY592AbVD1ftPPoLtWqsPRCMCyGDJChz1KxktNApIeQ7BUBsz
 zEqTu1nGwCWwr1O0Lcxvc2I8aj3ZruXcrHXvOVJmgH+mi//tgWsNQH5hDR2BJ/PH2uJGrEmJIA3
 4fodt6/FFcRnOJJfrXnADWtLhkkqE5a/pTJKST+EFJ/8q63crenKTFgC9IJ6nKnlbws37ndvbfu
 ZXMac0+EvHgI3VCkCvNAjIDqo4WFsVM0UJSI
X-Received: by 2002:ac8:7fc6:0:b0:4f1:a61a:1e8 with SMTP id
 d75a77b69052e-501eab944edmr4020121cf.10.1768432302406; Wed, 14 Jan 2026
 15:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <20260112083054.4151945-2-kane_chen@aspeedtech.com>
In-Reply-To: <20260112083054.4151945-2-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 14 Jan 2026 15:11:30 -0800
X-Gm-Features: AZwV_QhLVCqVeHJr__lKBUJlN0Vg4Yb2L0XiEomk3NfIrhN_1ljIvOrC2_9Sxv4
Message-ID: <CA+QoejXKnT6iNuyAS3rDg3ovYbAyBf5crPrw9kYGm73Uk0S1uw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Jan 12, 2026 at 12:38=E2=80=AFAM Kane Chen via qemu development
<qemu-devel@nongnu.org> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> On some Aspeed-based machines, multiple I2C controllers may exist
> across different components, such as the primary SoC and an external
> IO expander or co-processor (e.g., AST1700). Using the current static
> naming convention results in object name conflicts when multiple
> controllers attempt to instantiate buses with the same ID.
>
> This patch introduces a 'bus-label' property for the Aspeed I2C
> controller. This allows higher-level layers, such as the SoC realize
> function, to provide a unique identifier for the buses. The I2C bus
> object name is then constructed using this label (e.g., "ioexp0.0"
> instead of the default "aspeed.i2c.bus.0").
>
> This enhancement ensures unique bus identifiers across the system and
> resolves naming conflicts in multi-controller configurations.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

This is basically a rework of the bus-label patches I already tested
and we're carrying for AST1700, re-tested just in case, and everything
still looks good!

Thank you Kane!

-Nabih

> ---
>  include/hw/i2c/aspeed_i2c.h |  2 ++
>  hw/i2c/aspeed_i2c.c         | 27 +++++++++++++++++++++------
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index ffcff2580f..68bd138026 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -252,6 +252,7 @@ struct AspeedI2CBus {
>      MemoryRegion mr_pool;
>
>      I2CBus *bus;
> +    char *name;
>      uint8_t id;
>      qemu_irq irq;
>
> @@ -269,6 +270,7 @@ struct AspeedI2CState {
>      uint32_t intr_status;
>      uint32_t ctrl_global;
>      uint32_t new_clk_divider;
> +    char *bus_label;
>      MemoryRegion pool_iomem;
>      uint8_t share_pool[ASPEED_I2C_SHARE_POOL_SIZE];
>
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 1b8ac561c3..7cf92423c7 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1215,9 +1215,16 @@ static void aspeed_i2c_realize(DeviceState *dev, E=
rror **errp)
>                            "aspeed.i2c", aic->mem_size);
>      sysbus_init_mmio(sbd, &s->iomem);
>
> +    /* default value */
> +    if (!s->bus_label) {
> +        s->bus_label =3D g_strdup(TYPE_ASPEED_I2C_BUS);
> +    }
> +
>      for (i =3D 0; i < aic->num_busses; i++) {
>          Object *bus =3D OBJECT(&s->busses[i]);
>          int offset =3D i < aic->gap ? 1 : 5;
> +        g_autofree char *name =3D g_strdup_printf("%s.%d",
> +                                                s->bus_label, i);
>
>          if (!object_property_set_link(bus, "controller", OBJECT(s), errp=
)) {
>              return;
> @@ -1227,6 +1234,10 @@ static void aspeed_i2c_realize(DeviceState *dev, E=
rror **errp)
>              return;
>          }
>
> +        if (!object_property_set_str(bus, "bus-name", name, errp)) {
> +            return;
> +        }
> +
>          if (!sysbus_realize(SYS_BUS_DEVICE(bus), errp)) {
>              return;
>          }
> @@ -1263,6 +1274,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Er=
ror **errp)
>  static const Property aspeed_i2c_properties[] =3D {
>      DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
>                       TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_STRING("bus-label", AspeedI2CState, bus_label),
>  };
>
>  static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
> @@ -1423,24 +1435,26 @@ static void aspeed_i2c_bus_realize(DeviceState *d=
ev, Error **errp)
>  {
>      AspeedI2CBus *s =3D ASPEED_I2C_BUS(dev);
>      AspeedI2CClass *aic;
> -    g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d",=
 s->id);
> -    g_autofree char *pool_name =3D g_strdup_printf("%s.pool", name);
> +    g_autofree char *pool_name =3D NULL;
>
> -    if (!s->controller) {
> -        error_setg(errp, TYPE_ASPEED_I2C_BUS ": 'controller' link not se=
t");
> +    if (!s->controller || !s->name) {
> +        error_setg(errp, TYPE_ASPEED_I2C_BUS
> +                   ": 'controller' or 'bus-name' not set");
>          return;
>      }
>
> +    pool_name =3D g_strdup_printf("%s.pool", s->name);
> +
>      aic =3D ASPEED_I2C_GET_CLASS(s->controller);
>
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>
> -    s->bus =3D i2c_init_bus(dev, name);
> +    s->bus =3D i2c_init_bus(dev, s->name);
>      s->slave =3D i2c_slave_create_simple(s->bus, TYPE_ASPEED_I2C_BUS_SLA=
VE,
>                                         0xff);
>
>      memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
> -                          s, name, aic->reg_size);
> +                          s, s->name, aic->reg_size);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
>
>      memory_region_init_io(&s->mr_pool, OBJECT(s), &aspeed_i2c_bus_pool_o=
ps,
> @@ -1452,6 +1466,7 @@ static const Property aspeed_i2c_bus_properties[] =
=3D {
>      DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),
>      DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_ASPEED=
_I2C,
>                       AspeedI2CState *),
> +    DEFINE_PROP_STRING("bus-name", AspeedI2CBus, name),
>  };
>
>  static void aspeed_i2c_bus_class_init(ObjectClass *klass, const void *da=
ta)
> --
> 2.43.0
>
>

