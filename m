Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3FAE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 19:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRGGu-0006aX-H4; Fri, 27 Dec 2024 14:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRGGs-0006a6-Hq
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 14:45:18 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRGGq-0007xw-6D
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 14:45:18 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-518799f2828so3836882e0c.0
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 11:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735328714; x=1735933514;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fJ4uVxgbACdnpOPCbvmwLaFaOlEgparnQSB8FQbwHX8=;
 b=jAcHQXFqu9KrkHkt2n+J5SyIB1kyMndF+AUdOi3ze8PBtzqs8qCW1XTBnzTjxG7VT2
 FIS/+LZvBDXn8qP/haaBWwchoZJpBQ2JX1CITnhTV24eE6WythRkud37Jkylp5oRaZeT
 HBmRPCn+rYNoojzMN2X73IYCrAiCs4wJykKKaMQkvQe5kUMxPEYSKlz7VPSErhAwm79N
 iFpz9/ZPjrV+Zj4LZBG0AGRMu5wqL2jwkeA46Urk83EB9RBdmvRQr5zxjzefLl/BgSuo
 FX/lw7SzIR+C79vHuU+xhkktsQv0YGYwRnm9vjj9mSunKJeKeRiLUktnwk1oXgQt6mrR
 ke7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735328714; x=1735933514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fJ4uVxgbACdnpOPCbvmwLaFaOlEgparnQSB8FQbwHX8=;
 b=fUUrQyCTeUaAlE/+DIvWcNkS1TZWORP/M1hU/7ivGCw2bNCXxkE325LUh8yK6oAoP/
 zS7VEkKhSHGkHrphGqxY9w+HwyGWc4eJ5fH9FN9oAiW44TezsBy7/fYuCDnNAlz0DZ9/
 XhJfGpQN/MCUQhvn+pJRb1RQrtKBJtaCdgwKYlKCfJA7e7mmfGMidpctHanAjmKExnBq
 o6mi9Is1PO6XlXbMHKTDSYmH/xG7TK9MK0cXHldHITy1cgjSLHz2bD6UiCzEaS6TrjwW
 u+alNd+kFDBFTb2PBMUffuewj0xHm7h+2uiuW+nNb4KZQsOIyq9jbCFJG2sWF+Vt3W6j
 uXuw==
X-Gm-Message-State: AOJu0YyQEV0dsHe8HAXcQbXf7xju1qT/Oik8cqBsOIG7GtFu9QMxU08N
 +ZqkVhyJYJnqHT0X861ik6DHP4WDxQtN/9N2xAzDCciVQViGbqkTYODg/4G7cWP56dCgFpYkPyH
 jCg9PGa+PZpx0mBa75TtSWkJfAO8raQtJWSRK
X-Gm-Gg: ASbGncu00APIa2nRIgAIU1MeEmZrihx8mKYYur6/bDpntjbYNgqqnqxYDX3JYRWmGbn
 0TjRgPTxhG5yZMzJP+R/FLa1IN5w695MS7uwDxg==
X-Google-Smtp-Source: AGHT+IFaBsywIDb6zJANHRANt3Bh6uAutWZmReb6Wc6m8K7WOvtp1QioTaX8uDicC4mSXDpcocOsseiaB1u51crsakc=
X-Received: by 2002:a05:6122:320d:b0:517:e7b7:d04b with SMTP id
 71dfb90a1353d-51b64c0534bmr27424373e0c.5.1735328713969; Fri, 27 Dec 2024
 11:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20241227121336.25838-1-phil@philjordan.eu>
 <20241227121336.25838-2-phil@philjordan.eu>
 <e332da74-d815-4c46-804f-a850d2ee12dd@linaro.org>
In-Reply-To: <e332da74-d815-4c46-804f-a850d2ee12dd@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 27 Dec 2024 20:45:02 +0100
Message-ID: <CAAibmn0CtihG5dijOKKQeMpW32vPoZTd_ekW5n_-3wVBVOP+uQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] hw/usb/hcd-xhci-pci: Use modulo to select MSI
 vector as per spec
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, richard.henderson@linaro.org,
 thuth@redhat.com, 
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com, 
 npiggin@gmail.com
Content-Type: multipart/alternative; boundary="00000000000090a8d7062a45b3a5"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a32;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa32.google.com
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

