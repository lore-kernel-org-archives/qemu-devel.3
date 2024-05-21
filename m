Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28BCC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OlT-0006ba-Fl; Tue, 21 May 2024 08:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OlR-0006aw-NJ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OlP-0003BI-RV
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716295122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jl/WI5upc281e76q++hTKaafkNwCghV6FdCgkZpRbwE=;
 b=e30kHGLv6pXNXVadXlqa+J40uALGHw024tLo1UtukY+Neevos4s6qCQlKjhdvP6ShCLX35
 O2dwlBsL/0Vk7tFe/l5P72btdWa76x+u/xuyOT9ej0zSjsZ3/NKZX/46sv2jKD7/V559Er
 79BWpd5IwEx7FeUqkuXo6SoHMCxSkik=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-pAlAYog9OaGyqz_SzipzeQ-1; Tue, 21 May 2024 08:38:40 -0400
X-MC-Unique: pAlAYog9OaGyqz_SzipzeQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61b2ef746c9so210038917b3.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295119; x=1716899919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jl/WI5upc281e76q++hTKaafkNwCghV6FdCgkZpRbwE=;
 b=T8KIzEqkH0mQ4fdTzpZXKBPyWF827iF91KnIBlRw8h32Pbt6zKJvUYk1QZVZUuGKRW
 LO0U8ssSrBbCf28BZ77JCSixcEP/HN8BS9u6Lm9WOMbSsP4D/v51/FtU2Sy23RGUZqoK
 uB7pkwD1QdVAhEimc4jZ0kJE8Q85SnpESmLZy5/NdfbPQn0YliXJHR2Ro+cbaMtVit40
 W6Gq1ZF+EeNini0nftLZiDkF5jKxNjmZ0lanZkNPbs3MpSAvSmuBNTgojp+v+O5tX2u+
 sYvp+gxdVnqO+H9yT2Gb9eBpGTZtiKb9X1bMVYEb9ZTDguHgiYWaqUoBkBE3MXp9MrGO
 U4OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHs723FwKOVmb9iJxxVqmSpZKzLt7Rjdov7ltHv7PaIH2RchvpsaR8/g6BYuzXhE4C9uTPiJBuZxyMRUWAEudB2y32Yww=
X-Gm-Message-State: AOJu0Yw8vqTy1u7wxZXVamFHi7hcuYEworoTb4Z5pN2vWtZcoTnP8qlG
 fpy65oLLvo1Ag7jPGAXBkbfJdyhMFOQ3BKYFwXcPfNQGMcTYXFBMolDqpRB4ai+6lCWPIzm4jOa
 P06M1UZay6KGd++82ni6TQGeIgFZcGMXOAqsanRIospK7hKw9gyV9
X-Received: by 2002:a05:690c:1c:b0:618:9353:1023 with SMTP id
 00721157ae682-622aff93defmr496955407b3.17.1716295116622; 
 Tue, 21 May 2024 05:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF0Po/9kX7qUcAT+9mWJnDt49KF8hbTnIW775eoLhHTW/hNQyaqpxu/57G4A/fuR4cRg9wig==
X-Received: by 2002:a05:690c:1c:b0:618:9353:1023 with SMTP id
 00721157ae682-622aff93defmr496954087b3.17.1716295113803; 
 Tue, 21 May 2024 05:38:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a35290b864sm70021976d6.143.2024.05.21.05.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:38:33 -0700 (PDT)
Message-ID: <74e05bcb-79b2-4b76-982d-5e43039e9277@redhat.com>
Date: Tue, 21 May 2024 14:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] vfio/pci: Make vfio_pci_relocate_msix() and
 vfio_msix_early_setup() return a bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-10-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> Since vfio_pci_relocate_msix() and vfio_msix_early_setup() takes
> an 'Error **' argument, best practices suggest to return a bool.
> See the qapi/error.h Rules section.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 12fb534d79..379cbad757 100644
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
> @@ -3130,8 +3131,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       vfio_bars_prepare(vdev);
>   
> -    vfio_msix_early_setup(vdev, &err);
> -    if (err) {
> +    if (!vfio_msix_early_setup(vdev, &err)) {

why not pass errp directly and avoid error_propagate() ?


Thanks,

C.


>           error_propagate(errp, err);
>           goto error;
>       }


