Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550ADC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 08:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRSrY-0002l8-86; Wed, 10 Jul 2024 04:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sRSrW-0002kd-BQ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 04:39:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sRSrU-0008Ef-7P
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 04:39:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42725f8a789so32875e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720600778; x=1721205578; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jFmHJfmTGTP47K9khZ7rP9ll6eIMo1T/N9shnRIEclU=;
 b=2J7I+SYZK77CgK1ukw7+viIZ0hqsvaS32BdOQUwxMXsjJYBBEYrX7HazHMUsacul3U
 XCMhPtkSdoa/jF6LK9z6xIpy9REBIjVOeNLICjyYqVMpXzx9Wdr7P2wTCTzz+RrtIK7z
 YFB6QVDB+ndJgMAjhf4a6oUA4mtniJ56cYXR3IOQogw6LWIoCwBQU8jS8j4eAO+6tscX
 NBrgOgwRFCg2ARrLA29LxY2SL2QK5MwNiMkqryeTRAax5IFE0pDYNdwyNBYKOVA1wm93
 1SfFUSW1bE4zfRM6PR1J/nUKLRl71XWQe7jLss+4uJ8CsRh6Ij/5AsyOtjYoINp+GeAQ
 mzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720600778; x=1721205578;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jFmHJfmTGTP47K9khZ7rP9ll6eIMo1T/N9shnRIEclU=;
 b=h9bamh7fRUmQWu5CTXsURIjw6NXRV5aTCnOQxe4SSRGtEnL98bt40wMJT9rpEm6fyy
 A4SvLuaYFs4SkZxb2IZkaX3gxxcg4sXBI8+5pp1kCUzsXJLb9dnwJhe12IIXZwCnqxMY
 Xj1f2fJJyUi6Br6rmkVoLVsjZLdq6526Z75syCVelRCuKOIS3AeB8gNT2xPv52UnLPTN
 Js3hn4S3Gd66c6F9Ohm8MZ3LnS5qLQX96H9DL9z6THTqMNksLkf6Hpiiu+Ljv+1a8hCf
 hLzfrGdcEIMce0Lc1M7ukF7RWbjyjN8BrvXWgbFj2thdlh3xlKszaWIYW206Iv6zH5Vz
 pKAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURK7meYriTMELg3zBOBxbneoxjDkEUWlLlkAQc0ZJhKpThQujdHD+0BlSpaYDaNjdneRE9YR9QmV0vCaqQnL2vWJO11kE=
X-Gm-Message-State: AOJu0YxDxusqlkdmShqYe6fHGB4t8cMRAoHGc8H86hRlwVjRWApSCz8p
 NMbyP+jxPFiRHCbswTIklkuPMxtXfeKnUqhvYtmvUiTTTdOmroF3zrvg71Ou5A==
X-Google-Smtp-Source: AGHT+IEONpRIjGxgcWGaMYOktbD16oWQacf+RJ4S6rKqwyV84a86i0izLtqZBdKEdNoUt6XgwCV6+g==
X-Received: by 2002:a05:600c:354e:b0:426:66a0:6df6 with SMTP id
 5b1f17b1804b1-427937a580dmr1239115e9.0.1720600777705; 
 Wed, 10 Jul 2024 01:39:37 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm39968375e9.20.2024.07.10.01.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 01:39:37 -0700 (PDT)
Date: Wed, 10 Jul 2024 08:39:33 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 09/19] hw/arm/smmu-common: Rework TLB lookup for nesting
Message-ID: <Zo5Ixb3Li81fZPvQ@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-10-smostafa@google.com>
 <20240704181235.GF1693268@myrica> <ZozjS59a4aluqUju@google.com>
 <20240709171345.GC2189727@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709171345.GC2189727@myrica>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32d.google.com
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

On Tue, Jul 09, 2024 at 06:13:45PM +0100, Jean-Philippe Brucker wrote:
> On Tue, Jul 09, 2024 at 07:14:19AM +0000, Mostafa Saleh wrote:
> > Hi Jean,
> > 
> > On Thu, Jul 04, 2024 at 07:12:35PM +0100, Jean-Philippe Brucker wrote:
> > > On Mon, Jul 01, 2024 at 11:02:31AM +0000, Mostafa Saleh wrote:
> > > > In the next patch, combine_tlb() will be added which combines 2 TLB
> > > > entries into one for nested translations, which chooses the granule
> > > > and level from the smallest entry.
> > > > 
> > > > This means that with nested translation, an entry can be cached with
> > > > the granule of stage-2 and not stage-1.
> > > > 
> > > > However, currently, the lookup for an IOVA is done with input stage
> > > > granule, which is stage-1 for nested configuration, which will not
> > > > work with the above logic.
> > > > This patch reworks lookup in that case, so it falls back to stage-2
> > > > granule if no entry is found using stage-1 granule.
> > > 
> > > Why not initialize tt_combined to the minimum granule of stages 1 and 2?
> > > It looks like you introduced it for this. I'm wondering if we lookup the
> > > wrong IOVA if changing the granule size after the address is masked in
> > > smmu_translate()
> > 
> > I am not sure I fully understand, but I don’t think that would work as it is
> > not guaranteed that the minimum granule is the one that would be cached,
> > as we might hit block mappings.
> > 
> > The IOVA at first is masked with the first stage mask for the expected page
> > address, and the lookup logic would mask the address for each level look up,
> > so It should match the alignment of the cached page of that granule and level,
> > and as the combine logic is done with the aligned_addr it is guaranteed by
> > construction that it has to be aligned with stage-1.
> 
> I missed something, this is what I had in mind initially:
> 
> * s1 granule is 64k, s2 granule is 4k
> * the tlb already contains a translations for IOVA 0x30000, tg=4k
> * now we lookup IOVA 0x31000. Masked with the s1 granule, aligned_addr is
>   0x30000. Not found at first because lookup is with tg=64k, but then we
>   call smmu_iotlb_lookup_all_levels() again with the s2 granule and the
>   same IOVA, which returns the wrong translation

