Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52ACD111B0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 07:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7rhz-0001UX-DH; Mon, 04 Nov 2024 02:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t7rhw-0001UN-Hm
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:41:04 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t7rhv-0007Xl-0l
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:41:04 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-460da5a39fdso27899751cf.1
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 23:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730706061; x=1731310861; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DkC+J0imOgGYmljz+sTGoYNGzbwwx11t9DsVwT2BzeI=;
 b=R4FTKDaUF64opXFDgaocp0bCMahsKkvu7HHczMXLPL2I8znS85gZVr6OqhctIvzeS4
 LDsKmTKRcraydlSVq0j5fxBR1IFfkHelTq44KDeScF6pzYOUY/3wugdz/qz+t/sH00ho
 jyv8E0LZ4BbrUwTzISXvBNrYzz49j7PVVfn9du2xLbPgoyzTSmVBxw0jOYDgqk6QPGSt
 R+4GPZqmiOtoNJdyA8CVmdNpSLWw9kvk67P/e+vTfJb7pYIlc3bJ98oo4JRQgCEKDCNi
 ZqBQe62oAGYF3CVpX4X4ZVJj7NORdqKoumpKJauQEmALSh0TPoOmSF1HKJM78zfSy5uu
 pH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730706061; x=1731310861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DkC+J0imOgGYmljz+sTGoYNGzbwwx11t9DsVwT2BzeI=;
 b=o/vee39HieEAUKuxZbtsRmuOS7voEF4Q8yQPfifJbBYXPDChaNQ13U1DQNR1FyPPrK
 SjpPHuA6Hbf3GhRZzOQm/nmvR8kuJYSEq8DLHIoC5EV+pk4GcCV+Rczs1Wr9DC8QYzvn
 5GIPEsdxynSI3QZJi6Sxo+A146wO77XQAZUcQCqBVloC9ShdJym6I1/KUXv9ClIVBKFm
 egqqu8fVjj/YNmtr14AWC6LoqvdAK8P2f4pTgqLheFvTpJd/ROMf4vSAKc8cv4ZTTzDJ
 ErmkkcTIP/IcogA9Xo16YWOJlq6N4i7QBWXs3mMTlOgXMpMmF0cbeDoAgwTiNGRJhEL/
 43AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgK8wNUY/CCY1UHbhWhWo2/s9mKlgn6WMYGtSV/KtxZLUb4R4UfPr26XhqQjdXkf8U6Pbk0X9Jcxsy@nongnu.org
X-Gm-Message-State: AOJu0YyIrlahlbmrOoCBPc0zftiwRWmysWGFc+k6iKT1LgxX+taM4fbK
 lXIrbItpDJGWl7b1GIsxvrqr24ySNxT2rZUuGYvc7g5oag1LSCF6KiG+dbeN4nNFxtR+BuQkTk+
 sdakq2Hf52zJCr9j+ZwEdxXeoRe0=
X-Google-Smtp-Source: AGHT+IGmiQB7J9BrxCU8KbGUOQjyUHZPJ7VUv1S29GwppCTTKgiR8dVJXHhX1ZN/QTtfJVfxct8yfxQED751RY3cerI=
X-Received: by 2002:a05:622a:1811:b0:461:2146:3ab7 with SMTP id
 d75a77b69052e-4613bfc86c2mr438905131cf.4.1730706061491; Sun, 03 Nov 2024
 23:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20241102110719.682399-1-r.peniaev@gmail.com>
In-Reply-To: <20241102110719.682399-1-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Nov 2024 11:40:50 +0400
Message-ID: <CAJ+F1CKLf7qv+HAon4z+fv7rOPbOV=878of4+WjGkuj2MUtFZA@mail.gmail.com>
Subject: Re: [PATCH 0/2] chardev/char-mux: tweak mux bitset operations
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000001892306261168b4"
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

--00000000000001892306261168b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Nov 2, 2024 at 3:11=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com> =
wrote:

> Patchset tweaks bitset operations by changing a constant to unsigned
> long, introduces a static compile check and simplifies bitset operations.
>
> Roman Penyaev (2):
>   chardev/char-mux: shift unsigned long to avoid 32-bit overflow
>   chardev/char-mux: make boolean bit check instead of find_next_bit()
>
>  chardev/char-mux.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Cc: qemu-devel@nongnu.org


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--00000000000001892306261168b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Nov 2, 2024 at 3:11=E2=80=AFPM Roman =
Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peniaev@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Patch=
set tweaks bitset operations by changing a constant to unsigned<br>
long, introduces a static compile check and simplifies bitset operations.<b=
r>
<br>
Roman Penyaev (2):<br>
=C2=A0 chardev/char-mux: shift unsigned long to avoid 32-bit overflow<br>
=C2=A0 chardev/char-mux: make boolean bit check instead of find_next_bit()<=
br>
<br>
=C2=A0chardev/char-mux.c | 15 +++++++--------<br>
=C2=A01 file changed, 7 insertions(+), 8 deletions(-)<br>
<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D=
"_blank">peter.maydell@linaro.org</a>&gt;<br>
Cc: Cl=C3=A9ment Mathieu--Drif &lt;<a href=3D"mailto:clement.mathieu--drif@=
eviden.com" target=3D"_blank">clement.mathieu--drif@eviden.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 =
Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@=
redhat.com</a>&gt; <br></div></div><br clear=3D"all"><br><span class=3D"gma=
il_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signatur=
e">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000001892306261168b4--

