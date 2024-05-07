Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8970FC25B5C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 05:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Dpn-0000ml-OC; Tue, 07 May 2024 01:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Dpl-0000m8-Mu
 for qemu-devel@nongnu.org; Tue, 07 May 2024 01:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Dpi-0007ww-Um
 for qemu-devel@nongnu.org; Tue, 07 May 2024 01:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715061465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7eBcyek3WDFnvQvIljybn715jiil6QiLfvQlXQsk+20=;
 b=jLYsPCht53BbBPvCLBX7vJV6PINryAZgCRXzsMAxSKWaYRvQhqGVYvTGgNhItgzA6Pcz+T
 m/2FtOYphmq/7oDw9Jpx7BiM+gJQ/lqxgJndcVItpFFyj/HFYNasZoKFVZUTrwnn7re37F
 XDnIkSXxrRjo9WCC+O5sEVfv9vMCgpI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ge6UGYGLO0aycEdiSe_5Ww-1; Tue, 07 May 2024 01:57:44 -0400
X-MC-Unique: ge6UGYGLO0aycEdiSe_5Ww-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-de5a8638579so5533987276.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 22:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715061463; x=1715666263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7eBcyek3WDFnvQvIljybn715jiil6QiLfvQlXQsk+20=;
 b=ti7RbDzcHuDn+nP3SvS45IkFFw+b+PHxB9v+FXLfekSccS505VQZxpPxnmJx9Igb7J
 9yzjqhn3L2n+jOidZy8jp9LPLoA3bWP8r+Rx2Ypx/bJgfa+SWdd/j9Xtqvyn6wHkMvAS
 jHGKVM0EAeGccr47qJw9BBx+ON3rsCfRFdbTwHjI1pYmdAk+B/XrUAl1uxHfN1xyuJXk
 6zIAIrd9cQObrU2GxYb4fnIvM2xwvqCRXYvDtEHiuH5TDk3zyKgwPKFC8VFlL4wNHfJ7
 oQXjJA68M2MM/nFSuZGnlm9MfgCb207Fx/GNbAIQ8cdBHprg88jJ/R0i6ixRA+1MVS/R
 vgIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUowgjrWfu36bEq7m4v72VJnY8yOFoQt7l9QHu4fZi3SFmd+YipevV/ELrcnLrkVsulZksGLzYfyJfbXZau4ESLXsbuqyw=
X-Gm-Message-State: AOJu0YwI2FbZBhlMv4qH0hCC92aK2flQx72pWFX8lhnxGFYUuvt9E4P6
 UQ3J1s4I11GNa0LTyEnuGASbK25ORdbCkKfb6w5EooKy4qkTGI2ozObenaIIC0fLN3njLw602Jf
 +5vkH9SCyo+ljHbaRX8CloXk3ixnGQdjRlFfYvGSI1AeR4cSNDQAt
X-Received: by 2002:a05:6902:2804:b0:dea:cc08:13f8 with SMTP id
 ed4-20020a056902280400b00deacc0813f8mr14524708ybb.43.1715061463200; 
 Mon, 06 May 2024 22:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUauof0sHJIX7t9ZrJLaZnrDefFAbTqc8Ny8RDFpYE0gZU+h0nnTiQtiKExYjtQ2Pu5i8aZA==
X-Received: by 2002:a05:6902:2804:b0:dea:cc08:13f8 with SMTP id
 ed4-20020a056902280400b00deacc0813f8mr14524694ybb.43.1715061462785; 
 Mon, 06 May 2024 22:57:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z13-20020ac86b8d000000b0043d7a0ae5a1sm1343790qts.79.2024.05.06.22.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 22:57:42 -0700 (PDT)
Message-ID: <faba937d-885b-4b2c-a98f-47146b053031@redhat.com>
Date: Tue, 7 May 2024 07:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vfio: Make VFIOIOMMUClass::attach_device() and its
 wrapper return bool
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
 <20240506083352.4037226-2-zhenzhong.duan@intel.com>
 <056f1ba7-a51b-4859-a80d-616c30e63e06@redhat.com>
 <SJ0PR11MB67443A9F217791EF4E6EA43792E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67443A9F217791EF4E6EA43792E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/7/24 04:09, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH 1/3] vfio: Make VFIOIOMMUClass::attach_device() and
