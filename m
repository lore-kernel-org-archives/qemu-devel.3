Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA37D149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 19:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4PyS-0000Wa-7J; Fri, 25 Oct 2024 15:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4PyK-0000W4-KX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4PyI-0004et-Qf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729884460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rDls0cIjH4+9iyTriu/WJ76sIlZRNxQ84OEiuRmJrQQ=;
 b=LZZETDqGuZtKY5zbmilHP2ELHyEUdQAo0nE6wlZvgIWWb/O2yDjyjRbeDf1szdXvvYstt7
 IEwRsl4d0Ud9ysajYnB3WyngO10RRbtE9uKK6A/YheS6YIt4XtF931zE9gktxn2lpRiGgA
 ajBXYv2eYslyqkXF9qHZL9sEuZ/bv2g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-rSuomevmOCqJHZTeC608fw-1; Fri, 25 Oct 2024 15:27:35 -0400
X-MC-Unique: rSuomevmOCqJHZTeC608fw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so16866435e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 12:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729884454; x=1730489254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rDls0cIjH4+9iyTriu/WJ76sIlZRNxQ84OEiuRmJrQQ=;
 b=ehdaQV6nY7u501DS5EiDnSr08dHooeDSzmQfgdhavkd00xaoAWYRbKrkVzWlJREEY2
 dTblV6eiqZBBvpvFCjL3HAHJDvDmgu2QwI0vuJi0pq3ymQixJzNRbN4jF5gkN/H56BGa
 0NTy9TL42PfXl/euPVFT5JIMierpQhorcCofcfrYNLxFo7pqEN5fjPO7XSRTVJGu+GjB
 gJxmVTOwb16CSaiWvXqs1oDgK+SJZtWS7kvjnF6cnBFK+1EADJbr8SbN9tE+sq+OM2zb
 ke16ZBIZGoItSLO6fo5XqRzglIC24CPy/NdNrtfHGNRY1bbjyb07ypWdDWFcsoS2o5jB
 UPHg==
X-Gm-Message-State: AOJu0YxmHA4ilsKnFoh8/L/N/PS2FEDpfOds9fEjZMRueXe/PDDA+aAQ
 mjjFeE46Q0YacopP2meBFymu48hGshjKe6cbTWpRMNVukCVx5+OStyErnwXcusJZ8q0A4zRoQDp
 2tQaUtiMssyNdu/yeP7jBrPCat5SyYZbyAIqoytN9DzbzV89V/rTI+DIk1O6QKpRGg5wpavdN2Z
 3Ll5L+clLCrSksFJVVouisDYdrBOo=
X-Received: by 2002:a05:600c:1c1e:b0:431:5ecf:2a39 with SMTP id
 5b1f17b1804b1-4319ad32854mr1751585e9.35.1729884454002; 
 Fri, 25 Oct 2024 12:27:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl5RW9lkdvPi0GVfF3vLp6aJoHvaeLUrGi5vzmJkOAT75H8Gi2Pw866iUq/tKLlJw8pDwLnZhMLKRj5CqLwM0=
X-Received: by 2002:a05:600c:1c1e:b0:431:5ecf:2a39 with SMTP id
 5b1f17b1804b1-4319ad32854mr1751455e9.35.1729884453640; Fri, 25 Oct 2024
 12:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-24-pbonzini@redhat.com>
 <8b1fc9e7-7387-4386-b759-9c15873a1bd1@linaro.org>
In-Reply-To: <8b1fc9e7-7387-4386-b759-9c15873a1bd1@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 21:27:22 +0200
Message-ID: <CABgObfYtjfv0N3mwT4OzYFrcMujxmgQcsFkuRAQDOEPvx06NWA@mail.gmail.com>
Subject: Re: [PATCH 23/23] ci: enable rust in the Debian and Ubuntu system
 build job
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Junjie Mao <junjie.mao@hotmail.com>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005cbd150625521cea"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005cbd150625521cea
Content-Type: text/plain; charset="UTF-8"

