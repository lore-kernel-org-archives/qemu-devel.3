Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEECCEDD90
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 13:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syWQp-0002UA-5s; Wed, 09 Oct 2024 09:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syWQo-0002Tu-5Q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:08:46 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syWQh-0000no-Th
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:08:45 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-710daaadd9bso3766769a34.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728479316; x=1729084116;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4XKUtczd9AIdhigsMEcu9Di3UlEXZb8C/kTKMDYqoWs=;
 b=abooZPPPAI4xbqhYmXcRbCL1yqgVf1c92PRvtlihFIeSlXh24Zylti8aG0sedWApXD
 Q7EkB+m7V7Ya3qgSXWzMHPknTLvBTaYmxMmRq22WtgrvKYZWDKTYxkUFJVaCDxxC+myV
 zme7bdsmJY5+zKjz0dSBPNsq1SEsUh25CvJUuh+Qiz5WaxeL/dBFtOec02ja4aMiHP6j
 RW0k5fLbNj4336k2cEI0DwqIaGEe0BuR/5NzbL01rY0lX0EURZrBhWHnQZzXkgVy9Z7W
 UA6Y77H7Ma9AhafP2F7Hj5L4v2I9BSDjiG5+VS9EWno6Yq2SXOphsCS31tGoUcVivaWf
 +FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728479316; x=1729084116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4XKUtczd9AIdhigsMEcu9Di3UlEXZb8C/kTKMDYqoWs=;
 b=BB1cFJh3LOzlu2CRV4PZZLxLu5FWriBL78gmbqBN/xOUK7QcTTuVYFDTWyZ2D0GNrG
 VerGrqcUTzJ9+VZsg33swn3cZpNWeGdBQ5PoD3wu8p6iyBvP6qUzchkiuTWwjSin0mv3
 Esqezp6MyiJoJ6+nFvnG4XMRqNrCVnW25qrPtZZZxsqX5PypdnguC4kZCx43Ni8TZQBH
 Burz/tulLBCZQYdvtTJNIEbYDcPlN6/0hNCWPbkTTmgfvugjXIWk2iwM25oliAuv0ltu
 h9uGqESkmMN6PRU0dA100QE80WDlrsYSZhqN8lczpfBNxeuM5UGIj0arLcxeybdoZNId
 Ht6w==
X-Gm-Message-State: AOJu0Yy9xj9IuLANGsNw25Uh51INUuZg9wkLyjCH58vRgAh+Y8McXc+4
 6K5flVgFXRk/4z+EJP/CVfsRgM9EWYSoZIld6Gb39q6en65W5xSRIIaDleafEXQ4qO3CWKyyKlj
 7X52VO/dZ0JiJwRZrgdpQRkqn5F3h40i7uw0g
X-Google-Smtp-Source: AGHT+IG0Tw7c07cBhmqi6xWR7Xp1XbA/wVb/13EfH+UHOryw3jemALR5cTqzVw4hiA8qMmR9M065au/C8Fm55KDajJs=
X-Received: by 2002:a05:6358:52c2:b0:1b8:40e5:4237 with SMTP id
 e5c5f4694b2df-1c3080eda85mr68217855d.10.1728479316412; Wed, 09 Oct 2024
 06:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-13-phil@philjordan.eu>
 <08fb08f5-b0ca-4334-8896-b0941cea614a@daynix.com>
 <CAAibmn0S6Qe4gLirAA9eU+M_PbSUUqcJs1-eZmwGge+CXg4p1A@mail.gmail.com>
 <60753df2-c1da-400f-a9d4-36077ab0c1f7@daynix.com>
