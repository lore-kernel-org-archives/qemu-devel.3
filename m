Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74340D13C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOM9-0003Ax-NE; Mon, 26 Jan 2026 10:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkOM3-0003AT-03
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:18:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkOM0-0005Ss-II
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769440690;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohPTZclnAQMnghrHl5194tLPfpcaa/QRQ1ppXOCoZYA=;
 b=KbxwLSV7YjSsZbNWa8bTD4v4Xw1D5gw/JEShPTiZKmE4Km5RTW6emjEjga+q9LerQf+1TU
 eLdcQFVxAKNij4yLelMM2vvLrqD0L9A1ihqRHme+Uty1IUUCrCjIxluBf+VLe5TUOYzrd5
 XflM8Fm6AFwoL3c22Z/uVTSuFB9NFg8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-aI8uFLxwNGOfUMEnZxS_EA-1; Mon, 26 Jan 2026 10:18:09 -0500
X-MC-Unique: aI8uFLxwNGOfUMEnZxS_EA-1
X-Mimecast-MFC-AGG-ID: aI8uFLxwNGOfUMEnZxS_EA_1769440688
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcfe4494so4319935f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440688; x=1770045488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohPTZclnAQMnghrHl5194tLPfpcaa/QRQ1ppXOCoZYA=;
 b=Fr6KMWJzg9OLgeni8iPfMdCTK7u4eI5/Pp6/IBs+18H16Qbk3gjB2tg5HX4xl1cvX0
 w+HZqGg3QfEPZq5aQiPpizDYalMaq4fsXx5UqFR/CaF8r5BaWm56t+1a0dnCxEqecuC3
 VDY4NGnBv5ji6r7Nrhwhh3bajQFV8645tHqfEVYbsUp6vLXXr082Bx11lgOnyzWZDFrM
 xg5gndYkhlPbqDllItxpcgpZJ6fQfgbcfylW8e7O/XkIrMG6kOSphmbNGLIsoNYy1aCe
 OZ1vMTtan/mT/Q/kBvl8ixHj6KsVRi7Tr7xP6GEBc5kcCOOD3HEcutq6u5GtSRJ9Vzdi
 1DDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKQkUTl4zkzQUIoVmFNTzv694dGNG0pKZ5LjstygwBonCgoPWql97UZ44uS5GETbvTLImT9k32+jGG@nongnu.org
X-Gm-Message-State: AOJu0YylDa219V4ljG4rhI+x65fRa90iT/o7CsKZsKOo6IMke+zwnKN1
 qSckxv68NGKdXBF8AZlEPhxE0eHJu9U0IQKDvqbd5Ujmh6ZvRV6uL/oQ0JaqLcRG6/VRmaiMpVC
 5UCrPQQcww/zv/fkClokiQshcvKp3Etub4EIimDNlIdyOpPRfmYq6L+PkARWlX34a
X-Gm-Gg: AZuq6aK8X+xcijiVaza9wc71Teckfy7iJgO1n1t6UvcuwCrcWPA8J6kOfIZMmE/k3q7
 MihPnMgTxGKfWn8c/mfo/B266Actaz9gMCLSYet2xVKRIMIujPK6QFEEL1344iwCcYwTiPI+UZF
 xjWu8lDbjRo/LiWhH2iKurfibTCMXJIvHKPUw5NUwST7L/jvjnq4BwCStv3D4JACfTV2kHNXHbY
 sNEJHy2h6hkTTUxSOGS/zKaP2ApJ5FwTXnQmwNbJFlKr5P5LTj6vWUMm7tIo7sS6a2/i684un1f
 wAlSjANR0zejV2OUKBNjQuTIvrwScLPdABs/kqTdOhLQpRxT9XORWhBMQMKvTDKFJBArlsKOy2N
 +/ELBDMz1ng28KGFmfwbyrLcOP1dlu6nKc1x2ySc7eiiquGaM+kW/W7mIQQ==
