Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10B8CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4Va-0002FH-Ic; Thu, 04 Jun 2026 05:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV4VX-0002Em-Pz
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV4VU-0005EN-5H
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780565814;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFkSx3wyd3D/mCnuo2iL7oN/T+3NYa5PUu/HJnC8tYo=;
 b=TCNR806h1fdy8KAXb350Z2TtyyXQ9UOrQsKw7UletEi4qbb6oJ9MOh8fQs8zNuzHTpGoqK
 FmKvd4BgYuAIsXtcN/YTq/hXnjUwP6Ou4Gwude+b8n+0oTKxVKvbSD1KDy6CIXWnqWtxdV
 6Xf65R3rxU/KV8uMwq9KPsp+VKMTjsY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-fpMFjF-HN4mBnYF0w6WXRQ-1; Thu, 04 Jun 2026 05:36:53 -0400
X-MC-Unique: fpMFjF-HN4mBnYF0w6WXRQ-1
X-Mimecast-MFC-AGG-ID: fpMFjF-HN4mBnYF0w6WXRQ_1780565812
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490bfd70b0fso2120105e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565812; x=1781170612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFkSx3wyd3D/mCnuo2iL7oN/T+3NYa5PUu/HJnC8tYo=;
 b=e9u8LE0t7fEi1PgKPzqoy1GvnHv23fNMYHz5IdTxLPKxs0bLI6aQy3PGUQrE4/MLO3
 3TmaBhlLQhq4Z6krxgiRQC/KFV4taGK/Ulz/JFP4i+EJeHW6REDOnB6hHHJnBjhMFWqS
 SAX+hP5ngPFVHVxEswZZ2jeJCdOr5G5Q4/ek4RkrKxQSUTd7s74rBpvZTj714JFX29YX
 Dht9ohebCiCx9Lg1XUpTqQ0Jkdlhb0afe3YxsGtUKsbgSwQ9c1ESZQy9voGMCzGVNBsN
 BNSoijeQ+lsA1f6L1kaYaCyNU8sOIz/vQDjsiliSx/n25wBZTTCIpAuZcpQWrJzDb2AG
 OBdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oF/DmKxSb1f13iUo6DESeR2d1SF/nB/krcS9vVa4k4HZs9ernZNfFIXzaSCxehhQU/smtQQN/IjVn@nongnu.org
X-Gm-Message-State: AOJu0YzbzntF93qUj16eeL2R18hszK2putVG2EzRlacjHVcA1LvtK5wT
 YVCCHV+R7TPlSJVe/Rj6rUIlaPu8898fDkFjjcSk+Zn2mXPa8JZ4bW1fOtR1hLQ2NPZFsYWirKh
 GwXKMb+2gVftdmDXaN7TbxpQ6bYCcRARocVLPFPWIR8TAMgCgkNGfj9iF
X-Gm-Gg: Acq92OGtHcbMJaFrsb8pvF2pDax4SqrclBSGl26D6vfATG0JMjWCotmQJ8AR9KKPAoA
 /7I+KEZkXoMrT2rdm4VvO4aP09XM1b3+WY/MX5hby6yx1ZcTdP4Af9g5e1VZ11YrUlUEqxekHIO
 rAoVFdKJ1FFA6QOVH7H+xusXKMEFaaHYBjbJ0bwCKvc/vRDfiRcv5dWtKUVcg/tF24xsMoBtEkt
 4GhEj/88LvhuppoaA8DY/h2MI/3os6oFeXCLYfhtPfBur63kxa0Tv5UMbrcZmIX1xlQemEYdWoN
 qDzfqly6Cj5EpiNhfvJgYRKlU+K344KUFKeNpPapxZvVQfKYI1PPS+zmcEESe4Rs2LungR7VbHW
 DfpVEULsdiH8sjT0dzPZ/NgV0myLZZkQ4UdRMHWdGKUrSmnf6HuyxGI/yFmRf82wbvuXYXakth6
 GLP1x0
X-Received: by 2002:a05:600c:c111:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-490b8c0d5b2mr88355255e9.19.1780565811777; 
 Thu, 04 Jun 2026 02:36:51 -0700 (PDT)
X-Received: by 2002:a05:600c:c111:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-490b8c0d5b2mr88354885e9.19.1780565811332; 
 Thu, 04 Jun 2026 02:36:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b5b82sm60913515e9.1.2026.06.04.02.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 02:36:50 -0700 (PDT)
Message-ID: <8e656872-4991-4e44-a64a-c055efbb311a@redhat.com>
Date: Thu, 4 Jun 2026 11:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-19-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260601114221.457995-19-skolothumtho@nvidia.com>
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

On 6/1/26 1:42 PM, Shameer Kolothum wrote:
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
> CMDQV or VINTF is disabled, or when the ALLOC bit is cleared.
>
> On allocation failure, set CMDQ_INIT_ERR and clear CMDQ_EN_OK in the
> cache so trapped guest reads see the failure rather than a queue
> that looks live. Clear them on a later successful allocation.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h |  11 +++
>  hw/arm/tegra241-cmdqv.c | 154 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 156 insertions(+), 9 deletions(-)
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
> index a52e153501..54d95f4e4e 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -18,6 +18,96 @@
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
basically the same comment as previous patch. I would add in the exit
phase reset at this stage too.
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
> +    if (!tegra241_cmdqv_enabled(cmdqv) || !tegra241_vintf_enabled(cmdqv)) {
> +        return true;
> +    }
nit: I think I would introduce an helper
vcmdq_hw_queue_ready_to_be_allocated(cmdqv, index)
where you could put a proper doc comment.

Not that once flag the base is set it returns true. ie. you do not check
that both L & H are set.

But anyway the queue will be reallocated
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
> +static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
> +                                           Error **errp)
> +{
> +    for (int i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
> +        if (!tegra241_cmdqv_setup_vcmdq(cmdqv, i, errp)) {
> +            return;
> +        }
> +    }
nit: you you could after the tegra241_cmdqv_free_all_vcmdq helper
> +}
> +
>  /*
>   * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
>   *
> @@ -145,7 +235,12 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
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
does it really belong to this patch?
>          } else {
>              cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>          }
> @@ -169,16 +264,19 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
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
> @@ -202,11 +300,13 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
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
> @@ -272,8 +372,14 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
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
> @@ -388,16 +494,37 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
> @@ -427,12 +554,14 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
> @@ -451,6 +580,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>  static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
>                                          uint64_t value)
>  {
> +    Error *local_err = NULL;
>      int index;
>  
>      switch (offset) {
> @@ -463,18 +593,24 @@ static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
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
Otherwise looks good to me

Thanks

Eric


