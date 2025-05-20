Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B37C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMBA-00058d-7e; Tue, 20 May 2025 08:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHMB6-00058K-0j
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHMB2-00056R-Is
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747744467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9SEBu9Cql0lhjypJEqoK7XEIIvNCKpNaMO78I+EWMFU=;
 b=ikiOiYc+6MovgZLJ3kcuAtmv0MNbvGbTG8BlcPgMtjouphJwpSH97uOhWWoEemvS7mLqyM
 Nwlb5rAeuXHXYgystNBgDPBWgHWu3zGyoDlhIPwALRK0P3rpoUVc4staMJsmGlC7sGg09v
 zMdi/oXO6FTQBifoCqBb+4H0TrcAs+8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-IP7nzU-RPuGqikrEmJ5GKQ-1; Tue, 20 May 2025 08:34:26 -0400
X-MC-Unique: IP7nzU-RPuGqikrEmJ5GKQ-1
X-Mimecast-MFC-AGG-ID: IP7nzU-RPuGqikrEmJ5GKQ_1747744465
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so27237705e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747744465; x=1748349265;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SEBu9Cql0lhjypJEqoK7XEIIvNCKpNaMO78I+EWMFU=;
 b=c59FXQf1TnjnWgUyjZ0qnofermCxWtpjqW/ubXEUYoG+H/0ThuQRyfdSE8En/T7Ycy
 PJWObfCONCkay3SAfvhg7rlOFSnhVwArAgmLXUFD1Y7wfKjwzGadBlMLzRNiBLVD7X68
 1uCIP94sF6m36VobjebNOh2DH8iOgGd+4Cfh2N9z7VNmZEmkWLXiEZSx3wc+GCG2KLWM
 qFeHVctfpcjU71st2yRjz8+TGQ0p9/RpS1sx987233jVe1c/rg7AVst3/OBm9oYPdWMg
 FPVwpOCuLKh4lgCoye5Sm67uSGmIi5hHdD/ByXob4X2+Qd11ilgJJziSHpqJ8swY+z53
 +WRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+bq0TAE+LyO++LlJHS94CxTEbmIzzJjSeeU1JfX4vikSFVTFE7/v90k2c5aplD8Eni682qt6Tgstd@nongnu.org
X-Gm-Message-State: AOJu0YzRKGvP8+RxPj4WKAsA7r3lAOMRCQ0jSCK6ukPK+SHnIWaVuxo/
 9DwzivamHzCA2sn3M0RMEEwiSMCKvkDvFFeauY4g0ygpLvYdCm6fHME2Yvb0D13+nPBdGv4ZFSC
 57SfS0jwWTznud46SKnQCIzK5lUzcc562YrNJi7QEgk3hiJ7KK6G1CxZ2
X-Gm-Gg: ASbGncs3pCXcozp6U9xePB9zPEibbIoj1qp3OIQlqISkwClZW8whtHk79Pv0ypYRZTU
 gJu9aX7E+Ie3TYRiH/vadtHElKcgKE5YcN9oz4TS0shKPhurCMkNkfYzx9j3Uj8+Asy209HwvIc
 l5Z79ubs4xIedhrQ17uhzfeoXd5akghiEpZP5/0n+ljFOg4ctCs93nUWv6+cYHDZ6FhqgMDWh4T
 o6Ro3nmc/0B9/9170cRgyjM00GYuUuKCfDXo0AjT7ILkZZsvTsnMivSY93Zy4x9feJf4Xc4lO+V
 wGwzF39mcn5xa+FGu6Z69uu4yRR6CX8gPaCB2waK9duNVFWnmQ==
X-Received: by 2002:a05:600c:34c4:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-442fd6752e7mr161330495e9.27.1747744465396; 
 Tue, 20 May 2025 05:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJPOFcSObM9VewQcPatuh2eGrTQWSe+9JG9eb6p12Z7Cm+wyk/WgZJDDzCm5FZ+ccBr/f0xw==
X-Received: by 2002:a05:600c:34c4:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-442fd6752e7mr161330235e9.27.1747744465020; 
 Tue, 20 May 2025 05:34:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1825457sm31074645e9.1.2025.05.20.05.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:34:24 -0700 (PDT)
Message-ID: <a61b557c-5cee-4a6d-bc68-973582b797c4@redhat.com>
Date: Tue, 20 May 2025 14:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-34-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9ABCAFF7FB3204BA6549293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB6744C9ABCAFF7FB3204BA6549293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/16/25 10:55, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
>>
>> Extract hwpt creation code from iommufd_cdev_autodomains_get into the
>> helpers iommufd_cdev_use_hwpt and iommufd_cdev_make_hwpt.  These will
>> be used by CPR in a subsequent patch.
>>
>> Call vfio_device_hiod_create_and_realize earlier so iommufd_cdev_make_hwpt
>> can use vbasedev->hiod hw_caps, avoiding an extra call to
>> iommufd_backend_get_device_info
> 
> We had made consensus to realize hiod after attachment,
> it's not a hot path so an extra call is acceptable per Cedric.

We also placed the realize call where it is in preparation for
nested IOMMU support, and avoid a late_realize handler AFAICR


>> No functional change.


We should add a comment before to make sure the code is not moved
around.


Thanks,

