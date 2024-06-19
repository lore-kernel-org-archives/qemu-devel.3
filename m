Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A19FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJz2A-000074-Ii; Wed, 19 Jun 2024 13:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJz27-00006c-Tu
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJz25-0002XX-QM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718817820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F0wVpxlu+qFoJoFo4MR0VgoODgRh/e/nO0X7+FgRALU=;
 b=h+5ITTrY/eqSCZ91juB8BzPQE5HQ1nID2ThwStBMOq0oVxV8UeYI0RdHFHF6JrCTIUzkbs
 9Zte88ekSPPJUOYWvR1rNeXbdc1hRCZUNeREGY6gUsuc4rMyBh/j09gSL2GzzARwL2qg82
 H//j6c5kKCgvEnRQnFyMNzuQv9MEtII=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-htH99EBxOPWRcNU4KyncTQ-1; Wed, 19 Jun 2024 13:23:32 -0400
X-MC-Unique: htH99EBxOPWRcNU4KyncTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421e17ae038so426905e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718817810; x=1719422610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0wVpxlu+qFoJoFo4MR0VgoODgRh/e/nO0X7+FgRALU=;
 b=Xkp55naQcxdW/QRQd+VPzBN+WyPhaZOj/4504Y4qBizjxrFbQ+BdA7SZv/18TWhosw
 ZIyRVQ1Q0P5ysKmse7SRit1n/bYSMKaESVuHDcGTSaRh8lJeGnul4UxV6lj8AemU7P+G
 m+HcL0ora7mlmu/njj4FcOUM24LWcCRxqU9eJjiskCrfhtsF/LShT5CZhPTIAZQ0QXff
 KzIarszrGXYhiPRs42329l+o1wb4GzwXMrclAvRAgJoAfKccuWavHgItuS1NbBuCiQzZ
 QAr0VE3q5CkrnSPVfGDo0XbLBay9NFeRkuz1Jy8+vbV6FWucAaicA10dvfxTBsBbS58S
 hSaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVsa4kzOGkJa9lIb83YlwbZ1Q0hdLXwTWzXQoVK2wf5ac0C2mPHNprscuqXbeuxYHp24n1+nrLtvW/n5brT2TtcaTONrI=
X-Gm-Message-State: AOJu0YwJ814FIT1k8YdLV4QiXC9tqyrJ6aQYJTyJBqlpkqzvRj/s5RHt
 le2gk1fJnLStuQ0NwTluyrP98G/d770fkYv+SJbhuKIaBtBMFZgssHDpZNM/SJ0plWjXSsgAVKP
 ZeFMe8QYgTzBeJ53uypLuvKA7KyYTmCq6wp6oaOKhCIAaqHEDP+4qvsh5Bb+pcVQQ57LVx+EkpB
 Au+8gPkvTJAiaunSFMkDD3XWIGcT0=
X-Received: by 2002:adf:cf07:0:b0:364:7de:d70 with SMTP id
 ffacd0b85a97d-36407de0dcamr1154808f8f.29.1718817810374; 
 Wed, 19 Jun 2024 10:23:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENbH/KzYdqqQAlmLDUCAPHrWxR0ZE4inMtugROoSz7O5uiUzs91VS7mH5rl9spIeBP+BNvu1bR5Rxw5i+MDW4=
X-Received: by 2002:adf:cf07:0:b0:364:7de:d70 with SMTP id
 ffacd0b85a97d-36407de0dcamr1154800f8f.29.1718817809951; 
 Wed, 19 Jun 2024 10:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <0841ddd2-d962-4f1d-a818-be9a1ec4d9bf@linaro.org>
 <1c53f8d2-3b33-404c-bb1c-38475087d7ae@redhat.com>
 <ZnMNQJ23hC2OyGtT@redhat.com>
