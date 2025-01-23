Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C9EC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasDt-0001jM-MQ; Thu, 23 Jan 2025 03:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tasDs-0001j8-2h
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:05:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tasDp-0007Jp-I9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737619551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s0z8ILOTcINTa/TqyvCpAwADN3NaOl6SkqeH4X0ef9Q=;
 b=AxU5ePIy/8POe56bn+tg8y1Jz6GIwqzsnvuenoMoC/cAvhLf6xCWm7YJ376BtTpuCBtQum
 DvXCRsjje6bu9aBUKAZ+7Wpho9uzae1oKr3c++eFYod5YFr7xFUuYNXrQdx94SuvmexEx8
 3NwBilZH/KfwNa7A1h0SDa0gqQJhhA8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-M2nHnLVXPV6ep0Ux4dOKaw-1; Thu, 23 Jan 2025 03:05:48 -0500
X-MC-Unique: M2nHnLVXPV6ep0Ux4dOKaw-1
X-Mimecast-MFC-AGG-ID: M2nHnLVXPV6ep0Ux4dOKaw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385dcadffebso226406f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 00:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737619547; x=1738224347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0z8ILOTcINTa/TqyvCpAwADN3NaOl6SkqeH4X0ef9Q=;
 b=aPuKxfmTQr6DGmFWV+HTeKkh9b+8H2k7Oa73sQiueojOlFA3SbczKfgFJ/WOChQeDG
 f4sicgRCaO2VezdFrEwonWugWAE1185r6ZVUUxghecU3/JIQ+LUCpvtk+svXZyC95GFg
 rvxjshGOq5fahJZkVZe50b9ywAP5zUCQGa8PiiF91HCaUEOEOVjCMyv2UBIPoAvIl6i9
 flCz0/UhShLCo2kYqkrCIhnn7uVEx/E6feM+Fm3FZoaKzIe6JsbSTzoRAvl44qnK5+l3
 IyuiVOG7eGXs0T7iBg5t4fgbeFhzBh1Oq5dApj+HOgC19s3X/CLMIfHOx8Q+EFUWmcxH
 9jBQ==
X-Gm-Message-State: AOJu0Yx8saAvFWAkV5k1r/qYgK0ECzgmz/uQtD11w3MK+d3ejeIrdIRz
 6MfeEb0+bfFkEwioHwLubnA1+AxIZelD6BaN97FsRnR86PYlfuPFq6RHTCKfOjFsoJrV3IEWEYr
 1Ulpuv9FR6bNeO1fHF/jsMN9E7jjK9tI5t1OzRr4rwPEeADbPvcBaBgb0qa46KJcueFbE/8cNnt
 +PXT5h9ZQXNsmcEZLzZrGnAjCaLBY=
X-Gm-Gg: ASbGncv4HctsIC+ROLLEDkIizjzcvtb2ShxpcNtPsifWXilTEx5F14WzsZFR4XszYl4
 eQGt/d4ws8EQv06Px7SG1UP7ijf10w45tEnqgtMcfyv1iF0dGLKI=
X-Received: by 2002:a05:6000:4012:b0:38a:9f27:838c with SMTP id
 ffacd0b85a97d-38bf57ce8b8mr21778890f8f.55.1737619547302; 
 Thu, 23 Jan 2025 00:05:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtUIRVQrFKXj+YTwBprlYRlz3QDkPaM+H7i6onXfiZmJ76ipmSp/rK6nZjV9NTEs0bU545Hu8y55fL13IfgUc=
X-Received: by 2002:a05:6000:4012:b0:38a:9f27:838c with SMTP id
 ffacd0b85a97d-38bf57ce8b8mr21778856f8f.55.1737619546879; Thu, 23 Jan 2025
 00:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-8-pbonzini@redhat.com>
 <Z5HX2G0+bt+3vzVB@intel.com>
In-Reply-To: <Z5HX2G0+bt+3vzVB@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Jan 2025 09:05:34 +0100
X-Gm-Features: AWEUYZlY9lco2vho1KVgBFpiF_ZI6lrdz3KBE9aiZn1pk37Gl-Z7_N5xK02MAC8
Message-ID: <CABgObfYRG-BFGj3cK4xz_PZYSiVgCY-YkSJitQMSk=2AtkcBcA@mail.gmail.com>
Subject: Re: [PATCH 07/10] rust: pl011: wrap registers with BqlRefCell
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d8d900062c5b13e9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

--000000000000d8d900062c5b13e9
Content-Type: text/plain; charset="UTF-8"

