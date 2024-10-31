Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9EDE68955
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 11:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6TRU-00032p-0A; Thu, 31 Oct 2024 07:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t6TRS-00032Z-3S
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:34:18 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t6TRO-0006NU-Qt
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:34:16 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-460963d6233so5069481cf.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730374453; x=1730979253; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+hvLbjvy0lyCfBVxeB+vVxLKL0Z9qi/Je6W3+1ctHB0=;
 b=NCP+lbhq91M+cK1/Axfl/ZD4HQCw3W2EJurduC/rA3DU78QODfvmA/hCW7YojUEyJl
 83hw7gq6hpMujXkJ/Xwjj1bxqfFuaQVLdFcmgF9fyXDaMf50RTnJo9BrbwsGDFYcS7j5
 F4xjM+nfOA8bQCmN7i4y0zo5WYEb3PyH21A+2XGBNDInVjY0mhvaOoG2UBb/XxK4s3Ef
 F43S9xFPo/N6VljYf8dAiYm8iQSGG5GVi+NIJ2OIF9kvnDv87cCVcvi2m5QM3c6YYobp
 U4zfbA9GgcyRilPIjvpSYj5vfWeNTxZwDASb6GUZ0BtwCG7m2BPt8EtmdRsBvEd9OXDQ
 7vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730374453; x=1730979253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+hvLbjvy0lyCfBVxeB+vVxLKL0Z9qi/Je6W3+1ctHB0=;
 b=D8IetuHN8VuINS6IzHc27zXj1BglS1BYUFC/1FgOx4OltIacCOiRgE7jq6vzdttJx0
 e4plnFI4xzBGrkFKvCw/u/1950uY+IiEbnGsgxj7SFEhFX2TiQXC/SsGUEXkYTbLzvZc
 jnojO1pXlei7BPKfPEvx7XHrV6Cny0ZAKLU6T8Gduch4vS98YhWIK1njbLIdYpDxIMnD
 sABcWBfKvLhCUpgC6KxxROXkrUOb4LLN5W9hRl33vThtI8j5P0A5lYfXUh+eCSAj6hEC
 AZIaP2PHpE/VVD92PxfbRSSMkNtS+JDJVdYrUkJCC4bHfw3DJB415TePjxCju1fc/M4O
 d27w==
X-Gm-Message-State: AOJu0YxwfIEYYJCdQLMHFq05tHQP2cY8Ou2gjV2eVYH1plCrbATOXUuu
 iRLehah1sldAubHUvb9J8b/+ZRToP3B67vJFHxGTx7rS4d/TJVE6gcdbk60pAvsEDmyX6nvHYxE
 KfDGW7dn6TZg/IHpgklL0w97cBWk=
X-Google-Smtp-Source: AGHT+IFK8GtM4xp4pG7l8gUyYN/aiSHmT2Y9y1disoK74tYnoEjcoh3I/3umnbqEpbdtGM5/kx857wd9qeeNYPabHlQ=
X-Received: by 2002:ac8:59d5:0:b0:461:17e6:27b4 with SMTP id
 d75a77b69052e-462ab259d17mr35383901cf.17.1730374453224; Thu, 31 Oct 2024
 04:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241017144316.517709-1-r.peniaev@gmail.com>
 <CACZ9PQXT9xxuX40u_4J22d66hP73x4r8gUunPsMzhMS=MMTn9Q@mail.gmail.com>
In-Reply-To: <CACZ9PQXT9xxuX40u_4J22d66hP73x4r8gUunPsMzhMS=MMTn9Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 31 Oct 2024 15:34:01 +0400
Message-ID: <CAJ+F1CKtXFiYyoT3QkubESiTUo4VxYt2Ed0g_QjgU8YasAeZjw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] chardev: implement backend chardev multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009cf34b0625c4322d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, NORMAL_HTTP_TO_IP=0.001, NUMERIC_HTTP_ADDR=1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--0000000000009cf34b0625c4322d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman

On Thu, Oct 31, 2024 at 3:12=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> Hi Marc-Andr=C3=A9,
>
> In this 5th version of the mux-be series it seems I addressed all the
> comments and concerns. Could you please take a look once again?
>
>
I am not sure adding a "mux-be-id" option to all chardevs is the way to go.
To me it feels like working around the issue that arrays are not supported
on the CLI.

I would like others to comment..



