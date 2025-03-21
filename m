Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFFCC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 00:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvQfL-00067J-Eq; Thu, 20 Mar 2025 20:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tvQfJ-00066Y-Re
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tvQfI-0004zF-9I
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742518511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5y0wlXMt9o+MiCERHXtqeoHrLHN6OuuVFf0gqNCpnU=;
 b=fuixYRV2PiLbkS1LXfmXEbDCQDGzx79lYpZb7G7vcNZmSBjL73eAkfOCQZgTQYr1gDlx2F
 Mh/XERYdAEDKWsd/SYfZQO2e/S3r01vbT2XuKAVYIiFwk6o0ReummIl9T7i3UY+dN/qX53
 U5zTvlcr0l8O5dJbQwCVzymCwMg5Tng=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227--4yvFKQYPeWFT--Fq7WjGg-1; Thu, 20 Mar 2025 20:55:07 -0400
X-MC-Unique: -4yvFKQYPeWFT--Fq7WjGg-1
X-Mimecast-MFC-AGG-ID: -4yvFKQYPeWFT--Fq7WjGg_1742518506
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-85b53875729so299034139f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 17:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742518506; x=1743123306;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O5y0wlXMt9o+MiCERHXtqeoHrLHN6OuuVFf0gqNCpnU=;
 b=EjtLZNnnvpcvifb1sK2FMhN3thriexwneWco8+emHxIh95+9BojE12g3BvlWdgDkDN
 TUTk8akSd6Sy2CeRh/6dhrQKxQ8Sfs5noV3vFAIKnhsys0wRPTrYjLyjYIbkwVmyNaED
 nuIhjDRbo95QqOp1/a9Y0tON7XUhcWVsi8mAivMJ92JojYRqjnY7PWLdZYLPZf+/GYDE
 5L52R5bE/vGGC+UazjwacL+l+UBBVaYCc9qjjQswO9bKtReQfwCKyDwklvmFMLaqGzgZ
 hcIB7ny6jwOjJjpMjhvuESzPQYbsBECH0TSD45QwvxkbFXwvSbqmeUvWEZmJIIi1vFEq
 aRdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6bfzD07ffi5wORtWUWXKMLW0RRnqetPmpMuEBYuhHkM/WxiyLRbTU9gHynFmqlWw5gX/eiEivfZ+a@nongnu.org
X-Gm-Message-State: AOJu0YxvNDxxm+l6A1oIfl3A79Gzmnvgp3ccsP20J1N1GLvITpqpGryG
 1si6Ibthpuhppu35xlPtH65DoYZb1ElNab6T6Q4SuOj+GTSgIp77S5vTXDWJwzw/rgqatpe54eE
 jSoJ8QH+SWMdnWPq4CJAkpjF3KDPkY0bAkbj1ZtGWKvDTZPCGd90y
X-Gm-Gg: ASbGncvPrSauSDihulgl7p6AqMVacp/r+HLS0GeY3LuOP6IkE/CcKQvRsiJqfQYqpyC
 flPbscW3ct/VLMS3Kg0h2w+T6NRLKSOU/S/Ip4fNp9NHSu66PnpkEwll/y/c9spvBuktRIiJksx
 CjuTJDKowqybpNpNQQ4pnk9l/GavoB8gJRJ/mWWB/AKvKPPWkXzXdplCi+zWzM8dfj7acTac4Fz
 rwQqGuQMk9R6z0cTYDpNpGBcMyFlLzQSaBFwVExuon+pN2/5SO/fKCIsCuO+aoQDdWOjTWQ2ZYy
 9N1GEXJz/WXM+XCF
X-Received: by 2002:a05:6e02:b28:b0:3d4:3db1:77ae with SMTP id
 e9e14a558f8ab-3d59617c61emr20675065ab.18.1742518506621; 
 Thu, 20 Mar 2025 17:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfTw2ElLeXEH5wcYzEEikFwWPQJePt1C737FC57DGQtSHOnwMu4lVXda/2cihlGg6BvEwuvQ==