In-Reply-To: <60753df2-c1da-400f-a9d4-36077ab0c1f7@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 9 Oct 2024 15:08:25 +0200
Message-ID: <CAAibmn1j2db4yH1TVQ+e+6bSuGGaQtbQaf+joPkWWnD-z6rEqA@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] hw/vmapple/cfg: Introduce vmapple cfg region
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000a827d506240af395"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::331;
 envelope-from=phil@philjordan.eu; helo=mail-ot1-x331.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000a827d506240af395
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2024 at 20:04, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/10/07 23:10, Phil Dennis-Jordan wrote:
> >
> >
> > On Sat, 5 Oct 2024 at 07:35, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> >      > From: Alexander Graf <graf@amazon.com <mailto:graf@amazon.com>>
> >      >
> >      > Instead of device tree or other more standardized means, VMApple
> >     passes
> >      > platform configuration to the first stage boot loader in a binar=
y
> >     encoded
> >      > format that resides at a dedicated RAM region in physical addres=
s
> >     space.
> >      >
> >      > This patch models this configuration space as a qdev device whic=
h
> >     we can
> >      > then map at the fixed location in the address space. That way, w=
e
> can
> >      > influence and annotate all configuration fields easily.
> >      >
> >      > Signed-off-by: Alexander Graf <graf@amazon.com
> >     <mailto:graf@amazon.com>>
> >      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
> >     <mailto:phil@philjordan.eu>>
> >      >
> >      > ---
> >      > v3:
> >      >
> >      >   * Replaced legacy device reset method with Resettable method
> >      >
> >      >   hw/vmapple/Kconfig       |   3 ++
> >      >   hw/vmapple/cfg.c         | 106 +++++++++++++++++++++++++++++++=
+
> >     +++++++
> >      >   hw/vmapple/meson.build   |   1 +
> >      >   include/hw/vmapple/cfg.h |  68 +++++++++++++++++++++++++
> >      >   4 files changed, 178 insertions(+)
> >      >   create mode 100644 hw/vmapple/cfg.c
> >      >   create mode 100644 include/hw/vmapple/cfg.h
> >      >
> >      > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> >      > index 68f88876eb9..8bbeb9a9237 100644
> >      > --- a/hw/vmapple/Kconfig
> >      > +++ b/hw/vmapple/Kconfig
> >      > @@ -4,3 +4,6 @@ config VMAPPLE_AES
> >      >   config VMAPPLE_BDIF
> >      >       bool
> >      >
> >      > +config VMAPPLE_CFG
> >      > +    bool
> >      > +
> >      > diff --git a/hw/vmapple/cfg.c b/hw/vmapple/cfg.c
> >      > new file mode 100644
> >      > index 00000000000..a5e5c62f59f
> >      > --- /dev/null
> >      > +++ b/hw/vmapple/cfg.c
> >      > @@ -0,0 +1,106 @@
> >      > +/*
> >      > + * VMApple Configuration Region
> >      > + *
> >      > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. Al=
l
> >     Rights Reserved.
> >      > + *
> >      > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >     2 or later.
> >      > + * See the COPYING file in the top-level directory.
> >      > + */
> >      > +
> >      > +#include "qemu/osdep.h"
> >      > +#include "hw/vmapple/cfg.h"
> >      > +#include "qemu/log.h"
> >      > +#include "qemu/module.h"
> >      > +#include "qapi/error.h"
> >      > +
> >      > +static void vmapple_cfg_reset(Object *obj, ResetType type)
> >      > +{
> >      > +    VMAppleCfgState *s =3D VMAPPLE_CFG(obj);
> >      > +    VMAppleCfg *cfg;
> >      > +
> >      > +    cfg =3D memory_region_get_ram_ptr(&s->mem);
> >      > +    memset((void *)cfg, 0, VMAPPLE_CFG_SIZE);
> >      > +    *cfg =3D s->cfg;
> >       > +}> +
> >      > +static void vmapple_cfg_realize(DeviceState *dev, Error **errp)
> >      > +{
> >      > +    VMAppleCfgState *s =3D VMAPPLE_CFG(dev);
> >      > +    uint32_t i;
> >      > +
> >      > +    strncpy(s->cfg.serial, s->serial, sizeof(s->cfg.serial));
> >      > +    strncpy(s->cfg.model, s->model, sizeof(s->cfg.model));
> >      > +    strncpy(s->cfg.soc_name, s->soc_name,
> sizeof(s->cfg.soc_name));
> >      > +    strncpy(s->cfg.unk8, "D/A", sizeof(s->cfg.soc_name));
> >
> >     Use qemu_strnlen() to report an error for too long strings.
> >
> >
> > Hmm, I don't see any existing instances of such a pattern. I do however
> > see a couple of uses of g_strlcpy in the Qemu codebase - that would be =
a
> > better candidate for error checked string copying, though it still
> > involves some awkward return value checks. I'm going to wrap that in a
> > helper function and macro to replace all 4 strncpy instances here. If
> > the same thing is useful elsewhere later, it can be promoted to cutils
> > or similar.
>
> g_strlcpy() internally performs strlen(), which is worse than
> qemu_strnlen().
>

Worse in what sense? It really depends what you're defending against. Sure,
strlcpy blows up if the source string isn't nul-terminated. All the source
strings here are expected to be nul-terminated here though.


> It is nice to have a helper function. Linux also has something similar
> called strscpy():
> https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.strscpy
>

I'm not convinced this is the right patch set to be reinventing Qemu's
string copying functions. Instances abound of the even less safe strcpy()
(and sprintf, etc.) being used in Qemu. Some of those are likely even
problematic, but it seems that should be subject to a more holistic
investigation into what kinds of usage patterns there are, and then a
handful of safe solutions can be found that would work for 99% of string
copying in the code base. Not by adding yet another strcpy variant in a
device backend and machine type patch set where one of the existing
variants works just fine.


> >
> > (Also, I notice that last strncpy actually uses the wrong destination
> > size; my wrapper macro uses ARRAY_SIZE to avoid this mistake altogether=
.)
> >
> >      > +    s->cfg.ecid =3D cpu_to_be64(s->cfg.ecid);
> >      > +    s->cfg.version =3D 2;
> >      > +    s->cfg.unk1 =3D 1;
> >      > +    s->cfg.unk2 =3D 1;
> >      > +    s->cfg.unk3 =3D 0x20;
> >      > +    s->cfg.unk4 =3D 0;
> >      > +    s->cfg.unk5 =3D 1;
> >      > +    s->cfg.unk6 =3D 1;
> >      > +    s->cfg.unk7 =3D 0;
> >      > +    s->cfg.unk10 =3D 1;
> >      > +
> >      > +    g_assert(s->cfg.nr_cpus < ARRAY_SIZE(s->cfg.cpu_ids));
> >
> >     Report an error instead of asserting.
> >
> >      > +    for (i =3D 0; i < s->cfg.nr_cpus; i++) {
> >      > +        s->cfg.cpu_ids[i] =3D i;
> >      > +    }
> >       > +}> +
> >      > +static void vmapple_cfg_init(Object *obj)
> >      > +{
> >      > +    VMAppleCfgState *s =3D VMAPPLE_CFG(obj);
> >      > +
> >      > +    memory_region_init_ram(&s->mem, obj, "VMApple Config",
> >     VMAPPLE_CFG_SIZE,
> >      > +                           &error_fatal);
> >      > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mem);
> >      > +
> >      > +    s->serial =3D (char *)"1234";
> >      > +    s->model =3D (char *)"VM0001";
> >      > +    s->soc_name =3D (char *)"Apple M1 (Virtual)";
> >
> >     These casts are unsafe; these pointers will be freed when this
> >     device is
> >     freed.
> >
> >
> > Good catch! The more usual pattern for default string property values
> > seems to be to fill them in _realize() (using g_strdup()) if no other
> > value was previously set, so I've applied that here for the next versio=
n
> > of the patch.
> >
> >
> >      > +}
> >      > +
> >      > +static Property vmapple_cfg_properties[] =3D {
> >      > +    DEFINE_PROP_UINT32("nr-cpus", VMAppleCfgState, cfg.nr_cpus,
> 1),
> >      > +    DEFINE_PROP_UINT64("ecid", VMAppleCfgState, cfg.ecid, 0),
> >      > +    DEFINE_PROP_UINT64("ram-size", VMAppleCfgState,
> >     cfg.ram_size, 0),
> >      > +    DEFINE_PROP_UINT32("run_installer1", VMAppleCfgState,
> >     cfg.run_installer1, 0),
> >      > +    DEFINE_PROP_UINT32("run_installer2", VMAppleCfgState,
> >     cfg.run_installer2, 0),
> >      > +    DEFINE_PROP_UINT32("rnd", VMAppleCfgState, cfg.rnd, 0),
> >      > +    DEFINE_PROP_MACADDR("mac-en0", VMAppleCfgState, cfg.mac_en0=
),
> >      > +    DEFINE_PROP_MACADDR("mac-en1", VMAppleCfgState, cfg.mac_en1=
),
> >      > +    DEFINE_PROP_MACADDR("mac-wifi0", VMAppleCfgState,
> >     cfg.mac_wifi0),
> >      > +    DEFINE_PROP_MACADDR("mac-bt0", VMAppleCfgState, cfg.mac_bt0=
),
> >      > +    DEFINE_PROP_STRING("serial", VMAppleCfgState, serial),
> >      > +    DEFINE_PROP_STRING("model", VMAppleCfgState, model),
> >      > +    DEFINE_PROP_STRING("soc_name", VMAppleCfgState, soc_name),
> >      > +    DEFINE_PROP_END_OF_LIST(),
> >      > +};
> >      > +
> >      > +static void vmapple_cfg_class_init(ObjectClass *klass, void
> *data)
> >      > +{
> >      > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >      > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> >      > +
> >      > +    dc->realize =3D vmapple_cfg_realize;
> >      > +    dc->desc =3D "VMApple Configuration Region";
> >      > +    device_class_set_props(dc, vmapple_cfg_properties);
> >      > +    rc->phases.hold =3D vmapple_cfg_reset;
> >      > +}
> >      > +
> >      > +static const TypeInfo vmapple_cfg_info =3D {
> >      > +    .name          =3D TYPE_VMAPPLE_CFG,
> >      > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >      > +    .instance_size =3D sizeof(VMAppleCfgState),
> >      > +    .instance_init =3D vmapple_cfg_init,
> >      > +    .class_init    =3D vmapple_cfg_class_init,
> >      > +};
> >      > +
> >      > +static void vmapple_cfg_register_types(void)
> >      > +{
> >      > +    type_register_static(&vmapple_cfg_info);
> >      > +}
> >      > +
> >      > +type_init(vmapple_cfg_register_types)
> >      > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> >      > index d4624713deb..64b78693a31 100644
> >      > --- a/hw/vmapple/meson.build
> >      > +++ b/hw/vmapple/meson.build
> >      > @@ -1,2 +1,3 @@
> >      >   system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true:
> files('aes.c'))
> >      >   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true:
> >     files('bdif.c'))
> >      > +system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true:
> files('cfg.c'))
> >      > diff --git a/include/hw/vmapple/cfg.h b/include/hw/vmapple/cfg.h
> >      > new file mode 100644
> >      > index 00000000000..3337064e447
> >      > --- /dev/null
> >      > +++ b/include/hw/vmapple/cfg.h
> >      > @@ -0,0 +1,68 @@
> >      > +/*
> >      > + * VMApple Configuration Region
> >      > + *
> >      > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. Al=
l
> >     Rights Reserved.
> >      > + *
> >      > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >     2 or later.
> >      > + * See the COPYING file in the top-level directory.
> >      > + */
> >      > +
> >      > +#ifndef HW_VMAPPLE_CFG_H
> >      > +#define HW_VMAPPLE_CFG_H
> >      > +
> >      > +#include "hw/sysbus.h"
> >      > +#include "qom/object.h"
> >      > +#include "net/net.h"
> >      > +
> >      > +typedef struct VMAppleCfg {
> >      > +    uint32_t version;         /* 0x000 */
> >      > +    uint32_t nr_cpus;         /* 0x004 */
> >      > +    uint32_t unk1;            /* 0x008 */
> >      > +    uint32_t unk2;            /* 0x00c */
> >      > +    uint32_t unk3;            /* 0x010 */
> >      > +    uint32_t unk4;            /* 0x014 */
> >      > +    uint64_t ecid;            /* 0x018 */
> >      > +    uint64_t ram_size;        /* 0x020 */
> >      > +    uint32_t run_installer1;  /* 0x028 */
> >      > +    uint32_t unk5;            /* 0x02c */
> >      > +    uint32_t unk6;            /* 0x030 */
> >      > +    uint32_t run_installer2;  /* 0x034 */
> >      > +    uint32_t rnd;             /* 0x038 */
> >      > +    uint32_t unk7;            /* 0x03c */
> >      > +    MACAddr mac_en0;          /* 0x040 */
> >      > +    uint8_t pad1[2];
> >      > +    MACAddr mac_en1;          /* 0x048 */
> >      > +    uint8_t pad2[2];
> >      > +    MACAddr mac_wifi0;        /* 0x050 */
> >      > +    uint8_t pad3[2];
> >      > +    MACAddr mac_bt0;          /* 0x058 */
> >      > +    uint8_t pad4[2];
> >      > +    uint8_t reserved[0xa0];   /* 0x060 */
> >      > +    uint32_t cpu_ids[0x80];   /* 0x100 */
> >      > +    uint8_t scratch[0x200];   /* 0x180 */
> >      > +    char serial[32];          /* 0x380 */
> >      > +    char unk8[32];            /* 0x3a0 */
> >      > +    char model[32];           /* 0x3c0 */
> >      > +    uint8_t unk9[32];         /* 0x3e0 */
> >      > +    uint32_t unk10;           /* 0x400 */
> >      > +    char soc_name[32];        /* 0x404 */
> >      > +} VMAppleCfg;
> >      > +
> >      > +#define TYPE_VMAPPLE_CFG "vmapple-cfg"
> >      > +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleCfgState, VMAPPLE_CFG)
> >      > +
> >      > +struct VMAppleCfgState {
> >      > +    /* <private> */
> >      > +    SysBusDevice parent_obj;
> >      > +    VMAppleCfg cfg;
> >      > +
> >      > +    /* <public> */
> >      > +    MemoryRegion mem;
> >      > +    char *serial;
> >      > +    char *model;
> >      > +    char *soc_name;
> >      > +};
> >      > +
> >      > +#define VMAPPLE_CFG_SIZE 0x00010000
> >      > +
> >      > +#endif /* HW_VMAPPLE_CFG_H */
> >
>
>

