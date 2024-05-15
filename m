Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCA1C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Hv2-0008Bx-2Y; Wed, 15 May 2024 12:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7Hux-00088M-Lo
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7Hut-0003li-Fk
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715792145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ff3v+7Dg5xIywfLNaTxjDvI6zay/vdyjybQ+YV2DEVM=;
 b=LVhhmRDr88YAIHEF0jyDaBpbPpMjMKs0Ty/Mbwqxey+yU2MdvfCfJiA7tc7u3PdfH52Ktg
 XRPLejRFy839AlWN1SzYNPlJkGNA2QZurwxBAr+DV9OX0zn8JGvQZHRXiS6P6Q/6SUw7OP
 5c/8svsTXJiS26xIf093NenhFU4V+PU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-UvfRCymVNta8j59dv4KhIQ-1; Wed, 15 May 2024 12:55:44 -0400
X-MC-Unique: UvfRCymVNta8j59dv4KhIQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43e0881c436so62969081cf.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715792144; x=1716396944;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ff3v+7Dg5xIywfLNaTxjDvI6zay/vdyjybQ+YV2DEVM=;
 b=VlDQI996Rt8DEWr3Qxwnn3PXWTJyksnaNZX9v/UKqvbWKF1B5i5q+YBZDDi+owm4v7
 vlLxq7VvVnpHGj7U/VgVyrEj9XeXeAm9y47+enDu58vISRs/rIyk0Qnq1lukdNnWKhlM
 jQ3AUlKYCW//CUWJ0kNzb5eJdFrBi+wXCZ61LM8Bn5qbK49zVJ1CUFS5kwg9GXhFh2Dp
 0VknmsDVBOwS+F2gbZuCW9K2yq/0BIfdN5Pdsv8AvLGT4N76k0i+TspLXYzBgguJto+I
 2WSqTEb1xSFtI8GECje0SO2+79Yxkj7N4Q2894MMI1bK4WPQfJ9Pp0aH8NSJ11hO44vH
 J0Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyocasIM4og+nVAtZvaUiGTnuBsQC6jKFmuM+PS577r/NDRXJ56IqbgAwtqsgfdRBN+3eBtxUh/7S4k+5Bj7p/O3f7mYg=
X-Gm-Message-State: AOJu0YyMEdp/dxPdqHyft27+DCuqIPzYw3J8WVviwN2ooiUUl2itBOoL
 93mGu4vuZPsvniB15tCgjkdG0mNpQCLMhezep5ZjjNZYr8DKnVYFx7ErsqLG6uj279GH9mudMyq
 wqWHmy/fzk7lsP66f/u601zswvI1xgAGVaILGwdZSmPvJIpfOdOC6
X-Received: by 2002:ac8:5a13:0:b0:43a:f091:29ec with SMTP id
 d75a77b69052e-43dfdabca6cmr194745021cf.21.1715792143999; 
 Wed, 15 May 2024 09:55:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO8yX7ecNVks+3VkSJFOGPATO8L5v9nFjQFxONalqRvs0uhQTsi2Zdt+puY3Zaj+pLxDE5rQ==
X-Received: by 2002:ac8:5a13:0:b0:43a:f091:29ec with SMTP id
 d75a77b69052e-43dfdabca6cmr194744641cf.21.1715792143338; 
 Wed, 15 May 2024 09:55:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df56d0396sm84695111cf.86.2024.05.15.09.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 09:55:42 -0700 (PDT)
Message-ID: <6d284119-131a-4bd4-bf51-7dffec02474c@redhat.com>
Date: Wed, 15 May 2024 18:55:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-2-clg@redhat.com>
 <123206c7-37e0-4e0a-9e04-49ed3f0cbc15@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <123206c7-37e0-4e0a-9e04-49ed3f0cbc15@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On 5/15/24 08:40, Eric Auger wrote:
> Hi Cédric,
> 
> On 5/14/24 17:31, Cédric Le Goater wrote:
>> We will use the Error object to improve error reporting in the
>> .log_global*() handlers of VFIO. Add documentation while at it.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   Changes in v5:
>>
>>   - Fixed typo in set_dirty_page_tracking documentation
>>   
>>   include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>>   hw/vfio/common.c                      |  4 ++--
>>   hw/vfio/container-base.c              |  4 ++--
>>   hw/vfio/container.c                   |  6 +++---
>>   4 files changed, 23 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>                                          MemoryRegionSection *section);
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> -                                           bool start);
>> +                                           bool start, Error **errp);
> I am a bit confused now wrt [PATCH v2 03/11] vfio: Make
> VFIOIOMMUClass::attach_device() and its wrapper return bool & co
> 
> Shall we return a bool or a int?

It would be better to follow the best practices described in qapi/error.h.

Zhenzhong excluded some files from his cleanup series to avoid conflicts
with this series of mine. And indeed, I would prefer to merge this one
first. It should be addressed later.


> 
> Looking at ./include/qapi/error.h I have not found any stringent requirement
> 
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that
>   *   we still have many functions returning void.  We recommend
>   *   • bool-valued functions return true on success / false on failure,
>   *   • pointer-valued functions return non-null / null pointer, and
>   *   • integer-valued functions return non-negative / negative.
> 
> 
> 
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                                         VFIOBitmap *vbmap,
>>                                         hwaddr iova, hwaddr size);
>> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>                            AddressSpace *as, Error **errp);
>>       void (*detach_device)(VFIODevice *vbasedev);
>> +
>>       /* migration feature */
>> +
>> +    /**
>> +     * @set_dirty_page_tracking
>> +     *
>> +     * Start or stop dirty pages tracking on VFIO container
>> +     *
>> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
>> +     *              page tracking
>> +     * @start: indicates whether to start or stop dirty pages tracking
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>> -                                   bool start);
>> +                                   bool start, Error **errp);
>>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>>                                 VFIOBitmap *vbmap,
>>                                 hwaddr iova, hwaddr size);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1076,7 +1076,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           ret = vfio_devices_dma_logging_start(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
>>       }
>>   
>>       if (ret) {
>> @@ -1096,7 +1096,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           vfio_devices_dma_logging_stop(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>>       }
>>   
>>       if (ret) {
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>   }
>>   
>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>> -                                           bool start)
>> +                                           bool start, Error **errp)
>>   {
>>       if (!bcontainer->dirty_pages_supported) {
>>           return 0;
>>       }
>>   
>>       g_assert(bcontainer->ops->set_dirty_page_tracking);
>> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
>> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
>>   }
>>   
>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>   
>>   static int
>>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>> -                                    bool start)
>> +                                    bool start, Error **errp)
>>   {
>>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>                                                     bcontainer);
>> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>>       if (ret) {
>>           ret = -errno;
>> -        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
>> -                     dirty.flags, errno);
>> +        error_setg_errno(errp, errno, "Failed to set dirty tracking flag 0x%x",
>> +                         dirty.flags);
>>       }
>>   
>>       return ret;
> 
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric


Thanks,

C.




