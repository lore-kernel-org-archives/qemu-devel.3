Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9F3CE7AA6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 03:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smPHq-00026U-Nu; Thu, 05 Sep 2024 23:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPHn-00024o-T0; Thu, 05 Sep 2024 23:05:24 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smPHm-0004nM-14; Thu, 05 Sep 2024 23:05:23 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-49bd7809c84so326525137.0; 
 Thu, 05 Sep 2024 20:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725591920; x=1726196720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aKzJA8OaDtOIISihwxrfK7yuJ6NsKR5Mbzl7WnMAnk=;
 b=RW470e9Klgpm/kgeM5X4Pq0gWTgqs4bDqxZ7Ju8hrWzZg6Mku6L9hLUKqRDMLcXPKB
 xTbJ1bNUZMhwF/W2I1GJbwWTwfsLyXPh1FTBghSLiS0615W0l3ou25pGSyc2YpN+V51l
 aHqNZ7lfvaPLSEqYmYcBvFYMlCMKl4z6qd02CSszYRIgthLVC8H9jt3QRQzM/o2vqI2b
 XKh8t4NqIc0pOxWcKjG6q4weRjfy2zZFpGpo+poKKkXS00Fk1Gw73dITnyslr3XK55to
 1/AdNqvEmaxCjj3PnJGRwyABadequLwM5BZ+kWy295lQ/rL4BE+0T95cFLxjDFZ9sazc
 pufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725591920; x=1726196720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1aKzJA8OaDtOIISihwxrfK7yuJ6NsKR5Mbzl7WnMAnk=;
 b=AKlKp87tORHG7G02/w4pBcOORXv0Ocylzrnwic98MVj68bMomjQiXTNMZ/YbCHM7nN
 /EGh9iUXIwo5Jdg/w9sFKo20BCVIAb3Do4I/t9Q1w1kDwY/AWb72cKYQMs7nsMTsNNNi
 1KTEewP9bAVxjBKKXFICv6qedesPMj7vdUAqJZ7MurCeoTtgVBHB5PQMVKuCQH43GwAj
 SPe1+Q/JWrxKPOFrKGa9hQds87UtlaFNRBIUir/mYz01DqLndiUoa2Qmtz+yFEOwHsfw
 SE5+aVFtEboOeuME43OxIUcOeZwogpXahi4a0N4ouF4dJWPvYRik+rc+uPx21XImI3x2
 624g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzifSm7uhdqx65s//JzUQm9cm4z7hGR5P7D6KcIQk7oPhuiC7RtWm6ajbI74a/PwiywUvzCoGyqGsT@nongnu.org
X-Gm-Message-State: AOJu0YybYzfj2k2IlCTrvC3Q/z6cLLN6umX0/CywXAqHduw2y9ZqvXSa
 O37ryuwRuSFhOSNwsAZEpZ2XU0jlglldVjb/gRYrzM7gxYN92wNv2oxI3AnGgRH4Mo9t2QJObbU
 BwCTjJ363iPK7oIozVAqY+YJKYhdDAwib
X-Google-Smtp-Source: AGHT+IFGNkY0JSAJdP5FpI+GaDsEXrL47nof15Z8pbX863LxmLGRxJ3ilC3s+lCvZFK2l8mO7fTVphy+xtD/sTmD6Go=
X-Received: by 2002:a05:6102:e11:b0:493:b719:efb9 with SMTP id
 ada2fe7eead31-49bde1779c9mr1635524137.9.1725591920473; Thu, 05 Sep 2024
 20:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
 <20240819160742.27586-3-Ian.Brockbank@cirrus.com>
 <CAKmqyKP6DTHq=6Tv3F7DPzjiyXdJhUdr0isNokZPCFgstQV4gQ@mail.gmail.com>
