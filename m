Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C808C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 05:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMhNJ-0007WZ-IP; Thu, 27 Jun 2024 01:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pykfirst@gmail.com>)
 id 1sMhNA-0007Vq-3E
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 01:08:44 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pykfirst@gmail.com>)
 id 1sMhN5-0004gd-By
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 01:08:38 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b5253ffd24so22998866d6.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 22:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719464912; x=1720069712; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RyLfg7erkwaospXgzzDCgxy0Ye64vP6rkOcyyVB3WDw=;
 b=icxaYKBXqtel66XXN22LV5QY1hBRFCe/Hh8sxYAF3K0CONcMUIpb0LyXn97lizphVF
 3hYGTN7B5+VA7UJzMTkz6RJvMTsDDBUcifGNFUQXrvh1gpHmGS/VagTyWCMcmbnRCU17
 d7C2423nqYk0o5U73UgdghVE5bCTaBF4wvcWHboJZmKdxkKPyzEp4wMzWYh6H5iVuwTD
 eW7EYHN627LsP8UMjlPI6/AeQMGFDJAFXv6tow2pCQUhVp4YMRCHz3fkvb4su540mQE4
 LJilZbC+4xcHsEiTbG8d1TZ28yRVHPc1+XHSqkTX4S2/W2XaBJyv3GSs7qhZQve7z6Q1
 zqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719464912; x=1720069712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RyLfg7erkwaospXgzzDCgxy0Ye64vP6rkOcyyVB3WDw=;
 b=rFVpC2xb2vy73Y8C10yUmz6X1C+WIGr3QT69g22i2pE7lt+zaUzkhPm+/R7VzgzXTa
 Q3lp+jKl0M/RU0L+T1Qgwx4TyZGo2ttx+ZXe7gYDbuH7JIVNS3Dw524DmXkIq3de15h+
 8gJTrrucdl07ccu5gBgaXcoFvVI4e9fOM6unYO7xJT4/XQyFxExHLZMYqudgzL9TUD0O
 R83L3j9pOhJw8fgYm+61Yzduk5oSeBsHHo6ccBSdbTkOtqIPWzBGA+ymx8I3pa0/yhie
 nFOm3X6r16Yk5FgfJi6zynM8CNDlnJ5KaexpPdz0NltGa8W2j95ltXsLt7DkwGjk9hVa
 az/Q==
X-Gm-Message-State: AOJu0YwWzu62ydYd7mMtl+DtRxDe9EvMS8r6MPtc5mIrGcIwJQdgPDfR
 JGdkx9RkLGJmOrDmd1ic+TOzqQIO+CmtFb7+MQx58fDKBPvm8EmeHwyD2OJFmPf/1PY527QLhSL
 KAOolvJiNCJPYndVzqnfssHDky90=
X-Google-Smtp-Source: AGHT+IFJWxjQ1mrLVTqbkbhWyNxJttHlwEP4JLQlwrykRAqJTEVLWMO/AIfFQehGAolvd/SoXldBQbbA8Dcxfa4aKqg=
X-Received: by 2002:a0c:f3c3:0:b0:6b4:fde8:8688 with SMTP id
 6a1803df08f44-6b53653adb3mr133202506d6.53.1719464912267; Wed, 26 Jun 2024
 22:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240625112819.862282-1-pykfirst@gmail.com>
 <0baa7fcd-0b86-4ce0-88c9-4954363c2616@gmail.com>
In-Reply-To: <0baa7fcd-0b86-4ce0-88c9-4954363c2616@gmail.com>
From: Yuke Peng <pykfirst@gmail.com>
Date: Thu, 27 Jun 2024 13:08:21 +0800
Message-ID: <CAHJVP30fNZvuc7MVwAvNZM6fY+zUCOJcsUsXo2i4pG844RgvDA@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/intel_iommu: Block CFI when necessary
To: cmd <clement.mathieudrif.etu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004cb4c5061bd81feb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=pykfirst@gmail.com; helo=mail-qv1-xf2d.google.com
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

--0000000000004cb4c5061bd81feb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:15=E2=80=AFPM cmd <clement.mathieudrif.etu@gmail.=
com>
wrote:

> Hi,
>
> On 25/06/2024 13:28, Yuke Peng wrote:
> > According to Intel VT-d specification 5.1.4, CFI must be blocked when
> > Extended Interrupt Mode is enabled or Compatibility format interrupts
> > are disabled.
> >
> > Signed-off-by: Yuke Peng <pykfirst@gmail.com>
> > ---
> >   hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++++
> >   hw/i386/trace-events          |  1 +
> >   include/hw/i386/intel_iommu.h |  1 +
> >   3 files changed, 30 insertions(+)
> >
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 5085a6fee3..dfa2f979e7 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -2410,6 +2410,22 @@ static void vtd_handle_gcmd_ire(IntelIOMMUState
> *s, bool en)
> >       }
> >   }
> >
> > +/* Handle Compatibility Format Interrupts Enable/Disable */
> > +static void vtd_handle_gcmd_cfi(IntelIOMMUState *s, bool en)
> > +{
> > +    trace_vtd_cfi_enable(en);
> > +
> > +    if (en) {
> > +        s->cfi_enabled =3D true;
> > +        /* Ok - report back to driver */
> > +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_CFIS);
> > +    } else {
> > +        s->cfi_enabled =3D false;
> > +        /* Ok - report back to driver */
> > +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_CFIS, 0);
> > +    }
> You have the same comment in both branches of the if statement, couldn't
> we put it between 'trace' and 'if'?
>

