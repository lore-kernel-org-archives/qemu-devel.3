Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E18C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOO2E-0001PI-SM; Mon, 01 Jul 2024 16:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOO24-0001Oo-01
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOO21-0001oB-0D
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719867228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nW9suY4lBcYL4IWasTKvWNbr3EieRC5ANEBXi+/tBy4=;
 b=AwFpUYqGn/Njb+Xsk59pIDu0s+Z+CmAHRPCcNv0LfSNQo0JlkZnQO8LUefZmnPqrPDX1gt
 XXGbMCy/yKv4Hz2fpHJPyz39GsODGmculnDCLgD3T63Dv7tCNEiQS/XbOfxuiLaU3HbYHy
 7GakePuH9Ri9N4l9apQhvLXpqs2gH9E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-5YMG6JTbP5u87qL4gs9tdw-1; Mon, 01 Jul 2024 16:53:46 -0400
X-MC-Unique: 5YMG6JTbP5u87qL4gs9tdw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4256718144dso32077475e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719867225; x=1720472025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nW9suY4lBcYL4IWasTKvWNbr3EieRC5ANEBXi+/tBy4=;
 b=cS8oqnd1JIL0cDgtFPBKLtxXMN6Q6e0Ra+20MDi1Bsp8DnosBVLXeA0JG+wFRx/7rn
 hed651HDEjni3yxK9JUbfcfBzpF1+q9plxTqkF9F9MiC+Sjs5dHxU8GBOvbBISlc+j+y
 WkwagcKo3LTu0tCxUz9dK8Iw8Y2n644KIjQfeVrWowFnEDOm5jHYQYrmhP8zM1X4vVR+
 h9iregceZeJsnJ8KyUnxD1Lx9jzrhbua8QnISs6+N7/Fzdoyeqhg1QqHxP47v3qwOrdw
 pWl3sBV9KVAYdGSJuojbR5EzVf/Q+ePkqb5Z426N4JpOn9MN3jzoy4Dn6sbj+DhNh6UL
 FIaQ==
X-Gm-Message-State: AOJu0YyvgYjU2sBE4DO5ZBqv10sVblTLFpvQgkY/E4qPVGVas5HCATdS
 lmGXWTOigZv3TNAsOe3uOyAnqMiU1GaiXjZhe9pxH907kRktU0ZptQ0rdufYWexf2+qVN8gG9uH
 o3/aDh+oeElgRGBbHUrdgdOdLzok+AA9XHtV8rMAcP5/qYAi9luj8
X-Received: by 2002:a05:600c:4c95:b0:425:5e88:7133 with SMTP id
 5b1f17b1804b1-4257a0076efmr57955525e9.13.1719867225022; 
 Mon, 01 Jul 2024 13:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+YbdU8920PN4TiN9ikRkcwd2UpD7sXW1aOID5NhsM1c5hgLePQwn8pMKdROg8+I1BkoK3CQ==
X-Received: by 2002:a05:600c:4c95:b0:425:5e88:7133 with SMTP id
 5b1f17b1804b1-4257a0076efmr57955385e9.13.1719867224449; 
 Mon, 01 Jul 2024 13:53:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257c4e10d6sm95691775e9.30.2024.07.01.13.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:53:43 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:53:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikhail Krasheninnikov <krashmisha@gmail.com>
Cc: qemu-devel@nongnu.org, Matwey Kornilov <matwey.kornilov@gmail.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] virtio: Implement Virtio Backend for SD/MMC in QEMU
Message-ID: <20240701165239-mutt-send-email-mst@kernel.org>
References: <20240630134348.16830-1-krashmisha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630134348.16830-1-krashmisha@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jun 30, 2024 at 01:43:48PM +0000, Mikhail Krasheninnikov wrote:
> Add a Virtio backend for SD/MMC devices. Confirmed interoperability with
> Linux.
> 
> Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
> CC: Matwey Kornilov <matwey.kornilov@gmail.com>
> CC: qemu-block@nongnu.org
> CC: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/Kconfig                           |   5 +
>  hw/virtio/meson.build                       |   2 +
>  hw/virtio/virtio-mmc-pci.c                  |  85 ++++++++++
>  hw/virtio/virtio-mmc.c                      | 165 ++++++++++++++++++++
>  hw/virtio/virtio.c                          |   3 +-
>  include/hw/virtio/virtio-mmc.h              |  20 +++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  7 files changed, 280 insertions(+), 1 deletion(-)
>  create mode 100644 hw/virtio/virtio-mmc-pci.c
>  create mode 100644 hw/virtio/virtio-mmc.c
>  create mode 100644 include/hw/virtio/virtio-mmc.h

