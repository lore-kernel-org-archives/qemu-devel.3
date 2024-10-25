Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14535D149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 19:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Q6X-000348-OJ; Fri, 25 Oct 2024 15:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Q6U-00033w-4b
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Q6Q-0005la-27
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729884962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1V7ngz4DfZb9VW20WfKXYyHIzBozSgH8PC6wInuU1E=;
 b=ZE4+fCPxZWvtFVlkS8b7vfCetrwUYHR13JnVX9d+y2juFrlpS/NGTvCv+942SMOopynUFF
 QlsZhdjzDjRq0nTQTKZ2xAPAZC0TRQEaL57nlOPhvb0wvBTVA1h0POv5alMvcf0Lo60ZpU
 h8otxsKEOQlKEHZnwaj9ZnfwHFigb8g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-C6dPIriDPcmc8kGQt5oIIg-1; Fri, 25 Oct 2024 15:35:59 -0400
X-MC-Unique: C6dPIriDPcmc8kGQt5oIIg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518ae047so18372585e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 12:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729884958; x=1730489758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1V7ngz4DfZb9VW20WfKXYyHIzBozSgH8PC6wInuU1E=;
 b=UpOTCi0apJ0YHFxwWYYN0dJSffRdU4Xa/EZXCaQektUVk/7AHpklx9czGbC2ZhnbBJ
 VGNP6QxJVyZsWw1S3cVubqRfj0FipLuSj9nPOyM7zExDqgfVAudtuIkspgUrFG5yDQns
 7hiMxZiNuHNlFtEnUiuz3QNGQL5MuIXqhoFFWtodusDNV0nUldwextdevSEBjM6dFGm7
 eiiB+qP4EnKkcZ0nAIg7k1a6ovsT8SAOgensCRwV6dOLd5QXrlCTYuPAHQVIrlWxs9VM
 MXdzsCkuW0MC5DlGC+LR5u2j01D1UkH5/h4B8y7g/KFGLwYySWkRW1zBHTaQ5gfYPvpI
 nhcQ==
X-Gm-Message-State: AOJu0Yxkt0i3yjHS/CsuKuVb7MrdBG4wOQndHuL0cgRyvxuQZ/MqYmwV
 9RGG7o3wnJE986WOEThyQI3UW2wwgUK32iDxFBP9I0yIdvzx1VEUvINi2MdIt7sDTemRq75yd+t
 0zRdq0xFezmBJJ9lMSzrllW/tNv4uBuM4ueYmuPwJxjn8ioX0LRrWSHT0EOaSk8RQvQbxxLYWo9
 41gRuYXT3c4kCaOLItH4ZtWvyTh60=
X-Received: by 2002:a5d:658d:0:b0:37c:ce3c:e15d with SMTP id
 ffacd0b85a97d-38060ec0733mr527356f8f.14.1729884957789; 
 Fri, 25 Oct 2024 12:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9/rCVqV3ZLpDu4NO6hbLVI05GAiw4Te3dgyG9CToxuI5pIO0hwbGkqtMEt2xdG0zR1csuZ5R6iZFgrjGXCxQ=
X-Received: by 2002:a5d:658d:0:b0:37c:ce3c:e15d with SMTP id
 ffacd0b85a97d-38060ec0733mr527343f8f.14.1729884957428; Fri, 25 Oct 2024
 12:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-23-pbonzini@redhat.com>
 <580f10bc-4d37-4ece-b9d8-496ba66b7966@linaro.org>
In-Reply-To: <580f10bc-4d37-4ece-b9d8-496ba66b7966@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 21:35:46 +0200
Message-ID: <CABgObfbhJLeAon9rfpSpFG4cwDvCEMnK+1tkmOR5-+mkSdGOUQ@mail.gmail.com>
Subject: Re: [PATCH 22/23] dockerfiles: install bindgen from cargo on Ubuntu
 22.04
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Junjie Mao <junjie.mao@hotmail.com>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000063ef0e0625523a39"
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

--00000000000063ef0e0625523a39
Content-Type: text/plain; charset="UTF-8"

Il ven 25 ott 2024, 20:51 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> Hi Paolo,
>
> On 10/25/24 09:02, Paolo Bonzini wrote:
> > Because Ubuntu 22.04 has a very old version of bindgen, that
> > does not have the important option --allowlist-file, it will
> > not be able to use --enable-rust out of the box.  Instead,
> > install the latest version of bindgen-cli via "cargo install"
> > in the container, following QEMU's own documentation.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   tests/docker/dockerfiles/ubuntu2204.docker |  5 +++++
> >   tests/lcitool/mappings.yml                 |  4 ++++
> >   tests/lcitool/refresh                      | 11 ++++++++++-
> >   3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/docker/dockerfiles/ubuntu2204.docker
> b/tests/docker/dockerfiles/ubuntu2204.docker
> > index ce3aa39d4f3..245ac879622 100644
> > --- a/tests/docker/dockerfiles/ubuntu2204.docker
> > +++ b/tests/docker/dockerfiles/ubuntu2204.docker
> > @@ -149,6 +149,11 @@ ENV LANG "en_US.UTF-8"
> >   ENV MAKE "/usr/bin/make"
> >   ENV NINJA "/usr/bin/ninja"
> >   ENV PYTHON "/usr/bin/python3"
> > +ENV CARGO_HOME=/usr/local/cargo
> > +ENV PATH=$CARGO_HOME/bin:$PATH
> > +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> > +  apt install -y --no-install-recommends cargo
> > +RUN cargo install bindgen-cli
> >   # As a final step configure the user (if env is defined)
> >   ARG USER
> >   ARG UID
> > diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> > index 9c5ac87c1c2..c90b23a00f1 100644
> > --- a/tests/lcitool/mappings.yml
> > +++ b/tests/lcitool/mappings.yml
> > @@ -1,4 +1,8 @@
> >   mappings:
> > +  # Too old on Ubuntu 22.04; we install it from cargo instead
> > +  bindgen:
> > +    Ubuntu2204:
> > +
> >     flake8:
> >       OpenSUSELeap15:
> >
> > diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> > index 0f16f4d525c..a46cbbdca41 100755
> > --- a/tests/lcitool/refresh
> > +++ b/tests/lcitool/refresh
> > @@ -137,6 +137,14 @@ fedora_rustup_nightly_extras = [
> >       'RUN /usr/local/cargo/bin/rustup run nightly cargo install
> bindgen-cli\n',
> >   ]
> >
> > +ubuntu2204_bindgen_extras = [
> > +    "ENV CARGO_HOME=/usr/local/cargo\n",
> > +    'ENV PATH=$CARGO_HOME/bin:$PATH\n',
> > +    "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
> > +    "  apt install -y --no-install-recommends cargo\n",
> > +    'RUN cargo install bindgen-cli\n',
> > +]
> > +
> >   def cross_build(prefix, targets):
> >       conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
> >       targets = "ENV DEF_TARGET_LIST %s\n" % (targets)
> > @@ -157,7 +165,8 @@ try:
> >                           trailer="".join(debian12_extras))
> >       generate_dockerfile("fedora", "fedora-40")
> >       generate_dockerfile("opensuse-leap", "opensuse-leap-15")
> > -    generate_dockerfile("ubuntu2204", "ubuntu-2204")
> > +    generate_dockerfile("ubuntu2204", "ubuntu-2204",
> > +                        trailer="".join(ubuntu2204_bindgen_extras))
> >
> >       #
> >       # Non-fatal Rust-enabled build
>
> Should we install the same version as the minimal one we expect (0.60,
> in debian 12)? All the rest of series is focused on having fixed minimal
> version, and

this patch seems to escape this rule.
>

But in the end the operation of bindgen is quite deterministic, so if the
coverage is improved we can indeed install 0.60.x. For example, if we think
that user on Debian 12 might use distro bindgen together with a recent
rustc (in their case, rustup-installed), then installing bindgen 0.60.x on
Ubuntu would provide a similar effect.

On the other hand I expect that users will just do "cargo install
bindgen-cli", and Ubuntu is a pretty common distro, so that's what I went
for here.

Paolo

Note: we can still install it using cargo, but just having a fixed
> version would be better.
>
>

--00000000000063ef0e0625523a39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 25 ott 2024, 20:51 Pierrick Bouvier &lt;<a href=
=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt;=
 ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi =
Paolo,<br>
<br>
On 10/25/24 09:02, Paolo Bonzini wrote:<br>
&gt; Because Ubuntu 22.04 has a very old version of bindgen, that<br>
&gt; does not have the important option --allowlist-file, it will<br>
&gt; not be able to use --enable-rust out of the box.=C2=A0 Instead,<br>
&gt; install the latest version of bindgen-cli via &quot;cargo install&quot=
;<br>
&gt; in the container, following QEMU&#39;s own documentation.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0tests/docker/dockerfiles/ubuntu2204.docker |=C2=A0 5 +++++=
<br>
&gt;=C2=A0 =C2=A0tests/lcitool/mappings.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++<br>
&gt;=C2=A0 =C2=A0tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++++++++++-<br>
&gt;=C2=A0 =C2=A03 files changed, 19 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker=
/dockerfiles/ubuntu2204.docker<br>
&gt; index ce3aa39d4f3..245ac879622 100644<br>
&gt; --- a/tests/docker/dockerfiles/ubuntu2204.docker<br>
&gt; +++ b/tests/docker/dockerfiles/ubuntu2204.docker<br>
&gt; @@ -149,6 +149,11 @@ ENV LANG &quot;en_US.UTF-8&quot;<br>
&gt;=C2=A0 =C2=A0ENV MAKE &quot;/usr/bin/make&quot;<br>
&gt;=C2=A0 =C2=A0ENV NINJA &quot;/usr/bin/ninja&quot;<br>
&gt;=C2=A0 =C2=A0ENV PYTHON &quot;/usr/bin/python3&quot;<br>
&gt; +ENV CARGO_HOME=3D/usr/local/cargo<br>
&gt; +ENV PATH=3D$CARGO_HOME/bin:$PATH<br>
&gt; +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \<br>
&gt; +=C2=A0 apt install -y --no-install-recommends cargo<br>
&gt; +RUN cargo install bindgen-cli<br>
&gt;=C2=A0 =C2=A0# As a final step configure the user (if env is defined)<b=
r>
&gt;=C2=A0 =C2=A0ARG USER<br>
&gt;=C2=A0 =C2=A0ARG UID<br>
&gt; diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml<b=
r>
&gt; index 9c5ac87c1c2..c90b23a00f1 100644<br>
&gt; --- a/tests/lcitool/mappings.yml<br>
&gt; +++ b/tests/lcitool/mappings.yml<br>
&gt; @@ -1,4 +1,8 @@<br>
&gt;=C2=A0 =C2=A0mappings:<br>
&gt; +=C2=A0 # Too old on Ubuntu 22.04; we install it from cargo instead<br=
>
&gt; +=C2=A0 bindgen:<br>
&gt; +=C2=A0 =C2=A0 Ubuntu2204:<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0flake8:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0OpenSUSELeap15:<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh<br>
&gt; index 0f16f4d525c..a46cbbdca41 100755<br>
&gt; --- a/tests/lcitool/refresh<br>
&gt; +++ b/tests/lcitool/refresh<br>
&gt; @@ -137,6 +137,14 @@ fedora_rustup_nightly_extras =3D [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;RUN /usr/local/cargo/bin/rustup run nig=
htly cargo install bindgen-cli\n&#39;,<br>
&gt;=C2=A0 =C2=A0]<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +ubuntu2204_bindgen_extras =3D [<br>
&gt; +=C2=A0 =C2=A0 &quot;ENV CARGO_HOME=3D/usr/local/cargo\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 &#39;ENV PATH=3D$CARGO_HOME/bin:$PATH\n&#39;,<br>
&gt; +=C2=A0 =C2=A0 &quot;RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \\=
\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;=C2=A0 apt install -y --no-install-recommends car=
go\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 &#39;RUN cargo install bindgen-cli\n&#39;,<br>
&gt; +]<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0def cross_build(prefix, targets):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0conf =3D &quot;ENV QEMU_CONFIGURE_OPTS --cro=
ss-prefix=3D%s\n&quot; % (prefix)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0targets =3D &quot;ENV DEF_TARGET_LIST %s\n&q=
uot; % (targets)<br>
&gt; @@ -157,7 +165,8 @@ try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0trailer=3D&quot;&quot;.join(debian12_extras))<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0generate_dockerfile(&quot;fedora&quot;, &quo=
t;fedora-40&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0generate_dockerfile(&quot;opensuse-leap&quot=
;, &quot;opensuse-leap-15&quot;)<br>
&gt; -=C2=A0 =C2=A0 generate_dockerfile(&quot;ubuntu2204&quot;, &quot;ubunt=
u-2204&quot;)<br>
&gt; +=C2=A0 =C2=A0 generate_dockerfile(&quot;ubuntu2204&quot;, &quot;ubunt=
u-2204&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 trailer=3D&quot;&quot;.join(ubuntu2204_bindgen_extras))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0# Non-fatal Rust-enabled build<br>
<br>
Should we install the same version as the minimal one we expect (0.60, <br>
in debian 12)? All the rest of series is focused on having fixed minimal ve=
rsion, and</blockquote></div></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
this patch seems to escape this rule.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">But in the end the operation of bindg=
en is quite deterministic, so if the coverage is improved we can indeed ins=
tall 0.60.x. For example, if we think that user on Debian 12 might use dist=
ro bindgen together with a recent rustc (in their case, rustup-installed), =
then installing bindgen 0.60.x on Ubuntu would provide a similar effect.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">On the other hand I expect=
 that users will just do &quot;cargo install bindgen-cli&quot;, and Ubuntu =
is a pretty common distro, so that&#39;s what I went for here.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
Note: we can still install it using cargo, but just having a fixed <br>
version would be better.<br>
<br>
</blockquote></div></div></div>

--00000000000063ef0e0625523a39--


