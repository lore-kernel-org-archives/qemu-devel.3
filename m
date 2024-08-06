Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F51FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 03:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbAxZ-00017M-DJ; Mon, 05 Aug 2024 23:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1sbAxX-00016r-RV
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 23:34:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1sbAxV-000789-1o
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 23:34:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475IpLp5026195;
 Tue, 6 Aug 2024 03:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7yES8P5leOBP+roRwPgb+j5WgnCVD3BWSykBuKu/5DQ=; b=nDcFR54yzuKgxr9k
 hokLZvxi1u3N7Z8CNIeWsJrH40IEmTI5wCS30jYEoVCKObZKOblypPXoTvhxaNBg
 siOCEfjwwECns1EWg5uXaLQlHQ1ZJHhfdLv7Xfrjhib18XYqGNU+v3bs6GA8GcgY
 DV9W7QJhOEl/ir5no/oiC0MLC4sw/ymrWBQVkEV3TaOC+oAUIV8Tatd3U4kUzdo+
 qahb4IyJKX24jWbAGeJxqlXiJiTHwXLFRyEyuwYF19FFlYiIAbG+pG+69PHe+1xs
 HSdrHnykhA9hwPCIAgaaIBvPkEv4aQpOaWcgf6Nso0nYn/l+IjK8ygfzUignk72A
 91W0dQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40u4cpgvrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 03:33:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4763XsET004646
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 6 Aug 2024 03:33:54 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 20:33:53 -0700
Message-ID: <add1bc2f-0b9a-4124-bc5c-5352f011b91c@quicinc.com>
Date: Tue, 6 Aug 2024 11:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add vhost-user-spi and vhost-user-spi-pci devices
To: <qemu-devel@nongnu.org>, <viresh.kumar@linaro.org>,
 <alex.bennee@linaro.org>
CC: <quic_ztu@quicinc.com>, <quic_tsoni@quicinc.com>
References: <20240712034246.2553812-1-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20240712034246.2553812-1-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: aR5Zs27r_4WcjwEb9f-56-WwXyUw2iTt
X-Proofpoint-GUID: aR5Zs27r_4WcjwEb9f-56-WwXyUw2iTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_02,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408060023
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi,

     Can anyone please review the patch? Thank you so much.

Best Regards
Haixu Cui

