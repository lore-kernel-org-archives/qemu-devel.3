Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A339C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Ds2-00075K-Rn; Wed, 15 May 2024 08:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7Ds0-00073F-FY
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7Drx-0004dG-Ut
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715776588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXHcEqY/q1dZm7UbAC2cbmF1zgQohDen4dz7UOyPm4E=;
 b=Tw/t5X/8WC8Kn5LpPDN2XSzzGzvXJuEBETarHklsBNqqXxjOHXb2rbFXgK9kW2tFOf8LZ4
 /BHEt61EdkhFPVUm5m8D/kLaMhg9pN23A9YgATFGg12K1RugiG7cQ+lR1N04ktg823POsH
 Ln0972npuKBHzhv1yDg4k3nCtIsoqGY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-m-YQxRz_MVqSwANyooYyvw-1; Wed, 15 May 2024 08:36:27 -0400
X-MC-Unique: m-YQxRz_MVqSwANyooYyvw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43e0e94fa82so52421161cf.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776587; x=1716381387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lXHcEqY/q1dZm7UbAC2cbmF1zgQohDen4dz7UOyPm4E=;
 b=waEe4co8Wp/hZuvRjU+yiagH3i/LK93Xl93K6hqyDdPAFkvAoyjsKuRofgRt7IrOul
 aIBXA62FGufbOt1lHaw+LapYv0ImnxJRyh2zotea6aATrzlnayhp0Ts9WEvBnIy4DVYW
 h6Fd+WEaEk4v/rY7Qrvo+AdQ1OhER3KX2SEy2dVe3MBxuC3Xn2AaBf20/rConuNEukbt
 3U90AItRbXz6WWMhDRNa/Mgt4RmR+rEQqhu2ez3M4p2rLATaAxYpR7L8dhXquTE/hZnD
 QTNMVMMp8/sxkoOMdNPb2JcHCeLd+lqYmFGkw6a1hKafrmp2KniQU+x2Mzkrq7IeiKqb
 vCqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS9k0NN7UqDTw4Aixc0bBLR7iD1lxclYwfJcz3GZtpCoOfRTUGjUvpa5KO4EqWu8m2/gTA9ST04zrBgenZ1SwCLhLGAjk=
X-Gm-Message-State: AOJu0Yxxds6P8rfHGiZV++N2EwKpueZcMYZOHhYYOaHrlDm2N9sTTIvq
 c3aUDO6gZs5UJalOFYm3mpuzn0rEcQEU72vuCP6k0UB/eC1q3jf0kgGLA5Y/E0uBvE3IYS1OfyH
 ti5aRatIPTzBnwyNTJ/+b35bVwW3yYYR98uCFQWCFBOnlAOHAQQfm
X-Received: by 2002:a05:622a:514:b0:43b:86d:744d with SMTP id
 d75a77b69052e-43dfdabaca7mr182788521cf.9.1715776586675; 
 Wed, 15 May 2024 05:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn577SKoepeUmYFZMrmQro2vBCmGaGe6M0xnIIl/Su1yPwUcffLshDBzKx4kGJCaLGmMqDlg==
X-Received: by 2002:a05:622a:514:b0:43b:86d:744d with SMTP id
 d75a77b69052e-43dfdabaca7mr182788231cf.9.1715776586234; 
 Wed, 15 May 2024 05:36:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43dfe46c114sm71507491cf.0.2024.05.15.05.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:36:25 -0700 (PDT)
Message-ID: <d450c8c1-f23f-40e8-9e9c-26c8a161b4e0@redhat.com>
Date: Wed, 15 May 2024 14:36:22 +0200
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
 <2ef7b720-31a8-48b6-b825-a64b3fe87a1f@redhat.com>
 <020da629-845f-4599-92da-33cf41ad92f4@nvidia.com>
 <d8af0e9c-fa15-460b-b267-5e6a63d75f96@redhat.com>
 <c7d95391-551d-4d32-aaab-d2e0a47acddb@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <c7d95391-551d-4d32-aaab-d2e0a47acddb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/15/24 14:29, Avihai Horon wrote:
> 
> On 15/05/2024 15:25, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 5/15/24 14:17, Avihai Horon wrote:
>>>
>>> On 13/05/2024 19:27, Cédric Le Goater wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 5/13/24 15:03, Avihai Horon wrote:
>>>>> Hi Cedric,
>>>>>
>>>>> On 06/05/2024 12:20, Cédric Le Goater wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> We will use the Error object to improve error reporting in the
>>>>>> .log_global*() handlers of VFIO. Add documentation while at it.
>>>>>
>>>>> First of all, I think commit 3688fec8923 ("memory: Add Error** argument to .log_global_start() handler") forgot to set errp in vfio_listener_log_global_start() in case of error.
>>>>
>>>> yes. This is unfortunate. There has been a few respins, the series
>>>> was split and I was hoping to upstream this part sooner. My bad.
>>>>
>>>>> This causes a null pointer de-reference if DPT start fails.
>>>>> Maybe add a fix for that in the beginning of this series, or as a stand-alone fix?
>>>>
>>>> Since it is fixed by patch 1+2 of this series, we should be fine ?
>>>
>>> A fix could be useful to be backported to QEMU 9.0, no?
>>
>> These changes were only merged in 9.1 with the migration PR.
>> Am I missing something ?
> 
> Oh, my bad. I thought they were merged in 9.0.
> So patches 1+2 should cover it.

