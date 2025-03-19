Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E97C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 02:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuixi-0005Ew-6j; Tue, 18 Mar 2025 22:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuixb-0005E0-LX
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tuixY-0002vs-AB
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742350506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qonzyYXvvu1TU3IxZavApsjH9c4mi4mLrIVtVMRGXBg=;
 b=HVgzro3gVfWry9ilEZ7bpKWxP1zcBBgap7VHy9LMOAeE2POV9gWpzuwY2q0/JprXsorkSl
 AGZ4CglvkROf19sTlfUytZJxBjyXFhgXf21HmJWNaYVD1puiEwpvh194liiomgBA/giYNK
 w2YgMCU67viaN87vlvJ6AiZ/e5gh1m4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-wPsRk2irOkSvvWUStK30WQ-1; Tue, 18 Mar 2025 22:15:04 -0400
X-MC-Unique: wPsRk2irOkSvvWUStK30WQ-1
X-Mimecast-MFC-AGG-ID: wPsRk2irOkSvvWUStK30WQ_1742350503
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3ce843b51c3so176969705ab.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 19:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742350503; x=1742955303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qonzyYXvvu1TU3IxZavApsjH9c4mi4mLrIVtVMRGXBg=;
 b=eS5HGfWcWH7xpCreG+P3vBEo/AEyg1IYB3o/CDex2Rtl+mwJy2bqsJaBc9+8qm8uRE
 j9KNr5tssiLlha2PuidxaidCOBhyJ7WlKloekcqmvFW+ifDSgt+yjRh5Enl4M1mAt+T+
 HXJCCseLg68JPThoPeVxnX3HvmCeShc/8BVEObl3JPUYT0NRY/aeZ0hwxazCpU3lMC7u
 i9O7dQik8ck69jTcujIpc6dKH5zYKFmJ3yxGBVGazEWW763YRvHqw2SFPPaadW6wgj8z
 ETYQYIZnCDtFyK1iYBpsH7mr79jzsJ4OP2MNiMpDaUDWKFoqkAgDtFTdWHvKJ+QUkwZ/
 FQWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpGTRfEimMvqMRSpGTqJsKlY3PVHo0bRqJhLBrYXD1QnD/TAbdTlyYFLElgI38mWBll+euV1PYF3jj@nongnu.org
X-Gm-Message-State: AOJu0Yz3CublQ3Pj1+3pO4yGuFtMGX0s6jkZRuT5XBix7MDZ/z/KMKCr
 bGD9kKdyXysEfuX2s8/m4wRVcQAJT5hMt6z2reDruj35Zl2cz+qU+PFuUv6/RGNverRApWqJmHL
 0YmDbdKSC/daQM3BQ0d0NczzzQQ3BFrbjZ/hK4W9DKOFyaNWVfQ2t
X-Gm-Gg: ASbGnctcO2gla/TTk1gXqZMiY/K132a5G6Atq+WyyWhYSwCwDQ8zeLgkKsHkgCotMBK
 iXRX93FcEUDH5iX7scssoVYVXkK8OrTiNo4TmfdEe35JyeI4M29EoB5qmu3VwxtGYbhxT1rtBOm
 Rkzj5XPS/s7lgYYC21XGgV0+i6gy1Qya7i8k2Z5y4Oh5coCO6jTDX5NlRjdecvAcwI7svUTZQjm
 7qKBbdX+TH8TAu2lRwnxT3Rpng6+AeAzXBZvzvTPpiOzZJthfjs9lH9ISMD5LRuuZNekKW1E1N5
 HYGsfVv55xfAuk76
X-Received: by 2002:a05:6e02:188d:b0:3d0:4a82:3f43 with SMTP id
 e9e14a558f8ab-3d586b150f0mr11732045ab.5.1742350503487; 
 Tue, 18 Mar 2025 19:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGimtOF0LmtoQEutRQu/yBnHnTHu/LRz+8dbajzB6997miB5QGBb8icjxdAzV4oGC7dnCCSwA==
X-Received: by 2002:a05:6e02:188d:b0:3d0:4a82:3f43 with SMTP id
 e9e14a558f8ab-3d586b150f0mr11731835ab.5.1742350503124; 
 Tue, 18 Mar 2025 19:15:03 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d47a447ba8sm35796155ab.0.2025.03.18.19.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 19:15:02 -0700 (PDT)
