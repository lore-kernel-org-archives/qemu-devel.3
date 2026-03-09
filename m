Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC99AF4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdY0-0006Bx-22; Mon, 09 Mar 2026 12:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzdXy-0006B2-HV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzdXw-00071c-Gk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773074011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzsGv2nEA+RlxnGGvE+xj8vZD8g066zVUIL779XMY34=;
 b=RvI0z7mgOb3Tzah6lgTsOCnwyJ4tFByFbRrOMC5icxfSocRwWONnGKMyNh0LPNfddYtzjM
 P2AsbOmB8RDIjybxnlQ5UJqIJgAdoQsA1KYjmoTEVAMUZh7zLKCtvu8E3oKsiO2gm8Me7g
 eyS1KWQ5KJUnnE/7r37DDh+qr0E0osA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-IEnmrNCUNMSbmudfEGejsw-1; Mon, 09 Mar 2026 12:33:29 -0400
X-MC-Unique: IEnmrNCUNMSbmudfEGejsw-1
X-Mimecast-MFC-AGG-ID: IEnmrNCUNMSbmudfEGejsw_1773074009
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-485375aa56eso11872325e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773074008; x=1773678808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzsGv2nEA+RlxnGGvE+xj8vZD8g066zVUIL779XMY34=;
 b=mMXjWlkwHGRUObib3FXycu+Ga0kBKu9jsTbR87dh5lpBRv07pB2KLEFIPbe9s4wdTQ
 7w0CLPAYV6t2QM8M/8kG+PCmxo6IewsYZhTNYMKYgeWXzmBlgrraIvCh/e34gk1mUJ6/
 Yw4q//B5S8VNbjLaV1YRo/KcO9L+GqA07NWeZX1K8oqop0R6dFBC73Gg+2bns60P69Qo
 M9HMjKotfWY6esHaPGq9U4ibi/t30cTL5P2JSdY+JZllQYVDnpg1SU5GF1RbK1ZiwWyK
 HXouHjE3/GWfXai0P89kozpCcP/TYziRnZomu7hqJWogvTZYsUzhVpeFm/tD5qf4qOGN
 pGBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdKjJc3YC/rk8zbElEWwDxrQIJmpWMwFKxWuu2rK0IiBfMAMDX/bEoyFZu///1abLiu1GQUsd+VmAe@nongnu.org
X-Gm-Message-State: AOJu0YwUqA89yIb4PLEhdNSQJJxlgdy4rtxEzRr6SpXtrddnxjPpVPeg
 cFdgaqNOqJpozFeNOUym15/lxStu9DMLnxEpS6MmmbkD/NpR0rP6//8kHUFd74GiObqHqGhw/9k
 9AwA6kAzPj8ILZci/hKTvirc6DKxeqXXk3R60DK+GdvAU5AuOwVey9KSE
X-Gm-Gg: ATEYQzwsbAbE0fTvR7xw9j/dMPBu48bHDeZo9vtELb9CdYLpDMxrGmdkdPc2w+pbbPs
 xbNVjA10CObeAzssslaM0fZ6p0Gniz5tZ1R8ojrdWSQfyAIvIuU8urAvORJORKYJOfaRgvLiC7t
 pojLz0YLqUagej96/7dI98DSfp99BGBQAB4xiV3iHcpzyItd7Vkd4V545hcYGIApilArXg2LDNG
 ptQz5kMboXBqo5ulXGFoRRPcDxOXtysrCZmnQwiTh/NxLUHcyvKb+5t3dY4Q03m/jkZ+tggYNms
 tJp4t5BSSlvGFyKO7MCNaNbL920pgMTlIyfQz+AafPF4ChSly378LPsJcj5Q5aiEHViLKjw7tWv
 xlrh7OfT9oCGrDkBCaYQH9pvKNsMUG2fr6ZWVSpchnw3CIy6eHXfhySOt88nJi6A/P0t7Ug==
X-Received: by 2002:a05:6000:2902:b0:439:be86:5051 with SMTP id
 ffacd0b85a97d-439da8a35e6mr20500007f8f.59.1773074008380; 
 Mon, 09 Mar 2026 09:33:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2902:b0:439:be86:5051 with SMTP id
 ffacd0b85a97d-439da8a35e6mr20499917f8f.59.1773074007740; 
 Mon, 09 Mar 2026 09:33:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae57c05sm25765514f8f.39.2026.03.09.09.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 09:33:27 -0700 (PDT)
