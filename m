Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84163C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU39Y-0006yr-Pk; Wed, 17 Jul 2024 07:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU39R-0006Wm-P1
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU39K-0002Vc-Bq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721216923;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDM3oTJBDwPWzVoYRMs0OTFIrtDUGtirlJI/4IUga18=;
 b=F/TKm4678h1KhAxbWH4JOCbfvws7yXu0kIDUFlFXRNFpUMyTLLBOPXGg6JnOFLLCTWvWZ5
 MKw+CZz/ixd5UwaWfqnX/eH3nimIANkBAwHOWdhX2bmDQ9SQkxDKcxIAthZdBNahV6amFm
 Uf/QVeW/ypuVPgkngMDDJoTq6HGUi0E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-FsGcgJmZPtCPosfTZqrQJQ-1; Wed, 17 Jul 2024 07:48:42 -0400
X-MC-Unique: FsGcgJmZPtCPosfTZqrQJQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79f00facc85so652368985a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 04:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721216922; x=1721821722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDM3oTJBDwPWzVoYRMs0OTFIrtDUGtirlJI/4IUga18=;
 b=flTPckxQhgSzs9uoOzfRjscmwR3gLVdFlQOxN5hCDzDBjjqH7oDAGC/j+mGpDnlNc8
 YeEyLynIU39NnUXztFoCix/FLUCb3etwNaR8ryJ/RmZ/hLIOdukugxfyxuDBQvV5vt8h
 ruxfgG9gQYFagUMRviXv/vtOjHyxoFkUhoQCK2UK/EI61QS2SgtfwQ4iFPFpAfxACjhi
 XxV017a4BopYRl1q3+T+v6zqjuIo1TKsYDJK+96PTKQMiaAPK8S07L2ccAki2vd9VqNc
 X9XZ876DKAPseIu4lDYrIhwRLj+gEtezftaynehvmlJlfgwecZxsLLStShy1sBRRXtOd
 z89A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6tG9kKGrZAAq2EEtaG53MyAmxkusp7vwUlh/20c49lbNn5eg8furfXlyfOz4ihZ48hf7unXjE8tD1wFefiYydSnfwIoY=
X-Gm-Message-State: AOJu0Ywf4i1pPfY1mD588Mp6Xcloh9btI/wt6UzUT+JEFr5IxDIUjoAM
 SE/ozXHS8XvobGrAzrSWtbzclvc8JkO+wIwx5DRWrHDA6DJrenZbENtk9OeISGGiJLiVZS7ZSgj
 FmGZa/3OUlfM5LhKEgA29jg8dbIOMIoqBRLC5/1g84Okj7OMC2DRu
X-Received: by 2002:a05:620a:2890:b0:79f:793:9a63 with SMTP id
 af79cd13be357-7a187480c7bmr168768685a.44.1721216921812; 
 Wed, 17 Jul 2024 04:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlDOalV2P/W4DWExeBIZSmiVlAS8w2QjGQSau4MiXELHK+WL0GSG91TE81Zig74+NCPrnQfQ==
X-Received: by 2002:a05:620a:2890:b0:79f:793:9a63 with SMTP id
 af79cd13be357-7a187480c7bmr168767485a.44.1721216921501; 
 Wed, 17 Jul 2024 04:48:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b7e1242sm46202371cf.28.2024.07.17.04.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 04:48:40 -0700 (PDT)
Message-ID: <c1576d42-da50-43e2-955f-2c8e1fc3edbc@redhat.com>
Date: Wed, 17 Jul 2024 13:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] vfio/{iommufd,container}: Remove caps::aw_bits
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-7-joao.m.martins@oracle.com>
 <903e6f5a-76fc-4f8c-b83e-d7d2a0f45d7c@redhat.com>
 <7fa60a68-0670-4bdc-b1a7-b4dbec77aa9b@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7fa60a68-0670-4bdc-b1a7-b4dbec77aa9b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Joao,

On 7/16/24 20:22, Joao Martins wrote:
> On 16/07/2024 18:40, Eric Auger wrote:
>> Hi Joao,
>>
>> On 7/12/24 13:46, Joao Martins wrote:
>>> In preparation to moving HostIOMMUDevice realize() being able to called
>>> early during attach_device(), remove properties that rely on container
>>> being initialized.
>> It is difficult to parse the above sentence. Would deserve some rephrasing.
>>
>> Also properties have a different meaning in qemu.
> I think I will remove the above paragraph and instead adopt below with some
> rephrasing:
>
> Remove caps::aw_bits which requires the
> bcontainer::iova_ranges to be inititalized after device is actually
> initialized attached. Instead defer that to .get_cap() and call
s/initialized//g
> vfio_device_get_aw_bits() directly.
>
> This is in preparation for HostIOMMUDevice::realize() being called early during
> attach_device().
>
> Better?
Yes sounds better

Eric
>
>>> This means removing caps::aw_bits which requires the
>>> bcontainer::iova_ranges to be inititalized after device is actually
>> initialized
> Yes
>
>>> attached. Instead defer that to .get_cap() and call
>>> vfio_device_get_aw_bits() directly.
>>>
>>> Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>  include/sysemu/host_iommu_device.h | 1 -
>>>  backends/iommufd.c                 | 3 ++-
>>>  hw/vfio/container.c                | 5 +----
>>>  hw/vfio/iommufd.c                  | 1 -
>>>  4 files changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
>>> index ee6c813c8b22..20e77cf54568 100644
>>> --- a/include/sysemu/host_iommu_device.h
>>> +++ b/include/sysemu/host_iommu_device.h
>>> @@ -24,7 +24,6 @@
>>>   */
>>>  typedef struct HostIOMMUDeviceCaps {
>>>      uint32_t type;
>>> -    uint8_t aw_bits;
>> the doc comment needs to be updated accordingly.
>>>  } HostIOMMUDeviceCaps;
>>>  
>>>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 5d3dfa917415..41a9dec3b2c5 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -18,6 +18,7 @@
>>>  #include "qemu/error-report.h"
>>>  #include "monitor/monitor.h"
>>>  #include "trace.h"
>>> +#include "hw/vfio/vfio-common.h"
>>>  #include <sys/ioctl.h>
>>>  #include <linux/iommufd.h>
>>>  
>>> @@ -270,7 +271,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>>>      case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>>>          return caps->type;
>>>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>>> -        return caps->aw_bits;
>>> +        return vfio_device_get_aw_bits(hiod->agent);
>>>      default:
>>>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>>>          return -EINVAL;
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 88ede913d6f7..c27f448ba26e 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -1144,7 +1144,6 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>      VFIODevice *vdev = opaque;
>>>  
>>>      hiod->name = g_strdup(vdev->name);
>>> -    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
>>>      hiod->agent = opaque;
>>>  
>>>      return true;
>>> @@ -1153,11 +1152,9 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>  static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>>>                                      Error **errp)
>>>  {
>>> -    HostIOMMUDeviceCaps *caps = &hiod->caps;
>>> -
>>>      switch (cap) {
>>>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>>> -        return caps->aw_bits;
>>> +        return vfio_device_get_aw_bits(hiod->agent);
>>>      default:
>>>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>>>          return -EINVAL;
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 325c7598d5a1..873c919e319c 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -722,7 +722,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>  
>>>      hiod->name = g_strdup(vdev->name);
>>>      caps->type = type;
>>> -    caps->aw_bits = vfio_device_get_aw_bits(vdev);
>>>  
>>>      return true;
>>>  }


