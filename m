Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE898C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 19:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHp2A-0001gc-Hi; Wed, 21 May 2025 15:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uHp28-0001bt-5d
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uHp25-0001Yn-Os
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747855392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgOUUTS27w8X/x4WKuk+RDUn1UyE517Ia7vHkYfNYUY=;
 b=aXWLzVPX0TQ8QAITgxFqXnbL3kqqn9qQ4TXeYxQimP6XvxjSy+t+I2l/YjSqbSKFZsbJ+k
 EmqekyeIwF3G3YKg6fTIDvUGGY72HWWpNgzBMUmEd9N2MgR645jUQqVz2C5VZv5molkH9K
 IN36YJMktRdGAQ8XJyZWlrhB1keGBFU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-V-dkkGC-McSlbChMJNgQFw-1; Wed, 21 May 2025 15:23:10 -0400
X-MC-Unique: V-dkkGC-McSlbChMJNgQFw-1
X-Mimecast-MFC-AGG-ID: V-dkkGC-McSlbChMJNgQFw_1747855390
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-85b3e93e052so127807939f.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 12:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747855390; x=1748460190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgOUUTS27w8X/x4WKuk+RDUn1UyE517Ia7vHkYfNYUY=;
 b=tCMqC3itGtRJLadMmVYk0hpvJSubwZKBvTNbxV86mZwQrPwVE5as0qfApDLg3cnjYU
 6urkI+GnxDDTvL5JHAVG9rG9BOK5Vh04uq7hSq6doyqSvvzKhp4xuCVjxDF/o86ZqHNE
 4C1CHbA1oNFqXrTwV1OQF67U0JG/wIN3+gbY7D7Gq3NBjEsNe5jgKCssms/eJXvr5LFD
 KFNMLBZ+/NGm2hKatnYJd5X4Hjut6SJDc7b/R4yaxQy3KNVosQm5nTq1NlVZp8Vn+rZN
 E/lhQLLpC7ysx4ZEjb1qZYufI7TflkAp6n4NdG+J8EZ/PQSnCybzt4jjTh+qYy3uhtDm
 5ljw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSA/Pv7j7DbEXHIvxwHNofZ4MqApji1nxNOIcdNJqpCNEutHIMgBh8clpK/lm/mtvQ8y6na8Nqz/1P@nongnu.org
X-Gm-Message-State: AOJu0YzBqAmjUDjjLEE+lFzFT3baMvNl46QX/JvYMVxAEmIn7zRmaWot
 tcZYwhylP0GqkHQjZ+JIgzaRLb6VODmwSKX1eLVEpnCZN83IVGSEM21oro1HaoHzsrlZn2iDT61
 l4cuaAFueaoTy56IROhaeNTbzZazHJuxHGJY+u4JWca6e5sydnph/VzOE
X-Gm-Gg: ASbGncu0+jHnm14nyKEnfaZ9Zx/VaQJ21PkAGN+wakW3NLsKo9TPxDVsCiqkqY/4S6o
 jd9bB6ohhEbqKx5fK2BQLgoRdF1qnumoKmHJvqgpmlVtPAYP9Wul2xSQolI2k/cuaksUFyqMTX3
 KZ6gnPzIFg5g0merbkdpL08Cgd+L3c8e3JUkrz67LEgQ+j5ZjkB+WYuXWkLMm645KBef3L0O2TT
 few3JJtt4tJmbzZgVmG4ScQzpjTaRKxZGDYNmQYdeEqzVKVCKfSu7big2lYyVCZT5AFUY1Y0UzP
 ua+QES095deHUHE=
X-Received: by 2002:a05:6e02:144c:b0:3dc:87c7:a5a5 with SMTP id
 e9e14a558f8ab-3dc87c7a7cemr9491615ab.5.1747855389793; 
 Wed, 21 May 2025 12:23:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Q/TKG6OCbxOdHkQkcz+A5wYk94AivdlSiqSzQBGlKDp4g2fcbMjSk9zuPllcYq5vEanIRQ==
X-Received: by 2002:a05:6e02:144c:b0:3dc:87c7:a5a5 with SMTP id
 e9e14a558f8ab-3dc87c7a7cemr9491525ab.5.1747855389405; 
 Wed, 21 May 2025 12:23:09 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b1c78sm2960500173.57.2025.05.21.12.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 12:23:08 -0700 (PDT)
Date: Wed, 21 May 2025 13:23:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>,
 edmund.raile@proton.me, Edmund Raile <edmund.raile@protonmail.com>
Subject: Re: [PATCH] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Message-ID: <20250521132307.35210a3b.alex.williamson@redhat.com>
In-Reply-To: <20250521154036.28219-1-tomitamoeko@gmail.com>
References: <20250521154036.28219-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 21 May 2025 23:40:36 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> In vfio_pci_igd_opregion_detect(), errp will be set when device does
> not have OpRegion or is hotplugged. This errp will be propergated to

propagated

> pci_qdev_realize(), which interprets it as failure, causing unexpected
> termination on devices without OpRegion like SR-IOV VFs or discrete
> GPUs. Fix it by not setting errp in vfio_pci_igd_opregion_detect().
> 
> This patch also checks if the device has OpRegion before hotplug status
> to prvent unwanted warning messages on non-IGD devices.
> 
> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
> Reported-by: Edmund Raile <edmund.raile@protonmail.com>
> Link: https://lore.kernel.org/qemu-devel/30044d14-17ec-46e3-b9c3-63d27a5bde27@gmail.com
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e7952d15a0..e7a9d1ffc1 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -187,23 +187,21 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>  }
>  
>  static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
> -                                         struct vfio_region_info **opregion,
> -                                         Error **errp)
> +                                         struct vfio_region_info **opregion)
>  {
>      int ret;
>  
> -    /* Hotplugging is not supported for opregion access */
> -    if (vdev->pdev.qdev.hotplugged) {
> -        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
> -        return false;
> -    }
> -
>      ret = vfio_device_get_region_info_type(&vdev->vbasedev,
>                      VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>                      VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
>      if (ret) {
> -        error_setg_errno(errp, -ret,
> -                         "Device does not supports IGD OpRegion feature");
> +        return false;
> +    }
> +
> +    /* Hotplugging is not supported for opregion access */
> +    if (vdev->pdev.qdev.hotplugged) {
> +        warn_report("IGD device detected, but OpRegion is not supported "
> +                    "on hotplugged device.");
>          return false;
>      }
>  
> @@ -524,7 +522,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      }
>  
>      /* IGD device always comes with OpRegion */
> -    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> +    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>          return true;
>      }
>      info_report("OpRegion detected on Intel display %x.", vdev->device_id);
> @@ -695,7 +693,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          return true;
>      }
>  
> -    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> +    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>          /* Should never reach here, KVMGT always emulates OpRegion */
>          return false;
>      }


