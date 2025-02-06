Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EC1C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgAPI-00057v-M1; Thu, 06 Feb 2025 17:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgAPG-000574-MR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgAPE-0006Sc-WE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738881090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XvErDAAX4wr7158SLDmAc7o4gbw3Wspkwfwb2P9AaSM=;
 b=MXjP4K8Sp0+q5ITGnDuiygECFeJBOJC2fb8LeEvp2IMimSjQG1TBG/lVMCKmlFgA/m5PmK
 G1akp46AzfRogsQOTN53AJ95Ug4c3v/CXXm15WyZ/IUC9HPTs11OYK1HvvBSAJa6JHAv3U
 LOo+uaNb0ssewcI9wp3Vi7FpH3klB+o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-_YOlDbzfMleORec-Bx1zRw-1; Thu, 06 Feb 2025 17:31:28 -0500
X-MC-Unique: _YOlDbzfMleORec-Bx1zRw-1
X-Mimecast-MFC-AGG-ID: _YOlDbzfMleORec-Bx1zRw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38db0ec5adfso531349f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738881087; x=1739485887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvErDAAX4wr7158SLDmAc7o4gbw3Wspkwfwb2P9AaSM=;
 b=KHohufwrLe3m4k5DWR2GTmkJMu5boG1sv/lHGWs8uSw8M+r7om1wZRdHHrx9tP2DxO
 5q0AYOCGH88o8e+8vMLpoHH6XU02CKYR1vdQm0jSIJcPvm7vuVPlTRJYgsac36oFVYG0
 Q1v8ZrwaJBW3JJA1T+zLjBazEnT6yJ89FJT2tKWU/LT809ul7vHhOdT1B/c3kCscU9Kd
 KPIirI/z8HoQR0gwxsSz5lzcPTLOmLQGGIXBwiYcVaxfQEXxE3+gJIFD6c0CHEHcdOkM
 UcbYeU30TRa4jlPqUCD9TUDsOjbA4+MzTBLSdvSHDZNMsFLkbQ6pNDWosrJT1/4rwTn+
 uiyg==
X-Gm-Message-State: AOJu0YzZN0nAJzQS6IK9PUrBsj5wVfvzvg5TTlLBMkMDmnUZZAi2fWrj
 3f2DRBMWk/C8YvqCbwOX2QlXLvn/NRQi+TJ2A4q+XWeYIiwiT74MUY8AZOJMR4VzHiLy5HIC9Kf
 cHa0frhS7/l7wTEgevEWX+c3J6j7exkzUahTN0oncEjHr8G/FMhp15lnk8tq0Z77/LbQnyIfc2M
 KiTZ2nHBsdmxS0WTEOdSuYt756ycY=
X-Gm-Gg: ASbGncsQXmyIZ8sh1x+c4nPEEBMwUqvND9fCFSZufyPb1v+dyiiXeXK1BJcaQ6vbdZo
 YLi6J9riu4TC+JYpOMYn3q0txSwY4Lmcu1NnxWfZO7HIUBX57PIrdC5YBoWcI
X-Received: by 2002:a05:6000:4029:b0:38c:4a05:c25f with SMTP id
 ffacd0b85a97d-38dc9333a68mr395227f8f.42.1738881087175; 
 Thu, 06 Feb 2025 14:31:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOy4wfnIaa7P8x8MkhA12rcAAalDSd0dGxRBPaJibAfFMzhJf7FfKErLp4zQC3lRhQmB/vT4U0jNqjiA3RUrU=
X-Received: by 2002:a05:6000:4029:b0:38c:4a05:c25f with SMTP id
 ffacd0b85a97d-38dc9333a68mr395195f8f.42.1738881085883; Thu, 06 Feb 2025
 14:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20250129083705.1321407-1-pbonzini@redhat.com>
 <20250129083705.1321407-3-pbonzini@redhat.com>
 <Z6SWrSZ1HSyIc52q@intel.com>
In-Reply-To: <Z6SWrSZ1HSyIc52q@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Feb 2025 23:31:16 +0100
X-Gm-Features: AWEUYZnTRKxcyfdNPEv_IW8PyHlfW-3hZiC6--bsJzb0rAz74EmK2qpizNxq8xA
Message-ID: <CABgObfaKLUmbRwgvm0AkeAdJG5BCeQKO2TWfXz_1g1zcPAY6gQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: include rust_version in Cargo.toml
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006e5901062d80cdf6"
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

--0000000000006e5901062d80cdf6
Content-Type: text/plain; charset="UTF-8"

Il gio 6 feb 2025, 11:42 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > diff --git a/rust/hw/char/pl011/src/device_class.rs
> b/rust/hw/char/pl011/src/device_class.rs
> > index 8a157a663fb..dbef93f6cb3 100644
> > --- a/rust/hw/char/pl011/src/device_class.rs
> > +++ b/rust/hw/char/pl011/src/device_class.rs
> > @@ -12,7 +12,6 @@
> >
> >  use crate::device::{PL011Registers, PL011State};
> >
> > -#[allow(clippy::missing_const_for_fn)]
>
> It seems like a rebase nit since the commit 7d0520398f7f ("rust: prefer
> NonNull::new to assertions"), which is not worth an extra commit either.
>

It's not; adding rust_version let's Clippy know that this function cannot
be const in all supported versions of the standard library.

Paolo

>  extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
> >      let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
> >      unsafe { state.as_ref().migrate_clock }
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>
>

--0000000000006e5901062d80cdf6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 6 feb 2025, 11:42 Zhao Li=
u &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha=
 scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; d=
iff --git a/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">device_class.rs</a> b/rust/hw/=
char/pl011/src/<a href=3D"http://device_class.rs" rel=3D"noreferrer norefer=
rer" target=3D"_blank">device_class.rs</a><br>
&gt; index 8a157a663fb..dbef93f6cb3 100644<br>
&gt; --- a/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
&gt; +++ b/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
&gt; @@ -12,7 +12,6 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 use crate::device::{PL011Registers, PL011State};<br>
&gt;=C2=A0 <br>
&gt; -#[allow(clippy::missing_const_for_fn)]<br>
<br>
It seems like a rebase nit since the commit 7d0520398f7f (&quot;rust: prefe=
r<br>
NonNull::new to assertions&quot;), which is not worth an extra commit eithe=
r.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">It&#39;s not; adding rust_version let&#39;s Clippy know that this functio=
n cannot be const in all supported versions of the standard library.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 extern &quot;C&quot; fn pl011_clock_needed(opaque: *mut c_void) =
-&gt; bool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 let state =3D NonNull::new(opaque).unwrap().cast::=
&lt;PL011State&gt;();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsafe { state.as_ref().migrate_clock }<br>
<br>
Reviewed-by: Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com" target=3D"=
_blank" rel=3D"noreferrer">zhao1.liu@intel.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000006e5901062d80cdf6--


