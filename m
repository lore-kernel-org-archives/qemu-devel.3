Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE7EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdQcX-000215-Hv; Fri, 23 Feb 2024 03:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQcW-00020r-RA
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:09:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQcU-00019c-Tt
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708675762;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpqRj/4pboJWJecyHa+O52UiEbhowMxbk6mQzdyglhQ=;
 b=FUgMHdD50nBCSiLhnO9vxUar57fBwrzB52M8kq2QXXsSnfPOQ2OjSAOidozi6CloYvxHUT
 skF7+qA2KD3aXAzc2v3BOwOeMXrPJZ1a/If2GBxyB+jSEQkGwz9GMVzyQ07//ISjx7Opbx
 vnUf9zuyXKYvpSeVe08v3d0+nFbV4bI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-61MGwqBYNCCNNF7rS1uOfA-1; Fri, 23 Feb 2024 03:09:20 -0500
X-MC-Unique: 61MGwqBYNCCNNF7rS1uOfA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-68f8e8012b1so381016d6.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 00:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708675760; x=1709280560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CpqRj/4pboJWJecyHa+O52UiEbhowMxbk6mQzdyglhQ=;
 b=camSIchpxL+x/h/48gehr39Oi24G/f+pHe8Owevx6b6hHMp9SMTXkm1jFV8gRLhay9
 HsZousAEl8UYIh/WDOuMqEf56bEXgHpUFf3G14F5R8ymfpfNQDBgOo79hNFwSVx1wzw7
 1NEjSNmBfNQBMeY+WO3kp4ndXbQb9koPRMdjSPuYHzYNaR/CVl51EKqe984rdz9SxtcL
 17Pk5YcC8S8NQWWhelD72rmo6wxy8a26KfxC2GNg0cGWTpnsQiQ91zGJUpIVrv1XY7KP
 GOu+vU65zyX0+gnHAFO5Dq0iXxc6k4OmnQ1nhgDuy/uivARbk2TIHetx1oTTsrM0dUq9
 Qc1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUML/NAD0HgQW/q1Wvo2VNtIXNWKTedwFfjKI7b2eQFDMfTiEJEmiwAn+d6trDFFiFTrI8cy7+rm69WLXjcWbdYOfv0UDE=
X-Gm-Message-State: AOJu0Yw4h9lVpHLAv+9BS8qpR+duym7BnZBqmd8ryEcKdaVvylAHsynH
 d+Yb1yxEF9Q1+/WiSnFL7ASHxC8WLcleOfOk3MllBxDG3dXtoWTY0IPoQHSCDYLJ1+fQWyky9lR
 q3wJN3Q45hk1tz7CDBQUdh06Dre9l7jirwFsPxiX2S10twVsWI9L1
X-Received: by 2002:ad4:5fcf:0:b0:68f:cbd2:ec8d with SMTP id
 jq15-20020ad45fcf000000b0068fcbd2ec8dmr1650988qvb.64.1708675760143; 
 Fri, 23 Feb 2024 00:09:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF79BCtP4Hc+RHujKXEGNvEtBDf2Q5NEkwvKheJrRgR4Gr5pANpk3033P9kQPP7Y8x/4PPfTg==
X-Received: by 2002:ad4:5fcf:0:b0:68f:cbd2:ec8d with SMTP id
 jq15-20020ad45fcf000000b0068fcbd2ec8dmr1650970qvb.64.1708675759699; 
 Fri, 23 Feb 2024 00:09:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 lx6-20020a0562145f0600b0068f6dfcca55sm5855974qvb.65.2024.02.23.00.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 00:09:19 -0800 (PST)
Message-ID: <81c2b165-0961-4fea-947d-f55677049e9f@redhat.com>
Date: Fri, 23 Feb 2024 09:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/smmu-common: Create virtual function for
 implementation defined StreamID
Content-Language: en-US
To: Nabih Estefan <nabihestefan@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 its@irrelevant.dk, kbusch@kernel.org, roqueh@google.com
References: <20240221171716.1260192-1-nabihestefan@google.com>
 <20240221171716.1260192-3-nabihestefan@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240221171716.1260192-3-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

