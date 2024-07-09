Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E0FC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR59L-00043E-LV; Tue, 09 Jul 2024 03:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR59H-0003sQ-VQ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:20:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR59D-0002Kd-VT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:20:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266edcc54cso54725e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720509621; x=1721114421; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lQgiBgX82Mz62yDzj8fxlZaDlaODGH4QZ7AVoQBDUrw=;
 b=awz4nh4NwIphtbGjrNDZD+GvLRm5eEw5urgBHpXvXW6w2/qYjyW7ndkS+SBWR1+yWF
 NubbV8UJfQYHyOq9aSYqwABXbdCQfwrIrBYsBkCq6T02BRdR+5GbaRT4Av5LSw4U2xbp
 8wvQt0BSXMGfv+bvwcn4+RrdQ0sZ1BOjyCu9+gr1S4CwD/1UaTet/MLd+muqoxp4YzDv
 SgLc7FYs7gs3bfUg+5mmaFxUilNx/5DJ3ItblAbqpAbr87AgAUDTLbx+94rZ7DQcUhTS
 1c/QMcB1jvkZwdo/r5jZQ52xHrsKULCUJLMsPVpB7WF+uEz5HfDfT59AztS62/fBWP89
 LHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509621; x=1721114421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQgiBgX82Mz62yDzj8fxlZaDlaODGH4QZ7AVoQBDUrw=;
 b=G2LFk2sn8mEfHEEHtt/rA76io9xGvJkwMQLQGLSsL9OQRsA71sa9hZkE8Ec+wceEpe
 5oZ+WZu016XI8sLqWgSt989s+JjFFYYION8uMmzjc7y5Tto1E90m+sdRZC+2gBzCeIMB
 GpJIm5N8zECeQWuzXoO+onFHrgsStpFPOSahh7FhR0yPXiGRmKwlIL92n3uRR5gznPY5
 B/C041ySX9P9wC+/opFumJmgv026ENPodFn6cjaO3dFcxzJizDJ7Uze0nwzaZOBDN6MN
 4SzGoJ46mOtmKj+iDL4KJIRa9hMK5imKcvltYGEN3ROA5mAt2vGLVSkMcHl0re4LHd8i
 r3Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvjW4wB38SJxlii0VMyeEvNO1L9IWPSgrI6mtEYmLz6/AL4oxbuvk2Dfw9GjJMTByAUxDzQZgt1aViSho0M1pfEknFSJ4=
X-Gm-Message-State: AOJu0Yx89Uf5HvBQ/fE8xCYcxsUVX40hBCTzWV4iKGxkD+1Q5nCtcsxT
 IEDUllUDWw54IdaA3wOIrY4o4oW1tJDj2hX5Q9X83kQEgdXRHwyCaafpGosJV/rMxXxJ/yLaHxO
 QkA==
X-Google-Smtp-Source: AGHT+IGWOp6Az8LkeXXK0q3XxDyA/GZltzdSTffj12UYrjUwn9bCtjU4H9cKRv+lm6ht2YzN01dYhQ==
X-Received: by 2002:a05:600c:3b16:b0:426:5ef2:cd97 with SMTP id
 5b1f17b1804b1-42671a88f7dmr1441715e9.2.1720509621423; 
 Tue, 09 Jul 2024 00:20:21 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde89198sm1662607f8f.60.2024.07.09.00.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:20:20 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:20:17 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 15/19] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
Message-ID: <ZozksXro6STwOPA1@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-16-smostafa@google.com>
 <20240704183503.GL1693268@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704183503.GL1693268@myrica>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=smostafa@google.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Jean,

On Thu, Jul 04, 2024 at 07:35:03PM +0100, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:37AM +0000, Mostafa Saleh wrote:
> > IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
> > SMMU instances we consider the input address as the IOVA, but when
> > nesting is used, we can't mix stage-1 and stage-2 addresses, so for
> > nesting only stage-1 is considered the IOVA and would be notified.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3.c     | 28 +++++++++++++++++++---------
> >  hw/arm/trace-events |  2 +-
> >  2 files changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index e9007af3cd..36eb6f514a 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -1064,17 +1064,17 @@ epilogue:
> >   * @iova: iova
> >   * @tg: translation granule (if communicated through range invalidation)
> >   * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
> > + * @stage: Which stage(1 or 2) is used
> >   */
> >  static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >                                 IOMMUNotifier *n,
> >                                 int asid, int vmid,
> >                                 dma_addr_t iova, uint8_t tg,
> > -                               uint64_t num_pages)
> > +                               uint64_t num_pages, int stage)
> >  {
> >      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
> >      IOMMUTLBEvent event;
> >      uint8_t granule;
> > -    SMMUv3State *s = sdev->smmu;
> >  
> >      if (!tg) {
> 
> Should the stage check be outside of the TG test?  I think CMD_TLBI_S2_IPA
> with TG != 0 and nesting enabled would still go through.

Ah yes, I will fix it.

Thanks,
Mostafa

> 
> Thanks,
> Jean
> 
> >          SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
> > @@ -1093,14 +1093,24 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >              return;
> >          }
> >  
> > -        if (STAGE1_SUPPORTED(s)) {
> > +        /*
> > +         * stage is passed from TLB invalidation commands which can be either
> > +         * stage-1 or stage-2.
> > +         * However, IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
> > +         * SMMU instances we consider the input address as the IOVA, but when
> > +         * nesting is used, we can't mix stage-1 and stage-2 addresses, so for
> > +         * nesting only stage-1 is considered the IOVA and would be notified.
> > +         */
> > +        if (stage == SMMU_STAGE_1) {
> >              tt = select_tt(cfg, iova);
> >              if (!tt) {
> >                  return;
> >              }
> >              granule = tt->granule_sz;
> > -        } else {
> > +        } else if ((stage == SMMU_STAGE_2) && (cfg->stage != SMMU_NESTED)) {
> >              granule = cfg->s2cfg.granule_sz;
> > +        } else {
> > +            return;
> >          }
> >  
> >      } else {
> > @@ -1119,7 +1129,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >  /* invalidate an asid/vmid/iova range tuple in all mr's */
> >  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
> >                                        dma_addr_t iova, uint8_t tg,
> > -                                      uint64_t num_pages)
> > +                                      uint64_t num_pages, int stage)
> >  {
> >      SMMUDevice *sdev;
> >  
> > @@ -1128,10 +1138,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
> >          IOMMUNotifier *n;
> >  
> >          trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
> > -                                        iova, tg, num_pages);
> > +                                        iova, tg, num_pages, stage);
> >  
> >          IOMMU_NOTIFIER_FOREACH(n, mr) {
> > -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages);
> > +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
> >          }
> >      }
> >  }
> > @@ -1162,7 +1172,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
> >  
> >      if (!tg) {
> >          trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> > -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
> > +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
> >          if (stage == SMMU_STAGE_1) {
> >              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> >          } else {
> > @@ -1185,7 +1195,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
> >          num_pages = (mask + 1) >> granule;
> >          trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
> >                                   ttl, leaf, stage);
> > -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
> > +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
> >          if (stage == SMMU_STAGE_1) {
> >              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> >          } else {
> > diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> > index 593cc571da..be6c8f720b 100644
> > --- a/hw/arm/trace-events
> > +++ b/hw/arm/trace-events
> > @@ -55,7 +55,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
> >  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
> >  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
> >  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
> > -smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
> > +smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
> >  
> >  # strongarm.c
> >  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 

