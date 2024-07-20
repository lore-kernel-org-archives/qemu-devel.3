Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54A5C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 22:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVIEc-0007dh-22; Sat, 20 Jul 2024 18:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sVIEa-0007cW-1A
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 18:07:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sVIEX-0006pk-MN
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 18:07:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42725f8a789so77495e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721513235; x=1722118035; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QWF+mqdfgq0m4qSwHFJOdi5LiLHFgIXJ3tavmcy0ATk=;
 b=EAmHO/0fGfNy1boOFBZoukNGebzUJ9e6f1jtnqNiJXMdcKE7wZylZP3DBAK7wm8Y3B
 7CW4mGd3A09/ydclMKV8Py2Kjo3MpmpXJTEKMjklzAYpRlewlYkNEXIvZu0x5W4pO4CB
 BScCggKBHJsKseu3vnV1kv/GmEsK70Pr4QnYZkehoZzc3V1Gp2ONx7vVKm5rriSfeDlQ
 O2qqIxM1ZSpMFUF0IpSDeJr43pWJjhlifB6a2oiT6kI2LEmzasLBNLobHe+pwDr0/fXj
 g3fGPhOThZH9lM/sm+3MtYmSmKP4+zFS3YhGdCg+IfRVSWfDpu4WJWkfWnW00kKARPwl
 XpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721513235; x=1722118035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWF+mqdfgq0m4qSwHFJOdi5LiLHFgIXJ3tavmcy0ATk=;
 b=vyFYGz8ivGyRSnsPCwq7vUoGcCpvGS3qccvEETYLfX3Y+ckEAsID4CgM49QsKQy/af
 e/DnkSTA/DwAjeyXC/y+t1I8+DY7DsCJmTJRPnEjMnoe4ax3NqNM05Y2lx7LwwDqb9NN
 VH5AXaC/pnvyPZE8MtpFwIiW+oz7RNVhuET68+k8h1dMULDD4FqY5B00xUJc2FjPx0/g
 LcauFdDRetrkuWPZQ7DofLUg4BquyCAUHe7effN1aR+gkRiuNWXxeAucQ++tSCY1nImN
 2/GDHIMUK9+OF2+nliKiNTRbcVb2Q1K2xxigdotkFd88LTBuEmnw+rbbtJIrRlbrZTnk
 VQdA==
X-Gm-Message-State: AOJu0YxCw6+lskzLGw0oGLPrf1ZePQXaS85EbsaHneVzJtBCEAe2pFjx
 m4uj3xDS7uTNhy56G2x8NxxpIs/clTvH6h+bmf8ZFWp9rcVjPYa8pZywq3Tlng==
X-Google-Smtp-Source: AGHT+IG/PCma8RYx+jhmEluym/UEF9RyzwjUJUsim4qfvWJ31wMEjOT2Ayp46Y7JQ7z4QnfO54W18w==
X-Received: by 2002:a05:600c:4f51:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-427dd1764a0mr768935e9.7.1721513234615; 
 Sat, 20 Jul 2024 15:07:14 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94af6sm95038905e9.42.2024.07.20.15.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 15:07:13 -0700 (PDT)
Date: Sat, 20 Jul 2024 22:07:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 21/26] hw/arm/smmu: Refactor SMMU OAS
Message-ID: <Zpw1C7L4dG8NCetB@google.com>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
 <20240718132028.697927-22-peter.maydell@linaro.org>
 <CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com>
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

Hi Peter,

On Sat, Jul 20, 2024 at 04:05:40PM +0100, Peter Maydell wrote:
> On Thu, 18 Jul 2024 at 14:20, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > From: Mostafa Saleh <smostafa@google.com>
> >
> > SMMUv3 OAS is currently hardcoded in the code to 44 bits, for nested
> > configurations that can be a problem, as stage-2 might be shared with
> > the CPU which might have different PARANGE, and according to SMMU manual
> > ARM IHI 0070F.b:
> >     6.3.6 SMMU_IDR5, OAS must match the system physical address size.
> >
> > This patch doesn't change the SMMU OAS, but refactors the code to
> > make it easier to do that:
> > - Rely everywhere on IDR5 for reading OAS instead of using the
> >   SMMU_IDR5_OAS macro, so, it is easier just to change IDR5 and
> >   it propagages correctly.
> > - Add additional checks when OAS is greater than 48bits.
> > - Remove unused functions/macros: pa_range/MAX_PA.
> 
> Hi; Coverity has spotted a possible problem with the OAS handling
> in this code (CID 1558464). I'm not sure if that's directly because of
> this patch or if it's just that the code change has caused Coverity to
> flag up a preexisting problem.
> 
> It's quite possible this is a false-positive because Coverity hasn't
> noticed that the situation can't happen; but if so I think it's also
> sufficiently unclear to a human reader to be worth addressing anyway.
> 
> > -static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
> > +static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
> > +                             STE *ste)
> >  {
> > +    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
> > +
> >      if (STE_S2AA64(ste) == 0x0) {
> >          qemu_log_mask(LOG_UNIMP,
> >                        "SMMUv3 AArch32 tables not supported\n");
> > @@ -460,7 +463,15 @@ static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
> >      }
> >
> >      /* For AA64, The effective S2PS size is capped to the OAS. */
> > -    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), SMMU_IDR5_OAS));
> > +    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), oas));
> 
> oas2bits() is implemented as a function that returns -1 if the input
> isn't a valid OAS. But we don't check for that failure here, so we put
> the result into a uint8_t, which ends up as 255. Then later in
> the function we will do
>   MAKE_64BIT_MASK(0, cfg->s2cfg.eff_ps)
> which will do an undefined-behaviour shift by a negative number
> if eff_ps is 255.
> 
> If the invalid-OAS case is impossible we should assert rather
> than returning -1; if it's not impossible we should handle it.
> 
> Mostafa, could you have a look at this, please?

Yes, it should be impossible to have an invalid OAS.

This patch doesn't change the old behaviour, it just consolidate OAS
setting in one place, instead hardcoding it everywhere, so here
instead of using the macro (SMMU_IDR5_OAS) directly we now read it
from IDR5, which is set to SMMU_IDR5_OAS at smmuv3_init_regs().

The other field S2PS is casted to 6 bits, and as we use MIN, and
all the previous values are valid, so it should be fine:
- 0b000: 32 bits
- 0b001: 36 bits
- 0b010: 40 bits
- 0b011: 42 bits
- 0b100: 44 bits

Adding an assertion makes sense to me. Please, let me know if you
want me to send a patch for that.

Thanks,
Mostafa

> 
> thanks
> -- PMM
> 

