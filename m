Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6F6C25B7D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 13:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBaWC-0008IO-Ey; Mon, 27 May 2024 09:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sBaW9-0008Gy-FN
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sBaW7-00087j-H9
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716816958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mL2L9ouoWh5wekpYXmxO4bHVJ1jg8j9nZzrZi/r2PSA=;
 b=YtbCAF41HCcLL6j4Hm/zd2+INkixrwBYx2E7x0YSOJazJj3gqMwt/GyaNvQ/2hcJHatGH2
 yPRMvykCHD/xGc1KwLixuwSr9PUD+LDpqW0VQalrHznYtSnH6jH6PgnMU4tJzky1LxvkUj
 2+myMWatvaGGbT2htPL6MZ3ffspVi1E=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-NfkoSAybM_O6ZF3-UJyfzQ-1; Mon, 27 May 2024 09:35:56 -0400
X-MC-Unique: NfkoSAybM_O6ZF3-UJyfzQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3d1c5b88672so795643b6e.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 06:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716816955; x=1717421755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mL2L9ouoWh5wekpYXmxO4bHVJ1jg8j9nZzrZi/r2PSA=;
 b=ln4fNM+cV9YfV2y1G3+XLp6w1TZs9i9VN3taJdtLSfUxIMZeM9YJWkJoV4aRK/y8As
 nzGGoF1SKLzdkQuAgosGYmcb1b3oZvc7ZJnDfHNKDsbGMYwQ1vX99pEOQ2ROepWawyB+
 bfaGH49dyfSMybd/SvQMLXQgSy4m5GYLZsD4DBYUeIkl6wNcj3XsLQO0Pe+/+89gy1qf
 2Of+hHw9owdBXzBQHqSchNKwR5bAMZ4X2PynnXqfTwog+fkNSvu1j9QGsm7bjRK+aXzv
 YThzHMqRmacrD15tM0//B9H2RoTuENzTu2KWIgZ6CNyPkAAgllDdHp5aHGg2lbI61VgZ
 92YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU97rP1imah0/qeoS68vAuG7QIXnYbgkoA4Njf4CQzqJKPwKQMmSh1U2dBEvSRdl7RmZBa6rSCt5loTcdln1DwV+WcNJ5M=
X-Gm-Message-State: AOJu0YyEMoL/HJUOmdksUjw4htDQoCswWIgUwFzzRWxHeOq/78QevCPw
 eLi68w6iE21areJ71/yQk3ayaK4LiKX9bHgxF+PKQf1SZrhZu6DQkdjnatrJmTZxnMaVGhYViRa
 Ekfta+6rU3Zg9SGQRxLy2EO4wpT8kXVTY/puQwGP1qyENG0mKUhQi
X-Received: by 2002:a05:6808:6086:b0:3c9:cf09:a847 with SMTP id
 5614622812f47-3d1a7647769mr9309880b6e.40.1716816955646; 
 Mon, 27 May 2024 06:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNmcBED045g/nYpweTYUILjEh7pUfPWR5OEwuzPfpd23fNuf9XA921lGGP1IRrBsnSXTQuDQ==
X-Received: by 2002:a05:6808:6086:b0:3c9:cf09:a847 with SMTP id
 5614622812f47-3d1a7647769mr9309854b6e.40.1716816955216; 
 Mon, 27 May 2024 06:35:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:151b:2482:8f7e:1f56?
 ([2a01:e0a:280:24f0:151b:2482:8f7e:1f56])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac162fdfd7sm34051966d6.105.2024.05.27.06.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 06:35:54 -0700 (PDT)
Message-ID: <a5286af7-7aef-4db4-933e-510957e59e23@redhat.com>
Date: Mon, 27 May 2024 15:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>, harshpb@linux.ibm.com, npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, zhenzhong.duan@intel.com,
 qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
 <30e9ce3e-08d4-4ab4-b734-d7a7fb0639a9@kaod.org>
 <22634714-47ea-4421-9c2d-1ca61f25879c@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <22634714-47ea-4421-9c2d-1ca61f25879c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/22/24 18:15, Shivaprasad G Bhat wrote:
> On 5/13/24 17:53, Cédric Le Goater wrote:
>> Hello Shivaprasad,
>>
>> On 5/9/24 21:14, Shivaprasad G Bhat wrote:
>>> The commit 6ad359ec29 "(vfio/spapr: Move prereg_listener into
>>> spapr container)" began to use the newly introduced VFIOSpaprContainer
>>> structure.
>>>
>>> After several refactors, today the container_of(container,
>>> VFIOSpaprContainer, ABC) is used when VFIOSpaprContainer is actually
>>> not allocated. On PPC64 systems, this dereference is leading to corruption
>>> showing up as glibc malloc assertion during guest start when using vfio.
>>>
>>> Patch adds the missing allocation while also making the structure movement
>>> to vfio common header file.
>>>
>>> Fixes: 6ad359ec29 "(vfio/spapr: Move prereg_listener into spapr container)"
>>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>> ---
>>>   hw/vfio/container.c           |    6 ++++--
>>>   hw/vfio/spapr.c               |    6 ------
>>>   include/hw/vfio/vfio-common.h |    6 ++++++
>>>   3 files changed, 10 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 77bdec276e..ecaf5786d9 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -539,6 +539,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>>   {
>>>       VFIOContainer *container;
>>>       VFIOContainerBase *bcontainer;
>>> +    VFIOSpaprContainer *scontainer;
>>
>> We should do our best to avoid any direct use of ppc related attributes
>> in the common VFIO code. This comment also applies to VFIO_SPAPR_TCE*
>> which are still there because the clean up is not finished. So, this
>> proposal will have to be reworked.
>>
> Sure.
>> The first step is to finish the QOMification of VFIOContainer, so
>> that the VFIOContainer instance is created in vfio_connect_container()
>> with :
>>
>>     container = qdev_new(iommu_type_name);
> 
> This requires the VFIOContainer to be a DeviceState object.
> 
> The existing base class TYPE_VFIO_IOMMU is an InterfaceClass.
> 
> I attempted VFIOContainer object declaration with TYPE_VFIO_IOMMU,
> 
> like
> 
> OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY)
> 
> 
>>
>> This means reworking this part (and vfio_set_iommu()) :
>>
>>     ...
>>     container = g_malloc0(sizeof(*container));
>>     container->fd = fd;
>>     bcontainer = &container->bcontainer;
>>
>>     if (!vfio_set_iommu(container, group->fd, space, errp)) {
>>         goto free_container_exit;
>>     }
>>     ...
>>
>> VFIOSpaprContainer can then implement its own .init_instance() handler
>> to allocate/initialize attributes required by the pseries machines.
> 
> 
> With my above changes,
> 
> I see the instance_init() is not supported for the InterfaceClass with the


Yes. We need an Object, hence my remark on "QOMification of VFIOContainer".
VFIOContainerBase needs to be reworked.

Thanks,

C.

> 
> checks from below
> 
> commit 422ca1432f7b44f2a9f3ad94a65d36927da021fa
> Author: Marc-André Lureau <marcandre.lureau@redhat.com>
> Date:   Wed Sep 12 16:53:03 2018 +0400
> 
>      qom/object: add some interface asserts
> 
> Did you suggest me something else?



> 
> 
> Thank you,
> 
> Shivaprasad
> 
>>
>> While doing this, please try to reduce the use of ->iommu_type which
>> is a design shortcut. I would like to completely remove it at some
>> point.
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>
>>
>>
>>
>>>       int ret, fd;
>>>       VFIOAddressSpace *space;
>>>
>>> @@ -611,7 +612,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>>           goto close_fd_exit;
>>>       }
>>>
>>> -    container = g_malloc0(sizeof(*container));
>>> +    scontainer = g_malloc0(sizeof(*scontainer));
>>> +    container = &scontainer->container;
>>>       container->fd = fd;
>>>       bcontainer = &container->bcontainer;
>>>
>>> @@ -675,7 +677,7 @@ unregister_container_exit:
>>>       vfio_cpr_unregister_container(bcontainer);
>>>
>>>   free_container_exit:
>>> -    g_free(container);
>>> +    g_free(scontainer);
>>>
>>>   close_fd_exit:
>>>       close(fd);
>>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>>> index 0d949bb728..78d218b7e7 100644
>>> --- a/hw/vfio/spapr.c
>>> +++ b/hw/vfio/spapr.c
>>> @@ -24,12 +24,6 @@
>>>   #include "qapi/error.h"
>>>   #include "trace.h"
>>>
>>> -typedef struct VFIOSpaprContainer {
>>> -    VFIOContainer container;
>>> -    MemoryListener prereg_listener;
>>> -    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>>> -} VFIOSpaprContainer;
>>> -
>>>   static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
>>>   {
>>>       if (memory_region_is_iommu(section->mr)) {
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index b9da6c08ef..010fa68ac6 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -82,6 +82,12 @@ typedef struct VFIOContainer {
>>>       QLIST_HEAD(, VFIOGroup) group_list;
>>>   } VFIOContainer;
>>>
>>> +typedef struct VFIOSpaprContainer {
>>> +    VFIOContainer container;
>>> +    MemoryListener prereg_listener;
>>> +    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>>> +} VFIOSpaprContainer;
>>> +
>>>   typedef struct VFIOHostDMAWindow {
>>>       hwaddr min_iova;
>>>       hwaddr max_iova;
>>>
>>>
>>


