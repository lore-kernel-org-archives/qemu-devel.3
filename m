Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7B8C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1geC-0000YM-Hu; Mon, 07 Apr 2025 03:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1geA-0000Xy-Fx
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1ge7-0006v5-UP
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744009909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vp7GpaKONen6tggB/fSLLAL2GvzMmOciv3YkRZLmo9I=;
 b=SLS2DrP2ag5MhwAPLMBoBVYuHZEZ76UglqojJTPlI/PrzqIYbspmDRvNb9qvHSsVBpkEhz
 NOdJeeOhzI1VQ4SQ2GDBGkBFgFc/kNg0L0NlJfFjnEH0NIPdBrOfMS3yHnntFIcPjfJJeY
 5fsArDMn5YodJQGJ4a1zzNA+Xf5YveA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-WwQUsAklP1eBex6VAZYl1w-1; Mon, 07 Apr 2025 03:11:44 -0400
X-MC-Unique: WwQUsAklP1eBex6VAZYl1w-1
X-Mimecast-MFC-AGG-ID: WwQUsAklP1eBex6VAZYl1w_1744009904
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so33282275e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 00:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744009903; x=1744614703;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vp7GpaKONen6tggB/fSLLAL2GvzMmOciv3YkRZLmo9I=;
 b=kA0OhxlZQ1ZBwedyp85CU825IeiOywReMry/8yPtAUhiIWybfpnPSLjbxJBmw2Q14t
 GG5bvsi9VH5Eo8GXUd8AMR98rWxyfG7aBqXng0lTSI2GirPe1sZgCKM5PVXwnVikHR1Z
 DUEt0/hV6wnpU3fMPcvTcm7DQjA+dyRaB+Gkk0xXtr6fbcUXnlFL/tlRt3oUD8qIMURn
 3NpGHpZIfgrqCQqNqQ5YMAi7+i2sollGXHuLNzKALoD8afNYKkN1Wz1/I0DVFSA55Scm
 C+iYIECAVCaNdu01iOIgXcNSvyLLW+pyjKsQD0bcU57htn4ZMjb5abOYSJY429nMD1yc
 TF7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzA6dsYY4BKg10tq+gRlVFGO4plMk1102ljAyHOnd14FMFbO0ePLHLjIKSFFgcxdo3AqGfBt0biauY@nongnu.org
X-Gm-Message-State: AOJu0YxDGwwXDbioQt2dQpW9KBQPDkXnC8XMIDgl+mpF+Vx5Wr/2DFBP
 9y9TUvz1liDAuqzToSIlZHFMOppaU45FGYVG2so8ommwbxrTp7m0u+csuYUrIKgVLRf9GKzILGQ
 5/h41ZvkySAmC8ged+qf6Y7PURQgjk8vS0wmHs5zh80FwqDMiOkhM
X-Gm-Gg: ASbGnctiBtKZux+xXqbbcWfdkVru6e0fob/5oyIsDoNU+9gXsKCB8aXd9QWRH3iH29N
 IAxqAsj+kblU0qvtuFdjl93HkblOdN2cZ34k1VdeqNlGw/dE7Db2eWjQznw+lsip9CTe+TnIbc1
 7GvVQwHqGppXe3y33OtI3BvzO2reg/E3kt9lffdJMi6gza3sDNlobhPTJIqhAkmVLle/acCvoBl
 H4MEfPqEcQcbFfBKPgT77R0fPskewge146R0/fkMkynK0uzE8fmsB0QwGmyCmsdwpc8UCen2f2k
 8FKUrVR4aAylFs3JIhJ1HHJ5TEgJveWU0o9r9wGgn/QRogbjwRjfaQ==
X-Received: by 2002:a05:600c:3b14:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-43ed0bf6aeemr103259865e9.11.1744009903604; 
 Mon, 07 Apr 2025 00:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8nsw/L/q9EC2mTJIE6lmRI8GQWSlApQ0UsLOvtYq0C8kAn/FSZjW+n9FXUWuB3JjBrlLDJg==
X-Received: by 2002:a05:600c:3b14:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-43ed0bf6aeemr103259635e9.11.1744009903223; 
 Mon, 07 Apr 2025 00:11:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16313edsm123959905e9.6.2025.04.07.00.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 00:11:42 -0700 (PDT)
Message-ID: <0fc40000-dbe0-4330-8bd7-b9229287d708@redhat.com>
Date: Mon, 7 Apr 2025 09:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 28/37] vfio: Make
 vfio_container_query_dirty_bitmap() static
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-29-clg@redhat.com>
 <92f88380-3df0-4a64-8544-389199ead6a1@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <92f88380-3df0-4a64-8544-389199ead6a1@oracle.com>
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

On 4/2/25 15:34, Joao Martins wrote:
> On 26/03/2025 07:51, Cédric Le Goater wrote:
>> vfio_container_query_dirty_bitmap() is only used in "container-base.c".
>> Also, rename to vfio_container_vioc_query_dirty_bitmap() to reflect it
>> is using the VFIO IOMMU backend device ->query_dirty_bitmap() handler.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> I would just call it:
> 
> 	vfio_container_iommu_query_dirty_bitmap
> 
> That holds better as one queries devices the other queries the container iommu
> backend. 'vioc' sort of leaks type definition unnecessarily which seems to go
> against the generally naming style

Agree. Done.

> 
> With that:
> 
> 	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>


Thanks,

C.


> 
>    Joao
> 
>> ---
>>   include/hw/vfio/vfio-container-base.h |  2 --
>>   hw/vfio/container-base.c              | 24 ++++++++++++------------
>>   2 files changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 1227771dd896b5917366ef578109b0ad92da2375..04c87fe48bed75aa281a13f75a36e345036a9163 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -89,8 +89,6 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>                                          MemoryRegionSection *section);
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>>                                              bool start, Error **errp);
>> -int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> -                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>   bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
>>   bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 4edbd39185375dee42ee6e6410da7b94635b5ab8..7f11aad339e713ea09123f361425370d87762950 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -141,16 +141,6 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>>       return ret;
>>   }
>>   
>> -int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> -                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>> -{
>> -    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> -
>> -    g_assert(vioc->query_dirty_bitmap);
>> -    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
>> -                                               errp);
>> -}
>> -
>>   static bool vfio_devices_all_device_dirty_tracking_started(
>>       const VFIOContainerBase *bcontainer)
>>   {
>> @@ -214,6 +204,16 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>>       return 0;
>>   }
>>   
>> +static int vfio_container_vioc_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> +                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>> +{
>> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +
>> +    g_assert(vioc->query_dirty_bitmap);
>> +    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
>> +                                               errp);
>> +}
>> +
>>   static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>>   {
>> @@ -263,8 +263,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>           ret = vfio_container_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>>                                                           errp);
>>       } else {
>> -        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>> -                                                errp);
>> +        ret = vfio_container_vioc_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>> +                                                     errp);
>>       }
>>   
>>       if (ret) {
> 


