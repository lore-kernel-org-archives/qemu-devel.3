Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C844C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMn6w-0002OL-AG; Wed, 04 Jun 2025 08:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMn6k-0002Ng-Om
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMn6e-00048r-UQ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749039628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OM+xeQGeMgr0rSMomkgY26vKr0zEN0F0Z7e/RJlfKgM=;
 b=c4i5EyRDOb9KlToAiIxCfZ7S0xT8U2Ry57vOjRIlFeFgRbiMTb2yatdoLZwIGYNdn4pO5Y
 9sFKCUcavjitz4ejaDfCYVQ95Xp8bhPQvUHrSbTiIJ1tdMNF8aeMg109fR229J8+M34qr2
 pRR4+kHbVHu5+jmyJ4rAf144yy4CckI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-3j-gci0ZMp-tqL7SxeMtjA-1; Wed, 04 Jun 2025 08:20:27 -0400
X-MC-Unique: 3j-gci0ZMp-tqL7SxeMtjA-1
X-Mimecast-MFC-AGG-ID: 3j-gci0ZMp-tqL7SxeMtjA_1749039626
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso1892326f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 05:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749039626; x=1749644426;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OM+xeQGeMgr0rSMomkgY26vKr0zEN0F0Z7e/RJlfKgM=;
 b=pMCCnkcSCNgE1jYKV47J+uWxy0Sk0ffrDL3bTdXVaWqK1gj8Ihgo+jKb25TtUIjmgh
 vrFfCNu9wCeE45q6WkOlqDGSvdiN/WRSNqYLFuVwgEKpj3U2+Z4xs3LRKEbbJmSpndQL
 xhPw8RUOeoi/Iy/HLPn0kqq4vO9ehvnm7s24lvQN38LT+nnAo9lw1UrbcC46hDTpT34J
 Kdfo/HgjQAcodoVZkjGnl658EqJ3aDLBoGt8pDyYFMQXTyDZhUfufkq0Z/Pp5DZ5mJeV
 69A81OsnmOX89COZJRq3KxN324zvvUc3lFXnGsgp7Zy0q3HPGmOQ8Y9PLMWNA5fjiOC5
 QwQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYda+g342U1vy57wLTtE1tZzqnW+HpDm48qn30iTRdZebfKUN+2/3hiE9iqeF/3yrwSDXnwnlJVg1l@nongnu.org
X-Gm-Message-State: AOJu0YyzR4CDJTBxNTKZpeSstFMf5ap0EuZWlQlL6QCk2Ge+mDANq3T5
 rwjbtluznJchMYtmON0a7QTEeIs0HoEJyKauesPu4TJ8kvCJL0BkC5yjwpc7KCSx5tYyKXMIWOl
 ak5PSr3heCBoy4FKk14U38ObukXvKLX0Q/mZs/3nU8qZi+5lh1OuTh+ol
X-Gm-Gg: ASbGncvx8tY72CpmDWJycqKkFp3lyXhMYeHt4P0ovO4TWtj2ap+iAz8cLi3ISzmnKxY
 YqpR8/e9c4ybrZJbF5ULHJpC4GQdDiv+Aet4pV3G1B9xpNzDbczcYMLVLjBH0urmBlmz0/CZeLR
 455EwnWL0uUwgqhHYAwh23zyz/bhfCD6ENG9ppBOnoZQo5Be07J6b6jQ9GFcopazL5WK3JgKt/o
 a1BZwnbayKlxRWtyFKDVZHPysoRDSDLTrIC1IgM5oIU7hsnMawoyc0Ma+9fkGSDfvlKUMW+8obq
 ufiG7jI=
X-Received: by 2002:a05:6000:381:b0:3a4:c909:ce16 with SMTP id
 ffacd0b85a97d-3a51d970d90mr2252434f8f.49.1749039626058; 
 Wed, 04 Jun 2025 05:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWYs4pbGVXPbzSNYdWgSucy55Uo5dafxii8ZbwmsbODfvyacmQ5vcghtn0w/z+C3HFQce3bQ==
X-Received: by 2002:a05:6000:381:b0:3a4:c909:ce16 with SMTP id
 ffacd0b85a97d-3a51d970d90mr2252405f8f.49.1749039625644; 
 Wed, 04 Jun 2025 05:20:25 -0700 (PDT)
