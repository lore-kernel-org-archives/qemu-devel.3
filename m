Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E74DC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBRv-0001ev-MK; Thu, 06 Mar 2025 08:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqBRn-0001co-Jk
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqBRi-000516-Hy
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741268368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8z/Rkxwhtt5fxe9+b7koLxUU4cNkHHRA2mP3H5ac/Fs=;
 b=KI4B8Ed0CTuytURDAEJizXgHx478PUKDPXz482nl75me+6u1T1ktss0ThDLZ3vYErzvVTx
 a7r/jQ+OKKUaPW4vzh386Ph8gGLL+IUknbsCjuYrWKOmX6E/m2z8a6fb++/VJ8Y8rRsPx7
 YjNowjqeGecJhA4YY2S6ytIEOv9Rq60=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-aRUb-CgtP--_Se_6L2E2oQ-1; Thu, 06 Mar 2025 08:39:13 -0500
X-MC-Unique: aRUb-CgtP--_Se_6L2E2oQ-1
X-Mimecast-MFC-AGG-ID: aRUb-CgtP--_Se_6L2E2oQ_1741268352
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390e5214efdso449243f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 05:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741268352; x=1741873152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8z/Rkxwhtt5fxe9+b7koLxUU4cNkHHRA2mP3H5ac/Fs=;
 b=erMxujOrt9sAWKN6wQSR2HoBHvmQXdJk/y/m2R72b6U8ag1BqVnR7cWJGFQB/2uPM+
 hD9YMC7Z7Znu99ONeTCaTicSgulcsVFq7CzZzPR0LoB63mBYaXmUJWEg8ol73kfMSXB+
 ve5l/fUPxiOq+tEa9PnFq29Mi/riJ1PDna+pySsSdhA4N5eh+B7R64yCVpZotBDfeH7u
 Spk73I7pjBnROauNT/teqzBaTz6pLZp4U3iGK7zdwpki1o3d4sxpfhJN9+rvVpjQFCj0
 DMZG4YUTjwB3rcAKl6UVmbc7Q6uBlWklBt5eeKjMtlPHd4HXer3kR0osarxFh7qXLSx1
 yj+g==
X-Gm-Message-State: AOJu0Yz+KzP2bYF0eSyd906x/mZvS6jLhfp7sd+CCiQuryUFxlEMWnmD
 ZH/qXuPpT/zL/J+VltCxKJz0mycM+e0I9KSVkwQvzer8RLu0T/s4K0s1p0qCAMIYJa+pLUyvT+W
 OLBd+0yljgTRMXfSW3fT7AMt8+5gZcK8U5OHnV6P1986ZpOjSRLxdKZ8C0zlbQBgbvcfVFcTAsK
 obyj6k2aQ3IJSKAK1NHaoOWW34SUw=
X-Gm-Gg: ASbGncvpy8SEI7bk0B9zl6x5MpMj0tBu+07785XAM7+McjdVP/oMzB+TiXNfE4sfJYD
 j1CoJ/GUXwpGWWJRL5bPy0axm19siRKOVcj8NVk5Dm6M7GG/P3GBhgjlM8baYHHbxLJM9AXJa
X-Received: by 2002:a05:6000:4028:b0:38f:4b15:32fc with SMTP id
 ffacd0b85a97d-3911f720027mr6443493f8f.8.1741268352469; 
 Thu, 06 Mar 2025 05:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM+gFoapbVXAWFJktBWSomLserYbqBHvTAynD1s4ePlWvqbvuovA2EqlCK1SkkB3tYjq2zf7sZb2G1GOcMyHk=
X-Received: by 2002:a05:6000:4028:b0:38f:4b15:32fc with SMTP id
 ffacd0b85a97d-3911f720027mr6443473f8f.8.1741268352066; Thu, 06 Mar 2025
 05:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20250306105306.2064458-1-alex.bennee@linaro.org>
 <CABgObfZpf7Oki+0rH-3OTBLF_cW8+5e-jAaG=AU58oAn8CP=5w@mail.gmail.com>
 <877c524agm.fsf@draig.linaro.org>
