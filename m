Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBFDC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cRg-0003Mg-0f; Thu, 16 May 2024 10:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s7cRc-0003KK-SW
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:50:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1s7cRa-0003Wb-V4
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:50:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42012c85e61so385965e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715871051; x=1716475851; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0fMJVCubVaRpMDCSR7hSQVqaNqRKdkVSa3v5hqLU758=;
 b=04cZO8kXK++vdHC7YWxFzcpgRUYXJGiuRxtSnHDCeLlZAiexVTSWZTAPYvhjdAg17Z
 5hJouqJbKJqP9wwFt/K4jy8UcM/aorYl3wwnk0MsuaFIvnjHRSWmja/7GGNgcsRDo+tD
 PGIq8+8rpmsG5aV5SiRV/1wU/B4Hdx/uspA3ziiypBvJarokxAbpNs1vnFS0ydMJwqrx
 pRVlFA6QnIEpKzzd6+nXLTjdy+w2xrSlC5YKgylpnRb2MqvY+v9Bu5ZPO6U0a9Ppoug2
 CSjLmbww86LYsJTZvXrOyDNPHkzyEW5S41Cn72FkT20Y4haGcmbawBtk8/V0tNzy7/MQ
 NMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715871051; x=1716475851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fMJVCubVaRpMDCSR7hSQVqaNqRKdkVSa3v5hqLU758=;
 b=lbse2ZCsGFwXh+K9N9BOYR2X4DGGTL5JJ79qVh2IDZkhVke5zPwUYti0OvMQJnk3F6
 Hqw45yJm/Tt5Bar2XUzFIA9bGgqXRhfua3bQUjsDoJVdORg2FGkXjyMemlZTKJyAejev
 eJgFhf9S9PcklhGcuQdA8b82FefexmPRaqxavWJcknLO8sPkKYvBhzFQBc1OVI2QFPdJ
 hlQwnCiJins5arM3kvfSCaYWzqmk9xFXioS2X7eIQASXLd9A7cIenP0e466Xdgo1qAmj
 m4QGplGlWlRC8O6oOrOpqmWRZC9tIiPlSlBLFs3G3R47103UXF0EqQ9TdZQz+ibYxAqd
 W3Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6RtmFExLq4mxwVeh9zHEznb9gFAePXnI0ZAOBcgpT1lsLeUYwUcIZJVPxblVcalG5GHG+chgljV9KDhebEQ7lfYygYHM=
X-Gm-Message-State: AOJu0YwFBkWH2GNiShyny/Mz88Nc7gXGMy4lVV0DfUSwn8g05yqnoDSo
 UodFhADKzPmoiViy8MIBK4aAf62myE3Vn4StAVcvbPnpAkyKx+iPDjxpzBhY6w==
X-Google-Smtp-Source: AGHT+IGvBKsbNqZ2C0szf2K5UUJxaiEKlzZXy+jJ37XfQmuXY8ZsvfRD+1ZL+U1yCM1ZmC63Av/JWQ==
X-Received: by 2002:a05:600c:5010:b0:41b:4c6a:de6d with SMTP id
 5b1f17b1804b1-4200f8b159fmr11168565e9.5.1715871050937; 
 Thu, 16 May 2024 07:50:50 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3518d817ee2sm15520099f8f.2.2024.05.16.07.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 07:50:50 -0700 (PDT)
Date: Thu, 16 May 2024 14:50:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 03/18] hw/arm/smmuv3: Fix encoding of CLASS in
 events
Message-ID: <ZkYdRmCf4KJzIe9a@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-4-smostafa@google.com>
 <2ca04dfa-61bb-4f35-954a-b5f107bf8f36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca04dfa-61bb-4f35-954a-b5f107bf8f36@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=smostafa@google.com; helo=mail-wm1-x335.google.com
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

On Wed, May 15, 2024 at 02:27:45PM +0200, Eric Auger wrote:
> Hi Mostafa,
> On 4/29/24 05:23, Mostafa Saleh wrote:
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
> If this fixes somethings please add a Fixes: tag.
> 
> Also you may add that until nested gets implemented, CLASS values are
> the same for stage 1 and stage2. This will change later on.
Will do.

Thanks,
Mostafa

> 
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 
> >
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
> 

