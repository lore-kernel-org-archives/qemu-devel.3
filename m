Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C6C48BC1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqBA-0004Nv-1h; Tue, 13 Feb 2024 05:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZqB6-0004N2-UU
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZqB4-0002BE-ND
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707820694;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kttHkiSTsszLZqmx06RlazAmG/SduE8/h3JYqH1GYo=;
 b=Fa2HN6lbovZUQoQv0dRprFnwSglDu4QnQjsVyMNn79OqM9vYlRMPHvR2Q0DRTiFjJTNf0d
 qbLwK9tCeFoOBsZRj88cY7zKGarSZjAgz3G+sR/tbQnyRdyqB838ojTl5LSWplamrA7Sjq
 XYyQ2QaqcrDBISIInxrq8C4I31F83TU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-o0R-RwzAOxSzYhnmrRpyOQ-1; Tue, 13 Feb 2024 05:38:12 -0500
X-MC-Unique: o0R-RwzAOxSzYhnmrRpyOQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6e0df6d6530so4765400a34.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707820691; x=1708425491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0kttHkiSTsszLZqmx06RlazAmG/SduE8/h3JYqH1GYo=;
 b=gfwEh0Rt6bEOTa1BnQbZo388+OgqX3H4CmBKj6jJaKPnbqeZ1K4xZ9KLBVGjSlIwt8
 b8BrV2akiTbTqTCM0Y3W6SPeJ1HLHcUM1mgcUEMJTSGjtVZtj+s6rV2/rgdFF9xHaixF
 y0qkiNR9qO32KxeAXRy3P0e2XxoNblMl7pmyTgd9Z34spxXIpAjWB0nunzo2zi28n3aX
 K34Sfgqs3Nghrz3BS0/DkMiS9G2fKVajVvUcuo0XCq/OqzW9yyVJ65MgaXEzG7kXxJh4
 D4yM78Qvf7HjgggtUvt83MaT7A9dBhnPt8WNsK/a0/e/1RRBt39FB9vcUlJtkNamcr7E
 w9+A==
X-Gm-Message-State: AOJu0YxW+dZkS71NhqebiT4psYUjeKuGyFIc9fsH420bMTNedezFqXxy
 vZXmjUizspJguaUR7MjAAmAlI5CrykTQLdJ2iMYCyiRmMLOFvQazAAFknIUfjuKOgKSwrpJdNup
 nUKC6Fre4O22gyPNGRMRAp3oorxv02JPzur7FWMvlEA8g3ZoR06q1
X-Received: by 2002:a9d:6e95:0:b0:6e2:dde8:890a with SMTP id
 a21-20020a9d6e95000000b006e2dde8890amr7405435otr.14.1707820691759; 
 Tue, 13 Feb 2024 02:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD2u5c1lBRBMofS5t6q6nS8cjFBAdi503Hrg5Dwh/HquQ5GyaSx9tWg5oh+g5hXP3o2GhJwg==
X-Received: by 2002:a9d:6e95:0:b0:6e2:dde8:890a with SMTP id
 a21-20020a9d6e95000000b006e2dde8890amr7405416otr.14.1707820691530; 
 Tue, 13 Feb 2024 02:38:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWzifjVKAEhxqC2yLfj5G0+BySeqjThnJ7v42rsgD756rbgWUQjA/rZReR7y9lLd8KAOe70CvoGmFn9xt3VurZbuuH1OdAeVGE61ceoyfD/NbvORtnbQ3+rcbTj8yCH8mFDH3hPFqK/hYxz7GfpKrdTjXJMrDUE5Blyv6UhMg22lc3iZKGhHVE4uFD68UHf7y1gDmdqgN4GC9VmqKEKe/Z9p1zr26sxP7xMTnnjOM/G1MGD4wnkTsVsUv1ZOiLnZDRnzzJVMWgIwJt3LmbH31lOwTgpwRhHoisZUtvj7JCWgix1yMz5PBYfaxi7MqpSsCRV9CYjhoTHlIDNjdHREg==
