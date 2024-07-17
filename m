Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEE9C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4nm-0007GM-QR; Wed, 17 Jul 2024 09:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU4nj-00076u-98
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU4nh-0006FJ-5G
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721223271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dS64pbT0Xjofmt4p5DRr2f7tvNNSdptfjMpV+Ntymf4=;
 b=hy6eWEzgtBNfugVifYT7wihlu0m03sAxbRKD2W/HVh7eBrBdeN3tImTjXZNi1t+SOIHuNJ
 90SMwCa1VFtxFdJf0AdnLk9RXWmXsJ7Wyd6v6x+9TKWOf10e2yNgcX9E/5JH2dDGRjBYg2
 ZA2qrQUSmh/TK3BfWAVVNPP4yktwAq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-2XFMKhnjNFypaNvu5_3AoA-1; Wed, 17 Jul 2024 09:34:30 -0400
X-MC-Unique: 2XFMKhnjNFypaNvu5_3AoA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367991a0a64so4259019f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223269; x=1721828069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dS64pbT0Xjofmt4p5DRr2f7tvNNSdptfjMpV+Ntymf4=;
 b=Y03cuAkq3Z3SQ0S/1nvF2zcAyTO4MXLoSRfoY9uXPFzCVcjsHEwS18RKx/OlvlfO9f
 yNxHuG1YbnX4q7S7XqweBx+1HHYK8XyOk+e7i7sbMHmYHzawaSovcbr8kU36i+ZSo+xJ
 s7mvcsvW3S+SnbIK8pIaHgeRJd1AqegmTQKKH+PSfM1PhUIkqaBgAHBbnPJyylSSroXe
 jS9VXfpHMMHQXPOc9ca14Y//lDZTRAfZG0//S+0wgczwlDtb3gdBkpVSF5muVCsS/+IX
 2cnwohmOPpbflEUmL9+ZMbhvCgl9+ozvibg5To0kiVrNENm4U1zAEkOxt2hA29gKxC+I
 AYNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPiVxtec36mt9ha6O8PAKwh+djKMn48y0ME18BLeSjo7HQvE2ZBsoQj7BXe1MOJD+/NU5Sg8z4T9bTPBRTldicvdXY9I8=
X-Gm-Message-State: AOJu0Yw84BWNSUA5d96meIaMvHAN8qrQoQ3PQbfeRKJznKXLKxH84Kjq
 8uubI97Inncq4pnv+L70c5gWQtaLodZ2hRQo5yBKkM3+VyZj1OmI1kMkgcQU3IDYuaAGq+1zl56
 lRXcvZSwasWE9v/QHkLlya42nBfExEVxYxmYc4tR5kfECYeKUl2Zo
X-Received: by 2002:adf:f6c8:0:b0:367:95e8:3aef with SMTP id
 ffacd0b85a97d-3683175bbfcmr1138328f8f.42.1721223269586; 
 Wed, 17 Jul 2024 06:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyZ730Xmc4uZ+dKimInXWCySITU3Hzhdimqi5siC+jvmkVvwqAT8CcRef3yEQfC2RpTRA3yQ==
X-Received: by 2002:adf:f6c8:0:b0:367:95e8:3aef with SMTP id
 ffacd0b85a97d-3683175bbfcmr1138307f8f.42.1721223269197; 
 Wed, 17 Jul 2024 06:34:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3e27sm11767720f8f.15.2024.07.17.06.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 06:34:28 -0700 (PDT)
Message-ID: <1beb7010-a9f2-4379-9469-971b35adbe58@redhat.com>
Date: Wed, 17 Jul 2024 15:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-10-joao.m.martins@oracle.com>
 <bcac1f67-95de-41fb-ae34-9c479db29969@redhat.com>
 <bff9d18b-1286-414c-ad47-6898b55ae9dd@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <bff9d18b-1286-414c-ad47-6898b55ae9dd@oracle.com>
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



