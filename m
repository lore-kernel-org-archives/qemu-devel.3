Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3CECD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVq4-0002tt-U4; Wed, 10 Apr 2024 07:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVq3-0002tS-EQ; Wed, 10 Apr 2024 07:09:59 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVpw-0008N1-So; Wed, 10 Apr 2024 07:09:54 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e2b3e114fso6756630a12.2; 
 Wed, 10 Apr 2024 04:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712747391; x=1713352191; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vE92hnc8BAG0T6Kx44GKeZRxsC+3iq1fx3ux4Mdkiqk=;
 b=dof510Sqxl/FjzoeIGQfcxUMCAVS+dtJuBZUlvlm0hoRcrth9+1gjuyD3Aw6Hd3KeX
 JWQ1sY636E+g21W++k/9DDNkrQWqaYOqgq+6qmBJkgaxfp1+LVmn9A+EoaNFOpZUq5us
 +ncqYb8sQKlNXevBr3lXl9rosHNn7RGXbJa+4WfPzaaKuOpYLs6V1pzKcQvIFegxdA7e
 lR0ORbKeOCxfn7qJXbxP0rGtZDwJXRdoqau5jhQ1gmvcbLHnSvjyx4Jrjcc4czcA7VmC
 2BGkvQYtqyBIGkZjKZ7puJY03pSMksmRl4gRxDKncuBnzR1sCNmkFKRirUPK3y/qtSmw
 1YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747391; x=1713352191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vE92hnc8BAG0T6Kx44GKeZRxsC+3iq1fx3ux4Mdkiqk=;
 b=jKXbTG9If/tGVR5MrhGVmPzRaw7oKidVaIBVQUeEpjsfe3ePqy5uruDcyzv07gcafs
 B/Is0kj1uCfezf6y2SVjqWGZRmLhbvJvY+AFpRIVrT1JP5WHFYF3lS71Po3LGtFNBt6b
 o6oIAMZaVkQRUKFIrRdaCYnybaCyZAjHpc6eFJ6hZTU/CchkWwn+5NbxPmtlkw8kYKFn
 8OYJwTAytHh6jGCw+h6xhEXQKYE3Oh/adsxOSTd06Ij68pdNRfa/plsUagQ86oihNgS7
 k57nUgYxclPhCjfs5IgQCJH8/vWug3Nkir0Unt9CfRyRelMSfYWMbiJpXmcybiUzKawy
 MSbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD7QLX4zWNS9E7daVCyUAB2oh60h9h1mkh1ZGeeE/BO2Cu46zA8ohmsAH79QDUAZseWvQznE9AFB4ky73p37FECYi/qeyi0TH+5OtZjBU2P+LZGjIGDGdH2Yc=
X-Gm-Message-State: AOJu0Yz92V5dKjq63GExSxLT/CGsFYs/FLExRr8bx3E27JuzgwaClVth
 o40H9X5JE7QgQpEvhrXIX4fj9wTpTYikXOFh/vifw/BKrLnwSs20wMdD/D0WOSCyhRGJ7jl3thq
 e6tyzaxXRhiXnOUDngaq7xoStRIE=
X-Google-Smtp-Source: AGHT+IHrJ+Y8ioHbIy0Osc3IVG8sczZ/fh2l/i3k+Pjsz6iAjVr7s4zdD5EDW4dIxxrrt0vurUB8+OFWHS+EEB1t83Q=
X-Received: by 2002:a50:8a89:0:b0:56d:c88a:f37 with SMTP id
 j9-20020a508a89000000b0056dc88a0f37mr1422295edj.26.1712747390673; Wed, 10 Apr
 2024 04:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-8-vikram.garhwal@amd.com>
 <87il25514r.fsf@draig.linaro.org> <ZejYmXhm87RGhQED@amd.com>
In-Reply-To: <ZejYmXhm87RGhQED@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 13:09:39 +0200
Message-ID: <CAJy5ezqc1MsfR7A=ba5N42M-r42ciDzTvDy92r3SENQKg+FMYw@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 7/7] hw: arm: Add grant mapping.
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000cfa99e0615bc13e8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52c.google.com
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

--000000000000cfa99e0615bc13e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 9:57=E2=80=AFPM Vikram Garhwal <vikram.garhwal@amd.c=
om>
wrote:

> Hi Alex,
> On Fri, Mar 01, 2024 at 05:10:28PM +0000, Alex Benn=C3=A9e wrote:
> > Vikram Garhwal <vikram.garhwal@amd.com> writes:
> >
> > > Enable grant ram mapping support for Xenpvh machine on ARM.
> > >
> > > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > > ---
> > >  hw/arm/xen_arm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> > > index 32776d94df..b5993ef2a6 100644
> > > --- a/hw/arm/xen_arm.c
> > > +++ b/hw/arm/xen_arm.c
> > > @@ -125,6 +125,9 @@ static void xen_init_ram(MachineState *machine)
> > >                                   GUEST_RAM1_BASE, ram_size[1]);
> > >          memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi=
);
> > >      }
> > > +
> > > +    DPRINTF("init grant ram mapping for XEN\n");
> >
> > I don't think we need the DPRINTF here (there others where recently
> > converted to trace-points although I suspect a memory_region tracepoint
> > would be a better place to capture this).
> May be drop the print? As it's not providing much information anyways.
>

With the DPRINTF dropped:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

--000000000000cfa99e0615bc13e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Mar 6, 2024 at 9:57=E2=80=AFPM Vi=
kram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd.com">vikram.garhwal@a=
md.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Alex,<br>
On Fri, Mar 01, 2024 at 05:10:28PM +0000, Alex Benn=C3=A9e wrote:<br>
&gt; Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd.com" target=3D=
"_blank">vikram.garhwal@amd.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; Enable grant ram mapping support for Xenpvh machine on ARM.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwa=
l@amd.com" target=3D"_blank">vikram.garhwal@amd.com</a>&gt;<br>
&gt; &gt; Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini=
@kernel.org" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/arm/xen_arm.c | 3 +++<br>
&gt; &gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c<br>
&gt; &gt; index 32776d94df..b5993ef2a6 100644<br>
&gt; &gt; --- a/hw/arm/xen_arm.c<br>
&gt; &gt; +++ b/hw/arm/xen_arm.c<br>
&gt; &gt; @@ -125,6 +125,9 @@ static void xen_init_ram(MachineState *machin=
e)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GUEST_RAM1_BASE,=
 ram_size[1]);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(sys=
mem, GUEST_RAM1_BASE, &amp;ram_hi);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 DPRINTF(&quot;init grant ram mapping for XEN\n&quo=
t;);<br>
&gt; <br>
&gt; I don&#39;t think we need the DPRINTF here (there others where recentl=
y<br>
&gt; converted to trace-points although I suspect a memory_region tracepoin=
t<br>
&gt; would be a better place to capture this).<br>
May be drop the print? As it&#39;s not providing much information anyways.<=
br>
</blockquote><div><br></div><div>With the DPRINTF dropped:</div><div>Review=
ed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@amd.com">edga=
r.iglesias@amd.com</a>&gt;</div><div><br></div><div><br></div></div></div>

--000000000000cfa99e0615bc13e8--

