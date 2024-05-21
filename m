Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96891C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OvI-0005hK-FE; Tue, 21 May 2024 08:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OvF-0005dj-Uf
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OvD-00052B-EF
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716295730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6y5dYgSMPeFYxJEukOEYTrv7kXEMx7BjZPG+urXXj0=;
 b=W+92JFOJRfbQYeW0ElNJmpQsUKuodIJX8BkytOjI6zqAfRsks0FEHAhhJh/UQu5G0D1yOY
 igBJClu/iHHqyOGBm26d6TBgnyQdjEHTYX+TYWwXBVlmA36VJaVAEBBiad0uEfBYhz++I4
 EeIkRg1/g8PUeiIbVqPmc3UYJqm2D08=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-JDKtWNngPAS64ks-KbZNmg-1; Tue, 21 May 2024 08:48:46 -0400
X-MC-Unique: JDKtWNngPAS64ks-KbZNmg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5733eed0c19so33605a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295719; x=1716900519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6y5dYgSMPeFYxJEukOEYTrv7kXEMx7BjZPG+urXXj0=;
 b=dt2LPUeadOf5ZvkPtLS0+/WxXsgyPXEykSPGHsNQElSPjeAPl6BZy2CnmTu2NiBARD
 kqlPNfhKUSeJ/QFUtaSvSkWFRiKZRzkWieDMbIW+PrarnSKcrire407so1xoSEFZBFxT
 pu0JN0YLvIRpCNIupjWO0CmL0cbT/YIecpHIxaUzw6fMf2A3TAugWm6w3wDxEikntkND
 X0lD6V6Ct4B/rle/+syNoxrUP2CpkcksoVxvHp9QE3tCvup8wpAu9isxX6TYyk/b6lWG
 U6ur9vy6LO8AI8jMDugIs5QwR6NOIwkROKCmrwvWhUVC3K+W4w6IKlLE+XOHAwzN5HBy
 tXGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8e+UiyVWEn1AL2INmvFHZ7Z9ZQOWPiH7Iv7ypGcKI7g973uuDfTpV6gWbWier1YjdkDPsyNIt8sNC9hW9mG22IuHtK48=
X-Gm-Message-State: AOJu0YwcupV9inh0T2xbDW7zt9+UJbID2m2UY/2sWsy9zmCPuAlAuvGK
 lZlx7H7g/Sb7dxZfRALwpgeGt0+SK8uLkIFRgtn6GJaY7ytw6v1CzRCIzdmyhWywYDILoZEfgMF
 1Ovn7egbgxaSf0EiXuBXPLKMIORgMDDXR54KJeTq1c88gSLBZD3NM
X-Received: by 2002:a50:9f21:0:b0:572:71b3:3c4d with SMTP id
 4fb4d7f45d1cf-5734d67ae60mr20485573a12.34.1716295719247; 
 Tue, 21 May 2024 05:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrcJ2ETe28A2kOTag4kMAUvIfppXv9p1t6u23ZVmVexLN7yK24o7kdHTmKGT79qU8JkZJJDQ==
X-Received: by 2002:a50:9f21:0:b0:572:71b3:3c4d with SMTP id
 4fb4d7f45d1cf-5734d67ae60mr20485554a12.34.1716295718891; 
 Tue, 21 May 2024 05:48:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57509558cdasm6974522a12.59.2024.05.21.05.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:48:38 -0700 (PDT)
Message-ID: <b9f6a9d2-cd52-4935-a806-2c3a3add37e3@redhat.com>
Date: Tue, 21 May 2024 14:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] vfio/pci: Use g_autofree for vfio_region_info
 pointer
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-15-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
> Pointer opregion is freed after vfio_pci_igd_opregion_init().
> Use 'g_autofree' to avoid the g_free() calls.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ecfbb9619f..be87478716 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3146,7 +3146,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       if (!vdev->igd_opregion &&
>           vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
> -        struct vfio_region_info *opregion;
> +        g_autofree struct vfio_region_info *opregion = NULL;
>   
>           if (vdev->pdev.qdev.hotplugged) {
>               error_setg(errp,
> @@ -3165,7 +3165,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           }
>   
>           ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
> -        g_free(opregion);
>           if (ret) {
>               goto out_teardown;
>           }