On 7/17/24 14:41, Joao Martins wrote:
> On 17/07/2024 13:36, Eric Auger wrote:
>>
>> On 7/12/24 13:47, Joao Martins wrote:
>>> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
>>> enables or disables dirty page tracking. It is used if the hwpt
>>> has been created with dirty tracking supported domain (stored in
>>> hwpt::flags) and it is called on the whole list of iommu domains
>>> it is are tracking. On failure it rolls it back.
>> it is are tracking ?
> *it is*
>
>> also please clearly state what is "it"
>>
> sure
>
>>> The checking of hwpt::flags is introduced here as a second user
>> ?? -> introduce iommufd_hwpt_dirty_tracking() helper to avoid code dup?
> Right I am doing that already. Not sure what the problem is with this sentence?

"The checking of hwpt::flags is introduced here as a second user" phrasing sounds weird to me.
I guess you just meant that you need to check 
hwpt::flags in another place so better off introducing an helper.

>
> Or you meant to use yours as it's simpler/easier to understand.
>
>>> and thus consolidate such check into a helper function
>>> iommufd_hwpt_dirty_tracking().
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>  include/sysemu/iommufd.h |  3 +++
>>>  backends/iommufd.c       | 23 +++++++++++++++++++++++
>>>  hw/vfio/iommufd.c        | 39 ++++++++++++++++++++++++++++++++++++++-
>>>  backends/trace-events    |  1 +
>>>  4 files changed, 65 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>> index e917e7591d05..7416d9219703 100644
>>> --- a/include/sysemu/iommufd.h
>>> +++ b/include/sysemu/iommufd.h
>>> @@ -55,6 +55,9 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>>                                  uint32_t data_type, uint32_t data_len,
>>>                                  void *data_ptr, uint32_t *out_hwpt,
>>>                                  Error **errp);
>>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>>> +                                        bool start, Error **errp);
>>>  
>>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>> +
>> spurious line change
> ok
>
>>>  #endif
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 41a9dec3b2c5..239f0976e0ad 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -239,6 +239,29 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>>      return true;
>>>  }
>>>  
>>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>>> +                                        uint32_t hwpt_id, bool start,
>>> +                                        Error **errp)
>>> +{
>>> +    int ret;
>>> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
>>> +            .size = sizeof(set_dirty),
>>> +            .hwpt_id = hwpt_id,
>>> +            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
>>> +    };
>>> +
>>> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
>>> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno : 0);
>>> +    if (ret) {
>>> +        error_setg_errno(errp, errno,
>>> +                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) failed",
>>> +                         hwpt_id);
>>> +        return false;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>>                                       uint32_t *type, void *data, uint32_t len,
>>>                                       uint64_t *caps, Error **errp)
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index edc8f97d8f3d..da678315faeb 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -110,6 +110,42 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>>      iommufd_backend_disconnect(vbasedev->iommufd);
>>>  }
>>>  
>>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>> +{
>>> +    return hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +}
>>> +
>>> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>>> +                                           bool start, Error **errp)
>>> +{
>>> +    const VFIOIOMMUFDContainer *container =
>>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>>> +    VFIOIOASHwpt *hwpt;
>>> +
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>>> +            continue;
>>> +        }
>>> +
>>> +        if (!iommufd_backend_set_dirty_tracking(container->be,
>>> +                                                hwpt->hwpt_id, start, errp)) {
>>> +            goto err;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +err:
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>>> +            continue;
>>> +        }
>>> +        iommufd_backend_set_dirty_tracking(container->be,
>>> +                                           hwpt->hwpt_id, !start, NULL);
>>> +    }
>>> +    return -EINVAL;
>>> +}
>>> +
>>>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>>  {
>>>      ERRP_GUARD();
>>> @@ -278,7 +314,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>>      container->bcontainer.dirty_pages_supported |=
>>> -                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>>> +                              iommufd_hwpt_dirty_tracking(hwpt);
>>>      return true;
>>>  }
>>>  
>>> @@ -717,6 +753,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>>      vioc->attach_device = iommufd_cdev_attach;
>>>      vioc->detach_device = iommufd_cdev_detach;
>>>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>>> +    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>>>  };
>>>  
>>>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>> diff --git a/backends/trace-events b/backends/trace-events
>>> index 4d8ac02fe7d6..28aca3b859d4 100644
>>> --- a/backends/trace-events
>>> +++ b/backends/trace-events
>>> @@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
>>>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>>>  iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>>> +iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"


