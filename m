Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BBCC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 06:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1g7J-0008Og-BO; Mon, 07 Apr 2025 02:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1g7H-0008OU-Si
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1g7F-0002v3-RI
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744007869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mHKZOnd4xwLlUedReRkYkO98nOXBfho0oVC479PtilI=;
 b=TqbbeN9tGwXgWf2Sh5+PSskt01NtWAwbjq+c0pe0cxLdfnMgkvTg12uko2YbmMKNv7pHZ3
 Nz6YFS1f2JJXvJSoX4MAx4WD7auWUk3+GRiyqOuifPSieWOZf4q/TECyWg25ntyvNEUern
 Fr2VGiAQySg+SZg3C3w8mpBEFZdKelI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-IuK-Ds1BNmauQvWCZ-KbtQ-1; Mon, 07 Apr 2025 02:37:47 -0400
X-MC-Unique: IuK-Ds1BNmauQvWCZ-KbtQ-1
X-Mimecast-MFC-AGG-ID: IuK-Ds1BNmauQvWCZ-KbtQ_1744007867
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-391459c0395so1585844f8f.2
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 23:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744007866; x=1744612666;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHKZOnd4xwLlUedReRkYkO98nOXBfho0oVC479PtilI=;
 b=PcEhIc0SAwUkW8AwyH5bXsxRbSh7COXR2Dv1wgPBcSug9ATCnfgk9it09jhvQ2iKjj
 Rksc5D0U8O/puXUhiNVkqohxZb4UQd5qhx9vJ95Znl9wUYC/vGvyYrA2KpcKU9f/tY5K
 199bJeweNRjQBE8ZFkg5Y2eBTOS2yoatGY7Kc6/iKrSmBp3bSm6eNd4v0pTLtJitgeZ6
 ae2YdhWiG53Fr2QelPyrTa5KbLeWNbEU/xKEGPrrREhjxGub2wjeDB8yaW7rTSBdrQK4
 3WelMGOKtIOOwRDziogFjZIAAuY3yGZXoCuBYYU9cZBFEZyGf0ytmGvJmYTBrxHJHTeb
 Kzug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA85GtMEh+tbgK3InR11JZ2cNs5bs1oYxP7JSd1l2f9U9pxsYL5oE5UAaCWDhNB0Eh8UbEJJzR+0LZ@nongnu.org
X-Gm-Message-State: AOJu0YyQxg2E1nt5oTwUMyOif/RM/Bi2Al7L2R/VtsVlFAT/DApYA+E/
 5iVDx4S2sMyxfNnDz1nXwsBj0T1b+2e/ng6CAPCGaMGAiOxuUfSwE2JaIOU/PXQsUyjw+YApPyT
 UUPUzaNRWOdnhMXOUjebXik8qahCy7Gj86ZMSMRlUKES8zSZ0I48D
X-Gm-Gg: ASbGncsUaQZJQv6Rdet9EfXYJcvmal58uw9GbCEhzyCh7lyPkgrW53jjtARDdsnVeBj
 9ISuMOxnxKYd6u7mYdRMiD6p9bpgeYkYOlEVTfjPrZaxvoVw7N7d41fCmqAwy/ls0rHY69Yz+JD
 4qcSfSQN5igy6+f4XVEUV5x6E06kS4N97C72Ts7Li452k9wOjHIjeNpTyn3GI+Geuf6CZbVO4ny
 at0JobcPUgIcp0LxwBqZuJnWpprwsMPbkttr+4SQI4iZwr+IQe07xuDmBjph89cGyMcc5NgUHzv
 22uHLL0Mt7NvUNwRVHQ2g1pGCKfU7AvR00ceRhZu6qqeC3fUQBcuXg==
X-Received: by 2002:a05:6000:4284:b0:39c:1f11:ead with SMTP id
 ffacd0b85a97d-39cb35a8860mr10393553f8f.26.1744007866020; 
 Sun, 06 Apr 2025 23:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqoeMcyY4w+Wa2kI+UggCQ+3z9RP1ZZWhUvrRNnztL3ZhNjSjLk30jKj6xU/hrHhs/IRL3Tw==
