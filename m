Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F39C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4zl-0001JQ-Hc; Tue, 09 Jul 2024 03:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR4zk-0001Ie-2P
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:10:36 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR4zZ-0000Ki-Qw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:10:35 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51ab3715d46so1072e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720509023; x=1721113823; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y8vgJfXVho0VbUzceXepsNZ+mEZe0DdY5f/omIsH+xU=;
 b=QCYWNhg2zVEFEputkx3ANCUpbTG20FMHe9CXIkdOyqlBIyUmWpZxSvZcOYJHfmxEk0
 wEwtg7MLXbBup75KfMlv9GxjDyo7w4dj0BXIPhqbEsPI2xPvu5Nvg05af3iQhNcMEE5d
 IHdQooApyN+Ap8kEhCOCYsB9gOh041ZBREVpkQaISR+C1w2n4EHssK096Arhf3Nq0IGz
 c2G5L2YhvBOiHh2Xvzrcw9nVdV60KXvCjSlhTlve5zlWdPH3hoLLc/g+8g/JWOBE8ZrO
 D3Gx1b+JbXHonnJ1yNy3JxmHYl0SBEt4U2rhrR4SJOdqGyLSP+VK2FYRL9PAHNwL4and
 lFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509023; x=1721113823;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8vgJfXVho0VbUzceXepsNZ+mEZe0DdY5f/omIsH+xU=;
 b=bP4zj6+GVpGy2sbHFI7jT7uCQAhda3mvDSAT8xI9iu0d11drYV2/eTp4PCmxDugRzj
 pqHwFS9rv5raanDI0dt8V4GYUAhjiXBtyJg0VA2h3mJkgvIjd7ylCBGmYa30o5tdXfBK
 H215R33KUpiJQnioW3/+H+zhm32zmrUkhnCCTNt3RY/67xMxGL6BvtFSu62PCf3NwwQc
 AhjR4X7dH8zbiL60tEii3aEELuXY33jeyL+8SIqtD5sDe2ARujTGcGib7SyFHSGKj9iI
 d5e8GMtAdoGe6tDzDXe3O02uN4AKI+aChmT67F9z0f4nJYFOS2gjjNx4G6GNKgDird07
 6lHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV72Glit+/Yl5Kb9flx9H4IR+HclvYQO0Jr7yHXNJgaAJUEwrvZ4x0ExR30R7TLuxeldX9yJccVlECfDLxVEUrzgzew9Zc=
X-Gm-Message-State: AOJu0YyvubnNnDWiPZFx24H1+XfOkvSRZFwdaWd7GR2a07S17hUTZ8Ln
 yT0Qubal9yZVVPuPyeJBOOkTiDv/5q3s2JguHcnOhgoG19tz9a4ftcJuK94drIyQeyGiTfyi/Mb
 zVg==
X-Google-Smtp-Source: AGHT+IFHb9DcF9zXH7hFJ7v22SS/9vv0LLX29yu/h9ZLyyoX9HO+ZVc5jNVMsNQ8Rf2aKLi2YeijKg==
X-Received: by 2002:a05:6512:3048:b0:52e:7b72:4f3c with SMTP id
 2adb3069b0e04-52eb9a04ebemr92955e87.6.1720509022672; 
 Tue, 09 Jul 2024 00:10:22 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa0613sm1640045f8f.88.2024.07.09.00.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:10:22 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:10:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 03/19] hw/arm/smmuv3: Fix encoding of CLASS in events
Message-ID: <ZoziWlJTCvAWmHXN@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-4-smostafa@google.com>
 <20240704180200.GC1693268@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704180200.GC1693268@myrica>
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=smostafa@google.com; helo=mail-lf1-x12a.google.com
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

On Thu, Jul 04, 2024 at 07:02:00PM +0100, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:25AM +0000, Mostafa Saleh wrote:
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
> > While at it, add an enum for class as it would be used for nesting.
> > However, at the moment stage-1 and stage-2 use the same class values.
> > 
> > Fixes: 9bde7f0674 “hw/arm/smmuv3: Implement translate callback”
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3-internal.h | 6 ++++++
> >  hw/arm/smmuv3.c          | 6 +++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
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
> > index 9dd3ea48e4..1eb5b160d2 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -942,7 +942,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >              event.type = SMMU_EVT_F_WALK_EABT;
> >              event.u.f_walk_eabt.addr = addr;
> >              event.u.f_walk_eabt.rnw = flag & 0x1;
> > -            event.u.f_walk_eabt.class = 0x1;
> > +            event.u.f_walk_eabt.class = SMMU_CLASS_TT;
> 
> For EABT I think we have to differentiate S1/S2:
> 
> * s1-only walk that encounters EABT on S1 descriptor access is reported as
>   class=TT, 
> * s2 walk that encounters EABT on S2 descriptor while translating
>   non-descriptor IPA is reported as class=IN, even when doing s2-only.
> 
> Maybe it can be done in the later patch where you propagate the different
> classes, because it's a minor detail.

Thanks, for pointing it out. It is a bit tricky, for s2 only we need
class = IN which is easy.
But for nested, if we get a fault with s2 == 1 and EABT, we need to know
if it’s from:
- Translation of a s1 table IPA (translate_table_addr_ipa) as class => TT
- Access for s2 table as class = IN

We might need a new member in SMMUPTWEventInfo to distinguish this as
bool is_ipa_descriptor

Thanks,
Mostafa

> 
> Thanks,
> Jean
> 
> >              event.u.f_walk_eabt.addr2 = ptw_info.addr;
> >              break;
> >          case SMMU_PTW_ERR_TRANSLATION:
> > @@ -950,6 +950,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >                  event.type = SMMU_EVT_F_TRANSLATION;
> >                  event.u.f_translation.addr = addr;
> >                  event.u.f_translation.addr2 = ptw_info.addr;
> > +                event.u.f_translation.class = SMMU_CLASS_IN;
> >                  event.u.f_translation.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -958,6 +959,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >                  event.type = SMMU_EVT_F_ADDR_SIZE;
> >                  event.u.f_addr_size.addr = addr;
> >                  event.u.f_addr_size.addr2 = ptw_info.addr;
> > +                event.u.f_translation.class = SMMU_CLASS_IN;
> >                  event.u.f_addr_size.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -966,6 +968,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >                  event.type = SMMU_EVT_F_ACCESS;
> >                  event.u.f_access.addr = addr;
> >                  event.u.f_access.addr2 = ptw_info.addr;
> > +                event.u.f_translation.class = SMMU_CLASS_IN;
> >                  event.u.f_access.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -974,6 +977,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >                  event.type = SMMU_EVT_F_PERMISSION;
> >                  event.u.f_permission.addr = addr;
> >                  event.u.f_permission.addr2 = ptw_info.addr;
> > +                event.u.f_translation.class = SMMU_CLASS_IN;
> >                  event.u.f_permission.rnw = flag & 0x1;
> >              }
> >              break;
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 

