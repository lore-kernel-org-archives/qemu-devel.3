Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC72CEE33B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 18:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sybLS-0005iU-5F; Wed, 09 Oct 2024 14:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sybLP-0005h5-VF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:23:32 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sybLO-00009q-54
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 14:23:31 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-45ee18f05dfso1238571cf.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728498200; x=1729103000; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JHQkWvZp+V6DKYQPt97LsNFBm6Evdxw6hVq11UrDwig=;
 b=SotW71deM98LLqsLCMPolqH08R2nDc96fcjEriGjAgKuq5RShDgBZHLhp6xi7Syn8x
 ls0ORQlPjPp3bI3gOs8u22QUrtwCypNxW9Ou80YX499UwywfIC93ud7Dd54jjtPT3hR4
 PIoKKmiETsCe5uHb2LXoazShnDA1PsRugLHppTSC/04UE/DhiLbv01NXeG1ciuSsK19V
 Tf0NB6T/S3FMou3GFrlnOgqkoukdLchkxzHuyD7MokzKI1xjHDozCp/Yh/6ilbAMp64k
 41vNP3KuvaqOIILuJWroH9WmHajBPriO4yIj0YdG99YKmFUNusRuJJ26Rvn6LBzIw6hF
 N1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728498200; x=1729103000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JHQkWvZp+V6DKYQPt97LsNFBm6Evdxw6hVq11UrDwig=;
 b=d4l7O9TIAZW84owfp9bBbUoFhIjY/RfHxcHFZZKrH3sLnEtcYIi5ipepjktMLMIfv2
 eqWgye5KGxvFoi+xTs3ErhoI/1/dDIT6MRWpDTNvXEUYoa0oMJA5lXyV2/RyqKz/lgNf
 5pIbLLU3tgW82xSDgKMPUjedJfh+icEJKvmxROo+a5aEbIYTazt4r2q/tIbQD2ultYlK
 wgO/DVDlW+amlCFybJDrlziLdsTLE5GUFVVRTjxgoL54Ff4tsYQrGuCX8OgZHzwnO7l9
 qNO08FCdRiiV5bB88FATppdTsLsQrY2EM7S96+AVQ6QamZWEVSCB3Igr1MFK3TLh7xy/
 t7mg==
X-Gm-Message-State: AOJu0YxlR+D2hwT69DthwyuwKps6JwmE7ymxSaKhdoltdvn0uWvDZNzi
 tACwZs6pyWZ6Wcqwg2gozYpopAkewuAdDADbW8ONxjOf9u+QV5R5filihh7sBusNVTll3GLAye9
 dmsBZwTSGId1WjIfpxBA7791TfHM=
X-Google-Smtp-Source: AGHT+IGrHdnzzYDRsiVe74eM4Jl8IBn2CRXpfwqaQxxy16iVO4jKll60g9HCyQSAOiVc7mpRo+VTZiXCJ2vrvYHlVJM=
X-Received: by 2002:a05:622a:244d:b0:458:2b0f:6b59 with SMTP id
 d75a77b69052e-45fb0e3e402mr39635141cf.48.1728498200379; Wed, 09 Oct 2024
 11:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241009174517.286935-1-r.peniaev@gmail.com>
In-Reply-To: <20241009174517.286935-1-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 9 Oct 2024 22:23:08 +0400
Message-ID: <CAJ+F1C+JrO3zVEcFKSB2nm6xyY8HmLhAg_ZSXfwTzQcf3+rE+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] chardev: implement backend chardev multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003a89fb06240f597e"
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

--0000000000003a89fb06240f597e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman

On Wed, Oct 9, 2024 at 9:47=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com> =
wrote:

