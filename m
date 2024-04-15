Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFD5C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMX4-00063y-TW; Mon, 15 Apr 2024 09:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMWx-00061n-QU
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMWt-0004HH-1H
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713188270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Otby01cZZu++YmW/6+3uGCtE2y6g9ZUJlqPrv0gkNDg=;
 b=DMOtW4C1ViDn1FPlkXqoMBgBtblRlVu1eQd95pkdp2h2AxJLe9J4pSdOJMEf1C1lK2WLLT
 ARot0xkRb7j2EUhVeDuZSpYCuXG0dNtpTWLwffGAWtkmroZDV7M1WPtiB2cr0mXR3cIYXb
 hOFXlJsnA+s4rZtSJpru/Fx+/EYrG4c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-fHMGT9tqNi6lg_xKa-T95Q-1; Mon, 15 Apr 2024 09:37:49 -0400
X-MC-Unique: fHMGT9tqNi6lg_xKa-T95Q-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78ecaccfda5so331540485a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 06:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713188268; x=1713793068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Otby01cZZu++YmW/6+3uGCtE2y6g9ZUJlqPrv0gkNDg=;
 b=gnPAh3AO++8IPm/KHRvOLu8beACLQiox9o36nqOlDFGxbqiiUD1K+Ji7y+RG8xxvi6
 0e76k/uGyMbRg7INfHBAkafu4Jd+IX7cl6lUSg30KRBrHw0kN9zSslYUtL9TYb7rQOCX
 MMYIiHLS4SVAfeQwOkSebVNgaqRfM0AAH/7B8Puu1kYCvq1SBqeuHf9Coy27OMvThMel
 1nuZrWAu81g8deWaCK5abR5kt+XZCHbWUITWMJv1K8QIFe7VIepPDBRy2MIQ7xaXE6Pm
 jK5ysQ3/tHGFn8A4Xnc6+LcTRp92u+9uD4OWtxKbFvNnUU7dq4hwqnmYckbXJso95hzt
 S+Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRu/hzfRVzBHc5xruCAvXKd01ZyoQVzWG71K6F3yEn0AsTrt2MHpvopmtPjl/A6oc63w+S6ycYq8El47IY24pecEfHBzw=
X-Gm-Message-State: AOJu0Yy7g7ECnzmh6JkGX8sJIvSm63LFoPLEMm07cBJnfRNik2aVrAQI
 M6My+5Hboh0LEmMHRrfPy23pBEs3WpDLsYVH5cCyzXI4LOH5f1vP7MhTZS13K0j0cvyUbZp3V9P
 gQ2w8Shjf2CFPRlcR++gASNREOH/XMmagtxS5moz+dlENscoZCVTD
X-Received: by 2002:ae9:e201:0:b0:78d:646d:e2e7 with SMTP id
 c1-20020ae9e201000000b0078d646de2e7mr11026052qkc.66.1713188268394; 
 Mon, 15 Apr 2024 06:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHutCgrPI6+hYMGifyLmudnASBYdRAuSjyAoOEqLoRUciGSIJEVoyHvxHSDIBWW84TkQNgnsw==
X-Received: by 2002:ae9:e201:0:b0:78d:646d:e2e7 with SMTP id
 c1-20020ae9e201000000b0078d646de2e7mr11025981qkc.66.1713188267204; 
 Mon, 15 Apr 2024 06:37:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 e20-20020a05620a209400b0078edc0a447dsm2902548qka.68.2024.04.15.06.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 06:37:46 -0700 (PDT)
Message-ID: <b635938a-0cfe-40f9-a51d-c4f3f17bed89@redhat.com>
Date: Mon, 15 Apr 2024 15:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] vfio: Pass HostIOMMUDevice to vIOMMU
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-11-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On 4/8/24 10:12, Zhenzhong Duan wrote:
> With HostIOMMUDevice passed, vIOMMU can check compatibility with host
> IOMMU, call into IOMMUFD specific methods, etc.
> 
> Originally-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

LGTM, waiting v3.


Thanks,

C.




> ---
>   hw/vfio/pci.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b79..224501a86e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3111,11 +3111,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       vfio_bars_register(vdev);
>   
> -    ret = vfio_add_capabilities(vdev, errp);
> +    ret = pci_device_set_iommu_device(pdev, vbasedev->hiod, errp);
>       if (ret) {
> +        error_prepend(errp, "Failed to set iommu_device: ");
>           goto out_teardown;
>       }
>   
> +    ret = vfio_add_capabilities(vdev, errp);
> +    if (ret) {
> +        goto out_unset_idev;
> +    }
> +
>       if (vdev->vga) {
>           vfio_vga_quirk_setup(vdev);
>       }
> @@ -3132,7 +3138,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>               error_setg(errp,
>                          "cannot support IGD OpRegion feature on hotplugged "
>                          "device");
> -            goto out_teardown;
> +            goto out_unset_idev;
>           }
>   
>           ret = vfio_get_dev_region_info(vbasedev,
> @@ -3141,13 +3147,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           if (ret) {
>               error_setg_errno(errp, -ret,
>                                "does not support requested IGD OpRegion feature");
> -            goto out_teardown;
> +            goto out_unset_idev;
>           }
>   
>           ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
>           g_free(opregion);
>           if (ret) {
> -            goto out_teardown;
> +            goto out_unset_idev;
>           }
>       }
>   
> @@ -3233,6 +3239,8 @@ out_deregister:
>       if (vdev->intx.mmap_timer) {
>           timer_free(vdev->intx.mmap_timer);
>       }
> +out_unset_idev:
> +    pci_device_unset_iommu_device(pdev);
>   out_teardown:
>       vfio_teardown_msi(vdev);
>       vfio_bars_exit(vdev);
> @@ -3261,6 +3269,7 @@ static void vfio_instance_finalize(Object *obj)
>   static void vfio_exitfn(PCIDevice *pdev)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_unregister_req_notifier(vdev);
>       vfio_unregister_err_notifier(vdev);
> @@ -3275,7 +3284,8 @@ static void vfio_exitfn(PCIDevice *pdev)
>       vfio_teardown_msi(vdev);
>       vfio_pci_disable_rp_atomics(vdev);
>       vfio_bars_exit(vdev);
> -    vfio_migration_exit(&vdev->vbasedev);
> +    vfio_migration_exit(vbasedev);
> +    pci_device_unset_iommu_device(pdev);
>   }
>   
>   static void vfio_pci_reset(DeviceState *dev)


