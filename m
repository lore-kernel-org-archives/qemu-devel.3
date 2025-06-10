Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0786AC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 06:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOsD1-0005Lp-5S; Tue, 10 Jun 2025 02:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsCz-0005LP-Fe
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsCw-0008Lo-VU
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749535897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u1v8HajsCrDp9Ki2iOFGEbnnrwNu9n0O67uCAIUvDLo=;
 b=TGJcVW/AoNChckRYmkNmC9tVOVyJ+x4rOksvvhuDzCIosGNB0mYAMhvg4+M2PIbipFkHx5
 nbVxwsId7/Ts8wM9gRHeNWgQ8q5uNtHWGAeBte2YWZhQkwAiUg1SiH736rpCiBBMHHgHwl
 SzGG0zkMYrGctl6G/Lij3KJsQazVOq0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-AUdqTWqyOvmetLefv9JiSA-1; Tue, 10 Jun 2025 02:11:36 -0400
X-MC-Unique: AUdqTWqyOvmetLefv9JiSA-1
X-Mimecast-MFC-AGG-ID: AUdqTWqyOvmetLefv9JiSA_1749535895
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450df53d461so40920445e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 23:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749535895; x=1750140695;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1v8HajsCrDp9Ki2iOFGEbnnrwNu9n0O67uCAIUvDLo=;
 b=Y5cCypw4fgtAznCkEAJToCCP4pSSshBbfgpQzJTf4Uc27JpoPosTqFp3Byuq/KA7q7
 qNOVpNTjCJJC0wLaUZLgbCQJOMHDyYmX/GU5f2ygJCCOl67WroREH3iKjvgqGK4TiK8p
 7qkWJVl/jSKspUKJQC8kw1NxyqTEy5l4IHDxhZ8oyXprors8Ue7eR7fYuy7u63pV0eS2
 A++4qy8P7+LolHlR0YtO62Fijy3PvjS7po+tebHLvViq9QIs8SFn/aFq2TLwtELxWEzf
 SxkQF8i2CDFpBvN111yl0AbYW2pJpOFYodDAnVICopRqtkfXs+WPVHGPme2qb3h+92XP
 7LAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD7QKEF5OE1O6rc4omrruWhVnhcRsVbASXTRd80z2H6DLG5/PJSXhQvwCaAWoMWxgcmmpydv4aTKSn@nongnu.org
X-Gm-Message-State: AOJu0YzAvD9iGxr64xtAmo3N0L/1vtkyFzjie7Q5p2+o+lB9mNhSCViy
 FDhtDBdJGDE0xiWQncmePCqCxjt8qCO85EtIkIYP5s07hRB6EKwdKyJU8IKkVpnTbv8+J5sOxdd
 NxFMNgeFPLPBCkxXF2BXvOq/bVtB23s+h0f+PC9zf4elKQCo/T2CIEOrL
X-Gm-Gg: ASbGncvJyaKEle/tQY1rLNHCvHM/Xv+FkZ94ySTm+fjTgo9QTYL+AK64b+r2Ip26n+K
 o5LRlf51ehS96MJ+8DdsU00jjlnKkFcJYcOhpAtDLnhT/JKjP7QCQYSTTCb7hl/dJm93YTvB+TM
 +MzJtgZtq4n9ZEjmfaeB8CryBHzjUnmvXppVr8IAp3oXuXsDDryVEHMPWlh0NZhlkdE99a46lj1
 miQInD0+M4qw3dBXnOBZq8y2BD2G1tIhngSqMrzoDH5+AS6VEeETLKb6kYnkKSau6QcBc2jZ6sS
 AIg37bFOlTEvyVysSNuNol9a404r+3aT2j1tijwr6xCy4YqaQgJMPPhtKoch
X-Received: by 2002:a05:600c:c178:b0:442:dcdc:41c8 with SMTP id
 5b1f17b1804b1-4520147f531mr120326845e9.19.1749535894595; 
 Mon, 09 Jun 2025 23:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVZokqKMEj+1o4ejrXFsKyo5I7LVSIE4i7EYwa1iwmqZ1KzWbelhliPLDIxnC+j6SPS+ztjw==
X-Received: by 2002:a05:600c:c178:b0:442:dcdc:41c8 with SMTP id
 5b1f17b1804b1-4520147f531mr120326655e9.19.1749535894146; 
 Mon, 09 Jun 2025 23:11:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323a8acasm11075691f8f.26.2025.06.09.23.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 23:11:33 -0700 (PDT)
Message-ID: <6f77f151-909f-4a91-8adf-e50896359394@redhat.com>
Date: Tue, 10 Jun 2025 08:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 35/43] vfio/iommufd: register container for cpr
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-36-git-send-email-steven.sistare@oracle.com>
 <d94fc70b-2275-4c69-b163-6a3e3ff40f88@redhat.com>
 <a97f25cb-b543-44ad-b38d-76a086c55606@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a97f25cb-b543-44ad-b38d-76a086c55606@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/9/25 22:47, Steven Sistare wrote:
> On 6/9/2025 4:30 PM, Cédric Le Goater wrote:
>> On 5/29/25 21:24, Steve Sistare wrote:
>>> Register a vfio iommufd container and device for CPR, replacing the generic
>>> CPR register call with a more specific iommufd register call.  Add a
>>> blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.
>>>
>>> This is mostly boiler plate.  The fields to to saved and restored are added
>>> in subsequent patches.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   include/hw/vfio/vfio-cpr.h | 12 +++++++
>>>   include/system/iommufd.h   |  1 +
>>>   backends/iommufd.c         | 10 ++++++
>>>   hw/vfio/cpr-iommufd.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/iommufd.c          |  6 ++--
>>>   hw/vfio/meson.build        |  1 +
>>>   6 files changed, 112 insertions(+), 2 deletions(-)
>>>   create mode 100644 hw/vfio/cpr-iommufd.c
>>>
>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>> index 170a116..b9b77ae 100644
>>> --- a/include/hw/vfio/vfio-cpr.h
>>> +++ b/include/hw/vfio/vfio-cpr.h
>>> @@ -15,7 +15,10 @@
>>>   struct VFIOContainer;
>>>   struct VFIOContainerBase;
>>>   struct VFIOGroup;
>>> +struct VFIODevice;
>>>   struct VFIOPCIDevice;
>>> +struct VFIOIOMMUFDContainer;
>>> +struct IOMMUFDBackend;
>>>   typedef struct VFIOContainerCPR {
>>>       Error *blocker;
>>> @@ -43,6 +46,15 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>>                                    Error **errp);
>>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>> +bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
>>> +                                         Error **errp);
>>> +void vfio_iommufd_cpr_unregister_container(
>>> +    struct VFIOIOMMUFDContainer *container);
>>> +bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be, Error **errp);
>>> +void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
>>> +void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>>> +void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>>> +
>>>   int vfio_cpr_group_get_device_fd(int d, const char *name);
>>>   bool vfio_cpr_container_match(struct VFIOContainer *container,
>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>> index db9ed53..3c58ea8 100644
>>> --- a/include/system/iommufd.h
>>> +++ b/include/system/iommufd.h
>>> @@ -32,6 +32,7 @@ struct IOMMUFDBackend {
>>>       /*< protected >*/
>>>       int fd;            /* /dev/iommu file descriptor */
>>>       bool owned;        /* is the /dev/iommu opened internally */
>>> +    Error *cpr_blocker;/* set if be does not support CPR */
>>>       uint32_t users;
>>>       /*< public >*/
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index ed8bb4c..2e9d6cb 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -108,6 +108,13 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>>>           }
>>>           be->fd = fd;
>>>       }
>>> +    if (!be->users && !vfio_iommufd_cpr_register_iommufd(be, errp)) {
>>> +        if (be->owned) {
>>> +            close(be->fd);
>>> +            be->fd = -1;
>>> +        }
>>> +        return false;
>>> +    }
>>>       be->users++;
>>>       trace_iommufd_backend_connect(be->fd, be->owned, be->users);
>>> @@ -125,6 +132,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
>>>           be->fd = -1;
>>>       }
>>>   out:
>>> +    if (!be->users) {
>>> +        vfio_iommufd_cpr_unregister_iommufd(be);
>>> +    }
>>>       trace_iommufd_backend_disconnect(be->fd, be->users);
>>>   }
>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>> new file mode 100644
>>> index 0000000..60bd7e8
>>> --- /dev/null
>>> +++ b/hw/vfio/cpr-iommufd.c
>>> @@ -0,0 +1,84 @@
>>> +/*
>>> + * Copyright (c) 2024-2025 Oracle and/or its affiliates.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "hw/vfio/vfio-cpr.h"
>>> +#include "migration/blocker.h"
>>> +#include "migration/cpr.h"
>>> +#include "migration/migration.h"
>>> +#include "migration/vmstate.h"
>>> +#include "system/iommufd.h"
>>> +#include "vfio-iommufd.h"
>>> +
>>> +static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>>> +{
>>> +    if (!iommufd_change_process_capable(be)) {
>>> +        if (errp) {
>>> +            error_setg(errp, "vfio iommufd backend does not support "
>>> +                       "IOMMU_IOAS_CHANGE_PROCESS");
>>> +        }
>>> +        return false;
>>> +    }
>>> +    return true;
>>> +}
>>> +
>>> +static const VMStateDescription iommufd_cpr_vmstate = {
>>> +    .name = "iommufd",
>>> +    .version_id = 0,
>>> +    .minimum_version_id = 0,
>>> +    .needed = cpr_incoming_needed,
>>> +    .fields = (VMStateField[]) {
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>> +bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
>>> +{
>>> +    Error **cpr_blocker = &be->cpr_blocker;
>>> +
>>> +    if (!vfio_cpr_supported(be, cpr_blocker)) {
>>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>>> +    }
>>> +
>>> +    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
>>> +{
>>> +    vmstate_unregister(NULL, &iommufd_cpr_vmstate, be);
>>> +    migrate_del_blocker(&be->cpr_blocker);
>>> +}
>>> +
>>> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
>>> +                                         Error **errp)
>>> +{
>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>> +
>>> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>>> +                                vfio_cpr_reboot_notifier,
>>> +                                MIG_MODE_CPR_REBOOT);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
>>> +{
>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>> +
>>> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>>> +}
>>> +
>>> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
>>> +{
>>> +}
>>> +
>>> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
>>> +{
>>> +}
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index ca00d08..c690c2c 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -446,7 +446,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>>>       if (!QLIST_EMPTY(&bcontainer->device_list)) {
>>>           return;
>>>       }
>>> -    vfio_cpr_unregister_container(bcontainer);
>>> +    vfio_iommufd_cpr_unregister_container(container);
>>>       vfio_listener_unregister(bcontainer);
>>>       iommufd_backend_free_id(container->be, container->ioas_id);
>>>       object_unref(container);
>>> @@ -592,7 +592,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>>           goto err_listener_register;
>>>       }
>>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>>> +    if (!vfio_iommufd_cpr_register_container(container, errp)) {
>>>           goto err_listener_register;
>>>       }
>>> @@ -619,6 +619,7 @@ found_container:
>>>       }
>>>       vfio_device_prepare(vbasedev, bcontainer, &dev_info);
>>> +    vfio_iommufd_cpr_register_device(vbasedev);
>>>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>>>                                      vbasedev->num_regions, vbasedev->flags);
>>> @@ -656,6 +657,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>>       iommufd_cdev_container_destroy(container);
>>>       vfio_address_space_put(space);
>>> +    vfio_iommufd_cpr_unregister_device(vbasedev);
>>>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>>>       close(vbasedev->fd);
>>>   }
>>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>>> index 98134a7..12711fb 100644
>>> --- a/hw/vfio/meson.build
>>> +++ b/hw/vfio/meson.build
>>> @@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>>>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>>>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>>>     'cpr.c',
>>> +  'cpr-iommufd.c',
>>
>> This file should be compiled under CONFIG_IOMMUFD.
> 
> Sure, will fix.
> Tomorrow I plan to rebase to the lastest master, add this and the few other
> comments that came up for V4, and send V5.  Sound OK?
Please check compile on windows too.


Thanks,

C.





