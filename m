Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0775BD13C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOHn-0000Br-Jq; Mon, 26 Jan 2026 10:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkOHk-0000B2-G2
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkOHh-0004xW-K1
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769440424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrYFQ9Feglu7ykHaUOJljZFP8Ka7AAl21gZd7oVwO5g=;
 b=RQj+pBuBB3/HtnLGs2X0t8Yfv7qAiBi4JqPK5Lpl2fdMoDCgs3O7GQZKDa5hYq6XYcqRoJ
 DqdtvfUsUSXNPHIm1IeE+ksd5Ncavv2X7OQsw9fKRV/UTCZJw9qQitF4zQYh4QJbLgKjJM
 lwxDmsA062dJivNP4cwH22WOanHgT54=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-s67jnDqRNo2L4CAfz9scow-1; Mon, 26 Jan 2026 10:13:43 -0500
X-MC-Unique: s67jnDqRNo2L4CAfz9scow-1
X-Mimecast-MFC-AGG-ID: s67jnDqRNo2L4CAfz9scow_1769440422
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee432070aso41706195e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440422; x=1770045222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrYFQ9Feglu7ykHaUOJljZFP8Ka7AAl21gZd7oVwO5g=;
 b=FhOTih1CfIDRSfxs1DH7AdFOmUXL81fAe1v+PHTYJgJTcddBs5hGdGU1eNDqNV9Qgy
 qVOIUY86/N+C8n2hX/lVjvle6UdSuMS5BjUoVYdi/L4nlKNO0PAiiV5YakfsSft6aIMS
 r8F/2Wi4bbdWwA91btPegmBLqDLMNiFxjvA6u9brl/Mpn+zxB4vVfF5GcIpNNRXTeenr
 eEaeXpgaCGhwnDizXheWUWl2xT/mj4jUZvN7/ul3/pD5kFTbCm5pzOm2xDecdz/6CCBw
 2j4jKjB8RkFQnEpwuH0V9O0GOXKmCCZr4zhQc56sfRuy+6O0MAuARc8aOr68x3Q/FxjN
 JE+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8tqT4YPSvv0rSk7HEBSslThYUQ8a6FE0OcjWcNy0itLxrRA9b/j2I3+lftIDUPp5r6C2VHWlTmZ0a@nongnu.org
X-Gm-Message-State: AOJu0YwtSZESUh+90uD/IQLCbgnyVUMNeBs9t39FbmR3OQgO3IDRbF16
 lyLSVktQCeEMMVJgYTo5C1puLs1LGafAorQAOKZK+2svi7zD7uJLFBawutpB8k2y3qb24q4ZmLC
 Q8Xl3RYMzujZ2Zm+9c5voxJd07GnBEFlEwR932aDoQbtaCfrm0mwHpL3L
X-Gm-Gg: AZuq6aIaJgw5ypa25kSUKH5eoc6D1tXgnKe9wyXwiwASjk8LSp0m0pNSfN5HvXLpPmU
 N4vVHIAYisos8yi95Hj11sPs1FSOD5+XZdQ4SbHkW8gqFoV3YQhMtf+FUanRWi089+P7Xw+h6cf
 fahqRpediY9UZPqeb5M3y1EL9WGQ3Qsq8dxJEjv6iOW6CQ25l+noUpt+7UM9Ju+H0PTfz6V86FZ
 k4pfpEgtMBHXgn2t+VyfZ8N4PXqbw3r1nDR5Wz6U6VERP2hV3b0tEIlyrvDJC0OPBwqaSgx4iAg
 XGi/BJlJCMJI8Pk42zG7M1TM14gQdiH7r9leirKOn92me291Navc6akwe6BlyUUWXYE0MnWoUlb
 f+vdrmPhW6IZShuQ+Vfnng5mnmaHcYEFzOYKh6codov5Edf0GTytc1WfJrw==
X-Received: by 2002:a05:600c:8710:b0:480:1aae:676c with SMTP id
 5b1f17b1804b1-4805e6fda7amr65607465e9.18.1769440421575; 
 Mon, 26 Jan 2026 07:13:41 -0800 (PST)
X-Received: by 2002:a05:600c:8710:b0:480:1aae:676c with SMTP id
 5b1f17b1804b1-4805e6fda7amr65607155e9.18.1769440420993; 
 Mon, 26 Jan 2026 07:13:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cf385sm348146675e9.13.2026.01.26.07.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 07:13:40 -0800 (PST)
