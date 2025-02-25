Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE174C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 13:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmusc-0004xx-7H; Tue, 25 Feb 2025 08:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tmusZ-0004xg-Tt
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tmusW-0008BM-Mj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740489698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iGpGgXO6NB9sLn6ipWpBPC1m291UjGbIlwITEt2cGBA=;
 b=KhvQ1pCdY5zkh5OthDbLeo2jNFwiKXOcw0nIT57sPpTwLppOwH0fM0kd9bdPCCYy+emz3J
 HZHSjj69qwZTUrb1NrOyQJ3RXw7iiZiP5tpj5waJGKj5E4MOZIST4m6dUOcs5IOhVSkl/F
 QJxGgvx0O5QfY5nN7kg+Ph05mcUBnzs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-dkkuHxfyN-aA8-ZI03Lggw-1; Tue, 25 Feb 2025 08:21:37 -0500
X-MC-Unique: dkkuHxfyN-aA8-ZI03Lggw-1
X-Mimecast-MFC-AGG-ID: dkkuHxfyN-aA8-ZI03Lggw_1740489696
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f443b4949so2631271f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 05:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740489695; x=1741094495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGpGgXO6NB9sLn6ipWpBPC1m291UjGbIlwITEt2cGBA=;
 b=RdoU40aRCOgKczxIEYW4G2x09NIJxp5Kl2nB4QjLN65ZvhYECvuhY7qH2gY57JxJaP
 F8VmVJODaQ3w/ZR+NE5AkJHaCYxKHcLQvFHA9hH4Xgfg8Hwy0QIeWuBuFBQCCmnrm6gt
 BLRD+aGxgE8/ZgvwCzEoM4yzpKO9yHGJzDTFQUB+kh2s7qKutIrtYVdVTsjXhsPNAxlN
 G3kVpnJEUZJRne4Vvy7aBhFwnogfYMqK5QcDDjcPClvoXtpfr/h16oxXVqebnZjvOqZr
 vQeuWvzkzWHuMpJvqEl8pjq5Zrfo5FU5nxkT5VfwfwvC7QxnIav0ylTkQt5m9Tz2Dws5
 eYIA==
X-Gm-Message-State: AOJu0Yw08J9+v7kHHnsROkDPBRSwUlfiI1wrsboIIWusQskECRzHf6Ng
 +8opEnXvOAw3XdSYnpP+w11lmsrsULliFKS9ypF8MzgDuSJC80ud5OGmD+T2mJV70M2gEXHV61C
 jYUl4fD61wTHBPJ5zVztLvDmFnc2h3X4sFYBm7cyS4cOQsWvN883pqTuyZ69wKU4c1ngN+cWXFB
 d6s2aHNRm/tIOkiiCMHWS3AYqLy4L/4NFfHr2GJg==
X-Gm-Gg: ASbGncsKA67GbAXE/6Jz6XWAeCymQjG5m0QWG1Ff/R75b2qKBCHLR05Ywu1IVBMGLBN
 ZJNkVcKP33no0BLTjMqdGhpdOtWDDxmacbSaEvR+MAgv2oBPgnLVZvfFhs8Lk5wPD7pW+Jurg7g
 ==
X-Received: by 2002:a05:6000:2aa:b0:38f:2990:c08d with SMTP id
 ffacd0b85a97d-390cc605002mr3089046f8f.14.1740489695579; 
 Tue, 25 Feb 2025 05:21:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7JYMOPr+a9xnWz2ATLFhglKjyPY6fl21e3HYrcjK0qDhj/Oywy3DruelI/8DBrMsJnxFxZWBKNQlDxCmTVEM=
X-Received: by 2002:a05:6000:2aa:b0:38f:2990:c08d with SMTP id
 ffacd0b85a97d-390cc605002mr3089011f8f.14.1740489695113; Tue, 25 Feb 2025
 05:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20250220113659.863332-1-pbonzini@redhat.com>
 <20250220113659.863332-3-pbonzini@redhat.com>
 <Z7hc8+h+mGnT7CSh@intel.com>
