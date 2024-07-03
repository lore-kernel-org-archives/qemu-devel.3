Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECFBC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 20:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP6M6-0002nW-1z; Wed, 03 Jul 2024 16:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP6M4-0002nB-1K
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP6Lo-0006nn-FF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720037590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFguTLy/PiB0QVOy8/tq6w+Nq/a5S7rllCm8KmRgWVk=;
 b=DLDp9zR5Li2qx7nqKGu7qlnUp17uHLZJzfdpwUiGzTs2kDBX/wT5bSrjRX3hD871vdG9+0
 6uei8To4X5o8aGlA58rYQm5AA+JUvHEikatixIfaebdqztxHRLZfj+ayQmVWUSkwqbVd/+
 EnpJat1QoyXvoO/kC/bgQ/0aa1NVqsE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-iNB8CTJCN029m72PBiTXpg-1; Wed, 03 Jul 2024 16:13:06 -0400
X-MC-Unique: iNB8CTJCN029m72PBiTXpg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c978551866so847856a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 13:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720037585; x=1720642385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QFguTLy/PiB0QVOy8/tq6w+Nq/a5S7rllCm8KmRgWVk=;
 b=ORQ15K+XiKEE9LUqVwyRfmbRFqBvn02BPXFTjQhhxImmGVlMOdaeJ3MbVgFrt8E6Fb
 vhVnluhpPfHq5rMasyd3UtZiuz+TS7OENVItP/3KgUQTneuykRqsuHIERFmGfFfSEqO2
 3HGgj/2r07j4UbAk4857CWYaR8BxkSALNwi1s2xQYtfUs2NdkBCUVSyjxTOkQ/T9Ewb/
 e05l0BS4qpYQ6Ihv3rSZls7fd+QTgNz6MHeLnMAy0MWX5POsv4zU12GDF+kJlle7I7DV
 m3poVmHe4gSvmQcxveWtpIIeU9Nv/5vSyEgTStSLsGAHZ0QWgqH9u3+AXeyO4nMdwMQR
 1jgA==
X-Gm-Message-State: AOJu0YzPDikUNNLwRKO5MvxCMo6nW9VC30jayXpyxvQAGs9GhnGD3iD5
 8HGmAYTP7QswCeTPkOwbzKZwqBgOH27HO4e4uM6Bmf1C76PbUUCXOtkxB2q7ue3RjuJ8171ma9/
 cFacFA/UbKq4XsaJm4WeG1N8XSvZLYHQT6/2y5McXPoUsULHA9w4vjsN0FzyXc/3/FT45F8bZ96
 Z4p4X0U/OS+dQvNUL9PIOqAXhxTpUoh135o9E=
X-Received: by 2002:a17:90a:ab0e:b0:2c9:358c:babf with SMTP id
 98e67ed59e1d1-2c93d76772cmr8883507a91.36.1720037585116; 
 Wed, 03 Jul 2024 13:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaXpAgwjy+/QJqW4e2xfBqz2rIPRMIMUoluajumNjvhmQUEKcn1vtjN52HL/Ax7tc5h5/1T1VLjtmYkSVEJSc=
X-Received: by 2002:a17:90a:ab0e:b0:2c9:358c:babf with SMTP id
 98e67ed59e1d1-2c93d76772cmr8883485a91.36.1720037584753; Wed, 03 Jul 2024
 13:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240626232230.408004-1-jsnow@redhat.com>
 <20240626232230.408004-4-jsnow@redhat.com>
 <CAMRbyyuPVcwaLcyW=LeMhAWCRdqDBkNzYwE9q4Wan0Pm0k41GQ@mail.gmail.com>
 <CAFn=p-Yz58vhQkQABp7uPPFLuuT_bL=Bdjxz+swsaHPzqS+dVA@mail.gmail.com>
 <52CCCC9F-CAEE-46D2-9698-209A8D1DEA1E@redhat.com>
In-Reply-To: <52CCCC9F-CAEE-46D2-9698-209A8D1DEA1E@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 3 Jul 2024 16:12:52 -0400
Message-ID: <CAFn=p-YZyQisCXeg9W4zfZN4TmzT4CoZ6EcroQPBQaEBXs0P9w@mail.gmail.com>
Subject: Re: [PATCH 3/4] iotests: Change imports for Python 3.13
To: Nir Soffer <nsoffer@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003d7c93061c5d75f5"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--0000000000003d7c93061c5d75f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024, 1:51=E2=80=AFPM Nir Soffer <nsoffer@redhat.com> wrote:

>
> On 2 Jul 2024, at 17:44, John Snow <jsnow@redhat.com> wrote:
>
>
>
> On Tue, Jul 2, 2024 at 7:52=E2=80=AFAM Nir Soffer <nsoffer@redhat.com> wr=
ote:
>
>> On Thu, Jun 27, 2024 at 2:23=E2=80=AFAM John Snow <jsnow@redhat.com> wro=
te:
>> >
>> > Python 3.13 isn't out yet, but it's in beta and Fedora is ramping up t=
o
>> > make it the default system interpreter for Fedora 41.
>> >
>> > They moved our cheese for where ContextManager lives; add a conditiona=
l
>> > to locate it while we support both pre-3.9 and 3.13+.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  tests/qemu-iotests/testenv.py    | 7 ++++++-
>> >  tests/qemu-iotests/testrunner.py | 9 ++++++---
>> >  2 files changed, 12 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/tests/qemu-iotests/testenv.py
>> b/tests/qemu-iotests/testenv.py
>> > index 588f30a4f14..96d69e56963 100644
>> > --- a/tests/qemu-iotests/testenv.py
>> > +++ b/tests/qemu-iotests/testenv.py
>> > @@ -25,7 +25,12 @@
>> >  import random
>> >  import subprocess
>> >  import glob
>> > -from typing import List, Dict, Any, Optional, ContextManager
>> > +from typing import List, Dict, Any, Optional
>> > +
>> > +if sys.version_info >=3D (3, 9):
>> > +    from contextlib import AbstractContextManager as ContextManager
>> > +else:
>> > +    from typing import ContextManager
>>
>> It can be cleaner to add a compat module hiding the details so the
>> entire project
>> can have a single instance of this. Other code will just use:
>>
>>     from compat import ContextManager
>>
>
> If there were more than two uses, I'd consider it. As it stands, a
> compat.py module with just one import conditional in it doesn't seem wort=
h
> the hassle. Are there more cases of compatibility goop inside iotests tha=
t
> need to be factored out to make it worth it?
>
>
> I don=E2=80=99t about other. For me even one instance is ugly enough :-)
>

