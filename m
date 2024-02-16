Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE4FC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ray13-0007Yy-Nc; Fri, 16 Feb 2024 08:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ray11-0007YG-V6
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:12:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ray0z-0002Ee-9b
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708089148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UJnlXBVKDFPTtOjkYDA8LFAc/zxFfBoy4m8zfCR8hk=;
 b=g5t09qorJCfDNKVUJptRwnSaEdv2z+XY3Sm31rVETUbcFw55/XzxqCeawseVKuMjjlnoCJ
 Mtb70o5Vv449kjSGMBM/yojwe5Gzfh5o3qHsB7ZX9rWaEgtslUjSsoClswTVHEi9IH138Q
 4q31dv34q31KpwXBl3FZxqXDrbcl3tc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-X5RQenVgPUu5y2K8jwjM_g-1; Fri, 16 Feb 2024 08:12:24 -0500
X-MC-Unique: X5RQenVgPUu5y2K8jwjM_g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68efdf7e047so23529486d6.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089144; x=1708693944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9UJnlXBVKDFPTtOjkYDA8LFAc/zxFfBoy4m8zfCR8hk=;
 b=lvmYxtpAMmOZepeM0e39FdWWPFDgyjwqmvacfikq0r8PM2vAidqHK7FcVUKrxrxzZ0
 skNcUzrFb4RT4WswJG+vq7JbV/7D+8RuZRbcdWoRued+tIEFNMYHwO4Ex2vota3oVkN5
 WvqDwAiNEz3L1ur6sWiweSvh7pdCaTH77v1V6bLlzSfA8vHJM5KN577iCvg34VQFYq37
 5k/S5PUEEPZ9F4E2SSjgKdw6XBt6/oQMed3ku8+Vgf7R9uM7iH5dz3SZ13mGL8I9nb+D
 f/obu5I/N3Udq7vaUng6uRx7NhlS/5PMkgs9hpyrE8Vw3vLvfmmw/I5wQwqQR3ghkm7Z
 1ZGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6o/ZMOCXDvLk6AwXdEBvUtZ/MajxGPYVhr2BS8ZCIBJlj6CUrGgMIzUAmBNICtW+pPR3Wfkx7Cpw8OG2tTkA6PHtLEDY=
X-Gm-Message-State: AOJu0YxXJvdnZL1O0ssB9ZU66ZevD4bx+EhGVensfJseZSfc7x8MGd4e
 38nJe7LXgd5KytCDFcrxNFa2syMyf9MupXsriObfAOTAt71S7NQ098Yvit5VBuwb/8Px/kruQv5
 cS7C4BJok2SbAimHeavSkdU3JlXQiZg0odiIMYxb2OXl+XtKXbgW3
X-Received: by 2002:a05:6214:c6e:b0:68f:2f35:d957 with SMTP id
 t14-20020a0562140c6e00b0068f2f35d957mr2444039qvj.16.1708089144342; 
 Fri, 16 Feb 2024 05:12:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC2nBuJ1nCyxAhz6UJZBSs6SnflMlp9ipwqd77UUcc4OoX6OtacJWA0N6xdaEdSW6ESqNIag==
X-Received: by 2002:a05:6214:c6e:b0:68f:2f35:d957 with SMTP id
 t14-20020a0562140c6e00b0068f2f35d957mr2444014qvj.16.1708089143963; 
 Fri, 16 Feb 2024 05:12:23 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:f59e:918a:6675:6332?
 ([2a01:cb19:853d:fa00:f59e:918a:6675:6332])
 by smtp.gmail.com with ESMTPSA id
 ny4-20020a056214398400b006862b537412sm1737861qvb.123.2024.02.16.05.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 05:12:23 -0800 (PST)
Message-ID: <2c689be3-126a-4da8-b173-c29b8c8af5e0@redhat.com>
Date: Fri, 16 Feb 2024 14:12:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] vfio: Extend vfio_set_migration_error() with Error*
 argument
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-12-clg@redhat.com>
 <addd8e61-535e-4a7f-976a-8e0c57cfe944@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <addd8e61-535e-4a7f-976a-8e0c57cfe944@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Avihai,

