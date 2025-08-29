Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1510CCA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNFx-0006sT-V5; Sat, 30 Aug 2025 11:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1urxcn-0007sM-RL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1urxcj-00028O-Vu
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756468217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSZ5jwdrl8OITiKU6548rVC53D75N/XQebeOVPpPukE=;
 b=ISKQEv3/oNvxw4YNDP0dg2iGEvRQXfhgMsWw/M2/kdbdAzXKIMRDPSXpdKC2Ey/3/obpwZ
 iJXH5xVNGFCTviVMyzO5GcvsogJZFUBD7r8ad/GsanjR/Nd5tjVjZK9s6QGlbZt2zvFxdb
 0wLfH0ahz7ZwIqez26tK6VOFCIimD/g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-8PJFBgq3MTuUdfp_NpHT2A-1; Fri, 29 Aug 2025 07:50:15 -0400
X-MC-Unique: 8PJFBgq3MTuUdfp_NpHT2A-1
X-Mimecast-MFC-AGG-ID: 8PJFBgq3MTuUdfp_NpHT2A_1756468214
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3278bb34a68so2003530a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 04:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756468214; x=1757073014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CSZ5jwdrl8OITiKU6548rVC53D75N/XQebeOVPpPukE=;
 b=xLeAiGZa6DjAazfH47sVLRkpcA3+uddaaufsSQPRHbO9/g5URAVvdjD3ksyGi+I2x0
 bxCzmAQReyNp52x0kcBzvNQXgSdlCqbdka05eGfLaI6d+9NZkAav3yGbv9jsaqrgH4It
 UofQ1Wk7yVg2v2rs1Gep7oA9vheZU+gqqlfAJ5mRuXzzjW4ChsvJ1Pz3citeIlaqcGh1
 3tpd86IFAVidOcP/f7b7smCFlv6LwCBFON5viZMQPSmj142pAotgcJALAR+6a8NMzIhf
 ygazretN3/UJLTJNqbdmNpcCLV7n2hZJIAkotKQ1agNuwCGHyLyk4TaAiTWC17ypRLa2
 OBYA==
X-Gm-Message-State: AOJu0Yyc/Rf1AcjI9wvdqMEx1SAjIhKV5vrAuaEp5q6d3LeHJxlBGy2p
 Vw0gj54mErgmgW9tHRcM4TJX2X+6biqdLtKsnMxitUhRo83cGgNlX0usNE7YxxFDgE9yGgAVLqk
 oKuwT0lzqhxALUDuJ0mC0StP/idRhcj106sf9rD/v72cxS2ORkBhg0fbXRXV4mlNhFOLAe8EP4R
 y0Z3IW1/Lqaq98RfIG/vJlAnU0tfyIIZE=
X-Gm-Gg: ASbGncvIiua8yP0/CDEI2XKBuaT8+jHP38kJn93EDnCWzEGLkzsJoHjsrKIeVrvuuxw
 0ouSA8ps5cyT9KM8GfCp0L9QYUJMw1S4oaknAQw64/qU6fKhBsSuJn7SR8oWeTni0A1982t+2ZD
 ix/g2pqoGPwiN5NQJJHKLNai4=
X-Received: by 2002:a17:90b:1c06:b0:327:e59d:2cc2 with SMTP id
 98e67ed59e1d1-327e59d2f16mr3398180a91.10.1756468214316; 
 Fri, 29 Aug 2025 04:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjC1P2FcAfjO6LKTUVGB/zreEi60k+SmGeTcV8TpBSTk9i3DDUSHmw11zpDE+d7+3hrV55Wa8UKoxNaHJVeLg=
X-Received: by 2002:a17:90b:1c06:b0:327:e59d:2cc2 with SMTP id
 98e67ed59e1d1-327e59d2f16mr3398145a91.10.1756468213830; Fri, 29 Aug 2025
 04:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-11-marcandre.lureau@redhat.com>
 <aLFr3u+r8P5GGZRJ@intel.com>