C.




>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/iommufd.c | 116 ++++++++++++++++++++++++++++++----------------------
>> --
>> 1 file changed, 65 insertions(+), 51 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index f645a62..8661947 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -310,16 +310,70 @@ static bool
>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>      return true;
>> }
>>
>> +static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt
>> *hwpt)
>> +{
>> +    vbasedev->hwpt = hwpt;
>> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +}
>> +
>> +/*
>> + * iommufd_cdev_make_hwpt: If @alloc_id, allocate a hwpt_id, else use
>> @hwpt_id.
>> + * Create and add a hwpt struct to the container's list and to the device.
>> + * Always succeeds if !@alloc_id.
>> + */
>> +static bool iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
>> +                                   VFIOIOMMUFDContainer *container,
>> +                                   uint32_t hwpt_id, bool alloc_id,
>> +                                   Error **errp)
>> +{
>> +    VFIOIOASHwpt *hwpt;
>> +    uint32_t flags = 0;
>> +
>> +    /*
>> +     * This is quite early and VFIO Migration state isn't yet fully
>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>> +     * whether IOMMU dirty tracking is going to be requested. Later
>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>> +     * instead.
>> +     */
>> +    g_assert(vbasedev->hiod);
>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +    }
>> +
>> +    if (alloc_id) {
>> +        if (!iommufd_backend_alloc_hwpt(vbasedev->iommufd, vbasedev->devid,
>> +                                        container->ioas_id, flags,
>> +                                        IOMMU_HWPT_DATA_NONE, 0, NULL,
>> +                                        &hwpt_id, errp)) {
>> +            return false;
>> +        }
>> +
>> +        if (iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp)) {
>> +            iommufd_backend_free_id(container->be, hwpt_id);
>> +            return false;
>> +        }
>> +    }
>> +
>> +    hwpt = g_malloc0(sizeof(*hwpt));
>> +    hwpt->hwpt_id = hwpt_id;
>> +    hwpt->hwpt_flags = flags;
>> +    QLIST_INIT(&hwpt->device_list);
>> +
>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    container->bcontainer.dirty_pages_supported |=
>> +                                vbasedev->iommu_dirty_tracking;
>> +    iommufd_cdev_use_hwpt(vbasedev, hwpt);
>> +    return true;
>> +}
>> +
>> static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>                                           VFIOIOMMUFDContainer *container,
>>                                           Error **errp)
>> {
>>      ERRP_GUARD();
>> -    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>> -    uint32_t type, flags = 0;
>> -    uint64_t hw_caps;
>>      VFIOIOASHwpt *hwpt;
>> -    uint32_t hwpt_id;
>>      int ret;
>>
>>      /* Try to find a domain */
>> @@ -340,54 +394,14 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>
>>              return false;
>>          } else {
>> -            vbasedev->hwpt = hwpt;
>> -            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> -            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> +            iommufd_cdev_use_hwpt(vbasedev, hwpt);
>>              return true;
>>          }
>>      }
>> -
>> -    /*
>> -     * This is quite early and VFIO Migration state isn't yet fully
>> -     * initialized, thus rely only on IOMMU hardware capabilities as to
>> -     * whether IOMMU dirty tracking is going to be requested. Later
>> -     * vfio_migration_realize() may decide to use VF dirty tracking
>> -     * instead.
>> -     */
>> -    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>> -                                         &type, NULL, 0, &hw_caps, errp)) {
>> -        return false;
>> -    }
>> -
>> -    if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> -        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> -    }
>> -
>> -    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>> -                                    container->ioas_id, flags,
>> -                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>> -                                    &hwpt_id, errp)) {
>> -        return false;
>> -    }
>> -
>> -    hwpt = g_malloc0(sizeof(*hwpt));
>> -    hwpt->hwpt_id = hwpt_id;
>> -    hwpt->hwpt_flags = flags;
>> -    QLIST_INIT(&hwpt->device_list);
>> -
>> -    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> -    if (ret) {
>> -        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> -        g_free(hwpt);
>> +    if (!iommufd_cdev_make_hwpt(vbasedev, container, 0, true, errp)) {
>>          return false;
>>      }
>>
>> -    vbasedev->hwpt = hwpt;
>> -    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>> -    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> -    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> -    container->bcontainer.dirty_pages_supported |=
>> -                                vbasedev->iommu_dirty_tracking;
>>      if (container->bcontainer.dirty_pages_supported &&
>>          !vbasedev->iommu_dirty_tracking) {
>>          warn_report("IOMMU instance for device %s doesn't support dirty tracking",
>> @@ -530,6 +544,11 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>
>>      space = vfio_address_space_get(as);
>>
>> +    if (!vfio_device_hiod_create_and_realize(vbasedev,
>> +            TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>> +        goto err_alloc_ioas;
>> +    }
>> +
>>      /* try to attach to an existing container in this space */
>>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> @@ -604,11 +623,6 @@ found_container:
>>          goto err_listener_register;
>>      }
>>
>> -    if (!vfio_device_hiod_create_and_realize(vbasedev,
>> -                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>> -        goto err_listener_register;
>> -    }
>> -
>>      /*
>>       * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>>       * for discarding incompatibility check as well?
>> --
>> 1.8.3.1
> 


