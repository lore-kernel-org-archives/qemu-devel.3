Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AE607266D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SpPCsGYk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOhUs-0005uT-3n; Wed, 04 Nov 2026 15:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conti.manuele@gmail.com>)
 id 1xOhUp-0005h0-Cv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:22:11 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conti.manuele@gmail.com>)
 id 1xOhUm-0006qq-Is
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:22:10 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cdab6ae1ee9so528252a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 12:22:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793823725; cv=none;
 d=google.com; s=arc-20260327;
 b=DwktTgfM/4TZEf+79M5zo6Wbz/iWvYDu1/CH3fhV+qJvzOqw7wvjz5qen097QYsgI+
 huFhJFfbcEmb8HdrQRFpu7KuMJDYWSdZIMyPtTIJ62wZfH5H34ywJcrSY1+t3B1Xaa1Y
 /GK+OEIzdqn0Gk6VBAiLgXDoTKtfzfNtc43gdtEpAjzAjidToCCWWFxjDq7JmZtdobf/
 eLrnyMqLMptPnFcz/bfhb8TJE2InqjclplJm7fdoP3AO1LAF42kDQVsZOmq1IragcUti
 TMz5yNXM5UJ8qXgLP6DxoxD7hvUfiH9vqbW6MFolstj7/KvoWk0s9DirilAOnC4f1qU8
 spkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rHR3Wms5FmhOPrmNb88Yr07mWgBV4kMDIC8jDHRnIQw=;
 fh=zgr7BFV9NqzbGbK2jkIcDr/KLnFt1cLdgtzPAjTKPvM=;
 b=h1BZc9HJDr4XtsCYKUVFIVCpZt0GvsdReW/9UchGnZaK08jJ/Co+WfYC/C8UDdwTIP
 1Hf1BIXQx7XzDwTHbFFkSCiWZGyxJJUmy/qirAqCxTfkXBcD8/vUOobaaH9/Rdl7PLsN
 mbBzIl/RfegZWY2EYDsoG+bmwGSWJ79o4w2gtRaU1lo+Mqv4EsuylBa71u2JZY3GGPK7
 IFubv+TOHfLb/KhHnIjOjphEneo7TFZUCH6rzVzjDNLRDoBgG31qX1yEti9uZW9bebeZ
 uIMeYfA3PCMXYqEZs4n9fzXuFhfQON0JhEpYxubioXrYZ2A7L8MYI/JIxNSXoxcy/Ip3
 xBWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793823725; x=1794428525; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rHR3Wms5FmhOPrmNb88Yr07mWgBV4kMDIC8jDHRnIQw=;
 b=SpPCsGYkFnsGbdeynNOeUAAHqZeibtSU3d4xshnzgrzxoNt8700c2D8vYyx6cln2PY
 kOE0oLUCEYDF+l5VVLaIaAhwDKb0k0zFNF3etSFGsuGuzszZpr7BCpMerZ7UFT5QResU
 SdWAmFazkyumWDrw5EeOHZuwgL8ymZtYA/mSfHcbhJBKBkrFQVNRCzUTNpbSjE48Cvwq
 wmWb1bnzWY7dDQBpQ7uUhK5YpGdsIXtlH/a3latjRnlRWkjAS8SQllbTFHx7tCj+Dx0q
 sNGLJ/M3HTInldM3hxN+dEkgbCyerqNVUBRtdmysNjP3F/+sK49Uzu99J+QeX6Flx4VN
 L3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793823725; x=1794428525;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rHR3Wms5FmhOPrmNb88Yr07mWgBV4kMDIC8jDHRnIQw=;
 b=afC7YVEALoNXMe5YYYVB0Bjj5b91GPRd0u4wX6vT0b15eczk/86xbPop1a+vj8tlUI
 0ebU/pfILlPjXYgsN4qxIGC+LGAhugiXN6QA6q5dSW3QzTtNG25OG9ohus+xipB32nS7
 ooVEjzB+K17YeKd3EJpEgseH3OXSTf7QPpU2KDvfY1FEz+iN4X32ysiNUp2rVB8e7Ygw
 4652IJpBe/aYP6RPKIyWX1CQs4z3rHbWjVhSUwpkvZ9H/Mn85mdGOzFwTsCQ5yNUd+k3
 TG11pEH++gznk9yolkTJfLs5hzR65nO7f8cZhFMcJJLZn1V7ImwcGjOX9fsA15RbHaNl
 yVjg==