In-Reply-To: <aLFr3u+r8P5GGZRJ@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 29 Aug 2025 15:50:02 +0400
X-Gm-Features: Ac12FXyANT3wmldaJ9dZ2oFkOWhLKRs3TJpGJtCvfR8_w7isLdIQyGZ6oKUMCvQ
Message-ID: <CAMxuvaz6n1bhsknnyfgvgw9sha13sEicAfZ6hsNX-vX7v7eDsw@mail.gmail.com>
Subject: Re: [PATCH 10/22] rust: split "migration" crate
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f1edf8063d7f9ff3"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000f1edf8063d7f9ff3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 29, 2025 at 12:37=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wro=
te:

> Hi Marc-Andre,
>
> On Wed, Aug 27, 2025 at 02:41:32PM +0400, marcandre.lureau@redhat.com
> wrote:
> > Date: Wed, 27 Aug 2025 14:41:32 +0400
> > From: marcandre.lureau@redhat.com
> > Subject: [PATCH 10/22] rust: split "migration" crate
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
>
> ...
>
> > @@ -0,0 +1,51 @@
> > +/*
> > + * QEMU System Emulator
> > + *
> > + * Copyright (c) 2024 Linaro Ltd.
> > + *
> > + * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
>
> Could we use /* SPDX-License-Identifier: GPL-2.0-or-later */ directly ?
>
> [snip]
>

I guess we could. Probably for a future cleanup though.


