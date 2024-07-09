Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E68C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCJ5-0007yK-5b; Tue, 09 Jul 2024 10:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sRCJ0-0007wb-Ll
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:59:01 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sRCIx-0000RB-Jf
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:58:58 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d927fb8b82so1807151b6e.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720537133; x=1721141933; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VJP94J0CD02Xhbvj7KR7XOmpXQ7PTuEPH0hT56sBjxM=;
 b=DIxFXKLpV37648XdD/2lyNzP0jLcmLhm9/6gabhjncgE5RDNI87djwDjSewW2yXMUr
 RWP5BD0FswM87fHnLFWuTrk2/HJiOtSrLE8+QTD/FKr57obRgGoeOF+5wYt4MoOYDLn2
 IySTCYBuyvK5mBUFKdIHqZeGBreESt2a8yDVropGrthEzvsx0BVsYYmaHetkqTUNCRHc
 g25S0FtPrKzW1nOoDu02rvI5f9cC1PZ4kReSFq+cli9U6cWpxH7RUlsjXxQoyiXMGqjy
 wmscZ9iCS5Mz9kdpRIA+KrtphioI/cL7u2XAEbZw7JRbYBrovAxrSNzBcGd6iKLpu43I
 XGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720537133; x=1721141933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJP94J0CD02Xhbvj7KR7XOmpXQ7PTuEPH0hT56sBjxM=;
 b=X8zO0vljgjII1EIX2CM/04NGF3YflE2W9O0EsWuLyKIJu0h2weWwoRBEXVzAHfeTHn
 11WAdfuqUugv1BmUOBVLRk8uVP6NKlxutKsBTSQBT3hxqIUc3VQE6l9xRdwHKBMBCpzn
 JPPwPsMFHsPLfBIUCzUMJLpDYmGKtthmtiNrOivwawX4R98F8Pxvvy/Bvy4mh6J6i7qd
 N4EuDDWPcaU0+X4ne5SY2Use0MHo55xz2MoAAmgKg0l/p0Fzm9JYu2wkMCdJ/WmaYufq
 D0LMtNJ5NHNmmlG9ZvExiYXa/ccwy394KL/FB8Xb44eVWuAKaSYS9FQ6oCf5s0ZH573D
 iaxw==
X-Gm-Message-State: AOJu0YxPIJ2anoND/GgQz4M67rNzFLCnCz6dkwC352b1dHMBmHHELP+I
 Oo5lM9velKiyRcAzGKq0hrflvlcV6FAQNWg8xejoQgwIZa+LeM4CLyG45xk+OV9BlCmIY+qYGF4
 tlSEV3Rq0+5Y/1S0fplbcPWDDDMo=
X-Google-Smtp-Source: AGHT+IG9k0d8W6oEq6T/c83mH+qzycQl98I34iFc3mEa0Get1mQbnvPczIhGMen6lWl+/u31kOiQJsDcJt46y2dbNBA=
X-Received: by 2002:a05:6808:152b:b0:3d9:30a2:f8fc with SMTP id
 5614622812f47-3d93c00ad77mr2662555b6e.20.1720537133391; Tue, 09 Jul 2024
 07:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240707111940.232549-3-lrh2000@pku.edu.cn>
 <CAJ+F1CKHve-3SOzFOLBCKo-5yQDuo7QpSqxw9N5NtPbg7bdQdA@mail.gmail.com>
 <uvyay4oml2krvru2jflwcv7z6ex375glbmpmy2k2a7fophaiew@3cz5i7zqrd3j>
 <CAJ+F1CJc8dS3tSChnN+MwUCZfYPkoXGS+kd2Trw2RTtG1HRq1w@mail.gmail.com>
 <fx2rkepa2jhuy7novlpyqfgwh2fven3rjjzfng72hzkh3vnylg@wokdocju7bx4>
In-Reply-To: <fx2rkepa2jhuy7novlpyqfgwh2fven3rjjzfng72hzkh3vnylg@wokdocju7bx4>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Jul 2024 18:58:41 +0400
Message-ID: <CAJ+F1CL6A3oZqqCmgmHSDPmaDBODhsLaWhpVxvH3u0qgFZCPWg@mail.gmail.com>
Subject: Re: [PATCH] char-mux: Don't overwrite the receive buffer
To: Ruihan Li <lrh2000@pku.edu.cn>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a8ab83061cd1c4bb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x230.google.com
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

