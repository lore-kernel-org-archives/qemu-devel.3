Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A78CEDD98
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syXFe-0006ej-IP; Wed, 09 Oct 2024 10:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syXFc-0006dk-HK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 10:01:16 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syXFZ-0006aF-6D
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 10:01:16 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-50abb0c511cso2078435e0c.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728482472; x=1729087272;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SND2Qtyr6/qis6t0z3vm3/ix/MT1Wd+0FoAx5WvSVqk=;
 b=eq+SGYNh3eb2NuuJTPBdk09fSxgwogLd9qCRj/GoyBiWKjK6SKPNCU0zqbPzBoCCFp
 yxoFb2+gJw2VfiZRS/ZKkT4WrUQMoq3NEsTpDrjZvFVJ/667B64nWp59v4W+9epG56uI
 9Q+d78zcseFFFbIuiHnA8cL/d+hxqn1C9hKjuyhjqLf7VFUkgvcwsCxDWDbzSto4YqBf
 Zyew3CZQjzlTcj70fSj4n33yJ0RpC54I47BwJ5AB7CKRddpPo4VrsK83gECB4GiNLBTw
 3GA1u8xAfu9xa3KbUKs3bVdlcfhr3lvBo4YMVSQgWT8QmKZm5iPFuknmnK5yKEasReK+
 IY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728482472; x=1729087272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SND2Qtyr6/qis6t0z3vm3/ix/MT1Wd+0FoAx5WvSVqk=;
 b=KFXW2dc1bLkBFmM3JdI/Z/yGVxI7KSuqgQU1wbekwmwLoMdhgVrHDy5mR/SpUXukN8
 BePCFAqctf7Mo1y1GPTdax4uYpGchS/fVHOBshDirun5VdH2prShRa/gBP+xHtTJuCny
 oi7+BZH2nLsdG9J/ssefzKkJo1dd+kx+s9JAj+KOBkhM7pixannKulQ8RD8PjAQl64tI
 RWT4VgcE2cbNYjoSJyIvz1nklZbWwymexklyOxMTaLnVBEPZp6IzLptBJsIleFEJh0b4
 /Mo7rr1HO6Iosta8ZSwfOVVWinSazvL0AitOhqksSfb9m6qVXTaux7jif4s2iY8t8Vye
 jfxA==
X-Gm-Message-State: AOJu0Yxh1NMFBX9izHv0HDHpvlXq7wcxRY5BdgixQrbXRmUYTgFdQNPe
 ILQiIhZgzczYlhU9nsJB3ujzmbyUfJoYL8AtVNuy7CwbXv0zdTVpn9BtysphD43yycgUmV2S3VL
 aLeHjPV2FqpOu3XjtQh0uP6O2g40qhDmURi7g
X-Google-Smtp-Source: AGHT+IELNU8sMknyTL1OAIh8wclRcH7X5P/2Mnjc1L8xLQzmGQYwiRYFFsjwpzReyEj6O2pm9LwVNdTCBVnEbyYWed0=
X-Received: by 2002:a05:6122:4687:b0:509:3dc0:fdd9 with SMTP id
 71dfb90a1353d-50cf02511c4mr1613344e0c.0.1728482471235; Wed, 09 Oct 2024
 07:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-12-phil@philjordan.eu>
 <7af710d1-e337-41b8-9328-0488fc20f438@daynix.com>
In-Reply-To: <7af710d1-e337-41b8-9328-0488fc20f438@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 9 Oct 2024 16:00:59 +0200
Message-ID: <CAAibmn2XBPDO++ZaRV_Vt_zK-sDrkkRdkKd89x7hBcNhtEmGqQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] hw/vmapple/bdif: Introduce vmapple backdoor
 interface
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
Content-Type: multipart/alternative; boundary="000000000000b2f5b906240bafe9"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a34;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa34.google.com
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

