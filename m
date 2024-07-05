Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AC6C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPlEw-0008In-Nv; Fri, 05 Jul 2024 11:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sPlEv-0008HP-O5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sPlEu-0001Oa-3T
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720194767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NMrfNHlzkjcsTNOD+0GHdJcY1TJNRx/RCDWS3xygGVI=;
 b=LZ+ZWQ5qASbwKBfODLMz1K9evy+oC4wshysurcrgCCcxVfap+NF5VHxOzWOZjjqCjtOOd4
 9on0CsgIajkwZtF7yd1vJeDuymY6ZozOHtL/dZKf+crFEtQAmyEBXMcDwZQPNG2WbIbfG4
 4bNY4nkm09QLj3vIwDYS95dbylja62s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-L8tvGOD6PEuGl7j_4U7hAA-1; Fri, 05 Jul 2024 11:52:45 -0400
X-MC-Unique: L8tvGOD6PEuGl7j_4U7hAA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c9015b0910so2342093a91.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720194764; x=1720799564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMrfNHlzkjcsTNOD+0GHdJcY1TJNRx/RCDWS3xygGVI=;
 b=dOTs3eJtK5gwEZjDXZfTMDbSWwRCNvYaEvupJ5WsfjKusFT8BlWm/zzpxij4nXwmlC
 odi6ajMn5bLXrss/hIa/wBdK/vUfajgQ9kkr7i2uwZGhMn4vi4xJDdp62mQaym5U/CV9
 j55Mmvbjl0jdDFUSOR1uXy95LgWA3PP6RadiYRA24hENWdfMc8gOcMGSB4/g7OSLSn7W
 TcC7rG44CgH/dO+7vVXDHzVxxDnnLD55UNkdadeZRdXj0vxTCUZJ50BjUxjxtbSZyhbz
 zq60jHbx8w2cfYeUiPD3GImDM6rAdmNwVmUV8aQWbFQl+Wx1H4V10KCtBjOMmuTAUspr
 cdsw==
X-Gm-Message-State: AOJu0Yzf6wBAr3TzTbm0cC1uWtLgPouo45aFF3eXF8mH/iFnH8vJAf2J
 oEnHWBOOail7oplMe5tsduQcMvuJpugJ4VO/F2Ha0j767vh0J5RM6yYHrzkziGXPfDQuT7hujEs
 4gWSNjhwQhcCDGRwJ9YIVrSAf6ebvMXDmiT50j4EqYUjMy5VrV2gIXU7zUTOZAKue8GZ1bEHqZH
 J4AemiSe1YqOU6h4odhjrCAgHf59NkdME+GDc=
X-Received: by 2002:a17:90a:1197:b0:2c8:5055:e24f with SMTP id
 98e67ed59e1d1-2c99f2fd2c8mr6706180a91.2.1720194763787; 
 Fri, 05 Jul 2024 08:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPaOutwkwV8rmV80gOnHvNtV8c1L40XTt2OzNuyD0VL0zktASDlpuTeEemH0SWvKMbjkiEp2plShTiFCgvrT8=
X-Received: by 2002:a17:90a:1197:b0:2c8:5055:e24f with SMTP id
 98e67ed59e1d1-2c99f2fd2c8mr6706149a91.2.1720194763143; Fri, 05 Jul 2024
 08:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240626232230.408004-1-jsnow@redhat.com>
In-Reply-To: <20240626232230.408004-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 5 Jul 2024 11:52:30 -0400
Message-ID: <CAFn=p-ZF1mZC1rbHXe5rX-PMpKSOk+=Lg563aApKVUQwrQ6cwA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Python: Add 3.13 support, play linter whackamole
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cd5963061c820d0d"
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

--000000000000cd5963061c820d0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024, 7:22=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> Fix some regressions in check-python-tox that have crept in since Pylint
> 3.x, and add Python 3.13 support to the pipeline.
>
> GitLab pipeline (before I fixed the missing DCO, but let's be honest, it
> can't possibly be worth re-running so many tests for just that):
>   https://gitlab.com/jsnow/qemu/-/pipelines/1349737188
>
> John Snow (4):
>   python: linter changes for pylint 3.x
>   python: Do not use pylint 3.2.4 with python 3.8
>   iotests: Change imports for Python 3.13
>   python: enable testing for 3.13
>
>  python/qemu/machine/machine.py         | 1 +
>  python/qemu/utils/qemu_ga_client.py    | 2 +-
>  python/setup.cfg                       | 4 +++-
>  tests/docker/dockerfiles/python.docker | 1 +
>  tests/qemu-iotests/testenv.py          | 7 ++++++-
>  tests/qemu-iotests/testrunner.py       | 9 ++++++---
>  6 files changed, 18 insertions(+), 6 deletions(-)
>
> --
> 2.45.0
>

Staging under my Python branch, since I need to get tests green to roll
forward with some more substantial changes.

--js

>

--000000000000cd5963061c820d0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 26, 2024, 7:22=E2=80=AFPM John Snow &lt;<a=
 href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Fix some regressions in check-python-tox tha=
t have crept in since Pylint<br>
3.x, and add Python 3.13 support to the pipeline.<br>
<br>
GitLab pipeline (before I fixed the missing DCO, but let&#39;s be honest, i=
t<br>
can&#39;t possibly be worth re-running so many tests for just that):<br>
=C2=A0 <a href=3D"https://gitlab.com/jsnow/qemu/-/pipelines/1349737188" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qemu/=
-/pipelines/1349737188</a><br>
<br>
John Snow (4):<br>
=C2=A0 python: linter changes for pylint 3.x<br>
=C2=A0 python: Do not use pylint 3.2.4 with python 3.8<br>
=C2=A0 iotests: Change imports for Python 3.13<br>
=C2=A0 python: enable testing for 3.13<br>
<br>
=C2=A0python/qemu/machine/machine.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +=
<br>
=C2=A0python/qemu/utils/qemu_ga_client.py=C2=A0 =C2=A0 | 2 +-<br>
=C2=A0python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 +++-<br>
=C2=A0tests/docker/dockerfiles/python.docker | 1 +<br>
=C2=A0tests/qemu-iotests/testenv.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 7 +=
+++++-<br>
=C2=A0tests/qemu-iotests/testrunner.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 9 ++++++=
---<br>
=C2=A06 files changed, 18 insertions(+), 6 deletions(-)<br>
<br>
-- <br>
2.45.0<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Staging under my Python branch, since I need to get tests green to ro=
ll forward with some more substantial changes.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">--js</div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000cd5963061c820d0d--


