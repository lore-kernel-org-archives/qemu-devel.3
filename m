Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0A8C3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 17:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sREPO-0000wT-BD; Tue, 09 Jul 2024 13:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sREPL-0000oC-UP
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:13:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sREPJ-0000qc-LD
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 13:13:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso35706185e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720545216; x=1721150016; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M21kN0hAmUgoAhZACpNGCGJZUGoSABCOK98rI/RbKg0=;
 b=w4gfqhV4Df3dMO4A0UJ+TrVdqWDQNFGqAB6769EhMho1UapUOgsovagmpiCFc81PuJ
 6d04m/T7h/CPOj7VIJG48ip+9KXjeUkK2TjFpCBJ5K+Y/po980OtdcfqNjwkFlxnJVz6
 vYMjl7nY/tSYXBPOaQAFOam8xGRkcGy1ZOCpqNEQr9YVDFihw+oRrrKCxXjKba28MY/y
 JLMPL++4Fuc+kziiQ7iZUSAqgesMjWg8JrSGRd+zB9PJsKSB14iVH2qp+ZhxhSjZ0oSa
 fy18zdRP9AOsrfSoOY7RDOKri5GWicwkNEfztrX2uDIwXZO28x1VcXfR1ubzyyxy8ELU
 TCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720545216; x=1721150016;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M21kN0hAmUgoAhZACpNGCGJZUGoSABCOK98rI/RbKg0=;
 b=Uq8ZOibfRRGQqe+Yv8JH+dkAB0cW/DjdBaYwqlX+vjqmNPNZoF4vBm6rLcEWGs0RBX
 RNFEec8BJ5+2FbUxy8KDp/YhIJMRrtM/t+JKWhM8B5aywEjslYCGQ0soNKKeXJMcteM5
 XBV1Han2EXG8QWBgcpqn0BCusPkuQVqiLhOk35GyblHOZUqnWBxbsq31FnLZRoDfronM
 cjc+laUuaofb5+vLMbDvd299JigA9AwrBmfw/KhiXNSqI1NnPmUbv9o0/WguT0tL8ORw
 vLM9z6m9fTIVJ4H31lejs2Ys0eKSx3DZUvk8ljfdg+ulJKRokvOWdujLCD5WDPTYIsd3
 CvKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzu2jlN21qp5rG9GZcqIFZte8Pvt5/++ya+OVQGCtRqH4mThKdrYRZGZqhQsLfAARpM06ZYaEUMaRw2WJKGma+G/WKzOE=
X-Gm-Message-State: AOJu0YzVt7X5Kzt6B5m9kEYJJP2Q48vWtyEK6Uqs4Rx9BeSAxxcSkNKu
 U4z2qN3lte1xAdrDnh1kk7pslocpMQ5v9l061YUFBOFIYPN7vP28zPBjURwwqws=
X-Google-Smtp-Source: AGHT+IHBLw+TeFdnyPk0Q7oqWqKZJfnh1XGhmKfCEzfaPnBMQMNDxiF6KWHVFkKs9zHK1vjVPHTCdw==
X-Received: by 2002:a05:600c:41c4:b0:426:5ee5:3129 with SMTP id
 5b1f17b1804b1-426707ce948mr25035605e9.2.1720545215941; 
 Tue, 09 Jul 2024 10:13:35 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266e6478d7sm67474995e9.31.2024.07.09.10.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 10:13:35 -0700 (PDT)
Date: Tue, 9 Jul 2024 18:13:45 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 09/19] hw/arm/smmu-common: Rework TLB lookup for nesting
Message-ID: <20240709171345.GC2189727@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-10-smostafa@google.com>
 <20240704181235.GF1693268@myrica> <ZozjS59a4aluqUju@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZozjS59a4aluqUju@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 09, 2024 at 07:14:19AM +0000, Mostafa Saleh wrote:
