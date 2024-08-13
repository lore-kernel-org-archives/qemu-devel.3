Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B82C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdqAy-0003Rm-T8; Tue, 13 Aug 2024 07:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sdqAx-0003Qx-DU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sdqAv-0005mU-QF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723550331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZqBxK0nXTlE/aylL+H09TF3imEGkfSfEOwB4rydoWI=;
 b=X6IabJc1fQoill+qbFxk6LvTEd/q3Ae+nFrAKs1tM23G0dRMb0scsYGz9tczu3y0bKp25r
 FL666uRybFKPw1xO8b1VpFn0QxzDhnCEctU7/PBceBRIskXsoWMbh5HIxyQvyuJtlUVrmr
 hnQ48KsZ1c6jULI9Z0RLDCyZuvWcpzU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-V6YSLYbNNueBXynvxBvg5Q-1; Tue, 13 Aug 2024 07:58:48 -0400
X-MC-Unique: V6YSLYbNNueBXynvxBvg5Q-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1fc6f3ac7beso43616845ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 04:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723550328; x=1724155128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZqBxK0nXTlE/aylL+H09TF3imEGkfSfEOwB4rydoWI=;
 b=cQJyZ2H6xTV2Z39l3GoXwoznGPATAZTQZUmBggViBnYLsbR2VdeNgebuTLmtS7LfAU
 2nFab/GBtrKTvsyC1+n4kF+F+WQgygq1RtwqSQBJEJXhkCXz7HLx/shieJt+1NDeHr6i
 lv3UT608l4yCbqed//Rw0WIEYn+CWpr03vn6XODiO2gKycuNsjRy/EXDnt3yDNbCEx1U
 CNpUMhzQlzOYCxYtg+KThmytpGTWBH4bW0z1pYa5pRxTWbSW+ayuku67mwvEJpCnclfa
 xgRhDLi9nOpvNMl+gnx+Ns3evy2vviYwg6YGcnkB6DjdFwSfg4t5o1X5gQazYDv2blTc
 0AmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWu6CMmUOvfF8cNF/9SVNjrbITpyVsxBWjbtSFJbwQKK1TriB21H1gmK2uXGJD/Qn3g0SEiMHbcHqgeIAyi4uhfeaE6bM=
X-Gm-Message-State: AOJu0Yw7wGaTD12hCOqff3HZwu2tfMUPEmdYlXDCy+K9mdF1xQrCub3t
 TzDHApGj6SVQD18A7aYFxPkg4U9j4mUiDqf/3hqrI7jWk8vd4ATWXdeGbPGFbH2Lm1OLPFrxQeB
 N14dy6reikOig8d+Gs5zRH77xGwRtb9M79ggIfwFnr5HiJIP9LqpX/X4GFEMwA3aBT6lccGiPnE
 xHy1TX/9nYWWmqmChGHR0C14HMFzk=
X-Received: by 2002:a17:903:24d:b0:1f3:dd7:ad42 with SMTP id
 d9443c01a7336-201c9fefbf3mr46942925ad.0.1723550327864; 
 Tue, 13 Aug 2024 04:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGguX9fPZxBjIjJIQQEe66aQCmb8Mcfcr0xOUsdzUT8ouzGOBhfo1GHSsGLAAvLhgqjHSEj6d5hlqd/7aF4hgA=
X-Received: by 2002:a17:903:24d:b0:1f3:dd7:ad42 with SMTP id
 d9443c01a7336-201c9fefbf3mr46942735ad.0.1723550327489; Tue, 13 Aug 2024
 04:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <585da1f0-d755-47e0-bde3-eed6ca39c417@weilnetz.de>
 <987865b0-5e2a-4da1-85d6-57f3f0ad2456@linaro.org>
In-Reply-To: <987865b0-5e2a-4da1-85d6-57f3f0ad2456@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Aug 2024 07:58:35 -0400
Message-ID: <CAFn=p-b8SPZ_eDoR=r-gX4g-3+sZm=tzoQM3z0eC5JLpthH5Fg@mail.gmail.com>
Subject: Re: Drop support for Python 3.7?
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000005dd38061f8f555b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000005dd38061f8f555b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024, 7:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@l=
inaro.org>
wrote:

> Hi Stefan,
>
> On 13/8/24 13:36, Stefan Weil via wrote:
> > Hi,
> >
> > I just saw that the documentation still mentions that QEMU supports
> > Python 3.7.
>
> Oops.
>

Oops indeed, we just missed a spot. My apologies.


> > Python 3.7 is an unsupported Python version since about one year.
> > Therefore I suggest to update the documentation for QEMU 9.1.0 and
> > replace 3.7 by 3.8 as lowest supported version.
>
> Indeed, we dropped support for Python 3.7 one year ago, in commit
> ca056f4499 (May 3, 2023):
>
>    Our supported build platforms as of today all support at
>    least 3.8 [...]
>    Since it is safe under our supported platform policy, bump our
>    minimum supported version of Python to 3.8.
>
> > In addition the code which still mentions Python 3.7 or even 3.5 and 3.=
6
> > could be reviewed and maybe simplified, but I think this is less urgent
> > and can be done after QEMU release 9.1.0.
> >
> > Regards
> > Stefan W.
> >
> > $ git grep -i python.*3.7
> > docs/about/build-platforms.rst:  As of QEMU |version|, the minimum
> > supported version of Python is 3.7.
> > python/qemu/qmp/util.py:Python 3.7+.
> > scripts/qapi/introspect.py:    # TODO: Remove after Python 3.7 adds
> > @dataclass:
> > scripts/qapi/source.py:    # Replace with @dataclass in Python 3.7+
> > tests/qapi-schema/test-qapi.py:        # dict (requires Python 3.7)
> >
>

And this is harmless; but I'll send a patch to update it. I *did* forget.

Thanks,
~~js

>

--00000000000005dd38061f8f555b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Aug 13, 2024, 7:54=E2=80=AFAM Philippe Mathieu=
-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Stefan,<br>
<br>
On 13/8/24 13:36, Stefan Weil via wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I just saw that the documentation still mentions that QEMU supports <b=
r>
&gt; Python 3.7.<br>
<br>
Oops.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Oops indeed, we just missed a spot. My apologies.=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt; Python 3.7 is an unsupported Python version since about one year. <br>
&gt; Therefore I suggest to update the documentation for QEMU 9.1.0 and <br=
>
&gt; replace 3.7 by 3.8 as lowest supported version.<br>
<br>
Indeed, we dropped support for Python 3.7 one year ago, in commit<br>
ca056f4499 (May 3, 2023):<br>
<br>
=C2=A0 =C2=A0Our supported build platforms as of today all support at<br>
=C2=A0 =C2=A0least 3.8 [...]<br>
=C2=A0 =C2=A0Since it is safe under our supported platform policy, bump our=
<br>
=C2=A0 =C2=A0minimum supported version of Python to 3.8.<br>
<br>
&gt; In addition the code which still mentions Python 3.7 or even 3.5 and 3=
.6 <br>
&gt; could be reviewed and maybe simplified, but I think this is less urgen=
t <br>
&gt; and can be done after QEMU release 9.1.0.<br>
&gt; <br>
&gt; Regards<br>
&gt; Stefan W.<br>
&gt; <br>
&gt; $ git grep -i python.*3.7<br>
&gt; docs/about/build-platforms.rst:=C2=A0 As of QEMU |version|, the minimu=
m <br>
&gt; supported version of Python is 3.7.<br>
&gt; python/qemu/qmp/util.py:Python 3.7+.<br>
&gt; scripts/qapi/introspect.py:=C2=A0=C2=A0=C2=A0 # TODO: Remove after Pyt=
hon 3.7 adds <br>
&gt; @dataclass:<br>
&gt; scripts/qapi/source.py:=C2=A0=C2=A0=C2=A0 # Replace with @dataclass in=
 Python 3.7+<br>
&gt; tests/qapi-schema/test-qapi.py:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # dict (requires Python 3.7)<br>
&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">And this is harmless; but I&#39;ll send a patch to update it. I *did* f=
orget.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div=
 dir=3D"auto">~~js</div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000005dd38061f8f555b--


