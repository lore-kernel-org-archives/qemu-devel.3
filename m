Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F96C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9f7S-0000aT-Ub; Wed, 22 May 2024 02:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9f7I-0000XO-Ul
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9f7H-0002v4-3k
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716357982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iByorjUO8YNBOtrQe8qEdPCgeB8jyHU7TB/K8nyTd54=;
 b=AxDjm6qhehcUYDGPUkO4xTNc9hvuBaEnCekHR4MJl1KUolR814ssN+4Qi1B6D8KbNu3/0p
 TNEA/S8cc8swJL01f5eSMBHNPxaibWhI06HaVs7aPJXLGzu/bC1zWGIxTccgr6/wFdoeEJ
 lGmd2jAnEzlnRXe6VXQ8LOuEUveWlkE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-QdoGaELNPvikKFP3n5Sr8g-1; Wed, 22 May 2024 02:06:18 -0400
X-MC-Unique: QdoGaELNPvikKFP3n5Sr8g-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-794975e4dfdso104013185a.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 23:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716357978; x=1716962778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iByorjUO8YNBOtrQe8qEdPCgeB8jyHU7TB/K8nyTd54=;
 b=P520vWpGZRYlS8op7DexEDhnssjcQgxKGXIR64FtzCl8n3lRC6EdSVkYfk7kxI05BG
 5tXT69Wfh4X0fMeCSm8CIqVnAMICpYm3b7YitDGuEWl78VhhqcfVcyC1OqLW35OvKViZ
 eilsa7Ejb/rr8ah/7j5ZQJxSMkEvEfmIHs36nsJFzJr3YKgJDrpoMpTokl1SudQ6wRIn
 qKPF0ANYB5v/tvjgxBwDMub7nYTcoARmZ/EXRiXgYa6+l7VHUBYmx0h6RLucJT4+6vSd
 WP+q7lhKNCeDNBs4CaiZ94ya+7kOuvaCY+vLPPeTAGkC/0PALTfNhw91f+I4qaNQCrsG
 p5ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIo9o39Lh8Lz3R1M4jWFWdaDlzXjG1cKtWDIeBl+6cmgKXNtasSfVs1rMRdHinFLrZ6pV/W3b8pdRYpEp+ufncDN/99hE=
X-Gm-Message-State: AOJu0YycB6RSnSYz5saiFTGf6Oc+7NkfhreAWSKtol3/30sPfZm0U9md
 hc36bHtLQVMqe9Dd2/FDZmkFzN+2+J7BnVouwE4+DCMFXZmRWwdLKRRSiqAwK7Bok7LMI2AExTb
 UFXONAodSM/kdEIfs6MpZKCBAHpVmToVhnCRH6F07cNfxxMSWBALP
X-Received: by 2002:a05:620a:2496:b0:793:370:2f74 with SMTP id
 af79cd13be357-79498e710d5mr245299385a.0.1716357978023; 
 Tue, 21 May 2024 23:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqAwct6zCHbhPIyn8y4ka+Zjf3F56OthJe4Zt/m7W/DA5hpdKrdR8Qj291PbvF33K0G5DhJw==
X-Received: by 2002:a05:620a:2496:b0:793:370:2f74 with SMTP id
 af79cd13be357-79498e710d5mr245296785a.0.1716357977585; 
 Tue, 21 May 2024 23:06:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2ffdcdsm1364366685a.72.2024.05.21.23.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 23:06:16 -0700 (PDT)
Message-ID: <72ea2d66-a131-4595-8976-c275f35f3977@redhat.com>
Date: Wed, 22 May 2024 08:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/20] vfio/pci: Make vfio_pci_relocate_msix() and
 vfio_msix_early_setup() return a bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-10-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240522044015.412951-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 5/22/24 06:40, Zhenzhong Duan wrote:
