Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6008C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racbD-0005S9-I7; Thu, 15 Feb 2024 09:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1racbB-0005Re-16
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:20:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1racb8-0008WL-Ux
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708006821;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAeAmtiZqVWZ1bCF0JHGCoUIgx/D2jwPIXGHoB9U5JA=;
 b=Edi6rsmUpWH1QzaZ38f3j07kE7zi+GPvWf0L7gJ3NZiPGs83RsDAz4D2MDC4T7xjHxVhqK
 m1TeaoJgzo+O9u0v94hCbhWgLCVeE1I44h3Gkw0MvObuVT0oiFPVW71JBUqyg6/LxX/X4q
 zixARSC/OscNq2SBlzRzlV2D6gSkmAU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-0MpK5JBkNeO5iw-nRyupdQ-1; Thu, 15 Feb 2024 09:20:20 -0500
X-MC-Unique: 0MpK5JBkNeO5iw-nRyupdQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c137714c32so543754b6e.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006819; x=1708611619;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iAeAmtiZqVWZ1bCF0JHGCoUIgx/D2jwPIXGHoB9U5JA=;
 b=XgAA5k0yHELtelhZkODcxFPV56woe5yWpMRcuK35m+oj0xJHHoeD3naxc5GLp8jZV9
 Jt0SabYniok0JPljUPAlnEFQROgJv/Jxk1UF6QNAFBWuWodgCadStyr7jdu62BBm6r61
 hH93QPXia5AgRLWt7Hmp5Qogp+3C0GyVoAp/TizfSrsz7C0U9A820qT2LBejWiOc2p6M
 Y6TGv0YZtgbhS6RFEUWqj8+LA2TXgceY7keDIbaBGKqoal7wDdfdTwPCZwtLpxUhuVnr
 4LX4oQQ9A3N+jusgDq/I7gLdw99150gSTrmLxutpU5J2ntVCwznRVYYxDiF23cBWwL2V
 00LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS8s4qYqDTkozz72zOdtRQWniRVEGLjnfH5gJP56OmGwO6UxMZ9JiRBwTPeaM2xRcrWCsXnADmdksDc8y1acU8G5Mh73g=
X-Gm-Message-State: AOJu0YykxFM4bxIl+JCxbGASI3j1d11p8gGjfgLdcLNiwzf6HzIFxtGF
 oPF8FAA5n4jBoRHOgxZpUNhRJhMWvG67d8N05fIqbte5X8VNkh/nWES3l54Ju+XVJrBIeauX+lr
 yzy7Zg528bPeSMjA5IOYwSdxJNQE52OPUEMZmHhJLT6spDjCAy7uL
X-Received: by 2002:a05:6808:138c:b0:3c1:34a4:a0d4 with SMTP id
 c12-20020a056808138c00b003c134a4a0d4mr2440532oiw.4.1708006819451; 
 Thu, 15 Feb 2024 06:20:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXD5jHhgDjsvsJ7/XiVq4UeLTbEss1YQlFW3uQnYAQaBSKwuc2+nmgfcCtdL4ZgOI5BlT7aQ==
X-Received: by 2002:a05:6808:138c:b0:3c1:34a4:a0d4 with SMTP id
 c12-20020a056808138c00b003c134a4a0d4mr2440494oiw.4.1708006819073; 
 Thu, 15 Feb 2024 06:20:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 nf7-20020a0562143b8700b0068f11fe98a8sm683747qvb.97.2024.02.15.06.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:20:18 -0800 (PST)
Message-ID: <80d1356b-9a68-4997-be47-1270dd0b5206@redhat.com>
Date: Thu, 15 Feb 2024 15:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 0/8] vfio/iommufd: IOMMUFD Dirty Tracking
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <2540a4d3-c370-407f-8b97-9100615d2920@oracle.com>
 <a2ec891e-76fb-4985-a63d-b6609100af3c@redhat.com>
 <69e35528-21c3-4798-a847-119939236347@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <69e35528-21c3-4798-a847-119939236347@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