X-Received: by 2002:a05:6e02:b28:b0:3d4:3db1:77ae with SMTP id
 e9e14a558f8ab-3d59617c61emr20674865ab.18.1742518506314; 
 Thu, 20 Mar 2025 17:55:06 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d59607ea1esm1954825ab.19.2025.03.20.17.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 17:55:05 -0700 (PDT)
Message-ID: <1aa26060-d227-4b4a-9397-454ef33e7355@redhat.com>
Date: Thu, 20 Mar 2025 20:55:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: eric.auger@redhat.com, Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
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
 <27aee7f3-5316-40b7-bd7e-dc68a7a1d0d2@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <27aee7f3-5316-40b7-bd7e-dc68a7a1d0d2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 3/19/25 1:00 PM, Eric Auger wrote:
> Hi,
> 
> 
> On 3/19/25 1:23 AM, Jason Gunthorpe wrote:
>> On Tue, Mar 18, 2025 at 05:22:51PM -0400, Donald Dutile wrote:
>>
>>> I agree with Eric that 'accel' isn't needed -- this should be
>>> ascertained from the pSMMU that a physical device is attached to.
>> I seem to remember the point was made that we don't actually know if
>> accel is possible, or desired, especially in the case of hotplug.
> that's why I think it would be better if we could instantiate a single
> type of device that can do both accel and non accel mode.
> Maybe that would be at the price of always enforcing MSI resv regions on
> guest to assure MSI nesting is possible.
> 
>>
>> The accelerated mode has a number of limitations that the software
>> mode does not have. I think it does make sense that the user would
>> deliberately choose to use a more restrictive operating mode and then
>> would have to meet the requirements - eg by creating the required
>> number and configuration of vSMMUs.
> To avoid any misunderstanding I am not pushing for have a single vSMMU
> instance. I advocate for having several instances, each somehow
> specialized for VFIO devices or emulated devices. Maybe we can opt-in
> with accel=on but the default could be auto (the property can be
> AUTO_ON_OFF) where the code detects if a VFIO device is translated.In
> case incompatible devices are translated into a same vSMMU instance I
> guess it could be detected and will fail.
> 
> What I am pusshing for is to have a single type of QEMU device which can
> do both accel and non accel.
+1 !

>> In general I advocate for having several vSMMU instances, each of them
>>
>>> Now... how does vfio(?; why not qemu?) layer determine that? --
>>> where are SMMUv3 'accel' features exposed either: a) in the device
>>> struct (for the smmuv3) or (b) somewhere under sysfs? ... I couldn't
>>> find anything under either on my g-h system, but would appreciate a
>>> ptr if there is.
>> I think it is not discoverable yet other thatn through
>> try-and-fail. Discoverability would probably be some bits in an
>> iommufd GET_INFO ioctl or something like that.
> yeah but at least we can easily detect if a VFIO device is beeing
> translated by a vSMMU instance in which case there is no other choice to
> turn accel on.
> 
> Thanks
> 
> Eric
>>
>>> and like Eric, although 'accel' is better than the
>>> original 'nested', it's non-obvious what accel feature(s) are being
>>> turned on, or not.
>> There are really only one accel feature - direct HW usage of the IO
>> Page table in the guest (no shadowing).
>>
>> A secondary addon would be direct HW usage of an invalidation queue in
>> the guest.
>>
>>> kernel boot-param will be needed; if in sysfs, a write to 0 an
>>> enable(disable) it maybe an alternative as well.  Bottom line: we
>>> need a way to (a) ascertain the accel feature (b) a way to disable
>>> it when it is broken, so qemu's smmuv3 spec will 'just work'.
>> You'd turned it off by not asking qemu to use it, that is sort of the
>> reasoning behind the command line opt in for accel or not.
>>
>> Jason
>>
> 


