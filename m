Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96495C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiFm-0007v5-M6; Wed, 04 Jun 2025 03:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMiFl-0007uu-RH
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMiFk-0006PD-7J
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749020975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y9za2v8E9P/0GsnMmhFhe+Sa6HOR8+O5Yvbm/TqadZY=;
 b=SziZU/925GtdbrYgo58xCQD/n7YePQTzu3BOq79urLxxw+UFa25jba++WVknZO34kKG+eu
 EJMLUO+Hw6yHWNdWAxP1fo5ogVJvQ5k9jr2lcpXnhtBvATQ1uFXclA5ScpCFF96BAw7E4Q
 oO0IjFaQ7tfAOtC+cT2OWhRJ7KiYVR0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-OgVdD2NeO9mm_CDsmiT_LA-1; Wed, 04 Jun 2025 03:09:33 -0400
X-MC-Unique: OgVdD2NeO9mm_CDsmiT_LA-1
X-Mimecast-MFC-AGG-ID: OgVdD2NeO9mm_CDsmiT_LA_1749020972
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d64026baso27806355e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 00:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749020972; x=1749625772;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9za2v8E9P/0GsnMmhFhe+Sa6HOR8+O5Yvbm/TqadZY=;
 b=LboyD9kPFmJ3+mP7j4V3BAQGRTasq7390hrytCsG9R9f+2Io5FnVZmy6m1kI6FQWvB
 EXB9cIc66oTwFnFVo/rTwJE2JVNZCOOv5w8UH27vWpmbVOFPqSpcz7L/dvTYk8nfRcsR
 VQwf5HMbJf+gNS6eupHT5YLHNqYxKgj/eLG3jKUfFoqt1MYR2V/h5K0+c4ev6J/Osm/Q
 ztRUGN5BeUrnNAO0CiL6Xu1huTGR2xx5OlogjSATZrfOCoAbX4Hm6G4o1Srft1AWnoCP
 So24Q68bIpXalIfHHx1/ycjHusEwiOc2A4Cai3bTDYdtGCsWSLcgnNhfrzXfRmqdM3Jz
 XeVA==
X-Gm-Message-State: AOJu0Ywx9ylz5YcOcLCuWKMGEGdklF8DdA75RDD/QVKY075eEzp6YIxv
 rtcs7JeWSmOYHqxcex/3PV5XiMnYvXJyhPioqAv5UQA047C9kI46sxnFrqnk9+QoYg592eiMYOW
 NE2Z/hldHFewXSxgwn4vHgX7kpUK0cdQAZ2nNvz3fxCB+UMKOUYA7tOoN
X-Gm-Gg: ASbGnctF/5qNWWYuaNYSgDHm19S7i6HSjAckMM3pxN8g3GBEJprfAWp2Ixy6CfBw6fx
 D6UB76zb+oroQPUHIBWGCz2sA5Msqzy25gWlg65xQlKuluZ0+jbwwEzeQz6rhIqIj7O60gwiRDy
 TMhCT06YKRl3fq6Ilf4YdZnKL6VR0hE2LL2vECjQDomyKo2VWNFxJ00VdmVqLI6i4BTyxkiBROx
 ykcrdIJSCeP5M6TKUp73ygc1OhM09e13J108YUWK9ezdQkn7AwwhGxHghPy/KuJ9O1/1yRdChJj
 FaYDKuL5UIH4SlPEvC453mO7j5jXsGi2eCCmtsvNOdlWXFwH0CZLxH+duX9cHE8ekb2X8qJMoui
 tFNZuvjUPJatekXE6NEAG6VMnkCJKleIYdmH3
X-Received: by 2002:a05:600c:1991:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-451f09bb9f2mr14592665e9.0.1749020971906; 
 Wed, 04 Jun 2025 00:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNd2mb5QrgJ/5/z+xS/9J0E2jMVnrzSo44WQZE9B+ROwrcl/F13KBjZw1FHwEBC+UDTvGmsg==
X-Received: by 2002:a05:600c:1991:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-451f09bb9f2mr14592385e9.0.1749020971595; 
 Wed, 04 Jun 2025 00:09:31 -0700 (PDT)
Received: from ?IPV6:2a02:8428:527:dd01:97e1:f7ae:2e2c:ffab?
 (2a02-8428-0527-dd01-97e1-f7ae-2e2c-ffab.rev.sfr.net.
 [2a02:8428:527:dd01:97e1:f7ae:2e2c:ffab])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5215e4c4asm554876f8f.17.2025.06.04.00.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 00:09:30 -0700 (PDT)
Message-ID: <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
Date: Wed, 4 Jun 2025 09:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
To: Steven Sistare <steven.sistare@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
 <20250601150607-mutt-send-email-mst@kernel.org>
 <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/2/25 14:36, Steven Sistare wrote:
> On 6/1/2025 3:07 PM, Michael S. Tsirkin wrote:
>> On Sun, Jun 01, 2025 at 06:38:43PM +0200, Cédric Le Goater wrote:
>>> On 5/29/25 21:24, Steve Sistare wrote:
>>>> Do not reset a vfio-pci device during CPR.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/hw/pci/pci_device.h | 3 +++
>>>>    hw/pci/pci.c                | 5 +++++
>>>>    hw/vfio/pci.c               | 7 +++++++
>>>>    3 files changed, 15 insertions(+)
>>>>
>>>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>>>> index e41d95b..b481c5d 100644
>>>> --- a/include/hw/pci/pci_device.h
>>>> +++ b/include/hw/pci/pci_device.h
>>>> @@ -181,6 +181,9 @@ struct PCIDevice {
>>>>        uint32_t max_bounce_buffer_size;
>>>>        char *sriov_pf;
>>>> +
>>>> +    /* CPR */
>>>> +    bool skip_reset_on_cpr;
>>>>    };
>>>>    static inline int pci_intx(PCIDevice *pci_dev)
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index f5ab510..21eb11c 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -32,6 +32,7 @@
>>>>    #include "hw/pci/pci_host.h"
>>>>    #include "hw/qdev-properties.h"
>>>>    #include "hw/qdev-properties-system.h"
>>>> +#include "migration/cpr.h"
>>>>    #include "migration/qemu-file-types.h"
>>>>    #include "migration/vmstate.h"
>>>>    #include "net/net.h"
>>>> @@ -531,6 +532,10 @@ static void pci_reset_regions(PCIDevice *dev)
>>>>    static void pci_do_device_reset(PCIDevice *dev)
>>>>    {
>>>> +    if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
>>>> +        return;
>>>> +    }
>>>
>>> Since ->skip_reset_on_cpr is only true for vfio-pci devices, it could be
>>> replaced by : object_dynamic_cast(OBJECT(dev), "vfio-pci")
>>>
>>> Thanks,
>>>
>>> C.
>>
>> True but I don't really like driver dependent hacks.
>> what exactly about vfio makes it survive without this reset?
> 
> The kernel descriptors remain open and all the active kernel PCI state
> remains in place.  The device was never quiesced or de-configured in old QEMU.
> 
> The cast is fine with me; it depends on what Michael wants.
I don't see any good ways to avoid doing the reset when a cpr resume
is in progress. I agree the cast is pretty ugly. We could keep the
'skip_reset_on_cpr' attribute and make it a class attribute instead.


Which raises another question : is this specific to vfio-pci. What
about virtio devices ?

Thanks,

C.




