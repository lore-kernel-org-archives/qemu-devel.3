Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15A6CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 05:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPZYc-0005Yq-1a; Wed, 20 May 2026 01:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPZYX-0005YO-7d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPZYU-0007Qf-Po
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779255197;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+he7JyK7dX1Ki19D9XfJsskffyqCo2VDWfHj3OU70s=;
 b=UwrJXRUG0W872v6A69iEHltqWOK/ceEOjEfoo/DpNDBNIEQKOXW7jgwbcoOWo4rDVtvEye
 DbZpJM3BNmwP7/O3cZLxFo8DVTzDh0SMdKD3gtuYo8n4UoGPyxRZcW7e38SXNdlKb78vFg
 +FxwwmLaF1JLJTfw/dJzToSysL1vVaA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-DNOb9pKAMfe_Xx7Gyw-xCg-1; Wed, 20 May 2026 01:33:16 -0400
X-MC-Unique: DNOb9pKAMfe_Xx7Gyw-xCg-1
X-Mimecast-MFC-AGG-ID: DNOb9pKAMfe_Xx7Gyw-xCg_1779255195
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45e73a4f1dfso2879961f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 22:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779255195; x=1779859995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+he7JyK7dX1Ki19D9XfJsskffyqCo2VDWfHj3OU70s=;
 b=DBdejLScHPCZQbynTEBucTlbiCgFmnr2Vv2RRGrHPAk+CTPZM8xESyVhbS/a61jrss
 VtIIBBcSOKD3fYDu+DncnfdBLy5KERWggC6QXCQrQ5ChxF8+D4MGD7vC8pK7H8Mkym/U
 HUilOzc7gz1XGHaBfRGU32vEOGAWMg40VifVdMl9KKbFO4mMr+LQ3Mfpu6ID5Oe/J+Ey
 ZT6+RC+C/mjhG3jF8SJECp+BdEHxBh6Y4zJyVuXPn7y1g5tLZ1K1jULU5B3aDPGVx0PJ
 JPxtxf0gzoRzoCjFUGK4xOhP0SpDBGJRdIQVNU9EZR8i2s/FXykABiivS9QE9zk3Fki2
 KQqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/U0mldG7lWBJp0qDBJoc10II4rRVFD7pj8PSSnQWabld2EyYPKvEJwjQUe6dQkeSQdKwg/11+qMkzD@nongnu.org
X-Gm-Message-State: AOJu0YyiJYyRrrggla9j7Ry41uy1kWVXoMefPzk16GQoDdQptbyMAlRF
 uTIsBPFjP4dR6xFJcbPv0KRXuftY52OA8nYzwV2aYpGJ7tduKhgswtWfj58D8USixPAnBPs8Rrr
 hhoLdKQSNgMihkyaK7gnA4EOybKFx6/Y8Ft6ekeBpT7bgttdK7Lo560MM
X-Gm-Gg: Acq92OG2FMP7feQYdoBP97863rhE/c2uBNRF7A97cT9iorNU7KcwknZ7ZOpqtHUD8ia
 Zq5xCE5WdBnqzHb4ywXO1DDTQ8Zq5OrM/+il/9yDeTwSIzYgprcU+09EzJXpLe7yoqByqEO/2I2
 q7ws/GqoP93z8t2CSOo4q8p0SKZvwUnq9bBMN5H67cgysIcYAJCDJsioILyNYxh5hTNDtvF1F7B
 9Ida5wjDqF4fubgf1uPrISruIGwdEF7vNtsYpKOsWCqMu+PwM4cV6RfxRNt+aXhhGOhzDzOMPbN
 Ukt6fTxzz+2iKiv54h2QpLBsM+gkA9cVIS8sU6vw6wWx+wjbY7gTLh+rj/WRYUDT1PD44R4SN1y
 9zz1GC5oh+qRySjTT8QhNYQZR6oetgoeuiuPZWlv1HOEx4We5D5UEHHCJgX4fdALudVvfyQ==
X-Received: by 2002:a5d:64c6:0:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-45e5c5dadbamr35152096f8f.38.1779255194666; 
 Tue, 19 May 2026 22:33:14 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-45e5c5dadbamr35152043f8f.38.1779255194195; 
 Tue, 19 May 2026 22:33:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe1a41sm55160629f8f.31.2026.05.19.22.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 22:33:13 -0700 (PDT)
