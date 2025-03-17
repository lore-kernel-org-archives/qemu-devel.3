Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECB7C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDhm-0006qC-Vt; Mon, 17 Mar 2025 12:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuDhj-0006pF-2Y
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuDhe-00037O-Qk
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742230354;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAXbsGZdNS+8G7A18KwymoDmijmgppjTiy6zvWv7VKc=;
 b=gbMaF5X8txMzgLxCTpPHa8B+zHMa1jwBCc4++ys7g4lBwuuspkEf0JHFSor4SlTC0JZHqH
 06VNBrcgme7MbTS08xbGh/ramYve6uq+9rrwkhZXxuPE7jrQZlvxRfbm3KRMRt364AJBC2
 KrdQsixE8eYd3JwApT6tXSkZbzpy4+4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-so8Wg2PEMr6gqZAMN4L5Sg-1; Mon, 17 Mar 2025 12:52:31 -0400
X-MC-Unique: so8Wg2PEMr6gqZAMN4L5Sg-1
X-Mimecast-MFC-AGG-ID: so8Wg2PEMr6gqZAMN4L5Sg_1742230351
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e913e1cf4aso136128556d6.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742230351; x=1742835151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAXbsGZdNS+8G7A18KwymoDmijmgppjTiy6zvWv7VKc=;
 b=gBBNe1KvhiHd2TzLUKoB1yxQBdYO794V6LV4xIUPbvI2yPgU7iutdQPPQvmHCZbZFh
 b8DF8yITlR0BRmgdS2GMnAvZMuYN1xjcKIpVCLqgLow23gk5jzY5A6IYX2QJBwAHcXnG
 pVlOPW30onJnyJChp4qM6B7FU7K88Hp8kudonQUlHBv1hMxb7iICvc2d9yvLOnSE4VYD
 0MK5WBhJ8lR6iIZjbBjky2VxnXkL4eK3IAxvCZyx7RwCwD4XHs5xNlJiQK6bO6WX8xtJ
 mg7Qn0OYOyHU+dlbKZvhULvjlC0AfZ1ESr/CSuShqA1k7ZdC9Q41pwfuPbYKvWNF7mXY
 a/Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoAtZ7fCLYrgPavaQIRYc6NuAGjRLWvFkdG23tARlkazfLnu7DAlxK5i4fI0JZWPwlAkUA3tmMm3qr@nongnu.org
X-Gm-Message-State: AOJu0Yz6BbuRC23rK8ogvxFr01+LvWsAe21sTFY/KyMY+FBp0RwAEoO2
 0hhVUzKgkdrszZIqry5mzX5jnb6qPaToVPo9oooEm+siDgHj41N2N0Mdn+s2fggHXcbCDVUEgkE
 W1ipN7XpvSNR76rHx00+R7L86EXfLuHfBiXdlgmnAd8lg1HZYns5f
X-Gm-Gg: ASbGncusLfhaoCqi5xDPZ2FsNe/4JHBo60gvv7PiudYDr0Dmip3DtJv918D6/FtPAYN
 Z3dTmu83+TYAosZIdrLoyzmUbu9npTd3shq6ELlMvKUte696kp8iIkbc1NTrAyVQ1lhcg/7rKFf
 SF+Y/c/gOxyoluYHwAZQCn5TRVerxN/5re2VWxEp2x15IufRYVvrxMqK59Z4StWD6ugAco7dOTg
 5vePbt66uIXkiujVkFQNNQLwTyOYEXmfQFVgIaEcYz+9YQKsxARFeTqHPWwW9zNFKpX8WcEKtAX
 o8UzNoivMoxPYkAvHQO//IZlnKuYsOLTOrkHG9TB/dgJMqEVvnDbznIA5hF1AUs=
X-Received: by 2002:a05:6214:29ea:b0:6e8:f133:3795 with SMTP id
 6a1803df08f44-6eaeaaa12c3mr204511476d6.32.1742230351190; 
 Mon, 17 Mar 2025 09:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiBGZyMcpZsACO17zHypCZ6U/8ovIq0CREdQllG3mDf4E2IzkxrTRRfqOQR0xsNsp6GidYzg==
X-Received: by 2002:a05:6214:29ea:b0:6e8:f133:3795 with SMTP id
 6a1803df08f44-6eaeaaa12c3mr204510916d6.32.1742230350772; 
 Mon, 17 Mar 2025 09:52:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb036e8b00sm21684966d6.17.2025.03.17.09.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:52:30 -0700 (PDT)
