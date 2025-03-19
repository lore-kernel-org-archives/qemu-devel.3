Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B48FC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuxIz-0002Ua-Um; Wed, 19 Mar 2025 13:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuxIk-0002T8-U0
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuxIg-00050A-OG
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742405633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7wzt8V7wpuvr32t4L/Fl0APWgrnHUoPR6/Vo0n9bPhk=;
 b=Xm0+YCEvbEHTF1FGJheQHBtXrsyCM0ZQ7B5FQ1H0zxhNMSWu/k7yDINzjwtBxbp4B9QvNM
 fI9hzwOztAeU14qtIhHaYtqaFVhWOeP8RlwKiqrIRym8P/pjHsSahR2YkqybhrrMHLeWUq
 tHdjO34Ov5MT7snMUEPI5rJZdD6S6AY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-R94oj0a1MnOZDbJyYxL0wQ-1; Wed, 19 Mar 2025 13:33:51 -0400
X-MC-Unique: R94oj0a1MnOZDbJyYxL0wQ-1
X-Mimecast-MFC-AGG-ID: R94oj0a1MnOZDbJyYxL0wQ_1742405630
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so36183495e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742405630; x=1743010430;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wzt8V7wpuvr32t4L/Fl0APWgrnHUoPR6/Vo0n9bPhk=;
 b=LK20gMRK+C6Sr4KDR/8ZQeqcJ1Vo1hxcD6Evrn/J/oC8xFftPoXSn3SLSwN0Hx452N
 0q+xUUiAx1O3wAoLMxMVDyVvUkyzVJreW6n9OOQ8jP4b+fBYXWlSBduw7zZzg4yNdGTT
 VFI0Ju/YslJxilUwYIaiC8cS1pCgqnuSnqzAOShHgQskzpKR2kMBs0yAiPS8+u4hy9Fe
 rmr0iVRJQmuwW1mWgVLmegUnYQG3khvSLXxkUq7wNQmGuSUM1ZMH3W0AwPIdsvXaGetg
 N0DMRfMyICKFjlM/q8hlXeF+e59zSr6h5Sae/C+jfWzuIcc/O0KArRNXNBsUWAJcCOgc
 hg1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvtocxw0N0H0/GgLV4qRaQxtPANIRt690KjKLAVu2CHF3jsA7EXPS6QhGxiJRDdJOkcJqerpqiPc11@nongnu.org
X-Gm-Message-State: AOJu0Yzyg5frgwme/4z0AcOw/7cP+7ciK/TxY/elqfrCw2G8FHrFSQKd
 clyzLySV1I5OPT9CV/bLFJlbBOxM82a15ToGg6ihxTTqZ/eRvPwqFroG1rlb+Ex9604mVk6qn3o
 vwg4L86NfziIat5lSOjNu3dto9lKk/VXPYUU5d0rzQldmnqcoQFUS
X-Gm-Gg: ASbGncs8JYcUSO0ud7/AyEcdx7fGlE1AJ+w2LRMhhVT5bRy2nxsVoBMRTIh7s6xc143
 Siz40pyHVqXfGywR8ivt2d4+llqj0O7nPDWmJyYcp9IPeIX50qXwhGfR2ZcVu4Q6GxmpZV6dMXz
 zIRayiBX5qGv/dfbl4Sr3DD4ctxJMEApSQBjSaV8+QkzR023c/KjAzLu2X+yMNd6R6lzOYuWLyf
 lLewi9wgpKef1lZWx/YR1lJL9nG6D1x7EEZwLP1w6GBJqOfQM/fgf2Cg/YZW9zYud74rLWyO1nO
 WsAp7BsgYpbS3340mDNSjXkj07+TyICUyMQIZkTzNwlMmtR0ksqvjg==
X-Received: by 2002:a05:600c:ccb:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-43d495b084bmr150815e9.30.1742405630092; 
 Wed, 19 Mar 2025 10:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVSRwucNMh4W/dnA0ZPJmNqZLyNlxjVdickQyWL/jFFA6a9ZvZwoOHl5oT3Pj8JSa0dKJfqg==
X-Received: by 2002:a05:600c:ccb:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-43d495b084bmr150525e9.30.1742405629555; 
 Wed, 19 Mar 2025 10:33:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4174f8d3sm19416025e9.0.2025.03.19.10.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:33:49 -0700 (PDT)
Message-ID: <c6513560-cd3e-4e5e-a38d-5ba999773a2a@redhat.com>
Date: Wed, 19 Mar 2025 18:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 06/32] vfio: Introduce a new header file for
 internal migration services
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-7-clg@redhat.com>
 <cb0ad36a-8a3f-4385-8bd7-83abd0901c4d@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cb0ad36a-8a3f-4385-8bd7-83abd0901c4d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

On 3/19/25 15:05, Avihai Horon wrote:
> 
> On 18/03/2025 11:53, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Gather all VFIO migration related declarations into "migration.h" to
>> reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 
> Two nits below.


I will add a third. Moving the vfio_device_state_is_* routines could be
done in separate change.



