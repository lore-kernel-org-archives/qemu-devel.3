Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E98C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrk0-0003h3-RH; Mon, 22 Jul 2024 08:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVrj9-00085d-Rg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:23 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVrj7-0006Z1-3p
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:14 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-449f23df593so20847001cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721649671; x=1722254471; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Fln7ND/XFf9546dWeieHTYfFN5qdhIFy3sUae7oFtY=;
 b=gtqVW0p3Mkr8dnfq7EpeG5EoLFkWusASy6Wjn3ny5G7GdUkNgpdws9R9IuacNCLk/f
 EWgMEKTUugTFkHJaYXcXDNUuq1EPMYBlNHIgC6sbtHhws2rGY6CSzsGmXMP3m+iL+P2O
 2Wh2gZXkZwEqZVX7QH+ZyxdgkBWR8MwNfWQyCPNfdgI3euVEYncprBuYT6U1/IlZt8BG
 RrNV4Z5TQVsyQGGKuo+H53GY1e8KIqt9hXn2Y1eR70VpLWF+O8wCk3Yx2ihru5MiP+pg
 Owb2rVw7KFqlwK80YNWI7hbj8TDL1CmtiDSgdUrAZzKcmiNTqeBvPl7wm6x5Ym5VzPJ6
 84tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649671; x=1722254471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Fln7ND/XFf9546dWeieHTYfFN5qdhIFy3sUae7oFtY=;
 b=aven6r0kB+VR5fCstUu/hpP3ucO9D3oA5i2DYtu5xSTLjeBTn4Hc/jcKyfO4G/7YkX
 XCdzLhMRhhikNzk1UTaZajbyMYyqwUuTj0jyVJtgLAtIMXU0Q5T2JyndIV0ERorbettE
 KxLu1Ij7DqLLCahKijgccjZGqsRcvjWsih2ZSxhM2quvvVBLonxPgF1/LAytZloR8kfq
 o8bTTTB2n/MXep+KDFVn66/6IZa++n7ZwrO0Is4F0aIEvl5CnO/GfE7RybmViK/NVEw4
 LPEBimwgAEzSwr75BTsILYgu8D8eWHIwwUK33uT/hP3jJkRXoA+ZDKZBVvG1p8YrwcAy
 5MZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkyIzdgCVuNdyn4RtOFXYz1/VMN5VvcTFZaoYFdKS7aiPOuFtGvbMTP96Q0UjFRZBhO+RQUTmjLvf3u9APIklENAS2DRA=
X-Gm-Message-State: AOJu0YxuhqU88bXmC6fEzlAYf43qZ8Fv/b1MdhJHx4AS7ufnh1a8dVtY
 w0fVNzHRrcU26uMhg1gxnjMG7toH3gaPSszj9caUvVd14/AdgOsJN7lrJ5WN5ogS5xRfabywcVR
 fMlREYXhssrX63E5YRkMAUwOhP5Of5+AM
X-Google-Smtp-Source: AGHT+IHP1cSd6E9heOxhPOyiv6+Qx4G3corQtqt0GjtY0XKv7K7eaHeEZLtQnev++yuGsUev+n4MKdccFw3g8amqIpM=
X-Received: by 2002:a05:622a:1193:b0:447:f211:43f2 with SMTP id
 d75a77b69052e-44fa5261984mr107033441cf.12.1721649671428; Mon, 22 Jul 2024
 05:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <172150520664.2040.13953223569736513482-0@git.sr.ht>
 <CAJ+F1CJrhUD5wyQDDauoTY=hok0BM7hUx99+5mK4tC4YkhtM4g@mail.gmail.com>
 <CAAiTLFVv8_i4ucbRQOSi9=ARz7kPzV--8HNzZ05zoeKvuOkt5w@mail.gmail.com>
In-Reply-To: <CAAiTLFVv8_i4ucbRQOSi9=ARz7kPzV--8HNzZ05zoeKvuOkt5w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jul 2024 16:00:59 +0400
Message-ID: <CAJ+F1CLGQzp-CpNVZZx8w4bi9NLUc3Q+-ReOO7C8xjNxKpQhyQ@mail.gmail.com>
Subject: Re: [PATCH qemu] ui/gtk: Reuse input event slots for GdkEventTouch
To: Sergio Lopez Pascual <slp@redhat.com>
Cc: "~katharine_chui" <kwchuiaa@connect.ust.hk>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000017e211061dd4cd13"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

