Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77254C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMne5-0007gi-P8; Thu, 27 Jun 2024 07:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sMne3-0007fo-OX
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:50:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sMndw-0004al-7G
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:50:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4255f915611so47565e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719489022; x=1720093822; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e9P6rSk8vf64hp/l6OI3SI/PjxibwZs4WejYppaOX6Q=;
 b=YyRnTNfDTJHiu1jUrMVqbIKrDLCwazlh3m8pf/vfqd6D8VSiewnwoNKne5PJ8/lEwV
 GVCYgtBrqEn/ImRO7wxGgFH59fad7FJcKxh2+Oe1XulNHs6OhJLCDB1QiYSN2ZQ05cLa
 1U+XVkuxgGaUN34m+z3K1ki9cfNm3MvMaDQOEh/cvMQ4G2n0oB9Tb6vlyOH69Ox+Yk2m
 i7HxhnIp3wNJ+xE4LdiUvsK4hP8lZ78it5EB1/aZG66dljIPqVzk+PVsUG1Xlqdfh8Pe
 TGRb8qKp+VAC4d3Cil7FZm8Zad3P5PR6yfbjtlFUic4hpf+BtB30vmMqUnyI0ubTKD1T
 lfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719489022; x=1720093822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9P6rSk8vf64hp/l6OI3SI/PjxibwZs4WejYppaOX6Q=;
 b=sGGJGvMuYmiZ472DiBdp0c46xio9d7l57oO/RVj7HEpSKq7kyc0YC8qqvvTcDelppj
 EsAcz1cqFV+802BqU+so9HfqzA5OmVhCVbHhmBeYuDGyMdUJy6nV7jfkkTULLipRqgFK
 xkA/JdTRaNQHNTMM3yrUVzmb4XAsTAOZltm1C9l3AINNvcH9i9RGHeM+w1IOP0y3PYTf
 RdIICmS55aY2MAdmiSAy4jUjB6+tDRssdiI6Rk9VBywQsg1dnltnFbmnGodgZywq7jqS
 Yxx6HTqXzt9ehXO8T7WXlUMIglhoYZTebzmvpJUnAH0k1SJy1aGQOfBEdrx+Gz+SJ6s8
 q6lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuSZydwtcn01/TQ/yXbRCfw9MR3B9DDXfOxfq+swQieN+R6tzqzkWJ7tZ9fmzz5MPcA/i5G21bcMbheN4fcxJ0ltGNe9I=
X-Gm-Message-State: AOJu0Yw+MXzsX80AtPB3CmHzZzlkLPED77lx41EN6ZRwB1ctGFqAaQyL
 KlD6byIZm7brqOAXcOuCw7vY+clXOnb5x4bKc0s8UyHTNsx+5bkXNZOEUC/PtA==
X-Google-Smtp-Source: AGHT+IHF2+OWLkDVOlVs+eamxkFdARYG2bMOTEh+jiXREdWWJJJgTOLPwU4rS5i1HLRx+QKS9xzVFw==
X-Received: by 2002:a05:600c:3ba9:b0:424:891e:a9fe with SMTP id
 5b1f17b1804b1-425641c24c3mr1459555e9.1.1719489021028; 
 Thu, 27 Jun 2024 04:50:21 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c82462a2sm63024555e9.2.2024.06.27.04.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 04:50:20 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:50:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 17/18] hw/arm/smmuv3: Add property for OAS
Message-ID: <Zn1R-BwOnSRpstw2@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-18-smostafa@google.com>
 <689f6ac7-86ce-482f-a59a-fd17f8a5216d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689f6ac7-86ce-482f-a59a-fd17f8a5216d@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
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

On Tue, May 21, 2024 at 11:32:48AM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/29/24 05:24, Mostafa Saleh wrote:
> > Add property that sets the OAS of the SMMU, this in not used in this
> > patch.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3-internal.h |  3 ++-
> >  hw/arm/smmuv3.c          | 29 ++++++++++++++++++++++++++++-
> >  include/hw/arm/smmuv3.h  |  1 +
> >  3 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> > index 0ebf2eebcf..dd91807624 100644
> > --- a/hw/arm/smmuv3-internal.h
> > +++ b/hw/arm/smmuv3-internal.h
> > @@ -111,7 +111,8 @@ REG32(IDR5,                0x14)
> >       FIELD(IDR5, VAX,        10, 2);
> >       FIELD(IDR5, STALL_MAX,  16, 16);
> >  
> > -#define SMMU_IDR5_OAS 4
> > +#define SMMU_IDR5_OAS_DEF 4 /* 44 bits. */
> > +#define SMMU_IDR5_OAS_MAX 5 /* 48 bits. */
> >  
> >  REG32(IIDR,                0x18)
> >  REG32(AIDR,                0x1c)
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 4ac818cf7a..39d03e7e24 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -299,7 +299,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
> >      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
> >      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
> >  
> > -    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
> > +    /* PTW doesn't support 52 bits. */
> remove the point
> > +    s->oas = MIN(s->oas, SMMU_IDR5_OAS_MAX);
> > +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, s->oas);
> >      /* 4K, 16K and 64K granule support */
> >      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
> >      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
> > @@ -1901,11 +1903,34 @@ static const VMStateDescription vmstate_gbpa = {
> >      }
> >  };
> >  
> > +static const VMStateDescription vmstate_oas = {
> > +    .name = "smmuv3/oas",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> don't you need a .needed function?
> 
> I tested backward migration and this fails
> qemu-system-aarch64: error while loading state for instance 0x0 of
> device 'smmuv3'
> qemu-system-aarch64: load of migration failed: No such file or directory
> post-processing ...

Yes, I think we need a .needed which returns if oas is not as default,
that should be backward compatiable (at least for this patch) and would
break when oas changes.

Thanks,
Mostafa
> 
> Thanks
> 
> Eric
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_INT32(oas, SMMUv3State),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static int smmuv3_preload(void *opaque)
> > +{
> > +    SMMUv3State *s = opaque;
> > +
> > +    /*
> > +     * In case it wasn't migrated, use the value used
> > +     * by older QEMU.
> > +     */
> > +    s->oas = SMMU_IDR5_OAS_DEF;
> > +    return 0;
> > +}
> > +
> >  static const VMStateDescription vmstate_smmuv3 = {
> >      .name = "smmuv3",
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .priority = MIG_PRI_IOMMU,
> > +    .pre_load = smmuv3_preload,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_UINT32(features, SMMUv3State),
> >          VMSTATE_UINT8(sid_size, SMMUv3State),
> > @@ -1933,6 +1958,7 @@ static const VMStateDescription vmstate_smmuv3 = {
> >      },
> >      .subsections = (const VMStateDescription * const []) {
> >          &vmstate_gbpa,
> > +        &vmstate_oas,
> >          NULL
> >      }
> >  };
> > @@ -1945,6 +1971,7 @@ static Property smmuv3_properties[] = {
> >       * Defaults to stage 1
> >       */
> >      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> > +    DEFINE_PROP_INT32("oas", SMMUv3State, oas, SMMU_IDR5_OAS_DEF),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >  
> > diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> > index d183a62766..00a9eb4467 100644
> > --- a/include/hw/arm/smmuv3.h
> > +++ b/include/hw/arm/smmuv3.h
> > @@ -63,6 +63,7 @@ struct SMMUv3State {
> >      qemu_irq     irq[4];
> >      QemuMutex mutex;
> >      char *stage;
> > +    int32_t oas;
> >  };
> >  
> >  typedef enum {
> 