> Hi Jean,
> 
> On Thu, Jul 04, 2024 at 07:12:35PM +0100, Jean-Philippe Brucker wrote:
> > On Mon, Jul 01, 2024 at 11:02:31AM +0000, Mostafa Saleh wrote:
> > > In the next patch, combine_tlb() will be added which combines 2 TLB
> > > entries into one for nested translations, which chooses the granule
> > > and level from the smallest entry.
> > > 
> > > This means that with nested translation, an entry can be cached with
> > > the granule of stage-2 and not stage-1.
> > > 
> > > However, currently, the lookup for an IOVA is done with input stage
> > > granule, which is stage-1 for nested configuration, which will not
> > > work with the above logic.
> > > This patch reworks lookup in that case, so it falls back to stage-2
> > > granule if no entry is found using stage-1 granule.
> > 
> > Why not initialize tt_combined to the minimum granule of stages 1 and 2?
> > It looks like you introduced it for this. I'm wondering if we lookup the
> > wrong IOVA if changing the granule size after the address is masked in
> > smmu_translate()
> 
> I am not sure I fully understand, but I don’t think that would work as it is
> not guaranteed that the minimum granule is the one that would be cached,
> as we might hit block mappings.
> 
> The IOVA at first is masked with the first stage mask for the expected page
> address, and the lookup logic would mask the address for each level look up,
> so It should match the alignment of the cached page of that granule and level,
> and as the combine logic is done with the aligned_addr it is guaranteed by
> construction that it has to be aligned with stage-1.

I missed something, this is what I had in mind initially:

* s1 granule is 64k, s2 granule is 4k
* the tlb already contains a translations for IOVA 0x30000, tg=4k
* now we lookup IOVA 0x31000. Masked with the s1 granule, aligned_addr is
  0x30000. Not found at first because lookup is with tg=64k, but then we
  call smmu_iotlb_lookup_all_levels() again with the s2 granule and the
  same IOVA, which returns the wrong translation

But it's not actually possible, because if cfg->stage == SMMU_NESTED, then
in smmu_translate() we end up with

    } else {
        /* Stage2. */
        tt_combined.granule_sz = cfg->s2cfg.granule_sz;

So I think the condition

	(cfg->stage == SMMU_NESTED) && (cfg->s2cfg.granule_sz != tt->granule_sz)

in this patch is never true?


Then the following scenario:

* s1 granule is 4k, s2 granule is 64k
* we lookup IOVA A, miss. The translation gets cached with granule 4k
* we lookup IOVA A again, but with tt->granule_sz = 64k so we'll
  never find the entry?


I guess we want to start the lookup with the smallest granule, and then if
the s1 and s2 granules differ, retry with the other one. Or with
SMMU_NESTED, start with the s1 granule and keep this patch to fallback to
s2 granule, but without masking the IOVA in smmu_translate() (it will be
masked correctly by smmu_iotlb_lookup_all_levels()).

Thanks,
Jean

> 
> Thanks,
> Mostafa
> 
> > 
> > Thanks,
> > Jean
> > 
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  hw/arm/smmu-common.c | 36 ++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 34 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > > index 21982621c0..0840b5cffd 100644
> > > --- a/hw/arm/smmu-common.c
> > > +++ b/hw/arm/smmu-common.c
> > > @@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> > >      return key;
> > >  }
> > >  
> > > -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > > -                                SMMUTransTableInfo *tt, hwaddr iova)
> > > +static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
> > > +                                                  SMMUTransCfg *cfg,
> > > +                                                  SMMUTransTableInfo *tt,
> > > +                                                  hwaddr iova)
> > >  {
> > >      uint8_t tg = (tt->granule_sz - 10) / 2;
> > >      uint8_t inputsize = 64 - tt->tsz;
> > > @@ -88,6 +90,36 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > >          }
> > >          level++;
> > >      }
> > > +    return entry;
> > > +}
> > > +
> > > +/**
> > > + * smmu_iotlb_lookup - Look up for a TLB entry.
> > > + * @bs: SMMU state which includes the TLB instance
> > > + * @cfg: Configuration of the translation
> > > + * @tt: Translation table info (granule and tsz)
> > > + * @iova: IOVA address to lookup
> > > + *
> > > + * returns a valid entry on success, otherwise NULL.
> > > + * In case of nested translation, tt can be updated to include
> > > + * the granule of the found entry as it might different from
> > > + * the IOVA granule.
> > > + */
> > > +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > > +                                SMMUTransTableInfo *tt, hwaddr iova)
> > > +{
> > > +    SMMUTLBEntry *entry = NULL;
> > > +
> > > +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > > +    /*
> > > +     * For nested translation also try the s2 granule, as the TLB will insert
> > > +     * it if the size of s2 tlb entry was smaller.
> > > +     */
> > > +    if (!entry && (cfg->stage == SMMU_NESTED) &&
> > > +        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
> > > +        tt->granule_sz = cfg->s2cfg.granule_sz;
> > > +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > > +    }
> > >  
> > >      if (entry) {
> > >          cfg->iotlb_hits++;
> > > -- 
> > > 2.45.2.803.g4e1b14247a-goog
> > > 

