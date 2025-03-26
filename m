Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B991C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 16:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txTOT-0000PY-0a; Wed, 26 Mar 2025 12:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txTON-0000NS-Dn
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txTOL-0002bq-0n
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743005647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fifVV6QZ9E18e+jGkKLV1uCQkg/qBKdQk/1H1uCS11c=;
 b=BxxLLIDKpi6SBXUqhw+VXh0prN2QEb0BQ8Qx69H7qZ/mcVKd8b7RYtohyVqCXgTb1CDNHV
 bv+MNWJKV6oVwQFAkr7qQi/lkDcXrQ6bYr33xqtxZG6cau2tkKn2CWseloNyA2P0+LHGQL
 2R4X2GQ/ZzjQ/AW2oCPR0rktthW2b/0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-H0UrYy08NZehwbuAdG-vmg-1; Wed, 26 Mar 2025 12:14:05 -0400
X-MC-Unique: H0UrYy08NZehwbuAdG-vmg-1
X-Mimecast-MFC-AGG-ID: H0UrYy08NZehwbuAdG-vmg_1743005644
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso88845e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 09:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743005642; x=1743610442;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fifVV6QZ9E18e+jGkKLV1uCQkg/qBKdQk/1H1uCS11c=;
 b=EQDY/00p5Bcu1mMb+Z6w7kYjdDz5l5iYBEfKKJY88ZmL6Kn/DwtzWSlZ+sE4CNh1pP
 axPNWEdRruJahuyRDt6NbJ8WijGxHrA/PT9M/3+lpjrbAUzC7WlxnUrdh9P/fEX8GUHw
 VcfMb25DIf+mDNoApGJC5DVuDD8dEY78TCsUIcXwR+Y84Q+yzKDTy8FBS9E9+59iJU1f
 VzvZBFAi7rSWlAgmhjStnc5VY6Yr/i8zNg8rsRz9ijAcc4ujB4MHqZbz/UASlrt1jTEL
 J9HAuiMtXxOfg5ibLVp74xg8ebAyFB+RlGZwU4zaVbh30y7Poubb9OIF3/GCzUJmpl6x
 HKkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbYWE2O3eg0Vkd+OeKsq5mcPF/eVBvCAIsc9V3etLt869pjogLKTI8Lr3ajA2gDgfLoKsr3RAK9NaV@nongnu.org
X-Gm-Message-State: AOJu0YxzztyacDBK1lv5UmPz0nm2TCHmaExTKE913kkqUK3dnar4j12J
 qJwAtO8MX8VNht9pd0JYLH9ui0gWBm7EXfnnwP9RQEgEmiU1HmYHshWsZmAEtn8da9Y5Yw5TDrX
 DKlR7Xi89T52PBZtLVy8fLszFw6JK7gfAYAb+EZDeFvBN7tNiyR4x
X-Gm-Gg: ASbGnctuRcATZwgW+2xru/0nt4KBJMzsktPeltzmHl389O3nIaxkMGuJFgDGDxSzJ5c
 sfBYik09aqflRllSEHFoV1zzXABFznZqIXDPBL3nde1rtJenPYcUbue2RBNeLx5XP8/AHi3LvrN
 Dy7IJc4vy+r0GMhjUuacvuXKdTRmxIFWXo4YFsyBjlzTRNZWDKBzjSI8UO/Zf+tDs+cJ1Tq6w8f
 YZUrr0scNU8sLHogxzNAO1zxFXTzoTJ7gE8llXRijoD+b86TRzQA++yVKdqgqk4zIzpe2LbOGAA
 qQwxy0UT01X1JzqlfojUm0ECA1iQ7cJSPM0GDxMzeh9z6oM/TSwhkw==
X-Received: by 2002:a05:600c:3ba0:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-43d6c5d063cmr78851275e9.19.1743005641761; 
 Wed, 26 Mar 2025 09:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc0Y2Xg4skTvy1Hd3IndJuVdaZ2uP4O3U8TWcVRd1jiqbiU6NJCvfEO6ZnOwxQHA8Hhsfe9g==
X-Received: by 2002:a05:600c:3ba0:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-43d6c5d063cmr78850735e9.19.1743005641276; 
 Wed, 26 Mar 2025 09:14:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efebc2sm6576875e9.21.2025.03.26.09.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 09:14:00 -0700 (PDT)
