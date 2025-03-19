Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57980C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tux1h-0006Go-Ic; Wed, 19 Mar 2025 13:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tux1H-0006Bh-8I
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:15:55 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tux1E-00045K-LX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:15:54 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso8076912a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1742404550; x=1743009350; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IdJgxjmcTGbXvVdKYoLURKEw4k89qqKLcVUAeOb46hU=;
 b=SOOGlkQfnNT8R3LWM2n50vTjs6pCs7en1xXaE9csRvp4blhMyWTjreQYgjfj1+W+AB
 U9zO/dbGOHynApjpOBMP4TNoGvPVZ7qG+tQG0BTpseC4liMVbP8oF47QGeYbdDGeKoG/
 uMDq6abIZoHfH2Vhk4ZV8Uj2KN7D39fS/kNgapHC8HSU8AtthB2R0SVH6JMZfjMXqt3V
 fabYPmupJ4BC9pVlq5qApVd/BqE0lpbSkvOTCTU1J7NOfVFvqrv35GdPwsCjKKaU6uNJ
 uDQiqq8XTWXC07nkP9xKfLYLqRkQSH4WbFTJvAWggAMCaooVJ9u/aOZ5Q8MXqRbpyPym
 ubog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742404550; x=1743009350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IdJgxjmcTGbXvVdKYoLURKEw4k89qqKLcVUAeOb46hU=;
 b=jA0SiACqT6Jjmf7SfWuwDVQPW2lmodwSPkJZIM363F0kNOKonaXesprSi736ourtfz
 LXuehZcUHKyB3S21lLCDp3mYTHD0sJZ6Nkf+So4QHG1OzlsNnmXTppoHFwwnv8lkE4yH
 7vtM5c8cCotJ9F/c8DqqGSJY/GrSYJLaamMIVpCfVek1Nrl5w9kKo9dimSyUTOqRUruV
 wphnNAUXr4GArOvdogiLsLoqSjEuWZWLi18B2FEcypup1oe6o9hOzPJ6iYooscQmFcQq
 amZwD1u9eyZbOpCxq9Dbug8EHKD/uCxvAbfngtUwHmJCWIH2o4mSvGx6yNcATfDgGXWL
 +Utg==
X-Gm-Message-State: AOJu0Yz+9ImanmfHbycM9eF/DMMAtM3u3uioFwKHCR3lz7zaD0JJ00Yr
 /Cn/Ex13WkvdxoYqMzBaMEYJzDV2R2Xjg5QGxquFwOTi6j8Oz/XGHmSZ2R4di2DEmS53ZCtvMIj
 Kesi/30uF2+7pR+aw9Nev39SAj4HxIjxhS28q3g==
X-Gm-Gg: ASbGncu7ahE2ryjijscExCAI/XATro98RA+V48jf/3NAqPDbKPBV16ULf9SMXmifkrc
 erlWlp+btxuM2htXXxDXe9CSb3kQU6WawKpSeMxST8/Fshs9wflxK5FBwb24dWVgTFo519JSaqM
 3H4z2VH+kBDB4ysZXro78Wtms=
X-Google-Smtp-Source: AGHT+IE6oHZTZRT78SJvDDqaoCAXPLU4gbGBCTUlzsL6CuZ9NSRxbUAm3uNn8UCNWD1cUTYU7cW8LjB5aO2mZNBQm/s=
X-Received: by 2002:a05:6402:3513:b0:5e5:c637:b69 with SMTP id
 4fb4d7f45d1cf-5eb80cde92dmr4365996a12.6.1742404549533; Wed, 19 Mar 2025
 10:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250227073049.32655-1-jason.chien@sifive.com>
 <CAFEAcA8LPHEmLxDMUNN7DSHCw8pwvA7kUOAH+Ef1mDvOVH-dYQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8LPHEmLxDMUNN7DSHCw8pwvA7kUOAH+Ef1mDvOVH-dYQ@mail.gmail.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Thu, 20 Mar 2025 01:15:38 +0800
X-Gm-Features: AQ5f1Jqvm014VnT5kG0xaBrYnT1Wz6kKHYmKtYUIvkn5KaLbtks6kbBk8gs4y-s
Message-ID: <CADr__8rhGpOtLBh_8hhtpncAeN9OrxL19ODEcq8n1P9gp420ZA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/edu: Rename macros indicating the direction of
 DMA operations
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Jiri Slaby <jslaby@suse.cz>
Content-Type: multipart/alternative; boundary="0000000000003afd2b0630b52c47"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=jason.chien@sifive.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000003afd2b0630b52c47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a virtual device designed for educational purposes. The only spec I
found is in QEMU documentation:
https://github.com/qemu/qemu/blob/master/docs/specs/edu.rst
According to the documentation:
direction (0: from RAM to EDU, 1: from EDU to RAM)
The macros confused me and my goal is to make the direction easier to
differentiate. Something like EDU_DMA_TO_PCI_BUS and EDU_DMA_FROM_PCI_BUS
would also work. Do you have any suggestions?

