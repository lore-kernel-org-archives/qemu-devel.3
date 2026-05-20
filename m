Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77813CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 05:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPZUb-0004We-UC; Wed, 20 May 2026 01:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPZUX-0004Tk-Ue
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPZUV-0006Tx-0K
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779254950;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24T28WbTiXuvmHCalvk51F77sHhKg8vYObR3Hf/1szM=;
 b=h1icKdGnfOMLD0b5eYsl5OLJKeJ/vl3mgLvKH7wlcjAYTq1zaw64eEt615SOnDjp1UC3gi
 tRH08snnFuJOuWz6h0sQhKSAVgTCy5pj85eWb4xGWd29EGKt/JK8ivudOHCbJU1zdQIFSs
 qPSsc5klZhKfxTaXqDevAGM6pqCcLnA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-ORYWnAuaPTezMtv7eBkvgA-1; Wed, 20 May 2026 01:29:07 -0400
X-MC-Unique: ORYWnAuaPTezMtv7eBkvgA-1
X-Mimecast-MFC-AGG-ID: ORYWnAuaPTezMtv7eBkvgA_1779254947
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45e55c44ac1so3549660f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 22:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779254946; x=1779859746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24T28WbTiXuvmHCalvk51F77sHhKg8vYObR3Hf/1szM=;
 b=BYvNwPFtN4i5Yt3xJMD21ePE4f6HgvkaMXnKTpJxrHsGRrK5G3YlnFEftdaUxZGtIw
 5w69/nJvXZOardyLPye8at0E8ZjjuvDusl4vZAQP8Jqnxi5F+LJGedrvH3ZNADaPc4ph
 fO8Uxrr7NhoQYWQd8U5fdApCENFxT7YCnBrye5pXiU/XvbxSmmRDS+AfiVA+D394q5Y0
 VS5BsEG6nBfb4mo4QYJUQ8RgEWVdFsBB/cYiVCB8R9aPJhrHFUDT7zNBmELhOzFUPbU6
 siT/9gPEjNdJjqs/WlomnqwKh77Miw3SuWRxs7tDkmKKCaE4vXWolv3xxZzZs2JnNRjn
 Muag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SBoIH7leiedV06dwsyxYXBfCh5isdZr3FDRIufC7f7d4F35gpAFCpMCPfmbAXiTvYsvflXdSMWx4t@nongnu.org
X-Gm-Message-State: AOJu0Yxwel2DpQGcatF/FgLVtYq5hnf0o0rWI7DjlH9T7IO10febhnN0
 gS1K4csknIiLyjOK+GKODy1ban6uF8iIGlODtpITHeGabLUt9hTxrnb2SdrA1T13Hu1FiJs1+6k
 c9liPIQoXnvbRhKRb55sacaS0Je8LS9NHxU9+ntMJfNfPgDAwx9Qu9qig
X-Gm-Gg: Acq92OGNzJvpHeRvl8LQZwXLrzfnu/+xvaFu6TlmCYBumfDNv/7rNnoWuHm7LvYN0xg
 CET2sXIfpDOCC8twH36aqPE3WHXbocMxdLBUQo9Ny+WXBmKgUFbDYRTFwYRLP+n+ZYNcLIqZ8wO
 XY8kAMV2jB3NSiB7mx1cmi24BNIIppuArJ2xrNCeePzcqqWs+y8euw+38XIabLsrzI2RFWoOo6T
 d3dtH5wlAqKn79/8vy27SW30GlOMDETLizMEHdO84rE5L5QH670gfjzfJunfAtWq+a0z2qr/ufj
 FCtyQC+nDBoanbsWdrDe80Nq/3MVfonRMJSOM2qUJx1qDeBcjBenPCXN3L7QbTCUB4NuvyHlo+U
 GsjGXsG8SDfikRPrBAWb6Ae3lLTFetHJfJfdDMdpMd6FO7R6AoOigBz3gp9j++S7b5mJmcw==