--00000000000090a8d7062a45b3a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri 27. Dec 2024 at 18:45, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> On 27/12/24 13:13, Phil Dennis-Jordan wrote:
> > QEMU would crash with a failed assertion if the XHCI controller
> > attempted to raise the interrupt on a higher vector than the
> > highest configured for the device by the guest driver.
> >
> > It turns out the XHCI spec (Implementation Note in section 4.17,
> > "Interrupters") requires that the host controller signal the MSI
> > vector with the number computed by taking the interrupter number
> > modulo the number of enabled MSI vectors.
> >
> > This change introduces that modulo calculation, fixing the
> > failed assertion and making the device work correctly in MSI mode
> > with macOS's XHCI driver.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >
> > v2:
> >
> >   * Switch to modulo arithmetic for MSI vector number rather than
> dropping,
> >     as per spec.
> >
> >   hw/usb/hcd-xhci-pci.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> > index e110840c7a..e5e7330387 100644
> > --- a/hw/usb/hcd-xhci-pci.c
> > +++ b/hw/usb/hcd-xhci-pci.c
> > @@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int
> n, bool level)
> >       }
> >
> >       if (msi_enabled(pci_dev) && level) {
> > +        n %=3D msi_nr_vectors_allocated(pci_dev);
> >           msi_notify(pci_dev, n);
>
> Should this be done at the MSI layer in the callee?
> (I haven't checked the MSI spec).
>
> (Cc'ing hw/pci/msi.c maintainers)
>

MSI-X has specified aliasing behaviour. As far as I can tell, MSI does not
- this does not seem especially ambiguous either. From the PCI base spec
3.0:

6.8.3.4. Sending Messages
[=E2=80=A6]
=E2=80=9CIf the Multiple Message Enable field is =E2=80=9C000=E2=80=9D, the=
 function is not
permitted to modify the message data.=E2=80=9D
[=E2=80=A6]
=E2=80=9CHow a function uses multiple vectors (when allocated) is device de=
pendent.
A function must handle being allocated fewer vectors than requested.=E2=80=
=9D


I understand that to mean that MSI vector aliasing is entirely
device-specific, and the assertion in msi_notify() is correct. The XHCI
specification statement that the vector should be determined via the
modulus of the interrupter index and the number of allocated MSI vectors
does indeed seem to be XHCI-specific.

(NB: reading the PCI spec, I=E2=80=99m struck that it seems very vague on H=
OW the
low bits of the message data should be =E2=80=9Cmodified=E2=80=9D to encode=
 the vector
number. But perhaps I=E2=80=99ve just not found that section yet.)



> >           return true;
> >       }
>
>

--00000000000090a8d7062a45b3a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri 27. Dec 2024 at 18:45, Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)">On 27/12/24 13:13, Phil Dennis-Jordan wrote:<br>
&gt; QEMU would crash with a failed assertion if the XHCI controller<br>
&gt; attempted to raise the interrupt on a higher vector than the<br>
&gt; highest configured for the device by the guest driver.<br>
&gt; <br>
&gt; It turns out the XHCI spec (Implementation Note in section 4.17,<br>
&gt; &quot;Interrupters&quot;) requires that the host controller signal the=
 MSI<br>
&gt; vector with the number computed by taking the interrupter number<br>
&gt; modulo the number of enabled MSI vectors.<br>
&gt; <br>
&gt; This change introduces that modulo calculation, fixing the<br>
&gt; failed assertion and making the device work correctly in MSI mode<br>
&gt; with macOS&#39;s XHCI driver.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; v2:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Switch to modulo arithmetic for MSI vector number rather=
 than dropping,<br>
&gt;=C2=A0 =C2=A0 =C2=A0as per spec.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci.c | 1 +<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c<br>
&gt; index e110840c7a..e5e7330387 100644<br>
&gt; --- a/hw/usb/hcd-xhci-pci.c<br>
&gt; +++ b/hw/usb/hcd-xhci-pci.c<br>
&gt; @@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int=
 n, bool level)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (msi_enabled(pci_dev) &amp;&amp; level) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n %=3D msi_nr_vectors_allocated(pci_dev);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msi_notify(pci_dev, n);<br>
<br>
Should this be done at the MSI layer in the callee?<br>
(I haven&#39;t checked the MSI spec).<br>
<br>
(Cc&#39;ing hw/pci/msi.c maintainers)<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">MSI-X has specif=
ied aliasing behaviour. As far as I can tell, MSI does not - this does not =
seem especially ambiguous either. From the PCI base spec 3.0:</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">6.8.3.4. Sending Messages</div><div d=
ir=3D"auto">[=E2=80=A6]</div><div dir=3D"auto">=E2=80=9CIf the Multiple Mes=
sage Enable field is =E2=80=9C000=E2=80=9D, the function is not permitted t=
o modify the message data.=E2=80=9D</div><div dir=3D"auto">[=E2=80=A6]</div=
><div dir=3D"auto">=E2=80=9CHow a function uses multiple vectors (when allo=
cated) is device dependent. A function must handle being allocated fewer ve=
ctors than requested.=E2=80=9D</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">I understand that to mean that MSI vecto=
r aliasing is entirely device-specific, and the assertion in msi_notify() i=
s correct. The XHCI specification statement that the vector should be deter=
mined via the modulus of the interrupter index and the number of allocated =
MSI vectors does indeed seem to be XHCI-specific.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">(NB: reading the PCI spec, I=E2=80=99m struck tha=
t it seems very vague on HOW the low bits of the message data should be =E2=
=80=9Cmodified=E2=80=9D to encode the vector number. But perhaps I=E2=80=99=
ve just not found that section yet.)</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:=
1ex;border-left-color:rgb(204,204,204)"><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div></div>

--00000000000090a8d7062a45b3a5--

