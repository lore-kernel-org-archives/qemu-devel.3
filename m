Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AF8C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 08:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVohI-0002Hf-Oi; Mon, 22 Jul 2024 04:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVohG-0002GN-Oc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:47:06 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVohF-0000rj-2N
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:47:06 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-492aae5fde6so114565137.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721638024; x=1722242824; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vSWZQQgX/yMbSi88MVBZcJkBOdq2/Coa/757HPrD3d8=;
 b=HwBu4dy4jvSq4U95P/vYDDPWMLTMXoDb/oFHsnzttL4qxUGDJpwBAf6qkZ//nCYDkR
 vBH5RrU9fdTa6sbgbTk0ZLeGYBIYb8EBkQsE8eVadpAzxm4Ace14JNqEVd09CDnOBWF6
 0Wr9aijrRAIo0sP2owxONSJ+ZufDQBUSoJRH1VxXTm5mwKc1d6atu1W9Bwmi+TIxvhQl
 57l6VL/l2a6C8k9C7UwTysAf18bVYfANpdElHoS5T9j6noerL/V9wsU9sgTr0ceMJdJl
 SEldaXsNlixamBMrUfB+H9HSQRWEpPToci7rsBqmKBuOKO4x6gXZAeZ2qUzlTTc+zZSr
 eOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721638024; x=1722242824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vSWZQQgX/yMbSi88MVBZcJkBOdq2/Coa/757HPrD3d8=;
 b=GrShQT+R2KdPH/U5hMGySEb3h8UD52Abv8FrhUFFqlPM+awFCVbY2v1vNzgpDGLYui
 yRgsvo1xFcDcsHGHi9VE00CVpc8lBHnZJlB0Q8lkyOW7HojZfgLOCnItWEY345BTSqU/
 QxNu+NDxnjDepBbZDEmUNXey9sKirG5FjkxWw9blvClf5RD+t+Y/P8kVuu1J39VehFIA
 PsjU1cKlWrkIkllRJbq0+MEF4JuFtq7WGZxWW/ewUxWT6J749UMo8Os72TzYTY5AK5yY
 pp61gbXEQgzSndLf0NowvNP+qh0Qt0kkf7w9lyQ6sbdDF6LdrAIrBNdupbl2z5NME0GU
 MYTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmLvUYak67gQIC2MfquZst+BfpLpQyYF8U435FdAVKZWBbT1IZFzSg4uGnr8fuXJI7CDySbLyXlw5/88jcVwehYX7OqD8=
X-Gm-Message-State: AOJu0YxtygLk/EXVMUuzfonXIeF2emktVco1TnIwthbVJI9qrObyaDwJ
 oqu6iAA+deOFJAJGlj/fSwPNd8AZNUnSEeIFso8Byerd0uGvM7GpKs8XH1/r1sX/WcMx38C/wpr
 8rsvND4UuQWUy2xuoO2ghYvkJrew=
X-Google-Smtp-Source: AGHT+IEIeIowskGYz0VHlnR2XKQt8z0teQBECBrVMt3JeBB3JHJLAFGK8dVe5iAidy235Fk4k9cQ3aGKKFn9Sfe1su0=
X-Received: by 2002:a05:6102:3c8a:b0:48f:e57a:e2f6 with SMTP id
 ada2fe7eead31-4928b931429mr7603789137.1.1721638023920; Mon, 22 Jul 2024
 01:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240605185050.1678102-1-tavip@google.com>
 <87r0br8bve.fsf@pond.sub.org>
 <CAFEAcA8nFz_4M3s4NoWpfhJZ=pxRc92shSKfoL6iN=_Oqmc-tw@mail.gmail.com>
 <87msmfkp57.fsf@pond.sub.org>
In-Reply-To: <87msmfkp57.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jul 2024 12:46:53 +0400
Message-ID: <CAJ+F1CJtuGr2ahww4YhL_GqkjrysmO0NVAFBxN1_1NH-GQN4mQ@mail.gmail.com>
Subject: Re: [PATCH v3] chardev: add path option for pty backend
To: Octavian Purdila <tavip@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, berrange@redhat.com, 
 Paulo Neves <ptsneves@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d906bf061dd21625"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vs1-xe2b.google.com
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

--000000000000d906bf061dd21625
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Octavian,

You should send a new version with the changes requested by Markus. (we
might miss 9.1 though)