I was going to add it to qemu/utils, but then I remembered the
testenv/testrunner script here needs to operate without external
dependencies because part of the function of these modules is to *locate*
those dependencies.

Ehh. I'm going to say that repeating the import scaffolding in just two
places is fine enough for now and really not worth adding a compat.py for
*just* this. Let's just get the tests green.

--js

--0000000000003d7c93061c5d75f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024, 1:51=E2=80=AFPM =
Nir Soffer &lt;<a href=3D"mailto:nsoffer@redhat.com" target=3D"_blank">nsof=
fer@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
style=3D"line-break:after-white-space"><br><div><blockquote type=3D"cite"><=
div>On 2 Jul 2024, at 17:44, John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" rel=3D"noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; wrote:</d=
iv><br><div><br><br style=3D"font-family:Helvetica;font-size:13px;font-styl=
e:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none"><div class=3D"gmail_quote" style=3D"font-f=
amily:Helvetica;font-size:13px;font-style:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;text-decoration:none"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024 at 7:52=E2=80=AFAM =
Nir Soffer &lt;<a href=3D"mailto:nsoffer@redhat.com" rel=3D"noreferrer" tar=
get=3D"_blank">nsoffer@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Thu, Jun 27, 2024 at 2:23=E2=80=AFAM John Snow &lt;<a href=3D"mailto:jsn=
ow@redhat.com" rel=3D"noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt=
; wrote:<br>&gt;<br>&gt; Python 3.13 isn&#39;t out yet, but it&#39;s in bet=
a and Fedora is ramping up to<br>&gt; make it the default system interprete=
r for Fedora 41.<br>&gt;<br>&gt; They moved our cheese for where ContextMan=
ager lives; add a conditional<br>&gt; to locate it while we support both pr=
e-3.9 and 3.13+.<br>&gt;<br>&gt; Signed-off-by: John Snow &lt;<a href=3D"ma=
ilto:jsnow@redhat.com" rel=3D"noreferrer" target=3D"_blank">jsnow@redhat.co=
m</a>&gt;<br>&gt; ---<br>&gt;=C2=A0 tests/qemu-iotests/testenv.py=C2=A0 =C2=
=A0 | 7 ++++++-<br>&gt;=C2=A0 tests/qemu-iotests/testrunner.py | 9 ++++++--=
-<br>&gt;=C2=A0 2 files changed, 12 insertions(+), 4 deletions(-)<br>&gt;<b=
r>&gt; diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/test=
env.py<br>&gt; index 588f30a4f14..96d69e56963 100644<br>&gt; --- a/tests/qe=
mu-iotests/testenv.py<br>&gt; +++ b/tests/qemu-iotests/testenv.py<br>&gt; @=
@ -25,7 +25,12 @@<br>&gt;=C2=A0 import random<br>&gt;=C2=A0 import subproce=
ss<br>&gt;=C2=A0 import glob<br>&gt; -from typing import List, Dict, Any, O=
ptional, ContextManager<br>&gt; +from typing import List, Dict, Any, Option=
al<br>&gt; +<br>&gt; +if sys.version_info &gt;=3D (3, 9):<br>&gt; +=C2=A0 =
=C2=A0 from contextlib import AbstractContextManager as ContextManager<br>&=
gt; +else:<br>&gt; +=C2=A0 =C2=A0 from typing import ContextManager<br><br>=
It can be cleaner to add a compat module hiding the details so the<br>entir=
e project<br>can have a single instance of this. Other code will just use:<=
br><br>=C2=A0 =C2=A0<span>=C2=A0</span>from compat import ContextManager<br=
></blockquote><div><br></div><div>If there were more than two uses, I&#39;d=
 consider it. As it stands, a compat.py module with just one import conditi=
onal in it doesn&#39;t seem worth the hassle. Are there more cases of compa=
tibility goop inside iotests that need to be factored out to make it worth =
it?<br></div></div></div></blockquote><div><br></div><div>I don=E2=80=99t a=
bout other. For me even one instance is ugly enough :-)</div></div></div></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I was =
going to add it to qemu/utils, but then I remembered the testenv/testrunner=
 script here needs to operate without external dependencies because part of=
 the function of these modules is to *locate* those dependencies.<br><br></=
div><div>Ehh. I&#39;m going to say that repeating the import scaffolding in=
 just two places is fine enough for now and really not worth adding a compa=
t.py for *just* this. Let&#39;s just get the tests green.</div><div><br></d=
iv><div>--js<br></div><div dir=3D"auto"></div></div>
</div>

--0000000000003d7c93061c5d75f5--