Message-ID: <122fbdb7-c162-4809-89ab-d900d9845182@redhat.com>
Date: Mon, 9 Mar 2026 17:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/32] hw/arm/tegra241-cmdqv: Emulate global CMDQV
 registers
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-15-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Tegra241 CMDQV defines a set of global control and status registers
> used to configure virtual command queue allocation and interrupt
> behavior.
>
> Add read/write emulation for the global CMDQV register page
> (offset 0x00000), backed by a simple register cache. This includes
> CONFIG, PARAM, STATUS, VI error and interrupt maps, CMDQ allocation
> map and the VINTF0 related registers defined in the global CMDQV
> register space.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h | 108 +++++++++++++++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.c | 121 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 228 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 46aa9e8a9f..50bcecee9d 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -10,6 +10,9 @@
>  #ifndef HW_ARM_TEGRA241_CMDQV_H
>  #define HW_ARM_TEGRA241_CMDQV_H
>  
> +#include "hw/core/registerfields.h"
> +#include "smmuv3-accel.h"
> +
>  #define TEGRA241_CMDQV_VERSION             1
>  #define TEGRA241_CMDQV_NUM_CMDQ_LOG2       1
>  #define TEGRA241_CMDQV_MAX_CMDQ            (1U << TEGRA241_CMDQV_NUM_CMDQ_LOG2)
> @@ -31,8 +34,113 @@ typedef struct Tegra241CMDQV {
>      SMMUv3AccelState *s_accel;
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
> +
> +    /* Register Cache */
> +    uint32_t config;
> +    uint32_t param;
> +    uint32_t status;
> +    uint32_t vi_err_map[2];
> +    uint32_t vi_int_mask[2];
> +    uint32_t cmdq_err_map[4];
> +    uint32_t cmdq_alloc_map[TEGRA241_CMDQV_MAX_CMDQ];
> +    uint32_t vintf_config;
> +    uint32_t vintf_status;
> +    uint32_t vintf_sid_match[16];
> +    uint32_t vintf_sid_replace[16];
> +    uint32_t vintf_cmdq_err_map[4];
>  } Tegra241CMDQV;
>  
> +/* Global CMDQV MMIO registers (offset 0x00000) */
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
> +FIELD(PARAM, CMDQV_NUM_VM_LOG2, 8, 4)
this is called CMDQV_NUM_VI_LOG2 in the spec I have access to
VI = virtual interface
I guess there is 1-1 mapping vetween VI and VM but I would keep spec naming
> +FIELD(PARAM, CMDQV_NUM_SID_PER_VM_LOG2, 12, 4)
same here s/VM/VI
> +
> +REG32(STATUS, 0x8)
> +FIELD(STATUS, CMDQV_ENABLED, 0, 1)
> +
I would add "SMMU_CMDQV_VI_ERR_MAP_0/1 definitions"
> +#define A_VI_ERR_MAP 0x14
_0?
> +#define A_VI_ERR_MAP_1 0x18
> +#define V_VI_ERR_MAP_NO_ERROR (0)
> +#define V_VI_ERR_MAP_ERROR (1)
> +
same SMMU_CMDQV_VI_ING_MASK0/1
> +#define A_VI_INT_MASK 0x1c
> +#define A_VI_INT_MASK_1 0x20
> +#define V_VI_INT_MASK_NOT_MASKED (0)
> +#define V_VI_INT_MASK_MASKED (1)
> +
SMMU_CMDQV_CMDQ_ERR_MAP0-3
> +#define A_CMDQ_ERR_MAP 0x24
> +#define A_CMDQ_ERR_MAP_1 0x28
> +#define A_CMDQ_ERR_MAP_2 0x2c
> +#define A_CMDQ_ERR_MAP_3 0x30
> +
> +/* i = [0, 1] */