> Mux is a character backend (host side) device, which multiplexes
> multiple frontends with one backend device. The following is a
> few lines from the QEMU manpage [1]:
>
>   A multiplexer is a "1:N" device, and here the "1" end is your
>   specified chardev backend, and the "N" end is the various parts
>   of QEMU that can talk to a chardev.
>
> But sadly multiple backends are not supported.
>
> This work implements multiplexing capability of several backend
> devices, which opens up an opportunity to use a single frontend
> device on the guest, which can be manipulated from several
> backend devices.
>
> The motivation is the EVE project [2], where it would be very
> convenient to have a virtio console frontend device on the guest that
> can be controlled from multiple backend devices. The following is
> an example of the QEMU command line:
>
>    -chardev mux-be,id=3Dmux0 \
>    -chardev
> socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,mux-be-id=3Dmux=
0 \
>    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
>    -device virtconsole,chardev=3Dmux0 \
>    -vnc 0.0.0.0:0
>
> Which creates 2 backend devices: text virtual console (`vc0`) and a
> socket (`sock0`) connected to the single virtio hvc console with the
> backend multiplexer (`mux0`) help. `vc0` renders text to an image,
> which can be shared over the VNC protocol.  `sock0` is a socket
> backend which provides biderectional communication to the virtio hvc
> console.
>
> New type of multiplexer `mux-be` actually is an alias for the same
> `MuxChardev` struct, which uses same functions as for the original
> `mux` type, but supports multiplexing N backends with 1 frontend.
>
> Once QEMU starts VNC client and any TTY emulator can be used to
> control a single hvc console, for example these two different
> consoles should have similar input and output due the buffer
> multiplexing:
>
>    # VNC client
>    vncviewer :0
>
>    # TTY emulator
>    socat unix-connect:/tmp/sock pty,link=3D/tmp/pty
>    tio /tmp/pty
>
> Difference to the previous version:
>
> * Separate type for the backend multiplexer `mux-be`
> * Handle EAGAIN on write to the backend device
> * Support of watch of previously failed backend device
> * Proper json support of the `mux-be-id` option
> * Unit test for the `mux-be` multiplexer
>
> [1] https://www.qemu.org/docs/master/system/qemu-manpage.html#hxtool-6
> [2] https://github.com/lf-edge/eve
>
> Roman Penyaev (5):
>   chardev/char: introduce `mux-be-id=3DID` option and _MUX_BE type
>   chardev/char: rename `mux_cnt` to `fe_cnt` for the `MuxChardev`
>   chardev/char-mux: implement backend chardev multiplexing
>   tests/unit/test-char: add unit test for the `mux-be` multiplexer
>   qemu-options.hx: describe multiplexing of several backend devices
>

Please rebase, it fails to apply cleanly on master.

Can you try to split MuxChardev in a base common class? You could have
MuxBase or simply Mux abstract, with MuxFe (for 'mux') & MuxBe (for
'mux-be'). This should clarify the code a bit and avoid sharing the same
struct with unused fields.

Thanks for the tests, that helps a lot!


