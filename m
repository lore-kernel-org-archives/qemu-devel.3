Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C20C54F2E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 13:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIS6O-0002dI-MU; Fri, 23 May 2025 09:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uIS6H-0002az-P3
 for qemu-devel@nongnu.org; Fri, 23 May 2025 09:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uIS6E-000693-7R
 for qemu-devel@nongnu.org; Fri, 23 May 2025 09:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748005566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mc3mS5uLX/j3zhb1Qv7HdED6ZMFgmSc2h7kiupw2rr8=;
 b=S4WMcXW7MA505mFS37imJkeX08gVX2sCQ7FlofzwYNxBa3Gh3Ycs1xHj4YgW+ZEGbfHI5d
 1cwBypbUOodtwcRTZuTJ/YZ50G4UsWSG2Bhrcs355ISFSd34iZzJKQxJi6X3TGLHRkrsSU
 qGuiWKVDdUdaHT9BD4JWCt+bzNuRwYo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-axaBUyWjOv-g3lCMUifkQA-1; Fri, 23 May 2025 09:06:04 -0400
X-MC-Unique: axaBUyWjOv-g3lCMUifkQA-1
X-Mimecast-MFC-AGG-ID: axaBUyWjOv-g3lCMUifkQA_1748005563
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so51062285e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 06:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005563; x=1748610363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mc3mS5uLX/j3zhb1Qv7HdED6ZMFgmSc2h7kiupw2rr8=;
 b=TjONXOZBb2/CiO1QGutpviGcClI1yXHgFoMBGn41cu8nnAKNqAnTPtZD3c7PDjZIVj
 pTrfiuCx/LrR7SE+1Iiv5ipQA1xIkdR1d3p9Hh75tUgh9227fubKawrlprMDWulorHD9
 WLRnrzpxT0nvobsVl/4j1lJFrl+uvxZxVT1yH9GqucgeugimZRm7ujj7WtouyjhOneGD
 VOOwGNGzmdNM1H7g6mdIyXuQJyW9Evxfn06q/65Hf6eqjaKGod7Po8T/LPaO4cb9ddjU
 tGMlBq3wNzneJ17IanFpeb5xhbiRNUx3zfki/AL+4etLH6XOBN7W/bajSZqdpBczRV63
 IP2w==
X-Gm-Message-State: AOJu0YxJJ6Gt9xgP6NJOnSPoI18RdzE2QAMn+fXX8/cWihNMKiDmeLVU
 HIfuv3BQUuXA24nn+6/AjocPf9vBZf3k7YspKTO0k3i3xvw/iwbwBRD3rnpFmX/mi/XHtghl0G0
 wfCTFH5MoLYZv+rRec1HBgI9mQSBpMxon4lWBQ5u4Sok/FcvSSwtMQoXvAoLFB8uIbRYXl7oe8I
 RxgnFVLK0Slsy8Gc74TBY1NICubCir+D8=
X-Gm-Gg: ASbGncvaqiOWullYpUZ5Zmrl/n33HyRTWXsFMYTPuMQv/ZtjmFNUqOhNd63t4Ch9Fiz
 Kobb2+X32awuomt6MQP3T67vBg+fsSEOv/dGed4ckW2ZWDofkXGI5uPegILmAgFMeP2E=
X-Received: by 2002:a05:6000:2012:b0:3a3:7bed:cc2d with SMTP id
 ffacd0b85a97d-3a37bedcc56mr14042081f8f.39.1748005563335; 
 Fri, 23 May 2025 06:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaw4UNQsnpw2LEiZ/H9P0SOxbWGjFKK74VUhkv1044Oax/7C3KlOxDgpPjO/NbVs2ZCtuMqnMVaPre6QCooS0=
X-Received: by 2002:a05:6000:2012:b0:3a3:7bed:cc2d with SMTP id
 ffacd0b85a97d-3a37bedcc56mr14041926f8f.39.1748005561894; Fri, 23 May 2025
 06:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250522-rust-qdev-properties-v1-1-5b18b218bad1@linaro.org>
