Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3FAC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 04:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkd2Q-0006hB-HL; Thu, 14 Mar 2024 00:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rkd2I-0006gM-Hg; Thu, 14 Mar 2024 00:49:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rkd2F-0002vF-KP; Thu, 14 Mar 2024 00:49:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso358712b3a.1; 
 Wed, 13 Mar 2024 21:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710391782; x=1710996582; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UVE1ryl5uJfcgrnTbIeqTT16EH5KpFmKsK4ubt7/FU=;
 b=VsWVeCkRUEnOO/GH74CARTOxvy2/RJjTkljvIC4cxy8eDMgYW53rteXLlrPBud5x5a
 W0h/+7UISL52viVFnfRRmWzaCKGUzMd1w+8/3T18hJ5YQlSZoN1NQouM5B8IjccZXWs0
 Oumzj1ApIPwKBzgLM1HJufJnphX4f3HV7SMhGnEEWZdkYkqAU5P3dWsKUXQ2s2JPxFKT
 yJROWPO4+XjdDxf1bu2JIF/izVXua+o+vdX2Libhurtz7trTyIhGWltrwN+lcYfi8z2s
 hbuhTogIudTYhTcY3qBzyFi4xIfuBUVlLNRohG+7ip0Ozx2PUHfiHNZdVB5lwD+Odj8z
 iLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710391782; x=1710996582;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6UVE1ryl5uJfcgrnTbIeqTT16EH5KpFmKsK4ubt7/FU=;
 b=YtJ0l1iI7K+X2EhBdwCz1uR4xF1i1quJjNNeteFSfIL0kY32oquKyU0RbjPBpmn63z
 PSmlHhBgGV1uhP82kLto8B8ZSHDVJWdOiuIQtr0M3fp0hC9UX7z9yUHUwwoXP9dI8Ljg
 bTe5F0LLJQydZgDVmA/ZOtEaNF+fIp7smq4fiMPdQdLF/RHh5HfECqC/ZnUvc8XlNoG/
 qR5FZ6s1yjnn5T9UpMfDNuxmzIe7TCqTtDGV44o9fqNRm4ko1yUE+HbLASevNdm9/CYz
 rdbaV40rDM8ZCbBntMO87xCn58+AmrBKKXf3UO+3vXjaE5eVozCKTuyiyfGz4pdq627Q
 tfmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI3nbUcJkcCvB5KHluzGwMGcYPARgSn+pNnlLosvbv+IkXaaJeeAbGOg09pvC8BvAIz6mRfd5mXberPC2JglxIDmNMX3M=
X-Gm-Message-State: AOJu0YyslZJzNLGQYJUNEBM0Q9oeLa6bYM8srhHXMGCZkbchch+ZVA4k
 6Pw0Og2meCwtmTtUo7I7t8Y213atrNFovWUx7nm9oAf6ZOEXPMrj
X-Google-Smtp-Source: AGHT+IH6+sCaRjlZCHlpoLjKas3/Jty2dcdpInccR+xynUAMQu714Li0CxanfQu4dU2n++kITY+9WA==
X-Received: by 2002:a05:6a00:1790:b0:6e6:4dfe:4c7 with SMTP id
 s16-20020a056a00179000b006e64dfe04c7mr957440pfg.6.1710391781574; 
 Wed, 13 Mar 2024 21:49:41 -0700 (PDT)
Received: from localhost ([1.146.49.180]) by smtp.gmail.com with ESMTPSA id
 hy11-20020a056a006a0b00b006e5736e9e46sm482183pfb.42.2024.03.13.21.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 21:49:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 14:49:36 +1000
Message-Id: <CZT7A6OE68Z3.CBQT93DAOJ6K@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 03/10] ppc/spapr|pnv: Remove SAO from pa-features
X-Mailer: aerc 0.15.2
References: <20240312131419.2196845-1-npiggin@gmail.com>
 <20240312131419.2196845-4-npiggin@gmail.com> <ZfJiPpUcNt9B0i9l@zatzit>
In-Reply-To: <ZfJiPpUcNt9B0i9l@zatzit>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Mar 14, 2024 at 12:34 PM AEST, David Gibson wrote:
> On Tue, Mar 12, 2024 at 11:14:12PM +1000, Nicholas Piggin wrote:
> > SAO is a page table attribute that strengthens the memory ordering of
> > accesses. QEMU with MTTCG does not implement this, so clear it in
> > ibm,pa-features. This is an obscure feature that has been removed from
> > POWER10 ISA v3.1, there isn't much concern with removing it.
> >=20
> > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Usually altering a user visible feature like this without versioning
> would be a no-no.  However, I think it's probably ok here: AFAICT the
> feature was basically never used, it didn't work in some cases anyway,
> and it's now gone away.

Thanks David, I appreciate you keeping an eye on these kinds of
compatibility issues from time to time.

Yeah, we established that it doesn't really matter for Linux code out
there, but you thought it's ugly to change this based on the host
configuration for pseries machines.

And if this change does cause problems, it's quite possible that
configuration was broken anyway, so that's arguably preferable to
continuing to advertise a broken or at least non-migratable feature.

Thanks,
Nick

>
> > ---
> >  hw/ppc/pnv.c   |  2 +-
> >  hw/ppc/spapr.c | 14 ++++++++++----
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 0b47b92baa..aa9786e970 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -150,7 +150,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
> >      uint32_t page_sizes_prop[64];
> >      size_t page_sizes_prop_size;
> >      const uint8_t pa_features[] =3D { 24, 0,
> > -                                    0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0=
,
> > +                                    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0=
,
> >                                      0x80, 0x00, 0x00, 0x00, 0x00, 0x00=
,
> >                                      0x00, 0x00, 0x00, 0x00, 0x80, 0x00=
,
> >                                      0x80, 0x00, 0x80, 0x00, 0x80, 0x00=
 };
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 55263f0815..3108d7c532 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -233,17 +233,23 @@ static void spapr_dt_pa_features(SpaprMachineStat=
e *spapr,
> >                                   PowerPCCPU *cpu,
> >                                   void *fdt, int offset)
> >  {
> > +    /*
> > +     * SSO (SAO) ordering is supported on KVM and thread=3Dsingle host=
s,
> > +     * but not MTTCG, so disable it. To advertise it, a cap would have
> > +     * to be added, or support implemented for MTTCG.
> > +     */
> > +
> >      uint8_t pa_features_206[] =3D { 6, 0,
> > -        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> > +        0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
> >      uint8_t pa_features_207[] =3D { 24, 0,
> > -        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
> > +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0,
> >          0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> >          0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> >          0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
> >      uint8_t pa_features_300[] =3D { 66, 0,
> >          /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|P=
P110 */
> > -        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, SSO, 5: LE|CFAR|E=
B|LSQ */
> > -        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
> > +        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ=
 */
> > +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
> >          /* 6: DS207 */
> >          0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> >          /* 16: Vector */