In-Reply-To: <CAKmqyKP6DTHq=6Tv3F7DPzjiyXdJhUdr0isNokZPCFgstQV4gQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 13:04:54 +1000
Message-ID: <CAKmqyKPrz2544MFpORh==F-63M5pMMbsWcjNipOSozMeTB7G5Q@mail.gmail.com>
Subject: Re: [PATCH 01/11 v2] target/riscv: Add CLIC CSR mintstatus
To: Ian Brockbank <Ian.Brockbank@cirrus.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Sep 6, 2024 at 12:44=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Tue, Aug 20, 2024 at 2:11=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirr=
us.com> wrote:
> >
> > From: Ian Brockbank <ian.brockbank@cirrus.com>
> >
> > CSR mintstatus holds the active interrupt level for each supported
> > privilege mode. sintstatus, and user, uintstatus, provide restricted
> > views of mintstatus.
> >
> > Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
> > Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Whoops! Scratch that

>
> > ---
> >  target/riscv/cpu.h      |  3 +++
> >  target/riscv/cpu_bits.h | 11 +++++++++++
> >  target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
> >  3 files changed, 45 insertions(+)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 1619c3acb6..95303f50d3 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -259,6 +259,7 @@ struct CPUArchState {
> >      bool software_seip;
> >
> >      uint64_t miclaim;
> > +    uint64_t mintstatus; /* clic-spec */
> >
> >      uint64_t mie;
> >      uint64_t mideleg;
> > @@ -461,6 +462,8 @@ struct CPUArchState {
> >      QEMUTimer *vstimer; /* Internal timer for VS-mode interrupt */
> >      bool vstime_irq;
> >
> > +    void *clic;       /* clic interrupt controller */
> > +
> >      hwaddr kernel_addr;
> >      hwaddr fdt_addr;
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 32b068f18a..2e65495b54 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -165,6 +165,7 @@
> >  #define CSR_MCAUSE          0x342
> >  #define CSR_MTVAL           0x343
> >  #define CSR_MIP             0x344
> > +#define CSR_MINTSTATUS      0xfb1 /* clic-spec-draft */
> >
> >  /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
> >  #define CSR_MISELECT        0x350
> > @@ -206,6 +207,7 @@
> >  #define CSR_SCAUSE          0x142
> >  #define CSR_STVAL           0x143
> >  #define CSR_SIP             0x144
> > +#define CSR_SINTSTATUS      0xdb1 /* clic-spec-draft */
> >
> >  /* Sstc supervisor CSRs */
> >  #define CSR_STIMECMP        0x14D
> > @@ -733,6 +735,15 @@ typedef enum RISCVException {
> >  #define SIP_SEIP                           MIP_SEIP
> >  #define SIP_LCOFIP                         MIP_LCOFIP
> >
> > +/* mintstatus */
> > +#define MINTSTATUS_MIL                     0xff000000 /* mil[31:24] */
> > +#define MINTSTATUS_SIL                     0x0000ff00 /* sil[15:8] */
> > +#define MINTSTATUS_UIL                     0x000000ff /* uil[7:0] */
> > +
> > +/* sintstatus */
> > +#define SINTSTATUS_SIL                     0x0000ff00 /* sil[15:8] */
> > +#define SINTSTATUS_UIL                     0x000000ff /* uil[7:0] */
> > +
> >  /* MIE masks */
> >  #define MIE_SEIE                           (1 << IRQ_S_EXT)
> >  #define MIE_UEIE                           (1 << IRQ_U_EXT)
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index ea3560342c..f9ed7b9079 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -578,6 +578,16 @@ static RISCVException debug(CPURISCVState *env, in=
t csrno)
> >
> >      return RISCV_EXCP_ILLEGAL_INST;
> >  }
> > +
> > +static int clic(CPURISCVState *env, int csrno)
> > +{
> > +    if (env->clic) {

This isn't enough. There are smclic (M-mode) and ssclic (S-mode)
extensions that need to be checked against here to access the CSRs.

At the end of the series they can then be exposed as CPU properties
(which the virt machine can enable when required)

Alistair

