Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610BAC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZq8x-0002te-10; Tue, 13 Feb 2024 05:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZq8t-0002tB-Mh
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:35:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZq8r-0001iO-7h
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707820556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFjrhB1ldpJXgTU5OlqMUbOLWfQyxcNHDpBMUn/46ws=;
 b=YDcby66NEYGhEfunLXN2vJDjswVDx2LNLp467AAL3yfzPdlojZXIIa6MSy6m9ytOj5Qrqt
 BIhPOmjxYJ4i/W+xanpkdhYNeNhBiUMPip7n0mFjM8CeBvBe0M8bstAwtRRw9Z78Kfxl57
 Ld6KGJq99F0kD64XRNFNGr7ehSlS7MY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-LKg_x0g8Mq-RQ6HPLqdsFA-1; Tue, 13 Feb 2024 05:35:53 -0500
X-MC-Unique: LKg_x0g8Mq-RQ6HPLqdsFA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3a3cb0ed1aso177227766b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707820552; x=1708425352;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFjrhB1ldpJXgTU5OlqMUbOLWfQyxcNHDpBMUn/46ws=;
 b=Iwt3Aztg7COhig00pSx+C7HB8QocEZZkUOZ2mWOIccLfp1eYOAJihjWPltT7xXucgf
 SlwCVlPGdyJeC0SNd/P3AFQFvBzmKrs0E6EJm2pjUjrg6bRtf/QKIrgIavkrY7XuYr7q
 veL4/3gVOeE/9gn3HpTEpL6hf5NWAfGZSBSU1NfOzjSJqvLi4V2U+iE0sOrPyGZKNxO6
 jd/LxVkB9aRiy/9XqMxCHAQWhaMUoBkssk3VqNgJ5HsJDX2Udbup7G9xr6M2Fp6Bm6aw
 61EZQcppMhcPa7Q9YNNyMaiXiajzT2Zyia1gACfpxVF5xJJWHtymwKBnS+E7RfvOp8K2
 eejw==
X-Gm-Message-State: AOJu0YxbbqPHLYpqnwHqHSDdg/zMH5YQyGYpVgQO5Ep9jDDEu9st5rWt
 wAvX3Qn1If842UqgKXASJr4OcVKMsXL+8pgWo63C8oCvu9Vpj9an7y02kyfPs5lgiFRkbKB+0KH
 S2BGe4pwU7kRqU5hhctah+CXwWhI8ifmPP8G0laRuki+SbbaPtXMR
X-Received: by 2002:a17:906:6845:b0:a3c:91aa:6a6d with SMTP id
 a5-20020a170906684500b00a3c91aa6a6dmr4525476ejs.25.1707820551925; 
 Tue, 13 Feb 2024 02:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGanGJBwetyTUFVHEz+e9IhcedykuE8vYfIau+2mljZ4cgRu1EGXPaJDT4TloNQjDz4hk10EA==
X-Received: by 2002:a17:906:6845:b0:a3c:91aa:6a6d with SMTP id
 a5-20020a170906684500b00a3c91aa6a6dmr4525444ejs.25.1707820551055; 
 Tue, 13 Feb 2024 02:35:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVvBvywEm7K5jLDZ8be5qTgWamq5hMlGlVQC4QTQbl3Z7ORtV/4+5aogBV5C5g6Dk9xEDMfPJAp3/HGnCk5WzSKuLmx96j8/X1AkGfNQKP9rB4Yp/ZZkO/dQaP41NVeX1oZA1AksROAfPelhnfVt8DCAaQcKlPmCDZLr4lgybuHJkG6gYrM8aJUyOTsKv6GBuNm3mpOL0+km1HVdbrtlqc3nK0RcEQgyagEly3PtZLgGnybSQ2+VnanZH4Lpztxo2HdQpFGvwgCzMJOxb7eTYWCzwjeFPYhigpqakFiEs0NXcxNpuYcrUTEI2pWqiKOGWGR0RpveVFAxed29+2+8A==
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 a22-20020a170906191600b00a3ca40f5045sm1148691eje.72.2024.02.13.02.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:35:50 -0800 (PST)
Date: Tue, 13 Feb 2024 05:35:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 zhenzhong.duan@intel.com, yanghliu@redhat.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v3 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Message-ID: <20240213053502-mutt-send-email-mst@kernel.org>
References: <20240208101128.655167-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208101128.655167-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 08, 2024 at 11:10:16AM +0100, Eric Auger wrote:
> In [1] and [2] we attempted to fix a case where a VFIO-PCI device
> protected with a virtio-iommu is assigned to an x86 guest. On x86
> the physical IOMMU may have an address width (gaw) of 39 or 48 bits
> whereas the virtio-iommu exposes a 64b input address space by default.
> Hence the guest may try to use the full 64b space and DMA MAP
> failures may be encountered. To work around this issue we endeavoured
> to pass usable host IOVA regions (excluding the out of range space) from
> VFIO to the virtio-iommu device so that the virtio-iommu driver can
> query those latter during the probe request and let the guest iommu
> kernel subsystem carve them out. 
> 
> However if there are several devices in the same iommu group,
> only the reserved regions of the first one are taken into
> account by the iommu subsystem of the guest. This generally
> works on baremetal because devices are not going to
> expose different reserved regions. However in our case, this
> may prevent from taking into account the host iommu geometry.
> 
> So the simplest solution to this problem looks to introduce an
> input address width option, aw-bits, which matches what is
> done on the intel-iommu. By default, from now on it is set
> to 39 bits with pc_q35 and 48 with arm virt. This replaces the
> previous default value of 64b. So we need to introduce a compat
> for machines older than 9.0 to behave similarly. We use
> hw_compat_8_2 to acheive that goal.
> 
> Outstanding series [2] remains useful to let resv regions beeing
> communicated on time before the probe request.
> 
> [1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
>     https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/
>     - This is merged -
> 
> [2] [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged devices
>     https://lore.kernel.org/all/20240117080414.316890-1-eric.auger@redhat.com/
>     - This is pending for review on the ML -
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v3
> previous
> https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v2
> 
> Applied on top of [3]
> [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default page_size_mask
> https://lore.kernel.org/all/20240117132039.332273-1-eric.auger@redhat.com/

So, I applied this without that patch until we agree whether there are
compat issues in that one. Seems to work without or did I miss anything?


> History:
> v2 -> v3:
> - Collected Zhenzhong and Cédric's R-b + Yanghang's T-b
> - use &error_abort instead of NULL error handle
>   on object_property_get_uint() call (Cédric)
> - use VTD_HOST_AW_39BIT (Cédric)
> 
> v1 -> v2
> - Limit aw to 48b on ARM
> - Check aw is within [32,64]
> - Use hw_compat_8_2
> 
> 
> Eric Auger (3):
>   virtio-iommu: Add an option to define the input range width
>   virtio-iommu: Trace domain range limits as unsigned int
>   hw: Set virtio-iommu aw-bits default value on pc_q35 and arm virt
> 
>  include/hw/virtio/virtio-iommu.h | 1 +
>  hw/arm/virt.c                    | 6 ++++++
>  hw/core/machine.c                | 5 ++++-
>  hw/i386/pc.c                     | 6 ++++++
>  hw/virtio/virtio-iommu.c         | 7 ++++++-
>  hw/virtio/trace-events           | 2 +-
>  6 files changed, 24 insertions(+), 3 deletions(-)
> 
> -- 
> 2.41.0


