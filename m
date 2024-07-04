Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7FFC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPRIH-0001Xn-4l; Thu, 04 Jul 2024 14:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRIF-0001UY-4p
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:34:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRIB-0004qb-SN
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:34:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42562e4b5d1so6114115e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720118090; x=1720722890; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0QXWX4qz6faB0p5QP7wLk33QyiWxxAQGCZN44SNcwPo=;
 b=R8kmU92KOpmN8s3Yj6FzZsQlNwQSZUSZJsH80ICBUvW4EHCu7XIPdLKR1M0qt2ctVS
 h8oRb1W6uv9ysQh9UHeH6KXgK4jXpbUlDQjldDAOeOSaBL2awpHvaHaIlyhYcEv7W7jW
 ynaS5lQ0kHkBekcgC/1MEPzG3hWRKAE8/74DhlvMPYajps7kOUW/n5mAz8yuWTArlFs2
 UPY9HYRTbOI9AD9ot7mq3yJtqtwblzd2eEFRjqJXkPxo8gykR5GALEprLfQ7PJFMbECc
 K2MrZ+0RU4K9sbAQI4DfmUzRrxIbd22OxXwo9nI66V/V9cj4F6RBduk1rFdX56R+kWSn
 DIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720118090; x=1720722890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QXWX4qz6faB0p5QP7wLk33QyiWxxAQGCZN44SNcwPo=;
 b=du3/fIBcbgANsl4TBNcYEtQv9juGbmDDE7E8gzCeSHXjEpTBeyNiob+RPmhwTVHMf0
 HMdPd8hqrr5/d9JSX0+CE8L0xmx39OT0CuC8P7w76ZVMWWL311n/fumTRxMbKIcHL0Vz
 y0WB1S8CacM/FYHYyVCAP47W9+LEq5xbeOToaS1o3DbQxa4SSJnwKQnDi78vopmBBwu9
 ChKvg0PNHfmQqG2c8f5QB9UXcBN/C3bYblVV+G75Tirr2ToiXV516v0Bzk6o/cvRD283
 bEXM8EPfsItZMXr0itGPw9FYqIcXz+G4zYJ03eBr26Gf9c9YBbz03LpNOjy5VF+EaakY
 ygbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmR4v357Y3epKpS/6XqYOk/n/MriYCByy5Ayiyph0XFR3HLSkl8T00i6LCjaPDBd0WsI7z/OO2Kop4B6EwI7dC2l7ujFU=
X-Gm-Message-State: AOJu0Yy9dS18Sg7CTqt9MQg76+UEYasUnD1bwb+PHyG5hv6OH4/cJBJ6
 h1UqaXZtr/C2LNIkDPvdwPe/tmghv9+xAH0NHwIFxt9MUsoaM5v12BL3sTCPjt0=
X-Google-Smtp-Source: AGHT+IEyZTVVumnDnlONSxCGuoa6eb0or8S3heJSwMcSCBaCdF8PaInd4pTl1o5J8WRM68AE2jF4ug==
X-Received: by 2002:a05:600c:4f52:b0:425:602f:d62c with SMTP id
 5b1f17b1804b1-4264a3e2ed7mr18252725e9.9.1720118090509; 
 Thu, 04 Jul 2024 11:34:50 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a188edasm33430055e9.0.2024.07.04.11.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:34:50 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:35:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 15/19] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
Message-ID: <20240704183503.GL1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-16-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-16-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 01, 2024 at 11:02:37AM +0000, Mostafa Saleh wrote:
> IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
> SMMU instances we consider the input address as the IOVA, but when
> nesting is used, we can't mix stage-1 and stage-2 addresses, so for
> nesting only stage-1 is considered the IOVA and would be notified.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c     | 28 +++++++++++++++++++---------
>  hw/arm/trace-events |  2 +-
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e9007af3cd..36eb6f514a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1064,17 +1064,17 @@ epilogue:
>   * @iova: iova
>   * @tg: translation granule (if communicated through range invalidation)
>   * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
> + * @stage: Which stage(1 or 2) is used
>   */
>  static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>                                 IOMMUNotifier *n,
>                                 int asid, int vmid,
>                                 dma_addr_t iova, uint8_t tg,
> -                               uint64_t num_pages)
> +                               uint64_t num_pages, int stage)
>  {
>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>      IOMMUTLBEvent event;
>      uint8_t granule;
> -    SMMUv3State *s = sdev->smmu;
>  
>      if (!tg) {

Should the stage check be outside of the TG test?  I think CMD_TLBI_S2_IPA
with TG != 0 and nesting enabled would still go through.

Thanks,
Jean

>          SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
> @@ -1093,14 +1093,24 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>              return;
>          }
>  
> -        if (STAGE1_SUPPORTED(s)) {
> +        /*
> +         * stage is passed from TLB invalidation commands which can be either
> +         * stage-1 or stage-2.
> +         * However, IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
> +         * SMMU instances we consider the input address as the IOVA, but when
> +         * nesting is used, we can't mix stage-1 and stage-2 addresses, so for
> +         * nesting only stage-1 is considered the IOVA and would be notified.
> +         */
> +        if (stage == SMMU_STAGE_1) {
>              tt = select_tt(cfg, iova);
>              if (!tt) {
>                  return;
>              }
>              granule = tt->granule_sz;
> -        } else {
> +        } else if ((stage == SMMU_STAGE_2) && (cfg->stage != SMMU_NESTED)) {
>              granule = cfg->s2cfg.granule_sz;
> +        } else {
> +            return;
>          }
>  
>      } else {
> @@ -1119,7 +1129,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>  /* invalidate an asid/vmid/iova range tuple in all mr's */
>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                        dma_addr_t iova, uint8_t tg,
> -                                      uint64_t num_pages)
> +                                      uint64_t num_pages, int stage)
>  {
>      SMMUDevice *sdev;
>  
> @@ -1128,10 +1138,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>          IOMMUNotifier *n;
>  
>          trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
> -                                        iova, tg, num_pages);
> +                                        iova, tg, num_pages, stage);
>  
>          IOMMU_NOTIFIER_FOREACH(n, mr) {
> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages);
> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
>          }
>      }
>  }
> @@ -1162,7 +1172,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>  
>      if (!tg) {
>          trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
>          } else {
> @@ -1185,7 +1195,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>          num_pages = (mask + 1) >> granule;
>          trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
>                                   ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
>          } else {
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 593cc571da..be6c8f720b 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -55,7 +55,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
> -smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
> +smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

