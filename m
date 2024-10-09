Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC8CEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syWB2-0007Bb-AP; Wed, 09 Oct 2024 08:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syWAy-0007Ad-Cn
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:52:24 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syWAt-0007KD-Gt
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:52:24 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4a3be8c420cso1901779137.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728478337; x=1729083137;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W+P8KuOhyxh7XxYDJC4uC0250gm+Nb59cGNqYZnKj7E=;
 b=MnVbe7HSLLBB9KguPEJ3G36fkpUmutwbWaofUeQAelPQN3NpiCawH0pzeS5zZldfzd
 pdt1x/6odL3KHHYujgVRAupsGlyq7C7pBYp/8BLO+8UsisZ/h/WerBjr0Qm+h/t8e8a7
 2K21v/9Cw7O1ymldBIgMHeawke5CI2W6+o9OLtfflp1gFHNYo2apHBUTQpi4ygVW87Xq
 usEketBi2zGfC1hCsVS5Zk6s+ZDzGM9xZFGqkb4xEkZjrNo0CPLQZP1QM32dQAlqbfxK
 V543z8Duvoq6SKeutuExw6EmIn/pZrhLWjvOVcvuCWHbcEmSn1qzC9Xf4SKVAGECBim1
 gRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728478337; x=1729083137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+P8KuOhyxh7XxYDJC4uC0250gm+Nb59cGNqYZnKj7E=;
 b=bnyDGRQKnCtVDwd0cpplAPNFPH7k1DqOuH9rFrZb9oDSwhhLs1QXusBCvG03TYGYAV
 LyV1PA0dpHPLX76DhqD7NgjMeMUuts1xcAV2MLfc33RVt+CFONJ3a3Wor57LiRfN8NMx
 ZeQDeTtL1MnN1yQuNSXEG0gebZUNpUyaX3p0AGm+NAWngy3nOPYGAI3xTQeoLO8f6p9A
 IfKh1VelZwO4G/MGfjUSUYNM9m+96z0fe/ovnlGTa2OAlo4Aonig0KghOsbXv0AWEGNo
 x9XF9hq+2gqN567aa6qL6gqtOaVuAWTxuTlBz6x1xbdA4cko3pb0tEdybrfJxzvudg3P
 Rtxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBwF4Gk+Chf3IR+O+JLmjUti1StON86jxrtuNNVBWD/MgngFbtajNu6ZbyQbzwSe2XYw9HyqPBr1wV@nongnu.org
X-Gm-Message-State: AOJu0YyDG63Baz21kDJhd72bhTkd+b2IXPN7rEHAEwOpibChNIdd5p/T
 M6lsn5SUXPUeC/WMq+QpnpwGi+/QZK30ALoNGWex1S1HpXvzkMdjlHJtTuyyQhJ4Fnn/EHnoDCd
 5JWY6SCsXs2Y6QTsFHRxjQhzfSxTRLJqIV1Pj
X-Google-Smtp-Source: AGHT+IHU07p9Pib0rramHJPuQ4YFBAWBz2KqFBC7fcoPwaEYU87kQnT0FxwSjr5JT9q5Qpa0xtevRcJjtd5WXQMC0x4=
X-Received: by 2002:a05:6102:f0a:b0:498:9a94:d797 with SMTP id
 ada2fe7eead31-4a448e24223mr1588180137.20.1728478337283; Wed, 09 Oct 2024
 05:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-14-phil@philjordan.eu>
 <053c9224-6940-472a-8c62-276961b75935@daynix.com>
 <CAAibmn3q9ZxEHBiT8gLDWbSnFmZ4Z+gy3XphC0yAWj99ie+j9g@mail.gmail.com>
 <56369946-06ac-4b0f-b9aa-8e05be835858@daynix.com>
In-Reply-To: <56369946-06ac-4b0f-b9aa-8e05be835858@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 9 Oct 2024 14:52:06 +0200
Message-ID: <CAAibmn3_HcVw9qxRX_YG0AP2dtqCzFBC-UzpChsyJY7j4dBrfg@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="0000000000004bd4be06240ab9d3"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e31;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe31.google.com
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

