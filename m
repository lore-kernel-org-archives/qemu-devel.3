Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076CEE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 10:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRUFg-0007ep-HU; Sat, 28 Dec 2024 05:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUFU-0007e1-AK
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 05:40:49 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUFR-0007v5-Vo
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 05:40:48 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4b10dd44c8bso2165393137.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 02:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735382443; x=1735987243;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A0edgM3CXzY5MxsdiZgL274P24jR+TIWVqIyARo0LE4=;
 b=n7O1xT8rO5cJrOnGxkgYHZiORMk3YMMCmauZ43UdfW95jQME7ZGa0Qnhg560hl49LM
 E+55eIeSqOpkFc5lo4xiizWmkT9qqCrMx83u85AWcKgLzOiemjdQFDVzY5nnf1MPez7O
 B7TCIe0KGJcjbbVrzsXXKjykp9tSTdzeuZq3osYwR/M+b+vn3tHnHbB2Lnzha/PQyqnP
 n3rvSEc97kEe2HO6gSs0OXzgcsl9T/49nHRo8+Q5Q5O6xScKeZD+6fMfnzxabrTgjL48
 CJdAGKye/h2Mbcwlf9/A4bWQbzAY1r+5iIYtV4xP4ahlE5H6vNpvbDub3x8h/ZY+Dnka
 Zl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735382443; x=1735987243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A0edgM3CXzY5MxsdiZgL274P24jR+TIWVqIyARo0LE4=;
 b=LNQXFag3trbnjjh0OYxeTPUg8EsELRzcIVSVcHCwBYF40c242YJSOikDP7F+0dCptd
 rvVe6Y8aVxWgGwVY+jnBsP41gEF3MxAaD2bRAwsuEdxbZHm2utLXvZ/2Lxl809Q0w0yV
 DZYQ5GmvHaOm0czrX86qed1ArFdgAgC6AZzlkY1Er8aNPSZTLlU2Ioc4Cftqndq+gNGR
 n2BmiDx4YORS8Nw0m3TlUcLTWHLXfSMngHYix8QMtVKuQcqGP6P02/blPx7QnOIks3sI
 WkYQQNCKzF2BjYDQmKuTSfQsCVC4SIW+1tZaYqM4XTwAmIZM0Voj0ZpOXiY7mrtdfFqE
 GMKw==
X-Gm-Message-State: AOJu0Yz3Cw9w1xFUb9/U+eNqhc0LyUAroFBDlXf2hTfyRclryEmThpXp
 XophlvOVC6P0g7ra8xvJ25aEAlpEeHROekPAmvqv1ceguVEhFnAYp9bH1eYm4I1S4FaGFRTdKfY
 TT2AWrxt24NgtL2bJktCwRHzbVr8KfAu0Msft
X-Gm-Gg: ASbGncuQr4FoAs9Nm6pTq3aRn8Ht1oXYysLF5G+6EnvFEcT+BxE9e+OFb3oNxEZyEma
 ztoshXNFTdXVJ/OxoRud4kp73tauEUrpZFiiGiw==
X-Google-Smtp-Source: AGHT+IGspwGZ/MOCccLXVH5oeaIgrDMBA/5PhMuxFMJL5wTuOVYGi54nH86DOYaL1nYvkEw3DBDna2meGVws2GZ4J/E=
X-Received: by 2002:a05:6102:950:b0:4b2:49ec:1b77 with SMTP id
 ada2fe7eead31-4b2cc494cdamr23693167137.23.1735382442951; Sat, 28 Dec 2024
 02:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20241227121336.25838-1-phil@philjordan.eu>
 <20241227121336.25838-2-phil@philjordan.eu>
 <e332da74-d815-4c46-804f-a850d2ee12dd@linaro.org>
 <CAAibmn0CtihG5dijOKKQeMpW32vPoZTd_ekW5n_-3wVBVOP+uQ@mail.gmail.com>
 <f2f8a23e-32a8-4a2c-89a6-5f9ad0885dde@linaro.org>
In-Reply-To: <f2f8a23e-32a8-4a2c-89a6-5f9ad0885dde@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 28 Dec 2024 11:40:32 +0100
Message-ID: <CAAibmn0TQMLZ_kdpY9OZR8pHCiYNEPirS1oN5xHFHtoqUve7UQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] hw/usb/hcd-xhci-pci: Use modulo to select MSI
 vector as per spec
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, richard.henderson@linaro.org,
 thuth@redhat.com, 
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com, 
 npiggin@gmail.com
Content-Type: multipart/alternative; boundary="0000000000000fdb03062a523627"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e29;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe29.google.com
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

