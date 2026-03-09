Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D34EFCD9A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 11:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzYRB-0000cK-Er; Mon, 09 Mar 2026 07:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzYR9-0000Vj-BI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzYR4-0003bI-QP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773054363;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoF0Ch/aSprBYWXCQshySPAUdtlutjKvNeIRSVYy+9k=;
 b=cH9l4eLElAVksFjRc7Ze2T1c41ZBUjkBMfgfNfDNZJB6d3qKb6QylCqS6lexOu0613jtHP
 GQJHFGRv2eEk4FqsxjDSEERwgIodgvW/LwFxcXadI3IO7YF/Y5kLVgC98TCXVL8btw/AY6
 Fz5cmihpkPSjlMdpdsVhuErZYGdtxuk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-nd8snE71Ma2HeljsC5LSkQ-1; Mon, 09 Mar 2026 07:06:02 -0400
X-MC-Unique: nd8snE71Ma2HeljsC5LSkQ-1
X-Mimecast-MFC-AGG-ID: nd8snE71Ma2HeljsC5LSkQ_1773054361
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4852fbfc379so19699115e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 04:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773054361; x=1773659161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoF0Ch/aSprBYWXCQshySPAUdtlutjKvNeIRSVYy+9k=;
 b=xMUp5GD+JoS/7hVxU6pZrVysk9KOdvQHDanPJ+tLuh7AwNbhscGLuhojOZRp55Jh7v
 Nlf5zygjtEWz+PNyEvBxWsxdHvgM6fWtndnMiB1XDpXC3DOyAHEOOZC/dMoTDZ7hpKv2
 z0vCp0BCxN0hCnv0ANvw2qlqymKjDynSRMDDTLMh/aNGlepswodaah4FLpdTeWp64T4m
 VfoKMfQN5uhggPIlv9gTyxHlfH+k6fcuHyivkNelVTttrxeMV3Cb1JmHvFZ6k+aqIuQn
 EzJq0eW1Q+NOYUnL7B6u7jSv7ebr/PAUqjgmd452obIQ9LlbGIwPsnCH+GP1e0PTulbQ
 qQig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+CyBVhNyCQezOHTuhUk9GE2mxbiigdunR9TPDbhX1G1p1tpaSfj4DfD+853Q87VEEST7dFN1E18x2@nongnu.org
X-Gm-Message-State: AOJu0YyR0WRr6e6IO7z9YRR76yU81DQSnpHkAbfHkudBLqXrJu8bnnaj
 Rf3SFmWKtNfs6GX1IuSzwTfyPdJRR2OQB33ZPBt7MAyUC+981KLFmTmh+js3EjYNdUthGYnysOz
 ApXqdog3k5FztXqDIs5WSh8a5vrIgUjTKhF2QyOt3UwdHD1ZAndkr2Tir
X-Gm-Gg: ATEYQzyE4L0qQMuVe/W6Ulh+lgarLVxEHo9OQ0ktDxNhnn7LPOCddnqrRY5dAYvwVz9
 qsCIkx+Ka5sr/gXhcDrIS40bQU9EYJKn783770csbwawprBXn3mVk9qHHXzUNt1MR4m2YjnVojD
 C/hudJoqudZx2Nq8fQp1UrOa+be96vQY4djmgH3umsQTvihS+ST/AZPJYT4BDVSatMS+iqp3rQb
 0jojvZ1Vx9pqd2bBMDscees8iiTepJErOBe1PhTsxss4RHsCofH8f9D6SDb/Zg0BtWUmAQzoln4
 DqKOZ44amDLHVQTOR3m1tgIjcNni5p0wND8iLYvjVVebEIxQJms1BfQv685lg5L0+bxaSAw5h3s
 AkaHdpb7Dx7kT8Uxx91GKD20WepTy2hoLaVd49mcvvtBg3bDXPLiFMALT0/PDEvahhL3WXw==
X-Received: by 2002:a5d:64e8:0:b0:439:d67f:d48 with SMTP id
 ffacd0b85a97d-439da8a7cccmr18869977f8f.59.1773054360792; 
 Mon, 09 Mar 2026 04:06:00 -0700 (PDT)
X-Received: by 2002:a5d:64e8:0:b0:439:d67f:d48 with SMTP id
 ffacd0b85a97d-439da8a7cccmr18869900f8f.59.1773054360249; 
 Mon, 09 Mar 2026 04:06:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dada3b43sm26233383f8f.13.2026.03.09.04.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 04:05:59 -0700 (PDT)
Message-ID: <aa0319bf-066b-4c81-8368-19a93ee1eddb@redhat.com>
Date: Mon, 9 Mar 2026 12:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/32] hw/arm/smmuv3-accel: Wire CMDQV ops into accel
 lifecycle
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-8-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> Add support for selecting and initializing a CMDQV backend based on
> the cmdqv OnOffAuto property.
>
> If set to OFF, CMDQV is not used and the default IOMMUFD-backed
> allocation path is taken.
>
> If set to AUTO, QEMU attempts to probe a CMDQV backend during
> device setup. If probing succeeds, the selected ops are stored
> in the accelerated SMMUv3 state and used. If probing fails,
> QEMU silently falls back to the default path.
>
> If set to ON, QEMU requires CMDQV support. Probing is performed
> during setup and failure results in an error.
>
> When a CMDQV backend is active, its callbacks are used for vIOMMU
> allocation, free, and reset handling. Otherwise, the base
> implementation is used.
>
> The current implementation wires up the Tegra241 CMDQV backend
> through the generic ops interface. Functional CMDQV behaviour is
> added in subsequent patches.
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
> index 26b2fc42fd..648412cafc 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -73,6 +73,8 @@ struct SMMUv3State {
>      bool ats;
>      uint8_t oas;
>      uint8_t ssidsize;
> +    /* SMMU CMDQV extension */
> +    OnOffAuto cmdqv;
>  };
>  
>  typedef enum {
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index ab1b0a3669..4373bbd97b 100644
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
> @@ -522,6 +523,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                            Error **errp)
>  {
>      SMMUv3AccelState *accel = s->s_accel;
> +    const SMMUv3AccelCmdqvOps *cmdqv_ops = accel->cmdqv_ops;
>      struct iommu_hwpt_arm_smmuv3 bypass_data = {
>          .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
>      };
> @@ -532,10 +534,17 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
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
> @@ -581,12 +590,69 @@ free_bypass_hwpt:
>  free_abort_hwpt:
>      iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
>  free_viommu:
> -    iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
> +    if (cmdqv_ops && cmdqv_ops->free_viommu) {
> +        cmdqv_ops->free_viommu(s);
> +    } else {
> +        iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
> +    }
reading [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
alloc/free

tegra241_cmdqv_free_viommu() looks identifical in both implementations

So maybe this is not needed

Eric

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
> @@ -621,6 +687,10 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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
> @@ -867,8 +937,17 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
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


