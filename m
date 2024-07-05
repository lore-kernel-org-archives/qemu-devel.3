Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBEEC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfnQ-0001VO-9K; Fri, 05 Jul 2024 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sPfnL-0001QN-Rp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:04:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sPfnK-0003cs-3a
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:03:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3679df4cb4cso908245f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720173835; x=1720778635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y0PrWLwHFC55Ed4oBk8KyTAmfsGKZ/OmfUthkyxglSk=;
 b=Q5hi8oihvHL0CEKUmajVOKbGUpG2u0mBHX9kykGq1A9ZY2cljvMhoPoOc6uOvopByH
 mYrE+IOblKbFLzOFhvjyilG+Tr3VoXpRIhf2MIqMwKfoCoIdckJ5Asdbyt8fdKLh5p+S
 UdA5UWBgzG9axFYGNUdy/0gkgRHOJaal3LNX5tfl8CvW2OAnSc/YSTpQdv4MGx7UOSZW
 1pbPW04fQ8vywO6hoYRBlXtkQHz7bl0pOKX6ohbjjres4k+sywumH2iMYjwUK1r3fQIf
 1H4HDkYYKFo/0uXEcUgL0nkC+JM7vrOyZ+oRzgvhRA0wE4YeIh7T/065YKwE180VffjS
 iTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720173835; x=1720778635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0PrWLwHFC55Ed4oBk8KyTAmfsGKZ/OmfUthkyxglSk=;
 b=bKmk1BDqfVb86+opSEGKWHfCxzJQ6Ue/54KKqJHeqEwJXUJux3qr18Qfq+/krqfi93
 vng2VvXQjjryNpjjhy/mMbBAE8LXv2kD9FPwwvGGXDlcifn8269kFZh33sakiso5yJRF
 0WF/vOwNaKHMd6X+2aGnGzHbewGksdUBwsjHmgfDFqCfZ8fuK5uUcpWarmO1hWG5bDaP
 qSQJDDlez+8dSa79tgRw/Hq6r8iqt+0M6jlSgjXAB+7IwPfqT/PQzzMa5aOiTpsH3xH+
 7nBrwAuazbn0ZhY2utZbajesKKQ10xsmvxo4ogyH8WFiSeyrrLhp7MuxlcO14W0Czr4X
 cp+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2P9nBKyvd7KFT6CDEcZaObngGpAKLoN+imZuHw+2KxPaPOZCKh9AbT83/sTABpkc3r//qTcgqTtSoEbHn/Z6dR74e5QA=
X-Gm-Message-State: AOJu0YzxqGZ1+IdsphZRjJ2+OT94gE2DB9o6PyfIrcn6B3BldWvKD8Jh
 kUP1BX8w0NdUZeZjz+2FZSXbBz1qSIAoqG5FoDLGpMK9FNXGBrF8
X-Google-Smtp-Source: AGHT+IH1JcH/PJ6W0QZTbInVqSiD1fViyxvmjL5ioGBgSJ+VTbpo14wV04AsK550ytGTOWaOYmgYjg==
X-Received: by 2002:adf:f9cf:0:b0:366:ea4a:17ec with SMTP id
 ffacd0b85a97d-3679f6c5b81mr4140579f8f.2.1720173834447; 
 Fri, 05 Jul 2024 03:03:54 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:b26:7100:7654:8924:d030:917?
 ([2a01:cb1c:b26:7100:7654:8924:d030:917])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1dda06sm55582745e9.17.2024.07.05.03.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 03:03:54 -0700 (PDT)
Message-ID: <d010d1cf-6d13-4b9d-b26e-2b82b323be91@gmail.com>
Date: Fri, 5 Jul 2024 12:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] PRI support for VT-d
To: Yi Liu <yi.l.liu@intel.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
 <311d4200-a5a4-418b-bc54-9f2c871235b0@intel.com>
 <a72b873d-9641-47f2-8306-7e9f304037fe@eviden.com>
 <5b461da1-09ef-4744-970d-9f8aadf7cd32@intel.com>
Content-Language: en-US
From: cmd <clement.mathieudrif.etu@gmail.com>
In-Reply-To: <5b461da1-09ef-4744-970d-9f8aadf7cd32@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=clement.mathieudrif.etu@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 05/07/2024 08:20, Yi Liu wrote:
> On 2024/7/5 13:13, CLEMENT MATHIEU--DRIF wrote:
>>
>> On 05/07/2024 05:03, Yi Liu wrote:
>>> Caution: External email. Do not open attachments or click links,
>>> unless this email comes from a known sender and you know the content
>>> is safe.
>>>
>>>
>>> On 2024/5/30 20:24, CLEMENT MATHIEU--DRIF wrote:
>>>> This series belongs to a list of series that add SVM support for VT-d.
>>>>
>>>> Here we focus on the implementation of PRI support in the IOMMU and
>>>> on a PCI-level
>>>> API for PRI to be used by virtual devices.
>>>>
>>>> This work is based on the VT-d specification version 4.1 (March 2023).
>>>> Here is a link to a GitHub repository where you can find the
>>>> following elements :
>>>>       - Qemu with all the patches for SVM
>>>>           - ATS
>>>>           - PRI
>>>>           - Device IOTLB invalidations
>>>>           - Requests with already translated addresses
>>>>       - A demo device
>>>>       - A simple driver for the demo device
>>>>       - A userspace program (for testing and demonstration purposes)
>>>
>>> I didn't see the drain PRQ related logics in this series. Please 
>>> consider
>>> adding it in next version. It's needed when repurposing a PASID.
>>
>> Hi,
>>
>> Are you talking about wait descriptors with SW = 0, IF = 0, FN = 1
>> (section 7.10 of VT-d)?
>>
>> I'll move that to the PRI series.
>
> yes. But not only that patch. When guest software submitting the
> descriptors per CH7.10 of VT-d spec, QEMU need to emulate the
> PRQ drain behavior.
>
Ok, will check
>>>
>>>> https://github.com/BullSequana/Qemu-in-guest-SVM-demo
>>>>
>>>>
>>>> Clément Mathieu--Drif (8):
>>>>     pcie: add a helper to declare the PRI capability for a pcie device
>>>>     pcie: helper functions to check to check if PRI is enabled
>>>>     pcie: add a way to get the outstanding page request allocation 
>>>> (pri)
>>>>       from the config space.
>>>>     pci: declare structures and IOMMU operation for PRI
>>>>     pci: add a PCI-level API for PRI
>>>>     intel_iommu: declare PRI constants and structures
>>>>     intel_iommu: declare registers for PRI
>>>>     intel_iommu: add PRI operations support
>>>>
>>>>    hw/i386/intel_iommu.c          | 302 
>>>> +++++++++++++++++++++++++++++++++
>>>>    hw/i386/intel_iommu_internal.h |  54 +++++-
>>>>    hw/pci/pci.c                   |  37 ++++
>>>>    hw/pci/pcie.c                  |  42 +++++
>>>>    include/exec/memory.h          |  65 +++++++
>>>>    include/hw/pci/pci.h           |  45 +++++
>>>>    include/hw/pci/pci_bus.h       |   1 +
>>>>    include/hw/pci/pcie.h          |   7 +-
>>>>    include/hw/pci/pcie_regs.h     |   4 +
>>>>    system/memory.c                |  49 ++++++
>>>>    10 files changed, 604 insertions(+), 2 deletions(-)
>>>>
>>>
>>> -- 
>>> Regards,
>>> Yi Liu
>


