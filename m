Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4218BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLWq-000207-Bz; Fri, 09 Aug 2024 05:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scLWn-0001t7-2H
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:03:17 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scLWk-0004u1-EM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:03:16 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d9e13ef8edso1330186b6e.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723194069; x=1723798869;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6qz9TCfGbkGUHoPmIa9RPefw7RGfDvazkjw0vRjSp9g=;
 b=akvbRxLVChCWM+MR//BH/gssRPzK5YGzgfmkf4Xk+oPtUd9hdWMaUoby4zUR+Xmmfk
 DZYDLfaeBl93JDqbVpCsjTSII3CpDLR3nZZfiJ2jL/yG8GdTOL5RFBn8TwEAFOrg345k
 Zdl6twKx9E0JdKYJwTLd2akUrWBVzB5pekChvSAmUvBTLda2yNKQ5RAFw4AKia4kCZt9
 XuUxYu+zFYhRlQYyKwRI+qIQ2GSeg5hJMllwMcLmyGfmCod/ksWIUpcSKoi8CtLQhdyl
 YRsbXe40/q6Dbn5pu9tgu+QVsAE5iM5QorPJ1WB21nOAnVP+mDvB02bNUYLXPGKuVLPe
 9/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723194069; x=1723798869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qz9TCfGbkGUHoPmIa9RPefw7RGfDvazkjw0vRjSp9g=;
 b=tJX0b2YbQemkXfaasXzDgIPhtF81uR2i4Mh31rHzn4VCzDY/WHBuDEw1pdY4IEvffc
 01vd8yYXBP/Je1hdCr2QizYrgCfk1wpsWcIXnixND3mzztgcPnxGvCL6BYdVhm5wpTzJ
 R9+24W+zlocgAdF5sWUE6eugpOPL3H8MvD27fhxAfYYxbrBdvVXnbzBIqg+LS2ldbBM1
 WctyTLT244JOVS1/bbeoLXes36J7Pd0oZ9IuiRSWPfNmyQuy283xxWmmkFRvKt2jvOJb
 ceqKJPqO8wdlPE6BY/3I6KRmPGm2/qdN6N9zQkjmew6pqtxPpeYTgiePowdwcAxDNTND
 zmNQ==
X-Gm-Message-State: AOJu0YzOcFPKEz4i/Og0BrIK+AG27YaSjvoO2mcijF/nvx8ymo3+8IrL
 jzJ5+yY2mIX/2NbszYmS83yCFWjeOKK+iiFUGJFjuTX9lFfyfX+t6Q/bU5VTVrE5FDuDR0zTJTb
 VzH+JeD49wPIHcC4/rARD/UxUk7/K4PQmCmbnKg==
X-Google-Smtp-Source: AGHT+IFzCJW72swzQWdAwGjLXJ7X+sUR1X953iUjLD2UdlvpStSnH9m6xX3EDrIQSjUN7tWq3t/73XVoeX1laIcztCs=
X-Received: by 2002:a05:6870:d146:b0:25e:14e9:10c9 with SMTP id
 586e51a60fabf-26c62c42fbemr1032789fac.6.1723194068464; Fri, 09 Aug 2024
 02:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1723189080.git.yong.huang@smartx.com>
 <7134ee3f7632b0454ef287301bda6c4faeb1d473.1723189080.git.yong.huang@smartx.com>
 <ZrXUhQjfwleNraRS@redhat.com>
In-Reply-To: <ZrXUhQjfwleNraRS@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 9 Aug 2024 17:00:52 +0800
Message-ID: <CAK9dgmaGnhZOYyqC1GUoGSiep6jB+Dn5Z+9Xj8HV85sU85Ntxg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] tests/migration: Make initrd-stress.img built by
 default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000548d0d061f3c62db"
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000548d0d061f3c62db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:34=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Fri, Aug 09, 2024 at 03:43:33PM +0800, yong.huang@smartx.com wrote:
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > The initrd-stress.img was compiled by specifying the
> > target, to make it easier for developers to play the
> > guestperf tool, make it built by default.
>
> If you're going to do this, then you will need to make sure it is only
> built on a Linux host, and when glib static & sysprof are found. eg
>
>   if host_os =3D=3D 'linux' && glib_static.found() && sysprof.found()


Ok, thanks for the comments, I'll add the check in the next version.


>
>
>
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  tests/migration/meson.build | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/migration/meson.build b/tests/migration/meson.build
> > index a91aa61c65..393e401800 100644
> > --- a/tests/migration/meson.build
> > +++ b/tests/migration/meson.build
> > @@ -7,12 +7,13 @@ stress =3D executable(
> >    files('stress.c'),
> >    dependencies: [glib_static, sysprof],
> >    link_args: ['-static'],
> > -  build_by_default: false,
> > +  build_by_default: true,
> >  )
> >
> >  custom_target(
> >    'initrd-stress.img',
> >    output: 'initrd-stress.img',
> >    input: stress,
> > -  command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@']
> > +  command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@'],
> > +  build_by_default: true,
> >  )
> > --
> > 2.11.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
Best regards

--000000000000548d0d061f3c62db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 9, 202=
4 at 4:34=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange=
@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Fri, Aug 09, 2024 at 03:43:33PM +0800, <a href=3D"mailto:yong.huang@smar=
tx.com" target=3D"_blank">yong.huang@smartx.com</a> wrote:<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; The initrd-stress.img was compiled by specifying the<br>
&gt; target, to make it easier for developers to play the<br>
&gt; guestperf tool, make it built by default.<br>
<br>
If you&#39;re going to do this, then you will need to make sure it is only<=
br>
built on a Linux host, and when glib static &amp; sysprof are found. eg<br>
<br>
=C2=A0 if host_os =3D=3D &#39;linux&#39; &amp;&amp; glib_static.found() &am=
p;&amp; sysprof.found()</blockquote><div><br></div><div><div style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Ok, th=
anks for the comments, I&#39;ll add the check in the next version.</div></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-colo=
r:rgb(204,204,204);padding-left:1ex">=C2=A0<br></blockquote><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex=
">
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/migration/meson.build | 5 +++--<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/migration/meson.build b/tests/migration/meson.build=
<br>
&gt; index a91aa61c65..393e401800 100644<br>
&gt; --- a/tests/migration/meson.build<br>
&gt; +++ b/tests/migration/meson.build<br>
&gt; @@ -7,12 +7,13 @@ stress =3D executable(<br>
&gt;=C2=A0 =C2=A0 files(&#39;stress.c&#39;),<br>
&gt;=C2=A0 =C2=A0 dependencies: [glib_static, sysprof],<br>
&gt;=C2=A0 =C2=A0 link_args: [&#39;-static&#39;],<br>
&gt; -=C2=A0 build_by_default: false,<br>
&gt; +=C2=A0 build_by_default: true,<br>
&gt;=C2=A0 )<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 custom_target(<br>
&gt;=C2=A0 =C2=A0 &#39;initrd-stress.img&#39;,<br>
&gt;=C2=A0 =C2=A0 output: &#39;initrd-stress.img&#39;,<br>
&gt;=C2=A0 =C2=A0 input: stress,<br>
&gt; -=C2=A0 command: [find_program(&#39;initrd-stress.sh&#39;), &#39;@OUTP=
UT@&#39;, &#39;@INPUT@&#39;]<br>
&gt; +=C2=A0 command: [find_program(&#39;initrd-stress.sh&#39;), &#39;@OUTP=
UT@&#39;, &#39;@INPUT@&#39;],<br>
&gt; +=C2=A0 build_by_default: true,<br>
&gt;=C2=A0 )<br>
&gt; -- <br>
&gt; 2.11.0<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000548d0d061f3c62db--

