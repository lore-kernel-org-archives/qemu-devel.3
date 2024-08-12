Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14E2C52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJFH-0006fX-If; Sun, 11 Aug 2024 20:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sdJFF-0006Xf-KJ; Sun, 11 Aug 2024 20:49:09 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sdJFE-000274-1q; Sun, 11 Aug 2024 20:49:09 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84118fa2af4so1201318241.1; 
 Sun, 11 Aug 2024 17:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723423746; x=1724028546; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPNkrFJPCoRIIum9aNz21BUcZj0+lt1ejbtPX4ZRjGg=;
 b=CQ49tUwMP0nZ3Kxq15tg3yt6em10hmaUDMrkK1bHf65qwNWAodWLldx9Rhelh8Cuzi
 SOCEMhztIvrpCHfT9idktk5KcYtm2ibUvLbCd+A/96yD/ZWjMfwiiMrAvCA2Xykyi9Mb
 Ah1JZNHabf7XskNTBH6K9oG4RWXeuLTm2+Nc3iNZGRs8Ou3c/oR2Eh1/qbcdQSyFx2oC
 jZfhHRtQdYKN1QxjCoYuJYkey1JNoU7swk+taVAAP0Eo/wj4fmLG6A7bltfaM9boDM7c
 0QXf1yyQ0G4c5Vw4pnEJ5EuRjsZRxzPdZmtRoiIZ3hx913TyeaGvfbLjLeaZYR68GHxe
 kYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723423746; x=1724028546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xPNkrFJPCoRIIum9aNz21BUcZj0+lt1ejbtPX4ZRjGg=;
 b=xHrdU7v3vluKTGeSLy8M8Z0J8wuK9S9fdaJzw179hoT5KmKLbQ55fYUCgN3bhsoWBe
 L506OwTvr+GwFLFxpz3qjmXyzKPY1QTFWo+BldzfbsYaipvOo7UTZdal6TfG+/wRvkQr
 Jts6EsMiuh/zpRmskHT5iGozIRZPYsfRnCwq6yIE+5RHq3WtJzkm40a1WcaNfUPNgB7N
 bzaq41Of0gsfnp75DF22BqNKTt57NLqQPh36ptdn6WV1ppgq4neJBpN5nKuxGKZ8JAt1
 loJwJ4yh8elI5PiHPcd1+MsGrFzQM1fcu3tuTOVKdz/GYxaS6XmjeNg1QtHuVqJeNcMu
 f90A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4tj1x6l3xkdrsCBPV4ZXmQSw1FHOtLRmAw2sX1jhdQ1mVcQtLYMAdK1IwLN45ba9bL/I/cwFl4OtMsMOUGRmQVqk0Vl4=
X-Gm-Message-State: AOJu0Yzi6kOSexj6YWk9iA41B/hDP5HjQ24y7mPlGGlD6yy22BtEja/N
 AFQj7bha7DqzyqcWuJPudglINC+fTz7tsHkRsj49h6Yj7K2140vEgnRj6L2CW9thnobJQtEBe6C
 M08wK3doGK4n+NJCVNKNWtNMRdFg=
X-Google-Smtp-Source: AGHT+IENk+nLmV90bSQSpuLU6SUz5Wl26wC9iWg8GjSVgfgHrKWidEXY2X32Iqw+TnwHYPd9NNeh+t0RkJqoPECtPjw=
X-Received: by 2002:a05:6102:32ce:b0:495:6aeb:a0ed with SMTP id
 ada2fe7eead31-495d83f39b9mr10026256137.3.1723423746531; Sun, 11 Aug 2024
 17:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101434.1249621-1-ethan84@andestech.com>
 <CAKmqyKPgqNaT1A0+pk6srrtPQqs6=SUX_etg55hU3rxPbuFVsA@mail.gmail.com>
 <ZrXsFaBndB0zTONi@ethan84-VirtualBox>
In-Reply-To: <ZrXsFaBndB0zTONi@ethan84-VirtualBox>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 12 Aug 2024 10:48:40 +1000
Message-ID: <CAKmqyKMAr9oXz99ndNkPFaXvCSaVcr0pskKW=HbrYoBh2qmezg@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] hw/riscv/virt: Add IOPMP support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Fri, Aug 9, 2024 at 8:14=E2=80=AFPM Ethan Chen <ethan84@andestech.com> w=
rote:
>
> On Thu, Aug 08, 2024 at 02:01:13PM +1000, Alistair Francis wrote:
> >
> > On Mon, Jul 15, 2024 at 8:15=E2=80=AFPM Ethan Chen via <qemu-devel@nong=
nu.org> wrote:
> > >
> > > - Add 'iopmp=3Don' option to enable IOPMP. It adds an iopmp device vi=
rt machine
> > >   to protect all regions of system memory, and configures RRID of CPU=
.
> > >
> > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > ---
> > >  docs/system/riscv/virt.rst |  5 +++
> > >  hw/riscv/Kconfig           |  1 +
> > >  hw/riscv/virt.c            | 63 ++++++++++++++++++++++++++++++++++++=
++
> > >  include/hw/riscv/virt.h    |  5 ++-
> > >  4 files changed, 73 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > > index 9a06f95a34..9fd006ccc2 100644
> > > --- a/docs/system/riscv/virt.rst
> > > +++ b/docs/system/riscv/virt.rst
> > > @@ -116,6 +116,11 @@ The following machine-specific options are suppo=
rted:
> > >    having AIA IMSIC (i.e. "aia=3Daplic-imsic" selected). When not spe=
cified,
> > >    the default number of per-HART VS-level AIA IMSIC pages is 0.
> > >
> > > +- iopmp=3D[on|off]
> > > +
> > > +  When this option is "on", an IOPMP device is added to machine. IOP=
MP checks
> > > +  memory transcations in system memory. This option is assumed to be=
 "off".
> >
> > We probably should have a a little more here. You don't even mention
> > that this is the rapid-k model.
>
> I'll provide more details.
>
> >
> > It might be worth adding a `model` field, to make it easier to add
> > other models in the future. Thoughts?
> >
>
> I think the IOPMP model should be a device property and not
> configured here.

It should be a device property, but then how does a user configure
that? I guess users can globally set device props, but it's a bit
clunky

Alistair