Received: from ?IPV6:2a01:e0a:59e:9d80:4685:ff:fe66:ea36?
 ([2a01:e0a:59e:9d80:4685:ff:fe66:ea36])
 by smtp.gmail.com with ESMTPSA id
 om13-20020a0562143d8d00b0068cd7247806sm1140935qvb.121.2024.02.13.02.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 02:38:11 -0800 (PST)
Message-ID: <63c2eb75-6379-4c84-8b83-24392bcf3e35@redhat.com>
Date: Tue, 13 Feb 2024 11:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 zhenzhong.duan@intel.com, yanghliu@redhat.com, alex.williamson@redhat.com,
 jasowang@redhat.com
References: <20240208101128.655167-1-eric.auger@redhat.com>
 <20240213053502-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240213053502-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Michael,
On 2/13/24 11:35, Michael S. Tsirkin wrote:
> On Thu, Feb 08, 2024 at 11:10:16AM +0100, Eric Auger wrote:
>> In [1] and [2] we attempted to fix a case where a VFIO-PCI device
>> protected with a virtio-iommu is assigned to an x86 guest. On x86
>> the physical IOMMU may have an address width (gaw) of 39 or 48 bits
>> whereas the virtio-iommu exposes a 64b input address space by default.
>> Hence the guest may try to use the full 64b space and DMA MAP
>> failures may be encountered. To work around this issue we endeavoured
>> to pass usable host IOVA regions (excluding the out of range space) from
>> VFIO to the virtio-iommu device so that the virtio-iommu driver can
>> query those latter during the probe request and let the guest iommu
>> kernel subsystem carve them out. 
>>
>> However if there are several devices in the same iommu group,
>> only the reserved regions of the first one are taken into
>> account by the iommu subsystem of the guest. This generally
>> works on baremetal because devices are not going to
>> expose different reserved regions. However in our case, this
>> may prevent from taking into account the host iommu geometry.
>>
>> So the simplest solution to this problem looks to introduce an
>> input address width option, aw-bits, which matches what is
>> done on the intel-iommu. By default, from now on it is set
>> to 39 bits with pc_q35 and 48 with arm virt. This replaces the
>> previous default value of 64b. So we need to introduce a compat
>> for machines older than 9.0 to behave similarly. We use
>> hw_compat_8_2 to acheive that goal.
>>
>> Outstanding series [2] remains useful to let resv regions beeing
>> communicated on time before the probe request.
>>
>> [1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
>>     https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/
>>     - This is merged -
>>
>> [2] [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged devices
>>     https://lore.kernel.org/all/20240117080414.316890-1-eric.auger@redhat.com/
>>     - This is pending for review on the ML -
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v3
>> previous
>> https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v2
>>
>> Applied on top of [3]
>> [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default page_size_mask
>> https://lore.kernel.org/all/20240117132039.332273-1-eric.auger@redhat.com/
> So, I applied this without that patch until we agree whether there are
> compat issues in that one. Seems to work without or did I miss anything?
To me it works without compat by checking the input stream version and
if <= 3 apply the previous default.

maybe I miss something but I tested mig between v2 and v3 and that worked

Eric
>
>
>> History:
>> v2 -> v3:
>> - Collected Zhenzhong and Cédric's R-b + Yanghang's T-b
>> - use &error_abort instead of NULL error handle
>>   on object_property_get_uint() call (Cédric)
>> - use VTD_HOST_AW_39BIT (Cédric)
>>
>> v1 -> v2
>> - Limit aw to 48b on ARM
>> - Check aw is within [32,64]
>> - Use hw_compat_8_2
>>
>>
>> Eric Auger (3):
>>   virtio-iommu: Add an option to define the input range width
>>   virtio-iommu: Trace domain range limits as unsigned int
>>   hw: Set virtio-iommu aw-bits default value on pc_q35 and arm virt
>>
>>  include/hw/virtio/virtio-iommu.h | 1 +
>>  hw/arm/virt.c                    | 6 ++++++
>>  hw/core/machine.c                | 5 ++++-
>>  hw/i386/pc.c                     | 6 ++++++
>>  hw/virtio/virtio-iommu.c         | 7 ++++++-
>>  hw/virtio/trace-events           | 2 +-
>>  6 files changed, 24 insertions(+), 3 deletions(-)
>>
>> -- 
>> 2.41.0


