Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F70DCD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXh9c-0000Bc-9D; Thu, 11 Jun 2026 11:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wXh9Z-0000AC-3P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wXh9W-0004lb-MF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781191025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjaWmeSjIfcgb8LqaNS9bAZBwyZTDjeJuJ+JvsRUamY=;
 b=c5zy9InlI7GbS1/kuMJd83ucQaY6mwFa+HbLzhCqkdPlANYup6b265tTIKIvSjyKcw747P
 tES70boNLTig+l3Jzvc8z3m145kj1hTnu44RwqpF+kS7VHgJ754I3b+gp0r0UkZwagY3Km
 Hf/CZxa47Rt+4hjIq0E0Rq8mzSsU+Uk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-o4nKd81OPeC6RxnpfzBeqA-1; Thu, 11 Jun 2026 11:17:04 -0400
X-MC-Unique: o4nKd81OPeC6RxnpfzBeqA-1
X-Mimecast-MFC-AGG-ID: o4nKd81OPeC6RxnpfzBeqA_1781191023
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4601daf4c65so4950641f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781191023; x=1781795823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjaWmeSjIfcgb8LqaNS9bAZBwyZTDjeJuJ+JvsRUamY=;
 b=XOO4KjaCXAAfE60qbbjh9C+Fn7k9H48/oo4XsnrUl8YZAzEwCKkYsPFIVcUSXWz/wh
 k8yXw9D8dBsORKwnbKnzD/rTEZ2qM+WlRdyYLdv2y+wIyQzbe505oT4wdLF9Bz4fU2nv
 b0rdyA9EoBgprgakaxvZJhBuX6Oy48KbY57peMepKUXj0qeJUupgvIpRXhWqHctUrAc+
 GB0fqJVKCfTugs3DuMYTT+ojtEU8Yej2uPElag38WMpaAA1dTXWyfTm0FzuOpRYOYIF5
 sGyJzJ6TzNQQou8o0h1DrDT92oMrAT3/jfxdKsdNpMb+nkd78NYzu/0hB9rAGwaBi2Nm
 /wzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QR5t1Se5sRE6tkRkBMtbwdoaDX0jjdUsgRbUg5nEDZO7y6VO/H9nab1YRyHBYrxqqYYPVW3R1l6sm@nongnu.org
X-Gm-Message-State: AOJu0YynUU2Fo0D7xb0+rHxv5azh3X1Z+muZ/clRjiWBNSPs370Ehbf6
 SHNtaFoOMvqE/JSH/YvFadkcwW31WCC3xpWNj+p8hQZbmDdgDK9uncpxoVIgl9NURpCcHJZ84Me
 imnUrUN1LmcGfS+6rFZ2eDm12av+/GF54yH1tz0Lua7L7z/9yrdMSEurL
X-Gm-Gg: Acq92OED3oRBVAgBm/Z7DsijIJ6JR2myyxvv53rmsuOkHK3Lxqwr+miBpVn3ieyVstT
 LvpjFNel76V7EL610l6SPuC1+267xOMMXht+TH+2AG0rtRyw3sdBmtYqb7HU/2jU+uw1deVkHq2
 +5oBBar21HqVtttaTHKX6498CQJehHOZK72MiZj4zz92M0VnEdDXyFyMBjK0XKWWz1tbBc4C3iG
 fIDKnjvroz5lzxaSTry3lCKLEiRNtQ5lywyf+cutcVHvIn6PFXt0RLL1UWfC31Ab2ylPrpTUTPX
 zkoDGYAg0WQi+R1ZdQ2EuJ3VJJYWTqXU4UkHfRHj1JaMOAvJjiI6zR9x/pEPYUGTsfo1viowgkJ
 2wV7W0gDjAPvolfDvNTpbxo8yNFu5ZESVCTgXzNyP76qL69TigYRGDSwXS/WWhwwQcQ==
