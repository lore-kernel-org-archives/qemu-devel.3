Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EB1D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSuOB-0002lk-To; Tue, 09 Dec 2025 04:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSuO9-0002lM-JI
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:52:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSuO7-0000ti-G7
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765273925;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMOm/8gHRD8IZN8UblCC2X59Td222VnJrV4m5M6iU28=;
 b=SOhXjnbLO4lGZaSGnLtYj0ErJrufWsW9N7ukVxpliRvetDz9dQBOIBkvgNytorRLQA2Kjo
 DiMFI1xSyZQKihF1Zxy3vY/92GWNbkp7bc02TIxLxKiXYXgpCPkDYkgv8eMt/+xVmGmRUI
 lnDq/3nGI4YgY/e08LrmErayFwSzxbA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-vP4Z1d2KOzKuRsyhkkebrw-1; Tue, 09 Dec 2025 04:52:03 -0500
X-MC-Unique: vP4Z1d2KOzKuRsyhkkebrw-1
X-Mimecast-MFC-AGG-ID: vP4Z1d2KOzKuRsyhkkebrw_1765273923
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b245c49d0cso705704285a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 01:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765273922; x=1765878722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMOm/8gHRD8IZN8UblCC2X59Td222VnJrV4m5M6iU28=;
 b=UjPRBNFNqWlcmFCgsLEvWg++mcqDpduNg+vwJHGY59uD9iOnoQdpv2sV2uP4pkKidQ
 zKRSY3F8Kt7YzaSLJAdN1NFo+vAlqez48Xdxqaz83YVYH7QhbrHPqUwtqZ9V1AlXauWs
 yCHhCBP6QaiEsEmkfgQxjWI3VPVlknZaVIJ4al/NP7mcfoA9VCUcy0zd5JuAMG9/GXwD
 M48HncgtTMsyFgIglHtcWHg1ldLWwRpmFW0/LO1bh5NiG/BENrA4f7gyL0luB88upE2S
 sFZ+xdLVQbSwdFM6pkR/ssRdYM5wlHQfLyEDeXuDBEgQpF8Far6rJ9Nhk8nDLMXU8db5
 /X9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvdUtCkJH+uKmea4I8gvQ0NCL8M4nSD0sWqmcyrxVMAfytsiwRMRoulHQ4Er5RrP/Zrm4hx3DxE3Pl@nongnu.org
X-Gm-Message-State: AOJu0YyxhMCzZSCjUfkL2KrAgOd6DbA5imILDzfVpqUZC9sqvdHFE3g6
 q+8IerdF0KmPUP40Tc9GTZYE6De5k/m3/aMKylkWfgRl9+bUMa53W7m5jNK9WeRUPMBYy6k2AHv
 HgtujmaHvl6Tnm2BFJfy530e+FBEMAKH6fK7W0+cQqzzWD7lpqDSOdUsxno/4Uus/
X-Gm-Gg: ASbGncvQcYqVS0MKtsiJDeqxf+wGQrR9/EUkOrVYan+2cLcwDVG0bzofcez0isTftv+
 OeRy/mOC4POKnA0fKVtV+FcCHgQWqVxhB7W+UUVwQx5q3A+8gCid2O0CivcJnHClpL9ZNX1eQ1L
 kzXO6YNzEF7ijWbuxAOqbtSPoMT3fKKfjZh9iDFbYhUMbUEqoemiZ9VIvOyxkoYOosmf549Yj9W
 Ni0VgCwG27JiBMuXvC0fhBT+emPqIIv8C/ijHz2x5Rxw7qeTVSwI48Td/s6jhyxxke+iEa61gQJ
 1XyacQpzIdgNMc1rQXOAZQBBE98EXJXmkKGDagQvoFlTrm7QEzlvFmVFsZkkQKRsdyNY+mQy698
 rA0BQsqdejoy6RGiO2h59+eO3aNNrwv27iiymt/D+VoLvbf4C23hu1VkZpg==
X-Received: by 2002:a05:6214:e45:b0:880:480c:6054 with SMTP id
 6a1803df08f44-8883dae5a3amr140038646d6.19.1765273922464; 
 Tue, 09 Dec 2025 01:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRHWDGAG22ACgpv5Od67zNINTP3pD/RM19h0J49n22gkEXHkm2L3Zqs7vzirTQ0dwmBDsZZg==
