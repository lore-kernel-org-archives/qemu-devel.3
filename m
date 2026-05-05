Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DC2CD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 07:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKABT-0000RM-Mn; Tue, 05 May 2026 03:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKABR-0000Qi-2m
 for qemu-devel@nongnu.org; Tue, 05 May 2026 03:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wKABO-00009N-Og
 for qemu-devel@nongnu.org; Tue, 05 May 2026 03:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777966024;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqZXWSPNcUPBLZavDcucIL1KZfl/Drgz+DHAA7NcgHM=;
 b=ckPGWZW2RG4JEqH6AxFRJ6E2GfhmM7Dxa4Eo6v63wWtLxOY4EDp5My+4alWgYn+FLdEqxQ
 4ttC//0LH9f8Gk2QFhBq5Kr2+/RgcqEz72H5izFzWcBtY228OalgbZ4LXXgapT67bC5JnX
 I2RusKTplMbEHtIdhB9ht05OXidLe1E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-2gdRWGnyP-SvdiwN9WaNfg-1; Tue, 05 May 2026 03:27:03 -0400
X-MC-Unique: 2gdRWGnyP-SvdiwN9WaNfg-1
X-Mimecast-MFC-AGG-ID: 2gdRWGnyP-SvdiwN9WaNfg_1777966022
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a2c034fso3746637f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 00:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777966022; x=1778570822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqZXWSPNcUPBLZavDcucIL1KZfl/Drgz+DHAA7NcgHM=;
 b=IyzmZXJSH/3/gk09BSSNDES4MxeDSq0vp7ABTZWnOGvVH2hO9+9NHlebGE2Hp4FbOc
 visRehGWRXMw+vxI8p0d14qfWaPjbxHmLUDezgQBUYxV3glxIQ2SlafGyTCKvcxevJXv
 DNjHYM+4M0f/+hK4Wj4L9stmyOakoG+PabyVnVRP4nVXeH3McfIv5b59qv7g7yKGNHXG
 PxBoHACCrtoba7NkvFuUo1UC9Xsejor24d06MkOBCARdHrmITvihweptvxYhuf1iNWEo
 /iEVy5jwMI7lpUcxzT3efh2kDnXNyJ0BnaDil3HG7bI+zlv7Ni9Zqaig2nuuy0DME0HB
 INNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iHHdCIyIkYNf+U9DLeb4WK0Usj93n/0dWf5wl+/Cb2wPM05Y3+O0RylUy+/HaV6GoIWh7R4Zx+auM@nongnu.org
X-Gm-Message-State: AOJu0YyhUQiU6qJVt5DhfdW+gSzWU3RiXufFse1+IQFTTUa0cLFQwuuQ
 cWvGf+FtEvM3fyDPqPzOH1Y9NhEs5P7hAAW7sOjlQNQc7N7UhlH5/YVqgA6FPkGexahKY6sspCs
 InNPHQJsf4qSqRmu0pdizhxOS/7taLLmJKFJjCzUTdofeWjbMtFAwPpll
X-Gm-Gg: AeBDieuvsG5C4mlJSt0AX+MUHjZQ7xEfF2OziNc+ROJOTPWY/d035SszlyVY2evv0Wj
 VrAMVveShWB2/sjxXS4d+BhATVs/Fa46sN+BZ0ShmcPMM7KHyN2MI3JpDZkPoxqSnk2Jx2mXXqy
 w5OkLMa5xPrtBQX/Sit6BxFvEi1q8pA7ZFZ023XiJ4HdZL27EyAyiqnMuYcA9Xark8m5BDYj9ZZ
 e64MKN1YvUbrEzpKg4IRe3gUcd7/2s/DuevD4CPpjmbmq5dPX7r5fkx40kKt+m5re+adQ3Agx+J
 H1VtEqYwz3ajoIrXLcxLe62NXYvPxhdTPzZtprleZEQH2sNBuv8EaScLi2Gn4uDj4K5tN3IuZHU
 81AdvSWqhtprIBTGwH2vFKR6/JmWMcja043Xhdg5KZUxO0NfskK0q7IKRLYcuvU3MqUnCh04N2F
 bZOGTB
