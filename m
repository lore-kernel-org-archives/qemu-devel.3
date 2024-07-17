Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A212EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU72z-0005yT-Gg; Wed, 17 Jul 2024 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sU72w-0005td-U0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:58:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sU72u-0004HR-AV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:58:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266fd39527so52707755e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721231902; x=1721836702; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zouCLbYmcFgjAK4qv2JS6bT2SWhM3WRMe4azkl1Evik=;
 b=FvUaBEMtuHkr7XbsRKc4vzzCusIhWNeVDkJxYXhQhnZLy2Udz5Q9jwAVLCL+YKEwum
 LzE3hIB3pPFHlPUlCGjfSJsQxxRRLn8qoMGJ2hWYHrF71qhGmzJOrrqrL2NWyzGmaleI
 kpDGmyBWDVYZgu8rEqV18nPGJ1ST9b44F0eWBxG3Q83/bMlYx8zsRMGf8Hvmp/RG8t8p
 qXHH2xiZLBhRASug5c28o8rvYn3rHG75p+B3loOrvcnXaTrl/wFG2y/aT8OlQNTrMQ7o
 q/QANvRn+8x8tacqiMRM/5QzfbGJHmoBoVKwi6YzNSzZPBJkZc6F/dL+8YDb94GGV2k4
 XC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231902; x=1721836702;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zouCLbYmcFgjAK4qv2JS6bT2SWhM3WRMe4azkl1Evik=;
 b=sInBkES5HVuCLTQ4mI4a4w8s0fHgWRrAqy1iVpEF2Lnj1b1zZVJ+RD39jk+F4PSS7N
 /mykttAo8T5eN7mZ3PaeBht72zv3p2g+NPHKPnxHRkDmop6T+tdLOwl8mxJSNHkfD15J
 u36nwEO9ksoPuwzG0vLTB8Z+SDwMoz3bd/Mi5hty1nJAzwsc+hc2SSrTw66/kO+dBpgy
 ZT2OmZFqXxzi0sUvGd870MjTryFdguXPQe5JY8SirElgEgMM3MRer1siD+DsqVxG1XwX
 GKhjrkhC2kSbExLGXnpbyJ7VwHSsvwei5CMkoop8G7T7pl8Gg+aS1Qb5iaf/wM485Jct
 DHPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSU6WAbZpiNrYuiA+UMGw9eT0mD39aIPMkPVVBXx7inkLRwfoq/8WVdjzzOIBCvdB/R4ytpFpy9uiDOUKMOcsLAzBBvfM=
X-Gm-Message-State: AOJu0Yxu9w2fAxBTYAQ0xc4M+mqwlrgNvgLhcllLnzM1bfkDwKDz2lgh
 yX0JgoY5azexuUIRh0G4TZYpSgK9pyTT8wVettuI8hgjSez3rqJt/pl0Jc/keIo=
X-Google-Smtp-Source: AGHT+IH+Y/IUuU8cJdZrUYcb1gvil/YDFOURR7qNRgqSIEyxRxH6Yz0egIuyQtufE2EoYSpGtJGilg==
X-Received: by 2002:a05:600c:450f:b0:426:5cef:ee41 with SMTP id
 5b1f17b1804b1-427c2d109bemr15220915e9.38.1721231902398; 
 Wed, 17 Jul 2024 08:58:22 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c77b0300sm2801635e9.12.2024.07.17.08.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:58:21 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:58:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com,
 julien@xen.org, richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v5 03/18] hw/arm/smmuv3: Fix encoding of CLASS in events
Message-ID: <20240717155838.GA4073279@myrica>
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240715084519.1189624-4-smostafa@google.com>
 <cb687788-4bf4-4bc1-94e1-5f023b731b9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb687788-4bf4-4bc1-94e1-5f023b731b9c@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Eric,