Message-ID: <5dc1fcc4-a57d-4569-b86e-2e7cab7ed778@redhat.com>
Date: Tue, 18 Mar 2025 22:15:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia> <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
 <Z9nF6FaIU37BNg4B@Asurada-Nvidia>
 <3716d39d-3f88-4914-a9d6-440d379db3d7@redhat.com>
 <20250319002325.GG9311@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250319002325.GG9311@nvidia.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Jason,
Hey!

On 3/18/25 8:23 PM, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 05:22:51PM -0400, Donald Dutile wrote:
> 
>> I agree with Eric that 'accel' isn't needed -- this should be
>> ascertained from the pSMMU that a physical device is attached to.
> 
> I seem to remember the point was made that we don't actually know if
> accel is possible, or desired, especially in the case of hotplug.
> 
In the case of hw-passthrough hot-plug, what isn't known?:
a) domain:b:d.f is known
b) thus its hierarchy and SMMUv3 association in the host is known
c) thus, if the (accel) features of the SMMUv3 were exposed (known),
    then the proper setup (separate SMMUv3 vs system-wide-emulated SMMUv3;
    association of (allocated/configured) vSMMUv3 to pSMMUv3 would be known/made

What else is missing?

> The accelerated mode has a number of limitations that the software
> mode does not have. I think it does make sense that the user would
> deliberately choose to use a more restrictive operating mode and then
> would have to meet the requirements - eg by creating the required
> number and configuration of vSMMUs.
> 
At a qemu-cmd level, the right number & config of smmuv3's, but
libvirt, if it had the above info, could auto-generate the right number
of smmuv3's (stages, accel-features, etc.) ... just as it does today in
creating the right number of pcie bus's, RPs, etc. from simple(r)
device specs into more complete, qemu configs.

>> Now... how does vfio(?; why not qemu?) layer determine that? --
>> where are SMMUv3 'accel' features exposed either: a) in the device
>> struct (for the smmuv3) or (b) somewhere under sysfs? ... I couldn't
>> find anything under either on my g-h system, but would appreciate a
>> ptr if there is.
> 
> I think it is not discoverable yet other thatn through
> try-and-fail. Discoverability would probably be some bits in an
> iommufd GET_INFO ioctl or something like that.
> 
I don't see how iommufd would 'get-info' the needed info any better
than any other interface/subsystem.  ...

>> and like Eric, although 'accel' is better than the
>> original 'nested', it's non-obvious what accel feature(s) are being
>> turned on, or not.
> 
> There are really only one accel feature - direct HW usage of the IO
> Page table in the guest (no shadowing).
> 
> A secondary addon would be direct HW usage of an invalidation queue in
> the guest.
> 
and, if architected correctly, even in (device-specific) sw-provided tables,
it could be 'formatted' in a way that it was discoverable by the appropriate layers
(libvirt, qemu).
Once discoverable, this whole separate accel device -- which is really an
attribute of an SMMUv3 -- can be generalized, and reduced, to a much
smaller, simpler, sw footprint, with the concept of callbacks (as the series
uses) to enable hw accelerators to perform the shadow-ops that fully-emulated
smmuv3 would have to do.
  
>> kernel boot-param will be needed; if in sysfs, a write to 0 an
>> enable(disable) it maybe an alternative as well.  Bottom line: we
>> need a way to (a) ascertain the accel feature (b) a way to disable
>> it when it is broken, so qemu's smmuv3 spec will 'just work'.
> 
> You'd turned it off by not asking qemu to use it, that is sort of the
> reasoning behind the command line opt in for accel or not.
It would make machine-level definitions far more portable if the
working/non-working, and the one-accel, or two-accel, or three-accel, or ...
features were dynamically determined  vs a static (qemu) machine config, that would have
to be manipulated each time it ran on a different machine.

e.g., cluster sw scans servers for machines with device-X.
       create VMs, assigning some/all of device-X to a VM via its own smmuv3. done.
       Now, if the smmuv3 features were exposed all the way up to userspace,
       then one could argue the cluster sw could scan for those features and add it
       to the accel=x,y,z option of the smmuv3 associated with an assigned device.
       potato/po-tah-toe cluster sw or libvirt or qemu or <something-else> scans/reads
        ... discoverability of the features has to be done by
       (a) a computer, or (b) an error-prone human.
      ... all that AI gone to waste ... ;-)

- Don

> 
> Jason
> 


