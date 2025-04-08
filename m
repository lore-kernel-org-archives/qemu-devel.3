Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9719C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 21:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2GBb-0004Ow-LW; Tue, 08 Apr 2025 17:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2GBY-0004OB-AU
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 17:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2GBW-0002Wn-E9
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 17:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744146520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmwEdllYvQZrKPWM82RbtuVK/0oBP4xJWmm+4WZvaSQ=;
 b=as8tZvEE8fPQPxuHpai3Tt8E6nCeRV+f6AGmYVxtjmJf0f3YJtnIQSEgSsmFVZ2UPwKGCo
 bPvovJHLCKqPtnrIZl+zWA9PfrzZLhJBVY1akH60QZ+YgcW/f2loEqoYPxt40YvTC8Yx/7
 j+22ZXMjOFQiWvhJy1wBUcyt58zQuhA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-uJYUK80eM1a8mz9rbb2Zng-1; Tue, 08 Apr 2025 17:08:36 -0400
X-MC-Unique: uJYUK80eM1a8mz9rbb2Zng-1
X-Mimecast-MFC-AGG-ID: uJYUK80eM1a8mz9rbb2Zng_1744146515
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so2734292f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 14:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744146515; x=1744751315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DmwEdllYvQZrKPWM82RbtuVK/0oBP4xJWmm+4WZvaSQ=;
 b=qPn2RoVns7na6d7CegO0b3LTpPBo5s+T8LR3BR+aVjcaCs2IEx+rPiTZmr0QiOB1Fk
 O+hG8PsnJj4gtxkmf24C1szLqLVMFj9b0D8lhTlbkpkvpktDW5ov6RDa6MrXiVmbHs3d
 ypEqStOs8per+6g9h7SiqI9Rs9GmxnAz+d2cOuDRW5ow4rRIoc5X8lR7CzJkLEh19A5Y
 PYt84jnrEcT1JUS5bBuDD+dLINurygguL2/zPbjZL1mtOp3kNet60CQur+bGuT0yYpPP
 XmwkjqwXfeU11hszj5+voKRdIPdRUQvoE9udEklKui6eNK9zzP88Rz1NKZBgSrBuYcqP
 T3+w==
X-Gm-Message-State: AOJu0YzG/9iLHtVq49lSRp394E3GuE41lDf1PSPe7qBi8eG8mzTIZDMB
 bqvzxA/zV6/FnzwMONHmfnx/vDIEOmNeVy7AIGi64NoRyWzl7vUTDteVGsJnyB5HYDsgwXLSCOf
 oGgXcVhTxeFzR/noY9FUBr+ZqALUH0aF9AzZfouZr6S+heQXqM53MCbhJtaTHKX821BPaojPmBb
 PXHmS8uYVPUrTQlBYk4PL5OY7HZtA=
X-Gm-Gg: ASbGncul0KXXUChEV7e6RzQu3NekjxgcsofpIWraUYw8JKSO7U/HB+A2HOtsa7aNnBC
 mMfgCMhfdpJB9sWl1itP+FQZR5HwW7l88M/PT1YkBX3WkhkvhuINacCFZPwfyrOTX2z+PXVR1xw
 ==
X-Received: by 2002:a05:6000:2a9:b0:391:2ab1:d4b8 with SMTP id
 ffacd0b85a97d-39d88525f29mr132906f8f.1.1744146515042; 
 Tue, 08 Apr 2025 14:08:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGuKIknUMdLmuY0TQgtImt/b6sqKOlpl3gssEhek+HpClMUVf3Ic6HJ9wRHytTR8Qo2SQX3lLewYAs5zcNlok=
X-Received: by 2002:a05:6000:2a9:b0:391:2ab1:d4b8 with SMTP id
 ffacd0b85a97d-39d88525f29mr132895f8f.1.1744146514624; Tue, 08 Apr 2025
 14:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250405100603.253421-1-pbonzini@redhat.com>
 <0B9AB608-D9FE-4819-87DB-8B00F222F1C7@gmail.com>
In-Reply-To: <0B9AB608-D9FE-4819-87DB-8B00F222F1C7@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Apr 2025 23:08:23 +0200
X-Gm-Features: ATxdqUGESrymUeWKFLWdH3QXEgrYFAgM9-rE1c1geDWDwuD1UT6B6-MKnbBymyU
Message-ID: <CABgObfZjg8eZdPGY6RPR09oZ5U3n_ASFOLz2EPzT=Zm+vhMNmg@mail.gmail.com>
Subject: Re: [PATCH preview 0/3] rust: update build system for Meson 1.8.0
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000070e92606324ac1f0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000070e92606324ac1f0
Content-Type: text/plain; charset="UTF-8"