In-Reply-To: <877c524agm.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Mar 2025 14:38:59 +0100
X-Gm-Features: AQ5f1Jqdx56ZsY0z3ZV8aI1Y4ucbPc67SFfFmrL2O754933-Vx9JxE8q_FEtecc
Message-ID: <CABgObfbJz3ctqJ=pidb=gRxspwfnXMY9dtD0QYSwcjP6A-BQJw@mail.gmail.com>
Subject: Re: [PATCH v2] meson.build: default to -gsplit-dwarf for debug info
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009581de062faca1bb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000009581de062faca1bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 6 mar 2025, 13:20 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scrit=
to:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Il gio 6 mar 2025, 11:53 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha
> scritto:
> >
> >  -option_cflags =3D (get_option('debug') ? ['-g'] : [])
> >  +option_cflags =3D []
> >  +if get_option('debug')
> >  +  option_cflags +=3D get_option('split_debug') ? ['-gsplit-dwarf'] :
> ['-g']
> >  +endif
> >
> > option_cflags does nothing, it's only for clarity in the final summary.
> So you need
> >
> > if get_option('debug') and get_option('split_debug')
> >   qemu_cflags +=3D '-gsplit-dwarf'
> > endif
>
> Should I update the optimization field as well? is this the reason why I
> wasn't seeing changes occur for the tests that meson builds?
>

I am not sure what you mean by optimization field; anyway, qemu_cflags
applies to all C sources and qemu_ldflags to all programs linked with the C
compiler. As I understand it, '-gsplit-dwarf' should go in qemu_cflags.

Paolo


> >
> > (I wonder if it should be implemented in meson instead... It should be
> beneficial for other projects surely).
> >
> > Paolo
> >
> >   if get_option('optimization') !=3D 'plain'
> >     option_cflags +=3D ['-O' + get_option('optimization')]
> >   endif
> >  diff --git a/meson_options.txt b/meson_options.txt
> >  index 59d973bca0..3432123fee 100644
> >  --- a/meson_options.txt
> >  +++ b/meson_options.txt
> >  @@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: fals=
e,
> >          description: 'mutex debugging support')
> >   option('debug_stack_usage', type: 'boolean', value: false,
> >          description: 'measure coroutine stack usage')
> >  +option('split_debug', type: 'boolean', value: true,
> >  +       description: 'split debug info from object files')
> >   option('qom_cast_debug', type: 'boolean', value: true,
> >          description: 'cast debugging support')
> >   option('slirp_smbd', type : 'feature', value : 'auto',
> >  diff --git a/scripts/meson-buildoptions.sh
> b/scripts/meson-buildoptions.sh
> >  index 3e8e00852b..aca6e68830 100644
> >  --- a/scripts/meson-buildoptions.sh
> >  +++ b/scripts/meson-buildoptions.sh
> >  @@ -504,6 +504,8 @@ _meson_option_parse() {
> >       --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=3Dfa=
lse
> ;;
> >       --enable-strip) printf "%s" -Dstrip=3Dtrue ;;
> >       --disable-strip) printf "%s" -Dstrip=3Dfalse ;;
> >  +    --enable-split-debug) printf "%s" -Dsplit_debug=3Dtrue ;;
> >  +    --disable-split-debug) printf "%s" -Dsplit_debug=3Dfalse ;;
> >       --sysconfdir=3D*) quote_sh "-Dsysconfdir=3D$2" ;;
> >       --enable-tcg) printf "%s" -Dtcg=3Denabled ;;
> >       --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
> >  --
> >  2.39.5
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--0000000000009581de062faca1bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 6 mar 2025, 13:20 Alex Be=
nn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.=
org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; Il gio 6 mar 2025, 11:53 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.b=
ennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.o=
rg</a>&gt; ha scritto:<br>
&gt;<br>
&gt;=C2=A0 -option_cflags =3D (get_option(&#39;debug&#39;) ? [&#39;-g&#39;]=
 : [])<br>
&gt;=C2=A0 +option_cflags =3D []<br>
&gt;=C2=A0 +if get_option(&#39;debug&#39;)<br>
&gt;=C2=A0 +=C2=A0 option_cflags +=3D get_option(&#39;split_debug&#39;) ? [=
&#39;-gsplit-dwarf&#39;] : [&#39;-g&#39;]<br>
&gt;=C2=A0 +endif<br>
&gt;<br>
&gt; option_cflags does nothing, it&#39;s only for clarity in the final sum=
mary. So you need<br>
&gt;<br>
&gt; if get_option(&#39;debug&#39;) and get_option(&#39;split_debug&#39;)<b=
r>
&gt;=C2=A0 =C2=A0qemu_cflags +=3D &#39;-gsplit-dwarf&#39;<br>
&gt; endif<br>
<br>
Should I update the optimization field as well? is this the reason why I<br=
>
wasn&#39;t seeing changes occur for the tests that meson builds?<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I am not su=
re what you mean by optimization field; anyway, qemu_cflags applies to all =
C sources and qemu_ldflags to all programs linked with the C compiler. As I=
 understand it, &#39;-gsplit-dwarf&#39; should go in qemu_cflags.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; (I wonder if it should be implemented in meson instead... It should be=
 beneficial for other projects surely).<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt;=C2=A0 =C2=A0if get_option(&#39;optimization&#39;) !=3D &#39;plain&#39;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0option_cflags +=3D [&#39;-O&#39; + get_option(&#39;=
optimization&#39;)]<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt;=C2=A0 diff --git a/meson_options.txt b/meson_options.txt<br>
&gt;=C2=A0 index 59d973bca0..3432123fee 100644<br>
&gt;=C2=A0 --- a/meson_options.txt<br>
&gt;=C2=A0 +++ b/meson_options.txt<br>
&gt;=C2=A0 @@ -362,6 +362,8 @@ option(&#39;debug_mutex&#39;, type: &#39;boo=
lean&#39;, value: false,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;mutex debugging su=
pport&#39;)<br>
&gt;=C2=A0 =C2=A0option(&#39;debug_stack_usage&#39;, type: &#39;boolean&#39=
;, value: false,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;measure coroutine =
stack usage&#39;)<br>
&gt;=C2=A0 +option(&#39;split_debug&#39;, type: &#39;boolean&#39;, value: t=
rue,<br>
&gt;=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;split debug info f=
rom object files&#39;)<br>
&gt;=C2=A0 =C2=A0option(&#39;qom_cast_debug&#39;, type: &#39;boolean&#39;, =
value: true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;cast debugging sup=
port&#39;)<br>
&gt;=C2=A0 =C2=A0option(&#39;slirp_smbd&#39;, type : &#39;feature&#39;, val=
ue : &#39;auto&#39;,<br>
&gt;=C2=A0 diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-build=
options.sh<br>
&gt;=C2=A0 index 3e8e00852b..aca6e68830 100644<br>
&gt;=C2=A0 --- a/scripts/meson-buildoptions.sh<br>
&gt;=C2=A0 +++ b/scripts/meson-buildoptions.sh<br>
&gt;=C2=A0 @@ -504,6 +504,8 @@ _meson_option_parse() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-strict-rust-lints) printf &quot;%s=
&quot; -Dstrict_rust_lints=3Dfalse ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--enable-strip) printf &quot;%s&quot; -Dstri=
p=3Dtrue ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-strip) printf &quot;%s&quot; -Dstr=
ip=3Dfalse ;;<br>
&gt;=C2=A0 +=C2=A0 =C2=A0 --enable-split-debug) printf &quot;%s&quot; -Dspl=
it_debug=3Dtrue ;;<br>
&gt;=C2=A0 +=C2=A0 =C2=A0 --disable-split-debug) printf &quot;%s&quot; -Dsp=
lit_debug=3Dfalse ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--sysconfdir=3D*) quote_sh &quot;-Dsysconfdi=
r=3D$2&quot; ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--enable-tcg) printf &quot;%s&quot; -Dtcg=3D=
enabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-tcg) printf &quot;%s&quot; -Dtcg=
=3Ddisabled ;;<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 2.39.5<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div></div>

--0000000000009581de062faca1bb--


