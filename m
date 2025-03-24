Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C90FC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 15:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twjga-0001fw-MZ; Mon, 24 Mar 2025 11:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twjgY-0001fh-Mj
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 11:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twjgO-000885-BX
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 11:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742829941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UwJHzHAoOmA6QsgQibYLUf7l043koZkj96LrEAuIk1g=;
 b=Vi9rc9rH1Ye6guF46nC7J/NY+fWNTAT5gMsD/vWUYJl8Cx/eAPRwr7WfZZWRh9d1TQH4e+
 8Ph4sdR76LgWXxH9C2t/1gu3gczb+lp+WF5k9DwUfbjLkcxoJ/dsMdxO4+C8hCk4/eOn5f
 qQqFshQOpRxUrfjZ6sdPwd5AudKfEv4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-nZ7tiUlLMsaipEXqgTbSbA-1; Mon, 24 Mar 2025 11:25:36 -0400
X-MC-Unique: nZ7tiUlLMsaipEXqgTbSbA-1
X-Mimecast-MFC-AGG-ID: nZ7tiUlLMsaipEXqgTbSbA_1742829935
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso2700428f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 08:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742829934; x=1743434734;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwJHzHAoOmA6QsgQibYLUf7l043koZkj96LrEAuIk1g=;
 b=befZBj9Sjp9t+0gCMGkre2QJYg+m8jRIfutJw0NVbrU6ku1KlpvvdrQmW6C2mvAJP8
 rN4FfVrsup9f5zYlofuxPq96ZHHL9hP9CZ2FKsYPSJOYbKbDK0b04vrsMwgZ76RMou1M
 tEmcwyTqxC7hzya5YfKjctJboYI4s2OznkFReiQDnIf1fq8zsN6poZ2BbH2gu0czFqP1
 bVY1fR8habmtJ3XY/rM6tUp0clva+/wjK9hluqQ3qbEEP5R9gZ8cGzeWgwc66dtHzDRJ
 jL8xwdSqbPYSiB0IlYAGuMv1NHFCpH7qhQ5NtVGgn5RwqU5iV1lRIOZQP2FAj9BwxdQl
 qC9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZsA/n1xRVh9Bwwk6xavgX766DwIyZnyERI9vxAaDSh0zSuJUwLVah+2Q7qtkweDcfmEEY35Do9NYI@nongnu.org
X-Gm-Message-State: AOJu0YyCIlolbWtb4g0rBbDDa8tXRmoxgZvJILn2txMS2HozIQ0v4g4+
 mCtZ+m0f5YIRsZCE4ECkKamw6mN49RXt1AZXQXfLrLfEuvNre785cQrNsibAbm+D/EpmU3GbO69
 pdIyEuiYdQu2XcCqI70msGfNAq66WAKknavvuqMYQaZNSJDlCL98D
X-Gm-Gg: ASbGncvSQwjhqKX49uIp8hnsCXLoQreeBs3MP0ze+Jk0ydP4xVqO3IOyuggepLgtnz3
 R17W4cdNn93//o2rrh1jEWPK8CaYyRxgoFbz2LO9vs8M3cDa2Rmer2L6u9Y1N7Fp9q2PddZV9Mj
 KN4L10ggt5z7P2I2VWUAVALUlY54tveqfdYBfQPEM4/j27QwAaPwJ5/prL0eHRzbDHmvcvWhz7b
 cNHDGCtvUIBv9vebxPpSypeiER9LUmIwbgdyj2sFPfl3FoAiRYHbWcacjsUfKUxoAAOxi+nCdid
 cpWcebUiMqH85PeuIiVOSovV6DQsfZSmK1XIsJdGwceXh/3irmWTsg==
X-Received: by 2002:a05:6000:1fa6:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-3997f89b7f4mr9472896f8f.0.1742829934523; 
 Mon, 24 Mar 2025 08:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb9JwcsDQS8AemU6mYMWtvxG/ON8R9tO6vPz9LVq5gqc6meawLNIhCPKZjhcCVLNzuWz4JUQ==
X-Received: by 2002:a05:6000:1fa6:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-3997f89b7f4mr9472872f8f.0.1742829933997; 
 Mon, 24 Mar 2025 08:25:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e66a7sm11230060f8f.76.2025.03.24.08.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 08:25:33 -0700 (PDT)
Message-ID: <1a0e20d3-98f8-499c-8b5d-198fadbafb74@redhat.com>
Date: Mon, 24 Mar 2025 16:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Open code vfio_migration_set_error()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Prasad Pandit <pjp@fedoraproject.org>
References: <20250324123315.637827-1-clg@redhat.com>
 <cb21eec3-0489-4413-971b-40954e64f72e@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cb21eec3-0489-4413-971b-40954e64f72e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/24/25 16:14, Avihai Horon wrote:
