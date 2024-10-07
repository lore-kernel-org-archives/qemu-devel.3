Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71A2CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxomU-0002oC-18; Mon, 07 Oct 2024 10:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sxomQ-0002nO-Sq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:32:10 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sxomJ-0002KM-1u
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:32:09 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-84eaa16442aso1117246241.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728311521; x=1728916321;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WrwQDQ041k4BLGXmP+VgT5+cmFZHuu7g1byrzFnwuk0=;
 b=J3FvT73wdoUa+bblcu0u845FZI8weiTfxs96O+QFI+hKGe4b267/s6QtSoEJR7IB9M
 fFfZ+BB81SbYVy/+x7h2cAJkgaNrc3ES8Fiwv8YWJW23IMULNr9VE+QzMKAVWkdQCn6a
 roVKbOFivx3NfGu3ETSQ6Xz/iV6DDfZIzb8va+nwX7YrbFSMOlBT1Mlwc2M70jicjeto
 eJUHb9IuywM69QXxbNNhI9oOgFixxsYaofd+D1q/BfazU0fqGy917gSdjsmS9zN9+WdA
 ofwzlnw2EPWoYNQkBT2nw6T6awjlBrVcXRBS2XENea9+X+W51ctoEG7jYT9DTSQhmRwr
 jUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728311521; x=1728916321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WrwQDQ041k4BLGXmP+VgT5+cmFZHuu7g1byrzFnwuk0=;
 b=q05fYWC5PZoPKX1FIXJpeiIvD/vfuVU7jQCAEfIqOkfT634hSYIJpy7oDAts9mFYyT
 je+sWskAcZDtBmIe5RCVscc/zrSJmZuzqwkRDxUOV8oOK/k43h4Z3EsyBKpFWPIP9HVY
 hPkTW8qharx3b03SYkcpJ4HhXIwIMAbjOLZ4NhbeutaZ1uZ0sOqN51nCV/1DSYVc6Bdj
 jvFP0fj/eDxklSXOJ/qyXTbiyVf4QsxXP1DMn5JxdXK1Pd28uG+s1/iKj6vxx7n2Ye2Y
 9idVI5NF1AV1rlYNLn4ywPqenmdP0z41wXBpPEoZ/mjLSvPYJ3AP01+8d44I+eJbL5rP
 jzjA==
X-Gm-Message-State: AOJu0Yx4stXLGrZFp/5szi+6mdvIrTp4Jm/7Hr5yLHRom4iQXzvhzgCm
 TfBU49uQEuaLYxVImxs5INEv8IifmuPN6jpy/ABKUU7Wa3zkiyjwoOl6E7igVx3fZ3Hplo3n3rb
 2Z+XsIzuGDsHrYOAohUTqLhD8Olypj4U4NWi3
X-Google-Smtp-Source: AGHT+IE4/mBp0n0X1RntFq5OyPbzNYyvprOrdJI9f+vGAQRwuqlcew2zLYXcnjoTHffeCNUsHQBY086DIwi5z0FoyUQ=
X-Received: by 2002:a05:6122:2508:b0:508:4997:18c6 with SMTP id
 71dfb90a1353d-50c852f79e5mr6939605e0c.0.1728311521139; Mon, 07 Oct 2024
 07:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-14-phil@philjordan.eu>
 <053c9224-6940-472a-8c62-276961b75935@daynix.com>
In-Reply-To: <053c9224-6940-472a-8c62-276961b75935@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 7 Oct 2024 16:31:50 +0200
Message-ID: <CAAibmn3q9ZxEHBiT8gLDWbSnFmZ4Z+gy3XphC0yAWj99ie+j9g@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="00000000000047a6fc0623e3e22b"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::929;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x929.google.com
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

--00000000000047a6fc0623e3e22b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Oct 2024 at 07:47, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > Apple has its own virtio-blk PCI device ID where it deviates from the
> > official virtio-pci spec slightly: It puts a new "apple type"
> > field at a static offset in config space and introduces a new barrier
> > command.
> >
> > This patch first creates a mechanism for virtio-blk downstream classes =
to
> > handle unknown commands. It then creates such a downstream class and a
> new
> > vmapple-virtio-blk-pci class which support the additional apple type
> config
> > identifier as well as the barrier command.
> >
> > It then exposes 2 subclasses from that that we can use to expose root a=
nd
> > aux virtio-blk devices: "vmapple-virtio-root" and "vmapple-virtio-aux".
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   hw/block/virtio-blk.c           |  19 ++-
> >   hw/vmapple/Kconfig              |   3 +
> >   hw/vmapple/meson.build          |   1 +
> >   hw/vmapple/virtio-blk.c         | 212 +++++++++++++++++++++++++++++++=
+
> >   include/hw/pci/pci_ids.h        |   1 +
> >   include/hw/virtio/virtio-blk.h  |  12 +-
> >   include/hw/vmapple/virtio-blk.h |  39 ++++++
> >   7 files changed, 282 insertions(+), 5 deletions(-)
> >   create mode 100644 hw/vmapple/virtio-blk.c
> >   create mode 100644 include/hw/vmapple/virtio-blk.h
> >
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 115795392c4..cecc4cef9e4 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -50,12 +50,12 @@ static void virtio_blk_init_request(VirtIOBlock *s,
> VirtQueue *vq,
> >       req->mr_next =3D NULL;
> >   }
> >
> > -static void virtio_blk_free_request(VirtIOBlockReq *req)
> > +void virtio_blk_free_request(VirtIOBlockReq *req)
> >   {
> >       g_free(req);
> >   }
>
> This function is identical with g_free(). Perhaps it's better to remove
> it instead of updating it.
>