Received: from [192.168.1.46] ([92.174.52.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2342sm203649065e9.10.2025.06.04.05.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 05:20:25 -0700 (PDT)
Message-ID: <c34c79ce-6e3e-44b8-8293-714aa783a837@redhat.com>
Date: Wed, 4 Jun 2025 14:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] VFIO and IOMMU prerequisite stuff for IOMMU
 nesting support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250604062115.4004200-1-zhenzhong.duan@intel.com>
 <22733f4b-d759-448d-8cc0-ce25e723e859@redhat.com>
 <20250604120820.GA5028@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250604120820.GA5028@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 6/4/25 14:08, Jason Gunthorpe wrote:
> On Wed, Jun 04, 2025 at 08:59:37AM +0200, Cédric Le Goater wrote:
> 
>> b4 complained for a couple of trailers :
> 
> He re-reviewed patches he contributed to making :)
> 
>>      Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✗ DKIM/nvidia.com)
> 
> But why do you have an X? The messages are properly formed leaving the
> nvidia server, I checked.. And my b4 is happy:
> 
> $ b4 am https://lore.kernel.org/qemu-devel/aBUHLWY1Qdapgl+Y@Asurada-Nvidia/
> Grabbing thread from lore.kernel.org/all/aBUHLWY1Qdapgl%2BY@Asurada-Nvidia/t.mbox.gz
> Analyzing 50 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 7 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>    [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
>      + Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✓ DKIM/nvidia.com)
>    [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple smmuv3 devices
>      + Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✓ DKIM/nvidia.com)
>    [PATCH v2 3/6] hw/arm/virt: Factor out common SMMUV3 dt bindings code
>      + Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✓ DKIM/nvidia.com)
>      + Reviewed-by: Eric Auger <eric.auger@redhat.com> (✓ DKIM/redhat.com)
>    [PATCH v2 4/6] hw/arm/virt: Add an SMMU_IO_LEN macro
>      + Reviewed-by: Eric Auger <eric.auger@redhat.com> (✓ DKIM/redhat.com)
>      + Reviewed-by: Donald Dutile <ddutile@redhat.com> (✓ DKIM/redhat.com)
>    [PATCH v2 5/6] hw/arm/virt: Add support for smmuv3 device
>    [PATCH v2 6/6] hw/arm/smmuv3: Enable smmuv3 device creation
>      + Reviewed-by: Nicolin Chen <nicolinc@nvidia.com> (✓ DKIM/nvidia.com)

Ah ! Interesting, using the link doesn't report issues.

I use the message-id on v3 :

$ b4 am 20250604062115.4004200-1-zhenzhong.duan@intel.com
Analyzing 7 messages in the thread
Analyzing 76 code-review messages
Checking attestation on all messages, may take a moment...
---
   ✓ [PATCH v3 1/4] backends/iommufd: Add a helper to invalidate user-managed HWPT
   ✓ [PATCH v3 2/4] vfio/iommufd: Add properties and handlers to TYPE_HOST_IOMMU_DEVICE_IOMMUFD
   ✓ [PATCH v3 3/4] vfio/iommufd: Implement [at|de]tach_hwpt handlers
   ✓ [PATCH v3 4/4] vfio/iommufd: Save vendor specific device info
   ---
   ✓ Signed: DKIM/intel.com
---
Total patches: 4
---
NOTE: some trailers ignored due to from/email mismatches:
     ! Trailer: Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
      Msg From: Nicolin Chen via <qemu-devel@nongnu.org>
     ! Trailer: Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
      Msg From: Cédric Le Goater <clg@redhat.com>
NOTE: Rerun with -S to apply them anyway
---
Cover: ./v3_20250604_zhenzhong_duan_vfio_and_iommu_prerequisite_stuff_for_iommu_nesting_support.cover
  Link: https://lore.kernel.org/r/20250604062115.4004200-1-zhenzhong.duan@intel.com
  Base: not specified
        git am ./v3_20250604_zhenzhong_duan_vfio_and_iommu_prerequisite_stuff_for_iommu_nesting_support.mbx



C.