>
> > +// using extension traits would be nicer, unfortunately it doesn't
> allow const
> > +// fn yet
> > +pub struct VMStateFieldHelper(pub VMStateField);
> >
> >  // Add a couple builder-style methods to VMStateField, allowing
> >  // easy derivation of VMStateField constants from other types.
>
> A question: Sorry I didn't get your point about why we need
> VMStateFieldHelper?
>
> For its use case:
>
> > -        vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA,
> FooA).with_version_id(1),
> > -        vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32],
> &VMSTATE_FOOA, FooA).with_version_id(2),
> > +        VMStateFieldHelper(vmstate_struct!(FooB, arr_a[0 .. num_a],
> &VMSTATE_FOOA, FooA)).with_version_id(1).0,
> > +        VMStateFieldHelper(vmstate_struct!(FooB, arr_a_mul[0 ..
> num_a_mul * 32], &VMSTATE_FOOA, FooA)).with_version_id(2).0,
>
> It seems VMStateFieldHelper add another wrapper around vmstate_struct
> (and vmstate_of).
>
> The builder pattern is good, but I'm afraid this builder makes the use of
> vmstate_struct! more complex.
>
> > -impl VMStateField {
> > +impl VMStateFieldHelper {
> >      #[must_use]
> >      pub const fn with_version_id(mut self, version_id: i32) -> Self {
> >          assert!(version_id >=3D 0);
> > -        self.version_id =3D version_id;
> > +        self.0.version_id =3D version_id;
> >          self
> >      }
>
> If we could have a build() method then user doesn't need to write ".0"
> at the end.
>
> >  }
>
> And there's another VMStateDescriptionBuilder:
>
>
> https://lore.kernel.org/qemu-devel/20250505100854.73936-4-pbonzini@redhat=
.com/#t
>
> I think Paolo has the plan to merge it with v1.83 support. So if this
> VMStateFieldHelper is necessary, it's better seperate this into another
> patch and base it over VMStateDescriptionBuilder if possible.
>
>
Paolo rebased it and dropped the need for the VMStateFieldHelper.

--000000000000f1edf8063d7f9ff3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 29, 2=
025 at 12:37=E2=80=AFPM Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com"=
>zhao1.liu@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hi Marc-Andre,<br>
<br>
On Wed, Aug 27, 2025 at 02:41:32PM +0400, <a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; Date: Wed, 27 Aug 2025 14:41:32 +0400<br>
&gt; From: <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank"=
>marcandre.lureau@redhat.com</a><br>
&gt; Subject: [PATCH 10/22] rust: split &quot;migration&quot; crate<br>
&gt; <br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
<br>
...<br>
<br>
&gt; @@ -0,0 +1,51 @@<br>
&gt; +/*<br>
&gt; + * QEMU System Emulator<br>
&gt; + *<br>
&gt; + * Copyright (c) 2024 Linaro Ltd.<br>
&gt; + *<br>
&gt; + * Authors: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidian=
akis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<b=
r>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a copy<br>
&gt; + * of this software and associated documentation files (the &quot;Sof=
tware&quot;), to deal<br>
&gt; + * in the Software without restriction, including without limitation =
the rights<br>
&gt; + * to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell<br>
&gt; + * copies of the Software, and to permit persons to whom the Software=
 is<br>
&gt; + * furnished to do so, subject to the following conditions:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL<br>
&gt; + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER<br>
&gt; + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,<br>
&gt; + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN<br>
&gt; + * THE SOFTWARE.<br>
&gt; + */<br>
<br>
Could we use /* SPDX-License-Identifier: GPL-2.0-or-later */ directly ?<br>
<br>
[snip]<br></blockquote><div><br></div><div>I guess we could. Probably for a=
 future cleanup though.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
&gt; +// using extension traits would be nicer, unfortunately it doesn&#39;=
t allow const<br>
&gt; +// fn yet<br>
&gt; +pub struct VMStateFieldHelper(pub VMStateField);<br>
&gt;<br>
&gt;=C2=A0 // Add a couple builder-style methods to VMStateField, allowing<=
br>
&gt;=C2=A0 // easy derivation of VMStateField constants from other types.<b=
r>
<br>
A question: Sorry I didn&#39;t get your point about why we need<br>
VMStateFieldHelper?<br>
<br>
For its use case:<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_struct!(FooB, arr_a[0 .. num_a], =
&amp;VMSTATE_FOOA, FooA).with_version_id(1),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_struct!(FooB, arr_a_mul[0 .. num_=
a_mul * 32], &amp;VMSTATE_FOOA, FooA).with_version_id(2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMStateFieldHelper(vmstate_struct!(FooB, =
arr_a[0 .. num_a], &amp;VMSTATE_FOOA, FooA)).with_version_id(1).0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMStateFieldHelper(vmstate_struct!(FooB, =
arr_a_mul[0 .. num_a_mul * 32], &amp;VMSTATE_FOOA, FooA)).with_version_id(2=
).0,<br>
<br>
It seems VMStateFieldHelper add another wrapper around vmstate_struct<br>
(and vmstate_of).<br>
<br>
The builder pattern is good, but I&#39;m afraid this builder makes the use =
of<br>
vmstate_struct! more complex.<br>
<br>
&gt; -impl VMStateField {<br>
&gt; +impl VMStateFieldHelper {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #[must_use]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pub const fn with_version_id(mut self, version_id:=
 i32) -&gt; Self {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert!(version_id &gt;=3D 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.version_id =3D version_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.0.version_id =3D version_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
If we could have a build() method then user doesn&#39;t need to write &quot=
;.0&quot;<br>
at the end.<br>
<br>
&gt;=C2=A0 }<br>
<br>
And there&#39;s another VMStateDescriptionBuilder:<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20250505100854.73936-4-pbonzi=
ni@redhat.com/#t" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.=
org/qemu-devel/20250505100854.73936-4-pbonzini@redhat.com/#t</a><br>
<br>
I think Paolo has the plan to merge it with v1.83 support. So if this<br>
VMStateFieldHelper is necessary, it&#39;s better seperate this into another=
<br>
patch and base it over VMStateDescriptionBuilder if possible.<br><br></bloc=
kquote><div><br></div><div>Paolo rebased it and dropped the need for the VM=
StateFieldHelper.</div></div></div>

--000000000000f1edf8063d7f9ff3--


