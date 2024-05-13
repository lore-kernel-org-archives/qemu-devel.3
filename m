Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76901C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 16:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ycz-00044G-Bm; Mon, 13 May 2024 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6Ycs-000445-JO
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6Ycq-0001vN-FM
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715618046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtRWWA3qMX4MhUc2+ee3a5i2QgLY7ekSF6or0Lu60p4=;
 b=cz/rJ9SN+ufkw1FB/OKKgzH+jLEmY4U21Fue8P9ZIth0DG28xgfONebmuAMxM5FfrUHRWz
 gTiL1pWnzvlqYLtKjoNiYX7S0b3dHoFl1r1rFCkJvhwqVJks7u/fEwIFkSj/ef00mbBgg3
 15RJtwNVeMPmlt03/LcGYLrRGA3lwZI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-niRIN_9UOPymWRcTejSrOg-1; Mon, 13 May 2024 12:28:02 -0400
X-MC-Unique: niRIN_9UOPymWRcTejSrOg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43d1e3e7730so58104141cf.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 09:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715617682; x=1716222482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xtRWWA3qMX4MhUc2+ee3a5i2QgLY7ekSF6or0Lu60p4=;
 b=rhpcbQFLLlZKsFZ+VWYh5vRyFCiT4l/JInRaSGbSqp9vmq/FdDm6jZJE6AAfykUuiP
 WmBmYIaZvOC9Z2wcZy7ssFFP/84pStLfqYu+8MPlqRir7hVKAs7Z/+VXvB4olr3jwtdt
 mE0xQCxMt96IRc84V1w11Ws6iF1Qfz9rhAdSV9NirIhpv/+cm8f+pMAHjtkK2aoz5FF+
 OMLyCRqh8Ixw2mg0Q4bT36CGun+n5pUEe9Z0b/t2jD1whIVgRtB86eJHxIcYWBIAICY1
 P6Sl+1Z/x9qtIZCClCGN07omj3OH4MBBAHF3oBBySWjsuLZUcEW4H466Ku+eLkRoj+ov
 Itqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE18iNPhlZ+Lvzx/82HH4a6NZcKdHo3k8ToRmUmvphp1F7s6wPoi0GILfI4WJlAKbCfAzwuOLsZp7NpSGmyEoSL1d+x38=
X-Gm-Message-State: AOJu0YwjPltaDU+QhCZ253UXEnttJfEhePDWMGY0QAUiPl/Nzcm9yZKL
 UcsHxhSgn453vlJRHJpWHhg2CyHr2UhDSiymhbvKXMBmqfVEcmRhnRt/InRZ7eaRyQpygMxrjgv
 /tMtgi7Fby8url5/+2/4xNQSZjfKX2Kok/9i613X8KhyC44OO3htV
X-Received: by 2002:a05:6214:3293:b0:6a0:9378:5a8c with SMTP id
 6a1803df08f44-6a1680bd9f0mr119564756d6.0.1715617682160; 
 Mon, 13 May 2024 09:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA5j/ObolG10iVkG8NjbwImXDRSfU24y6sQE4heWmg3uhP01zsNtZ0EnzQ9mRYn0BA/ut8Ng==
X-Received: by 2002:a05:6214:3293:b0:6a0:9378:5a8c with SMTP id
 6a1803df08f44-6a1680bd9f0mr119564596d6.0.1715617681788; 
 Mon, 13 May 2024 09:28:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd3b5sm44879186d6.82.2024.05.13.09.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 09:28:01 -0700 (PDT)
Message-ID: <2ef7b720-31a8-48b6-b825-a64b3fe87a1f@redhat.com>
Date: Mon, 13 May 2024 18:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-2-clg@redhat.com>
 <2e55e1ad-5c40-4ae5-a362-5f7fd610b0e9@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <2e55e1ad-5c40-4ae5-a362-5f7fd610b0e9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/13/24 15:03, Avihai Horon wrote:
> Hi Cedric,
> 
> On 06/05/2024 12:20, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> We will use the Error object to improve error reporting in the
>> .log_global*() handlers of VFIO. Add documentation while at it.
> 
> First of all, I think commit 3688fec8923 ("memory: Add Error** argument to .log_global_start() handler") forgot to set errp in vfio_listener_log_global_start() in case of error.

yes. This is unfortunate. There has been a few respins, the series
was split and I was hoping to upstream this part sooner. My bad.

> This causes a null pointer de-reference if DPT start fails.
> Maybe add a fix for that in the beginning of this series, or as a stand-alone fix?

Since it is fixed by patch 1+2 of this series, we should be fine ?

> Back to this patch, personally, I found the split of patch #1 and #2 a bit confusing.
> Maybe consider squashing patch #1 and #2 so container based and device based DPT start/stop are changed in the same patch? Like you did in patch #8?
> Whatever you think is better.

ok. Let's see how v5 goes. I might just send a PR with it if
no major changes are requested.

> 
> In any case:
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>


Thanks,

C.


> 
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v5:
>>
>>   - Fixed typo in set_dirty_page_tracking documentation
>>
>>   include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>>   hw/vfio/common.c                      |  4 ++--
>>   hw/vfio/container-base.c              |  4 ++--
>>   hw/vfio/container.c                   |  6 +++---
>>   4 files changed, 23 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>                                          MemoryRegionSection *section);
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> -                                           bool start);
>> +                                           bool start, Error **errp);
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                                         VFIOBitmap *vbmap,
>>                                         hwaddr iova, hwaddr size);
>> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>                            AddressSpace *as, Error **errp);
>>       void (*detach_device)(VFIODevice *vbasedev);
>> +
>>       /* migration feature */
>> +
>> +    /**
>> +     * @set_dirty_page_tracking
>> +     *
>> +     * Start or stop dirty pages tracking on VFIO container
>> +     *
>> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
>> +     *              page tracking
>> +     * @start: indicates whether to start or stop dirty pages tracking
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>> -                                   bool start);
>> +                                   bool start, Error **errp);
>>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>>                                 VFIOBitmap *vbmap,
>>                                 hwaddr iova, hwaddr size);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1076,7 +1076,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           ret = vfio_devices_dma_logging_start(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
>>       }
>>
>>       if (ret) {
>> @@ -1096,7 +1096,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           vfio_devices_dma_logging_stop(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>>       }
>>
>>       if (ret) {
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>   }
>>
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> -                                           bool start)
>> +                                           bool start, Error **errp)
>>   {
>>       if (!bcontainer->dirty_pages_supported) {
>>           return 0;
>>       }
>>
>>       g_assert(bcontainer->ops->set_dirty_page_tracking);
>> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
>> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
>>   }
>>
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>
>>   static int
>>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>> -                                    bool start)
>> +                                    bool start, Error **errp)
>>   {
>>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>                                                     bcontainer);
>> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>>       if (ret) {
>>           ret = -errno;
>> -        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
>> -                     dirty.flags, errno);
>> +        error_setg_errno(errp, errno, "Failed to set dirty tracking flag 0x%x",
>> +                         dirty.flags);
>>       }
>>
>>       return ret;
>> -- 
>> 2.45.0
>>
> 