X-Received: by 2002:a05:600c:400f:b0:490:b8c0:d471 with SMTP id
 5b1f17b1804b1-490e56177e6mr30492295e9.23.1781191022507; 
 Thu, 11 Jun 2026 08:17:02 -0700 (PDT)
X-Received: by 2002:a05:600c:400f:b0:490:b8c0:d471 with SMTP id
 5b1f17b1804b1-490e56177e6mr30491675e9.23.1781191021981; 
 Thu, 11 Jun 2026 08:17:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e5314dedsm66737285e9.9.2026.06.11.08.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 08:17:01 -0700 (PDT)
Message-ID: <ee8808d4-0e7c-4ace-a9c8-4ac1f5a58ad3@redhat.com>
Date: Thu, 11 Jun 2026 17:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
 <20260609112552.378999-19-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260609112552.378999-19-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/9/26 1:25 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add support for allocating IOMMUFD hardware queues when the guest
> programs the VCMDQ BASE registers.
>
> VCMDQ_EN lives in VCMDQ_CONFIG, which is on the VINTF Page0 region
> that a later patch installs into guest MMIO — so QEMU won't trap its
> writes. Allocate the hardware queue instead once all of these are
> set: BASE programmed, CMDQ_ALLOC_MAP.ALLOC, and CMDQV / VINTF
> enabled. Each precondition write retries the allocation, so the
> guest may program them in any order.
>
> iommufd_backend_alloc_hw_queue() needs the guest physical address of
> the VCMDQ ring buffer, so allocation is deferred until the guest has
> populated BASE.
>
> If a hardware queue was previously allocated for the same VCMDQ,
> free it before reallocation. All allocated VCMDQs are freed when
> CMDQV or VINTF is disabled, when the ALLOC bit is cleared, or on reset.
>
> On allocation failure, set CMDQ_INIT_ERR and clear CMDQ_EN_OK in the
> cache so trapped guest reads see the failure rather than a queue
> that looks live. Clear them on a later successful allocation. A guest
> CMDQ_EN write then sets CMDQ_EN_OK only if CMDQ_INIT_ERR is clear.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  hw/arm/tegra241-cmdqv.h |  11 +++
>  hw/arm/tegra241-cmdqv.c | 171 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 171 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index c4d327a9a5..84499b840d 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -47,6 +47,7 @@ typedef struct Tegra241CMDQV {
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
>      IOMMUFDVeventq *veventq;
> +    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
>      void *vintf_page0;
>  
>      /* CMDQ-V Config page register cache */
> @@ -364,6 +365,16 @@ SMMU_CMDQV_VI_VCMDQi_BASE_H_(1)
>  SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
>  SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
>  
> +static inline bool tegra241_cmdqv_enabled(Tegra241CMDQV *cmdqv)
> +{
> +    return cmdqv->status & R_STATUS_CMDQV_ENABLED_MASK;
> +}
> +
> +static inline bool tegra241_vintf_enabled(Tegra241CMDQV *cmdqv)
> +{
> +    return cmdqv->vintf_status & R_VINTF0_STATUS_ENABLE_OK_MASK;
> +}
> +
>  const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
>  
>  #endif /* HW_ARM_TEGRA241_CMDQV_H */
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 1f3d883cfe..8cb39e87c4 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -16,6 +16,96 @@
>  #include "tegra241-cmdqv.h"
>  #include "trace.h"
>  
> +static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
> +{
> +    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
> +    IOMMUFDHWqueue *vcmdq = cmdqv->vcmdq[index];
> +
> +    if (!vcmdq) {
> +        return;
> +    }
> +    iommufd_backend_free_id(viommu->iommufd, vcmdq->hw_queue_id);
> +    g_free(vcmdq);
> +    cmdqv->vcmdq[index] = NULL;
> +}
> +
> +/*
> + * A VCMDQ's HW queue can be allocated once the guest has programmed:
> + *  - VCMDQ_BASE (ring buffer GPA and size). This only checks that BASE is
> + *    non-zero, not that both the _L and _H halves have been written; a
> + *    half-written BASE may pass here, but the write of the second half
> + *    re-runs setup and reallocates with the complete address.
> + *  - the VINTF mapping (CMDQ_ALLOC_MAP.ALLOC).
> + *  - both the CMDQV global enable and the VINTF enable.
> + */
> +static bool tegra241_cmdqv_vcmdq_ready_to_alloc(Tegra241CMDQV *cmdqv, int index)
> +{
> +    return cmdqv->vcmdq_base[index] &&
> +           (cmdqv->cmdq_alloc_map[index] & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK) &&
> +           tegra241_cmdqv_enabled(cmdqv) && tegra241_vintf_enabled(cmdqv);
> +}
> +
> +/*
> + * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
> + * No-op (returns true) until the VCMDQ is ready to be allocated.
> + */
> +static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> +                                       Error **errp)
> +{
> +    SMMUv3AccelState *accel = cmdqv->s_accel;
> +    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
> +                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
> +    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
> +    uint64_t log2 = cmdqv->vcmdq_base[index] & R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
> +    uint64_t size = 1ULL << (log2 + 4);
> +    IOMMUFDViommu *viommu = accel->viommu;
> +    IOMMUFDHWqueue *hw_queue;
> +    uint32_t hw_queue_id;
> +
> +    if (!tegra241_cmdqv_vcmdq_ready_to_alloc(cmdqv, index)) {
> +        return true;
> +    }
> +
> +    tegra241_cmdqv_free_vcmdq(cmdqv, index);
> +
> +    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu->viommu_id,
> +                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
> +                                        index, addr, size, &hw_queue_id,
> +                                        errp)) {
> +        /* Record the failure in the cache. */
> +        cmdqv->vcmdq_gerror[index] |= R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
> +        cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> +        return false;
> +    }
> +    hw_queue = g_new(IOMMUFDHWqueue, 1);
> +    hw_queue->hw_queue_id = hw_queue_id;
> +    hw_queue->viommu = viommu;
> +    cmdqv->vcmdq[index] = hw_queue;
> +
> +    cmdqv->vcmdq_gerror[index] &= ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
> +    cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> +
> +    return true;
> +}
> +
> +static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
> +{
> +    /* uapi/linux/iommufd.h: hw_queue destroy must be in descending @index. */
> +    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
> +        tegra241_cmdqv_free_vcmdq(cmdqv, i);
> +    }
> +}
> +
> +static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
> +                                           Error **errp)
> +{
> +    for (int i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
> +        if (!tegra241_cmdqv_setup_vcmdq(cmdqv, i, errp)) {
> +            return;
> +        }
> +    }
> +}
> +
>  /*
>   * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
>   *
> @@ -143,7 +233,12 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>          break;
>      case A_VCMDQ0_CONFIG:
>          if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
> -            cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> +            /* Report init error if any. */
> +            if (!(cmdqv->vcmdq_gerror[index] &
> +                  R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK)) {
> +                cmdqv->vcmdq_status[index] |=
> +                    R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
> +            }
>          } else {
>              cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>          }
> @@ -167,16 +262,19 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>   */
>  static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
>                                               hwaddr offset0, int index,
> -                                             uint32_t value, bool direct)
> +                                             uint32_t value, bool direct,
> +                                             Error **errp)
>  {
>      switch (offset0) {
>      case A_VCMDQ0_BASE_L:
>          cmdqv->vcmdq_base[index] =
>              deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
> +        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
>          break;
>      case A_VCMDQ0_BASE_H:
>          cmdqv->vcmdq_base[index] =
>              deposit64(cmdqv->vcmdq_base[index], 32, 32, value);
> +        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
>          break;
>      case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
>          cmdqv->vcmdq_cons_indx_base[index] =
> @@ -200,11 +298,13 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
>   */
>  static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
>                                                  hwaddr offset0, int index,
> -                                                uint64_t value, bool direct)
> +                                                uint64_t value, bool direct,
> +                                                Error **errp)
>  {
>      switch (offset0) {
>      case A_VCMDQ0_BASE_L:
>          cmdqv->vcmdq_base[index] = value;
> +        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
>          break;
>      case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
>          cmdqv->vcmdq_cons_indx_base[index] = value;
> @@ -219,7 +319,8 @@ static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
>  }
>  
>  static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
> -                                              hwaddr offset, uint64_t value)
> +                                              hwaddr offset, uint64_t value,
> +                                              Error **errp)
>  {
>      int i;
>  
> @@ -235,7 +336,13 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
>          cmdqv->vintf_config = value;
>          if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
>              cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
> +            /*
> +             * VCMDQs whose BASE was programmed before VINTF was
> +             * enabled need their hw_queue allocated now.
> +             */
> +            tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
>          } else {
> +            tegra241_cmdqv_free_all_vcmdq(cmdqv);
>              cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
>          }
>          break;
> @@ -341,6 +448,7 @@ out:
>  static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>                                         uint32_t value)
>  {
> +    Error *local_err = NULL;
>      int index;
>  
>      switch (offset) {
> @@ -348,18 +456,39 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>          cmdqv->config = value;
>          if (value & R_CONFIG_CMDQV_EN_MASK) {
>              cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
> +            /*
> +             * VCMDQs whose BASE was programmed before CMDQV was enabled
> +             * need their hw_queue allocated now.
> +             */
> +            tegra241_cmdqv_setup_all_vcmdq(cmdqv, &local_err);
>          } else {
> +            tegra241_cmdqv_free_all_vcmdq(cmdqv);
>              cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
>          }
>          break;
>      case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
>          cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4] = value;
>          break;
> -    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
> -        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
> +    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1: {
> +        int idx = (offset - A_CMDQ_ALLOC_MAP_0) / 4;
> +        bool was_alloc = cmdqv->cmdq_alloc_map[idx] &
> +                         R_CMDQ_ALLOC_MAP_0_ALLOC_MASK;
> +        bool now_alloc = value & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK;
> +
> +        cmdqv->cmdq_alloc_map[idx] = value;
> +        /*
> +         * If the VCMDQ was already programmed (BASE) before mapping, fire
> +         * setup on the ALLOC 0->1 transition; tear down on 1->0.
> +         */
> +        if (!was_alloc && now_alloc) {
> +            tegra241_cmdqv_setup_vcmdq(cmdqv, idx, &local_err);
> +        } else if (was_alloc && !now_alloc) {
> +            tegra241_cmdqv_free_vcmdq(cmdqv, idx);
> +        }
>          break;
> +    }
>      case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
> -        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
> +        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value, &local_err);
>          break;
>      case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
>          /*
> @@ -387,17 +516,23 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>          offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
>          index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
>          tegra241_cmdqv_write_vcmdq_page1(cmdqv,
> -                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
> +                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false,
> +                &local_err);
>          break;
>      case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
>          index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
>          tegra241_cmdqv_write_vcmdq_page1(cmdqv,
> -                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
> +                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true,
> +                &local_err);
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
>                        __func__, offset);
>      }
> +
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
>  }
>  
>  /*
> @@ -407,6 +542,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>  static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>                                          uint64_t value)
>  {
> +    Error *local_err = NULL;
>      int index;
>  
>      switch (offset) {
> @@ -419,18 +555,24 @@ static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>          offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
>          index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
>          tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
> -                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
> +                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false,
> +                &local_err);
>          break;
>      case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
>          index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
>          tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
> -                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
> +                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true,
> +                &local_err);
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
>                        __func__, offset);
>      }
> +
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
>  }
>  
>  static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
> @@ -535,6 +677,13 @@ free_viommu:
>  
>  static void tegra241_cmdqv_reset(SMMUv3State *s)
>  {
> +    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
> +
> +    if (!cmdqv) {
> +        return;
> +    }
> +
> +    tegra241_cmdqv_free_all_vcmdq(cmdqv);
>  }
>  
>  static const MemoryRegionOps mmio_cmdqv_ops = {


