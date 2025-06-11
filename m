Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326A9C71137
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 17:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPOpd-0001wL-T6; Wed, 11 Jun 2025 13:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPOpa-0001vt-Ut
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 13:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPOpY-00008P-Mt
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 13:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749661298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kxAHTkHp4cg4K+i25GqXzZqeYY1egWB+edkVlVmls7M=;
 b=ESJgbDgk9w9+QrXIUZfCB5rh4zpx8lNNlK/iP2tHhyH3leMyWLqfwFAz1POptM2c1MyMli
 uJeAckz+H1ZRVcbMmpFhekKTeVwGaZ6VYTLnHVoMtnTGvnnDkTzUy5yW68udeRxXTVffRs
 QuKjI1P5Ytx++d1BFSiCIfPFBU/wOvY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-pZBSak18PcSiCuYAELIjSg-1; Wed, 11 Jun 2025 13:01:36 -0400
X-MC-Unique: pZBSak18PcSiCuYAELIjSg-1
X-Mimecast-MFC-AGG-ID: pZBSak18PcSiCuYAELIjSg_1749661296
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2e922a13d49so6260108fac.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 10:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749661294; x=1750266094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxAHTkHp4cg4K+i25GqXzZqeYY1egWB+edkVlVmls7M=;
 b=WDoiAYoyX6K2PXa7YOpubWLbZdFgI75yn9+Q2/1OhfeFzJSJnSRopwQ/oV3///ywCE
 bWByC9ZzKPpBzvlD3wfESeG/ndy47MXalujzOYMXdWTxSPYd6yv9ZVj9UpclGyBZ6OsE
 nGFMmUP53Qrth4j7bv87ZyH+uqE8ROZIdqNQrcH4rXioEKzu6ohm7ih2DzW83QZkCICb
 MCTCaIZ5zrYLoiKET12nma7y5ILacv1GQs5M4+7LeNYaVh16EfOi8aUPOeHtJtqeSWVm
 WpWymMurFEJEXmhVBIOVUB3o/UWTjtWIZ0CoWIcDx/AFxSPy+PIHv2bsMSrhxvc1a7/p
 lF0A==
X-Gm-Message-State: AOJu0YzmVp3MWzG5roPuyp5aGVCP4yQxuvU1qm9Rq9lmOPMBEkypeGKj
 SG9KYoN8nRcame+/2bhZSyVEc0Ido9mWMOmljZVyAT7husZhq2vfQCDHmTMo4dFdhKkgSg7E/zH
 1GXZU5fY3A9Me6K9tn39N8IQh4a6afLA7bw5ynclM6iqmMfMJoVgJ0b+WdDzA6QZde2s1/QLDP5
 rS6S98U1mjdw+GswHTLqKhvQLmDRoOYvoCqflCcU/QVA==
X-Gm-Gg: ASbGncvCOw4woElRriEtc8heQ65ONzNnOuQx2feor/hWZermXkSfE5/wo17j/ImvCXL
 WsuzE/k9WrebhW6qGxtHSb8FDqiK3M6IMgM3AYAnVGHC6xwwonl2ajHI8X+nWfn9WUDQpM/Gceq
 qd
X-Received: by 2002:a05:6870:41ce:b0:2d4:ce45:6983 with SMTP id
 586e51a60fabf-2ea96c31d98mr2372196fac.10.1749661291868; 
 Wed, 11 Jun 2025 10:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYzEaIVLICiDwt4Wvh9+xprSwxiXM7wLz4ee79W++FIpZ9nxAPJUuzoeDljxvem2Pk+NnP9qk5QjWQAnRi3yY=
X-Received: by 2002:a17:90b:5102:b0:313:62ee:45a with SMTP id
 98e67ed59e1d1-313af172849mr5736947a91.13.1749661278342; Wed, 11 Jun 2025
 10:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250606205009.584615-1-jsnow@redhat.com>
In-Reply-To: <20250606205009.584615-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 11 Jun 2025 13:01:06 -0400
X-Gm-Features: AX0GCFvn2JUiQJtS14tZF9TjjuyPKA6q__WE4cuG1YQSMLUvlmK2TNUCO7htNbA
Message-ID: <CAFn=p-ZDcydfipUfOkU2tfkhU63K86rz3J9wk+CwBkpV812kwg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Docs: bump sphinx version to 6.2.1
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f94f3f06374ec2c1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000f94f3f06374ec2c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:50=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> This is a re-send of Akihiko Odaki's series, rebased and altered to cope
> with the new QAPI static analysis tests now running on GitLab CI.
>
> Changes in this "v1":
>
>  - Update python static analysis testing configuration to work with the
>    new Sphinx minimum version
>  - Small adjustments to qapi_domain.py in light of upstream changes to
>    keep new CI tests passing.
>    (Thank you for deleting compat.py, Odaki-san!)
>  - Make the minimum versions for sphinx and sphinx-rtd-theme more
>    explicit, including the patch version number; thiis is *required* for
>    Debian platforms which ship sphinx-rtd-theme 1.2.1 and will fail to
>    build docs otherwise.
>
> Akihiko Odaki (3):
>   docs: Bump sphinx to 6.2.1
>   docs: Require sphinx>=3D6.2
>   MAINTAINERS: Add docs/requirements.txt
>
> John Snow (1):
>   python: update requirements for Sphinx
>
>  MAINTAINERS                |   1 +
>  docs/requirements.txt      |   4 +-
>  docs/sphinx/compat.py      | 230 -------------------------------------
>  docs/sphinx/qapi_domain.py |  38 +++---
>  python/setup.cfg           |   2 +-
>  python/tests/minreqs.txt   |  36 +++---
>  python/tests/qapi-isort.sh |   4 +-
>  pythondeps.toml            |   4 +-
>  8 files changed, 46 insertions(+), 273 deletions(-)
>  delete mode 100644 docs/sphinx/compat.py
>
> --
> 2.48.1
>
>
Markus is on vacation, so it'd be nice to get some input from some of the
other key maintainers before I take this.

