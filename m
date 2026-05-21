Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113BFCD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzj4-0002O7-H8; Thu, 21 May 2026 05:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPzj2-0002NX-NM
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPzj0-0003Dp-E3
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779355793;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVyw4GiBFb6sqM6EXfAhMtZfzwqXeRMINbhGcGFvUfE=;
 b=NXJQO/wOwctTvpBTrBZcmX9MfVEuCzDBsruyVf7NRL9brtd/J3uOHQ2tFM17as9L08FrCD
 y4+auU/lo69PKkWCQ4bf6fpMgMxnhTNUl/Ba5S1SbI5Tr1sEIrVqm+Mcj+pX/9hRMpYj2h
 CufGynr7xIEnQAYtAQz5gb6RAUlr5Rw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-LVuW_8nkOkOyikrmHMwiow-1; Thu, 21 May 2026 05:29:50 -0400
X-MC-Unique: LVuW_8nkOkOyikrmHMwiow-1
X-Mimecast-MFC-AGG-ID: LVuW_8nkOkOyikrmHMwiow_1779355789
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso4519548f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779355789; x=1779960589;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVyw4GiBFb6sqM6EXfAhMtZfzwqXeRMINbhGcGFvUfE=;
 b=gWboY3nac+9RatQV+DQx7Z9A3m6bfI5tDBGwxkg2IzHLG3v2YppgfR/o1RN9WI1dFa
 ReKSeC7iVfv/W1rdCot4tRQEmQOlfWfo1ULvvHHTyaUVUBbRdjjMDltpArAD8T9uDq4C
 TCsLQHjrMn/FIVKj7feAfEB6twt9qPcrQsnvr6yO3my2zJZbL1rGHAOXhsBpq4Dv8JoT
 B9aOcN72g+FWfmNFKLOxSC4X3O4k4hW5A4VgsUSjx4LoOhpWdPeIEBz33ZlbaztVA8Sc
 l3O7K1M7feSaVFteploehkYtLN0sv59a1cWwTZgFoBtbccZfU2IzFeiW/vF00wkWIUSz
 vBOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rRVvHNRYwbnrEVDhACYwwA7QJOXb7ve7wryGerY0PZMNOsYp8EVx39ylx3N+D3H2Be1cwh5oT0Yhg@nongnu.org
X-Gm-Message-State: AOJu0Yw5oOVQOEQZQSOhWYMPk+mdlkFZj0MOHvH+4UKKN+9nmDmqecj2
 V/Q08aEesppHF4Rgcr5QUiBefEUh+ejTga5v0WsROQ4jTOh6UqvuT8M7TGI6jNoiLFBY2kXglrK
 Hri0evAaUUAh/xhQtdbwWzN3OKS+H3ooCtHLjGh3X+8doFuMhZhjX9G3/
X-Gm-Gg: Acq92OFl6xqVjMC4HRubWlVvnhpyZoO+HPfj/CwjY1YviLJEiVdujluK+REi4dU2Sw6
 8pP3UTixKvg7NeeChvdoKwPqmkbHPxiGIllCI1yMiJyKcl/l4E59ie1MkThLJ3AGHSbvxDerC6y
 Umcb5S0hiaHdCTXkQFfagd9bvK0pGAGHFBc1AhEQ5/l3Kw4SjluTHbtXi/UVlNOmUIGd6eP/b6Y
 l6vk3NiketUHeIFNcTFn8OnueAhILSz9MAlElV9kyF46zF6VLHmZchbTSFg+6B3+42WXSCD6+3P
 stiZjdK96eijwc3eGI8IiPOb2MLZcYrOIyU4m9jCz06Ud+z2JvQoW6NP368uaoHiBs4s1w0dM+q
 hX0ScGwJ3KC2YwzD9OxyjtPff+iXF0jeBbGcYUhswQGMBc6pjNlMqxEGdly1rhtJOBaQ0yu1lOJ
 7Ci+dT
X-Received: by 2002:a05:600c:4e02:b0:48f:d620:c27f with SMTP id
 5b1f17b1804b1-49036053ec5mr22990495e9.4.1779355789161; 
 Thu, 21 May 2026 02:29:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4e02:b0:48f:d620:c27f with SMTP id
 5b1f17b1804b1-49036053ec5mr22990155e9.4.1779355788570; 
 Thu, 21 May 2026 02:29:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d9eca8sm51493915e9.12.2026.05.21.02.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 02:29:47 -0700 (PDT)
Message-ID: <166c5efb-0fa3-49f6-a1e7-faec85a6ec44@redhat.com>
Date: Thu, 21 May 2026 11:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-20-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-20-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On 5/19/26 12:36 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add support for allocating IOMMUFD hardware queues when the guest
> programs the VCMDQ BASE registers.
You should add the fact that 

iommufd_backend_alloc_hw_queue() requires the GPA of the VCMDQ. This explains why you need to those operations once the GPA has been populated.

