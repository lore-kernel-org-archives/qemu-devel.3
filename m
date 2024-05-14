Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02090C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uhi-0000ic-4Z; Tue, 14 May 2024 12:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s6uha-0000i2-Fz; Tue, 14 May 2024 12:08:30 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s6uhY-0008IO-Hh; Tue, 14 May 2024 12:08:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso413044a12.3; 
 Tue, 14 May 2024 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715702905; x=1716307705; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5k+/i3+2q0m+c/EnilIbx/pYX31595rahMkFAgHWYBE=;
 b=GAjzHQh5o1lC6wtPZ7U4UGRYMPd3euBoVrBlztNInlb3i6GGNDmzHOZMs9Gd51eZC9
 RVSI5HTjaSY045EBn62lMtJ5BFbt3XvT1FRVdr7RhbtUfbgcyHpmMPbH4Nl6lV18Nnzo
 gRNiuYPIpIiKKMd02p3NyuAGcm2p3yRvSzND6xfEgUHUtSxIvF1ll7JPydUbSEJUN3K3
 UeWMCAHNuOiA8WW1B8vF65C63Q9vthchTSt76Mstg3cE12SPXV73TlRLBrBkb7tPHByX
 Bl19S3ryiThXOyzmcSEFtOBpc6O4KjdkHQCPUvkUGQTn1tyF9ciMNq/TPgwbbPCH2X2f
 A8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715702905; x=1716307705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5k+/i3+2q0m+c/EnilIbx/pYX31595rahMkFAgHWYBE=;
 b=FVhcvf/6M40xE/PIII6Jqgiu5qD8rMLq1UWsS81WehBBViyAEmt6c0k7Q1r3SU5Da6
 MrkfNbKjNz3Xyxx3oPOzsWmuvoqhPKreIc+mz7SvC/HIjuAMqxSwa/+8/+db6PJ6tKFJ
 PzPnqbSxWDNHDTC5vE5CT3uPZT71sWnV5xgN1FCoAl2OiWTng1Cqn7qP5Nw/FnK4ahPT
 POhNWh2ycwfA9h8x8nj6EatB/4pWk2glGmJhNcJs7/CJH7/r0cTo9Us6wm5lqsUjj5qd
 SZ+k+xQlCu2FMEEw8W8wVZrxuOwf5EhaayRZBaWnHr8yyeTjee5edFPN8YgZcJWPp2Ti
 wodQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo/EaUpTOOfwLmWKAx17Tm9e6bveLNH3nSZogdBc8lVCaoaR7uevc5/UZJ5GyWc5MgMVzfwUaEv4dSFrLwzcwkSaSJ1MvvmP+ECrqjNrhF2k1e4OISN8LnUp4C5w==
X-Gm-Message-State: AOJu0YxYczoPJl8a5sP7f8+vwtUswZhNmElKZNmLA4bvFjD7CdNWXjKk
 pC4OMUH8ENiOPmAV+r/YQQ+lQpqDiEWRaw0TEaxiEa5UrhPTcJEGzU/Twy12iVm2SAPtSlRaYrz
 gULpnirnt2+88pQlcNZrHcREpCkA=
X-Google-Smtp-Source: AGHT+IEE74u4yD+0sV+LoWW5oEkFMd6H3rYgOiMv3a259R6NgZWNG6OXFzJet9J8eLb3z/hoZoPRkOMLBzmxHPdaA4g=
X-Received: by 2002:a50:9f8f:0:b0:572:a23d:7912 with SMTP id
 4fb4d7f45d1cf-5734d5c2584mr8753612a12.13.1715702904608; Tue, 14 May 2024
 09:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <b732f7bd-53d2-4c66-9821-a5bd589f6c56@gmail.com>
 <CAKmqyKM+2jhFdAL=3Z0De03hBFR6cn2xtVm3FrkPvn=U8tJLpg@mail.gmail.com>
 <CAFukJ-CfsChuYbpdUP9EOPEEn0s=jdBmp9aV691U8By68HV6Aw@mail.gmail.com>
 <CAKmqyKOQLTYm7F8NBeoSmL1B6icfPzuH-ZHPXhz+wJLrjJyd6w@mail.gmail.com>
 <CAKmqyKMtJPGXs+rXFzfN7jqYTMbKBQ2SYVYoQ5kONT-FKkp=9g@mail.gmail.com>
In-Reply-To: <CAKmqyKMtJPGXs+rXFzfN7jqYTMbKBQ2SYVYoQ5kONT-FKkp=9g@mail.gmail.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Tue, 14 May 2024 19:08:13 +0300
Message-ID: <CAFukJ-D9SMJUoSDOf5us5QXY2VM79Xbi=siy7obOo42B3fLxXg@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Alistair Francis <alistair23@gmail.com>
Cc: liwei <liwei1518@gmail.com>, richard.henderson@linaro.org, 
 space.monkey.delivers@gmail.com, palmer@dabbelt.com, Alistair.Francis@wdc.com, 
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002b5da006186c3637"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002b5da006186c3637
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>The cover letter says that this implements version 1.0 of the spec, this
sounds like it doesn't.
Yeah, sorry about the confusion. Yes, the patch is actually for v0.8 but as
you've correctly mentioned v0.8 has not so much differences to v1.0.