X-Received: by 2002:a05:6000:4284:b0:39c:1f11:ead with SMTP id
 ffacd0b85a97d-39cb35a8860mr10393534f8f.26.1744007865635; 
 Sun, 06 Apr 2025 23:37:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096923sm11271393f8f.17.2025.04.06.23.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Apr 2025 23:37:45 -0700 (PDT)
Message-ID: <a5ddec85-d4d8-45aa-b746-f0841ee32fd4@redhat.com>
Date: Mon, 7 Apr 2025 08:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 03/37] vfio: Introduce a new header file for
 external migration services
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins
 <joao.m.martins@oracle.com>, Kirti Wankhede <kwankhede@nvidia.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-4-clg@redhat.com>
 <d22dc2c7-b552-4341-a3db-fe99a1b52ef9@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d22dc2c7-b552-4341-a3db-fe99a1b52ef9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/31/25 14:07, Avihai Horon wrote:
> 
> On 26/03/2025 9:50, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> The migration core subsystem makes use of the VFIO migration API to
>> collect statistics on the number of bytes transferred. These services
>> are declared in "hw/vfio/vfio-common.h" which also contains VFIO
>> internal declarations. Move the migration declarations into a new
>> header file "hw/vfio/vfio-migration.h" to reduce the exposure of VFIO
>> internals.
>>
>> While at it, use a 'vfio_migration_' prefix for these services.
>>
>> To be noted, vfio_migration_add_bytes_transferred() is a VFIO
>> migration internal service which we will moved in the subsequent
>> patches.
>>
>> Cc: Kirti Wankhede <kwankhede@nvidia.com>
>> Cc: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Since lore didn't receive the email :

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

> Small nit below.
> 
>> ---
>>   include/hw/vfio/vfio-common.h    |  5 +----
>>   include/hw/vfio/vfio-migration.h | 16 ++++++++++++++++
>>   hw/vfio/migration-multifd.c      |  5 +++--
>>   hw/vfio/migration.c              | 11 ++++++-----
>>   migration/target.c               |  8 ++++----
>>   5 files changed, 30 insertions(+), 15 deletions(-)
>>   create mode 100644 include/hw/vfio/vfio-migration.h
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 9cfb3fb6931e71395ef1d67b0a743d8bc1433fdc..fd424a4a3d40132e940f457f9250458e50ea0b71 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -290,13 +290,10 @@ extern VFIODeviceList vfio_device_list;
>>   extern const MemoryListener vfio_memory_listener;
>>   extern int vfio_kvm_device_fd;
>>
>> -bool vfio_mig_active(void);
>>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>>   void vfio_unblock_multiple_devices_migration(void);
>>   bool vfio_viommu_preset(VFIODevice *vbasedev);
>> -int64_t vfio_mig_bytes_transferred(void);
>> -void vfio_mig_reset_bytes_transferred(void);
>> -void vfio_mig_add_bytes_transferred(unsigned long val);
>> +void vfio_migration_add_bytes_transferred(unsigned long val);
>>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>>
>> diff --git a/include/hw/vfio/vfio-migration.h b/include/hw/vfio/vfio-migration.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..0d4ecd33d5d8c214bb77e0652b4405b6e43bcafa
>> --- /dev/null
>> +++ b/include/hw/vfio/vfio-migration.h
>> @@ -0,0 +1,16 @@
>> +/*
>> + * VFIO migration interface
>> + *
>> + * Copyright Red Hat, Inc. 2025
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_VFIO_VFIO_MIGRATION_H
>> +#define HW_VFIO_VFIO_MIGRATION_H
>> +
>> +bool vfio_migration_active(void);
>> +int64_t vfio_migration_bytes_transferred(void);
>> +void vfio_migration_reset_bytes_transferred(void);
>> +
>> +#endif /* HW_VFIO_VFIO_MIGRATION_H */
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 378f6f3bf01f6a4155fb424f8028cb5380f27f02..09aa57f5f890f37f7e36c857fd813f55b1da2fce 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -11,6 +11,7 @@
>>
>>   #include "qemu/osdep.h"
>>   #include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-migration.h"
> 
> This can be dropped.

