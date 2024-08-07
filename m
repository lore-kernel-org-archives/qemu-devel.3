Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049C4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 10:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbeO0-0001Cm-Ma; Wed, 07 Aug 2024 06:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbeNz-0001AG-4x; Wed, 07 Aug 2024 06:59:19 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbeNx-0004an-1U; Wed, 07 Aug 2024 06:59:18 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4f52cc4d3beso593824e0c.3; 
 Wed, 07 Aug 2024 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723028355; x=1723633155; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJb2tNczD1SzPofhWO+9fOiBuoFvb5LmfVhKCDXvVYs=;
 b=YlhLuRZwTXCFcILdp5xUN+7lXjfBIbp4pTghQkrsu/me10aW75EngCbw7yGi3xTqME
 mNN5u4jEAk/pvbzjMLB3dNYwAQyl3QQNQtUCzhiHW7OSDijaOU0ci1xum8OPtOR4ieGp
 PbNiHSJuSgtsBQAWajmhMKFyG7G48XrKatHj02ipzEED4YPx5LHpNuysE+zomS+3EBKf
 qWS5qmb/wMGEJu0kQBE/Ivr3OTIap/arTq92y+howBgdogn2RYjLhFPfQXMABaVqgcnh
 4TWL39EPkmhFRXxXsi9U0YNT/9F7AbRB3Rqjf4wOHB+zQ+QWLa+sBr32Evoq8Ng8hySN
 pBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723028355; x=1723633155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJb2tNczD1SzPofhWO+9fOiBuoFvb5LmfVhKCDXvVYs=;
 b=bVU0pde7wOgsXgulkdtWQ+mJxeX1SitpqxIqzcxvrV9iWJA7A4EbxG/37lFRvkqyY6
 xh05zx2NM6Qstrl2K8+owANAexN5huzILmwrMTspqQ5tK/aNqx7lw//qgtCw7j584p0G
 RiZQo3Hcsj6ERlfWvC9E9oX40r8/yfLh8YNphguFHipPOwvda9xwyy++lNLWrIP/XL+M
 o1bFg0NM5ICj8yFLNzS/34HZ6LN++EHXd6HoraIKynj2NDZFZRj78dQa8gA9zp54nuBJ
 wQJkL3HUha9BePwAaqKTfUSZOeZFBzhJIcGTGqyXyHgM6xUpyoxYI5ya2+ljDs2L1o80
 3aWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrfWkiUbX/EvhdAUEYlJcEzuhJIjKLSEtrCT6Tut8noq2D+iD10xzAb9jpXHQcggG0e0AkYUz3u3XAhrD6Kav8HH2DdUM=
X-Gm-Message-State: AOJu0Yx/ZuBgPaYO16JH0TwHVtSOa6Fc5BDOFHWtLb5EWxWVXWJzYxiB
 nIejlYLSzYKFDjlztJbxVMI2ETBvYNAgucDvrPitB/CcN9yZf92/GDsqj2pnn4Opip4FYrsHA16
 Zk+KuY5rBzKs15aS+xaoiFzBk6fI=
X-Google-Smtp-Source: AGHT+IH7MfLRTWitlK49M5yfhPijAM0PE92ZXV4rACiJQXPyjrkx3FMRGVlejwP8I+Alwq2hNWtxP+jmf/+Lw5Sa7Nc=
X-Received: by 2002:a05:6122:1699:b0:4ef:27e0:3f8c with SMTP id
 71dfb90a1353d-4f89fe80b79mr22659885e0c.0.1723028355421; Wed, 07 Aug 2024
 03:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240721072422.1377506-1-alvinga@andestech.com>
 <CAKmqyKN2hnN+wQzx3bdcFjEpo1R_rW23mR9OiCE8goJJ198-xw@mail.gmail.com>
 <SEYPR03MB6700421A6AAA65C5F310ED99A8B82@SEYPR03MB6700.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB6700421A6AAA65C5F310ED99A8B82@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 7 Aug 2024 20:58:49 +1000
Message-ID: <CAKmqyKM2uxubXW4YAdeJ_WwOQ5jC4KLYwEXin1Vt=89353nT7g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] RISC-V: Add preliminary textra trigger CSR
 functions
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Aug 7, 2024 at 3:24=E2=80=AFPM Alvin Che-Chia Chang(=E5=BC=B5=E5=93=
=B2=E5=98=89)
<alvinga@andestech.com> wrote:
>
> Hello Alistair,
>
> > -----Original Message-----
> > From: Alistair Francis <alistair23@gmail.com>
> > Sent: Wednesday, July 24, 2024 10:40 AM
> > To: Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89) <alvinga@andestec=
h.com>
> > Cc: qemu-riscv@nongnu.org; qemu-devel@nongnu.org;
> > alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com;
> > dbarboza@ventanamicro.com; zhiwei_liu@linux.alibaba.com
> > Subject: Re: [PATCH v3 0/2] RISC-V: Add preliminary textra trigger CSR
> > functions
> >
> > [EXTERNAL MAIL]
> >
> > On Sun, Jul 21, 2024 at 5:26=E2=80=AFPM Alvin Chang via <qemu-devel@non=
gnu.org>
> > wrote:
> > >
> > > According to RISC-V Debug specification, the optional textra32 and
> > > textra64 trigger CSRs can be used to configure additional matching
> > > conditions for the triggers.
> > >
> > > This series support to write MHVALUE and MHSELECT fields into textra3=
2
> > > and
> > > textra64 trigger CSRs. Besides, the additional matching condition
> > > between textra.MHVALUE and mcontext CSR is also implemented.
> > >
> > > Changes from v2:
> > > - Remove redundant log
> > >
> > > Changes from v1:
> > > - Log that mhselect only supports 0 or 4 for now
> > > - Simplify writing of tdata3
> > >
> > > Alvin Chang (2):
> > >   target/riscv: Preliminary textra trigger CSR writting support
> > >   target/riscv: Add textra matching condition for the triggers
> >
> > Thanks!
> >
> > Applied to riscv-to-apply.next
>
> I saw latest riscv-to-apply queue was submitted to qemu-devel yesterday. =
But this series was not included.
> Please allow me to inform this. Thanks!

Good catch!

The PR yesterday was just fixing bugs for the upcoming release [1].

As this series isn't a bug fix I dropped it from the PR. It will be in
the first PR for 9.2 though

1: https://wiki.qemu.org/Planning/9.1

Alistair

