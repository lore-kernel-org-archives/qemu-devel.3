Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A279BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 22:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW1BV-0000aF-LB; Mon, 22 Jul 2024 18:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sW1BP-0000Yy-Gs
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:07:03 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sW1BM-0000M7-Qw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:07:03 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70b703eda27so2122126b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721686018; x=1722290818;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JYZBXP2nXslwCWH7ZrB/pSTeK3jna5bS/B2OPfJZGj0=;
 b=aIyW7uih+Oi9yFW1AlOKXF421SIOjw3c2ueOkXNqE0Un27TeZVLPEkseUoQhjCWkZM
 cMkYtrIBQo6ujSZ/88zAvPlAYSMeBOldrkehgC38zXUg+ZTGbnAwjxCG/QcVIHJFxzIj
 8f9bPY+FGUdcZTxiHwqUzs4p7aHvCYf5T1KGhPXuYf+jiusSl5h6HDA9Oq8S/j+ScDEp
 /4DQf5IgaeGQhgwr2K71ylqstqOuQso8Q+rHjHuaRUZe30ZiABZppCzajO5eO1VBxiJy
 OjRg+uNbMJ+DjryBwEtlOmbTNomhop/p+uSc4p335rT7LDemoGJGKufSAdb9LZGd+QsQ
 nHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721686018; x=1722290818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JYZBXP2nXslwCWH7ZrB/pSTeK3jna5bS/B2OPfJZGj0=;
 b=SlZO15FFEUJdMp2bBL9uG+Yby2UxApPW+/BlR9Z69VYU4V1r4ew1EhfAsqRNJRR81Y
 cpzyM3TlsD/jaFgnCzqynWOUo06nwIHnaRO5GzBfQ3mp06mAo9BIZn36upjIppQQoexR
 LCccOdjZGrb40MVT4gYqJBKNU5HcCdho1gj9ZnCd/MO31enaO/KEvU5Gsm/LKy4jDrjj
 Sv17f/taSkqOQVXrIBVsLjzjWazshYi9IZsCR5FYDRaHx0le27KMBgRq6sGGyV504JJg
 CSE8jhWzlgV+8eDSYBwmMVQwfE6TDRQ8XiQWsAMqDI386t2FQmGAQOcXJXZs1Sew9Aaw
 nL+Q==
X-Gm-Message-State: AOJu0YxJM+n1Er8BoLZynJW9wYEK6q0lGC5fD4Sgl8L0O8eN6eSKPyqx
 BTvGGOOcIkQENcpkIBGjlGoGGNKfULRVP0EBO3WT5hfgwPEiDhSg957S+TH7HR/hXSrg3h9ZDJ/
 5K/pG9Zt8aOVsKmVPI0KJmWZm8akU1dabVWLbIg==
X-Google-Smtp-Source: AGHT+IEpyhwTD/Wqb9/uG1Mf0RUvLWj+6vpsBPgQtRboub5K4VTOMF2ay7Kps6Oi/toVjzwuq5j3rSOUGS87mayPB7s=
X-Received: by 2002:a05:6a00:84f:b0:70a:97d9:5b9e with SMTP id
 d2e1a72fcca58-70d0efa95b9mr6412067b3a.10.1721686018163; Mon, 22 Jul 2024
 15:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-15-imp@bsdimp.com>
 <f3c9d0c0-1cfd-46c8-8524-cffbe5180d3f@linaro.org>
In-Reply-To: <f3c9d0c0-1cfd-46c8-8524-cffbe5180d3f@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 22 Jul 2024 16:06:47 -0600
Message-ID: <CANCZdfpPrjt8G5WWRPdMNWyb=hskk7ZCVS3HEAcway=XO=K3ng@mail.gmail.com>
Subject: Re: [PATCH 14/14] bsd-user: Add aarch64 build to tree
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000871f6b061ddd4382"
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000871f6b061ddd4382
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 3:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Warner,
>
> On 22/7/24 23:43, Warner Losh wrote:
> > Add the aarch64 bsd-user fragments needed to build the new aarch64 code=
.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   configs/targets/aarch64-bsd-user.mak | 3 +++
> >   1 file changed, 3 insertions(+)
> >   create mode 100644 configs/targets/aarch64-bsd-user.mak
>
> Can we build aarch64 on Cirrus-CI? (not clear on
> https://cirrus-ci.org/guide/FreeBSD/). If so, could you add
> a follow-up patch to build that on our CI, patching
> .gitlab-ci.d/cirrus.yml?
>

We can build aarch64 host for bsd-user for sure. I'll see if we can do it
in cirrus CI.
If so, I'll try to add it to cirrus.yml.

This patch series adds aarch64 guest...

Warner

--000000000000871f6b061ddd4382
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 22, 2024 at 3:54=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Warner,<br>
<br>
On 22/7/24 23:43, Warner Losh wrote:<br>
&gt; Add the aarch64 bsd-user fragments needed to build the new aarch64 cod=
e.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0configs/targets/aarch64-bsd-user.mak | 3 +++<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 configs/targets/aarch64-bsd-user.mak<br=
>
<br>
Can we build aarch64 on Cirrus-CI? (not clear on<br>
<a href=3D"https://cirrus-ci.org/guide/FreeBSD/" rel=3D"noreferrer" target=
=3D"_blank">https://cirrus-ci.org/guide/FreeBSD/</a>). If so, could you add=
<br>
a follow-up patch to build that on our CI, patching<br>
.gitlab-ci.d/cirrus.yml?<br></blockquote><div><br></div><div>We can build a=
arch64 host for bsd-user for sure. I&#39;ll see if we can do it in cirrus C=
I.</div><div>If so, I&#39;ll try to add it to cirrus.yml.</div><div><br></d=
iv><div>This patch series adds aarch64 guest...</div><div><br></div><div>Wa=
rner</div></div></div>

--000000000000871f6b061ddd4382--

