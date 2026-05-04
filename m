Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4624FFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJv4u-0003nU-Ax; Mon, 04 May 2026 11:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJv4q-0003nA-9q
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJv4o-0000Mr-Ev
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777907957;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yt/VfQoTUiZe78brLczOhoVwGSx28VRzckW7rfcI65Y=;
 b=Qmvy1fqQnwjdAEh66hehlxpAoYdfnlfGUBiXoTz+b7Wv+5FoXI5qnj6oaRV/S04ZBsp3Yl
 hVkM+D0qZWS4csSDgx/Q2WP7VC82WqL10/h3ukbcAEtV4ewYs5YXILoO2exSaNGLGzqFcn
 PMRfkJYPe10zXOzMIrdzqVZTHogc7IQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-0IaByuUeOi28_oUMVNxwTg-1; Mon, 04 May 2026 11:19:16 -0400
X-MC-Unique: 0IaByuUeOi28_oUMVNxwTg-1
X-Mimecast-MFC-AGG-ID: 0IaByuUeOi28_oUMVNxwTg_1777907955
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488c2aa6becso30010985e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777907955; x=1778512755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yt/VfQoTUiZe78brLczOhoVwGSx28VRzckW7rfcI65Y=;
 b=sjWM77sr5QymrCJ7mm6fP2UvCQUe/v2XsYmrKNBoTuN2pIJ0vpiJ/5DTv37Hh4zuHu
 8mjV5U1qm/j+bolI7TnBpwEYjgVsHFzCK8dtMitMUpToIuWP4UJj+S0UtdIAT3HQHMVF
 fOjS8Bp5MRtTsfHsN8hfUWEs7aUEIt6T6wE7I+q5mhH5uiHTZtQxpPSHeUJDURuDNA7K
 UXTNiL2tfdp5NbdNNc3Nh4LlmpdJJJJSZuJ7KJ9urcFFVFeVO7TT5eOgV/Rbeya/je7Y
 p8POUsoF/6R4+hBptURkKYkMVujm8W1eMMQOVGzgk3KjNd10v/nQQK9ZEPOB+tmswwn2
 7sBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tmb9n+Dg6WeemBXYmUbfLH/XwsOG/MO7HMVCZ0XrhmCGKul8CzYlHTCRXWDYrocos3SIWxz41kXfe@nongnu.org
X-Gm-Message-State: AOJu0YyATRaLqVDl1zOm83n/0sNq4xghFBIobPm5N/7QSBDIG30jZP3J
 R9+m5VX/5J9qgQxMYBVDPAY5k+cxP7cAm5qYdAJ/1WDIUtuHYzrwMNFVOmu2p8vuDGQDgQQvsq0
 3fNDGW1gUMBszPnbOrL8crc02aYtR6AIg1O1lGTSc9SF/RdLLLIQ2ZX6F
X-Gm-Gg: AeBDiesYK0RpSnHkq09b6qr8FUkxgsRwSuBcasPhrR/qzQg37IQlIyPsOZNxElMu/tN
 bHNTH2YDO733Uxr/ZIlbsW8WeHMZrSSDBKCy9kfZhcRWu9zIGXQo2j9HxRahJ2ea3JhI7RrIfol
 Csyc6/TcV7uZ2avmMHnLKNp8PnKID0CP8ztNCKhrdV+xgQ5xDSShm81NUrU1o3Iv9EudtyzjjDT
 cOOZOQ+kLF+YM1ssCB5AY7umjZbDzf3Onx2aimINPMhm9P8uaQ8VjdHpy7HepWg+8Hac1717Z59
 /h57bNo9LWKiIaAFazxHpPRh0/+PgU60RU4UJhvE8HWllg1fL0iuOMaCurN0I7gcyqcnAL43vki
 8wjk59MWzgG7yEXAEj7XE/V040H5f3Jzxo0hn1Xb5rAYpPMaRR8fZUAjkDKc9WSkYlF4BMPxVUb
 mhO/lU
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48a98662e71mr136764445e9.21.1777907954821; 
 Mon, 04 May 2026 08:19:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48a98662e71mr136763895e9.21.1777907954468; 
 Mon, 04 May 2026 08:19:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a9919fc3asm113453245e9.0.2026.05.04.08.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 08:19:13 -0700 (PDT)
Message-ID: <a47b9e6b-0d29-4a49-bbfd-db40cc6a520c@redhat.com>
Date: Mon, 4 May 2026 17:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/31] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-7-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 4/15/26 12:55 PM, Shameer Kolothum wrote:
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
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 7b4a0be000..86301afcb4 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -10,11 +10,28 @@
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
I would doc-comment which of those ops are mandated. For instance it
looks alloc_viommu is mandatory if the the whole ops exists. By the way,
it looks strange that !cmdqv_ops->free_viommu does not cause any assert
in 8/31 because we may not free the viommu_id if it does not exist?
Can't we enforce each mandated ops is implemented?

Thanks

Eric
> + */
> +typedef struct SMMUv3AccelCmdqvOps {
> +    bool (*probe)(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev, Error **errp);
> +    bool (*init)(SMMUv3State *s, Error **errp);
> +    bool (*alloc_viommu)(SMMUv3State *s,
> +                         HostIOMMUDeviceIOMMUFD *idev,
> +                         uint32_t *out_viommu_id,
> +                         Error **errp);
> +    void (*free_viommu)(SMMUv3State *s);
> +    void (*reset)(SMMUv3State *s);
> +} SMMUv3AccelCmdqvOps;
> +
>  /*
>   * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
>   * Holds bypass and abort proxy HWPT IDs used for device attachment.
> @@ -27,6 +44,7 @@ typedef struct SMMUv3AccelState {
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>      bool auto_mode;
>      bool auto_finalised;
> +    const SMMUv3AccelCmdqvOps *cmdqv_ops;
>  } SMMUv3AccelState;
>  
>  typedef struct SMMUS1Hwpt {