>  chardev/char-fe.c          |  14 ++-
>  chardev/char-mux.c         | 212 +++++++++++++++++++++++++++++++-----
>  chardev/char.c             |  57 ++++++++--
>  chardev/chardev-internal.h |  33 +++++-
>  include/chardev/char.h     |   1 +
>  qapi/char.json             |   9 +-
>  qemu-options.hx            |  46 +++++++-
>  tests/unit/test-char.c     | 217 ++++++++++++++++++++++++++++++++++++-
>  8 files changed, 538 insertions(+), 51 deletions(-)
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
>
> --
> 2.43.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000003a89fb06240f597e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Roman<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 9, 2024 at 9:47=
=E2=80=AFPM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peni=
aev@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Mux is a character backend (host side) device, which multiplex=
es<br>
multiple frontends with one backend device. The following is a<br>
few lines from the QEMU manpage [1]:<br>
<br>
=C2=A0 A multiplexer is a &quot;1:N&quot; device, and here the &quot;1&quot=
; end is your<br>
=C2=A0 specified chardev backend, and the &quot;N&quot; end is the various =
parts<br>
=C2=A0 of QEMU that can talk to a chardev.<br>
<br>
But sadly multiple backends are not supported.<br>
<br>
This work implements multiplexing capability of several backend<br>
devices, which opens up an opportunity to use a single frontend<br>
device on the guest, which can be manipulated from several<br>
backend devices.<br>
<br>
The motivation is the EVE project [2], where it would be very<br>
convenient to have a virtio console frontend device on the guest that<br>
can be controlled from multiple backend devices. The following is<br>
an example of the QEMU command line:<br>
<br>
=C2=A0 =C2=A0-chardev mux-be,id=3Dmux0 \<br>
=C2=A0 =C2=A0-chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Ds=
ock0,mux-be-id=3Dmux0 \<br>
=C2=A0 =C2=A0-chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \<br>
=C2=A0 =C2=A0-device virtconsole,chardev=3Dmux0 \<br>
=C2=A0 =C2=A0-vnc <a href=3D"http://0.0.0.0:0" rel=3D"noreferrer" target=3D=
"_blank">0.0.0.0:0</a><br>
<br>
Which creates 2 backend devices: text virtual console (`vc0`) and a<br>
socket (`sock0`) connected to the single virtio hvc console with the<br>
backend multiplexer (`mux0`) help. `vc0` renders text to an image,<br>
which can be shared over the VNC protocol.=C2=A0 `sock0` is a socket<br>
backend which provides biderectional communication to the virtio hvc<br>
console.<br>
<br>
New type of multiplexer `mux-be` actually is an alias for the same<br>
`MuxChardev` struct, which uses same functions as for the original<br>
`mux` type, but supports multiplexing N backends with 1 frontend.<br>
<br>
Once QEMU starts VNC client and any TTY emulator can be used to<br>
control a single hvc console, for example these two different<br>
consoles should have similar input and output due the buffer<br>
multiplexing:<br>
<br>
=C2=A0 =C2=A0# VNC client<br>
=C2=A0 =C2=A0vncviewer :0<br>
<br>
=C2=A0 =C2=A0# TTY emulator<br>
=C2=A0 =C2=A0socat unix-connect:/tmp/sock pty,link=3D/tmp/pty<br>
=C2=A0 =C2=A0tio /tmp/pty<br>
<br>
Difference to the previous version:<br>
<br>
* Separate type for the backend multiplexer `mux-be`<br>
* Handle EAGAIN on write to the backend device<br>
* Support of watch of previously failed backend device<br>
* Proper json support of the `mux-be-id` option<br>
* Unit test for the `mux-be` multiplexer<br>
<br>
[1] <a href=3D"https://www.qemu.org/docs/master/system/qemu-manpage.html#hx=
tool-6" rel=3D"noreferrer" target=3D"_blank">https://www.qemu.org/docs/mast=
er/system/qemu-manpage.html#hxtool-6</a><br>
[2] <a href=3D"https://github.com/lf-edge/eve" rel=3D"noreferrer" target=3D=
"_blank">https://github.com/lf-edge/eve</a><br>
<br>
Roman Penyaev (5):<br>
=C2=A0 chardev/char: introduce `mux-be-id=3DID` option and _MUX_BE type<br>
=C2=A0 chardev/char: rename `mux_cnt` to `fe_cnt` for the `MuxChardev`<br>
=C2=A0 chardev/char-mux: implement backend chardev multiplexing<br>
=C2=A0 tests/unit/test-char: add unit test for the `mux-be` multiplexer<br>
=C2=A0 qemu-options.hx: describe multiplexing of several backend devices<br=
></blockquote><div><br></div><div>Please rebase, it fails to apply cleanly =
on master.</div><div><br></div><div>Can you try to split MuxChardev in a ba=
se common class? You could have MuxBase or simply Mux abstract, with MuxFe =
(for &#39;mux&#39;) &amp; MuxBe (for &#39;mux-be&#39;). This should clarify=
 the code a bit and avoid sharing the same struct with unused fields.<br></=
div><div><br></div><div>Thanks for the tests, that helps a lot!</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 ++-<br=
>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 212 +++++++++++=
++++++++++++++++++++-----<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 57 ++++++++--<br>
=C2=A0chardev/chardev-internal.h |=C2=A0 33 +++++-<br>
=C2=A0include/chardev/char.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A09 +-<br>
=C2=A0qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 46 +=
++++++-<br>
=C2=A0tests/unit/test-char.c=C2=A0 =C2=A0 =C2=A0| 217 +++++++++++++++++++++=
+++++++++++++++-<br>
=C2=A08 files changed, 538 insertions(+), 51 deletions(-)<br>
<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000003a89fb06240f597e--

