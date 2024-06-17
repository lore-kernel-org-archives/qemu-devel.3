Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42F1C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDsH-0006FO-Jx; Mon, 17 Jun 2024 11:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDsD-0006CK-3z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:02:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDs9-0002Ne-B8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:02:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4216d9952d2so116625e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718636529; x=1719241329; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XQ0ikf2V9L0ChQ2aIx/bsKRbW4q9ae9R/rVmAWg7XLA=;
 b=HKpAGhwa+gYJnATJoJdVeya4CJoGtp/S5ctj6PtxvNf1hPXCegUBaXuuok1wbPUAEq
 E94HSMaYTIwdMcI/n3U/h4AJX6NpipjXQNYPrTMbPaKNL+/Uf93Rq1eQX9PEWvrgInSE
 ASCMBtQDKb5+TOefsbcHWtycScOJkbjQjSuXgMZzsfR5sV5CTK0lA1JAiPd493l6ucBD
 Ek7dQy3oKZI11rUamjaDcl6C5ISAorvVW8OGENvtSYhUTlt/d8CtQ9lbCT9S+wCcQYxS
 cLTsMtn6Zo9O3PAx3S8SA9+P8KbfbIbPxSQNY0shzB3OsobCXPRMzHrIgYOKzKtPge4/
 0Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718636529; x=1719241329;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XQ0ikf2V9L0ChQ2aIx/bsKRbW4q9ae9R/rVmAWg7XLA=;
 b=Ev/aRgjosTklgzoq1n4uq0y4wqrjrjwBVLvExNYFqVbaNHXXWlIuyt8TZmAZks7a47
 pmXijTldgFTSp2yAGBeCx+sxKamPEkmtoiyFpbgZCjMMxAPhxxpJ6sGjT62o6qLCCQ/h
 jMo41RYFjJnsreidLS3RrswKVJ1ropWTb/OOhuxcde0qoXHMHjJkX1q+AeyG/Iw4FWNm
 V4NtGjRSr0g2HdRMWcLlwYqZf52/wENaRWuQVBh/gunFDVwJM7GOLrWnCjdIRMjXVEbF
 ImLrsyXWmjrNPWWcmgwHoU4HeQFGsnVfYdlaZKASnOFDC7zm2e44kKfa5xvEe7EPAq+B
 NfBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/BOouFYX+09QPnNGpWLb0Ip+5tYPhxGbazcyYW1KjgEyCeye5zJsmPuo2qyA6rjB4kRcNlfzFpUtpxZ0VWY9sy6Zsoaw=
X-Gm-Message-State: AOJu0YzXjPuEqlXtVZg0CGpwudxDpwoDI86mWoGY+lYDWInuuoMoFESI
 s52oQP8MjwjmagVEFXu+tSNfWrLdsFULcKgEMvIU0dBLEe2AN5pX2qzEek59ow==
X-Google-Smtp-Source: AGHT+IGBAWlDbf3t2O5QBHwdJ9TGMY2eblhj+E8+lvwHE9MJ/znatv1R9DsFMyS1hSb/uJt5gPTtAg==
X-Received: by 2002:a05:600c:1d97:b0:421:292d:f1e7 with SMTP id
 5b1f17b1804b1-423b5fb137amr3803065e9.6.1718636528842; 
 Mon, 17 Jun 2024 08:02:08 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874de63asm200740215e9.30.2024.06.17.08.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:02:08 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:02:04 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 13/18] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
Message-ID: <ZnBP7ONKCr2fxp-S@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-14-smostafa@google.com>
 <ee406ad2-68c9-47e2-8167-20dbceb1e484@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee406ad2-68c9-47e2-8167-20dbceb1e484@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
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

Hi Eric,

On Mon, May 20, 2024 at 12:37:55PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > IOMMUTLBEvent only understands IOVA, for stage-2 only SMMUs keep
> > the implementation, while only notify for stage-1 invalidation
> > in case of nesting.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3.c     | 23 +++++++++++++++--------
> >  hw/arm/trace-events |  2 +-
> >  2 files changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index e0fd494646..96d07234fe 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -1051,7 +1051,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >                                 IOMMUNotifier *n,
> >                                 int asid, int vmid,
> >                                 dma_addr_t iova, uint8_t tg,
> > -                               uint64_t num_pages)
> > +                               uint64_t num_pages, int stage)
> add the new param in the doc comment above
> >  {
> >      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
> >      IOMMUTLBEvent event;
> > @@ -1075,14 +1075,21 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >              return;
> >          }
> >  
> > -        if (STAGE1_SUPPORTED(s)) {
> > +        /*
> > +         * IOMMUTLBEvent only understands IOVA, for stage-2 only SMMUs
> > +         * keep the implementation, while only notify for stage-1
> > +         * invalidation in case of nesting.
> > +         */
> > +        if (stage == SMMU_STAGE_1) {
> >              tt = select_tt(cfg, iova);
> >              if (!tt) {
> >                  return;
> >              }
> >              granule = tt->granule_sz;
> > -        } else {
> > +        } else if (!STAGE1_SUPPORTED(s)) {
> I don't get why you don't test stage == SMMU_STAGE_2 instead
> in each block shouldn't you test if the corresponding state of supported?
> >              granule = cfg->s2cfg.granule_sz;
> > +        } else {
> I don't really understand the logic here. Please can you comment each case?

The current implementation will call memory_region_notify_iommu_one()
from smmuv3_notify_iova() for stage-1 or stage-2 based on which one is supported
and in each case this address is considered an “IOVA”.

However, with nested translation memory_region_notify_iommu_one() doesn’t distinguish
between stage-1 and stage-2, so only stage-1 is considered “IOVA”.

And the implementation basically as follows:
1) If the translation was stage-1, it’s an IOVA and
   memory_region_notify_iommu_one() is called.

2) If stage-1 is not supported (this is an stage-2 only instance) maintain
   the old behaviour by calling memory_region_notify_iommu_one()

3) This leaves us with stage-1 being supported and this is a stage-2
   translation, where the notification would be ignored, I think in
   this case if the SW configured only for stage-2 it would expect
   it to behave as 2) :/

Not sure how to fix that, maybe only ignore stage-2 if it was in a nested STE,
or just or always ignore stage-2?

Thanks,
Mostafa

> 
> Thanks
> 
> Eric
> > +            return;
> >          }
> >  
> >      } else {
> > @@ -1101,7 +1108,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >  /* invalidate an asid/vmid/iova range tuple in all mr's */
> >  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
> >                                        dma_addr_t iova, uint8_t tg,
> > -                                      uint64_t num_pages)
> > +                                      uint64_t num_pages, int stage)
> >  {
> >      SMMUDevice *sdev;
> >  
> > @@ -1110,10 +1117,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
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
> > @@ -1144,7 +1151,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
> >  
> >      if (!tg) {
> >          trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> > -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
> > +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
> >          if (stage == SMMU_STAGE_1) {
> >              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> >          } else {
> > @@ -1167,7 +1174,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
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
> 

