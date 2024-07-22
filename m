Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2285DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVuQ9-0000mV-FX; Mon, 22 Jul 2024 10:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVuQ2-0000kz-HV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVuPy-0001gx-1K
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721660015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0Mf5rgCKchnsAOErpbTgcmp12w8QxTlco4vT6xm1ss=;
 b=b/EP3NSRploj/ENYcGqCGyQX1Zo0zxD2w2c9HIuLhkf6rV3o9IjqnCABsV+k/LwntYvk17
 3EzkuKPVLdw3tLeA6MmL+Ehh5B5moT+ub6HPT6TuQI7mfmw1kTt4XDC+BCJna9YV7uvkhS
 MWYeo4hH2oQqLccoMv4NviSo2eJhNfk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-1Ts6b2-LOeK_yVhQrbaibQ-1; Mon, 22 Jul 2024 10:53:33 -0400
X-MC-Unique: 1Ts6b2-LOeK_yVhQrbaibQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79efc957469so540288685a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721660009; x=1722264809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l0Mf5rgCKchnsAOErpbTgcmp12w8QxTlco4vT6xm1ss=;
 b=tYYHnGvSM6Nqxs2mkB5PRa9Vjygy7Q1Zqt0vnGQ/bCFSYcgbE+G14p1jB/VGWE+dWk
 QWPVCm2Ntx3cymOc6uo73vUbhUbnPvtV8JZYWs3uMXSXEpMHPZOjoq4YZ0aF6boOq5FF
 uI6b4mcN2B+sNlaYrcmrt2QJLL6qDeW2el5RIc4E03jCD1ArP87+1cE5cLlXIw4Uy03+
 tMmCS3xG/BuM+jHyAAi1zA0krE3zJ34w6/PaVyCOUtM+YnXTLdh1ZDzzBvgjTDTHWt7E
 CbjhZz4En9lrtDL2BqZd2O97JxwgBeIPb694LzGj4Gpp8MFNH0qBOP8yojA5AMEqji/K
 dp6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYKzmG9Iq40Whp+kasYvbiuhHY0lMG/xZodE7hc2AG9c9v5UrrpehEdTWlVCcu7/CPFgNKxoc901pwHgfb/DTVeqSeVDo=
X-Gm-Message-State: AOJu0YxWltHzn91pwkiPbW7kC4P80a6Mzj/PVJ1TMHxf4TIIxYQEKzrf
 McIYn4JFfJgavzK3oVFaE76fH+N+cBV+JpfEwjdw2vOVwSjvQ5gVZODDpIuQR/1umTdXjVAlDSO
 M6i06wdlrOqxmC8NftV8VPu4Xhs//LgIHEhTYagdKLAPF8Q6JWIuJ
X-Received: by 2002:a05:620a:17a3:b0:79f:17da:6444 with SMTP id
 af79cd13be357-7a1a13a88ddmr1271400585a.47.1721660008954; 
 Mon, 22 Jul 2024 07:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTMQC404fiBdL45X4xVBfC513xX+p+2uqQOLCFKKLCYbQmELiavFsUR5qgyWT3pnHhv9tPtw==
X-Received: by 2002:a05:620a:17a3:b0:79f:17da:6444 with SMTP id
 af79cd13be357-7a1a13a88ddmr1271397385a.47.1721660008556; 
 Mon, 22 Jul 2024 07:53:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19906038asm365815785a.92.2024.07.22.07.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:53:28 -0700 (PDT)
Message-ID: <967952f0-e3bd-4c86-b4a8-4906e6b3e248@redhat.com>
Date: Mon, 22 Jul 2024 16:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
 <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
 <1304a8c4-be47-4b47-88dd-328a8f167e54@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <1304a8c4-be47-4b47-88dd-328a8f167e54@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On 7/19/24 19:26, Joao Martins wrote:
> On 19/07/2024 15:24, Joao Martins wrote:
>> On 19/07/2024 15:17, Cédric Le Goater wrote:
>>> On 7/19/24 14:05, Joao Martins wrote:
>>>> By default VFIO migration is set to auto, which will support live
>>>> migration if the migration capability is set *and* also dirty page
>>>> tracking is supported.
>>>>
>>>> For testing purposes one can force enable without dirty page tracking
>>>> via enable-migration=on, but that option is generally left for testing
>>>> purposes.
>>>>
>>>> So starting with IOMMU dirty tracking it can use to accomodate the lack of
>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>> migration and thus enabling migration by default for those too.
>>>>
>>>> While at it change the error messages to mention IOMMU dirty tracking as
>>>> well.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>>    include/hw/vfio/vfio-common.h |  1 +
>>>>    hw/vfio/iommufd.c             |  2 +-
>>>>    hw/vfio/migration.c           | 11 ++++++-----
>>>>    3 files changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index 7e530c7869dc..00b9e933449e 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>>> VFIOContainerBase *bcontainer,
>>>>                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>>>    int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>>                              uint64_t size, ram_addr_t ram_addr, Error **errp);
>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>      /* Returns 0 on success, or a negative errno. */
>>>>    bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 7dd5d43ce06a..a998e8578552 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -111,7 +111,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice
>>>> *vbasedev)
>>>>        iommufd_backend_disconnect(vbasedev->iommufd);
>>>>    }
>>>>    -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>    {
>>>>        return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>>    }
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>>>> Error **errp)
>>>>            return !vfio_block_migration(vbasedev, err, errp);
>>>>        }
>>>>    -    if (!vbasedev->dirty_pages_supported) {
>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>>
>>>
>>> Some platforms do not have IOMMUFD support and this call will need
>>> some kind of abstract wrapper to reflect dirty tracking support in
>>> the IOMMU backend.
>>>
>>
>> This was actually on purpose because only IOMMUFD presents a view of hardware
>> whereas type1 supporting dirty page tracking is not used as means to 'migration
>> is supported'.
>>
>> The hwpt is nil in type1 and the helper checks that, so it should return false.
>>
> 
> Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally didn't
> consider. Maybe this would be a elegant way to address it? Looks to pass my
> build with CONFIG_IOMMUFD=n
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 61dd48e79b71..422ad4a5bdd1 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase
> *bcontainer,
>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
> +#ifdef CONFIG_IOMMUFD
>   bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
> +#else
> +static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
> +{
> +    return false;
> +}
> +#endif
> 
>   /* Returns 0 on success, or a negative errno. */
>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> 

hmm, no. You will need to introduce a new Host IOMMU device capability,
something like :

    HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING,

Then, introduce an helper routine to check the capability  :

    return hiodc->get_cap( ... HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING...)
  
and replace the iommufd_hwpt_dirty_tracking call with it.

Yeah I know, it's cumbersome but it's cleaner !

That's not a major problem in the series. I can address it at the end
to avoid a resend. First, let's get a R-b on all other patches.

Thanks,

C.



