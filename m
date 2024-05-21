Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FFDC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9P0m-0005Q0-8p; Tue, 21 May 2024 08:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9P0l-0005OD-60
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9P0i-0005pn-E8
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716296071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Do/Jl/kDhukA6v/irix7JpXgKeu9Z18l4Z5lw2iH7e4=;
 b=RPc8iEedP2TNcWVdg6uzo6AoIaPH18/w837gw67TDFQWwMcM9ERIPDpqtI6F8xVXqnGmYP
 x3Pg1sY41EpSHBDKMyDQ73WTH7lYgM+YggDlvB9CplZwjb/KsVE0yskwpjORbyMresVxkG
 Eoe52kcwLd0Jmu/zkf0zlFjQ8neREOc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-M0-hMrzhONWdKjaCEGbCVA-1; Tue, 21 May 2024 08:54:30 -0400
X-MC-Unique: M0-hMrzhONWdKjaCEGbCVA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59eea00cafso839221766b.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716296069; x=1716900869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Do/Jl/kDhukA6v/irix7JpXgKeu9Z18l4Z5lw2iH7e4=;
 b=JBUt5g/Fiuc5yB6WDgRci86X4i2HCEVFb1EyGdFIIc8JGksKMuSphNlVJmiKv2jbcG
 CYUXYGoMqtwruoHy5Evf11QULn3dvFts9JYzYS1QBHJUSaYke3Zyqlg6Bhb4Mxi/Y69X
 zqjSvQRKLg3dLrHa2LEKb07D26GHtPSSjTLycPDHyF/DUcejYz3Y4SM3O9wdMSKG5bwv
 WL8GLF3Q2YAum5SCiUNJBJZgY5GinoE3IeIMfrkRzAeowGRPHpTs7/D+yAimCiMjzBdW
 h0f0U5g73IUZGp1zu5YFoWxAKuY2QksBgEbOeMhn6YiVlJI4dvGe1lYjagpJHTi4JRk/
 5tgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/AxAKMCCjR4636EoVgFqTJUhNqcYiT4wSve+MLss6wxpdcxbC9sB9lVIh7vQk4INgFs/1SQ6tz/DYA45jt/KFZJhF/Fw=
X-Gm-Message-State: AOJu0YxvBsx2OXCAjaxXd7RJPvpngqRwgobeZhZKeJwHBlYmQOem6qIy
 V/TzjQI0opzT4WcA7ETnEkwrGK0DTfPtJ6HKdKKxHoHoGkEUgKG6EKgx/RNrJJM5ZzBozoMMWHd
 3c3jsDtANzLcMs4Hf7N3Dj8vOnm7pH9eqZpMb9iHZM+l/iP17bu4/
X-Received: by 2002:a17:907:35d4:b0:a5a:7d28:54aa with SMTP id
 a640c23a62f3a-a5a7d285594mr2090962166b.23.1716296069031; 
 Tue, 21 May 2024 05:54:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc60oiPsyjSbxUvNfX6BAdDt7X31B0KaeIEoH+SGAz7bDc9z2YjhgGfhD+3YA719xm69TvTw==
X-Received: by 2002:a17:907:35d4:b0:a5a:7d28:54aa with SMTP id
 a640c23a62f3a-a5a7d285594mr2090961266b.23.1716296068735; 
 Tue, 21 May 2024 05:54:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5ec2a8f320sm424992566b.170.2024.05.21.05.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:54:28 -0700 (PDT)