In-Reply-To: <ZnMNQJ23hC2OyGtT@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Jun 2024 19:23:18 +0200
Message-ID: <CABgObfZosvvGczJ2AAgPia1viCosnvd+++m+sdKYf0WEGYLVxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ff05ec061b417434"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000ff05ec061b417434
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 19 giu 2024, 18:54 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> >    build/
> >      rust/
> >        .cargo/
> >          config.toml   # generated by configure or meson.build
> >        Cargo.toml      # workspace generated by configure or meson.buil=
d
> >        Cargo.lock      # can be either linked to srctree or generated
> >        qemu/           # symlink to srctree/rust/qemu
> >        aarch64-softmmu-hw/
> >          Cargo.toml    # generated by meson.build (*)
> >          src/          # symlink to srctree/rust/hw/
> >        i386-softmmu-hw/
> >          Cargo.toml    # generated by meson.build
> >          src/          # symlink to srctree/rust/hw/
> >        generated/      # files generated by rust/generated/meson.build
>
> If we're generating a build tree to invoke cargo on, can we then
> avoid creating a completely separate dir hierarchy in the source
> tree rooted at /rust, and just have rust source within our existing
> hierarchy.
>

Maybe... I hadn't even considered the possibility of having a single cargo
invocation (and thus a cargo workspace in the build tree) until Richard
pointed out the duplication in configuration files.

I suppose you could just link rust/aarch64-softmmu-hw to srctree/hw, and
have a srctree/hw/lib.rs file in there to prime the search for submodules.

I think the resulting hierarchy would feel a little foreign though. Without
seeing the code I can't judge but my impression is that, if we wanted to go
that way, I would also move all C code under src/. Perhaps we can consider
such a unification later, once we have more experience, but for now keep
Rust and C code separate?

Paolo



> eg
>
>         aarch64-softmmu-hw/
>           Cargo.toml    # generated by meson.build (*)
>           src/
>             pl011/      # symlink to srctree/hw/p1011/
>
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

--000000000000ff05ec061b417434
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 19 giu 2024, 18:54 Daniel P. Berrang=C3=A9 &lt;=
<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; ha scrit=
to:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 build/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 rust/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cargo/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config.toml=C2=A0 =C2=A0# generated =
by configure or meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Cargo.toml=C2=A0 =C2=A0 =C2=A0 # workspace =
generated by configure or meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Cargo.lock=C2=A0 =C2=A0 =C2=A0 # can be eit=
her linked to srctree or generated<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0# symlink to srctree/rust/qemu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64-softmmu-hw/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cargo.toml=C2=A0 =C2=A0 # generated =
by meson.build (*)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 # symlink to srctree/rust/hw/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 i386-softmmu-hw/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cargo.toml=C2=A0 =C2=A0 # generated =
by meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 # symlink to srctree/rust/hw/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 generated/=C2=A0 =C2=A0 =C2=A0 # files gene=
rated by rust/generated/meson.build<br>
<br>
If we&#39;re generating a build tree to invoke cargo on, can we then<br>
avoid creating a completely separate dir hierarchy in the source<br>
tree rooted at /rust, and just have rust source within our existing<br>
hierarchy.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Maybe... I hadn&#39;t even considered the possibility of having a=
 single cargo invocation (and thus a cargo workspace in the build tree) unt=
il Richard pointed out the duplication in configuration files.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">I suppose you could just link rust/a=
arch64-softmmu-hw to srctree/hw, and have a srctree/hw/<a href=3D"http://li=
b.rs">lib.rs</a> file in there to prime the search for submodules.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">I think the resulting hierarchy =
would feel a little foreign though. Without seeing the code I can&#39;t jud=
ge but my impression is that, if we wanted to go that way, I would also mov=
e all C code under src/. Perhaps we can consider such a unification later, =
once we have more experience, but for now keep Rust and C code separate?</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
eg<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64-softmmu-hw/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cargo.toml=C2=A0 =C2=A0 # generated by m=
eson.build (*)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pl011/=C2=A0 =C2=A0 =C2=A0 # syml=
ink to srctree/hw/p1011/<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000ff05ec061b417434--