--0000000000004bd4be06240ab9d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2024 at 20:10, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/10/07 23:31, Phil Dennis-Jordan wrote:
> >
> > On Sat, 5 Oct 2024 at 07:47, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> >      > From: Alexander Graf <graf@amazon.com <mailto:graf@amazon.com>>
> >      >
> >      > Apple has its own virtio-blk PCI device ID where it deviates fro=
m
> the
> >      > official virtio-pci spec slightly: It puts a new "apple type"
> >      > field at a static offset in config space and introduces a new
> barrier
> >      > command.
> >      >
> >      > This patch first creates a mechanism for virtio-blk downstream
> >     classes to
> >      > handle unknown commands. It then creates such a downstream class
> >     and a new
> >      > vmapple-virtio-blk-pci class which support the additional apple
> >     type config
> >      > identifier as well as the barrier command.
> >      >
> >      > It then exposes 2 subclasses from that that we can use to expose
> >     root and
> >      > aux virtio-blk devices: "vmapple-virtio-root" and "vmapple-
> >     virtio-aux".
> >      >
> >      > Signed-off-by: Alexander Graf <graf@amazon.com
> >     <mailto:graf@amazon.com>>
> >      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
> >     <mailto:phil@philjordan.eu>>
> >      > ---
> >      >   hw/block/virtio-blk.c           |  19 ++-
> >      >   hw/vmapple/Kconfig              |   3 +
> >      >   hw/vmapple/meson.build          |   1 +
> >      >   hw/vmapple/virtio-blk.c         | 212 ++++++++++++++++++++++++=
+
> >     +++++++
> >      >   include/hw/pci/pci_ids.h        |   1 +
> >      >   include/hw/virtio/virtio-blk.h  |  12 +-
> >      >   include/hw/vmapple/virtio-blk.h |  39 ++++++
> >      >   7 files changed, 282 insertions(+), 5 deletions(-)
> >      >   create mode 100644 hw/vmapple/virtio-blk.c
> >      >   create mode 100644 include/hw/vmapple/virtio-blk.h
> >      >
> >      > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> >      > index 115795392c4..cecc4cef9e4 100644
> >      > --- a/hw/block/virtio-blk.c
> >      > +++ b/hw/block/virtio-blk.c
> >      > @@ -50,12 +50,12 @@ static void
> >     virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
> >      >       req->mr_next =3D NULL;
> >      >   }
> >      >
> >      > -static void virtio_blk_free_request(VirtIOBlockReq *req)
> >      > +void virtio_blk_free_request(VirtIOBlockReq *req)
> >      >   {
> >      >       g_free(req);
> >      >   }
> >
> >     This function is identical with g_free(). Perhaps it's better to
> remove
> >     it instead of updating it.
> >
> >
> > I'm not sure that's something I should be doing in such a tangential
> > patch series, and it's very much a matter of taste - other operations o=
n
> > VirtIOBlockReq have similar, consistent naming, and this function
> > seemingly hasn't been touched for 7 years.
>
> It is not really consistent when it comes to memory allocation. It
> simply uses virtqueue_pop() or qemu_get_virtqueue_element() without
> function wrappers to get VirtIOBlockReq allocated. It shouldn't be
> necessary for deallocation either.
>
> git blame reveals virtio_blk_free_request() used to be more complex.
> It's more likely that just nobody had a need to remove this function.
>

I've included this code transformation as an optional second commit in v4,
it can then either be pulled or dropped from the pull depending on popular
opinion.


