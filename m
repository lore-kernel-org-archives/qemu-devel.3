Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E4DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC3o-00055l-TH; Wed, 14 May 2025 09:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uFBy9-0007lZ-Tp; Wed, 14 May 2025 09:16:22 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uFBy6-0002bL-K9; Wed, 14 May 2025 09:16:20 -0400
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b2325c56ebdso5718791a12.1; 
 Wed, 14 May 2025 06:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747228575; x=1747833375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BC6736sHMTaOSi7YQSSykMWxb+O1DJ2Dg8riyoBLr0s=;
 b=dzrN2zEdj111vu5mOBpojzZWLAyrcdZ31PYMfHE8Y/jljWAKA45rjLb2BK0R04tdoS
 EqjKGomqutsvBn0zACCl5sR40O7l/CAjuF+rQXV1QwDY5EhILH/ApyXG+ceODLzKJLiP
 tSlHzl+/p+1zL7Tqpyu1HJjHPmdwkWCS5geWGOjLWYxXhwXfBlLHA56pGlr7P23pMUhQ
 Awz2AUsco0j4rTCyhS3dhJA0QUVrj7NWhbIlKTFLrjqvSk75rrVwR51VRTOq5a650gub
 wg8uQ6Dk4ixVnowRYuZoBSssNXIdq6PyCITDhn1Fnf1p+ZvA2jwCNzbTG+rnUE1u0jsG
 nuNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuktOc11wjCVTmA79jSApAnL3kpwwfVZMS+aLdG+Zx4CwKxM8y4brHTnf0JWUDsG84F4nTfJ4CmBY=@nongnu.org
X-Gm-Message-State: AOJu0Yy58mRy8Depglzo5bENX4qrM+KA1ln6qVZEK9uERKDumKxZ5CoL
 xifjBTN5vV9prME6SUV3+qvaraoXFuP28GcKNM2iBzTU5fL6Wa7AjfUqYjooDUtrXRDjXqJwjrP
 QUgVcgi3Krenw5zOmXtCxekJ5fd8=
X-Gm-Gg: ASbGnctECfiYBMWwb7ywviV/Hw26SNP14UI4fOsYVqTTNUS+hPtGzt3Q/PB4EHsRDkm
 K4y3eS8aLKRVCYPTWEg2tQb/U7yvcH4Idas24bjR5AghMEYAZOOE0vo7XNCAdx3lHJImCrn22+S
 fLr4unXtIfb4yOJg0YlHdmYzAqKWgn5Fijog==
X-Google-Smtp-Source: AGHT+IFMG2XKNa4+3LTzMdrKymyLYu77xXGXJpgzbziSKR83hyb6XIwsg10gjsczLI6vnBXyQddS8Kz720GqOZKUYSY=
X-Received: by 2002:a17:903:198e:b0:231:7399:7db8 with SMTP id
 d9443c01a7336-231980bbe87mr45797755ad.7.1747228574735; Wed, 14 May 2025
 06:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <CAAjaMXZhq_uv-w_9TT3++HAcO7r_OhriJA0RKWs8YqY_ryjK4w@mail.gmail.com>
 <7101782c-f642-41e6-8f3a-7061ca722c99@gnu.org>
 <CAAjaMXbLUG1jsDZVcwKQV5+UfaCZUWTi4o5KFNJRowLbQ67yqQ@mail.gmail.com>
In-Reply-To: <CAAjaMXbLUG1jsDZVcwKQV5+UfaCZUWTi4o5KFNJRowLbQ67yqQ@mail.gmail.com>
From: Paolo Bonzini <bonzini@gnu.org>
Date: Wed, 14 May 2025 09:16:03 -0400
X-Gm-Features: AX0GCFtBJLgvF7v0FOLg3LPjtiB4RqQTwVWBpkLtzQgyPp2pwyffy6qUkeT0jTI
Message-ID: <CAHFMJ7tJ0ArHvA3kaJ=8CqGdQX3eTacX9TRrJdoLJGeqbhrk+A@mail.gmail.com>
Subject: Re: Rust in QEMU update, April 2025
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000089e2240635185a51"
Received-SPF: pass client-ip=209.85.215.175;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-pg1-f175.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--00000000000089e2240635185a51
Content-Type: text/plain; charset="UTF-8"