Message-ID: <d6314700-71bd-4c8b-ae4b-3b7df0333829@redhat.com>
Date: Wed, 26 Mar 2025 17:13:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 21/37] vfio: Introduce new files for CPR
 definitions and declarations
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-22-clg@redhat.com>
 <7cdc6d56-ca84-4e85-9949-cd75160e05c1@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7cdc6d56-ca84-4e85-9949-cd75160e05c1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 3/26/25 15:38, Steven Sistare wrote:
> On 3/26/2025 3:51 AM, Cédric Le Goater wrote:
>> Gather all CPR related declarations into "vfio-cpr.h" to reduce exposure
>> of VFIO internals in "hw/vfio/vfio-common.h". These were introduced in
>> commit d9fa4223b30a ("vfio: register container for cpr").
>>
>> Order file list in meson.build while at it.
>>
>> Cc: Steve Sistare <steven.sistare@oracle.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/vfio-cpr.h            | 15 +++++++++++++++
>>   include/hw/vfio/vfio-common.h |  3 ---
>>   hw/vfio/container.c           |  1 +
>>   hw/vfio/cpr.c                 |  1 +
>>   hw/vfio/iommufd.c             |  1 +
>>   hw/vfio/meson.build           |  2 +-
>>   6 files changed, 19 insertions(+), 4 deletions(-)
>>   create mode 100644 hw/vfio/vfio-cpr.h
>>
>> diff --git a/hw/vfio/vfio-cpr.h b/hw/vfio/vfio-cpr.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..9e78b422623683509929f2982f0be465306f4e99
>> --- /dev/null
>> +++ b/hw/vfio/vfio-cpr.h
>> @@ -0,0 +1,15 @@
>> +/*
>> + * VFIO CPR
>> + *
>> + * Copyright Red Hat, Inc. 2025
> 
> This, please:
>    Copyright (c) 2025 Oracle and/or its affiliates.
> 
> I created the copied code, and I created this file vfio-cpr.h in my vfio cpr series.

Yes. Will replace the copyright notice.

> Other than that:
>    Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

Thanks,

C.


> 
> - Steve
> 
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_VFIO_CPR_H
>> +#define HW_VFIO_CPR_H
>> +
>> +bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>> +void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
>> +
>> +#endif /* HW_VFIO_CPR_H */
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 75c48ebf5c21ea93aa8ac4c3aecc63172b633f0e..c587ed08feabd0c4845d824960dd0799e9ace69b 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -129,9 +129,6 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>   void vfio_detach_device(VFIODevice *vbasedev);
>>   VFIODevice *vfio_get_vfio_device(Object *obj);
>> -bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>> -void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
>> -
>>   typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>>   extern VFIODeviceList vfio_device_list;
>>   extern const MemoryListener vfio_memory_listener;
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 6e9378434377f4b03176a16157c337ab1286c53e..7436388a73a424b11e6bad9ce80b86c3792242dd 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -34,6 +34,7 @@
>>   #include "pci.h"
>>   #include "hw/vfio/vfio-container.h"
>>   #include "vfio-helpers.h"
>> +#include "vfio-cpr.h"
>>   #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index 3d1c8d290a5e6b6d67e244931a9ef8c194a0b574..696987006b853227e76caedb3c7f4e4be31cfa06 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -10,6 +10,7 @@
>>   #include "migration/misc.h"
>>   #include "qapi/error.h"
>>   #include "system/runstate.h"
>> +#include "vfio-cpr.h"
>>   static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>                                       MigrationEvent *e, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 85b5a8146ac401af6be8109c28ea4c7a39e84521..a5bd189a86d70bd11ecb80384ac145a51979322b 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -27,6 +27,7 @@
>>   #include "pci.h"
>>   #include "vfio-iommufd.h"
>>   #include "vfio-helpers.h"
>> +#include "vfio-cpr.h"
>>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
>>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index 60caa366175edee6bc69c0febebaef84e752e346..1f89bd28c13dea55bcfff476ce99d51b453d8533 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -20,10 +20,10 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>>     'container-base.c',
>> +  'cpr.c',
>>     'device.c',
>>     'migration.c',
>>     'migration-multifd.c',
>> -  'cpr.c',
>>     'region.c',
>>   ))
>>   system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
> 


