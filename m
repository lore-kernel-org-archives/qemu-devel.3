Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CC4C3ABAD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 07:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB6sy-0008DS-Mn; Sat, 03 May 2025 03:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB6sw-0008DI-R1
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB6su-0008E6-0X
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746255721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTGjVUPMTVyQjV2xcte11TGKSC9sxruDtm9EXeNeuYI=;
 b=gh3L9kCteAUV0CzQrOTg+Pg7nW/seDwLp0o4e4b+qM85zLOHXQnmDIOUTGlAp42vfvqZ16
 a1380ZyowHK1ep9geVWyjRLVyIYLGTBUpm2lqYYH9PMd/jbAuFWl+r3MRjQ+mnLDmHpqGe
 0L/4z3vex8WVKLFOCl6okDisvDFI/HA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-O-3r_JiKPB2lm87nWlwnuw-1; Sat, 03 May 2025 03:01:59 -0400
X-MC-Unique: O-3r_JiKPB2lm87nWlwnuw-1
X-Mimecast-MFC-AGG-ID: O-3r_JiKPB2lm87nWlwnuw_1746255718
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so939996f8f.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746255717; x=1746860517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jTGjVUPMTVyQjV2xcte11TGKSC9sxruDtm9EXeNeuYI=;
 b=uT4VIvQ0dRzlP/eynmART/kJNOiX6MNDQukKS4VrHqBc6nKCSz5s3z0nUjqc0gjrT0
 8pc21nvwfb7NLAGdPNV75HV9FcxwmRy61/EzZs9zo+0UJbrUA6JjrX8EUUe8wir8ylbc
 fMrO7Hxue7uGQT+CsdVQFD+L6qnItoRaBNYXPYiFW/m0N11RdzVDaqsc252c6I808YRm
 RP8YlMig8l1v1CJx83ye/m+wwWXlsWPQuTmiHM6vLLJL4/SDSWXiMz0anuyOhkaFTK5W
 Ym69qG0i3+qCHb/+6BEYbwnF+3XCggUEXFFWI9tmPsWyezqITH+XhnHfGGFugxCAt1R/
 g6Eg==
X-Gm-Message-State: AOJu0YyKFLmsCdv0Vi8VrOuVZ11mcz2QK2TRxLbdUNqBlwWH0ek+D+FC
 K4WmyYAZSCxk1ZbF+0rjVvoTMXbB/E3pLeCh7I6L+mgm4XPvvEFKGILW0zxu6xDQiXXmy88lyz6
 vUUjyXiFSjQkj8iBjsZSTLCWcPwH20GUxMC89bD7DPtJusPJfQufxJG/bVqmSZVWnnCTQc1r1AE
 HWImP+TIAMeVGFjs9YdPlj8AamSWlVP56E0yo=
X-Gm-Gg: ASbGncudZIv7C+WKgwmDNc0c+18mLvmzAY3SWTYfWzkME6vL/Z3iOKk8FwIIsqaeWi8
 fBEtkCIzx2rUL/4c9tzybuAhKx6wDmVlSjG1B0nvKFlND0B+m/innXDTihgtI2gJtpTxs
X-Received: by 2002:a05:6000:178f:b0:3a0:99b1:bab5 with SMTP id
 ffacd0b85a97d-3a09fdd9d32mr117342f8f.57.1746255716602; 
 Sat, 03 May 2025 00:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEki6//b9YsMwVHBy+rO6dXvZ584bf9phQsZdOv6QlONKQEbjWyaNJrsHOxyn/yY/o/EMPAEo+PIqAB7J6fqqY=
X-Received: by 2002:a05:6000:178f:b0:3a0:99b1:bab5 with SMTP id
 ffacd0b85a97d-3a09fdd9d32mr117321f8f.57.1746255716246; Sat, 03 May 2025
 00:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <aBWr8FH9otBP5dqd@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aBWr8FH9otBP5dqd@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 3 May 2025 09:01:46 +0200
X-Gm-Features: ATxdqUHe2b1Xpex6YlsxtlsQQ2_Jh2ieJhoLdWxucS5TzrCANgSu1jKHF9XF4jE
Message-ID: <CABgObfbv8eRMTsgkzXfp_dFHGfjh_eu+z-U=4y9-2OUxvyyUhA@mail.gmail.com>
Subject: Re: [CFT PATCH 0/4] target/i386/emulate: cleanups
To: Wei Liu <wei.liu@kernel.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000a78104063435d71b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000a78104063435d71b
Content-Type: text/plain; charset="UTF-8"

Il sab 3 mag 2025, 07:39 Wei Liu <wei.liu@kernel.org> ha scritto:

> FWIW this series builds fine on for x86 HVF.
>

Thanks, can you also test it on either HVF or Hyper-V?

Paolo

Thanks,
> Wei.
>
> >
> > Paolo Bonzini (4):
> >   target/i386/emulate: fix target_ulong format strings
> >   target/i386/emulate: stop overloading decode->op[N].ptr
> >   target/i386/emulate: mostly rewrite flags handling
> >   target/i386: remove lflags
> >
> >  target/i386/cpu.h                |   6 -
> >  target/i386/emulate/x86_decode.h |   9 +-
> >  target/i386/emulate/x86_emu.h    |   8 +-
> >  target/i386/emulate/x86_flags.h  |  12 +-
> >  target/i386/emulate/x86_decode.c |  76 ++++++------
> >  target/i386/emulate/x86_emu.c    | 125 +++++++++----------
> >  target/i386/emulate/x86_flags.c  | 198 +++++++++++++------------------
> >  7 files changed, 197 insertions(+), 237 deletions(-)
> >
> > --
> > 2.49.0
> >
>
>

--000000000000a78104063435d71b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 3 mag 2025, 07:39 Wei Liu=
 &lt;<a href=3D"mailto:wei.liu@kernel.org">wei.liu@kernel.org</a>&gt; ha sc=
ritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">FWIW this=
 series builds fine on for x86 HVF.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Thanks, can you also test it on either H=
VF or Hyper-V?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks,<br>
Wei.<br>
<br>
&gt; <br>
&gt; Paolo Bonzini (4):<br>
&gt;=C2=A0 =C2=A0target/i386/emulate: fix target_ulong format strings<br>
&gt;=C2=A0 =C2=A0target/i386/emulate: stop overloading decode-&gt;op[N].ptr=
<br>
&gt;=C2=A0 =C2=A0target/i386/emulate: mostly rewrite flags handling<br>
&gt;=C2=A0 =C2=A0target/i386: remove lflags<br>
&gt; <br>
&gt;=C2=A0 target/i386/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A06 -<br>
&gt;=C2=A0 target/i386/emulate/x86_decode.h |=C2=A0 =C2=A09 +-<br>
&gt;=C2=A0 target/i386/emulate/x86_emu.h=C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br=
>
&gt;=C2=A0 target/i386/emulate/x86_flags.h=C2=A0 |=C2=A0 12 +-<br>
&gt;=C2=A0 target/i386/emulate/x86_decode.c |=C2=A0 76 ++++++------<br>
&gt;=C2=A0 target/i386/emulate/x86_emu.c=C2=A0 =C2=A0 | 125 +++++++++------=
----<br>
&gt;=C2=A0 target/i386/emulate/x86_flags.c=C2=A0 | 198 +++++++++++++-------=
-----------<br>
&gt;=C2=A0 7 files changed, 197 insertions(+), 237 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.49.0<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--000000000000a78104063435d71b--


