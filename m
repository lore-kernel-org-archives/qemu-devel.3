Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E39AD29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhrwD-0003wI-OR; Mon, 19 Jan 2026 11:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhrw9-0003q0-Ip
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhrw5-0003ev-F6
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768839419;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xi1X6rkQoxNixq6jbHULaCA65UN8glv9KoT4WWVarcM=;
 b=C2/KYgCxz2ATfnVkr4BqhIMexHRdPAG3I1xP49XekQBsDNh/afZhlhmp/x88qajHAVJ2QG
 09RP5Kma6b31gFZsNgJzYGTV3PFOyYzIAnfUlMB9/z7bEqVWJyBG0D+AKFePNduYe3crAb
 C861hL6mgodoXsFj+w5PWaWorMqekY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-WO0ayB2TO_uqOgrZ5iPWFw-1; Mon, 19 Jan 2026 11:16:55 -0500
X-MC-Unique: WO0ayB2TO_uqOgrZ5iPWFw-1
X-Mimecast-MFC-AGG-ID: WO0ayB2TO_uqOgrZ5iPWFw_1768839414
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so40184575e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 08:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768839414; x=1769444214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xi1X6rkQoxNixq6jbHULaCA65UN8glv9KoT4WWVarcM=;
 b=H3qWT1unPJqZYnakSObPm+/fbOh79ypHHB0dOUK/sDxRtuR/5MVZGY9OmkRLXZAscu
 oyZYJhAL4eIhIUc1TxrkmNZ8Z0dVYfEquHdrd4YK/GZ0HRstmeZHBd4EMqVwftPl5Kx1
 Ojc7WvGPRB+GFrcMvysHdYCno6ZuOSyQAnKYDwkwWzwdiV7qAMn8hkMenuMjLTQHiPGf
 FSi3r9MpyWCos8LbuqObamdfnrWyF+JYC54UewlasBgqatVqrXFP/57SlCakdT/0fmp3
 +xFWC+ZS6iSrx7mSwDJFyGlOVVJI400c5GsrQBY2xoRLK97jJRcFKeskWb+MrnYlhaNO
 2Lnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB8jRcYTGyKOOz7uQOz+gGlZY5jLs5Nvq40dcVvx83lBPC6VEUuMu1TJZdZ6d0nYBws6BBC4LhQAZ9@nongnu.org
X-Gm-Message-State: AOJu0YzzFkyZ3aCsZx8AcgssSza1KUYkzLVwbkoy6IuGlkiCUVXrgAPw
 hGPail+lRvTMBuc/7JTS5hb3Ermyh8GRAmmT+X8lUp/7lTyXFOx5x59d8jI9NfdA0QktngBDym6
 nyZV9r7N6uXx5Gks/qaZoSdGyU4VmbJIAwVQLpqxLDKv/FeFT8uCUzkuN
X-Gm-Gg: AY/fxX78zkU7VQVJRhOH2doaeYqFMAJQ5xBbM2K7ExXIoriJVGuxvySsP6CoPnK4frs
 0BmODR6O7hRyLQ8wzakjxsz77XH5cwHkYfeCdOReUCqrWFG2RmfPpdYJNkvW15CxqMfB6FzKus9
 ivpYSuTTBATxcsefUrMp4+FrTOMfS4k3058mHXvmZC23G13g5NpoDIYu63tEDkz8e3nFEv5txJw
 +gCtlsYY1u7D/kpsZqPgP0cmFa/e9GIm+r0npQwT+9MkPAYDefJAR0ApNyU4LH6I4gBKEVKB/Cx
 IETHAeqrkwU5S9QpqH2s2m/U2dMBWeVjIfLJaHA65QHzBQTjYF04wsjVfQyq7srK5vElz3SWfZz
 mCaXXF/hv3ctGNlgFLsSd7XOfgahtuQ+qjpEylqm5Ib29ohduvmTmlSo0mg==
X-Received: by 2002:a05:600c:6215:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-4801e3388b6mr137977365e9.18.1768839413562; 
 Mon, 19 Jan 2026 08:16:53 -0800 (PST)
X-Received: by 2002:a05:600c:6215:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-4801e3388b6mr137976925e9.18.1768839413102; 
 Mon, 19 Jan 2026 08:16:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm24946343f8f.6.2026.01.19.08.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 08:16:52 -0800 (PST)
