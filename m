Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3808D1D88D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 16:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0km0-0008WR-Iw; Tue, 15 Oct 2024 12:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0kly-0008W2-V8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:51:50 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0klx-0000uM-HS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:51:50 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb5111747cso24839501fa.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 09:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729011107; x=1729615907; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DYiM0KqI0TRJDACI7x2+rplXBH2koLJUactg6yllxhI=;
 b=ikORFUEk1GVj9q5d9Tj+eFDUQDa3lLQvwCEB4NIsXFIAQ+SV4BpZUq1VkcrOr+BdBn
 Gb4HYuuatesYq9Cx1PI1DJQpUjE/ytOUrIpfjfwJHGp39gXE34Fo7GupdFdg84gXU/dn
 7mgZWmoC9mcnzBYmMDXa6wuprGS6sxtJUjETbuf78a9Fk1T8bHuPH/wuTYAy9RNF/W7e
 iFyf0+H9M2kV5bJyNn2XH9L8Vq/+gnuwPVmJSY09did7TfiBkItrg30xsnkBH+GARrPZ
 ghsNGrKgDEZgl3aYYona5QE99urRQ6FWoVB4l0xhdQt593jD8/CkXa8bDDbYGUD5zUAS
 /WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729011107; x=1729615907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DYiM0KqI0TRJDACI7x2+rplXBH2koLJUactg6yllxhI=;
 b=srb5OOsM96DkhRkcCDe1kZcpswIwGBb1bHH+hgtTXaWRpg5tw9aFtP7l0FV5Zq84RK
 MXMKsjsY3Uuo5gBXd7Rv/Ak11XGgKlJBjGw8lvAVaTA5Ujtc0YMfIaDl/GdfY4H+8khS
 JL1TIa75kTvMs74fjkcVFPYZAPTnlNDKb0um7pdsAgxqdGAm0C0DR776t03Qj2cAX2rn
 RXwm4qq+wCgqBmStFgwXBrmzj2FM9EEzxqWukE9g/2YNaNb/TR0QijGrOK4Rt1gQppCd
 mwzgZcYJSrDZnH3lMf7VM4mHCj4woCEMAu1FXC5e05t8rNULENT1TOEGAUoisMXgdm0U
 Ka/Q==
X-Gm-Message-State: AOJu0YwxpaRUeKp6Qoc+eu2TgOqc+c+RdDFKWAglAoHHHhEEiPvUvZpn
 anCQ5fBtDxIRML771r337j8D9IlsNKbz1vw3PB0SiJ1sSMa9rfv+Oh3mRgKg3bFwkR5F+xMvyJZ
 LoRhPdk0h5Vzf8rc72Pxn0yo+yLtKfw==
X-Google-Smtp-Source: AGHT+IGQleW2mYxavj4McZnZcv6CJGPDN+DNEveLqP6EqvjnNEBAECGVI1WVUlUAiAkJGnQzDIAFIWkJm3Zm1zB4EIk=
X-Received: by 2002:a2e:612:0:b0:2fb:4730:b882 with SMTP id
 38308e7fff4ca-2fb4730b8a8mr31934461fa.34.1729011106943; Tue, 15 Oct 2024
 09:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241014152408.427700-1-r.peniaev@gmail.com>
 <20241014152408.427700-9-r.peniaev@gmail.com>
 <CAMxuvazSjsWF1JQw28b4LnS+ysO-paCv5wq8dgugMiUbsU=bQg@mail.gmail.com>
In-Reply-To: <CAMxuvazSjsWF1JQw28b4LnS+ysO-paCv5wq8dgugMiUbsU=bQg@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Tue, 15 Oct 2024 18:51:35 +0200
Message-ID: <CACZ9PQURK70vkYG9n_=zAuFVTm7PoX3=eyVEK1a0es=A_mmoRQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] tests/unit/test-char: implement a few mux remove
 test cases
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d79f30062486c477"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22c.google.com
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

--000000000000d79f30062486c477
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2024, 10:50 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat=
.com>
wrote:

[cut]

>      qemu_chr_fe_deinit(&chr_be1, false);
> > -    qemu_chr_fe_deinit(&chr_be2, true);
> > +
> > +    error =3D NULL;
>
> Unnecessary assignment,
>
> > +    qmp_chardev_remove("mux-label", &error);
> > +    g_assert_cmpstr(error_get_pretty(error), =3D=3D, "Chardev 'mux-lab=
el'
> is busy");
>
> However, error_free() is missing.
> I'll touch on commit
>
> thanks
>


My bad, thanks for taking care of this.

--
Roman

--000000000000d79f30062486c477
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi,=C2=A0<br><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Oct 15, 2024, 10:50 Marc-Andr=C3=A9 L=
ureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@r=
edhat.com</a>&gt; wrote:</div><div dir=3D"ltr" class=3D"gmail_attr"><br></d=
iv><div dir=3D"ltr" class=3D"gmail_attr">[cut]</div><div dir=3D"ltr" class=
=3D"gmail_attr"><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_deinit(&amp;chr_be1, false);<br>
&gt; -=C2=A0 =C2=A0 qemu_chr_fe_deinit(&amp;chr_be2, true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 error =3D NULL;<br>
<br>
Unnecessary assignment,<br>
<br>
&gt; +=C2=A0 =C2=A0 qmp_chardev_remove(&quot;mux-label&quot;, &amp;error);<=
br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpstr(error_get_pretty(error), =3D=3D, &quot;=
Chardev &#39;mux-label&#39; is busy&quot;);<br>
<br>
However, error_free() is missing.<br>
I&#39;ll touch on commit<br>
<br>
thanks<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">My bad, thanks for taking care of this.<b=
r></div><div dir=3D"auto"><br></div><div dir=3D"auto">--</div><div dir=3D"a=
uto">Roman</div></div>

--000000000000d79f30062486c477--

