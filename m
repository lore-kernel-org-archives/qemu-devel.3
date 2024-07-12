Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E1AC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 01:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5IL-0001Bq-Bx; Thu, 11 Jul 2024 21:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5IK-0001A1-70; Thu, 11 Jul 2024 21:41:56 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5II-0002aa-3u; Thu, 11 Jul 2024 21:41:55 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-81177442f46so402921241.3; 
 Thu, 11 Jul 2024 18:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720748512; x=1721353312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQfqs/W7mE61tsRR5tJN3PuMWsND00BUuiY1spOzn7A=;
 b=B0furNenCDSNmKAMngllJ8IWhSvZtMlHDQU3h++st2/8q6YkS93ep+KEig/V2CVTs9
 lv7BT6tI0kclLeYrrYU0RqwXoDDSrP4CLiKt4k8md3o44a8ax25tzgBkuEXRY+b7LFbg
 9XTkR1gJL6D3P4K8WX/SQteNNErM3AC9COe27xyu2z0JTrk143UAEMHu5ZMxJv9pkciv
 kkd/sdX7YOFRrJM3yD+uDZQZjB9K68rxsTDKwTq7HyTRW1LErA+aymDAtRDovXV4KjtW
 TaKBDAldaZp7viNtIMsJwz7vJdms9NblDNppKApFRvqAZaEwpUl28EIGhiGD5I7tdzCq
 kWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720748512; x=1721353312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQfqs/W7mE61tsRR5tJN3PuMWsND00BUuiY1spOzn7A=;
 b=YTxb2+TIzP2AT0LMTm7Chtv73nKJJ+9eTgl2HtBUmU8LGOVDlF4KyKgHiBxgKBROHw
 egZn9whw3k+KOtQC2FzYzMWLwoqeZT9EONULuAN4/03kbxCvUsJP3xcs+0a8QChzFoFN
 p1ztIwZ4eGVx1zIK5LS7bZLohH8MSm8W4Wyy8jdj2ldXzG3jqmbH2tzMTGa2A9m7kA7h
 HMmOlnObomDrg8UY4YvIiUvO9oSG9JnOjDI6pCGl1rz3YBz1T3JqHTo7QeAGOVkUMN7h
 Oqdee/h+nEnjlwqgu08D6Jiv8c6U4rhicS+EuztEw59xjflnz1fEw8WFtbWL4nzOdkfN
 ZtTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEHw9jQGBhfB6IwpdajdcKUTHKBp8OvUIw2GfX+wjv/s29U7WojfDHUrpvsHHrK+VsSuiD6zjhcnPe2Sjr20UGcVjRfm4hsNDGvYXVgKPZ+wL6zdJE3HWiuSdru3bN8SibhoqTREbgwxfkDli7vkHfAXJB14RIZr/YzY2IMhmxD3fVg6lcTQ==
X-Gm-Message-State: AOJu0YwE0ThbwyVkHcEqO+pN5XKBfs+9frgfMDxCuRZB5Uy8ZtAL2qPf
 kck5a57yMeGtJ7MHqreiv4miRWKn+qwZGUgXkTjmXoy0beRgnJf6hmywRHnQciDn6+cVjzZCisC
 25/Jyo86xoU1/gVgQQ650dldTyos=
X-Google-Smtp-Source: AGHT+IEqW4C6791kz5lmRum5CV+vQ/yFOoBH0VIxihpxLbedgEaAXHzhtjmQBrV2zG45QnHw5ZKna4l1KTYUlrSjojA=
X-Received: by 2002:a05:6102:38c8:b0:48f:385f:efc with SMTP id
 ada2fe7eead31-490321b9b4bmr12232885137.18.1720748511628; Thu, 11 Jul 2024
 18:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240612081416.29704-1-jim.shu@sifive.com>
 <20240612081416.29704-5-jim.shu@sifive.com>
