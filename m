Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E707CC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lNI-0006oQ-5K; Wed, 22 May 2024 08:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s9lNB-0006aX-O1
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:47:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s9lNA-0000p9-1C
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:47:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41fef5dda72so57915e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1716382030; x=1716986830; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CxAZSVLZ56+EW157G/uXZntKJFAn9KrC9pysQzHkGHQ=;
 b=ncSHhivC2UEat7/5GRpfUk/FGwiJqxBTgwR+I0dwkUyShdZXnNoDWtJQ4IghtA2L8M
 2Zh8J7kNftvXcROXb78dZ51nJ/uDctWBEE59mWn/mAnNi1/jBjcAsd4vyBdQDBlms6yK
 Ug96KsNpipuFKmX5AKH+ZaMnIdx1ZV++5gZm69QdpaAFnLdJ9Wosdh4BhAovDAg+PZDI
 EqlkkmLCiY6/aTw0qITTsA5qVaRULq+l8x4zIcDu1litrensuhZF7QUem+b3cRFRqWi9
 QMhoOGEZHoUKLAQD+GvI4sv3G0Us5TM7OqUlpN9+Jr//ogaOXLhEDqkIceVzuR7zhlkx
 zsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716382030; x=1716986830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxAZSVLZ56+EW157G/uXZntKJFAn9KrC9pysQzHkGHQ=;
 b=WJy+M2ij2KHNbvgE69ljlEP+FX9mSUjc3vxn6WP9oxwO0to9jSGlG/uspYeKr9GcGt
 MfYF3eN/1Mi+wTyPqx1AR7b2+YeWXCTULOWsBMIT0Ds5yHhwYDBJYR9s48oui+v5J3ww
 peoKPbZvvlQeaD3tjJXVl7OPt+4cX/QRn8d1D3cEtqAxOp6+AYrAffmibFxCzQtytUhI
 0ZzlheMek6AZa8y3d3zAKnK4M2UEaJY2+VbwdIzxN94DVdulVeeaz/q52Ljz1T8PQcF7
 2ZPjsNPKJlxl/70yuNOaNYX0ruIrYq8BvFxcxYGRq5qY9NP6sh/GAMsJf9NMwX9dpmX5
 JsSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+3xF7kjMZT7a9xVSadE29AxyZpJuwtWLhZxU+xDeXEC9LwNo2mXCyjGj9pI9+f9rR5FriQdRDgIwfzmfcoutk8HIdfUo=
X-Gm-Message-State: AOJu0Yz5sVopwWFMhc/IlZTmI5qBh+q6sX04kPWb842p3rpqQisu8wnQ
 wo6gyYbZkT8hYu7vnGW3feAWPdxflierPMxb8nwleqMgHAF6fstDnejuJ3Mu5A==
X-Google-Smtp-Source: AGHT+IETwOHkJouFP3GeZBUOh4yMU/26CxPH0F0XnwPjR7//YfmE6yXJ5jk4WBzmrcA8pKYnjg2zKQ==
X-Received: by 2002:a05:600c:3d05:b0:41b:8715:1158 with SMTP id
 5b1f17b1804b1-420fc8142admr1806955e9.6.1716382029990; 
 Wed, 22 May 2024 05:47:09 -0700 (PDT)
Received: from google.com (230.213.79.34.bc.googleusercontent.com.
 [34.79.213.230]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc077sm34177034f8f.104.2024.05.22.05.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 05:47:09 -0700 (PDT)
Date: Wed, 22 May 2024 12:47:05 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 09/18] hw/arm/smmu-common: Rework TLB lookup for
 nesting
Message-ID: <Zk3pSdhym_mLak_L@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-10-smostafa@google.com>
 <c22b04a2-c15c-4d9e-bfff-8d9922a83122@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c22b04a2-c15c-4d9e-bfff-8d9922a83122@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=smostafa@google.com; helo=mail-wm1-x331.google.com
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

On Mon, May 20, 2024 at 10:27:50AM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > In the previous patch, comine_tlb() was added which combines 2 TLB
> > entries into one, which chooses the granule and level from the
> > smallest entry.
> >
> > This means that a nested translation, an entry can be cached with the
> > granule of stage-2 and not stage-1.
> >
> > However, the lookup for an IOVA in nested configuration is done with
> > stage-1 granule, this patch reworks lookup in that case, so it falls
> > back to stage-2 granule if no entry is found using stage-1 granule.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 0d6945fa54..c67af3bc6d 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> >      return key;
> >  }
> >  
> > -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > -                                SMMUTransTableInfo *tt, hwaddr iova)
> > +static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
> > +                                                  SMMUTransCfg *cfg,
> > +                                                  SMMUTransTableInfo *tt,
> > +                                                  hwaddr iova)
> >  {
> >      uint8_t tg = (tt->granule_sz - 10) / 2;
> >      uint8_t inputsize = 64 - tt->tsz;
> > @@ -88,6 +90,24 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> >          }
> >          level++;
> >      }
> > +    return entry;
> > +}
> > +
> > +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > +                                SMMUTransTableInfo *tt, hwaddr iova)
> > +{
> > +    SMMUTLBEntry *entry = NULL;
> > +
> > +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > +    /*
> > +     * For nested translation also try the s2 granule, as the TLB will insert
> > +     * it if the size of s2 tlb entry was smaller.
> > +     */
> > +    if (!entry && (cfg->stage == SMMU_NESTED) &&
> > +        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
> > +        tt->granule_sz = cfg->s2cfg.granule_sz;
> is it safe to alter the tt->granule_sz without restoring it? In the
> positive I think this would deserve a comment.

It should be safe in the current usage, I will add a comment to
clarify how the function behaves (something as the the granule_sz
would be updated to the entry tg if found)

Thanks,
Mostafa
> 
> Eric
> > +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > +    }
> >  
> >      if (entry) {
> >          cfg->iotlb_hits++;
> 

