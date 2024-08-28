Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF3C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 06:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjCNT-0005Vz-S8; Wed, 28 Aug 2024 02:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sjCNO-0005VI-4h
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:41:54 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sjCNM-0006ny-PI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:41:53 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-45327512c3eso34893321cf.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724827311; x=1725432111; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R7wmPsFssthWDMM5eT4MkIKfVEE//6Oeu5Ria35L+iE=;
 b=bhar5BaIb6VzXTKk8zUB12YUgRvdKFIKoqEOen2O5RechHp6bDGL/GqQA+Iy+5uvel
 gQLVt09EaUcp9VVjsbX4YKJnkEqcdCUk2PkQquQ1qzuSvTquhltttpEkBbudPa6AYVAM
 uZqpNsbduIgRlFKX8HYIKQfYnUI7pIYglYscbEgLv6mURsheGRFmm+jPfpnsu1jPe6Nw
 7pmT9oXXsvD1qtcRjc8H7gCFEjPZEZHPKkA7Ar6M2lITYILgnJGsBhrYPF41MxqDVft8
 UayIrUXGx+7RIk/taq6nZUuw6qs9f2/HygECBM3YR5odMXEqo/x/SO6kwHld8TlsTurk
 t4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724827311; x=1725432111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7wmPsFssthWDMM5eT4MkIKfVEE//6Oeu5Ria35L+iE=;
 b=JQWYAHE8NAU6jAPTntgDgSjVai+nXgqo2jX1z3Afd2t7PGs/2oxHwhLh7Sb/w+TzeL
 MMvG70P3BxffFjn9OyHbyv/bZgbjIGAH5obaZaYZu+cK2Vg7Fdgjmr6y2zfXpDKdpv9H
 +0d1S+QDGD7l/ETwqgY0IrBwLLord+Bd/asRLXjKhkn6Dh2HMrtuhQwE9m3lhvvDvUt7
 4m4qCz1q5/jjhfQSGJ16E4AlX3CcG67jpKTNUNC09KGqfIQ7mtqsxZAJtMy0kHP4Pxwu
 HTJv7MqlhdqM1kuxFqMfjxu16T1EThtahlNkv3OG3FVAlxd/taFfeWlK0yn7fXjNK8Qr
 iAAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlQfVfIZz4ZA3r+5ePEGtfMpEmBgZu/YVQSBrtbpJMPDl9AfSVh1ULQl6Z9PSESD4sfPWbeQ1T2B/4@nongnu.org
X-Gm-Message-State: AOJu0YysveG0UIkncPWvvoittcVqwBEr2IJFEzLPQ+8Odvh0dhhPY9PX
 Vc7poVjkqALGnrwaStki9yRmI2shn4n4BNb79rlPMQ+WbbkiERUn9ljCJJAyLnJ5TfzSI/ezAde
 wN9og0K7uLHGs2dyPk2XtE3wkxWg=
X-Google-Smtp-Source: AGHT+IHDz4+HXW/l86S9mjFwMsUVQi3hIYA9cNhDR6MAs4WYBOxosZmPd+Bwep07xpeVr2RMQC8swZzk8Iu4Z4aRXWU=
X-Received: by 2002:a05:622a:248b:b0:446:4a6d:44aa with SMTP id
 d75a77b69052e-45509ced3edmr174957751cf.52.1724827311143; Tue, 27 Aug 2024
 23:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240828043337.14587-1-npiggin@gmail.com>
In-Reply-To: <20240828043337.14587-1-npiggin@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 28 Aug 2024 10:41:39 +0400
Message-ID: <CAJ+F1CL375Qb2CCWG6j=Ns_wde_xvyFN+ujbzwW+DkWF7kFwfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] chardev: fixes for recent record/replay on muxed
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002e00e10620b8a763"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

--0000000000002e00e10620b8a763
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 28, 2024 at 8:34=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com>=
 wrote:

> Fix a couple of issues that Peter found with recent record/replay
> fix for muxed device.
>
> Thanks,
> Nick
>
> Nicholas Piggin (2):
>   chardev: Fix record/replay error path NULL deref in device creation
>   chardev: Remove __-prefixed names
>
>  chardev/char.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> --
> 2.45.2
>
>
>
Series,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--0000000000002e00e10620b8a763
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Aug 28, 2024 at 8:34=E2=80=AFAM Nicho=
las Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npiggin@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fix a =
couple of issues that Peter found with recent record/replay<br>
fix for muxed device.<br>
<br>
Thanks,<br>
Nick<br>
<br>
Nicholas Piggin (2):<br>
=C2=A0 chardev: Fix record/replay error path NULL deref in device creation<=
br>
=C2=A0 chardev: Remove __-prefixed names<br>
<br>
=C2=A0chardev/char.c | 22 ++++++++++++----------<br>
=C2=A01 file changed, 12 insertions(+), 10 deletions(-)<br>
<br>
-- <br>
2.45.2<br>
<br>
<br></blockquote><div><br></div><div>Series,<br></div><div>Reviewed-by: Mar=
c-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marc=
andre.lureau@redhat.com</a>&gt; <br></div></div><br clear=3D"all"><br><span=
 class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000002e00e10620b8a763--

