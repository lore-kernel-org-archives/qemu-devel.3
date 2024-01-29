Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0B8C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 12:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUQfq-0002o7-3f; Mon, 29 Jan 2024 07:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rUQfm-0002nG-RZ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:23:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rUQfk-00065u-LR
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:23:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3394b892691so1430570f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 04:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706531010; x=1707135810; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Wg2tLs+wwWFAO0PWwUWdRnW42bI9re2kMkNBGePrvU=;
 b=KUBxLN88xv4WCuVgJxVKqu2jcLgKS57RWTCoz0i5ScXpWLfYn8WTYxoEHm6+j0rfpl
 t53Asy83R9VCb/buQCOXt+SA9zmi0UpkjzB5XCC8krm5Sav15jLoFGk30vOuJ0EvbE+A
 h3AeegM/tx/mdSMFOqkKSObRAJN2xR+ADo31UWHSsealOA47TJjiRN+WAfaR8jN8yuyG
 3JLh+2a8x3trXsiDHpxlmV73Se17o4mIRQ5t0EGjA7GiNGKSdG2q4hkm2Rwr2i2rKrH1
 0+IsgleqjTFF4Dls312xqz45UbUQ4/1+jdUdphBpYpnQdz7VK4TdnwFmEwvn42HE72hj
 Ey7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706531010; x=1707135810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Wg2tLs+wwWFAO0PWwUWdRnW42bI9re2kMkNBGePrvU=;
 b=pnWW6/a0J/AOLFoE9sIYBqB1exKSaAXz+ap0fJ7nEMsLi7dJcmybTSOt6KB2LQYR4x
 OYT1FjAbdGEWTU/l5qBPrjUJwda4HRrnKmVeEqgk16vt5r9gzIJyKNyffdQG5EwJgszA
 xVOm/LrdTP42qcgiEQRJU3PP72ZdL6VKp7SVBDN1lDz73PsXbKSsyhxeBHm5zu+OftCs
 I7sL9ofzQC+wus2dUcRntaHfKX5NgdZJRnCSjVCbqMrP+6YnaBInCujOv97Mv2hTbSTM
 0fMba7ZPbEGbZubJpuWEQo413guF8k7x5j01sVZzNIw+3VrlVsO6+bKlA6r6jaKosS6c
 s/og==
X-Gm-Message-State: AOJu0YxsDNHe92I8YTNZ47JYetmyHCcdeGbi303FNCiEbpfXENdnFydO
 Emq5UEtVbeLeC9fWb7kmfA84srzWw+rauMI6KpzkOFdDwlnzn2kb2PphVw0hZy4=
X-Google-Smtp-Source: AGHT+IGUDdeZffWScz9RIFIugd0oai2U92zXZ9AVdd7cp8Y14yj0xjM0w+M7WafNI9QcgACyMpYDlA==
X-Received: by 2002:a05:6000:1561:b0:33a:edc9:8e32 with SMTP id
 1-20020a056000156100b0033aedc98e32mr2193420wrz.26.1706531010564; 
 Mon, 29 Jan 2024 04:23:30 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ce6-20020a5d5e06000000b0033af3a43e91sm1271833wrb.46.2024.01.29.04.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 04:23:30 -0800 (PST)
Date: Mon, 29 Jan 2024 12:23:32 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, peterx@redhat.com, yanghliu@redhat.com,
 mst@redhat.com, clg@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Message-ID: <20240129122332.GA909471@myrica>
References: <20240123181753.413961-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123181753.413961-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Eric,

On Tue, Jan 23, 2024 at 07:15:54PM +0100, Eric Auger wrote:
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
> to 39 bits with pc_q35 and 64b with arm virt.

Doesn't Arm have the same problem?  The TTB0 page tables limit what can be
mapped to 48-bit, or 52-bit when SMMU_IDR5.VAX==1 and granule is 64kB.
A Linux host driver could configure smaller VA sizes:
* SMMUv2 limits the VA to SMMU_IDR2.UBS (upstream bus size) which
  can go as low as 32-bit (I'm assuming we don't care about 32-bit hosts).
* SMMUv3 currently limits the VA to CONFIG_ARM64_VA_BITS, which
  could be as low as 36 bits (but realistically 39, since 36 depends on
  16kB pages and CONFIG_EXPERT).

But 64-bit definitely can't work for VFIO, and I suppose isn't useful for
virtual devices, so maybe 39 is also a reasonable default on Arm.

Thanks,
Jean

> This replaces the
> previous default value of 64b. So we need to introduce a compat
> for pc_q35 machines older than 9.0 to behave similarly.

