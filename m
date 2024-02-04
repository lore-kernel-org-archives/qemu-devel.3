Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F2DC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 08:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWXpw-0005Wy-9H; Sun, 04 Feb 2024 03:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1rWXpu-0005WW-An
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 03:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1rWXpf-0001KC-46
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 03:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707035189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiCW7noQ4mWsxLf3VXie+aglCYUebh7ZqwivJ/jyoUw=;
 b=WKPck/lL1az5LTKRaU/n/wHymnifnG2H/Qf2XmRwMFgoAek2SDMVV0aOWYhZo9cmEoWwoG
 RBG3FyfpeqGN0D7++IFR6aXSyMucOllZqDAjaaoyiToTbrEHYP3wx2JG4LIcJ66oa0lfxe
 yIFXnB7iQlG3Ml17VkbF3BA/mqc/IEA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-TJA2c0QKO5SodMti9wb6Dw-1; Sun, 04 Feb 2024 03:26:27 -0500
X-MC-Unique: TJA2c0QKO5SodMti9wb6Dw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5f6c12872fbso58927557b3.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 00:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707035187; x=1707639987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AiCW7noQ4mWsxLf3VXie+aglCYUebh7ZqwivJ/jyoUw=;
 b=UOVPhzncHIap8Q3QWrTvVthd+MGTK+e9Kwo8eXDNk7zDUvzrr3gMbab/LW8kbbs+Xc
 N3rqXJlpok9OFnmXTzMqkIzUMhxDK7Z0Jzi94WuCENPAC3e7FUX1nkFnSC109X7CKyo7
 0XnPfaHMwK+Zmc01EKKFWl5DxqJ/y7lMt+Q9haCE/T/Bvcqjk8rW3SZFp3QT+5fQgt4O
 dmo7ajVGhDaZmZSDnqPr8Dq8ah9Pl9YofqHh9VYcJZlg+cjb986Pt7LHJFALEpYqw1Dc
 1LT2iaDqT4P43k8HT2bRncQXUjB+HB7QTadYpBvcDXW1BAcltH8UTklOn89R+K7lIfkm
 JAAw==
X-Gm-Message-State: AOJu0YzBC39XeTjJr6I/rGurb9q71Lh/Ckjz4E7FhiwWlXevhfpwB44J
 uUJpXEsBiskpeNRdGIZ5z/D00NxJQR7tAwoCjA0azOjvy6qW5PX5D0EReDL7mduak7JADS+XSGA
 iKkNJ3vmE92l+RC5xfEz5H7mFkqU7DWFNzEltsCxrS+xVjh0xBMQy16hrM+xroTh9PL4I1KtVbH
 sJ41LRjm/H4T+0pCiL1ZdlVTcKIjI=
X-Received: by 2002:a81:4f45:0:b0:5ff:488c:9a6a with SMTP id
 d66-20020a814f45000000b005ff488c9a6amr7505901ywb.17.1707035186910; 
 Sun, 04 Feb 2024 00:26:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhbSzuCHM7cAMrT+xDy+DvC50Sldbj0luqURbzqdPSZve4690oQxLfCDSnHK5cG3QXffxhjpQnVc2GioXG00s=
X-Received: by 2002:a81:4f45:0:b0:5ff:488c:9a6a with SMTP id
 d66-20020a814f45000000b005ff488c9a6amr7505894ywb.17.1707035186609; Sun, 04
 Feb 2024 00:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20240201163324.564525-1-eric.auger@redhat.com>
In-Reply-To: <20240201163324.564525-1-eric.auger@redhat.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Sun, 4 Feb 2024 16:26:15 +0800
Message-ID: <CAGYh1E8gHXcN3OxT84-xKXvweSAEnJf+OrMLnOUOgHvJJCm-rg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 jean-philippe@linaro.org, alex.williamson@redhat.com, 
 peter.maydell@linaro.org, zhenzhong.duan@intel.com, mst@redhat.com, 
 clg@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.137,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

There is no VFIO_MAP_DMA error when hotplug 2 E810 PFs into a VM which
has a virtio-iommu device.

In addition, 21 regression tests of Tier1 level were run and all got PASS.

Tested-by: Yanghang Liu<yanghliu@redhat.com>


On Fri, Feb 2, 2024 at 12:33=E2=80=AFAM Eric Auger <eric.auger@redhat.com> =
wrote:
>
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
>     https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat=
.com/
>     - This is merged -
>
> [2] [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hot=
plugged devices
>     https://lore.kernel.org/all/20240117080414.316890-1-eric.auger@redhat=
.com/
>     - This is pending for review on the ML -
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v2
>
> Applied on top of [3]
> [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default page_siz=
e_mask
> https://lore.kernel.org/all/20240117132039.332273-1-eric.auger@redhat.com=
/
>
> History:
> v1 -> v2
> - Limit aw to 48b on ARM
> - Check aw is within [32,64]
> - Use hw_compat_8_2
>
> Eric Auger (3):
>   virtio-iommu: Add an option to define the input range width
>   virtio-iommu: Trace domain range limits as unsigned int
>   hw: Set virtio-iommu aw-bits default value on pc_q35_9.0 and arm virt
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
>