X-Gm-Message-State: APuU4Z+iz6BLvL2D5W4ZoYkc1lY288N4dqzkE12M07a0vPdc2dqAoXWr
 ejBmrmjdeRhY3L0++dRXOB9yBA6UuVast6NroaoJaiNSzx+TTEh7lHOmhyVpTeUSQJ6vL5nHzTS
 CglXIvmHct5cza+NekjXSayk3+fN3vXk=
X-Gm-Gg: AYBFou1dLaepqvDyVgpZ87D1Y8ib31qnM9fQsLEBlZ1hBaYwKqt02NNWRchFBpdGTul
 OJgt/cwPslZhB0rGIr5HbXPQA+TetWxlIEWkwxlm/vCNsvY9jFL9hGjKJrlnQs84MFf38DS+qur
 1YzWq7rGIfyH2+yjnkERUr5Lp8I/AwGjM9EulNzy6+Qg2E5Trh9CHcU0QzckLKoIHUZjNMZM0ig
 vZdw7r9F8FYrPWNaK/YZuo+1FuA0CswxR4mxI5KN0T+ahkw6seGjhwKi016P5Qz1WJAV1Vrbs2d
 eTrb1kKdtaoDCQ386sCHhTi7YPG4B1bFi2DAwRUf5ku68gy2/Pw047HBdphton2dp97PPnEz/mI
 33db8kV4fI0mwYY6ZT0FwuIViF7HGYtkH/N4W+yeo5msZBnF8vr+37dSRY1cuoeixJ8msDw==
X-Received: by 2002:a17:90b:51cf:b0:3ad:818f:3da2 with SMTP id
 98e67ed59e1d1-3ae8982cc41mr12202999a91.63.1793823725313; Wed, 04 Nov 2026
 12:22:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104111619.24479-1-conti.manuele@gmail.com>
 <20261104123605.37729-1-conti.manuele@gmail.com>
 <7240871b-1ff0-40ee-bcf0-bb15139f6c4a@oss.qualcomm.com>
In-Reply-To: <7240871b-1ff0-40ee-bcf0-bb15139f6c4a@oss.qualcomm.com>
From: Manuele Conti <conti.manuele@gmail.com>
Date: Wed, 4 Nov 2026 21:21:48 +0100
X-Gm-Features: AclHuK9Tb8G3rpldxJIYYKys58QcTs00neYy6I9Hj54MiYhI-teA_F03Rmc1nLE
Message-ID: <CAKm0YZzOEEMK=z5JfJb-fBqWMDwN7_rS2sQR+6dSndB2b+tCrw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/sd/ssi-sd: Handle immediate write start token after
 R1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>
Content-Type: multipart/alternative; boundary="000000000000efe31d065f79212a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=conti.manuele@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000efe31d065f79212a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe, Bin,

Thank you for the detailed review and for pointing out the NWR timing
requirement.

I checked section 7.5.4 and Figure 56 of the SD Physical Layer
Specification v1.10. I agree that NWR has a minimum of one byte (8 clock
cycles), which means my zero-gap test case does not establish a
protocol-compliant host sequence.

The other observation about matching the write tokens to CMD24/CMD25 and
handling the CMD25 data response is also valid.

Before sending another revision, I will investigate the guest-side SPI
sequence and check whether the issue can be reproduced with the required
NWR interval.

I will also check whether the firmware is accounting for this delay or
whether the problem is caused by the interaction with QEMU's response
handling.

I won't submit a v3 until I can demonstrate a protocol-compliant reproducer=
.

Thanks again for the careful review.

Best regards,
Manuele

Il giorno mer 4 nov 2026 alle ore 15:25 Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> ha scritto:

> Please keep Bin in Cc (as maintainer)
>
> $ ./scripts/get_maintainer.pl -f hw/sd/ssi-sd.c
> "Philippe Mathieu-Daud=C3=A9" <philmd@oss.qualcomm.com> (odd fixer:SD (Se=
cure
> Card), gitlab:@philmd)
> Bin Meng <bmeng.cn@gmail.com> (odd fixer:SD (Secure Card), gitlab:@lbmeng=
)
>
> On 4/11/26 13:31, Manuele Conti wrote:
> > When a write start token immediately follows the R1 response,
> > the SPI SD controller may still be in SSI_SD_RESPONSE state
> > and discard the token.
> >
> > Recognize single-block and multi-block write start tokens
> > when the SD card is ready to receive data, allowing the
> > write operation to proceed without an additional dummy byte.
> >
> > Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
> > ---
> > Hi Philippe,
> >
> > Thanks for your feedback.
> >
> > I encountered this issue while running a bare-metal STM32F4 firmware
> under QEMU, using SPI mode to communicate with an SD card.
> >
> > The firmware performs a block write (CMD24) and sends the data start
> token (0xFE) immediately after receiving the R1 response, without an
> additional dummy byte.
> >
> > In this case, the SSI SD controller is still in SSI_SD_RESPONSE state
> and discards the token, causing the subsequent write operation to fail.
> >
> > I've now added a regression test to reproduce this behavior without
> requiring the original firmware.
>
> Wow, that was fast! I suppose you already had that qtest written
> locally, if so next time better share along with a fix.
>
> Looking at older spec v1.10 I found section 7.5.4 "Timing Values" and
> Figure 56 "Write operation - bus timing". The table gives NWR (between
> the write command response and the data block) a minimum of 1, in
> units of 8 clock cycles (so at least one byte). If that reading is
> right, a host sending 0xFE in the very next byte after R1 is outside
> the card timing, and the model dropping it is not obviously a bug.
>
> You described the model but not the guest, what firmware / drivers
> it uses. Does your firmware work on real HW -- and if so what is the
> SD card being used --? Does the FW intentionally send the token with
> no gap, or does it poll/read a byte after the command response that
> our SPI controller model hides or reorders?
>
> Thanks,
>
> Phil.
>
> > The test exercises the immediate write-token sequence and verifies that
> the controller correctly transitions to the data-write state.
> >
> > I'll submit an updated patch including the regression test so the issue
> can be reproduced and verified independently.
> >
> > Best regards,
> > Manuele
> >
> >   hw/sd/ssi-sd.c                        |   6 +
> >   tests/qtest/ssi-sd-token-local-test.c | 165 +++++++++++++++++++++++++=
+
> >   2 files changed, 171 insertions(+)
> >   create mode 100644 tests/qtest/ssi-sd-token-local-test.c
>
>

--000000000000efe31d065f79212a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"caret-color: rgb(255, 255, 255);"><font color=
=3D"#000000">Hi Philippe, Bin,</font></p><p style=3D"caret-color: rgb(255, =
255, 255);"><font color=3D"#000000">Thank you for the detailed review and f=
or pointing out the NWR timing requirement.</font></p><p style=3D"caret-col=
or: rgb(255, 255, 255);"><font color=3D"#000000">I checked section 7.5.4 an=
d Figure 56 of the SD Physical Layer Specification v1.10. I agree that NWR =
has a minimum of one byte (8 clock cycles), which means my zero-gap test ca=
se does not establish a protocol-compliant host sequence.</font></p><p styl=
e=3D"caret-color: rgb(255, 255, 255);"><font color=3D"#000000">The other ob=
servation about matching the write tokens to CMD24/CMD25 and handling the C=
MD25 data response is also valid.</font></p><p style=3D"caret-color: rgb(25=
5, 255, 255);"><font color=3D"#000000">Before sending another revision, I w=
ill investigate the guest-side SPI sequence and check whether the issue can=
 be reproduced with the required NWR interval.</font></p><p style=3D"caret-=
