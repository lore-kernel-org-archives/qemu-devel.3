Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8DFC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmRm-0004R3-4R; Mon, 08 Jul 2024 07:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sQmRh-0004QO-O7
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:22:16 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sQmRf-0004Hh-FP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:22:13 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4464284029dso37818661cf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720437730; x=1721042530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Amypvso2fuvag8QQY7JZd2gHEx7K9zzE9LuZ8DznCh8=;
 b=RUSIK9BCRghNuaw79xISkbhJ3gSHUeSXdECceDx+8eLLfii8hKXUDtjziPThJxyUKV
 V1rnmfV67EaXMOXsdQg7q3a8hZPUGYHIY8mHy28+UjnniQHJ2CckRA/3edBXpDIMNbYO
 SH8zHTSrWT3fQ38ijVNxcXXCnmMPsA4LGUPBGvmyHhZA84r9Kb4dSc1WnC7gb0djHkTW
 sjXLlT3SEioT5DcFYxF0RDlqW5SKEvybJuTIUOZHVecToy4O9lkTcuvXAXlQz/u77wiH
 SKR+RNVM+TIq4/IZyhXZigl550b2laRtAhedi2SKi9GZ7u8PyG9k+8y/Q+2KIl4MQ75n
 y3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720437730; x=1721042530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Amypvso2fuvag8QQY7JZd2gHEx7K9zzE9LuZ8DznCh8=;
 b=InvuLq6+RWVqO4Pt+VrAyqtjoCTcIq68CiW7n+eqjNGQQ1BpHJ7ArhnU0jj40/CkYD
 8Jo6piXwkRjSZIL7V1YFxDVbPieqVOFjlar0m6VGOGcBLkbkaLjGAWmgy1sROdRHkuk+
 HndTosFxeDpQz9ZsO9U1UOhd+lccBus1GaH8qP3D5xddCVaP0O+163y1LlfjoxWIm5jO
 OroYtoYm5sB1vld49GNFlCUWT2kBdkTcd+KgvIKpEUoewPfvZB4lWdS7DeUcEJGK5ONl
 FPGfO2EjFz1ffux/bdcOQcHys4Q60nLIml1E7IB9cKUxvSgSS81WnR/1n/aedp6I1yQ+
 GGhQ==
X-Gm-Message-State: AOJu0YyXViCmant0UahLoGREMgitfNnE7k3P6J47AKUToOxjkXXDXDt+
 wMwZw5wNYyDgk4msM6ijdw+4odEYAgtrGjrK/b0+S2wjAZIl0aOKxIdHynfQuw0gahDcM9MbHKA
 +HI2mdeG2NRpaRw/GYXTliHCI8Cg=
X-Google-Smtp-Source: AGHT+IFbH/eHdSRfTZ5VY1a+BQz9Jd5cd9ji+2DpGgHknseLXJgZhnqNu2gHEJnpGjFIp+nJ106W88hQhvVu+JZd+IA=
X-Received: by 2002:ac8:5916:0:b0:447:e808:ab2a with SMTP id
 d75a77b69052e-447e808b028mr54920681cf.20.1720437730132; Mon, 08 Jul 2024
 04:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240707111940.232549-3-lrh2000@pku.edu.cn>
 <CAJ+F1CKHve-3SOzFOLBCKo-5yQDuo7QpSqxw9N5NtPbg7bdQdA@mail.gmail.com>
 <uvyay4oml2krvru2jflwcv7z6ex375glbmpmy2k2a7fophaiew@3cz5i7zqrd3j>
In-Reply-To: <uvyay4oml2krvru2jflwcv7z6ex375glbmpmy2k2a7fophaiew@3cz5i7zqrd3j>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 8 Jul 2024 15:21:58 +0400
Message-ID: <CAJ+F1CJc8dS3tSChnN+MwUCZfYPkoXGS+kd2Trw2RTtG1HRq1w@mail.gmail.com>
Subject: Re: [PATCH] char-mux: Don't overwrite the receive buffer
To: Ruihan Li <lrh2000@pku.edu.cn>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c34c38061cba9f8e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

--000000000000c34c38061cba9f8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 8, 2024 at 12:12=E2=80=AFAM Ruihan Li <lrh2000@pku.edu.cn> wrot=
e:

