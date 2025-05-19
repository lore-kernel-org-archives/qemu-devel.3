Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD0DC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH4Vy-0002wQ-Nd; Mon, 19 May 2025 13:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qwinci222@gmail.com>)
 id 1uH4Vv-0002wC-P2
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:43:00 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qwinci222@gmail.com>)
 id 1uH4Vt-0004nN-PE
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:42:59 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-601afe51106so2684496a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747676576; x=1748281376; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UTjJNJAi7LgxFZ6sSDSuyhLGOCaZn2s+lPKGIBLNrGY=;
 b=UkrtvnNkuxINFXH3+6Yn1UW3DXGI6cQwo9M4/FQQxjFSsxSRwosvwoVFHh38XSEFV6
 mrxwh/GzzmRWrTQw4vknCdAN3VCvVFl/cbD5lhP913Dp2TydpJT6om5grV+bN/yZbwyt
 cuKKEMHLoPUd4Nmg89IkWSjvKoH87C/fYi1sfbM3E2llf9sv7RgMZHd4EcUrTu2yyFyZ
 USJ1HMldpx5znGVDUAE7XbrfTyj7oYUtsStvLkgQDKMfRPI85b4nG540ioClmutuqap0
 TDHxkGuc2PJtSWyOxsRQ9o02yypXNlITUnHlJDKnZduq6jSS7lnTQHCdW/N81nbQ1/gD
 GVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747676576; x=1748281376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTjJNJAi7LgxFZ6sSDSuyhLGOCaZn2s+lPKGIBLNrGY=;
 b=syPQD/I3E4sXM3zZUId8g7B6Y8HV145mXMLnOaTYCDMdpkzRz0tFuMQaakSBwa+wC9
 g+BTmGj4UnX/t32Le3Y9BlFQmufZgrUoJ6xIJHNRMfcv7IPQ5s94Acah0QWDGd/etgJ0
 KAdBk6No8Wi1fy0fjaZEMVL+qnsLiY/LggvRqOWOyW+crcnahQevGgrK1bGLlt2sZi6L
 KurulhDbvHW8ssdF+Vjdg2o34Elk5mqYimCShS949gGKgXdW+2unTAwrSx+pENN4mHLL
 mR6X6DCiXSVVePH2zt7QmFZmKHCPy7UVtY6DrmeZ3Qv178ItqOApGH1RHnjmXvzlHVfP
 nfdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEZ6eK2VwIbeM8eeIqvX0HCfzNKSJIXFcDdStiB0gsrwsmz3Ok5W8gFR+8mtGJYoNrIKkubLgQDb7w@nongnu.org
X-Gm-Message-State: AOJu0YxnL8Zf2ZbGq7oM08jiUnYfXnkazxTMvXKGeX9IqySTesU1fQd9
 YWKe6esJIvH1lAqR4gD4ylFlkx+54LDhpdw7FZMdC3p3B0jbY5SOVc3MGpJ5RFXcagPMM7WRZto
 FCLO/N2MB5fypYdv9mC0HLkkkFxFgenU=
X-Gm-Gg: ASbGncsuYDulcU9kTfWLm2XDhlYP2eGqc+Os6H0Otc5s6X9e0hkjHIx+/AwGzaJWgEG
 tLCoIiu7zg7MUAv3jjq+4bv99i3yci8JO7hJ/g7AbYZBMAUNdzjKZOLv8/p0iF8bJ6JrrFxhmuN
 f9P6xPLNoi1rtr8G4LoybEQoIZg474wxY=
X-Google-Smtp-Source: AGHT+IEHg4Rvgn+AKL/awW+9V5834OjlWfqNt+lmN/8CKdZ3PVSs1joGP0nVOrLFUrHHITGa2ycasErTFgzXoSD+8tU=
X-Received: by 2002:a17:907:2d2a:b0:ad5:1e70:7145 with SMTP id
 a640c23a62f3a-ad52d4e746dmr1322679066b.22.1747676575401; Mon, 19 May 2025
 10:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250519150837.23146-3-qwinci222@gmail.com>
 <20250519111527.6cafd01a.alex.williamson@redhat.com>
 <5de0e6b8-7c05-4e20-b828-93442c670eca@gmail.com>
In-Reply-To: <5de0e6b8-7c05-4e20-b828-93442c670eca@gmail.com>
From: Visa <qwinci222@gmail.com>
Date: Mon, 19 May 2025 20:42:43 +0300
X-Gm-Features: AX0GCFsJXN2JOLf9nh54aD0KjD548krJuW44LNelvXtRvO-hpKUFnZ6yb7Cj4pM
Message-ID: <CANHiinFQkHkS1XY0FfkJnByiAY9aNhjA+HBKBaGCpHS7eJ6Z7w@mail.gmail.com>
Subject: Re: [PATCH] vfio/igd: Support non-boot gpus
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000758c9e063580a95b"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=qwinci222@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000758c9e063580a95b
Content-Type: text/plain; charset="UTF-8"

