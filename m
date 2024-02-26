Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5635C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUk6-0003dd-NS; Mon, 26 Feb 2024 01:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reUju-0003cc-7F; Mon, 26 Feb 2024 01:45:26 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reUjs-0006zu-7l; Mon, 26 Feb 2024 01:45:25 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4ce9bfffa19so285257e0c.1; 
 Sun, 25 Feb 2024 22:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708929923; x=1709534723; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFTaaCFAq/RhfYyacjBcB5FFe+2BBi9czp5A/Jh9x1E=;
 b=nGLm6GPjVxVXZiswM13khsYeaOYs/zPuKYvPLjaXo1PUaHwG4nFwILyhHboP4mV6dk
 VUIgSYWLAkeDFRxYYXRO9+8+MfPklfWlk8FSvbhZhK9hJ/c0zHyVM5yqYqaivgOIMihs
 hX6XemxV4WkHa67ESNhLlaBvYrTGVFOdTeW8/xtPb4qm1mYwzZevPKIW1rw7N3LHpoz9
 HNNkO3gZXMJDcGrnfMRSxeLBHrABz7+biV4nh2w1FVpwB6Z/wlJogA6Zkuyq/4peO/bj
 rGkvGUA+OtnEcn5rPuWl/r9w2j9HyDXGwSfYp2VHz8eejApKR1xuBwHNcPmo7Vb/RWcP
 cOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708929923; x=1709534723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFTaaCFAq/RhfYyacjBcB5FFe+2BBi9czp5A/Jh9x1E=;
 b=s6Obv2qN0ptIHvATultI/yniCDnF+UpTlpHyF5Wo70EhCdpx+ZwEwcHMhMOk7JIOKi
 +cjr2NW+ryUdc/NMzbDvXNMgk9n6j0dV+UrAjQhQX1unPH35X52MvTFLB3tRT/r2oeew
 QFrKely3ejCUz0FfeVceRKSd3M9xVJ09J8rU+9sfcAvMeHCo4BuT0adNRzWlplnzUGyj
 ZqxtKpn2NxCX2/u6Kp5BzF3mQgLLislGJKLSia5fyB5cP3iApS6U8EAQR1TVBl3WB6JY
 ikNeniBL2O34xcNgQgwik29byqBxJTUosEN06744AiUUfUwcV2FGML1hGTm+Ss27NqfN
 BFRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfgvvblHfYzkt6f2arLJuQ4RbXDNzQSWJpO/GwfhezPwRmcXhSNF3VOWTAcFEEOznnRCOY+XdDmpk9+QTTE0Z33Udw67o=
X-Gm-Message-State: AOJu0YyBXpXY51j2CxmHrzjgsajo/nv5jE+/iKppAWsx/h4heLVTJyx4
 1zGbwMWvuR98H/R9ednQhgcnJzU99pbbymfFkiF94iuoaevzY/Cky6gS/UxAUDCyAhv98A38Pq4
 IhniczHQYlHW59j06alrviCpNkFY=
X-Google-Smtp-Source: AGHT+IG4mAx/lWrqcHRKBXs/3mhSxZAqiZgyqCrIjKwWU2dD+GQ+lsSlfzzKRp+66/itLhucoFqc9dmbAd76NMsNWyc=
X-Received: by 2002:a1f:e681:0:b0:4c8:f33e:67a9 with SMTP id
 d123-20020a1fe681000000b004c8f33e67a9mr2788018vkh.5.1708929922881; Sun, 25
 Feb 2024 22:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20240223022119.41255-1-alvinga@andestech.com>
 <CAKmqyKMkXf8mJvwh2vDEGh2fq-5AP2yz2Y9k-UH1D6MuW6CgTA@mail.gmail.com>
 <SEYPR03MB6700C2BF43C958F591025714A85A2@SEYPR03MB6700.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB6700C2BF43C958F591025714A85A2@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Feb 2024 16:44:56 +1000
Message-ID: <CAKmqyKPa--pcYiZ955qqRhYeeUP2LXE5d=LVuCX58aYCGEgy1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] RISC-V: Modularize common match conditions for
 trigger
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Mon, Feb 26, 2024 at 11:16=E2=80=AFAM Alvin Che-Chia Chang(=E5=BC=B5=E5=
=93=B2=E5=98=89)
<alvinga@andestech.com> wrote:
>
> Hi Alistair,
>
> > -----Original Message-----
> > From: Alistair Francis <alistair23@gmail.com>
> > Sent: Monday, February 26, 2024 8:25 AM
> > To: Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89) <alvinga@andestec=
h.com>
> > Cc: qemu-riscv@nongnu.org; qemu-devel@nongnu.org;
> > alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com;
> > dbarboza@ventanamicro.com; zhiwei_liu@linux.alibaba.com
> > Subject: Re: [PATCH v2 0/4] RISC-V: Modularize common match conditions =
for
> > trigger
> >
> > [EXTERNAL MAIL =E5=A4=96=E9=83=A8=E4=BF=A1=E4=BB=B6]
> >
> > On Fri, Feb 23, 2024 at 12:22=E2=80=AFPM Alvin Chang via <qemu-devel@no=
ngnu.org>
> > wrote:
> > >
> > > According to RISC-V Debug specification, the enabled privilege levels
> > > of
> >
> > Can you specify what version of the debug spec?
>
> In general, this series does not add any new functionalities.
> The original implementation has duplicated code in type 2/3/6 triggers.
> I just eliminated those code and modularized them to be trigger_common_ma=
tch().
> Besides, we may want to check other conditions in the future, so this fun=
ction can be used for those purposes.

Ah, you are right. I just skimmed the message

>
> When I track the commit history, it seems the code is submitted in the fo=
llowing commits two years ago:
> https://github.com/qemu/qemu/commit/95799e36c15a9ab602a388491c40f6860f6ae=
8bf
> https://github.com/qemu/qemu/commit/b5f6379d134bd201d52380c73ff73565e6a43=
21e
> https://github.com/qemu/qemu/commit/c32461d8eeb17490b1b1e969e2ce8f1ecd83b=
fbb
> https://github.com/qemu/qemu/commit/c472c142a7552f5b0e40378d5643a2810ef1b=
111
>
> Since they mentioned the "type 6" trigger and "Sdtrig" extension, I assum=
e current implementation is based on Debug Spec version 1.0
> There is no type 6 trigger and Sdtrig extension in Debug Spec version 0.1=
3

Yeah, we are a weird mix-match of the two unfortunately. Which is why
I wanted to be explicit about which debug spec version you are
targeting.

>
> Sincerely,
> Alvin Chang
>
> >
> > Ideally if you can link directly to the PDF that would be very useful.
> > There are multiple versions so it's hard to keep track of.
> >
> > Alistair
> >
> > > the trigger is common match conditions for all the types of the trigg=
er.
> > > This series modularize the code for checking the privilege levels of
> > > type 2/3/6 triggers by implementing functions trigger_common_match()
> > > and trigger_priv_match().
> > >
> > > Additional match conditions, such as CSR tcontrol and textra, can be
> > > further implemented into trigger_common_match() in the future.
> > >
> > > Changes from v1:
> > > - Fix typo
> > > - Add commit description for changing behavior of looping the trigger=
s
> > >   when we check type 2 triggers.
> > >
> > > Alvin Chang (4):
> > >   target/riscv: Add functions for common matching conditions of trigg=
er
> > >   target/riscv: Apply modularized matching conditions for breakpoint
> > >   target/riscv: Apply modularized matching conditions for watchpoint
> > >   target/riscv: Apply modularized matching conditions for icount
> > > trigger
> > >
> > >  target/riscv/debug.c | 124
> > > +++++++++++++++++++++++++++++--------------
> > >  1 file changed, 83 insertions(+), 41 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> > >
> CONFIDENTIALITY NOTICE:
>
> This e-mail (and its attachments) may contain confidential and legally pr=
ivileged information or information protected from disclosure. If you are n=
ot the intended recipient, you are hereby notified that any disclosure, cop=
ying, distribution, or use of the information contained herein is strictly =
prohibited. In this case, please immediately notify the sender by return e-=
mail, delete the message (and any accompanying documents) and destroy all p=
rinted hard copies. Thank you for your cooperation.
>
> Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.

I'm not sure what you want me to do here

Alistair

