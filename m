Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEB1C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOek6-0007s6-PW; Tue, 02 Jul 2024 10:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOek3-0007k0-3S
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOejy-0006ru-NO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719931456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1a9vvIucL315NhtrEUuzFITeYXQKpYLmLOB4maHst7Y=;
 b=ZRlGIC9aiVAX1kRXM0zmmrC1ofINNPsXvodQRSSR4tsLIxgpCjvGYoTPeW0PwlzTXLD9pC
 2xF8l5PVrutSVtJZSeGmH3/O+Htxd8JReiNMsa7DXwKCOB8C9lXFBotnVWsqSMwOSuWObE
 vzam8HO9GQkXtzSVxYF10UDXPLpsh9k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-ve_6nmc4N0641yu2fqT8AQ-1; Tue, 02 Jul 2024 10:44:15 -0400
X-MC-Unique: ve_6nmc4N0641yu2fqT8AQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c7d46d273cso3456523a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719931454; x=1720536254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1a9vvIucL315NhtrEUuzFITeYXQKpYLmLOB4maHst7Y=;
 b=Ka+DHFBIN/bqH+0M2UJoUGM4j8NAgypRq7pwFFFn4bEwdz28owqQ7Rkt6ZPTRQKnnO
 w7l8oyc0X2bZp0HVhgzq/NJ5sXq4USBd7QAEO2kYkrbMWjtRzgXcd5KgHKuIVolrw3SE
 Q2t22OHQIZ9aPCXoxwYNZvWZhSN/wwHcCdomdZ2+Sy3v1YBpQWefgBYenyBIKYKCgdTo
 Lg7l+BCb/6CeBbvdMXY7fJyPf9gFZjJbLjmWNonMPxkY0pXqjKBQeOaICiyDQbdyvf9m
 5oxU7HiGAUGCPTsvG1KHed82ZwjYKTZFCmvCsOh1a4cXYbhrcM4qJng1jlVYOhZCYfIX
 fQrg==
X-Gm-Message-State: AOJu0YyPDHFKcb69aszOMwY3TPP1TbXcUeqZLiHGLQhLjD3isth2gQSJ
 vyCl5WACrlhbu3ErkRU+3LCrIKg1muW6vMv9Rl2F3zbJoRdYkrC5Vy7P3xYsVamypHiJMBqBphA
 jcpAZmMK2ArtIoHHpopagSXUFHj1vmhMnTXsEfMBA+qEOy3s5S8xHNG6iPfKAkCqubzbBIPSuP3
 hXe/4xLWROU8X03UjpbcdbvIHGltA=
X-Received: by 2002:a17:90b:c11:b0:2c2:c3f5:33c3 with SMTP id
 98e67ed59e1d1-2c9276553cbmr19210530a91.6.1719931453892; 
 Tue, 02 Jul 2024 07:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHiRxvM33MOiPKWnVhEAee11M55gWgE281NpaEzL0DO2m+XOQlzYM+f5Zg7h1mmvXS3kEGREek5GClRvJTSTo=
X-Received: by 2002:a17:90b:c11:b0:2c2:c3f5:33c3 with SMTP id
 98e67ed59e1d1-2c9276553cbmr19210503a91.6.1719931453559; Tue, 02 Jul 2024
 07:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240626232230.408004-1-jsnow@redhat.com>
 <20240626232230.408004-4-jsnow@redhat.com>
 <CAMRbyyuPVcwaLcyW=LeMhAWCRdqDBkNzYwE9q4Wan0Pm0k41GQ@mail.gmail.com>
In-Reply-To: <CAMRbyyuPVcwaLcyW=LeMhAWCRdqDBkNzYwE9q4Wan0Pm0k41GQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 2 Jul 2024 10:44:00 -0400
Message-ID: <CAFn=p-Yz58vhQkQABp7uPPFLuuT_bL=Bdjxz+swsaHPzqS+dVA@mail.gmail.com>
Subject: Re: [PATCH 3/4] iotests: Change imports for Python 3.13
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000053f0ba061c44bfc0"
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

--00000000000053f0ba061c44bfc0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:52=E2=80=AFAM Nir Soffer <nsoffer@redhat.com> wrot=
e:

