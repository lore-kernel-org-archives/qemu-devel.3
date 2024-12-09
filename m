Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFC4E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 11:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKbie-0000eO-20; Mon, 09 Dec 2024 06:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKbia-0000e9-Af
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:14:24 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKbiX-00045R-Ph
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:14:24 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-85c5d4f3d58so275008241.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733742860; x=1734347660;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=exFHiGIK7DVWr9Yk8KkO12AvqQIfrjQp6nY9v0nD1c8=;
 b=HhTosiaAI3mD76Qs0D/adjjyh2iHcvS+FqlzG7t783ux60tJGn6VCTNH3gA79i3bUb
 HwSxMtbblf42VYDxuDDxy45r+8o1hjppQmy+jUop9OxZDIgWMbg9fWUb5DFHnBYPnh8Q
 ns3Mu6OIy7d2DdiUtAongnfMxnpOycaahy0zpIesZQ7a546DXZrWlnmHy8G34zii39HR
 6+OyRKyjtQqwzef7s06n8UkK47dMXT6x8s76jPtudT+BPlYoFGTLlxtPf6gZo8zHEwiD
 0XIMmAcmpL12L2x2fksOaKkWd85OPKoIunkgVw9YK1TZe4cy9QK2BLyfKN6LD+oChrfw
 CXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733742860; x=1734347660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=exFHiGIK7DVWr9Yk8KkO12AvqQIfrjQp6nY9v0nD1c8=;
 b=aCKVhInpQMz3qQuNTOxx+21b2HzYb1jbfPmH7ZN3r6wZcVSA+IV98PPedHM26jx7nP
 AvWtgjpZpM10U/MeXcxuMAtMewxGRySaOZChM8DCKr8m/JV1k/Rs+sTTxCaSc1xcoCwA
 WcJHKulvqa35vggjqYzcTzb5fgOFODUty/FGSqiebfV8GuHs0WYEI6WQdhNAfM6GpPdu
 1SIbpMs0GumegkQXTHPBxdqY3035Lr3XFaPzYcHgPujMtU1wqRKMFJTUcmwZmRuDzd3G
 LcS4Kk22yfNcik/KyCfC7wRLeRWypce8+0VJfqJtpA7Ss0uYsW6ywKbbEgU6cAlAeky5
 MKVQ==
X-Gm-Message-State: AOJu0YwOzZlfwCojQt259tdH1j2Iesya5Sq3h0+1KeQbFBEsls5thOqG
 6OjT8fhK9noXf7H0Aie/78l5fz+lFj8VoFi8RkyYFoZKGsRluFEFveaAFhXDZpeJLCI2f6pgU9s
 3ZguHqIQJyaxbdADS7ifuny3E18kiYnXusSR4
X-Gm-Gg: ASbGncuoiONPQcekAa1V9Qis2Gazy1wgmpp1xXFueLVcREC09tDSxyD9vsmdE4E3e+r
 iyjGjfj7zl3sBsWsV902m7gScxAnJIYg=
X-Google-Smtp-Source: AGHT+IG3JNU80DCqZ8Q+KNBMKx13X6cfjUlkdEl+4XVqOskZrG7GaKwlKbcLc0qCfdw7O3Bi4qQswPwCpwd8ukM3lZs=
X-Received: by 2002:a05:6122:2402:b0:516:240b:58ff with SMTP id
 71dfb90a1353d-51888347d91mr72323e0c.5.1733742859899; Mon, 09 Dec 2024
 03:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20241208191646.64857-1-phil@philjordan.eu>
 <20241208191646.64857-7-phil@philjordan.eu>
 <df6847f5-11d0-4c69-bfac-ec2281279841@daynix.com>
In-Reply-To: <df6847f5-11d0-4c69-bfac-ec2281279841@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 9 Dec 2024 12:14:08 +0100
Message-ID: <CAAibmn1sRa409YCPr6WQ1XmVBntkjh3EokKU1S6ywTwHMcV8xQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] hw/vmapple: XHCI controller's interrupt mapping
 workaround for macOS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 thuth@redhat.com, zhao1.liu@intel.com, imammedo@redhat.com
Content-Type: multipart/alternative; boundary="0000000000004bf2410628d477ab"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::935;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x935.google.com
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