In-Reply-To: <20250522-rust-qdev-properties-v1-1-5b18b218bad1@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 May 2025 15:05:48 +0200
X-Gm-Features: AX0GCFsnDuWc5mO6BLbwysmLgbjjJtjZqJRofjA9PrvoehgUdR3xkRR2VvN8yRI
Message-ID: <CABgObfbVSZ9MNzjXBu1mr8bzX9F-AoKVRQzCJj6c+SUpsoUQNw@mail.gmail.com>
Subject: Re: [PATCH WIP RFC] rust: add qdev DeviceProperties derive macro
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="0000000000009526fe0635cd42fd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

--0000000000009526fe0635cd42fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 22 mag 2025, 10:12 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> This is unnecessary though, because once we have the
> const_refs_to_static feature we can introduce a QdevProp trait that
> returns a reference to a type's qdev_prop_* global variable. We cannot
> do this now because for our minimum Rust version we cannot refer to
> statics from const values.
>

Why don't you already write it assuming const_refs_to_static? If needed we
can add a hack to make the VALUE an enum, similar to what is already in
vmstate.rs.

So, this patch is not for merging yet, I will wait until we upgrade the
> Rust version and re-spin it with a proper trait-based implementation (and
> also split it into individual steps/patches).
>

It's not too large, overall.

 #[repr(C)]
> -#[derive(qemu_api_macros::Object)]
> +#[derive(qemu_api_macros::Object, qemu_api_macros::DeviceProperties)]
>

Is there more to be derived that is useful for Devices? Maybe the macro can
be DeviceState or Device.

 +    #[property(name =3D c"chardev", qdev_prop =3D
> qemu_api::bindings::qdev_prop_chr)]
>

Can you change the name to be a "normal" string and change it to a C
literal in the macro?

diff --git a/rust/hw/char/pl011/src/device_class.rs
> b/rust/hw/char/pl011/src/device_class.rs
> index
> d328d846323f6080a9573053767e51481eb32941..83d70d7d82aac4a3252a0b4cb24af70=
5b01d3635
> 100644
> --- a/rust/hw/char/pl011/src/device_class.rs
> +++ b/rust/hw/char/pl011/src/device_class.rs
> @@ -8,11 +8,8 @@
>  };
>
>  use qemu_api::{
> -    bindings::{qdev_prop_bool, qdev_prop_chr},
> -    prelude::*,
> -    vmstate::VMStateDescription,
> -    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,
> vmstate_subsections, vmstate_unused,
> -    zeroable::Zeroable,
> +    prelude::*, vmstate::VMStateDescription, vmstate_clock,
> vmstate_fields, vmstate_of,
> +    vmstate_struct, vmstate_subsections, vmstate_unused,
> zeroable::Zeroable,
>  };
>

I would also merge the files at this point, but no hurry.

