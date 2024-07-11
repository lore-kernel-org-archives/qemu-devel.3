Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D867C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtSR-0007bW-Dy; Thu, 11 Jul 2024 09:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sRtSJ-0007H6-Lh
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:03:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sRtSH-0008Hz-Fc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:03:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266f796e67so53365e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720703003; x=1721307803; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T1tEsDBDWsovvb9XXtE9YS/ok36swrWeL71lNKwHwT0=;
 b=hPmvi/XTh1Rp6ArlX7yOY3s5tbpm6dLQ4ttqJ34uyhT+wWwPnsa9Fgwge6h41mCml9
 OT0c6xNl/TTLs0ed4zSDj0ZaLANBpl6w+YudwFiJBgKBXpKdI8gvtrwF7KOd0G6XWWnY
 jB6sZ6zypBNu3PYU9XafMQVyj5uTcqixt8y5peJGFbBUckw5ouIWsUZAWwOqPu5nGS/g
 L6EW5gPvOcok16uum/0UfCh7V5/g35ooz4WJM2EXrFlqbKj9y2W6tk/UxUDqHURJP86J
 nRcWEomnXxV+5zTjT6BDfxa3bcry26r2pz7z+EMuLe8b9f4UGBHkxtvrFy/MBkmvSjgo
 vGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703003; x=1721307803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1tEsDBDWsovvb9XXtE9YS/ok36swrWeL71lNKwHwT0=;
 b=WE7EElNUadwXKvzwZCf7hfht4zJeOnnQnlhw+gtHjIC8r4UjKsTS7UGGHK1sR14/k7
 svPDp41pFFgUi99Q1Xb16uOlADuW1o+qMMtpSaBlVQIpmkzu+fBvZphx520olT0fArsG
 ebXS3mivonkuCJAuPWbBzOpJQSkIW9GizXLw1Nn/LWB0839oPuAXYhdAO2eWbEPf7dAY
 zzqddTp6C4pbWq7j06bLdVGjrI1Pwx+38UK0j0f7aBKcbgc2QbV9CXIde7KiisIGQyuq
 BgOrUwRJrWtNXfJLfK1BHHDGrKtqSpZPzqVV8etr6NHuwgZtpgVi0nEEcimT+NHWsckF
 Gi5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSvbJkYHoJRrhz6C2CMPKpxvXIKfWu0VEXdWPL6d5X0TLl+6webikugXR7iV0Gc/xfQwWOZu/ECliUaiiEmr/Z57ZutD4=
X-Gm-Message-State: AOJu0YzdtXYfDPi1ZUb6nPIxQLZ85hlr2f7rBUKX+PJeyAM4sZXab5JK
 VmhCXcJO0q7iggLCoXTAvlZLFDfvAnrvq0Ys+rarfTor1cwP1R/Kv7PbULeKTQ==
X-Google-Smtp-Source: AGHT+IFTOGfXRoqpDnrKQAF8LEdAv9irjpAvHVwnuvazB1I19VdY8/QDaMO+oN5nIgRYT0fFU+XY2w==
X-Received: by 2002:a7b:cd95:0:b0:426:6e95:6ea7 with SMTP id
 5b1f17b1804b1-427986dc130mr1787535e9.0.1720703002903; 
 Thu, 11 Jul 2024 06:03:22 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm84986905e9.20.2024.07.11.06.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:03:22 -0700 (PDT)
Date: Thu, 11 Jul 2024 13:03:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 08/19] hw/arm/smmuv3: Translate CD and TT using
 stage-2 table
Message-ID: <Zo_YFuoldgMzJ5Pj@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-9-smostafa@google.com>
 <20240704180843.GE1693268@myrica> <Zozi-87pVHOdwJGN@google.com>
 <20240709130004.GB2189727@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709130004.GB2189727@myrica>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32b.google.com
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

On Tue, Jul 09, 2024 at 02:00:04PM +0100, Jean-Philippe Brucker wrote:
> Hi Mostafa,
> 
> On Tue, Jul 09, 2024 at 07:12:59AM +0000, Mostafa Saleh wrote:
> > > In this case I think we're reporting InputAddr as the CD address, but it
> > > should be the IOVA
> > 
> > As Eric mentioned this would require some rework to propagate the iova,
> > but what I am more worried about is the readability in that case, may be we
> > can just fixup the event after smmuv3_get_config() in case of errors,
> > something like:
> > 
> > /*
> >  * smmuv3_get_config() Only return translation faults in case of
> >  * nested translation, otherwise it can only return C_BAD_CD,
> >  * C_BAD_STE, C_BAD_STREAMID or F_STE_FETCH.
> >  * But in case of translation fault, we need to fixup the
> >  * InputAddr to be the IOVA of the translation as the decode
> >  * functions don't know about it.
> >  */
> > static void smmuv3_config_fixup_event(SMMUEventInfo *event, hwaddr iova)
> > {
> >    switch (event->type) {
> >    case SMMU_EVT_F_WALK_EABT:
> >    case SMMU_EVT_F_TRANSLATION:
> >    case SMMU_EVT_F_ADDR_SIZE:
> >    case SMMU_EVT_F_ACCESS:
> >    case SMMU_EVT_F_PERMISSION:
> >        event->u.f_walk_eabt.addr = iova;
> >        break;
> >    default:
> >        break;
> >    }
> > }
> > 
> > What do you think?
> 
> Yes, I think that's also what I came up with. Maybe it would be simpler to
> unconditionally do the fixup at the end of smmuv3_translate() and remove
> .addr write from smmuv3_do_translate()?

I wanted to make it clear what case causes the IOVA to be missing, but I
guess if we unify the setup for the InputAddr it would be easier to
read and just add a comment instead.

> 
> A separate union field "f_common" rather than f_walk_eabt may be clearer.
> 

Makes sense, but I will not do it in this patch to avoid making it larger
and harder to review, and this can be a separate cleanup as I see in other
places we use eabt already (smmuv3_record_event and for s2 population).

Thanks,
Mostafa

> Thanks,
> Jean