--0000000000004bf2410628d477ab
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 07:26, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2024/12/09 4:16, Phil Dennis-Jordan wrote:
> > This change enables the new conditional interrupt mapping support
> > property on the vmapple machine type's integrated XHCI controller.
> > The macOS guest driver attempts to use event rings 1 and 2 on the XHCI
> > controller, despite there being only one (PCI pin) interrupt channel
> > available. With conditional interrupt mapping enabled, the XHCI
> > controller will only schedule events on interrupter 0 in PCI pin mode
> > or when only a single MSI vector is active.
>
> I think docs/system/arm/vmapple.rst also needs to be updated.
>

Can you be more specific about what you think I should include? That file
currently does not mention USB in any way, and if we set the new property
in the machine type, there shouldn't be any need for manual configuration
on the command line, should there?


> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   hw/vmapple/vmapple.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
> > index f607981bc40..156ea33ae79 100644
> > --- a/hw/vmapple/vmapple.c
> > +++ b/hw/vmapple/vmapple.c
> > @@ -453,6 +453,13 @@ static void create_pcie(VMAppleMachineState *vms)
> >       }
> >
> >       usb_controller = qdev_new(TYPE_QEMU_XHCI);
> > +    /*
> > +     * macOS XHCI driver attempts to schedule events onto even rings 1
> & 2
> > +     * even when (as here) there is no MSI-X support on this PCIe bus.
> Disabling
> > +     * interrupter mapping in the XHCI controller works around the
> problem.
> > +     */
> > +    object_property_set_bool(OBJECT(usb_controller),
> > +                             "conditional-intr-mapping", true,
> &error_fatal);
>
> Use compat_props to change the global default for this machine.
>

Thanks, that works.



> By the way, this unconditionally adds xHCI and USB devices, but that
> should be avoided so that users can customize the configuration. Use
> defaults_enabled() as a condition.
>

Makes sense, I guess I'd better add that to the VMApple patch set though.



> Regards,
> Akihiko Odaki
>
> >       qdev_realize_and_unref(usb_controller, BUS(pci->bus),
> &error_fatal);
> >
> >       usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
>
>

--0000000000004bf2410628d477ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 9 Dec 2=
024 at 07:26, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com"=
>akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 2024/12/09 4:16, Phil Dennis-Jordan wrote:<br>
&gt; This change enables the new conditional interrupt mapping support<br>
&gt; property on the vmapple machine type&#39;s integrated XHCI controller.=
<br>
&gt; The macOS guest driver attempts to use event rings 1 and 2 on the XHCI=
<br>
&gt; controller, despite there being only one (PCI pin) interrupt channel<b=
r>
&gt; available. With conditional interrupt mapping enabled, the XHCI<br>
&gt; controller will only schedule events on interrupter 0 in PCI pin mode<=
br>
&gt; or when only a single MSI vector is active.<br>
<br>
I think docs/system/arm/vmapple.rst also needs to be updated.<br></blockquo=
te><div><br></div><div>Can you be more specific about what you think I shou=
ld include? That file currently does not mention USB in any way, and if we =
set the new property in the machine type, there shouldn&#39;t be any need f=
or manual configuration on the command line, should there?<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/vmapple/vmapple.c | 7 +++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 7 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c<br>
&gt; index f607981bc40..156ea33ae79 100644<br>
&gt; --- a/hw/vmapple/vmapple.c<br>
&gt; +++ b/hw/vmapple/vmapple.c<br>
&gt; @@ -453,6 +453,13 @@ static void create_pcie(VMAppleMachineState *vms)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0usb_controller =3D qdev_new(TYPE_QEMU_XHCI);=
<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* macOS XHCI driver attempts to schedule events o=
nto even rings 1 &amp; 2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* even when (as here) there is no MSI-X support o=
n this PCIe bus. Disabling<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* interrupter mapping in the XHCI controller work=
s around the problem.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(usb_controller),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;conditional-intr-mapping&quot;, tr=
ue, &amp;error_fatal);<br>
<br>
Use compat_props to change the global default for this machine.<br></blockq=
uote><div><br></div><div>Thanks, that works.<br></div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
By the way, this unconditionally adds xHCI and USB devices, but that <br>
should be avoided so that users can customize the configuration. Use <br>
defaults_enabled() as a condition.<br></blockquote><div><br></div><div>Make=
s sense, I guess I&#39;d better add that to the VMApple patch set though. <=
br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
Regards,<br>
Akihiko Odaki<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_realize_and_unref(usb_controller, BUS(p=
ci-&gt;bus), &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0usb_bus =3D USB_BUS(object_resolve_type_unam=
biguous(TYPE_USB_BUS,<br>
<br>
</blockquote></div></div>

--0000000000004bf2410628d477ab--

