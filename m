Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B16CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 12:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urFKw-0005Hr-7N; Wed, 27 Aug 2025 08:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urFKp-0005Gs-8o
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 08:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urFKg-0005mA-FG
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 08:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756297967;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pc5dHiysNwj7NYyB9S62zQEXeflc+tgT8hb8wJB0U80=;
 b=dHKoMuT59qxUXGZ6N6Rh/xn2KuTJA3vIuA6e43qIEnxmn/8OXn0/XoSqjFQiwXhsliWqoU
 LmquQ0KoPmEFI6tfZ8O4ECvJoZXZ06sFrCLVvcMe2pmwtfenWNUJ0Z/4bm513SUdSUAu6f
 RJNYD5nXZzOTH9fMRXP9btVe4mwSLVk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-gkL2UPQPPby8ca_b7_ymkQ-1; Wed, 27 Aug 2025 08:32:45 -0400
X-MC-Unique: gkL2UPQPPby8ca_b7_ymkQ-1
X-Mimecast-MFC-AGG-ID: gkL2UPQPPby8ca_b7_ymkQ_1756297964
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0b46bbso30627745e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 05:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756297964; x=1756902764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pc5dHiysNwj7NYyB9S62zQEXeflc+tgT8hb8wJB0U80=;
 b=pbuuA6Y9QG7sugYXe/wFe1Rd4ckMIlWrhg/K9Ys46W9Tmll+TGoADLhIfF/41Ud1v0
 auvqRnSXliz3SdhkYEa8xxiCTJ3+SHaBrF1o82onvc4KPT0gOH/hx5JHLqMygPy1Nr0v
 lET+3KoDpp17yNSX9g67mg49uoGrtI5HOWrUUSJqgKzybFeF9tS33U2OwOR8twtDWjPn
 E9EmAtabIxJcon9d4w3l6OuKV8GXpWm46fNsqLTxgX3gdpS13QMxN6O1rUKH631HxogT
 6fR9xUCz8DiSAJyrDGBEQu+uOHVXhiaJpO1lo6g1Xhp1aPMcseN7WLYaZjAZhNyvpJEy
 PtOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSS/AnOTWakb3WXz0EqDF+0RetNsCMQAwdHzrWmpS0w+JLneBLuVa7KPC81dUAvtYEeyY5abEoGjeS@nongnu.org
X-Gm-Message-State: AOJu0YxYjzpjmECcfR/slQcWlxrLyBI6zqTRX0p4CIzXdavWJtStH6jV
 Nn6/Q93Pm3SBUBGhI0bv+mggqqTxPZHuV/K0hIhCZyx5/JZwg7ATCoMpkiosD9GhZ5R4cmjflV4
 oOsILeo0O/SKiADtTEhuajb64gFHIPMe5ge8ccT70R8UMRO3FiiBgSeld
X-Gm-Gg: ASbGncs7zOHATJaJVo33TVmjRsZxGYQd1H6gWF69/kr9Y2yxxGtG2wGNU6ewfguQqQk
 2j/Jl0tr+47qzd+mrbY/r7QfueVtFjzQ0op3nYmJvonzprxB89WoTOw2BWkSmTofSCCRuX91gnK
 PUkRM3RmEmAoaRFBhAsZh2ZjWvLZPK0esRdSYMMNgQonwJzSViYkVku1lG2aMTFX6ZJx1yIpwqa
 bbKgmP4hGjN8lnHXRbFR/AGfLurbAzr+gWjQj/Wjhc/CTDmeILvoi0wl6222S3bmaAuiMZoNT8Q
 2Mw7jv7miC0dfup2U+AinjQ4bf5AozJMk6Fvoxe4+ffu1rCvU8elw1/p0fRFX9dNLWY9gu5nSYr
 w4Y3Szwylb5Y=
X-Received: by 2002:a05:600c:3b9d:b0:45b:6d43:76ce with SMTP id
 5b1f17b1804b1-45b705f4371mr21574945e9.15.1756297964346; 
 Wed, 27 Aug 2025 05:32:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5TS7dZxC0yRkjdyJhy4esWGdhY4eqYbN2hjOYf0MN5f74qgY0/lI/7LZYB/bOGMSgY2+tig==
X-Received: by 2002:a05:600c:3b9d:b0:45b:6d43:76ce with SMTP id
 5b1f17b1804b1-45b705f4371mr21574425e9.15.1756297963804; 
 Wed, 27 Aug 2025 05:32:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c72f8sm29611895e9.3.2025.08.27.05.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 05:32:43 -0700 (PDT)
Message-ID: <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
Date: Wed, 27 Aug 2025 14:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Yi,

