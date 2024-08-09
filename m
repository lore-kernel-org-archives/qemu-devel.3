Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CB7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 03:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scGJ0-0005To-DF; Thu, 08 Aug 2024 23:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1scGIx-0005Rz-5U
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:28:39 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1scGIv-0005S7-Ih
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:28:38 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-26b5173e861so721956fac.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 20:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723174116; x=1723778916; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dF1Th3mxnkasppLjmRi/GC8aJHarOPFDvn5z8aJZCOg=;
 b=PloT4velnIcoLRmIdcbuSCOdHYDCUD9pz58qqN6zesU4o/Pt1G7cpwE64lMhbMlTto
 Oq2YvaGzJ7GmWLqmfJ7lggrSsQjXrvJN6EWzpFZtTL9yabG08M1bKjWOGAgQWnp8b0uJ
 HHGGEKk7jFrOx4XvzI4+prY67Z4B/77vLTnez0F2+N3hF7xeSowgYuUn46Z6LGXvuXoj
 jGx3h3y8ctO9/rBgQM1Pd9sSy1dRmYfbish3PECTU2Zkg4vQBUGic8N0MTbVBne1T2A6
 NaAmHkemy8pXCz5SsUzYZrzY/x8AWn9NegW6mlPxWVEYCxvXg08ABqlY6C1ZkMJlU8vG
 PlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723174116; x=1723778916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dF1Th3mxnkasppLjmRi/GC8aJHarOPFDvn5z8aJZCOg=;
 b=QGtvhB5jcnJABGEf4Va4cWH5NSx+dx3mne1E9Qv5PksxBrSoFWMQOBULi3YO/MhcMx
 lQPj9MkN0hI8viYlGjNWKWy5LQljzyEpY07cD1d//1fzpT5ifq/tyi6j16XMIuTHAaul
 /VJSVaMKMhiPpsVs3eEY73hdlgBOo6OeX4O5evBQz/XTYNixZlNEh5FKrEFzi6ykjw6f
 /rMeWfCXOK2EKZgkjRnTC/9wVPP9J536RUW3zNcAEzjfF29wX1FlWVF8jMz5BGfvmm6G
 rL4Mab9mtfSRR7izwGAlFzoxl5SHC5+ySQa2e2ihNEPxSV8gx9NnPLw34cgdmnWvbPlN
 YtGg==
X-Gm-Message-State: AOJu0Yytj9ZDv1eDY6hSITkIebi/EuKBzLFB66bnTzr/C0ClBwOanO97
 Lj56RLuzJy0wAhAB+3TLZ1ZpsTCwCKBs0DP7uI4vXbFnHGV9+8lQ5svfzcnrewkMbKCNM4sUQGL
 cZGFIDvcPb4jUQXuSjkU/quwnEzYbV3e6Jvdutg==
X-Google-Smtp-Source: AGHT+IEusv3yAaHfX3hGBlzegdNIeWCp+xiKRlsZ89tsugccQEzW9rou7sH3aUFAIV43BFPtd0p1PtDvBouCTO6exz0=
X-Received: by 2002:a05:6870:d8d2:b0:260:e678:b660 with SMTP id
 586e51a60fabf-26c63043149mr283914fac.51.1723174116021; Thu, 08 Aug 2024
 20:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240808082030.25940-1-yongxuan.wang@sifive.com>
 <aad11c6d-8c5d-40bd-8b0d-3dae10b80d4d@ventanamicro.com>
In-Reply-To: <aad11c6d-8c5d-40bd-8b0d-3dae10b80d4d@ventanamicro.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Fri, 9 Aug 2024 11:28:23 +0800
Message-ID: <CAMWQL2h6=MO1YFW2tUONM_yDnmdtG-CfGyk+RCPZo3u2s6o4Uw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/intc/riscv_aplic: Fix APLIC in clrip and clripnum
 write emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-oa1-x33.google.com
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

Hi Daniel,

On Fri, Aug 9, 2024 at 5:40=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Ccing Anup
>
> On 8/8/24 5:20 AM, Yong-Xuan Wang wrote:
> > In the section "4.7 Precise effects on interrupt-pending bits"
> > of the RISC-V AIA specification defines that:
> >
> > If the source mode is Level1 or Level0 and the interrupt domain
> > is configured in MSI delivery mode (domaincfg.DM =3D 1):
> > The pending bit is cleared whenever the rectified input value is
> > low, when the interrupt is forwarded by MSI, or by a relevant
> > write to an in clrip register or to clripnum.
> >
> > Update the riscv_aplic_set_pending() to match the spec.
> >
>
> This would need a
>
> Fixes: bf31cf06eb ("hw/intc/riscv_aplic: Fix setipnum_le write emulation =
for APLIC MSI-mode")
>

I will add it into next version. Thank you!

> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >   hw/intc/riscv_aplic.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> > index c1748c2d17d1..45d8b4089229 100644
> > --- a/hw/intc/riscv_aplic.c
> > +++ b/hw/intc/riscv_aplic.c
> > @@ -247,7 +247,7 @@ static void riscv_aplic_set_pending(RISCVAPLICState=
 *aplic,
> >
> >       if ((sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
> >           (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)) {
> > -        if (!aplic->msimode || (aplic->msimode && !pending)) {
> > +        if (!aplic->msimode) {
>
> The change you're doing here seems sensible to me but I'd rather have Anu=
p take
> a look to see if this somehow undo what was made here in commit bf31cf06.
>
> In particular w.r.t this paragraph from section 4.9.2 of AIA:
>
> "A second option is for the interrupt service routine to write the
> APLIC=E2=80=99s source identity number for the interrupt to the domain=E2=
=80=99s
> setipnum register just before exiting. This will cause the interrupt=E2=
=80=99s
> pending bit to be set to one again if the source is still asserting
> an interrupt, but not if the source is not asserting an interrupt."
>

I think that this patch won't affect setipnum. For the setipnum case,
the pending value would
be true. And it is handled by the 2 if conditions below.

Regards,
Yong-Xuan

>
> Thanks,
>
> Daniel
>
>
> >               return;
> >           }
> >           if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&