Message-ID: <effd4af0-c43b-4a6b-b07b-8eb89e69613c@redhat.com>
Date: Tue, 21 May 2024 14:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] vfio/pci-quirks: Make vfio_add_*_cap() return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-17-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-17-zhenzhong.duan@intel.com>
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> This is to follow the coding standand in qapi/error.h to return bool
> for bool-valued functions.
> 
> Include below functions:
> vfio_add_virt_caps()
> vfio_add_nv_gpudirect_cap()
> vfio_add_vmd_shadow_cap()
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.h        |  2 +-
>   hw/vfio/pci-quirks.c | 42 +++++++++++++++++++-----------------------
>   hw/vfio/pci.c        |  3 +--
>   3 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index f158681072..bf67df2fbc 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -212,7 +212,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr);
>   void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
>   void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
>   void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
> -int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
> +bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
>   void vfio_quirk_reset(VFIOPCIDevice *vdev);
>   VFIOQuirk *vfio_quirk_alloc(int nr_mem);
>   void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index ca27917159..39dae72497 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1536,7 +1536,7 @@ static bool is_valid_std_cap_offset(uint8_t pos)
>               pos <= (PCI_CFG_SPACE_SIZE - PCI_CAP_SIZEOF));
>   }
>   
> -static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>   {
>       ERRP_GUARD();
>       PCIDevice *pdev = &vdev->pdev;
> @@ -1545,18 +1545,18 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>       uint8_t tmp;
>   
>       if (vdev->nv_gpudirect_clique == 0xFF) {
> -        return 0;
> +        return true;
>       }
>   
>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID)) {
>           error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid device vendor");
> -        return -EINVAL;
> +        return false;
>       }
>   
>       if (pci_get_byte(pdev->config + PCI_CLASS_DEVICE + 1) !=
>           PCI_BASE_CLASS_DISPLAY) {
>           error_setg(errp, "NVIDIA GPUDirect Clique ID: unsupported PCI class");
> -        return -EINVAL;
> +        return false;
>       }
>   
>       /*
> @@ -1572,7 +1572,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>                   vdev->config_offset + PCI_CAPABILITY_LIST);
>       if (ret != 1 || !is_valid_std_cap_offset(tmp)) {
>           error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
> -        return -EINVAL;
> +        return false;
>       }
>   
>       do {
> @@ -1590,13 +1590,13 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>           pos = 0xD4;
>       } else {
>           error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid config space");
> -        return -EINVAL;
> +        return false;
>       }
>   
>       ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
>       if (ret < 0) {
>           error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: ");
> -        return ret;
> +        return false;
>       }
>   
>       memset(vdev->emulated_config_bits + pos, 0xFF, 8);
> @@ -1608,7 +1608,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>       pci_set_byte(pdev->config + pos++, vdev->nv_gpudirect_clique << 3);
>       pci_set_byte(pdev->config + pos, 0);
>   
> -    return 0;
> +    return true;
>   }
>   
>   /*
> @@ -1629,7 +1629,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>    */
>   #define VMD_SHADOW_CAP_VER 1
>   #define VMD_SHADOW_CAP_LEN 24
> -static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
>   {
>       ERRP_GUARD();
>       uint8_t membar_phys[16];
> @@ -1639,7 +1639,7 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
>             vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x467F) ||
>             vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x4C3D) ||
>             vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x9A0B))) {
> -        return 0;
> +        return true;
>       }
>   
>       ret = pread(vdev->vbasedev.fd, membar_phys, 16,
> @@ -1647,14 +1647,14 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
>       if (ret != 16) {
>           error_report("VMD %s cannot read MEMBARs (%d)",
>                        vdev->vbasedev.name, ret);
> -        return -EFAULT;
> +        return false;
>       }
>   
>       ret = pci_add_capability(&vdev->pdev, PCI_CAP_ID_VNDR, pos,
>                                VMD_SHADOW_CAP_LEN, errp);
>       if (ret < 0) {
>           error_prepend(errp, "Failed to add VMD MEMBAR Shadow cap: ");
> -        return ret;
> +        return false;
>       }
>   
>       memset(vdev->emulated_config_bits + pos, 0xFF, VMD_SHADOW_CAP_LEN);
> @@ -1664,22 +1664,18 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
>       pci_set_long(vdev->pdev.config + pos, 0x53484457); /* SHDW */
>       memcpy(vdev->pdev.config + pos + 4, membar_phys, 16);
>   
> -    return 0;
> +    return true;
>   }
>   
> -int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    int ret;
> -
> -    ret = vfio_add_nv_gpudirect_cap(vdev, errp);
> -    if (ret) {
> -        return ret;
> +    if (!vfio_add_nv_gpudirect_cap(vdev, errp)) {
> +        return false;
>       }
>   
> -    ret = vfio_add_vmd_shadow_cap(vdev, errp);
> -    if (ret) {
> -        return ret;
> +    if (!vfio_add_vmd_shadow_cap(vdev, errp)) {
> +        return false;
>       }
>   
> -    return 0;
> +    return true;
>   }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 15823c359a..1254650d4a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2194,8 +2194,7 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>           vdev->emulated_config_bits[PCI_CAPABILITY_LIST] = 0xff;
>           vdev->emulated_config_bits[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
>   
> -        ret = vfio_add_virt_caps(vdev, errp);
> -        if (ret) {
> +        if (!vfio_add_virt_caps(vdev, errp)) {
>               return false;
>           }
>       }