> >
> > Perhaps virtio-blk maintainer Stefan Hajnoczi could weigh in? (tagged i=
n
> > To:)
> >
> >
> >      > -static void virtio_blk_req_complete(VirtIOBlockReq *req,
> >     unsigned char status)
> >      > +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char
> >     status)
> >      >   {
> >      >       VirtIOBlock *s =3D req->dev;
> >      >       VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> >      > @@ -966,8 +966,18 @@ static int
> >     virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
> >      >           break;
> >      >       }
> >      >       default:
> >      > -        virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> >      > -        virtio_blk_free_request(req);
> >      > +    {
> >      > +        /*
> >      > +         * Give subclasses a chance to handle unknown requests.
> >     This way the
> >      > +         * class lookup is not in the hot path.
> >      > +         */
> >      > +        VirtIOBlkClass *vbk =3D VIRTIO_BLK_GET_CLASS(s);
> >      > +        if (!vbk->handle_unknown_request ||
> >      > +            !vbk->handle_unknown_request(req, mrb, type)) {
> >      > +            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> >      > +            virtio_blk_free_request(req);
> >      > +        }
> >      > +    }
> >      >       }
> >      >       return 0;
> >      >   }
> >      > @@ -2044,6 +2054,7 @@ static const TypeInfo virtio_blk_info =3D =
{
> >      >       .instance_size =3D sizeof(VirtIOBlock),
> >      >       .instance_init =3D virtio_blk_instance_init,
> >      >       .class_init =3D virtio_blk_class_init,
> >      > +    .class_size =3D sizeof(VirtIOBlkClass),
> >      >   };
> >      >
> >      >   static void virtio_register_types(void)
> >      > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> >      > index 8bbeb9a9237..bcd1be63e3c 100644
> >      > --- a/hw/vmapple/Kconfig
> >      > +++ b/hw/vmapple/Kconfig
> >      > @@ -7,3 +7,6 @@ config VMAPPLE_BDIF
> >      >   config VMAPPLE_CFG
> >      >       bool
> >      >
> >      > +config VMAPPLE_VIRTIO_BLK
> >      > +    bool
> >      > +
> >      > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> >      > index 64b78693a31..bf17cf906c9 100644
> >      > --- a/hw/vmapple/meson.build
> >      > +++ b/hw/vmapple/meson.build
> >      > @@ -1,3 +1,4 @@
> >      >   system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true:
> files('aes.c'))
> >      >   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true:
> >     files('bdif.c'))
> >      >   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true:
> files('cfg.c'))
> >      > +system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true:
> >     files('virtio-blk.c'))
> >      > diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
> >      > new file mode 100644
> >      > index 00000000000..720eaa61a86
> >      > --- /dev/null
> >      > +++ b/hw/vmapple/virtio-blk.c
> >      > @@ -0,0 +1,212 @@
> >      > +/*
> >      > + * VMApple specific VirtIO Block implementation
> >      > + *
> >      > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. Al=
l
> >     Rights Reserved.
> >      > + *
> >      > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >     2 or later.
> >      > + * See the COPYING file in the top-level directory.
> >      > + *
> >      > + * VMApple uses almost standard VirtIO Block, but with a few ke=
y
> >     differences:
> >      > + *
> >      > + *  - Different PCI device/vendor ID
> >      > + *  - An additional "type" identifier to differentiate AUX and
> >     Root volumes
> >      > + *  - An additional BARRIER command
> >      > + */
> >      > +
> >      > +#include "qemu/osdep.h"
> >      > +#include "hw/vmapple/virtio-blk.h"
> >      > +#include "qemu/log.h"
> >      > +#include "qemu/module.h"
> >      > +#include "qapi/error.h"
> >      > +
> >      > +#define VIRTIO_BLK_T_APPLE_BARRIER     0x10000
> >      > +
> >      > +#define VIRTIO_APPLE_TYPE_ROOT 1
> >      > +#define VIRTIO_APPLE_TYPE_AUX  2
> >      > +
> >      > +static bool
> >     vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq *req,
> >      > +
> >     MultiReqBuffer *mrb,
> >      > +                                                      uint32_t
> type)
> >      > +{
> >      > +    switch (type) {
> >      > +    case VIRTIO_BLK_T_APPLE_BARRIER:
> >      > +        /* We ignore barriers for now. YOLO. */
> >
> >     It should be LOG_UNIMP instead of a mere comment.
> >
> >
> > Fixed in next patch version.
> >
> >      > +        virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> >      > +        virtio_blk_free_request(req);
> >      > +        return true;
> >      > +    default:
> >      > +        return false;
> >      > +    }
> >      > +}
> >      > +
> >      > +/*
> >      > + * VMApple virtio-blk uses the same config format as normal
> >     virtio, with one
> >      > + * exception: It adds an "apple type" specififer at the same
> >     location that
> >      > + * the spec reserves for max_secure_erase_sectors. Let's hook
> >     into the
> >      > + * get_config code path here, run it as usual and then patch in
> >     the apple type.
> >      > + */
> >      > +static void vmapple_virtio_blk_get_config(VirtIODevice *vdev,
> >     uint8_t *config)
> >      > +{
> >      > +    VMAppleVirtIOBlk *dev =3D VMAPPLE_VIRTIO_BLK(vdev);
> >      > +    VMAppleVirtIOBlkClass *vvbk =3D
> VMAPPLE_VIRTIO_BLK_GET_CLASS(dev);
> >      > +    struct virtio_blk_config *blkcfg =3D (struct virtio_blk_con=
fig
> >     *)config;
> >      > +
> >      > +    vvbk->get_config(vdev, config);
> >      > +
> >      > +    g_assert(dev->parent_obj.config_size >=3D endof(struct
> >     virtio_blk_config, zoned));
> >      > +
> >      > +    /* Apple abuses the field for max_secure_erase_sectors as
> >     type id */
> >      > +    blkcfg->max_secure_erase_sectors =3D dev->apple_type;
> >      > +}
> >      > +
> >      > +static Property vmapple_virtio_blk_properties[] =3D {
> >      > +    DEFINE_PROP_UINT32("apple-type", VMAppleVirtIOBlk,
> >     apple_type, 0),
> >      > +    DEFINE_PROP_END_OF_LIST(),
> >      > +};
> >      > +
> >      > +static void vmapple_virtio_blk_class_init(ObjectClass *klass,
> >     void *data)
> >      > +{
> >      > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >      > +    VirtIOBlkClass *vbk =3D VIRTIO_BLK_CLASS(klass);
> >      > +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> >      > +    VMAppleVirtIOBlkClass *vvbk =3D
> VMAPPLE_VIRTIO_BLK_CLASS(klass);
> >      > +
> >      > +    vbk->handle_unknown_request =3D
> >     vmapple_virtio_blk_handle_unknown_request;
> >      > +    vvbk->get_config =3D vdc->get_config;
> >      > +    vdc->get_config =3D vmapple_virtio_blk_get_config;
> >      > +    device_class_set_props(dc, vmapple_virtio_blk_properties);
> >      > +}
> >      > +
> >      > +static const TypeInfo vmapple_virtio_blk_info =3D {
> >      > +    .name          =3D TYPE_VMAPPLE_VIRTIO_BLK,
> >      > +    .parent        =3D TYPE_VIRTIO_BLK,
> >      > +    .instance_size =3D sizeof(VMAppleVirtIOBlk),
> >      > +    .class_init    =3D vmapple_virtio_blk_class_init,
> >      > +};
> >      > +
> >      > +/* PCI Devices */
> >      > +
> >      > +typedef struct VMAppleVirtIOBlkPCI {
> >      > +    VirtIOPCIProxy parent_obj;
> >      > +    VMAppleVirtIOBlk vdev;
> >      > +    uint32_t apple_type;
> >      > +} VMAppleVirtIOBlkPCI;
> >      > +
> >      > +/*
> >      > + * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.
> >      > + */
> >      > +#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci-bas=
e"
> >      > +DECLARE_INSTANCE_CHECKER(VMAppleVirtIOBlkPCI,
> >     VMAPPLE_VIRTIO_BLK_PCI,
> >      > +                         TYPE_VMAPPLE_VIRTIO_BLK_PCI)
> >      > +
> >      > +static Property vmapple_virtio_blk_pci_properties[] =3D {
> >      > +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> >      > +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> >      > +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> >      > +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> >      > +                       DEV_NVECTORS_UNSPECIFIED),
> >      > +    DEFINE_PROP_END_OF_LIST(),
> >      > +};
> >      > +
> >      > +static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy
> >     *vpci_dev, Error **errp)
> >      > +{
> >      > +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(vpci_de=
v);
> >      > +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> >      > +    VirtIOBlkConf *conf =3D &dev->vdev.parent_obj.conf;
> >      > +
> >      > +    if (conf->num_queues =3D=3D VIRTIO_BLK_AUTO_NUM_QUEUES) {
> >      > +        conf->num_queues =3D virtio_pci_optimal_num_queues(0);
> >      > +    }
> >      > +
> >      > +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> >      > +        vpci_dev->nvectors =3D conf->num_queues + 1;
> >      > +    }
> >      > +
> >      > +    /*
> >      > +     * We don't support zones, but we need the additional confi=
g
> >     space size.
> >      > +     * Let's just expose the feature so the rest of the virtio-
> >     blk logic
> >      > +     * allocates enough space for us. The guest will ignore
> >     zones anyway.
> >      > +     */
> >      > +    virtio_add_feature(&dev->vdev.parent_obj.host_features,
> >     VIRTIO_BLK_F_ZONED);
> >      > +    /* Propagate the apple type down to the virtio-blk device *=
/
> >      > +    qdev_prop_set_uint32(DEVICE(&dev->vdev), "apple-type", dev-
> >      >apple_type);
> >      > +    /* and spawn the virtio-blk device */
> >      > +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >      > +
> >      > +    /*
> >      > +     * The virtio-pci machinery adjusts its vendor/device ID
> >     based on whether
> >      > +     * we support modern or legacy virtio. Let's patch it back
> >     to the Apple
> >      > +     * identifiers here.
> >      > +     */
> >      > +    pci_config_set_vendor_id(vpci_dev->pci_dev.config,
> >     PCI_VENDOR_ID_APPLE);
> >      > +    pci_config_set_device_id(vpci_dev->pci_dev.config,
> >     PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
> >      > +}
> >      > +
> >      > +static void vmapple_virtio_blk_pci_class_init(ObjectClass
> >     *klass, void *data)
> >      > +{
> >      > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >      > +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> >      > +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> >      > +
> >      > +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> >      > +    device_class_set_props(dc,
> vmapple_virtio_blk_pci_properties);
> >      > +    k->realize =3D vmapple_virtio_blk_pci_realize;
> >      > +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_APPLE;
> >      > +    pcidev_k->device_id =3D PCI_DEVICE_ID_APPLE_VIRTIO_BLK;
> >      > +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> >      > +    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
> >      > +}
> >      > +
> >      > +static void vmapple_virtio_blk_pci_instance_init(Object *obj)
> >      > +{
> >      > +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> >      > +
> >      > +    virtio_instance_init_common(obj, &dev->vdev,
> sizeof(dev->vdev),
> >      > +                                TYPE_VMAPPLE_VIRTIO_BLK);
> >      > +}
> >      > +
> >      > +static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_inf=
o
> =3D {
> >      > +    .base_name     =3D TYPE_VMAPPLE_VIRTIO_BLK_PCI,
> >      > +    .generic_name  =3D "vmapple-virtio-blk-pci",
> >      > +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> >      > +    .instance_init =3D vmapple_virtio_blk_pci_instance_init,
> >      > +    .class_init    =3D vmapple_virtio_blk_pci_class_init,
> >      > +};
> >      > +
> >      > +static void vmapple_virtio_root_instance_init(Object *obj)
> >      > +{
> >      > +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> >      > +
> >      > +    dev->apple_type =3D VIRTIO_APPLE_TYPE_ROOT;
> >      > +}
> >      > +
> >      > +static const TypeInfo vmapple_virtio_root_info =3D {
> >      > +    .name          =3D TYPE_VMAPPLE_VIRTIO_ROOT,
> >      > +    .parent        =3D "vmapple-virtio-blk-pci",
> >      > +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> >      > +    .instance_init =3D vmapple_virtio_root_instance_init,
> >      > +};
> >      > +
> >      > +static void vmapple_virtio_aux_instance_init(Object *obj)
> >      > +{
> >      > +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> >      > +
> >      > +    dev->apple_type =3D VIRTIO_APPLE_TYPE_AUX;
> >      > +}
> >      > +
> >      > +static const TypeInfo vmapple_virtio_aux_info =3D {
> >      > +    .name          =3D TYPE_VMAPPLE_VIRTIO_AUX,
> >      > +    .parent        =3D "vmapple-virtio-blk-pci",
> >      > +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> >      > +    .instance_init =3D vmapple_virtio_aux_instance_init,
> >      > +};
> >      > +
> >      > +static void vmapple_virtio_blk_register_types(void)
> >      > +{
> >      > +    type_register_static(&vmapple_virtio_blk_info);
> >      > +    virtio_pci_types_register(&vmapple_virtio_blk_pci_info);
> >      > +    type_register_static(&vmapple_virtio_root_info);
> >      > +    type_register_static(&vmapple_virtio_aux_info);
> >      > +}
> >      > +
> >      > +type_init(vmapple_virtio_blk_register_types)
> >      > diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> >      > index f1a53fea8d6..33e2898be95 100644
> >      > --- a/include/hw/pci/pci_ids.h
> >      > +++ b/include/hw/pci/pci_ids.h
> >      > @@ -191,6 +191,7 @@
> >      >   #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
> >      >   #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
> >      >   #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
> >      > +#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
> >      >
> >      >   #define PCI_VENDOR_ID_SUN                0x108e
> >      >   #define PCI_DEVICE_ID_SUN_EBUS           0x1000
> >      > diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/
> >     virtio-blk.h
> >      > index 5c14110c4b1..28d5046ea6c 100644
> >      > --- a/include/hw/virtio/virtio-blk.h
> >      > +++ b/include/hw/virtio/virtio-blk.h
> >      > @@ -24,7 +24,7 @@
> >      >   #include "qapi/qapi-types-virtio.h"
> >      >
> >      >   #define TYPE_VIRTIO_BLK "virtio-blk-device"
> >      > -OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)
> >      > +OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkClass, VIRTIO_BLK)
> >      >
> >      >   /* This is the last element of the write scatter-gather list *=
/
> >      >   struct virtio_blk_inhdr
> >      > @@ -100,6 +100,16 @@ typedef struct MultiReqBuffer {
> >      >       bool is_write;
> >      >   } MultiReqBuffer;
> >      >
> >      > +typedef struct VirtIOBlkClass {
> >      > +    /*< private >*/
> >      > +    VirtioDeviceClass parent;
> >      > +    /*< public >*/
> >      > +    bool (*handle_unknown_request)(VirtIOBlockReq *req,
> >     MultiReqBuffer *mrb,
> >      > +                                   uint32_t type);
> >      > +} VirtIOBlkClass;
> >      > +
> >      >   void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
> >      > +void virtio_blk_free_request(VirtIOBlockReq *req);
> >      > +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char
> >     status);
> >      >
> >      >   #endif
> >      > diff --git a/include/hw/vmapple/virtio-blk.h b/include/hw/
> >     vmapple/virtio-blk.h
> >      > new file mode 100644
> >      > index 00000000000..b23106a3dfb
> >      > --- /dev/null
> >      > +++ b/include/hw/vmapple/virtio-blk.h
> >      > @@ -0,0 +1,39 @@
> >      > +/*
> >      > + * VMApple specific VirtIO Block implementation
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
> >      > +#include "hw/virtio/virtio-pci.h"
> >      > +#include "hw/virtio/virtio-blk.h"
> >      > +
> >      > +#define TYPE_VMAPPLE_VIRTIO_BLK "vmapple-virtio-blk"
> >      > +#define TYPE_VMAPPLE_VIRTIO_ROOT "vmapple-virtio-root"
> >      > +#define TYPE_VMAPPLE_VIRTIO_AUX "vmapple-virtio-aux"
> >      > +
> >      > +OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass,
> >     VMAPPLE_VIRTIO_BLK)
> >      > +
> >      > +typedef struct VMAppleVirtIOBlkClass {
> >      > +    /*< private >*/
> >      > +    VirtIOBlkClass parent;
> >      > +    /*< public >*/
> >      > +    void (*get_config)(VirtIODevice *vdev, uint8_t *config);
> >      > +} VMAppleVirtIOBlkClass;
> >      > +
> >      > +typedef struct VMAppleVirtIOBlk {
> >      > +    /* <private> */
> >      > +    VirtIOBlock parent_obj;
> >      > +
> >      > +    /* <public> */
> >      > +    uint32_t apple_type;
> >      > +} VMAppleVirtIOBlk;
> >      > +
> >      > +#endif /* HW_VMAPPLE_CFG_H */
> >
>
>