Il gio 23 gen 2025, 06:27 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> On Fri, Jan 17, 2025 at 10:26:54AM +0100, Paolo Bonzini wrote:
> > Date: Fri, 17 Jan 2025 10:26:54 +0100
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH 07/10] rust: pl011: wrap registers with BqlRefCell
> > X-Mailer: git-send-email 2.47.1
> >
> > This is a step towards making memory ops use a shared reference to the
> > device type; it's not yet possible due to the calls to character device
> > functions.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/hw/char/pl011/src/device.rs       | 38 +++++++++++++-------------
> >  rust/hw/char/pl011/src/device_class.rs |  8 +++---
> >  rust/hw/char/pl011/src/memory_ops.rs   |  2 +-
> >  3 files changed, 24 insertions(+), 24 deletions(-)
> >
> > diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/
> device.rs
> > index 476abe765a9..1d3da59e481 100644
> > --- a/rust/hw/char/pl011/src/device.rs
> > +++ b/rust/hw/char/pl011/src/device.rs
> > @@ -102,14 +102,14 @@ pub struct PL011Registers {
> >  }
> >
> >  #[repr(C)]
> > -#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
>
> This is the issue I also met, so why not drive "Debug" for BqlRefCell?
>

Because it is not entirely possible to do it safely--there could be
outstanding borrows that break invariants and cause debug() to fail. Maybe
we could implement it on BqlRefCell<PL011Registers> with a custom derive
macro...

RefCell doesn't implement Debug either for the same reason.

