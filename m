Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2271AC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZuv6-0005l1-1F; Tue, 13 Feb 2024 10:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZuv3-0005kI-NV
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZuv2-0003ko-33
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707838919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQMBVf6ot6L5yvYqDah4DqdCtJLRoOoiC0tHLvg2ukM=;
 b=dbrca7K6VaKECT9G15KTBfc00CPlOIhkWBcFKF0CwHD+g62HfBYtsrZ4Odxyxvsv+f5LSr
 X2F75DldjOr9RGpTOQI+DIMeQTFjE8Q0Mk1Mo6iecrIlI62dThTTiTqIhYEn8OZIXRXttS
 zkU7F51aSjGg51fE61bbjg861DxmprY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-fiRLdKZ1P9Cu-1mnBGLBtA-1; Tue, 13 Feb 2024 10:41:57 -0500
X-MC-Unique: fiRLdKZ1P9Cu-1mnBGLBtA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4114d21fca5so9121735e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707838914; x=1708443714;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kQMBVf6ot6L5yvYqDah4DqdCtJLRoOoiC0tHLvg2ukM=;
 b=dWZj58y8zHGw9gY2R/wkNWIibdbJNzFt6m4SfKeyDlYOwGH9FRzW26LX747mRM1kQ6
 d2mz5C3LTj/9xBto3WdiYxvqJ3bPSa83YRx8xl+EgjVUkau2Vu7axghGhIZJl3XNdL5r
 EFCLtt9IT4tClpMpLvt4um8NtWPsRzCa1uPsvINwgE2hNeOsDhuxgM8D9K86wCLBncRK
 WWuoXk5H5sN3Ho65Bct77czBMeinr3r/s9Uez7i7PfOmewjdvO/VEgvL2PlKB0q+oSfm
 86SSPRSF5isMA/91xQpOLU6+XdBdQAJ+rpBWd4O3iV0mhlRDAkFObBOBTieKE8le8/lR
 6oCw==
X-Gm-Message-State: AOJu0YzmrkE/Ujbq2dvOLhgMeZ19+9nE18FN02Ry9gWPF06527kB7FrJ
 p3Gwy9kOPCZGmfMCgpsxGibUOh8un1v8MaIV/tvzzDTxCUPeqLqa2GH2RyCzACGHER0BhnIZexE
 S1lvmNtgNaOxIYOmUiMOEb7ORZJSHTAklmL6kROOcPpaof13t+kHe
X-Received: by 2002:a5d:424c:0:b0:33b:2633:b527 with SMTP id
 s12-20020a5d424c000000b0033b2633b527mr6018915wrr.20.1707838914627; 
 Tue, 13 Feb 2024 07:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoOgXCFBNBZBorV0TcRKdZvR9d4AB+x+nFObEum0mzJ3k8OUhZjUSZPYSiHIRByk0d21ZjGQ==
X-Received: by 2002:a5d:424c:0:b0:33b:2633:b527 with SMTP id
 s12-20020a5d424c000000b0033b2633b527mr6018896wrr.20.1707838914214; 
 Tue, 13 Feb 2024 07:41:54 -0800 (PST)
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 l30-20020a05600c1d1e00b00410c44a39bfsm1055068wms.1.2024.02.13.07.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:41:53 -0800 (PST)
Date: Tue, 13 Feb 2024 10:41:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 zhenzhong.duan@intel.com, yanghliu@redhat.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v3 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Message-ID: <20240213104100-mutt-send-email-mst@kernel.org>
References: <20240208101128.655167-1-eric.auger@redhat.com>
 <20240213053502-mutt-send-email-mst@kernel.org>
 <63c2eb75-6379-4c84-8b83-24392bcf3e35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63c2eb75-6379-4c84-8b83-24392bcf3e35@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 13, 2024 at 11:38:06AM +0100, Eric Auger wrote:
