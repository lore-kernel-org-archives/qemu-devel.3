Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EF0C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMrt2-0006pK-8P; Wed, 04 Jun 2025 13:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMrt0-0006p2-1W
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMrsx-0007qu-IN
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749058001;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlaCyqpRi8MqH0aFsM4CNzlSQ7/z/97JRoHWttdujEs=;
 b=i4w9AA/zCu8qY7MpnFdT3GTsAB6uU8cVsCKN/8dpH6Jr94nQoPAXekpHRlP7XRrFoDCw0G
 L6VCIe4T5rq/h/CsLXzLb5eit1lWZutuUBVHp/Mq8fWGxFl8oyUjITnDGBT+0yLz0sXA6G
 EB2TImciT7pvcXnciM2APqvtYkGyjnk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-wxakWK1fN4yw0pG06QnW4g-1; Wed, 04 Jun 2025 13:26:40 -0400
X-MC-Unique: wxakWK1fN4yw0pG06QnW4g-1
X-Mimecast-MFC-AGG-ID: wxakWK1fN4yw0pG06QnW4g_1749057999
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso123825e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749057999; x=1749662799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XlaCyqpRi8MqH0aFsM4CNzlSQ7/z/97JRoHWttdujEs=;
 b=qWsNa6c4gJVYgnsC/gV7VyRJirgtYx810KA0yLhvC0gGJ2o8YemASRPgFZ7ksoF7xc
 3Xf1wJcbsYC+HrdbvufRBVcIB7oG+dqQ9sPOUASexMcAwSpa/oqS4a5N7GYTP2aZE0AP
 pSLngSPAIVlA0wqjj6CS0l5mgwFaIWyqDn3DF5NOs+huIJkPognWjeYkJUmD7mA2F4RX
 5JZdyAWVbKXMYqAndVuqxTWe4Tpm9UbKSLa6Yql6RtTzUy4LK1clh93sh6BTsR1UTMLu
 m5JXOKy4hl7F9vJvfOyCmts+Cm7spIZ6JjQavzXpWKbO56msM7OxTYhQuefleDEkQiUz
 ZLnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS6AVlzEkxVyE1azPwCfa89PBibdM3wxLyuVTLd1q995Qvz5SwRDmDxdOknyYtbuDOQyKETBeVCFIL@nongnu.org
X-Gm-Message-State: AOJu0Yztb42I4KAXRMVqYsylBwoBrBlVuzz5aoWbLFxd1luwxyIu0mtW
 xBledmLZGANn8B8vTYt8Mtm0GGbL0R5s40pBRGKSI3sTyuYtydB09dKD0CWjcpkm4W9FwPA1QRi
 ojMKoomi98IYS9dIaQiVWR34x9Q/I98oln7142zY7I9j5B3SIL7tg6tMh
X-Gm-Gg: ASbGncu70iEIKWApc/tMyxqwbkrFWtTt54I1dOP/nAowIy9KosG41PWTaDoFCKgKRzS
 8N7e788w0BleK6km6bKPql5pdrfqbSFKn2JiVFOGTqNmXV0FyZu8eiBSFtuPndGzoy5e2Bb+5fi
 su5/+kQFN9zkinKCn/o7NQrzNZSUtctEsuJMzQyIxo0AaS/9lbueblHqzVdzRpfWbGbTyqUhSWh
 Q+UtbWNckitytkXC3uILbjJ//gvQqTzyy2ESMSTB100GTzdDPU/KHvATFy4TG1BoAeDB7RCdTYT
 qxbIRgfDFWM2Bqc36OXSIWW/DyE6u+FZ/8SLQ6jTnECalaVGqnbUtmCY5e7Ye0G360MpGg==
X-Received: by 2002:a05:6000:2f88:b0:3a4:e629:6518 with SMTP id
 ffacd0b85a97d-3a51d8f603fmr3118267f8f.7.1749057999036; 
 Wed, 04 Jun 2025 10:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTndGuFGjgkPObHUkW/2g4txmv1+icdWF2BpUYwuXbJF3FCBfKR7k6yUTTvQfsWNu6k9dAlQ==
X-Received: by 2002:a05:6000:2f88:b0:3a4:e629:6518 with SMTP id
 ffacd0b85a97d-3a51d8f603fmr3118248f8f.7.1749057998650; 
 Wed, 04 Jun 2025 10:26:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b79asm21945282f8f.2.2025.06.04.10.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 10:26:37 -0700 (PDT)