--000000000000a827d506240af395
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 7 Oct 2024 at 20:04, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 2024/10/07 23:10, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Sat, 5 Oct 2024 at 07:35, Akihiko Odaki &lt;<a href=3D"mailto:akihi=
ko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2024/09/28 17:57, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; From: Alexander Graf &lt;<a href=3D"mailto:gr=
af@amazon.com" target=3D"_blank">graf@amazon.com</a> &lt;mailto:<a href=3D"=
mailto:graf@amazon.com" target=3D"_blank">graf@amazon.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Instead of device tree or other more standard=
ized means, VMApple<br>
&gt;=C2=A0 =C2=A0 =C2=A0passes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; platform configuration to the first stage boo=
t loader in a binary<br>
&gt;=C2=A0 =C2=A0 =C2=A0encoded<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; format that resides at a dedicated RAM region=
 in physical address<br>
&gt;=C2=A0 =C2=A0 =C2=A0space.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This patch models this configuration space as=
 a qdev device which<br>
&gt;=C2=A0 =C2=A0 =C2=A0we can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; then map at the fixed location in the address=
 space. That way, we can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; influence and annotate all configuration fiel=
ds easily.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Alexander Graf &lt;<a href=3D"=
mailto:graf@amazon.com" target=3D"_blank">graf@amazon.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:graf@amazon.com" targe=
t=3D"_blank">graf@amazon.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=
=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v3:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Replaced legacy device reset me=
thod with Resettable method<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A03 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/cfg.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 106 ++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/hw/vmapple/cfg.h |=C2=A0 =
68 +++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A04 files changed, 178 insertions(+=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/cfg=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 include/hw/vma=
pple/cfg.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/=
Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 68f88876eb9..8bbeb9a9237 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -4,3 +4,6 @@ config VMAPPLE_AES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0config VMAPPLE_BDIF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +config VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/cfg.c b/hw/vmapple/cf=
g.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..a5e5c62f59f<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/cfg.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,106 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * VMApple Configuration Region<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or=
 its affiliates. All<br>
&gt;=C2=A0 =C2=A0 =C2=A0Rights Reserved.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This work is licensed under the terms of =
the GNU GPL, version<br>
&gt;=C2=A0 =C2=A0 =C2=A02 or later.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * See the COPYING file in the top-level dir=
ectory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/vmapple/cfg.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_cfg_reset(Object *obj, R=
esetType type)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleCfgState *s =3D VMAPPLE=
_CFG(obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleCfg *cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 cfg =3D memory_region_get_ram_=
ptr(&amp;s-&gt;mem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memset((void *)cfg, 0, VMAPPLE=
_CFG_SIZE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 *cfg =3D s-&gt;cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +}&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_cfg_realize(DeviceState =
*dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleCfgState *s =3D VMAPPLE=
_CFG(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 strncpy(s-&gt;cfg.serial, s-&g=
t;serial, sizeof(s-&gt;cfg.serial));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 strncpy(s-&gt;cfg.model, s-&gt=
;model, sizeof(s-&gt;cfg.model));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 strncpy(s-&gt;cfg.soc_name, s-=
&gt;soc_name, sizeof(s-&gt;cfg.soc_name));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 strncpy(s-&gt;cfg.unk8, &quot;=
D/A&quot;, sizeof(s-&gt;cfg.soc_name));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Use qemu_strnlen() to report an error for too long =
strings.<br>
&gt; <br>
&gt; <br>
&gt; Hmm, I don&#39;t see any existing instances of such a pattern. I do ho=
wever <br>
&gt; see a couple of uses of=C2=A0g_strlcpy in the Qemu codebase - that wou=
ld be a <br>
&gt; better candidate for error checked string copying, though it still <br=
>
&gt; involves some awkward return value checks. I&#39;m going to wrap that =
in a <br>
&gt; helper function and macro to replace all 4 strncpy instances here. If =
<br>
&gt; the same thing is useful elsewhere later, it can be promoted to cutils=
 <br>
&gt; or similar.<br>
<br>
g_strlcpy() internally performs strlen(), which is worse than <br>
qemu_strnlen().<br></blockquote><div><br></div><div>Worse in what sense? It=
 really depends what you&#39;re defending against. Sure, strlcpy blows up i=
f the source string isn&#39;t nul-terminated. All the source strings here a=
re expected to be nul-terminated here though. </div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
It is nice to have a helper function. Linux also has something similar <br>
called strscpy():<br>
<a href=3D"https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#=
c.strscpy" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/=
html/latest/core-api/kernel-api.html#c.strscpy</a><br></blockquote><div><br=
></div><div>I&#39;m not convinced this is the right patch set to be reinven=
ting Qemu&#39;s string copying functions. Instances abound of the even less=
 safe strcpy() (and sprintf, etc.) being used in Qemu. Some of those are li=
kely even problematic, but it seems that should be subject to a more holist=
ic investigation into what kinds of usage patterns there are, and then a ha=
ndful of safe solutions can be found that would work for 99% of string copy=
ing in the code base. Not by adding yet another strcpy variant in a device =
backend and machine type patch set where one of the existing variants works=
 just fine.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt; <br>
&gt; (Also, I notice that last strncpy actually uses the wrong destination =
<br>
&gt; size; my wrapper macro uses ARRAY_SIZE to avoid this mistake altogethe=
r.)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.ecid =3D cpu_to_be64=
(s-&gt;cfg.ecid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.version =3D 2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk1 =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk2 =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk3 =3D 0x20;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk4 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk5 =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk6 =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk7 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cfg.unk10 =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 g_assert(s-&gt;cfg.nr_cpus &lt=
; ARRAY_SIZE(s-&gt;cfg.cpu_ids));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Report an error instead of asserting.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; s-&gt;cfg=
.nr_cpus; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cfg.cpu_id=
s[i] =3D i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +}&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_cfg_init(Object *obj)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleCfgState *s =3D VMAPPLE=
_CFG(obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-=
&gt;mem, obj, &quot;VMApple Config&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0VMAPPLE_CFG_SIZE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVIC=
E(obj), &amp;s-&gt;mem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;serial =3D (char *)&quot=
;1234&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;model =3D (char *)&quot;=
VM0001&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;soc_name =3D (char *)&qu=
ot;Apple M1 (Virtual)&quot;;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0These casts are unsafe; these pointers will be free=
d when this<br>
&gt;=C2=A0 =C2=A0 =C2=A0device is<br>
&gt;=C2=A0 =C2=A0 =C2=A0freed.<br>
&gt; <br>
&gt; <br>
&gt; Good catch! The more usual pattern for default string property values =
<br>
&gt; seems to be to fill them in _realize() (using g_strdup()) if no other =
<br>
&gt; value was previously set, so I&#39;ve applied that here for the next v=
ersion <br>
&gt; of the patch.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static Property vmapple_cfg_properties[] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;nr-cp=
us&quot;, VMAppleCfgState, cfg.nr_cpus, 1),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;ecid&=
quot;, VMAppleCfgState, cfg.ecid, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;ram-s=
ize&quot;, VMAppleCfgState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0cfg.ram_size, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;run_i=
nstaller1&quot;, VMAppleCfgState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0cfg.run_installer1, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;run_i=
nstaller2&quot;, VMAppleCfgState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0cfg.run_installer2, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;rnd&q=
uot;, VMAppleCfgState, cfg.rnd, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_MACADDR(&quot;mac-=
en0&quot;, VMAppleCfgState, cfg.mac_en0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_MACADDR(&quot;mac-=
en1&quot;, VMAppleCfgState, cfg.mac_en1),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_MACADDR(&quot;mac-=
wifi0&quot;, VMAppleCfgState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0cfg.mac_wifi0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_MACADDR(&quot;mac-=
bt0&quot;, VMAppleCfgState, cfg.mac_bt0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;seria=
l&quot;, VMAppleCfgState, serial),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;model=
&quot;, VMAppleCfgState, model),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;soc_n=
ame&quot;, VMAppleCfgState, soc_name),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_cfg_class_init(ObjectCla=
ss *klass, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLA=
SS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 ResettableClass *rc =3D RESETT=
ABLE_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D vmapple_cfg=
_realize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;VMApple =
Configuration Region&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 device_class_set_props(dc, vma=
pple_cfg_properties);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 rc-&gt;phases.hold =3D vmapple=
_cfg_reset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const TypeInfo vmapple_cfg_info =3D {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D TYPE_VMAPPLE_CFG,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D TYPE_SYS_BUS_DEVICE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAp=
pleCfgState),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_cfg=
_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D v=
mapple_cfg_class_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_cfg_register_types(void)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmap=
ple_cfg_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +type_init(vmapple_cfg_register_types)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/meson.build b/hw/vmap=
ple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index d4624713deb..64b78693a31 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/vmapple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -1,2 +1,3 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_V=
MAPPLE_AES&#39;,=C2=A0 if_true: files(&#39;aes.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_V=
MAPPLE_BDIF&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;bdif.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +system_ss.add(when: &#39;CONFIG_VMAPPLE_CFG&=
#39;,=C2=A0 if_true: files(&#39;cfg.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/hw/vmapple/cfg.h b/inclu=
de/hw/vmapple/cfg.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..3337064e447<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/hw/vmapple/cfg.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,68 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * VMApple Configuration Region<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or=
 its affiliates. All<br>
&gt;=C2=A0 =C2=A0 =C2=A0Rights Reserved.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This work is licensed under the terms of =
the GNU GPL, version<br>
&gt;=C2=A0 =C2=A0 =C2=A02 or later.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * See the COPYING file in the top-level dir=
ectory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#ifndef HW_VMAPPLE_CFG_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define HW_VMAPPLE_CFG_H<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qom/object.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;net/net.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct VMAppleCfg {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t version;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* 0x000 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t nr_cpus;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* 0x004 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t unk1;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x008 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t unk2;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x00c */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t unk3;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x010 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t unk4;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x014 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t ecid;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x018 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint64_t ram_size;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* 0x020 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t run_installer1;=C2=A0=
 /* 0x028 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t unk5;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x02c */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t unk6;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x030 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t run_installer2;=C2=A0=
 /* 0x034 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t rnd;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 0x038 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t unk7;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x03c */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MACAddr mac_en0;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* 0x040 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint8_t pad1[2];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MACAddr mac_en1;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* 0x048 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint8_t pad2[2];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MACAddr mac_wifi0;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* 0x050 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint8_t pad3[2];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MACAddr mac_bt0;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* 0x058 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint8_t pad4[2];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint8_t reserved[0xa0];=C2=A0 =
=C2=A0/* 0x060 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t cpu_ids[0x80];=C2=A0 =
=C2=A0/* 0x100 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint8_t scratch[0x200];=C2=A0 =
=C2=A0/* 0x180 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char serial[32];=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* 0x380 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char unk8[32];=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x3a0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char model[32];=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 0x3c0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint8_t unk9[32];=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* 0x3e0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t unk10;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 0x400 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char soc_name[32];=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* 0x404 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} VMAppleCfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define TYPE_VMAPPLE_CFG &quot;vmapple-cfg&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleCfgState, =
VMAPPLE_CFG)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +struct VMAppleCfgState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* &lt;private&gt; */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleCfg cfg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* &lt;public&gt; */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MemoryRegion mem;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char *serial;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char *model;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 char *soc_name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define VMAPPLE_CFG_SIZE 0x00010000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#endif /* HW_VMAPPLE_CFG_H */<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000a827d506240af395--

