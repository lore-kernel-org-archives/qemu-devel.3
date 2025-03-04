Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22FCC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 18:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpXIO-0004dK-UI; Tue, 04 Mar 2025 13:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpXIM-0004c9-Bh
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 13:47:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpXIB-0006vj-LS
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 13:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741114017;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K696u+pYDGDwY+rda9IQpMlYtvzwuZoaR/uvQMgE6hs=;
 b=VRrJvv2OmUoGB2ank2fKWGaYdvrJke3sfBorUG+JK17lyE+i6nkAEQbT7ZOll7TYqO+64m
 AlydDkDu4D3B16gc7OvxqTC0Sj2hax8n3005wACjLVEuRNMy3zyaoiiB9bjKMIrJF1iRYW
 QisodaMYUqynM1jIoExSwImkr2FqoiY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-wBLW7PtWMVarc5dVRepGPw-1; Tue,
 04 Mar 2025 13:46:42 -0500
X-MC-Unique: wBLW7PtWMVarc5dVRepGPw-1
X-Mimecast-MFC-AGG-ID: wBLW7PtWMVarc5dVRepGPw_1741114000
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16B8E180099F; Tue,  4 Mar 2025 18:46:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.210])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D01819560AB; Tue,  4 Mar 2025 18:46:34 +0000 (UTC)
Date: Tue, 4 Mar 2025 18:46:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 kraxel@redhat.com, bsd@redhat.com, ddutile@redhat.com
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <Z8dKh9EAFPJeHlXU@redhat.com>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I/O
> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
> device is platform-specific.
> 
> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
> undefined device id.
> 
> Therefore, change the vendor id to Red Hat and request a new QEMU-specific
> device id.
> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
> 
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

Ordinarily this change would need to have versioned machine type
back compat logic.

The AMD IOMMU has a migration blocker currently, so at least we
are guaranteed to not hit a problem for running guests.

There's still risk that an existing installed guest is upset by a
change of PCI vendor/device ID across cold-boots.

We can add in the fact that we couldn't guarantee a stable PCI
device slot either until the split to allow AMDVI-PCI to be
independantly created.

With all this in mind, I think it is reasonable to say the current
device is incapable of providing a stable ABI in general, and thus
it is justified to omit the versioned machine type back compat
logic this time.

This patch should probably be bundled with the other two outstanding
amd iommu patches for migration support.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

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
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