For recap, the issue at hand here is that our preferred version of Sphinx,
5.3.0, is not compatible with Python 3.13 - so if you run configure without
a good Sphinx version, python/scripts/mkvenv.py will attempt to install a
bad version.

This series then does three closely related things:

(1) Update our preferred version of Sphinx to 6.2.1, which should work with
the latest Python versions
(2) Update our *minimum* version of Sphinx to 6.2.1, which allows us to
delete a lot of compatibility crud for Sphinx, which possibly has some
implications for the other Sphinx issues we've been having concerning
duplicate label warnings (I don't know for sure, I haven't tracked that one
as closely.)
(3) Updates the python testing venv to match the above change.

Where I am not fully confident this change will be without problems is the
fact that Debian (and likely some versions of RHEL/SUSE we still support)
do not ship with >=3D 6.2.1, which may introduce complications for docs in
certain scenarios, particularly for offline/isolated builds of QEMU. Please
refer to my email "Build platform guarantees, docs, tests, and snakes in
the garden" for more detail on concerns there.

Thanks,
--js

--000000000000f94f3f06374ec2c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 6, =
2025 at 4:50=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">j=
snow@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">This is a re-send of Akihiko Odaki&#39;s series, rebased and=
 altered to cope<br>
with the new QAPI static analysis tests now running on GitLab CI.<br>
<br>
Changes in this &quot;v1&quot;:<br>
<br>
=C2=A0- Update python static analysis testing configuration to work with th=
e<br>
=C2=A0 =C2=A0new Sphinx minimum version<br>
=C2=A0- Small adjustments to qapi_domain.py in light of upstream changes to=
<br>
=C2=A0 =C2=A0keep new CI tests passing.<br>
=C2=A0 =C2=A0(Thank you for deleting compat.py, Odaki-san!)<br>
=C2=A0- Make the minimum versions for sphinx and sphinx-rtd-theme more<br>
=C2=A0 =C2=A0explicit, including the patch version number; thiis is *requir=
ed* for<br>
=C2=A0 =C2=A0Debian platforms which ship sphinx-rtd-theme 1.2.1 and will fa=
il to<br>
=C2=A0 =C2=A0build docs otherwise.<br>
<br>
Akihiko Odaki (3):<br>
=C2=A0 docs: Bump sphinx to 6.2.1<br>
=C2=A0 docs: Require sphinx&gt;=3D6.2<br>
=C2=A0 MAINTAINERS: Add docs/requirements.txt<br>
<br>
John Snow (1):<br>
=C2=A0 python: update requirements for Sphinx<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
=C2=A0docs/requirements.txt=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0docs/sphinx/compat.py=C2=A0 =C2=A0 =C2=A0 | 230 ---------------------=
----------------<br>
=C2=A0docs/sphinx/qapi_domain.py |=C2=A0 38 +++---<br>
=C2=A0python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A0python/tests/minreqs.txt=C2=A0 =C2=A0|=C2=A0 36 +++---<br>
=C2=A0python/tests/qapi-isort.sh |=C2=A0 =C2=A04 +-<br>
=C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A04 +-<br>
=C2=A08 files changed, 46 insertions(+), 273 deletions(-)<br>
=C2=A0delete mode 100644 docs/sphinx/compat.py<br>
<br>
-- <br>
2.48.1<br>
<br></blockquote><div><br></div><div>Markus is on vacation, so it&#39;d be =
nice to get some input from some of the other key maintainers before I take=
 this.</div><div><br></div><div>For recap, the issue at hand here is that o=
ur preferred version of Sphinx, 5.3.0, is not compatible with Python 3.13 -=
 so if you run configure without a good Sphinx version, python/scripts/mkve=
nv.py will attempt to install a bad version.</div><div><br></div><div>This =
series then does three closely related things:<br><br></div><div>(1) Update=
 our preferred version of Sphinx to 6.2.1, which should work with the lates=
t Python versions</div><div>(2) Update our *minimum* version of Sphinx to 6=
.2.1, which allows us to delete a lot of compatibility crud for Sphinx, whi=
ch possibly has some implications for the other Sphinx issues we&#39;ve bee=
n having concerning duplicate label warnings (I don&#39;t know for sure, I =
haven&#39;t tracked that one as closely.)</div><div>(3) Updates the python =
testing venv to match the above change.</div><div><br></div><div>Where I am=
 not fully confident this change will be without problems is the fact that =
Debian (and likely some versions of RHEL/SUSE we still support) do not ship=
 with &gt;=3D 6.2.1, which may introduce complications for docs in certain =
scenarios, particularly for offline/isolated builds of QEMU. Please refer t=
o my email &quot;Build platform guarantees, docs, tests, and snakes in the =
garden&quot; for more detail on concerns there.</div><div><br></div><div>Th=
anks,</div><div>--js</div></div></div>

--000000000000f94f3f06374ec2c1--