I'm not sure that's something I should be doing in such a tangential patch
series, and it's very much a matter of taste - other operations on
VirtIOBlockReq have similar, consistent naming, and this function seemingly
hasn't been touched for 7 years.

Perhaps virtio-blk maintainer Stefan Hajnoczi could weigh in? (tagged in
To:)



> > -static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char
> status)
> > +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status=
)
> >   {
> >       VirtIOBlock *s =3D req->dev;
> >       VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> > @@ -966,8 +966,18 @@ static int virtio_blk_handle_request(VirtIOBlockRe=
q
> *req, MultiReqBuffer *mrb)
> >           break;
> >       }
> >       default:
> > -        virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> > -        virtio_blk_free_request(req);
> > +    {
> > +        /*
> > +         * Give subclasses a chance to handle unknown requests. This
> way the
> > +         * class lookup is not in the hot path.
> > +         */
> > +        VirtIOBlkClass *vbk =3D VIRTIO_BLK_GET_CLASS(s);
> > +        if (!vbk->handle_unknown_request ||
> > +            !vbk->handle_unknown_request(req, mrb, type)) {
> > +            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> > +            virtio_blk_free_request(req);
> > +        }
> > +    }
> >       }
> >       return 0;
> >   }
> > @@ -2044,6 +2054,7 @@ static const TypeInfo virtio_blk_info =3D {
> >       .instance_size =3D sizeof(VirtIOBlock),
> >       .instance_init =3D virtio_blk_instance_init,
> >       .class_init =3D virtio_blk_class_init,
> > +    .class_size =3D sizeof(VirtIOBlkClass),
> >   };
> >
> >   static void virtio_register_types(void)
> > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> > index 8bbeb9a9237..bcd1be63e3c 100644
> > --- a/hw/vmapple/Kconfig
> > +++ b/hw/vmapple/Kconfig
> > @@ -7,3 +7,6 @@ config VMAPPLE_BDIF
> >   config VMAPPLE_CFG
> >       bool
> >
> > +config VMAPPLE_VIRTIO_BLK
> > +    bool
> > +
> > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> > index 64b78693a31..bf17cf906c9 100644
> > --- a/hw/vmapple/meson.build
> > +++ b/hw/vmapple/meson.build
> > @@ -1,3 +1,4 @@
> >   system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
> >   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
> >   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
> > +system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true:
> files('virtio-blk.c'))
> > diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
> > new file mode 100644
> > index 00000000000..720eaa61a86
> > --- /dev/null
> > +++ b/hw/vmapple/virtio-blk.c
> > @@ -0,0 +1,212 @@
> > +/*
> > + * VMApple specific VirtIO Block implementation
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s
> Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + * VMApple uses almost standard VirtIO Block, but with a few key
> differences:
> > + *
> > + *  - Different PCI device/vendor ID
> > + *  - An additional "type" identifier to differentiate AUX and Root
> volumes
> > + *  - An additional BARRIER command
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/vmapple/virtio-blk.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qapi/error.h"
> > +
> > +#define VIRTIO_BLK_T_APPLE_BARRIER     0x10000
> > +
> > +#define VIRTIO_APPLE_TYPE_ROOT 1
> > +#define VIRTIO_APPLE_TYPE_AUX  2
> > +
> > +static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq
> *req,
> > +                                                      MultiReqBuffer
> *mrb,
> > +                                                      uint32_t type)
> > +{
> > +    switch (type) {
> > +    case VIRTIO_BLK_T_APPLE_BARRIER:
> > +        /* We ignore barriers for now. YOLO. */
>
> It should be LOG_UNIMP instead of a mere comment.
>

Fixed in next patch version.