Message-ID: <361ee189-8254-4024-b83e-6c88291e2eb1@redhat.com>
Date: Wed, 20 May 2026 07:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/32] hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config
 region
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-15-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 5/19/26 12:36 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Tegra241 CMDQV exposes control and status registers in the CMDQ-V
> Config page (offset [0x0, 0x10000)) used to configure virtual command
> queue allocation and interrupt behavior.
>
> Add read/write emulation for the CMDQ-V Config region
> ([CMDQV_BASE, CMDQV_CMDQ_BASE]), backed by a simple register cache.
> This includes CONFIG, PARAM, STATUS, VI error and interrupt maps, CMDQ
> allocation map and the VINTF0 related registers defined in the CMDQ-V
> Config space. Only VINTF0 is supported; VINTF1-63 are not.
>
> Dispatch writes on access size: Introduced writel_mmio for 4-byte and
> writell_mmio for 8-byte. Reads need no split as the MMIO framework masks
> the returned value to the access size.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h | 110 +++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.c | 188 +++++++++++++++++++++++++++++++++++++++-
>  hw/arm/trace-events     |   4 +
>  3 files changed, 298 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 54854421f2..ace327443a 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -10,10 +10,15 @@
>  #ifndef HW_ARM_TEGRA241_CMDQV_H
>  #define HW_ARM_TEGRA241_CMDQV_H
>  
> +#include "hw/core/registerfields.h"
> +
>  #define CMDQV_VER                 1
>  #define CMDQV_NUM_CMDQ_LOG2       1
>  #define CMDQV_NUM_SID_PER_VI_LOG2 4
>  
> +#define TEGRA241_CMDQV_MAX_CMDQ      (1U << CMDQV_NUM_CMDQ_LOG2)
> +#define TEGRA241_CMDQV_MAX_NUM_SID   (1U << CMDQV_NUM_SID_PER_VI_LOG2)
> +
>  /*
>   * Tegra241 CMDQV MMIO layout (64KB pages)
>   *
> @@ -31,8 +36,113 @@ typedef struct Tegra241CMDQV {
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
>      IOMMUFDVeventq *veventq;
> +
> +    /* CMDQ-V Config page register cache */
> +    uint32_t config;
> +    uint32_t param;
> +    uint32_t status;
> +    uint32_t vi_err_map[2];
> +    uint32_t vi_int_mask[2];
> +    uint32_t cmdq_err_map[4];
> +    uint32_t cmdq_alloc_map[TEGRA241_CMDQV_MAX_CMDQ];
> +
> +    /* VINTF0 register cache (within CMDQ-V Config page) */
> +    uint32_t vintf_config;
> +    uint32_t vintf_status;
> +    uint32_t vintf_sid_match[TEGRA241_CMDQV_MAX_NUM_SID];
> +    uint32_t vintf_sid_replace[TEGRA241_CMDQV_MAX_NUM_SID];
> +    uint32_t vintf_cmdq_err_map[4];
>  } Tegra241CMDQV;
>  
> +/* CMDQ-V Config page registers (offset 0x00000) */
> +REG32(CONFIG, 0x0)
> +FIELD(CONFIG, CMDQV_EN, 0, 1)
> +FIELD(CONFIG, CMDQV_PER_CMD_OFFSET, 1, 3)
> +FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
> +FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
> +FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
> +
> +REG32(PARAM, 0x4)
> +FIELD(PARAM, CMDQV_VER, 0, 4)
> +FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
> +FIELD(PARAM, CMDQV_NUM_VI_LOG2, 8, 4)
> +FIELD(PARAM, CMDQV_NUM_SID_PER_VI_LOG2, 12, 4)
> +
> +REG32(STATUS, 0x8)
> +FIELD(STATUS, CMDQV_ENABLED, 0, 1)
> +
> +/* SMMU_CMDQV_VI_ERR_MAP_0/1 definitions */
> +#define A_VI_ERR_MAP_0 0x14
> +#define A_VI_ERR_MAP_1 0x18
> +#define V_VI_ERR_MAP_NO_ERROR (0)
> +#define V_VI_ERR_MAP_ERROR (1)
> +
> +/* SMMU_CMDQV_VI_INT_MASK_0/1 definitions */
> +#define A_VI_INT_MASK_0 0x1c
> +#define A_VI_INT_MASK_1 0x20
> +#define V_VI_INT_MASK_NOT_MASKED (0)
> +#define V_VI_INT_MASK_MASKED (1)
> +
> +/* SMMU_CMDQV_CMDQ_ERR_MAP_0-3 definitions */
> +#define A_CMDQ_ERR_MAP_0 0x24
> +#define A_CMDQ_ERR_MAP_1 0x28
> +#define A_CMDQ_ERR_MAP_2 0x2c
> +#define A_CMDQ_ERR_MAP_3 0x30
> +
> +/*
> + * CMDQ_ALLOC_MAP: one entry per physical VCMDQ. Hardware supports up to 128
> + * entries (CMDQV_NUM_CMDQ_LOG2=7), but QEMU only exposes
> + * TEGRA241_CMDQV_MAX_CMDQ (=2) VCMDQs per VM so only entries 0 and 1 are
> + * defined here.
> + */
> +/* 2 identical register entries */
> +#define SMMU_CMDQV_CMDQ_ALLOC_MAP_(i)                       \
> +    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4)                \
> +    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)                  \
> +    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)                 \
> +    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
> +
> +SMMU_CMDQV_CMDQ_ALLOC_MAP_(0)
> +SMMU_CMDQV_CMDQ_ALLOC_MAP_(1)
> +
> +/* SMMU_CMDQV_VINTF0 registers (only VINTF0 is exposed to the guest) */
> +REG32(VINTF0_CONFIG, 0x1000)
> +FIELD(VINTF0_CONFIG, ENABLE, 0, 1)
> +FIELD(VINTF0_CONFIG, VMID, 1, 16)
> +FIELD(VINTF0_CONFIG, HYP_OWN, 17, 1)
> +
> +REG32(VINTF0_STATUS, 0x1004)
> +FIELD(VINTF0_STATUS, ENABLE_OK, 0, 1)
> +FIELD(VINTF0_STATUS, STATUS, 1, 3)
> +FIELD(VINTF0_STATUS, VI_NUM_LVCMDQ, 16, 8)
> +
> +#define V_VINTF_STATUS_NO_ERROR    (0 << 1)
> +#define V_VINTF_STATUS_VCMDQ_ERROR (1 << 1)
> +
> +/*
> + * SMMU_CMDQV_VINTF0_SID_MATCH/_REPLACE: 16 entries per VINTF
> + * (CMDQV_NUM_SID_PER_VI_LOG2=4). Only _0 and _15 are defined,
> + * used as switch case range bounds.
> + */
> +REG32(VINTF0_SID_MATCH_0, 0x1040)
> +FIELD(VINTF0_SID_MATCH_0, ENABLE, 0, 1)
> +FIELD(VINTF0_SID_MATCH_0, VIRT_SID, 1, 20)
> +#define A_VINTF0_SID_MATCH_15  (A_VINTF0_SID_MATCH_0 + 15 * 4)
> +
> +REG32(VINTF0_SID_REPLACE_0, 0x1080)
> +FIELD(VINTF0_SID_REPLACE_0, PHYS_SID, 0, 20)
> +#define A_VINTF0_SID_REPLACE_15 (A_VINTF0_SID_REPLACE_0 + 15 * 4)
> +
> +/*
> + * SMMU_CMDQV_VINTF0_LVCMDQ_ERR_MAP: 4 registers per VINTF covering 32 logical
> + * VCMDQs each. With TEGRA241_CMDQV_MAX_CMDQ=2, only MAP_0 bits [1:0] carry
> + * error state. MAP_1..MAP_3 always read as 0. Only _0 and _3 are defined,
> + * used as switch case range bounds.
> + */
> +REG32(VINTF0_LVCMDQ_ERR_MAP_0, 0x10c0)
> +FIELD(VINTF0_LVCMDQ_ERR_MAP_0, LVCMDQ_ERR_MAP, 0, 32)
> +#define A_VINTF0_LVCMDQ_ERR_MAP_3 (A_VINTF0_LVCMDQ_ERR_MAP_0 + 3 * 4)
> +
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>  
>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 6a6cfc2f71..813b9a61ce 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -8,20 +8,200 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  
>  #include "hw/arm/smmuv3.h"
>  #include "hw/arm/smmuv3-common.h"
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
> +#include "trace.h"
>  
> -static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset, unsigned size)
> +static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
> +                                                 hwaddr offset)
>  {
> -    return 0;
> +    int i;
> +
> +    switch (offset) {
> +    case A_VINTF0_CONFIG:
> +        return cmdqv->vintf_config;
> +    case A_VINTF0_STATUS:
> +        return cmdqv->vintf_status;
> +    case A_VINTF0_SID_MATCH_0 ... A_VINTF0_SID_MATCH_15:
> +        i = (offset - A_VINTF0_SID_MATCH_0) / 4;
> +        return cmdqv->vintf_sid_match[i];
> +    case A_VINTF0_SID_REPLACE_0 ... A_VINTF0_SID_REPLACE_15:
> +        i = (offset - A_VINTF0_SID_REPLACE_0) / 4;
> +        return cmdqv->vintf_sid_replace[i];
> +    case A_VINTF0_LVCMDQ_ERR_MAP_0 ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> +        i = (offset - A_VINTF0_LVCMDQ_ERR_MAP_0) / 4;
> +        return cmdqv->vintf_cmdq_err_map[i];
> +    default:
> +        /*
> +         * GLB_FILT_CFG_0 (offset 0xC) and GLB_FILT_DATA_0 (offset 0x10) are
> +         * filter config and filter data registers. They are not required for
> +         * normal VINTF operation and are not emulated.
> +         */
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +}
> +
> +static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
> +                                              hwaddr offset, uint64_t value)
> +{
> +    int i;
> +
> +    switch (offset) {
> +    case A_VINTF0_CONFIG:
> +        /*
> +         * Mask out HYP_OWN on guest writes. This bit selects Hypervisor (1) vs
> +         * Guest (0) ownership of the CMDQ. Force it to 0 so the VINTF always
> +         * remains guest-owned.
> +         */
> +        value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
> +
> +        cmdqv->vintf_config = value;
> +        if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
> +            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
> +        } else {
> +            cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
> +        }
> +        break;
> +    case A_VINTF0_SID_MATCH_0 ... A_VINTF0_SID_MATCH_15:
> +        i = (offset - A_VINTF0_SID_MATCH_0) / 4;
> +        cmdqv->vintf_sid_match[i] = value;
> +        break;
> +    case A_VINTF0_SID_REPLACE_0 ... A_VINTF0_SID_REPLACE_15:
> +        i = (offset - A_VINTF0_SID_REPLACE_0) / 4;
> +        cmdqv->vintf_sid_replace[i] = value;
> +        break;
> +    default:
> +        /*
> +         * GLB_FILT_CFG_0 (offset 0xC) and GLB_FILT_DATA_0 (offset 0x10) are
> +         * filter config and filter data registers. They are not required for
> +         * normal VINTF operation and are not emulated.
> +         */
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return;
> +    }
>  }
>  
> -static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset, uint64_t value,
> -                                 unsigned size)
> +static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
> +                                         unsigned size)
>  {
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +    uint64_t val = 0;
> +
> +    if (offset >= TEGRA241_CMDQV_IO_LEN) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s offset 0x%" PRIx64 " off limit (0x%x)\n", __func__,
> +                      offset, TEGRA241_CMDQV_IO_LEN);
> +        goto out;
> +    }
> +
> +    switch (offset) {
> +    case A_CONFIG:
> +        val = cmdqv->config;
> +        break;
> +    case A_PARAM:
> +        val = cmdqv->param;
> +        break;
> +    case A_STATUS:
> +        val = cmdqv->status;
> +        break;
> +    case A_VI_ERR_MAP_0 ... A_VI_ERR_MAP_1:
> +        val = cmdqv->vi_err_map[(offset - A_VI_ERR_MAP_0) / 4];
> +        break;
> +    case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
> +        val = cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4];
> +        break;
> +    case A_CMDQ_ERR_MAP_0 ... A_CMDQ_ERR_MAP_3:
> +        val = cmdqv->cmdq_err_map[(offset - A_CMDQ_ERR_MAP_0) / 4];
> +        break;
> +    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
> +        val = cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
> +        break;
> +    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> +        val = tegra241_cmdqv_config_vintf_read(cmdqv, offset);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +    }
> +
> +out:
> +    trace_tegra241_cmdqv_read_mmio(offset, val, size);
> +    return val;
> +}
> +
> +/* 4-byte MMIO write handler. */
> +static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
> +                                       uint32_t value)
> +{
> +    switch (offset) {
> +    case A_CONFIG:
> +        cmdqv->config = value;
> +        if (value & R_CONFIG_CMDQV_EN_MASK) {
> +            cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
> +        } else {
> +            cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
> +        }
> +        break;
> +    case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
> +        cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4] = value;
> +        break;
> +    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
> +        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
> +        break;
> +    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> +        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +    }
> +}
> +
> +/*
> + * 8-byte MMIO write handler.
> + */
> +static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
> +                                        uint64_t value)
> +{
> +    qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
> +                      __func__, offset);
> +}
> +
> +static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
> +                                      uint64_t value, unsigned size)
> +{
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +
> +    if (offset >= TEGRA241_CMDQV_IO_LEN) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s offset 0x%" PRIx64 " off limit (0x%x)\n", __func__,
> +                      offset, TEGRA241_CMDQV_IO_LEN);
> +        goto out;
> +    }
> +
> +    switch (size) {
> +    case 4:
> +        tegra241_cmdqv_writel_mmio(cmdqv, offset, value);
> +        break;
> +    case 8:
> +        tegra241_cmdqv_writell_mmio(cmdqv, offset, value);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s bad write size %u at 0x%" PRIx64 "\n",
> +                      __func__, size, offset);
> +    }
> +
> +out:
> +    trace_tegra241_cmdqv_write_mmio(offset, value, size);
>  }
>  
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 3457536fb0..8c61d66a26 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -72,6 +72,10 @@ smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev dev
>  smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
>  smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
>  
> +# tegra241-cmdqv
> +tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
> +tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
> +
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
>  strongarm_ssp_read_underrun(void) "SSP rx underrun"
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


