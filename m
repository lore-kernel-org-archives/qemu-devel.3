Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8405FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJvIg-0006hA-Rj; Mon, 04 May 2026 11:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJvIQ-0006eS-9T
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJvIM-0002r4-3I
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777908796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XLAd5nTIsX705bo8LdHWp6/7O8o3feme8ncu8h+9m4=;
 b=EZvCCu2k6FLpRyj9lhkXd9iFGtwQeA/4d9FbFYASO8WzVTfLdddfNSL2OEVgcDdKgsFxaY
 J8xLDrCwChQN9utl2lwMf/YqwP2BAFkp2VIk8jQwp99mla+5eRxaHk7ZwBAqU8r78t125s
 iv0tLSttDAbsnDvCeFopqYgsJ4Mp2oU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-qTq70BzMP9KeesoPUcLamA-1; Mon, 04 May 2026 11:33:15 -0400
X-MC-Unique: qTq70BzMP9KeesoPUcLamA-1
X-Mimecast-MFC-AGG-ID: qTq70BzMP9KeesoPUcLamA_1777908794
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48d05e7b117so10857805e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777908794; x=1778513594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XLAd5nTIsX705bo8LdHWp6/7O8o3feme8ncu8h+9m4=;
 b=WfFvL3dDMuVSy9kCRs0CUes4oKwjEdhSwi+dQSqNiwpN/dFdxYf4Y/hoilBK3EAv9Q
 4UeMSTwlTwx/DSWXvQD3klhDnmRpVFkLSWKezqUXO5Y3iuvJ+y+/lJF6n207VVdPRJdp
 0AzQVOXkMJ9Ez5YIL4a8tGIiIyzge9cIr+GJ0Ask/6/ZeuEXjao0z0s06PkD4IKUrhJc
 UhFH8wxcy3GO7Xe1+TrWWpulbw87lxcxeqis74vEgeYligukGqwxSoHuHULw/u0ILQlW
 O14n0AgdQt/PQ5tP37z29qGLBevRUQ7YdaTXULt5SKv14BDvxHGuR+gWRzGPUEkvtpFs
 Yiug==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kuS7uLJjhGMT60OOS7bZXELIkko6rxq62yrxHyXuZoQtldPwHtUSg/I50fw+NCaIAz4LhgBArKO9e@nongnu.org
X-Gm-Message-State: AOJu0YwTWSYOVOAHtrDeHFGuPe2vXhLyGG3rSGCTeooh5Xe+9gcWfpir
 vqLBfv4XibZcA7BEjfnm8cYVpC72KJpp4Qj59GVqN0XUEgBd4RoDBXNStmtzv/3tDvzTFe9+36D
 uefd/lKnHYlVT7XcLxLtSzFlI1SuDhPDH2klC+IL/JNtB9jbnXL29gQVK
X-Gm-Gg: AeBDietMICw9Mdx/BOF/la7kkFzpjDHWIMraxFOzS3Da6tVB+Xr8AF4FzWtMPqAkoYK
 kA3srBU94/NLmlERmFuaw36l8CJ5jII+E5paBwlfWdwdMmsKWd4WFGVAKBexZ5D6JxeA2kRKHCJ
 1s8G5YT0ETqDK6b83Hgrzsl1WhwCI6TPyPJOnJ4kVOB/WMd3GzpzlFsVKMDpeJb+GwPseTj15BX
 vd1cofn4RcncY/QlB65ceilG0QT4A+ADKzes+TMKmY83M5mO3HjQZBzQx/3GZn+baVquebimIIo
 SuQJoG7eX97tHXOuPUSXyKIzlgeNC4p2tfvTnv7HUdRLFnUhT2vBaQdAW7n2K9U1cCnHK5R22DP
 DWCUFU7/L3V61iGXEq9MshY1zaNg3CkqLWR8UFqbRNXpkKgo84LpBIOBhcFOOlFEpVFoBPE6CR0
 eZwg3T
X-Received: by 2002:a05:600c:a117:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48a9866837bmr127274405e9.19.1777908794307; 
 Mon, 04 May 2026 08:33:14 -0700 (PDT)
X-Received: by 2002:a05:600c:a117:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48a9866837bmr127273875e9.19.1777908793846; 
 Mon, 04 May 2026 08:33:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed6bafsm593723325e9.2.2026.05.04.08.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:33:13 -0700 (PDT)
