Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03013C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WuP-0004JZ-Tg; Mon, 13 May 2024 10:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6WuN-0004Dj-TZ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6WuL-0004ec-8R
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715611444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO5X2B/bzYGp9O63azdE6TUarRQLzp4GFEWvkg2422A=;
 b=PWyhuT7W63dxa9a0NlV3Uge7mQLsGEUOZUBK8GY1hIGxnKD/CJpCw8KGg4k9n61K5y3bU5
 9tmO2w3H2ottht0wiCvYfUfso27skf9evzEwWqcwdJJX9DuGCDb9Aae3CJM0ZjGHFpNZ9L
 WEPNmTXw1EIGXO3NdFxHsdYOsZ0NmUY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Tf7ow1PzOo2Hem50SBFmrA-1; Mon, 13 May 2024 10:44:03 -0400
X-MC-Unique: Tf7ow1PzOo2Hem50SBFmrA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43e0e0dab52so34431141cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715611442; x=1716216242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TO5X2B/bzYGp9O63azdE6TUarRQLzp4GFEWvkg2422A=;
 b=X2MGZUKTe7ZjPyldP7HLrNz3LNEsRa1sY9gOgeSZG5tCSYV43tgb2+NZLin1/8wXBu
 9SSwJ21Mo3v1wSF721Jmv0tboZGIIw3gIPbTnPzdJiI7JssqHd9IfV7FrPm4UORx4wOZ
 52kP5yfM/lpr3FNRpDFfSIgHtA4XtlMDw7Gxx7oJLHrtrrbgxQpTAKjKEMzgiNtX3FyS
 EuZylB/aib8uxvK2hlifR5WPCtCDMC43kUyS613lCX8JxuiZj6JjP7Yccs/Z1O5AI3/T
 9lZCwY2hCs5UsdoxBNEJ434lSB4kx2G/avdEE+cBMu11yTnq3AcU9d3GyU4nAPtVtZtM
 c15A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0OWK80Er5Nds3SSC/xB8jBupu/kAAd9JTBq3TL2YdCHdgdkbFrvbRlSDfh7wHF0yIKTg3kLHMJbCKo2ikZ0EaAOqt/XU=
X-Gm-Message-State: AOJu0Yw5D0eNrQ5yQVFnlI5AfD1rx/1RDDsK/VmWdM4PTjxz+W0DvHcm
 hsNCNfk2N1xg1AIc4kEcPXAccxn8y1ukOXPUU20975tG5mwL0zrNA0PV5EJLGeEtZLQooFy/8An
 9Te8NCbfJi6R8/F8PM6NvaaLgci4/jPc/OFPLVjglF+O5HTxc61nh
X-Received: by 2002:ac8:5acb:0:b0:43a:c90b:34e5 with SMTP id
 d75a77b69052e-43dfce5dc1dmr181448271cf.34.1715611442388; 
 Mon, 13 May 2024 07:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH7o/mMaHjRn28tx3xpxMoahuzY/N5F/jmcc+Tbo9/RVT8rhuMKz5QoRGa91NKFu7nWqOIDw==
X-Received: by 2002:ac8:5acb:0:b0:43a:c90b:34e5 with SMTP id
 d75a77b69052e-43dfce5dc1dmr181447861cf.34.1715611441985; 
 Mon, 13 May 2024 07:44:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e1a021d02sm12601411cf.52.2024.05.13.07.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:44:01 -0700 (PDT)
Message-ID: <81662c99-96c7-431d-b2a4-4ae9f2cae6a9@redhat.com>
Date: Mon, 13 May 2024 16:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/migration: Emit VFIO migration QAPI event
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
 <20240509090954.16447-3-avihaih@nvidia.com>
 <8fe65dfe-dd9c-47c0-8769-3479484b3e5e@redhat.com>
 <d4252893-905f-46ec-8113-a39ef5623d34@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <d4252893-905f-46ec-8113-a39ef5623d34@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

