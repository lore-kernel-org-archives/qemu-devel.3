Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AE8C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4w6-00077q-57; Wed, 17 Jul 2024 09:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU4w3-0006tZ-FL
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU4vz-00086q-Q6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721223787;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gopACS077jS+1nalVCAjtjFiFkJfNVN2NSSrpNV/nDk=;
 b=hP1+LyxtUzWdvVZMCU/KCFgnYdwSaBKWBquNff30bpnWbK6GIIgYNHgEd00ZS9flClx09U
 4+pEY2KSzqKVplGOuTULQYAnXL3AZ5TDncs8SYKkmf7xX/JNrQcBmpcKE3L0iYFcb4p5Zr
 EinAC+o/9Ub6xzobsDACiNHCOLDpiNs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-2sNuHJaENcmXmWHXzKHL-Q-1; Wed, 17 Jul 2024 09:43:05 -0400
X-MC-Unique: 2sNuHJaENcmXmWHXzKHL-Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3678fbf4aa7so3927822f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223784; x=1721828584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gopACS077jS+1nalVCAjtjFiFkJfNVN2NSSrpNV/nDk=;
 b=W7X/zGX1cxsnDU3mpdFRCzCwMGMzmQcQgdA/5/j52yIbz1jO6dfbOEk8SFUHsz1f2z
 4BrkVAkjsVWa99mKDcUTxQea+O2VFmycDwm6QRGlCBfPWP7TBZoloa4iyM/HwGr5LvRA
 zwbEm3ZsoXEX7MdX059MqxkeevM0ruAk5JXVbQK3jO1KTez17VLqLOB6HUYMDeuINFb5
 9ffyVeIllguiqlH88kZ9VF98JmHjkk94R83p723AEc4ao9AhevBUpoUmfgdjhkxBDqYT
 S0qG6iAP8mUorF2xEZFcocg1lnwHnnFLdnIrqU4mb7b5EQ1xVYcZp0r6vpPflACR9lNb
 6apg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSuyOt9M58ppeH4dsaS6RCuL9GqvVT69QHhJlQkTebivPNFCRTyu77nocirKlZlflTjDJXTHgGnhh8B1rg4+cBj5T6b9E=
X-Gm-Message-State: AOJu0Yx2C9f2pj4BUbO47dAji0AwStO1LwSiRigS7WSTP0fE5ld5LZx3
 4nBvPebZ0Ri6DFWajV78f67yOHyh3QIaEU85TT1GH86xrkbAEY89EpYeUmdRR5pEatgUgmR7N28
 yp5JRR49WOYB7yF8/jUr+xms1VfpIFPlkItOqL8drjSfFpwmuvEtU
X-Received: by 2002:a5d:45d2:0:b0:367:4ddf:385c with SMTP id
 ffacd0b85a97d-368315e7ad6mr1265795f8f.6.1721223784502; 
 Wed, 17 Jul 2024 06:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpXZYEiA80agcjIYf2lWziOxewRt5J/D3ccmoP+qoY+JcEdc8qvT8IGPJQjxZ8/jVS3JB/GA==
X-Received: by 2002:a5d:45d2:0:b0:367:4ddf:385c with SMTP id
 ffacd0b85a97d-368315e7ad6mr1265773f8f.6.1721223784057; 
 Wed, 17 Jul 2024 06:43:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm11803380f8f.69.2024.07.17.06.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 06:43:03 -0700 (PDT)
Message-ID: <333ba549-9cd8-4246-ac93-81f92c441646@redhat.com>
Date: Wed, 17 Jul 2024 15:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-9-joao.m.martins@oracle.com>
 <6001b538-c191-4a78-a3bb-3d57de1b64cd@redhat.com>
 <a6c21e9f-daf0-41cf-a2e4-7450568977c7@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <a6c21e9f-daf0-41cf-a2e4-7450568977c7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/17/24 14:38, Joao Martins wrote:
> On 17/07/2024 13:27, Eric Auger wrote:
>> Hi Joao,
>>
>> On 7/12/24 13:47, Joao Martins wrote:
>>> Probe hardware dirty tracking support by querying device hw capabilities via
>>> IOMMUFD_GET_HW_INFO.
>> this is not what the patch brings. GET_HW_INFO is always in place.
> Yes. This is my mistake in squashing things as there was some shuffling going
> around on how we do GET_HW_INFO. and didn't adjust the right hand of this sentence.
>
> I'll rephrase it.
>
>>> In preparation to using the dirty tracking UAPI, request dirty tracking in the
>>> HWPT flags when the IOMMU supports dirty tracking.
>> this is what the patch brings.
> Right.
>
>>> The auto domain logic allows different IOMMU domains to be created when DMA
>>> dirty tracking is not desired (and VF can provide it) while others doesn't have
>> don't
> Right
>
>>> it and want the IOMMU capability. This is not used in this way here given how
>>> VFIODevice migration capability checking takes place *after* the device
>>> attachment.
>> Id on't understand the above sentence
>>
> The whole paragraph is meant to emphasize that we don't know if VF dirty
> tracking is supported because VFIODevice migration state hasn't been probed
> *yet*. And so we can't pick VF dirty tracking vs IOMMU dirty tracking at this
> stage when using IOMMU_HWPT_ALLOC_DIRTY_TRACKING flag and hence we always use it
> if IOMMU hw supports it even if later on VFIOMigration decides to use VF dirty
> tracking always instead.

that sounds a clearer explanation to me

Eric
>
>> Eric
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>  include/hw/vfio/vfio-common.h |  1 +
>>>  hw/vfio/iommufd.c             | 12 ++++++++++++
>>>  2 files changed, 13 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 2dd468ce3c02..760f31d84ac8 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>  
>>>  typedef struct VFIOIOASHwpt {
>>>      uint32_t hwpt_id;
>>> +    uint32_t hwpt_flags;
>>>      QLIST_HEAD(, VFIODevice) device_list;
>>>      QLIST_ENTRY(VFIOIOASHwpt) next;
>>>  } VFIOIOASHwpt;
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index d34dc88231ec..edc8f97d8f3d 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -246,6 +246,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>          }
>>>      }
>>>  
>>> +    /*
>>> +     * This is quite early and VFIODevice isn't yet fully initialized,
>> so what's the problem exactly with the above?
> I should really say 'VFIO Migration state' here (see previous comment)
>
>>> +     * thus rely on IOMMU hardware capabilities as to whether IOMMU dirty
>>> +     * tracking is going to be needed.
>>> +     */
>>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +    }
>>> +
>>>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>                                      container->ioas_id, flags,
>>>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,
>>> @@ -255,6 +264,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>  
>>>      hwpt = g_malloc0(sizeof(*hwpt));
>>>      hwpt->hwpt_id = hwpt_id;
>>> +    hwpt->hwpt_flags = flags;
>>>      QLIST_INIT(&hwpt->device_list);
>>>  
>>>      ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>> @@ -267,6 +277,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>      vbasedev->hwpt = hwpt;
>>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>> +    container->bcontainer.dirty_pages_supported |=
>>> +                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>>>      return true;
>>>  }
>>>  


