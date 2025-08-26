Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6A9CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvP8-0006HC-3l; Tue, 26 Aug 2025 11:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uqvOw-0006Cd-Jw
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uqvOl-0004cS-Uc
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756221338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=apDad2bbnrJVF3oXeIECJ1Y0YLrfwQbQii/KbeCcQC8=;
 b=In/w++ai/8mkyz9+w8nlyJO2ZgJc4QiF4j42YonCw72XJrqV9/SZE5VKNirdMf3x5TsyQ5
 LAdamRbmVP1cxdhMZL2Nc9ssaxUA1KTWM5epdhpbXrdw0bm/zxtE16Ch3+iccnagJdVxFh
 WutNju+0P+O26axACcbrtQVJQ68JP5w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-uCCZpEObP4q32GIWqGEQug-1; Tue, 26 Aug 2025 11:15:34 -0400
X-MC-Unique: uCCZpEObP4q32GIWqGEQug-1
X-Mimecast-MFC-AGG-ID: uCCZpEObP4q32GIWqGEQug_1756221333
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-325ce1082bcso2412277a91.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 08:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756221333; x=1756826133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=apDad2bbnrJVF3oXeIECJ1Y0YLrfwQbQii/KbeCcQC8=;
 b=whmEyR5vLNrvP5N2VuPTwmuR29E/clYBgccCh0P/qV5WQgzufFQOdrINGUCWKJkYY2
 cLYZ2Ol5Fh7KG5rWE3c3v8dearFprXWOG+mXZKbgFkHQDshGsvZBqWSkgu25RC4qcmHD
 dpW3z8ctV9uKu2gjo3Z2iIoknG0ysQVGYrMPm6GrOOTAluu/1USCPxP9Ukn1etj4VJk5
 7O5DM6JbsGt7LIW9Gq4KetMbJufC34GHjPTlNAQnaDAkAlbEGajtRmN97Dr+b9MC97mP
 FR7/637G62IDqFUwsR8c0hiFKWG1clNwDSdgcUxnKSsRUmnHzvPBfk61eyrG4JF47e9l
 yKLA==
X-Gm-Message-State: AOJu0YwBVe14Dzv2otM9lxA5bQVPXALCniAgDjha5NTYO2Ao5FX9rD2h
 HpfQZWtu4wS78d0CgKU+mZJcFH2PoKJDCgc6RtFT9OY7pmeUv65qa2gWQkBMpWHIVwK4kvvPa1G
 Ibb1LeqKwZVeevAoEkoSL6w0a07rD8iMtmrF/2OPEk0yZD+fDH33wO0pnXI5DjNxw8IRFQP2YYc
 +roDquP6EPohf+G2GvbJIxur1ytlMToL8=
X-Gm-Gg: ASbGncvCQFAvy/uBEeNQFaKQvRzmqkjJVoXOy+IZNtHxdtSy++ZpkL5QNoNJzlK5nor
 5ps2Xnd8wq8pbit2E0i7JP4yJ9GlfFUB3oyhWMOAk+xFXv+ijsZt9Z/JZ/6bplqblyMEX0Xb61f
 uauSlwP8ynEOweyxh+S+o3zEMqilSww5iOqhNpU3i+xG18LxPsxuEaiw==
X-Received: by 2002:a17:90b:5627:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-32515eaafdcmr23655325a91.19.1756221333175; 
 Tue, 26 Aug 2025 08:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq8i93LR3ff0gxtxLBPX6/1s3s+GQ5Ml3ArL3vvR8jvI/jkVOzNQWfA/aCg3NwOl2RtfUsOBO2qMyw7/ilrAM=
X-Received: by 2002:a17:90b:5627:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-32515eaafdcmr23655255a91.19.1756221332411; Tue, 26 Aug 2025
 08:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <e58ea933-f941-44d8-8477-c8298663cc24@redhat.com>