On 2/21/24 18:17, Nabih Estefan wrote:
> From: Roque Arcudia Hernandez <roqueh@google.com>
>
> According to the SMMU specification the StreamID construction and size is
> IMPLEMENTATION DEFINED, the size being between 0 and 32 bits.
>
> This patch creates virtual functions get_sid and get_iommu_mr to allow different
> implementations of how the StreamID is constructed via inheritance. The default
> implementation of these functions will match the current ones where the BDF is
> used directly as StreamID.

The patch itself looks good to me but it lacks a concrete derived
implementation of get_sid() and get_iommu_mr(). Until you do not
upstream it I don't see the point in introducing those callbacks. Thanks
Eric
>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  hw/arm/smmu-common.c         | 12 ++++++++++++
>  include/hw/arm/smmu-common.h | 16 +++++++++++-----
>  2 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 4caedb4998..14b3240a88 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -621,6 +621,11 @@ static const PCIIOMMUOps smmu_ops = {
>  };
>  
>  IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
> +{
> +    return ARM_SMMU_GET_CLASS(s)->get_iommu_mr(s, sid);
> +}
> +
> +static IOMMUMemoryRegion *smmu_base_iommu_mr(SMMUState *s, uint32_t sid)
>  {
>      uint8_t bus_n, devfn;
>      SMMUPciBus *smmu_bus;
> @@ -659,6 +664,11 @@ void smmu_inv_notifiers_all(SMMUState *s)
>      }
>  }
>  
> +static uint32_t smmu_base_get_sid(SMMUDevice *sdev)
> +{
> +    return PCI_BUILD_BDF(pci_bus_num(sdev->bus), sdev->devfn);
> +}
> +
>  static void smmu_base_realize(DeviceState *dev, Error **errp)
>  {
>      SMMUState *s = ARM_SMMU(dev);
> @@ -709,6 +719,8 @@ static void smmu_base_class_init(ObjectClass *klass, void *data)
>      device_class_set_parent_realize(dc, smmu_base_realize,
>                                      &sbc->parent_realize);
>      rc->phases.hold = smmu_base_reset_hold;
> +    sbc->get_sid = smmu_base_get_sid;
> +    sbc->get_iommu_mr = smmu_base_iommu_mr;
>  }
>  
>  static const TypeInfo smmu_base_info = {
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 5ec2e6c1a4..d53121fe37 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -131,6 +131,9 @@ typedef struct SMMUIOTLBKey {
>      uint8_t level;
>  } SMMUIOTLBKey;
>  
> +#define TYPE_ARM_SMMU "arm-smmu"
> +OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
> +
>  struct SMMUState {
>      /* <private> */
>      SysBusDevice  dev;
> @@ -147,6 +150,9 @@ struct SMMUState {
>      PCIBus *primary_bus;
>  };
>  
> +typedef uint32_t GetSidFunc(SMMUDevice *obj);
> +typedef IOMMUMemoryRegion *GetIommuMr(SMMUState *s, uint32_t sid);
> +
>  struct SMMUBaseClass {
>      /* <private> */
>      SysBusDeviceClass parent_class;
> @@ -154,19 +160,19 @@ struct SMMUBaseClass {
>      /*< public >*/
>  
>      DeviceRealize parent_realize;
> +    GetSidFunc *get_sid;
> +    GetIommuMr *get_iommu_mr;
>  
>  };
>  
> -#define TYPE_ARM_SMMU "arm-smmu"
> -OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
> -
>  /* Return the SMMUPciBus handle associated to a PCI bus number */
>  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
>  
>  /* Return the stream ID of an SMMU device */
> -static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
> +static inline uint32_t smmu_get_sid(SMMUDevice *sdev)
>  {
> -    return PCI_BUILD_BDF(pci_bus_num(sdev->bus), sdev->devfn);
> +    SMMUState *s = sdev->smmu;
> +    return ARM_SMMU_GET_CLASS(s)->get_sid(sdev);
>  }
>  
>  /**