In-Reply-To: <20240612081416.29704-5-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jul 2024 11:41:25 +1000
Message-ID: <CAKmqyKNjBj8y5RZ8X1U-q=cZLPYcc-x6L2VAY2spfPNxjWMpmg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/16] hw/misc: riscv_worldguard: Add RISC-V
 WorldGuard global config
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Jun 12, 2024 at 6:18=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> Add a device for RISCV WG global config, which contains the number of
> worlds, reset value, and trusted WID ... etc.
>
> This global config is used by both CPU WG extension and wgChecker devices=
.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  hw/misc/Kconfig                    |   3 +
>  hw/misc/meson.build                |   1 +
>  hw/misc/riscv_worldguard.c         | 183 +++++++++++++++++++++++++++++
>  include/hw/misc/riscv_worldguard.h |  55 +++++++++
>  4 files changed, 242 insertions(+)
>  create mode 100644 hw/misc/riscv_worldguard.c
>  create mode 100644 include/hw/misc/riscv_worldguard.h
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1e08785b83..08fc0f2b8c 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -213,4 +213,7 @@ config IOSB
>  config XLNX_VERSAL_TRNG
>      bool
>
> +config RISCV_WORLDGUARD
> +    bool

We should ensure this is enabled as well so that it is built by default

Alistair