> --
> Roman
>
> On Thu, Oct 17, 2024 at 4:45=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
> >
> > Mux is a character backend (host side) device, which multiplexes
> > multiple frontends with one backend device. The following is a
> > few lines from the QEMU manpage [1]:
> >
> >   A multiplexer is a "1:N" device, and here the "1" end is your
> >   specified chardev backend, and the "N" end is the various parts
> >   of QEMU that can talk to a chardev.
> >
> > But sadly multiple backends are not supported.
> >
> > This work implements multiplexing capability of several backend
> > devices, which opens up an opportunity to use a single frontend
> > device on the guest, which can be manipulated from several
> > backend devices.
> >
> > The motivation is the EVE project [2], where it would be very
> > convenient to have a virtio console frontend device on the guest that
> > can be controlled from multiple backend devices, namely VNC and local
> > TTY emulator. The following is an example of the QEMU command line:
> >
> >    -chardev mux-be,id=3Dmux0 \
> >    -chardev
> socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,mux-be-id=3Dmux=
0 \
> >    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
> >    -device virtconsole,chardev=3Dmux0 \
> >    -vnc 0.0.0.0:0
> >
> > Which creates two backend devices:
> >
> > * Text virtual console (`vc0`)
> > * A socket (`sock0`) connected to the single virtio hvc console with th=
e
> >   help of the backend multiplexer (`mux0`)
> >
> > `vc0` renders text to an image, which can be shared over the VNC
> protocol.
> > `sock0` is a socket backend which provides bidirectional communication =
to
> > the virtio hvc console.
> >
> > Once QEMU starts, the VNC client and any TTY emulator can be used to
> > control a single hvc console. For example, these two different
> > consoles should have similar input and output due to the buffer
> > multiplexing:
> >
> >    # VNC client
> >    vncviewer :0
> >
> >    # TTY emulator
> >    socat unix-connect:/tmp/sock pty,link=3D/tmp/pty
> >    tio /tmp/pty
> >
> > v4 .. v5:
> >
> > * Spelling fixes in qemu-options description
> > * Memory leaks fixes in mux-be tests
> > * Add sanity checks to chardev to avoid stacking of mux devices
> > * Add corresponding unit test case to cover the creation of stacked
> >   muxers: `-chardev mux-be,mux-id-be=3DID`, which is forbidden
> > * Reflect the fact that stacking is not supported in the documentation
> >
> > v3 .. v4:
> >
> > * Rebase on latest chardev changes
> > * Add unit tests which test corner cases:
> >    * Inability to remove mux with active frontend
> >    * Inability to add more chardevs to a mux than `MUX_MAX`
> >    * Inability to mix mux-fe and mux-be for the same chardev
> >
> > v2 .. v3:
> >
> > * Split frontend and backend multiplexer implementations and
> >   move them to separate files: char-mux-fe.c and char-mux-be.c
> >
> > v1 .. v2:
> >
> > * Separate type for the backend multiplexer `mux-be`
> > * Handle EAGAIN on write to the backend device
> > * Support of watch of previously failed backend device
> > * Proper json support of the `mux-be-id` option
> > * Unit test for the `mux-be` multiplexer
> >
> > [1] https://www.qemu.org/docs/master/system/qemu-manpage.html#hxtool-6
> > [2] https://github.com/lf-edge/eve
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: qemu-devel@nongnu.org
> >
> > Roman Penyaev (8):
> >   chardev/char: rename `MuxChardev` struct to `MuxFeChardev`
> >   chardev/char: rename `char-mux.c` to `char-mux-fe.c`
> >   chardev/char: move away mux suspend/resume calls
> >   chardev/char: rename frontend mux calls
> >   chardev/char: introduce `mux-be-id=3DID` option
> >   chardev/char-mux: implement backend chardev multiplexing
> >   tests/unit/test-char: add unit test for the `mux-be` multiplexer
> >   qemu-options.hx: describe multiplexing of several backend devices
> >
> >  chardev/char-fe.c                     |  25 +-
> >  chardev/char-mux-be.c                 | 290 +++++++++++++++++++++++
> >  chardev/{char-mux.c =3D> char-mux-fe.c} | 157 ++++---------
> >  chardev/char.c                        | 139 +++++++++--
> >  chardev/chardev-internal.h            |  55 ++++-
> >  chardev/meson.build                   |   3 +-
> >  include/chardev/char.h                |   8 +-
> >  qapi/char.json                        |  31 ++-
> >  qemu-options.hx                       |  80 +++++--
> >  system/vl.c                           |   4 +-
> >  tests/unit/test-char.c                | 323 +++++++++++++++++++++++++-
> >  11 files changed, 947 insertions(+), 168 deletions(-)
> >  create mode 100644 chardev/char-mux-be.c
> >  rename chardev/{char-mux.c =3D> char-mux-fe.c} (71%)
> >
> > --
> > 2.34.1
> >
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000009cf34b0625c4322d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Roman<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 31, 2024 at 3:12=
=E2=80=AFPM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peni=
aev@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi Marc-Andr=C3=A9,<br>
<br>
In this 5th version of the mux-be series it seems I addressed all the<br>
comments and concerns. Could you please take a look once again?<br>
<br></blockquote><div><br></div><div>I am not sure adding a &quot;mux-be-id=
&quot; option to all chardevs is the way to go. To me it feels like working=
 around the issue that arrays are not supported on the CLI.<br></div><div><=
