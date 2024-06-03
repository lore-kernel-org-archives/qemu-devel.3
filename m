Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6455FC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE88p-0006zS-Dr; Mon, 03 Jun 2024 09:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE88o-0006zJ-Jz
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE88n-00063l-02
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717422863;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01ZY/DzDPcsvRfg/LmsqTi0U7/0bCyxnMKeQH/X4d50=;
 b=hcVcsrbNMZ6ZiywfxgHPqWMDQyOtb2BgJkYhMjR0P3lUuK6XgFG2ayVBQ1DzwNUtk+6ly8
 dYo2gkMukaKHHLp58WDbFMGys8OAt7njjArSbKEt2kb8YJmpgEdH6+oGQR8pCqvvM126kM
 dmNMib8+L7bEmaIJaiT+1KnLMp+UAcw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-gajk7A2ZMYuD0LpEXUhuXA-1; Mon, 03 Jun 2024 09:54:22 -0400
X-MC-Unique: gajk7A2ZMYuD0LpEXUhuXA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35dcdb26f5eso2415760f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717422861; x=1718027661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01ZY/DzDPcsvRfg/LmsqTi0U7/0bCyxnMKeQH/X4d50=;
 b=RTjRqjvh+iheLsVXBnFU7GEfNsq9mTd9uwVZKgcrEke+uGUTMGxGkkLb5IUnIEszBI
 PaKbpOkG5ydasEnCabVo0RVuAzQQVxnPlf6cjsokfolVNpjpe8krxy8El1EKuq7thWKU
 fxA/xg1IDYmmBCxVF9JzAXDbkyqwGQlM8lCNaDpoZB/FtU8Kwv/VW3Z1v0hlyJ4ew4fD
 D1L9SQ96Ozts2O6M9FvB9TTSPwhjc9wFc5qUXVa1FAYgi2Ne+YRT1iGy/6MTPaldISG+
 ulH7CcFwXBpnn4x4ECAz+Gi/1GIqLmSn3WvL4KDsl/q8BzY7GrFyMoNLhdxRYziqDBhC
 uIfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY67T8gcg0hqkCA02QePZyD3SGCYnktZKIBuGsX77UzZO0WYlSrx7QwGftucsjqF+mmPdABdQnyNjMYGDJCP5ZSkAHSq4=
X-Gm-Message-State: AOJu0YyfRE3BjWlG2PmxP8MXsvQHnCs1A0nhGzFwRBUJ46CBKCvpQVoa
 ixlPvRuog0BcH5BmJ6Qv8LfeNHVkGfAx+tYhcDjYLXulcpveLrXid45updEm8Z72vThAtMrUaHd
 +0k0ReMfQj9EhuHRDz8SvUEnWoby/lJHv/y776D5bPmBKOxSvKpYR
X-Received: by 2002:a05:600c:1e12:b0:421:2a43:6518 with SMTP id
 5b1f17b1804b1-4212e0c12ddmr78094665e9.33.1717422861139; 
 Mon, 03 Jun 2024 06:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3SydLhD+Bu4it9P5AaXow4pJjthG2bAm8sE29MKd0LE2QG3g+VVl+yxeg0CaU/NTlIJ2LeQ==
X-Received: by 2002:a05:600c:1e12:b0:421:2a43:6518 with SMTP id
 5b1f17b1804b1-4212e0c12ddmr78094445e9.33.1717422860758; 
 Mon, 03 Jun 2024 06:54:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04e48b9sm8844838f8f.64.2024.06.03.06.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 06:54:20 -0700 (PDT)
Message-ID: <7e562724-a539-4cd5-8162-84f4aae4c772@redhat.com>
Date: Mon, 3 Jun 2024 15:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/19] vfio/pci: Pass HostIOMMUDevice to vIOMMU
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-17-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-17-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/3/24 08:10, Zhenzhong Duan wrote:
> With HostIOMMUDevice passed, vIOMMU can check compatibility with host
> IOMMU, call into IOMMUFD specific methods, etc.
>
> Originally-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/pci.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 74a79bdf61..d8a76c1ee0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3121,10 +3121,15 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>      vfio_bars_register(vdev);
>  
> -    if (!vfio_add_capabilities(vdev, errp)) {
> +    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
> +        error_prepend(errp, "Failed to set iommu_device: ");
>          goto out_teardown;
>      }
>  
> +    if (!vfio_add_capabilities(vdev, errp)) {
> +        goto out_unset_idev;
> +    }
> +
>      if (vdev->vga) {
>          vfio_vga_quirk_setup(vdev);
>      }
> @@ -3141,7 +3146,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>              error_setg(errp,
>                         "cannot support IGD OpRegion feature on hotplugged "
>                         "device");
> -            goto out_teardown;
> +            goto out_unset_idev;
>          }
>  
>          ret = vfio_get_dev_region_info(vbasedev,
> @@ -3150,11 +3155,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          if (ret) {
>              error_setg_errno(errp, -ret,
>                               "does not support requested IGD OpRegion feature");
> -            goto out_teardown;
> +            goto out_unset_idev;
>          }
>  
>          if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
> -            goto out_teardown;
> +            goto out_unset_idev;
>          }
>      }
>  
> @@ -3238,6 +3243,8 @@ out_deregister:
>      if (vdev->intx.mmap_timer) {
>          timer_free(vdev->intx.mmap_timer);
>      }
> +out_unset_idev:
> +    pci_device_unset_iommu_device(pdev);
>  out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
> @@ -3266,6 +3273,7 @@ static void vfio_instance_finalize(Object *obj)
>  static void vfio_exitfn(PCIDevice *pdev)
>  {
>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>  
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
> @@ -3280,7 +3288,8 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_teardown_msi(vdev);
>      vfio_pci_disable_rp_atomics(vdev);
>      vfio_bars_exit(vdev);
> -    vfio_migration_exit(&vdev->vbasedev);
> +    vfio_migration_exit(vbasedev);
> +    pci_device_unset_iommu_device(pdev);
>  }
>  
>  static void vfio_pci_reset(DeviceState *dev)
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


