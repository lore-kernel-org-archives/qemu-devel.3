Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F931C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QJM-0004l3-UI; Mon, 29 Apr 2024 08:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1QJK-0004kK-MO
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1QJI-0004nR-FF
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714394441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6D2a3vGvyPEJ5sHXioTCcxQC31damFpV0mzd8HdSwSo=;
 b=MyQueRBE9LlX4/Ww7SZJHnnNPrDBeQmiMvezW0VHdBX+GKJ/bcXJ5g/YiO29oP1HfzOLS5
 QL0En0pTKMwD+TEKwzF/DNHduYZwEeA2W+ChKcZ+w23ROlF/fr8PCBGOWsEzpDZ97icKYR
 hjrceyLOBWmIqa5F215tn8m0ZZOMmKw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-m0CZ1tZPMtK8aCxOS0yQDg-1; Mon, 29 Apr 2024 08:40:39 -0400
X-MC-Unique: m0CZ1tZPMtK8aCxOS0yQDg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43ad0f1a08aso17227201cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714394439; x=1714999239;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6D2a3vGvyPEJ5sHXioTCcxQC31damFpV0mzd8HdSwSo=;
 b=oBVvsanUdzjca0RPokbwoox0NyYezZn+p81oLpKNTB246fcigLiDovx8Qygu9+exO+
 7vRNvqH+qDi3W8yOCkoEirtIxqLbTeORNunFekNdCahTUgfV2TozP4nss70W8kOm1fbq
 nWe2aNmFDV2Ce6zSU1zkq4p2ePZ6HPg/15yeEYPeDIbYdCtwSCuM9m1xF1w6rCfEpMwT
 /JwJ7Xf3TNeVJ8V6grURNENczoR9CIBimpc9F2PlfnhB09YGCiwLLayTpF4Ejm8vGRhF
 XnaaA2fNnoI/7fihkykRWriifTijMLCOucDSwwd5My4SaE/EnZRt/ybKBD6Y5qu/kHXn
 Sa0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa3o4LzDA+zSdAX3uNRCnP6V0I2sbpMVqfY5rMMxP7ORfNbNQwCueapjIIGkCK+DiyBilLfXLGYTdygrZQ0e++3zTgkKo=
X-Gm-Message-State: AOJu0YwGENyj9f00zhMkPQ2MIXLM2vlpwAmc/0nyyUA147AKoJEUnoj4
 QDaG12zb5zuiMiAGRnEhnYa6jzGoLz/Fw2hNCfddH9U7tqkOLrubgsViZhPFlHyFQ/lcx5p26Tq
 iPKV/kPTyZbInBHsgfe7AvoSe+pWv09V+9ge2J+DPw+/9t+XWHBMP
X-Received: by 2002:ac8:5ad6:0:b0:43a:ef4e:7b28 with SMTP id
 d22-20020ac85ad6000000b0043aef4e7b28mr3558102qtd.21.1714394439514; 
 Mon, 29 Apr 2024 05:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+6+yZssObbaeBialeUKT9GT3Il2t+xTdj7JPBwoyu19bRWzh7C46GmQYHvJdfmx+jFldVVg==
X-Received: by 2002:ac8:5ad6:0:b0:43a:ef4e:7b28 with SMTP id
 d22-20020ac85ad6000000b0043aef4e7b28mr3558080qtd.21.1714394439200; 
 Mon, 29 Apr 2024 05:40:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s24-20020ac87598000000b00436440fd8bfsm10368318qtq.3.2024.04.29.05.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:40:38 -0700 (PDT)
Message-ID: <d8cc4405-fe9c-4b47-be76-708a72d4b1a1@redhat.com>
Date: Mon, 29 Apr 2024 14:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/pci: migration: Skip config space check for
 Vendor Specific Information in VSC during restore/load
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vinayak Kale <vkale@nvidia.com>, qemu-devel@nongnu.org,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com, acurrid@nvidia.com,
 cjia@nvidia.com, zhiw@nvidia.com, targupta@nvidia.com, kvm@vger.kernel.org
References: <20240322064210.1520394-1-vkale@nvidia.com>
 <20240327113915.19f6256c.alex.williamson@redhat.com>
 <20240327161108-mutt-send-email-mst@kernel.org>
 <20240327145235.47338c2b.alex.williamson@redhat.com>
 <10a42156-067e-4dc1-8467-b840595b38fa@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <10a42156-067e-4dc1-8467-b840595b38fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

Hello Vinayak,

On 3/28/24 10:30, Cédric Le Goater wrote:
> On 3/27/24 21:52, Alex Williamson wrote:
>> On Wed, 27 Mar 2024 16:11:37 -0400
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Wed, Mar 27, 2024 at 11:39:15AM -0600, Alex Williamson wrote:
>>>> On Fri, 22 Mar 2024 12:12:10 +0530
>>>> Vinayak Kale <vkale@nvidia.com> wrote:
>>>>> In case of migration, during restore operation, qemu checks config space of the
>>>>> pci device with the config space in the migration stream captured during save
>>>>> operation. In case of config space data mismatch, restore operation is failed.
>>>>>
>>>>> config space check is done in function get_pci_config_device(). By default VSC
>>>>> (vendor-specific-capability) in config space is checked.
>>>>>
>>>>> Due to qemu's config space check for VSC, live migration is broken across NVIDIA
>>>>> vGPU devices in situation where source and destination host driver is different.
>>>>> In this situation, Vendor Specific Information in VSC varies on the destination
>>>>> to ensure vGPU feature capabilities exposed to the guest driver are compatible
>>>>> with destination host.
>>>>>
>>>>> If a vfio-pci device is migration capable and vfio-pci vendor driver is OK with
>>>>> volatile Vendor Specific Info in VSC then qemu should exempt config space check
>>>>> for Vendor Specific Info. It is vendor driver's responsibility to ensure that
>>>>> VSC is consistent across migration. Here consistency could mean that VSC format
>>>>> should be same on source and destination, however actual Vendor Specific Info
>>>>> may not be byte-to-byte identical.
>>>>>
>>>>> This patch skips the check for Vendor Specific Information in VSC for VFIO-PCI
>>>>> device by clearing pdev->cmask[] offsets. Config space check is still enforced
>>>>> for 3 byte VSC header. If cmask[] is not set for an offset, then qemu skips
>>>>> config space check for that offset.
>>>>>
>>>>> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
>>>>> ---
>>>>> Version History
>>>>> v2->v3:
>>>>>      - Config space check skipped only for Vendor Specific Info in VSC, check is
>>>>>        still enforced for 3 byte VSC header.
>>>>>      - Updated commit description with live migration failure scenario.
>>>>> v1->v2:
>>>>>      - Limited scope of change to vfio-pci devices instead of all pci devices.
>>>>>
>>>>>   hw/vfio/pci.c | 24 ++++++++++++++++++++++++
>>>>>   1 file changed, 24 insertions(+)
>>>>
>>>>
>>>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>>>
>>>
>>> A very reasonable way to do it.
>>>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> Merge through the VFIO tree I presume?
>>
>> Yep, Cédric said he´d grab it for 9.1.  Thanks,

Could you please resend an update of this change adding a machine
compatibility property for migration ?

Thanks,

C.


