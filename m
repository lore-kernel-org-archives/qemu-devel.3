Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BFCC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubjg-0007cm-By; Tue, 18 Mar 2025 14:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tubjA-0007aV-Kt
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tubj8-0005UI-LF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742322703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isVT39Tp1plNgJjPWjPIhXflR6POwtIpRciclR11LO4=;
 b=UrYVQieIF2sOAyIqdbsZDT0BrW9t+5C7NlPQfcYPHHMOARN893sXBwbYAfybsXR15ZMkaM
 YMKSabsP9l1HG8x46u54/JIWdu7zM0urviTusq0GF7/UogO6Mx0K1chiyyeupV7oS1gnX5
 wj4gnieSJatQxHaBKKyJF7NETcttJ1I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-LwNp-ANrM6OYzTUv09HkZg-1; Tue, 18 Mar 2025 14:31:42 -0400
X-MC-Unique: LwNp-ANrM6OYzTUv09HkZg-1
X-Mimecast-MFC-AGG-ID: LwNp-ANrM6OYzTUv09HkZg_1742322701
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-476b2179079so119763681cf.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742322701; x=1742927501;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=isVT39Tp1plNgJjPWjPIhXflR6POwtIpRciclR11LO4=;
 b=cBNTjUY2sde0V2d3YEGPeLtxi48xU/ruebpqlzn3Kib/LAM99ohF4A98/6tvnmYHqn
 ZGIfggK+6j88vJ3XPqvQaRbqoUs7op2c4wrsWxSZMSWp9lfpVsRw++9ZYwbVBNfgzLUQ
 233NzNogafYv0MQTTEK2dXy8nsSVWxyicAZ7nKBE2H0RcyRgNLUFSkwi8KqWLQAfHF4v
 SeIx9J3/F8BjEbu7tS5EcyGbfL60My2kYiamZ4ksb8kGKr8CerNJ27DU0phq6sxotz7W
 JCtod3JxjF+E30zYmCtF/V5FxJ5tseknriyXvY584gs3DWofgjloMTG1cR2AXF976A9a
 ipaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZIzTWDM/6I8Uf/wve4otIzZXdaE1idGvIx9U6pWVlcEjNo6vj9p+BFc5fSWXRTCsTJpAmUZiPEPzS@nongnu.org
X-Gm-Message-State: AOJu0YwdIfJFg/Gd/ES+VBNEmVfB3RDmBFtXnNSuM6IMplLmTL8H5Ltu
 INpGbxGvx6ZMWBzbQGV63lIhP7YSTjS7ipV1dAN9VBMIT/vD2ll/B67Ia6Blj6hpHMtZ+Q+9PSw
 YglK3GSAPDC/LoR4tnx50X+8Lrb+8uf/U1JFlJ9MQI8qWNrXZTlHb
X-Gm-Gg: ASbGncvnnyR30zGxtsb/CGxhXu+/8h7V7J6q0aJWOIKRsBWRmYVBfLLvQixvi6RjnAJ
 9yFSSWSRoR4u8UWII7nBuX1GP18di0T5W4dzCg+8uTu+0G+i6BJterdtCHzyW2JbL/aD9ZuDvGP
 weq5uGIYvZxtTdBM127NXr5NstdH85Ks1w642wHDqBmwsD+16h6Oq4r5gR6HvyZXCPUpfOF2RYx
 DjyCSImsQi0kq4lbqVOV0t27tWQWDnnq+Zlm8iR4BMO4sHKaoap1pJNNjkGYaHHAtpwJ5psGib6
 Bb+uD5y4Mon7qIEY4spFHJP5SWhHt42opJU/RU4XEJDzL2jQTK/Xjn88lK8o8eM=
X-Received: by 2002:ac8:6f07:0:b0:476:a713:f783 with SMTP id
 d75a77b69052e-4770806a9b6mr529381cf.47.1742322701501; 
 Tue, 18 Mar 2025 11:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcXyf3i+qKw9TF13vbMQP9s3xXj1Ph/jly7dAuS98aFoalwlryHZCyb2KjfWsazdy7wugm/Q==
X-Received: by 2002:ac8:6f07:0:b0:476:a713:f783 with SMTP id
 d75a77b69052e-4770806a9b6mr528991cf.47.1742322701146; 
 Tue, 18 Mar 2025 11:31:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4770065d060sm10380231cf.0.2025.03.18.11.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 11:31:40 -0700 (PDT)
Message-ID: <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
Date: Tue, 18 Mar 2025 19:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia> <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,


On 3/17/25 9:19 PM, Nicolin Chen wrote:
> On Mon, Mar 17, 2025 at 04:24:53PM -0300, Jason Gunthorpe wrote:
>> On Mon, Mar 17, 2025 at 12:10:19PM -0700, Nicolin Chen wrote:
>>> Another question: how does an emulated device work with a vSMMUv3?
>>> I could imagine that all the accel steps would be bypassed since
>>> !sdev->idev. Yet, the emulated iotlb should cache its translation
>>> so we will need to flush the iotlb, which will increase complexity
>>> as the TLBI command dispatching function will need to be aware what
>>> ASID is for emulated device and what is for vfio device..
>> I think you should block it. We already expect different vSMMU's
>> depending on the physical SMMU under the PCI device, it makes sense
>> that a SW VFIO device would have it's own, non-accelerated, vSMMU
>> model in the guest.
> Yea, I agree and it'd be cleaner for an implementation separating
> them.
>
> In my mind, the general idea of "accel=on" is also to keep things
> in a more efficient way: passthrough devices go to HW-accelerated
> vSMMUs (separated PCIE buses), while emulated ones go to a vSMMU-
> bypassed (PCIE0).
Originally a specific SMMU device was needed to opt in for MSI reserved
region ACPI IORT description which are not needed if you don't rely on
S1+S2. However if we don't rely on this trick this was not even needed
with legacy integration
(https://patchwork.kernel.org/project/qemu-devel/cover/20180921081819.9203-1-eric.auger@redhat.com/).

Nevertheless I don't think anything prevents the acceleration granted
device from also working with virtio/vhost devices for instance unless
you unplug the existing infra. The translation and invalidation just
should use different control paths (explicit translation requests,
invalidation notifications towards vhost, ...).

Again, what does legitimate to have different qemu devices for the same
IP? I understand that it simplifies the implementation but I am not sure
this is a good reason. Nevertheless it worth challenging. What is the
plan for intel iommu? Will we have 2 devices, the legacy device and one
for nested?

Thanks

Eric


>
> Though I do see the point from QEMU prospective that user may want
> to start a VM with HW-accelerated vSMMU for one passthrough device
> using a simple setup without caring about the routing via command.
>
> Thanks
> Nicolin
>


