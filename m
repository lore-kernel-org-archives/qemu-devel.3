Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5352C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cKm-00073m-0Y; Thu, 16 May 2024 10:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s7cKi-00072p-Gv
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:43:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s7cKg-0001v5-IA
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:43:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41fef5dda72so411555e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 07:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715870624; x=1716475424; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NWkcSf/8im92H27wvNg3Z2ek6JT78ooJ7tgguzoBa8Q=;
 b=FFGD0Godq1fWDh1oXrZZKbr16T674AG1eLVKQOxLlkhQ5l1sn6TgjLo2wRug2IMSac
 /+DNK3ASNO9ccwItdIlR6XD7m0sI7ejjyzwStoUKfs6pVtSwQ05wx9uoeMMsleHY+Vpk
 D7iYfD6PO9a50AHZv2YrrrtQyzz41NIYc1BWZ+KO2MvM2G2gLc20syp2Wx1hV0MVPQia
 jdK6IS8NfSnboA3yC+VdTgzeMuBuhz3vQjbna3ezc/jrd1oW1Eh1wZiGyWY2660Uk5va
 GSd0g47O6eov5/q9/79oP5npEbMrV9jxXLDGbDg3h9CQycPw0l4aF7SfqVlUxWo93Uhm
 xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715870624; x=1716475424;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWkcSf/8im92H27wvNg3Z2ek6JT78ooJ7tgguzoBa8Q=;
 b=lbofRHcs6mXuEp/WzbrXjAdbSTX+z5vFyA8Z3Me2dFA0eMhAyrilGMUwLOSfbwc+hR
 Ps22g2gJFb6z5w2bKjXhI9G6s5+EqmWiOtTuEJp+Zdjzx4traBtppMHrCPLa5daQ9KwB
 Z3wYSEsQubfwvb4B+0b7rD5T0q/Wh79ZLB+5hVWgKB3hzNpqgEjEHSmyQQvK4wx/CNqv
 xw4rPufKh6ln/mYKLbQNiXXDRHtjU+uVQ5tU5x64gy2JIR7RDyWZ5NYkACZNPMZeO6fz
 /YEw2u7W+Jzye5eoYCw3i8t93ESWOCnXa4mDTEu5eeqnihLVP9jBG1vAx2BBRwPQ8Q/i
 q0jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXDY1mGR3xDcgvrw4DCRATUOQ/ICpp/w9YABiPx21EWL+32JkDIKGTgGIostb61RxuSoeL0/HXEHrxu3OfIQ9mBSdk134=
X-Gm-Message-State: AOJu0YxvUTjMo5LjTvXGZaI+mhelBCcNqimI3tL1af5gWxphiuhuCEbh
 W9CIqPcfl1ZXrMnuVla7TBU0JEcz4trmwC/6dZ0R4bTpixEOxEaYgXSKZNvoQQ==
X-Google-Smtp-Source: AGHT+IFRYVanbhYW8BmcC3n1FeDtASd2iWzN0nlBA6T7Qhfh4hbQq7qbD603QECiovVm3qK2FP+BKg==
X-Received: by 2002:a05:600c:a4a:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-4200ee37a4cmr11750855e9.4.1715870623671; 
 Thu, 16 May 2024 07:43:43 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fe004eae9sm257098935e9.1.2024.05.16.07.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 07:43:43 -0700 (PDT)
Date: Thu, 16 May 2024 14:43:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 02/18] hw/arm/smmu: Fix IPA for stage-2 events
Message-ID: <ZkYbm91fd0Flwo2r@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-3-smostafa@google.com>
 <4161c29f-411c-480e-abca-84e8963ce0ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4161c29f-411c-480e-abca-84e8963ce0ab@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=smostafa@google.com; helo=mail-wm1-x330.google.com
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

On Mon, May 13, 2024 at 01:47:44PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > For the following events (ARM IHI 0070 F.b - 7.3 Event records):
> > - F_TRANSLATION
> > - F_ACCESS
> > - F_PERMISSION
> > - F_ADDR_SIZE
> >
> > If fault occurs at stage 2, S2 == 1 and:
> >   - If translating an IPA for a transaction (whether by input to
> >     stage 2-only configuration, or after successful stage 1 translation),
> >     CLASS == IN, and IPA is provided.
> CLASS == IN sounds a bit confusing here since the class value depends on
> what is being translated and class is not handled in that patch.
At this point only CLASS IN is used as nesting is not supported,
I will clarify that in the commit message.

