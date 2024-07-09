Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBC0C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR58c-0000oS-Q8; Tue, 09 Jul 2024 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR58b-0000jN-GZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:19:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR58Z-00024x-HA
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:19:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4266f796e67so33065e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720509580; x=1721114380; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tsq4U+37Tl7NlZkMyh/LfriJsyfCLzRpcj9KqI175jE=;
 b=f2H/ONKd+vNYyCENzZkP7crmi0RTaqF3KYFYxLeeamJEJVOi6/9vmVxXay2ZsPooad
 az97U5x5Cb29FqhD3HCKvcr3nf8CKLCqhwa/pdABNh6yjl6BN43EqynlZ+aYE71dD/42
 mzDkBXYNgMJIknFVyRjVkyn9zDhJwJ7Y62csETIayUw6/4CHV/ASrZoiC4sT1S4K+H7D
 GBZ+c5tQVN/JhapY1962+Rjoj9nLuN759GGX1tHHvFxOQfu9U7vhGJ4NZcUfSMwiBDSD
 C/8fFdBAnNd3zdFz79okwjGiOnRjtQIBDxCV6rV5hA4OFdv8UDGJRVhQsjMBDy9kAyge
 TudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509580; x=1721114380;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tsq4U+37Tl7NlZkMyh/LfriJsyfCLzRpcj9KqI175jE=;
 b=Dcf+qQEUqa7eGgN00C+lw9r3rnXHGL34ACJuShH2JBRAEU1XbJM6Qhy/WV4IQsEOND
 hR2iIBpNdkG1RwC3WIqY2eZzvZ2ut34LD8Sjk0tjZXqtlBvYoNM+uM0KQP8OIiweTyGn
 Uh5e48AlMZbbop4kYU3osQ5Sg7fOqydK7ImQwQVlq9larvkPQ7lwJkjfkIefnoeUxoUr
 WhM+YQsyUGyuHG9mVsF0qD1sBSsY16w65GhT/+mkeAiytFJdoloI7Z+5aXF2Az0/6pHx
 GaXZnlVMZK3pETpOpCZFNPizCVfRZx4GUyvD49EIy8W/GicjF2IlwqzpsxMWonThyiXs
 rFqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhwJGc6ISP5owd1QTFAzjrUX/cwEO9Ps6zfNu99fSMEozZWt7MSVG1bX/4OBmOsYHCjvw3iF1brrfaJUXHCnHMwiZelsk=
X-Gm-Message-State: AOJu0YxeRbBdr09llUcrnRd6Ni8y9L2QT0ui4QCtG6fW2jw47FRDOQ68
 e/pVQtqGX7di2CgEuC4Gtg//FRZzzDCe1qs7B4uBMd2dOZBFglTIxlklej9yNw==
X-Google-Smtp-Source: AGHT+IHFF/Rtg8GLpIvyfIDHqdYoTZMRnd9JlTuPatZJ3YSm/RdWIjIIPJZpNIvdk//xJqvALURP4A==
X-Received: by 2002:a05:600c:2145:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-426731798e5mr876635e9.1.1720509580046; 
 Tue, 09 Jul 2024 00:19:40 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266d0185d9sm50516605e9.3.2024.07.09.00.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:19:39 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:19:35 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 12/19] hw/arm/smmu: Support nesting in
 smmuv3_range_inval()
Message-ID: <Zozkh8yY1GFaFz0r@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-13-smostafa@google.com>
 <20240704183236.GI1693268@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704183236.GI1693268@myrica>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=smostafa@google.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 04, 2024 at 07:32:36PM +0100, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:34AM +0000, Mostafa Saleh wrote:
> > With nesting, we would need to invalidate IPAs without
> > over-invalidating stage-1 IOVAs. This can be done by
> > distinguishing IPAs in the TLBs by having ASID=-1.
> > To achieve that, rework the invalidation for IPAs to have a
> > separate function, while for IOVA invalidation ASID=-1 means
> > invalidate for all ASIDs.
> > 
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c         | 47 ++++++++++++++++++++++++++++++++++++
> >  hw/arm/smmuv3.c              | 23 ++++++++++++------
> >  hw/arm/trace-events          |  2 +-
> >  include/hw/arm/smmu-common.h |  3 ++-
> >  4 files changed, 66 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 71afd486ba..5bf9eadeff 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -195,6 +195,25 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
> >             ((entry->iova & ~info->mask) == info->iova);
> >  }
> >  
> > +static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
> > +                                             gpointer user_data)
> > +{
> > +    SMMUTLBEntry *iter = (SMMUTLBEntry *)value;
> > +    IOMMUTLBEntry *entry = &iter->entry;
> > +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
> > +    SMMUIOTLBKey iotlb_key = *(SMMUIOTLBKey *)key;
> > +
> > +    if (info->asid >= 0) {
> 
> Should this test SMMU_IOTLB_ASID(iotlb_key) instead?
> 
Yes, nice catch!

> > +        /* This is a stage-1 address. */
> > +        return false;
> > +    }
> > +    if (info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
> > +        return false;
> > +    }
> > +    return ((info->iova & ~entry->addr_mask) == entry->iova) ||
> > +           ((entry->iova & ~info->mask) == info->iova);
> > +}
> > +
> >  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >                           uint8_t tg, uint64_t num_pages, uint8_t ttl)
> >  {
> > @@ -223,6 +242,34 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >                                  &info);
> >  }
> >  
> > +/*
> > + * Similar to smmu_iotlb_inv_iova(), but for Stage-2, ASID is always -1,
> > + * in Stage-1 invalidation ASID = -1, means don't care.
> > + */
> > +void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> > +                        uint64_t num_pages, uint8_t ttl)
> > +{
> > +    uint8_t granule = tg ? tg * 2 + 10 : 12;
> > +    int asid = -1;
> > +
> > +   if (ttl && (num_pages == 1)) {
> > +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa, tg, ttl);
> > +
> > +        if (g_hash_table_remove(s->iotlb, &key)) {
> > +            return;
> > +        }
> > +    }
> > +
> > +    SMMUIOTLBPageInvInfo info = {
> > +        .iova = ipa,
> > +        .vmid = vmid,
> > +        .mask = (num_pages * 1 << granule) - 1};
> 
> Since multiplication takes precedence over shift this looks strange.
> We could just remove "* 1" here and in smmu_iotlb_inv_iova() to avoid the
> confusion?

Agh, I just copied this and didn’t notice, that makes sense, I will fix it
here for smmu_iotlb_inv_ipa and maybe iova can be fixed separately?

Thanks,
Mostafa

> 
> Thanks,
> Jean
> 
> > +
> > +    g_hash_table_foreach_remove(s->iotlb,
> > +                                smmu_hash_remove_by_vmid_ipa,
> > +                                &info);
> > +}
> > +
> >  void smmu_iotlb_inv_asid(SMMUState *s, int asid)
> >  {
> >      trace_smmu_iotlb_inv_asid(asid);
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 86f95c1e40..e5ecd93258 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -1136,7 +1136,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
> >      }
> >  }
> >  
> > -static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
> > +static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
> >  {
> >      dma_addr_t end, addr = CMD_ADDR(cmd);
> >      uint8_t type = CMD_TYPE(cmd);
> > @@ -1161,9 +1161,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
> >      }
> >  
> >      if (!tg) {
> > -        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
> > +        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> >          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
> > -        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> > +        if (stage == SMMU_STAGE_1) {
> > +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> > +        } else {
> > +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl);
> > +        }
> >          return;
> >      }
> >  
> > @@ -1179,9 +1183,14 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
> >          uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
> >  
> >          num_pages = (mask + 1) >> granule;
> > -        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
> > +        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
> > +                                 ttl, leaf, stage);
> >          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
> > -        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> > +        if (stage == SMMU_STAGE_1) {
> > +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> > +        } else {
> > +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl);
> > +        }
> >          addr += mask + 1;
> >      }
> >  }
> > @@ -1340,7 +1349,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> >                  cmd_error = SMMU_CERROR_ILL;
> >                  break;
> >              }
> > -            smmuv3_range_inval(bs, &cmd);
> > +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> >              break;
> >          case SMMU_CMD_TLBI_S12_VMALL:
> >          {
> > @@ -1365,7 +1374,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> >               * As currently only either s1 or s2 are supported
> >               * we can reuse same function for s2.
> >               */
> > -            smmuv3_range_inval(bs, &cmd);
> > +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
> >              break;
> >          case SMMU_CMD_TLBI_EL3_ALL:
> >          case SMMU_CMD_TLBI_EL3_VA:
> > diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> > index 09ccd39548..7d9c1703da 100644
> > --- a/hw/arm/trace-events
> > +++ b/hw/arm/trace-events
> > @@ -46,7 +46,7 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
> >  smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
> >  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> >  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> > -smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
> > +smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> >  smmuv3_cmdq_tlbi_nh(void) ""
> >  smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
> >  smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index cf0fd3ec74..de032fdfd1 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -216,7 +216,8 @@ void smmu_iotlb_inv_asid(SMMUState *s, int asid);
> >  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> >  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
> > -
> > +void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> > +                        uint64_t num_pages, uint8_t ttl);
> >  /* Unmap the range of all the notifiers registered to any IOMMU mr */
> >  void smmu_inv_notifiers_all(SMMUState *s);
> >  
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 