This include is needed until patch 6. Where I forgot to remove it.
Will fix,

Thanks,

C.


> Thanks.
> 
>>   #include "migration/misc.h"
>>   #include "qapi/error.h"
>>   #include "qemu/bswap.h"
>> @@ -575,7 +576,7 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>>           return false;
>>       }
>>
>> -    vfio_mig_add_bytes_transferred(packet_len);
>> +    vfio_migration_add_bytes_transferred(packet_len);
>>
>>       return true;
>>   }
>> @@ -645,7 +646,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
>>               goto thread_exit;
>>           }
>>
>> -        vfio_mig_add_bytes_transferred(packet_size);
>> +        vfio_migration_add_bytes_transferred(packet_size);
>>       }
>>
>>       if (!vfio_save_complete_precopy_thread_config_state(vbasedev,
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 8bf65b8e11094b8363692dba3084b762362c7dd6..582d65932a6c590eaecd8bf0b765f27d93896c72 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -17,6 +17,7 @@
>>
>>   #include "system/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-migration.h"
>>   #include "migration/misc.h"
>>   #include "migration/savevm.h"
>>   #include "migration/vmstate.h"
>> @@ -373,7 +374,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>>       qemu_put_be64(f, data_size);
>>       qemu_put_buffer(f, migration->data_buffer, data_size);
>> -    vfio_mig_add_bytes_transferred(data_size);
>> +    vfio_migration_add_bytes_transferred(data_size);
>>
>>       trace_vfio_save_block(migration->vbasedev->name, data_size);
>>
>> @@ -1047,22 +1048,22 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>>
>>   /* ---------------------------------------------------------------------- */
>>
>> -int64_t vfio_mig_bytes_transferred(void)
>> +int64_t vfio_migration_bytes_transferred(void)
>>   {
>>       return MIN(qatomic_read(&bytes_transferred), INT64_MAX);
>>   }
>>
>> -void vfio_mig_reset_bytes_transferred(void)
>> +void vfio_migration_reset_bytes_transferred(void)
>>   {
>>       qatomic_set(&bytes_transferred, 0);
>>   }
>>
>> -void vfio_mig_add_bytes_transferred(unsigned long val)
>> +void vfio_migration_add_bytes_transferred(unsigned long val)
>>   {
>>       qatomic_add(&bytes_transferred, val);
>>   }
>>
>> -bool vfio_mig_active(void)
>> +bool vfio_migration_active(void)
>>   {
>>       VFIODevice *vbasedev;
>>
>> diff --git a/migration/target.c b/migration/target.c
>> index f5d8cfe7c2a3473f4bd3f5068145598c60973c58..12fd399f0c521c5c28535b58f24feab6845947fd 100644
>> --- a/migration/target.c
>> +++ b/migration/target.c
>> @@ -11,21 +11,21 @@
>>   #include CONFIG_DEVICES
>>
>>   #ifdef CONFIG_VFIO
>> -#include "hw/vfio/vfio-common.h"
>> +#include "hw/vfio/vfio-migration.h"
>>   #endif
>>
>>   #ifdef CONFIG_VFIO
>>   void migration_populate_vfio_info(MigrationInfo *info)
>>   {
>> -    if (vfio_mig_active()) {
>> +    if (vfio_migration_active()) {
>>           info->vfio = g_malloc0(sizeof(*info->vfio));
>> -        info->vfio->transferred = vfio_mig_bytes_transferred();
>> +        info->vfio->transferred = vfio_migration_bytes_transferred();
>>       }
>>   }
>>
>>   void migration_reset_vfio_bytes_transferred(void)
>>   {
>> -    vfio_mig_reset_bytes_transferred();
>> +    vfio_migration_reset_bytes_transferred();
>>   }
>>   #else
>>   void migration_populate_vfio_info(MigrationInfo *info)
>> -- 
>> 2.49.0
>>
> 


