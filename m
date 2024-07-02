Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F595C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 17:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOhfF-0007Ia-B4; Tue, 02 Jul 2024 13:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sOhfC-0007I7-Uh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 13:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sOhfA-0001DU-FG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 13:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719942691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nxgYAXd/+YFzZ7rLI+uMe+OUSE9XQYlUOuvjx3bEFOE=;
 b=CkJ2FVhmQndZo+iDhDgufqHZ72DAQSctD1VD/w6h3bg4BqFsCzblPaclovPd81nMjUmRUq
 kMNyaqRqA4b1bnOkzkCL41C1u8SNiWIeo4Jy/tvtNU1LKm0ohZJUe2O/syG99ajwaawKfq
 iJaF0qB9c3O8in9e/86e1mX0O97pNPE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-KnTOE_L-MzuqIWVSwcpuvw-1; Tue, 02 Jul 2024 13:51:27 -0400
X-MC-Unique: KnTOE_L-MzuqIWVSwcpuvw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257db9d71fso18275795e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 10:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719942686; x=1720547486;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nxgYAXd/+YFzZ7rLI+uMe+OUSE9XQYlUOuvjx3bEFOE=;
 b=vkAyk8D2abtGUb4jf80fn0mkjNbhOLMReZ8Y045Tlud+vk6+exwaHb6DFm5A3m7f5V
 wKsVX+xTBNmBKaew0pyEgCuJ7ZGJFIvqHnqWGK7nCUtcFOzfQG1TbroRaOaMJsvzF6qn
 NMaw+VoKqKSUd8/REcMRp3vu6CHF2cKhcd5/l5Wme+d45tD9xeo5BTzTReZejWOuVZx8
 jIJlojfvZ8NglqmBYTr6J7YHGJ+QRAuGViWfVe2emAhG3I/Ed5kFuB5qsatowwW38VwK
 8ddBYX+rTuvgJ4qnDVGyJo+JpBrHuROGaziUpSedY5+Y3eI0yQHwMJTE7gqc6XXZOjlp
 /S/A==
X-Gm-Message-State: AOJu0Yz06WQsmllaHTxG12JNc2sGO1er5cGfkYry33tAZFPaTeJOAdzM
 UNo+2mWo3wVKhZeboKAb15L2vsx7WDXSPg38fuhMnuu0Rc4cCJX7RWhBiTChvQ5lbGq/69i6Jdp
 WlOuPUeArkIIAgttmBgYB6TQOyaJXtdbw2xz2h7kvFxpHJMSzvg6j
X-Received: by 2002:a05:600c:a297:b0:425:8d90:4ade with SMTP id
 5b1f17b1804b1-4258d904b67mr7797625e9.22.1719942686539; 
 Tue, 02 Jul 2024 10:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyYJwdZeYzSikZgUoUdNoIj3A2EIMxSl7R0yzabdfAn3LE3LS01dhapzwKTi6g+X6fCMsdCg==
X-Received: by 2002:a05:600c:a297:b0:425:8d90:4ade with SMTP id
 5b1f17b1804b1-4258d904b67mr7797455e9.22.1719942686146; 
 Tue, 02 Jul 2024 10:51:26 -0700 (PDT)