X-Received: by 2002:a05:6214:e45:b0:880:480c:6054 with SMTP id
 6a1803df08f44-8883dae5a3amr140038476d6.19.1765273921911; 
 Tue, 09 Dec 2025 01:52:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f4dcd3sm128468716d6.19.2025.12.09.01.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 01:51:59 -0800 (PST)
Message-ID: <7dc608a7-b36b-4250-befd-d26115b54e26@redhat.com>
Date: Tue, 9 Dec 2025 10:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-33-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251120132213.56581-33-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,
On 11/20/25 2:22 PM, Shameer Kolothum wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> If user wants to expose PASID capability in vIOMMU, then VFIO would also
> need to report the PASID cap for this device if the underlying hardware
> supports it as well.
>
> As a start, this chooses to put the vPASID cap in the last 8 bytes of the
> vconfig space. This is a choice in the good hope of no conflict with any
> existing cap or hidden registers. For the devices that has hidden registers,
> user should figure out a proper offset for the vPASID cap. This may require
> an option for user to config it. Here we leave it as a future extension.
> There are more discussions on the mechanism of finding the proper offset.
>
> https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com/
>
> Since we add a check to ensure the vIOMMU supports PASID, only devices
> under those vIOMMUs can synthesize the vPASID capability. This gives
> users control over which devices expose vPASID.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/vfio/pci.c      | 38 ++++++++++++++++++++++++++++++++++++++
>  include/hw/iommu.h |  1 +
>  2 files changed, 39 insertions(+)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8b8bc5a421..e11e39d667 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -24,6 +24,7 @@
>  #include <sys/ioctl.h>
>  
>  #include "hw/hw.h"
> +#include "hw/iommu.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci_bridge.h"
> @@ -2500,7 +2501,12 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
>  
>  static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>  {
> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>      PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint64_t max_pasid_log2 = 0;
> +    bool pasid_cap_added = false;
> +    uint64_t hw_caps;
>      uint32_t header;
>      uint16_t cap_id, next, size;
>      uint8_t cap_ver;
> @@ -2578,12 +2584,44 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>                  pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>              }
>              break;
> +        /*
> +         * VFIO kernel does not expose the PASID CAP today. We may synthesize
> +         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
> +         * record its presence here so we do not create a duplicate CAP.
> +         */
> +        case PCI_EXT_CAP_ID_PASID:
> +             pasid_cap_added = true;
> +             /* fallthrough */
>          default:
>              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>          }
>  
>      }
>  
> +#ifdef CONFIG_IOMMUFD
> +    /* Try to retrieve PASID CAP through IOMMUFD APIs */
> +    if (!pasid_cap_added && hiodc && hiodc->get_cap) {
> +        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_GENERIC_HW, &hw_caps, NULL);
> +        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2,
> +                       &max_pasid_log2, NULL);
> +    }
> +
> +    /*
> +     * If supported, adds the PASID capability in the end of the PCIe config
> +     * space. TODO: Add option for enabling pasid at a safe offset.
> +     */
> +    if (max_pasid_log2 && (pci_device_get_viommu_flags(pdev) &
> +                           VIOMMU_FLAG_PASID_SUPPORTED)) {
> +        bool exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
> +        bool priv_mod = (hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
> +
> +        pcie_pasid_init(pdev, PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF,
> +                        max_pasid_log2, exec_perm, priv_mod);
> +        /* PASID capability is fully emulated by QEMU */
> +        memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff, 8);
> +    }
> +#endif
> +
>      /* Cleanup chain head ID if necessary */
>      if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
>          pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> index 9b8bb94fc2..9635770bee 100644
> --- a/include/hw/iommu.h
> +++ b/include/hw/iommu.h
> @@ -20,6 +20,7 @@
>  enum viommu_flags {
>      /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>      VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
> +    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
>  };
>  
>  #endif /* HW_IOMMU_H */
Besides the fact the offset is arbitrarily chosen so that this is the
last cap of the vconfig space, the code looks good to me.
So
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Just wondering whether we couldn't add some generic pcie code that
parses the extended cap linked list to check the offset range is not
used by another cap before allowing the insertion at a given offset?
This wouldn't prevent a subsequent addition from failing but at least we
would know if there is some collision.this could be added later on though.

Thanks

Eric


