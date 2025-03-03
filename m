Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977A0C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 20:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpCR8-0007Fu-Py; Mon, 03 Mar 2025 15:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tpCR6-0007FO-Ff
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:30:48 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tpCQy-0001GH-AB
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:30:48 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86b5515dd5fso1177103241.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 12:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1741033837; x=1741638637;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pOsp2vY13k2XExgGYfdVVsmGZinD+jyXkzh+Sq28GQc=;
 b=gIXPY8zaPmcfJIw2McvSi4wLkQablTq0VjzvAhhZCr/iY7cntrsclt4gTpFdXEf1L+
 kQOGt8o6I6DLerE38U/HX1FXNcnfLsKq0L97QLT1PpnnBF5aC6EmSEkusBF/WvDDdy3+
 eqwIXOM5Bj3u3/m2LeoMXinfi1GXAsgL4iC4PAhfuI+GU68pr5JUD+kE2TYrzARlLvRF
 o0HFCcu1dTTapVQW9Y0YipCmH/lvEsga0QHxdtyao6kiNUaV/blB2bZ4Gj310VWufgSd
 wVPH4OKT/RD6pSKbs3s4Dp7HXXYwBj9HwAIgkhJskXmZSebN3Nap3FtYg49Y2/nrZ+k/
 THCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741033837; x=1741638637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOsp2vY13k2XExgGYfdVVsmGZinD+jyXkzh+Sq28GQc=;
 b=rVrkjk1e+yg0oG7jc5+jSYXENl7zmwdLNQwdXTxFIekiDCM0scFFPmoZiWpiEjr0Fi
 /+ISoVgr9bD3OZlOeY25z/0HpdaoKBk3A9rgvwzyb7AcZN7q55EYldklxyC8Hk6k+js4
 JWtOlQsKgQrbLiCG3MM1FTwCPhQkMapmCkPK9vxOQeBVhHLfqqJNe0yOsGaxYwxi9W36
 EcuRn3AMqhkcNdwd7CyTzZ0Osy8gRTjLX+2Dz0v79MdqD7xUKqoPuJJOh3BTIvTqDhx2
 4Ko4WWXw0vpXql3nrmEe5lnATDN0SflvpvCL84F2P1esSaijO9s4xZO7fW6Okw4QsgHr
 iv5w==
X-Gm-Message-State: AOJu0Yw1v+8LIZxda143OdL/VAoTaOtrz4A1iE/EDRgZKT3nRrmMcf+o
 nzImAUhD4wilRbRcWpLW6qS87xJglQMFWX6uVUYWOFacw98yGWBPljYw4yAj9v7HTSwYm44XDbK
 MdKGMuod07J8w2Feup6wWkJsRf/WytaoBP63l
X-Gm-Gg: ASbGnctdiIXloqzfWf+RQPFAMiXL1ijjA60nVMKnyZ5lJ8sgPLOgJNB4bFEETCEOm6O
 wV8masnL2684ip5zFeWLfOT9jFZzBoD3MxRndCsNDOmQjyPFCMeBVOn7Rt1BtS3vLs2OzdGh3dv
 V7ECSPL0mSMhGCSS+B5nKkNbtNEQ==
X-Google-Smtp-Source: AGHT+IH3dyKPVdsrqs7zuiHdDTk8+40ap3FwbpKw1s731Fg76L6KYuSRYTNM3rK+z7UIDFDE9H7MjWLSQL/AUYOGGgg=
X-Received: by 2002:a05:6102:1514:b0:4b9:bd00:454b with SMTP id
 ada2fe7eead31-4c044992ebemr10252175137.13.1741033836979; Mon, 03 Mar 2025
 12:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250112210056.16658-5-phil@philjordan.eu>
 <54399bc5-2dc8-4494-a501-ddfbabf4699b@linaro.org>
In-Reply-To: <54399bc5-2dc8-4494-a501-ddfbabf4699b@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 3 Mar 2025 21:30:26 +0100
X-Gm-Features: AQ5f1JrgLalRMkVTanhSl-m0hNK6cKQEjxCcHZ7AF8-8oKPFzBvWx70gHoMYhZ8
Message-ID: <CAAibmn0kUmh9dUZs5kK1zr-itLEj2ds3J34nYhYFvHH+BwiEYw@mail.gmail.com>
Subject: Re: [PATCH v17 04/11] hw/misc/pvpanic: Add MMIO interface
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, 
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-block@nongnu.org, qemu-arm@nongnu.org, 
 Alexander Graf <graf@amazon.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="00000000000065466f062f7607a9"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::929;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x929.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--00000000000065466f062f7607a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Mar 2025 at 18:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
>
wrote:

> On 12/1/25 22:00, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
> > platform device that we can use in embedded arm environments.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >
> > v3:
> >   * Rebased on upstream, updated a header path
> >
> > v15:
> >   * Constified the property table.
> >
> > v16:
> >   * Removed the DEFINE_PROP_END_OF_LIST marker to match recent upstream
> >     changes.
> >
> >   hw/misc/Kconfig           |  4 +++
> >   hw/misc/meson.build       |  1 +
> >   hw/misc/pvpanic-mmio.c    | 60 ++++++++++++++++++++++++++++++++++++++=
+
>
> Missing MAINTAINERS update, who is going to maintain this file?


Good spot!


> I could add it within the vmapple section in the next patch, but I'd
> rather pvpanic have its own entry covering all variants.


You're welcome to put me down as a maintainer on this.

Thanks for taking another look at this series and helping to get it merged!


> >   include/hw/misc/pvpanic.h |  1 +
> >   4 files changed, 66 insertions(+)
> >   create mode 100644 hw/misc/pvpanic-mmio.c
>
>

--00000000000065466f062f7607a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 3 Mar 2=
025 at 18:54, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lina=
ro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 12/1/25 22:00, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; In addition to the ISA and PCI variants of pvpanic, let&#39;s add an M=
MIO<br>
&gt; platform device that we can use in embedded arm environments.<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@li=
naro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; Tested-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.co=
m" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; v3:<br>
&gt;=C2=A0 =C2=A0* Rebased on upstream, updated a header path<br>
&gt; <br>
&gt; v15:<br>
&gt;=C2=A0 =C2=A0* Constified the property table.<br>
&gt; <br>
&gt; v16:<br>
&gt;=C2=A0 =C2=A0* Removed the DEFINE_PROP_END_OF_LIST marker to match rece=
nt upstream<br>
&gt;=C2=A0 =C2=A0 =C2=A0changes.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 +++<br>
&gt;=C2=A0 =C2=A0hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<=
br>
&gt;=C2=A0 =C2=A0hw/misc/pvpanic-mmio.c=C2=A0 =C2=A0 | 60 +++++++++++++++++=
++++++++++++++++++++++<br>
<br>
Missing MAINTAINERS update, who is going to maintain this file?</blockquote=
><div><br></div><div>Good spot!</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
I could add it within the vmapple section in the next patch, but I&#39;d<br=
>
rather pvpanic have its own entry covering all variants.</blockquote><div><=
br></div><div>You&#39;re welcome to put me down as a maintainer on this.</d=
iv><div><br></div><div>Thanks for taking another look at this series and he=
lping to get it merged!</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt;=C2=A0 =C2=A0include/hw/misc/pvpanic.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A04 files changed, 66 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/pvpanic-mmio.c<br>
<br>
</blockquote></div></div>

--00000000000065466f062f7607a9--

