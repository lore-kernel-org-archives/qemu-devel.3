Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B99C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 12:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdqML-0000P6-K0; Fri, 31 Jan 2025 07:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdqM5-0000ND-Fn
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 07:42:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdqM3-00038N-Bs
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 07:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738327357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L1gq4p0zfBKFy6qE5wibp9OHFR3bu9nx4E8I6u5CEjA=;
 b=Ug9KZbpqrtHnFz13jn65nhVJOPdtllxlPdae/MOnSPIWhJ2jVirSqQCXcoMj9hbLbvwdb/
 AgPT1F+CBPrJ0H0c5zHvMwhl9TQ4hJE/uqUG9eb0OLOGa0di4sV9blhK5AuLgPG9EMBOtS
 Pf2xvb4+CcGrYG38jdpqXrHo+UZ7jUk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-JCfLMmANNDmEr1B07RrWQQ-1; Fri, 31 Jan 2025 07:42:33 -0500
X-MC-Unique: JCfLMmANNDmEr1B07RrWQQ-1
X-Mimecast-MFC-AGG-ID: JCfLMmANNDmEr1B07RrWQQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-468f6f2f57aso22238861cf.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 04:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738327353; x=1738932153;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1gq4p0zfBKFy6qE5wibp9OHFR3bu9nx4E8I6u5CEjA=;
 b=tFr08f0yiWkKLqExD6jWBTwHUhDkHQTAeVdns0dmx+qXNmNKxmVYtqNzhX+OcKl6DW
 1Um5IGMkXy6b+CRcernAMOhMs92yKPAJPCRcYCWhiXaeQyQtIb7BYu707F8fXs3Yy08V
 6x/rsGNUd3L3xk0QGF/jYyXQ1F28Q+bUDIoyeKyjjtJWpr/PNiRVVmkkY0SrX5uTIFo2
 Vhvty+ikM6rWH4z3rXANCvwekvX5gGdfdotMxatrXqUrr7Bmz2OPQ26YzXV9aGqoJXrP
 Wjp6qeuf9qtAQARgpsUfaG5/pTFTuJJrov0ltIqWgEbh4a1NHUEMs+z/CBhhCpucx9j0
 DGAg==
X-Gm-Message-State: AOJu0Yx4RuqWn+6yHg5l3UVUV8nr7GxvJKFx2Z1CF/TFalWa83e155KP
 3rARvZNPWBikQ/1p6JddhIeMzGjLJjQ4gxy8EjwNtcbsJyPwzbRS8T+xrdkMSXCzsBQSvbWxfgm
 GEahIw6PT0d6e3/bh6vFbgKzLzhXqhy5JV+/vaCHqxoEyeG2s73zr
X-Gm-Gg: ASbGncsSZIz+P6uod2ZXdrG22ZvSPJxtF492WiG6A0awzu7nV7agxTkabcbTgKMLvsz
 AyS24S2KvEkkODsf1rjUXKxNsj7/a0tFH01LHIvAH6QWRGsTp4WcpsizPSTKFBefVkhH9g6+2vc
 FvZTiUURsPS+Vd6pK7m6oyP7SwlebUWSHY0jNX+d1t/hZqNsC6ieQeYgTVieIm9Rbcc6072h/TY
 Dv9cWUkjihpP7hw/hpYPIwK/aMam1PoXpwu730hBozl/2dfF8wuAjbHQ+mvrI2gdxaTLfO4t3Nt
 /VypXUT356PDkh1pNEbX2NpB8jYeiuufGP+GGpqIuNk=
X-Received: by 2002:ac8:5d52:0:b0:467:86fa:6b72 with SMTP id
 d75a77b69052e-46fd0a6486cmr156708391cf.12.1738327353241; 
 Fri, 31 Jan 2025 04:42:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF13fHcLrDxPviPCksGzDrkjGbco5jUGrGFKM13vwt4rESefJ15vDohW4CAmJf4kW3Mbl+D/w==
X-Received: by 2002:ac8:5d52:0:b0:467:86fa:6b72 with SMTP id
 d75a77b69052e-46fd0a6486cmr156708131cf.12.1738327352856; 
 Fri, 31 Jan 2025 04:42:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf17c7cfsm17483011cf.66.2025.01.31.04.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 04:42:32 -0800 (PST)
Message-ID: <9cfaf81e-d8cc-4ec0-9c56-956b716891e7@redhat.com>
Date: Fri, 31 Jan 2025 13:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU address
 space width
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
 <20250130115800.60b7cbe6.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250130115800.60b7cbe6.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