X-Received: by 2002:a05:600c:c08d:b0:488:ffad:6728 with SMTP id
 5b1f17b1804b1-48d18ce221dmr19744565e9.19.1777966021945; 
 Tue, 05 May 2026 00:27:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c08d:b0:488:ffad:6728 with SMTP id
 5b1f17b1804b1-48d18ce221dmr19744165e9.19.1777966021469; 
 Tue, 05 May 2026 00:27:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48911sm2443751f8f.11.2026.05.05.00.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 00:27:00 -0700 (PDT)
Message-ID: <279d7659-b2e6-4620-a5c9-fbc71c55d099@redhat.com>
Date: Tue, 5 May 2026 09:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/31] hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config
 region
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-15-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-15-skolothumtho@nvidia.com>
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
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h | 127 +++++++++++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.c | 163 ++++++++++++++++++++++++++++++++++++++--
>  hw/arm/trace-events     |   4 +
>  3 files changed, 288 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index fa0aa3ab04..965670066d 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -10,10 +10,14 @@
>  #ifndef HW_ARM_TEGRA241_CMDQV_H
>  #define HW_ARM_TEGRA241_CMDQV_H
>  
> +#include "hw/core/registerfields.h"
> +
>  #define CMDQV_VER                 1
>  #define CMDQV_NUM_CMDQ_LOG2       1
>  #define CMDQV_NUM_SID_PER_VI_LOG2 4
>  
> +#define TEGRA241_CMDQV_MAX_CMDQ   (1U << CMDQV_NUM_CMDQ_LOG2)
> +
>  /*
>   * Tegra241 CMDQV MMIO layout (64KB pages)
>   *
> @@ -31,8 +35,131 @@ typedef struct Tegra241CMDQV {
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
>      IOMMUFDVeventq *veventq;
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
> +#define A_VI_INT_MASK 0x1c
pls use spec terminology: _0


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
> +#define SMMU_CMDQV_CMDQ_ALLOC_MAP_(i)        \
> +    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4) \
> +    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)   \
> +    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)  \
> +    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
> +
> +SMMU_CMDQV_CMDQ_ALLOC_MAP_(0)
> +SMMU_CMDQV_CMDQ_ALLOC_MAP_(1)
> +
> +
> +/* Only VINTF0 is exposed to the guest; vintf = 0 */
is it supposed to evolve? Otherwise we can keep things simple and just
define a single

SMMU_CMDQV_VINTF0_CONFIG_0 and same for the rest.


