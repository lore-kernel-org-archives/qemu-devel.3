Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A1CC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 13:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD2b6-0001xD-GW; Fri, 31 May 2024 09:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sD2b4-0001wp-LQ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:47:06 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sD2b2-0006uZ-PB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:47:06 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso26869281fa.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717163221; x=1717768021; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hOEPuqonTFw/5O28aVLak0of6LjmMtGlY71TDgH6v0A=;
 b=WarWswmvaYH/bzktWYhkCQLc2mq77rv4OIvdMwb6lMLVeEm7a0clyqnwphD+C4snV9
 C8XvV2hxlULFo8oE1l6XggLvGYrxbArnyctaNxp9S6cQc24x09QypwOiMElRx34g+ylx
 63XvwImlRcF+kseaM3vJtbYLdpqyNfmCHJw/lk/42JHzvfsRSDoWKxBmNn7QIEe6j5aq
 lashQus+tRCRePuzAAqtssgjiW3ksUefx42VqtN9a5nPakEBg4LJOOKFuUXlDv9B5PQr
 Jj85jHY0JDCbW1UerfShMlB978m3gXFcLGNErIY3qOSFPen5ySdVkmVy3hqWPAawqmuF
 c5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163221; x=1717768021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOEPuqonTFw/5O28aVLak0of6LjmMtGlY71TDgH6v0A=;
 b=EPbRo/e1NY19eqPzRSLOs9wCBWiDArYMuorlBN5XxuXLmcCebv2dxxiLKH/TeKZPzu
 jkStbYnfnRqVhpTvL9s/+lcfyGFRWdPadYEMkwdoDrf9Cec9SvOJ68UMxPuvQzQmhqhc
 eHGXqkzup4ZPzbCPPJ2w5sa8FSdM40Np8LhPvw0Tu8jCfJN27Vvq9va55PLOsR83Avkl
 egRzoEyZmlSpNcqU/w7QgCrZjl7rgqaqhj+Zn9gxe9gyxG1i0MtAKKv9QiYBQcbSf9xa
 tAbGDwe+ftXAujKz1IlNMaZu2O4it5FOulA8AP/VHuyNISDYwm9dbMqO6q7pEntXR/XT
 4h+g==
X-Gm-Message-State: AOJu0YyVnhEgW1URzvrjolhbOaw1qDRf1t0w2NQu6c+21a5BV9SZ/Os/
 eSlwrDjYkH28SrRZuFactj3J9k4yRUFuvfMlO/PA93PK8lRx7psEJmcd06zjnHCyE6U3u5rLWK9
 rTE6fDkr5b46uElGZC8fn/PpKnNo=
X-Google-Smtp-Source: AGHT+IGFDrbdWl+c+cZwpQdXAaKmtUOQgGy7FxtcQ5VOo1BM06ZIYocxk4iBK+hQTqetzg/QyHrK6GWV5okPmc5yX8E=
X-Received: by 2002:a2e:9b56:0:b0:2df:97b1:d4f4 with SMTP id
 38308e7fff4ca-2ea951dfaf6mr11611451fa.33.1717163221110; Fri, 31 May 2024
 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
 <CAFfO_h57h7MX0Drw_jjym-kq8q9jFwTx7J7nYX7cxW_XY+pOsA@mail.gmail.com>
 <CAFEAcA_1AWpCyPvx6KRk6zg9zN72exozyfiw3grOb2NSGtW8iw@mail.gmail.com>