+ Gerd for insights regarding vIOMMU support in edk2.

On 1/30/25 19:58, Alex Williamson wrote:
> On Thu, 30 Jan 2025 14:43:45 +0100
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> Print a warning if IOMMU address space width is smaller than the
>> physical address width. In this case, PCI peer-to-peer transactions on
>> BARs are not supported and failures of device MMIO regions are to be
>> expected.
>>
>> This can occur with the 39-bit IOMMU address space width as found on
>> consumer grade processors or when using a vIOMMU device with default
>> settings.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/common.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 5c9d8657d746ce30af5ae8f9122101e086a61ef5..e5ef93c589b2bed68f790608868ec3c7779d4cb8 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -44,6 +44,8 @@
>>   #include "migration/qemu-file.h"
>>   #include "system/tpm.h"
>>   
>> +#include "hw/core/cpu.h"
>> +
>>   VFIODeviceList vfio_device_list =
>>       QLIST_HEAD_INITIALIZER(vfio_device_list);
>>   static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>> @@ -1546,12 +1548,28 @@ retry:
>>       return info;
>>   }
>>   
>> +static bool vfio_device_check_address_space(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    uint32_t cpu_aw_bits = cpu_get_phys_bits(first_cpu);
>> +    uint32_t iommu_aw_bits = vfio_device_get_aw_bits(vbasedev);
>> +
>> +    if (cpu_aw_bits && cpu_aw_bits > iommu_aw_bits) {
> 
> Should we be testing the 64-bit MMIO window and maximum RAM GPA rather
> than the vCPU physical address width?
> 
> Maybe we're just stuck with an indirect solution currently.  AIUI,
> we're testing the vCPU physical address width because (obviously) all
> devices and memory need to be addressable within that address space.
> However, as we've explored offline, there are bare metal systems where
> the CPU physical address width exceeds the IOMMU address width and this
> is not a fundamental problem.  It places restrictions on the maximum
> RAM physical address and the location of the 64-bit MMIO space.
> 
> RAM tends not to be a problem on these bare metal systems since they
> physically cannot hold enough RAM to exceed the IOMMU width and, for
> the most part, we map RAM starting from the bottom of the address
> space.  So long as the VMM doesn't decide to map RAM at the top of the
> physical address space, this doesn't become a problem.
> 
> However, we've decided to do exactly that for the 64-bit MMIO window.
> It's not that the vCPU width being greater than the IOMMU width is a
> fundamental problem, it's that we've chosen a 64-bit MMIO policy that
> makes this become a problem and QEMU only has a convenient mechanism to
> check the host IOMMU width when a vfio device is present.  Arguably,
> when a vIOMMU is present guest firmware should be enlightened to
> understand the address width of that vIOMMU when placing the 64-bit
> MMIO window.  I'd say the failure to do so is a current firmware bug.
> 
> If the vIOMMU address width were honored, we could recommend users set
> that to match the host, regardless of the vCPU physical address width.
> We also already have a failure condition if the vIOMMU address width
> exceeds the vfio-device (ie. indirectly the host) IOMMU width.
> 
> Of course without a vIOMMU, given our 64-bit MMIO policy, we don't have
> a good solution without specifying the 64-bit window or implementing a
> more conservative placement.
> 
> Not sure how much of this is immediately solvable and some indication
> to the user how they can resolve the issue, such as implemented here, is
> better than none, but maybe we can elaborate in a comment that this is
> really more of a workaround for the current behavior of firmware
> relative to the 64-bit MMIO placement policy.  Thanks,

Sure. I will improve the commit log in v3.

Thanks,

C.


> Alex
> 
>> +        error_setg(errp, "Host physical address space (%u) is larger than "
>> +                   "the host IOMMU address space (%u).", cpu_aw_bits,
>> +                   iommu_aw_bits);
>> +        vfio_device_error_append(vbasedev, errp);
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                           AddressSpace *as, Error **errp)
>>   {
>>       const VFIOIOMMUClass *ops =
>>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>       HostIOMMUDevice *hiod = NULL;
>> +    Error *local_err = NULL;
>>   
>>       if (vbasedev->iommufd) {
>>           ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>> @@ -1571,6 +1589,9 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>           return false;
>>       }
>>   
>> +    if (!vfio_device_check_address_space(vbasedev, &local_err)) {
>> +        warn_report_err(local_err);
>> +    }
>>       return true;
>>   }
>>   
> 