> Hi Michael,
> On 2/13/24 11:35, Michael S. Tsirkin wrote:
> > On Thu, Feb 08, 2024 at 11:10:16AM +0100, Eric Auger wrote:
> >> In [1] and [2] we attempted to fix a case where a VFIO-PCI device
> >> protected with a virtio-iommu is assigned to an x86 guest. On x86
> >> the physical IOMMU may have an address width (gaw) of 39 or 48 bits
> >> whereas the virtio-iommu exposes a 64b input address space by default.
> >> Hence the guest may try to use the full 64b space and DMA MAP
> >> failures may be encountered. To work around this issue we endeavoured
> >> to pass usable host IOVA regions (excluding the out of range space) from
> >> VFIO to the virtio-iommu device so that the virtio-iommu driver can
> >> query those latter during the probe request and let the guest iommu
> >> kernel subsystem carve them out. 
> >>
> >> However if there are several devices in the same iommu group,
> >> only the reserved regions of the first one are taken into
> >> account by the iommu subsystem of the guest. This generally
> >> works on baremetal because devices are not going to
> >> expose different reserved regions. However in our case, this
> >> may prevent from taking into account the host iommu geometry.
> >>
> >> So the simplest solution to this problem looks to introduce an
> >> input address width option, aw-bits, which matches what is
> >> done on the intel-iommu. By default, from now on it is set
> >> to 39 bits with pc_q35 and 48 with arm virt. This replaces the
> >> previous default value of 64b. So we need to introduce a compat
> >> for machines older than 9.0 to behave similarly. We use
> >> hw_compat_8_2 to acheive that goal.
> >>
> >> Outstanding series [2] remains useful to let resv regions beeing
> >> communicated on time before the probe request.
> >>
> >> [1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
> >>     https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/
> >>     - This is merged -
> >>
> >> [2] [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged devices
> >>     https://lore.kernel.org/all/20240117080414.316890-1-eric.auger@redhat.com/
> >>     - This is pending for review on the ML -
> >>
> >> This series can be found at:
> >> https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v3
> >> previous
> >> https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v2
> >>
> >> Applied on top of [3]
> >> [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default page_size_mask
> >> https://lore.kernel.org/all/20240117132039.332273-1-eric.auger@redhat.com/
> > So, I applied this without that patch until we agree whether there are
> > compat issues in that one. Seems to work without or did I miss anything?
> To me it works without compat by checking the input stream version and
> if <= 3 apply the previous default.
> 
> maybe I miss something but I tested mig between v2 and v3 and that worked
> 
> Eric


Can you rebase without that other change?
ATM it fails make check for me:

▶  44/462 ERROR:../tests/qtest/virtio-iommu-test.c:37:pci_config: assertion failed (input_range_end == UINT64_MAX): (0x7fffffffff == 0xffffffffffffffff) ERROR         


https://gitlab.com/mstredhat/qemu/-/jobs/6162397307



> >
> >
> >> History:
> >> v2 -> v3:
> >> - Collected Zhenzhong and Cédric's R-b + Yanghang's T-b
> >> - use &error_abort instead of NULL error handle
> >>   on object_property_get_uint() call (Cédric)
> >> - use VTD_HOST_AW_39BIT (Cédric)
> >>
> >> v1 -> v2
> >> - Limit aw to 48b on ARM
> >> - Check aw is within [32,64]
> >> - Use hw_compat_8_2
> >>
> >>
> >> Eric Auger (3):
> >>   virtio-iommu: Add an option to define the input range width
> >>   virtio-iommu: Trace domain range limits as unsigned int
> >>   hw: Set virtio-iommu aw-bits default value on pc_q35 and arm virt
> >>
> >>  include/hw/virtio/virtio-iommu.h | 1 +
> >>  hw/arm/virt.c                    | 6 ++++++
> >>  hw/core/machine.c                | 5 ++++-
> >>  hw/i386/pc.c                     | 6 ++++++
> >>  hw/virtio/virtio-iommu.c         | 7 ++++++-
> >>  hw/virtio/trace-events           | 2 +-
> >>  6 files changed, 24 insertions(+), 3 deletions(-)
> >>
> >> -- 
> >> 2.41.0


