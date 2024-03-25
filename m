Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551EEC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 20:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rorE8-0005ep-4e; Mon, 25 Mar 2024 16:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rorE6-0005eT-Kp
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:47:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rorE4-0006i5-RY
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 16:47:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-413f8c8192eso6385e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711399642; x=1712004442; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KzzT5/g7h3BtKN08HVpS/NBgjLGvcyxBh480N/I/y6A=;
 b=g2OqSKHjkwXh1bjY4Y51H/FiIedEg9YoKxVxvPIYYz5tH/ldrYs+8TbAc50bvYz6ZE
 1DT4vMzXtahv+JsJolmE7UEW7270yhO+KxrDiETTuMh9mlc55Jb8bzXl1AeryNuTn4eD
 vzDim/sXNdINJaNDtJW0fjvkr++eL3KEhIy+HCqcNqDrXv0GxfFf6JNk7I2CfV1ABik5
 GOSfcT7UhGYfh6ihyl0Olp+3RX6WFSLC1Ypv4wI8ANsU0qGI1doT3rEqsjnkTV/PMX6m
 9XEER0TtNm3QJHHsLeyO1DI22y4rcGnPpot9ZNYdm4z4ao5bSl4SQkBngXkBcuW/zC+r
 /v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711399642; x=1712004442;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KzzT5/g7h3BtKN08HVpS/NBgjLGvcyxBh480N/I/y6A=;
 b=GEwHT8/f6nagiMeerYgWVVGgXpSO/I4DZbCA/YFlgck1XBkR7Y3BUyUi5EQJTNS3E/
 2k8bKBpYWX4FHsDFx/qbAb7JxjgvMAw8AtACi4fLaKTNFS5A5D/SJPlmd9hgPRx2XO4s
 zXycwyNrQ7hUjoDh5S2P5/qK2leCeRBDvWRnZ+Cpq7xD4moDRhLg1j78lbauUcJYM0C2
 0TUsvWuzb5/rf72yoAFiQTvtRfyILlKFWcybDvzass1F1zPRbieeW2i6wkJRyYGgBXry
 o6TgGFuTzeYtLn4VP2hve+FLTZiwu8vvWYoYuukzAPp4iVsC5XP9Pb7ysC3Rvf3IkeF9
 01Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVchKNEg0CIYsK7+hs+IDwPr8ga7C7uSyxkLqHhTGw8rF3b/O15n8mukiaM7BTehBMIvZlTdAvsv6mCw1f6phklSiNiyUo=
X-Gm-Message-State: AOJu0Yx3ON5iDXnnt480UWs/J0icoL7JCZqcAOFDMu91+cExgTCCurS/
 1cLYXh29U0Iwsj5WJVD3bWEPTI6K6j0J9w7XscHZfG28MVCseSJHXSVHmF8f3Q==
X-Google-Smtp-Source: AGHT+IFX0D1hkRYCJNUuU0gq4lc3j5XsVVwR7qg72xtqIYu/WkP/8t8GeqC2aDlNPKDtdVU3DvlO/Q==
X-Received: by 2002:a05:600c:3793:b0:414:7f46:95f with SMTP id
 o19-20020a05600c379300b004147f46095fmr11078wmr.5.1711399642503; 
 Mon, 25 Mar 2024 13:47:22 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 d9-20020a05600c3ac900b004148dee09afsm119163wms.14.2024.03.25.13.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 13:47:22 -0700 (PDT)
Date: Mon, 25 Mar 2024 20:47:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Julien Grall <julien@xen.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, jean-philippe@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com
Subject: Re: [RFC PATCH 07/12] hw/arm/smmu-common: Support nested translation
Message-ID: <ZgHi1s3RCayh6uyp@google.com>
References: <20240325101442.1306300-1-smostafa@google.com>
 <20240325101442.1306300-8-smostafa@google.com>
 <bd24dc1a-d474-4cc7-87f9-2d5059a19602@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd24dc1a-d474-4cc7-87f9-2d5059a19602@xen.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=smostafa@google.com; helo=mail-wm1-x332.google.com
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

Hi Julien,

