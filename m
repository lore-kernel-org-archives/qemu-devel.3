Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A3C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 16:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLmff-0005a2-GG; Mon, 24 Jun 2024 12:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLmfe-0005Zi-52
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 12:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLmfW-0004ys-PC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 12:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719246949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Meivl4Agu7d29WsADN49B9HDfoVc4uC6eggOyBtWcGk=;
 b=C8Ny/SnEyuD0uSeOZJpA8IJWH480yZE7cFkoQkWRak/fswxY0qSOi/6MvyrZuPmwLQ1H94
 IX6ALlRdz59SYORCRxTJbaDAxv6a5OewodjPqrGXmkcuEVsQsejqRnl88mVDvqvzlt7+IE
 72jiUdmcEZ3CX+R7VrZNzqr06rH/R4E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-3gXz9UMqNvqZan8yM0bkaA-1; Mon, 24 Jun 2024 12:35:45 -0400
X-MC-Unique: 3gXz9UMqNvqZan8yM0bkaA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-363542774e1so3713468f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 09:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719246944; x=1719851744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Meivl4Agu7d29WsADN49B9HDfoVc4uC6eggOyBtWcGk=;
 b=tcRJHYwHN1I2/INspucFgScDyZpQ7m6k4lIDOy+Kcktp9jBZ+L0x/Ef3niyNERhesz
 pKyStVAlU8tOWM1EFY7UnxILYeLhmKpKiR3WV2dQrAyHcwuTXOLHgrnDQqFcNnexQ9jY
 GyrfoEl+WzdwvhCIjU2PRnmY7L0dcZjLpdWPl5YH19UW5+Lj8tdrasl+o4R8IbMUR3rV
 rO6RCLyoj9VIkQef54MqXPzhbGzbt475nvRRSc5BNxj043hgelpQKkRBYnJUNk0rkMng
 6isH3P/ic1W4NwfnTZtbHLnFwr9KsZqiNIAuHzsSOGDB+303eevuCtBO+vhfAY9XSFMc
 Q53A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIfeyBCi+kk6ef3tRdSQnTypnZE7yOxRdCdCgVCwq9Cga4/E8+TSNJoxZ+a/9pCQNMex8SgXD2G2DX5qVGzfg2O3FhcwY=
X-Gm-Message-State: AOJu0Yw6aPw/op1OE6ZgNAnx13GF6km9gjHw4KV+P6e1wWfXtZQjFp9m
 HZedjF7nfyNocWUWR16FCvEygwMd1FpTK290XoRhN3Vp/nndXgcvdn8A9mdvWxF2+XPr4NVgMxI
 HDnMgyp72QS6cLiYx2fP9wSj0czZvQJB2X9+ulDja9ouatNS0MzU5JX1qqFTB8mNCJ7lj8caG58
 FMFeD6apZDB9mouVji+bqPqNFyPnA=
X-Received: by 2002:a05:6000:1847:b0:366:eba0:8d8c with SMTP id
 ffacd0b85a97d-366eba08d93mr4940193f8f.54.1719246944210; 
 Mon, 24 Jun 2024 09:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz7huzo+HcNwTRYqAtMGx96rZvu7zEcosz/B1azQBp7Ms2cvDehzb8qzMNubVzoaCgr2gSv/zSstpCiC+KySw=
X-Received: by 2002:a05:6000:1847:b0:366:eba0:8d8c with SMTP id
 ffacd0b85a97d-366eba08d93mr4940161f8f.54.1719246943905; Mon, 24 Jun 2024
 09:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ae1397b5-4154-4aeb-bf5f-3a62adcc05fd@redhat.com> <ZnkzpBUQMMGTgQlL@intel.com>
In-Reply-To: <ZnkzpBUQMMGTgQlL@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 24 Jun 2024 18:35:33 +0200
Message-ID: <CABgObfaJ3MzG-G+4+gwRO5oTwPV1ma0Yxce-RJrWEqzhv1jG=g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 rowan.hart@intel.com, Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005f86b3061ba55ffe"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000005f86b3061ba55ffe
Content-Type: text/plain; charset="UTF-8"