> > +        virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> > +        virtio_blk_free_request(req);
> > +        return true;
> > +    default:
> > +        return false;
> > +    }
> > +}
> > +
> > +/*
> > + * VMApple virtio-blk uses the same config format as normal virtio,
> with one
> > + * exception: It adds an "apple type" specififer at the same location
> that
> > + * the spec reserves for max_secure_erase_sectors. Let's hook into the
> > + * get_config code path here, run it as usual and then patch in the
> apple type.
> > + */
> > +static void vmapple_virtio_blk_get_config(VirtIODevice *vdev, uint8_t
> *config)
> > +{
> > +    VMAppleVirtIOBlk *dev =3D VMAPPLE_VIRTIO_BLK(vdev);
> > +    VMAppleVirtIOBlkClass *vvbk =3D VMAPPLE_VIRTIO_BLK_GET_CLASS(dev);
> > +    struct virtio_blk_config *blkcfg =3D (struct virtio_blk_config
> *)config;
> > +
> > +    vvbk->get_config(vdev, config);
> > +
> > +    g_assert(dev->parent_obj.config_size >=3D endof(struct
> virtio_blk_config, zoned));
> > +
> > +    /* Apple abuses the field for max_secure_erase_sectors as type id =
*/
> > +    blkcfg->max_secure_erase_sectors =3D dev->apple_type;
> > +}
> > +
> > +static Property vmapple_virtio_blk_properties[] =3D {
> > +    DEFINE_PROP_UINT32("apple-type", VMAppleVirtIOBlk, apple_type, 0),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void vmapple_virtio_blk_class_init(ObjectClass *klass, void
> *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtIOBlkClass *vbk =3D VIRTIO_BLK_CLASS(klass);
> > +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> > +    VMAppleVirtIOBlkClass *vvbk =3D VMAPPLE_VIRTIO_BLK_CLASS(klass);
> > +
> > +    vbk->handle_unknown_request =3D
> vmapple_virtio_blk_handle_unknown_request;
> > +    vvbk->get_config =3D vdc->get_config;
> > +    vdc->get_config =3D vmapple_virtio_blk_get_config;
> > +    device_class_set_props(dc, vmapple_virtio_blk_properties);
> > +}
> > +
> > +static const TypeInfo vmapple_virtio_blk_info =3D {
> > +    .name          =3D TYPE_VMAPPLE_VIRTIO_BLK,
> > +    .parent        =3D TYPE_VIRTIO_BLK,
> > +    .instance_size =3D sizeof(VMAppleVirtIOBlk),
> > +    .class_init    =3D vmapple_virtio_blk_class_init,
> > +};
> > +
> > +/* PCI Devices */
> > +
> > +typedef struct VMAppleVirtIOBlkPCI {
> > +    VirtIOPCIProxy parent_obj;
> > +    VMAppleVirtIOBlk vdev;
> > +    uint32_t apple_type;
> > +} VMAppleVirtIOBlkPCI;
> > +
> > +/*
> > + * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.
> > + */
> > +#define TYPE_VMAPPLE_VIRTIO_BLK_PCI "vmapple-virtio-blk-pci-base"
> > +DECLARE_INSTANCE_CHECKER(VMAppleVirtIOBlkPCI, VMAPPLE_VIRTIO_BLK_PCI,
> > +                         TYPE_VMAPPLE_VIRTIO_BLK_PCI)
> > +
> > +static Property vmapple_virtio_blk_pci_properties[] =3D {
> > +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> > +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> > +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> > +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> > +                       DEV_NVECTORS_UNSPECIFIED),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev,
> Error **errp)
> > +{
> > +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(vpci_dev);
> > +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> > +    VirtIOBlkConf *conf =3D &dev->vdev.parent_obj.conf;
> > +
> > +    if (conf->num_queues =3D=3D VIRTIO_BLK_AUTO_NUM_QUEUES) {
> > +        conf->num_queues =3D virtio_pci_optimal_num_queues(0);
> > +    }
> > +
> > +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> > +        vpci_dev->nvectors =3D conf->num_queues + 1;
> > +    }
> > +
> > +    /*
> > +     * We don't support zones, but we need the additional config space
> size.
> > +     * Let's just expose the feature so the rest of the virtio-blk log=
ic
> > +     * allocates enough space for us. The guest will ignore zones
> anyway.
> > +     */
> > +    virtio_add_feature(&dev->vdev.parent_obj.host_features,
> VIRTIO_BLK_F_ZONED);
> > +    /* Propagate the apple type down to the virtio-blk device */
> > +    qdev_prop_set_uint32(DEVICE(&dev->vdev), "apple-type",
> dev->apple_type);
> > +    /* and spawn the virtio-blk device */
> > +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > +
> > +    /*
> > +     * The virtio-pci machinery adjusts its vendor/device ID based on
> whether
> > +     * we support modern or legacy virtio. Let's patch it back to the
> Apple
> > +     * identifiers here.
> > +     */
> > +    pci_config_set_vendor_id(vpci_dev->pci_dev.config,
> PCI_VENDOR_ID_APPLE);
> > +    pci_config_set_device_id(vpci_dev->pci_dev.config,
> PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
> > +}
> > +
> > +static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass, void
> *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> > +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> > +
> > +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > +    device_class_set_props(dc, vmapple_virtio_blk_pci_properties);
> > +    k->realize =3D vmapple_virtio_blk_pci_realize;
> > +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_APPLE;
> > +    pcidev_k->device_id =3D PCI_DEVICE_ID_APPLE_VIRTIO_BLK;
> > +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> > +    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
> > +}
> > +
> > +static void vmapple_virtio_blk_pci_instance_init(Object *obj)
> > +{
> > +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> > +
> > +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> > +                                TYPE_VMAPPLE_VIRTIO_BLK);
> > +}
> > +
> > +static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_info =3D {
> > +    .base_name     =3D TYPE_VMAPPLE_VIRTIO_BLK_PCI,
> > +    .generic_name  =3D "vmapple-virtio-blk-pci",
> > +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> > +    .instance_init =3D vmapple_virtio_blk_pci_instance_init,
> > +    .class_init    =3D vmapple_virtio_blk_pci_class_init,
> > +};
> > +
> > +static void vmapple_virtio_root_instance_init(Object *obj)
> > +{
> > +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> > +
> > +    dev->apple_type =3D VIRTIO_APPLE_TYPE_ROOT;
> > +}
> > +
> > +static const TypeInfo vmapple_virtio_root_info =3D {
> > +    .name          =3D TYPE_VMAPPLE_VIRTIO_ROOT,
> > +    .parent        =3D "vmapple-virtio-blk-pci",
> > +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> > +    .instance_init =3D vmapple_virtio_root_instance_init,
> > +};
> > +
> > +static void vmapple_virtio_aux_instance_init(Object *obj)
> > +{
> > +    VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj);
> > +
> > +    dev->apple_type =3D VIRTIO_APPLE_TYPE_AUX;
> > +}
> > +
> > +static const TypeInfo vmapple_virtio_aux_info =3D {
> > +    .name          =3D TYPE_VMAPPLE_VIRTIO_AUX,
> > +    .parent        =3D "vmapple-virtio-blk-pci",
> > +    .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),
> > +    .instance_init =3D vmapple_virtio_aux_instance_init,
> > +};
> > +
> > +static void vmapple_virtio_blk_register_types(void)
> > +{
> > +    type_register_static(&vmapple_virtio_blk_info);
> > +    virtio_pci_types_register(&vmapple_virtio_blk_pci_info);
> > +    type_register_static(&vmapple_virtio_root_info);
> > +    type_register_static(&vmapple_virtio_aux_info);
> > +}
> > +
> > +type_init(vmapple_virtio_blk_register_types)
> > diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> > index f1a53fea8d6..33e2898be95 100644
> > --- a/include/hw/pci/pci_ids.h
> > +++ b/include/hw/pci/pci_ids.h
> > @@ -191,6 +191,7 @@
> >   #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
> >   #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
> >   #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
> > +#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
> >
> >   #define PCI_VENDOR_ID_SUN                0x108e
> >   #define PCI_DEVICE_ID_SUN_EBUS           0x1000
> > diff --git a/include/hw/virtio/virtio-blk.h
> b/include/hw/virtio/virtio-blk.h
> > index 5c14110c4b1..28d5046ea6c 100644
> > --- a/include/hw/virtio/virtio-blk.h
> > +++ b/include/hw/virtio/virtio-blk.h
> > @@ -24,7 +24,7 @@
> >   #include "qapi/qapi-types-virtio.h"
> >
> >   #define TYPE_VIRTIO_BLK "virtio-blk-device"
> > -OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)
> > +OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkClass, VIRTIO_BLK)
> >
> >   /* This is the last element of the write scatter-gather list */
> >   struct virtio_blk_inhdr
> > @@ -100,6 +100,16 @@ typedef struct MultiReqBuffer {
> >       bool is_write;
> >   } MultiReqBuffer;
> >
> > +typedef struct VirtIOBlkClass {
> > +    /*< private >*/
> > +    VirtioDeviceClass parent;
> > +    /*< public >*/
> > +    bool (*handle_unknown_request)(VirtIOBlockReq *req, MultiReqBuffer
> *mrb,
> > +                                   uint32_t type);
> > +} VirtIOBlkClass;
> > +
> >   void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
> > +void virtio_blk_free_request(VirtIOBlockReq *req);
> > +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status=
);
> >
> >   #endif
> > diff --git a/include/hw/vmapple/virtio-blk.h
> b/include/hw/vmapple/virtio-blk.h
> > new file mode 100644
> > index 00000000000..b23106a3dfb
> > --- /dev/null
> > +++ b/include/hw/vmapple/virtio-blk.h
> > @@ -0,0 +1,39 @@
> > +/*
> > + * VMApple specific VirtIO Block implementation
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
> > +#ifndef HW_VMAPPLE_CFG_H
> > +#define HW_VMAPPLE_CFG_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "qom/object.h"
> > +#include "hw/virtio/virtio-pci.h"
> > +#include "hw/virtio/virtio-blk.h"
> > +
> > +#define TYPE_VMAPPLE_VIRTIO_BLK "vmapple-virtio-blk"
> > +#define TYPE_VMAPPLE_VIRTIO_ROOT "vmapple-virtio-root"
> > +#define TYPE_VMAPPLE_VIRTIO_AUX "vmapple-virtio-aux"
> > +
> > +OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass,
> VMAPPLE_VIRTIO_BLK)
> > +
> > +typedef struct VMAppleVirtIOBlkClass {
> > +    /*< private >*/
> > +    VirtIOBlkClass parent;
> > +    /*< public >*/
> > +    void (*get_config)(VirtIODevice *vdev, uint8_t *config);
> > +} VMAppleVirtIOBlkClass;
> > +
> > +typedef struct VMAppleVirtIOBlk {
> > +    /* <private> */
> > +    VirtIOBlock parent_obj;
> > +
> > +    /* <public> */
> > +    uint32_t apple_type;
> > +} VMAppleVirtIOBlk;
> > +
> > +#endif /* HW_VMAPPLE_CFG_H */
>
>