Message-ID: <47b7ba85-b080-4074-8550-3c1f06c18648@redhat.com>
Date: Mon, 4 May 2026 17:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/31] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-9-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> Add support for selecting and initializing a CMDQV backend based on the
> cmdqv OnOffAuto property.
>
> If set to OFF, CMDQV is not used and the default IOMMUFD-backed allocation
> path is taken.
>
> If set to AUTO, QEMU attempts to probe a CMDQV backend during device setup.
> If probing succeeds, the selected ops are stored in the accelerated SMMUv3
> state and used. If probing fails, QEMU silently falls back to the default
> path.
>
> If set to ON, QEMU requires CMDQV support. Probing is performed during
> setup and failure results in an error.
>
> When a CMDQV backend is active, its callbacks are used for vIOMMU
> allocation, free, and reset handling. Otherwise, the base implementation
> is used.
>
> The current implementation wires up the Tegra241 CMDQV backend through the
> generic ops interface. Functional CMDQV behaviour is added in subsequent
> patches.
>
> No functional change.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  include/hw/arm/smmuv3.h |  2 +
>  hw/arm/smmuv3-accel.c   | 93 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index fe0493c1aa..aa6a79237a 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -74,6 +74,8 @@ struct SMMUv3State {
>      OnOffAuto ats;
>      OasMode oas;
>      SsidSizeMode ssidsize;
> +    /* SMMU CMDQV extension */
> +    OnOffAuto cmdqv;
>  
>      Notifier machine_done;
>  };
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index f65e654adf..9068e65e2b 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,6 +18,7 @@
>  
>  #include "smmuv3-internal.h"
>  #include "smmuv3-accel.h"
> +#include "tegra241-cmdqv.h"
>  
>  /*
>   * The root region aliases the global system memory, and shared_as_sysmem
> @@ -566,6 +567,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                            Error **errp)
>  {
>      SMMUv3AccelState *accel = s->s_accel;
> +    const SMMUv3AccelCmdqvOps *cmdqv_ops = accel->cmdqv_ops;
>      struct iommu_hwpt_arm_smmuv3 bypass_data = {
>          .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
>      };
> @@ -576,10 +578,17 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>      uint32_t viommu_id, hwpt_id;
>      IOMMUFDViommu *viommu;
>  
> -    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> -                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
> -                                      NULL, 0, &viommu_id, errp)) {
> -        return false;
> +    if (cmdqv_ops) {
> +        if (!cmdqv_ops->alloc_viommu(s, idev, &viommu_id, errp)) {
> +            return false;
> +        }
> +    } else {
> +        if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                          IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> +                                          s2_hwpt_id, NULL, 0, &viommu_id,
> +                                          errp)) {
> +            return false;
> +        }
>      }
>  
>      viommu = g_new0(IOMMUFDViommu, 1);
> @@ -625,12 +634,69 @@ free_bypass_hwpt:
>  free_abort_hwpt:
>      iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
>  free_viommu:
> -    iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
> +    if (cmdqv_ops && cmdqv_ops->free_viommu) {
> +        cmdqv_ops->free_viommu(s);
hum actually we do free the iommu id below in case the free_viommu is
not implemented. So forget my previously comment. Besides this means
free_viommu shall be documented as not mandatory.
> +    } else {
> +        iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
> +    }
>      g_free(viommu);
>      accel->viommu = NULL;
>      return false;
>  }
>  
> +static const SMMUv3AccelCmdqvOps *
> +smmuv3_accel_probe_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                          Error **errp)
> +{
> +    const SMMUv3AccelCmdqvOps *ops = tegra241_cmdqv_get_ops();
> +
> +    if (!ops || !ops->probe) {
> +        error_setg(errp, "No CMDQV ops found");
> +        return NULL;
> +    }
> +
> +    if (!ops->probe(s, idev, errp)) {
> +        return NULL;
> +    }
> +    return ops;
> +}
> +
> +static bool
> +smmuv3_accel_select_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                          Error **errp)
> +{
> +    const SMMUv3AccelCmdqvOps *ops = NULL;
> +
> +    if (s->s_accel->cmdqv_ops) {
> +        return true;
> +    }
> +
> +    switch (s->cmdqv) {
> +    case ON_OFF_AUTO_OFF:
> +        s->s_accel->cmdqv_ops = NULL;
> +        return true;
> +    case ON_OFF_AUTO_AUTO:
> +        ops = smmuv3_accel_probe_cmdqv(s, idev, NULL);
> +        break;
> +    case ON_OFF_AUTO_ON:
> +        ops = smmuv3_accel_probe_cmdqv(s, idev, errp);
> +        if (!ops) {
> +            error_append_hint(errp, "CMDQV requested but not supported");
> +            return false;
> +        }
> +        s->s_accel->cmdqv_ops = ops;
Shouldn't you remove the above setting as you do it again below in case
init succeeds?
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (ops && ops->init && !ops->init(s, errp)) {
> +        return false;
> +    }
> +    s->s_accel->cmdqv_ops = ops;
> +    return true;
> +}
> +
>  static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                            HostIOMMUDevice *hiod, Error **errp)
>  {
> @@ -665,6 +731,10 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>          goto done;
>      }
>  
> +    if (!smmuv3_accel_select_cmdqv(s, idev, errp)) {
> +        return false;
> +    }
> +
>      if (!smmuv3_accel_alloc_viommu(s, idev, errp)) {
>          error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
>                            idev->devid);
> @@ -936,8 +1006,17 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>  
>  void smmuv3_accel_reset(SMMUv3State *s)
>  {
> -     /* Attach a HWPT based on GBPA reset value */
> -     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
> +    SMMUv3AccelState *accel = s->s_accel;
> +
> +    if (!accel) {
> +        return;
> +    }
> +    /* Attach a HWPT based on GBPA reset value */
> +    smmuv3_accel_attach_gbpa_hwpt(s, NULL);
> +
> +    if (accel->cmdqv_ops && accel->cmdqv_ops->reset) {
> +        accel->cmdqv_ops->reset(s);
> +    }
>  }
>  
>  static void smmuv3_accel_as_init(SMMUv3State *s)
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric


