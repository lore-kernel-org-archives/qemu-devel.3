Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F77C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKrc-0004kz-6a; Thu, 04 Jul 2024 07:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sPKrT-0004jU-9z
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:42:52 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sPKrR-0005yW-CH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:42:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38028so730480a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720093358; x=1720698158; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HzfFhpY9wpDm0aoDe9W7snDRqUECUqFzPYV35L92RvU=;
 b=M9CvCUbMwxio+gcm+0zrL7Oo706otEllpjZvh782VJJO0s3dwG/Zcxqr3SjUav/YoT
 ayu25gTZDqHb/0gd6iveyzCfjnhE5YNuVOY24N+nwjRj+EV0K02qPcOm0XD5wFEbRR/n
 kztsW7sCFUNLiGa5anC/Y+pKiK4QEO7OQBvK4rGup1FstcqyO8ZS213gwe3bBn1EKWgH
 VeGprHa9kE2V2bcAp80MSEWc3BxyMez0+r1trI+BWIQjdOA1RrZ2FhjM8HJuwEwe/KLq
 DvOWV8/LZnUkf9mi8UhpbppkOLQINSEY/zFHYD+RGW81Y+bKobtRFfaMoW71Que/VyLD
 MDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720093358; x=1720698158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzfFhpY9wpDm0aoDe9W7snDRqUECUqFzPYV35L92RvU=;
 b=riS2fQXdH0yTxePeOA1LVpnoDAgDCRZFYtZtiQRAwGPrin8jobJ2+tw/QIQOq+qIKs
 UtvcKx6/aG+ZwFehU4jQ52EFjxWZ5czEukFrg+OCdm3jbOu07xcIoqFfdfOuqk3Z9zW/
 WtyTtmERhtRDw+QTGwijfvSV9sbdyW+ow43QHyrW80odNdKybIJryNdiI0pkiH19JNfl
 b6fK5cOf2WkVgd7yb9zuCYLWw9MCi1nfgke0FI6GgYsSL4+5biM0yA1K8v9WZM89k73J
 e78JItbmV/YIVwmalCLH1BRKTUWsoIbtkwAYoaEOM82IRANi2E71ElfWzUyhQMPQITQQ
 pDVw==
X-Gm-Message-State: AOJu0YyV6+L6YmIvA96zXe9pG4IQrf6AMKF/J6IX9TpWfOP3WKhZpPGx
 XWQxOlwLHdflULU0TWXZ6cXrqek6DMEKhrVaoFI5tb0DgRFZz6LQNYSOPfCSuaMwBHtJ5xXse+T
 I5vT0jy2CLqBNe1JSjkbKSl72b+E=
X-Google-Smtp-Source: AGHT+IHasBEGIlgvaru77AmnEamynOyBIUI9Gcvx3G8Hln78yqQw9r5HACJZLDYiclHUBv3xStP7OftQm8aV8lp5t9E=
X-Received: by 2002:a05:6402:34c2:b0:58d:e458:1310 with SMTP id
 4fb4d7f45d1cf-58e5acd87ccmr827965a12.13.1720093357631; Thu, 04 Jul 2024
 04:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-2-edgar.iglesias@gmail.com>
 <87ikxlo3lx.fsf@draig.linaro.org>
In-Reply-To: <87ikxlo3lx.fsf@draig.linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 4 Jul 2024 14:42:25 +0300
Message-ID: <CAJy5ezpD6i3Fc9K-i58=V0e1uxrB-VZ2sd+gtoOc4TnbkWHSZQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] physmem: Bail out qemu_ram_block_from_host() for
 invalid ram addrs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008fef90061c6a7180"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52a.google.com
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

--0000000000008fef90061c6a7180
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:26=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> "Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:
>
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > Bail out in qemu_ram_block_from_host() when
> > xen_ram_addr_from_mapcache() does not find an existing
> > mapping.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  system/physmem.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 33d09f7571..59d1576c2b 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -2277,6 +2277,10 @@ RAMBlock *qemu_ram_block_from_host(void *ptr,
> bool round_offset,
> >          ram_addr_t ram_addr;
> >          RCU_READ_LOCK_GUARD();
> >          ram_addr =3D xen_ram_addr_from_mapcache(ptr);
> > +        if (ram_addr =3D=3D RAM_ADDR_INVALID) {
> > +            return NULL;
> > +        }
> > +
>
> Isn't this indicative of a failure? Should there at least be a trace
> point for failed mappings?
>
>
Yes but there are already trace points for the failure cases inside
xen_ram_addr_from_mapcache().
Do those address your concerns or do you think we need additional trace
points?

Cheers,
Edgar


> >          block =3D qemu_get_ram_block(ram_addr);
> >          if (block) {
> >              *offset =3D ram_addr - block->offset;
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000008fef90061c6a7180
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jul 4, 2024 at 1:26=E2=80=AFPM Al=
ex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@li=
naro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">&quot;Edgar E. Iglesias&quot; &lt;<a hre=
f=3D"mailto:edgar.iglesias@gmail.com" target=3D"_blank">edgar.iglesias@gmai=
l.com</a>&gt; writes:<br>
<br>
&gt; From: &quot;Edgar E. Iglesias&quot; &lt;<a href=3D"mailto:edgar.iglesi=
as@amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt;<br>
&gt; Bail out in qemu_ram_block_from_host() when<br>
&gt; xen_ram_addr_from_mapcache() does not find an existing<br>
&gt; mapping.<br>
&gt;<br>
&gt; Signed-off-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@=
amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 system/physmem.c | 4 ++++<br>
&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/system/physmem.c b/system/physmem.c<br>
&gt; index 33d09f7571..59d1576c2b 100644<br>
&gt; --- a/system/physmem.c<br>
&gt; +++ b/system/physmem.c<br>
&gt; @@ -2277,6 +2277,10 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, b=
ool round_offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_addr_t ram_addr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RCU_READ_LOCK_GUARD();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_addr =3D xen_ram_addr_from_mapca=
che(ptr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ram_addr =3D=3D RAM_ADDR_INVALID) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
Isn&#39;t this indicative of a failure? Should there at least be a trace<br=
>
point for failed mappings?<br>
<br></blockquote><div><br></div><div>Yes but there are already trace points=
 for the failure cases inside xen_ram_addr_from_mapcache().</div><div>Do th=
ose address your concerns or do you think we need additional trace points?<=
/div><div><br></div><div>Cheers,</div><div>Edgar</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block =3D qemu_get_ram_block(ram_add=
r);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (block) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *offset =3D ram_addr -=
 block-&gt;offset;<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--0000000000008fef90061c6a7180--

