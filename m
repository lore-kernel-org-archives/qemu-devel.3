Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC56C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR53X-0002EZ-BI; Tue, 09 Jul 2024 03:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR53W-0002Ao-C5
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:14:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR53S-0001No-9c
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:14:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42725f8a789so10675e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720509264; x=1721114064; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3sKwju1f78C/prHBclW/s70RYAmRYQ/oOkEShhP5EGg=;
 b=zYozXK5X0FSceo/779gnBEQ+yfra9/DoRqXaGhUV6iTzsO2ecAcJAXDEKD/00TwtMm
 k+6yfmkLNvVCTPExy/ucT+zUkCWn5uvKlqPMVpZjFVQjNClIQSHzE2vhJqpJn8VykGAO
 z/VFDlBf5PWfHlyD3N5v4ri6LMMJV9fwMTlXf0OC1UrZbj95FMIAyPXk5xN9Wv6siSkc
 WCtBPAe0A9bqcJa8Rv27pY6T2bcaPAdZB84DJYDAckFMbFR4FboE+SUXBBHTw0cSCI70
 CV3dTdLkKxtRFoHGYdhflFyocppnYIocYKeJjwcnhmHwYV3PYxEqVlMg5V6CNMkUhw3U
 ODlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509264; x=1721114064;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3sKwju1f78C/prHBclW/s70RYAmRYQ/oOkEShhP5EGg=;
 b=atlHxZJ1iHIloqtf7OB9MLuTwNXivtGOUotf+h0hEZOltBNoLCxgDBHNlUh3MFg2Uj
 NPkQ6xgMDihmCj1i3molUfyDpLd79yf0m52TsQttMaixcQuoI2WXWCFL4X5eWlbBjvUn
 xSSUsI0C8BV8bnV4sXWpRrEi9eX9/Y7TOcs8UOsUO5TLZzM33JIxqWHZXdzJudyqZtzk
 zmuTUCylez8fJmqpWANpL9LBZYM/cBiszglMVTbjJBYEEOTq+fo6MvbK77mZGUQUdlva
 3R2lEL+tfnC46kDbW8YzR+s9/Cq3pdR1Kwy7q0yeSsptN00cHKV9TZUJ14EOeIGwK7um
 WoAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7s1ga8EzI+oOZrr6Z/x2K00HVHYeQG3xuOWCDIEu7uN2mWd/RbtLislwIGLESYEcwxqyqZTytToBNwMSozBzMfGVwAgw=
X-Gm-Message-State: AOJu0Yx1DC5RUEbhvmu2IymYjTKx08YNovTHE3MgYe1F4iCbnpnHIUk8
 D0OZnThPxlq+JIgsukCqUiPnGIKCDtD0rRyxKranL7XJ+GF5B20EdFoQ/34HKQ==
X-Google-Smtp-Source: AGHT+IFfdxc5fJP0OkW3IExzFHyKme2aWPFwVXaZ4SvkPW5D7CXlOhtgNDzkUXrpoZD89+M9efdieQ==
X-Received: by 2002:a05:600c:3b16:b0:426:5ef2:cd97 with SMTP id
 5b1f17b1804b1-42671a88f7dmr1428805e9.2.1720509263754; 
 Tue, 09 Jul 2024 00:14:23 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab0b4sm1643325f8f.90.2024.07.09.00.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:14:23 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:14:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 09/19] hw/arm/smmu-common: Rework TLB lookup for nesting
Message-ID: <ZozjS59a4aluqUju@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-10-smostafa@google.com>
 <20240704181235.GF1693268@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704181235.GF1693268@myrica>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=smostafa@google.com; helo=mail-wm1-x329.google.com
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

On Thu, Jul 04, 2024 at 07:12:35PM +0100, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:31AM +0000, Mostafa Saleh wrote:
> > In the next patch, combine_tlb() will be added which combines 2 TLB
> > entries into one for nested translations, which chooses the granule
> > and level from the smallest entry.
> > 
> > This means that with nested translation, an entry can be cached with
> > the granule of stage-2 and not stage-1.
> > 
> > However, currently, the lookup for an IOVA is done with input stage
> > granule, which is stage-1 for nested configuration, which will not
> > work with the above logic.
> > This patch reworks lookup in that case, so it falls back to stage-2
> > granule if no entry is found using stage-1 granule.
> 
> Why not initialize tt_combined to the minimum granule of stages 1 and 2?
> It looks like you introduced it for this. I'm wondering if we lookup the
> wrong IOVA if changing the granule size after the address is masked in
> smmu_translate()

I am not sure I fully understand, but I don’t think that would work as it is
not guaranteed that the minimum granule is the one that would be cached,
as we might hit block mappings.

The IOVA at first is masked with the first stage mask for the expected page
address, and the lookup logic would mask the address for each level look up,
so It should match the alignment of the cached page of that granule and level,
and as the combine logic is done with the aligned_addr it is guaranteed by
construction that it has to be aligned with stage-1.

Thanks,
Mostafa

> 
> Thanks,
> Jean
> 
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c | 36 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 21982621c0..0840b5cffd 100644
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
> > @@ -88,6 +90,36 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> >          }
> >          level++;
> >      }
> > +    return entry;
> > +}
> > +
> > +/**
> > + * smmu_iotlb_lookup - Look up for a TLB entry.
> > + * @bs: SMMU state which includes the TLB instance
> > + * @cfg: Configuration of the translation
> > + * @tt: Translation table info (granule and tsz)
> > + * @iova: IOVA address to lookup
> > + *
> > + * returns a valid entry on success, otherwise NULL.
> > + * In case of nested translation, tt can be updated to include
> > + * the granule of the found entry as it might different from
> > + * the IOVA granule.
> > + */
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
> > +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > +    }
> >  
> >      if (entry) {
> >          cfg->iotlb_hits++;
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 

