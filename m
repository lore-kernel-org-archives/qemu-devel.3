Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39E9C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNOw-00077R-B5; Tue, 20 Feb 2024 05:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcNOh-00075d-HV; Tue, 20 Feb 2024 05:30:47 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rcNOf-0000Is-Mk; Tue, 20 Feb 2024 05:30:47 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-21e2673a206so3401431fac.2; 
 Tue, 20 Feb 2024 02:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708425044; x=1709029844; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fyzB5YCU69e9aRpVkB+NNMXTDYsdgwjqpgK8fMoXVPc=;
 b=JxJpRSxmLh3RfqM5iSOb+AJ4t6VV4J7uWHKFYt3nvNOMO3694pOTFO/FdbAqiCFzj9
 FxpbSiVUaNwyGweYNeu8D4ChCK9Zjirr6bGL5vN50/D9WmTW+DkcUYmXNa3TTW7I9AiF
 eR2IP+AnCMc7fpsQHVXegVL7iqOmfnC5dm0kNE1WSWOwuvmGq/fEPZXZR3GoRGZC5N/C
 qZORJkx2p//DKL7Ct9wI8mmGWLgU8oId6c2QCBKIG2wxti7G6+XJUgQTOtULcfOK2emO
 3J9u0iXyC2xyqltyyR8sjHAwqAfHV5vpOlF8s6+4Vrg8zTmAcXLlG+OiTcCpYRQ810Hf
 EHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708425044; x=1709029844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyzB5YCU69e9aRpVkB+NNMXTDYsdgwjqpgK8fMoXVPc=;
 b=e38h9jBzN0tV3M7X2Yffui9ygHF/xbqtD2V4Rz9Uo60dDBTKXwSiqdgzp3afQ6JrtL
 msq+THbHJdViT5Mu5nKJ4s2XtIAjlf47O6bHir+zJ6ZRF3c0OrfaZYJTu+f5bPzgg1xO
 IQKfhZ5OAQlY3O++en2LnvMU82x6GnHlVAwj1vx3KKELNCvBS09Yndem7LXU65JvK2Ob
 jb0tauFcK3ndZDBD/UIgPfgN5LkzCyYwkKBvsexlrvJI5iVkOwRqYb0HEhgpL8v5kXxw
 Cz1PwrcI+3ewQY6+A/dBecFBqCFpn4ru2Z7X5WGpG57rJ9TCsEJ51f8IcqlbFpgQb6uV
 zwlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg0ZrW39tobUSI6pxaCcvmZRng94tOK6U+wNUJwyyg5bAnGMnUosnN+MH2Rc7+CwwKADVzJmfKlus/6awAV20Zmvxb
X-Gm-Message-State: AOJu0YwxY9cZyK7jEBuztEmKP5Bs7IcNmldSXLviHJAyjj5GgzHjSiay
 4Hj0WesshCB/D7xfyUKBBLKWvx+sfpVhaStAlVIoksbfHZ+hLdAeU4gTQE7XxJFFjm8cxVoat81
 oJMQ7mNjF5YdtcDx8uiFKedD0uDo=
X-Google-Smtp-Source: AGHT+IHU9/uDjmtOfNMpct8BNY3FHX01ErvKxYUVL1Iun08M+evIO5AYLAuUWfZS9ubIDrGc+IXaHtJMojXNX6o7UYc=
X-Received: by 2002:a05:6871:411:b0:21e:7fa5:c58a with SMTP id
 d17-20020a056871041100b0021e7fa5c58amr11677523oag.30.1708425043958; Tue, 20
 Feb 2024 02:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20240219225958.2421873-1-rayhan.faizel@gmail.com>
 <20240219225958.2421873-4-rayhan.faizel@gmail.com>
 <e61e02ee-e181-4ea3-b079-638b50889742@redhat.com>
