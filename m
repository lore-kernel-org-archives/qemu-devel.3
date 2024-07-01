Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDCEC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONF0-00088N-2Y; Mon, 01 Jul 2024 16:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONEx-00085d-Bx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONEv-0003NB-Bd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719864184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GnyM0Y48tu7pMntL7aTXdpi5vTyEOBaOqkcn+SvmHc=;
 b=J9R7YkUcg/cx4zJ3vahFw3cBMHK9TW/ImMeZz4qNxr03l5WgbBthrW4GGQTRUPgdaIoZvP
 g7m0DszR9IZQ3VT9Qz0AFhYZsltzermnrIIVan70tDFHyl10gQlaYIoqkJZzZN6M1ahbFa
 YF3QXdR/6HK4252Cb2wCAn9oEFJejNg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-2_Jj7hJpN7WhIE2b06CJaA-1; Mon, 01 Jul 2024 16:03:03 -0400
X-MC-Unique: 2_Jj7hJpN7WhIE2b06CJaA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4257f95ffc6so10445545e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719864182; x=1720468982;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6GnyM0Y48tu7pMntL7aTXdpi5vTyEOBaOqkcn+SvmHc=;
 b=W0W2iELl56kGS1Vkq+38S7UlfHgm+PlkrpBdvfFJ/vg9TO2+w/+tbRf9c5JF4yjFpk
 8bVidckjehqcbUZyYMoWRnM40BpDH2wFlx+4GooBfdLV9ecUV07T/YOJHN38tgu/mx+r
 1hPhbrvGbSHAmTIq2rqmS4+AmytG4EEsGFxGjcMk+rsFx12BPtpPQA/ECxoW8MPO6OUf
 8HQzgVMS3+8phdGvZiukVk3lAgv/nFv9lr9midSopcZYDw/TIswiwrlDRSQoQk2dnzJr
 yH+zOwBKbt+Gfhmdvj0bx9QQ7a0xJlLT86T3cMIWJP75c5AjjTbMB/NqXY2lddrOrMgI
 D7oQ==
X-Gm-Message-State: AOJu0YxVxN7D7ERaNcPJopXftiM/dAFujYzLVLp6I1Ni5qR8sAKxi5G+
 5AphSDw/oSShQVRCyUjbv/Uy1KHQE2J9IB4qm3tw4jQZHgL22BfDkMEEuK7a41exIjAOcs3Krxp
 QKz8aC6ywgSfAbpHEMi26eIHgsAfqqk/6SBeBppAP9KhUpeWQPm/x
X-Received: by 2002:a5d:43ce:0:b0:366:e9ec:ca64 with SMTP id
 ffacd0b85a97d-3677572014bmr4026959f8f.54.1719864182197; 
 Mon, 01 Jul 2024 13:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAhlp1Ba1frtpg2gP6UgUGpGzQowG8efJj8DuCl+QCKX6n9AZwC+mDFhdUL6D3uqIlxQhuCQ==
X-Received: by 2002:a5d:43ce:0:b0:366:e9ec:ca64 with SMTP id
 ffacd0b85a97d-3677572014bmr4026945f8f.54.1719864181601; 
 Mon, 01 Jul 2024 13:03:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd56dsm10925000f8f.19.2024.07.01.13.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:03:00 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:02:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Message-ID: <20240701160122-mutt-send-email-mst@kernel.org>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Jun 03, 2024 at 05:59:38AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> This series belongs to a list of series that add SVM support for VT-d.
> 
> As a starting point, we use the series called 'intel_iommu: Enable stage-1 translation' (rfc2) by Zhenzhong Duan and Yi Liu.
> 
> Here we focus on the implementation of ATS support in the IOMMU and on a PCI-level
> API for ATS to be used by virtual devices.
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

I will merge, but could you please resend this using git format-patch
for formatting?  The patches have trailing CRs and don't show which sha1
they are for, which makes re-applying them after each change painful.