--000000000000a8ab83061cd1c4bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jul 9, 2024 at 6:41=E2=80=AFPM Ruihan Li <lrh2000@pku.edu.cn> wrote=
:

> Hi,
>
> On Mon, Jul 08, 2024 at 03:21:58PM GMT, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Jul 8, 2024 at 12:12=E2=80=AFAM Ruihan Li <lrh2000@pku.edu.cn> =
wrote:
> >
> > > Hi,
> > >
> > > Thanks for your quick review!
> > >
> > > On Sun, Jul 07, 2024 at 08:28:50PM GMT, Marc-Andr=C3=A9 Lureau wrote:
> > > > Hi
> > > >
> > > > On Sun, Jul 7, 2024 at 3:26=E2=80=AFPM Ruihan Li <lrh2000@pku.edu.c=
n> wrote:
> > > >
> > > > > This commit fixes a bug that causes incorrect results when pastin=
g
> more
> > > > > than 32 bytes, the size of the receive buffer b->buffer, into the
> > > virtio
> > > > > console.
> > > > >
> > > > > Example (note that the last 32 bytes are always correct, but
> something
> > > > > goes wrong just before the last 32 bytes):
> > > > >
> > > > >         Pasting
> > > > >
> > >
> abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
> > > > >         Received
> > > > >
> > >
> abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
> > > > >
> > > > > The root cause of this bug is as follows:
> > > > >
> > > > > The mux_chr_read function passes the data to the backend via
> > > > > be->chr_read one byte at a time, either directly or via another
> > > > > mux_chr_accept_input method. However, if the receive buffer is
> full,
> > > > > there is a chance that the mux_chr_can_read method will return mo=
re
> > > than
> > > > > one byte, because in this case the method directly returns whatev=
er
> > > > > be->chr_can_read returns.
> > > > >
> > > > > This is problematic because if mux_chr_read passes a byte to the
> > > backend
> > > > > by calling be->chr_read, it will consume the entire backend
> buffer, at
> > > > > least in the case of virtio. Once all backend buffers are used,
> > > > > mux_chr_read writes all remaining bytes to the receive buffer
> > > d->buffer,
> > > > >
> > > >
> > > > My understanding of the code execution is:
> > > > - mux_chr_can_read() returns be->chr_can_read(), say N, because
> d->buffer
> > > > is already MUX_BUFFER_SIZE.
> > > > - mux_chr_read() is called with N bytes
> > > > - mux_chr_accept_input() flushes d->buffer, writing MUX_BUFFER_SIZE
> > > > - be should still accept N-MUX_BUFFER_SIZE
> > > > - mux_proc_byte() loops for N bytes
> > > > - chr_read() should accept the N-MUX_BUFFER_SIZE
> > > > - d->buffer is then filled with the remaining MUX_BUFFER_SIZE
> > >
> > > Note this:
> > >         [..] if mux_chr_read passes a byte to the backend by calling
> > >         be->chr_read, it will consume the entire backend buffer, at
> > >         least in the case of virtio [..]
> > >
> > > At least in the case of virtio, if the guest provides a buffer of
> length
> > > 4096, be->chr_can_read will report 4096. But if you then call
> > > be->chr_read with one byte, the whole 4096 buffer will be used. After
> > > that, be->chr_can_read will return zero instead of 4095.
> > >
> > > This should make sense since the device cannot change the number of
> > > bytes in the buffer after it has made the buffer available to the CPU=
.
> > >
> >
> > Thanks, that helps explaining the incorrect behaviour.
> >
> > I think the concept of extra buffer as introduced in commit
> > bd9bdce694ccb76facc882363e4c337e8a88c918 ("Add input buffer to mux chr
> > (patch by Tristan Gingold)") is flawed, as Jan Kiszka explained in comm=
it
> > a80bf99fa3dd829ecea88b9bfb4f7cf146208f07 ("char-mux: Use separate input
> > buffers (Jan Kiszka)"):
> >     Note: In contrast to the original author's claim, the buffering
> concept
> >     still breaks down when the fifo of the currently active sub-device =
is
> >     full. As we cannot accept futher data from this point on without
> risking
> >     to loose it, we will also miss escape sequences, just like without
> all
> >     that buffering. In short: There is no reliable escape sequence
> handling
> >     without infinite buffers or the risk of loosing some data.
> >
> > Maybe the best course is to remove the cycle buffer and either:
> > - drop the data that be can't accept, but have always responsive mux (b=
y
> > default)
> > - blocking, including mux, until the be can accept more data (not
> friendly)
> > - or allow unlimited buffering?
> >
> > Given that mux is meant for developers and qemu CLI users, I guess any =
of
> > this would be acceptable.
>
> Thanks for your comments.
>
> However, I'm not really sure what you're talking about. If we make
> mux_chr_can_read return either zero or one (as I've done in the patch),
> do you mean that we are still at risk of losing some escape sequences?
>

> In mux_proc_byte, we set d->term_got_escape to 1 when we see the escape
> character. As far as I can see, the escape sequence is always handled
> correctly. So I don't understand how losing escape sequences can happen.
>
> Would you mind explaining this in more detail?
>


I agree with you that returning 0 or 1 in mux_chr_can_read() should solve
the issue (assuming future call to be can_read still return >=3D 1). But it=
's
not elegant to read/write by 1 bytes, especially as you explained, it takes
4k buffers for virtio-serial by write. My comment is more general also: the
32 bytes buffer isn't really helping, at some point it may be full and mux
will stop handling input...

(I think the quoted comment talks about escape sequences for the guest, not
the mux term_got_escape - unfortunately the original commit bd9bdce69
introducing the mux buffer doesn't have details)


> >
> >
> > >
> > > >
> > > >
> > > > > but the number of remaining bytes can be larger than the buffer
> size.
> > > > >
> > > >
> > > > By the above description, I don't see how it happens.
> > > >
> > > > This does not lead to security problems since it is a ring buffer,
> but
> > > > > it does mess up the receive data.
> > > > >
> > > > > This can be fixed by having mux_chr_can_read return either zero o=
r
> one.
> > > > > This fix is not very efficient, but it is quite reasonable since
> > > > > mux_chr_read also passes the data to the backend one byte at a
> time.
> > > > >
> > > >
> > > > Could you share your testing setup? Even better if you could write =
a
> > > test!
> > >
> > > This happens in https://github.com/asterinas/asterinas. Sorry, but I
> > > don't have a minimal reproducible example, and I don't think I can ma=
ke
> > > one anytime soon.
> > >
> > > As for the tests, I'd like to know how to write such tests in QEMU. I
> > > checked the documentation but didn't find anything, maybe I'm missing
> > > something?
> > >
> > > >
> > > >
> > > > thanks
> > > >
> > > >
> > > > > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > > > > ---
> > > > >  chardev/char-mux.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > > > > index ee2d47b..5c6eea2 100644
> > > > > --- a/chardev/char-mux.c
> > > > > +++ b/chardev/char-mux.c
> > > > > @@ -210,8 +210,8 @@ static int mux_chr_can_read(void *opaque)
> > > > >          return 1;
> > > > >      }
> > > > >
> > > > > -    if (be && be->chr_can_read) {
> > > > > -        return be->chr_can_read(be->opaque);
> > > > > +    if (be && be->chr_can_read && be->chr_can_read(be->opaque)) =
{
> > > > > +        return 1;
> > > > >      }
> > > > >
> > > > >      return 0;
> > > > > --
> > > > > 2.45.2
> > > > >
> > > > >
> > > > >
> > > >
> > > > --
> > > > Marc-Andr=C3=A9 Lureau
> > >
> > > Thanks,
> > > Ruihan Li
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

--000000000000a8ab83061cd1c4bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 9, 2024 at 6:41=E2=80=
=AFPM Ruihan Li &lt;<a href=3D"mailto:lrh2000@pku.edu.cn">lrh2000@pku.edu.c=
n</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi,<br>
<br>
On Mon, Jul 08, 2024 at 03:21:58PM GMT, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Mon, Jul 8, 2024 at 12:12=E2=80=AFAM Ruihan Li &lt;<a href=3D"mailt=
o:lrh2000@pku.edu.cn" target=3D"_blank">lrh2000@pku.edu.cn</a>&gt; wrote:<b=
r>
&gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; Thanks for your quick review!<br>
&gt; &gt;<br>
&gt; &gt; On Sun, Jul 07, 2024 at 08:28:50PM GMT, Marc-Andr=C3=A9 Lureau wr=
ote:<br>
&gt; &gt; &gt; Hi<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Sun, Jul 7, 2024 at 3:26=E2=80=AFPM Ruihan Li &lt;<a href=
=3D"mailto:lrh2000@pku.edu.cn" target=3D"_blank">lrh2000@pku.edu.cn</a>&gt;=
 wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This commit fixes a bug that causes incorrect results w=
hen pasting more<br>
&gt; &gt; &gt; &gt; than 32 bytes, the size of the receive buffer b-&gt;buf=
fer, into the<br>
&gt; &gt; virtio<br>
&gt; &gt; &gt; &gt; console.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Example (note that the last 32 bytes are always correct=
, but something<br>
&gt; &gt; &gt; &gt; goes wrong just before the last 32 bytes):<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Pasting<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#=
$%^&amp;*()<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Received<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&amp;*()EFGHIJKLMNOPQRSTUVWXY=
Z!@#$%^&amp;*()<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The root cause of this bug is as follows:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The mux_chr_read function passes the data to the backen=
d via<br>
&gt; &gt; &gt; &gt; be-&gt;chr_read one byte at a time, either directly or =
via another<br>
&gt; &gt; &gt; &gt; mux_chr_accept_input method. However, if the receive bu=
ffer is full,<br>
&gt; &gt; &gt; &gt; there is a chance that the mux_chr_can_read method will=
 return more<br>
&gt; &gt; than<br>
&gt; &gt; &gt; &gt; one byte, because in this case the method directly retu=
rns whatever<br>
&gt; &gt; &gt; &gt; be-&gt;chr_can_read returns.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This is problematic because if mux_chr_read passes a by=
te to the<br>
&gt; &gt; backend<br>
&gt; &gt; &gt; &gt; by calling be-&gt;chr_read, it will consume the entire =
backend buffer, at<br>
&gt; &gt; &gt; &gt; least in the case of virtio. Once all backend buffers a=
re used,<br>
&gt; &gt; &gt; &gt; mux_chr_read writes all remaining bytes to the receive =
buffer<br>
&gt; &gt; d-&gt;buffer,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; My understanding of the code execution is:<br>
&gt; &gt; &gt; - mux_chr_can_read() returns be-&gt;chr_can_read(), say N, b=
ecause d-&gt;buffer<br>
&gt; &gt; &gt; is already MUX_BUFFER_SIZE.<br>
&gt; &gt; &gt; - mux_chr_read() is called with N bytes<br>
&gt; &gt; &gt; - mux_chr_accept_input() flushes d-&gt;buffer, writing MUX_B=
UFFER_SIZE<br>
&gt; &gt; &gt; - be should still accept N-MUX_BUFFER_SIZE<br>
&gt; &gt; &gt; - mux_proc_byte() loops for N bytes<br>
&gt; &gt; &gt; - chr_read() should accept the N-MUX_BUFFER_SIZE<br>
&gt; &gt; &gt; - d-&gt;buffer is then filled with the remaining MUX_BUFFER_=
SIZE<br>
&gt; &gt;<br>
&gt; &gt; Note this:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[..] if mux_chr_read passes a by=
te to the backend by calling<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be-&gt;chr_read, it will consume=
 the entire backend buffer, at<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0least in the case of virtio [..]=
<br>
&gt; &gt;<br>
&gt; &gt; At least in the case of virtio, if the guest provides a buffer of=
 length<br>
&gt; &gt; 4096, be-&gt;chr_can_read will report 4096. But if you then call<=
br>
&gt; &gt; be-&gt;chr_read with one byte, the whole 4096 buffer will be used=
. After<br>
&gt; &gt; that, be-&gt;chr_can_read will return zero instead of 4095.<br>
&gt; &gt;<br>
&gt; &gt; This should make sense since the device cannot change the number =
of<br>
&gt; &gt; bytes in the buffer after it has made the buffer available to the=
 CPU.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Thanks, that helps explaining the incorrect behaviour.<br>
&gt; <br>
&gt; I think the concept of extra buffer as introduced in commit<br>
&gt; bd9bdce694ccb76facc882363e4c337e8a88c918 (&quot;Add input buffer to mu=
x chr<br>
&gt; (patch by Tristan Gingold)&quot;) is flawed, as Jan Kiszka explained i=
n commit<br>
&gt; a80bf99fa3dd829ecea88b9bfb4f7cf146208f07 (&quot;char-mux: Use separate=
 input<br>
&gt; buffers (Jan Kiszka)&quot;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0Note: In contrast to the original author&#39;s clai=
m, the buffering concept<br>
&gt;=C2=A0 =C2=A0 =C2=A0still breaks down when the fifo of the currently ac=
tive sub-device is<br>
&gt;=C2=A0 =C2=A0 =C2=A0full. As we cannot accept futher data from this poi=
nt on without risking<br>
&gt;=C2=A0 =C2=A0 =C2=A0to loose it, we will also miss escape sequences, ju=
st like without all<br>
&gt;=C2=A0 =C2=A0 =C2=A0that buffering. In short: There is no reliable esca=
pe sequence handling<br>
&gt;=C2=A0 =C2=A0 =C2=A0without infinite buffers or the risk of loosing som=
e data.<br>
&gt; <br>
&gt; Maybe the best course is to remove the cycle buffer and either:<br>
&gt; - drop the data that be can&#39;t accept, but have always responsive m=
ux (by<br>
&gt; default)<br>
&gt; - blocking, including mux, until the be can accept more data (not frie=
ndly)<br>
&gt; - or allow unlimited buffering?<br>
&gt; <br>
&gt; Given that mux is meant for developers and qemu CLI users, I guess any=
 of<br>
&gt; this would be acceptable.<br>
<br>
Thanks for your comments.<br>
<br>
However, I&#39;m not really sure what you&#39;re talking about. If we make<=
br>
mux_chr_can_read return either zero or one (as I&#39;ve done in the patch),=
<br>
do you mean that we are still at risk of losing some escape sequences? <br>=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
In mux_proc_byte, we set d-&gt;term_got_escape to 1 when we see the escape<=
br>
character. As far as I can see, the escape sequence is always handled<br>
correctly. So I don&#39;t understand how losing escape sequences can happen=
.<br>
<br>
Would you mind explaining this in more detail?<br></blockquote><div><br></d=
iv><div><br></div><div>I agree with you that returning 0 or 1 in mux_chr_ca=
n_read() should solve the issue (assuming future call to be can_read still =
return &gt;=3D 1). But it&#39;s not elegant to read/write by 1 bytes, espec=
ially as you explained, it takes 4k buffers for virtio-serial by write. My =
comment is more general also: the 32 bytes buffer isn&#39;t really helping,=
 at some point it may be full and mux will stop handling input...</div><div=
><br></div><div>(I think the quoted comment talks about escape sequences fo=
r the guest, not the mux term_got_escape - unfortunately the original commi=
t bd9bdce69 introducing the mux buffer doesn&#39;t have details)<br></div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; but the number of remaining bytes can be larger than th=
e buffer size.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; By the above description, I don&#39;t see how it happens.<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This does not lead to security problems since it is a ring b=
uffer, but<br>
&gt; &gt; &gt; &gt; it does mess up the receive data.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This can be fixed by having mux_chr_can_read return eit=
her zero or one.<br>
&gt; &gt; &gt; &gt; This fix is not very efficient, but it is quite reasona=
ble since<br>
&gt; &gt; &gt; &gt; mux_chr_read also passes the data to the backend one by=
te at a time.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Could you share your testing setup? Even better if you could=
 write a<br>
&gt; &gt; test!<br>
&gt; &gt;<br>
&gt; &gt; This happens in <a href=3D"https://github.com/asterinas/asterinas=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/asterinas/asterin=
as</a>. Sorry, but I<br>
&gt; &gt; don&#39;t have a minimal reproducible example, and I don&#39;t th=
ink I can make<br>
&gt; &gt; one anytime soon.<br>
&gt; &gt;<br>
&gt; &gt; As for the tests, I&#39;d like to know how to write such tests in=
 QEMU. I<br>
&gt; &gt; checked the documentation but didn&#39;t find anything, maybe I&#=
39;m missing<br>
&gt; &gt; something?<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; thanks<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Ruihan Li &lt;<a href=3D"mailto:lrh2000@=
pku.edu.cn" target=3D"_blank">lrh2000@pku.edu.cn</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 chardev/char-mux.c | 4 ++--<br>
&gt; &gt; &gt; &gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br=
>
&gt; &gt; &gt; &gt; index ee2d47b..5c6eea2 100644<br>
&gt; &gt; &gt; &gt; --- a/chardev/char-mux.c<br>
&gt; &gt; &gt; &gt; +++ b/chardev/char-mux.c<br>
&gt; &gt; &gt; &gt; @@ -210,8 +210,8 @@ static int mux_chr_can_read(void *o=
paque)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 if (be &amp;&amp; be-&gt;chr_can_read) {=
<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return be-&gt;chr_can_read=
(be-&gt;opaque);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 if (be &amp;&amp; be-&gt;chr_can_read &a=
mp;&amp; be-&gt;chr_can_read(be-&gt;opaque)) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; 2.45.2<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; Marc-Andr=C3=A9 Lureau<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Ruihan Li<br>
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

--000000000000a8ab83061cd1c4bb--