thanks

Peter Maydell <peter.maydell@linaro.org> =E6=96=BC 2025=E5=B9=B43=E6=9C=881=
2=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:41=E5=AF=AB=E9=81=93=EF=
=BC=9A

> On Thu, 27 Feb 2025 at 07:32, Jason Chien <jason.chien@sifive.com> wrote:
> >
> > This commit renames the macros to accurately reflect the direction of
> > DMA operations.
> >
> > EDU_DMA_TO_PCI now represents reading memory content into the EDU buffe=
r,
> > while EDU_DMA_FROM_PCI represents writing EDU buffer content to memory.
>
> The EDU device is a PCI device, so if it is reading
> then it is reading data from the PCI bus, and if it is
> writing then it is writing data to the PCI bus. So I
> think there's an argument that the current names make
> sense.
>
> Plus, presumably this device model is implementing the hardware
> half of a defined specification. The authoritative source for
> what names the 0 and 1 values of the DIR bit should be named
> would be that specification.
>
> Where is that spec, and what does it say? If it says 0 for
> FROM and 1 for TO, that's what we should use. If it's the
> other way around, that's an error in our device implementation
> that we should correct.
>
> thanks
> -- PMM
>

--0000000000003afd2b0630b52c47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div id=3D"gmail-:1g8" class=3D"gmail-Am gmail-aiL gmail-a=
O9 gmail-Al editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"=
=E9=83=B5=E4=BB=B6=E5=85=A7=E6=96=87" role=3D"textbox" aria-multiline=3D"tr=
ue" tabindex=3D"1" style=3D"direction:ltr;min-height:85px" aria-controls=3D=
":20c" aria-expanded=3D"false">This is a virtual device designed for educat=
ional purposes. The only spec I found is in QEMU documentation: <a href=3D"=
https://github.com/qemu/qemu/blob/master/docs/specs/edu.rst">https://github=
.com/qemu/qemu/blob/master/docs/specs/edu.rst</a></div><div id=3D"gmail-:1g=
8" class=3D"gmail-Am gmail-aiL gmail-aO9 gmail-Al editable gmail-LW-avf gma=
il-tS-tW gmail-tS-tY" aria-label=3D"=E9=83=B5=E4=BB=B6=E5=85=A7=E6=96=87" r=
ole=3D"textbox" aria-multiline=3D"true" tabindex=3D"1" style=3D"direction:l=
tr;min-height:85px" aria-controls=3D":20c" aria-expanded=3D"false">Accordin=
g to the documentation:<br>direction (0: from RAM to EDU, 1: from EDU to RA=
M)</div><div id=3D"gmail-:1g8" class=3D"gmail-Am gmail-aiL gmail-aO9 gmail-=
Al editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"=E9=83=B5=
=E4=BB=B6=E5=85=A7=E6=96=87" role=3D"textbox" aria-multiline=3D"true" tabin=
dex=3D"1" style=3D"direction:ltr;min-height:85px" aria-controls=3D":20c" ar=
ia-expanded=3D"false">The macros confused me and my goal is to make the dir=
ection easier to differentiate. Something like EDU_DMA_TO_PCI_BUS and=C2=A0=
EDU_DMA_FROM_PCI_BUS would also work. Do you have any suggestions?<br><br>t=
hanks<br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">Peter Maydell &lt;<a href=3D"mailto:pe=
ter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =E6=96=BC 2025=E5=
=B9=B43=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:41=E5=AF=
=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Thu, 27 Feb 2025 at 07:32, Jason Chien &lt;<a href=3D"mailto:jason=
.chien@sifive.com" target=3D"_blank">jason.chien@sifive.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; This commit renames the macros to accurately reflect the direction of<=
br>
&gt; DMA operations.<br>
&gt;<br>
&gt; EDU_DMA_TO_PCI now represents reading memory content into the EDU buff=
er,<br>
&gt; while EDU_DMA_FROM_PCI represents writing EDU buffer content to memory=
.<br>
<br>
The EDU device is a PCI device, so if it is reading<br>
then it is reading data from the PCI bus, and if it is<br>
writing then it is writing data to the PCI bus. So I<br>
think there&#39;s an argument that the current names make<br>
sense.<br>
<br>
Plus, presumably this device model is implementing the hardware<br>
half of a defined specification. The authoritative source for<br>
what names the 0 and 1 values of the DIR bit should be named<br>
would be that specification.<br>
<br>
Where is that spec, and what does it say? If it says 0 for<br>
FROM and 1 for TO, that&#39;s what we should use. If it&#39;s the<br>
other way around, that&#39;s an error in our device implementation<br>
that we should correct.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000003afd2b0630b52c47--

