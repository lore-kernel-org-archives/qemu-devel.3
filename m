Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADB9C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 07:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmTie-0007d0-3V; Tue, 19 Mar 2024 03:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmTic-0007cj-AY
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 03:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmTiR-0005qG-VL
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 03:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710832614;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCGQhiMr5ghO5ogITkrEdFm0n0RUBae4b0OJFCvOK5M=;
 b=TIE/vjadPlzhKtprxUT004TmRiRLu1rlXlMyTn3c4gE9f3xsLNG/RIibGDMnvC60eLNcAq
 WIoMhH3xyxocEdCcBJ1VqgiQ8xDx/ZUn50xsEs///4pMucnVp9G+qq1lgoO8PQQjlaVER7
 ExF3vJiR4y8mNIWjRaw4sQooD0xjhv8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-ZHqkjnFuPFKRvQyxkm0cFw-1; Tue, 19 Mar 2024 03:16:52 -0400
X-MC-Unique: ZHqkjnFuPFKRvQyxkm0cFw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-430baecb018so37702621cf.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 00:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710832612; x=1711437412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RCGQhiMr5ghO5ogITkrEdFm0n0RUBae4b0OJFCvOK5M=;
 b=Osvhus2+8wjKymWCBlDHuQw7ULNRhsJMQvEImeGM78HR7bOOnDWksGG/VYG7iN63xq
 6kvpwtZN79rCBmii8iLLZZus08TFr1l9AOyC/sfKKBOAwkjSOBYaG9RisQbxPJTM7O9W
 PjbMCBhz0geDbVxtdW2aiuTVmRBHIbWLfj3+/88+omM2AMfi3lzc2aZhEYmp5msbNZFM
 6Th3dtkEjY2BICTjerjjBFaleuivfUMBkTPmVfIV8tGYXjqqmP5SPbN/T7/MessF5ZSj
 tODlZ2Laxs29N9OOaZm4LACYw1FYDIj8kYVPjzgXXTrlKppnY8tiX3/LKHfLIDJIW+or
 W/rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7+Zb+vr07KDH+CqZdXLB6T5w+LPRC/kfDaueaPw38teSSBomTD0gwON1oxdgSwuEVKOpZ8njJpoQ/m6Rr1cUWsaEc7Vg=
X-Gm-Message-State: AOJu0YyhY2Nb7Zih2xb6ubIF/I0JZIE3qaNsQlKPOHKao1WwrnS3vFoX
 hkeM113KTL7H/fJ+ODBLwcGnFI4S29/dwjL/6QnGA4hZYXCXKR11vKh/6tPg9+X++1hc2HgPdxI
 sHI9urI/ydXYvPIUvbqAyz+hFDpP9rUYhqTJUDs5Do4LhtxLT3MIV
X-Received: by 2002:ac8:570f:0:b0:42f:5131:54a9 with SMTP id
 15-20020ac8570f000000b0042f513154a9mr18751130qtw.63.1710832612060; 
 Tue, 19 Mar 2024 00:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWGe+ma6WnQnxkzyGxB3BLbd6FHoytIt6Ay7wezYBSbC2tSVNBVRcKhgHK9gOV62SGiUq41A==
X-Received: by 2002:ac8:570f:0:b0:42f:5131:54a9 with SMTP id
 15-20020ac8570f000000b0042f513154a9mr18751120qtw.63.1710832611775; 
 Tue, 19 Mar 2024 00:16:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 fd6-20020a05622a4d0600b00430d8ca2a82sm1349318qtb.66.2024.03.19.00.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 00:16:51 -0700 (PDT)
Message-ID: <2fcea648-bdf8-40f7-ac8f-6be6131249d3@redhat.com>
Date: Tue, 19 Mar 2024 08:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create callback
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-6-zhenzhong.duan@intel.com>
 <49c49a2e-859e-45bb-b281-0ed9c72ecf9c@redhat.com>
 <SJ0PR11MB67448B4FB9B8E10A2F0DCEB6922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67448B4FB9B8E10A2F0DCEB6922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 3/19/24 06:44, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create
>> callback
>>
>>
>>
>> On 2/28/24 04:58, Zhenzhong Duan wrote:
>>> Introduce host_iommu_device_create callback and a wrapper for it.
>>>
>>> This callback is used to allocate a host iommu device instance and
>>> initialize it based on type.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/vfio/vfio-common.h         | 1 +
>>>  include/hw/vfio/vfio-container-base.h | 1 +
>>>  hw/vfio/common.c                      | 8 ++++++++
>>>  3 files changed, 10 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>> index b6676c9f79..9fefea4b89 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -208,6 +208,7 @@ struct vfio_device_info *vfio_get_device_info(int
>> fd);
>>>  int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>                         AddressSpace *as, Error **errp);
>>>  void vfio_detach_device(VFIODevice *vbasedev);
>>> +void host_iommu_device_create(VFIODevice *vbasedev);
>>>
>>>  int vfio_kvm_device_add_fd(int fd, Error **errp);
>>>  int vfio_kvm_device_del_fd(int fd, Error **errp);
>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>>> index b2813b0c11..dc003f6eb2 100644
>>> --- a/include/hw/vfio/vfio-container-base.h
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -120,6 +120,7 @@ struct VFIOIOMMUClass {
>>>      int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>>                           AddressSpace *as, Error **errp);
>>>      void (*detach_device)(VFIODevice *vbasedev);
>>> +    void (*host_iommu_device_create)(VFIODevice *vbasedev);
>> Maybe return an int instead. It is common the allocation can fail and
>> the deallocation cannot. While at it I would also pass an errp in case
>> it fails
> Currently host_iommu_device_create implementation only calls g_malloc0,
> so never fails, so I returned void.
>
> I'm fine to return an int, will be like below, take iommufd for example:
>
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -651,7 +651,7 @@ static IOMMUFDDeviceOps vfio_iommufd_device_ops = {
>      .detach_hwpt = vfio_iommufd_device_detach_hwpt,
>  };
>
> -static void vfio_cdev_host_iommu_device_create(VFIODevice *vbasedev)
> +static int vfio_cdev_host_iommu_device_create(VFIODevice *vbasedev, Error **errp)
>  {
>      IOMMUFDDevice *idev = g_malloc0(sizeof(IOMMUFDDevice));
>      VFIOIOMMUFDContainer *container = container_of(vbasedev->bcontainer,
> @@ -661,6 +661,8 @@ static void vfio_cdev_host_iommu_device_create(VFIODevice *vbasedev)
>
>      iommufd_device_init(idev, vbasedev->iommufd, vbasedev->devid,
>                          container->ioas_id, vbasedev, &vfio_iommufd_device_ops);
> +
> +    return 0;
>  }
I think the rationale behind introducing an error handle is to propagate
it down to the callbacks. This is were I anticipated errors to occur.
But if you don't foresee any maybe we can just wait and postpone this
addition.

Thanks

Eric
>
> Thanks
> Zhenzhong


>
>> Eric
>>>      /* migration feature */
>>>      int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>>>                                     bool start);
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 059bfdc07a..41e9031c59 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1521,3 +1521,11 @@ void vfio_detach_device(VFIODevice
>> *vbasedev)
>>>      }
>>>      vbasedev->bcontainer->ops->detach_device(vbasedev);
>>>  }
>>> +
>>> +void host_iommu_device_create(VFIODevice *vbasedev)
>>> +{
>>> +    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
>>> +
>>> +    assert(ops->host_iommu_device_create);
>>> +    ops->host_iommu_device_create(vbasedev);
>>> +}


