Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068F1CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 07:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu4oh-0001Ad-IW; Thu, 04 Sep 2025 03:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uu4of-0001AF-56
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 03:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uu4oc-0005cB-5N
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 03:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756972527;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV/JkLPsplmb7MZakCOP37DHgaUkD9O13bJkEPqbPmE=;
 b=M7j4DkzeOpx2Q9vYFduveQOM8YBE4MMIdLBsO1+gnt/ZYGDoLi0RR8LPqMNXbyGb/Mb2Kz
 ZpmHSSbXnJsyDMdJevg6tqzlWuhOwSeat5u9hejlRtIVhP/JrBvzyTXcnsGxIin1yCZdTi
 9igPjGFjA7ZSPrHVIkhc1zx1mj8qhCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-UecA-NzMPumc0-9jAohKiQ-1; Thu, 04 Sep 2025 03:55:26 -0400
X-MC-Unique: UecA-NzMPumc0-9jAohKiQ-1
X-Mimecast-MFC-AGG-ID: UecA-NzMPumc0-9jAohKiQ_1756972525
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a15f10f31so11569545e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 00:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756972525; x=1757577325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TV/JkLPsplmb7MZakCOP37DHgaUkD9O13bJkEPqbPmE=;
 b=qBlgLsf29pnbpMAr1hoI/j6PI99MbVOyW3l1yzLImY3IBYSdl4QYEIXEV0GyurWWsu
 laEqwJRaRcN7nNHsvG19zNOrs4aupouKgngQnKbZMsYKwz2sQoJXcibQ3ClVIDwKgqgf
 sXrA8kDTlaBM18xr8OEYW3m0h+Jbq2MZ+dVe9kmHKiL4NXqDmfbBmPPnSPJyAuMi/kxn
 szhKIU6dVZ6+Ul7zg5ENKuXRg+uB2laqvcCQ0tKnrB4NwIQDP9vN2tKiefwJr9yvMaHP
 6RSRXxRTWHQJ8r7VLBGlN+/TT2SmU+XOrKXx7vAZkxxG/9gq05GBRLpcsovcTx7WB5Zx
 Nu6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4UbVjqwCKsnd2KuzuoX3HS8IPFy4qNGu/DqpyFZWzqpDXMNtSl/3ZzO/+b2a1l5vvuOFUNtA6502L@nongnu.org
X-Gm-Message-State: AOJu0YyVJvVdyRXfiY3tvWXZeBC0Dhi9CY9iO/PE/zMA5oe80AJNH1Fi
 vEcq9wR5jlSvv8vorqt+1n9TOGPc/3+GejMt8APPECsLalXSRMVuXAr1E7DhNr9oWWbXqTjn93Y
 D+mjph0b/2tez0QRxQo3+Wi0DPfyGaBwbn3kCl/touxSStf9EM7JwEl0X
X-Gm-Gg: ASbGncuTKfEermUXNNu+47PEMaW1vJ2pBBvPKBMSic1dlBtjb7qWpQMRFwgCpLH21OY
 5OUQOH3zUMAHSOt7BMTgF7Csfneq150D9FQoWHIBhX4nU8T0KB9J1cXW5eSfg4sJF2yub18dDcD
 E64UfYg+5H/8nxj3u5W50Sj0CTtjTdr2NWMbw7JAe19k+XJ9DQa8FFDxGKJACvAbGWCr5Y8c9PJ
 XZxro1VhQ2OlrcHO6YmH4E4VwyH/tTEVc90l0nuiYdcZN9xufXFDa10PHd4ZH82DDySTjEKOPx3
 7e56nEHOBr15S2hA3Hl+3aAaLt3q8437mlnfjHI7UJ9qv+AVvcaM+MtO7gHCYqKVBPiT542xMJI
 tMGep1cJpIMI=
X-Received: by 2002:a5d:5d10:0:b0:3d3:1ad0:e8a2 with SMTP id
 ffacd0b85a97d-3d31b2c7b3bmr9077068f8f.27.1756972524859; 
 Thu, 04 Sep 2025 00:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYRZGnlAhVz/CqbddOvVxz2RHMiNNcgUs/INAahbhakPgWqumCOz9hj8nyL+USHn3UoJpWiA==
X-Received: by 2002:a5d:5d10:0:b0:3d3:1ad0:e8a2 with SMTP id
 ffacd0b85a97d-3d31b2c7b3bmr9077043f8f.27.1756972524414; 
 Thu, 04 Sep 2025 00:55:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dcfd000dasm13089105e9.5.2025.09.04.00.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 00:55:23 -0700 (PDT)
Message-ID: <ba0763fd-6f87-47cf-b425-91f096fadc12@redhat.com>
Date: Thu, 4 Sep 2025 09:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/15] hw/arm/smmu-common: Introduce
 smmu_iommu_ops_by_type() helper
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, skolothumtho@nvidia.com
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-5-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250714155941.22176-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> Allows to retrieve the PCIIOMMUOps based on the SMMU type. This will be
> useful when we add support for accelerated SMMUV3 in subsequent patches
> as that requires a different set of callbacks for iommu ops.
>
> No special handling is required for now and returns the default ops
> in base SMMU Class.
>
> No functional changes intended.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/arm/smmu-common.c         | 17 +++++++++++++++--
>  include/hw/arm/smmu-common.h |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 0f1a06cec2..3a1080773a 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -934,6 +934,16 @@ void smmu_inv_notifiers_all(SMMUState *s)
>      }
>  }
>  
> +static const PCIIOMMUOps *smmu_iommu_ops_by_type(SMMUState *s)
> +{
> +    SMMUBaseClass *sbc;
> +
> +    sbc = ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));
> +    assert(sbc->iommu_ops);
> +
> +    return sbc->iommu_ops;
> +}
> +
>  static void smmu_base_realize(DeviceState *dev, Error **errp)
>  {
>      SMMUState *s = ARM_SMMU(dev);
> @@ -962,6 +972,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>       */
>      if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
>          object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
> +        const PCIIOMMUOps  *iommu_ops;
>          /*
>           * This condition matches either the default pcie.0, pxb-pcie, or
>           * pxb-cxl. For both pxb-pcie and pxb-cxl, parent_dev will be set.
> @@ -974,10 +985,11 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>              }
>          }
>  
> +        iommu_ops = smmu_iommu_ops_by_type(s);
>          if (s->smmu_per_bus) {
> -            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
> +            pci_setup_iommu_per_bus(pci_bus, iommu_ops, s);
>          } else {
> -            pci_setup_iommu(pci_bus, &smmu_ops, s);
> +            pci_setup_iommu(pci_bus, iommu_ops, s);
>          }
>          return;
>      }
> @@ -1018,6 +1030,7 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
>      device_class_set_parent_realize(dc, smmu_base_realize,
>                                      &sbc->parent_realize);
>      rc->phases.exit = smmu_base_reset_exit;
> +    sbc->iommu_ops = &smmu_ops;
>  }
>  
>  static const TypeInfo smmu_base_info = {
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index c6f899e403..eb94623555 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -171,6 +171,7 @@ struct SMMUBaseClass {
>      /*< public >*/
>  
>      DeviceRealize parent_realize;
> +    const PCIIOMMUOps *iommu_ops;
>  
>  };
>  