In-Reply-To: <CAFEAcA_1AWpCyPvx6KRk6zg9zN72exozyfiw3grOb2NSGtW8iw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 31 May 2024 19:46:49 +0600
Message-ID: <CAFfO_h40DsWK1NjSTu63defOPjuoehi4SevYH56wJQiammDdhg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d0dd000619c037d6"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000d0dd000619c037d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Fri, May 31, 2024, 6:53 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Fri, 3 May 2024 at 17:53, Dorjoy Chowdhury <dorjoychy111@gmail.com>
> wrote:
> >
> > On Fri, May 3, 2024 at 10:28=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org>
> wrote:
> > >
> > > On Fri, 19 Apr 2024 at 19:31, Dorjoy Chowdhury <dorjoychy111@gmail.co=
m>
> wrote:
> > > >
> > > > Some ARM CPUs advertise themselves as SMT by having the MT[24] bit
> set
> > > > to 1 in the MPIDR register. These CPUs have the thread id in
> Aff0[7:0]
> > > > bits, CPU id in Aff1[15:8] bits and cluster id in Aff2[23:16] bits =
in
> > > > MPIDR.
> > > >
> > > > On the other hand, ARM CPUs without SMT have the MT[24] bit set to =
0,
> > > > CPU id in Aff0[7:0] bits and cluster id in Aff1[15:8] bits in MPIDR=
.
> > > >
> > > > The mpidr_read_val() function always reported non-SMT i.e., MT=3D0
> style
> > > > MPIDR value which means it was wrong for the following CPUs with SM=
T
> > > > supported by QEMU:
> > > >     - cortex-a55
> > > >     - cortex-a76
> > > >     - cortex-a710
> > > >     - neoverse-v1
> > > >     - neoverse-n1
> > > >     - neoverse-n2
> > >
> > > This has definitely turned out to be rather more complicated
> > > than I thought it would be when I wrote up the original issue
> > > in gitlab, so sorry about that.
> > >
> > > I still need to think through how we should deal with the
> > > interaction between what the CPU type implies about the MPIDR
> > > format and the topology information provided by the user.
> > > I probably won't get to that next week, because I'm on holiday
> > > for most of it, but I will see if I can at least make a start.
> > >
> >
> > No problem at all. Just let me know when you get to it. I will see if
> > I can fix it or ask if I need help then. Please enjoy your holidays.
>
> Hi -- this is a note to say that I haven't forgotten about this
> patch and the related issues, but I still haven't been able to
> make the time to think through how it ought to work yet :-(
>

No problem at all. Thanks for letting me know.

Regards,
Dorjoy

>

--000000000000d0dd000619c037d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Peter,<br><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, May 31, 2024, 6:53 PM Peter Maydell &=
lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 3 May 2024 at 1=
7:53, Dorjoy Chowdhury &lt;<a href=3D"mailto:dorjoychy111@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">dorjoychy111@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, May 3, 2024 at 10:28=E2=80=AFPM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.=
maydell@linaro.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Fri, 19 Apr 2024 at 19:31, Dorjoy Chowdhury &lt;<a href=3D"mai=
lto:dorjoychy111@gmail.com" target=3D"_blank" rel=3D"noreferrer">dorjoychy1=
11@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Some ARM CPUs advertise themselves as SMT by having the MT[2=
4] bit set<br>
&gt; &gt; &gt; to 1 in the MPIDR register. These CPUs have the thread id in=
 Aff0[7:0]<br>
&gt; &gt; &gt; bits, CPU id in Aff1[15:8] bits and cluster id in Aff2[23:16=
] bits in<br>
&gt; &gt; &gt; MPIDR.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On the other hand, ARM CPUs without SMT have the MT[24] bit =
set to 0,<br>
&gt; &gt; &gt; CPU id in Aff0[7:0] bits and cluster id in Aff1[15:8] bits i=
n MPIDR.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The mpidr_read_val() function always reported non-SMT i.e., =
MT=3D0 style<br>
&gt; &gt; &gt; MPIDR value which means it was wrong for the following CPUs =
with SMT<br>
&gt; &gt; &gt; supported by QEMU:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0- cortex-a55<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0- cortex-a76<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0- cortex-a710<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0- neoverse-v1<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0- neoverse-n1<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0- neoverse-n2<br>
&gt; &gt;<br>
&gt; &gt; This has definitely turned out to be rather more complicated<br>
&gt; &gt; than I thought it would be when I wrote up the original issue<br>
&gt; &gt; in gitlab, so sorry about that.<br>
&gt; &gt;<br>
&gt; &gt; I still need to think through how we should deal with the<br>
&gt; &gt; interaction between what the CPU type implies about the MPIDR<br>
&gt; &gt; format and the topology information provided by the user.<br>
&gt; &gt; I probably won&#39;t get to that next week, because I&#39;m on ho=
liday<br>
&gt; &gt; for most of it, but I will see if I can at least make a start.<br=
>
&gt; &gt;<br>
&gt;<br>
&gt; No problem at all. Just let me know when you get to it. I will see if<=
br>
&gt; I can fix it or ask if I need help then. Please enjoy your holidays.<b=
r>
<br>
Hi -- this is a note to say that I haven&#39;t forgotten about this<br>
patch and the related issues, but I still haven&#39;t been able to<br>
make the time to think through how it ought to work yet :-(<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">No problem at al=
l. Thanks for letting me know.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Regards,</div><div dir=3D"auto">Dorjoy</div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div></di=
v></div>

--000000000000d0dd000619c037d6--

