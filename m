Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F83ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 08:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snwPp-0002xV-4O; Tue, 10 Sep 2024 04:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1snwPn-0002wv-Ih
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 04:39:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1snwPk-00012C-RI
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 04:39:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A45unY020319;
 Tue, 10 Sep 2024 08:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0J91xjAqynBlwXPr0KMbeXawaTK9hXuLki8RMYQDPXE=; b=py3mE4WpGbE1Bezc
 fV+ydcRUwNBRqYIPc5QR/Ki8GDJVs4nf93gzIT/AW6GBR3X78RO4Of0NP4CYOFq0
 HUVJA0SSdhq2HGbEI1Us8okHShvri6xoCaOdTuxf6I9lVdA4I7llcF1c5Rli1Lwf
 KZnBoaReqOCA0qMlSqgjl6kOv3smvPISFnX0IDhOtirrCJySQ8Byz+VVKZxRz/cv
 HI7hI7guM5++77MH3NeFYkl2BOfv6GDgCH7lEqPJe0qL1iK0UG71u6Z4aYCOX84c
 y/qQEl8qN4pDerwLEtakUpxkY3ns9KPMRlPzDokjlVCSXIJwKVi4WqsCJx7+4bq+
 PKdykg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41he5dvfgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Sep 2024 08:39:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48A8dp4S011489
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Sep 2024 08:39:51 GMT
Received: from [10.233.23.41] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Sep
 2024 01:39:49 -0700
Message-ID: <20570bfd-72b6-454f-abf1-7ca308c96b8c@quicinc.com>
Date: Tue, 10 Sep 2024 16:39:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add vhost-user-spi and vhost-user-spi-pci devices
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
CC: <qemu-devel@nongnu.org>, <viresh.kumar@linaro.org>, <quic_ztu@quicinc.com>,
 <quic_tsoni@quicinc.com>
References: <20240712034246.2553812-1-quic_haixcui@quicinc.com>
 <8734mp6g81.fsf@draig.linaro.org>
 <944cb43a-e578-4102-9d8d-8cea475455f0@quicinc.com>
 <87v7zecqeh.fsf@draig.linaro.org>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <87v7zecqeh.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: mRelhFH_-njVy5BH7bzLvJNpz34yNpAm
X-Proofpoint-GUID: mRelhFH_-njVy5BH7bzLvJNpz34yNpAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 9/2/2024 6:15 PM, Alex Bennée wrote:
> Haixu Cui <quic_haixcui@quicinc.com> writes:
> 
>> Hi Alex,
>>      Thanks a lot for your comments, please refer to my response below.
>>
>> On 8/28/2024 1:14 AM, Alex Bennée wrote:
>>> Haixu Cui <quic_haixcui@quicinc.com> writes:
>>> Apologies for the delay in getting to this.
>>>
>>>> This work is based on the virtio-spi spec, virtio-spi driver introduced by
>>>> the following patch series:
>>>> - https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4/device-types/spi
>>>> - https://lwn.net/Articles/966715/
>>>>
>>>> To test with rust-vmm vhost-user-spi daemon, start the vhost-daemon firstly:
>>>>       vhost-device-spi --socket-path=vspi.sock --socket-count=1 --device "/dev/spidev0.0"
>>> I'm struggling to test this on my main dev box. Are there any dummy
>>> SPI
>>> modules for the kernel for testing? Otherwise we could consider
>>> implementing something similar to "mock_gpio" for the rust-vmm
>>> vhost-user-spi backend?
>>
>> I verified this on my board with physical SPI interface, and I don't
>> know if these is dummy SPI module available in kernel. I'll look into
>> this.
> 
> I'll see if I can boot full Linux into a QEMU machine with SPI devices
> which would be another approach.
> 

Great idea.

