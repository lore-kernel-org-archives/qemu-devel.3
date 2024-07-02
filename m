Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFA8C31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjhE-0002LJ-QM; Tue, 02 Jul 2024 16:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOjhA-0002Kg-EM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOjh8-00054j-Oa
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719950501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4AGPlNJFw2joUXXjyM/R0fQ9nmCPdKV7rxzJkpcrpw4=;
 b=O92iW+3v4gkgrR+YYwh9Nb1LiH8fzpRlZPMC2WfdAgm3YwP22wCENH/cUT0vNNwG22F111
 VfRb21UTXfV3mjjMkT19VIK6tRBc76WXhAU85UIJgsi3+dDxHvPl0D2ibWc+hvu02tOUJP
 KHdhsuOJWRsUefDZJlXIrm1QGUaQGRM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-3dZNyQylMkqc4w62Bd9C6Q-1; Tue, 02 Jul 2024 16:01:39 -0400
X-MC-Unique: 3dZNyQylMkqc4w62Bd9C6Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c30144b103so3675161a91.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719950497; x=1720555297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4AGPlNJFw2joUXXjyM/R0fQ9nmCPdKV7rxzJkpcrpw4=;
 b=U/I2nVZ3roM8yXwGkM0ut0C3pm6g1xgDHfRs9MSCaU8/en4qu8S7oUeiyFR53UADqv
 BNfbTmFnPucNrrBdoAABqOcAlcvzPOH2nPe91UjvU7lFitcrHe6oLaNI3DPY6/0ANfBz
 KgXxJMMsrZ1DTf/ZCOlUI2JG63Bu2+cYT07XN1ojUUA5GchQbgqreoZRXgN84xti4FYT
 pDgnlrHLPXhlr10snABaP1XoMYCM6z7D1e0ADJCqqgMcJWx3pL5c5zjoq6WvbAY/psg/
 uvdGUQOEuo2P7SIuCLazGBhesIU6/3cucWDU9+lLqvN232PZxOZspMNbyCfRPd9p2X/9
 Nh1w==
X-Gm-Message-State: AOJu0Yyu8Yay2deOTAGm9eUILZ7qATpOHQpnyKh5d6/G8vJrEaHmNuR9
 umCw7rtdW1MmFwgmF226GklIzt8IzuZpA699Vx8zzlQiAv30UVRdbd1eAptkZwYEtRcOyNFdVGz
 F4yzGAm9naXfOXTp8iuEYXUUeV0tlxPmmuzOnCwgYP9hmRLXQ32/L2k0IUU4vw+OrEwVYltqLO8
 LgBB5m4oYHuV+KROwRdXJ3mb3W6XE4vpiY7aw=
X-Received: by 2002:a17:90b:230f:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c93d2d18d8mr14926344a91.21.1719950497552; 
 Tue, 02 Jul 2024 13:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcwZRubx0USigz8lmLSqODVE4A06i4IKqkgPyLWo/eCZsDJbwMw/f/jRU90cOvn9t9IDT49RCFiTFCyN2tbXU=
X-Received: by 2002:a17:90b:230f:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c93d2d18d8mr14926312a91.21.1719950497090; Tue, 02 Jul 2024
 13:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240702195903.204007-1-jsnow@redhat.com>
In-Reply-To: <20240702195903.204007-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 2 Jul 2024 16:01:24 -0400
Message-ID: <CAFn=p-Y1r3SfoA=T9rPMnTzk2ZiF28R8GUCGmLdEdhFnSDzarA@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs/python: bump minimum Sphinx version
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000006935de061c492e32"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

--0000000000006935de061c492e32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:59=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> With recent deprecations, we can advance our minimum sphinx version
> safely. This is heavily motivated by new qapidoc work which is much
> easier to maintain cross-version compatibility for - see difficulties in
> our dbus documentation which only works on sphinx >=3D 4.
>
> We can only guarantee >=3D 3.4.3 now, but that's still vastly easier than
> maintaining compatibility all the way back to 1.x.
>
> GitLab: https://gitlab.com/jsnow/qemu/-/pipelines/1357902509
>
> (failures appear to be unrelated to the series.)
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

Bleurgh. I meant to shuffle some of the changes in patch 1 into patch 2,
I'll fix that on re-spin. If you want to review it anyway, just presume
I'll fix that next go-around.

--js

--0000000000006935de061c492e32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024 at 3:59=E2=80=AFP=
M John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">With re=
cent deprecations, we can advance our minimum sphinx version<br>
safely. This is heavily motivated by new qapidoc work which is much<br>
easier to maintain cross-version compatibility for - see difficulties in<br=
>
our dbus documentation which only works on sphinx &gt;=3D 4.<br>
<br>
We can only guarantee &gt;=3D 3.4.3 now, but that&#39;s still vastly easier=
 than<br>
maintaining compatibility all the way back to 1.x.<br>
<br>
GitLab: <a href=3D"https://gitlab.com/jsnow/qemu/-/pipelines/1357902509" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qemu/-/pipeline=
s/1357902509</a><br>
<br>
(failures appear to be unrelated to the series.)<br>
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
2.45.0<br></blockquote><div><br></div><div>Bleurgh. I meant to shuffle some=
 of the changes in patch 1 into patch 2, I&#39;ll fix that on re-spin. If y=
ou want to review it anyway, just presume I&#39;ll fix that next go-around.=
</div><div><br></div><div>--js <br></div></div></div>

--0000000000006935de061c492e32--