Message-ID: <d285998e-0250-40eb-97a3-996d5471abac@redhat.com>
Date: Mon, 19 Jan 2026 17:16:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-36-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260111195508.106943-36-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On 1/11/26 8:53 PM, Shameer Kolothum wrote:
> Add support for synthesizing a PCIe PASID extended capability for
> vfio-pci devices when PASID is enabled via a vIOMMU and supported by
> the host IOMMU backend.
>
> PASID capability parameters are retrieved via IOMMUFD APIs and the
> capability is inserted into the PCIe extended capability list using
> the insertion helper. A new x-vpasid-cap-offset property allows
> explicit control over the placement; by default the capability is
> placed at the end of the PCIe extended configuration space.
>
> If the kernel does not expose PASID information or insertion fails,
> the device continues without PASID support.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/vfio/pci.c           | 84 +++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h           |  1 +
>  include/hw/core/iommu.h |  1 +
>  3 files changed, 86 insertions(+)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c734472721..96990576ac 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -24,6 +24,7 @@
>  #include <sys/ioctl.h>
>  
>  #include "hw/core/hw-error.h"
> +#include "hw/core/iommu.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  #include "hw/pci/pci_bridge.h"
> @@ -2498,9 +2499,71 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
>      return 0;
>  }
>  
> +/*
> + * Try to retrieve PASID capability information via IOMMUFD APIs and,
> + * if supported, synthesize a PASID PCIe extended capability for the
> + * VFIO device.
> + *
> + * Use user-specified PASID capability offset if provided, otherwise
> + * place it at the end of the PCIe extended configuration space.
> + */
> +static void vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev)
> +{
> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
> +    HostIOMMUDeviceClass *hiodc;
> +    PasidInfo pasid_info;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint16_t pasid_offset;
> +
> +    if (vdev->vbasedev.mdev) {
> +        return;
> +    }
> +
> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    if (!hiodc || !hiodc->get_pasid_info ||
> +        !hiodc->get_pasid_info(hiod, &pasid_info) ||
> +        !(pci_device_get_viommu_flags(pdev) & VIOMMU_FLAG_PASID_SUPPORTED)) {
> +        return;
> +    }
> +
> +    /*
> +     * Check if user has specified an offset to place PASID CAP,
> +     * else select the last offset as default
> +     */
> +    if (vdev->vpasid_cap_offset) {
> +        if (!QEMU_IS_ALIGNED(vdev->vpasid_cap_offset, PCI_EXT_CAP_ALIGN) ||
For other checks you put an assert i pcie_insert_capability()
> +            vdev->vpasid_cap_offset < PCI_CONFIG_SPACE_SIZE ||
> +            vdev->vpasid_cap_offset + PCI_EXT_CAP_PASID_SIZEOF >
> +                PCIE_CONFIG_SPACE_SIZE) {
> +            error_report("vfio: invalid x-vpasid-cap-offset 0x%x, skipping PASID",
> +                        vdev->vpasid_cap_offset);
> +            return;
> +        }
> +        pasid_offset = vdev->vpasid_cap_offset;
> +    } else {
> +        pasid_offset = PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF;
> +        warn_report("vfio: PASID capability offset(x-vpasid-cap-offset) not specified, "
> +                    "placing at the default offset 0x%x",
> +                    pasid_offset);
I am not sure we want a warn_report() if this is a normal behavior. Add
a trace point instead?
> +    }
> +
> +    if (!pcie_insert_capability(pdev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER,
> +                                pasid_offset, PCI_EXT_CAP_PASID_SIZEOF)) {
> +        error_report("vfio: Placing PASID capability at offset 0x%x failed",
> +                     pasid_offset);
instead of having asserts in pcie_insert_capability() you could
factorize all checks there including the 4B alignment check and return
false if any fails. Then you could propably get rifd of above checks
which are partially redundant. Thanks Eric
> +    }
> +    pcie_pasid_common_init(pdev, pasid_offset, pasid_info.max_pasid_log2,
> +                           pasid_info.exec_perm, pasid_info.priv_mod);
> +
> +    /* PASID capability is fully emulated by QEMU */
> +    memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff,
> +           PCI_EXT_CAP_PASID_SIZEOF);
> +}
> +
>  static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>  {
>      PCIDevice *pdev = PCI_DEVICE(vdev);
> +    bool pasid_cap_added = false;
>      uint32_t header;
>      uint16_t cap_id, next, size;
>      uint8_t cap_ver;
> @@ -2578,12 +2641,24 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>                  pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>              }
>              break;
> +        /*
> +         * VFIO kernel does not expose the PASID CAP today. We may synthesize
> +         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
> +         * record its presence here so we do not create a duplicate CAP.
> +         */
> +        case PCI_EXT_CAP_ID_PASID:
> +            pasid_cap_added = true;
> +            /* fallthrough */
>          default:
>              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>          }
>  
>      }
>  
> +    if (!pasid_cap_added) {
> +        vfio_pci_synthesize_pasid_cap(vdev);
> +    }
> +
>      /* Cleanup chain head ID if necessary */
>      if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
>          pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
> @@ -3756,6 +3831,8 @@ static const Property vfio_pci_properties[] = {
>                       TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>  #endif
>      DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
> +    DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
> +                       vpasid_cap_offset, 0),
>  };
>  
>  #ifdef CONFIG_IOMMUFD
> @@ -3913,6 +3990,13 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>                                            "destination when doing live "
>                                            "migration of device state via "
>                                            "multifd channels");
> +   object_class_property_set_description(klass, /* 11.0 */
> +                                          "x-vpasid-cap-offset",
> +                                          "PCIe extended configuration space offset at which to place a "
> +                                          "synthetic PASID extended capability when PASID is enabled via "
> +                                          "a vIOMMU. A value of 0 (default) places the capability at the "
> +                                          "end of the extended configuration space. The offset must be "
> +                                          "4-byte aligned and within the PCIe extended configuration space");
>  }
>  
>  static const TypeInfo vfio_pci_info = {
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 0f78cf9cdb..d6495d7f29 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -187,6 +187,7 @@ struct VFIOPCIDevice {
>      bool defer_kvm_irq_routing;
>      bool clear_parent_atomics_on_exit;
>      bool skip_vsc_check;
> +    uint16_t vpasid_cap_offset;
>      VFIODisplay *dpy;
>      Notifier irqchip_change_notifier;
>      VFIOPCICPR cpr;
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> index 9b8bb94fc2..9635770bee 100644
> --- a/include/hw/core/iommu.h
> +++ b/include/hw/core/iommu.h
> @@ -20,6 +20,7 @@
>  enum viommu_flags {
>      /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>      VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
> +    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
>  };
>  
>  #endif /* HW_IOMMU_H */