> Instead of constantly removing and re-adding the code
I was talking about only one removing the existing code and replacing it
with current patches and then making updates on top of them.

>Do you mind fixing that and addressing the other comments/concerns
Sure

=D0=BF=D0=BD, 13 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 14:32, Alis=
tair Francis <alistair23@gmail.com>:

> On Mon, May 13, 2024 at 9:14=E2=80=AFPM Alistair Francis <alistair23@gmai=
l.com>
> wrote:
> >
> > On Mon, May 13, 2024 at 9:05=E2=80=AFPM Alexey Baturo <baturo.alexey@gm=
ail.com>
> wrote:
> > >
> > > Hi,
> > >
> > > > Hi, any change from v0.8 to v1.0?
> > > Not in the patches that were sent. I'd still suggest applying a
> step-by-step approach with cleaning up old code and establishing the new
> mechanisms first and then updating the code to match the spec 100%. Also =
I
> heard Martin has some arch compliance tests for J-ext somewhere.
> >
> > The cover letter says that this implements version 1.0 of the spec,
> > this sounds like it doesn't.
> >
> > Also, it's better to make the changes on top of the current code.
> > Instead of constantly removing and re-adding the code. Which is then
> > hard to review. Especially as I'm guessing there isn't a huge
> > difference between v0.8 and v1.0.
> >
> > > @Alistair Francis @liwei does this approach sound reasonable to you?
> > >
> > > >Also, this needs another rebase
> > > Sure, no problem at all. I'll rebase and re-send them later today.
>
> Sorry, it did apply correctly! That was my mistake.
>
> But this series generates a warning. Do you mind fixing that and
> addressing the other comments/concerns
>
> Alistair
>
> >
> > Thanks. Can you be very clear which version of the spec you have
> > developed and tested against as well.
> >
> > Alistair
>

--0000000000002b5da006186c3637
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;The cover letter says that this implements version 1.0=
 of the spec, this sounds like it doesn&#39;t.<div>Yeah, sorry about the co=
nfusion. Yes, the patch is actually for v0.8 but as you&#39;ve correctly me=
ntioned v0.8 has not so much differences to v1.0.</div><div><br></div>&gt; =
Instead of constantly removing and re-adding the code<div>I was talking abo=
ut only one removing=C2=A0the existing code and replacing it with current p=
atches and then making updates on top of them.</div><div><br></div>&gt;Do y=
ou mind fixing that and addressing the other comments/concerns<div>Sure<br>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=
=D0=BD, 13 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 14:32, Alistair F=
rancis &lt;<a href=3D"mailto:alistair23@gmail.com" target=3D"_blank">alista=
ir23@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Mon, May 13, 2024 at 9:14=E2=80=AFPM Alistair Francis &lt;<a hre=
f=3D"mailto:alistair23@gmail.com" target=3D"_blank">alistair23@gmail.com</a=
>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, May 13, 2024 at 9:05=E2=80=AFPM Alexey Baturo &lt;<a href=3D"m=
ailto:baturo.alexey@gmail.com" target=3D"_blank">baturo.alexey@gmail.com</a=
>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; &gt; Hi, any change from v0.8 to v1.0?<br>
&gt; &gt; Not in the patches that were sent. I&#39;d still suggest applying=
 a step-by-step approach with cleaning up old code and establishing the new=
 mechanisms first and then updating the code to match the spec 100%. Also I=
 heard Martin has some arch compliance tests for J-ext somewhere.<br>
&gt;<br>
&gt; The cover letter says that this implements version 1.0 of the spec,<br=
>
&gt; this sounds like it doesn&#39;t.<br>
&gt;<br>
&gt; Also, it&#39;s better to make the changes on top of the current code.<=
br>
&gt; Instead of constantly removing and re-adding the code. Which is then<b=
r>
&gt; hard to review. Especially as I&#39;m guessing there isn&#39;t a huge<=
br>
&gt; difference between v0.8 and v1.0.<br>
&gt;<br>
&gt; &gt; @Alistair Francis @liwei does this approach sound reasonable to y=
ou?<br>
&gt; &gt;<br>
&gt; &gt; &gt;Also, this needs another rebase<br>
&gt; &gt; Sure, no problem at all. I&#39;ll rebase and re-send them later t=
oday.<br>
<br>
Sorry, it did apply correctly! That was my mistake.<br>
<br>
But this series generates a warning. Do you mind fixing that and<br>
addressing the other comments/concerns<br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt; Thanks. Can you be very clear which version of the spec you have<br>
&gt; developed and tested against as well.<br>
&gt;<br>
&gt; Alistair<br>
</blockquote></div></div></div>

--0000000000002b5da006186c3637--