Message-ID: <3474d223-8519-4575-9f8c-d64cd3682422@redhat.com>
Date: Wed, 4 Jun 2025 19:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-2-zhenzhong.duan@intel.com>
 <bcec7aeb-47c2-4edf-87f4-d09362e59715@redhat.com>
 <IA3PR11MB9136A572E2D94B5537C26CBE926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136A572E2D94B5537C26CBE926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 6/4/25 7:50 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Tuesday, June 3, 2025 8:21 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
>> Cc: alex.williamson@redhat.com; clg@redhat.com; mst@redhat.com;
>> jasowang@redhat.com; peterx@redhat.com; ddutile@redhat.com;
>> jgg@nvidia.com; nicolinc@nvidia.com; shameerali.kolothum.thodi@huawei.com;
>> joao.m.martins@oracle.com; clement.mathieu--drif@eviden.com; Tian, Kevin
>> <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Peng, Chao P
>> <chao.p.peng@intel.com>
>> Subject: Re: [PATCH v2 1/4] backends/iommufd: Add a helper to invalidate user-
>> managed HWPT
>>
>> Hi Zhenzhong,
>>
>> On 5/30/25 11:35 AM, Zhenzhong Duan wrote:
>>> This helper passes cache invalidation request from guest to invalidate
>>> stage-1 page table cache in host hardware.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/system/iommufd.h |  4 ++++
>>>  backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
>>>  backends/trace-events    |  1 +
>>>  3 files changed, 41 insertions(+)
>>>
>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>> index cbab75bfbf..83ab8e1e4c 100644
>>> --- a/include/system/iommufd.h
>>> +++ b/include/system/iommufd.h
>>> @@ -61,6 +61,10 @@ bool
>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>>                                        uint64_t iova, ram_addr_t size,
>>>                                        uint64_t page_size, uint64_t *data,
>>>                                        Error **errp);
>>> +bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>>> +                                      uint32_t data_type, uint32_t entry_len,
>>> +                                      uint32_t *entry_num, void *data,
>>> +                                      Error **errp);
>>>
>>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>>  #endif
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index b73f75cd0b..8bcdb60fe7 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -311,6 +311,42 @@ bool
>> iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>>      return true;
>>>  }
>>>
>>> +bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>>> +                                      uint32_t data_type, uint32_t entry_len,
>>> +                                      uint32_t *entry_num, void *data,
>>> +                                      Error **errp)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    uint32_t total_entries = *entry_num;
>>> +    struct iommu_hwpt_invalidate cache = {
>>> +        .size = sizeof(cache),
>>> +        .hwpt_id = id,
>>> +        .data_type = data_type,
>>> +        .entry_len = entry_len,
>>> +        .entry_num = total_entries,
>>> +        .data_uptr = (uintptr_t)data,
>>> +    };
>>> +
>>> +    ret = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
>>> +    trace_iommufd_backend_invalidate_cache(fd, id, data_type, entry_len,
>>> +                                           total_entries, cache.entry_num,
>>> +                                           (uintptr_t)data, ret ? errno : 0);
>>> +    *entry_num = cache.entry_num;
>>> +
>>> +    if (ret) {
>>> +        error_setg_errno(errp, errno, "IOMMU_HWPT_INVALIDATE failed:"
>>> +                         " total %d entries, processed %d entries",
>>> +                         total_entries, cache.entry_num);
>>> +    } else if (total_entries != cache.entry_num) {
>>> +        error_setg(errp, "IOMMU_HWPT_INVALIDATE succeed but with
>> unprocessed"
>>> +                         " entries: total %d entries, processed %d entries."
>>> +                         " Kernel BUG?!", total_entries, cache.entry_num);
>> Can this happen? Isn't it a failure case?
> It shouldn't happen except kernel has a bug. It's a failure case, so false is returned.
OK. I missed it was an error case.

Eric
>
> Thanks
> Zhenzhong
>
>> Besides
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
>>
>> Eric
>>> +        return false;
>>> +    }
>>> +
>>> +    return !ret;
>>> +}
>>> +
>>>  static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error
>> **errp)
>>>  {
>>>      HostIOMMUDeviceCaps *caps = &hiod->caps;
>>> diff --git a/backends/trace-events b/backends/trace-events
>>> index 40811a3162..7278214ea5 100644
>>> --- a/backends/trace-events
>>> +++ b/backends/trace-events
>>> @@ -18,3 +18,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t
>> dev_id, uint32_t pt_id, uint32_
>>>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>> id=%d (%d)"
>>>  iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret)
>> " iommufd=%d hwpt=%u enable=%d (%d)"
>>>  iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t
>> iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u
>> iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>>> +iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t
>> data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t
>> data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u
>> entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"


