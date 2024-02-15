Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC42FC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rac2d-0000zu-9O; Thu, 15 Feb 2024 08:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rac2c-0000zZ-6y
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:44:42 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rac2a-0000FG-EQ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:44:41 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-563d017696eso132134a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708004679; x=1708609479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J+pOyVfvea9nOtLO0AHVksVXnQlbdm5DYEppBzqpeTk=;
 b=stLz7uWSBmt6IQqZ7QZrl/wbneA6TilVehqfVHOT44yaBAppaMFS2E1D26aSuQFnfm
 en+i8JpF+HDmCqmxSslY3ELvx22mnEKlQcyyXQ825eBLs/0Un+XypS7021I1JdmcvP6y
 NVZC0Ps+7Cdi+blVFc6TZwC3vW+Ehi4YQ8s+U0GlSZ5LZwOoqlhRKg+4dO8//wXRVE0h
 EqQdOkbPe3Cvl/5vBhQow5vq/2WEMsp1yUieQk9W9vLVbbmC+8PC+JjxpMtzs+juu8ap
 vIKgEeo5L7mv4qR1RiPUGtvkNfbeDy0BO04s1rOIXfkSYZzntFMiSHoa9nk0NwlRfMLi
 jSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708004679; x=1708609479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J+pOyVfvea9nOtLO0AHVksVXnQlbdm5DYEppBzqpeTk=;
 b=rOph19+eZMoUJBnO4w7fqrjQRYgkwkOr0zk7Fa8tcHb7EOmCZ6gedUKtQJQoXpjeKU
 ITxEf3X2Wy+tLMoH8HeQS47DezXr/nswK8Z5Q59zVIvhj6KO6qRXqh3k3xq9ZBfZh54/
 gxQTklEaHfh08VkZxFP3jqGgC12DhI9R/R4c3pdEVUjz53DW+Xt1+pNNLjGMJwz5c9Ew
 hvqqwZnTir/fMwL0q2ftRLLkBrwyKnL37ScgLoUEkQjrXnZPyvW6AVbT+1EAWKizzJeT
 JbBjked1GfdfID+rvxxAryfgrYA16CTeDUbgAhyDHuPjDDBzV8ZxStvGeW+UOoKQ4VJc
 DEnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsB8K+lg2ltnJXFO1G8Bmne5fTPK/vZCIrhpfOqbTTIdL8Km4LbISh0z7erw6xBcergIx0OlculvZvSsY2SzbUIUtUsUM=
X-Gm-Message-State: AOJu0YxlqlIB0GQxiRrXpcsyJAmLkauMaBbeSAUYjAtusnjnOySLtr4E
 v7PIsnqFnLPrj8c59BBzS/vvzr8bI9GkJQnFnMKTPu4lBwrus0lv5cuMMH+5Askb9/O1Q+auJQc
 3UcupwBP9pngn8dNA/kmeYmg66hDIlPTBnCeDjQ==
X-Google-Smtp-Source: AGHT+IG0+NfNhBiEoDxAZKksXvV6Kwl4I/8mYt1ZQGqzK6uy+Q2ukZNXX/ljaCQ8mXarg2oSYgafoVMkndK1Xlb+k8M=
X-Received: by 2002:a05:6402:148d:b0:561:dd88:efde with SMTP id
 e13-20020a056402148d00b00561dd88efdemr1461459edv.27.1708004678831; Thu, 15
 Feb 2024 05:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20240213082211.3330400-1-luc.michel@amd.com>
 <522cfa0b-050a-4a93-acf5-62dfe71c8185@redhat.com>
In-Reply-To: <522cfa0b-050a-4a93-acf5-62dfe71c8185@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 13:44:27 +0000
Message-ID: <CAFEAcA-Xifh-ST9b+zRcN1a3yg4-ScmMW5LqV3Gm3iUZsdUNsQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/smmuv3: add support for stage 1 access fault
To: eric.auger@redhat.com
Cc: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Feb 2024 at 07:22, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Luc,
> On 2/13/24 09:22, Luc Michel wrote:
> > An access fault is raised when the Access Flag is not set in the
> > looked-up PTE and the AFFD field is not set in the corresponding context
> > descriptor. This was already implemented for stage 2. Implement it for
> > stage 1 as well.
> >
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > ---
> >
> > v2: drop erroneous submodule modification
> >
> > ---
> >
> >  hw/arm/smmuv3-internal.h     |  1 +
> >  include/hw/arm/smmu-common.h |  1 +
> >  hw/arm/smmu-common.c         | 10 ++++++++++
> >  hw/arm/smmuv3.c              |  1 +
> >  4 files changed, 13 insertions(+)
> >
> > diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> > index e987bc4686b..e4dd11e1e62 100644
> > --- a/hw/arm/smmuv3-internal.h
> > +++ b/hw/arm/smmuv3-internal.h
> > @@ -622,10 +622,11 @@ static inline int pa_range(STE *ste)
> >  #define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
> >  #define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
> >  #define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
> >  #define CD_ENDI(x)       extract32((x)->word[0], 15, 1)
> >  #define CD_IPS(x)        extract32((x)->word[1], 0 , 3)
> > +#define CD_AFFD(x)       extract32((x)->word[1], 3 , 1)
> >  #define CD_TBI(x)        extract32((x)->word[1], 6 , 2)
> >  #define CD_HD(x)         extract32((x)->word[1], 10 , 1)
> >  #define CD_HA(x)         extract32((x)->word[1], 11 , 1)
> >  #define CD_S(x)          extract32((x)->word[1], 12, 1)
> >  #define CD_R(x)          extract32((x)->word[1], 13, 1)
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index fd8d772da11..5ec2e6c1a43 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -90,10 +90,11 @@ typedef struct SMMUTransCfg {
> >      /* Shared fields between stage-1 and stage-2. */
> >      int stage;                 /* translation stage */
> >      bool disabled;             /* smmu is disabled */
> >      bool bypassed;             /* translation is bypassed */
> >      bool aborted;              /* translation is aborted */
> > +    bool affd;                 /* AF fault disable */
> >      uint32_t iotlb_hits;       /* counts IOTLB hits */
> >      uint32_t iotlb_misses;     /* counts IOTLB misses*/
> >      /* Used by stage-1 only. */
> >      bool aa64;                 /* arch64 or aarch32 translation table */
> >      bool record_faults;        /* record fault events */
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 9a8ac45431a..09ff72e55f5 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -362,10 +362,20 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >                                          &block_size);
> >              trace_smmu_ptw_block_pte(stage, level, baseaddr,
> >                                       pte_addr, pte, iova, gpa,
> >                                       block_size >> 20);
> >          }
> > +
> > +        /*
> > +         * If AFFD and PTE.AF are 0 => fault. (5.4. Context Descriptor)
> > +         * An Access fault takes priority over a Permission fault.
> nit: you may precise that this holds because HTTU is not currently supported
> > +         */

I tweaked this comment text to read

+         * QEMU does not currently implement HTTU, so if AFFD and PTE.AF
+         * are 0 we take an Access flag fault. (5.4. Context Descriptor)
+         * An Access flag fault takes priority over a Permission fault.

and have applied the patch to target-arm.next, thanks.

-- PMM