Message-ID: <1105d100-dd1e-4aca-b518-50f903967416@redhat.com>
Date: Mon, 17 Mar 2025 17:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/20] hw/arm/smmu-common: Introduce callbacks for
 PCIIOMMUOps
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-8-shameerali.kolothum.thodi@huawei.com>
 <fe047856-b564-4776-8651-daa65c02133b@redhat.com>
 <2606bc1d06f24495a8f382b3d1af3fc6@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2606bc1d06f24495a8f382b3d1af3fc6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Shameer,

On 3/13/25 9:09 AM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, March 12, 2025 4:24 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 07/20] hw/arm/smmu-common: Introduce
>> callbacks for PCIIOMMUOps
>>
>>
>>
>>
>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>> Subsequently smmuv3-accel will provide these callbacks
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  hw/arm/smmu-common.c         | 27 +++++++++++++++++++++++++++
>>>  include/hw/arm/smmu-common.h |  5 +++++
>>>  2 files changed, 32 insertions(+)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c index
>>> 83c0693f5a..9fd455baa0 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -865,6 +865,10 @@ static AddressSpace *smmu_find_add_as(PCIBus
>> *bus, void *opaque, int devfn)
>>>      SMMUState *s = opaque;
>>>      SMMUPciBus *sbus = smmu_get_sbus(s, bus);
>>>
>>> +    if (s->accel && s->get_address_space) {
>>> +        return s->get_address_space(bus, opaque, devfn);
>>> +    }
>>> +
>> why do we require that new call site? This needs to be documented in the
>> commit msg esp. because we don't know what this cb will do.
> Currently, this is where the first time SMMUDevice sdev is allocated. And for smmuv3-accel
> cases we are introducing a new SMMUv3AccelDevice accel_dev for holding additional
> accel specific information. In order to do that the above cb is used. Same for other callbacks
> as well.
>
> Another way of avoiding the callbacks would be to  move the pci_setup_iommu(bus, ops) 
> call from the smmu-common.c to smmuv3/smmuv3-accel and handle it directly there.
>
> Or is there a better idea?
>
>>>      sdev = sbus->pbdev[devfn];
>>>      if (!sdev) {
>>>          sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1); @@ -874,8
>>> +878,31 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void
>> *opaque, int devfn)
>>>      return &sdev->as;
>>>  }
>>>
>>> +static bool smmu_dev_set_iommu_device(PCIBus *bus, void *opaque,
>> int devfn,
>>> +                                      HostIOMMUDevice *hiod, Error
>>> +**errp) {
>>> +    SMMUState *s = opaque;
>>> +
>>> +    if (s->accel && s->set_iommu_device) {
>>> +        return s->set_iommu_device(bus, opaque, devfn, hiod, errp);
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>> +static void smmu_dev_unset_iommu_device(PCIBus *bus, void *opaque,
>>> +int devfn) {
>>> +    SMMUState *s = opaque;
>>> +
>>> +    if (s->accel && s->unset_iommu_device) {
>>> +        s->unset_iommu_device(bus, opaque, devfn);
>>> +    }
>>> +}
>>> +
>>>  static const PCIIOMMUOps smmu_ops = {
>>>      .get_address_space = smmu_find_add_as,
>>> +    .set_iommu_device = smmu_dev_set_iommu_device,
>>> +    .unset_iommu_device = smmu_dev_unset_iommu_device,
>>>  };
>>>
>>>  SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid) diff --git
>>> a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index
>>> 80ff2ef6aa..7b05640167 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -160,6 +160,11 @@ struct SMMUState {
>>>
>>>      /* For smmuv3-accel */
>>>      bool accel;
>>> +
>>> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int
>> devfn);
>>> +    bool (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
>>> +                             HostIOMMUDevice *dev, Error **errp);
>>> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>> I think this should be exposed by a class and only implemented in the
>> smmuv3 accel device. Adding those cbs directly in the State looks not the
>> std way.
> Ok. You mean we can directly place  PCIIOMMUOps *ops here then? 
When I first skimmed through the series I assumed you would use 2
seperate devices, in which case that would use 2 different
implementations of the same class. You may have a look at
docs/devel/qom.rst and Methods and class there.

Now as I commented earlier I think the end user shall instantiate the
same device for non accel and accel. I would advocate for passing an
option telling whether we want accel modality. Then it rather looks like
what was done for vfio device with either legacy or iommufd backend.

depending on whether the iommufd option is passed you select the right
class implementation:
see hw/vfio/common.c and vfio_attach_device


    const VFIOIOMMUClass *ops =
        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));

    if (vbasedev->iommufd) {
        ops =
VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
    }

I would doing something similar for selecting the right ops depending on
the passed option.

I hope this helps

Eric


>
> Thanks,
> Shameer