The reason I put the comment within the branches is that the function
'vtd_handle_gcmd_cfi'  is similar to the function 'vtd_handle_gcmd_ire'
and  'vtd_handle_gcmd_te'. So for consistency, I also put comments
within the branches instead of in front of 'if'. Besides, I think the
comments
only explain the statement 'vtd_set_clear_mask_long'.

The 'vtd_handle_gcmd_ire' function:

> /* Handle Interrupt Remap Enable/Disable */
> static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
> {
>     trace_vtd_ir_enable(en);
>
>     if (en) {
>         s->intr_enabled =3D true;
>         /* Ok - report back to driver */
>         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRES);
>     } else {
>         s->intr_enabled =3D false;
>         /* Ok - report back to driver */
>         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_IRES, 0);
>     }
> }

--0000000000004cb4c5061bd81feb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jun 26, 2024 at 2:15=E2=80=AFPM c=
md &lt;<a href=3D"mailto:clement.mathieudrif.etu@gmail.com">clement.mathieu=
drif.etu@gmail.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 25/06/2024 13:28, Yuke Peng wrote:<br>
&gt; According to Intel VT-d specification 5.1.4, CFI must be blocked when<=
br>
&gt; Extended Interrupt Mode is enabled or Compatibility format interrupts<=
br>
&gt; are disabled.<br>
&gt;<br>
&gt; Signed-off-by: Yuke Peng &lt;<a href=3D"mailto:pykfirst@gmail.com" tar=
get=3D"_blank">pykfirst@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/i386/intel_iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2=
8 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/i386/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0include/hw/i386/intel_iommu.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A03 files changed, 30 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
&gt; index 5085a6fee3..dfa2f979e7 100644<br>
&gt; --- a/hw/i386/intel_iommu.c<br>
&gt; +++ b/hw/i386/intel_iommu.c<br>
&gt; @@ -2410,6 +2410,22 @@ static void vtd_handle_gcmd_ire(IntelIOMMUState=
 *s, bool en)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* Handle Compatibility Format Interrupts Enable/Disable */<br>
&gt; +static void vtd_handle_gcmd_cfi(IntelIOMMUState *s, bool en)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 trace_vtd_cfi_enable(en);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (en) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cfi_enabled =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ok - report back to driver */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vtd_set_clear_mask_long(s, DMAR_GSTS_REG,=
 0, VTD_GSTS_CFIS);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cfi_enabled =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ok - report back to driver */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vtd_set_clear_mask_long(s, DMAR_GSTS_REG,=
 VTD_GSTS_CFIS, 0);<br>
&gt; +=C2=A0 =C2=A0 }<br>
You have the same comment in both branches of the if statement, couldn&#39;=
t <br>
we put it between &#39;trace&#39; and &#39;if&#39;?<br></blockquote><div><b=
r></div><div>The reason I put the comment within the branches is that the f=
unction=C2=A0</div><div>&#39;vtd_handle_gcmd_cfi&#39;=C2=A0 is similar to t=
he function &#39;vtd_handle_gcmd_ire&#39;=C2=A0</div><div>and=C2=A0 &#39;vt=
d_handle_gcmd_te&#39;. So for consistency, I also put comments=C2=A0</div><=
div>within the branches instead of in front of &#39;if&#39;. Besides, I thi=
nk the comments</div><div>only explain the statement &#39;vtd_set_clear_mas=
k_long&#39;.</div><div><br></div><div>The &#39;vtd_handle_gcmd_ire&#39; fun=
ction:<br></div><div><br></div><div>&gt; /* Handle Interrupt Remap Enable/D=
isable */<br>&gt; static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool =
en)<br>&gt; {<br>&gt;=C2=A0 =C2=A0 =C2=A0trace_vtd_ir_enable(en);<br>&gt;=
=C2=A0<br>&gt;=C2=A0 =C2=A0 =C2=A0if (en) {<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;intr_enabled =3D true;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Ok - report back to driver */<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRES);<br>&gt;=
=C2=A0 =C2=A0 =C2=A0} else {<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt=
;intr_enabled =3D false;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ok - r=
eport back to driver */<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vtd_set_cl=
ear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_IRES, 0);<br>&gt;=C2=A0 =C2=A0 =C2=
=A0}<br>&gt; }<br></div><div>=C2=A0</div></div></div>

--0000000000004cb4c5061bd81feb--

