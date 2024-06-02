Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288EFC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 14:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDlv2-0001AQ-5i; Sun, 02 Jun 2024 10:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlv0-00019p-5a
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 10:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlux-0004hZ-Qr
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 10:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717337438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4m7KZ7ijFCzK+r3/bd7UTxW3HH4hYn4RHCVBdyXLZM=;
 b=cJp1USw50jFvROSdxYE0lrvyvpphGr/7lkIMkUWkDgkQG5/ZtZCPi4EoGwcxl0FL/oUNo9
 Vb0DlPg1ZcKf8yea7dyVCmLg4T6ZAyD5LNs+o+kGNtXOxAbTm7MgtyWfpu43XXaIxpOwkt
 xvKyKATQjM3qjM9jdZ1nuOQyF8RVDzs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-cjEtpNLcM7Gu88nqKPCY_g-1; Sun, 02 Jun 2024 10:10:36 -0400
X-MC-Unique: cjEtpNLcM7Gu88nqKPCY_g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dcd645095so1847937f8f.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 07:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717337435; x=1717942235;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N4m7KZ7ijFCzK+r3/bd7UTxW3HH4hYn4RHCVBdyXLZM=;
 b=N4FeuyHS5mGImXNQ1WcYp+NfmjVImJH6lp+I/bzZ9xv4CBd6a5ItSSbMunztPnRR2V
 E2IK4Lwr6kROe5qM067Due0M1u8ThwGcl2fkMdC3OFnCmzevdQtzonPxImPL7Q3tl3Wx
 G8EstmUQGAY260I9cAbdiGb0lNSRXV6jowS1P1bZQuZZ1p8+CBp7mZW4K/NL63Z/g01w
 mq4iVDNencgsMqj+Mdgg4r5UJk7IvIokoeKdg8cQveSNnwRRce3JwueTS5s1xblzFOmY
 FBe9ZHJVbA3PLKKZyfgPj15AAW6rmmgh+dH2B9Q2Xi+3AbBQiA6Y9ieI2NHkvDtXsm+L
 xGqw==
X-Gm-Message-State: AOJu0YzV4uNNfSeB9+xZF2i/LEVDb3I0hqSFCzwYRSJPjQpX9gST0H72
 mqthBj4DFrAfKZ5wbNmt/EUXGVgdA3ckba8sz4u0cVnhcRTuVhJw4j/P/zwoFHIdRvp6GaKzDC4
 gTWUTa7ykcZ8B3JaiKonCTohrbWTTLNyDuVhUs9qETcpcbmVWi+e0
X-Received: by 2002:a5d:4bc3:0:b0:354:f622:fc5b with SMTP id
 ffacd0b85a97d-35e0f2712b8mr4541294f8f.23.1717337435575; 
 Sun, 02 Jun 2024 07:10:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWmJK3IK4lbp0A62SqbFYHMaQPwWxDAAkA5YDn3B9U0vW+029+f9jKGdGkFyu6VVzMeqal/w==
X-Received: by 2002:a5d:4bc3:0:b0:354:f622:fc5b with SMTP id
 ffacd0b85a97d-35e0f2712b8mr4541277f8f.23.1717337434993; 
 Sun, 02 Jun 2024 07:10:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04ca9bbsm6343354f8f.31.2024.06.02.07.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 07:10:34 -0700 (PDT)
Date: Sun, 2 Jun 2024 10:10:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH intel_iommu 0/7] FLTS for VT-d
Message-ID: <20240602100955-mutt-send-email-mst@kernel.org>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 22, 2024 at 03:52:52PM +0000, CLEMENT MATHIEU--DRIF wrote:
> This series is the first of a list that add support for SVM in the Intel IOMMU.
> 
> Here, we implement support for first-stage translation in VT-d.
> The PASID-based IOTLB invalidation is also added in this series as it is a
> requirement of FLTS.
> 
> The last patch introduces the 'flts' option to enable the feature from
> the command line.
> Once enabled, several drivers of the Linux kernel use this feature.
> 
> This work is based on the VT-d specification version 4.1 (March 2023)
> 
> Here is a link to a GitHub repository where you can find the following elements :
>     - Qemu with all the patches for SVM
>         - ATS
>         - PRI
>         - PASID based IOTLB invalidation
>         - Device IOTLB invalidations
>         - First-stage translations
>         - Requests with already translated addresses
>     - A demo device
>     - A simple driver for the demo device
>     - A userspace program (for testing and demonstration purposes)
> 
> https://github.com/BullSequana/Qemu-in-guest-SVM-demo

Pls post v2 addressing minor comments so far.


> Clément Mathieu--Drif (7):
>   intel_iommu: fix FRCD construction macro.
>   intel_iommu: rename slpte to pte before adding FLTS
>   intel_iommu: make types match
>   intel_iommu: add support for first-stage translation
>   intel_iommu: extract device IOTLB invalidation logic
>   intel_iommu: add PASID-based IOTLB invalidation
>   intel_iommu: add a CLI option to enable FLTS
> 
>  hw/i386/intel_iommu.c          | 655 ++++++++++++++++++++++++++-------
>  hw/i386/intel_iommu_internal.h | 114 ++++--
>  include/hw/i386/intel_iommu.h  |   3 +-
>  3 files changed, 609 insertions(+), 163 deletions(-)
> 
> -- 
> 2.44.0