On Thu, Jul 18, 2024 at 1:48=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 18 Jul 2024 at 07:15, Markus Armbruster <armbru@redhat.com>
> wrote:
> >>
> >> Looks like this one fell through the cracks.
> >>
> >> Octavian Purdila <tavip@google.com> writes:
> >>
> >> > Add path option to the pty char backend which will create a symbolic
> >> > link to the given path that points to the allocated PTY.
> >> >
> >> > This avoids having to make QMP or HMP monitor queries to find out wh=
at
> >> > the new PTY device path is.
> >>
> >> QMP commands chardev-add and chardev-change return the information you
> >> want:
> >>
> >>     # @pty: name of the slave pseudoterminal device, present if and on=
ly
> >>     #     if a chardev of type 'pty' was created
> >>
> >> So does HMP command chardev-add.  HMP chardev apparently doesn't, but
> >> that could be fixed.
> >>
> >> So, the use case is basically the command line, right?
> >
> >> The feature feels rather doubtful to me, to be honest.
> >
> > The command line is an important use-case, though. Not every
> > user of QEMU is libvirt with a QMP/HMP connection readily
> > to hand that they would prefer to use for all configuration...
>
> In general yes.  But what are the use cases for this one?
>
> To me, specifying path=3D/mumble/symlink plus the bother of cleaning up
> stale ones doesn't feel like much of an improvement over reading the pty
> name from "info chardev".  I guess I'm missing something.  Tell me!
>
> If we decide we want this, then the QMP interface needs to be fixed:
> Call the argument @path for consistency, and document it properly.
> Actually straightforward, just create a new struct instead of pressing
> ChardevHostdev into service.
>
> Some advice on robust use of @path could be useful, in particular on
> guarding against QEMU leaving stale links behind.
>
> Additional decision: whether to extend the old-style syntax.
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d906bf061dd21625
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Octavian,</div><div><br></div><div>You should send=
 a new version with the changes requested by Markus. (we might miss 9.1 tho=
ugh)<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Thu, Jul 18, 2024 at 1:48=E2=80=AFPM Markus Armbruster &lt;<a hr=
ef=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro=
.org</a>&gt; writes:<br>
<br>
&gt; On Thu, 18 Jul 2024 at 07:15, Markus Armbruster &lt;<a href=3D"mailto:=
armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Looks like this one fell through the cracks.<br>
&gt;&gt;<br>
&gt;&gt; Octavian Purdila &lt;<a href=3D"mailto:tavip@google.com" target=3D=
"_blank">tavip@google.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Add path option to the pty char backend which will create a s=
ymbolic<br>
&gt;&gt; &gt; link to the given path that points to the allocated PTY.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This avoids having to make QMP or HMP monitor queries to find=
 out what<br>
&gt;&gt; &gt; the new PTY device path is.<br>
&gt;&gt;<br>
&gt;&gt; QMP commands chardev-add and chardev-change return the information=
 you<br>
&gt;&gt; want:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0# @pty: name of the slave pseudoterminal device=
, present if and only<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0if a chardev of type &#39;=
pty&#39; was created<br>
&gt;&gt;<br>
&gt;&gt; So does HMP command chardev-add.=C2=A0 HMP chardev apparently does=
n&#39;t, but<br>
&gt;&gt; that could be fixed.<br>
&gt;&gt;<br>
&gt;&gt; So, the use case is basically the command line, right?<br>
&gt;<br>
&gt;&gt; The feature feels rather doubtful to me, to be honest.<br>
&gt;<br>
&gt; The command line is an important use-case, though. Not every<br>
&gt; user of QEMU is libvirt with a QMP/HMP connection readily<br>
&gt; to hand that they would prefer to use for all configuration...<br>
<br>
In general yes.=C2=A0 But what are the use cases for this one?<br>
<br>
To me, specifying path=3D/mumble/symlink plus the bother of cleaning up<br>
stale ones doesn&#39;t feel like much of an improvement over reading the pt=
y<br>
name from &quot;info chardev&quot;.=C2=A0 I guess I&#39;m missing something=
.=C2=A0 Tell me!<br>
<br>
If we decide we want this, then the QMP interface needs to be fixed:<br>
Call the argument @path for consistency, and document it properly.<br>
Actually straightforward, just create a new struct instead of pressing<br>
ChardevHostdev into service.<br>
<br>
Some advice on robust use of @path could be useful, in particular on<br>
guarding against QEMU leaving stale links behind.<br>
<br>
Additional decision: whether to extend the old-style syntax.<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000d906bf061dd21625--