> +#define SMMU_CMDQV_VINTFi_CONFIG_(vi)                 \
> +    REG32(VINTF##vi##_CONFIG, 0x1000 + vi * 0x100) \
> +    FIELD(VINTF##vi##_CONFIG, ENABLE, 0, 1)       \
> +    FIELD(VINTF##vi##_CONFIG, VMID, 1, 16)        \
> +    FIELD(VINTF##vi##_CONFIG, HYP_OWN, 17, 1)
> +
> +SMMU_CMDQV_VINTFi_CONFIG_(0)
> +
> +#define SMMU_CMDQV_VINTFi_STATUS_(vi)                 \
> +    REG32(VINTF##vi##_STATUS, 0x1004 + vi * 0x100) \
> +    FIELD(VINTF##vi##_STATUS, ENABLE_OK, 0, 1)    \
> +    FIELD(VINTF##vi##_STATUS, STATUS, 1, 3)       \
> +    FIELD(VINTF##vi##_STATUS, VI_NUM_LVCMDQ, 16, 8)
> +
> +SMMU_CMDQV_VINTFi_STATUS_(0)
> +
> +#define V_VINTF_STATUS_NO_ERROR (0 << 1)
> +#define V_VINTF_STATUS_VCMDQ_ERROR (1 << 1)
> +
> +/*
> + * SID_MATCH/SID_REPLACE: 16 entries per VINTF (CMDQV_NUM_SID_PER_VI_LOG2=4).
> + * vintf = 0, 16 identical register entries
> + */
> +#define SMMU_CMDQV_VINTFi_SID_MATCH_(vi, j)  
this could also be simplified
>                         \
> +    REG32(VINTF##vi##_SID_MATCH_##j, 0x1040 + j * 4 + vi * 0x100) \
> +    FIELD(VINTF##vi##_SID_MATCH_##j, ENABLE, 0, 1)               \
> +    FIELD(VINTF##vi##_SID_MATCH_##j, VIRT_SID, 1, 20)
> +
> +SMMU_CMDQV_VINTFi_SID_MATCH_(0, 0)
> +/* Omitting [0][1~14] as not being directly called */
> +SMMU_CMDQV_VINTFi_SID_MATCH_(0, 15)
> +
> +/* vintf = 0, 16 identical register entries */
> +#define SMMU_CMDQV_VINTFi_SID_REPLACE_(vi, j)                          \
> +    REG32(VINTF##vi##_SID_REPLACE_##j, 0x1080 + j * 4 + vi * 0x100) \
> +    FIELD(VINTF##vi##_SID_REPLACE_##j, PHYS_SID, 0, 20)
> +
> +SMMU_CMDQV_VINTFi_SID_REPLACE_(0, 0)
> +/* Omitting [0][1~14] as not being directly called */
why?
> +SMMU_CMDQV_VINTFi_SID_REPLACE_(0, 15)
> +
> +/*
> + * LVCMDQ_ERR_MAP: hardware defines 4 registers per VINTF (offset
> + * 0x10c0..0x10cc), each covering 32 logical VCMDQs. All 4 are accessible
> + * by the guest. With TEGRA241_CMDQV_MAX_CMDQ=2 only MAP_0 bits [1:0]
> + * carry meaningful error state; MAP_1..MAP_3 always read as 0.
> + * vintf = 0, 4 identical register entries
> + */
> +#define SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(vi, j)  
Again I won't add this extra complexity, get rid of vi everywhere for now.
>                         \
> +    REG32(VINTF##vi##_LVCMDQ_ERR_MAP_##j, 0x10c0 + j * 4 + vi * 0x100) \
> +    FIELD(VINTF##vi##_LVCMDQ_ERR_MAP_##j, LVCMDQ_ERR_MAP, 0, 32)
> +
> +SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
> +/* MAP_1 and MAP_2 omitted; not referenced directly */
> +SMMU_CMDQV_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
> +
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>  
>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 2f1084b55f..3b08ed0ff3 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -8,19 +8,170 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  
>  #include "hw/arm/smmuv3.h"
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
> +#include "trace.h"
>  
> -static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
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
> +}
> +
> +static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
> +                                         unsigned size)
> +{
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
> +    case A_VI_INT_MASK ... A_VI_INT_MASK_1:
> +        val = cmdqv->vi_int_mask[(offset - A_VI_INT_MASK) / 4];
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
>  }
>  
> -static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
> -                                 unsigned size)
> +static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
> +                                      uint64_t value, unsigned size)
>  {
> +    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
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
> +        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +    }
> +
> +out:
> +    trace_tegra241_cmdqv_write_mmio(offset, value, size);
>  }
>  
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
> @@ -84,8 +235,8 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
>  }
>  
>  static const MemoryRegionOps mmio_cmdqv_ops = {
> -    .read = tegra241_cmdqv_read,
> -    .write = tegra241_cmdqv_write,
> +    .read = tegra241_cmdqv_read_mmio,
> +    .write = tegra241_cmdqv_write_mmio,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
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
Thanks

Eric