--0000000000004bd4be06240ab9d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 7 Oct 2024 at 20:10, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 2024/10/07 23:31, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; On Sat, 5 Oct 2024 at 07:47, Akihiko Odaki &lt;<a href=3D"mailto:akihi=
ko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blan=
k">akihiko.odaki@daynix.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2024/09/28 17:57, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; From: Alexander Graf &lt;<a href=3D"mailto:gr=
af@amazon.com" target=3D"_blank">graf@amazon.com</a> &lt;mailto:<a href=3D"=
mailto:graf@amazon.com" target=3D"_blank">graf@amazon.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Apple has its own virtio-blk PCI device ID wh=
ere it deviates from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; official virtio-pci spec slightly: It puts a =
new &quot;apple type&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; field at a static offset in config space and =
introduces a new barrier<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; command.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This patch first creates a mechanism for virt=
io-blk downstream<br>
&gt;=C2=A0 =C2=A0 =C2=A0classes to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; handle unknown commands. It then creates such=
 a downstream class<br>
&gt;=C2=A0 =C2=A0 =C2=A0and a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; vmapple-virtio-blk-pci class which support th=
e additional apple<br>
&gt;=C2=A0 =C2=A0 =C2=A0type config<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; identifier as well as the barrier command.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; It then exposes 2 subclasses from that that w=
e can use to expose<br>
&gt;=C2=A0 =C2=A0 =C2=A0root and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; aux virtio-blk devices: &quot;vmapple-virtio-=
root&quot; and &quot;vmapple-<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio-aux&quot;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Alexander Graf &lt;<a href=3D"=
mailto:graf@amazon.com" target=3D"_blank">graf@amazon.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:graf@amazon.com" targe=
t=3D"_blank">graf@amazon.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=
=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/block/virtio-blk.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 19 ++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/vmapple/virtio-blk.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 212 +++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/hw/pci/pci_ids.h=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/hw/virtio/virtio-blk.h=C2=
=A0 |=C2=A0 12 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0include/hw/vmapple/virtio-blk.h |=
=C2=A0 39 ++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A07 files changed, 282 insertions(+=
), 5 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/vir=
tio-blk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 include/hw/vma=
pple/virtio-blk.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/block/virtio-blk.c b/hw/block=
/virtio-blk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 115795392c4..cecc4cef9e4 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/block/virtio-blk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/block/virtio-blk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -50,12 +50,12 @@ static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_blk_init_request(VirtIOBlock *s, VirtQueue *=
vq,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;mr_next =3D=
 NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -static void virtio_blk_free_request(VirtIOBl=
ockReq *req)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void virtio_blk_free_request(VirtIOBlockReq =
*req)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(req);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This function is identical with g_free(). Perhaps i=
t&#39;s better to remove<br>
&gt;=C2=A0 =C2=A0 =C2=A0it instead of updating it.<br>
&gt; <br>
&gt; <br>
&gt; I&#39;m not sure that&#39;s something I should be doing in such a tang=
ential <br>
&gt; patch series, and it&#39;s very much a matter of taste - other operati=
ons on <br>
&gt; VirtIOBlockReq have similar, consistent naming, and this function <br>
&gt; seemingly hasn&#39;t been touched for 7 years.<br>
<br>
It is not really consistent when it comes to memory allocation. It <br>
simply uses virtqueue_pop() or qemu_get_virtqueue_element() without <br>
function wrappers to get VirtIOBlockReq allocated. It shouldn&#39;t be <br>
necessary for deallocation either.<br>
<br>
git blame reveals virtio_blk_free_request() used to be more complex. <br>
It&#39;s more likely that just nobody had a need to remove this function.<b=
r></blockquote><div><br></div><div>I&#39;ve included this code transformati=
on as an optional second commit in v4, it can then either be pulled or drop=
ped from the pull depending on popular opinion.<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Perhaps virtio-blk maintainer Stefan Hajnoczi could weigh in? (tagged =
in <br>
&gt; To:)<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -static void virtio_blk_req_complete(VirtIOBl=
ockReq *req,<br>
&gt;=C2=A0 =C2=A0 =C2=A0unsigned char status)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void virtio_blk_req_complete(VirtIOBlockReq =
*req, unsigned char<br>
&gt;=C2=A0 =C2=A0 =C2=A0status)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtIOBlock *s =3D =
req-&gt;dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtIODevice *vdev =
=3D VIRTIO_DEVICE(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -966,8 +966,18 @@ static int<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_blk_handle_request(VirtIOBlockReq *req, Mult=
iReqBuffer *mrb)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_req_c=
omplete(req, VIRTIO_BLK_S_UNSUPP);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_free_=
request(req);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Give sub=
classes a chance to handle unknown requests.<br>
&gt;=C2=A0 =C2=A0 =C2=A0This way the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* class lo=
okup is not in the hot path.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtIOBlkClass *=
vbk =3D VIRTIO_BLK_GET_CLASS(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vbk-&gt;han=
dle_unknown_request ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !v=
bk-&gt;handle_unknown_request(req, mrb, type)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vi=
rtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vi=
rtio_blk_free_request(req);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -2044,6 +2054,7 @@ static const TypeInfo v=
irtio_blk_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_size =3D =
sizeof(VirtIOBlock),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_init =3D =
virtio_blk_instance_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init =3D vir=
tio_blk_class_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .class_size =3D sizeof(VirtIOB=
lkClass),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0static void virtio_register_types=
(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/=
Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 8bbeb9a9237..bcd1be63e3c 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -7,3 +7,6 @@ config VMAPPLE_BDIF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0config VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +config VMAPPLE_VIRTIO_BLK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/meson.build b/hw/vmap=
ple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 64b78693a31..bf17cf906c9 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/vmapple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -1,3 +1,4 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_V=
MAPPLE_AES&#39;,=C2=A0 if_true: files(&#39;aes.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_V=
MAPPLE_BDIF&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;bdif.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_V=
MAPPLE_CFG&#39;,=C2=A0 if_true: files(&#39;cfg.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +system_ss.add(when: &#39;CONFIG_VMAPPLE_VIRT=
IO_BLK&#39;,=C2=A0 if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;virtio-blk.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/virtio-blk.c b/hw/vma=
pple/virtio-blk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..720eaa61a86<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/virtio-blk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,212 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * VMApple specific VirtIO Block implementat=
ion<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * VMApple uses almost standard VirtIO Block=
, but with a few key<br>
&gt;=C2=A0 =C2=A0 =C2=A0differences:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *=C2=A0 - Different PCI device/vendor ID<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *=C2=A0 - An additional &quot;type&quot; id=
entifier to differentiate AUX and<br>
&gt;=C2=A0 =C2=A0 =C2=A0Root volumes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *=C2=A0 - An additional BARRIER command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/vmapple/virtio-blk.h&quot;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define VIRTIO_BLK_T_APPLE_BARRIER=C2=A0 =C2=
=A0 =C2=A00x10000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define VIRTIO_APPLE_TYPE_ROOT 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define VIRTIO_APPLE_TYPE_AUX=C2=A0 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple_virtio_blk_handle_unknown_request(VirtIOBlo=
ckReq *req,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0MultiReqBuffer *mrb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
int32_t type)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 switch (type) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case VIRTIO_BLK_T_APPLE_BARRIE=
R:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We ignore bar=
riers for now. YOLO. */<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It should be LOG_UNIMP instead of a mere comment.<b=
r>
&gt; <br>
&gt; <br>
&gt; Fixed in next patch version.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_req_c=
omplete(req, VIRTIO_BLK_S_OK);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_free_=
request(req);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * VMApple virtio-blk uses the same config f=
ormat as normal<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio, with one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * exception: It adds an &quot;apple type&qu=
ot; specififer at the same<br>
&gt;=C2=A0 =C2=A0 =C2=A0location that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * the spec reserves for max_secure_erase_se=
ctors. Let&#39;s hook<br>
&gt;=C2=A0 =C2=A0 =C2=A0into the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * get_config code path here, run it as usua=
l and then patch in<br>
&gt;=C2=A0 =C2=A0 =C2=A0the apple type.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_virtio_blk_get_config(Vi=
rtIODevice *vdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint8_t *config)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlk *dev =3D VMAP=
PLE_VIRTIO_BLK(vdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkClass *vvbk =
=3D VMAPPLE_VIRTIO_BLK_GET_CLASS(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 struct virtio_blk_config *blkc=
fg =3D (struct virtio_blk_config<br>
&gt;=C2=A0 =C2=A0 =C2=A0*)config;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vvbk-&gt;get_config(vdev, conf=
ig);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 g_assert(dev-&gt;parent_obj.co=
nfig_size &gt;=3D endof(struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_blk_config, zoned));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Apple abuses the field for =
max_secure_erase_sectors as<br>
&gt;=C2=A0 =C2=A0 =C2=A0type id */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 blkcfg-&gt;max_secure_erase_se=
ctors =3D dev-&gt;apple_type;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static Property vmapple_virtio_blk_propertie=
s[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;apple=
-type&quot;, VMAppleVirtIOBlk,<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_type, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_virtio_blk_class_init(Ob=
jectClass *klass,<br>
&gt;=C2=A0 =C2=A0 =C2=A0void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLA=
SS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VirtIOBlkClass *vbk =3D VIRTIO=
_BLK_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VirtioDeviceClass *vdc =3D VIR=
TIO_DEVICE_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkClass *vvbk =
=3D VMAPPLE_VIRTIO_BLK_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vbk-&gt;handle_unknown_request=
 =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple_virtio_blk_handle_unknown_request;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vvbk-&gt;get_config =3D vdc-&g=
t;get_config;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vdc-&gt;get_config =3D vmapple=
_virtio_blk_get_config;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 device_class_set_props(dc, vma=
pple_virtio_blk_properties);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const TypeInfo vmapple_virtio_blk_inf=
o =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D TYPE_VMAPPLE_VIRTIO_BLK,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D TYPE_VIRTIO_BLK,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAp=
pleVirtIOBlk),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D v=
mapple_virtio_blk_class_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/* PCI Devices */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct VMAppleVirtIOBlkPCI {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VirtIOPCIProxy parent_obj;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlk vdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t apple_type;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} VMAppleVirtIOBlkPCI;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * vmapple-virtio-blk-pci: This extends Virt=
ioPCIProxy.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define TYPE_VMAPPLE_VIRTIO_BLK_PCI &quot;vm=
apple-virtio-blk-pci-base&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +DECLARE_INSTANCE_CHECKER(VMAppleVirtIOBlkPCI=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0VMAPPLE_VIRTIO_BLK_PCI,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_VMAPPLE_VIRTIO_BLK_PCI=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static Property vmapple_virtio_blk_pci_prope=
rties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;class=
&quot;, VirtIOPCIProxy, class_code, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT(&quot;ioeventf=
d&quot;, VirtIOPCIProxy, flags,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;vecto=
rs&quot;, VirtIOPCIProxy, nvectors,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEV_NVECTORS_UNSPECIFIED),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_virtio_blk_pci_realize(V=
irtIOPCIProxy<br>
&gt;=C2=A0 =C2=A0 =C2=A0*vpci_dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkPCI *dev =3D V=
MAPPLE_VIRTIO_BLK_PCI(vpci_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceState *vdev =3D DEVICE(&=
amp;dev-&gt;vdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VirtIOBlkConf *conf =3D &amp;d=
ev-&gt;vdev.parent_obj.conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (conf-&gt;num_queues =3D=3D=
 VIRTIO_BLK_AUTO_NUM_QUEUES) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 conf-&gt;num_que=
ues =3D virtio_pci_optimal_num_queues(0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (vpci_dev-&gt;nvectors =3D=
=3D DEV_NVECTORS_UNSPECIFIED) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vpci_dev-&gt;nve=
ctors =3D conf-&gt;num_queues + 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* We don&#39;t support z=
ones, but we need the additional config<br>
&gt;=C2=A0 =C2=A0 =C2=A0space size.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* Let&#39;s just expose =
the feature so the rest of the virtio-<br>
&gt;=C2=A0 =C2=A0 =C2=A0blk logic<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* allocates enough space=
 for us. The guest will ignore<br>
&gt;=C2=A0 =C2=A0 =C2=A0zones anyway.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 virtio_add_feature(&amp;dev-&g=
t;vdev.parent_obj.host_features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_BLK_F_ZONED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Propagate the apple type do=
wn to the virtio-blk device */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&a=
mp;dev-&gt;vdev), &quot;apple-type&quot;, dev-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;apple_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* and spawn the virtio-blk de=
vice */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_realize(vdev, BUS(&amp;vp=
ci_dev-&gt;bus), errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* The virtio-pci machine=
ry adjusts its vendor/device ID<br>
&gt;=C2=A0 =C2=A0 =C2=A0based on whether<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* we support modern or l=
egacy virtio. Let&#39;s patch it back<br>
&gt;=C2=A0 =C2=A0 =C2=A0to the Apple<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0* identifiers here.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 pci_config_set_vendor_id(vpci_=
dev-&gt;pci_dev.config,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PCI_VENDOR_ID_APPLE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 pci_config_set_device_id(vpci_=
dev-&gt;pci_dev.config,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PCI_DEVICE_ID_APPLE_VIRTIO_BLK);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_virtio_blk_pci_class_ini=
t(ObjectClass<br>
&gt;=C2=A0 =C2=A0 =C2=A0*klass, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLA=
SS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VirtioPCIClass *k =3D VIRTIO_P=
CI_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PCIDeviceClass *pcidev_k =3D P=
CI_DEVICE_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_STORAG=
E, dc-&gt;categories);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 device_class_set_props(dc, vma=
pple_virtio_blk_pci_properties);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 k-&gt;realize =3D vmapple_virt=
io_blk_pci_realize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 pcidev_k-&gt;vendor_id =3D PCI=
_VENDOR_ID_APPLE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 pcidev_k-&gt;device_id =3D PCI=
_DEVICE_ID_APPLE_VIRTIO_BLK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 pcidev_k-&gt;revision =3D VIRT=
IO_PCI_ABI_VERSION;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 pcidev_k-&gt;class_id =3D PCI_=
CLASS_STORAGE_SCSI;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_virtio_blk_pci_instance_=
init(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkPCI *dev =3D V=
MAPPLE_VIRTIO_BLK_PCI(obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 virtio_instance_init_common(ob=
j, &amp;dev-&gt;vdev, sizeof(dev-&gt;vdev),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_=
VMAPPLE_VIRTIO_BLK);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const VirtioPCIDeviceTypeInfo vmapple=
_virtio_blk_pci_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .base_name=C2=A0 =C2=A0 =C2=A0=
=3D TYPE_VMAPPLE_VIRTIO_BLK_PCI,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .generic_name=C2=A0 =3D &quot;=
vmapple-virtio-blk-pci&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAp=
pleVirtIOBlkPCI),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_vir=
tio_blk_pci_instance_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D v=
mapple_virtio_blk_pci_class_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_virtio_root_instance_ini=
t(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkPCI *dev =3D V=
MAPPLE_VIRTIO_BLK_PCI(obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dev-&gt;apple_type =3D VIRTIO_=
APPLE_TYPE_ROOT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const TypeInfo vmapple_virtio_root_in=
fo =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D TYPE_VMAPPLE_VIRTIO_ROOT,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D &quot;vmapple-virtio-blk-pci&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAp=
pleVirtIOBlkPCI),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_vir=
tio_root_instance_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_virtio_aux_instance_init=
(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkPCI *dev =3D V=
MAPPLE_VIRTIO_BLK_PCI(obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dev-&gt;apple_type =3D VIRTIO_=
APPLE_TYPE_AUX;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const TypeInfo vmapple_virtio_aux_inf=
o =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D TYPE_VMAPPLE_VIRTIO_AUX,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D &quot;vmapple-virtio-blk-pci&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAp=
pleVirtIOBlkPCI),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_vir=
tio_aux_instance_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void vmapple_virtio_blk_register_type=
s(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmap=
ple_virtio_blk_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 virtio_pci_types_register(&amp=
;vmapple_virtio_blk_pci_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmap=
ple_virtio_root_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmap=
ple_virtio_aux_info);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +type_init(vmapple_virtio_blk_register_types)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/hw/pci/pci_ids.h b/inclu=
de/hw/pci/pci_ids.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index f1a53fea8d6..33e2898be95 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/include/hw/pci/pci_ids.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/hw/pci/pci_ids.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -191,6 +191,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#define PCI_DEVICE_ID_APPLE_UNI_N=
_AGP=C2=A0 =C2=A0 0x0020<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#define PCI_DEVICE_ID_APPLE_U3_AG=
P=C2=A0 =C2=A0 =C2=A0 =C2=A00x004b<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#define PCI_DEVICE_ID_APPLE_UNI_N=
_GMAC=C2=A0 =C2=A00x0021<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK=C2=A0=
 =C2=A00x1a00<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#define PCI_VENDOR_ID_SUN=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x108e<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#define PCI_DEVICE_ID_SUN_EBUS=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/hw/virtio/virtio-blk.h b=
/include/hw/virtio/<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio-blk.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 5c14110c4b1..28d5046ea6c 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/include/hw/virtio/virtio-blk.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/hw/virtio/virtio-blk.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -24,7 +24,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#include &quot;qapi/qapi-types-vi=
rtio.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#define TYPE_VIRTIO_BLK &quot;vir=
tio-blk-device&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRT=
IO_BLK)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkCl=
ass, VIRTIO_BLK)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0/* This is the last element of th=
e write scatter-gather list */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0struct virtio_blk_inhdr<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -100,6 +100,16 @@ typedef struct MultiReqB=
uffer {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_write;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0} MultiReqBuffer;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct VirtIOBlkClass {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VirtioDeviceClass parent;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool (*handle_unknown_request)=
(VirtIOBlockReq *req,<br>
&gt;=C2=A0 =C2=A0 =C2=A0MultiReqBuffer *mrb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} VirtIOBlkClass;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0void virtio_blk_handle_vq(VirtIOB=
lock *s, VirtQueue *vq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void virtio_blk_free_request(VirtIOBlockReq =
*req);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void virtio_blk_req_complete(VirtIOBlockReq =
*req, unsigned char<br>
&gt;=C2=A0 =C2=A0 =C2=A0status);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/include/hw/vmapple/virtio-blk.h =
b/include/hw/<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple/virtio-blk.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..b23106a3dfb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/include/hw/vmapple/virtio-blk.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,39 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * VMApple specific VirtIO Block implementat=
ion<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/virtio/virtio-pci.h&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/virtio/virtio-blk.h&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define TYPE_VMAPPLE_VIRTIO_BLK &quot;vmappl=
e-virtio-blk&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define TYPE_VMAPPLE_VIRTIO_ROOT &quot;vmapp=
le-virtio-root&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define TYPE_VMAPPLE_VIRTIO_AUX &quot;vmappl=
e-virtio-aux&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppl=
eVirtIOBlkClass,<br>
&gt;=C2=A0 =C2=A0 =C2=A0VMAPPLE_VIRTIO_BLK)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct VMAppleVirtIOBlkClass {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VirtIOBlkClass parent;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 void (*get_config)(VirtIODevic=
e *vdev, uint8_t *config);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} VMAppleVirtIOBlkClass;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct VMAppleVirtIOBlk {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* &lt;private&gt; */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 VirtIOBlock parent_obj;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* &lt;public&gt; */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t apple_type;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +} VMAppleVirtIOBlk;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#endif /* HW_VMAPPLE_CFG_H */<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000004bd4be06240ab9d3--