> +
>  source macio/Kconfig
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 86596a3888..a75668ff86 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: fi=
les('sifive_e_prci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prc=
i.c'))
> +specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv_w=
orldguard.c'))
>
>  subdir('macio')
>
> diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
> new file mode 100644
> index 0000000000..c839cc4e87
> --- /dev/null
> +++ b/hw/misc/riscv_worldguard.c
> @@ -0,0 +1,183 @@
> +/*
> + * RISC-V WorldGuard Device
> + *
> + * Copyright (c) 2022 SiFive, Inc.
> + *
> + * This provides WorldGuard global config.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "exec/hwaddr.h"
> +#include "hw/registerfields.h"
> +#include "hw/sysbus.h"
> +#include "hw/hw.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/riscv_worldguard.h"
> +#include "hw/core/cpu.h"
> +#include "target/riscv/cpu.h"
> +#include "trace.h"
> +
> +/*
> + * WorldGuard global config:
> + * List the global setting of WG, like num-of-worlds. It is unique in th=
e machine.
> + * All CPUs with WG extension and wgChecker devices will use it.
> + */
> +struct RISCVWorldGuardState *worldguard_config =3D NULL;
> +
> +static Property riscv_worldguard_properties[] =3D {
> +    DEFINE_PROP_UINT32("nworlds", RISCVWorldGuardState, nworlds, 0),
> +
> +    /* Only Trusted WID could access wgCheckers if it is enabled. */
> +    DEFINE_PROP_UINT32("trustedwid", RISCVWorldGuardState, trustedwid, N=
O_TRUSTEDWID),
> +
> +    /*
> +     * WG reset value is bypass mode in HW. All WG permission checkings =
are
> +     * pass by default, so SW could correctly run on the machine w/o any=
 WG
> +     * programming.
> +     */
> +    DEFINE_PROP_BOOL("hw-bypass", RISCVWorldGuardState, hw_bypass, false=
),
> +
> +    /*
> +     * TrustZone compatible mode:
> +     * This mode is only supported in 2 worlds system. It converts World=
Guard
> +     * WID to TZ NS signal on the bus so WG could be cooperated with
> +     * TZ components. In QEMU, it converts WID to 'MemTxAttrs.secure' bi=
t used
> +     * by TZ.
> +     */
> +    DEFINE_PROP_BOOL("tz-compat", RISCVWorldGuardState, tz_compat, false=
),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +/* WID to MemTxAttrs converter */
> +static void wid_to_mem_attrs(MemTxAttrs *attrs, uint32_t wid)
> +{
> +    g_assert(wid < worldguard_config->nworlds);
> +
> +    attrs->unspecified =3D 0;
> +    if (worldguard_config->tz_compat) {
> +        attrs->secure =3D wid;
> +    } else {
> +        attrs->world_id =3D wid;
> +    }
> +}
> +
> +/* MemTxAttrs to WID converter */
> +uint32_t mem_attrs_to_wid(MemTxAttrs attrs)
> +{
> +    if (attrs.unspecified) {
> +        if (worldguard_config->trustedwid !=3D NO_TRUSTEDWID) {
> +            return worldguard_config->trustedwid;
> +        } else {
> +            return worldguard_config->nworlds - 1;
> +        }
> +    }
> +
> +    if (worldguard_config->tz_compat) {
> +        return attrs.secure;
> +    } else {
> +        return attrs.world_id;
> +    }
> +}
> +
> +bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock)
> +{
> +    uint32_t wid =3D mem_attrs_to_wid(attrs);
> +    uint32_t trustedwid =3D worldguard_config->trustedwid;
> +
> +    if ((trustedwid =3D=3D NO_TRUSTEDWID) || (wid =3D=3D trustedwid)) {
> +        return true;
> +    } else {
> +        /*
> +         * Only Trusted WID could access WG blocks if having it.
> +         * Access them from other WIDs will get failed.
> +         */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Invalid access to %s from non-trusted WID %d\=
n",
> +                      __func__, wgblock, wid);
> +
> +        return false;
> +    }
> +}
> +
> +static void riscv_worldguard_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVWorldGuardState *s =3D RISCV_WORLDGUARD(dev);
> +
> +    if (worldguard_config !=3D NULL) {
> +        error_setg(errp, "Couldn't realize multiple global WorldGuard co=
nfigs.");
> +        return;
> +    }
> +
> +    if ((s->nworlds) & (s->nworlds - 1)) {
> +        error_setg(errp, "Current implementation only support power-of-2=
 NWorld.");
> +        return;
> +    }
> +
> +    if ((s->trustedwid !=3D NO_TRUSTEDWID) && (s->trustedwid >=3D s->nwo=
rlds)) {
> +        error_setg(errp, "Trusted WID must be less than the number of wo=
rld.");
> +        return;
> +    }
> +
> +    if ((s->nworlds !=3D 2) && (s->tz_compat)) {
> +        error_setg(errp, "Only 2 worlds system could use TrustZone compa=
tible mode.");
> +        return;
> +    }
> +
> +    /* Register WG global config */
> +    worldguard_config =3D s;
> +
> +    /* Initialize global data for wgChecker */
> +    wgc_slot_perm_mask =3D MAKE_64BIT_MASK(0, 2 * worldguard_config->nwo=
rlds);
> +}
> +
> +static void riscv_worldguard_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, riscv_worldguard_properties);
> +    dc->user_creatable =3D true;
> +    dc->realize =3D riscv_worldguard_realize;
> +}
> +
> +static const TypeInfo riscv_worldguard_info =3D {
> +    .name          =3D TYPE_RISCV_WORLDGUARD,
> +    .parent        =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(RISCVWorldGuardState),
> +    .class_init    =3D riscv_worldguard_class_init,
> +};
> +
> +/*
> + * Create WorldGuard global config
> + */
> +DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedw=
id,
> +                                     bool hw_bypass, bool tz_compat)
> +{
> +    DeviceState *dev =3D qdev_new(TYPE_RISCV_WORLDGUARD);
> +    qdev_prop_set_uint32(dev, "nworlds", nworlds);
> +    qdev_prop_set_uint32(dev, "trustedwid", trustedwid);
> +    qdev_prop_set_bit(dev, "hw-bypass", hw_bypass);
> +    qdev_prop_set_bit(dev, "tz-compat", tz_compat);
> +    qdev_realize(DEVICE(dev), NULL, &error_fatal);
> +    return dev;
> +}
> +
> +static void riscv_worldguard_register_types(void)
> +{
> +    type_register_static(&riscv_worldguard_info);
> +}
> +
> +type_init(riscv_worldguard_register_types)
> diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_w=
orldguard.h
> new file mode 100644
> index 0000000000..8a533a0517
> --- /dev/null
> +++ b/include/hw/misc/riscv_worldguard.h
> @@ -0,0 +1,55 @@
> +/*
> + * RISC-V WorldGuard Devices
> + *
> + * Copyright (c) 2022 RISCV, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RISCV_WORLDGUARD_H
> +#define HW_RISCV_WORLDGUARD_H
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +#include "exec/hwaddr.h"
> +
> +#define TYPE_RISCV_WORLDGUARD "riscv.worldguard"
> +
> +#define NO_TRUSTEDWID           UINT32_MAX
> +
> +typedef struct RISCVWorldGuardState RISCVWorldGuardState;
> +DECLARE_INSTANCE_CHECKER(RISCVWorldGuardState, RISCV_WORLDGUARD,
> +                         TYPE_RISCV_WORLDGUARD)
> +
> +struct RISCVWorldGuardState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +
> +    /* Property */
> +    uint32_t nworlds;
> +    uint32_t trustedwid;
> +    bool hw_bypass;
> +    bool tz_compat;
> +};
> +
> +extern struct RISCVWorldGuardState *worldguard_config;
> +
> +DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedw=
id,
> +                                     bool hw_bypass, bool tz_compat);
> +
> +uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
> +bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
> +
> +#endif
> --
> 2.17.1
>
>