>> its wrapper return bool
>>
>> On 5/6/24 10:33, Zhenzhong Duan wrote:
>>> Make VFIOIOMMUClass::attach_device() and its wrapper function
>>> vfio_attach_device() return bool.
>>>
>>> This is to follow the coding standand to return bool if 'Error **'
>>> is used to pass error.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h         |  4 ++--
>>>    include/hw/vfio/vfio-container-base.h |  4 ++--
>>>    hw/vfio/ap.c                          |  6 ++----
>>>    hw/vfio/ccw.c                         |  6 ++----
>>>    hw/vfio/common.c                      |  4 ++--
>>>    hw/vfio/container.c                   | 14 +++++++-------
>>>    hw/vfio/iommufd.c                     | 11 +++++------
>>>    hw/vfio/pci.c                         |  8 +++-----
>>>    hw/vfio/platform.c                    |  7 +++----
>>>    9 files changed, 28 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>> index b9da6c08ef..a7b6fc8f46 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -198,8 +198,8 @@ void vfio_region_exit(VFIORegion *region);
>>>    void vfio_region_finalize(VFIORegion *region);
>>>    void vfio_reset_handler(void *opaque);
>>>    struct vfio_device_info *vfio_get_device_info(int fd);
>>> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> -                       AddressSpace *as, Error **errp);
>>> +bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> +                        AddressSpace *as, Error **errp);
>>>    void vfio_detach_device(VFIODevice *vbasedev);
>>>
>>>    int vfio_kvm_device_add_fd(int fd, Error **errp);
>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>>> index 3582d5f97a..c839cfd9cb 100644
>>> --- a/include/hw/vfio/vfio-container-base.h
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -118,8 +118,8 @@ struct VFIOIOMMUClass {
>>>        int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>>>                         hwaddr iova, ram_addr_t size,
>>>                         IOMMUTLBEntry *iotlb);
>>> -    int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>> -                         AddressSpace *as, Error **errp);
>>> +    bool (*attach_device)(const char *name, VFIODevice *vbasedev,
>>> +                          AddressSpace *as, Error **errp);
>>>        void (*detach_device)(VFIODevice *vbasedev);
>>>        /* migration feature */
>>>        int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 7c4caa5938..d50600b702 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -156,7 +156,6 @@ static void
>> vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>>>    static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>    {
>>>        ERRP_GUARD();
>>> -    int ret;
>>>        Error *err = NULL;
>>>        VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>>>        VFIODevice *vbasedev = &vapdev->vdev;
>>> @@ -165,9 +164,8 @@ static void vfio_ap_realize(DeviceState *dev, Error
>> **errp)
>>>            return;
>>>        }
>>>
>>> -    ret = vfio_attach_device(vbasedev->name, vbasedev,
>>> -                             &address_space_memory, errp);
>>> -    if (ret) {
>>> +    if (!vfio_attach_device(vbasedev->name, vbasedev,
>>> +                            &address_space_memory, errp)) {
>>>            goto error;
>>>        }
>>>
>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>> index 90e4a53437..782bd4bed7 100644
>>> --- a/hw/vfio/ccw.c
>>> +++ b/hw/vfio/ccw.c
>>> @@ -580,7 +580,6 @@ static void vfio_ccw_realize(DeviceState *dev,
>> Error **errp)
>>>        S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>>>        VFIODevice *vbasedev = &vcdev->vdev;
>>>        Error *err = NULL;
>>> -    int ret;
>>>
>>>        /* Call the class init function for subchannel. */
>>>        if (cdc->realize) {
>>> @@ -594,9 +593,8 @@ static void vfio_ccw_realize(DeviceState *dev,
>> Error **errp)
>>>            return;
>>>        }
>>>
>>> -    ret = vfio_attach_device(cdev->mdevid, vbasedev,
>>> -                             &address_space_memory, errp);
>>> -    if (ret) {
>>> +    if (!vfio_attach_device(cdev->mdevid, vbasedev,
>>> +                            &address_space_memory, errp)) {
>>>            goto out_attach_dev_err;
>>>        }
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 8f9cbdc026..890d30910e 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1492,8 +1492,8 @@ retry:
>>>        return info;
>>>    }
>>>
>>> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> -                       AddressSpace *as, Error **errp)
>>> +bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>> +                        AddressSpace *as, Error **errp)
>>>    {
>>>        const VFIOIOMMUClass *ops =
>>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>
>>
>> I think vfio_attach_device() can be cleaned up a little further :
>>
>>     ret = ops->attach_device(name, vbasedev, as, errp);
>>      if (ret < 0) {
>>          return ret;
>>      }
> 
> Not understand this.
> I have both ops->attach_device() and vfio_attach_device() return bool
> in this patch. Do you mean drop the change for ops->attach_device()?
> Or split the two changes?

The return value of ops->attach_device() should be tested as a bool now
and not as an int, as it is still currently done.

See the fix here :
      https://gitlab.com/legoater/qemu/-/commit/abae88dc28e723745fe2ff506ea9f0adeb47afdb

Please simply fold the changes in this patch.

Thanks,

C.


>>
>>
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 77bdec276e..ea3b145913 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -908,8 +908,8 @@ static int vfio_device_groupid(VFIODevice
>> *vbasedev, Error **errp)
>>>     * @name and @vbasedev->name are likely to be different depending
>>>     * on the type of the device, hence the need for passing @name
>>>     */
>>> -static int vfio_legacy_attach_device(const char *name, VFIODevice
>> *vbasedev,
>>> -                                     AddressSpace *as, Error **errp)
>>> +static bool vfio_legacy_attach_device(const char *name, VFIODevice
>> *vbasedev,
>>> +                                      AddressSpace *as, Error **errp)
>>>    {
>>>        int groupid = vfio_device_groupid(vbasedev, errp);
>>>        VFIODevice *vbasedev_iter;
>>> @@ -918,27 +918,27 @@ static int vfio_legacy_attach_device(const char
>> *name, VFIODevice *vbasedev,
>>>        int ret;
>>>
>>>        if (groupid < 0) {
>>> -        return groupid;
>>> +        return false;
>>>        }
>>>
>>>        trace_vfio_attach_device(vbasedev->name, groupid);
>>>
>>>        group = vfio_get_group(groupid, as, errp);
>>>        if (!group) {
>>> -        return -ENOENT;
>>> +        return false;
>>>        }
>>>
>>>        QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>>>            if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>>>                error_setg(errp, "device is already attached");
>>>                vfio_put_group(group);
>>> -            return -EBUSY;
>>> +            return false;
>>>            }
>>>        }
>>>        ret = vfio_get_device(group, name, vbasedev, errp);
>>>        if (ret) {
>>
>> vfio_get_device() would be the next candidate for cleanup.
> 
> Yes.
> 
>>
>>>            vfio_put_group(group);
>>> -        return ret;
>>> +        return false;
>>>        }
>>>
>>>        bcontainer = &group->container->bcontainer;
>>> @@ -946,7 +946,7 @@ static int vfio_legacy_attach_device(const char
>> *name, VFIODevice *vbasedev,
>>>        QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev,
>> container_next);
>>>        QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>>>
>>> -    return ret;
>>> +    return true;
>>>    }
>>>
>>>    static void vfio_legacy_detach_device(VFIODevice *vbasedev)
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 8827ffe636..9aa0dd6d8e 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -301,8 +301,8 @@ error:
>>>        return ret;
>>>    }
>>>
>>> -static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>> -                               AddressSpace *as, Error **errp)
>>> +static bool iommufd_cdev_attach(const char *name, VFIODevice
>> *vbasedev,
>>> +                                AddressSpace *as, Error **errp)
>>>    {
>>>        VFIOContainerBase *bcontainer;
>>>        VFIOIOMMUFDContainer *container;
>>> @@ -317,7 +317,7 @@ static int iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>>        if (vbasedev->fd < 0) {
>>>            devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>>>            if (devfd < 0) {
>>> -            return devfd;
>>> +            return false;
>>>            }
>>>            vbasedev->fd = devfd;
>>>        } else {
>>> @@ -394,7 +394,6 @@ static int iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>>        memory_listener_register(&bcontainer->listener, bcontainer->space-
>>> as);
>>>
>>>        if (bcontainer->error) {
>>> -        ret = -1;
>>>            error_propagate_prepend(errp, bcontainer->error,
>>>                                    "memory listener initialization failed: ");
>>>            goto err_listener_register;
>>> @@ -433,7 +432,7 @@ found_container:
>>>
>>>        trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev-
>>> num_irqs,
>>>                                       vbasedev->num_regions, vbasedev->flags);
>>> -    return 0;
>>> +    return true;
>>>
>>>    err_listener_register:
>>>        iommufd_cdev_ram_block_discard_disable(false);
>>> @@ -446,7 +445,7 @@ err_alloc_ioas:
>>>        iommufd_cdev_unbind_and_disconnect(vbasedev);
>>>    err_connect_bind:
>>>        close(vbasedev->fd);
>>> -    return ret;
>>> +    return false;
>>>    }
>>>
>>>    static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 64780d1b79..952e4b1a25 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2951,7 +2951,7 @@ static void vfio_realize(PCIDevice *pdev, Error
>> **errp)
>>>        int i, ret;
>>>        bool is_mdev;
>>>        char uuid[UUID_STR_LEN];
>>> -    char *name;
>>> +    g_autofree char *name = NULL;
>>>
>>>        if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>>>            if (!(~vdev->host.domain || ~vdev->host.bus ||
>>> @@ -3001,10 +3001,8 @@ static void vfio_realize(PCIDevice *pdev, Error
>> **errp)
>>>            name = g_strdup(vbasedev->name);
>>>        }
>>>
>>> -    ret = vfio_attach_device(name, vbasedev,
>>> -                             pci_device_iommu_address_space(pdev), errp);
>>> -    g_free(name);
>>
>> This change would deserve another patch.
> 
> Will do.
> 
> Thanks
> Zhenzhong


