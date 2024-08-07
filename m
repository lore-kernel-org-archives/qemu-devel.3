Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36F6C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbUI-0007VL-Kw; Wed, 07 Aug 2024 03:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sbbUG-0007SV-Fn
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:53:36 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sbbUE-0003OA-OG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:53:36 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ef2cb7d562so15557951fa.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723017213; x=1723622013;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmRAZp2UGIsdgrVqP66l1MM2Sy96mlil4RliD4ibjl8=;
 b=zre0K3xPWV0kVgkC8BDwR2tQ7oCjI6rHjHJ4ngEoQnnBx3dno5p8DXNfxKo0ZIfWkj
 gaC4DOAe9uQ4MRMya5zlJKqOkxAg9UATSacXcWE5RDKNUmmSDJdca8FbvW42MZ/sAgmw
 ZJgo4KE7SKbaE4xaSbc2NSzo4g25h00JMphAkvgd6+ZVQe/5IZffO3eWgcbnAnFPSQof
 grgstUsPywkVcjUVFD4lIECz0mAAh8yLxXP6F3rchYJo2VFwurETL105+4ciL/cGN+8C
 +ucGCFGkcM9jLhD+Rx5ynt2o1OdAC9KD+PF0iSMviTNIgCSoOUAQ8q4SfJbG8Z1svwnP
 5nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723017213; x=1723622013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmRAZp2UGIsdgrVqP66l1MM2Sy96mlil4RliD4ibjl8=;
 b=TJtgXjKnGSdjky31tV0AdUIiOMKfquQzcazjmnorkm0u6XUywLfim6uFZvHnQNLPAm
 cNzk6ayZx4f1Tn+cUA+6OfEU4nYBgmSG+BnCftea6pTUET13MBV+J6rWnpLbw82fs81u
 Ep3hcrgLClX7zQPLFIOcMolL2lrEjG6CGsVx1ftXM1WOUC/MzXr9DkfVDIEfBbVglRAD
 75nHRZSVeleqO+I2tP+DSQA4vdTl0sVgXiO6VgjiSS4kbZu49mIaUrbVR5n4o7xVwM80
 LvuzGfj/fxFJCqNnRowtCUWEYqdCSeoHpzMqaPPlCAHmup9Hx7NootqMbx0wdhtuDQse
 znvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVok0OGO72BW9V0uWoPDLgGcDq6x0S+a7Q+SxA77AIMO3gIQvyjGpS8TdRVSKDEJxANUi6QHr6Zdj3UjxpexcfgzXCMOJg=
X-Gm-Message-State: AOJu0Yy/3ns/cxVPL8TFf4h7B9Q0wBYieIqwhZzBwBP+jrT/bJTx2tOQ
 k4nHlmoKla2T5os1bDRuGPABo14xRImYso/Rk3jJaCnpKKWt7CRHgPGAt1pEYDj7mRo7Lu2ZzqO
 AyM5mnJvVrjCgPF9+KTl47qRVHwTq2D91SHYrPCgjI4IlhV5t
X-Google-Smtp-Source: AGHT+IHTY1wKSQruF7lPBz5w1jIYFwj8iw4fN4E6vWPpG2LjvI7kjGFhBt17kJg9/Cbpqiw6kFbWNaCwZ2Xf0xmEWBY=
X-Received: by 2002:a2e:b602:0:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2f15aa85eeamr123417791fa.4.1723017212504; Wed, 07 Aug 2024
 00:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-1-c4170a5348ca@rivosinc.com>
 <CAKmqyKPEWgA=s5sokPG2_v2qdbuaHwdGf6RJzqFfL15Htq=vBA@mail.gmail.com>
 <CAHBxVyGzogwFhFu+kF=PvVEJ+Mm_1EYyaHD+6NR=mh9WrrEBBw@mail.gmail.com>
 <CAKmqyKOc0GmuSXK1PZi4CHSVDJcyNG7wP+m6TD8faFPXH4vhBA@mail.gmail.com>
In-Reply-To: <CAKmqyKOc0GmuSXK1PZi4CHSVDJcyNG7wP+m6TD8faFPXH4vhBA@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 7 Aug 2024 00:53:21 -0700
Message-ID: <CAHBxVyHrQoj-eSwLkABivPL5sugkL=BQqc+MnQBWPQtgMKk6Ag@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] target/riscv: Add properties for Indirect CSR
 Access extension
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=atishp@rivosinc.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 31, 2024 at 2:24=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Sat, Jul 27, 2024 at 11:33=E2=80=AFAM Atish Kumar Patra <atishp@rivosi=
nc.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 12:42=E2=80=AFAM Alistair Francis <alistair23@g=
mail.com> wrote:
> > >
> > > On Wed, Jul 24, 2024 at 9:31=E2=80=AFAM Atish Patra <atishp@rivosinc.=
com> wrote:
> > > >
> > > > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> > > >
> > > > This adds the properties for sxcsrind. Definitions of new registers=
 and
> > > > implementations will come with future patches.
> > > >
> > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > > > ---
> > > >  target/riscv/cpu.c     | 2 ++
> > > >  target/riscv/cpu_cfg.h | 2 ++
> > > >  2 files changed, 4 insertions(+)
> > > >
> > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > index a90808a3bace..ebc19090b40d 100644
> > > > --- a/target/riscv/cpu.c
> > > > +++ b/target/riscv/cpu.c
> > > > @@ -183,12 +183,14 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> > > >      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin=
),
> > > >      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> > > >      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrp=
mf),
> > > > +    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_12_0, ext_smcsrind=
),
> > >
> > > This is actually part of the unpriv spec, so it's a bit weird that it
> > > depends on the priv spec. But that's how it's all set up.
> > >
> >
> > Smcsrind is part of priv spec[1]. Am I missing something ?
> >
> > https://drive.google.com/file/d/17GeetSnT5wW3xNuAHI95-SI1gPGd5sJ_/view
>
> Ah, I just saw
>
> "This specification has been merged into the Unprivileged Specification" =
at
>
> https://github.com/riscvarchive/riscv-indirect-csr-access
>

Probably a typo. I pinged RVI folks as the repo is already read only
now. I can't create an issue either.

> Alistair
>
> >
> > > But shouldn't this be PRIV_VERSION_1_13_0?
> > >
> >
> > Yes. Sorry I forgot about that. smcntrpmf should also be PRIV_VERSION_1=
_13_0.
> > I will send a fix patch along with the v2 for assert fix.
> >
> > > Alistair