--0000000000000fdb03062a523627
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Dec 2024 at 21:27, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> On 27/12/24 20:45, Phil Dennis-Jordan wrote:
> >
> >
> > On Fri 27. Dec 2024 at 18:45, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org
> > <mailto:philmd@linaro.org>> wrote:
> >
> >     On 27/12/24 13:13, Phil Dennis-Jordan wrote:
> >      > QEMU would crash with a failed assertion if the XHCI controller
> >      > attempted to raise the interrupt on a higher vector than the
> >      > highest configured for the device by the guest driver.
> >      >
> >      > It turns out the XHCI spec (Implementation Note in section 4.17,
> >      > "Interrupters") requires that the host controller signal the MSI
> >      > vector with the number computed by taking the interrupter number
> >      > modulo the number of enabled MSI vectors.
> >      >
> >      > This change introduces that modulo calculation, fixing the
> >      > failed assertion and making the device work correctly in MSI mod=
e
> >      > with macOS's XHCI driver.
> >      >
> >      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
> >     <mailto:phil@philjordan.eu>>
> >      > ---
> >      >
> >      > v2:
> >      >
> >      >   * Switch to modulo arithmetic for MSI vector number rather tha=
n
> >     dropping,
> >      >     as per spec.
> >      >
> >      >   hw/usb/hcd-xhci-pci.c | 1 +
> >      >   1 file changed, 1 insertion(+)
> >      >
> >      > diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> >      > index e110840c7a..e5e7330387 100644
> >      > --- a/hw/usb/hcd-xhci-pci.c
> >      > +++ b/hw/usb/hcd-xhci-pci.c
> >      > @@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState
> >     *xhci, int n, bool level)
> >      >       }
> >      >
> >      >       if (msi_enabled(pci_dev) && level) {
> >      > +        n %=3D msi_nr_vectors_allocated(pci_dev);
> >      >           msi_notify(pci_dev, n);
> >
> >     Should this be done at the MSI layer in the callee?
> >     (I haven't checked the MSI spec).
> >
> >     (Cc'ing hw/pci/msi.c maintainers)
> >
> >
> > MSI-X has specified aliasing behaviour. As far as I can tell, MSI does
> > not - this does not seem especially ambiguous either. From the PCI base
> > spec 3.0:
> >
> > 6.8.3.4. Sending Messages
> > [=E2=80=A6]
> > =E2=80=9CIf the Multiple Message Enable field is =E2=80=9C000=E2=80=9D,=
 the function is not
> > permitted to modify the message data.=E2=80=9D
> > [=E2=80=A6]
> > =E2=80=9CHow a function uses multiple vectors (when allocated) is devic=
e
> > dependent. A function must handle being allocated fewer vectors than
> > requested.=E2=80=9D
> >
> >
> > I understand that to mean that MSI vector aliasing is entirely device-
> > specific, and the assertion in msi_notify() is correct. The XHCI
> > specification statement that the vector should be determined via the
> > modulus of the interrupter index and the number of allocated MSI vector=
s
> > does indeed seem to be XHCI-specific.
>
> OK, thanks for checking! Should we add this new information to the
> patch description?
>

How about this for the new commit message (I've also slightly clarified the
final paragraph about macOS guests):


hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec

QEMU would crash with a failed assertion if the XHCI controller
attempted to raise the interrupt on an interrupter corresponding
to a MSI vector with a higher index than the highest configured
for the device by the guest driver.

This behaviour is correct on the MSI/PCI side: per PCI 3.0 spec,
devices must ensure they do not send MSI notifications for
vectors beyond the range of those allocated by the system/driver
software. Unlike MSI-X, there is no generic way for handling
aliasing in the case of fewer allocated vectors than requested,
so the specifics are up to device implementors. (Section
6.8.3.4. "Sending Messages")

It turns out the XHCI spec (Implementation Note in section 4.17,
"Interrupters") requires that the host controller signal the MSI
vector with the number computed by taking the interrupter number
modulo the number of enabled MSI vectors.

This change introduces that modulo calculation, fixing the
failed assertion. This makes the device work correctly in MSI mode
with macOS's XHCI driver, which only allocates a single vector.



Otherwise,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> > (NB: reading the PCI spec, I=E2=80=99m struck that it seems very vague =
on HOW
> > the low bits of the message data should be =E2=80=9Cmodified=E2=80=9D t=
o encode the
> > vector number. But perhaps I=E2=80=99ve just not found that section yet=
.)
>
> Maybe MST/Marcel know.
>

msi_prepare_message() implements it by masking off the bits and bitwise
or'ing the vector number, which must clearly be the correct method of doing
it or guest OSes would not be happy. I was just struck by the lack of
clarity in the spec. :-) Much like the handwaving in the XHCI spec on the
point of pin-based interrupts. [Note to self: if I ever co-author a
standard specification, make sure someone with no prior involvement
implements it before ratification.]

--0000000000000fdb03062a523627
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 27 Dec =
2024 at 21:27, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 27/12/24 20:45, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri 27. Dec 2024 at 18:45, Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">phil=
md@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 27/12/24 13:13, Phil Dennis-Jordan wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; QEMU would crash with a failed assertion if t=
he XHCI controller<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; attempted to raise the interrupt on a higher =
vector than the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; highest configured for the device by the gues=
t driver.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; It turns out the XHCI spec (Implementation No=
te in section 4.17,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &quot;Interrupters&quot;) requires that the h=
ost controller signal the MSI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; vector with the number computed by taking the=
 interrupter number<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; modulo the number of enabled MSI vectors.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This change introduces that modulo calculatio=
n, fixing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; failed assertion and making the device work c=
orrectly in MSI mode<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with macOS&#39;s XHCI driver.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=
=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:phil@philjordan.eu" ta=
rget=3D"_blank">phil@philjordan.eu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v2:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Switch to modulo arithmetic for=
 MSI vector number rather than<br>
&gt;=C2=A0 =C2=A0 =C2=A0dropping,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0as per spec.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci.c | 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A01 file changed, 1 insertion(+)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/h=
cd-xhci-pci.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index e110840c7a..e5e7330387 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/usb/hcd-xhci-pci.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/usb/hcd-xhci-pci.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -74,6 +74,7 @@ static bool xhci_pci_intr_r=
aise(XHCIState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*xhci, int n, bool level)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (msi_enabled(pci=
_dev) &amp;&amp; level) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n %=3D msi_nr_ve=
ctors_allocated(pci_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msi_n=
otify(pci_dev, n);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Should this be done at the MSI layer in the callee?=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0(I haven&#39;t checked the MSI spec).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0(Cc&#39;ing hw/pci/msi.c maintainers)<br>
&gt; <br>
&gt; <br>
&gt; MSI-X has specified aliasing behaviour. As far as I can tell, MSI does=
 <br>
&gt; not - this does not seem especially ambiguous either. From the PCI bas=
e <br>
&gt; spec 3.0:<br>
&gt; <br>
&gt; 6.8.3.4. Sending Messages<br>
&gt; [=E2=80=A6]<br>
&gt; =E2=80=9CIf the Multiple Message Enable field is =E2=80=9C000=E2=80=9D=
, the function is not <br>
&gt; permitted to modify the message data.=E2=80=9D<br>
&gt; [=E2=80=A6]<br>
&gt; =E2=80=9CHow a function uses multiple vectors (when allocated) is devi=
ce <br>
&gt; dependent. A function must handle being allocated fewer vectors than <=
br>
&gt; requested.=E2=80=9D<br>
&gt; <br>
&gt; <br>
&gt; I understand that to mean that MSI vector aliasing is entirely device-=
 <br>
&gt; specific, and the assertion in msi_notify() is correct. The XHCI <br>
&gt; specification statement that the vector should be determined via the <=
br>
&gt; modulus of the interrupter index and the number of allocated MSI vecto=
rs <br>
&gt; does indeed seem to be XHCI-specific.<br>
<br>
OK, thanks for checking! Should we add this new information to the<br>
patch description?<br></blockquote><div><br></div><div>How about this for t=
he new commit message (I&#39;ve also slightly clarified the final paragraph=
 about macOS guests):</div><div><br></div><div><br></div>hw/usb/hcd-xhci-pc=
i: Use modulo to select MSI vector as per spec<br><br>QEMU would crash with=
 a failed assertion if the XHCI controller<br>attempted to raise the interr=
upt on an interrupter corresponding</div><div class=3D"gmail_quote gmail_qu=
ote_container">to a MSI vector with a higher index than the highest configu=
red</div><div class=3D"gmail_quote gmail_quote_container">for the device by=
 the guest driver.<br><br>This behaviour is correct on the MSI/PCI side: pe=
r PCI 3.0 spec,<br>devices must ensure they do not send MSI notifications f=
or<br>vectors beyond the range of those allocated by the system/driver<br>s=
oftware. Unlike MSI-X, there is no generic way for handling<br>aliasing in =
the case of fewer allocated vectors than requested,<br>so the specifics are=
 up to device implementors. (Section<br>6.8.3.4. &quot;Sending Messages&quo=
t;)<br><br>It turns out the XHCI spec (Implementation Note in section 4.17,=
<br>&quot;Interrupters&quot;) requires that the host controller signal the =
MSI<br>vector with the number computed by taking the interrupter number<br>=
modulo the number of enabled MSI vectors.<br><br>This change introduces tha=
t modulo calculation, fixing the<br>failed assertion. This makes the device=
 work correctly in MSI mode<br>with macOS&#39;s XHCI driver, which only all=
ocates a single vector.<br><div><br></div><div>=C2=A0</div><div><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
Otherwise,<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
&gt; (NB: reading the PCI spec, I=E2=80=99m struck that it seems very vague=
 on HOW <br>
&gt; the low bits of the message data should be =E2=80=9Cmodified=E2=80=9D =
to encode the <br>
&gt; vector number. But perhaps I=E2=80=99ve just not found that section ye=
t.)<br>
<br>
Maybe MST/Marcel know.<br></blockquote><div><br></div><div>msi_prepare_mess=
age() implements it by masking off the bits and bitwise or&#39;ing the vect=
or number, which must clearly be the correct method of doing it or guest OS=
es would not be happy. I was just struck by the lack of clarity in the spec=
. :-) Much like the handwaving in the XHCI spec on the point of pin-based i=
nterrupts. [Note to self: if I ever co-author a standard specification, mak=
e sure someone with no prior involvement  implements it before ratification=
.]</div><div><br></div><div><br></div></div></div>

--0000000000000fdb03062a523627--