+#[derive(Debug)]
> +struct DeviceProperty {
> +    name: Option<syn::LitCStr>,
> +    qdev_prop: Option<syn::Path>,
> +    assert_type: Option<proc_macro2::TokenStream>,
> +    bitnr: Option<syn::Expr>,
> +    defval: Option<syn::Expr>,
> +}
> +
> +impl Parse for DeviceProperty {
>

Can you look into using https://docs.rs/crate/attrs/latest for parsing?

(attrs doesn't support LitCStr btw)

+#[proc_macro_derive(DeviceProperties, attributes(property, bool_property))=
]
> +pub fn derive_device_properties(input: TokenStream) -> TokenStream {
>

Do you need to handle errors in the parsing of attributes?...

+        _other =3D> unreachable!(),
>

... Yes, you do=E2=80=94there is code already in qemu_macros, used by
derive_object_or_error(), to get the fields of a struct with proper error
handling.

let prop_name =3D prop.name.as_ref().unwrap();

+ let field_name =3D field.ident.as_ref().unwrap();

+ let qdev_prop =3D prop.qdev_prop.as_ref().unwrap();

+ let bitnr =3D prop.bitnr.as_ref().unwrap_or(&zero);

+ let set_default =3D prop.defval.is_some();

+ let defval =3D prop.defval.as_ref().unwrap_or(&zero);+
> bitnr: #bitnr,
> +


You also need to use let...else here instead of unwrap(), since panicking
provides worse error messages.

              set_default: #set_default,
> +                defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u=
:
> #defval as u64 },
>

If you like it, you can write this also as

  #(bitnr: #bitnr,)?
  #(set_default: true, defval: ...)?

and keep bitnr and defval as Options, since the None case is handled by the
default below.

Paolo


+                ..::qemu_api::zeroable::Zeroable::ZERO
> +            }
> +        });
> +    }
> +    let properties_expanded =3D quote_spanned! {span.into()=3D>
> +        #(#assertions)*
> +
> +        impl ::qemu_api::qdev::DevicePropertiesImpl for #name {
> +            fn properties() -> &'static [::qemu_api::bindings::Property]=
 {
> +                static PROPERTIES: &'static
> [::qemu_api::bindings::Property] =3D &[#(#properties_expanded),*];
> +
> +                PROPERTIES
> +            }
> +        }
> +    };
> +
> +    TokenStream::from(properties_expanded)
> +}
> +
>  #[proc_macro_derive(Wrapper)]
>  pub fn derive_opaque(input: TokenStream) -> TokenStream {
>      let input =3D parse_macro_input!(input as DeriveInput);
> diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
> index
> 1279d7a58d50e1bf6c8d2e6f00d7229bbb19e003..2fd8b2750ffabcaa1065558d38a700e=
35fbc9136
> 100644
> --- a/rust/qemu-api/src/qdev.rs
> +++ b/rust/qemu-api/src/qdev.rs
> @@ -100,8 +100,19 @@ pub trait ResettablePhasesImpl {
>      T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);
>  }
>
> +pub trait DevicePropertiesImpl {
> +    /// An array providing the properties that the user can set on the
> +    /// device.  Not a `const` because referencing statics in constants
> +    /// is unstable until Rust 1.83.0.
> +    fn properties() -> &'static [Property] {
> +        &[]
> +    }
> +}
> +
>  /// Trait providing the contents of [`DeviceClass`].
> -pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl +
> IsA<DeviceState> {
> +pub trait DeviceImpl:
> +    ObjectImpl + ResettablePhasesImpl + DevicePropertiesImpl +
> IsA<DeviceState>
> +{
>      /// _Realization_ is the second stage of device creation. It contain=
s
>      /// all operations that depend on device properties and can fail
> (note:
>      /// this is not yet supported for Rust devices).
> @@ -110,13 +121,6 @@ pub trait DeviceImpl: ObjectImpl +
> ResettablePhasesImpl + IsA<DeviceState> {
>      /// with the function pointed to by `REALIZE`.
>      const REALIZE: Option<fn(&Self)> =3D None;
>
> -    /// An array providing the properties that the user can set on the
> -    /// device.  Not a `const` because referencing statics in constants
> -    /// is unstable until Rust 1.83.0.
> -    fn properties() -> &'static [Property] {
> -        &[]
> -    }
> -
>      /// A `VMStateDescription` providing the migration format for the
> device
>      /// Not a `const` because referencing statics in constants is unstab=
le
>      /// until Rust 1.83.0.
> @@ -171,7 +175,7 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
>          if let Some(vmsd) =3D <T as DeviceImpl>::vmsd() {
>              self.vmsd =3D vmsd;
>          }
> -        let prop =3D <T as DeviceImpl>::properties();
> +        let prop =3D <T as DevicePropertiesImpl>::properties();
>          if !prop.is_empty() {
>              unsafe {
>                  bindings::device_class_set_props_n(self, prop.as_ptr(),
> prop.len());
> diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
> index
> a658a49fcfdda8fa4b9d139c10afb6ff3243790b..e8eadfd6e9add385ffc97de015b84aa=
e825c18ee
> 100644
> --- a/rust/qemu-api/tests/tests.rs
> +++ b/rust/qemu-api/tests/tests.rs
> @@ -9,7 +9,7 @@
>      cell::{self, BqlCell},
>      declare_properties, define_property,
>      prelude::*,
> -    qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
> +    qdev::{DeviceImpl, DevicePropertiesImpl, DeviceState, Property,
> ResettablePhasesImpl},
>      qom::{ObjectImpl, ParentField},
>      sysbus::SysBusDevice,
>      vmstate::VMStateDescription,
> @@ -68,10 +68,13 @@ impl ObjectImpl for DummyState {
>
>  impl ResettablePhasesImpl for DummyState {}
>
> -impl DeviceImpl for DummyState {
> +impl DevicePropertiesImpl for DummyState {
>      fn properties() -> &'static [Property] {
>          &DUMMY_PROPERTIES
>      }
> +}
> +
> +impl DeviceImpl for DummyState {
>      fn vmsd() -> Option<&'static VMStateDescription> {
>          Some(&VMSTATE)
>      }
> @@ -85,6 +88,8 @@ pub struct DummyChildState {
>
>  qom_isa!(DummyChildState: Object, DeviceState, DummyState);
>
> +impl DevicePropertiesImpl for DummyChildState {}
> +
>  pub struct DummyChildClass {
>      parent_class: <DummyState as ObjectType>::Class,
>  }
>
> ---
> base-commit: 2af4a82ab2cce3412ffc92cd4c96bd870e33bc8e
> change-id: 20250522-rust-qdev-properties-728e8f6a468e
>
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>
>

--0000000000009526fe0635cd42fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 22 mag 2025, 10:12 Manos Pitsidianakis &lt;<a h=
ref=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank" rel=3D"nore=
ferrer">manos.pitsidianakis@linaro.org</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">This is unnecessary though, beca=
use once we have the<br>
const_refs_to_static feature we can introduce a QdevProp trait that<br>
returns a reference to a type&#39;s qdev_prop_* global variable. We cannot<=
br>
do this now because for our minimum Rust version we cannot refer to<br>
statics from const values.<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Why don&#39;t you already write it assuming const=
_refs_to_static? If needed we can add a hack to make the VALUE an enum, sim=
ilar to what is already in <a href=3D"http://vmstate.rs" target=3D"_blank" =
rel=3D"noreferrer">vmstate.rs</a>.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">So, this patch is not for merging yet, I will wait until we up=
grade the<br>
Rust version and re-spin it with a proper trait-based implementation (and<b=
r>
also split it into individual steps/patches).<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s not too large, overal=
l.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0#[repr(C)]<br=
>
-#[derive(qemu_api_macros::Object)]<br>
+#[derive(qemu_api_macros::Object, qemu_api_macros::DeviceProperties)]<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Is th=
ere more to be derived that is useful for Devices? Maybe the macro can be D=
eviceState or Device.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
=C2=A0+=C2=A0 =C2=A0 #[property(name =3D c&quot;chardev&quot;, qdev_prop =
=3D qemu_api::bindings::qdev_prop_chr)]<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Can you change the name to be a &quo=
t;normal&quot; string and change it to a C literal in the macro?</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
diff --git a/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=
=3D"noreferrer noreferrer noreferrer" target=3D"_blank">device_class.rs</a>=
 b/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D"norefer=
rer noreferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
index d328d846323f6080a9573053767e51481eb32941..83d70d7d82aac4a3252a0b4cb24=
af705b01d3635 100644<br>
--- a/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D"nore=
ferrer noreferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
+++ b/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D"nore=
ferrer noreferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
@@ -8,11 +8,8 @@<br>
=C2=A0};<br>
<br>
=C2=A0use qemu_api::{<br>
-=C2=A0 =C2=A0 bindings::{qdev_prop_bool, qdev_prop_chr},<br>
-=C2=A0 =C2=A0 prelude::*,<br>
-=C2=A0 =C2=A0 vmstate::VMStateDescription,<br>
-=C2=A0 =C2=A0 vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, v=
mstate_subsections, vmstate_unused,<br>
-=C2=A0 =C2=A0 zeroable::Zeroable,<br>
+=C2=A0 =C2=A0 prelude::*, vmstate::VMStateDescription, vmstate_clock, vmst=
ate_fields, vmstate_of,<br>
+=C2=A0 =C2=A0 vmstate_struct, vmstate_subsections, vmstate_unused, zeroabl=
e::Zeroable,<br>
=C2=A0};<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I would also merge the files at this point, but no hurry.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+#[derive(Debug)]<br>
+struct DeviceProperty {<br>
+=C2=A0 =C2=A0 name: Option&lt;syn::LitCStr&gt;,<br>
+=C2=A0 =C2=A0 qdev_prop: Option&lt;syn::Path&gt;,<br>
+=C2=A0 =C2=A0 assert_type: Option&lt;proc_macro2::TokenStream&gt;,<br>
+=C2=A0 =C2=A0 bitnr: Option&lt;syn::Expr&gt;,<br>
+=C2=A0 =C2=A0 defval: Option&lt;syn::Expr&gt;,<br>
+}<br>
+<br>
+impl Parse for DeviceProperty {<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Can you look into using <a href=3D"https://=
docs.rs/crate/attrs/latest" target=3D"_blank" rel=3D"noreferrer">https://do=
cs.rs/crate/attrs/latest</a> for parsing?</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">(attrs doesn&#39;t support LitCStr btw)</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
+#[proc_macro_derive(DeviceProperties, attributes(property, bool_property))=
]<br>
+pub fn derive_device_properties(input: TokenStream) -&gt; TokenStream {<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Do =
you need to handle errors in the parsing of attributes?...</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _other =
=3D&gt; unreachable!(),<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">... Yes, you do=E2=80=94there is code already in qem=
u_macros, used by derive_object_or_error(), to get the fields of a struct w=
ith proper error handling.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">let prop_name =3D prop.name.as_ref().unwrap();</blockquote><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">+        let field_name =3D field.id=
ent.as_ref().unwrap();</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">+        let qdev_prop =3D prop.qdev_prop.as_ref().unwrap();</bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">+        let bit=
nr =3D prop.bitnr.as_ref().unwrap_or(&amp;zero);</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">+        let set_default =3D prop.defva=
l.is_some();</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
+        let defval =3D prop.defval.as_ref().unwrap_or(&amp;zero);+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bitnr: #bitnr,<br>
+=C2=A0 </blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">You also need to use let...else here instead of unwrap(), since panicki=
ng provides worse error messages.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_default: #=
set_default,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defval: ::qemu_api=
::bindings::Property__bindgen_ty_1 { u: #defval as u64 },<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">If you like it, yo=
u can write this also as</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>=C2=A0 #(bitnr: #bitnr,)?</div><div dir=3D"auto">=C2=A0 #(set_default: tru=
e, defval: ...)?</div><div dir=3D"auto"><br></div><div dir=3D"auto">and kee=
p bitnr and defval as Options, since the None case is handled by the defaul=
t below.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ..::qemu_api::zero=
able::Zeroable::ZERO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 let properties_expanded =3D quote_spanned! {span.into()=3D&g=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #(#assertions)*<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 impl ::qemu_api::qdev::DevicePropertiesImpl fo=
r #name {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn properties() -&gt; &amp;&#39;=
static [::qemu_api::bindings::Property] {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static PROPERTIES:=
 &amp;&#39;static [::qemu_api::bindings::Property] =3D &amp;[#(#properties_=
expanded),*];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PROPERTIES<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 TokenStream::from(properties_expanded)<br>
+}<br>
+<br>
=C2=A0#[proc_macro_derive(Wrapper)]<br>
=C2=A0pub fn derive_opaque(input: TokenStream) -&gt; TokenStream {<br>
=C2=A0 =C2=A0 =C2=A0let input =3D parse_macro_input!(input as DeriveInput);=
<br>
diff --git a/rust/qemu-api/src/<a href=3D"http://qdev.rs" rel=3D"noreferrer=
 noreferrer noreferrer" target=3D"_blank">qdev.rs</a> b/rust/qemu-api/src/<=
a href=3D"http://qdev.rs" rel=3D"noreferrer noreferrer noreferrer" target=
=3D"_blank">qdev.rs</a><br>
index 1279d7a58d50e1bf6c8d2e6f00d7229bbb19e003..2fd8b2750ffabcaa1065558d38a=
700e35fbc9136 100644<br>
--- a/rust/qemu-api/src/<a href=3D"http://qdev.rs" rel=3D"noreferrer norefe=
rrer noreferrer" target=3D"_blank">qdev.rs</a><br>
+++ b/rust/qemu-api/src/<a href=3D"http://qdev.rs" rel=3D"noreferrer norefe=
rrer noreferrer" target=3D"_blank">qdev.rs</a><br>
@@ -100,8 +100,19 @@ pub trait ResettablePhasesImpl {<br>
=C2=A0 =C2=A0 =C2=A0T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);<br>
=C2=A0}<br>
<br>
+pub trait DevicePropertiesImpl {<br>
+=C2=A0 =C2=A0 /// An array providing the properties that the user can set =
on the<br>
+=C2=A0 =C2=A0 /// device.=C2=A0 Not a `const` because referencing statics =
in constants<br>
+=C2=A0 =C2=A0 /// is unstable until Rust 1.83.0.<br>
+=C2=A0 =C2=A0 fn properties() -&gt; &amp;&#39;static [Property] {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;[]<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0/// Trait providing the contents of [`DeviceClass`].<br>
-pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA&lt;DeviceSta=
te&gt; {<br>
+pub trait DeviceImpl:<br>
+=C2=A0 =C2=A0 ObjectImpl + ResettablePhasesImpl + DevicePropertiesImpl + I=
sA&lt;DeviceState&gt;<br>
+{<br>
=C2=A0 =C2=A0 =C2=A0/// _Realization_ is the second stage of device creatio=
n. It contains<br>
=C2=A0 =C2=A0 =C2=A0/// all operations that depend on device properties and=
 can fail (note:<br>
=C2=A0 =C2=A0 =C2=A0/// this is not yet supported for Rust devices).<br>
@@ -110,13 +121,6 @@ pub trait DeviceImpl: ObjectImpl + ResettablePhasesImp=
l + IsA&lt;DeviceState&gt; {<br>
=C2=A0 =C2=A0 =C2=A0/// with the function pointed to by `REALIZE`.<br>
=C2=A0 =C2=A0 =C2=A0const REALIZE: Option&lt;fn(&amp;Self)&gt; =3D None;<br=
>
<br>
-=C2=A0 =C2=A0 /// An array providing the properties that the user can set =
on the<br>
-=C2=A0 =C2=A0 /// device.=C2=A0 Not a `const` because referencing statics =
in constants<br>
-=C2=A0 =C2=A0 /// is unstable until Rust 1.83.0.<br>
-=C2=A0 =C2=A0 fn properties() -&gt; &amp;&#39;static [Property] {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;[]<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/// A `VMStateDescription` providing the migration form=
at for the device<br>
=C2=A0 =C2=A0 =C2=A0/// Not a `const` because referencing statics in consta=
nts is unstable<br>
=C2=A0 =C2=A0 =C2=A0/// until Rust 1.83.0.<br>
@@ -171,7 +175,7 @@ pub fn class_init&lt;T: DeviceImpl&gt;(&amp;mut self) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if let Some(vmsd) =3D &lt;T as DeviceImpl=
&gt;::vmsd() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vmsd =3D vmsd;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 let prop =3D &lt;T as DeviceImpl&gt;::properti=
es();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 let prop =3D &lt;T as DevicePropertiesImpl&gt;=
::properties();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if !prop.is_empty() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bindings::dev=
ice_class_set_props_n(self, prop.as_ptr(), prop.len());<br>
diff --git a/rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"norefer=
rer noreferrer noreferrer" target=3D"_blank">tests.rs</a> b/rust/qemu-api/t=
ests/<a href=3D"http://tests.rs" rel=3D"noreferrer noreferrer noreferrer" t=
arget=3D"_blank">tests.rs</a><br>
index a658a49fcfdda8fa4b9d139c10afb6ff3243790b..e8eadfd6e9add385ffc97de015b=
84aae825c18ee 100644<br>
--- a/rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"noreferrer nor=
eferrer noreferrer" target=3D"_blank">tests.rs</a><br>
+++ b/rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"noreferrer nor=
eferrer noreferrer" target=3D"_blank">tests.rs</a><br>
@@ -9,7 +9,7 @@<br>
=C2=A0 =C2=A0 =C2=A0cell::{self, BqlCell},<br>
=C2=A0 =C2=A0 =C2=A0declare_properties, define_property,<br>
=C2=A0 =C2=A0 =C2=A0prelude::*,<br>
-=C2=A0 =C2=A0 qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesIm=
pl},<br>
+=C2=A0 =C2=A0 qdev::{DeviceImpl, DevicePropertiesImpl, DeviceState, Proper=
ty, ResettablePhasesImpl},<br>
=C2=A0 =C2=A0 =C2=A0qom::{ObjectImpl, ParentField},<br>
=C2=A0 =C2=A0 =C2=A0sysbus::SysBusDevice,<br>
=C2=A0 =C2=A0 =C2=A0vmstate::VMStateDescription,<br>
@@ -68,10 +68,13 @@ impl ObjectImpl for DummyState {<br>
<br>
=C2=A0impl ResettablePhasesImpl for DummyState {}<br>
<br>
-impl DeviceImpl for DummyState {<br>
+impl DevicePropertiesImpl for DummyState {<br>
=C2=A0 =C2=A0 =C2=A0fn properties() -&gt; &amp;&#39;static [Property] {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;DUMMY_PROPERTIES<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+impl DeviceImpl for DummyState {<br>
=C2=A0 =C2=A0 =C2=A0fn vmsd() -&gt; Option&lt;&amp;&#39;static VMStateDescr=
iption&gt; {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Some(&amp;VMSTATE)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -85,6 +88,8 @@ pub struct DummyChildState {<br>
<br>
=C2=A0qom_isa!(DummyChildState: Object, DeviceState, DummyState);<br>
<br>
+impl DevicePropertiesImpl for DummyChildState {}<br>
+<br>
=C2=A0pub struct DummyChildClass {<br>
=C2=A0 =C2=A0 =C2=A0parent_class: &lt;DummyState as ObjectType&gt;::Class,<=
br>
=C2=A0}<br>
<br>
---<br>
base-commit: 2af4a82ab2cce3412ffc92cd4c96bd870e33bc8e<br>
change-id: 20250522-rust-qdev-properties-728e8f6a468e<br>
<br>
--<br>
=CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=CE=
=B8=CE=AE=CF=84=CF=89<br>
<br>
</blockquote></div></div></div>

--0000000000009526fe0635cd42fd--