--00000000000047a6fc0623e3e22b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sat, 5 Oct 2024 at 07:47, Akihiko Odak=
i &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 2024/09/28 17:57, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; Apple has its own virtio-blk PCI device ID where it deviates from the<=
br>
&gt; official virtio-pci spec slightly: It puts a new &quot;apple type&quot=
;<br>
&gt; field at a static offset in config space and introduces a new barrier<=
br>
&gt; command.<br>
&gt; <br>
&gt; This patch first creates a mechanism for virtio-blk downstream classes=
 to<br>
&gt; handle unknown commands. It then creates such a downstream class and a=
 new<br>
&gt; vmapple-virtio-blk-pci class which support the additional apple type c=
onfig<br>
&gt; identifier as well as the barrier command.<br>
&gt; <br>
&gt; It then exposes 2 subclasses from that that we can use to expose root =
and<br>
&gt; aux virtio-blk devices: &quot;vmapple-virtio-root&quot; and &quot;vmap=
ple-virtio-aux&quot;.<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 19 ++-<br>
&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 212 ++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/pci/pci_ids.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-blk.h=C2=A0 |=C2=A0 12 +-<br>
&gt;=C2=A0 =C2=A0include/hw/vmapple/virtio-blk.h |=C2=A0 39 ++++++<br>
&gt;=C2=A0 =C2=A07 files changed, 282 insertions(+), 5 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/virtio-blk.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/vmapple/virtio-blk.h<br>
&gt; <br>
&gt; diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c<br>
&gt; index 115795392c4..cecc4cef9e4 100644<br>
&gt; --- a/hw/block/virtio-blk.c<br>
&gt; +++ b/hw/block/virtio-blk.c<br>
&gt; @@ -50,12 +50,12 @@ static void virtio_blk_init_request(VirtIOBlock *s=
, VirtQueue *vq,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;mr_next =3D NULL;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static void virtio_blk_free_request(VirtIOBlockReq *req)<br>
&gt; +void virtio_blk_free_request(VirtIOBlockReq *req)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(req);<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
This function is identical with g_free(). Perhaps it&#39;s better to remove=
 <br>
it instead of updating it.<br></blockquote><div><br></div><div>I&#39;m not =
sure that&#39;s something I should be doing in such a tangential patch seri=
es, and it&#39;s very much a matter of taste - other operations on VirtIOBl=
ockReq have similar, consistent naming, and this function seemingly hasn&#3=
9;t been touched for 7 years.</div><div><br></div><div>Perhaps virtio-blk m=
aintainer Stefan Hajnoczi could weigh in? (tagged in To:)<br></div><div><br=
></div><div>=C2=A0=C2=A0 <br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; -static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned cha=
r status)<br>
&gt; +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char statu=
s)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtIOBlock *s =3D req-&gt;dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtIODevice *vdev =3D VIRTIO_DEVICE(s);<br>
&gt; @@ -966,8 +966,18 @@ static int virtio_blk_handle_request(VirtIOBlockR=
eq *req, MultiReqBuffer *mrb)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_req_complete(req, VIRTIO_BLK_S=
_UNSUPP);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_free_request(req);<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Give subclasses a chance to handl=
e unknown requests. This way the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* class lookup is not in the hot pa=
th.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtIOBlkClass *vbk =3D VIRTIO_BLK_GET_CL=
ASS(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vbk-&gt;handle_unknown_request ||<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !vbk-&gt;handle_unknown_req=
uest(req, mrb, type)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_req_complete(req=
, VIRTIO_BLK_S_UNSUPP);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_free_request(req=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; @@ -2044,6 +2054,7 @@ static const TypeInfo virtio_blk_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(VirtIOBlock),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_init =3D virtio_blk_instance_init,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init =3D virtio_blk_class_init,<br>
&gt; +=C2=A0 =C2=A0 .class_size =3D sizeof(VirtIOBlkClass),<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void virtio_register_types(void)<br>
&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
&gt; index 8bbeb9a9237..bcd1be63e3c 100644<br>
&gt; --- a/hw/vmapple/Kconfig<br>
&gt; +++ b/hw/vmapple/Kconfig<br>
&gt; @@ -7,3 +7,6 @@ config VMAPPLE_BDIF<br>
&gt;=C2=A0 =C2=A0config VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config VMAPPLE_VIRTIO_BLK<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +<br>
&gt; diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build<br>
&gt; index 64b78693a31..bf17cf906c9 100644<br>
&gt; --- a/hw/vmapple/meson.build<br>
&gt; +++ b/hw/vmapple/meson.build<br>
&gt; @@ -1,3 +1,4 @@<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_VMAPPLE_AES&#39;,=C2=A0 if=
_true: files(&#39;aes.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_VMAPPLE_BDIF&#39;, if_true=
: files(&#39;bdif.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_VMAPPLE_CFG&#39;,=C2=A0 if=
_true: files(&#39;cfg.c&#39;))<br>
&gt; +system_ss.add(when: &#39;CONFIG_VMAPPLE_VIRTIO_BLK&#39;,=C2=A0 if_tru=
e: files(&#39;virtio-blk.c&#39;))<br>
&gt; diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..720eaa61a86<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/vmapple/virtio-blk.c<br>
&gt; @@ -0,0 +1,212 @@<br>
&gt; +/*<br>
&gt; + * VMApple specific VirtIO Block implementation<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + * VMApple uses almost standard VirtIO Block, but with a few key diff=
erences:<br>
&gt; + *<br>
&gt; + *=C2=A0 - Different PCI device/vendor ID<br>
&gt; + *=C2=A0 - An additional &quot;type&quot; identifier to differentiate=
 AUX and Root volumes<br>
&gt; + *=C2=A0 - An additional BARRIER command<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/vmapple/virtio-blk.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +<br>
&gt; +#define VIRTIO_BLK_T_APPLE_BARRIER=C2=A0 =C2=A0 =C2=A00x10000<br>
&gt; +<br>
&gt; +#define VIRTIO_APPLE_TYPE_ROOT 1<br>
&gt; +#define VIRTIO_APPLE_TYPE_AUX=C2=A0 2<br>
&gt; +<br>
&gt; +static bool vmapple_virtio_blk_handle_unknown_request(VirtIOBlockReq =
*req,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MultiReqBuffer *mrb,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 switch (type) {<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_BLK_T_APPLE_BARRIER:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We ignore barriers for now. YOLO. */<b=
r>
<br>
It should be LOG_UNIMP instead of a mere comment.<br></blockquote><div><br>=
</div><div>Fixed in next patch version.<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_req_complete(req, VIRTIO_BLK_S=
_OK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_blk_free_request(req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * VMApple virtio-blk uses the same config format as normal virtio, w=
ith one<br>
&gt; + * exception: It adds an &quot;apple type&quot; specififer at the sam=
e location that<br>
&gt; + * the spec reserves for max_secure_erase_sectors. Let&#39;s hook int=
o the<br>
&gt; + * get_config code path here, run it as usual and then patch in the a=
pple type.<br>
&gt; + */<br>
&gt; +static void vmapple_virtio_blk_get_config(VirtIODevice *vdev, uint8_t=
 *config)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlk *dev =3D VMAPPLE_VIRTIO_BLK(vdev);<br>
&gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkClass *vvbk =3D VMAPPLE_VIRTIO_BLK_GET_=
CLASS(dev);<br>
&gt; +=C2=A0 =C2=A0 struct virtio_blk_config *blkcfg =3D (struct virtio_blk=
_config *)config;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vvbk-&gt;get_config(vdev, config);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert(dev-&gt;parent_obj.config_size &gt;=3D endof(s=
truct virtio_blk_config, zoned));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Apple abuses the field for max_secure_erase_sectors =
as type id */<br>
&gt; +=C2=A0 =C2=A0 blkcfg-&gt;max_secure_erase_sectors =3D dev-&gt;apple_t=
ype;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static Property vmapple_virtio_blk_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;apple-type&quot;, VMAppleVirtI=
OBlk, apple_type, 0),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void vmapple_virtio_blk_class_init(ObjectClass *klass, void *d=
ata)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 VirtIOBlkClass *vbk =3D VIRTIO_BLK_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);<=
br>
&gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkClass *vvbk =3D VMAPPLE_VIRTIO_BLK_CLAS=
S(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vbk-&gt;handle_unknown_request =3D vmapple_virtio_blk_h=
andle_unknown_request;<br>
&gt; +=C2=A0 =C2=A0 vvbk-&gt;get_config =3D vdc-&gt;get_config;<br>
&gt; +=C2=A0 =C2=A0 vdc-&gt;get_config =3D vmapple_virtio_blk_get_config;<b=
r>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, vmapple_virtio_blk_propertie=
s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo vmapple_virtio_blk_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_VMAPPL=
E_VIRTIO_BLK,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_VIRTIO_BLK,=
<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAppleVirtIOBlk),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D vmapple_virtio_blk_class_i=
nit,<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* PCI Devices */<br>
&gt; +<br>
&gt; +typedef struct VMAppleVirtIOBlkPCI {<br>
&gt; +=C2=A0 =C2=A0 VirtIOPCIProxy parent_obj;<br>
&gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlk vdev;<br>
&gt; +=C2=A0 =C2=A0 uint32_t apple_type;<br>
&gt; +} VMAppleVirtIOBlkPCI;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * vmapple-virtio-blk-pci: This extends VirtioPCIProxy.<br>
&gt; + */<br>
&gt; +#define TYPE_VMAPPLE_VIRTIO_BLK_PCI &quot;vmapple-virtio-blk-pci-base=
&quot;<br>
&gt; +DECLARE_INSTANCE_CHECKER(VMAppleVirtIOBlkPCI, VMAPPLE_VIRTIO_BLK_PCI,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0TYPE_VMAPPLE_VIRTIO_BLK_PCI)<br>
&gt; +<br>
&gt; +static Property vmapple_virtio_blk_pci_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;class&quot;, VirtIOPCIProxy, c=
lass_code, 0),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT(&quot;ioeventfd&quot;, VirtIOPCIProxy, =
flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;vectors&quot;, VirtIOPCIProxy,=
 nvectors,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0DEV_NVECTORS_UNSPECIFIED),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void vmapple_virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, =
Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(vpc=
i_dev);<br>
&gt; +=C2=A0 =C2=A0 DeviceState *vdev =3D DEVICE(&amp;dev-&gt;vdev);<br>
&gt; +=C2=A0 =C2=A0 VirtIOBlkConf *conf =3D &amp;dev-&gt;vdev.parent_obj.co=
nf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (conf-&gt;num_queues =3D=3D VIRTIO_BLK_AUTO_NUM_QUEU=
ES) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 conf-&gt;num_queues =3D virtio_pci_optima=
l_num_queues(0);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vpci_dev-&gt;nvectors =3D=3D DEV_NVECTORS_UNSPECIFI=
ED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vpci_dev-&gt;nvectors =3D conf-&gt;num_qu=
eues + 1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* We don&#39;t support zones, but we need the add=
itional config space size.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Let&#39;s just expose the feature so the rest o=
f the virtio-blk logic<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* allocates enough space for us. The guest will i=
gnore zones anyway.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 virtio_add_feature(&amp;dev-&gt;vdev.parent_obj.host_fe=
atures, VIRTIO_BLK_F_ZONED);<br>
&gt; +=C2=A0 =C2=A0 /* Propagate the apple type down to the virtio-blk devi=
ce */<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;dev-&gt;vdev), &quot;a=
pple-type&quot;, dev-&gt;apple_type);<br>
&gt; +=C2=A0 =C2=A0 /* and spawn the virtio-blk device */<br>
&gt; +=C2=A0 =C2=A0 qdev_realize(vdev, BUS(&amp;vpci_dev-&gt;bus), errp);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The virtio-pci machinery adjusts its vendor/dev=
ice ID based on whether<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* we support modern or legacy virtio. Let&#39;s p=
atch it back to the Apple<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* identifiers here.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 pci_config_set_vendor_id(vpci_dev-&gt;pci_dev.config, P=
CI_VENDOR_ID_APPLE);<br>
&gt; +=C2=A0 =C2=A0 pci_config_set_device_id(vpci_dev-&gt;pci_dev.config, P=
CI_DEVICE_ID_APPLE_VIRTIO_BLK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vmapple_virtio_blk_pci_class_init(ObjectClass *klass, voi=
d *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_STORAGE, dc-&gt;categories);<br=
>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, vmapple_virtio_blk_pci_prope=
rties);<br>
&gt; +=C2=A0 =C2=A0 k-&gt;realize =3D vmapple_virtio_blk_pci_realize;<br>
&gt; +=C2=A0 =C2=A0 pcidev_k-&gt;vendor_id =3D PCI_VENDOR_ID_APPLE;<br>
&gt; +=C2=A0 =C2=A0 pcidev_k-&gt;device_id =3D PCI_DEVICE_ID_APPLE_VIRTIO_B=
LK;<br>
&gt; +=C2=A0 =C2=A0 pcidev_k-&gt;revision =3D VIRTIO_PCI_ABI_VERSION;<br>
&gt; +=C2=A0 =C2=A0 pcidev_k-&gt;class_id =3D PCI_CLASS_STORAGE_SCSI;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vmapple_virtio_blk_pci_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_instance_init_common(obj, &amp;dev-&gt;vdev, siz=
eof(dev-&gt;vdev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VMAPPLE_VIRTIO_BLK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VirtioPCIDeviceTypeInfo vmapple_virtio_blk_pci_info =3D =
{<br>
&gt; +=C2=A0 =C2=A0 .base_name=C2=A0 =C2=A0 =C2=A0=3D TYPE_VMAPPLE_VIRTIO_B=
LK_PCI,<br>
&gt; +=C2=A0 =C2=A0 .generic_name=C2=A0 =3D &quot;vmapple-virtio-blk-pci&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_virtio_blk_pci_instance_init=
,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D vmapple_virtio_blk_pci_cla=
ss_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void vmapple_virtio_root_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev-&gt;apple_type =3D VIRTIO_APPLE_TYPE_ROOT;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo vmapple_virtio_root_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_VMAPPL=
E_VIRTIO_ROOT,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;vmapple-vi=
rtio-blk-pci&quot;,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_virtio_root_instance_init,<b=
r>
&gt; +};<br>
&gt; +<br>
&gt; +static void vmapple_virtio_aux_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleVirtIOBlkPCI *dev =3D VMAPPLE_VIRTIO_BLK_PCI(obj=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev-&gt;apple_type =3D VIRTIO_APPLE_TYPE_AUX;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo vmapple_virtio_aux_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_VMAPPL=
E_VIRTIO_AUX,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;vmapple-vi=
rtio-blk-pci&quot;,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAppleVirtIOBlkPCI),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_virtio_aux_instance_init,<br=
>
&gt; +};<br>
&gt; +<br>
&gt; +static void vmapple_virtio_blk_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmapple_virtio_blk_info);<br>
&gt; +=C2=A0 =C2=A0 virtio_pci_types_register(&amp;vmapple_virtio_blk_pci_i=
nfo);<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmapple_virtio_root_info);<br=
>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmapple_virtio_aux_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(vmapple_virtio_blk_register_types)<br>
&gt; diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h<br>
&gt; index f1a53fea8d6..33e2898be95 100644<br>
&gt; --- a/include/hw/pci/pci_ids.h<br>
&gt; +++ b/include/hw/pci/pci_ids.h<br>
&gt; @@ -191,6 +191,7 @@<br>
&gt;=C2=A0 =C2=A0#define PCI_DEVICE_ID_APPLE_UNI_N_AGP=C2=A0 =C2=A0 0x0020<=
br>
&gt;=C2=A0 =C2=A0#define PCI_DEVICE_ID_APPLE_U3_AGP=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x004b<br>
&gt;=C2=A0 =C2=A0#define PCI_DEVICE_ID_APPLE_UNI_N_GMAC=C2=A0 =C2=A00x0021<=
br>
&gt; +#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK=C2=A0 =C2=A00x1a00<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define PCI_VENDOR_ID_SUN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x108e<br>
&gt;=C2=A0 =C2=A0#define PCI_DEVICE_ID_SUN_EBUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x1000<br>
&gt; diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio=
-blk.h<br>
&gt; index 5c14110c4b1..28d5046ea6c 100644<br>
&gt; --- a/include/hw/virtio/virtio-blk.h<br>
&gt; +++ b/include/hw/virtio/virtio-blk.h<br>
&gt; @@ -24,7 +24,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;qapi/qapi-types-virtio.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define TYPE_VIRTIO_BLK &quot;virtio-blk-device&quot;<br>
&gt; -OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)<br>
&gt; +OBJECT_DECLARE_TYPE(VirtIOBlock, VirtIOBlkClass, VIRTIO_BLK)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* This is the last element of the write scatter-gather li=
st */<br>
&gt;=C2=A0 =C2=A0struct virtio_blk_inhdr<br>
&gt; @@ -100,6 +100,16 @@ typedef struct MultiReqBuffer {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_write;<br>
&gt;=C2=A0 =C2=A0} MultiReqBuffer;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +typedef struct VirtIOBlkClass {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 VirtioDeviceClass parent;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 =C2=A0 bool (*handle_unknown_request)(VirtIOBlockReq *req, Mul=
tiReqBuffer *mrb,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t type);<br>
&gt; +} VirtIOBlkClass;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);<=
br>
&gt; +void virtio_blk_free_request(VirtIOBlockReq *req);<br>
&gt; +void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char statu=
s);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; diff --git a/include/hw/vmapple/virtio-blk.h b/include/hw/vmapple/virt=
io-blk.h<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..b23106a3dfb<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/vmapple/virtio-blk.h<br>
&gt; @@ -0,0 +1,39 @@<br>
&gt; +/*<br>
&gt; + * VMApple specific VirtIO Block implementation<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_VMAPPLE_CFG_H<br>
&gt; +#define HW_VMAPPLE_CFG_H<br>
&gt; +<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-pci.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-blk.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_VMAPPLE_VIRTIO_BLK &quot;vmapple-virtio-blk&quot;<br>
&gt; +#define TYPE_VMAPPLE_VIRTIO_ROOT &quot;vmapple-virtio-root&quot;<br>
&gt; +#define TYPE_VMAPPLE_VIRTIO_AUX &quot;vmapple-virtio-aux&quot;<br>
&gt; +<br>
&gt; +OBJECT_DECLARE_TYPE(VMAppleVirtIOBlk, VMAppleVirtIOBlkClass, VMAPPLE_=
VIRTIO_BLK)<br>
&gt; +<br>
&gt; +typedef struct VMAppleVirtIOBlkClass {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 VirtIOBlkClass parent;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 =C2=A0 void (*get_config)(VirtIODevice *vdev, uint8_t *config)=
;<br>
&gt; +} VMAppleVirtIOBlkClass;<br>
&gt; +<br>
&gt; +typedef struct VMAppleVirtIOBlk {<br>
&gt; +=C2=A0 =C2=A0 /* &lt;private&gt; */<br>
&gt; +=C2=A0 =C2=A0 VirtIOBlock parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* &lt;public&gt; */<br>
&gt; +=C2=A0 =C2=A0 uint32_t apple_type;<br>
&gt; +} VMAppleVirtIOBlk;<br>
&gt; +<br>
&gt; +#endif /* HW_VMAPPLE_CFG_H */<br>
<br>
</blockquote></div></div>

--00000000000047a6fc0623e3e22b--