> 
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/migration.h           | 72 +++++++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h | 54 +-------------------------
>>   hw/vfio/common.c              | 17 +--------
>>   hw/vfio/iommufd.c             |  1 +
>>   hw/vfio/migration-multifd.c   |  1 +
>>   hw/vfio/migration.c           | 17 +++++++++
>>   hw/vfio/pci.c                 |  1 +
>>   7 files changed, 94 insertions(+), 69 deletions(-)
>>   create mode 100644 hw/vfio/migration.h
>>
>> diff --git a/hw/vfio/migration.h b/hw/vfio/migration.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..7ad2141d06a7c97f034db908f9ce19fd06f415b9
>> --- /dev/null
>> +++ b/hw/vfio/migration.h
>> @@ -0,0 +1,72 @@
>> +/*
>> + * VFIO migration
>> + *
>> + * Copyright Red Hat, Inc. 2025
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_VFIO_MIGRATION_H
>> +#define HW_VFIO_MIGRATION_H
>> +
>> +#ifdef CONFIG_LINUX
>> +#include <linux/vfio.h>
>> +#endif
>> +
>> +#include "qemu/notify.h"
>> +
>> +/*
>> + * Flags to be used as unique delimiters for VFIO devices in the migration
>> + * stream. These flags are composed as:
>> + * 0xffffffff => MSB 32-bit all 1s
>> + * 0xef10     => Magic ID, represents emulated (virtual) function IO
>> + * 0x0000     => 16-bits reserved for flags
>> + *
>> + * The beginning of state information is marked by _DEV_CONFIG_STATE,
>> + * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
>> + * certain state information is marked by _END_OF_STATE.
>> + */
>> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
>> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
>> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>> +#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
>> +
>> +typedef struct VFIODevice VFIODevice;
>> +typedef struct VFIOMultifd VFIOMultifd;
>> +
>> +typedef struct VFIOMigration {
>> +    struct VFIODevice *vbasedev;
>> +    VMChangeStateEntry *vm_state;
>> +    NotifierWithReturn migration_state;
>> +    uint32_t device_state;
>> +    int data_fd;
>> +    void *data_buffer;
>> +    size_t data_buffer_size;
>> +    uint64_t mig_flags;
>> +    uint64_t precopy_init_size;
>> +    uint64_t precopy_dirty_size;
>> +    bool multifd_transfer;
>> +    VFIOMultifd *multifd;
>> +    bool initial_data_sent;
>> +
>> +    bool event_save_iterate_started;
>> +    bool event_precopy_empty_hit;
>> +} VFIOMigration;
>> +
>> +
> 
> Extra line break.
> 
>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>> +void vfio_migration_exit(VFIODevice *vbasedev);
>> +bool vfio_device_state_is_running(VFIODevice *vbasedev);
>> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
>> +int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>> +
>> +#ifdef CONFIG_LINUX
>> +int vfio_migration_set_state(VFIODevice *vbasedev,
>> +                             enum vfio_device_mig_state new_state,
>> +                             enum vfio_device_mig_state recover_state,
>> +                             Error **errp);
>> +#endif
>> +
>> +#endif /* HW_VFIO_MIGRATION_H */
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 0aae88131cffda1a90b8ccd0224387133c0fa83a..799e12d43747addbf444c15052f629b65978322f 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -23,7 +23,6 @@
>>
>>   #include "exec/memory.h"
>>   #include "qemu/queue.h"
>> -#include "qemu/notify.h"
>>   #include "ui/console.h"
>>   #include "hw/display/ramfb.h"
>>   #ifdef CONFIG_LINUX
>> @@ -36,23 +35,6 @@
>>
>>   #define VFIO_MSG_PREFIX "vfio %s: "
>>
>> -/*
>> - * Flags to be used as unique delimiters for VFIO devices in the migration
>> - * stream. These flags are composed as:
>> - * 0xffffffff => MSB 32-bit all 1s
>> - * 0xef10     => Magic ID, represents emulated (virtual) function IO
>> - * 0x0000     => 16-bits reserved for flags
>> - *
>> - * The beginning of state information is marked by _DEV_CONFIG_STATE,
>> - * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
>> - * certain state information is marked by _END_OF_STATE.
>> - */
>> -#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
>> -#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
>> -#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>> -#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>> -#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
>> -
>>   enum {
>>       VFIO_DEVICE_TYPE_PCI = 0,
>>       VFIO_DEVICE_TYPE_PLATFORM = 1,
>> @@ -78,27 +60,6 @@ typedef struct VFIORegion {
>>       uint8_t nr; /* cache the region number for debug */
>>   } VFIORegion;
>>
>> -typedef struct VFIOMultifd VFIOMultifd;
>> -
>> -typedef struct VFIOMigration {
>> -    struct VFIODevice *vbasedev;
>> -    VMChangeStateEntry *vm_state;
>> -    NotifierWithReturn migration_state;
>> -    uint32_t device_state;
>> -    int data_fd;
>> -    void *data_buffer;
>> -    size_t data_buffer_size;
>> -    uint64_t mig_flags;
>> -    uint64_t precopy_init_size;
>> -    uint64_t precopy_dirty_size;
>> -    bool multifd_transfer;
>> -    VFIOMultifd *multifd;
>> -    bool initial_data_sent;
>> -
>> -    bool event_save_iterate_started;
>> -    bool event_precopy_empty_hit;
>> -} VFIOMigration;
>> -
>>   struct VFIOGroup;
>>
>>   typedef struct VFIOContainer {
>> @@ -136,6 +97,7 @@ typedef struct VFIOIOMMUFDContainer {
>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>>
>>   typedef struct VFIODeviceOps VFIODeviceOps;
>> +typedef struct VFIOMigration VFIOMigration;
>>
>>   typedef struct VFIODevice {
>>       QLIST_ENTRY(VFIODevice) next;
>> @@ -290,12 +252,6 @@ extern VFIODeviceList vfio_device_list;
>>   extern const MemoryListener vfio_memory_listener;
>>   extern int vfio_kvm_device_fd;
>>
>> -bool vfio_device_state_is_running(VFIODevice *vbasedev);
>> -bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>> -
>> -int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
>> -int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>> -
>>   #ifdef CONFIG_LINUX
>>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
>>                            struct vfio_region_info **info);
>> @@ -310,16 +266,8 @@ struct vfio_info_cap_header *
>>   vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
>>   struct vfio_info_cap_header *
>>   vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
>> -
>> -int vfio_migration_set_state(VFIODevice *vbasedev,
>> -                             enum vfio_device_mig_state new_state,
>> -                             enum vfio_device_mig_state recover_state,
>> -                             Error **errp);
>>   #endif
>>
>> -bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>> -void vfio_migration_exit(VFIODevice *vbasedev);
>> -
>>   int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
>>   bool vfio_devices_all_dirty_tracking_started(
>>       const VFIOContainerBase *bcontainer);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 0b9b071cd0490867bb6aa4ceb261350ccd6e1125..0e3746eddd1c08e98bf57a59d542e158487d346e 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -44,6 +44,7 @@
>>   #include "migration/qemu-file.h"
>>   #include "system/tcg.h"
>>   #include "system/tpm.h"
>> +#include "migration.h"
>>
>>   VFIODeviceList vfio_device_list =
>>       QLIST_HEAD_INITIALIZER(vfio_device_list);
>> @@ -72,22 +73,6 @@ static void vfio_set_migration_error(int ret)
>>       }
>>   }
>>
>> -bool vfio_device_state_is_running(VFIODevice *vbasedev)
>> -{
>> -    VFIOMigration *migration = vbasedev->migration;
>> -
>> -    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
>> -           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
>> -}
>> -
>> -bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>> -{
>> -    VFIOMigration *migration = vbasedev->migration;
>> -
>> -    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
>> -           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>> -}
>> -
>>   static bool vfio_devices_all_device_dirty_tracking_started(
>>       const VFIOContainerBase *bcontainer)
>>   {
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 42c8412bbf50724dddb43f9b19a3aa40c8bc311d..2fb2a01ec6d29dbc284cfd9830c24e78ce560dd0 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -25,6 +25,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/chardev_open.h"
>>   #include "pci.h"
>> +#include "migration.h"
> 
> I think iommufd.c doesn't need migration.h.

Indeed !


Thanks,

C.


> 
> Thanks.
> 
>>
>>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>                               ram_addr_t size, void *vaddr, bool readonly)
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index fe84735ec2c7bd085820d25c06be558761fbe0d5..285f9a9a18dd8f0847ac5ac3fdaa304779a2d0db 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -22,6 +22,7 @@
>>   #include "io/channel-buffer.h"
>>   #include "migration/qemu-file.h"
>>   #include "migration-multifd.h"
>> +#include "migration.h"
>>   #include "trace.h"
>>
>>   #define VFIO_DEVICE_STATE_CONFIG_STATE (1)
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index a1ba993ce549fce0d2a9a60ba07d4782c87c0c09..46c4cfecce25ba1146a1d8f2de0d7c51425afe8e 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -31,6 +31,7 @@
>>   #include "pci.h"
>>   #include "trace.h"
>>   #include "hw/hw.h"
>> +#include "migration.h"
>>
>>   /*
>>    * This is an arbitrary size based on migration of mlx5 devices, where typically
>> @@ -1222,3 +1223,19 @@ void vfio_migration_exit(VFIODevice *vbasedev)
>>
>>       migrate_del_blocker(&vbasedev->migration_blocker);
>>   }
>> +
>> +bool vfio_device_state_is_running(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
>> +           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
>> +}
>> +
>> +bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
>> +           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>> +}
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 7f1532fbed9aed2eae2c98f6fd79a9056ff1e84f..3612f6fe7d0864fe3789f4ea221da01ef87d0664 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -44,6 +44,7 @@
>>   #include "migration/blocker.h"
>>   #include "migration/qemu-file.h"
>>   #include "system/iommufd.h"
>> +#include "migration.h"
>>
>>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>>
>> -- 
>> 2.48.1
>>
> 