>>>
>>>> Then invoke qemu with the following parameters:
>>>>       qemu-system-aarch64 -m 1G \
>>>>           -chardev socket,path=/home/root/vspi.sock0,id=vspi \
>>>>           -device vhost-user-spi-pci,chardev=vspi,id=spi \
>>>>           -object memory-backend-file,id=mem,size=1G,mem-path=/dev/shm,share=on \
>>>>           -numa node,memdev=mem
>>>>           ...
>>>
>>>>
>>>> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>>>> ---
>>>>    hw/virtio/Kconfig                           |   5 +
>>>>    hw/virtio/meson.build                       |   3 +
>>>>    hw/virtio/vhost-user-spi-pci.c              |  69 ++++++++
>>>>    hw/virtio/vhost-user-spi.c                  |  66 +++++++
>>>>    hw/virtio/virtio.c                          |   4 +-
>>>>    include/hw/virtio/vhost-user-spi.h          |  25 +++
>>>>    include/standard-headers/linux/virtio_ids.h |   1 +
>>>>    include/standard-headers/linux/virtio_spi.h | 186 ++++++++++++++++++++
>>>>    8 files changed, 358 insertions(+), 1 deletion(-)
>>>>    create mode 100644 hw/virtio/vhost-user-spi-pci.c
>>>>    create mode 100644 hw/virtio/vhost-user-spi.c
>>>>    create mode 100644 include/hw/virtio/vhost-user-spi.h
>>>>    create mode 100644 include/standard-headers/linux/virtio_spi.h
>>> Generally we want separate headers patches for the importing of
>>> headers.
>>> Doubly so in this case because I can't see the SPI definitions in the
>>> current Linux master. So:
>>>     - 1/2 - Import headers for SPI (!merge until upstream)
>>>     - 2/2 - Implement vhost-user stub for virtio-spi
>>>
>>
>> Should I move only virtio_spi.h to the first patch, or all of the
>> header files? I don't quite understand here.
> 
> Just the kernel headers (include/standard-headers). You should import
> the kernel headers from a checked out kernel tree using:
> 
>    ./scripts/update-linux-headers.sh <path/to/linux.git>
> 
> and save them as a single commit for the 1st patch. As the SPI code is
> not yet upstream just make it clear in the commit to avoid merging. e.g.
> 
>    linux-headers: update to 6.10-rc5 + SPI patches (!merge)
> 
>    This imports the headers from the current Linux HEAD + the VirtIO SPI
>    patches which are not yet upstream. Once the SPI work is up-streamed in
>    the kernel they will be imported from there.
> 
> Just make sure you kernel base is newer than the last import otherwise
> you will get a lot of additional noise.
> 

Thank you so much for your guidance, I'll generate header file based on 
6.11-rc7, the latest version.

BR & Thanks