X-Received: by 2002:a05:6000:2304:b0:435:a136:b891 with SMTP id
 ffacd0b85a97d-435ca125895mr7680606f8f.13.1769440687953; 
 Mon, 26 Jan 2026 07:18:07 -0800 (PST)
X-Received: by 2002:a05:6000:2304:b0:435:a136:b891 with SMTP id
 ffacd0b85a97d-435ca125895mr7680571f8f.13.1769440687476; 
 Mon, 26 Jan 2026 07:18:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24bedsm29779717f8f.17.2026.01.26.07.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 07:18:06 -0800 (PST)
Message-ID: <74fa098b-0a1e-4b7c-a0c7-ee2fdf943295@redhat.com>
Date: Mon, 26 Jan 2026 16:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/16] hw/arm/tegra241-cmdqv:: Add write emulation for
 registers
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-10-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-10-skolothumtho@nvidia.com>
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

On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Introduces write handling for VINTF and VCMDQ MMIO regions, including
> status/config updates, queue index tracking, and BASE_L/BASE_H
> processing. Writes to VCMDQ BASE_L/BASE_H trigger allocation or
> teardown of an IOMMUFD HW queue.

I would strongly recommend to split read/write emulation patches into
several patches. The code diff is huge and I am pretty sure you can
split that into several functional changes. Then comes the question
about to review that with a proper spec.