> >
> > However, this was not implemented correctly, as for stage 2, we Qemu
> s/we QEMU/ the code
Will do.

> > only sets the  S2 bit but not the IPA.
> If this is a fix, please add the "Fixes:" tag and fixed commit sha1.
Will do.

> >
> > This field has the same bits as FetchAddr in F_WALK_EABT which is
> > populated correctly, so we don’t change that.
> > The population of this field should be done from the walker as the IPA address
> s/population/setting? I am not a native english speaker though
Me neither :), I will change it.

Thanks,
Mostafa
> > wouldn't be known in case of nesting.
> >
> > For stage 1, the spec says:
> >   If fault occurs at stage 1, S2 == 0 and:
> >   CLASS == IN, IPA is UNKNOWN.
> >
> > So, no need to set it to for stage 1, as ptw_info is initialised by zero in
> > smmuv3_translate().
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c | 10 ++++++----
> >  hw/arm/smmuv3.c      |  4 ++++
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index eb2356bc35..8a8c718e6b 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -448,7 +448,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
> >       */
> >      if (ipa >= (1ULL << inputsize)) {
> >          info->type = SMMU_PTW_ERR_TRANSLATION;
> > -        goto error;
> > +        goto error_ipa;
> >      }
> >  
> >      while (level < VMSA_LEVELS) {
> > @@ -494,13 +494,13 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
> >           */
> >          if (!PTE_AF(pte) && !cfg->s2cfg.affd) {
> >              info->type = SMMU_PTW_ERR_ACCESS;
> > -            goto error;
> > +            goto error_ipa;
> >          }
> >  
> >          s2ap = PTE_AP(pte);
> >          if (is_permission_fault_s2(s2ap, perm)) {
> >              info->type = SMMU_PTW_ERR_PERMISSION;
> > -            goto error;
> > +            goto error_ipa;
> >          }
> >  
> >          /*
> > @@ -509,7 +509,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
> >           */
> >          if (gpa >= (1ULL << cfg->s2cfg.eff_ps)) {
> >              info->type = SMMU_PTW_ERR_ADDR_SIZE;
> > -            goto error;
> > +            goto error_ipa;
> >          }
> >  
> >          tlbe->entry.translated_addr = gpa;
> > @@ -522,6 +522,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
> >      }
> >      info->type = SMMU_PTW_ERR_TRANSLATION;
> >  
> > +error_ipa:
> > +    info->addr = ipa;
> >  error:
> >      info->stage = 2;
> >      tlbe->entry.perm = IOMMU_NONE;
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 2d1e0d55ec..9dd3ea48e4 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -949,6 +949,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >              if (PTW_RECORD_FAULT(cfg)) {
> >                  event.type = SMMU_EVT_F_TRANSLATION;
> >                  event.u.f_translation.addr = addr;
> > +                event.u.f_translation.addr2 = ptw_info.addr;
> >                  event.u.f_translation.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -956,6 +957,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >              if (PTW_RECORD_FAULT(cfg)) {
> >                  event.type = SMMU_EVT_F_ADDR_SIZE;
> >                  event.u.f_addr_size.addr = addr;
> > +                event.u.f_addr_size.addr2 = ptw_info.addr;
> >                  event.u.f_addr_size.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -963,6 +965,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >              if (PTW_RECORD_FAULT(cfg)) {
> >                  event.type = SMMU_EVT_F_ACCESS;
> >                  event.u.f_access.addr = addr;
> > +                event.u.f_access.addr2 = ptw_info.addr;
> >                  event.u.f_access.rnw = flag & 0x1;
> >              }
> >              break;
> > @@ -970,6 +973,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >              if (PTW_RECORD_FAULT(cfg)) {
> >                  event.type = SMMU_EVT_F_PERMISSION;
> >                  event.u.f_permission.addr = addr;
> > +                event.u.f_permission.addr2 = ptw_info.addr;
> >                  event.u.f_permission.rnw = flag & 0x1;
> >              }
> >              break;
> >
> After taking into account above comments,
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 

