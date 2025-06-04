Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900B1C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmmS-0008D2-Is; Wed, 04 Jun 2025 07:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMmmO-0008BR-4K
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMmmM-00011E-9a
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749038371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hdKxLM187xIiqgEI+UkQCl+jsol2kl3VYE2X9erGz2A=;
 b=dXjHj3J0I3X5NImtsy0SP5IHcXT1NUYxZUm68lQCuU68G7uWaEXM2k54pLtlj5KOz4KxcZ
 bgS/JbCX5utjsOLtpaMLSoJ38VkMTKr54TmQX/BDnkHyHVez4SkmK8YMarY42NpgFmWIV8
 4giV4kay0CYCac4cPl0iuGAHFTTjD9k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-uA8xng6GN0ihvolFZZyQxA-1; Wed, 04 Jun 2025 07:59:30 -0400
X-MC-Unique: uA8xng6GN0ihvolFZZyQxA-1
X-Mimecast-MFC-AGG-ID: uA8xng6GN0ihvolFZZyQxA_1749038369
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so1488941f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 04:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749038369; x=1749643169;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdKxLM187xIiqgEI+UkQCl+jsol2kl3VYE2X9erGz2A=;
 b=pUkPhgv3eP0Ni+ixGmzZxu65eNKU7YAO/dhJrbN+aZOdQ2W0Cgr+Lbi8i4rtdSbJBn
 AZucjOVLTgjVcaGiG8mZw6lJIsjXz5pcmKKHNBBboKBaN4HKW2y+ZZlsl3rj/iQuRdjV
 Xd6zA/N3oi/BbMZrYyVzTkFEhWoOsQXmxcHbz1OVGBYc9khRb2CXWKnzZEnEE6mdFABK
 0ZGFpSI8OafL9BEGZKFGdscWHk+Jx27B0fYOdbmynbiD96hMKyLRSCbMpG09i2Icuvij
 OI9/q/d6KcP/SNIZ8WPtHpfH1bCfo961/SXNvNbMJrQePG1ksIYv7Ogi3LVZekRVQZdp
 Zf1Q==
X-Gm-Message-State: AOJu0Ywzm4n8h+gjlkvmmlMiNIayraCjK+Y4LW5yNE5kalMR5xrHDVwp
 kHtujsKP+AsQE6EvKyxqMdrylNJlu9czItd0qC9PWAGJWqzWnHjOUwvsNMQ4+FzxMLolRBIE8Z0
 d7Vl/sBd8PQMJW0gz005P4Vy/gNfTeh9a956Fs414OAVsqBPQUgf6xr4e
X-Gm-Gg: ASbGncuAssn6lKhMbwRUjs87EIDyXnK1i3lGF2E9OFONn3ZMRu1+NalpBiHmw0Ex0l8
 tFgb3KOdb68jRwPp97d4LRq0X7rv7ecjmrdyL2LnZK/EyO9jmO/Orn7xDk86DPx+rQW+sJDQV4I
 4dcVIIIEEbX6HGk0SrTiyAgd6wXyouHZ4IOTBTgOsuHhwTmCh8nh8If7zHZm1vecr1IPe5NxHaa
 rS7T+Vio3ue+oA4bMFoLnYv/F1ozmQynq6N9REZY9Jo3Tl5NppQhY/Th7moWYDg8yg9ePaRD3sf
 STnB8+SGUxu1pAWi1A==
X-Received: by 2002:a05:6000:2082:b0:3a4:ddbe:4b17 with SMTP id
 ffacd0b85a97d-3a51d8ef6fbmr2013980f8f.12.1749038369360; 
 Wed, 04 Jun 2025 04:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt/LZ5Q4BaAMs2Q0siMu/StgmMcW6lLXWtD87cU9C9X/NwUc9DYgvRT9kxd72LHdLzQqKvsQ==
X-Received: by 2002:a05:6000:2082:b0:3a4:ddbe:4b17 with SMTP id
 ffacd0b85a97d-3a51d8ef6fbmr2013955f8f.12.1749038368978; 
 Wed, 04 Jun 2025 04:59:28 -0700 (PDT)
Received: from [192.168.1.46] ([92.174.52.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73eadsm21221528f8f.41.2025.06.04.04.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 04:59:28 -0700 (PDT)
Message-ID: <c01c7c19-2422-45c7-9582-09ca37170974@redhat.com>
Date: Wed, 4 Jun 2025 13:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
 <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
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

On 6/4/25 09:09, Cédric Le Goater wrote:
> On 6/2/25 14:36, Steven Sistare wrote:
>> On 6/1/2025 3:07 PM, Michael S. Tsirkin wrote:
>>> On Sun, Jun 01, 2025 at 06:38:43PM +0200, Cédric Le Goater wrote:
>>>> On 5/29/25 21:24, Steve Sistare wrote:
>>>>> Do not reset a vfio-pci device during CPR.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>    include/hw/pci/pci_device.h | 3 +++
>>>>>    hw/pci/pci.c                | 5 +++++
>>>>>    hw/vfio/pci.c               | 7 +++++++
>>>>>    3 files changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>>>>> index e41d95b..b481c5d 100644
>>>>> --- a/include/hw/pci/pci_device.h
>>>>> +++ b/include/hw/pci/pci_device.h
>>>>> @@ -181,6 +181,9 @@ struct PCIDevice {
>>>>>        uint32_t max_bounce_buffer_size;
>>>>>        char *sriov_pf;
>>>>> +
>>>>> +    /* CPR */
>>>>> +    bool skip_reset_on_cpr;
>>>>>    };
>>>>>    static inline int pci_intx(PCIDevice *pci_dev)
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index f5ab510..21eb11c 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -32,6 +32,7 @@
>>>>>    #include "hw/pci/pci_host.h"
>>>>>    #include "hw/qdev-properties.h"
>>>>>    #include "hw/qdev-properties-system.h"
>>>>> +#include "migration/cpr.h"
>>>>>    #include "migration/qemu-file-types.h"
>>>>>    #include "migration/vmstate.h"
>>>>>    #include "net/net.h"
>>>>> @@ -531,6 +532,10 @@ static void pci_reset_regions(PCIDevice *dev)
>>>>>    static void pci_do_device_reset(PCIDevice *dev)
>>>>>    {
>>>>> +    if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
>>>>> +        return;
>>>>> +    }
>>>>
>>>> Since ->skip_reset_on_cpr is only true for vfio-pci devices, it could be
>>>> replaced by : object_dynamic_cast(OBJECT(dev), "vfio-pci")
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>
>>> True but I don't really like driver dependent hacks.
>>> what exactly about vfio makes it survive without this reset?
>>
>> The kernel descriptors remain open and all the active kernel PCI state
>> remains in place.  The device was never quiesced or de-configured in old QEMU.
>>
>> The cast is fine with me; it depends on what Michael wants.
> I don't see any good ways to avoid doing the reset when a cpr resume
> is in progress. I agree the cast is pretty ugly. We could keep the
> 'skip_reset_on_cpr' attribute and make it a class attribute instead.
Also,

I wonder if the resettable interface, and more specifically the
RESET_TYPE_SNAPSHOT_LOAD type, might be useful. Have you explored
this alternative ?


Thanks,

C.