Thanks for the comments, Ill make a new patch with a `vfio_is_display`
function`,
should I still change all uses of the `vfio_is_vga` function to use that one
even if the other quirks aren't needed in that configuration?


ma 19.5.2025 klo 20.28 Tomita Moeko (tomitamoeko@gmail.com) kirjoitti:

> On 5/20/25 01:15, Alex Williamson wrote:
> > [Please Cc maintainers - added here]
> >
> > On Mon, 19 May 2025 18:08:39 +0300
> > Qwinci <qwinci222@gmail.com> wrote:
> >
> >> Change the IGD detection logic to also accept gpus with
> >> PCI_CLASS_DISPLAY_OTHER class which is used if the igpu is not
> >> set as the primary boot gpu.
> >>
> >> Signed-off-by: Qwinci <qwinci222@gmail.com>
> >> ---
> >>  hw/vfio/igd.c | 16 +++++++++++++---
> >>  1 file changed, 13 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> >> index e7952d15a0..1ddfcc2c17 100644
> >> --- a/hw/vfio/igd.c
> >> +++ b/hw/vfio/igd.c
> >> @@ -454,6 +454,16 @@ static bool vfio_pci_igd_override_gms(int gen,
> uint32_t gms, uint32_t *gmch)
> >>  #define IGD_GGC_MMIO_OFFSET     0x108040
> >>  #define IGD_BDSM_MMIO_OFFSET    0x1080C0
> >>
> >> +static bool is_igd(VFIOPCIDevice *vdev) {
> >> +    if (vfio_is_vga(vdev)) {
> >> +        return true;
> >> +    }
> >> +
> >> +    PCIDevice *pdev = &vdev->pdev;
> >> +    uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
> >> +    return class == PCI_CLASS_DISPLAY_OTHER;
> >> +}
> >
> > But the function isn't detecting IGD, it's detecting VGA or DISPLAY
> > class devices.  So it's misnamed and we might want a new
> > vfio_is_display() and if necessary a wrapper for both that tests
> > vfio_is_vga_or_display(), or maybe a vfio_is_base_display() if we want
> > to test only the base class.
>
> +1, matching the base class is enough here I think.
>
> > More importantly maybe, sure there might be IGD as non-primary
> > configurations, but are the quirks still relevant to those devices?
> > Which ones?  Thanks,
> >
> > Alex
>
> Actually this is what I've worked on for a while. Only the OpRegion
> quirk is needed in this configuration, Windows driver requires it.
> Additionally, legacy mode should be disabled when IGD is non-primary as
> VGA ranges are not routed to IGD.
>
> It also requires a more recent version kernel (6.15+) [1] for OpRegion
> support on IGD as non-primary graphics.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=41112160ca87d6b5280813ef61f1c35bb9ee2f82
>
> Thanks,
> Moeko
>
> >>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
> >>  {
> >>      VFIOQuirk *ggc_quirk, *bdsm_quirk;
> >> @@ -461,7 +471,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev,
> int nr)
> >>      int gen;
> >>
> >>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> >> -        !vfio_is_vga(vdev) || nr != 0) {
> >> +        !is_igd(vdev) || nr != 0) {
> >>          return;
> >>      }
> >>
> >> @@ -519,7 +529,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice
> *vdev, Error **errp)
> >>      Error *err = NULL;
> >>
> >>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> >> -        !vfio_is_vga(vdev)) {
> >> +        !is_igd(vdev)) {
> >>          return true;
> >>      }
> >>
> >> @@ -685,7 +695,7 @@ static bool
> vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
> >>      int gen;
> >>
> >>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> >> -        !vfio_is_vga(vdev)) {
> >> +        !is_igd(vdev)) {
> >>          return true;
> >>      }
> >>
> >
>

--000000000000758c9e063580a95b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks for the comments, Ill make a new p=
atch with a `vfio_is_display` function`,<br>should I still change all uses =
of the `vfio_is_vga` function to use that one</div><div dir=3D"ltr">even if=
 the other quirks aren&#39;t needed in that configuration?</div><br></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">ma 19.5.2025 klo 20.28 Tomita Moeko (<a href=3D"mailto:tomi=