Il lun 24 giu 2024, 10:36 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> [snip]
>
> > diff --git a/meson.build b/meson.build
> > index c5360fbd299..ad7dbc0d641 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -290,6 +290,11 @@ foreach lang : all_languages
> >    endif
> >  endforeach
> > +cargo = not_found
> > +if 'RUST_TARGET_TRIPLE' in config_host
> > +  cargo = find_program('cargo', required: true)
> > +endif
> > +
>
> As with the original Manos version, it looks like there's no need to
> check cargo here? Since patch 2 checks cargo and others in
> rust/meson.build.
>
> Otherwise, cargo was checked twice.
>

Yes, I would check it here though because it's used in the summary, already
in this patch.

Paolo


> >  # default flags for all hosts
> >  # We use -fwrapv to tell the compiler that we require a C dialect where
> >  # left shift of signed integers is well defined and has the expected
> > @@ -4239,6 +4244,10 @@ if 'objc' in all_languages
> >  else
> >    summary_info += {'Objective-C compiler': false}
> >  endif
> > +summary_info += {'Rust support':      cargo.found()}
> > +if cargo.found() and config_host['RUST_TARGET_TRIPLE']) !=
> config_host['RUST_HOST_TRIPLE']
> > +  summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
> > +endif
> >  option_cflags = (get_option('debug') ? ['-g'] : [])
> >  if get_option('optimization') != 'plain'
> >    option_cflags += ['-O' + get_option('optimization')]
> >
> >
>
>

--0000000000005f86b3061ba55ffe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 24 giu 2024, 10:36 Zhao Liu &lt;<a href=3D"mail=
to:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha scritto:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">[snip]<br>
<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index c5360fbd299..ad7dbc0d641 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -290,6 +290,11 @@ foreach lang : all_languages<br>
&gt;=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 endforeach<br>
&gt; +cargo =3D not_found<br>
&gt; +if &#39;RUST_TARGET_TRIPLE&#39; in config_host<br>
&gt; +=C2=A0 cargo =3D find_program(&#39;cargo&#39;, required: true)<br>
&gt; +endif<br>
&gt; +<br>
<br>
As with the original Manos version, it looks like there&#39;s no need to<br=
>
check cargo here? Since patch 2 checks cargo and others in rust/meson.build=
.<br>
<br>
Otherwise, cargo was checked twice.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Yes, I would check it here though becaus=
e it&#39;s used in the summary, already in this patch.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt;=C2=A0 # default flags for all hosts<br>
&gt;=C2=A0 # We use -fwrapv to tell the compiler that we require a C dialec=
t where<br>
&gt;=C2=A0 # left shift of signed integers is well defined and has the expe=
cted<br>
&gt; @@ -4239,6 +4244,10 @@ if &#39;objc&#39; in all_languages<br>
&gt;=C2=A0 else<br>
&gt;=C2=A0 =C2=A0 summary_info +=3D {&#39;Objective-C compiler&#39;: false}=
<br>
&gt;=C2=A0 endif<br>
&gt; +summary_info +=3D {&#39;Rust support&#39;:=C2=A0 =C2=A0 =C2=A0 cargo.=
found()}<br>
&gt; +if cargo.found() and config_host[&#39;RUST_TARGET_TRIPLE&#39;]) !=3D =
config_host[&#39;RUST_HOST_TRIPLE&#39;]<br>
&gt; +=C2=A0 summary_info +=3D {&#39;Rust target&#39;:=C2=A0 =C2=A0 =C2=A0c=
onfig_host[&#39;RUST_TARGET_TRIPLE&#39;]}<br>
&gt; +endif<br>
&gt;=C2=A0 option_cflags =3D (get_option(&#39;debug&#39;) ? [&#39;-g&#39;] =
: [])<br>
&gt;=C2=A0 if get_option(&#39;optimization&#39;) !=3D &#39;plain&#39;<br>
&gt;=C2=A0 =C2=A0 option_cflags +=3D [&#39;-O&#39; + get_option(&#39;optimi=
zation&#39;)]<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000005f86b3061ba55ffe--


