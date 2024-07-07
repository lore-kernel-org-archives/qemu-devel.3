Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938BFC30653
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 16:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQUsb-0005qn-L1; Sun, 07 Jul 2024 12:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sQUsa-0005qR-IG; Sun, 07 Jul 2024 12:36:48 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sQUsY-0002yg-2A; Sun, 07 Jul 2024 12:36:48 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eea7e2b0e6so2146591fa.3; 
 Sun, 07 Jul 2024 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720370202; x=1720975002; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apkyt5Q8sZGoaK5S+TLHoMEG45378kk4Vg5teQ8gTWw=;
 b=IIXUZG7Cl+T3d6R8QS1kphdycFUBLwKqrQTCnRL1fnB9l7BhaE/ALLRpjflhvZJr2J
 CdUWBaIO61p3+EX1WtxmXivXnlWj7glZ5UeJL8AqeMfvxWB1de3OWD8DSrAkf+RgMN6u
 IPBH6kztg6xcajcaPE3tQZ/zeYcObf0ZztMdF5zKdaqcJwB1bmYx5ErY0ZVmUdrmtoMu
 8g0QSqcQgnlk55tNQ2zJ8iTri9ugus2eACGltJpsT0Jj5DNMHVcN+HHiGDyaPzUV8AN0
 pFk7hJ19H5/gK8vrerhsoOr3LQKsOJOLbNhMM52DxyuKig/9VJ+h2q4Abt0UWEBF8Qql
 ZdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720370202; x=1720975002;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apkyt5Q8sZGoaK5S+TLHoMEG45378kk4Vg5teQ8gTWw=;
 b=Iw8ELaWoa1Dgeplo/yhpSgCeXrXOTenL7uItQj9IIMdsslqj0lLpQ+rE4dk1Ia2IC/
 UbINxAyMmk1MKi67sWpp+OtcGvd1qi14Sp97ATWBrxoIPuznAJf69bdVkZv5cKdQCQzP
 4D7Ctlnc0CJ9MWZciAAkrnQ5gBnk+o2e+mNRDeK/4CXSXASRkGB8Aycoh0G+u+yoUUea
 ifpDu0OVx89zWj4d/pk3O8tHMDPuei3C/CfcAnP2OGJjE+yK97qiDzd9eztubSsDXrro
 EOGcC+o35JBr9fVvUwJ61eE9cH7IzV/mLl3qXPal79ojB2vF41jX7C5MyU8cov8JWfT4
 WJJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2lWfxyv0FFb9dPcp8c/uDJ9t7Q0m066J30peHUR5XQ8P/0CFJ6gO2ZrsANsYVOFw+E3HvYqr3LMq/RhS6J3cv0iSblqY=
X-Gm-Message-State: AOJu0YyHlJpGs5KtsjDL0twWkQpL2Irm8r800VSkRsGOh4iGCn7ENZvo
 U3GE0uGoOWXcm/OkM/j3qo9qT/l0G6oJITwODT982VNWHEu8MVm6FmJQmZmbT5Q=
X-Google-Smtp-Source: AGHT+IGogZBb7TmBdOQBvu4BXyWQqkV79MI6140fcq7edyOVHJs1PBfB1KVqkBY3XXdMKEv9eBdEVg==
X-Received: by 2002:a05:651c:d1:b0:2ec:89b8:3d2f with SMTP id
 38308e7fff4ca-2ee8ed45b27mr67177811fa.19.1720370202082; 
 Sun, 07 Jul 2024 09:36:42 -0700 (PDT)
Received: from smtpclient.apple ([176.194.243.4])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ee94c5938fsm6879241fa.47.2024.07.07.09.36.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jul 2024 09:36:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH RFC v4] virtio: Implement Virtio Backend for SD/MMC in QEMU
From: =?utf-8?B?0JzQuA==?= <krashmisha@gmail.com>
In-Reply-To: <20240706154840.39503-1-krashmisha@gmail.com>
Date: Sun, 7 Jul 2024 19:36:30 +0300
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0F5EAE2-F698-4870-8B29-8238CF9B7513@gmail.com>
References: <20240706154840.39503-1-krashmisha@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3774.600.62)
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=krashmisha@gmail.com; helo=mail-lj1-x234.google.com
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


