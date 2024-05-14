Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78485C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6qCn-0003N2-66; Tue, 14 May 2024 07:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6qCl-0003Mf-3G
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6qCj-0000lA-3n
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715685618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6t9wOrjQC/MrluvGMtQ9isCn/bLu9xofEp7LsVcl+CI=;
 b=Xu0pS2wfTB7Y09JKKJ4bhRqUcowZQa1J/E5Pd7+NshXMxB8t/jAH+gTfBhDyiQaIyuxHX3
 n1gCeu9qg+wsYUsbEIZq0w/eRaak4unC0Y8GMK9Z836/+NKFYics6jzXrKFlxf6aRwRxNi
 4VPBpSW7mjdENjKWF4CnpqXsRGjzomA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-w4WPB1A7P7O2eVeyCfMDow-1; Tue, 14 May 2024 07:20:16 -0400
X-MC-Unique: w4WPB1A7P7O2eVeyCfMDow-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c992d8407dso5249911b6e.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 04:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715685616; x=1716290416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6t9wOrjQC/MrluvGMtQ9isCn/bLu9xofEp7LsVcl+CI=;
 b=XL7qn4hwQtJPBRl1aG0ihOuFlBCpJolSg8hBFidadd97SDd1GshLauidULj5Dig8ZJ
 JkCh16N3HTVsZIiCQPkQGtwNhT+o2LnEvQ1oHLu0NhWovjiznKlhp8X9yr4IlxHJccA5
 vcNo5vIntMsUn1qA/rshFK2CCRwagoSVBGs6LYUHlS4450MbOKa/pbPnvWQPiUaA5zk6
 IJZ4w+t5RSJiZafnhiJl6g/hGjGBxx08eHeTHSltW8oicD3ciCydYGtGp4Oh4UdCSLzb
 hddBa9Uulq5DXvIgOC1LPjiQNnSfBvIOkbkhTzvYnW1TevXx0rc6ajOQmvBECOJo0FgS
 kuiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEGSQmGhJadLpTYCiMZu84GJfRBluWSj65tfmBMhPJM7twEAU0ZarBefIDBWdMaQvgG0k3lss6AlZ4DoHthNyqQ39+5BQ=
X-Gm-Message-State: AOJu0Yw7CfFbtB6NITN1QWZGZ9k/iB5SyvaiHTs0gev5yctBMjGkK1gd
 WvEg2QxmJL0r5PIk4ezlx5eAW5mXq4JlvPO9GVB7xDOwdlWQW0U4IRsqhlwo96+0Tu7+GhJU8Br
 bG2FY9xjJYbICeSMzI92/40uESEBXteK2wyH6yKPG9lJ1oalQ/B0l
X-Received: by 2002:a05:6808:190b:b0:3c9:93f1:c787 with SMTP id
 5614622812f47-3c997023c6amr17006437b6e.3.1715685615877; 
 Tue, 14 May 2024 04:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQdqvM3hmnaHl/kKCTlSp5KvvtZI+nX3LgCovOZ8NDyoK8WYupKQi5Qs7+QGraFhntcsck6Q==
X-Received: by 2002:a05:6808:190b:b0:3c9:93f1:c787 with SMTP id
 5614622812f47-3c997023c6amr17006417b6e.3.1715685615508; 
 Tue, 14 May 2024 04:20:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27779fsm553323685a.21.2024.05.14.04.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 04:20:14 -0700 (PDT)
Message-ID: <d7122cae-8e84-4ea3-987b-107f44bee937@redhat.com>
Date: Tue, 14 May 2024 13:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] vfio: Extend vfio_set_migration_error() with
 Error* argument
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-11-clg@redhat.com>
 <c06e8de4-a3ad-4044-a4ca-f45d404314fb@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <c06e8de4-a3ad-4044-a4ca-f45d404314fb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/13/24 16:26, Avihai Horon wrote:
> 
> On 06/05/2024 12:20, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> vfio_set_migration_error() sets the 'return' error on the migration
>> stream if a migration is in progress. To improve error reporting, add
>> a new Error* argument to also set the Error object on the migration
>> stream, if a migration is progress.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v5:
>>
>>   - Rebased on 20c64c8a51a4 ("migration: migration_file_set_error")
>>
>>   hw/vfio/common.c | 37 ++++++++++++++++++-------------------
>>   1 file changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index c3d82a9d6e434e33f361e4b96157bf912d5c3a2f..4cf3e13a8439bd1b9a032e9d4e75df676eba457b 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -147,10 +147,10 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>>       return vbasedev->bcontainer->space->as != &address_space_memory;
>>   }
>>
>> -static void vfio_set_migration_error(int err)
>> +static void vfio_set_migration_error(int ret, Error *err)
>>   {
>>       if (migration_is_setup_or_active()) {
>> -        migration_file_set_error(err, NULL);
>> +        migration_file_set_error(ret, err);
>>       }
>>   }
>>
>> @@ -295,9 +295,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
>> @@ -330,11 +331,12 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
> 
> Use error_setg_errno()?

sure.

> 
>> +            vfio_set_migration_error(ret, local_err);
> 
> Now dma unmap errors (and also the error before it) are not reported if they happen not during migration.
> 
> This makes me think, maybe vfio_set_migration_error() is redundant and can be replaced by migration_file_set_error()?


yes. Good suggestion. I would like to get rid of vfio_set_migration_error(),
so that's a good start.

Thanks,

C.
  
> Thanks.
> 
>>           }
>>       }
>>   out:
>> @@ -1108,8 +1110,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>       if (ret) {
>>           error_prepend(&local_err,
>>                         "vfio: Could not stop dirty page tracking - ");
>> -        error_report_err(local_err);
>> -        vfio_set_migration_error(ret);
>> +        vfio_set_migration_error(ret, local_err);
>>       }
>>   }
>>
>> @@ -1226,14 +1227,14 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
>>           goto out_lock;
>>       }
>>
>> @@ -1244,7 +1245,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>                         "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>>                         "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
>>                         iotlb->addr_mask + 1);
>> -        error_report_err(local_err);
>>       }
>>
>>   out_lock:
>> @@ -1252,7 +1252,7 @@ out_lock:
>>
>>   out:
>>       if (ret) {
>> -        vfio_set_migration_error(ret);
>> +        vfio_set_migration_error(ret, local_err);
>>       }
>>   }
>>
>> @@ -1372,8 +1372,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>>       if (vfio_devices_all_dirty_tracking(bcontainer)) {
>>           ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>>           if (ret) {
>> -            error_report_err(local_err);
>> -            vfio_set_migration_error(ret);
>> +            vfio_set_migration_error(ret, local_err);
>>           }
>>       }
>>   }
>> -- 
>> 2.45.0
>>
> 