On Wed, Jul 17, 2024 at 05:07:57PM +0200, Eric Auger wrote:
> Hi Jean,
> 
> On 7/15/24 10:45, Mostafa Saleh wrote:
> > The SMMUv3 spec (ARM IHI 0070 F.b - 7.3 Event records) defines the
> > class of events faults as:
> >
> > CLASS: The class of the operation that caused the fault:
> > - 0b00: CD, CD fetch.
> > - 0b01: TTD, Stage 1 translation table fetch.
> > - 0b10: IN, Input address
> >
> > However, this value was not set and left as 0 which means CD and not
> > IN (0b10).
> >
> > Another problem was that stage-2 class is considered IN not TT for
> > EABT, according to the spec:
> >     Translation of an IPA after successful stage 1 translation (or,
> >     in stage 2-only configuration, an input IPA)
> >     - S2 == 1 (stage 2), CLASS == IN (Input to stage)
> >
> > This would change soon when nested translations are supported.
> >
> > While at it, add an enum for class as it would be used for nesting.
> > However, at the moment stage-1 and stage-2 use the same class values,
> > except for EABT.
> >
> > Fixes: 9bde7f0674 “hw/arm/smmuv3: Implement translate callback”
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3-internal.h | 6 ++++++
> >  hw/arm/smmuv3.c          | 8 +++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> > index e4dd11e1e6..0f3ecec804 100644
> > --- a/hw/arm/smmuv3-internal.h
> > +++ b/hw/arm/smmuv3-internal.h
> > @@ -32,6 +32,12 @@ typedef enum SMMUTranslationStatus {
> >      SMMU_TRANS_SUCCESS,
> >  } SMMUTranslationStatus;
> >  
> > +typedef enum SMMUTranslationClass {
> > +    SMMU_CLASS_CD,
> > +    SMMU_CLASS_TT,
> > +    SMMU_CLASS_IN,
> > +} SMMUTranslationClass;
> > +
> >  /* MMIO Registers */
> >  
> >  REG32(IDR0,                0x0)
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 9dd3ea48e4..3d214c9f57 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -942,7 +942,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >              event.type = SMMU_EVT_F_WALK_EABT;
> >              event.u.f_walk_eabt.addr = addr;
> >              event.u.f_walk_eabt.rnw = flag & 0x1;
> > -            event.u.f_walk_eabt.class = 0x1;
> > +            /* Stage-2 (only) is class IN while stage-1 is class TT */
> > +            event.u.f_walk_eabt.class = (ptw_info.stage == 2) ?
> > +                                         SMMU_CLASS_IN : SMMU_CLASS_TT;
> does it match your expectations. While reading your previous comment I
> have the impression what you had in mind was more complicated than that
> 
> * s2 walk that encounters EABT on S2 descriptor while translating
>   non-descriptor IPA is reported as class=IN, even when doing s2-only.

At this point we only support single-stage, so I believe this is correct:
	"A stage 1-only table walk that encounters EABT ... CLASS == TT"
	"translation of ... in stage 2-only configuration, an input IPA...
	 CLASS == IN"

Later in the series this code changes in order to support nesting, but I
think it's still correct, because the EABT class works similarly to
translation errors, except for stage-1 faults which have CLASS==TT

Thanks,
Jean

> 
> Thanks
> 
> Eric
> 
> >              event.u.f_walk_eabt.addr2 = ptw_info.addr;
> >              break;
> >          case SMMU_PTW_ERR_TRANSLATION:
> > @@ -950,6 +952,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >                  event.type = SMMU_EVT_F_TRANSLATION;
> >                  event.u.f_translation.addr = addr;
> >                  event.u.f_translation.addr2 = ptw_info.addr;
> > +                event.u.f_translation.class = SMMU_CLASS_IN;
> >                  event.u.f_translation.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -958,6 +961,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >                  event.type = SMMU_EVT_F_ADDR_SIZE;
> >                  event.u.f_addr_size.addr = addr;
> >                  event.u.f_addr_size.addr2 = ptw_info.addr;
> > +                event.u.f_translation.class = SMMU_CLASS_IN;
> >                  event.u.f_addr_size.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -966,6 +970,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >                  event.type = SMMU_EVT_F_ACCESS;
> >                  event.u.f_access.addr = addr;
> >                  event.u.f_access.addr2 = ptw_info.addr;
> > +                event.u.f_translation.class = SMMU_CLASS_IN;
> >                  event.u.f_access.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -974,6 +979,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >                  event.type = SMMU_EVT_F_PERMISSION;
> >                  event.u.f_permission.addr = addr;
> >                  event.u.f_permission.addr2 = ptw_info.addr;
> > +                event.u.f_translation.class = SMMU_CLASS_IN;
> >                  event.u.f_permission.rnw = flag & 0x1;
> >              }
> >              break;
> 