--000000000000b2f5b906240bafe9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Oct 2024 at 07:12, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > The VMApple machine exposes AUX and ROOT block devices (as well as USB
> OTG
> > emulation) via virtio-pci as well as a special, simple backdoor platfor=
m
> > device.
> >
> > This patch implements this backdoor platform device to the best of my
> > understanding. I left out any USB OTG parts; they're only needed for
> > guest recovery and I don't understand the protocol yet.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   hw/vmapple/Kconfig        |   3 +
> >   hw/vmapple/bdif.c         | 245 +++++++++++++++++++++++++++++++++++++=
+
> >   hw/vmapple/meson.build    |   1 +
> >   hw/vmapple/trace-events   |   5 +
> >   include/hw/vmapple/bdif.h |  31 +++++
> >   5 files changed, 285 insertions(+)
> >   create mode 100644 hw/vmapple/bdif.c
> >   create mode 100644 include/hw/vmapple/bdif.h
> >
> > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> > index a73504d5999..68f88876eb9 100644
> > --- a/hw/vmapple/Kconfig
> > +++ b/hw/vmapple/Kconfig
> > @@ -1,3 +1,6 @@
> >   config VMAPPLE_AES
> >       bool
> >
> > +config VMAPPLE_BDIF
> > +    bool
> > +
> > diff --git a/hw/vmapple/bdif.c b/hw/vmapple/bdif.c
> > new file mode 100644
> > index 00000000000..36b5915ff30
> > --- /dev/null
> > +++ b/hw/vmapple/bdif.c
> > @@ -0,0 +1,245 @@
> > +/*
> > + * VMApple Backdoor Interface
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s
> Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/vmapple/bdif.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qapi/error.h"
> > +#include "trace.h"
> > +#include "hw/block/block.h"
> > +#include "sysemu/block-backend.h"
> > +
> > +#define REG_DEVID_MASK      0xffff0000
> > +#define DEVID_ROOT          0x00000000
> > +#define DEVID_AUX           0x00010000
> > +#define DEVID_USB           0x00100000
> > +
> > +#define REG_STATUS          0x0
> > +#define REG_STATUS_ACTIVE     BIT(0)
> > +#define REG_CFG             0x4
> > +#define REG_CFG_ACTIVE        BIT(1)
> > +#define REG_UNK1            0x8
> > +#define REG_BUSY            0x10
> > +#define REG_BUSY_READY        BIT(0)
> > +#define REG_UNK2            0x400
> > +#define REG_CMD             0x408
> > +#define REG_NEXT_DEVICE     0x420
> > +#define REG_UNK3            0x434
> > +
> > +typedef struct vblk_sector {
>
> Please use VblkSector for the tag name too.
>
> > +    uint32_t pad;
> > +    uint32_t pad2;
> > +    uint32_t sector;
> > +    uint32_t pad3;
> > +} VblkSector;
> > +
> > +typedef struct vblk_req_cmd {
> > +    uint64_t addr;
> > +    uint32_t len;
> > +    uint32_t flags;
> > +} VblkReqCmd;
> > +
> > +typedef struct vblk_req {
> > +    VblkReqCmd sector;
> > +    VblkReqCmd data;
> > +    VblkReqCmd retval;
> > +} VblkReq;
> > +
> > +#define VBLK_DATA_FLAGS_READ  0x00030001
> > +#define VBLK_DATA_FLAGS_WRITE 0x00010001
> > +
> > +#define VBLK_RET_SUCCESS  0
> > +#define VBLK_RET_FAILED   1
> > +
> > +static uint64_t bdif_read(void *opaque, hwaddr offset, unsigned size)
> > +{
> > +    uint64_t ret =3D -1;
> > +    uint64_t devid =3D (offset & REG_DEVID_MASK);
>
> The parenthes in this line are unnecessary.
>
> > +
> > +    switch (offset & ~REG_DEVID_MASK) {
> > +    case REG_STATUS:
> > +        ret =3D REG_STATUS_ACTIVE;
> > +        break;
> > +    case REG_CFG:
> > +        ret =3D REG_CFG_ACTIVE;
> > +        break;
> > +    case REG_UNK1:
> > +        ret =3D 0x420;
> > +        break;
> > +    case REG_BUSY:
> > +        ret =3D REG_BUSY_READY;
> > +        break;
> > +    case REG_UNK2:
> > +        ret =3D 0x1;
> > +        break;
> > +    case REG_UNK3:
> > +        ret =3D 0x0;
> > +        break;
> > +    case REG_NEXT_DEVICE:
> > +        switch (devid) {
> > +        case DEVID_ROOT:
> > +            ret =3D 0x8000000;
> > +            break;
> > +        case DEVID_AUX:
> > +            ret =3D 0x10000;
> > +            break;
> > +        }
> > +        break;
> > +    }
> > +
> > +    trace_bdif_read(offset, size, ret);
> > +    return ret;
> > +}
> > +
> > +static void le2cpu_sector(VblkSector *sector)
> > +{
> > +    sector->sector =3D le32_to_cpu(sector->sector);
> > +}
> > +
> > +static void le2cpu_reqcmd(VblkReqCmd *cmd)
> > +{
> > +    cmd->addr =3D le64_to_cpu(cmd->addr);
> > +    cmd->len =3D le32_to_cpu(cmd->len);
> > +    cmd->flags =3D le32_to_cpu(cmd->flags);
> > +}
> > +
> > +static void le2cpu_req(VblkReq *req)
> > +{
> > +    le2cpu_reqcmd(&req->sector);
> > +    le2cpu_reqcmd(&req->data);
> > +    le2cpu_reqcmd(&req->retval);
> > +}
> > +
> > +static void vblk_cmd(uint64_t devid, BlockBackend *blk, uint64_t value=
,
> > +                     uint64_t static_off)
> > +{
> > +    VblkReq req;
> > +    VblkSector sector;
> > +    uint64_t off =3D 0;
> > +    char *buf =3D NULL;
> > +    uint8_t ret =3D VBLK_RET_FAILED;
> > +    int r;
> > +
> > +    cpu_physical_memory_read(value, &req, sizeof(req));
> > +    le2cpu_req(&req);
> > +
> > +    if (req.sector.len !=3D sizeof(sector)) {
> > +        ret =3D VBLK_RET_FAILED;
> > +        goto out;
> > +    }
> > +
> > +    /* Read the vblk command */
> > +    cpu_physical_memory_read(req.sector.addr, &sector, sizeof(sector))=
;
> > +    le2cpu_sector(&sector);
> > +
> > +    off =3D sector.sector * 512ULL + static_off;
> > +
> > +    /* Sanity check that we're not allocating bogus sizes */
> > +    if (req.data.len > (128 * 1024 * 1024)) {
>
> Use MiB defined in: include/qemu/units.h
> The parentheses on the right hand are also unnecessary.
>
> > +        goto out;
> > +    }
> > +
> > +    buf =3D g_malloc0(req.data.len);
> > +    switch (req.data.flags) {
> > +    case VBLK_DATA_FLAGS_READ:
> > +        r =3D blk_pread(blk, off, req.data.len, buf, 0);
> > +        trace_bdif_vblk_read(devid =3D=3D DEVID_AUX ? "aux" : "root",
> > +                             req.data.addr, off, req.data.len, r);
> > +        if (r < 0) {
> > +            goto out;
> > +        }
> > +        cpu_physical_memory_write(req.data.addr, buf, req.data.len);
> > +        ret =3D VBLK_RET_SUCCESS;
> > +        break;
> > +    case VBLK_DATA_FLAGS_WRITE:
> > +        /* Not needed, iBoot only reads */
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +
> > +out:
> > +    g_free(buf);
> > +    cpu_physical_memory_write(req.retval.addr, &ret, 1);
> > +}
> > +
> > +static void bdif_write(void *opaque, hwaddr offset,
> > +                       uint64_t value, unsigned size)
> > +{
> > +    VMAppleBdifState *s =3D opaque;
> > +    uint64_t devid =3D (offset & REG_DEVID_MASK);
> > +
> > +    trace_bdif_write(offset, size, value);
> > +
> > +    switch (offset & ~REG_DEVID_MASK) {
> > +    case REG_CMD:
> > +        switch (devid) {
> > +        case DEVID_ROOT:
> > +            vblk_cmd(devid, s->root, value, 0x0);
> > +            break;
> > +        case DEVID_AUX:
> > +            vblk_cmd(devid, s->aux, value, 0x0);
> > +            break;
> > +        }
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps bdif_ops =3D {
> > +    .read =3D bdif_read,
> > +    .write =3D bdif_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 8,
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 8,
> > +    },
> > +};
> > +
> > +static void bdif_init(Object *obj)
> > +{
> > +    VMAppleBdifState *s =3D VMAPPLE_BDIF(obj);
> > +
> > +    memory_region_init_io(&s->mmio, obj, &bdif_ops, obj,
> > +                         "VMApple Backdoor Interface",
> VMAPPLE_BDIF_SIZE);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > +}
> > +
> > +static Property bdif_properties[] =3D {
> > +    DEFINE_PROP_DRIVE("aux", VMAppleBdifState, aux),
> > +    DEFINE_PROP_DRIVE("root", VMAppleBdifState, root),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void bdif_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->desc =3D "VMApple Backdoor Interface";
> > +    device_class_set_props(dc, bdif_properties);
> > +}
> > +
> > +static const TypeInfo bdif_info =3D {
> > +    .name          =3D TYPE_VMAPPLE_BDIF,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(VMAppleBdifState),
> > +    .instance_init =3D bdif_init,
> > +    .class_init    =3D bdif_class_init,
> > +};
> > +
> > +static void bdif_register_types(void)
> > +{
> > +    type_register_static(&bdif_info);
> > +}
> > +
> > +type_init(bdif_register_types)
> > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> > index bcd4dcb28d2..d4624713deb 100644
> > --- a/hw/vmapple/meson.build
> > +++ b/hw/vmapple/meson.build
> > @@ -1 +1,2 @@
> >   system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
> > +system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
> > diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
> > index 1c9a3326eb4..fc8e9cc5897 100644
> > --- a/hw/vmapple/trace-events
> > +++ b/hw/vmapple/trace-events
> > @@ -19,3 +19,8 @@ aes_2_write_unknown(uint64_t offset) "offset=3D0x%"PR=
Ix64
> >   aes_2_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64"
> val=3D0x%"PRIx64
> >   aes_dump_data(const char *desc, const char *hex) "%s%s"
> >
> > +# bdif.c
> > +bdif_read(uint64_t offset, uint32_t size, uint64_t value)
> "offset=3D0x%"PRIx64" size=3D0x%x value=3D0x%"PRIx64
> > +bdif_write(uint64_t offset, uint32_t size, uint64_t value)
> "offset=3D0x%"PRIx64" size=3D0x%x value=3D0x%"PRIx64
> > +bdif_vblk_read(const char *dev, uint64_t addr, uint64_t offset,
> uint32_t len, int r) "dev=3D%s addr=3D0x%"PRIx64" off=3D0x%"PRIx64" size=
=3D0x%x
> r=3D%d"
> > +
> > diff --git a/include/hw/vmapple/bdif.h b/include/hw/vmapple/bdif.h
> > new file mode 100644
> > index 00000000000..65ee43457b9
> > --- /dev/null
> > +++ b/include/hw/vmapple/bdif.h
> > @@ -0,0 +1,31 @@
> > +/*
> > + * VMApple Backdoor Interface
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s
> Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef HW_VMAPPLE_BDIF_H
> > +#define HW_VMAPPLE_BDIF_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "qom/object.h"
> > +
> > +#define TYPE_VMAPPLE_BDIF "vmapple-bdif"
> > +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleBdifState, VMAPPLE_BDIF)
> > +
> > +struct VMAppleBdifState {
> > +    /* <private> */
> > +    SysBusDevice parent_obj;
> > +
> > +    /* <public> */
> > +    BlockBackend *aux;
> > +    BlockBackend *root;
> > +    MemoryRegion mmio;
> > +};
> > +
> > +#define VMAPPLE_BDIF_SIZE 0x00200000
>
> Please move VMAppleBdifState and VMAPPLE_BDIF_SIZE into: hw/vmapple/bdif.=
c
> They are both private.
>