tamoeko@gmail.com">tomitamoeko@gmail.com</a>) kirjoitti:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 5/20/25 01:15, Alex Williamson =
wrote:<br>
&gt; [Please Cc maintainers - added here]<br>
&gt; <br>
&gt; On Mon, 19 May 2025 18:08:39 +0300<br>
&gt; Qwinci &lt;<a href=3D"mailto:qwinci222@gmail.com" target=3D"_blank">qw=
inci222@gmail.com</a>&gt; wrote:<br>
&gt; <br>
&gt;&gt; Change the IGD detection logic to also accept gpus with<br>
&gt;&gt; PCI_CLASS_DISPLAY_OTHER class which is used if the igpu is not<br>
&gt;&gt; set as the primary boot gpu.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Qwinci &lt;<a href=3D"mailto:qwinci222@gmail.com" t=
arget=3D"_blank">qwinci222@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 hw/vfio/igd.c | 16 +++++++++++++---<br>
&gt;&gt;=C2=A0 1 file changed, 13 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c<br>
&gt;&gt; index e7952d15a0..1ddfcc2c17 100644<br>
&gt;&gt; --- a/hw/vfio/igd.c<br>
&gt;&gt; +++ b/hw/vfio/igd.c<br>
&gt;&gt; @@ -454,6 +454,16 @@ static bool vfio_pci_igd_override_gms(int gen=
, uint32_t gms, uint32_t *gmch)<br>
&gt;&gt;=C2=A0 #define IGD_GGC_MMIO_OFFSET=C2=A0 =C2=A0 =C2=A00x108040<br>
&gt;&gt;=C2=A0 #define IGD_BDSM_MMIO_OFFSET=C2=A0 =C2=A0 0x1080C0<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt; +static bool is_igd(VFIOPCIDevice *vdev) {<br>
&gt;&gt; +=C2=A0 =C2=A0 if (vfio_is_vga(vdev)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 PCIDevice *pdev =3D &amp;vdev-&gt;pdev;<br>
&gt;&gt; +=C2=A0 =C2=A0 uint16_t class =3D pci_get_word(pdev-&gt;config + P=
CI_CLASS_DEVICE);<br>
&gt;&gt; +=C2=A0 =C2=A0 return class =3D=3D PCI_CLASS_DISPLAY_OTHER;<br>
&gt;&gt; +}<br>
&gt; <br>
&gt; But the function isn&#39;t detecting IGD, it&#39;s detecting VGA or DI=
SPLAY<br>
&gt; class devices.=C2=A0 So it&#39;s misnamed and we might want a new<br>
&gt; vfio_is_display() and if necessary a wrapper for both that tests<br>
&gt; vfio_is_vga_or_display(), or maybe a vfio_is_base_display() if we want=
<br>
&gt; to test only the base class.<br>
<br>
+1, matching the base class is enough here I think.<br>
<br>
&gt; More importantly maybe, sure there might be IGD as non-primary<br>
&gt; configurations, but are the quirks still relevant to those devices?<br=
>
&gt; Which ones?=C2=A0 Thanks,<br>
&gt; <br>
&gt; Alex<br>
<br>
Actually this is what I&#39;ve worked on for a while. Only the OpRegion<br>
quirk is needed in this configuration, Windows driver requires it.<br>
Additionally, legacy mode should be disabled when IGD is non-primary as<br>
VGA ranges are not routed to IGD.<br>
<br>
It also requires a more recent version kernel (6.15+) [1] for OpRegion<br>
support on IGD as non-primary graphics.<br>
<br>
[1] <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3D41112160ca87d6b5280813ef61f1c35bb9ee2f82" rel=3D"norefe=
rrer" target=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git/commit/?id=3D41112160ca87d6b5280813ef61f1c35bb9ee2f82</a><b=
r>
<br>
Thanks,<br>
Moeko<br>
<br>
&gt;&gt;=C2=A0 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)<=
br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 VFIOQuirk *ggc_quirk, *bdsm_quirk;<br>
&gt;&gt; @@ -461,7 +471,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *=
vdev, int nr)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 int gen;<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PC=
I_ANY_ID) ||<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 !vfio_is_vga(vdev) || nr !=3D 0) {<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !is_igd(vdev) || nr !=3D 0) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt; @@ -519,7 +529,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCID=
evice *vdev, Error **errp)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PC=
I_ANY_ID) ||<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 !vfio_is_vga(vdev)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !is_igd(vdev)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt; @@ -685,7 +695,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPC=
IDevice *vdev, Error **errp)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 int gen;<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PC=
I_ANY_ID) ||<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 !vfio_is_vga(vdev)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !is_igd(vdev)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 <br>
&gt; <br>
</blockquote></div>

--000000000000758c9e063580a95b--