> Hi,
>
> Thanks for your quick review!
>
> On Sun, Jul 07, 2024 at 08:28:50PM GMT, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Sun, Jul 7, 2024 at 3:26=E2=80=AFPM Ruihan Li <lrh2000@pku.edu.cn> w=
rote:
> >
> > > This commit fixes a bug that causes incorrect results when pasting mo=
re
> > > than 32 bytes, the size of the receive buffer b->buffer, into the
> virtio
> > > console.
> > >
> > > Example (note that the last 32 bytes are always correct, but somethin=
g
> > > goes wrong just before the last 32 bytes):
> > >
> > >         Pasting
> > >
> abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
> > >         Received
> > >
> abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
> > >
> > > The root cause of this bug is as follows:
> > >
> > > The mux_chr_read function passes the data to the backend via
> > > be->chr_read one byte at a time, either directly or via another
> > > mux_chr_accept_input method. However, if the receive buffer is full,
> > > there is a chance that the mux_chr_can_read method will return more
> than
> > > one byte, because in this case the method directly returns whatever
> > > be->chr_can_read returns.
> > >
> > > This is problematic because if mux_chr_read passes a byte to the
> backend
> > > by calling be->chr_read, it will consume the entire backend buffer, a=
t
> > > least in the case of virtio. Once all backend buffers are used,
> > > mux_chr_read writes all remaining bytes to the receive buffer
> d->buffer,
> > >
> >
> > My understanding of the code execution is:
> > - mux_chr_can_read() returns be->chr_can_read(), say N, because d->buff=
er
> > is already MUX_BUFFER_SIZE.
> > - mux_chr_read() is called with N bytes
> > - mux_chr_accept_input() flushes d->buffer, writing MUX_BUFFER_SIZE
> > - be should still accept N-MUX_BUFFER_SIZE
> > - mux_proc_byte() loops for N bytes
> > - chr_read() should accept the N-MUX_BUFFER_SIZE
> > - d->buffer is then filled with the remaining MUX_BUFFER_SIZE
>
> Note this:
>         [..] if mux_chr_read passes a byte to the backend by calling
>         be->chr_read, it will consume the entire backend buffer, at
>         least in the case of virtio [..]
>
> At least in the case of virtio, if the guest provides a buffer of length
> 4096, be->chr_can_read will report 4096. But if you then call
> be->chr_read with one byte, the whole 4096 buffer will be used. After
> that, be->chr_can_read will return zero instead of 4095.
>
> This should make sense since the device cannot change the number of
> bytes in the buffer after it has made the buffer available to the CPU.
>

Thanks, that helps explaining the incorrect behaviour.

