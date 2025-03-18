Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36532C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuehs-0001pJ-Ua; Tue, 18 Mar 2025 17:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuehr-0001ot-75
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tueho-00037V-Vx
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742334155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbIPN7AS6G9xolEmuC8tYbLVdteMxhoPrmydpSaGuQs=;
 b=WHu9x+wSWbMI8dAU5RFwl3rQoXavA+GwWzyET+davfdauLztA9pV/yOBmXPHZxXc97o/zu
 yPuFRzF/BMf9DNcSNT4QqfvPEJtb6aeQG+s3CxmUPhLfTMmoYpPfCdYSKMgrkIujBPzyxZ
 4ZkTQSk9t/kmkFUag8B4Mu6alMorP64=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-fDiWvw7sPhK4zn0bfieXww-1; Tue, 18 Mar 2025 17:42:32 -0400
X-MC-Unique: fDiWvw7sPhK4zn0bfieXww-1
X-Mimecast-MFC-AGG-ID: fDiWvw7sPhK4zn0bfieXww_1742334151
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-85b402f6a1bso1724168639f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742334151; x=1742938951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kbIPN7AS6G9xolEmuC8tYbLVdteMxhoPrmydpSaGuQs=;
 b=gy+/rhLrLEt47uohC9ZqPJ6enQzrbTEsK6UNBHcystRh73vGIbuNllGm2L/r9Alcq4
 cojGdIHVKGlrwXlJrd95293ifl57RJFm77lQlJmfn2BhirbunzT5bPvMVPn9uobnjn05
 uOxBkK0Rdwgya3k/jmBkl/kTBd7HPbdbDOm+FQdnWKfh6SbQ8gvjnYlQklw5AcBMVrW5
 hAIvn8RuVBLeNF+XLS55RJ/YutDoAqHSUvJf+RiXsfBLZxdkSr2uZeY1pBVDdZSo00GL
 s96CrgSnOdHxSmk4dvM4teXHPYa9Pf30UR30Z3tZtwqOyoRR2qR8MZ6v7VSk4QQPIwHm
 Z7aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI3Uor0ujSkSC9GTS1c/EFh5ClTW39NNjSzBG0He5nfaM30QW5mJ+EneIhoQVwt7l2yGcFeDZRCG6D@nongnu.org
X-Gm-Message-State: AOJu0YwO9qx8C+RMXnpKydn8rrZ5FGZyuG2RmfQM+jeEHr4hs4JZkxGb
 Lvglce8NDSsNei+jrO7dLIs+CUa1ZdbrfFrhz1lnHG3wKW6C62JKUVDD7u5gcuVKBrGbG9y+Q7h
 Rd8d+o1F3AWJEXsQtQ3yZYpPsAYVXdsfHvz2aoZcQvOljta/be67w
X-Gm-Gg: ASbGncvCqJQWbWgekLU1JJMH7xf0G5jYKks9UEbRqYVGxEV2EW4HV3vZ2sJgsfMtFyV
 Bal0rn/x+G8JxlJxc5JguHtip9dPPxuFfmrSmC68YIvRfS3XS/9KFvNRAEaVFM5Gir2t6sFz511
 aC2xT1059StubIxnoInzxYceUlDf44VjK2u0ES3sw2ytBYlsz9dInL+UvBg3jsoOvDrLzKGlmQB
 krtUSpQ7xOQx4VjIIfn/2z4wOxIKrn5rSmBnDEFa3Owninquk50ANhuYbUglbyxHQr2f15kuqf6
 Y5G/Abve30QQek3v
X-Received: by 2002:a05:6e02:1564:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d586b9eb76mr4569965ab.15.1742334151293; 
 Tue, 18 Mar 2025 14:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUfDdUNsU6RaJBinXDzrnfg5izfiWYHksP5vcR8AwQto4nQfxxUe7k9UhIzcu+QLuS/tHf9g==
X-Received: by 2002:a05:6e02:1564:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d586b9eb76mr4569695ab.15.1742334150949; 
 Tue, 18 Mar 2025 14:42:30 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f263824f30sm2911865173.116.2025.03.18.14.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 14:42:30 -0700 (PDT)
Message-ID: <953783f3-923b-4afb-886e-9be5f81e26ad@redhat.com>
Date: Tue, 18 Mar 2025 17:42:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia> <20250317192453.GR9311@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250317192453.GR9311@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



On 3/17/25 3:24 PM, Jason Gunthorpe wrote:
> On Mon, Mar 17, 2025 at 12:10:19PM -0700, Nicolin Chen wrote:
>> Another question: how does an emulated device work with a vSMMUv3?
>> I could imagine that all the accel steps would be bypassed since
>> !sdev->idev. Yet, the emulated iotlb should cache its translation
>> so we will need to flush the iotlb, which will increase complexity
>> as the TLBI command dispatching function will need to be aware what
>> ASID is for emulated device and what is for vfio device..
> 
> I think you should block it. We already expect different vSMMU's
... and when you say 'block', you mean qemu prints out a helpful message
like "Mixing emulate/virtual devices and physical devices on a single SMMUv3 is not allowed.
       Specify separate smmuv3 objects for each type of device; multiple smmuv3 objects may
       be required for each physical device if they are attached to different smmuv3's in the host system."

Or would that be an allowed qemu machine definition, but the 'block' would be a warning like:
  "Mixing emulated/virtual devices and physical devices on a single SMMUv3 is not recommended for
   performance reasons.  To yield optimal performance, place physical devices on separate SMMUv3 objects
   than emulated/virtual device SMMUv3 objects."
... and in this case, the physical devices would not use the accel features of an smmuv3, but still be 'functional'.
This may be desired for a machine definition that wants to be used on different hosts that may not have the
(same) accel feature(s).



> depending on the physical SMMU under the PCI device, it makes sense
> that a SW VFIO device would have it's own, non-accelerated, vSMMU
> model in the guest.
> 
> Jason
> 


