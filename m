Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3807D16261
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0L2c-0004m7-J3; Mon, 14 Oct 2024 09:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0L2Y-0004lf-3R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:23:15 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0L2U-0000tZ-3W
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:23:11 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4604bd47e35so14437431cf.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728912185; x=1729516985; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rht7zlAs0fK/Qv3CzMwus7zCI0kj8bsRX/s2v3/ory4=;
 b=hKT1yh8SDdQ9M1834cnrhC6DLjZSnwai71eLZNSHjuhWr1rN127u+eHUlOoi8WOJSp
 4B7VweIFiAG9sOKFxo+1pbQAo2TgVoJjw4NkOuu5+35yVm1IWXCrgbWZQvaGepbIJSLX
 vLRIMMrMMTutyGI3yGR+Czq8DU/TimSpP5NVWIN0Lj+459Ktv3ydJBma6gCJQQVh+rLE
 pwTgetxNh5SoyW2JEt1zSvv7z86GTxVWeVmTNgUkf/VUBGTTIrDxsX9waXERJFNZlAdj
 jj98ZXIxMZq5MBD+itm1IfXy2WpXpE8fBbJPLB98bdFT+uw1hAqiy9D7SuOw19l2JETJ
 7SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728912185; x=1729516985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rht7zlAs0fK/Qv3CzMwus7zCI0kj8bsRX/s2v3/ory4=;
 b=d5zZA4WTGbR9c+yaOZ4DijnQ4dzqdqUz0SL1LduwWyuspzm16jxNskSye2qSrUsvb5
 WikvKtBqG8yWkNee59zFfmcnTL31CV1kb4C8HHE4upQrHqp2Oxgt7QrD2VZoQIL+tKPa
 l/eYlu9C8A4aLk0n8b+Ycnxlc85gv6qh+gyK0/sfcvzC9EgtvhP6l6MVxuxyWw2O0vhB
 9rP9npA4zAT6nLdAmuWcLuYKI83Pe+qFVgweOKufblHEFOajphWFckJQ4ZuXGtENFG7q
 cFVYD0On0kUFUo/SFFUOgh2KtDgeJ02gMNQbPspqD9KJnKzf8SVvfMLQLfhbD5yRDdCK
 XjVg==
X-Gm-Message-State: AOJu0YzvrLnwM2DU/e/mFiY4c+WOCHtX6URnLZ31ML3s9MogyhbqPI/2
 zw1+Jci8TruhV+jZs0l4z+mjM7jOWs9oQn7STYn/uX6+kRifM81DP4U4uRPN+Oo5+XBfiOo+uCr
 CJ5kJq5COlZdT4A8t8q+V74GQ2bI=
X-Google-Smtp-Source: AGHT+IHZBuzC/l0vXfnWIZXQu5F6z/tRNjQnn0/o5qHI2wi8ANNmdb6PJbNGjdan/TJ924Oj+ss6FXiPqUnTIPmhuWQ=
X-Received: by 2002:a05:622a:1889:b0:458:27f4:5e1f with SMTP id
 d75a77b69052e-4604bbb878bmr175357101cf.18.1728912185037; Mon, 14 Oct 2024
 06:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241014114135.389766-1-r.peniaev@gmail.com>
In-Reply-To: <20241014114135.389766-1-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Oct 2024 17:22:53 +0400
Message-ID: <CAJ+F1CK3kc3ePUviJbtcYgA7A-vLdqRJ56Bh5Ok6d1_9zB3u=Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] chardev/mux: implement frontend detach
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a31c6806246fbc7a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

--000000000000a31c6806246fbc7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Oct 14, 2024 at 3:47=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> Frontend device can be detached in run-time, which can lead to a
> "Chardev 'MUX' is busy" error (see the last patch with the test case
> implementation). This series implements frontend detach for the
> multiplexer based on bitset, which provides the ability to attach or
> detach frontend devices in any order.
>
> Also first patches do some refactoring the purpose of which is to make
> integer unsigned where possible (such as sizes or lengths).
>
> Roman Penyaev (8):
>   chardev/char: fix qemu_chr_is_busy() check
>   chardev/chardev-internal: remove unused `max_size` struct member
>   chardev/mux: use bool type for `linestart` and `term_got_escape`
>   chardev/mux: convert size members to unsigned int
>   chardev/mux: introduce `mux_chr_attach_frontend() call
>   chardev/mux: switch mux frontends management to bitset
>   chardev/mux: implement detach of frontends from mux
>   tests/unit/test-char: implement a few mux remove test cases
>
>  chardev/char-fe.c          | 13 ++----
>  chardev/char-mux.c         | 88 ++++++++++++++++++++++++++++----------
>  chardev/char.c             |  2 +-
>  chardev/chardev-internal.h | 16 ++++---
>  include/chardev/char-fe.h  |  2 +-
>  tests/unit/test-char.c     | 24 ++++++++++-
>  6 files changed, 103 insertions(+), 42 deletions(-)
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org


lgtm, with some pre-conditions that could be improved I belive

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
>
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000a31c6806246fbc7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 14, 2024 at 3:47=E2=80=
=AFPM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peniaev@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Frontend device can be detached in run-time, which can lead to a<br>
&quot;Chardev &#39;MUX&#39; is busy&quot; error (see the last patch with th=
e test case<br>
implementation). This series implements frontend detach for the<br>
multiplexer based on bitset, which provides the ability to attach or<br>
detach frontend devices in any order.<br>
<br>
Also first patches do some refactoring the purpose of which is to make<br>
integer unsigned where possible (such as sizes or lengths).<br>
<br>
Roman Penyaev (8):<br>
=C2=A0 chardev/char: fix qemu_chr_is_busy() check<br>
=C2=A0 chardev/chardev-internal: remove unused `max_size` struct member<br>
=C2=A0 chardev/mux: use bool type for `linestart` and `term_got_escape`<br>
=C2=A0 chardev/mux: convert size members to unsigned int<br>
=C2=A0 chardev/mux: introduce `mux_chr_attach_frontend() call<br>
=C2=A0 chardev/mux: switch mux frontends management to bitset<br>
=C2=A0 chardev/mux: implement detach of frontends from mux<br>
=C2=A0 tests/unit/test-char: implement a few mux remove test cases<br>
<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 ++----<br>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 88 ++++++++++++=
++++++++++++++++----------<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 +-<br>
=C2=A0chardev/chardev-internal.h | 16 ++++---<br>
=C2=A0include/chardev/char-fe.h=C2=A0 |=C2=A0 2 +-<br>
=C2=A0tests/unit/test-char.c=C2=A0 =C2=A0 =C2=A0| 24 ++++++++++-<br>
=C2=A06 files changed, 103 insertions(+), 42 deletions(-)<br>
<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a></blockquote><div><br></div><div>lgtm, with some pre-condition=
s that could be improved I belive<br></div><div><br></div><div>Reviewed-by:=
 Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">=
marcandre.lureau@redhat.com</a>&gt; <br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><br>
<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000a31c6806246fbc7a--