> Since vfio_pci_relocate_msix() and vfio_msix_early_setup() takes
> an 'Error **' argument, best practices suggest to return a bool.
> See the qapi/error.h Rules section.
> 
> By this chance, pass errp directly to vfio_msix_early_setup() to avoid
> calling error_propagate().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 12fb534d79..4fb5fd0c9f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1450,13 +1450,13 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>   {
>       int target_bar = -1;
>       size_t msix_sz;
>   
>       if (!vdev->msix || vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
> -        return;
> +        return true;
>       }
>   
>       /* The actual minimum size of MSI-X structures */
> @@ -1479,7 +1479,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>           if (target_bar < 0) {
>               error_setg(errp, "No automatic MSI-X relocation available for "
>                          "device %04x:%04x", vdev->vendor_id, vdev->device_id);
> -            return;
> +            return false;
>           }
>       } else {
>           target_bar = (int)(vdev->msix_relo - OFF_AUTOPCIBAR_BAR0);
> @@ -1489,7 +1489,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>       if (vdev->bars[target_bar].ioport) {
>           error_setg(errp, "Invalid MSI-X relocation BAR %d, "
>                      "I/O port BAR", target_bar);
> -        return;
> +        return false;
>       }
>   
>       /* Cannot use a BAR in the "shadow" of a 64-bit BAR */
> @@ -1497,7 +1497,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>            target_bar > 0 && vdev->bars[target_bar - 1].mem64) {
>           error_setg(errp, "Invalid MSI-X relocation BAR %d, "
>                      "consumed by 64-bit BAR %d", target_bar, target_bar - 1);
> -        return;
> +        return false;
>       }
>   
>       /* 2GB max size for 32-bit BARs, cannot double if already > 1G */
> @@ -1505,7 +1505,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>           !vdev->bars[target_bar].mem64) {
>           error_setg(errp, "Invalid MSI-X relocation BAR %d, "
>                      "no space to extend 32-bit BAR", target_bar);
> -        return;
> +        return false;
>       }
>   
>       /*
> @@ -1540,6 +1540,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>   
>       trace_vfio_msix_relo(vdev->vbasedev.name,
>                            vdev->msix->table_bar, vdev->msix->table_offset);
> +    return true;
>   }
>   
>   /*
> @@ -1550,7 +1551,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>    * need to first look for where the MSI-X table lives.  So we
>    * unfortunately split MSI-X setup across two functions.
>    */
> -static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
>       uint8_t pos;
>       uint16_t ctrl;
> @@ -1562,25 +1563,25 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>   
>       pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
>       if (!pos) {
> -        return;
> +        return true;
>       }
>   
>       if (pread(fd, &ctrl, sizeof(ctrl),
>                 vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
>           error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
> -        return;
> +        return false;
>       }
>   
>       if (pread(fd, &table, sizeof(table),
>                 vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
>           error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
> -        return;
> +        return false;
>       }
>   
>       if (pread(fd, &pba, sizeof(pba),
>                 vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
>           error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
> -        return;
> +        return false;
>       }
>   
>       ctrl = le16_to_cpu(ctrl);
> @@ -1598,7 +1599,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
>           g_free(msix);
> -        return;
> +        return false;
>       }
>   
>       msix->noresize = !!(irq_info.flags & VFIO_IRQ_INFO_NORESIZE);
> @@ -1630,7 +1631,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>               error_setg(errp, "hardware reports invalid configuration, "
>                          "MSIX PBA outside of specified BAR");
>               g_free(msix);
> -            return;
> +            return false;
>           }
>       }
>   
> @@ -1641,7 +1642,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>   
>       vfio_pci_fixup_msix_region(vdev);
>   
> -    vfio_pci_relocate_msix(vdev, errp);
> +    return vfio_pci_relocate_msix(vdev, errp);
>   }
>   
>   static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
> @@ -3130,9 +3131,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       vfio_bars_prepare(vdev);
>   
> -    vfio_msix_early_setup(vdev, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> +    if (!vfio_msix_early_setup(vdev, errp)) {
>           goto error;
>       }
>   