Il ven 25 ott 2024, 20:55 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> On 10/25/24 09:02, Paolo Bonzini wrote:
> > We have fixed all incompatibilities with older versions of rustc
> > and bindgen.  Enable Rust on Debian to check that the minimum
> > supported version of Rust is indeed 1.63.0, and 0.60.x for bindgen.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   .gitlab-ci.d/buildtest.yml | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index aba65ff833a..8deaf9627cb 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -40,7 +40,7 @@ build-system-ubuntu:
> >       job: amd64-ubuntu2204-container
> >     variables:
> >       IMAGE: ubuntu2204
> > -    CONFIGURE_ARGS: --enable-docs
> > +    CONFIGURE_ARGS: --enable-docs --enable-rust
> >       TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
> >       MAKE_CHECK_ARGS: check-build
> >
> > @@ -71,7 +71,7 @@ build-system-debian:
> >       job: amd64-debian-container
> >     variables:
> >       IMAGE: debian
> > -    CONFIGURE_ARGS: --with-coroutine=sigaltstack
> > +    CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
> >       TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4-softmmu
> >         sparc-softmmu xtensa-softmmu
> >       MAKE_CHECK_ARGS: check-build
>
> Do you think it could be valuable to have a third job for Rust with:
> - ubuntu2204 or debian with latest rustc/cargo/bindgen, so we may detect
> regressions when those are updated.
>

Note that apart from these two jobs we have Fedora with rustup-installed
nightly (in master) and Fedora with distro Rust tool chain (patches
posted). Would that provide the same (or similar enough) scenario?

Paolo


> This way, we would test (2204 + min, debian + min, latest), which should
> ensure Rust code will build correctly on older and newer systems.
>
> Pierrick
>
>

--0000000000005cbd150625521cea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 25 ott 2024, 20:55 Pierrick Bouvier &lt;<a href=
=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt;=
 ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
10/25/24 09:02, Paolo Bonzini wrote:<br>
&gt; We have fixed all incompatibilities with older versions of rustc<br>
&gt; and bindgen.=C2=A0 Enable Rust on Debian to check that the minimum<br>
&gt; supported version of Rust is indeed 1.63.0, and 0.60.x for bindgen.<br=
>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0.gitlab-ci.d/buildtest.yml | 4 ++--<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml<b=
r>
&gt; index aba65ff833a..8deaf9627cb 100644<br>
&gt; --- a/.gitlab-ci.d/buildtest.yml<br>
&gt; +++ b/.gitlab-ci.d/buildtest.yml<br>
&gt; @@ -40,7 +40,7 @@ build-system-ubuntu:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0job: amd64-ubuntu2204-container<br>
&gt;=C2=A0 =C2=A0 =C2=A0variables:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0IMAGE: ubuntu2204<br>
&gt; -=C2=A0 =C2=A0 CONFIGURE_ARGS: --enable-docs<br>
&gt; +=C2=A0 =C2=A0 CONFIGURE_ARGS: --enable-docs --enable-rust<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGETS: alpha-softmmu microblazeel-softmmu =
mips64el-softmmu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MAKE_CHECK_ARGS: check-build<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -71,7 +71,7 @@ build-system-debian:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0job: amd64-debian-container<br>
&gt;=C2=A0 =C2=A0 =C2=A0variables:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0IMAGE: debian<br>
&gt; -=C2=A0 =C2=A0 CONFIGURE_ARGS: --with-coroutine=3Dsigaltstack<br>
&gt; +=C2=A0 =C2=A0 CONFIGURE_ARGS: --with-coroutine=3Dsigaltstack --enable=
-rust<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGETS: arm-softmmu i386-softmmu riscv64-so=
ftmmu sh4-softmmu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sparc-softmmu xtensa-softmmu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MAKE_CHECK_ARGS: check-build<br>
<br>
Do you think it could be valuable to have a third job for Rust with:<br>
- ubuntu2204 or debian with latest rustc/cargo/bindgen, so we may detect <b=
r>
regressions when those are updated.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Note that apart from these two jobs we h=
ave Fedora with rustup-installed nightly (in master) and Fedora with distro=
 Rust tool chain (patches posted). Would that provide the same (or similar =
enough) scenario?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
This way, we would test (2204 + min, debian + min, latest), which should <b=
r>
ensure Rust code will build correctly on older and newer systems.<br>
<br>
Pierrick<br>
<br>
</blockquote></div></div></div>

--0000000000005cbd150625521cea--