>
> VCMDQ_EN lives in VCMDQ_CONFIG, which is on the VINTF Page0 region
> that a later patch maps directly into the guest — so QEMU won't trap
> its writes. Allocate the hardware queue instead once all of these
> are set: a RAM-backed BASE, CMDQ_ALLOC_MAP.ALLOC, and CMDQV / VINTF
> enabled. Each precondition write retries the allocation, so the
> guest may program them in any order.
> If a hardware queue was previously allocated for the same VCMDQ,
> free it before reallocation.
>
> Writes with invalid addresses are ignored.
>
> All allocated VCMDQs are freed when CMDQV or VINTF is disabled, or
> when the ALLOC bit is cleared.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h |  11 ++++
>  hw/arm/tegra241-cmdqv.c | 138 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 143 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index f0b031b4dc..7a8cb2ebc7 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -45,6 +45,7 @@ typedef struct Tegra241CMDQV {
>      MemoryRegion mmio_cmdqv;
>      qemu_irq irq;
>      IOMMUFDVeventq *veventq;
> +    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
>      void *vintf_page0;
>  
>      /* CMDQ-V Config page register cache */
> @@ -361,6 +362,16 @@ SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
>  SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(0)
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
> index 4d9f094b2a..f4968520f3 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -18,6 +18,95 @@
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
> +static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
> +{
> +    /* uapi/linux/iommufd.h: hw_queue destroy must be in descending @index. */
> +    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
> +        tegra241_cmdqv_free_vcmdq(cmdqv, i);
> +    }
> +}
> +
> +/*
> + * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
> + *
> + * Setup is a no-op (returns true) when any of the following preconditions
> + * isn't met yet:
> + *  - BASE not prgrammed yet.
> + *  - VCMDQ is not mapped to a VINTF (CMDQ_ALLOC_MAP.ALLOC == 0)
> + *  - BASE / size don't resolve to a RAM region
> + *  - CMDQV global enable or VINTF enable is not yet asserted
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
> +    /* BASE not programmed yet. */
> +    if (!cmdqv->vcmdq_base[index]) {
> +        return true;
> +    }
> +
> +    /* VCMDQ not yet mapped to a VINTF. */
> +    if (!(cmdqv->cmdq_alloc_map[index] & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK)) {
> +        return true;
> +    }
> +
> +    /* Ignore any invalid address. This may come as part of reset etc. */
> +    if (!address_space_range_is_ram(&address_space_memory, addr, size)) {
why do you need to test the whole range and not only the start address
> +        return true;
> +    }
> +
> +    if (!tegra241_cmdqv_enabled(cmdqv) || !tegra241_vintf_enabled(cmdqv)) {
> +        return true;
> +    }
> +
> +    tegra241_cmdqv_free_vcmdq(cmdqv, index);
> +
> +    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu->viommu_id,
> +                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
> +                                        index, addr, size, &hw_queue_id,
> +                                        errp)) {
> +        return false;
> +    }
> +    hw_queue = g_new(IOMMUFDHWqueue, 1);
> +    hw_queue->hw_queue_id = hw_queue_id;
> +    hw_queue->viommu = viommu;
> +    cmdqv->vcmdq[index] = hw_queue;
> +
> +    return true;
> +}
> +
> +static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
> +                                           Error **errp)
> +{
> +    for (int i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
> +        if (!tegra241_cmdqv_setup_vcmdq(cmdqv, i, errp)) {
if case of failure,what is the functional consequence. Can you comment
on this in the commit msg or here.


> +            return;
> +        }
> +    }
> +}
> +
>  /*
>   * Returns true if the per-VCMDQ CMDQ_EN_OK bit is set.
>   */
> @@ -172,7 +261,7 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>   */
>  static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
>                                               hwaddr offset0, int index,
> -                                             uint32_t value)
> +                                             uint32_t value, Error **errp)
>  {
>      switch (offset0) {
>      case A_VCMDQ0_BASE_L:
> @@ -181,6 +270,7 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
>          }
>          cmdqv->vcmdq_base[index] =
>              deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
> +        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
>          break;
>      case A_VCMDQ0_BASE_H:
>          if (tegra241_vcmdq_enabled(cmdqv, index)) {
> @@ -188,6 +278,7 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
>          }
>          cmdqv->vcmdq_base[index] =
>              deposit64(cmdqv->vcmdq_base[index], 32, 32, value);
> +        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
>          break;
>      case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
>          cmdqv->vcmdq_cons_indx_base[index] =
> @@ -210,7 +301,7 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
>   */
>  static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
>                                                  hwaddr offset0, int index,
> -                                                uint64_t value)
> +                                                uint64_t value, Error **errp)
>  {
>      switch (offset0) {
>      case A_VCMDQ0_BASE_L:
> @@ -218,6 +309,7 @@ static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
>              return;
>          }
>          cmdqv->vcmdq_base[index] = value;
> +        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
>          break;
>      case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
>          cmdqv->vcmdq_cons_indx_base[index] = value;
> @@ -282,8 +374,14 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
>          if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
>              if (tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp)) {
>                  cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
> +                /*
> +                 * VCMDQs whose BASE was programmed before VINTF was
> +                 * enabled need their hw_queue allocated now.
> +                 */
> +                tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
>              }
>          } else {
> +            tegra241_cmdqv_free_all_vcmdq(cmdqv);
>              tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
>              cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
>          }
> @@ -394,16 +492,37 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
>          tegra241_cmdqv_config_vintf_write(cmdqv, offset, value, &local_err);
>          break;
> @@ -432,7 +551,8 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>      case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
>          index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
>          tegra241_cmdqv_write_vcmdq_page1(cmdqv,
> -                offset - index * CMDQV_VCMDQ_STRIDE, index, value);
> +                offset - index * CMDQV_VCMDQ_STRIDE, index, value,
> +                &local_err);
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
> @@ -451,6 +571,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>  static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>                                          uint64_t value)
>  {
> +    Error *local_err = NULL;
>      int index;
>  
>      switch (offset) {
> @@ -465,13 +586,18 @@ static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>      case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
>          index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
>          tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
> -                offset - index * CMDQV_VCMDQ_STRIDE, index, value);
> +                offset - index * CMDQV_VCMDQ_STRIDE, index, value,
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
Thanks

Eric


