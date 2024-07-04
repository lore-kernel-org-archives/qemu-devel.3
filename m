Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B86C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFtW-0005zU-6t; Thu, 04 Jul 2024 02:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPFtQ-0005yR-HW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 02:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPFtN-0002Nw-3x
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 02:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720074265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbWAN/jWLPxSh31gcHe1aEGF01n6sh9YS0SIckHY8Rg=;
 b=dPVoviCCVaBDwXzrvEQNOhOBVuJ3q5IrvMqmWS/WM/syEY49H35+GGLQ4WjftwoeZsB6be
 w+WFxlAfL3oKWSA8p2xhlHAVrgJEdKA8LgpcshU2UwSV7eFDHSF/aiMTV07ki3cTFjLeOD
 wDxax1g+vIiW3LWbGdRTWIqFM+UM+yU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-rvfMOaouNy-Hmpi5fyk-mw-1; Thu, 04 Jul 2024 02:24:24 -0400
X-MC-Unique: rvfMOaouNy-Hmpi5fyk-mw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7244d1b086so23714366b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 23:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074263; x=1720679063;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NbWAN/jWLPxSh31gcHe1aEGF01n6sh9YS0SIckHY8Rg=;
 b=G4JhH/9oWfc5HaHmcw8QCisXDNQVQg30Zhqk3/82E3wK69DN3iLgKDOKIaCAXyFwIS
 a332jZrAockCbXgDo4dqiKnjAqbnZ6wCOnHnF9RY3DjLDxUvb63GKCQjqgGyipWsmZLt
 Ay1LAG8WqijRPjxt9G7ihYdLYd62x0LQcX+DbT77JIvEYc/GZ98KIB567KPpxqJO/fkn
 lod1F6urGota7mIyznp79QfGRE3syRiQ9Sx8BWhE/CCWyOkQWzY08iauJzofH9rk9ZNa
 vDc9oxmqw/xjmrIGXqDvniW5lczK7x90/Tpocf0D7/Yhl3GwnSOSVhGZewvNBrIRJvK1
 RPqg==
X-Gm-Message-State: AOJu0YxjqBj1SJTRL7cMQ66x/yT1vQktkb9AzXJisj5NhieYgaH25cP9
 2mbsxhi8FZbHsvKY9VN5zbqzJPWQ7pQqYsYqxryspXeaaQytmYCpwoX8Z1qAVmrIGUsvs4K7NJG
 9Vkj+GXi/scSzPHYA55/p07CUlqJ4EtFafZ2c5ouMLHVaFCv3jfZI
X-Received: by 2002:a17:906:c104:b0:a6f:38:6968 with SMTP id
 a640c23a62f3a-a77ba471103mr46613166b.32.1720074262805; 
 Wed, 03 Jul 2024 23:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYDQscumDq9gdmeIb41iysaDiaXm/iqg7vGhnR1eh0U1dR+br83EXMEcpNpdSqoNOeUW1/+A==
X-Received: by 2002:a17:906:c104:b0:a6f:38:6968 with SMTP id
 a640c23a62f3a-a77ba471103mr46610766b.32.1720074262232; 
 Wed, 03 Jul 2024 23:24:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08cfb6sm569958666b.159.2024.07.03.23.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 23:24:21 -0700 (PDT)
Date: Thu, 4 Jul 2024 02:24:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v1 0/8] PRI support for VT-d
Message-ID: <20240704022318-mutt-send-email-mst@kernel.org>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 12:24:58PM +0000, CLEMENT MATHIEU--DRIF wrote:
> This series belongs to a list of series that add SVM support for VT-d.
> 
> Here we focus on the implementation of PRI support in the IOMMU and on a PCI-level
> API for PRI to be used by virtual devices.
> 
> This work is based on the VT-d specification version 4.1 (March 2023).
> Here is a link to a GitHub repository where you can find the following elements :
>     - Qemu with all the patches for SVM
>         - ATS
>         - PRI
>         - Device IOTLB invalidations
>         - Requests with already translated addresses
>     - A demo device
>     - A simple driver for the demo device
>     - A userspace program (for testing and demonstration purposes)
> 
> https://github.com/BullSequana/Qemu-in-guest-SVM-demo


To make things clear, is this patchset independent or
does it have a dependency, too?


> Clément Mathieu--Drif (8):
>   pcie: add a helper to declare the PRI capability for a pcie device
>   pcie: helper functions to check to check if PRI is enabled
>   pcie: add a way to get the outstanding page request allocation (pri)
>     from the config space.
>   pci: declare structures and IOMMU operation for PRI
>   pci: add a PCI-level API for PRI
>   intel_iommu: declare PRI constants and structures
>   intel_iommu: declare registers for PRI
>   intel_iommu: add PRI operations support
> 
>  hw/i386/intel_iommu.c          | 302 +++++++++++++++++++++++++++++++++
>  hw/i386/intel_iommu_internal.h |  54 +++++-
>  hw/pci/pci.c                   |  37 ++++
>  hw/pci/pcie.c                  |  42 +++++
>  include/exec/memory.h          |  65 +++++++
>  include/hw/pci/pci.h           |  45 +++++
>  include/hw/pci/pci_bus.h       |   1 +
>  include/hw/pci/pcie.h          |   7 +-
>  include/hw/pci/pcie_regs.h     |   4 +
>  system/memory.c                |  49 ++++++
>  10 files changed, 604 insertions(+), 2 deletions(-)
> 
> -- 
> 2.45.1


