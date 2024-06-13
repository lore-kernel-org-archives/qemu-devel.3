Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F6C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 13:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHkfT-0005wZ-5E; Thu, 13 Jun 2024 09:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHkfR-0005wL-B8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 09:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHkfM-00040n-4Z
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 09:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718285938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjslBrGI6JRJPKhxVCd4cPQ3zxcNIxJjhmmXQ9kKu/c=;
 b=AY4dXAQU4xpthUSxdVzusbNmULlhkXWTCYjIqnHljVrmxMzcBju0HhrpohpuAwMTn2Z0pr
 lRIlZzVFo7CeMKW51+Ycv1hzL1k+dkXmDJmHE1kGvJWt6q71PZ35zTt/W2qNxvXSM57oqU
 IgbYHu/yxRug6EuMTViQp6dwjuVb02s=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-6C6vqrBeOh-wEP26WKyEwA-1; Thu, 13 Jun 2024 09:38:56 -0400
X-MC-Unique: 6C6vqrBeOh-wEP26WKyEwA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6f98cd3826bso893655a34.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 06:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718285935; x=1718890735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vjslBrGI6JRJPKhxVCd4cPQ3zxcNIxJjhmmXQ9kKu/c=;
 b=hPMJl2iZSu0ugTP+rTBUl+h1xAatLttwwxEXN2tb9+s2oWaB/GhZymZKxvS9LCzf08
 uzNWjMKuryTwyOiymMbfGd4BCYCvrwRjTc1oUm4xSwn1uj6u1AfpRq2pWFi09YN81PEk
 STa+4rmZCYGB1Z98iSBiiJ+SJFqGE47cjMWy8FjDmJWzHWJ+AIKv24udqR7e8jmJN1bT
 ojZifT5aXhpkcyfRK5MPqBn/laDWWx0v7dNG4sQ15loHA3cO/sLZJc0mlSySEIAkLwxv
 FZF2whRllhwTAQNT3t+N7LkvS6Xc/+1hSKudxa10aaZ+UIMgxEQ+roHg8u995J1T4sqV
 Z+Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Okb7tV94SkrIxImDsCFCdNUH+mmmBxjiCwoYU113Zr6q22JS8kogaoTNzjbVb5r7vufbtrZ3lcqetSPAmd9zIHne1SU=
X-Gm-Message-State: AOJu0YzAFQMvy8yxVkUrtcW0yt649Pba77X49AGezqwwYBe0oUZnSwwn
 TOxJqNrfNzPRBeYDhO36jDoYz0QAqe833gbYqWxLfrBXs7znKFcY4U/2spO0kNJxvTp3FFiPCK7
 Qw70Lwu6QBIqbEYNsCOM6NH72XRqk/XlB7OxlkCGd4QAqSNyTiTc5
X-Received: by 2002:a05:6830:3488:b0:6f9:6e0d:dfca with SMTP id
 46e09a7af769-6fa1bf5dbdcmr6565740a34.14.1718285935573; 
 Thu, 13 Jun 2024 06:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETROBg67sdwHxgQK4YjU1uDVHuTfh2eiPsN3iHtoxMctSSlHB8Nv30J1ZR0IVK2aD8Fh0SKg==
X-Received: by 2002:a05:6830:3488:b0:6f9:6e0d:dfca with SMTP id
 46e09a7af769-6fa1bf5dbdcmr6565712a34.14.1718285935017; 
 Thu, 13 Jun 2024 06:38:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798caafd87dsm11987585a.119.2024.06.13.06.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 06:38:54 -0700 (PDT)
Message-ID: <04834b0f-38a3-4fa4-878c-d032662cfc60@redhat.com>
Date: Thu, 13 Jun 2024 15:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/16] vfio/container: Remove vfio_container_init()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240612130122.813935-1-clg@redhat.com>
 <20240612130122.813935-16-clg@redhat.com>
 <SJ0PR11MB674417EA5535737259F15DE492C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674417EA5535737259F15DE492C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/13/24 11:20 AM, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH v1 15/16] vfio/container: Remove vfio_container_init()
>>
>> It's now empty.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> include/hw/vfio/vfio-container-base.h | 2 --
>> hw/vfio/container-base.c              | 5 -----
>> hw/vfio/container.c                   | 3 ---
>> hw/vfio/iommufd.c                     | 1 -
>> 4 files changed, 11 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>> index
>> 6b57cd8e7f5d7d2817f6e3b96ce4566d2630bb12..6242a62771caa8cf19440
>> a53ad6f4db862ca12d7 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -86,8 +86,6 @@ int
>> vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> int vfio_container_query_dirty_bitmap(const VFIOContainerBase
>> *bcontainer,
>>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>
>> -void vfio_container_init(VFIOContainerBase *bcontainer,
>> -                         const VFIOIOMMUClass *ops);
>> void vfio_container_destroy(VFIOContainerBase *bcontainer);
> 
> Maybe we can do the same for vfio_container_destroy()?
> Move the code into .instance_finalize().

yes. let's add a instance_finalize handler.

Thanks,

C.

> 
> Thanks
> Zhenzhong
> 
>>
>>
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index
>> 24669d4d7472f49ac3adf2618a32bf7d82c5c344..970ae2356a92f87df44e1d
>> d58ff8c67045a24ef1 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -83,11 +83,6 @@ int vfio_container_query_dirty_bitmap(const
>> VFIOContainerBase *bcontainer,
>>                                                 errp);
>> }
>>
>> -void vfio_container_init(VFIOContainerBase *bcontainer,
>> -                         const VFIOIOMMUClass *ops)
>> -{
>> -}
>> -
>> void vfio_container_destroy(VFIOContainerBase *bcontainer)
>> {
>>      VFIOGuestIOMMU *giommu, *tmp;
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index
>> 9e9e1ab229c0804f073cd65d92735d4bbf63d1d7..60a0838a9ca83a010d733
>> 96dbcd2d24fcdc802ae 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -419,7 +419,6 @@ static VFIOContainer *vfio_create_container(int fd,
>> VFIOGroup *group,
>>                                              Error **errp)
>> {
>>      int iommu_type;
>> -    const VFIOIOMMUClass *vioc;
>>      const char *vioc_name;
>>      VFIOContainer *container;
>>
>> @@ -433,12 +432,10 @@ static VFIOContainer *vfio_create_container(int
>> fd, VFIOGroup *group,
>>      }
>>
>>      vioc_name = vfio_get_iommu_class_name(iommu_type);
>> -    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
>>
>>      container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>>      container->fd = fd;
>>      container->iommu_type = iommu_type;
>> -    vfio_container_init(&container->bcontainer, vioc);
>>      return container;
>> }
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index
>> e1932135df410c53d4062616ee2664b27d30b92c..811e12b7da91357fa5b8
>> 5ebb9dcc3adeabfa41fd 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -357,7 +357,6 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>      container->ioas_id = ioas_id;
>>
>>      bcontainer = &container->bcontainer;
>> -    vfio_container_init(bcontainer, iommufd_vioc);
>>      vfio_address_space_insert(space, bcontainer);
>>
>>      if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>> --
>> 2.45.2
> 