--00000000000017e211061dd4cd13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 22, 2024 at 3:58=E2=80=AFPM Sergio Lopez Pascual <slp@redhat.co=
m> wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > Adding Sergio in CC, who wrote that code. I don't have means to test it=
,
> > which also limits my understanding and ability to check this.
> >
> > On Sat, Jul 20, 2024 at 11:58=E2=80=AFPM ~katharine_chui <
> katharine_chui@git.sr.ht>
> > wrote:
> >
> >> From: Katharine Chui <kwchuiaa@connect.ust.hk>
> >>
> >> There seems to be no guarantee as to how GdkEventTouch.sequence
> >> would progress https://docs.gtk.org/gdk3/struct.EventTouch.html
> >>
> >>
> > True, we also abuse the internal implementation which stores low intege=
rs
> > in the sequence pointer.
> >
> > In the case of steam gamescope session, touch input would
> >> increment the number every touch, resulting in all touch inputs
> >> after the 10th touch to get dropped
> >>
> >> ...
> >> qemu: warning: Unexpected touch slot number:  10 >=3D 10
> >> qemu: warning: Unexpected touch slot number:  11 >=3D 10
> >> qemu: warning: Unexpected touch slot number:  12 >=3D 10
> >> qemu: warning: Unexpected touch slot number:  13 >=3D 10
> >> qemu: warning: Unexpected touch slot number:  14 >=3D 10
> >> ...
> >>
> >> Reuse the slots on gtk to avoid that
> >>
> >
> > But doing modulo like this, there is a chance of conflict with already
> used
> > slots.
> >
> > Maybe it's time for a better gtk implementation which would handle a
> proper
> > sequence pointer to slot mapping.
>
> The problem with slots vs. sequences is that, from what I can see,
> there's not way to obtain the slot number from EventTouch, which makes
> me thing we're a little to high in the abstraction layer to emulate
> multi-touch properly. And with GTK4 it seems to be even worse, because
> it tries harder to process gestures on its own (we need them to be
> processed by the guest instead).
>
> Under some compositors, we were lucky enough that indeed slots =3D=3D
> sequences, so we could actually pass those events as that and have the
> guest process and recognize simple gestures (i.e. pinching) properly.
>
> The "right" solution would be finding a way to operate at a lower level
> than what EventTouch provides us today, but I don't know how feasible is
> that from within the limits of the ui/gtk3.c.
>
> In case that's not possible, the modulo workaround is probably as good
> as we can get.
>

Can't we map the sequence pointer to a (reusable) counter? So up to
max-slots sequences could be mapped uniquely and we would reject events
that do not fit within max-slots.


--=20
Marc-Andr=C3=A9 Lureau

--00000000000017e211061dd4cd13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 22, 2024 at 3:58=E2=80=
=AFPM Sergio Lopez Pascual &lt;<a href=3D"mailto:slp@redhat.com">slp@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com=
" target=3D"_blank">marcandre.lureau@gmail.com</a>&gt; writes:<br>
<br>
&gt; Hi<br>
&gt;<br>
&gt; Adding Sergio in CC, who wrote that code. I don&#39;t have means to te=
st it,<br>
&gt; which also limits my understanding and ability to check this.<br>
&gt;<br>
&gt; On Sat, Jul 20, 2024 at 11:58=E2=80=AFPM ~katharine_chui &lt;<a href=
=3D"mailto:katharine_chui@git.sr.ht" target=3D"_blank">katharine_chui@git.s=
r.ht</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; From: Katharine Chui &lt;<a href=3D"mailto:kwchuiaa@connect.ust.hk=
" target=3D"_blank">kwchuiaa@connect.ust.hk</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; There seems to be no guarantee as to how GdkEventTouch.sequence<br=
>
&gt;&gt; would progress <a href=3D"https://docs.gtk.org/gdk3/struct.EventTo=
uch.html" rel=3D"noreferrer" target=3D"_blank">https://docs.gtk.org/gdk3/st=
ruct.EventTouch.html</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; True, we also abuse the internal implementation which stores low integ=
ers<br>
&gt; in the sequence pointer.<br>
&gt;<br>
&gt; In the case of steam gamescope session, touch input would<br>
&gt;&gt; increment the number every touch, resulting in all touch inputs<br=
>
&gt;&gt; after the 10th touch to get dropped<br>
&gt;&gt;<br>
&gt;&gt; ...<br>
&gt;&gt; qemu: warning: Unexpected touch slot number:=C2=A0 10 &gt;=3D 10<b=
r>
&gt;&gt; qemu: warning: Unexpected touch slot number:=C2=A0 11 &gt;=3D 10<b=
r>
&gt;&gt; qemu: warning: Unexpected touch slot number:=C2=A0 12 &gt;=3D 10<b=
r>
&gt;&gt; qemu: warning: Unexpected touch slot number:=C2=A0 13 &gt;=3D 10<b=
r>
&gt;&gt; qemu: warning: Unexpected touch slot number:=C2=A0 14 &gt;=3D 10<b=
r>
&gt;&gt; ...<br>
&gt;&gt;<br>
&gt;&gt; Reuse the slots on gtk to avoid that<br>
&gt;&gt;<br>
&gt;<br>
&gt; But doing modulo like this, there is a chance of conflict with already=
 used<br>
&gt; slots.<br>
&gt;<br>
&gt; Maybe it&#39;s time for a better gtk implementation which would handle=
 a proper<br>
&gt; sequence pointer to slot mapping.<br>
<br>
The problem with slots vs. sequences is that, from what I can see,<br>
there&#39;s not way to obtain the slot number from EventTouch, which makes<=
br>
me thing we&#39;re a little to high in the abstraction layer to emulate<br>
multi-touch properly. And with GTK4 it seems to be even worse, because<br>
it tries harder to process gestures on its own (we need them to be<br>
processed by the guest instead).<br>
<br>
Under some compositors, we were lucky enough that indeed slots =3D=3D<br>
sequences, so we could actually pass those events as that and have the<br>
guest process and recognize simple gestures (i.e. pinching) properly.<br>
<br>
The &quot;right&quot; solution would be finding a way to operate at a lower=
 level<br>
than what EventTouch provides us today, but I don&#39;t know how feasible i=
s<br>
that from within the limits of the ui/gtk3.c.<br>
<br>
In case that&#39;s not possible, the modulo workaround is probably as good<=
br>
as we can get.<br clear=3D"all"></blockquote><div><br></div><div>Can&#39;t =
we map the sequence pointer to a (reusable) counter? So up to max-slots seq=
uences could be mapped uniquely and we would reject events that do not fit =
within max-slots.</div><div> <br></div></div><br><span class=3D"gmail_signa=
ture_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-=
Andr=C3=A9 Lureau<br></div></div>

--00000000000017e211061dd4cd13--