Eric
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 213 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 213 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 185ef957bc..5e9a980d27 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -210,11 +210,158 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
>      }
>  }
>  
> +/* Note that offset aligns down to 0x1000 */
> +static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
> +                                       uint64_t value, unsigned size)
> +{
> +    switch (offset) {
> +    case A_VINTF0_CONFIG:
> +        /* Strip off HYP_OWN setting from guest kernel */
> +        value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
> +
> +        cmdqv->vintf_config = value;
> +        if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
> +            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
> +        } else {
> +            cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return;
> +    }
> +}
> +
> +static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> +                                       Error **errp)
> +{
> +    SMMUv3State *smmu = cmdqv->smmu;
> +    SMMUv3AccelState *s_accel = smmu->s_accel;
> +    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
> +                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
> +    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
> +    uint64_t log2 = cmdqv->vcmdq_base[index] & R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
> +    uint64_t size = 1ULL << (log2 + 4);
> +    IOMMUFDHWqueue *vcmdq = cmdqv->vcmdq[index];
> +    IOMMUFDViommu *viommu;
> +    IOMMUFDHWqueue *hw_queue;
> +    uint32_t hw_queue_id;
> +
> +    /* Ignore any invalid address. This may come as part of reset etc */
> +    if (!cpu_physical_memory_is_ram(addr)) {
> +        return true;
> +    }
> +
> +    if (vcmdq) {
> +        iommufd_backend_free_id(s_accel->viommu.iommufd, vcmdq->hw_queue_id);
> +        cmdqv->vcmdq[index] = NULL;
> +        g_free(vcmdq);
> +    }
> +
> +    viommu = &s_accel->viommu;
> +    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu->viommu_id,
> +                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
> +                                        index, addr, size, &hw_queue_id,
> +                                        errp)) {
> +        return false;
> +    }
> +    hw_queue = g_new(IOMMUFDHWqueue, 1);
> +    hw_queue->hw_queue_id = hw_queue_id;
> +    hw_queue->viommu = viommu;
> +
> +    cmdqv->vcmdq[index] = hw_queue;
> +    return true;
> +}
> +
> +/* Note that offset aligns down to 0x10000 */
> +static void
> +tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset, int index,
> +                           uint64_t value, unsigned size, Error **errp)
> +{
> +    uint32_t *ptr = NULL;
> +    uint64_t off;
> +
> +    if (cmdqv->vcmdq_page0) {
> +        off = (0x80 * index) + (offset - 0x10000);
> +        ptr = (uint32_t *)(cmdqv->vcmdq_page0 + off);
> +    }
> +
> +    switch (offset) {
> +    case A_VCMDQ0_CONS_INDX:
> +        if (ptr) {
> +            *ptr = value;
> +        }
> +        cmdqv->vcmdq_cons_indx[index] = value;
> +        return;
> +    case A_VCMDQ0_PROD_INDX:
> +        if (ptr) {
> +            *ptr = value;
> +        }
> +        cmdqv->vcmdq_prod_indx[index] = (uint32_t)value;
> +        return;
> +    case A_VCMDQ0_CONFIG:
> +        if (ptr) {
> +            *ptr = (uint32_t)value;
> +        } else {
> +            if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
> +                cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> +            } else {
> +                cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> +            }
> +        }
> +        cmdqv->vcmdq_config[index] = (uint32_t)value;
> +        return;
> +    case A_VCMDQ0_GERRORN:
> +        if (ptr) {
> +            *ptr = (uint32_t)value;
> +        }
> +        cmdqv->vcmdq_gerrorn[index] = (uint32_t)value;
> +        return;
> +    case A_VCMDQ0_BASE_L:
> +        if (size == 8) {
> +            cmdqv->vcmdq_base[index] = value;
> +        } else if (size == 4) {
> +            cmdqv->vcmdq_base[index] =
> +                (cmdqv->vcmdq_base[index] & 0xffffffff00000000ULL) |
> +                (value & 0xffffffffULL);
> +        }
> +        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
> +        return;
> +    case A_VCMDQ0_BASE_H:
> +        cmdqv->vcmdq_base[index] =
> +            (cmdqv->vcmdq_base[index] & 0xffffffffULL) |
> +            ((uint64_t)value << 32);
> +        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
> +        return;
> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
> +        if (size == 8) {
> +            cmdqv->vcmdq_cons_indx_base[index] = value;
> +        } else if (size == 4) {
> +            cmdqv->vcmdq_cons_indx_base[index] =
> +                (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffff00000000ULL) |
> +                (value & 0xffffffffULL);
> +        }
> +        return;
> +    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
> +        cmdqv->vcmdq_cons_indx_base[index] =
> +            (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffffULL) |
> +            ((uint64_t)value << 32);
> +        return;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +        return;
> +    }
> +}
> +
>  static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
>                                   unsigned size)
>  {
>      Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
>      Error *local_err = NULL;
> +    int index;
>  
>      if (!cmdqv->vcmdq_page0) {
>          tegra241_cmdqv_init_vcmdq_page0(cmdqv, &local_err);
> @@ -223,6 +370,72 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
>              local_err = NULL;
>          }
>      }
> +
> +    if (offset > TEGRA241_CMDQV_IO_LEN) {
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
> +    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_127:
> +        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
> +        break;
> +    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> +        tegra241_cmdqv_write_vintf(cmdqv, offset, value, size);
> +        break;
> +    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ127_GERRORN:
> +        offset -= 0x20000;
> +        QEMU_FALLTHROUGH;
> +    case A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN:
> +        /*
> +         * Align offset down to 0x10000 while extracting the index:
> +         *   VCMDQ0_CONS_INDX  (0x10000) => 0x10000, 0
> +         *   VCMDQ1_CONS_INDX  (0x10080) => 0x10000, 1
> +         *   VCMDQ2_CONS_INDX  (0x10100) => 0x10000, 2
> +         *   ...
> +         *   VCMDQ127_CONS_INDX (0x13f80) => 0x10000, 127
> +         */
> +        index = (offset - 0x10000) / 0x80;
> +        tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
> +                                   size, &local_err);
> +        break;
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
> +        tegra241_cmdqv_write_vcmdq(cmdqv, offset - 0x80 * index, index, value,
> +                                   size, &local_err);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
> +                      __func__, offset);
> +    }
> +
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
>  }
>  
>  static const MemoryRegionOps mmio_cmdqv_ops = {


