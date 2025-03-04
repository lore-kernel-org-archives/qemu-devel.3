Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46501C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpbJF-0003kW-2R; Tue, 04 Mar 2025 18:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tpbIa-0003XV-Ea
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tpbIW-0000fg-Kb
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741129413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ECG3CILomG/zrcnKloSA50DArlI2u38sRYKoeRp/QU=;
 b=AES7OARgzK9PL/AZwxFMZiohPiYavYVox8m0slC+ZXfdOmETAswsz3pwy2sN2ZHy6tB44A
 Ww2Iez/KDNXY/fvGRrA3pI5KB/mPjpaqdh3ET2h3a91spKdGG3KTS1pFSHopeb79o8XRrG
 ZJQMn242ZBJjbtrSvYybC0Y/gpyxB7c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-LgoB8y4rPa-UYyfM7rBBRA-1; Tue, 04 Mar 2025 18:02:21 -0500
X-MC-Unique: LgoB8y4rPa-UYyfM7rBBRA-1
X-Mimecast-MFC-AGG-ID: LgoB8y4rPa-UYyfM7rBBRA_1741129341
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e8e171fd66so23481426d6.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 15:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741129341; x=1741734141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ECG3CILomG/zrcnKloSA50DArlI2u38sRYKoeRp/QU=;
 b=ESLaNaBAURcPLjpCPLr2ysq7ib6g0S3h/SUH/EvxMh2sWvyhUwQN4h1pykuefYHijQ
 0IPGtRCapmY37U/NzpHGfyH3PmXPet1X39H+6sfJxf07/i3ArIMpmGnX4Ee/rMg8uTZm
 SqbbH9I6b4nuF3N+tpbIUN9WMLdcFMtFclS/g2WGO9iGRDYPY84IuRtCY31hD9KLlaVo
 lCP8y+cTern6RHq9g1nxu657e4oixSMiHAah2jg8V/oB85zGvP9YvSMvUn1X5PlJL4kc
 VvuvaCudndVPqm3B5Mgi3RXcxqp65Ixk7wWibeOynzUX9U6IuUAtptas4MrjRmoeCrvc
 jbmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDtSso7VYmQLjdb5AaOTLOGVZXmKX43vJPMoE2JqZqtTZ1NrmxNy0MeomZGZgbhYWIfTP/njg7mbFi@nongnu.org
X-Gm-Message-State: AOJu0Yxsa8tYM+en24z2GhyYzq9FSRGyO/fOPzyAf9gNncegRSv/VXYQ
 ZJIAK8059JnB2+S4spBo+E+30vKj+vqRwvH+zO/ek1itKVunbqCgEP7FAtOgNZKEjG49gEgxHvE
 kYGGlxInelj07/n7TQR+pvpy1uzrEj26S1q1euFtvEJrFlbOfbb/N
X-Gm-Gg: ASbGncvEeo5SLfEbwB4k9qL4YXXXukCHdApMDFrfCAeObc9cfCwtcjuqXyAbHU33ZVj
 j265YFszcyGuAOf+A0XzA6VcIwNuAco8QWqg4hCyEV+eIzmzxM6GBLLDE6WCZ1HocVG6R8HMVCR
 ArFp16l6G7RgVgGXItk+8k/STnlIByqXE/q+UF6D9pVRm2vLmw3J1wcaXZYIwqrMCvLxzpPy13Q
 cUVCkBUkKkTxQVxXvdH+s/yHgtE/8z71VEeDRWJRjUfErxm0omlbIjqsrSbqs7xzuDrVkDPX3Kt
 ZZ0Rsqs637EpsL5k
X-Received: by 2002:ad4:5aa9:0:b0:6e8:9ba6:597d with SMTP id
 6a1803df08f44-6e8e6d500e8mr15437726d6.38.1741129341008; 
 Tue, 04 Mar 2025 15:02:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIAtRd1tuZyb+JZ+7ftew0BSBHxYZNUEoZEhUa18Y0uG5zp63X3iDjrhO3j1uUUl0F4i8qoA==
X-Received: by 2002:ad4:5aa9:0:b0:6e8:9ba6:597d with SMTP id
 6a1803df08f44-6e8e6d500e8mr15437496d6.38.1741129340703; 
 Tue, 04 Mar 2025 15:02:20 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976d9fe1sm71935946d6.102.2025.03.04.15.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 15:02:20 -0800 (PST)
Message-ID: <c8adb591-c4e5-4658-9b87-cb11d75c143f@redhat.com>
Date: Tue, 4 Mar 2025 18:02:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, kraxel@redhat.com, bsd@redhat.com,
 berrange@redhat.com
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
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

Hi Suravee!

Not your issue, but wondering if others know:

Why isn't this an issue for Intel-vtd-iommu & ARM-SMMUV3 ?
Are they instantiated as non-PCI-id (platform) devices, but AMD puts their IOMMU in PCI space?

Adv. thanks for the info.

- Don


On 3/4/25 1:37 PM, Suravee Suthikulpanit wrote:
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
>   docs/specs/pci-ids.rst | 2 ++
>   hw/i386/amd_iommu.c    | 3 ++-
>   include/hw/pci/pci.h   | 1 +
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> index 261b0f359f..2416a70a2d 100644
> --- a/docs/specs/pci-ids.rst
> +++ b/docs/specs/pci-ids.rst
> @@ -100,6 +100,8 @@ PCI devices (other than virtio):
>     PCI UFS device (``-device ufs``)
>   1b36:0014
>     PCI RISC-V IOMMU device
> +1b36:0015
> +  PCI AMD IOMMU device (``-device amd-iommu``)
>   
>   All these devices are documented in :doc:`index`.
>   
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index dda1a5781f..4d8564249c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1766,7 +1766,8 @@ static void amdvi_pci_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>   
> -    k->vendor_id = PCI_VENDOR_ID_AMD;
> +    k->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    k->device_id = PCI_DEVICE_ID_REDHAT_AMD_IOMMU;
>       k->class_id = 0x0806;
>       k->realize = amdvi_pci_realize;
>   
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 4002bbeebd..da44e6673d 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -117,6 +117,7 @@ extern bool pci_available;
>   #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
>   #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
>   #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
> +#define PCI_DEVICE_ID_REDHAT_AMD_IOMMU   0x0015
>   #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>   
>   #define FMT_PCIBUS                      PRIx64


