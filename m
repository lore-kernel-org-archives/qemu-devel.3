Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABA9C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 14:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSe2j-0004TK-Gi; Wed, 24 Jan 2024 09:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rSe2U-0004Kd-7m
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 09:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rSe2S-0001PG-Iq
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 09:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706105736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elOfKOGNedOe/JPT/oWJQXKuQpjws5ocJG2TnWB9sGs=;
 b=FjRn66EpXBk6a94NX6HCehNS0Z+B6+lNseS5JXCmc1cSgI5TCQFrwucVg9iND3ZKtzj+qo
 +4QAGLA1NmIIixRUWyEBZGXnqVKcK2D11XzVqj5XkA4z+82TaXHF1Ivanz4jHY5DxhVdRa
 57qKLU6g5ak467eglq6DEVMX7SilXcQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-I-YL5PTSMGuAMewIhvaRug-1; Wed, 24 Jan 2024 09:15:33 -0500
X-MC-Unique: I-YL5PTSMGuAMewIhvaRug-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7bf8868dfc7so417557339f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 06:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706105733; x=1706710533;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=elOfKOGNedOe/JPT/oWJQXKuQpjws5ocJG2TnWB9sGs=;
 b=ucRHvbyuIrC+pwKpk2rM0Bs+RI81+sZrN0GgdvnSm0idEy5f7Td5zlSTwvtzQtuhnJ
 N3WpHvAx+bi1gootn58s+Uo9XTWdzQMzNA+CIPWnl3Pc15RmueLLFU6j3zfk23H/RyKh
 zuOArHs3PrXJXBlWU1kq2136Cq87YLskIQmybQ2BU4a0ZV83WsCZBOyyfWZKmDwkN8xr
 s5MRlVXZB/sdEixqeO2qHgT38xjqzsSIi4wijqk5uv9CKgn7PVQ+F6AWZUnhlaZAkC5E
 dz2PnF7xGurduONp/n8pPDtdrEIt+XG8Mtum2Pq6iOSkrOkY08HtveNQj4691/XLMkLT
 H8ww==
X-Gm-Message-State: AOJu0Yz5UVr7M4VBaQlCduyRr1AQ+x5tgjFfDXuXupbQv4XWeO3+48AD
 IK5E578jS+RGiI1LhElfv5NV0gVak0EqmNWpJU26iG1wp0MN9xa35FJjugwXpcKWJfj9VsV5Ae9
 RrtEL+Gtj3WP6+qOQLXgl5sAlqB7GtnzQpRTxKP9/nktBIUTtFlAQ
X-Received: by 2002:a05:6e02:13e7:b0:361:a9c7:d5c3 with SMTP id
 w7-20020a056e0213e700b00361a9c7d5c3mr1387343ilj.31.1706105732770; 
 Wed, 24 Jan 2024 06:15:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJOaGucA+7rpymi/ZNvH+Kn3kBP+Cqs19FnSL0EhWpMxQz3rLcW0jMHB4+fZWaCHGxvMEmwQ==
X-Received: by 2002:a05:6e02:13e7:b0:361:a9c7:d5c3 with SMTP id
 w7-20020a056e0213e700b00361a9c7d5c3mr1387328ilj.31.1706105732483; 
 Wed, 24 Jan 2024 06:15:32 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 br5-20020a056e0223c500b0035fb30380bcsm1848590ilb.58.2024.01.24.06.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 06:15:32 -0800 (PST)
Date: Wed, 24 Jan 2024 07:15:31 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, peterx@redhat.com, yanghliu@redhat.com,
 mst@redhat.com, clg@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 1/3] virtio-iommu: Add an option to define the input
 range width
Message-ID: <20240124071531.44bd7164.alex.williamson@redhat.com>
In-Reply-To: <a92a2023-7448-4b74-bfd9-e412c6092270@redhat.com>
References: <20240123181753.413961-1-eric.auger@redhat.com>
 <20240123181753.413961-2-eric.auger@redhat.com>
 <20240123165141.7a79de34.alex.williamson@redhat.com>
 <a35c4fad-a981-4fbf-81d1-be5625a537b9@redhat.com>
 <20240124063700.67c8c32c.alex.williamson@redhat.com>
 <a92a2023-7448-4b74-bfd9-e412c6092270@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 24 Jan 2024 14:57:41 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 1/24/24 14:37, Alex Williamson wrote:
