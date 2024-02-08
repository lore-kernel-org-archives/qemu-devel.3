Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52005C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 14:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY5cL-0007hK-8i; Thu, 08 Feb 2024 09:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rY5cK-0007gc-5j
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:43:08 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rY5cI-0001qr-9k
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:43:07 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so1328863f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707403384; x=1708008184; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y1S4UelR9CNPx0frZBsgWPnXiIkVW38h5UY4dbA5Chc=;
 b=FdFJcPrU1frbjz80DHuFGeGXgUJRSOV1WvEqPUtrgPL7OYxPCh9c7RWl1fcKIWdxZE
 QkLU3A1c6HW6ohLyh3t/PWxBDzwAXmRwaEr6rZn40mRWS8s1fNo3Cnn9vyLctDstCDyQ
 qkWlnusNE0yHWBx5b48DuqCNsQ9KQn4S6rt2xSa38IOAeKXtY1VvdJUZcAimJ1xlD1ap
 TnEi0ahVZzwfXZDXMa3YzOF8xjOrPUL0SuiEeMvnJzlfdQhFhM3ZunZPV2nD5E1uYaNw
 QVBWIw/tbb3AqH7YaT31Yu66j2TUvbKzvviSQJsy8hb7BmR/AKE5Izv2yTEwQGTcIAhm
 yI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707403384; x=1708008184;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y1S4UelR9CNPx0frZBsgWPnXiIkVW38h5UY4dbA5Chc=;
 b=t+vHXA1DCTSCce/2h5FVw53LsL7l2vaxxpMhdS6M8oB/6SLmP1u4BbBxz32d9LB9qi
 e0tpB/vOpVGCQmHObEaH/WL5aNYoEwEAKZ3wmNjsnatBTlBoUu1VG+Qho8JpAk5XGMex
 L1BtvSZAoyAXpRUWiOSHfWGyNsZpLF8FQXTDJLKJJ1ZMjFBR3Agj/E7DSBudVZGejq4C
 4x+MB2H3DR9fucqV1919EBoouxBDnUMaMmLB9MDTxTFkK49PcYVI89QBxeaTutVjjcF5
 l1ViSeNWTVPzvNWPt/UjStF0HOIuKfZJpAz3xf4jSLoJ/pRLsBGCxaqmiJ1jHeDVTAMG
 WQVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEYM09IQGB2ixGchWUeJLW67Dr9BTzHGi6x6qOWJkdi4/qigVhp9xxBLmlRzWa0gOr3cKAQVzoOzgGqrqSJmk4R9nUszM=
X-Gm-Message-State: AOJu0Yw+c2Jg8nJyGPDmeiffhX0IJhOuo33wc3fQ1uQ5WNOWY8DUpVOs
 UR4dgPx+dyoI69c0n1Ogt+oxC5stO+6OGEQrc61IHSqNiDNJcr1jmUGl/FMJnA8=
X-Google-Smtp-Source: AGHT+IE0XEVrBKvt9CRj0tZP34lu1e13Zgt7vP7Lc26uYT2lf2aKbtUYuyWboaWELNgMsAMVkCehJQ==
X-Received: by 2002:a5d:498a:0:b0:33b:24b3:83d1 with SMTP id
 r10-20020a5d498a000000b0033b24b383d1mr7243822wrq.27.1707403384582; 
 Thu, 08 Feb 2024 06:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWPa5KaQbqKb80SgJeKxEYDaZsVh69t7UIE1OE2+FyfFC8Eot8Ug9IBIML0zPGQ//FU6Ww2F/LxqsKcsssIHbOifazMrMpbqHB166x4Wz3pJxn7lkggSrts6p8/I1I4RTvrQwX5MGzxwvjjEAgpQTp5ywt4vbz3nhEGo4f+zqAOCl01xEGvwv98bNlKDVxAAizZwk3Gf729PoIaGvqSHB+RjnlS27A/3jzaDEHWxXamfeE7R51dyfSBFD4H1K5lT2HH6iItPc1CdqHvdLO1IbfaEAXbH587uynsNFLl1NVdcG8QaZnl7tnFy0tHYMtqSyC1wTkQ
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 c13-20020a056000184d00b0033b07f428b6sm3777501wri.0.2024.02.08.06.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 06:43:04 -0800 (PST)
Date: Thu, 8 Feb 2024 14:42:57 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, peter.maydell@linaro.org, clg@redhat.com,
 zhenzhong.duan@intel.com, yanghliu@redhat.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v3 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Message-ID: <20240208144257.GA2863476@myrica>
References: <20240208101128.655167-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208101128.655167-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

For the series:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

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
> 
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
> 