I think the concept of extra buffer as introduced in commit
bd9bdce694ccb76facc882363e4c337e8a88c918 ("Add input buffer to mux chr
(patch by Tristan Gingold)") is flawed, as Jan Kiszka explained in commit
a80bf99fa3dd829ecea88b9bfb4f7cf146208f07 ("char-mux: Use separate input
buffers (Jan Kiszka)"):
    Note: In contrast to the original author's claim, the buffering concept
    still breaks down when the fifo of the currently active sub-device is
    full. As we cannot accept futher data from this point on without riskin=
g
    to loose it, we will also miss escape sequences, just like without all
    that buffering. In short: There is no reliable escape sequence handling
    without infinite buffers or the risk of loosing some data.

Maybe the best course is to remove the cycle buffer and either:
- drop the data that be can't accept, but have always responsive mux (by
default)
- blocking, including mux, until the be can accept more data (not friendly)
- or allow unlimited buffering?

Given that mux is meant for developers and qemu CLI users, I guess any of
this would be acceptable.


>
> >
> >
> > > but the number of remaining bytes can be larger than the buffer size.
> > >
> >
> > By the above description, I don't see how it happens.
> >
> > This does not lead to security problems since it is a ring buffer, but
> > > it does mess up the receive data.
> > >
> > > This can be fixed by having mux_chr_can_read return either zero or on=
e.
> > > This fix is not very efficient, but it is quite reasonable since
> > > mux_chr_read also passes the data to the backend one byte at a time.
> > >
> >
> > Could you share your testing setup? Even better if you could write a
> test!
>
> This happens in https://github.com/asterinas/asterinas. Sorry, but I
> don't have a minimal reproducible example, and I don't think I can make
> one anytime soon.
>
> As for the tests, I'd like to know how to write such tests in QEMU. I
> checked the documentation but didn't find anything, maybe I'm missing
> something?
>
> >
> >
> > thanks
> >
> >
> > > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > > ---
> > >  chardev/char-mux.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > > index ee2d47b..5c6eea2 100644
> > > --- a/chardev/char-mux.c
> > > +++ b/chardev/char-mux.c
> > > @@ -210,8 +210,8 @@ static int mux_chr_can_read(void *opaque)
> > >          return 1;
> > >      }
> > >
> > > -    if (be && be->chr_can_read) {
> > > -        return be->chr_can_read(be->opaque);
> > > +    if (be && be->chr_can_read && be->chr_can_read(be->opaque)) {
> > > +        return 1;
> > >      }
> > >
> > >      return 0;
> > > --
> > > 2.45.2
> > >
> > >
> > >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
> Thanks,
> Ruihan Li
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c34c38061cba9f8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 8, 2024 at 12:12=E2=80=
=AFAM Ruihan Li &lt;<a href=3D"mailto:lrh2000@pku.edu.cn">lrh2000@pku.edu.c=
n</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi,<br>
<br>
Thanks for your quick review!<br>
<br>
On Sun, Jul 07, 2024 at 08:28:50PM GMT, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Sun, Jul 7, 2024 at 3:26=E2=80=AFPM Ruihan Li &lt;<a href=3D"mailto=
:lrh2000@pku.edu.cn" target=3D"_blank">lrh2000@pku.edu.cn</a>&gt; wrote:<br=
>
&gt; <br>
&gt; &gt; This commit fixes a bug that causes incorrect results when pastin=
g more<br>
&gt; &gt; than 32 bytes, the size of the receive buffer b-&gt;buffer, into =
the virtio<br>
&gt; &gt; console.<br>
&gt; &gt;<br>
&gt; &gt; Example (note that the last 32 bytes are always correct, but some=
thing<br>
&gt; &gt; goes wrong just before the last 32 bytes):<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Pasting<br>
&gt; &gt; abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#=
$%^&amp;*()<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Received<br>
&gt; &gt; abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&amp;*()EFGHIJKLMNOPQRSTUVWXY=
Z!@#$%^&amp;*()<br>
&gt; &gt;<br>
&gt; &gt; The root cause of this bug is as follows:<br>
&gt; &gt;<br>
&gt; &gt; The mux_chr_read function passes the data to the backend via<br>
&gt; &gt; be-&gt;chr_read one byte at a time, either directly or via anothe=
r<br>
&gt; &gt; mux_chr_accept_input method. However, if the receive buffer is fu=
ll,<br>
&gt; &gt; there is a chance that the mux_chr_can_read method will return mo=
re than<br>
&gt; &gt; one byte, because in this case the method directly returns whatev=
er<br>
&gt; &gt; be-&gt;chr_can_read returns.<br>
&gt; &gt;<br>
&gt; &gt; This is problematic because if mux_chr_read passes a byte to the =
backend<br>
&gt; &gt; by calling be-&gt;chr_read, it will consume the entire backend bu=
ffer, at<br>
&gt; &gt; least in the case of virtio. Once all backend buffers are used,<b=
r>
&gt; &gt; mux_chr_read writes all remaining bytes to the receive buffer d-&=
gt;buffer,<br>
&gt; &gt;<br>
&gt; <br>
&gt; My understanding of the code execution is:<br>
&gt; - mux_chr_can_read() returns be-&gt;chr_can_read(), say N, because d-&=
gt;buffer<br>
&gt; is already MUX_BUFFER_SIZE.<br>
&gt; - mux_chr_read() is called with N bytes<br>
&gt; - mux_chr_accept_input() flushes d-&gt;buffer, writing MUX_BUFFER_SIZE=
<br>
&gt; - be should still accept N-MUX_BUFFER_SIZE<br>
&gt; - mux_proc_byte() loops for N bytes<br>
&gt; - chr_read() should accept the N-MUX_BUFFER_SIZE<br>
&gt; - d-&gt;buffer is then filled with the remaining MUX_BUFFER_SIZE<br>
<br>
Note this:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [..] if mux_chr_read passes a byte to the backe=
nd by calling<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 be-&gt;chr_read, it will consume the entire bac=
kend buffer, at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 least in the case of virtio [..]<br>
<br>
At least in the case of virtio, if the guest provides a buffer of length<br=
>
4096, be-&gt;chr_can_read will report 4096. But if you then call<br>
be-&gt;chr_read with one byte, the whole 4096 buffer will be used. After<br=
>
that, be-&gt;chr_can_read will return zero instead of 4095.<br>
<br>
This should make sense since the device cannot change the number of<br>
bytes in the buffer after it has made the buffer available to the CPU.<br><=
/blockquote><div><br></div><div>Thanks, that helps explaining the incorrect=
 behaviour.</div><div><br></div><div>I think the concept of extra buffer as=
 introduced in commit bd9bdce694ccb76facc882363e4c337e8a88c918 (&quot;Add i=
nput buffer to mux chr (patch by Tristan Gingold)&quot;) is flawed, as Jan =
Kiszka explained in commit a80bf99fa3dd829ecea88b9bfb4f7cf146208f07 (&quot;=
char-mux: Use separate input buffers (Jan Kiszka)&quot;):</div><div>=C2=A0 =
=C2=A0 Note: In contrast to the original author&#39;s claim, the buffering =
concept<br>=C2=A0 =C2=A0 still breaks down when the fifo of the currently a=
ctive sub-device is<br>=C2=A0 =C2=A0 full. As we cannot accept futher data =
from this point on without risking<br>=C2=A0 =C2=A0 to loose it, we will al=
so miss escape sequences, just like without all<br>=C2=A0 =C2=A0 that buffe=
ring. In short: There is no reliable escape sequence handling<br>=C2=A0 =C2=
=A0 without infinite buffers or the risk of loosing some data.</div><div><b=
r></div><div>Maybe the best course is to remove the cycle buffer and either=
:</div><div>- drop the data that be can&#39;t accept, but have always respo=
nsive mux (by default)</div><div>- blocking, including mux, until the be ca=
n accept more data (not friendly)<br></div><div>- or allow unlimited buffer=
ing?</div><div><br></div><div>Given that mux is meant for developers and qe=
mu CLI users, I guess any of this would be acceptable.<br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; &gt; but the number of remaining bytes can be larger than the buffer s=
ize.<br>
&gt; &gt;<br>
&gt; <br>
&gt; By the above description, I don&#39;t see how it happens.<br>
&gt; <br>
&gt; This does not lead to security problems since it is a ring buffer, but=
<br>
&gt; &gt; it does mess up the receive data.<br>
&gt; &gt;<br>
&gt; &gt; This can be fixed by having mux_chr_can_read return either zero o=
r one.<br>
&gt; &gt; This fix is not very efficient, but it is quite reasonable since<=
br>
&gt; &gt; mux_chr_read also passes the data to the backend one byte at a ti=
me.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Could you share your testing setup? Even better if you could write a t=
est!<br>
<br>
This happens in <a href=3D"https://github.com/asterinas/asterinas" rel=3D"n=
oreferrer" target=3D"_blank">https://github.com/asterinas/asterinas</a>. So=
rry, but I<br>
don&#39;t have a minimal reproducible example, and I don&#39;t think I can =
make<br>
one anytime soon.<br>
<br>
As for the tests, I&#39;d like to know how to write such tests in QEMU. I<b=
r>
checked the documentation but didn&#39;t find anything, maybe I&#39;m missi=
ng<br>
something?<br>
<br>
&gt; <br>
&gt; <br>
&gt; thanks<br>
&gt; <br>
&gt; <br>
&gt; &gt; Signed-off-by: Ruihan Li &lt;<a href=3D"mailto:lrh2000@pku.edu.cn=
" target=3D"_blank">lrh2000@pku.edu.cn</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 chardev/char-mux.c | 4 ++--<br>
&gt; &gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
&gt; &gt; index ee2d47b..5c6eea2 100644<br>
&gt; &gt; --- a/chardev/char-mux.c<br>
&gt; &gt; +++ b/chardev/char-mux.c<br>
&gt; &gt; @@ -210,8 +210,8 @@ static int mux_chr_can_read(void *opaque)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 if (be &amp;&amp; be-&gt;chr_can_read) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return be-&gt;chr_can_read(be-&gt;op=
aque);<br>
&gt; &gt; +=C2=A0 =C2=A0 if (be &amp;&amp; be-&gt;chr_can_read &amp;&amp; b=
e-&gt;chr_can_read(be-&gt;opaque)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; --<br>
&gt; &gt; 2.45.2<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; <br>
&gt; -- <br>
&gt; Marc-Andr=C3=A9 Lureau<br>
<br>
Thanks,<br>
Ruihan Li<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000c34c38061cba9f8e--