Hmm, the same thing applies to the cfg device and the virtio-blk extension;
the only thing that's actually interesting to have in a header file are the
device type string definitions, so I think I'll put all of them in a single
/include/hw/vmapple/vmapple.h file.


> > +
> > +#endif /* HW_VMAPPLE_BDIF_H */
>
>

--000000000000b2f5b906240bafe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, 5 Oct 2024 at 07:12, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 2024/09/28 17:57, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; The VMApple machine exposes AUX and ROOT block devices (as well as USB=
 OTG<br>
&gt; emulation) via virtio-pci as well as a special, simple backdoor platfo=
rm<br>
&gt; device.<br>
&gt; <br>
&gt; This patch implements this backdoor platform device to the best of my<=
br>
&gt; understanding. I left out any USB OTG parts; they&#39;re only needed f=
or<br>
&gt; guest recovery and I don&#39;t understand the protocol yet.<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/bdif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 245 +=
+++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/trace-events=C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0include/hw/vmapple/bdif.h |=C2=A0 31 +++++<br>
&gt;=C2=A0 =C2=A05 files changed, 285 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/bdif.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/vmapple/bdif.h<br>
&gt; <br>
&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
&gt; index a73504d5999..68f88876eb9 100644<br>
&gt; --- a/hw/vmapple/Kconfig<br>
&gt; +++ b/hw/vmapple/Kconfig<br>
&gt; @@ -1,3 +1,6 @@<br>
&gt;=C2=A0 =C2=A0config VMAPPLE_AES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config VMAPPLE_BDIF<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +<br>
&gt; diff --git a/hw/vmapple/bdif.c b/hw/vmapple/bdif.c<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..36b5915ff30<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/vmapple/bdif.c<br>
&gt; @@ -0,0 +1,245 @@<br>
&gt; +/*<br>
&gt; + * VMApple Backdoor Interface<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/vmapple/bdif.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#include &quot;hw/block/block.h&quot;<br>
&gt; +#include &quot;sysemu/block-backend.h&quot;<br>
&gt; +<br>
&gt; +#define REG_DEVID_MASK=C2=A0 =C2=A0 =C2=A0 0xffff0000<br>
&gt; +#define DEVID_ROOT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000<br>
&gt; +#define DEVID_AUX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00010000<=
br>
&gt; +#define DEVID_USB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00100000<=
br>
&gt; +<br>
&gt; +#define REG_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0<br>
&gt; +#define REG_STATUS_ACTIVE=C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +#define REG_CFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4<br=
>
&gt; +#define REG_CFG_ACTIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(1)<br>
&gt; +#define REG_UNK1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8<br>
&gt; +#define REG_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10<br>
&gt; +#define REG_BUSY_READY=C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(0)<br>
&gt; +#define REG_UNK2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x400<br>
&gt; +#define REG_CMD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x408<=
br>
&gt; +#define REG_NEXT_DEVICE=C2=A0 =C2=A0 =C2=A00x420<br>
&gt; +#define REG_UNK3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x434<br>
&gt; +<br>
&gt; +typedef struct vblk_sector {<br>
<br>
Please use VblkSector for the tag name too.<br>
<br>
&gt; +=C2=A0 =C2=A0 uint32_t pad;<br>
&gt; +=C2=A0 =C2=A0 uint32_t pad2;<br>
&gt; +=C2=A0 =C2=A0 uint32_t sector;<br>
&gt; +=C2=A0 =C2=A0 uint32_t pad3;<br>
&gt; +} VblkSector;<br>
&gt; +<br>
&gt; +typedef struct vblk_req_cmd {<br>
&gt; +=C2=A0 =C2=A0 uint64_t addr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t len;<br>
&gt; +=C2=A0 =C2=A0 uint32_t flags;<br>
&gt; +} VblkReqCmd;<br>
&gt; +<br>
&gt; +typedef struct vblk_req {<br>
&gt; +=C2=A0 =C2=A0 VblkReqCmd sector;<br>
&gt; +=C2=A0 =C2=A0 VblkReqCmd data;<br>
&gt; +=C2=A0 =C2=A0 VblkReqCmd retval;<br>
&gt; +} VblkReq;<br>
&gt; +<br>
&gt; +#define VBLK_DATA_FLAGS_READ=C2=A0 0x00030001<br>
&gt; +#define VBLK_DATA_FLAGS_WRITE 0x00010001<br>
&gt; +<br>
&gt; +#define VBLK_RET_SUCCESS=C2=A0 0<br>
&gt; +#define VBLK_RET_FAILED=C2=A0 =C2=A01<br>
&gt; +<br>
&gt; +static uint64_t bdif_read(void *opaque, hwaddr offset, unsigned size)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t ret =3D -1;<br>
&gt; +=C2=A0 =C2=A0 uint64_t devid =3D (offset &amp; REG_DEVID_MASK);<br>
<br>
The parenthes in this line are unnecessary.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset &amp; ~REG_DEVID_MASK) {<br>
&gt; +=C2=A0 =C2=A0 case REG_STATUS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D REG_STATUS_ACTIVE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_CFG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D REG_CFG_ACTIVE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_UNK1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x420;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_BUSY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D REG_BUSY_READY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_UNK2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_UNK3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_NEXT_DEVICE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (devid) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DEVID_ROOT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x8000000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DEVID_AUX:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x10000;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_bdif_read(offset, size, ret);<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void le2cpu_sector(VblkSector *sector)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 sector-&gt;sector =3D le32_to_cpu(sector-&gt;sector);<b=
r>
&gt; +}<br>
&gt; +<br>
&gt; +static void le2cpu_reqcmd(VblkReqCmd *cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cmd-&gt;addr =3D le64_to_cpu(cmd-&gt;addr);<br>
&gt; +=C2=A0 =C2=A0 cmd-&gt;len =3D le32_to_cpu(cmd-&gt;len);<br>
&gt; +=C2=A0 =C2=A0 cmd-&gt;flags =3D le32_to_cpu(cmd-&gt;flags);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void le2cpu_req(VblkReq *req)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 le2cpu_reqcmd(&amp;req-&gt;sector);<br>
&gt; +=C2=A0 =C2=A0 le2cpu_reqcmd(&amp;req-&gt;data);<br>
&gt; +=C2=A0 =C2=A0 le2cpu_reqcmd(&amp;req-&gt;retval);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vblk_cmd(uint64_t devid, BlockBackend *blk, uint64_t valu=
e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0uint64_t static_off)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VblkReq req;<br>
&gt; +=C2=A0 =C2=A0 VblkSector sector;<br>
&gt; +=C2=A0 =C2=A0 uint64_t off =3D 0;<br>
&gt; +=C2=A0 =C2=A0 char *buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 uint8_t ret =3D VBLK_RET_FAILED;<br>
&gt; +=C2=A0 =C2=A0 int r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_physical_memory_read(value, &amp;req, sizeof(req));=
<br>
&gt; +=C2=A0 =C2=A0 le2cpu_req(&amp;req);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (req.sector.len !=3D sizeof(sector)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D VBLK_RET_FAILED;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Read the vblk command */<br>
&gt; +=C2=A0 =C2=A0 cpu_physical_memory_read(req.sector.addr, &amp;sector, =
sizeof(sector));<br>
&gt; +=C2=A0 =C2=A0 le2cpu_sector(&amp;sector);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 off =3D sector.sector * 512ULL + static_off;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Sanity check that we&#39;re not allocating bogus siz=
es */<br>
&gt; +=C2=A0 =C2=A0 if (req.data.len &gt; (128 * 1024 * 1024)) {<br>
<br>
Use MiB defined in: include/qemu/units.h<br>
The parentheses on the right hand are also unnecessary.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 buf =3D g_malloc0(req.data.len);<br>
&gt; +=C2=A0 =C2=A0 switch (req.data.flags) {<br>
&gt; +=C2=A0 =C2=A0 case VBLK_DATA_FLAGS_READ:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D blk_pread(blk, off, req.data.len, b=
uf, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_bdif_vblk_read(devid =3D=3D DEVID_A=
UX ? &quot;aux&quot; : &quot;root&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0req.data.addr, off, req.data.len, r);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write(req.data.addr, =
buf, req.data.len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D VBLK_RET_SUCCESS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VBLK_DATA_FLAGS_WRITE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not needed, iBoot only reads */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 g_free(buf);<br>
&gt; +=C2=A0 =C2=A0 cpu_physical_memory_write(req.retval.addr, &amp;ret, 1)=
;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void bdif_write(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uint64_t value, unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleBdifState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint64_t devid =3D (offset &amp; REG_DEVID_MASK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_bdif_write(offset, size, value);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset &amp; ~REG_DEVID_MASK) {<br>
&gt; +=C2=A0 =C2=A0 case REG_CMD:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (devid) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DEVID_ROOT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vblk_cmd(devid, s-&gt;root,=
 value, 0x0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case DEVID_AUX:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vblk_cmd(devid, s-&gt;aux, =
value, 0x0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps bdif_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D bdif_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D bdif_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void bdif_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleBdifState *s =3D VMAPPLE_BDIF(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;mmio, obj, &amp;bdif_o=
ps, obj,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;VMApple Backdoor Interface&quot;, VMAPPLE_BDIF_S=
IZE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &amp;s-&gt;mmio);=
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static Property bdif_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_DRIVE(&quot;aux&quot;, VMAppleBdifState, au=
x),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_DRIVE(&quot;root&quot;, VMAppleBdifState, r=
oot),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void bdif_class_init(ObjectClass *klass, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;VMApple Backdoor Interface&quot;;=
<br>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, bdif_properties);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo bdif_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_VMAPPL=
E_BDIF,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAppleBdifState),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D bdif_init,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D bdif_class_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void bdif_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;bdif_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(bdif_register_types)<br>
&gt; diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build<br>
&gt; index bcd4dcb28d2..d4624713deb 100644<br>
&gt; --- a/hw/vmapple/meson.build<br>
&gt; +++ b/hw/vmapple/meson.build<br>
&gt; @@ -1 +1,2 @@<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_VMAPPLE_AES&#39;,=C2=A0 if=
_true: files(&#39;aes.c&#39;))<br>
&gt; +system_ss.add(when: &#39;CONFIG_VMAPPLE_BDIF&#39;, if_true: files(&#3=
9;bdif.c&#39;))<br>
&gt; diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events<br>
&gt; index 1c9a3326eb4..fc8e9cc5897 100644<br>
&gt; --- a/hw/vmapple/trace-events<br>
&gt; +++ b/hw/vmapple/trace-events<br>
&gt; @@ -19,3 +19,8 @@ aes_2_write_unknown(uint64_t offset) &quot;offset=3D=
0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0aes_2_write(uint64_t offset, uint64_t val) &quot;offset=3D=
0x%&quot;PRIx64&quot; val=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0aes_dump_data(const char *desc, const char *hex) &quot;%s%=
s&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +# bdif.c<br>
&gt; +bdif_read(uint64_t offset, uint32_t size, uint64_t value) &quot;offse=
t=3D0x%&quot;PRIx64&quot; size=3D0x%x value=3D0x%&quot;PRIx64<br>
&gt; +bdif_write(uint64_t offset, uint32_t size, uint64_t value) &quot;offs=
et=3D0x%&quot;PRIx64&quot; size=3D0x%x value=3D0x%&quot;PRIx64<br>
&gt; +bdif_vblk_read(const char *dev, uint64_t addr, uint64_t offset, uint3=
2_t len, int r) &quot;dev=3D%s addr=3D0x%&quot;PRIx64&quot; off=3D0x%&quot;=
PRIx64&quot; size=3D0x%x r=3D%d&quot;<br>
&gt; +<br>
&gt; diff --git a/include/hw/vmapple/bdif.h b/include/hw/vmapple/bdif.h<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..65ee43457b9<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/vmapple/bdif.h<br>
&gt; @@ -0,0 +1,31 @@<br>
&gt; +/*<br>
&gt; + * VMApple Backdoor Interface<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_VMAPPLE_BDIF_H<br>
&gt; +#define HW_VMAPPLE_BDIF_H<br>
&gt; +<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_VMAPPLE_BDIF &quot;vmapple-bdif&quot;<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleBdifState, VMAPPLE_BDIF)<br>
&gt; +<br>
&gt; +struct VMAppleBdifState {<br>
&gt; +=C2=A0 =C2=A0 /* &lt;private&gt; */<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* &lt;public&gt; */<br>
&gt; +=C2=A0 =C2=A0 BlockBackend *aux;<br>
&gt; +=C2=A0 =C2=A0 BlockBackend *root;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion mmio;<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define VMAPPLE_BDIF_SIZE 0x00200000<br>
<br>
Please move VMAppleBdifState and VMAPPLE_BDIF_SIZE into: hw/vmapple/bdif.c<=
br>
They are both private.<br></blockquote><div><br></div><div>Hmm, the same th=
ing applies to the cfg device and the virtio-blk extension; the only thing =
that&#39;s actually interesting to have in a header file are the device typ=
e string definitions, so I think I&#39;ll put all of them in a single /incl=
ude/hw/vmapple/vmapple.h file.<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +#endif /* HW_VMAPPLE_BDIF_H */<br>
<br>
</blockquote></div></div>

--000000000000b2f5b906240bafe9--