In-Reply-To: <Z7hc8+h+mGnT7CSh@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Feb 2025 14:21:23 +0100
X-Gm-Features: AQ5f1JrVrIYPxz2qHl2LRhtendRUr11pYxzePfvb5CWViRd_xXtsPWyDOgkol_o
Message-ID: <CABgObfZicQjY-vas9w4bozKZtBhqtcU=HGOVoW2knGDFbV92tg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add module to convert between success/-errno
 and io::Result
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Wolf, Kevin" <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000035973062ef75689"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000035973062ef75689
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 21 feb 2025, 11:41 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> Hi Paolo,
>
> > It is a common convention in QEMU to return a positive value in case of
> > success, and a negated errno value in case of error.  Unfortunately,
> > using errno portably in Rust is a bit complicated; on Unix the errno
> > values are supported natively by io::Error, but on Windows they are not=
;
> > so, use the libc crate.
>
> I'm a bit confused. The doc of error.h just said the negative value for
> failure:
>
> =E2=80=A2 integer-valued functions return non-negative / negative.
>
> Why do we need to using libc's -errno for Windows as well?
>

error.h doesn't explicitly mention errno because there are functions that
return -1 on all errors, but errno is a common convention for negative
return values too.

Converting `io::Error::last_os_error().raw_os_error().unwrap()` to a
> negative value seems compatible with Windows, except it returns Windows
> error codes.
>

... but that's not what C functions expect. They might pass it to set
error_setg_errno for example.