I don't think we want these in virtio core directory.

Where does it belong? hw/block?

And CC people that you expect to maintain this, please.

Thanks!




> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 92c9cf6c96..e5fa7607c4 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -105,3 +105,8 @@ config VHOST_USER_SCMI
>      bool
>      default y
>      depends on VIRTIO && VHOST_USER
> +
> +config VIRTIO_MMC
> +    bool
> +    default y
> +    depends on VIRTIO
> \ No newline at end of file
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 47baf00366..1ff095c5bc 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -41,6 +41,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-use
>  specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
>  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
>  specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
> +specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MMC', if_true: files('virtio-mmc.c'))
>  
>  virtio_pci_ss = ss.source_set()
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
> @@ -68,6 +69,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
> +virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MMC', if_true: files('virtio-mmc-pci.c'))
>  
>  specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
>  
> diff --git a/hw/virtio/virtio-mmc-pci.c b/hw/virtio/virtio-mmc-pci.c
> new file mode 100644
> index 0000000000..f0ed17d03b
> --- /dev/null
> +++ b/hw/virtio/virtio-mmc-pci.c
> @@ -0,0 +1,85 @@
> +#include "qemu/osdep.h"
> +
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-mmc.h"
> +#include "hw/qdev-properties-system.h"
> +#include "qemu/typedefs.h"
> +#include "qapi/error.h"
> +#include "sysemu/block-backend-global-state.h"
> +
> +typedef struct VirtIOMMCPCI VirtIOMMCPCI;
> +
> +/*
> + * virtio-mmc-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_MMC_PCI "virtio-mmc-pci-base"
> +DECLARE_INSTANCE_CHECKER(VirtIOMMCPCI, VIRTIO_MMC_PCI,
> +                         TYPE_VIRTIO_MMC_PCI)
> +
> +struct VirtIOMMCPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOMMC vdev;
> +    BlockBackend *blk;
> +};
> +
> +static void virtio_mmc_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOMMCPCI *vmmc = VIRTIO_MMC_PCI(vpci_dev);
> +    DeviceState *dev = DEVICE(&vmmc->vdev);
> +
> +    if (!vmmc->blk) {
> +        error_setg(errp, "Drive property not set");
> +        return;
> +    }
> +    VirtIOMMC *vmmc_dev = &vmmc->vdev;
> +    vmmc_dev->blk = vmmc->blk;
> +    blk_detach_dev(vmmc->blk, DEVICE(vpci_dev));
> +
> +    qdev_set_parent_bus(dev, BUS(&vpci_dev->bus), errp);
> +
> +    virtio_pci_force_virtio_1(vpci_dev);
> +    object_property_set_bool(OBJECT(dev), "realized", true, errp);
> +}
> +
> +static Property virtio_mmc_properties[] = {
> +    DEFINE_PROP_DRIVE("drive", VirtIOMMCPCI, blk),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_mmc_pci_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    VirtioPCIClass *virtio_pci_class = VIRTIO_PCI_CLASS(oc);
> +    PCIDeviceClass *pci_device_class = PCI_DEVICE_CLASS(oc);
> +
> +    device_class_set_props(dc, virtio_mmc_properties);
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +
> +    virtio_pci_class->realize = virtio_mmc_pci_realize;
> +
> +    pci_device_class->revision = VIRTIO_PCI_ABI_VERSION;
> +    pci_device_class->class_id = PCI_CLASS_MEMORY_FLASH;
> +}
> +
> +static void virtio_mmc_pci_instance_init(Object *obj)
> +{
> +    VirtIOMMCPCI *dev = VIRTIO_MMC_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_MMC);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_mmc_pci_info = {
> +    .base_name     = TYPE_VIRTIO_MMC_PCI,
> +    .generic_name  = "virtio-mmc-pci",
> +    .instance_size = sizeof(VirtIOMMCPCI),
> +    .class_init    = virtio_mmc_pci_class_init,
> +    .instance_init = virtio_mmc_pci_instance_init,
> +};
> +
> +static void virtio_mmc_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_mmc_pci_info);
> +}
> +
> +type_init(virtio_mmc_pci_register)
> diff --git a/hw/virtio/virtio-mmc.c b/hw/virtio/virtio-mmc.c
> new file mode 100644
> index 0000000000..50bd7113c5
> --- /dev/null
> +++ b/hw/virtio/virtio-mmc.c
> @@ -0,0 +1,165 @@
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-mmc.h"
> +#include "qemu/typedefs.h"
> +#include "sysemu/blockdev.h"
> +
> +typedef struct mmc_req {
> +    uint32_t opcode;
> +    uint32_t arg;
> +} mmc_req;
> +
> +typedef struct virtio_mmc_req {
> +    uint8_t flags;
> +
> +#define VIRTIO_MMC_REQUEST_DATA BIT(1)
> +#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
> +#define VIRTIO_MMC_REQUEST_STOP BIT(3)
> +#define VIRTIO_MMC_REQUEST_SBC BIT(4)
> +
> +    mmc_req request;
> +
> +    uint8_t buf[4096];
> +    size_t buf_len;
> +
> +    mmc_req stop_req;
> +    mmc_req sbc_req;
> +} virtio_mmc_req;
> +
> +typedef struct virtio_mmc_resp {
> +    uint32_t response[4];
> +    int resp_len;
> +    uint8_t buf[4096];
> +} virtio_mmc_resp;
> +
> +static void send_command(SDBus *sdbus, mmc_req *mmc_request, uint8_t *response,
> +                         virtio_mmc_resp *virtio_resp)
> +{
> +    SDRequest sdreq;
> +    sdreq.cmd = (uint8_t)mmc_request->opcode;
> +    sdreq.arg = mmc_request->arg;
> +    int resp_len = sdbus_do_command(sdbus, &sdreq, response);
> +    virtio_resp->resp_len = resp_len;
> +
> +    for (int i = 0; i < resp_len / sizeof(uint32_t); i++) {
> +        virtio_resp->response[i] = ldl_be_p(&virtio_resp->response[i]);
> +    }
> +}
> +
> +static void send_command_without_response(SDBus *sdbus, mmc_req *mmc_request)
> +{
> +    SDRequest sdreq;
> +    sdreq.cmd = (uint8_t)mmc_request->opcode;
> +    sdreq.arg = mmc_request->arg;
> +    uint8_t response[4];
> +    sdbus_do_command(sdbus, &sdreq, response);
> +}
> +
> +static void handle_mmc_request(VirtIODevice *vdev, virtio_mmc_req *virtio_req,
> +                               virtio_mmc_resp *virtio_resp)
> +{
> +    VirtIOMMC *vmmc = VIRTIO_MMC(vdev);
> +    SDBus *sdbus = &vmmc->sdbus;
> +
> +    if (virtio_req->flags & VIRTIO_MMC_REQUEST_SBC) {
> +        send_command_without_response(sdbus, &virtio_req->sbc_req);
> +    }
> +
> +    send_command(sdbus, &virtio_req->request,
> +    (uint8_t *)virtio_resp->response, virtio_resp);
> +
> +    if (virtio_req->flags & VIRTIO_MMC_REQUEST_DATA) {
> +        if (virtio_req->flags & VIRTIO_MMC_REQUEST_WRITE) {
> +            sdbus_write_data(sdbus, virtio_req->buf, virtio_req->buf_len);
> +        } else {
> +            sdbus_read_data(sdbus, virtio_resp->buf, virtio_req->buf_len);
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
> +    virtio_mmc_req virtio_req;
> +    virtio_mmc_resp virtio_resp;
> +
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +
> +    iov_to_buf(elem->out_sg, elem->out_num, 0,
> +    &virtio_req, sizeof(virtio_mmc_req));
> +
> +    handle_mmc_request(vdev, &virtio_req, &virtio_resp);
> +
> +    iov_from_buf(elem->in_sg, elem->in_num, 0,
> +    &virtio_resp, sizeof(virtio_mmc_resp));
> +
> +    virtqueue_push(vq, elem, 1);
> +
> +    virtio_notify(vdev, vq);
> +}
> +
> +static void virtio_mmc_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VirtIOMMC *vmmc = VIRTIO_MMC(dev);
> +
> +    virtio_init(vdev, VIRTIO_ID_MMC, 0);
> +
> +    vmmc->vq = virtio_add_queue(vdev, 1, handle_request);
> +
> +    BlockBackend *blk = vmmc->blk;
> +    if (!blk) {
> +        error_setg(errp, "Block backend not found");
> +        return;
> +    }
> +
> +    qbus_init(&vmmc->sdbus, sizeof(vmmc->sdbus), TYPE_SD_BUS, dev, "sd-bus");
> +    DeviceState *card = qdev_new(TYPE_SD_CARD);
> +    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
> +    qdev_realize_and_unref(card,
> +    qdev_get_child_bus(dev, "sd-bus"), &error_fatal);
> +}
> +
> +static void virtio_mmc_unrealize(DeviceState *dev)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    virtio_cleanup(vdev);
> +}
> +
> +static uint64_t virtio_mmc_get_features(VirtIODevice *vdev,
> +                                        uint64_t features, Error **errp)
> +{
> +    return features;
> +}
> +
> +static void virtio_mmc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioDeviceClass *k = VIRTIO_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +
> +    k->realize = virtio_mmc_realize;
> +    k->unrealize = virtio_mmc_unrealize;
> +    k->get_features = virtio_mmc_get_features;
> +}
> +
> +static const TypeInfo virtio_mmc_info = {
> +    .name = TYPE_VIRTIO_MMC,
> +    .parent = TYPE_VIRTIO_DEVICE,
> +    .instance_size = sizeof(VirtIOMMC),
> +    .class_init = virtio_mmc_class_init,
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&virtio_mmc_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 7549094154..35f00f06aa 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -193,7 +193,8 @@ const char *virtio_device_names[] = {
>      [VIRTIO_ID_PARAM_SERV] = "virtio-param-serv",
>      [VIRTIO_ID_AUDIO_POLICY] = "virtio-audio-pol",
>      [VIRTIO_ID_BT] = "virtio-bluetooth",
> -    [VIRTIO_ID_GPIO] = "virtio-gpio"
> +    [VIRTIO_ID_GPIO] = "virtio-gpio",
> +    [VIRTIO_ID_MMC] = "virtio-mmc",
>  };
>  
>  static const char *virtio_id_to_name(uint16_t device_id)
> diff --git a/include/hw/virtio/virtio-mmc.h b/include/hw/virtio/virtio-mmc.h
> new file mode 100644
> index 0000000000..a68f45d7cb
> --- /dev/null
> +++ b/include/hw/virtio/virtio-mmc.h
> @@ -0,0 +1,20 @@
> +#pragma once
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/sd/sd.h"
> +#include "qemu/typedefs.h"
> +
> +#define VIRTIO_ID_MMC 42
> +
> +#define TYPE_VIRTIO_MMC "virtio-mmc-device"
> +#define VIRTIO_MMC(obj) \
> +    OBJECT_CHECK(VirtIOMMC, (obj), TYPE_VIRTIO_MMC)
> +#define VIRTIO_MMC_GET_PARENT_CLASS(obj) \
> +    OBJECT_GET_PARENT_CLASS(VIRTIO_MMC(obj), TYPE_VIRTIO_MMC)
> +
> +typedef struct VirtIOMMC {
> +    VirtIODevice parent_obj;
> +    VirtQueue *vq;
> +    SDBus sdbus;
> +    BlockBackend *blk;
> +} VirtIOMMC;
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 7aa2eb7662..0c67fbf709 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_MMC			42 /* virtio mmc */
>  
>  /*
>   * Virtio Transitional IDs
> -- 
> 2.34.1


