Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E091C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 10:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3nw-00088l-4U; Fri, 14 Jun 2024 06:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI3nu-000886-9k
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sI3ns-0005lk-6N
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718359502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gwo/Jsa13Ll3Es/y0yghFvctU2KH/rcsXeXQKCHBjPY=;
 b=O+DRbl0rsv/v5vWcDboJltcCXxEjpmN8cTH4mgOcw2Fw4k2q4XgsV489PIaUpBEaRmOws/
 9Y7zVavLmYCR3wnUTkAZSReDSIZmC6C9RdukY1u2KGDpv0BMLkoiUDcKUCNuSGiay/W1cZ
 UG6V8TKCBdBtxlDftf481aNkcvc59nE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-QGoFsgqpNom_ire3PuxyUA-1; Fri, 14 Jun 2024 06:04:59 -0400
X-MC-Unique: QGoFsgqpNom_ire3PuxyUA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d2283ce6c9so1586873b6e.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 03:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718359498; x=1718964298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gwo/Jsa13Ll3Es/y0yghFvctU2KH/rcsXeXQKCHBjPY=;
 b=J38NzmFUUGTPqTfIUxEJo1xP5lCaFNRidq/UnU8BEjwiHvVFA3jg0/4Bc2N3hJxuuC
 wVpnNmvARq8S3qBcXPEt79HSuIhrMAwnKKW7mh0g95nnQPP7jUJMU3c+LRFFKWvAUV4/
 Fhxzit1Yi64F+YCWLq0M11LAtd4U4ZTwPPomsGQiJHewKNk9GeKj4m4GNmXET9Egkch1
 RKFlOKr0z9GB1pRKRVvg/FAgT05UwRE82Zah1ZhoCLskM9V2Y2JYYLe0V+9N3BEsu8Rg
 SVkODRh+6XIJAW9ybEs+IYamGXmWIGsoBVHKBJQdDqMWYzP21hmQQq69nR/D7dJNwcDv
 3yuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJmnajJGAkNV2GSGB2s0RZP1HLrFTZBGICLtKrE7k+mt/mb27sQ5JfIZ+98G8P+wSABnFswHggtklE8JEWc1ioS6kwR8Q=
X-Gm-Message-State: AOJu0YzmwCzImYeAoYikVQ9K5/FT2Kihg6nSLwrlAii7SO7tfG+rDT6j
 Hm0beoh3dSz/qOyVBNe1A8Y2muWC5AmemTj4yXv5atRzQollNt14DG7D6qakCYihqiqRl2vFPjK
 6hn4aXUtrVFgp/ScbF5zIXt35jgNdqnZDXWTYxvFzzS+895Fxoxds
X-Received: by 2002:a05:6808:1485:b0:3d2:2293:9990 with SMTP id
 5614622812f47-3d24e8ace79mr2336680b6e.2.1718359498683; 
 Fri, 14 Jun 2024 03:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCGXzTg/Hc4yAi7mz8J4o15NslCmqRgXbG0TxduAkPVCEG4KPGs7DXL4rHYXYo8S5PbvnnJw==
X-Received: by 2002:a05:6808:1485:b0:3d2:2293:9990 with SMTP id
 5614622812f47-3d24e8ace79mr2336661b6e.2.1718359498325; 
 Fri, 14 Jun 2024 03:04:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abf64365sm127898885a.136.2024.06.14.03.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 03:04:57 -0700 (PDT)
Message-ID: <ec740f33-44ae-4d50-be65-5f717122f4f0@redhat.com>
Date: Fri, 14 Jun 2024 12:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] HostIOMMUDevice: Store the VFIO/VDPA agent
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-2-eric.auger@redhat.com>
 <ef400920-dcf4-4f37-b4ce-c5560b92d9c5@redhat.com>
 <f6473f76-1d8f-41cb-9488-73edc960c996@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <f6473f76-1d8f-41cb-9488-73edc960c996@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


>> Talking of which, why are we passing a 'VFIODevice *' parameter to
>> HostIOMMUDeviceClass::realize ? I don't see a good reason
>>
>> I think a 'VFIOContainerBase *' would be more appropriate since
>> 'HostIOMMUDevice' represents a device on the host which is common
>> to all VFIO devices.
>>   
>> In that case, HostIOMMUDevice::agent wouldn't need to be opaque
>> anymore. It could  simply be a 'VFIOContainerBase *' and
>> hiod_legacy_vfio_get_iova_ranges() in patch 3 would grab the
>> 'iova_ranges' from the 'VFIOContainerBase *' directly.
>>
>> This means some rework :
>>
>> * vfio_device_get_aw_bits() would use a  'VFIOContainerBase *' instead.
>> * HostIOMMUDevice::name would be removed. This is just for error
>> messages.
>> * hiod_iommufd_vfio_realize() would use VFIOIOMMUFDContainer::be.
>>
>> That said, I think we need the QOMification changes first.
> 
> OK I need to review your series first. At the moment I have just
> addressed Zhenzhong's comment in v4, just sent.

Yep. Just take a look at mine. If both of you agree with above
proposal, I can care of it and resend all 3. It's a small change.

Thanks,

C.


