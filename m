Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707C1C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPlCk-0007N0-Gd; Fri, 05 Jul 2024 11:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sPlCi-0007Mm-MS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sPlCb-0008TL-S8
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720194621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=weDaGjOAUwFqvvd7/Kx5DdMHewGv1COwQycMqPQvvNI=;
 b=bqq3fu+tyoLNts5cjWorQ/0yVu5Rbz4ygKK8xyulhgN4hVvB0QaQZdD/7AbMqKuX0Tg0mu
 ghB7tKNEWvvJECcA5j8NklaDXQPaFkOkCRA8AumgQ1QYEz5TxRFzXzjKxagjVDxXuvt9u9
 pJOmT5IhhsRilTYCL/S/+PS3AOeBZKk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-BTSXSwbVPre2xMZzUSguTg-1; Fri, 05 Jul 2024 11:50:19 -0400
X-MC-Unique: BTSXSwbVPre2xMZzUSguTg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7623e193d89so1145960a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720194617; x=1720799417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=weDaGjOAUwFqvvd7/Kx5DdMHewGv1COwQycMqPQvvNI=;
 b=Y16OPp+A8Ly7wrGNNnUfElJc5+Y8VMg7Gf8+8agWGR6/hJ08yHWNN5oloUkug52JqT
 abSceiPJYSPQLfhxO/Nza0QuMOmGgTOUPF1gvjMl//IA3kx5dROR+ET1afNNKJFN7cyn
 h9927mr7yejaSsX8euKuH3jcoqEquhzRlE1/jqrdiVLz43EcT3pj62TK6NjJ6p49qYzy
 1J1ALxEbSydiLpz5gnfnIg0mXb1AoXchGHcS/qNcs+RHCczUAvc7L/CXACIJTswF40Wg
 OHxIb7J3tEJAVTXTaUkPRHOtTGRyVKAxfUC/GoYVkkzzLN3KWCgp0N/Am0zAzq7epsSt
 PGiQ==
X-Gm-Message-State: AOJu0YyHEBy1vuO+HXzvM/REah7Dm4m85Mx3HXUmsPfJUygtSa4b+3Yd
 IWjRpbE25cT2xwK0+o5tsFYhDaTFgJxD2rT53AbTDArnPIr+gslb62FYLM5qLWOt0+bO2bnGSYj
 NUNofxzu4Uwqt+VB1TfVcr3HFLGQU3FAozUsKEmDbCOEGxV7K8ZQ38t/6gFJPY+GwF5rRwRLxus
 AJkIn0AxQ7ECmbkJLMc41MZj4qf6d77IXRXNM=
X-Received: by 2002:a17:90a:d803:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2c99c6b383emr3828161a91.35.1720194617515; 
 Fri, 05 Jul 2024 08:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGD2EGdQlC4L8A9PwJ6h35oPhNxfCD2hhuDENSSQD9jFtU4M/cXKjASnS/mt7JRgNjfgfg/L5jHIejKtBhkoE=
X-Received: by 2002:a17:90a:d803:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2c99c6b383emr3828147a91.35.1720194617107; Fri, 05 Jul 2024
 08:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240703175235.239004-1-jsnow@redhat.com>
In-Reply-To: <20240703175235.239004-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 5 Jul 2024 11:50:04 -0400
Message-ID: <CAFn=p-Z6jM3AVodkNh=n=-4+W8wF4suG1S_O2tNCotewkLTruw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] docs/python: bump minimum Sphinx version
To: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000018fce5061c82052c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000018fce5061c82052c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024, 1:52=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> With recent deprecations, we can advance our minimum sphinx version
> safely. This is heavily motivated by new qapidoc work which is much
> easier to maintain cross-version compatibility for - see difficulties in
> our dbus documentation which only works on sphinx >=3D 4.
>
> We can only guarantee >=3D 3.4.3 now, but that's still vastly easier than
> maintaining compatibility all the way back to 1.x.
>
> https://gitlab.com/jsnow/qemu/-/pipelines/1359549621
>
> (failures appear to be unrelated to the series.)
>
> V2: refactor all code deletions into patch 2
>
> John Snow (2):
>   Python: bump minimum sphinx version to 3.4.3
>   docs: remove Sphinx 1.x compatibility code
>
>  docs/conf.py             |  7 +++----
>  docs/sphinx/hxtool.py    | 21 ++++-----------------
>  docs/sphinx/kerneldoc.py | 38 ++++++++++++--------------------------
>  docs/sphinx/kernellog.py | 28 ----------------------------
>  docs/sphinx/qapidoc.py   | 29 +++--------------------------
>  pythondeps.toml          |  2 +-
>  6 files changed, 23 insertions(+), 102 deletions(-)
>  delete mode 100644 docs/sphinx/kernellog.py
>
> --
> 2.45.0
>

Going to assume It's okay for me to stage this one under my Python tree.

Markus: This will create a minor conflict with the notes patches (the
delint patch), but the resolution is straightforward.

--js

--00000000000018fce5061c82052c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jul 3, 2024, 1:52=E2=80=AFPM John Snow &lt;<a =
href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">With recent deprecations, we can advance our =
minimum sphinx version<br>
safely. This is heavily motivated by new qapidoc work which is much<br>
easier to maintain cross-version compatibility for - see difficulties in<br=
>
our dbus documentation which only works on sphinx &gt;=3D 4.<br>
<br>
We can only guarantee &gt;=3D 3.4.3 now, but that&#39;s still vastly easier=
 than<br>
maintaining compatibility all the way back to 1.x.<br>
<br>
<a href=3D"https://gitlab.com/jsnow/qemu/-/pipelines/1359549621" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qemu/-/pipel=
ines/1359549621</a><br>
<br>
(failures appear to be unrelated to the series.)<br>
<br>
V2: refactor all code deletions into patch 2<br>
<br>
John Snow (2):<br>
=C2=A0 Python: bump minimum sphinx version to 3.4.3<br>
=C2=A0 docs: remove Sphinx 1.x compatibility code<br>
<br>
=C2=A0docs/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7=
 +++----<br>
=C2=A0docs/sphinx/hxtool.py=C2=A0 =C2=A0 | 21 ++++-----------------<br>
=C2=A0docs/sphinx/kerneldoc.py | 38 ++++++++++++--------------------------<=
br>
=C2=A0docs/sphinx/kernellog.py | 28 ----------------------------<br>
=C2=A0docs/sphinx/qapidoc.py=C2=A0 =C2=A0| 29 +++--------------------------=
<br>
=C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A06 files changed, 23 insertions(+), 102 deletions(-)<br>
=C2=A0delete mode 100644 docs/sphinx/kernellog.py<br>
<br>
-- <br>
2.45.0<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Going to assume It&#39;s okay for me to stage this one under my Pytho=
n tree.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Markus: This wil=
l create a minor conflict with the notes patches (the delint patch), but th=
e resolution is straightforward.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">--js</div><div dir=3D"auto"><br></div></div>

--00000000000018fce5061c82052c--