If the granules are s1=64k, s2=4k, the only way we get a cached entry as
(IOVA 0x30000, tg=4k) would be for s2 and level-3 as for level-2 it has
to be aligned with 0x200000

So when we look up for 0x31000, there is no entry for it anyway.

But I can see some problems here:
In case also s1 granule is 64k, s2 granule is 4k
- Translation A: 0x31000
- TLB is empty => PTW, entry s1 =  64k 0x30000, s2 = 4k, 0x30000 and
  the cached entry would be 0x30000,tg=4k as the combine logic also
  uses the aligned address
- Translation B: 0x31000 => also misses as the only cached entry
  is 0x30000, 4k

I think this is actually a bug and not just a TLB inefficiency, I need
to think more about it, but my initial thought is not to align the
iova until it’s used by a stage so it can use its granule.

> 
> But it's not actually possible, because if cfg->stage == SMMU_NESTED, then
> in smmu_translate() we end up with
> 
>     } else {
>         /* Stage2. */
>         tt_combined.granule_sz = cfg->s2cfg.granule_sz;
> 
> So I think the condition
> 
> 	(cfg->stage == SMMU_NESTED) && (cfg->s2cfg.granule_sz != tt->granule_sz)
> 
> in this patch is never true?
> 

Ah, that’s a bug, I will fix it, NESTED should use stage-1 granule.

> 
> Then the following scenario:
> 
> * s1 granule is 4k, s2 granule is 64k
> * we lookup IOVA A, miss. The translation gets cached with granule 4k
> * we lookup IOVA A again, but with tt->granule_sz = 64k so we'll
>   never find the entry?
> 
> 
> I guess we want to start the lookup with the smallest granule, and then if
> the s1 and s2 granules differ, retry with the other one. Or with
> SMMU_NESTED, start with the s1 granule and keep this patch to fallback to
> s2 granule, but without masking the IOVA in smmu_translate() (it will be
> masked correctly by smmu_iotlb_lookup_all_levels()).

Thanks for pointing that out, I will think more about it but I sense
that we would need to modify where we align the iova, for translation
and lookup.


Thanks,
Mostafa

> 
> Thanks,
> Jean
> 
> > 
> > Thanks,
> > Mostafa
> > 
> > > 
> > > Thanks,
> > > Jean
> > > 
> > > > 
> > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > ---
> > > >  hw/arm/smmu-common.c | 36 ++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 34 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > > > index 21982621c0..0840b5cffd 100644
> > > > --- a/hw/arm/smmu-common.c
> > > > +++ b/hw/arm/smmu-common.c
> > > > @@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> > > >      return key;
> > > >  }
> > > >  
> > > > -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > > > -                                SMMUTransTableInfo *tt, hwaddr iova)
> > > > +static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
> > > > +                                                  SMMUTransCfg *cfg,
> > > > +                                                  SMMUTransTableInfo *tt,
> > > > +                                                  hwaddr iova)
> > > >  {
> > > >      uint8_t tg = (tt->granule_sz - 10) / 2;
> > > >      uint8_t inputsize = 64 - tt->tsz;
> > > > @@ -88,6 +90,36 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > > >          }
> > > >          level++;
> > > >      }
> > > > +    return entry;
> > > > +}
> > > > +
> > > > +/**
> > > > + * smmu_iotlb_lookup - Look up for a TLB entry.
> > > > + * @bs: SMMU state which includes the TLB instance
> > > > + * @cfg: Configuration of the translation
> > > > + * @tt: Translation table info (granule and tsz)
> > > > + * @iova: IOVA address to lookup
> > > > + *
> > > > + * returns a valid entry on success, otherwise NULL.
> > > > + * In case of nested translation, tt can be updated to include
> > > > + * the granule of the found entry as it might different from
> > > > + * the IOVA granule.
> > > > + */
> > > > +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > > > +                                SMMUTransTableInfo *tt, hwaddr iova)
> > > > +{
> > > > +    SMMUTLBEntry *entry = NULL;
> > > > +
> > > > +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > > > +    /*
> > > > +     * For nested translation also try the s2 granule, as the TLB will insert
> > > > +     * it if the size of s2 tlb entry was smaller.
> > > > +     */
> > > > +    if (!entry && (cfg->stage == SMMU_NESTED) &&
> > > > +        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
> > > > +        tt->granule_sz = cfg->s2cfg.granule_sz;
> > > > +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > > > +    }
> > > >  
> > > >      if (entry) {
> > > >          cfg->iotlb_hits++;
> > > > -- 
> > > > 2.45.2.803.g4e1b14247a-goog
> > > > 