> > On Wed, 24 Jan 2024 14:14:19 +0100
> > Eric Auger <eric.auger@redhat.com> wrote:
> >  
> >> Hi Alex,
> >>
> >> On 1/24/24 00:51, Alex Williamson wrote:  
> >>> On Tue, 23 Jan 2024 19:15:55 +0100
> >>> Eric Auger <eric.auger@redhat.com> wrote:
> >>>    
> >>>> aw-bits is a new option that allows to set the bit width of
> >>>> the input address range. This value will be used as a default for
> >>>> the device config input_range.end. By default it is set to 64 bits
> >>>> which is the current value.
> >>>>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> ---
> >>>>  include/hw/virtio/virtio-iommu.h | 1 +
> >>>>  hw/virtio/virtio-iommu.c         | 4 +++-
> >>>>  2 files changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> >>>> index 781ebaea8f..5fbe4677c2 100644
> >>>> --- a/include/hw/virtio/virtio-iommu.h
> >>>> +++ b/include/hw/virtio/virtio-iommu.h
> >>>> @@ -66,6 +66,7 @@ struct VirtIOIOMMU {
> >>>>      bool boot_bypass;
> >>>>      Notifier machine_done;
> >>>>      bool granule_frozen;
> >>>> +    uint8_t aw_bits;
> >>>>  };
> >>>>  
> >>>>  #endif
> >>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> >>>> index ec2ba11d1d..e7f299e0c6 100644
> >>>> --- a/hw/virtio/virtio-iommu.c
> >>>> +++ b/hw/virtio/virtio-iommu.c
> >>>> @@ -1314,7 +1314,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> >>>>       */
> >>>>      s->config.bypass = s->boot_bypass;
> >>>>      s->config.page_size_mask = qemu_real_host_page_mask();
> >>>> -    s->config.input_range.end = UINT64_MAX;
> >>>> +    s->config.input_range.end =
> >>>> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;    
> >>> What happens when someone sets aw_bits = 1?  There are a whole bunch of
> >>> impractical values here ripe for annoying bug reports.  vtd_realize()
> >>> returns an Error for any values other than 39 or 48.  We might pick an
> >>> arbitrary lower bound (39?) or some other more creative solution here
> >>> to avoid those silly issues in our future.  Thanks,    
> >> You're right. I can check the input value. This needs to be dependent on
> >> the machine though but this should be feasable.
> >> Then I would allow 39 and 48 for q35 and 64 only on ARM.  
> > AFAIK AMD-Vi supports 64-bit address space.  Without querying the host
> > there's no way to place an accurate limit below 64-bit.  Thanks,  
> 
> Hum this means I would need to look at
> /sys/class/iommu/<iommu>/amd-iommu/ or /sys/class/iommu/dmar* to
> discriminate between AMD IOMMU and INTEL IOMMU physical IOMMU. Would
> that be acceptable?

I'm not necessarily suggesting that we look at the host, I'm mostly
just stating that enforcing 39/48 bits on non-ARM is incorrect for a
large portion of the non-ARM world too.  There might even be some
interesting use cases for a 32-bit IOVA space, so maybe just set
defaults tuned for compatibility and accept anything between 32- and
64-bits.  Thanks,

Alex

> >>>>      s->config.domain_range.end = UINT32_MAX;
> >>>>      s->config.probe_size = VIOMMU_PROBE_SIZE;
> >>>>  
> >>>> @@ -1525,6 +1526,7 @@ static Property virtio_iommu_properties[] = {
> >>>>      DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
> >>>>                       TYPE_PCI_BUS, PCIBus *),
> >>>>      DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
> >>>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
> >>>>      DEFINE_PROP_END_OF_LIST(),
> >>>>  };
> >>>>      
> 


