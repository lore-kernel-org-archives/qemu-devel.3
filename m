Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93C0C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBb3-0008Ey-4j; Tue, 21 Jan 2025 05:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1taBay-0008Dj-1n
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1taBaw-0002AE-7c
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737455691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GVaV6pCR9o4B7GwP1aGuRTWrDi/V4w2aFUhBtO2UNmI=;
 b=DGgz14otIuXlydYjAYPhxpfOgB/FzrM0X0H8JOQ+/bQOFaS+e1lNw0jvS0KbzrJTas9J/e
 k780hcqwswBw0j9j+wI3qt5pS/J4KQ4oKrUCVimJn943JNfXBZV5G6Q41HhVVXkx+pro0A
 mFvXl64+sMdDiihv6XR09jLieJTn62Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-9MneRvsBNNikz_VGIAJmxg-1; Tue, 21 Jan 2025 05:34:49 -0500
X-MC-Unique: 9MneRvsBNNikz_VGIAJmxg-1
X-Mimecast-MFC-AGG-ID: 9MneRvsBNNikz_VGIAJmxg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso41748765e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 02:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737455688; x=1738060488;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVaV6pCR9o4B7GwP1aGuRTWrDi/V4w2aFUhBtO2UNmI=;
 b=tFO9cS4MulWpzOZ3lTFIGxIs7t7sOKc7yuWsU1gYdK3ZuWEsSt4hgSreidDFtD8I7R
 oaZHUIQgIs+F6B9GeDcQI3/TtLFZaxzsBmilP7gbpYxM8pYu0WKsQBLq81DQPqneqrnZ
 MzSNjb+8hYV0kWhK9H6u20X9lC1WIF9Pikz9kViQRDhueSIt+qyMRvKbTBFtwAe2qxOk
 gtrDV5nI6b2OHTKTdGi8DvLJ3y+J0pXTDtexEUJXEhsAW5ZdkJEmSHe3f27OnjTMJGSm
 2UAQtJjiasJL1osYUdXnRqzqfaQRiWdD9wbwUSNNmlkaBoVgxx4JwLsUFVxEFDtjr1W8
 AzYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkNi7gW6RobH7Maaath6UJnIY968K631YqXNI0I25P8a6vqOJdZ7RVjNvih2uRs80NelMgj/G9+aEb@nongnu.org
X-Gm-Message-State: AOJu0YxaSKmjLTAL3ZG3e6ifrxJA9NSAlqsFqaGBwESB4An7e0QkFWZ3
 /VEfGRqq0lUio0DYLj5Ppj5sfW68GbNDv6DmnBqUoVEeBeCOlBeo5iDTrDQkdwiBJcr08v9lgZA
 8XTxDyaViKkNlS5KvVq4I5LdAu27CApP6ObNCQtRmrx4AtBfZBPux
X-Gm-Gg: ASbGncu/u5gkMUbx9hVSFd6faFIPpqcuSnLKHHj8Yf0XXG2iW065sN4LMrY++XXtNnQ
 ZrE5C/Rnh9NT7fxnW2TBq2PI6HhjB7nyMPRuGYVtIb8RtTz84KNJfruYddq/K2DEvXzsCAaytMQ
 Cls/c1zobKtLFOg8EYIOlqGeWnDv0IU+ONHP6zS1g54bKL3XHIimc34JWlMeGmhDrzFyYUMz8xw
 xRa6bBLllDL+CR5OrVPyih7PYTGQXF7g63IvBkxsnqNjfR+n1k8It64bADxU5Rw9BKrECJaXEzK
 F8t7nGzmElyr9MVgeJFdB6QAhlmUh0lsC1lG/Ot4TQ==
X-Received: by 2002:a05:600c:c87:b0:434:ff30:a159 with SMTP id
 5b1f17b1804b1-438912d54b1mr173781475e9.0.1737455688001; 
 Tue, 21 Jan 2025 02:34:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8GdzMsO1SaYqYb+sWlSq7IAHtE2gfO75IXZvB+oF71+MuvE2xePApPZzrsv3msYGeJnPBsg==
X-Received: by 2002:a05:600c:c87:b0:434:ff30:a159 with SMTP id
 5b1f17b1804b1-438912d54b1mr173781205e9.0.1737455687673; 
 Tue, 21 Jan 2025 02:34:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389040854bsm178122435e9.7.2025.01.21.02.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 02:34:46 -0800 (PST)
Message-ID: <0a9acf3d-184d-4947-be72-63e7187ef82f@redhat.com>
Date: Tue, 21 Jan 2025 11:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <SJ0PR11MB67445918D03892472C78C2DD92E62@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67445918D03892472C78C2DD92E62@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,


On 1/21/25 10:18 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
>> disabled
>>
>> When a guest exposed with a vhost device and protected by an
>> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>>
>> Fail to lookup the translated address ffffe000
> Do you see this print once during one time reboot?
Actually this happens rarely on reboot. The reproducibility is of the
order of magnitude of 1/10 for me. I use a vm with vhost net device +
virtual intel iommu featuring a crontab job.
@reboot /usr/sbin/reboot
>
>> We observe that the IOMMU gets disabled through a write to the global
>> command register (CMAR_GCMD.TE) before the vhost device gets stopped.
>> When this warning happens it can be observed an inflight IOTLB
>> miss occurs after the IOMMU disable and before the vhost stop. In
>> that case a flat translation occurs and the check in
>> vhost_memory_region_lookup() fails.
>>
>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
>> unregistered.
> Try to understand the sequence, is it like below?
>
>            vhost                                                     vcpu          
>
> call into vtd_iommu_translate();
No that's a kernel vhost translate request that normally tries to find
out the translated address on kernel side in the IOTLB but since the
data is not there it ends up asking for the translation to user space ...
>
>                                                                     set s->dmar_enabled = false;
>                                                                     switch off iommu address space;
>                                                                     disable vhost IOTLB callbacks;
vtd_handle_gcmd_write/vtd_handle_gcmd_te/vtd_handle_gcmd_te which
eventually calls vhost_iommu_region_del
>
> check if !s->dmar_enabled;
> return flat translation and trigger warning
vhost inflight translation reaches user space through
vhost_device_iotlb_miss()
>
> Thanks
> Zhenzhong
>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> hw/virtio/vhost.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 6aa72fd434..128c2ab094 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener
>> *listener,
>>             break;
>>         }
>>     }
>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>> +    }
>> }
>>
>> void vhost_toggle_device_iotlb(VirtIODevice *vdev)
>> --
>> 2.47.1