>>
>> Best Regards
>> Thanks
>>>
>>>>
>>>> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
>>>> index aa63ff7fd4..d5857651e5 100644
>>>> --- a/hw/virtio/Kconfig
>>>> +++ b/hw/virtio/Kconfig
>>>> @@ -110,3 +110,8 @@ config VHOST_USER_SCMI
>>>>        bool
>>>>        default y
>>>>        depends on VIRTIO && VHOST_USER
>>>> +
>>>> +config VHOST_USER_SPI
>>>> +    bool
>>>> +    default y
>>>> +    depends on VIRTIO && VHOST_USER
>>>> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>>>> index 621fc65454..42296219e5 100644
>>>> --- a/hw/virtio/meson.build
>>>> +++ b/hw/virtio/meson.build
>>>> @@ -26,6 +26,7 @@ if have_vhost
>>>>        system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
>>>>        system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
>>>>        system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
>>>> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files('vhost-user-spi.c'))
>>>>          # PCI Stubs
>>>>        system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
>>>> @@ -39,6 +40,8 @@ if have_vhost
>>>>                             if_true: files('vhost-user-snd-pci.c'))
>>>>        system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_INPUT'],
>>>>                             if_true: files('vhost-user-input-pci.c'))
>>>> +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
>>>> +                         if_true: files('vhost-user-spi-pci.c'))
>>>>      endif
>>>>      if have_vhost_vdpa
>>>>        system_virtio_ss.add(files('vhost-vdpa.c'))
>>>> diff --git a/hw/virtio/vhost-user-spi-pci.c b/hw/virtio/vhost-user-spi-pci.c
>>>> new file mode 100644
>>>> index 0000000000..3565d526af
>>>> --- /dev/null
>>>> +++ b/hw/virtio/vhost-user-spi-pci.c
>>>> @@ -0,0 +1,69 @@
>>>> +/*
>>>> + * Vhost-user spi virtio device PCI glue
>>>> + *
>>>> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/qdev-properties.h"
>>>> +#include "hw/virtio/vhost-user-spi.h"
>>>> +#include "hw/virtio/virtio-pci.h"
>>>> +
>>>> +struct VHostUserSPIPCI {
>>>> +    VirtIOPCIProxy parent_obj;
>>>> +    VHostUserSPI vdev;
>>>> +};
>>>> +
>>>> +typedef struct VHostUserSPIPCI VHostUserSPIPCI;
>>>> +
>>>> +#define TYPE_VHOST_USER_SPI_PCI "vhost-user-spi-pci-base"
>>>> +
>>>> +DECLARE_INSTANCE_CHECKER(VHostUserSPIPCI, VHOST_USER_SPI_PCI,
>>>> +                         TYPE_VHOST_USER_SPI_PCI)
>>>> +
>>>> +static void vhost_user_spi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>>>> +{
>>>> +    VHostUserSPIPCI *dev = VHOST_USER_SPI_PCI(vpci_dev);
>>>> +    DeviceState *vdev = DEVICE(&dev->vdev);
>>>> +
>>>> +    vpci_dev->nvectors = 1;
>>>> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>>>> +}
>>>> +
>>>> +static void vhost_user_spi_pci_class_init(ObjectClass *klass, void *data)
>>>> +{
>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
>>>> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>>>> +    k->realize = vhost_user_spi_pci_realize;
>>>> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>>> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
>>>> +    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
>>>> +    pcidev_k->revision = 0x00;
>>>> +    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
>>>> +}
>>>> +
>>>> +static void vhost_user_spi_pci_instance_init(Object *obj)
>>>> +{
>>>> +    VHostUserSPIPCI *dev = VHOST_USER_SPI_PCI(obj);
>>>> +
>>>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>>>> +                                TYPE_VHOST_USER_SPI);
>>>> +}
>>>> +
>>>> +static const VirtioPCIDeviceTypeInfo vhost_user_spi_pci_info = {
>>>> +    .base_name = TYPE_VHOST_USER_SPI_PCI,
>>>> +    .non_transitional_name = "vhost-user-spi-pci",
>>>> +    .instance_size = sizeof(VHostUserSPIPCI),
>>>> +    .instance_init = vhost_user_spi_pci_instance_init,
>>>> +    .class_init = vhost_user_spi_pci_class_init,
>>>> +};
>>>> +
>>>> +static void vhost_user_spi_pci_register(void)
>>>> +{
>>>> +    virtio_pci_types_register(&vhost_user_spi_pci_info);
>>>> +}
>>>> +
>>>> +type_init(vhost_user_spi_pci_register);
>>>> diff --git a/hw/virtio/vhost-user-spi.c b/hw/virtio/vhost-user-spi.c
>>>> new file mode 100644
>>>> index 0000000000..e138b8b53b
>>>> --- /dev/null
>>>> +++ b/hw/virtio/vhost-user-spi.c
>>>> @@ -0,0 +1,66 @@
>>>> +/*
>>>> + * Vhost-user spi virtio device
>>>> + *
>>>> + * Copyright(c) 2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qapi/error.h"
>>>> +#include "hw/qdev-properties.h"
>>>> +#include "hw/virtio/virtio-bus.h"
>>>> +#include "hw/virtio/vhost-user-spi.h"
>>>> +#include "qemu/error-report.h"
>>>> +#include "standard-headers/linux/virtio_ids.h"
>>>> +#include "standard-headers/linux/virtio_spi.h"
>>>> +
>>>> +static Property vspi_properties[] = {
>>>> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
>>>> +    DEFINE_PROP_END_OF_LIST(),
>>>> +};
>>>> +
>>>> +static void vspi_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    VHostUserBase *vub = VHOST_USER_BASE(dev);
>>>> +    VHostUserBaseClass *vubc = VHOST_USER_BASE_GET_CLASS(dev);
>>>> +
>>>> +    /* Fixed for SPI */
>>>> +    vub->virtio_id = VIRTIO_ID_SPI;
>>>> +    vub->num_vqs = 1;
>>>> +    vub->vq_size = 4;
>>>> +    vub->config_size = sizeof(struct virtio_spi_config);
>>>> +
>>>> +    vubc->parent_realize(dev, errp);
>>>> +}
>>>> +
>>>> +static const VMStateDescription vu_spi_vmstate = {
>>>> +    .name = "vhost-user-spi",
>>>> +    .unmigratable = 1,
>>>> +};
>>>> +
>>>> +static void vu_spi_class_init(ObjectClass *klass, void *data)
>>>> +{
>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>> +    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
>>>> +
>>>> +    dc->vmsd = &vu_spi_vmstate;
>>>> +    device_class_set_props(dc, vspi_properties);
>>>> +    device_class_set_parent_realize(dc, vspi_realize,
>>>> +                                    &vubc->parent_realize);
>>>> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>>> +}
>>>> +
>>>> +static const TypeInfo vu_spi_info = {
>>>> +    .name = TYPE_VHOST_USER_SPI,
>>>> +    .parent = TYPE_VHOST_USER_BASE,
>>>> +    .instance_size = sizeof(VHostUserSPI),
>>>> +    .class_init = vu_spi_class_init,
>>>> +};
>>>> +
>>>> +static void vu_spi_register_types(void)
>>>> +{
>>>> +    type_register_static(&vu_spi_info);
>>>> +}
>>>> +
>>>> +type_init(vu_spi_register_types)
>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>> index 583a224163..689e2e21e7 100644
>>>> --- a/hw/virtio/virtio.c
>>>> +++ b/hw/virtio/virtio.c
>>>> @@ -46,6 +46,7 @@
>>>>    #include "standard-headers/linux/virtio_iommu.h"
>>>>    #include "standard-headers/linux/virtio_mem.h"
>>>>    #include "standard-headers/linux/virtio_vsock.h"
>>>> +#include "standard-headers/linux/virtio_spi.h"
>>>>      /*
>>>>     * Maximum size of virtio device config space
>>>> @@ -194,7 +195,8 @@ const char *virtio_device_names[] = {
>>>>        [VIRTIO_ID_PARAM_SERV] = "virtio-param-serv",
>>>>        [VIRTIO_ID_AUDIO_POLICY] = "virtio-audio-pol",
>>>>        [VIRTIO_ID_BT] = "virtio-bluetooth",
>>>> -    [VIRTIO_ID_GPIO] = "virtio-gpio"
>>>> +    [VIRTIO_ID_GPIO] = "virtio-gpio",
>>>> +    [VIRTIO_ID_SPI] = "virtio-spi"
>>>>    };
>>> For the vhost-user-stub bits when split from the headers:
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>
> 