Received: from smtpclient.apple ([89.138.166.0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm209680515e9.11.2024.07.02.10.51.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2024 10:51:25 -0700 (PDT)
From: Nir Soffer <nsoffer@redhat.com>
Message-Id: <52CCCC9F-CAEE-46D2-9698-209A8D1DEA1E@redhat.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_6863A337-8BE4-4E1D-951C-5378B714D697"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 3/4] iotests: Change imports for Python 3.13
Date: Tue, 2 Jul 2024 20:51:13 +0300
In-Reply-To: <CAFn=p-Yz58vhQkQABp7uPPFLuuT_bL=Bdjxz+swsaHPzqS+dVA@mail.gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20240626232230.408004-1-jsnow@redhat.com>
 <20240626232230.408004-4-jsnow@redhat.com>
 <CAMRbyyuPVcwaLcyW=LeMhAWCRdqDBkNzYwE9q4Wan0Pm0k41GQ@mail.gmail.com>
 <CAFn=p-Yz58vhQkQABp7uPPFLuuT_bL=Bdjxz+swsaHPzqS+dVA@mail.gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=nsoffer@redhat.com;
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


--Apple-Mail=_6863A337-8BE4-4E1D-951C-5378B714D697
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 2 Jul 2024, at 17:44, John Snow <jsnow@redhat.com> wrote:
>=20
>=20
>=20
> On Tue, Jul 2, 2024 at 7:52=E2=80=AFAM Nir Soffer <nsoffer@redhat.com =
<mailto:nsoffer@redhat.com>> wrote:
>> On Thu, Jun 27, 2024 at 2:23=E2=80=AFAM John Snow <jsnow@redhat.com =
<mailto:jsnow@redhat.com>> wrote:
>> >
>> > Python 3.13 isn't out yet, but it's in beta and Fedora is ramping =
up to
>> > make it the default system interpreter for Fedora 41.
>> >
>> > They moved our cheese for where ContextManager lives; add a =
conditional
>> > to locate it while we support both pre-3.9 and 3.13+.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com =
<mailto:jsnow@redhat.com>>
>> > ---
>> >  tests/qemu-iotests/testenv.py    | 7 ++++++-
>> >  tests/qemu-iotests/testrunner.py | 9 ++++++---
>> >  2 files changed, 12 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/tests/qemu-iotests/testenv.py =
b/tests/qemu-iotests/testenv.py
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
>> > +    from contextlib import AbstractContextManager as =
ContextManager
>> > +else:
>> > +    from typing import ContextManager
>>=20
>> It can be cleaner to add a compat module hiding the details so the
>> entire project
>> can have a single instance of this. Other code will just use:
>>=20
>>     from compat import ContextManager
>=20
> If there were more than two uses, I'd consider it. As it stands, a =
compat.py module with just one import conditional in it doesn't seem =
worth the hassle. Are there more cases of compatibility goop inside =
iotests that need to be factored out to make it worth it?

I don=E2=80=99t about other. For me even one instance is ugly enough :-)


--Apple-Mail=_6863A337-8BE4-4E1D-951C-5378B714D697
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><blockquote type=3D"cite"><div>On 2 Jul =
2024, at 17:44, John Snow &lt;jsnow@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><br =
class=3D"Apple-interchange-newline"><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><div class=3D"gmail_quote" style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 13px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Jul 2, 2024 at 7:52=E2=80=AFAM Nir Soffer &lt;<a =
href=3D"mailto:nsoffer@redhat.com">nsoffer@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0px =
0px 0px 0.8ex; border-left-width: 1px; border-left-style: solid; =
border-left-color: rgb(204, 204, 204); padding-left: 1ex;">On Thu, Jun =
27, 2024 at 2:23=E2=80=AFAM John Snow &lt;<a =
href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; wrote:<br>&gt;<br>&gt; Python =
3.13 isn't out yet, but it's in beta and Fedora is ramping up to<br>&gt; =
make it the default system interpreter for Fedora 41.<br>&gt;<br>&gt; =
They moved our cheese for where ContextManager lives; add a =
conditional<br>&gt; to locate it while we support both pre-3.9 and =
3.13+.<br>&gt;<br>&gt; Signed-off-by: John Snow &lt;<a =
href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt;<br>&gt; ---<br>&gt;&nbsp; =
tests/qemu-iotests/testenv.py&nbsp; &nbsp; | 7 ++++++-<br>&gt;&nbsp; =
tests/qemu-iotests/testrunner.py | 9 ++++++---<br>&gt;&nbsp; 2 files =
changed, 12 insertions(+), 4 deletions(-)<br>&gt;<br>&gt; diff --git =
a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py<br>&gt; =
index 588f30a4f14..96d69e56963 100644<br>&gt; --- =
a/tests/qemu-iotests/testenv.py<br>&gt; +++ =
b/tests/qemu-iotests/testenv.py<br>&gt; @@ -25,7 +25,12 @@<br>&gt;&nbsp; =
import random<br>&gt;&nbsp; import subprocess<br>&gt;&nbsp; import =
glob<br>&gt; -from typing import List, Dict, Any, Optional, =
ContextManager<br>&gt; +from typing import List, Dict, Any, =
Optional<br>&gt; +<br>&gt; +if sys.version_info &gt;=3D (3, 9):<br>&gt; =
+&nbsp; &nbsp; from contextlib import AbstractContextManager as =
ContextManager<br>&gt; +else:<br>&gt; +&nbsp; &nbsp; from typing import =
ContextManager<br><br>It can be cleaner to add a compat module hiding =
the details so the<br>entire project<br>can have a single instance of =
this. Other code will just use:<br><br>&nbsp; &nbsp;<span =
class=3D"Apple-converted-space">&nbsp;</span>from compat import =
ContextManager<br></blockquote><div><br></div><div>If there were more =
than two uses, I'd consider it. As it stands, a compat.py module with =
just one import conditional in it doesn't seem worth the hassle. Are =
there more cases of compatibility goop inside iotests that need to be =
factored out to make it worth =
it?<br></div></div></div></blockquote><div><br></div><div>I don=E2=80=99t =
about other. For me even one instance is ugly enough =
:-)</div></div><br></body></html>=

--Apple-Mail=_6863A337-8BE4-4E1D-951C-5378B714D697--