On 5/13/24 16:34, Avihai Horon wrote:
> 
> On 13/05/2024 17:01, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 5/9/24 11:09, Avihai Horon wrote:
>>> Emit VFIO migration QAPI event when a VFIO device changes its migration
>>> state. This can be used by management applications to get updates on the
>>> current state of the VFIO device for their own purposes.
>>>
>>> A new per VFIO device capability, "migration-events", is added so events
>>> can be enabled only for the required devices. It is disabled by default.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   include/hw/vfio/vfio-common.h |  1 +
>>>   hw/vfio/migration.c           | 56 +++++++++++++++++++++++++++++++++--
>>>   hw/vfio/pci.c                 |  2 ++
>>>   3 files changed, 56 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index b9da6c08ef..3ec5f2425e 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>>       bool no_mmap;
>>>       bool ram_block_discard_allowed;
>>>       OnOffAuto enable_migration;
>>> +    bool migration_events;
>>>       VFIODeviceOps *ops;
>>>       unsigned int num_irqs;
>>>       unsigned int num_regions;
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 06ae40969b..5a359c4c78 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -24,6 +24,7 @@
>>>   #include "migration/register.h"
>>>   #include "migration/blocker.h"
>>>   #include "qapi/error.h"
>>> +#include "qapi/qapi-events-vfio.h"
>>>   #include "exec/ramlist.h"
>>>   #include "exec/ram_addr.h"
>>>   #include "pci.h"
>>> @@ -80,6 +81,55 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>>>       }
>>>   }
>>>
>>> +static VfioMigrationState
>>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>> +{
>>> +    switch (state) {
>>> +    case VFIO_DEVICE_STATE_STOP:
>>> +        return QAPI_VFIO_MIGRATION_STATE_STOP;
>>> +    case VFIO_DEVICE_STATE_RUNNING:
>>> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING;
>>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>>> +        return QAPI_VFIO_MIGRATION_STATE_STOP_COPY;
>>> +    case VFIO_DEVICE_STATE_RESUMING:
>>> +        return QAPI_VFIO_MIGRATION_STATE_RESUMING;
>>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>>> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING_P2P;
>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>>> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
>>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>>> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
>>> +    default:
>>> +        g_assert_not_reached();
>>> +    }
>>> +}
>>> +
>>> +static void vfio_migration_send_event(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    DeviceState *dev = vbasedev->dev;
>>> +    g_autofree char *qom_path = NULL;
>>> +    Object *obj;
>>> +
>>> +    if (!vbasedev->migration_events) {
>>> +        return;
>>> +    }
>>
>> I would add an assert on vbasedev->ops->vfio_get_object
>>
>>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>>
>> and another assert on obj.
> 
> vfio_migration_init() already checks these:
> 
>      if (!vbasedev->ops->vfio_get_object) {
>          return -EINVAL;
>      }
> 
>      obj = vbasedev->ops->vfio_get_object(vbasedev);
>      if (!obj) {
>          return -EINVAL;
>      }
> 
> Do you think these checks in migration init are enough?

I am sure they are today. These extra asserts are to avoid issues if
the code is moved around or if anyone finds inspiration by reading
vfio_migration_send_event().

Thanks,

C.



> 
>>
>>> +    qom_path = object_get_canonical_path(obj);
>>> +
>>> +    qapi_event_send_vfio_migration(
>>> +        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
>>> +}
>>> +
>>> +static void set_state(VFIODevice *vbasedev, enum vfio_device_mig_state state)
>>
>> to avoid the conflict with vfio_migration_set_state(), let's call it :
>> vfio_migration_set_device_state() ? We want a 'vfio_migration_' prefix.
> 
> Sure, I will rename to that.
> 
> Thanks.
> 
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    migration->device_state = state;
>>> +    vfio_migration_send_event(vbasedev);
>>> +}
>>> +
>>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>>                                       enum vfio_device_mig_state new_state,
>>>                                       enum vfio_device_mig_state recover_state)
>>> @@ -125,12 +175,12 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>>               goto reset_device;
>>>           }
>>>
>>> -        migration->device_state = recover_state;
>>> +        set_state(vbasedev, recover_state);
>>>
>>>           return ret;
>>>       }
>>>
>>> -    migration->device_state = new_state;
>>> +    set_state(vbasedev, new_state);
>>>       if (mig_state->data_fd != -1) {
>>>           if (migration->data_fd != -1) {
>>>               /*
>>> @@ -156,7 +206,7 @@ reset_device:
>>>                    strerror(errno));
>>>       }
>>>
>>> -    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>>> +    set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
>>>
>>>       return ret;
>>>   }
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 64780d1b79..8840602c50 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>>> +                     vbasedev.migration_events, false),
>>>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>>                        vbasedev.ram_block_discard_allowed, false),
>>
> 


