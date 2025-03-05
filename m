Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6CDC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpicu-0000IY-94; Wed, 05 Mar 2025 01:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tpicr-0000IO-9p
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:53:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tpicn-0004wg-P1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741157580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=psQ7ZnH7blFSRYIoIWVachSRcExkF1M2wts4eqPiX60=;
 b=a1QRNs/cns3BwLItz5BskPMS+327mFCGJxZoOFGPqZDVO7yNWuj36mnjPs5HfcwXEgCEon
 PxjUj2QRXfkjesBAE8MXs9LRfXv6X7ODOT+xiifpkFuuhMopGe/fvhI4t5oRPAugTIiCnP
 oaE+OusAMRoaQzp9e09CYo4rFneh/kA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-1iBhLTN-Oy68mSbG_d8HpQ-1; Wed, 05 Mar 2025 01:52:58 -0500
X-MC-Unique: 1iBhLTN-Oy68mSbG_d8HpQ-1
X-Mimecast-MFC-AGG-ID: 1iBhLTN-Oy68mSbG_d8HpQ_1741157577
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so2063545e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 22:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741157577; x=1741762377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psQ7ZnH7blFSRYIoIWVachSRcExkF1M2wts4eqPiX60=;
 b=pyo5lnq19QfwIICPKDk1dNyWP/hcP/wP7zVY7D55m17BrAI28D1zCG1r359d0sWrz/
 2Py2CXn7ckAr7g7r4oPMfIEQ84N7ga+G5LdquBi1C4mMO91dgMTOQT9ljpl7E1kbnQBH
 t+6wV2JtyAuGZ8s1+Y2gF8EoVRpKQMakd5uxUBFddeHX+d12lmrNh+xpZND+InVQAfmE
 HkjWMv4D1xaQIyT5V21YiqBRyMyMY8QDSw2hu1LfJAM60I7ks8Hq6yuI8AbkMfP76g7Y
 et/e4NtQ86+O+/xMVoBx4Odgpt5mX5GEAibH5HwmDypsM/UUKKLoBOPCogFwSvvWksx7
 jq8w==
X-Gm-Message-State: AOJu0YyI2pE1evTQIlShXaXuKAgEbB2ybMarV/NQ6oYv2AAGqqW7CBpa
 AkX96bdcVMPiB22gADRQLX7d3KoS/nNeaY5Nr841R9vDkyqHDdGsGcbyGbxm8Cjs30Q+ZAoRiZ6
 unnBtrr7bWEAoi+CLpW7Lvh4Uxt1K9qMxqa0wyW6ha0lUUvsOrN+h
X-Gm-Gg: ASbGnctIdJwTCoel9MZv/mN8/AxdnWGObggSTfIpYLKsv9Dv5dUp8nl1VPBVqRerNAO
 Fa3iBVKiVceZHP9x0oG30AiSt6yX6LmOvmzmORykaL+Mp/q3Yfs15MOSO+is/AW50vfF4Imj5We
 b4nixSyjtzx2+fZA8qoIN2cFacGx5Wph3k2pWj5yG5+vs5nFYke35CG1XLjWPb1xCZN4i773Oxo
 t8vgL5GzjkbwjStZNO86aQa0SGTkp7gYcsLdD6qyMOnzrUVcte84bRlj5+eJJeVf57vUQ2+dQ8l
 dt7ex4eerA==
X-Received: by 2002:a05:600c:428c:b0:43b:d0b1:90c5 with SMTP id
 5b1f17b1804b1-43bd0b1912emr19743425e9.10.1741157577382; 
 Tue, 04 Mar 2025 22:52:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1bN6bmcqaxSgrvEyQECsYlLNEJ5lmhzF8o2pvw6SQwZHBkReAP7wPUixLuRrPylmM0/S4AA==
X-Received: by 2002:a05:600c:428c:b0:43b:d0b1:90c5 with SMTP id
 5b1f17b1804b1-43bd0b1912emr19743225e9.10.1741157577049; 
 Tue, 04 Mar 2025 22:52:57 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292eeasm8032905e9.16.2025.03.04.22.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 22:52:55 -0800 (PST)
Date: Wed, 5 Mar 2025 01:52:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <20250305015122-mutt-send-email-mst@kernel.org>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I/O
> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
> device is platform-specific.
> 
> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
> undefined device id.

undefined?

> Therefore, change the vendor id to Red Hat and request a new QEMU-specific
> device id.

Won't the drivers fail to load then?


> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

what is this link teaching us? It's a 300 page document. Where to look
in there?

> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  docs/specs/pci-ids.rst | 2 ++
>  hw/i386/amd_iommu.c    | 3 ++-
>  include/hw/pci/pci.h   | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> index 261b0f359f..2416a70a2d 100644
> --- a/docs/specs/pci-ids.rst
> +++ b/docs/specs/pci-ids.rst
> @@ -100,6 +100,8 @@ PCI devices (other than virtio):
>    PCI UFS device (``-device ufs``)
>  1b36:0014
>    PCI RISC-V IOMMU device
> +1b36:0015
> +  PCI AMD IOMMU device (``-device amd-iommu``)
>  
>  All these devices are documented in :doc:`index`.
>  
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index dda1a5781f..4d8564249c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1766,7 +1766,8 @@ static void amdvi_pci_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->vendor_id = PCI_VENDOR_ID_AMD;
> +    k->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    k->device_id = PCI_DEVICE_ID_REDHAT_AMD_IOMMU;
>      k->class_id = 0x0806;
>      k->realize = amdvi_pci_realize;
>  
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 4002bbeebd..da44e6673d 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -117,6 +117,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
>  #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
>  #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
> +#define PCI_DEVICE_ID_REDHAT_AMD_IOMMU   0x0015
>  #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>  
>  #define FMT_PCIBUS                      PRIx64
> -- 
> 2.34.1


