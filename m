Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4195EC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cud-0005YQ-QA; Thu, 16 May 2024 11:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s7cuc-0005Y9-3y
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:20:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s7cua-0004yp-8h
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:20:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41fef5dda72so417985e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715872850; x=1716477650; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rKBkDfuu4ovIlFS5i9OYlDEjCa+HYlUUd2BNYILbC1I=;
 b=1iuGLwPDv21Sq8UrZ//Dpq1rpZ6OndfY6nl9i5IzzAkrW10cfYzlu8635Fyw2CuMcZ
 inbUJjRjosHkkiV4DUXbVcBGI58EhK6qIRYQyTX3GafhcacecwCrtL3fjkN5Imwr0oQT
 QGP4pAyitvKfxLND+XtxBZtEcJQlWIpPNcAqE5laqEE3BMCBPxPh1+31zZPNgjwY4Rc2
 3U2ZqacTJNITtv592WhYTX3bPGxqhYBGgokYy4hQllf2YVk6GwqyOnZI25ALdc3o+aXI
 kqdP00g7Rt9W8SJ35fnodRD4c9xoADavisyNswYmPAbcw4lcQiiw6cpuEFIrwIAHnoht
 W2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715872850; x=1716477650;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKBkDfuu4ovIlFS5i9OYlDEjCa+HYlUUd2BNYILbC1I=;
 b=EM6+OukEP8Cee52s8jBEl4N/B1bJpKucW80J+hY0wBFQftaa8LsS1U7rC0GwWodPU9
 Lm7/u1bNGBldStwKWa2HxM/E7LuqT/2vhhxBhRSIWj8+H7x/CxnPzPOa3SsJ0gjP3mSo
 Kb9XioOCQvFVJYG0pzBVUbgFcNZoTPD1eOsdL1nK6MFTLvPHP7NQHQkYVyzWZRbpaLP0
 zNRlvlmsHYsFeZe3pMCxZISkYDN8aUHuCmAJRfz45m2zky1FA6ITB34nAHxKqqD596aH
 jzImAnPkoSlVjLKaKFXuxiR0G50N+tZw0whh8Y1hiCzr52U4fGkqndM9JK5247/L46wZ
 4ZKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCNJlkqTdunSs5nBuZI25IozeFK57MteVpDdUOG581exErIivhsg6F8Civ8KOyMjf5pxWk47suxYC+AT46TKVmYe14dlk=
X-Gm-Message-State: AOJu0YwDtOWUMH1qCv7veU6xHuzqWRt4479RIlJI3IbvgV6eHYbO3lPt
 tTA0MoWVdDpRYLjThwrY7wOpSyghDop/Mx/iTpU65LExbMXKKGtPzLof684cZA==
X-Google-Smtp-Source: AGHT+IFgMAeYxnuW2uFNhhf9/gQCKbo+IFo2Sh8OwOx+8HLGqZeVaM874LWFf5HJC24SZz1TR2oTCA==
X-Received: by 2002:a05:600c:3d0c:b0:41c:ab7:f9af with SMTP id
 5b1f17b1804b1-4200f8ac9c8mr11310135e9.3.1715872850174; 
 Thu, 16 May 2024 08:20:50 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b79be1dsm19430571f8f.10.2024.05.16.08.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:20:49 -0700 (PDT)
Date: Thu, 16 May 2024 15:20:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 08/18] hw/arm/smmu-common: Add support for nested
 TLB
Message-ID: <ZkYkTgDztEyX6GT_@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-9-smostafa@google.com>
 <dc8d52ac-68af-4426-9a60-07ad909c86b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc8d52ac-68af-4426-9a60-07ad909c86b0@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32e.google.com
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

Hi Eric,

On Wed, May 15, 2024 at 03:48:05PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > This patch adds support for nested(combined) TLB entries.
> space between nested and (.
Will do.
> > The main function combine_tlb() is not used here but in the next
> > patches, but to simplify the patches it is introduced first.
> >
> > Main changes:
> > 1) New entry added in the TLB, parent_perm, for nested TLB, holds the
> s/entry/field, s/TLB/SMMUTLBEntry struct
Will do.
> >    stage-2 permission, this can be used to know the origin of a
> >    permission fault from a cached entry as caching the “and” of the
> >    permissions loses this information.
> >
> >    SMMUPTWEventInfo is used to hold information about PTW faults so
> >    the event can be populated, the value of stage (which maps to S2
> >    in the event) used to be set based on the current stage for TLB
> I don't understand "(which maps to S2 in the event)". What do you mean?
> This could be S1 or S2 depending on the active stage, no?