X-Received: by 2002:a05:6000:200f:b0:45d:b14b:23f8 with SMTP id
 ffacd0b85a97d-45e5c5af4eamr35667069f8f.18.1779254946612; 
 Tue, 19 May 2026 22:29:06 -0700 (PDT)
X-Received: by 2002:a05:6000:200f:b0:45d:b14b:23f8 with SMTP id
 ffacd0b85a97d-45e5c5af4eamr35667032f8f.18.1779254946175; 
 Tue, 19 May 2026 22:29:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6449sm50807086f8f.37.2026.05.19.22.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 22:29:05 -0700 (PDT)
Message-ID: <cdadf6bd-d7d8-41cd-94f7-9031cc21cb3c@redhat.com>
Date: Wed, 20 May 2026 07:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/32] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-7-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/19/26 12:36 PM, Shameer Kolothum wrote:
> Command Queue Virtualization (CMDQV) is a hardware extension available
> on certain platforms that allows the SMMUv3 command queue to be
> virtualized and passed through to a VM, improving performance.
>
> For example, NVIDIA Tegra241 implements CMDQV to support virtualization
> of multiple command queues (VCMDQs).
>
> The term CMDQV is used here generically to refer to any platform that
> provides hardware support to virtualize the SMMUv3 command queue.
>
> CMDQV support is a specialization of the IOMMUFD-backed accelerated
> SMMUv3 path. Introduce an ops interface to factor out CMDQV-specific
> probe, initialization, and vIOMMU allocation logic from the base
> implementation. The ops pointer and associated state are stored in
> the accelerated SMMUv3 state.
>
> This provides an extensible design to support future vendor-specific
> CMDQV implementations.
>
> No functional change.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 87fecb5c68..f82a7112d8 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -10,11 +10,45 @@
>  #define HW_ARM_SMMUV3_ACCEL_H
>  
>  #include "hw/arm/smmu-common.h"
> +#include "hw/arm/smmuv3.h"
>  #include "system/iommufd.h"
>  #ifdef CONFIG_LINUX
>  #include <linux/iommufd.h>
>  #endif
>  
> +/*
> + * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
> + * support multiple VCMDQs with virtualization capabilities.
> + * CMDQV specific behavior is factored behind this ops interface.
> + */
> +typedef struct SMMUv3AccelCmdqvOps {
> +    /**
> +     * @probe: Optional callback. Vendor-specific device probing.
> +     */
> +    bool (*probe)(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev, Error **errp);
> +    /**
> +     * @init: Optional callback. Initialize CMDQV hardware.
> +     */
> +    bool (*init)(SMMUv3State *s, Error **errp);
> +    /**
> +     * @alloc_viommu: Mandatory when probe is implemented.
see my comment on 8/32. Aren't probe and alloc_viommu somehow mandatory?

Eric
> +     * Allocate CMDQV viommu resources.
> +     */
> +    bool (*alloc_viommu)(SMMUv3State *s,
> +                         HostIOMMUDeviceIOMMUFD *idev,
> +                         uint32_t *out_viommu_id,
> +                         Error **errp);
> +    /**
> +     * @free_viommu: Optional callback. Free CMDQV viommu resources.
> +     * If NULL, the viommu_id is freed directly via iommufd_backend_free_id().
> +     */
> +    void (*free_viommu)(SMMUv3State *s);
> +    /**
> +     * @reset: Optional callback. Reset CMDQV state.
> +     */
> +    void (*reset)(SMMUv3State *s);
> +} SMMUv3AccelCmdqvOps;
> +
>  /*
>   * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
>   * Holds bypass and abort proxy HWPT IDs used for device attachment.
> @@ -27,6 +61,7 @@ typedef struct SMMUv3AccelState {
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>      bool auto_mode;
>      bool auto_finalised;
> +    const SMMUv3AccelCmdqvOps *cmdqv_ops;
>  } SMMUv3AccelState;
>  
>  typedef struct SMMUS1Hwpt {