On Mon, Mar 25, 2024 at 02:20:07PM +0000, Julien Grall wrote:
> Hi Mostafa,
> 
> On 25/03/2024 10:14, Mostafa Saleh wrote:
> > @@ -524,7 +551,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
> >           tlbe->entry.translated_addr = gpa;
> >           tlbe->entry.iova = ipa & ~mask;
> >           tlbe->entry.addr_mask = mask;
> > -        tlbe->entry.perm = s2ap;
> > +        tlbe->parent_perm = tlbe->entry.perm = s2ap;
> >           tlbe->level = level;
> >           tlbe->granule = granule_sz;
> >           return 0;
> > @@ -537,6 +564,35 @@ error:
> >       return -EINVAL;
> >   }
> > +/* Combine 2 TLB enteries and return in tlbe. */
> > +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> > +                        dma_addr_t iova, SMMUTransCfg *cfg)
> > +{
> > +        if (cfg->stage == SMMU_NESTED) {
> > +
> > +            /*
> > +             * tg and level are used from stage-1, while the addr mask can be
> With the current approach, I can't boot a guest if I create a dummy stage-1
> using 512GB mapping and a stage-2 using 2MB mapping. It looks like this is
> because the level will be used during the TLB lookup.

Agh, I guess that case is’t common with Linux.

I was able to reproduce it with a hacked Linux driver, and the issue
happens in smmu_iotlb_lookup() because it assumes the cached entry has
a mask matching level and granularity, which is not correct with
nesting and I missed it, and fixing the mask is not enough here.

Looking at the mask of the found entry, not good also, if there is
disparity between stage-1 and stage-2 levels we always miss in TLB
even for the same address.

> 
> I managed to solve the issue by using the max level of the two stages. I
> think we may need to do a minimum for the granule.
> 

Just fixing the granularity and level, will alway miss in TLB if they
are different as granularity is used in lookup, I guess one way is to
fall back for stage-2 granularity in lookup if stage-1 lookup fails,
I will have another look and see if there is a better solution for v2.

But for now as you mentioned (also we need update the IOVA to match
the mask), that just should at least work:

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index ef5edfe4dc..ac2dc3efeb 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -572,21 +572,13 @@ static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
                         dma_addr_t iova, SMMUTransCfg *cfg)
 {
         if (cfg->stage == SMMU_NESTED) {
-
-            /*
-             * tg and level are used from stage-1, while the addr mask can be
-             * smaller in case stage-2 size(based on granule and level) was
-             * smaller than stage-1.
-             * That should have no impact on:
-             * - lookup: as iova is properly aligned with the stage-1 level and
-             *   granule.
-             * - Invalidation: as it uses the entry mask.
-             */
             tlbe->entry.addr_mask = MIN(tlbe->entry.addr_mask,
                                         tlbe_s2->entry.addr_mask);
             tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
                                           tlbe->entry.translated_addr);
-
+            tlbe->granule = MIN(tlbe->granule, tlbe_s2->granule);
+            tlbe->level = MAX(tlbe->level, tlbe_s2->level);
+            tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
             /* parent_perm has s2 perm while perm has s1 perm. */
             tlbe->parent_perm = tlbe_s2->entry.perm;

> 
> > +             * smaller in case stage-2 size(based on granule and level) was
> > +             * smaller than stage-1.
> > +             * That should have no impact on:
> > +             * - lookup: as iova is properly aligned with the stage-1 level and
> > +             *   granule.
> > +             * - Invalidation: as it uses the entry mask.
> > +             */
> > +            tlbe->entry.addr_mask = MIN(tlbe->entry.addr_mask,
> > +                                        tlbe_s2->entry.addr_mask);
> > +            tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
> > +                                          tlbe->entry.translated_addr);
> > +
> > +            /* parent_perm has s2 perm while perm has s1 perm. */
> > +            tlbe->parent_perm = tlbe_s2->entry.perm;
> > +            return;
> > +        }
> > +
> > +        /* That was not nested, use the s2. */
> > +        memcpy(tlbe, tlbe_s2, sizeof(*tlbe));
> > +}
> 
> Cheers,
> 
> -- 
> Julien Grall

Thanks,
Mostafa