> +#define A_CMDQ_ALLOC_MAP_(i)   
why A_? Since you rely on the REG macros, A_ should prefix the address
offset
Can't we call that SMMU_CMDQV_CMDQ_ALLOC_MAP_() as it is refered to in
the spec?
>               \
> +    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4) \
> +    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)   \
> +    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)  \
> +    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
> +
Please explain why we only expose 2 of those regs among 128?
> +A_CMDQ_ALLOC_MAP_(0)
> +A_CMDQ_ALLOC_MAP_(1)
> +
> +
> +/* i = [0, 0] */
> +#define A_VINTFi_CONFIG(i)     
again why don't we use the spec terminology
SMMU_CMDQV_VINTF0_CONFIG_0
>                   \
> +    REG32(VINTF##i##_CONFIG, 0x1000 + i * 0x100) \
> +    FIELD(VINTF##i##_CONFIG, ENABLE, 0, 1)       \
> +    FIELD(VINTF##i##_CONFIG, VMID, 1, 16)        \
> +    FIELD(VINTF##i##_CONFIG, HYP_OWN, 17, 1)
> +
> +A_VINTFi_CONFIG(0)
> +
> +#define A_VINTFi_STATUS(i)                       \
> +    REG32(VINTF##i##_STATUS, 0x1004 + i * 0x100) \
> +    FIELD(VINTF##i##_STATUS, ENABLE_OK, 0, 1)    \
> +    FIELD(VINTF##i##_STATUS, STATUS, 1, 3)       \
> +    FIELD(VINTF##i##_STATUS, VI_NUM_LVCMDQ, 16, 8)
> +
> +A_VINTFi_STATUS(0)
> +
> +#define V_VINTF_STATUS_NO_ERROR (0 << 1)
> +#define V_VINTF_STATUS_VCMDQ_EROR (1 << 1)
Nit: the spec also contains the typo but I would rather fix it in the code

Explicitly state we only expose 1 VINTF
> +
> +/* i = [0, 0], j = [0, 15] */
does that mean that we can have a max 16 SIDs per VM?
> +#define A_VINTFi_SID_MATCH_(i, j) 
if matched vi, I would prefer vi
>                               \
> +    REG32(VINTF##i##_SID_MATCH_##j, 0x1040 + j * 4 + i * 0x100) \
> +    FIELD(VINTF##i##_SID_MATCH_##j, ENABLE, 0, 1)               \
> +    FIELD(VINTF##i##_SID_MATCH_##j, VIRT_SID, 1, 20)
> +
> +A_VINTFi_SID_MATCH_(0, 0)
> +/* Omitting [0][1~14] as not being directly called */
> +A_VINTFi_SID_MATCH_(0, 15)
> +
> +/* i = [0, 0], j = [0, 15] */
vint = 0, 16 identical register entries
> +#define A_VINTFi_SID_REPLACE_(i, j)                               \
> +    REG32(VINTF##i##_SID_REPLACE_##j, 0x1080 + j * 4 + i * 0x100) \
> +    FIELD(VINTF##i##_SID_REPLACE_##j, PHYS_SID, 0, 19)
s/19/20
> +
> +A_VINTFi_SID_REPLACE_(0, 0)
> +/* Omitting [0][1~14] as not being directly called */
> +A_VINTFi_SID_REPLACE_(0, 15)
> +
> +/* i = [0, 0], j = [0, 3] */
vi = 0, 4 identical regs
> +#define A_VINTFi_LVCMDQ_ERR_MAP_(i, j)                               \
> +    REG32(VINTF##i##_LVCMDQ_ERR_MAP_##j, 0x10c0 + j * 4 + i * 0x100) \
> +    FIELD(VINTF##i##_LVCMDQ_ERR_MAP_##j, LVCMDQ_ERR_MAP, 0, 32)
> +
> +A_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
> +/* Omitting [0][1~2] as not being directly called */
I don't get this comment
> +A_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
> +
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>  
>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index d487612ba2..a3830a02d6 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -8,19 +8,138 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  
>  #include "hw/arm/smmuv3.h"
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
>  
> +static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
> +{
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
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +}
> +
>  static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
>  {
> -    return 0;
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +
> +    if (offset >= TEGRA241_CMDQV_IO_LEN) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
> +                      offset);
If all those regs belong to the Global CMDQV registers page this shall
be within the first 64KB
> +        return 0;
> +    }
> +
> +    switch (offset) {
> +    case A_CONFIG:
> +        return cmdqv->config;
> +    case A_PARAM:
> +        return cmdqv->param;
> +    case A_STATUS:
> +        return cmdqv->status;
> +    case A_VI_ERR_MAP ... A_VI_ERR_MAP_1:
> +        return cmdqv->vi_err_map[(offset - A_VI_ERR_MAP) / 4];
> +    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
> +        return cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4];
> +    case A_CMDQ_ERR_MAP ... A_CMDQ_ERR_MAP_3:
> +        return cmdqv->cmdq_err_map[(offset - A_CMDQ_ERR_MAP) / 4];
> +    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
> +        return cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
> +    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> +        return tegra241_cmdqv_read_vintf(cmdqv, offset);
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +}
> +
> +static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
> +                                       uint64_t value)
> +{
> +    int i;
> +
> +    switch (offset) {
> +    case A_VINTF0_CONFIG:
> +        /* Strip off HYP_OWN setting from guest kernel */
> +        value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
Can you explain why this needed?
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
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return;
> +    }
>  }
nit: if you can put write_vintf just after its read fellow, I think it
would ease the comparison/review
>  
>  static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
>                                   unsigned size)
>  {
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +
> +    if (offset >= TEGRA241_CMDQV_IO_LEN) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
> +                      offset);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    case A_CONFIG:
> +        cmdqv->config = value;
> +        if (value & R_CONFIG_CMDQV_EN_MASK) {
> +            cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
> +        } else {
> +            cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
> +        }
> +        break;
> +    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
> +        cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4] = value;
> +        break;
> +    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
> +        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
> +        break;
> +    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> +        tegra241_cmdqv_write_vintf(cmdqv, offset, value);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +    }
>  }
>  
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)

At this stage of the reading it is unclear to me why we need to expose
all those regs to the guest. I would assume that a subset of them are
used by the hyp and not supposed to be accessed by the guest. For
instance the SID match/replace, ...

Please could you clairfy what is absolutely needed to expose to the guest?

Thanks

Eric


