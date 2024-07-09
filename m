Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DA9C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR5AG-0008Jb-3f; Tue, 09 Jul 2024 03:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR5AD-00087b-0h
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:21:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR5AB-0002VK-FD
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:21:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42666b89057so56145e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720509681; x=1721114481; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gIkOsfO4MWR8FV0BxCpeB1qOa5jyLB5kgFJtPbMATAo=;
 b=zwtmj5fqwKgmDt77lcVsApeqr9cX7wSG37O1Vmx3XIJ1T3X/rGgRa2ubaehGATupmi
 xIr6QZAXfqTbJCSd83/xSxPcH40pcf67NpxvZtWE+0d/useyKuF0K5cI/JIt7mHrxwC9
 FQDMEf8KqrJkxNmrAEtVxPa/+ZDg4XTDzMo5yVwNdKls9dIhbpCCHkEz7QQkOXKpeRk6
 7BPPzHnu5+keV93MaPjOEOboVSMIZ/kSvbmoBYh4LeLTTw9S49+/pUm0qcwTb7oa9MgC
 yrErZICUxtVv9by6GxArTIZk7bTkzUFW1w5DcgJk571Jj078yxwRZ0FcMS7C+VV0XTlu
 Oc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509681; x=1721114481;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gIkOsfO4MWR8FV0BxCpeB1qOa5jyLB5kgFJtPbMATAo=;
 b=QUrfWfSKje2kdT6h4lZL61e9R7m8p2Z6QYm9okEONCA45cOnqCM0hzY8AfA1ptySHi
 DkJYRPTcXOGPv468pgbsC+BXQLF5RTBDK839YHEXB2t3MDZs73Ivi9c5DlGxBIJY5jhi
 CeuLCKI9dDMCgRb2MnKr64ApUmij6wVd4iygeZ8ZbgSh9WkPOgs+9gRqck+SyXzKZT58
 5FaUfjEuKkXG0E0N52DPf1KChnjnNQpXPrE3rRdenFj69C4ZIzcgd0OHMgmdHmmz3dbO
 UodDp1T9MaTfX+nlNRaYqjOPb5+dYLkKVU938pmqyI/czSN5J9DvpVKfv0lDwHTEZUcM
 oheQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1nKrjxB4xrqCRAgvruFFHezOVG7A/kKuYmOToupjt0jGabKOKxNUjBZV/821heUD3hEUVtZny4oGZesw/iB2bD2/YGxw=
X-Gm-Message-State: AOJu0YyjVdmzmDCljBiGTXP3igJIRG1slfVCNyWezIImh1WOSTJf4DVl
 SVOnRdv20c2HO14ZcsYHalhyKco/AeeCsttg+rqt6oqESBgKAA/ljl5FTzSv4A==
X-Google-Smtp-Source: AGHT+IEL04bxd3EFQJudI33ZxQSuRGB1U2za770AoRhm3DAxGO2Wj86zA/oZ6KC3BaDfHBl5U248ag==
X-Received: by 2002:a05:600c:4f53:b0:426:6e95:6ea7 with SMTP id
 5b1f17b1804b1-426717a3a54mr1371955e9.0.1720509681160; 
 Tue, 09 Jul 2024 00:21:21 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab7d4sm1654148f8f.113.2024.07.09.00.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:21:20 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:21:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 18/19] hw/arm/smmuv3: Advertise S2FWB
Message-ID: <Zozk7IdpbYqtGMiN@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-19-smostafa@google.com>
 <20240704183658.GO1693268@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704183658.GO1693268@myrica>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=smostafa@google.com; helo=mail-wm1-x329.google.com
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

On Thu, Jul 04, 2024 at 07:36:58PM +0100, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:40AM +0000, Mostafa Saleh wrote:
> > QEMU doesn's support memory attributes, so FWB is NOP, this
> > might change in the future if memory attributre would be supported.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 807f26f2da..88378e83dd 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
> >      if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
> >          /* XNX is a stage-2-specific feature */
> >          s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
> > +        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {
> 
> Why is this check needed?
>

I thought that only made sense only for nested SMMUs, but I guess in
practice it’s not important for qemu and Linux doesn’t use it, I can
just drop this patch.

Thanks,
Mostafa

> 
> > +            /*
> > +             * QEMU doesn's support memory attributes, so FWB is NOP, this
> 
> doesn't
> 
> Thanks,
> Jean
> 
> > +             * might change in the future if memory attributre would be
> > +             * supported.
> > +             */
> > +           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
> > +        }
> >      }
> >      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
> >      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 