In-Reply-To: <e58ea933-f941-44d8-8477-c8298663cc24@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 26 Aug 2025 19:15:21 +0400
X-Gm-Features: Ac12FXxbwuXqOT7ugEZ37qpRYFJOysdL_bpL1KsVr5pOzDYO4JWSPQYaafxdA-c
Message-ID: <CAMxuvazgnPAY76PA75t-rUBDHG5rpTQqa+UepizSAMo_0a5VWA@mail.gmail.com>
Subject: Re: [RFC 00/18] rust: split qemu-api
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-rust@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000aa6a5c063d462425"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000aa6a5c063d462425
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 26, 2025 at 6:44=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> On 8/26/25 16:04, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > qemu-api is providing bindings for various internal libraries. Instead,
> the
> > bindings requirements should match the various libraries and use the
> minimal set
> > of dependencies.
> >
> > An initial Rust-only "common" crate is introduced, then "util" (for
> libqemuutil,
> > without bql), "migration" (so it doesn't depend on bql), "bql", "qom"
> (arguably,
> > bql shouldn't be required?), and "chardev", "system", "hwcore". Finally
> the
> > qemu-api crates are renamed and repurposed.
> >
> > This involves a lot of code churn, so hopefully it can be reviewed and
> merged
> > early and iterated upon :)
>
> The one comment that I would like to handle before merging, is that I'd
> prefer to keep the preludes and, in fact, even add more exports to them
> since they can now be chosen per-crate.  Ideally, many of the crates
> you've crated would be accessed through many "use xyz::prelude::*"
> statements.
>

It's not very useful if you have to include all the preludes though :)

Also, prelude feels a bit too much magic and may pollute namespace. In
general, not so many crates provide them and that's usually a good thing
imho, since you can explicitly import what you need, and LSP and good error
report make that fairly trivial.

So, I am not convinced having each crate its own prelude is a good thing,
but I don't care much. Can easily be added back though.


>
> Also, if I understood correctly the split util/errno.rs can move to
> common/.  While it has a dependency on libc, it doesn't need bindgen.
>
>
True, I will move it


> There's a bunch of code duplication for the various bindings.rs and
> build.rs files, which is not ideal but shouldn't grow much more than
> this.  I wonder if, later, common code across build.rs could be written
> just once by adding a new crate (e.g. "qemu_meson") to the workspace,
> that can be used as a build-dependency.
>
>
I am not sure, but I can try. Alternatively, we can have a build.rs
symlink, if we can guess the module path.

--000000000000aa6a5c063d462425
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 26, 2=
025 at 6:44=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.=
com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On 8/26/25 16:04, <a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; qemu-api is providing bindings for various internal libraries. Instead=
, the<br>
&gt; bindings requirements should match the various libraries and use the m=
inimal set<br>
&gt; of dependencies.<br>
&gt; <br>
&gt; An initial Rust-only &quot;common&quot; crate is introduced, then &quo=
t;util&quot; (for libqemuutil,<br>
&gt; without bql), &quot;migration&quot; (so it doesn&#39;t depend on bql),=
 &quot;bql&quot;, &quot;qom&quot; (arguably,<br>
&gt; bql shouldn&#39;t be required?), and &quot;chardev&quot;, &quot;system=
&quot;, &quot;hwcore&quot;. Finally the<br>
&gt; qemu-api crates are renamed and repurposed.<br>
&gt; <br>
&gt; This involves a lot of code churn, so hopefully it can be reviewed and=
 merged<br>
&gt; early and iterated upon :)<br>
<br>
The one comment that I would like to handle before merging, is that I&#39;d=
 <br>
prefer to keep the preludes and, in fact, even add more exports to them <br=
>
since they can now be chosen per-crate.=C2=A0 Ideally, many of the crates <=
br>
you&#39;ve crated would be accessed through many &quot;use xyz::prelude::*&=
quot; <br>
statements.<br></blockquote><div><br></div><div>It&#39;s not very useful if=
 you have to include all the preludes though :)</div><div><br></div><div>Al=
so, prelude feels a bit too much magic and may pollute namespace. In genera=
l, not so many crates provide them and that&#39;s usually a good thing imho=
,=C2=A0since you can explicitly import what you need, and LSP and good erro=
r report make that fairly trivial.</div><div><br></div><div>So, I am not co=
nvinced having each crate its own prelude is a good thing, but I don&#39;t =
care much. Can easily be added back though.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
Also, if I understood correctly the split util/<a href=3D"http://errno.rs" =
rel=3D"noreferrer" target=3D"_blank">errno.rs</a> can move to <br>
common/.=C2=A0 While it has a dependency on libc, it doesn&#39;t need bindg=
en.<br>
<br></blockquote><div><br></div><div>True, I will move it</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
There&#39;s a bunch of code duplication for the various <a href=3D"http://b=
indings.rs" rel=3D"noreferrer" target=3D"_blank">bindings.rs</a> and <br>
<a href=3D"http://build.rs" rel=3D"noreferrer" target=3D"_blank">build.rs</=
a> files, which is not ideal but shouldn&#39;t grow much more than <br>
this.=C2=A0 I wonder if, later, common code across <a href=3D"http://build.=
rs" rel=3D"noreferrer" target=3D"_blank">build.rs</a> could be written <br>
just once by adding a new crate (e.g. &quot;qemu_meson&quot;) to the worksp=
ace, <br>
that can be used as a build-dependency.<br>
<br></blockquote><div><br></div><div>I am not sure, but I can try. Alternat=
ively, we can have a <a href=3D"http://build.rs">build.rs</a> symlink, if w=
e can guess the module path.</div></div></div>

--000000000000aa6a5c063d462425--