Il mar 8 apr 2025, 22:34 Bernhard Beschow <shentey@gmail.com> ha scritto:

>
>
> Am 5. April 2025 10:06:00 UTC schrieb Paolo Bonzini <pbonzini@redhat.com>:
> >Meson 1.7.0 and 1.8.0 include improved support for Rust, namely:
> >* support for "objects" in Rust executables
> >* support for doctest targets
>
> Using Meson 1.7.2 (shipped with my distro) I didn't succeed with either of
> these. If just applying the first patch with --enable-modules I get linker
> errors again. With all patches applied, "doctest" isn't recognized. Is this
> perhaps 1.8-only material?
>

Yes, it's 1.8 only. Once it's released I will repost it with an update to
pythondeps.toml, for now you can uninstall the distro Meson and install
from their git repository using pip (I think "pip install ." should work).

I did test modules a few months ago when you reported it, but I will check
again before reposting.

Paolo


> Best regards,
> Bernhard
>
> >
> >Use it to remove BQL-related hacks, fix --enable-modules --enable-rust
> >and also simplify the Meson logic for building the qemu-api crate
> >(which may help splitting the crate, too).
> >
> >Meson also supports clippy and rustdoc but there are some bugs in the
> >prerelease.  I'll try to get them fixed before 1.8.0.
> >
> >Paolo
> >
> >Paolo Bonzini (3):
> >  rust: use "objects" for Rust executables as well
> >  rust: add qemu-api doctests to "meson test"
> >  rust: cell: remove support for running doctests with "cargo test --doc"
> >
> > docs/devel/rust.rst        |  2 --
> > .gitlab-ci.d/buildtest.yml |  5 -----
> > rust/qemu-api/meson.build  | 35 +++++++++++++++--------------------
> > rust/qemu-api/src/cell.rs  | 22 +++++++++-------------
> > 4 files changed, 24 insertions(+), 40 deletions(-)
> >
>
>

--00000000000070e92606324ac1f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 8 apr 2025, 22:34 Bernhar=
d Beschow &lt;<a href=3D"mailto:shentey@gmail.com">shentey@gmail.com</a>&gt=
; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><b=
r>
<br>
Am 5. April 2025 10:06:00 UTC schrieb Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.co=
m</a>&gt;:<br>
&gt;Meson 1.7.0 and 1.8.0 include improved support for Rust, namely:<br>
&gt;* support for &quot;objects&quot; in Rust executables<br>
&gt;* support for doctest targets<br>
<br>
Using Meson 1.7.2 (shipped with my distro) I didn&#39;t succeed with either=
 of these. If just applying the first patch with --enable-modules I get lin=
ker errors again. With all patches applied, &quot;doctest&quot; isn&#39;t r=
ecognized. Is this perhaps 1.8-only material?<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Yes, it&#39;s 1.8 only. Once i=
t&#39;s released I will repost it with an update to pythondeps.toml, for no=
w you can uninstall the distro Meson and install from their git repository =
using pip (I think &quot;pip install .&quot; should work).</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">I did test modules a few months ago when=
 you reported it, but I will check again before reposting.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Best regards,<br>
Bernhard<br>
<br>
&gt;<br>
&gt;Use it to remove BQL-related hacks, fix --enable-modules --enable-rust<=
br>
&gt;and also simplify the Meson logic for building the qemu-api crate<br>
&gt;(which may help splitting the crate, too).<br>
&gt;<br>
&gt;Meson also supports clippy and rustdoc but there are some bugs in the<b=
r>
&gt;prerelease.=C2=A0 I&#39;ll try to get them fixed before 1.8.0.<br>
&gt;<br>
&gt;Paolo<br>
&gt;<br>
&gt;Paolo Bonzini (3):<br>
&gt;=C2=A0 rust: use &quot;objects&quot; for Rust executables as well<br>
&gt;=C2=A0 rust: add qemu-api doctests to &quot;meson test&quot;<br>
&gt;=C2=A0 rust: cell: remove support for running doctests with &quot;cargo=
 test --doc&quot;<br>
&gt;<br>
&gt; docs/devel/rust.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 --<br>
&gt; .gitlab-ci.d/buildtest.yml |=C2=A0 5 -----<br>
&gt; rust/qemu-api/meson.build=C2=A0 | 35 +++++++++++++++------------------=
--<br>
&gt; rust/qemu-api/src/<a href=3D"http://cell.rs" rel=3D"noreferrer norefer=
rer" target=3D"_blank">cell.rs</a>=C2=A0 | 22 +++++++++-------------<br>
&gt; 4 files changed, 24 insertions(+), 40 deletions(-)<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--00000000000070e92606324ac1f0--