br></div><div>I would like others to comment..<br></div><div><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
--<br>
Roman<br>
<br>
On Thu, Oct 17, 2024 at 4:45=E2=80=AFPM Roman Penyaev &lt;<a href=3D"mailto=
:r.peniaev@gmail.com" target=3D"_blank">r.peniaev@gmail.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; Mux is a character backend (host side) device, which multiplexes<br>
&gt; multiple frontends with one backend device. The following is a<br>
&gt; few lines from the QEMU manpage [1]:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0A multiplexer is a &quot;1:N&quot; device, and here the &q=
uot;1&quot; end is your<br>
&gt;=C2=A0 =C2=A0specified chardev backend, and the &quot;N&quot; end is th=
e various parts<br>
&gt;=C2=A0 =C2=A0of QEMU that can talk to a chardev.<br>
&gt;<br>
&gt; But sadly multiple backends are not supported.<br>
&gt;<br>
&gt; This work implements multiplexing capability of several backend<br>
&gt; devices, which opens up an opportunity to use a single frontend<br>
&gt; device on the guest, which can be manipulated from several<br>
&gt; backend devices.<br>
&gt;<br>
&gt; The motivation is the EVE project [2], where it would be very<br>
&gt; convenient to have a virtio console frontend device on the guest that<=
br>
&gt; can be controlled from multiple backend devices, namely VNC and local<=
br>
&gt; TTY emulator. The following is an example of the QEMU command line:<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 -chardev mux-be,id=3Dmux0 \<br>
&gt;=C2=A0 =C2=A0 -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,i=
d=3Dsock0,mux-be-id=3Dmux0 \<br>
&gt;=C2=A0 =C2=A0 -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \<br>
&gt;=C2=A0 =C2=A0 -device virtconsole,chardev=3Dmux0 \<br>
&gt;=C2=A0 =C2=A0 -vnc <a href=3D"http://0.0.0.0:0" rel=3D"noreferrer" targ=
et=3D"_blank">0.0.0.0:0</a><br>
&gt;<br>
&gt; Which creates two backend devices:<br>
&gt;<br>
&gt; * Text virtual console (`vc0`)<br>
&gt; * A socket (`sock0`) connected to the single virtio hvc console with t=
he<br>
&gt;=C2=A0 =C2=A0help of the backend multiplexer (`mux0`)<br>
&gt;<br>
&gt; `vc0` renders text to an image, which can be shared over the VNC proto=
col.<br>
&gt; `sock0` is a socket backend which provides bidirectional communication=
 to<br>
