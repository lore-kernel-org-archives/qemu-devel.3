Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867F9C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAH9-0004lP-At; Tue, 23 Jul 2024 03:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWAH4-0004kl-Rz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWAH2-0001gO-T9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721720966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rw3nFtm9zegoBN8YX4JTW36pDU9NtWxu/T39TQmQ3M8=;
 b=f4wIIa9GBwKzA5PKkzhEf1T7e3nELEu1KaMcMGjTN2MvYoTbFCLdgEdD6M2m5OCqi2d4Lp
 uf4cPSE9+dRHxqlnZvHZ0UeMOSwEw9Di3uATCs3s0HBmjUaMnDO0VvyP8Jo8UbM+nJ7k0z
 ciLvIlj5qR3iWq0tVb+6mNshKLD55Zs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184--XDLejKbMTu57VfQQtRrOg-1; Tue, 23 Jul 2024 03:45:02 -0400
X-MC-Unique: -XDLejKbMTu57VfQQtRrOg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4279418eb2bso35529695e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721720701; x=1722325501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rw3nFtm9zegoBN8YX4JTW36pDU9NtWxu/T39TQmQ3M8=;
 b=V5ycDGzNBtFj0XJc44sEeeOSdQD8hQOnMSTVZ1qAdPLOAcJT3NUwpt2XWJGgkxyYC+
 E6XDQrxW229Vj37Hss04hMx4PeErfdLv0ps03xQmMwetZri7Opg+90dNg91QyPk8XyQL
 Mf1yWDD45Yv/dLSG0mRbtmQ6yXMCO9iNBT89prqdsF4Vw8UtrSS99YKrdiQIJA+LZfC7
 LvieZFDpV3PhLaN0v+W8gVvy2Ho32ctKWqJL8kUVxWUc2h6KEa+XKbwnrmrZSkPe2G57
 3ZBACzJ+mPab0Gtp2IrPwiZ01c9z9czIuhusTiAQ9tPuQRt4HqpRXAmxEZBFt4CBNEJg
 ifGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPlctEs+w4Jbc31J7Mp0jyl8R/VwPJECUkUa2DAVhfMhP8MZaADDugfliJx/pqXo+Dryrj/xUQhQl65sj0E/oOqbpZgiw=
X-Gm-Message-State: AOJu0Yy3qUFeneiUUQwTd3k3CVJlRLMu9ert3S/AD99kBV4Z/loNhkMK
 6eJW3uVWeLyA/CpOlgJyEHRketHSRNqJ8nRjgkctlvxZM6DrtY7kIkTYrzqQaVn6MeOu9u3AMOn
 NPV22uaMLJiqlLvuSzVFoCdD3QrFAD9M1XaZN1lGz8AMImsaYZTDE
X-Received: by 2002:a05:600c:4e8b:b0:427:9db3:46ad with SMTP id
 5b1f17b1804b1-427dc532266mr62651005e9.23.1721720701454; 
 Tue, 23 Jul 2024 00:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUJ6pr3RnPfdXf0CYY1vFJ70pb8mDpnBkWiDCRljtD8E3UKqDeMX1fZexGPl73gwsIERvj6w==
X-Received: by 2002:a05:600c:4e8b:b0:427:9db3:46ad with SMTP id
 5b1f17b1804b1-427dc532266mr62650865e9.23.1721720701059; 
 Tue, 23 Jul 2024 00:45:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d692977asm159878035e9.31.2024.07.23.00.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:45:00 -0700 (PDT)
Message-ID: <eae669f6-f24f-4573-9934-2c6fb5b364ad@redhat.com>
Date: Tue, 23 Jul 2024 09:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
To: eric.auger@redhat.com, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
 <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On 7/23/24 09:38, Eric Auger wrote:
> Hi Joao,
> 
> On 7/22/24 23:13, Joao Martins wrote:
>> Move the HostIOMMUDevice::realize() to be invoked during the attach of the device
>> before we allocate IOMMUFD hardware pagetable objects (HWPT). This allows the use
>> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell if the IOMMU
>> behind the device supports dirty tracking.
>>
>> Note: The HostIOMMUDevice data from legacy backend is static and doesn't
>> need any information from the (type1-iommu) backend to be initialized.
>> In contrast however, the IOMMUFD HostIOMMUDevice data requires the
>> iommufd FD to be connected and having a devid to be able to successfully
> Nit: maybe this comment shall be also added in iommufd.c before the call
> to vfio_device_hiod_realize() to avoid someone else to move that call
> earlier at some point
>> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
>> different places within the backend .attach_device() implementation.
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.cm>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  1 +
>>   hw/vfio/common.c              | 16 ++++++----------
>>   hw/vfio/container.c           |  4 ++++
>>   hw/vfio/helpers.c             | 11 +++++++++++
>>   hw/vfio/iommufd.c             |  4 ++++
>>   5 files changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 1a96678f8c38..4e44b26d3c45 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>>   void vfio_reset_handler(void *opaque);
>>   struct vfio_device_info *vfio_get_device_info(int fd);
>>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                           AddressSpace *as, Error **errp);
>>   void vfio_detach_device(VFIODevice *vbasedev);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 784e266e6aab..da12cbd56408 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>   {
>>       const VFIOIOMMUClass *ops =
>>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>> -    HostIOMMUDevice *hiod;
>> +    HostIOMMUDevice *hiod = NULL;
>>   
>>       if (vbasedev->iommufd) {
>>           ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>> @@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>   
>>       assert(ops);
>>   
>> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>> -        return false;
>> -    }
>>   
>> -    if (vbasedev->mdev) {
>> -        return true;
>> +    if (!vbasedev->mdev) {
>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> +        vbasedev->hiod = hiod;
>>       }
>>   
>> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>           object_unref(hiod);
>> -        ops->detach_device(vbasedev);
>> +        vbasedev->hiod = NULL;
>>           return false;
>>       }
>> -    vbasedev->hiod = hiod;
>>   
>>       return true;
>>   }
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 10cb4b4320ac..9ccdb639ac84 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>   
>>       trace_vfio_attach_device(vbasedev->name, groupid);
>>   
>> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>> +        return false;
> don't you want to go to err_alloc_ioas instead?

hmm, the err_alloc_ioas label is in a different function iommufd_cdev_attach().

may be you meant the comment for routine iommufd_cdev_attach() and
label err_connect_bind ?


Thanks,

C.


>> +    }
>> +
>>       group = vfio_get_group(groupid, as, errp);
>>       if (!group) {
>>           return false;
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index 7e23e9080c9d..ea15c79db0a3 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>>       subsys = realpath(tmp, NULL);
>>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>>   }
>> +
>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>> +
>> +    if (!hiod) {
>> +        return true;
>> +    }
>> +
>> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
>> +}
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 5e2fc1ce089d..2324bf892c56 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>   
>>       space = vfio_get_address_space(as);
>>   
>> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>> +        return false;
>> +    }
>> +
>>       /* try to attach to an existing container in this space */
>>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>>           container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> Eric
> 