> v2
>     - handle huge pages better by detecting the page table level at which the translation errors occur
>     - Changes after review by ZhenZhong Duan :
>     	- Set the access bit after checking permissions
>     	- helper for PASID and ATS : make the commit message more accurate ('present' replaced with 'enabled')
>     	- pcie_pasid_init: add PCI_PASID_CAP_WIDTH_SHIFT and use it instead of PCI_EXT_CAP_PASID_SIZEOF for shifting the pasid width when preparing the capability register
>     	- pci: do not check pci_bus_bypass_iommu after calling pci_device_get_iommu_bus_devfn
>     	- do not alter formatting of IOMMUTLBEntry declaration
>     	- vtd_iova_fl_check_canonical : directly use s->aw_bits instead of aw for the sake of clarity
> 
> v3
>     - rebase on new version of Zhenzhong's flts implementation
>     - fix the atc lookup operation (check the mask before returning an entry)
>     - add a unit test for the ATC
>     - store a user pointer in the iommu notifiers to simplify the implementation of svm devices
>     Changes after review by Zhenzhong :
>     	- store the input pasid instead of rid2pasid when returning an entry after a translation
>     	- split the ATC implementation and its unit tests
> 
> v4
>     Changes after internal review
>     	- Fix the nowrite optimization, an ATS translation without the nowrite flag should not fail when the write permission is not set
> 
> v5
>     Changes after review by Philippe :
>     	- change the type of 'level' to unsigned in vtd_lookup_iotlb
> 
> 
> 
> Clément Mathieu--Drif (22):
>   intel_iommu: fix FRCD construction macro.
>   intel_iommu: make types match
>   intel_iommu: return page walk level even when the translation fails
>   intel_iommu: do not consider wait_desc as an invalid descriptor
>   memory: add permissions in IOMMUAccessFlags
>   pcie: add helper to declare PASID capability for a pcie device
>   pcie: helper functions to check if PASID and ATS are enabled
>   intel_iommu: declare supported PASID size
>   pci: cache the bus mastering status in the device
>   pci: add IOMMU operations to get address spaces and memory regions
>     with PASID
>   memory: store user data pointer in the IOMMU notifiers
>   pci: add a pci-level initialization function for iommu notifiers
>   intel_iommu: implement the get_address_space_pasid iommu operation
>   intel_iommu: implement the get_memory_region_pasid iommu operation
>   memory: Allow to store the PASID in IOMMUTLBEntry
>   intel_iommu: fill the PASID field when creating an instance of
>     IOMMUTLBEntry
>   atc: generic ATC that can be used by PCIe devices that support SVM
>   atc: add unit tests
>   memory: add an API for ATS support
>   pci: add a pci-level API for ATS
>   intel_iommu: set the address mask even when a translation fails
>   intel_iommu: add support for ATS
> 
>  hw/i386/intel_iommu.c                     | 142 +++++-
>  hw/i386/intel_iommu_internal.h            |   6 +-
>  hw/pci/pci.c                              | 127 +++++-
>  hw/pci/pcie.c                             |  42 ++
>  include/exec/memory.h                     |  51 ++-
>  include/hw/i386/intel_iommu.h             |   2 +-
>  include/hw/pci/pci.h                      | 101 +++++
>  include/hw/pci/pci_device.h               |   1 +
>  include/hw/pci/pcie.h                     |   9 +-
>  include/hw/pci/pcie_regs.h                |   3 +
>  include/standard-headers/linux/pci_regs.h |   1 +
>  system/memory.c                           |  20 +
>  tests/unit/meson.build                    |   1 +
>  tests/unit/test-atc.c                     | 527 ++++++++++++++++++++++
>  util/atc.c                                | 211 +++++++++
>  util/atc.h                                | 117 +++++
>  util/meson.build                          |   1 +
>  17 files changed, 1330 insertions(+), 32 deletions(-)
>  create mode 100644 tests/unit/test-atc.c
>  create mode 100644 util/atc.c
>  create mode 100644 util/atc.h
> 
> -- 
> 2.45.1