I tried to do this in [*]. Do we need to reconsider this?
>
> [*]:
> https://lore.kernel.org/qemu-devel/20241205060714.256270-3-zhao1.liu@intel.com/
>
> > +#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
> >  /// PL011 Device Model in QEMU
> >  pub struct PL011State {
> >      pub parent_obj: ParentField<SysBusDevice>,
> >      pub iomem: MemoryRegion,
> >      #[doc(alias = "chr")]
> >      pub char_backend: CharBackend,
> > -    pub regs: PL011Registers,
> > +    pub regs: BqlRefCell<PL011Registers>,
>
> This is a good example on the usage of BqlRefCell!
>
> //! `BqlRefCell` is best suited for data that is primarily accessed by the
> //! device's own methods, where multiple reads and writes can be grouped
> within
> //! a single borrow and a mutable reference can be passed around. "
>

Yeah, the comment was inspired by this usage and not vice versa. :D

>      /// QEMU interrupts
> >      ///
> >      /// ```text
> > @@ -530,8 +530,8 @@ fn post_init(&self) {
> >          }
> >      }
> >
> > +    #[allow(clippy::needless_pass_by_ref_mut)]
>
> How did you trigger this lint error? I switched to 1.84 and didn't get
> any errors (I noticed that 1.84 fixed the issue of ignoring `self` [*],
> but it still doesn't seem to work on my side).
>

I will double check. But I do see that there is no mut access inside, at
least not until the qemu_chr_fe_accept_input() is moved here. Unfortunately
until all MemoryRegion and CharBackend bindings are available the uses of
&mut and the casts to *mut are really really wonky.

(On the other hand it wouldn't be possible to have a grip on the qemu_api
code without users).

Paolo

> @@ -603,19 +603,19 @@ pub fn realize(&mut self) {
> >      }
> >
> >      pub fn reset(&mut self) {
>
> In principle, this place should also trigger `needless_pass_by_ref_mut`.
>

Yes but clippy hides it because this function is assigned to a function
pointer const. At least I think so---the point is more generally that you
can't change &mut to & without breaking compilation.


> > -        self.regs.reset();
> > +        self.regs.borrow_mut().reset();
> >      }
>
> [snip]
>
> > @@ -657,10 +657,10 @@ pub fn post_load(&mut self, _version_id: u32) ->
> Result<(), ()> {
> >  pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const
> u8, size: c_int) {
> >      unsafe {
> >          debug_assert!(!opaque.is_null());
> > -        let mut state =
> NonNull::new_unchecked(opaque.cast::<PL011State>());
> > +        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
>
> Perhaps we can use NonNull::new and unwrap()? Then debug_assert! is
> unnecessary.
>
> let state = unsafe {
> NonNull::new(opaque.cast::<PL011State>()).unwrap().as_ref() };
>

Yeah, though that's preexisting and it's code that will go away relatively
soon. I tried to minimize unrelated changes and changes to these temporary
unsafe functions, but in some cases there were some that sneaked in.

Let me know what you prefer.

Paolo

--000000000000d8d900062c5b13e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 23 gen 2025, 06:27 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fr=
i, Jan 17, 2025 at 10:26:54AM +0100, Paolo Bonzini wrote:<br>
&gt; Date: Fri, 17 Jan 2025 10:26:54 +0100<br>
&gt; From: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; Subject: [PATCH 07/10] rust: pl011: wrap registers with BqlRefCell<br>
&gt; X-Mailer: git-send-email 2.47.1<br>
&gt; <br>
&gt; This is a step towards making memory ops use a shared reference to the=
<br>
&gt; device type; it&#39;s not yet possible due to the calls to character d=
evice<br>
&gt; functions.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">device.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 38 +++++++++++++-------------<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">device_class.rs</a> |=C2=A0 8 +++=
---<br>
&gt;=C2=A0 rust/hw/char/pl011/src/<a href=3D"http://memory_ops.rs" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">memory_ops.rs</a>=C2=A0 =C2=A0|=C2=
=A0 2 +-<br>
&gt;=C2=A0 3 files changed, 24 insertions(+), 24 deletions(-)<br>
&gt; <br>
&gt; diff --git a/rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">device.rs</a> b/rust/hw/char/p=
l011/src/<a href=3D"http://device.rs" rel=3D"noreferrer noreferrer" target=
=3D"_blank">device.rs</a><br>
&gt; index 476abe765a9..1d3da59e481 100644<br>
&gt; --- a/rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">device.rs</a><br>
&gt; +++ b/rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">device.rs</a><br>
&gt; @@ -102,14 +102,14 @@ pub struct PL011Registers {<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #[repr(C)]<br>
&gt; -#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]<b=
r>
<br>
This is the issue I also met, so why not drive &quot;Debug&quot; for BqlRef=
Cell?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Because it is not entirely possible to do it safely--there could be ou=
tstanding borrows that break invariants and cause debug() to fail. Maybe we=
 could implement it on BqlRefCell&lt;PL011Registers&gt; with a custom deriv=
e macro...</div><div dir=3D"auto"><br></div><div dir=3D"auto">RefCell doesn=
&#39;t implement Debug either for the same reason.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
I tried to do this in [*]. Do we need to reconsider this?<br>
<br>
[*]: <a href=3D"https://lore.kernel.org/qemu-devel/20241205060714.256270-3-=
zhao1.liu@intel.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://lore.kernel.org/qemu-devel/20241205060714.256270-3-zhao1.liu@intel.com/<=
/a><br>
<br>
&gt; +#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]<br>
&gt;=C2=A0 /// PL011 Device Model in QEMU<br>
&gt;=C2=A0 pub struct PL011State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pub parent_obj: ParentField&lt;SysBusDevice&gt;,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 pub iomem: MemoryRegion,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #[doc(alias =3D &quot;chr&quot;)]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pub char_backend: CharBackend,<br>
&gt; -=C2=A0 =C2=A0 pub regs: PL011Registers,<br>
&gt; +=C2=A0 =C2=A0 pub regs: BqlRefCell&lt;PL011Registers&gt;,<br>
<br>
This is a good example on the usage of BqlRefCell!<br>
<br>
//! `BqlRefCell` is best suited for data that is primarily accessed by the<=
br>
//! device&#39;s own methods, where multiple reads and writes can be groupe=
d within<br>
//! a single borrow and a mutable reference can be passed around. &quot;<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yea=
h, the comment was inspired by this usage and not vice versa. :D</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_qu=
ote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 /// QEMU interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ///<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /// ```text<br>
&gt; @@ -530,8 +530,8 @@ fn post_init(&amp;self) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 #[allow(clippy::needless_pass_by_ref_mut)]<br>
<br>
How did you trigger this lint error? I switched to 1.84 and didn&#39;t get<=
br>
any errors (I noticed that 1.84 fixed the issue of ignoring `self` [*],<br>
but it still doesn&#39;t seem to work on my side).<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">I will double check. But =
I do see that there is no mut access inside, at least not until the qemu_ch=
r_fe_accept_input() is moved here. Unfortunately until all MemoryRegion and=
 CharBackend bindings are available the uses of &amp;mut and the casts to *=
mut are really really wonky.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">(On the other hand it wouldn&#39;t be possible to have a grip on the q=
emu_api code without users).</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; @@ -603,19 +603,19 @@ pub fn realize(&amp;mut self) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 pub fn reset(&amp;mut self) {<br>
<br>
In principle, this place should also trigger `needless_pass_by_ref_mut`.<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes=
 but clippy hides it because this function is assigned to a function pointe=
r const. At least I think so---the point is more generally that you can&#39=
;t change &amp;mut to &amp; without breaking compilation.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.regs.reset();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.regs.borrow_mut().reset();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
[snip]<br>
<br>
&gt; @@ -657,10 +657,10 @@ pub fn post_load(&amp;mut self, _version_id: u32=
) -&gt; Result&lt;(), ()&gt; {<br>
&gt;=C2=A0 pub unsafe extern &quot;C&quot; fn pl011_receive(opaque: *mut c_=
void, buf: *const u8, size: c_int) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsafe {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug_assert!(!opaque.is_null());<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 let mut state =3D NonNull::new_unchecked(=
opaque.cast::&lt;PL011State&gt;());<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 let state =3D NonNull::new_unchecked(opaq=
ue.cast::&lt;PL011State&gt;());<br>
<br>
Perhaps we can use NonNull::new and unwrap()? Then debug_assert! is<br>
unnecessary.<br>
<br>
let state =3D unsafe { NonNull::new(opaque.cast::&lt;PL011State&gt;()).unwr=
ap().as_ref() };<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Yeah, though that&#39;s preexisting and it&#39;s code that =
will go away relatively soon. I tried to minimize unrelated changes and cha=
nges to these temporary unsafe functions, but in some cases there were some=
 that sneaked in.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Let me=
 know what you prefer.</div><div dir=3D"auto"><br></div><div dir=3D"auto">P=
aolo</div></div>

--000000000000d8d900062c5b13e9--


