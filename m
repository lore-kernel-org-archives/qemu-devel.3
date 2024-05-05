Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDDFC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 06:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3V0e-00049w-BB; Sun, 05 May 2024 02:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1s3V0S-00044i-8Y; Sun, 05 May 2024 02:05:52 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1s3V0Q-0005gE-4r; Sun, 05 May 2024 02:05:51 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-23f62699219so47992fac.0; 
 Sat, 04 May 2024 23:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714889148; x=1715493948; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=joSaW5Q73FN0Zzf2sziQVGs0aG3j4d1B9rZFS+CMsX8=;
 b=OQa7nPmXZekq1d2zzl6O+JJM0cjYsJlvDZ1/vmMA9zlnXYgh7MRUjMRX3y+IZ1g3FH
 Tb6PBtyZiJuCKAfRPPRB7OfStvJzxPCm7tXbYx9Y6L4PE7N2p/62+627zycpEumN0xno
 UrgMIj2D9hLaczS0rxoxoMfW6wMA51PuqzaLtjwU6+owxGk4CdQHvzZyAKJEyNFvvjyh
 25Bp/5k9v6GJlO8h1BucB2r0iUZjw7iJDZCTIT7E+eftfX/lqqBkMpRETqh51rpGXiVD
 V4LbETDTyPzXRyLpiY0pNHFez4CkpSKgomkOzhq5roEJ6TOnVg9OyakgMhWLD+8zx1Q4
 5q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714889148; x=1715493948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joSaW5Q73FN0Zzf2sziQVGs0aG3j4d1B9rZFS+CMsX8=;
 b=SlihpyVlhPtHGyiEHr+umYDRZwLgRswa7ZhKiCaODC7QzMv6IAqnC+LQGfLopgms3l
 PEOsLbhaQriUhPXMY4Di2TyQF/hn6zxuJyQMQsUbo6kKKSEgBqhUNoX5y6LZFYA6McFU
 idYZ8827cApuoOvxusKUpgMRsVYBnx3m7/nlLmvpNowvuAtPwZOUi7o0ixHZE7HeUECB
 HEQkahHxgO4/Wp3dAqwQkGfLKeyMsO5m25HmztFWjfSwkXeTMcvG7/52Q6lBAhWI/VmD
 754iG1lGkuKMZLnvafLw6NN9GJjzshhF2hJCho1DhWfutH5008lDJRCFevrAORMdPjWo
 4wvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3HzknkFipsHBx8FQr/APpKOBqHi/5nVrdihK5hxBtC/OfnHQVeIz84lvyLQ0dQF+Ds8li7VWa0VlGCN6z97GrGBBkxQU=
X-Gm-Message-State: AOJu0YwpycRKZFFF/rYy2PNHAkf6aamc+EO9U3qF6Y7nfCX57tB7nJdu
 VzVHYowU8815S3qSfIQIKYoTY8rDblkS8GepC2QNtBz/j0aip4Mfbtzudh7DL8ihOK37SNzZwWO
 HVQ/I3BD1fX5sdt48W70GR+uzoNmkuSPgKBw=
X-Google-Smtp-Source: AGHT+IG+QwKXasAwGdMo0OTPAleIX9Rlf/RdbuOgldV81FYuuW3JpAyZQ62QTNL4MSibQLNDwSj5MEaNs2v6+g+xrOk=
X-Received: by 2002:a05:6871:5213:b0:23c:6619:5970 with SMTP id
 ht19-20020a056871521300b0023c66195970mr8938671oac.7.1714889148221; Sat, 04
 May 2024 23:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnsOnM6gzcjpmEqCN0cFjZKXZCK_ZGAphuf46xWmUyBcNrAxQ@mail.gmail.com>
 <df14595f-3a26-4b7f-948d-df522f487b92@tls.msk.ru>
In-Reply-To: <df14595f-3a26-4b7f-948d-df522f487b92@tls.msk.ru>
From: Tanmay <tanmaynpatil105@gmail.com>
Date: Sun, 5 May 2024 11:35:37 +0530
Message-ID: <CAHnsOnNX=sWCM8pjKHnA6G_PVVjWhVi3RUbVVrPHtRX0hqA0Nw@mail.gmail.com>
Subject: Re: [PATCH] Fixes: Indentation using TABs and improve formatting
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008251f60617aebe99"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=tanmaynpatil105@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000008251f60617aebe99
Content-Type: text/plain; charset="UTF-8"

Hi,

I completely agree!
This was more of a "NEWCOMERS" issue to help us understand how the patch
flow works.
I'll take up a trivial issue and work on it instead.

Thanks,
Tanmay

On Sun, 5 May 2024 at 02:05, Michael Tokarev <mjt@tls.msk.ru> wrote:

> 04.05.2024 21:58, Tanmay wrote:
> > Hi,
> >
> > I have attached a patch file that fixes indentation and formatting for
> some files as listed in https://gitlab.com/qemu-project/qemu/-/issues/373
> > <https://gitlab.com/qemu-project/qemu/-/issues/373>.
>
> it is sort of good you posted this patch to stable@.  It has absolutely
> nothing to do
> with stable, but it serves as a an example of things which should - in my
> opinion -
> not be done at all.  We had another similar change, 55339361276a "sh4:
> Coding style:
> Remove tabs", which makes all further changes (fixes) in this area
> basically
> non-back-portable to previous stable series.
>
> FWIW,
>
> /mjt
> --
> GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
> New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD
> 3D98 ECDF 2C8E
> Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C
> E0A0 8044 65C5
> Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt
>
>

--0000000000008251f60617aebe99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I completely agree!<br></d=
iv>This was more of a &quot;NEWCOMERS&quot; issue to help us understand how=
 the patch flow works.<br>I&#39;ll take up a trivial issue and work on it i=
nstead.<br><br></div><div>Thanks,<br></div><div>Tanmay<br></div></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 5 M=
ay 2024 at 02:05, Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt=
@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">04.05.2024 21:58, Tanmay wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I have attached a patch file that fixes indentation and formatting for=
 some files as listed in <a href=3D"https://gitlab.com/qemu-project/qemu/-/=
issues/373" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-pr=
oject/qemu/-/issues/373</a> <br>
&gt; &lt;<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/373" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/is=
sues/373</a>&gt;.<br>
<br>
it is sort of good you posted this patch to stable@.=C2=A0 It has absolutel=
y nothing to do<br>
with stable, but it serves as a an example of things which should - in my o=
pinion -<br>
not be done at all.=C2=A0 We had another similar change, 55339361276a &quot=
;sh4: Coding style:<br>
Remove tabs&quot;, which makes all further changes (fixes) in this area bas=
ically<br>
non-back-portable to previous stable series.<br>
<br>
FWIW,<br>
<br>
/mjt<br>
-- <br>
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.<br>
New key: rsa4096/61AD3D98ECDF2C8E=C2=A0 9D8B E14E 3F2A 9DD7 9199=C2=A0 28F1=
 61AD 3D98 ECDF 2C8E<br>
Old key: rsa2048/457CE0A0804465C5=C2=A0 6EE1 95D1 886E 8FFB 810D=C2=A0 4324=
 457C E0A0 8044 65C5<br>
Transition statement: <a href=3D"http://www.corpit.ru/mjt/gpg-transition-20=
24.txt" rel=3D"noreferrer" target=3D"_blank">http://www.corpit.ru/mjt/gpg-t=
ransition-2024.txt</a><br>
<br>
</blockquote></div>

--0000000000008251f60617aebe99--