Il mar 6 mag 2025, 04:41 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
ha scritto:

> > It's not about hot paths, it's more that 1) you cannot use From/Into in
> > a "static"'s initializer 2) bilge relies a lot on non-const methods in
> > its internal implementation, which makes it quite messy to use it in
> > some places.  See for example this thing for which I take all the blame:
>
> Yeah it's not nice that we can't use it in static/const initializers. [...]

It has its pros and cons that's for sure... there are many crates that
> let you define typed bitfields, I haven't looked into the current
> state of the art lately. We should definitely move on to something
> better if it exists now or in the future.
>

I tried using bitfield-struct. The definitions are a bit less polished than
bilge but usage is the same, it is const friendly and has fewer
dependencies. I don't think there's one that's clearly better, but we can
look at the tradeoffs and decide.

To streamline expressions on bit flags maybe we could have a macro like
bits!(Interrupt: RX | TX) which expands to
Interrupt.RX.union(Interrupt.TX), where union() is a const function
(likewise for & or !). This should not be hard to write as a procedural
macro, it's just a recursive descent parser.

Oops, I forgot I had archived it because I moved development to
> https://gitlab.com/epilys/qemu . I made it public again. Bear in mind
> this was a WIP, basically my git stash but committed.
>

Understood. The nice thing to have would be to automatically derive the
PropertyInfo from the type of the field.

Paolo

> BTW, if you need it to model reflection better I think it is acceptable
> > to assume const_refs_to_static is present.
> >
> > Paolo
>
>

--00000000000089e2240635185a51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 6 mag 2025, 04:41 Manos P=
itsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org">manos.pi=
tsidianakis@linaro.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
&gt; It&#39;s not about hot paths, it&#39;s more that 1) you cannot use Fro=
m/Into in<br>
&gt; a &quot;static&quot;&#39;s initializer 2) bilge relies a lot on non-co=
nst methods in<br>
&gt; its internal implementation, which makes it quite messy to use it in<b=
r>
&gt; some places.=C2=A0 See for example this thing for which I take all the=
 blame:<br>
<br>
Yeah it&#39;s not nice that we can&#39;t use it in static/const initializer=
s. [...]</blockquote></div></div><div dir=3D"auto"><div class=3D"gmail_quot=
e gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">It has its pros and=
 cons that&#39;s for sure... there are many crates that<br>
let you define typed bitfields, I haven&#39;t looked into the current<br>
state of the art lately. We should definitely move on to something<br>
better if it exists now or in the future.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">I tried using bitfield-struct. The=
 definitions are a bit less polished than bilge but usage is the same, it i=
s const friendly and has fewer dependencies. I don&#39;t think there&#39;s =
one that&#39;s clearly better, but we can look at the tradeoffs and decide.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">To streamline expressio=
ns on bit flags maybe we could have a macro like bits!(Interrupt: RX | TX) =
which expands to Interrupt.RX.union(Interrupt.TX), where union() is a const=
 function (likewise for &amp; or !). This should not be hard to write as a =
procedural macro, it&#39;s just a recursive descent parser.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Oops, I forgot I had archived it=
 because I moved development to<br>
<a href=3D"https://gitlab.com/epilys/qemu" rel=3D"noreferrer noreferrer" ta=
rget=3D"_blank">https://gitlab.com/epilys/qemu</a> . I made it public again=
. Bear in mind<br>
this was a WIP, basically my git stash but committed.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Understood. The nice t=
hing to have would be to automatically derive the PropertyInfo from the typ=
e of the field.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; BTW, if you need=
 it to model reflection better I think it is acceptable<br>
&gt; to assume const_refs_to_static is present.<br>
&gt;<br>
&gt; Paolo<br>
<br>
</blockquote></div></div></div>

--00000000000089e2240635185a51--