> 6 =D0=B8=D1=8E=D0=BB=D1=8F 2024=E2=80=AF=D0=B3., =D0=B2 18:48, Mikhail =
Krasheninnikov <krashmisha@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BB(=D0=B0):
>=20
> From: Mi <krashmisha@gmail.com>
>=20
> Add a Virtio backend for SD/MMC devices. Confirmed interoperability =
with
> Linux.
>=20
> Linux patch link: =
https://lore.kernel.org/linux-mmc/20240701120642.30001-1-krashmisha@gmail.=
com/
>=20
> Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
> CC: Matwey Kornilov <matwey.kornilov@gmail.com>
> CC: qemu-block@nongnu.org
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>=20
> Changes from v3:
> - Many structs were moved to uapi in kernel patch (new link would be
>   sent as response to this letter). This patch integrates them.
> - Since there's no corresponding patch to Virtio specification yet,
>   this patch is marked as RFC.
>=20
> hw/block/Kconfig                              |   6 +
> hw/block/meson.build                          |   1 +
> hw/block/virtio-sdhci.c                       | 142 ++++++++++++++++++
> hw/virtio/meson.build                         |   1 +
> hw/virtio/virtio-sdhci-pci.c                  |  86 +++++++++++
> hw/virtio/virtio.c                            |   3 +-
> include/hw/virtio/virtio-sdhci.h              |  22 +++
> include/standard-headers/linux/virtio_ids.h   |   1 +
> include/standard-headers/linux/virtio_sdhci.h |  39 +++++
> 9 files changed, 300 insertions(+), 1 deletion(-)
> create mode 100644 hw/block/virtio-sdhci.c
> create mode 100644 hw/virtio/virtio-sdhci-pci.c
> create mode 100644 include/hw/virtio/virtio-sdhci.h
> create mode 100644 include/standard-headers/linux/virtio_sdhci.h
>=20
> diff --git a/hw/block/Kconfig b/hw/block/Kconfig
> index 9e8f28f982..5b5363da01 100644
> --- a/hw/block/Kconfig
> +++ b/hw/block/Kconfig
> @@ -44,3 +44,9 @@ config VHOST_USER_BLK
>=20
> config SWIM
>     bool
> +
> +config VIRTIO_SDHCI
> +    bool
> +    default y
> +    select SD
> +    depends on VIRTIO
> diff --git a/hw/block/meson.build b/hw/block/meson.build
> index 8aa4dc3893..82356c264e 100644
> --- a/hw/block/meson.build
> +++ b/hw/block/meson.build
> @@ -19,5 +19,6 @@ system_ss.add(when: 'CONFIG_TC58128', if_true: =
files('tc58128.c'))
>=20
> specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: =
files('virtio-blk.c', 'virtio-blk-common.c'))
> specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: =
files('vhost-user-blk.c', 'virtio-blk-common.c'))
> +specific_ss.add(when: 'CONFIG_VIRTIO_SDHCI', if_true: =
files('virtio-sdhci.c'))
>=20
> subdir('dataplane')
> diff --git a/hw/block/virtio-sdhci.c b/hw/block/virtio-sdhci.c
> new file mode 100644
> index 0000000000..d3a90f7b5a
> --- /dev/null
> +++ b/hw/block/virtio-sdhci.c
> @@ -0,0 +1,142 @@
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-sdhci.h"
> +#include "qemu/typedefs.h"
> +#include "sysemu/blockdev.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_sdhci.h"
> +
> +static void send_command(SDBus *sdbus, struct mmc_req *mmc_request, =
uint8_t *response,
> +                         struct virtio_mmc_response *virtio_resp)
> +{
> +    SDRequest sdreq;
> +    int resp_len;
> +
> +    sdreq.cmd =3D (uint8_t)mmc_request->opcode;
> +    sdreq.arg =3D mmc_request->arg;
> +    resp_len =3D sdbus_do_command(sdbus, &sdreq, response);
> +    virtio_resp->cmd_resp_len =3D resp_len;
> +
> +    for (int i =3D 0; i < resp_len / sizeof(__le32); i++) {
> +        virtio_resp->cmd_resp[i] =3D =
ldl_be_p(&virtio_resp->cmd_resp[i]);
> +    }
> +}
> +
> +static void send_command_without_response(SDBus *sdbus, struct =
mmc_req *mmc_request)
> +{
> +    SDRequest sdreq;
> +    uint8_t response[4];
> +
> +    sdreq.cmd =3D (uint8_t)mmc_request->opcode;
> +    sdreq.arg =3D mmc_request->arg;
> +    sdbus_do_command(sdbus, &sdreq, response);
> +}
> +
> +static void handle_mmc_request(VirtIODevice *vdev, struct =
virtio_mmc_request *virtio_req,
> +                               struct virtio_mmc_response =
*virtio_resp)
> +{
> +    VirtIOSDHCI *vsd =3D VIRTIO_SDHCI(vdev);
> +    SDBus *sdbus =3D &vsd->sdbus;
> +
> +    if (virtio_req->flags & VIRTIO_MMC_REQUEST_SBC) {
> +        send_command_without_response(sdbus, &virtio_req->sbc_req);
> +    }
> +
> +    send_command(sdbus, &virtio_req->request,
> +    (uint8_t *)virtio_resp->cmd_resp, virtio_resp);
> +
> +    if (virtio_req->flags & VIRTIO_MMC_REQUEST_DATA) {
> +        if (virtio_req->flags & VIRTIO_MMC_REQUEST_WRITE) {
> +            sdbus_write_data(sdbus, virtio_req->buf, =
virtio_req->buf_len);
> +        } else {
> +            sdbus_read_data(sdbus, virtio_resp->buf, =
virtio_req->buf_len);
> +        }
> +    }
> +
> +    if (virtio_req->flags & VIRTIO_MMC_REQUEST_STOP) {
> +        send_command_without_response(sdbus, &virtio_req->stop_req);
> +    }
> +}
> +
> +static void handle_request(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem;
> +    struct virtio_mmc_request virtio_req;
> +    struct virtio_mmc_response virtio_resp;
> +
> +    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +
> +    iov_to_buf(elem->out_sg, elem->out_num, 0,
> +    &virtio_req, sizeof(struct virtio_mmc_request));
> +
> +    handle_mmc_request(vdev, &virtio_req, &virtio_resp);
> +
> +    iov_from_buf(elem->in_sg, elem->in_num, 0,
> +    &virtio_resp, sizeof(struct virtio_mmc_response));
> +
> +    virtqueue_push(vq, elem, 1);
> +
> +    virtio_notify(vdev, vq);
> +}
> +
> +static void virtio_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOSDHCI *vsd =3D VIRTIO_SDHCI(dev);
> +
> +    virtio_init(vdev, VIRTIO_ID_SDHCI, 0);
> +
> +    vsd->vq =3D virtio_add_queue(vdev, 1, handle_request);
> +
> +    BlockBackend *blk =3D vsd->blk;
> +    if (!blk) {
> +        error_setg(errp, "Block backend not found");
> +        return;
> +    }
> +
> +    qbus_init(&vsd->sdbus, sizeof(vsd->sdbus), TYPE_SD_BUS, dev, =
"sd-bus");
> +    DeviceState *card =3D qdev_new(TYPE_SD_CARD);
> +    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
> +    qdev_realize_and_unref(card,
> +    qdev_get_child_bus(dev, "sd-bus"), &error_fatal);
> +}
> +
> +static void virtio_sdhci_unrealize(DeviceState *dev)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    virtio_cleanup(vdev);
> +}
> +
> +static uint64_t virtio_sdhci_get_features(VirtIODevice *vdev,
> +                                          uint64_t features, Error =
**errp)
> +{
> +    return features;
> +}
> +
> +static void virtio_sdhci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioDeviceClass *k =3D VIRTIO_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +
> +    k->realize =3D virtio_sdhci_realize;
> +    k->unrealize =3D virtio_sdhci_unrealize;
> +    k->get_features =3D virtio_sdhci_get_features;
> +}
> +
> +static const TypeInfo virtio_sdhci_info =3D {
> +    .name =3D TYPE_VIRTIO_SDHCI,
> +    .parent =3D TYPE_VIRTIO_DEVICE,
> +    .instance_size =3D sizeof(VirtIOSDHCI),
> +    .class_init =3D virtio_sdhci_class_init,
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&virtio_sdhci_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 47baf00366..c7a8707ba6 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -68,6 +68,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', =
if_true: files('virtio-iommu-pci.
> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: =
files('virtio-mem-pci.c'))
> virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: =
files('vdpa-dev-pci.c'))
> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: =
files('virtio-md-pci.c'))
> +virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SDHCI', if_true: =
files('virtio-sdhci-pci.c'))
>=20
> specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: =
virtio_pci_ss)
>=20
> diff --git a/hw/virtio/virtio-sdhci-pci.c =
b/hw/virtio/virtio-sdhci-pci.c
> new file mode 100644
> index 0000000000..889352f577
> --- /dev/null
> +++ b/hw/virtio/virtio-sdhci-pci.c
> @@ -0,0 +1,86 @@
> +#include "qemu/osdep.h"
> +
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-sdhci.h"
> +#include "hw/qdev-properties-system.h"
> +#include "qemu/typedefs.h"
> +#include "qapi/error.h"
> +#include "sysemu/block-backend-global-state.h"
> +
> +typedef struct VirtIOSDHCIPCI VirtIOSDHCIPCI;
> +
> +/*
> + * virtio-mmc-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_SDHCI_PCI "virtio-sdhci-pci-base"
> +DECLARE_INSTANCE_CHECKER(VirtIOSDHCIPCI, VIRTIO_SDHCI_PCI,
> +                         TYPE_VIRTIO_SDHCI_PCI)
> +
> +struct VirtIOSDHCIPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOSDHCI vdev;
> +    BlockBackend *blk;
> +};
> +
> +static void virtio_sdhci_pci_realize(VirtIOPCIProxy *vpci_dev, Error =
**errp)
> +{
> +    VirtIOSDHCIPCI *vsd =3D VIRTIO_SDHCI_PCI(vpci_dev);
> +    DeviceState *dev =3D DEVICE(&vsd->vdev);
> +    VirtIOSDHCI *vsd_dev;
> +
> +    if (!vsd->blk) {
> +        error_setg(errp, "Drive property not set");
> +        return;
> +    }
> +    vsd_dev =3D &vsd->vdev;
> +    vsd_dev->blk =3D vsd->blk;
> +    blk_detach_dev(vsd->blk, DEVICE(vpci_dev));
> +
> +    qdev_set_parent_bus(dev, BUS(&vpci_dev->bus), errp);
> +
> +    virtio_pci_force_virtio_1(vpci_dev);
> +    object_property_set_bool(OBJECT(dev), "realized", true, errp);
> +}
> +
> +static Property virtio_sdhci_properties[] =3D {
> +    DEFINE_PROP_DRIVE("drive", VirtIOSDHCIPCI, blk),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_sdhci_pci_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    VirtioPCIClass *virtio_pci_class =3D VIRTIO_PCI_CLASS(oc);
> +    PCIDeviceClass *pci_device_class =3D PCI_DEVICE_CLASS(oc);
> +
> +    device_class_set_props(dc, virtio_sdhci_properties);
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +
> +    virtio_pci_class->realize =3D virtio_sdhci_pci_realize;
> +
> +    pci_device_class->revision =3D VIRTIO_PCI_ABI_VERSION;
> +    pci_device_class->class_id =3D PCI_CLASS_MEMORY_FLASH;
> +}
> +
> +static void virtio_sdhci_pci_instance_init(Object *obj)
> +{
> +    VirtIOSDHCIPCI *dev =3D VIRTIO_SDHCI_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_SDHCI);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_sdhci_pci_info =3D {
> +    .base_name     =3D TYPE_VIRTIO_SDHCI_PCI,
> +    .generic_name  =3D "virtio-sdhci-pci",
> +    .instance_size =3D sizeof(VirtIOSDHCIPCI),
> +    .class_init    =3D virtio_sdhci_pci_class_init,
> +    .instance_init =3D virtio_sdhci_pci_instance_init,
> +};
> +
> +static void virtio_sdhci_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_sdhci_pci_info);
> +}
> +
> +type_init(virtio_sdhci_pci_register)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 7549094154..90a346dfc0 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -193,7 +193,8 @@ const char *virtio_device_names[] =3D {
>     [VIRTIO_ID_PARAM_SERV] =3D "virtio-param-serv",
>     [VIRTIO_ID_AUDIO_POLICY] =3D "virtio-audio-pol",
>     [VIRTIO_ID_BT] =3D "virtio-bluetooth",
> -    [VIRTIO_ID_GPIO] =3D "virtio-gpio"
> +    [VIRTIO_ID_GPIO] =3D "virtio-gpio",
> +    [VIRTIO_ID_SDHCI] =3D "virtio-sdhci",
> };
>=20
> static const char *virtio_id_to_name(uint16_t device_id)
> diff --git a/include/hw/virtio/virtio-sdhci.h =
b/include/hw/virtio/virtio-sdhci.h
> new file mode 100644
> index 0000000000..0d91f4a973
> --- /dev/null
> +++ b/include/hw/virtio/virtio-sdhci.h
> @@ -0,0 +1,22 @@
> +#ifndef QEMU_VIRTIO_SDHCI_H
> +#define QEMU_VIRTIO_SDHCI_H
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/sd/sd.h"
> +#include "qemu/typedefs.h"
> +
> +#define TYPE_VIRTIO_SDHCI "virtio-sdhci-device"
> +#define VIRTIO_SDHCI(obj) \
> +    OBJECT_CHECK(VirtIOSDHCI, (obj), TYPE_VIRTIO_SDHCI)
> +#define VIRTIO_SDHCI_GET_PARENT_CLASS(obj) \
> +    OBJECT_GET_PARENT_CLASS(VIRTIO_SDHCI(obj), TYPE_VIRTIO_SDHCI)
> +
> +typedef struct VirtIOSDHCI {
> +    VirtIODevice parent_obj;
> +
> +    VirtQueue *vq;
> +    SDBus sdbus;
> +    BlockBackend *blk;
> +} VirtIOSDHCI;
> +
> +#endif
> diff --git a/include/standard-headers/linux/virtio_ids.h =
b/include/standard-headers/linux/virtio_ids.h
> index 7aa2eb7662..7f13999359 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
> #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio =
policy */
> #define VIRTIO_ID_BT			40 /* virtio bluetooth */
> #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_SDHCI			42 /* virtio sdhci */
>=20
> /*
>  * Virtio Transitional IDs
> diff --git a/include/standard-headers/linux/virtio_sdhci.h =
b/include/standard-headers/linux/virtio_sdhci.h
> new file mode 100644
> index 0000000000..d620441c4a
> --- /dev/null
> +++ b/include/standard-headers/linux/virtio_sdhci.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + *  VirtIO SD/MMC driver
> + *
> + *  Author: Mikhail Krasheninnikov <krashmisha@gmail.com>
> + */
> +#ifndef _LINUX_VIRTIO_MMC_H
> +#define _LINUX_VIRTIO_MMC_H
> +#include <linux/types.h>
> +
> +struct mmc_req {
> +	__le32 opcode;
> +	__le32 arg;
> +};
> +
> +struct virtio_mmc_request {
> +	uint8_t flags;
> +
> +#define VIRTIO_MMC_REQUEST_DATA BIT(1)
> +#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
> +#define VIRTIO_MMC_REQUEST_STOP BIT(3)
> +#define VIRTIO_MMC_REQUEST_SBC BIT(4)
> +
> +	struct mmc_req request;
> +
> +	uint8_t buf[4096];
> +	__le32 buf_len;
> +
> +	struct mmc_req stop_req;
> +	struct mmc_req sbc_req;
> +};
> +
> +struct virtio_mmc_response {
> +	__le32 cmd_resp[4];
> +	int cmd_resp_len;
> +	uint8_t buf[4096];
> +};
> +
> +#endif /* _LINUX_VIRTIO_MMC_H */
> --=20
> 2.34.1
>=20

Link to the linux patch:=20
=
https://lore.kernel.org/linux-mmc/20240707160555.78062-1-krashmisha@gmail.=
com/T/#u=