Not really, if the IPA size is larger than S2 input size, this is
considered stage-1 fault.

For TLB permission fault, yes, that is how it is decided.
However, with nesting, a permission fault from a cached entry can be
from a stage-1 or stage-2, that’s why we now cache both and not just
the combined permission, and the logic to set fault stage is modified
accordingly.

> >    permission faults, however with the parent_perm, it is now set
> >    based on which perm has the missing permission
> >
> >    When nesting is not enabled it has the same value as perm which
> >    doesn't change the logic.
> >
> > 2) As combined TLB implementation is used, the combination logic
> >    chooses:
> >    - tg and level from the entry which has the smallest addr_mask.
> tbh I am scared bout swapping s1/s2 tg and level. In smmu_iotlb_lookup()
> I see tt->granule_sz being used which is s1 data. I mean it is not
> obvious to me this is correct. Could you maybe give more explanations
> detailing why/how this is guaranted to work.

As you mentioned the next patch reworks the lookup logic, I can reorder
the 2 patches if that is better, please let me know what you think?

> 
> Can you give additional details about what s1+s2 combinations were tested?

I tested with S1 and S2 4K pages
S1 level = 3 and S2 level = 3
S1 level = 2 and S2 level = 3
S1 level = 3 and S2 level = 2
S1 level = 1 and S2 level = 2

And also tested with with S1 64K granule and S2 4K.

> >    - Based on that the iova that would be cached is recalculated.
> >    - Translated_addr is chosen from stage-2.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c         | 32 ++++++++++++++++++++++++++++----
> >  include/hw/arm/smmu-common.h |  1 +
> >  2 files changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 21982621c0..0d6945fa54 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -394,7 +394,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >          tlbe->entry.translated_addr = gpa;
> >          tlbe->entry.iova = iova & ~mask;
> >          tlbe->entry.addr_mask = mask;
> > -        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
> > +        tlbe->parent_perm = tlbe->entry.perm = PTE_AP_TO_PERM(ap);
> nit: I would prefer on separate lines.
Will do.

> >          tlbe->level = level;
> >          tlbe->granule = granule_sz;
> >          return 0;
> > @@ -515,7 +515,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
> >          tlbe->entry.translated_addr = gpa;
> >          tlbe->entry.iova = ipa & ~mask;
> >          tlbe->entry.addr_mask = mask;
> > -        tlbe->entry.perm = s2ap;
> > +        tlbe->parent_perm = tlbe->entry.perm = s2ap;
> >          tlbe->level = level;
> >          tlbe->granule = granule_sz;
> >          return 0;
> > @@ -530,6 +530,27 @@ error:
> >      return -EINVAL;
> >  }
> >  
> > +/* combine 2 TLB entries and return in tlbe in nested config. */
> suggestion: combine S1 and S2 TLB entries into a single entry. As a
> result the S1 entry is overriden with combined data.
Will do.

> > +static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> > +                                                SMMUTLBEntry *tlbe_s2,
> > +                                                dma_addr_t iova,
> > +                                                SMMUTransCfg *cfg)
> > +{
> > +    if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
> > +        tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
> > +        tlbe->granule = tlbe_s2->granule;
> > +        tlbe->level = tlbe_s2->level;
> > +    }
> > +
> > +    tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
> > +                                    tlbe->entry.translated_addr);
> > +
> > +    tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
> > +    /* parent_perm has s2 perm while perm has s1 perm. */
> 
>  suggestion: while perm keeps s1 perm.
> 
Will do.

Thanks,
Mostafa
> > +    tlbe->parent_perm = tlbe_s2->entry.perm;
> > +    return;
> > +}
> > +
> >  /**
> >   * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
> >   *
> > @@ -607,9 +628,12 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> >  
> >      cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
> >      if (cached_entry) {
> > -        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
> > +        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
> > +            cached_entry->parent_perm & IOMMU_WO)) {
> >              info->type = SMMU_PTW_ERR_PERMISSION;
> > -            info->stage = cfg->stage;
> > +            info->stage = !(cached_entry->entry.perm & IOMMU_WO) ?
> > +                          SMMU_STAGE_1 :
> > +                          SMMU_STAGE_2;
> >              return NULL;
> >          }
> >          return cached_entry;
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index 09d3b9e734..1db566d451 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -77,6 +77,7 @@ typedef struct SMMUTLBEntry {
> >      IOMMUTLBEntry entry;
> >      uint8_t level;
> >      uint8_t granule;
> > +    IOMMUAccessFlags parent_perm;
> >  } SMMUTLBEntry;
> >  
> >  /* Stage-2 configuration. */
> Thanks
> 
> Eric
> 