On 8/27/25 2:30 PM, Yi Liu wrote:
> Hi Eric,
>
> On 2025/8/27 19:22, Eric Auger wrote:
>> Hi
>>
>> On 8/27/25 1:13 PM, Yi Liu wrote:
>>> On 2025/8/22 14:40, Zhenzhong Duan wrote:
>>>> Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
>>>> allows to retrieve capabilities exposed by a vIOMMU. The first planned
>>>> vIOMMU device capability is VIOMMU_CAP_HW_NESTED that advertises the
>>>> support of HW nested stage translation scheme.
>>>> pci_device_get_viommu_cap
>>>> is a wrapper that can be called on a PCI device potentially
>>>> protected by
>>>> a vIOMMU.
>>>>
>>>> get_viommu_cap() is designed to return 64bit bitmap of purely emulated
>>>> capabilities which are only determined by user's configuration, no
>>>> host
>>>> capabilities involved. Reasons are:
>>>>
>>>> 1. host may has heterogeneous IOMMUs, each with different capabilities
>>>> 2. this is migration friendly, return value is consistent between
>>>> source
>>>>      and target.
>>>> 3. host IOMMU capabilities are passed to vIOMMU through
>>>> set_iommu_device()
>>>>      interface which have to be after attach_device(), when
>>>> get_viommu_cap()
>>>>      is called in attach_device(), there is no way for vIOMMU to
>>>> get host
>>>>      IOMMU capabilities yet, so only emulated capabilities can be
>>>> returned.
>>>>      See below sequence:
>>>>
>>>>        vfio_device_attach():
>>>>            iommufd_cdev_attach():
>>>>                pci_device_get_viommu_cap() for HW nesting cap
>>>>                create a nesting parent hwpt
>>>>                attach device to the hwpt
>>>>                vfio_device_hiod_create_and_realize() creating hiod
>>>>        ...
>>>>        pci_device_set_iommu_device(hiod)
>>>
>>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>    MAINTAINERS          |  1 +
>>>>    include/hw/iommu.h   | 19 +++++++++++++++++++
>>>>    include/hw/pci/pci.h | 25 +++++++++++++++++++++++++
>>>>    hw/pci/pci.c         | 11 +++++++++++
>>>>    4 files changed, 56 insertions(+)
>>>>    create mode 100644 include/hw/iommu.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index a07086ed76..54fb878128 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2305,6 +2305,7 @@ F: include/system/iommufd.h
>>>>    F: backends/host_iommu_device.c
>>>>    F: include/system/host_iommu_device.h
>>>>    F: include/qemu/chardev_open.h
>>>> +F: include/hw/iommu.h
>>>>    F: util/chardev_open.c
>>>>    F: docs/devel/vfio-iommufd.rst
>>>>    diff --git a/include/hw/iommu.h b/include/hw/iommu.h
>>>> new file mode 100644
>>>> index 0000000000..7dd0c11b16
>>>> --- /dev/null
>>>> +++ b/include/hw/iommu.h
>>>> @@ -0,0 +1,19 @@
>>>> +/*
>>>> + * General vIOMMU capabilities, flags, etc
>>>> + *
>>>> + * Copyright (C) 2025 Intel Corporation.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#ifndef HW_IOMMU_H
>>>> +#define HW_IOMMU_H
>>>> +
>>>> +#include "qemu/bitops.h"
>>>> +
>>>> +enum {
>>>> +    /* hardware nested stage-1 page table support */
>>>> +    VIOMMU_CAP_HW_NESTED = BIT_ULL(0),
>>>
>>> This naming is a bit confusing. get_viommu_cap indicates it will return
>>> the viommu's capability while this naming is HW_NESTED. It's conflict
>>> with the commit message which claims only emulated capability will be
>>> returned.
>>
>> it actually means the viommu has the code to handle HW nested case,
>> independently on the actual HW support.
>> maybe remove the "emulation" wording.
>
> yeah, I know the meaning and the purpose here. Just not quite satisfied
> with the naming.
>
>>
>> Otherwise we may also use the virtio has_feature naming?
>
> has_feature seems better. Looks to ask if vIOMMU has something and then
> do something.
>
>>
>>>
>>> TBH. I'm hesitating to name it as get_viommu_cap. The scope is a little
>>> larger than what we want so far. So I'm wondering if it can be done
>>> in a
>>> more straightforward way. e.g. just a bool op named
>>> iommu_nested_wanted(). Just an example, maybe better naming. We can
>>> extend the op to be returning a u64 value in the future when we see
>>> another request on VFIO from vIOMMU.
>> personnally I am fine with the bitmask which looks more future proof.
>
> not quite sure if there is another info that needs to be checked in
> this "VFIO asks vIOMMU" manner. Have you seen one beside this
> nested hwpt requirement by vIOMMU?

I don't remember any at this point. But I guess with ARM CCA device
passthrough we might have other needs

Eric
>
> Regards,
> Yi Liu
>