> 
> On 24/03/2025 14:33, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> VFIO uses migration_file_set_error() in a couple of places where an
>> 'Error **' parameter is not provided. In MemoryListener handlers :
>>
>>    vfio_listener_region_add
>>    vfio_listener_log_global_stop
>>    vfio_listener_log_sync
>>
>> and in callback routines for IOMMU notifiers :
>>
>>    vfio_iommu_map_notify
>>    vfio_iommu_map_dirty_notify
>>
>> Hopefully, one day, we will be able to extend these callbacks with an
>> 'Error **' parameter and avoid setting the global migration error.
>> Until then, it seems sensible to clearly identify the use cases, which
>> are limited, and open code vfio_migration_set_error(). One other
>> benefit is an improved error reporting when migration is running.
>>
>> While at it, slightly modify error reporting to only report errors
>> when migration is not active and not always as is currently done.
>>
>> Cc: Prasad Pandit <pjp@fedoraproject.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/common.c | 60 +++++++++++++++++++++++++++++-------------------
>>   1 file changed, 36 insertions(+), 24 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 1a0d9290f88c9774a98f65087a36b86922b21a73..a591ce5b97ff41cdc8249e9eeafc8dc347d45fac 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -149,13 +149,6 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>>       return vbasedev->bcontainer->space->as != &address_space_memory;
>>   }
>>
>> -static void vfio_set_migration_error(int ret)
>> -{
>> -    if (migration_is_running()) {
>> -        migration_file_set_error(ret, NULL);
>> -    }
>> -}
> 
> Wouldn't it be better to extend vfio_set_migration_error() to take also Error* instead of duplicating code?
> We can rename it to vfio_set_error() if it's not solely related to vfio migration anymore.

IMO, the vfio_set_migration_error() wrapper shadows the use of the
migration routines and their context. I prefer to be explicit about
it, open the code and work on removal. It is possible to add an
'Error **' parameter to log_global_stop handlers and to the IOMMU
notifiers. It just takes time.

Thanks,

C.

> 
> Thanks.
> 
>> -
>>   bool vfio_device_state_is_running(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>> @@ -291,9 +284,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>                                   iova, iova + iotlb->addr_mask);
>>
>>       if (iotlb->target_as != &address_space_memory) {
>> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
>> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
>> -        vfio_set_migration_error(-EINVAL);
>> +        error_setg(&local_err,
>> +                   "Wrong target AS \"%s\", only system memory is allowed",
>> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
>> +        if (migration_is_running()) {
>> +            migration_file_set_error(-EINVAL, local_err);
>> +        } else {
>> +            error_report_err(local_err);
>> +        }
>>           return;
>>       }
>>
>> @@ -326,11 +324,16 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
>> +            if (migration_is_running()) {
>> +                migration_file_set_error(ret, local_err);
>> +            } else {
>> +                error_report_err(local_err);
>> +            }
>>           }
>>       }
>>   out:
>> @@ -1112,8 +1115,11 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>       if (ret) {
>>           error_prepend(&local_err,
>>                         "vfio: Could not stop dirty page tracking - ");
>> -        error_report_err(local_err);
>> -        vfio_set_migration_error(ret);
>> +        if (migration_is_running()) {
>> +            migration_file_set_error(ret, local_err);
>> +        } else {
>> +            error_report_err(local_err);
>> +        }
>>       }
>>   }
>>
>> @@ -1229,14 +1235,14 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
>>       rcu_read_lock();
>>       if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
>> -        error_report_err(local_err);
>>           goto out_unlock;
>>       }
>>
>> @@ -1247,7 +1253,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>                         "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>>                         "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
>>                         iotlb->addr_mask + 1);
>> -        error_report_err(local_err);
>>       }
>>
>>   out_unlock:
>> @@ -1255,7 +1260,11 @@ out_unlock:
>>
>>   out:
>>       if (ret) {
>> -        vfio_set_migration_error(ret);
>> +        if (migration_is_running()) {
>> +            migration_file_set_error(ret, local_err);
>> +        } else {
>> +            error_report_err(local_err);
>> +        }
>>       }
>>   }
>>
>> @@ -1388,8 +1397,11 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>>       if (vfio_log_sync_needed(bcontainer)) {
>>           ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>>           if (ret) {
>> -            error_report_err(local_err);
>> -            vfio_set_migration_error(ret);
>> +            if (migration_is_running()) {
>> +                migration_file_set_error(ret, local_err);
>> +            } else {
>> +                error_report_err(local_err);
>> +            }
>>           }
>>       }
>>   }
>> -- 
>> 2.49.0
>>
>>
> 