In-Reply-To: <e61e02ee-e181-4ea3-b079-638b50889742@redhat.com>
From: Rayhan Faizel <rayhan.faizel@gmail.com>
Date: Tue, 20 Feb 2024 13:30:33 +0300
Message-ID: <CAKUh+Qf5=kgUC3H9uWy6fAxB=76Tai28D6hPQ=qMwxc92YpNyA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/qtest: Add testcase for BCM2835 BSC
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org, 
 pbonzini@redhat.com, qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000dee10c0611cdb38c"
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000dee10c0611cdb38c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Do you want me to add an SPDX line to the other two commits or will just
this one suffice?

On Tue, Feb 20, 2024 at 9:45=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 19/02/2024 23.59, Rayhan Faizel wrote:
> > Simple testcase for validating proper operation of read and write for a=
ll
> > three BSC controllers.
> >
> > Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> > ---
> >   tests/qtest/bcm2835-i2c-test.c | 105 ++++++++++++++++++++++++++++++++=
+
> >   tests/qtest/meson.build        |   2 +-
> >   2 files changed, 106 insertions(+), 1 deletion(-)
> >   create mode 100644 tests/qtest/bcm2835-i2c-test.c
> >
> > diff --git a/tests/qtest/bcm2835-i2c-test.c
> b/tests/qtest/bcm2835-i2c-test.c
> > new file mode 100644
> > index 0000000000..6ec15b8976
> > --- /dev/null
> > +++ b/tests/qtest/bcm2835-i2c-test.c
> > @@ -0,0 +1,105 @@
> > +/*
> > + * QTest testcase for Broadcom Serial Controller (BSC)
> > + *
> > + * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
>
> Could you maybe also add a SPDX license line, so that it is more obvious
> at
> a quick glance what license this is?
>
> Anyway,
> Acked-by: Thomas Huth <thuth@redhat.com>
>
>

--=20
Rayhan Faizel

--000000000000dee10c0611cdb38c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Thomas,<div><br></div><div>Do you want me to add an SPD=
X line to the other two commits or will just this one suffice?</div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue,=
 Feb 20, 2024 at 9:45=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@re=
dhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On 19/0=
2/2024 23.59, Rayhan Faizel wrote:<br>
&gt; Simple testcase for validating proper operation of read and write for =
all<br>
&gt; three BSC controllers.<br>
&gt; <br>
&gt; Signed-off-by: Rayhan Faizel &lt;<a href=3D"mailto:rayhan.faizel@gmail=
.com" target=3D"_blank">rayhan.faizel@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/qtest/bcm2835-i2c-test.c | 105 +++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A0tests/qtest/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A02 files changed, 106 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 tests/qtest/bcm2835-i2c-test.c<br>
&gt; <br>
&gt; diff --git a/tests/qtest/bcm2835-i2c-test.c b/tests/qtest/bcm2835-i2c-=
test.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..6ec15b8976<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/qtest/bcm2835-i2c-test.c<br>
&gt; @@ -0,0 +1,105 @@<br>
&gt; +/*<br>
&gt; + * QTest testcase for Broadcom Serial Controller (BSC)<br>
&gt; + *<br>
&gt; + * Copyright (c) 2024 Rayhan Faizel &lt;<a href=3D"mailto:rayhan.faiz=
el@gmail.com" target=3D"_blank">rayhan.faizel@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a copy<br>
&gt; + * of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal<br>
&gt; + * in the Software without restriction, including without limitation =
the rights<br>
&gt; + * to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell<br>
&gt; + * copies of the Software, and to permit persons to whom the Software=
 is<br>
&gt; + * furnished to do so, subject to the following conditions:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL<br>
&gt; + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER<br>
&gt; + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,<br>
&gt; + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN<br>
&gt; + * THE SOFTWARE.<br>
&gt; + */<br>
<br>
Could you maybe also add a SPDX license line, so that it is more obvious at=
 <br>
a quick glance what license this is?<br>
<br>
Anyway,<br>
Acked-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_bl=
ank">thuth@redhat.com</a>&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Ra=
yhan Faizel<br></div>

--000000000000dee10c0611cdb38c--

