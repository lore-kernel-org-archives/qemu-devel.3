Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C550CC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7d3l-0008UK-0z; Thu, 16 May 2024 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s7d3f-0008SO-7E
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:30:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s7d3Z-000677-02
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:30:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42012c85e61so392915e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715873406; x=1716478206; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jinLSx1Bi957v0doVAhmp1h/kFD3OvDhTl6ISPr3gNU=;
 b=YRVvo/9o13CpFo314jX3S73dnGK4iE1wpamurgJsqS45/b77m3LWS7PQo0yISA3W5J
 MAKzpF5u4TrW9qW5nO2RXp7jUOdv74p90lQKGgby7w7lmwNOTXCze+UqqXomqt/IC25H
 UFx3sg7g8gw8HW49xQlZ7ubeFQ4vlSNr2+yJmrLnRho46Fw5KeO2dvfzyszitST4L8iX
 kJXRQY72SBH15OLy5Ko1uaMfMFAHAUtz74V9xSN2sMcAREpU1OdvU4vn+WZCAX7GtKnc
 /ZA/MtSm8KbvKcDMmbe7UiWqRk4wz/8m51izjvV/LcF9xu47QxevKTIBY9i7cJJRxK+P
 FG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715873406; x=1716478206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jinLSx1Bi957v0doVAhmp1h/kFD3OvDhTl6ISPr3gNU=;
 b=KLUyZqonldS/RvSNyrjMKDHKkhWGEMXB/BzgnuzpW1CmSFXqdU5VxuqTouT/k5YDU4
 pr1rbo3MnH5JFBvjOCetxOlSmWA8G704iw4j01M31x6Z0LvvuVa+y/YwG+LqpaYmJ3o3
 tp8JU7Tf+dcGxPd0dc+oRWP36QqrNno/ApqiOMs3rKQrzsrxHVOjekq3PJN5XHWXxFKk
 ErsfMSfO7OEz475xs3QkkfX9YyUnwhrV89q71aLjsaknfQg6jQM0iwwj54SVwYZVBGLN
 rEceqIEGdu+iJVWzqtnkfNoDqr60tndPA8xy9MxLzfffkeWoI9MRtVq19/xoxAiNANtv
 IgjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGSon5bHImKphbIj41szi1CKFBhaXLM9RKQHdmLvcrv6vKeqM3uWgpBHbZoWQwiHzfvffew6UvrnVnmb3JF075NV0M1ng=
X-Gm-Message-State: AOJu0YxaSNvpLwb0eqmjeRtfWCSGs3LAB4CEMf+IZeFEDP14dqDhw6mm
 QbDggqz01YKRS3yif1Nv6+tT3NF3TOgvuez+IG3TTvggsiaEEuGg44hAGPVaAg==
X-Google-Smtp-Source: AGHT+IEQn1WPGq1X/VJV81JrV7ibIaep5s4Zt2ExJV4yXQect/QS33902BWt98J9Hmu6k510FE2fiA==
X-Received: by 2002:a05:600c:1e12:b0:419:b16:9c14 with SMTP id
 5b1f17b1804b1-4200f8697eemr11861635e9.1.1715873405853; 
 Thu, 16 May 2024 08:30:05 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41ff063d8cesm239609605e9.46.2024.05.16.08.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:30:05 -0700 (PDT)
Date: Thu, 16 May 2024 15:30:01 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 09/18] hw/arm/smmu-common: Rework TLB lookup for
 nesting
Message-ID: <ZkYmedM5uHf3DM2O@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-10-smostafa@google.com>
 <6afc41f6-7127-46f2-833f-6eb4abb2730d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6afc41f6-7127-46f2-833f-6eb4abb2730d@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=smostafa@google.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Eric,

On Wed, May 15, 2024 at 03:54:36PM +0200, Eric Auger wrote:
> 
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > In the previous patch, comine_tlb() was added which combines 2 TLB
> combine
Will do.

> > entries into one, which chooses the granule and level from the
> > smallest entry.
> >
> > This means that a nested translation, an entry can be cached with the
> that with nested translation
Will do.

> > granule of stage-2 and not stage-1.
> >
> > However, the lookup for an IOVA in nested configuration is done with
> > stage-1 granule, this patch reworks lookup in that case, so it falls
> > back to stage-2 granule if no entry is found using stage-1 granule.
> I should have read that before commenting previous patch ;-)
> Anyway this shows that something is missing in previous patch, at least
> the above explanation ;-)

Yup, I can add a comment in the previous patch or reorder them, let me
know what you prefer.

Thanks,
Mostafa

> 
> Eric
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
> > +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > +    }
> >  
> >      if (entry) {
> >          cfg->iotlb_hits++;
> 