> +// On Unix, from_raw_os_error takes an errno value and OS errors
> > +// are printed using strerror.  On Windows however it takes a
> > +// GetLastError() value; therefore we need to convert errno values
> > +// into io::Error by hand.  This is the same mapping that the
> > +// standard library uses to retrieve the kind of OS errors
> > +// (`std::sys::pal::unix::decode_error_kind`).
> > +impl From<Errno> for ErrorKind {
> > +    fn from(value: Errno) -> ErrorKind {
>
> What about `use ErrorKind::*;` to omit the following "ErrorKind::"
> prefix?
>

Yeah, that's possible.


> > +        let Errno(errno) =3D value;
> > +        match i32::from(errno) {
>
> Maybe `match i32::from(errno.0)` ?


Well, I don't like .0 too much...

> +            libc::EPERM | libc::EACCES =3D> ErrorKind::PermissionDenied,
> > +            libc::ENOENT =3D> ErrorKind::NotFound,
> > +            libc::EINTR =3D> ErrorKind::Interrupted,
> > +            x if x =3D=3D libc::EAGAIN || x =3D=3D libc::EWOULDBLOCK =
=3D>
> ErrorKind::WouldBlock,
> > +            libc::ENOMEM =3D> ErrorKind::OutOfMemory,
> > +            libc::EEXIST =3D> ErrorKind::AlreadyExists,
> > +            libc::EINVAL =3D> ErrorKind::InvalidInput,
> > +            libc::EPIPE =3D> ErrorKind::BrokenPipe,
> > +            libc::EADDRINUSE =3D> ErrorKind::AddrInUse,
> > +            libc::EADDRNOTAVAIL =3D> ErrorKind::AddrNotAvailable,
> > +            libc::ECONNABORTED =3D> ErrorKind::ConnectionAborted,
> > +            libc::ECONNREFUSED =3D> ErrorKind::ConnectionRefused,
> > +            libc::ECONNRESET =3D> ErrorKind::ConnectionReset,
> > +            libc::ENOTCONN =3D> ErrorKind::NotConnected,
> > +            libc::ENOTSUP =3D> ErrorKind::Unsupported,
> > +            libc::ETIMEDOUT =3D> ErrorKind::TimedOut,
> > +            _ =3D> ErrorKind::Other,
>
> Are these errno cases specifically selected? It seems to have fewer than
> `decode_error_kind` lists. Why not support all the cases
> `decode_error_kind`
> mentions?


Not all of them are in all Rust versions; see
https://stdrs.dev/nightly/x86_64-unknown-linux-gnu/src/std/io/error.rs.html=
#179-395
.

> +// This is used on Windows for all io::Errors, but also on Unix if the
> > +// io::Error does not have a raw OS error.  This is the reversed
> > +// mapping of the above.
>
> Maybe:
>
> This is the "almost" reversed (except the default case) mapping
>

True, thanks.

Paolo

--000000000000035973062ef75689
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 21 feb 2025, 11:41 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Pa=
olo,<br>
<br>
&gt; It is a common convention in QEMU to return a positive value in case o=
f<br>
&gt; success, and a negated errno value in case of error.=C2=A0 Unfortunate=
ly,<br>
&gt; using errno portably in Rust is a bit complicated; on Unix the errno<b=
r>
&gt; values are supported natively by io::Error, but on Windows they are no=
t;<br>
&gt; so, use the libc crate.<br>
<br>
I&#39;m a bit confused. The doc of error.h just said the negative value for=
<br>
failure:<br>
<br>
=E2=80=A2 integer-valued functions return non-negative / negative.<br>
<br>
Why do we need to using libc&#39;s -errno for Windows as well?<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">error.h doesn=
&#39;t explicitly mention errno because there are functions that return -1 =
on all errors, but errno is a common convention for negative return values =
too.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
Converting `io::Error::last_os_error().raw_os_error().unwrap()` to a<br>
negative value seems compatible with Windows, except it returns Windows<br>
error codes.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">... but that&#39;s not what C functions expect. They might pass=
 it to set error_setg_errno for example.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">&gt; +// On Unix, from_raw_os_erro=
r takes an errno value and OS errors<br>
&gt; +// are printed using strerror.=C2=A0 On Windows however it takes a<br=
>
&gt; +// GetLastError() value; therefore we need to convert errno values<br=
>
&gt; +// into io::Error by hand.=C2=A0 This is the same mapping that the<br=
>
&gt; +// standard library uses to retrieve the kind of OS errors<br>
&gt; +// (`std::sys::pal::unix::decode_error_kind`).<br>
&gt; +impl From&lt;Errno&gt; for ErrorKind {<br>
&gt; +=C2=A0 =C2=A0 fn from(value: Errno) -&gt; ErrorKind {<br>
<br>
What about `use ErrorKind::*;` to omit the following &quot;ErrorKind::&quot=
;<br>
prefix?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Yeah, that&#39;s possible.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 let Errno(errno) =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 match i32::from(errno) {<br>
<br>
Maybe `match i32::from(errno.0)` ?</blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Well, I don&#39;t like .0 too much...</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::EPERM | libc::EACCES =
=3D&gt; ErrorKind::PermissionDenied,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::ENOENT =3D&gt; ErrorK=
ind::NotFound,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::EINTR =3D&gt; ErrorKi=
nd::Interrupted,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x if x =3D=3D libc::EAGAIN =
|| x =3D=3D libc::EWOULDBLOCK =3D&gt; ErrorKind::WouldBlock,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::ENOMEM =3D&gt; ErrorK=
ind::OutOfMemory,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::EEXIST =3D&gt; ErrorK=
ind::AlreadyExists,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::EINVAL =3D&gt; ErrorK=
ind::InvalidInput,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::EPIPE =3D&gt; ErrorKi=
nd::BrokenPipe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::EADDRINUSE =3D&gt; Er=
rorKind::AddrInUse,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::EADDRNOTAVAIL =3D&gt;=
 ErrorKind::AddrNotAvailable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::ECONNABORTED =3D&gt; =
ErrorKind::ConnectionAborted,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::ECONNREFUSED =3D&gt; =
ErrorKind::ConnectionRefused,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::ECONNRESET =3D&gt; Er=
rorKind::ConnectionReset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::ENOTCONN =3D&gt; Erro=
rKind::NotConnected,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::ENOTSUP =3D&gt; Error=
Kind::Unsupported,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc::ETIMEDOUT =3D&gt; Err=
orKind::TimedOut,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _ =3D&gt; ErrorKind::Other,=
<br>
<br>
Are these errno cases specifically selected? It seems to have fewer than<br=
>
`decode_error_kind` lists. Why not support all the cases `decode_error_kind=
`<br>
mentions?</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Not all of them are in all Rust versions; see <a href=3D"https://stdrs=
.dev/nightly/x86_64-unknown-linux-gnu/src/std/io/error.rs.html#179-395">htt=
ps://stdrs.dev/nightly/x86_64-unknown-linux-gnu/src/std/io/error.rs.html#17=
9-395</a>.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; +// This is used on Windows for all io::Errors, but also on=
 Unix if the<br>
&gt; +// io::Error does not have a raw OS error.=C2=A0 This is the reversed=
<br>
&gt; +// mapping of the above.<br>
<br>
Maybe:<br>
<br>
This is the &quot;almost&quot; reversed (except the default case) mapping<b=
r></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Tr=
ue, thanks.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><=
/div>

--000000000000035973062ef75689--


