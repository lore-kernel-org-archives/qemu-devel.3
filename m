Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498DAD216A9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iIN-0003Wh-RN; Tue, 15 Oct 2024 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t0iIL-0003W6-R7
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:13:05 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t0iIK-0002nQ-6d
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:13:05 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-84ea1e5e964so3465736241.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729001582; x=1729606382; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uv24sxOIWDaXySEDhSJgMbl6NmfFuI2E75I9MOxSq74=;
 b=fAHcAWVhVhtTzlqW0ix24+QG3RSmM4FZegSkdJ8jwASMqYhlb2UecO+2SlHTzwtQfL
 WFNs8tDsTwROUbsPvdoqAORRAClXaYNC54a+Xg9RNZxdPoMQ/rbpgFmLnYBG5gKoCrtG
 wRgUOph4lJOWKqoKzbYPWnc6FvPiYvAw0scGhyxrMjCOnbf+ztwSuPUuQABhP2Zx8NzJ
 GIA/l28/byv5N/TfQr2tbR9JiU3OA3lNndkVZrUE4kUmUYlh9W7KiRJaKmQUDwNvx6wx
 nuDrI3XMYPa9K8nFdyV33Y63oQAF2GeoWbnh7Yic9yQMf+9agGHB9jmfBIZIEwxYjs9Y
 D35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001583; x=1729606383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uv24sxOIWDaXySEDhSJgMbl6NmfFuI2E75I9MOxSq74=;
 b=KTUTriOdHf0ZRZg9zUnw83Nt/zmx/GvvEM2DeQIIuEmAXnV2VbtYuT1TvQkYnc0eXf
 pj4jBtHBQjRWfeqJZRVZXr6jA8fDj8pljwAAXAVSAMmh/SaEUXtX5NAq6ZXYMcI1K0jq
 UIDiupBdvm1IoRPySy8JEjXFcJPVijrm/g5bnHNUH1t2NGTwsqpyD6YjjLk8jqlO3V31
 FEZFmXVh08m/2jJM77JrdcnEMQCLt5UZJVA581TIXo9oS7tNCWAPBv1XajdznEWqXu2j
 Mj/z4SJyiCo+GkT3GLiYSaNF8mRn9JJq4O6wtwdb9mJWB142XKrmuFzh48DktpBJz+MS
 xpEw==
X-Gm-Message-State: AOJu0Yy1z4nDJWndeq6NkD+d2oq6LS2c4W/HvlbrxxelRZxxhdY9FMeO
 2zgPnIDpAhNLZGJWLH9tcMa0Sfw544QS0DXpKykS/tB550dqc4+kGhVfWX36y6LdJkNbVDnvd8f
 YWbwn6Lp6Xi5dEdFDKZHaManp2Fs=
X-Google-Smtp-Source: AGHT+IHycepXoT4shLSd6PpvQzLaZJyjryVYYqS9aUnvIj3VsbOttpC8v4K7pv5U6dBLEGUxHRYZauoDFNdnaFKPypI=
X-Received: by 2002:a05:6122:2216:b0:50c:ef20:6bed with SMTP id
 71dfb90a1353d-50d1bb18ba6mr9728991e0c.3.1729001582384; Tue, 15 Oct 2024
 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241015125629.301367-1-berrange@redhat.com>
 <20241015125629.301367-2-berrange@redhat.com>
In-Reply-To: <20241015125629.301367-2-berrange@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 15 Oct 2024 20:13:00 +0600
Message-ID: <CAFfO_h4fTspFTHJVHeoCz5TSBtS9HV5v6dr6sZMsrHQ_uodZ2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto/hash: avoid overwriting user supplied result
 pointer
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002262200624848d84"
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x935.google.com
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

--0000000000002262200624848d84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:56=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> If the user provides a pre-allocated buffer for the hash result,
> we must use that rather than re-allocating a new buffer.
>
> Reported-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/hash-gcrypt.c | 15 ++++++++++++---
>  crypto/hash-glib.c   | 11 +++++++++--
>  crypto/hash-gnutls.c | 16 +++++++++++++---
>  crypto/hash-nettle.c | 14 +++++++++++---
>  4 files changed, 45 insertions(+), 11 deletions(-)
>

Thanks for fixing. These changes look good to me but it might make sense to
update the corresponding api documentation in include/crypto/hash.h to
explicitly mention that *result can be a user supplied buffer with proper
*result_len, if not, allocated inside the function itself. I see a few
places in that file that may be worth updating as part of this commit. What
do you think?

Regards,
Dorjoy

--0000000000002262200624848d84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 15, 2024 at 6:56=E2=80=AF=
PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">If the user provides a pre-allocated buffer for the hash resu=
lt,<br>
we must use that rather than re-allocating a new buffer.<br>
<br>
Reported-by: Dorjoy Chowdhury &lt;<a href=3D"mailto:dorjoychy111@gmail.com"=
 target=3D"_blank">dorjoychy111@gmail.com</a>&gt;<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0crypto/hash-gcrypt.c | 15 ++++++++++++---<br>
=C2=A0crypto/hash-glib.c=C2=A0 =C2=A0| 11 +++++++++--<br>
=C2=A0crypto/hash-gnutls.c | 16 +++++++++++++---<br>
=C2=A0crypto/hash-nettle.c | 14 +++++++++++---<br>
=C2=A04 files changed, 45 insertions(+), 11 deletions(-)<br></blockquote><d=
iv><br></div><div>Thanks for fixing. These changes look good to me but it m=
ight make sense to update the corresponding api documentation in include/cr=
ypto/hash.h to explicitly mention that *result can be a user supplied buffe=
r with proper *result_len, if not, allocated inside the function itself. I =
see a few places in that file that may be worth updating as part of this co=
mmit. What do you think?<br></div><div><br></div><div>Regards,<br></div><di=
v>Dorjoy<br></div></div></div>

--0000000000002262200624848d84--

