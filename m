Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6993EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 21:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCn6t-0005AY-IE; Thu, 30 May 2024 17:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sCn6r-0005A3-Nk
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:14:53 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sCn6q-0004aP-0T
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:14:53 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-48bb24c6091so257625137.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717103691; x=1717708491; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6zg79pLSRlFYZcBHVQLsNJCOmnTQyC/tGOTgf1IWQo=;
 b=gmQeTvLfBqS+eIe4HNmPD8cxNqqom1K4UmPXOe6mSLQzgDGsvU4pnAuHw3S2e2i4sC
 rcQAML5edl+uNqrWz2OG1xY1YQ4V6c15p16xg97eNm7eoWTA3vsvT0IYIRKXUmAetPD3
 P3bI4R5VXhHcRtp2xZ5vs0R3BWdBHJJk+UxsAn6SNHwMri5grFbYtQprwbea3bjY8SwR
 Hz7gOq69Guw8mNsoDI4KU1xWJf1C+IBFavY1alJSV0s9/9A1i0PmHXOnXRwsq5FVnLi0
 fHD2BaMs0cJkLyBlLO4s1CIT0EvTPLDAngjE0sIX1Nx0cjInkKoE/1E0mxhLmh98mlk8
 ZQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717103691; x=1717708491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6zg79pLSRlFYZcBHVQLsNJCOmnTQyC/tGOTgf1IWQo=;
 b=IyseP70C+mXAci9F6rWeVJa/KSttt2KkkELw2bQbORxOoTNfc3MNH9QMjUdLfQhbez
 uImHhEb+yqzU2Rl4WCpmuP27KMIsZeigoFDL8nGLYzJaPPDjLbqYLRlJU2rPrSUMr2Gi
 yEILooc0Mr9w4Pp2Dw+jDuN+6tBRJn9AivnPL39RKFc0UcwbMylm1ZjkOOx1i77jgDGl
 rwQj96H8hEXY6DRhijvuG87m3iLvQRh1kYm6I+Bs6t/44oiqISecSGRjXWTRsmU15zQe
 nkeXitsAEhy9lF0MmXmW01eyN4+B1ZSJSLcn/J8FJUnX19V1OTqwN1j5Fp6Tp85QHjYo
 hK/w==
X-Gm-Message-State: AOJu0YyFuqlGUna0zdJvD44tIyBt1G2XnX7bieob0Nma/ePsnxL9Mr2V
 T4MQIkXe+Z1iqqr19DN/KkR6Vu2l5hUphuDoN5xqlZ8paZGZViaOfQVmOvOjYBSglTeyQgiRa9h
 OBzhNYHps0HG3aFQCJSrCZJor8BHf1qb4
X-Google-Smtp-Source: AGHT+IFrzXszaeMjcbTZgtwLxMiHA9xJc94VZ09QcOekXK5FRSPTATnu1PdYuKA+X9E3ALToZVKgd/I3qg4+ZMEeLDg=
X-Received: by 2002:a67:f48a:0:b0:47b:b058:849b with SMTP id
 ada2fe7eead31-48bc1fe0c82mr76408137.10.1717103690687; Thu, 30 May 2024
 14:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <87ikyvcdsl.fsf@draig.linaro.org>
In-Reply-To: <87ikyvcdsl.fsf@draig.linaro.org>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Thu, 30 May 2024 16:14:39 -0500
Message-ID: <CACBuX0TKvqZ6QBRgza=D4x0XoMT+vgqBEeTxkDkgP-ZitKXY8A@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Philippe Mathieu-Daude <philmd@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000086a9090619b25be6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=dmamfmgm@gmail.com; helo=mail-vs1-xe2a.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.006, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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

--00000000000086a9090619b25be6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 2:14=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> David Hubbard <dmamfmgm@gmail.com> writes:
>
> > From: Cord Amfmgm <dmamfmgm@gmail.com>
> >
> > This changes the way the ohci emulation handles a Transfer Descriptor
> with
> > "Current Buffer Pointer" set to "Buffer End" + 1.
> >
> > The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than
> td.be
> > to signal the buffer has zero length. Currently qemu only accepts
> zero-length
> > Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI
> hardware
> > accepts both cases.
>
> Which version of the OHCI spec is this? I can't find it in the one copy
> Google throws up:
>
>
> http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-9231=
43f3456c/ohci_11.pdf
>
>
Replace http with https in that URL and it downloads the PDF OK - it is for
IEEE-1394 Firewire though.

Try this link: https://www.cs.usfca.edu/~cruse/cs698s10/hcir1_0a.pdf - I am
on page 35/160 (the page is numbered "21" on the bottom) for the Table 4-2.

--00000000000086a9090619b25be6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 30, 2024 at 2:14=E2=80=AF=
PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.benn=
ee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">David Hubbard &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=
=3D"_blank">dmamfmgm@gmail.com</a>&gt; writes:<br>
<br>
&gt; From: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"=
_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt;<br>
&gt; This changes the way the ohci emulation handles a Transfer Descriptor =
with<br>
&gt; &quot;Current Buffer Pointer&quot; set to &quot;Buffer End&quot; + 1.<=
br>
&gt;<br>
&gt; The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than=
 <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a><br=
>
&gt; to signal the buffer has zero length. Currently qemu only accepts zero=
-length<br>
&gt; Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI ha=
rdware<br>
&gt; accepts both cases.<br>
<br>
Which version of the OHCI spec is this? I can&#39;t find it in the one copy=
<br>
Google throws up:<br>
<br>
=C2=A0 <a href=3D"http://download.microsoft.com/download/1/6/1/161ba512-40e=
2-4cc9-843a-923143f3456c/ohci_11.pdf" rel=3D"noreferrer" target=3D"_blank">=
http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143=
f3456c/ohci_11.pdf</a><br>
<br></blockquote><div><br></div><div>Replace http with https in that URL an=
d it downloads the PDF OK - it is for IEEE-1394 Firewire though.</div><div>=
<br></div><div>Try this link:=C2=A0<a href=3D"https://www.cs.usfca.edu/~cru=
se/cs698s10/hcir1_0a.pdf">https://www.cs.usfca.edu/~cruse/cs698s10/hcir1_0a=
.pdf</a> -=C2=A0I am on page 35/160 (the page is numbered &quot;21&quot; on=
 the bottom) for the Table 4-2.</div><div>=C2=A0</div></div></div>

--00000000000086a9090619b25be6--