On 2/12/24 10:35, Avihai Horon wrote:
> Hi Cedric,
> 
> On 07/02/2024 15:33, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> vfio_set_migration_error() sets the 'return' error on the migration
>> stream if a migration is in progress. To improve error reporting, add
>> a new Error* argument to also set the Error object on the migration
>> stream.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/common.c | 50 +++++++++++++++++++++++++++++-------------------
>>   1 file changed, 30 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 82173b039c47150f5edd05d329192c5b9c8a9a0f..afe8b6bd294fd5904f394a5db48aae3fd718b14e 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -148,16 +148,18 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>>       return vbasedev->bcontainer->space->as != &address_space_memory;
>>   }
>>
>> -static void vfio_set_migration_error(int err)
>> +static void vfio_set_migration_error(int ret, Error *err)
>>   {
>>       MigrationState *ms = migrate_get_current();
>>
>>       if (migration_is_setup_or_active(ms->state)) {
>>           WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>>               if (ms->to_dst_file) {
>> -                qemu_file_set_error(ms->to_dst_file, err);
>> +                qemu_file_set_error_obj(ms->to_dst_file, ret, err);
>>               }
>>           }
>> +    } else {
>> +        error_report_err(err);
>>       }
>>   }
>>
>> @@ -296,15 +298,17 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>>       void *vaddr;
>> +    Error *local_err = NULL;
>>       int ret;
>>
>>       trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
>>                                   iova, iova + iotlb->addr_mask);
>>
>>       if (iotlb->target_as != &address_space_memory) {
>> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
>> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
>> -        vfio_set_migration_error(-EINVAL);
>> +        error_setg(&local_err,
>> +                   "Wrong target AS \"%s\", only system memory is allowed",
>> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
>> +        vfio_set_migration_error(-EINVAL, local_err);
>>           return;
>>       }
>>
>> @@ -336,11 +340,12 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>           ret = vfio_container_dma_unmap(bcontainer, iova,
>>                                          iotlb->addr_mask + 1, iotlb);
>>           if (ret) {
>> -            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>> -                         "0x%"HWADDR_PRIx") = %d (%s)",
>> -                         bcontainer, iova,
>> -                         iotlb->addr_mask + 1, ret, strerror(-ret));
>> -            vfio_set_migration_error(ret);
>> +            error_setg(&local_err,
>> +                       "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>> +                       "0x%"HWADDR_PRIx") = %d (%s)",
>> +                       bcontainer, iova,
>> +                       iotlb->addr_mask + 1, ret, strerror(-ret));
>> +            vfio_set_migration_error(ret, local_err);
>>           }
>>       }
>>   out:
>> @@ -1224,13 +1229,15 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>>       ram_addr_t translated_addr;
>> +    Error *local_err = NULL;
>>       int ret = -EINVAL;
>>
>>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>>
>>       if (iotlb->target_as != &address_space_memory) {
>> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
>> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
>> +        error_setg(&local_err,
>> +                   "Wrong target AS \"%s\", only system memory is allowed",
>> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
>>           goto out;
>>       }
>>
>> @@ -1239,17 +1246,18 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>           ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>                                       translated_addr);
> 
> If vfio_get_xlat_addr() above (it's not shown here) returns false, we will pass a NULL local_err to vfio_set_migration_error() and it may de-reference NULL ptr in error_report_err().

Ah yes. Thanks for spotting this.

> 
> Should we refactor vfio_get_xlat_addr() to get errp, 

I think we should add an Error** parameter to vfio_get_xlat_addr() and
memory_get_xlat_addr(). It shouldn't be too much change and would be
cleaner.

Thanks,

C.


> or add an else branch below, setting -EINVAL (and removing the default -EINVAL from the top of the function)?
> 
> Thanks.
> 
>>           if (ret) {
>> -            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>> -                         "0x%"HWADDR_PRIx") = %d (%s)",
>> -                         bcontainer, iova, iotlb->addr_mask + 1, ret,
>> -                         strerror(-ret));
>> +            error_setg(&local_err,
>> +                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>> +                       "0x%"HWADDR_PRIx") = %d (%s)",
>> +                       bcontainer, iova, iotlb->addr_mask + 1, ret,
>> +                       strerror(-ret));
>>           }
>>       }
>>       rcu_read_unlock();
>>
>>   out:
>>       if (ret) {
>> -        vfio_set_migration_error(ret);
>> +        vfio_set_migration_error(ret, local_err);
>>       }
>>   }
>>
>> @@ -1345,6 +1353,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>>   {
>>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>                                                    listener);
>> +    Error *local_err = NULL;
>>       int ret;
>>
>>       if (vfio_listener_skipped_section(section)) {
>> @@ -1354,9 +1363,10 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>>       if (vfio_devices_all_dirty_tracking(bcontainer)) {
>>           ret = vfio_sync_dirty_bitmap(bcontainer, section);
>>           if (ret) {
>> -            error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
>> -                         strerror(-ret));
>> -            vfio_set_migration_error(ret);
>> +            error_setg(&local_err,
>> +                       "vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
>> +                       strerror(-ret));
>> +            vfio_set_migration_error(ret, local_err);
>>           }
>>       }
>>   }
>> -- 
>> 2.43.0
>>
>>
> 