> On Thu, Jun 27, 2024 at 2:23=E2=80=AFAM John Snow <jsnow@redhat.com> wrot=
e:
> >
> > Python 3.13 isn't out yet, but it's in beta and Fedora is ramping up to
> > make it the default system interpreter for Fedora 41.
> >
> > They moved our cheese for where ContextManager lives; add a conditional
> > to locate it while we support both pre-3.9 and 3.13+.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/qemu-iotests/testenv.py    | 7 ++++++-
> >  tests/qemu-iotests/testrunner.py | 9 ++++++---
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/qemu-iotests/testenv.py
> b/tests/qemu-iotests/testenv.py
> > index 588f30a4f14..96d69e56963 100644
> > --- a/tests/qemu-iotests/testenv.py
> > +++ b/tests/qemu-iotests/testenv.py
> > @@ -25,7 +25,12 @@
> >  import random
> >  import subprocess
> >  import glob
> > -from typing import List, Dict, Any, Optional, ContextManager
> > +from typing import List, Dict, Any, Optional
> > +
> > +if sys.version_info >=3D (3, 9):
> > +    from contextlib import AbstractContextManager as ContextManager
> > +else:
> > +    from typing import ContextManager
>
> It can be cleaner to add a compat module hiding the details so the
> entire project
> can have a single instance of this. Other code will just use:
>
>     from compat import ContextManager
>

If there were more than two uses, I'd consider it. As it stands, a
compat.py module with just one import conditional in it doesn't seem worth
the hassle. Are there more cases of compatibility goop inside iotests that
need to be factored out to make it worth it?

--js

--00000000000053f0ba061c44bfc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024 at 7:52=E2=80=AFA=
M Nir Soffer &lt;<a href=3D"mailto:nsoffer@redhat.com">nsoffer@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Thu, Jun 27, 2024 at 2:23=E2=80=AFAM John Snow &lt;<a href=3D"mailto:jsnow=
@redhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Python 3.13 isn&#39;t out yet, but it&#39;s in beta and Fedora is ramp=
ing up to<br>
&gt; make it the default system interpreter for Fedora 41.<br>
&gt;<br>
&gt; They moved our cheese for where ContextManager lives; add a conditiona=
l<br>
&gt; to locate it while we support both pre-3.9 and 3.13+.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/qemu-iotests/testenv.py=C2=A0 =C2=A0 | 7 ++++++-<br>
&gt;=C2=A0 tests/qemu-iotests/testrunner.py | 9 ++++++---<br>
&gt;=C2=A0 2 files changed, 12 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testen=
v.py<br>
&gt; index 588f30a4f14..96d69e56963 100644<br>
&gt; --- a/tests/qemu-iotests/testenv.py<br>
&gt; +++ b/tests/qemu-iotests/testenv.py<br>
&gt; @@ -25,7 +25,12 @@<br>
&gt;=C2=A0 import random<br>
&gt;=C2=A0 import subprocess<br>
&gt;=C2=A0 import glob<br>
&gt; -from typing import List, Dict, Any, Optional, ContextManager<br>
&gt; +from typing import List, Dict, Any, Optional<br>
&gt; +<br>
&gt; +if sys.version_info &gt;=3D (3, 9):<br>
&gt; +=C2=A0 =C2=A0 from contextlib import AbstractContextManager as Contex=
tManager<br>
&gt; +else:<br>
&gt; +=C2=A0 =C2=A0 from typing import ContextManager<br>
<br>
It can be cleaner to add a compat module hiding the details so the<br>
entire project<br>
can have a single instance of this. Other code will just use:<br>
<br>
=C2=A0 =C2=A0 from compat import ContextManager<br></blockquote><div><br></=
div><div>If there were more than two uses, I&#39;d consider it. As it stand=
s, a compat.py module with just one import conditional in it doesn&#39;t se=
em worth the hassle. Are there more cases of compatibility goop inside iote=
sts that need to be factored out to make it worth it?<br></div><div><br></d=
iv><div>--js<br></div><br></div></div>

--00000000000053f0ba061c44bfc0--