Message-ID: <d50e2921-38a0-412f-ac9d-1d0d81490590@redhat.com>
Date: Mon, 26 Jan 2026 16:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/16] hw/arm/tegra241-cmdqv: Add read emulation
 support for registers
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-8-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Implement read support for Tegra241 CMDQV register blocks, including VINTF
> and per VCMDQ register regions. The patch decodes offsets, extracts queue
> indices, and returns the corresponding cached register state.
>
> Subsequent patch will add write support.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 144 +++++++++++++++++++-
>  hw/arm/tegra241-cmdqv.h | 282 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 425 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index d8858322dc..185ef957bc 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  
>  #include "hw/arm/smmuv3.h"
>  #include "smmuv3-accel.h"
> @@ -52,10 +53,94 @@ static bool tegra241_cmdqv_init_vcmdq_page0(Tegra241CMDQV *cmdqv, Error **errp)
>      return true;
>  }
>  
> +/* Note that offset aligns down to 0x1000 */
> +static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
> +{
> +    int i;
> +
> +    switch (offset) {
> +    case A_VINTF0_CONFIG:
> +        return cmdqv->vintf_config;
> +    case A_VINTF0_STATUS:
> +        return cmdqv->vintf_status;
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
> +/* Note that offset aligns down to 0x10000 */
> +static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset,
> +                                          int index)
the offset is within the instance, right? Better to rename it
differently from the main offset
> +{
> +    uint32_t *ptr = NULL;
> +    uint64_t off;
better initialize it?
> +
> +    /*
> +     * Each VCMDQ instance occupies a 128 byte region (0x80).
> +     * The hardware layout is:
> +     *   vcmdq_page0 + (index * 0x80) + (offset - 0x10000)
> +     */
> +    if (cmdqv->vcmdq_page0) {
> +        off = (0x80 * index) + (offset - 0x10000);
> +        ptr = (uint32_t *)(cmdqv->vcmdq_page0 + off);
I am confused because I understood page0 was mmapped so that the guest
could read it without VMM mediation?
> +    }
> +
> +    switch (offset) {
> +    case A_VCMDQ0_CONS_INDX:
> +        if (ptr) {
> +            cmdqv->vcmdq_cons_indx[index] = *ptr;
> +        }
> +        return cmdqv->vcmdq_cons_indx[index];
> +    case A_VCMDQ0_PROD_INDX:
> +        if (ptr) {
> +            cmdqv->vcmdq_prod_indx[index] = *ptr;
> +        }
> +        return cmdqv->vcmdq_prod_indx[index];
> +    case A_VCMDQ0_CONFIG:
> +        if (ptr) {
> +            cmdqv->vcmdq_config[index] = *ptr;
> +        }
> +        return cmdqv->vcmdq_config[index];
> +    case A_VCMDQ0_STATUS:
> +        if (ptr) {
> +            cmdqv->vcmdq_status[index] = *ptr;
> +        }
> +        return cmdqv->vcmdq_status[index];
> +    case A_VCMDQ0_GERROR:
> +        if (ptr) {
> +            cmdqv->vcmdq_gerror[index] = *ptr;
> +        }
> +        return cmdqv->vcmdq_gerror[index];
> +    case A_VCMDQ0_GERRORN:
> +        if (ptr) {
> +            cmdqv->vcmdq_gerrorn[index] = *ptr;
> +        }
> +        return cmdqv->vcmdq_gerrorn[index];
> +    case A_VCMDQ0_BASE_L:
> +        return cmdqv->vcmdq_base[index];
> +    case A_VCMDQ0_BASE_H:
> +        return cmdqv->vcmdq_base[index] >> 32;
> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
> +        return cmdqv->vcmdq_cons_indx_base[index];
> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
> +        return cmdqv->vcmdq_cons_indx_base[index] >> 32;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +}
>  static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
>      Error *local_err = NULL;
> +    int index;
>  
>      if (!cmdqv->vcmdq_page0) {
>          tegra241_cmdqv_init_vcmdq_page0(cmdqv, &local_err);
> @@ -65,7 +150,64 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
>          }
>      }
>  
> -    return 0;
> +    if (offset > TEGRA241_CMDQV_IO_LEN) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s offset 0x%" PRIx64 " off limit (0x50000)\n", __func__,
> +                      offset);
> +        return 0;
> +    }
> +
> +    /* Fallback to cached register values */
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
> +    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_127:
> +        return cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
> +    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> +        return tegra241_cmdqv_read_vintf(cmdqv, offset);
> +    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ127_GERRORN:
> +        offset -= 0x20000;
> +        QEMU_FALLTHROUGH;
> +    case A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN:
> +        /*
> +         * Align offset down to 0x10000 while extracting the index:
this is a bit cryptic to me. Could you explain this in the commit msg
> +         *   VCMDQ0_CONS_INDX  (0x10000) => 0x10000, 0
> +         *   VCMDQ1_CONS_INDX  (0x10080) => 0x10000, 1
> +         *   VCMDQ2_CONS_INDX  (0x10100) => 0x10000, 2
> +         *   ...
> +         *   VCMDQ127_CONS_INDX (0x13f80) => 0x10000, 127
> +         */
> +        index = (offset - 0x10000) / 0x80;
> +        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - 0x80 * index, index);
> +    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ127_CONS_INDX_BASE_DRAM_H:
> +        offset -= 0x20000;
> +        QEMU_FALLTHROUGH;
> +    case A_VCMDQ0_BASE_L ... A_VCMDQ127_CONS_INDX_BASE_DRAM_H:
> +        /*
> +         * Align offset down to 0x20000 while extracting the index:
> +         *   VCMDQ0_BASE_L  (0x20000) => 0x20000, 0
> +         *   VCMDQ1_BASE_L  (0x20080) => 0x20000, 1
> +         *   VCMDQ2_BASE_L  (0x20100) => 0x20000, 2
> +         *   ...
> +         *   VCMDQ127_BASE_L (0x23f80) => 0x20000, 127
> +         */
> +        index = (offset - 0x20000) / 0x80;
> +        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - 0x80 * index, index);
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
>  }
>  
>  static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index ccdf0651be..4972e367f6 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -10,6 +10,7 @@
>  #ifndef HW_TEGRA241_CMDQV_H
>  #define HW_TEGRA241_CMDQV_H
>  
> +#include "hw/registerfields.h"
>  #include CONFIG_DEVICES
>  
>  #define TEGRA241_CMDQV_IO_LEN 0x50000
> @@ -22,10 +23,291 @@ typedef struct Tegra241CMDQV {
>      MemoryRegion mmio_vcmdq_page;
>      MemoryRegion mmio_vintf_page;
>      void *vcmdq_page0;
> +    IOMMUFDHWqueue *vcmdq[128];
> +
> +    /* Register Cache */
> +    uint32_t config;
> +    uint32_t param;
> +    uint32_t status;
> +    uint32_t vi_err_map[2];
> +    uint32_t vi_int_mask[2];
> +    uint32_t cmdq_err_map[4];
> +    uint32_t cmdq_alloc_map[128];
> +    uint32_t vintf_config;
> +    uint32_t vintf_status;
> +    uint32_t vintf_cmdq_err_map[4];
> +    uint32_t vcmdq_cons_indx[128];
> +    uint32_t vcmdq_prod_indx[128];
> +    uint32_t vcmdq_config[128];
> +    uint32_t vcmdq_status[128];
> +    uint32_t vcmdq_gerror[128];
> +    uint32_t vcmdq_gerrorn[128];
> +    uint64_t vcmdq_base[128];
> +    uint64_t vcmdq_cons_indx_base[128];
>  } Tegra241CMDQV;
>  
> +/* MMIO Registers */
> +REG32(CONFIG, 0x0)
> +FIELD(CONFIG, CMDQV_EN, 0, 1)
> +FIELD(CONFIG, CMDQV_PER_CMD_OFFSET, 1, 3)
> +FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
> +FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
> +FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
> +
> +#define V_CONFIG_RESET 0x00020403
> +
> +REG32(PARAM, 0x4)
> +FIELD(PARAM, CMDQV_VER, 0, 4)
> +FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
> +FIELD(PARAM, CMDQV_NUM_VM_LOG2, 8, 4)
> +FIELD(PARAM, CMDQV_NUM_SID_PER_VM_LOG2, 12, 4)
> +
> +#define V_PARAM_RESET 0x00004011
> +
> +REG32(STATUS, 0x8)
> +FIELD(STATUS, CMDQV_ENABLED, 0, 1)
> +
> +#define A_VI_ERR_MAP 0x14
> +#define A_VI_ERR_MAP_1 0x18
> +#define V_VI_ERR_MAP_NO_ERROR (0)
> +#define V_VI_ERR_MAP_ERROR (1)
> +
> +#define A_VI_INT_MASK 0x1c
> +#define A_VI_INT_MASK_1 0x20
> +#define V_VI_INT_MASK_NOT_MASKED (0)
> +#define V_VI_INT_MASK_MASKED (1)
> +
> +#define A_CMDQ_ERR_MAP 0x24
> +#define A_CMDQ_ERR_MAP_1 0x28
> +#define A_CMDQ_ERR_MAP_2 0x2c
> +#define A_CMDQ_ERR_MAP_3 0x30
> +
> +/* i = [0, 127] */
> +#define A_CMDQ_ALLOC_MAP_(i)                 \
> +    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4) \
> +    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)   \
> +    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)  \
> +    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
> +
> +A_CMDQ_ALLOC_MAP_(0)cmdq_alloc_map
>
> +/* Omitting 1~126 as not being directly called */
> +A_CMDQ_ALLOC_MAP_(127)
> +
> +/* i = [0, 0] */
> +#define A_VINTFi_CONFIG(i)                       \
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
> +    A_VINTFi_STATUS(0)
> +
> +#define V_VINTF_STATUS_NO_ERROR (0 << 1)
> +#define V_VINTF_STATUS_VCMDQ_EROR (1 << 1)
> +
> +/* i = [0, 0], j = [0, 3] */
> +#define A_VINTFi_LVCMDQ_ERR_MAP_(i, j)                               \
> +    REG32(VINTF##i##_LVCMDQ_ERR_MAP_##j, 0x10c0 + j * 4 + i * 0x100) \
> +    FIELD(VINTF##i##_LVCMDQ_ERR_MAP_##j, LVCMDQ_ERR_MAP, 0, 32)
> +
> +        A_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
> +    /* Omitting [0][1~2] as not being directly called */
> +    A_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
> +
> +/* VCMDQ registers -- starting from 0x10000 with size 64KB * 2 (0x20000) */
> +#define VCMDQ_REG_OFFSET 0x10000
>  #define VCMDQ_REG_PAGE_SIZE 0x10000
>  
> +#define A_VCMDQi_CONS_INDX(i)                       \
> +    REG32(VCMDQ##i##_CONS_INDX, 0x10000 + i * 0x80) \
> +    FIELD(VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
> +    FIELD(VCMDQ##i##_CONS_INDX, ERR, 24, 7)
> +
> +        A_VCMDQi_CONS_INDX(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_CONS_INDX(127)
> +
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_NONE 0
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_OPCODE 1
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ABT 2
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ATC_INV_SYNC 3
> +#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_ACCESS 4
> +
> +#define A_VCMDQi_PROD_INDX(i)                             \
> +    REG32(VCMDQ##i##_PROD_INDX, 0x10000 + 0x4 + i * 0x80) \
> +    FIELD(VCMDQ##i##_PROD_INDX, WR, 0, 20)
> +
> +        A_VCMDQi_PROD_INDX(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_PROD_INDX(127)
> +
> +#define A_VCMDQi_CONFIG(i)                             \
> +    REG32(VCMDQ##i##_CONFIG, 0x10000 + 0x8 + i * 0x80) \
> +    FIELD(VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
> +
> +        A_VCMDQi_CONFIG(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_CONFIG(127)
> +
> +#define A_VCMDQi_STATUS(i)                             \
> +    REG32(VCMDQ##i##_STATUS, 0x10000 + 0xc + i * 0x80) \
> +    FIELD(VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
> +
> +        A_VCMDQi_STATUS(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_STATUS(127)
> +
> +#define A_VCMDQi_GERROR(i)                               \
> +    REG32(VCMDQ##i##_GERROR, 0x10000 + 0x10 + i * 0x80)  \
> +    FIELD(VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
> +    FIELD(VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
> +    FIELD(VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
> +
> +        A_VCMDQi_GERROR(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_GERROR(127)
> +
> +#define A_VCMDQi_GERRORN(i)                               \
> +    REG32(VCMDQ##i##_GERRORN, 0x10000 + 0x14 + i * 0x80)  \
> +    FIELD(VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
> +    FIELD(VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
> +    FIELD(VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
> +
> +        A_VCMDQi_GERRORN(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_GERRORN(127)
> +
> +#define A_VCMDQi_BASE_L(i)                       \
> +    REG32(VCMDQ##i##_BASE_L, 0x20000 + i * 0x80) \
> +    FIELD(VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
> +    FIELD(VCMDQ##i##_BASE_L, ADDR, 5, 27)
> +
> +        A_VCMDQi_BASE_L(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_BASE_L(127)
> +
> +#define A_VCMDQi_BASE_H(i)                             \
> +    REG32(VCMDQ##i##_BASE_H, 0x20000 + 0x4 + i * 0x80) \
> +    FIELD(VCMDQ##i##_BASE_H, ADDR, 0, 16)
> +
> +        A_VCMDQi_BASE_H(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_BASE_H(127)
> +
> +#define A_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
> +    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x20000 + 0x8 + i * 0x80) \
> +    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
> +
> +        A_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_CONS_INDX_BASE_DRAM_L(127)
> +
> +#define A_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
> +    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x20000 + 0xc + i * 0x80) \
> +    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
> +
> +        A_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VCMDQi_CONS_INDX_BASE_DRAM_H(127)
> +
> +/*
> + * VINTF VI_VCMDQ registers -- starting from 0x30000 with size 64KB * 2
> + * (0x20000)
> + */
> +#define A_VI_VCMDQi_CONS_INDX(i)                       \
> +    REG32(VI_VCMDQ##i##_CONS_INDX, 0x30000 + i * 0x80) \
> +    FIELD(VI_VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
> +    FIELD(VI_VCMDQ##i##_CONS_INDX, ERR, 24, 7)
> +
> +        A_VI_VCMDQi_CONS_INDX(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_CONS_INDX(127)
> +
> +#define A_VI_VCMDQi_PROD_INDX(i)                             \
> +    REG32(VI_VCMDQ##i##_PROD_INDX, 0x30000 + 0x4 + i * 0x80) \
> +    FIELD(VI_VCMDQ##i##_PROD_INDX, WR, 0, 20)
> +
> +        A_VI_VCMDQi_PROD_INDX(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_PROD_INDX(127)
> +
> +#define A_VI_VCMDQi_CONFIG(i)                             \
> +    REG32(VI_VCMDQ##i##_CONFIG, 0x30000 + 0x8 + i * 0x80) \
> +    FIELD(VI_VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
> +
> +        A_VI_VCMDQi_CONFIG(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_CONFIG(127)
> +
> +#define A_VI_VCMDQi_STATUS(i)                             \
> +    REG32(VI_VCMDQ##i##_STATUS, 0x30000 + 0xc + i * 0x80) \
> +    FIELD(VI_VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
> +
> +        A_VI_VCMDQi_STATUS(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_STATUS(127)
> +
> +#define A_VI_VCMDQi_GERROR(i)                               \
> +    REG32(VI_VCMDQ##i##_GERROR, 0x30000 + 0x10 + i * 0x80)  \
> +    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
> +    FIELD(VI_VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
> +    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
> +
> +        A_VI_VCMDQi_GERROR(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_GERROR(127)
> +
> +#define A_VI_VCMDQi_GERRORN(i)                               \
> +    REG32(VI_VCMDQ##i##_GERRORN, 0x30000 + 0x14 + i * 0x80)  \
> +    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
> +    FIELD(VI_VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
> +    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
> +
> +        A_VI_VCMDQi_GERRORN(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_GERRORN(127)
> +
> +#define A_VI_VCMDQi_BASE_L(i)                       \
> +    REG32(VI_VCMDQ##i##_BASE_L, 0x40000 + i * 0x80) \
> +    FIELD(VI_VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
> +    FIELD(VI_VCMDQ##i##_BASE_L, ADDR, 5, 27)
> +
> +        A_VI_VCMDQi_BASE_L(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_BASE_L(127)
> +
> +#define A_VI_VCMDQi_BASE_H(i)                             \
> +    REG32(VI_VCMDQ##i##_BASE_H, 0x40000 + 0x4 + i * 0x80) \
> +    FIELD(VI_VCMDQ##i##_BASE_H, ADDR, 0, 16)
> +
> +        A_VI_VCMDQi_BASE_H(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_BASE_H(127)
> +
> +#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
> +    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x40000 + 0x8 + i * 0x80) \
> +    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
> +
> +        A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(127)
> +
> +#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
> +    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x40000 + 0xc + i * 0x80) \
> +    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
> +
> +        A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
> +    /* Omitting [1~126] as not being directly called */
> +    A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(127)
> +
>  #ifdef CONFIG_TEGRA241_CMDQV
>  bool tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                                   uint32_t *out_viommu_id, Error **errp);
Thanks

Eric