On 7/12/2024 11:42 AM, Haixu Cui wrote:
> This work is based on the virtio-spi spec, virtio-spi driver introduced by
> the following patch series:
> - https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4/device-types/spi
> - https://lwn.net/Articles/966715/
> 
> To test with rust-vmm vhost-user-spi daemon, start the vhost-daemon firstly:
>      vhost-device-spi --socket-path=vspi.sock --socket-count=1 --device "/dev/spidev0.0"
> 
> Then invoke qemu with the following parameters:
>      qemu-system-aarch64 -m 1G \
>          -chardev socket,path=/home/root/vspi.sock0,id=vspi \
>          -device vhost-user-spi-pci,chardev=vspi,id=spi \
>          -object memory-backend-file,id=mem,size=1G,mem-path=/dev/shm,share=on \
>          -numa node,memdev=mem
>          ...
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>   hw/virtio/Kconfig                           |   5 +
>   hw/virtio/meson.build                       |   3 +
>   hw/virtio/vhost-user-spi-pci.c              |  69 ++++++++
>   hw/virtio/vhost-user-spi.c                  |  66 +++++++
>   hw/virtio/virtio.c                          |   4 +-
>   include/hw/virtio/vhost-user-spi.h          |  25 +++
>   include/standard-headers/linux/virtio_ids.h |   1 +
>   include/standard-headers/linux/virtio_spi.h | 186 ++++++++++++++++++++
>   8 files changed, 358 insertions(+), 1 deletion(-)
>   create mode 100644 hw/virtio/vhost-user-spi-pci.c
>   create mode 100644 hw/virtio/vhost-user-spi.c
>   create mode 100644 include/hw/virtio/vhost-user-spi.h
>   create mode 100644 include/standard-headers/linux/virtio_spi.h
> 
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index aa63ff7fd4..d5857651e5 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -110,3 +110,8 @@ config VHOST_USER_SCMI
>       bool
>       default y
>       depends on VIRTIO && VHOST_USER
> +
> +config VHOST_USER_SPI
> +    bool
> +    default y
> +    depends on VIRTIO && VHOST_USER
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 621fc65454..42296219e5 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -26,6 +26,7 @@ if have_vhost
>       system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
>       system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
>       system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files('vhost-user-spi.c'))
>   
>       # PCI Stubs
>       system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
> @@ -39,6 +40,8 @@ if have_vhost
>                            if_true: files('vhost-user-snd-pci.c'))
>       system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_INPUT'],
>                            if_true: files('vhost-user-input-pci.c'))
> +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
> +                         if_true: files('vhost-user-spi-pci.c'))
>     endif
>     if have_vhost_vdpa
>       system_virtio_ss.add(files('vhost-vdpa.c'))
> diff --git a/hw/virtio/vhost-user-spi-pci.c b/hw/virtio/vhost-user-spi-pci.c
> new file mode 100644
> index 0000000000..3565d526af
> --- /dev/null
> +++ b/hw/virtio/vhost-user-spi-pci.c
> @@ -0,0 +1,69 @@
> +/*
> + * Vhost-user spi virtio device PCI glue
> + *
> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/vhost-user-spi.h"
> +#include "hw/virtio/virtio-pci.h"
> +
> +struct VHostUserSPIPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VHostUserSPI vdev;
> +};
> +
> +typedef struct VHostUserSPIPCI VHostUserSPIPCI;
> +
> +#define TYPE_VHOST_USER_SPI_PCI "vhost-user-spi-pci-base"
> +
> +DECLARE_INSTANCE_CHECKER(VHostUserSPIPCI, VHOST_USER_SPI_PCI,
> +                         TYPE_VHOST_USER_SPI_PCI)
> +
> +static void vhost_user_spi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VHostUserSPIPCI *dev = VHOST_USER_SPI_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    vpci_dev->nvectors = 1;
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +}
> +
> +static void vhost_user_spi_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +    k->realize = vhost_user_spi_pci_realize;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
> +    pcidev_k->revision = 0x00;
> +    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
> +}
> +
> +static void vhost_user_spi_pci_instance_init(Object *obj)
> +{
> +    VHostUserSPIPCI *dev = VHOST_USER_SPI_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_USER_SPI);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vhost_user_spi_pci_info = {
> +    .base_name = TYPE_VHOST_USER_SPI_PCI,
> +    .non_transitional_name = "vhost-user-spi-pci",
> +    .instance_size = sizeof(VHostUserSPIPCI),
> +    .instance_init = vhost_user_spi_pci_instance_init,
> +    .class_init = vhost_user_spi_pci_class_init,
> +};
> +
> +static void vhost_user_spi_pci_register(void)
> +{
> +    virtio_pci_types_register(&vhost_user_spi_pci_info);
> +}
> +
> +type_init(vhost_user_spi_pci_register);
> diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
> new file mode 100644
> index 0000000000..e138b8b53b
> --- /dev/null
> +++ b/hw/virtio/vhost-user-spi.c
> @@ -0,0 +1,66 @@
> +/*
> + * Vhost-user spi virtio device
> + *
> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/vhost-user-spi.h"
> +#include "qemu/error-report.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_spi.h"
> +
> +static Property vspi_properties[] = {
> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vspi_realize(DeviceState *dev, Error **errp)
> +{
> +    VHostUserBase *vub = VHOST_USER_BASE(dev);
> +    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
> +
> +    /* Fixed for SPI */
> +    vub->virtio_id = VIRTIO_ID_SPI;
> +    vub->num_vqs = 1;
> +    vub->vq_size = 4;
> +    vub->config_size = sizeof(struct virtio_spi_config);
> +
> +    vubc->parent_realize(dev, errp);
> +}
> +
> +static const VMStateDescription vu_spi_vmstate = {
> +    .name = "vhost-user-spi",
> +    .unmigratable = 1,
> +};
> +
> +static void vu_spi_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
> +
> +    dc->vmsd = &vu_spi_vmstate;
> +    device_class_set_props(dc, vspi_properties);
> +    device_class_set_parent_realize(dc, vspi_realize,
> +                                    &vubc->parent_realize);
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static const TypeInfo vu_spi_info = {
> +    .name = TYPE_VHOST_USER_SPI,
> +    .parent = TYPE_VHOST_USER_BASE,
> +    .instance_size = sizeof(VHostUserSPI),
> +    .class_init = vu_spi_class_init,
> +};
> +
> +static void vu_spi_register_types(void)
> +{
> +    type_register_static(&vu_spi_info);
> +}
> +
> +type_init(vu_spi_register_types)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 583a224163..689e2e21e7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -46,6 +46,7 @@
>   #include "standard-headers/linux/virtio_iommu.h"
>   #include "standard-headers/linux/virtio_mem.h"
>   #include "standard-headers/linux/virtio_vsock.h"
> +#include "standard-headers/linux/virtio_spi.h"
>   
>   /*
>    * Maximum size of virtio device config space
> @@ -194,7 +195,8 @@ const char *virtio_device_names[] = {
>       [VIRTIO_ID_PARAM_SERV] = "virtio-param-serv",
>       [VIRTIO_ID_AUDIO_POLICY] = "virtio-audio-pol",
>       [VIRTIO_ID_BT] = "virtio-bluetooth",
> -    [VIRTIO_ID_GPIO] = "virtio-gpio"
> +    [VIRTIO_ID_GPIO] = "virtio-gpio",
> +    [VIRTIO_ID_SPI] = "virtio-spi"
>   };
>   
>   static const char *virtio_id_to_name(uint16_t device_id)
> diff --git a/include/hw/virtio/vhost-user-spi.h b/include/hw/virtio/vhost-user-spi.h
> new file mode 100644
> index 0000000000..d6967d8431
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-spi.h
> @@ -0,0 +1,25 @@
> +/*
> + * Vhost-user spi virtio device
> + *
> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_VHOST_USER_SPI_H
> +#define QEMU_VHOST_USER_SPI_H
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
> +#include "hw/virtio/vhost-user-base.h"
> +
> +#define TYPE_VHOST_USER_SPI "vhost-user-spi-device"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSPI, VHOST_USER_SPI)
> +
> +struct VHostUserSPI {
> +    VHostUserBase parent_obj;
> +};
> +
> +#endif /* QEMU_VHOST_USER_SPI_H */
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 7aa2eb7662..601d387c5a 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>   #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>   #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>   #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_SPI                   45 /* virtio spi */
>   
>   /*
>    * Virtio Transitional IDs
> diff --git a/include/standard-headers/linux/virtio_spi.h b/include/standard-headers/linux/virtio_spi.h
> new file mode 100644
> index 0000000000..6631827bfa
> --- /dev/null
> +++ b/include/standard-headers/linux/virtio_spi.h
> @@ -0,0 +1,186 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
> +/*
> + * Definitions for virtio SPI Controller
> + *
> + * Copyright (c) 2021 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef _LINUX_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_SPI_H
> +
> +#include "standard-headers/linux/const.h"
> +#include "standard-headers/linux/types.h"
> +
> +/* Sample data on trailing clock edge */
> +#define VIRTIO_SPI_CPHA (1 << 0)
> +/* Clock is high when IDLE */
> +#define VIRTIO_SPI_CPOL (1 << 1)
> +/* Chip Select is active high */
> +#define VIRTIO_SPI_CS_HIGH (1 << 2)
> +/* Transmit LSB first */
> +#define VIRTIO_SPI_MODE_LSB_FIRST (1 << 3)
> +/* Loopback mode */
> +#define VIRTIO_SPI_MODE_LOOP (1 << 4)
> +
> +/*
> + * All config fields are read-only for the Virtio SPI driver
> + *
> + * @cs_max_number: maximum number of chipselect the host SPI controller
> + *   supports.
> + * @cs_change_supported: indicates if the host SPI controller supports to toggle
> + * chipselect after each transfer in one message:
> + *   0: unsupported, chipselect will be kept in active state throughout the
> + *      message transaction;
> + *   1: supported.
> + *   Note: Message here contains a sequence of SPI transfers.
> + * @tx_nbits_supported: indicates the supported number of bit for writing:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @rx_nbits_supported: indicates the supported number of bit for reading:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @bits_per_word_mask: mask indicating which values of bits_per_word are
> + *   supported. If not set, no limitation for bits_per_word.
> + * @mode_func_supported: indicates the following features are supported or not:
> + *   bit 0-1: CPHA feature
> + *     0b00: invalid, should support as least one CPHA setting
> + *     0b01: supports CPHA=0 only
> + *     0b10: supports CPHA=1 only
> + *     0b11: supports CPHA=0 and CPHA=1.
> + *   bit 2-3: CPOL feature
> + *     0b00: invalid, should support as least one CPOL setting
> + *     0b01: supports CPOL=0 only
> + *     0b10: supports CPOL=1 only
> + *     0b11: supports CPOL=0 and CPOL=1.
> + *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
> + *     supported, chipselect active low should always be supported.
> + *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
> + *     MSB first should always be supported.
> + *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
> + *     normal mode should always be supported.
> + * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
> + *   limitation for transfer speed.
> + * @max_word_delay_ns: the maximum word delay supported in ns unit,
> + *   0 means word delay feature is unsupported.
> + *   Note: Just as one message contains a sequence of transfers,
> + *         one transfer may contain a sequence of words.
> + * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   asserted.
> + * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce before chipselect
> + *   is deasserted.
> + * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   deasserted.
> + */
> +struct virtio_spi_config {
> +	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
> +        uint8_t cs_max_number;
> +        uint8_t cs_change_supported;
> +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL (1 << 0)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD (1 << 1)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL (1 << 2)
> +        uint8_t tx_nbits_supported;
> +        uint8_t rx_nbits_supported;
> +        uint32_t bits_per_word_mask;
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_0 (1 << 0)
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_1 (1 << 1)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_0 (1 << 2)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_1 (1 << 3)
> +#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH (1 << 4)
> +#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST (1 << 5)
> +#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK (1 << 6)
> +        uint32_t mode_func_supported;
> +        uint32_t max_freq_hz;
> +        uint32_t max_word_delay_ns;
> +        uint32_t max_cs_setup_ns;
> +        uint32_t max_cs_hold_ns;
> +        uint32_t max_cs_inactive_ns;
> +};
> +
> +/*
> + * @chip_select_id: chipselect index the SPI transfer used.
> + *
> + * @bits_per_word: the number of bits in each SPI transfer word.
> + *
> + * @cs_change: whether to deselect device after finishing this transfer
> + *     before starting the next transfer, 0 means cs keep asserted and
> + *     1 means cs deasserted then asserted again.
> + *
> + * @tx_nbits: bus width for write transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @rx_nbits: bus width for read transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @reserved: for future use.
> + *
> + * @mode: SPI transfer mode.
> + *     bit 0: CPHA, determines the timing (i.e. phase) of the data
> + *         bits relative to the clock pulses.For CPHA=0, the
> + *         "out" side changes the data on the trailing edge of the
> + *         preceding clock cycle, while the "in" side captures the data
> + *         on (or shortly after) the leading edge of the clock cycle.
> + *         For CPHA=1, the "out" side changes the data on the leading
> + *         edge of the current clock cycle, while the "in" side
> + *         captures the data on (or shortly after) the trailing edge of
> + *         the clock cycle.
> + *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
> + *         clock which idles at 0, and each cycle consists of a pulse
> + *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
> + *         consists of a pulse of 0.
> + *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
> + *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
> + *         first, else LSB first.
> + *     bit 4: LOOP, loopback mode.
> + *
> + * @freq: the transfer speed in Hz.
> + *
> + * @word_delay_ns: delay to be inserted between consecutive words of a
> + *     transfer, in ns unit.
> + *
> + * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
> + *     unit.
> + *
> + * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
> + *     for each transfer, in ns unit.
> + *
> + * @cs_change_delay_inactive_ns: delay to be introduced after CS is
> + *     deasserted and before next asserted, in ns unit.
> + */
> +struct spi_transfer_head {
> +        uint8_t chip_select_id;
> +        uint8_t bits_per_word;
> +        uint8_t cs_change;
> +        uint8_t tx_nbits;
> +        uint8_t rx_nbits;
> +        uint8_t reserved[3];
> +        uint32_t mode;
> +        uint32_t freq;
> +        uint32_t word_delay_ns;
> +        uint32_t cs_setup_ns;
> +        uint32_t cs_delay_hold_ns;
> +        uint32_t cs_change_delay_inactive_ns;
> +};
> +
> +struct spi_transfer_result {
> +#define VIRTIO_SPI_TRANS_OK 0
> +#define VIRTIO_SPI_PARAM_ERR 1
> +#define VIRTIO_SPI_TRANS_ERR 2
> +	uint8_t status;
> +};
> +
> +#endif /* _LINUX_VIRTIO_SPI_H */