color: rgb(255, 255, 255);"><font color=3D"#000000">I will also check wheth=
er the firmware is accounting for this delay or whether the problem is caus=
ed by the interaction with QEMU&#39;s response handling.</font></p><p style=
=3D"caret-color: rgb(255, 255, 255);"><font color=3D"#000000">I won&#39;t s=
ubmit a v3 until I can demonstrate a protocol-compliant reproducer.</font><=
/p><p style=3D"caret-color: rgb(255, 255, 255);"><font color=3D"#000000">Th=
anks again for the careful review.</font></p><p style=3D"caret-color: rgb(2=
55, 255, 255);"><font color=3D"#000000">Best regards,<br>Manuele</font></p>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">Il giorno mer 4 nov 2026 alle ore 15:25 Philippe Math=
ieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.qualcomm.com">philmd@oss.qu=
alcomm.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Please keep Bin in Cc (as maintainer)<br>
<br>
$ ./scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferrer" target=
=3D"_blank">get_maintainer.pl</a> -f hw/sd/ssi-sd.c<br>
&quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"mailto:philmd@oss.qu=
alcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt; (odd fixer:SD=
 (Secure <br>
Card), gitlab:@philmd)<br>
Bin Meng &lt;<a href=3D"mailto:bmeng.cn@gmail.com" target=3D"_blank">bmeng.=
cn@gmail.com</a>&gt; (odd fixer:SD (Secure Card), gitlab:@lbmeng)<br>
<br>
On 4/11/26 13:31, Manuele Conti wrote:<br>
&gt; When a write start token immediately follows the R1 response,<br>
&gt; the SPI SD controller may still be in SSI_SD_RESPONSE state<br>
&gt; and discard the token.<br>
&gt; <br>
&gt; Recognize single-block and multi-block write start tokens<br>
&gt; when the SD card is ready to receive data, allowing the<br>
&gt; write operation to proceed without an additional dummy byte.<br>
&gt; <br>
&gt; Signed-off-by: Manuele Conti &lt;<a href=3D"mailto:conti.manuele@gmail=
.com" target=3D"_blank">conti.manuele@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Hi Philippe,<br>
&gt; <br>
&gt; Thanks for your feedback.<br>
&gt; <br>
&gt; I encountered this issue while running a bare-metal STM32F4 firmware u=
nder QEMU, using SPI mode to communicate with an SD card.<br>
&gt; <br>
&gt; The firmware performs a block write (CMD24) and sends the data start t=
oken (0xFE) immediately after receiving the R1 response, without an additio=
nal dummy byte.<br>
&gt; <br>
&gt; In this case, the SSI SD controller is still in SSI_SD_RESPONSE state =
and discards the token, causing the subsequent write operation to fail.<br>
&gt; <br>
&gt; I&#39;ve now added a regression test to reproduce this behavior withou=
t requiring the original firmware.<br>
<br>
Wow, that was fast! I suppose you already had that qtest written<br>
locally, if so next time better share along with a fix.<br>
<br>
Looking at older spec v1.10 I found section 7.5.4 &quot;Timing Values&quot;=
 and<br>
Figure 56 &quot;Write operation - bus timing&quot;. The table gives NWR (be=
tween<br>
the write command response and the data block) a minimum of 1, in<br>
units of 8 clock cycles (so at least one byte). If that reading is<br>
right, a host sending 0xFE in the very next byte after R1 is outside<br>
the card timing, and the model dropping it is not obviously a bug.<br>
<br>
You described the model but not the guest, what firmware / drivers<br>
it uses. Does your firmware work on real HW -- and if so what is the<br>
SD card being used --? Does the FW intentionally send the token with<br>
no gap, or does it poll/read a byte after the command response that<br>
our SPI controller model hides or reorders?<br>
<br>
Thanks,<br>
<br>
Phil.<br>
<br>
&gt; The test exercises the immediate write-token sequence and verifies tha=
t the controller correctly transitions to the data-write state.<br>
&gt; <br>
&gt; I&#39;ll submit an updated patch including the regression test so the =
issue can be reproduced and verified independently.<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Manuele<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/sd/ssi-sd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 =C2=A0tests/qtest/ssi-sd-token-local-test.c | 165 ++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 171 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 tests/qtest/ssi-sd-token-local-test.c<b=
r>
<br>
</blockquote></div>

--000000000000efe31d065f79212a--