&gt; the virtio hvc console.<br>
&gt;<br>
&gt; Once QEMU starts, the VNC client and any TTY emulator can be used to<b=
r>
&gt; control a single hvc console. For example, these two different<br>
&gt; consoles should have similar input and output due to the buffer<br>
&gt; multiplexing:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 # VNC client<br>
&gt;=C2=A0 =C2=A0 vncviewer :0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 # TTY emulator<br>
&gt;=C2=A0 =C2=A0 socat unix-connect:/tmp/sock pty,link=3D/tmp/pty<br>
&gt;=C2=A0 =C2=A0 tio /tmp/pty<br>
&gt;<br>
&gt; v4 .. v5:<br>
&gt;<br>
&gt; * Spelling fixes in qemu-options description<br>
&gt; * Memory leaks fixes in mux-be tests<br>
&gt; * Add sanity checks to chardev to avoid stacking of mux devices<br>
&gt; * Add corresponding unit test case to cover the creation of stacked<br=
>
&gt;=C2=A0 =C2=A0muxers: `-chardev mux-be,mux-id-be=3DID`, which is forbidd=
en<br>
&gt; * Reflect the fact that stacking is not supported in the documentation=
<br>
&gt;<br>
&gt; v3 .. v4:<br>
&gt;<br>
&gt; * Rebase on latest chardev changes<br>
&gt; * Add unit tests which test corner cases:<br>
&gt;=C2=A0 =C2=A0 * Inability to remove mux with active frontend<br>
&gt;=C2=A0 =C2=A0 * Inability to add more chardevs to a mux than `MUX_MAX`<=
br>
&gt;=C2=A0 =C2=A0 * Inability to mix mux-fe and mux-be for the same chardev=
<br>
&gt;<br>
&gt; v2 .. v3:<br>
&gt;<br>
&gt; * Split frontend and backend multiplexer implementations and<br>
&gt;=C2=A0 =C2=A0move them to separate files: char-mux-fe.c and char-mux-be=
.c<br>
&gt;<br>
&gt; v1 .. v2:<br>
&gt;<br>
&gt; * Separate type for the backend multiplexer `mux-be`<br>
&gt; * Handle EAGAIN on write to the backend device<br>
&gt; * Support of watch of previously failed backend device<br>
&gt; * Proper json support of the `mux-be-id` option<br>
&gt; * Unit test for the `mux-be` multiplexer<br>
&gt;<br>
&gt; [1] <a href=3D"https://www.qemu.org/docs/master/system/qemu-manpage.ht=
ml#hxtool-6" rel=3D"noreferrer" target=3D"_blank">https://www.qemu.org/docs=
/master/system/qemu-manpage.html#hxtool-6</a><br>
&gt; [2] <a href=3D"https://github.com/lf-edge/eve" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/lf-edge/eve</a><br>
&gt;<br>
&gt; Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com=
" target=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
&gt; Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<b=
r>
&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-de=
vel@nongnu.org</a><br>
&gt;<br>
&gt; Roman Penyaev (8):<br>
&gt;=C2=A0 =C2=A0chardev/char: rename `MuxChardev` struct to `MuxFeChardev`=
<br>
&gt;=C2=A0 =C2=A0chardev/char: rename `char-mux.c` to `char-mux-fe.c`<br>
&gt;=C2=A0 =C2=A0chardev/char: move away mux suspend/resume calls<br>
&gt;=C2=A0 =C2=A0chardev/char: rename frontend mux calls<br>
&gt;=C2=A0 =C2=A0chardev/char: introduce `mux-be-id=3DID` option<br>
&gt;=C2=A0 =C2=A0chardev/char-mux: implement backend chardev multiplexing<b=
r>
&gt;=C2=A0 =C2=A0tests/unit/test-char: add unit test for the `mux-be` multi=
plexer<br>
&gt;=C2=A0 =C2=A0qemu-options.hx: describe multiplexing of several backend =
devices<br>
&gt;<br>
&gt;=C2=A0 chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 25 +-<br>
&gt;=C2=A0 chardev/char-mux-be.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 290 +++++++++++++++++++++++<br>
&gt;=C2=A0 chardev/{char-mux.c =3D&gt; char-mux-fe.c} | 157 ++++---------<b=
r>
&gt;=C2=A0 chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 139 +++++++++--<br>
&gt;=C2=A0 chardev/chardev-internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 55 ++++-<br>
&gt;=C2=A0 chardev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 include/chardev/char.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 31 ++-<br>
&gt;=C2=A0 qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 80 +++++--<br>
&gt;=C2=A0 system/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/unit/test-char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 323 +++++++++++++++++++++++++-<br>
&gt;=C2=A0 11 files changed, 947 insertions(+), 168 deletions(-)<br>
&gt;=C2=A0 create mode 100644 chardev/char-mux-be.c<br>
&gt;=C2=A0 rename chardev/{char-mux.c =3D&gt; char-mux-fe.c} (71%)<br>
&gt;<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000009cf34b0625c4322d--