yeah. I still would like to merge them asap, with your little series
possibly, the one adding the event, plus the 2 cleanup series from
ZhenZhong. I will update vfio-next when they are sufficiently reviewed.


Thanks,

C.



> 
> Thanks.
> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>>
>>>>
>>>>> Back to this patch, personally, I found the split of patch #1 and #2 a bit confusing.
>>>>> Maybe consider squashing patch #1 and #2 so container based and device based DPT start/stop are changed in the same patch? Like you did in patch #8?
>>>>> Whatever you think is better.
>>>>
>>>> ok. Let's see how v5 goes. I might just send a PR with it if
>>>> no major changes are requested.
>>>>
>>>>>
>>>>> In any case:
>>>>> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>>> ---
>>>>>>
>>>>>>   Changes in v5:
>>>>>>
>>>>>>   - Fixed typo in set_dirty_page_tracking documentation
>>>>>>
>>>>>>   include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>>>>>>   hw/vfio/common.c                      |  4 ++--
>>>>>>   hw/vfio/container-base.c              |  4 ++--
>>>>>>   hw/vfio/container.c                   |  6 +++---
>>>>>>   4 files changed, 23 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>>>>>> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 100644
>>>>>> --- a/include/hw/vfio/vfio-container-base.h
>>>>>> +++ b/include/hw/vfio/vfio-container-base.h
>>>>>> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>>>>>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>>>>> MemoryRegionSection *section);
>>>>>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>>>>>> -                                           bool start);
>>>>>> +                                           bool start, Error **errp);
>>>>>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>>                                         VFIOBitmap *vbmap,
>>>>>>                                         hwaddr iova, hwaddr size);
>>>>>> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>>>>>>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>>>>>                            AddressSpace *as, Error **errp);
>>>>>>       void (*detach_device)(VFIODevice *vbasedev);
>>>>>> +
>>>>>>       /* migration feature */
>>>>>> +
>>>>>> +    /**
>>>>>> +     * @set_dirty_page_tracking
>>>>>> +     *
>>>>>> +     * Start or stop dirty pages tracking on VFIO container
>>>>>> +     *
>>>>>> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
>>>>>> +     *              page tracking
>>>>>> +     * @start: indicates whether to start or stop dirty pages tracking
>>>>>> +     * @errp: pointer to Error*, to store an error if it happens.
>>>>>> +     *
>>>>>> +     * Returns zero to indicate success and negative for error
>>>>>> +     */
>>>>>>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>>>>>> -                                   bool start);
>>>>>> +                                   bool start, Error **errp);
>>>>>>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>>>>>>                                 VFIOBitmap *vbmap,
>>>>>>                                 hwaddr iova, hwaddr size);
>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>>> index 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 100644
>>>>>> --- a/hw/vfio/common.c
>>>>>> +++ b/hw/vfio/common.c
>>>>>> @@ -1076,7 +1076,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>>>>>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>>>           ret = vfio_devices_dma_logging_start(bcontainer);
>>>>>>       } else {
>>>>>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
>>>>>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
>>>>>>       }
>>>>>>
>>>>>>       if (ret) {
>>>>>> @@ -1096,7 +1096,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>>>>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>>>>           vfio_devices_dma_logging_stop(bcontainer);
>>>>>>       } else {
>>>>>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
>>>>>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>>>>>>       }
>>>>>>
>>>>>>       if (ret) {
>>>>>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>>>>>> index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
>>>>>> --- a/hw/vfio/container-base.c
>>>>>> +++ b/hw/vfio/container-base.c
>>>>>> @@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>>>>>   }
>>>>>>
>>>>>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>>>>>> -                                           bool start)
>>>>>> +                                           bool start, Error **errp)
>>>>>>   {
>>>>>>       if (!bcontainer->dirty_pages_supported) {
>>>>>>           return 0;
>>>>>>       }
>>>>>>
>>>>>> g_assert(bcontainer->ops->set_dirty_page_tracking);
>>>>>> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
>>>>>> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
>>>>>>   }
>>>>>>
>>>>>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>>>> index 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 100644
>>>>>> --- a/hw/vfio/container.c
>>>>>> +++ b/hw/vfio/container.c
>>>>>> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>>>>>
>>>>>>   static int
>>>>>>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>>>>>> -                                    bool start)
>>>>>> +                                    bool start, Error **errp)
>>>>>>   {
>>>>>>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>>>>> bcontainer);
>>>>>> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>>>>>>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>>>>>>       if (ret) {
>>>>>>           ret = -errno;
>>>>>> -        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
>>>>>> -                     dirty.flags, errno);
>>>>>> +        error_setg_errno(errp, errno, "Failed to set dirty tracking flag 0x%x",
>>>>>> +                         dirty.flags);
>>>>>>       }
>>>>>>
>>>>>>       return ret;
>>>>>> -- 
>>>>>> 2.45.0
>>>>>>
>>>>>
>>>>
>>>
>>
> 