On 2/14/24 17:25, Joao Martins wrote:
> On 14/02/2024 15:40, Cédric Le Goater wrote:
>> Hello Joao,
>>
>> On 2/13/24 12:59, Joao Martins wrote:
>>> On 12/02/2024 13:56, Joao Martins wrote:
>>>> This small series adds support for Dirty Tracking in IOMMUFD backend.
>>>> The sole reason I still made it RFC is because of the second patch,
>>>> where we are implementing user-managed auto domains.
>>>>
>>>> In essence it is quite similar to the original IOMMUFD series where we
>>>> would allocate a HWPT, until we switched later on into a IOAS attach.
>>>> Patch 2 goes into more detail, but the gist is that there's two modes of
>>>> using IOMMUFD and by keep using kernel managed auto domains we would end
>>>> up duplicating the same flags we have in HWPT but into the VFIO IOAS
>>>> attach. While it is true that just adding a flag is simpler, it also
>>>> creates duplication and motivates duplicate what hwpt-alloc already has.
>>>> But there's a chance I have the wrong expectation here, so any feedback
>>>> welcome.
>>>>
>>>> The series is divided into:
>>>>
>>>> * Patch 1: Adds a simple helper to get device capabilities;
>>>>
>>>> * Patches 2 - 5: IOMMUFD backend support for dirty tracking;
>>>>
>>>> The workflow is relatively simple:
>>>>
>>>> 1) Probe device and allow dirty tracking in the HWPT
>>>> 2) Toggling dirty tracking on/off
>>>> 3) Read-and-clear of Dirty IOVAs
>>>>
>>>> The heuristics selected for (1) were to enable it *if* device supports
>>>> migration but doesn't support VF dirty tracking or IOMMU dirty tracking
>>>> is supported. The latter is for the hotplug case where we can add a device
>>>> without a tracker and thus still support migration.
>>>>
>>>> The unmap case is deferred until further vIOMMU support with migration
>>>> is added[3] which will then introduce the usage of
>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
>>>> dma unmap bitmap flow.
>>>>
>>>> * Patches 6-8: Add disabling of hugepages to allow tracking at base
>>>> page; avoid blocking live migration where there's no VF dirty
>>>> tracker, considering that we have IOMMU dirty tracking. And allow
>>>> disabling VF dirty tracker via qemu command line.
>>>>
>>>> This series builds on top of Zhengzhong series[0], but only requires the
>>>> first 9 patches i.e. up to ("vfio/pci: Initialize host iommu device
>>>> instance after attachment")[1] that are more generic IOMMUFD device
>>>> plumbing, and doesn't require the nesting counterpart.
>>>>
>>> I need to add that this series doesn't *need* to be based on Zhengzhong series.
>>> Though given that he is consolidating how an IOMMUFD device info is represented
>>> it felt the correct thing to do. For dirty tracking we mainly need the
>>> dev_id/iommufd available when we are going to attach, that's it.
>>>
>>> I've pushed this series version that doesn't have such dependency, let me know
>>> if you want me to pursue this version instead going forward:
>>>
>>> https://github.com/jpemartins/qemu/commits/iommufd-v5.nodeps
>> I feel I have lost track of all the different patchsets.
>>
>> To recap, there is yours :
>>
>> * vfio/iommufd: IOMMUFD Dirty Tracking
>>  
>> https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
>>
>> Zhengzhong's :
>>
>> * [PATCH rfcv2 00/18] Check and sync host IOMMU cap/ecap with vIOMMU
>>  
>> https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
>>
> There's also this one from Zhenzhong which depends on this set above:
>
> 	https://lore.kernel.org/qemu-devel/20240115103735.132209-1-zhenzhong.duan@intel.com/
>
> But I suspect that part of it is stale already, considering a whole lot of
> IOMMUFDDevice was reworked. Though the series is about bringup intel-iommu
> nesting support.
>
>> Eric's :
>>
>> * [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged
>> devices
>>   https://lore.kernel.org/qemu-devel/20240117080414.316890-1-eric.auger@redhat.com/

don't spend time reviewing my series at that stage. I will review
Zhenzhong's

[PATCH rfcv2 00/18] Check and sync host IOMMU cap/ecap with vIOMMU

and try to rebase on it.

Thanks

Eric

>>
>> Steve's:
>>
>> * [PATCH V3 00/13] allow cpr-reboot for vfio
>>  
>> https://lore.kernel.org/qemu-devel/1707418446-134863-1-git-send-email-steven.sistare@oracle.com/
>>
>> Mine, which should be an RFC :
>>
>> * [PATCH 00/14] migration: Improve error reporting
>>   https://lore.kernel.org/qemu-devel/20240207133347.1115903-1-clg@redhat.com/
>>
>> Anything else ?
> In terms of major series, I think you only forgot one. The rest look to be
> what's out there.
>
> Just to avoid confusion, yesterday's message was just providing an alternative
> of this same series but it that wouldn't be dependent on:
>
> 	[PATCH rfcv2 00/18] Check and sync host IOMMU cap/ecap with vIOMMU
>
> ... which is what is posted in this link:
>
> 	https://github.com/jpemartins/qemu/commits/iommufd-v5.nodeps
>
> While the series, as posted, is here:
>
> 	https://github.com/jpemartins/qemu/commits/iommufd-v5
>


