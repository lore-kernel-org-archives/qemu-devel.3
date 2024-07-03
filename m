Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC7AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOzPb-0003U4-2v; Wed, 03 Jul 2024 08:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOzPY-0003T9-5M
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:48:36 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOzPN-0002kF-RI
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:48:35 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-445033fbc24so43698791cf.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720010903; x=1720615703; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FXe54UJENT4oYRKOoepZjVZET03mrUfuhNQKtc+uPAw=;
 b=l5uws+734jvwR9ffzLK0IMXlkWfdfEeuCyJvbi9S82TVlAuGTWuEOy/cg3e25jY1BR
 I7Q9bCiD0EfAABsbCL/ekcWld8uempOhvjZdsdV8jlcNEEZkzstQt7nQB9tJ9nQL3wIz
 kDAsQ7t3dMqp5Fh3t8J+PUOJgWbVlLaSW8JF/qvhIIEthtYYccMIv3tXSPJ1NTlkOzH/
 P+2T2WtEo3eUZdEuaiyhGO6g4uGI3GAbz+HULpAD0hRvWWfP4t8NzG0l99gd1w/3jF6t
 wCIKZRhsdLfYHwdq3KO2xVyj1KFFx5b1DQq3fSl7NH7s0ztBJCJcjrI5kxoKrTfa10aQ
 kcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720010903; x=1720615703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FXe54UJENT4oYRKOoepZjVZET03mrUfuhNQKtc+uPAw=;
 b=VcKxa8H5QCP0HdVI4KAboRBtKDqoLIEVXSiAdrD9iZOnjYApfsBumAAxuwVCV4isld
 7FMZsvtozeabbRtbT1mtcMsu7PwawZhO9z0G05P/0p/ll0Z6MEZV8nTzdiZXajkN1m7g
 5g/ZvdxoNaGMDFEgDdZL2ujiWsUOLNVMvy+6xjHGyNCFnWesNRUYXXfL2ojNCuq/gK+i
 c3ySf1oELm2R0SE/dSLRPodRYlIpZED97YGSNF0QkHpQt66eejl3uF36qmZ+MG3Mk4ci
 d9IQswcJIpzGThhCzXmTQR9fKfvULG19g+C1zfSm1P6ha6xugu//hrAONqndOKfvigrq
 Ufog==
X-Gm-Message-State: AOJu0YzYF75MOuF0YymLkIcSfBWo0RSOxsQwA5i56FSFSyGAEPkpuxkg
 SVaFeCxU1eWxYgEyPQlvM3cCH22v4FIr+XBLHE0AhOFf1x7DU6MRyR3Gdmdwn92lmM8lZdu7g1C
 yW+TCSL+EFxT8pVHutpI3ho4XY6qDlSIk
X-Google-Smtp-Source: AGHT+IFgzjwfmigfTGTiF35NgB9i87plFoS4/x1cPBz9t0lTZB8BJ8ipui2VAaGe4TqIcKbgOe/zwPcdeNd9Al3seSY=
X-Received: by 2002:a05:622a:199b:b0:446:5d60:5cfb with SMTP id
 d75a77b69052e-44662c9985amr148734021cf.10.1720010903298; Wed, 03 Jul 2024
 05:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <20240701145853.1394967-4-pbonzini@redhat.com>
In-Reply-To: <20240701145853.1394967-4-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jul 2024 16:48:11 +0400
Message-ID: <CAJ+F1C+__WX3EUFw-XdsqtXbwFtH0JZJdNH3WDvFazkNnecAbw@mail.gmail.com>
Subject: Re: [PATCH 03/14] rust: define traits and pointer wrappers to convert
 from/to C representations
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Sebastian_Dr=C3=B6ge?= <slomo@circular-chaos.org>
Content-Type: multipart/alternative; boundary="000000000000e6ac68061c573e27"
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000e6ac68061c573e27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

(adding Sebastian, one of the glib-rs developers in CC)

On Mon, Jul 1, 2024 at 7:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:

> The qemu::util::foreign module provides:
>
> - A trait for structs that can be converted to a C ("foreign")
> representation
>   (CloneToForeign)
>
> - A trait for structs that can be built from a C ("foreign") representati=
on
>   (FromForeign), and the utility IntoNative that can be used with less
> typing
>   (similar to the standard library's From and Into pair)
>
> - Automatic implementations of the above traits for Option<>, supporting
> NULL
>   pointers
>
> - A wrapper for a pointer that automatically frees the contained data.  I=
f
>   a struct XYZ implements CloneToForeign, you can build an
> OwnedPointer<XYZ>
>   and it will free the contents automatically unless you retrieve it with
>   owned_ptr.into_inner()
>

You worry about technical debt, and I do too. Here you introduce quite
different traits than what glib-rs offers. We already touched this subject
2y ago, my opinion didn't change much (
https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.c=
om/20210907121943.3498701-13-marcandre.lureau@redhat.com/).
Also, you don't offer the equivalent of "to_glib_none" which uses a
temporary stash and is quite useful, as a majority of functions don't take
ownership.

Because much of our code is using GLib types and API style, I think we
should strive for something that is close (if not just the same) to what
glib-rs offers. It's already hard enough to handle one binding concept,
having 2 will only make the matter worse. Consider a type like
GHashTable<GUuid, QOM>, it will be very annoying to deal with if we have
different bindings traits and implementations and we will likely end up
duplicating glib-rs effort.

As for naming & consistency, glib-rs settled on something clearer imho:

from_glib_full
from_glib_none
to_glib_full
to_glib_none

vs

from_foreign
cloned_from_foreign
clone_to_foreign
/nothing/

but overall, this is still close enough that we shouldn't reinvent it.

It may be worth studying what the kernel offers, I haven't checked yet.


>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qemu/src/lib.rs          |   6 +
>  qemu/src/util/foreign.rs | 247 +++++++++++++++++++++++++++++++++++++++
>  qemu/src/util/mod.rs     |   1 +
>  3 files changed, 254 insertions(+)
>  create mode 100644 qemu/src/util/foreign.rs
>  create mode 100644 qemu/src/util/mod.rs
>
> diff --git a/qemu/src/lib.rs b/qemu/src/lib.rs
> index fce21d7..c48edcf 100644
> --- a/qemu/src/lib.rs
> +++ b/qemu/src/lib.rs
> @@ -2,3 +2,9 @@
>  #![allow(dead_code)]
>
>  pub mod bindings;
> +
> +pub mod util;
> +pub use util::foreign::CloneToForeign;
> +pub use util::foreign::FromForeign;
> +pub use util::foreign::IntoNative;
> +pub use util::foreign::OwnedPointer;
> diff --git a/qemu/src/util/foreign.rs b/qemu/src/util/foreign.rs
> new file mode 100644
> index 0000000..a591925
> --- /dev/null
> +++ b/qemu/src/util/foreign.rs
> @@ -0,0 +1,247 @@
> +// TODO: change to use .cast() etc.
> +#![allow(clippy::ptr_as_ptr)]
> +
> +/// Traits to map between C structs and native Rust types.
> +/// Similar to glib-rs but a bit simpler and possibly more
> +/// idiomatic.
> +use std::borrow::Cow;
> +use std::fmt;
> +use std::fmt::Debug;
> +use std::mem;
> +use std::ptr;
> +
> +/// A type for which there is a canonical representation as a C datum.
> +pub trait CloneToForeign {
> +    /// The representation of `Self` as a C datum.  Typically a
> +    /// `struct`, though there are exceptions for example `c_char`
> +    /// for strings, since C strings are of `char *` type).
> +    type Foreign;
> +
> +    /// Free the C datum pointed to by `p`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `p` must be `NULL` or point to valid data.
> +    unsafe fn free_foreign(p: *mut Self::Foreign);
> +
> +    /// Convert a native Rust object to a foreign C struct, copying
> +    /// everything pointed to by `self` (same as `to_glib_full` in
> `glib-rs`)
> +    fn clone_to_foreign(&self) -> OwnedPointer<Self>;
> +
> +    /// Convert a native Rust object to a foreign C pointer, copying
> +    /// everything pointed to by `self`.  The returned pointer must
> +    /// be freed with the `free_foreign` associated function.
> +    fn clone_to_foreign_ptr(&self) -> *mut Self::Foreign {
> +        self.clone_to_foreign().into_inner()
> +    }
> +}
> +
> +impl<T> CloneToForeign for Option<T>
> +where
> +    T: CloneToForeign,
> +{
> +    type Foreign =3D <T as CloneToForeign>::Foreign;
> +
> +    unsafe fn free_foreign(x: *mut Self::Foreign) {
> +        T::free_foreign(x)
> +    }
> +
> +    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
> +        // Same as the underlying implementation, but also convert `None=
`
> +        // to a `NULL` pointer.
> +        self.as_ref()
> +            .map(CloneToForeign::clone_to_foreign)
> +            .map(OwnedPointer::into)
> +            .unwrap_or_default()
> +    }
> +}
> +
> +impl<T> FromForeign for Option<T>
> +where
> +    T: FromForeign,
> +{
> +    unsafe fn cloned_from_foreign(p: *const Self::Foreign) -> Self {
> +        // Same as the underlying implementation, but also accept a
> `NULL` pointer.
> +        if p.is_null() {
> +            None
> +        } else {
> +            Some(T::cloned_from_foreign(p))
> +        }
> +    }
> +}
> +
> +impl<T> CloneToForeign for Box<T>
> +where
> +    T: CloneToForeign,
> +{
> +    type Foreign =3D <T as CloneToForeign>::Foreign;
> +
> +    unsafe fn free_foreign(x: *mut Self::Foreign) {
> +        T::free_foreign(x)
> +    }
> +
> +    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
> +        self.as_ref().clone_to_foreign().into()
> +    }
> +}
> +
> +impl<T> FromForeign for Box<T>
> +where
> +    T: FromForeign,
> +{
> +    unsafe fn cloned_from_foreign(p: *const Self::Foreign) -> Self {
> +        Box::new(T::cloned_from_foreign(p))
> +    }
> +}
> +
> +impl<'a, B> CloneToForeign for Cow<'a, B>
> +    where B: 'a + ToOwned + ?Sized + CloneToForeign,
> +{
> +    type Foreign =3D B::Foreign;
> +
> +    unsafe fn free_foreign(ptr: *mut B::Foreign) {
> +        B::free_foreign(ptr);
> +    }
> +
> +    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
> +        self.as_ref().clone_to_foreign().into()
> +    }
> +}
> +
> +/// Convert a C datum into a native Rust object, taking ownership of
> +/// the C datum.  You should not need to implement this trait
> +/// as long as Rust types implement `FromForeign`.
> +pub trait IntoNative<T> {
> +    /// Convert a C datum to a native Rust object, taking ownership of
> +    /// the pointer or Rust object (same as `from_glib_full` in `glib-rs=
`)
> +    ///
> +    /// # Safety
> +    ///
> +    /// `p` must point to valid data, or can be `NULL` if Self is an
> +    /// `Option` type.  It becomes invalid after the function returns.
> +    unsafe fn into_native(self) -> T;
> +}
> +
> +impl<T, U> IntoNative<U> for *mut T
> +where
> +    U: FromForeign<Foreign =3D T>,
> +{
> +    unsafe fn into_native(self) -> U {
> +        U::from_foreign(self)
> +    }
> +}
> +
> +/// A type which can be constructed from a canonical representation as a
> +/// C datum.
> +pub trait FromForeign: CloneToForeign + Sized {
> +    /// Convert a C datum to a native Rust object, copying everything
> +    /// pointed to by `p` (same as `from_glib_none` in `glib-rs`)
> +    ///
> +    /// # Safety
> +    ///
> +    /// `p` must point to valid data, or can be `NULL` is `Self` is an
> +    /// `Option` type.
> +    unsafe fn cloned_from_foreign(p: *const Self::Foreign) -> Self;
> +
> +    /// Convert a C datum to a native Rust object, taking ownership of
> +    /// the pointer or Rust object (same as `from_glib_full` in `glib-rs=
`)
> +    ///
> +    /// The default implementation calls `cloned_from_foreign` and frees
> `p`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `p` must point to valid data, or can be `NULL` is `Self` is an
> +    /// `Option` type.  `p` becomes invalid after the function returns.
> +    unsafe fn from_foreign(p: *mut Self::Foreign) -> Self {
> +        let result =3D Self::cloned_from_foreign(p);
> +        Self::free_foreign(p);
> +        result
> +    }
> +}
> +
> +pub struct OwnedPointer<T: CloneToForeign + ?Sized> {
> +    ptr: *mut <T as CloneToForeign>::Foreign,
> +}
> +
> +impl<T: CloneToForeign + ?Sized> OwnedPointer<T> {
> +    /// Return a new `OwnedPointer` that wraps the pointer `ptr`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must be valid and live until the returned
> `OwnedPointer`
> +    /// is dropped.
> +    pub unsafe fn new(ptr: *mut <T as CloneToForeign>::Foreign) -> Self =
{
> +        OwnedPointer { ptr }
> +    }
> +
> +    /// Safely create an `OwnedPointer` from one that has the same
> +    /// freeing function.
> +    pub fn from<U>(x: OwnedPointer<U>) -> Self
> +    where
> +        U: CloneToForeign<Foreign =3D <T as CloneToForeign>::Foreign> +
> ?Sized,
> +    {
> +        unsafe {
> +            // SAFETY: the pointer type and free function are the same,
> +            // only the type changes
> +            OwnedPointer::new(x.into_inner())
> +        }
> +    }
> +
> +    /// Safely convert an `OwnedPointer` into one that has the same
> +    /// freeing function.
> +    pub fn into<U>(self) -> OwnedPointer<U>
> +    where
> +        U: CloneToForeign<Foreign =3D <T as CloneToForeign>::Foreign>,
> +    {
> +        OwnedPointer::from(self)
> +    }
> +
> +    /// Return the pointer that is stored in the `OwnedPointer`.  The
> +    /// pointer is valid for as long as the `OwnedPointer` itself.
> +    pub fn as_ptr(&self) -> *const <T as CloneToForeign>::Foreign {
> +        self.ptr
> +    }
> +
> +    pub fn as_mut_ptr(&self) -> *mut <T as CloneToForeign>::Foreign {
> +        self.ptr
> +    }
> +
> +    /// Return the pointer that is stored in the `OwnedPointer`,
> +    /// consuming the `OwnedPointer` but not freeing the pointer.
> +    pub fn into_inner(mut self) -> *mut <T as CloneToForeign>::Foreign {
> +        let result =3D mem::replace(&mut self.ptr, ptr::null_mut());
> +        mem::forget(self);
> +        result
> +    }
> +}
> +
> +impl<T: FromForeign + ?Sized> OwnedPointer<T> {
> +    /// Convert a C datum to a native Rust object, taking ownership of
> +    /// the pointer or Rust object (same as `from_glib_full` in `glib-rs=
`)
> +    pub fn into_native(self) -> T {
> +        // SAFETY: the pointer was passed to the unsafe constructor
> OwnedPointer::new
> +        unsafe { T::from_foreign(self.into_inner()) }
> +    }
> +}
> +
> +impl<T: CloneToForeign + ?Sized> Debug for OwnedPointer<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        let name =3D std::any::type_name::<T>();
> +        let name =3D format!("OwnedPointer<{}>", name);
> +        f.debug_tuple(&name).field(&self.as_ptr()).finish()
> +    }
> +}
> +
> +impl<T: CloneToForeign + Default + ?Sized> Default for OwnedPointer<T> {
> +    fn default() -> Self {
> +        <T as Default>::default().clone_to_foreign()
> +    }
> +}
> +
> +impl<T: CloneToForeign + ?Sized> Drop for OwnedPointer<T> {
> +    fn drop(&mut self) {
> +        let p =3D mem::replace(&mut self.ptr, ptr::null_mut());
> +        // SAFETY: the pointer was passed to the unsafe constructor
> OwnedPointer::new
> +        unsafe { T::free_foreign(p) }
> +    }
> +}
> diff --git a/qemu/src/util/mod.rs b/qemu/src/util/mod.rs
> new file mode 100644
> index 0000000..be00d0c
> --- /dev/null
> +++ b/qemu/src/util/mod.rs
> @@ -0,0 +1 @@
> +pub mod foreign;
> --
> 2.45.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e6ac68061c573e27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><div><br></div><div>(adding S=
ebastian, one of the glib-rs developers in CC)</div><div><br></div><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 202=
4 at 7:02=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.co=
m">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">The qemu::util::foreign module provides:<br>
<br>
- A trait for structs that can be converted to a C (&quot;foreign&quot;) re=
presentation<br>
=C2=A0 (CloneToForeign)<br>
<br>
- A trait for structs that can be built from a C (&quot;foreign&quot;) repr=
esentation<br>
=C2=A0 (FromForeign), and the utility IntoNative that can be used with less=
 typing<br>
=C2=A0 (similar to the standard library&#39;s From and Into pair)<br>
<br>
- Automatic implementations of the above traits for Option&lt;&gt;, support=
ing NULL<br>
=C2=A0 pointers<br>
<br>
- A wrapper for a pointer that automatically frees the contained data.=C2=
=A0 If<br>
=C2=A0 a struct XYZ implements CloneToForeign, you can build an OwnedPointe=
r&lt;XYZ&gt;<br>
=C2=A0 and it will free the contents automatically unless you retrieve it w=
ith<br>
=C2=A0 owned_ptr.into_inner()<br></blockquote><div><br></div><div>You worry=
 about technical debt, and I do too. Here you introduce quite different tra=
its than what glib-rs offers. We already touched this subject 2y ago, my op=
inion didn&#39;t change much (<a href=3D"https://patchew.org/QEMU/202109071=
21943.3498701-1-marcandre.lureau@redhat.com/20210907121943.3498701-13-marca=
ndre.lureau@redhat.com/">https://patchew.org/QEMU/20210907121943.3498701-1-=
marcandre.lureau@redhat.com/20210907121943.3498701-13-marcandre.lureau@redh=
at.com/</a>). Also, you don&#39;t offer the equivalent of &quot;to_glib_non=
e&quot; which uses a temporary stash and is quite useful, as a majority of =
functions don&#39;t take ownership.<br></div><div><br></div><div>Because mu=
ch of our code is using GLib types and API style, I think we should strive =
for something that is close (if not just the same) to what glib-rs offers. =
It&#39;s already hard enough to handle one binding concept, having 2 will o=
nly make the matter worse. Consider a type like GHashTable&lt;GUuid, QOM&gt=
;, it will be very annoying to deal with if we have different bindings trai=
ts and implementations and we will likely end up duplicating glib-rs effort=
.</div><div><br></div><div>As for naming &amp; consistency, glib-rs settled=
 on something clearer imho:</div><div><br></div><div>from_glib_full</div><d=
iv>from_glib_none</div><div>to_glib_full</div><div>to_glib_none</div><div><=
br></div><div>vs</div><div><br></div><div>from_foreign</div><div>cloned_fro=
m_foreign</div><div>clone_to_foreign</div><div>/nothing/<br></div><div><br>=
</div><div>but overall, this is still close enough that we shouldn&#39;t re=
invent it.</div><div><br></div><div>It may be worth studying what the kerne=
l offers, I haven&#39;t checked yet.<br></div><div>=C2=A0<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0qemu/src/<a href=3D"http://lib.rs" rel=3D"noreferrer" target=3D"_blan=
k">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0qemu/src/util/<a href=3D"http://foreign.rs" rel=3D"noreferrer" target=
=3D"_blank">foreign.rs</a> | 247 +++++++++++++++++++++++++++++++++++++++<br=
>
=C2=A0qemu/src/util/<a href=3D"http://mod.rs" rel=3D"noreferrer" target=3D"=
_blank">mod.rs</a>=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A03 files changed, 254 insertions(+)<br>
=C2=A0create mode 100644 qemu/src/util/<a href=3D"http://foreign.rs" rel=3D=
"noreferrer" target=3D"_blank">foreign.rs</a><br>
=C2=A0create mode 100644 qemu/src/util/<a href=3D"http://mod.rs" rel=3D"nor=
eferrer" target=3D"_blank">mod.rs</a><br>
<br>
diff --git a/qemu/src/<a href=3D"http://lib.rs" rel=3D"noreferrer" target=
=3D"_blank">lib.rs</a> b/qemu/src/<a href=3D"http://lib.rs" rel=3D"noreferr=
er" target=3D"_blank">lib.rs</a><br>
index fce21d7..c48edcf 100644<br>
--- a/qemu/src/<a href=3D"http://lib.rs" rel=3D"noreferrer" target=3D"_blan=
k">lib.rs</a><br>
+++ b/qemu/src/<a href=3D"http://lib.rs" rel=3D"noreferrer" target=3D"_blan=
k">lib.rs</a><br>
@@ -2,3 +2,9 @@<br>
=C2=A0#![allow(dead_code)]<br>
<br>
=C2=A0pub mod bindings;<br>
+<br>
+pub mod util;<br>
+pub use util::foreign::CloneToForeign;<br>
+pub use util::foreign::FromForeign;<br>
+pub use util::foreign::IntoNative;<br>
+pub use util::foreign::OwnedPointer;<br>
diff --git a/qemu/src/util/<a href=3D"http://foreign.rs" rel=3D"noreferrer"=
 target=3D"_blank">foreign.rs</a> b/qemu/src/util/<a href=3D"http://foreign=
.rs" rel=3D"noreferrer" target=3D"_blank">foreign.rs</a><br>
new file mode 100644<br>
index 0000000..a591925<br>
--- /dev/null<br>
+++ b/qemu/src/util/<a href=3D"http://foreign.rs" rel=3D"noreferrer" target=
=3D"_blank">foreign.rs</a><br>
@@ -0,0 +1,247 @@<br>
+// TODO: change to use .cast() etc.<br>
+#![allow(clippy::ptr_as_ptr)]<br>
+<br>
+/// Traits to map between C structs and native Rust types.<br>
+/// Similar to glib-rs but a bit simpler and possibly more<br>
+/// idiomatic.<br>
+use std::borrow::Cow;<br>
+use std::fmt;<br>
+use std::fmt::Debug;<br>
+use std::mem;<br>
+use std::ptr;<br>
+<br>
+/// A type for which there is a canonical representation as a C datum.<br>
+pub trait CloneToForeign {<br>
+=C2=A0 =C2=A0 /// The representation of `Self` as a C datum.=C2=A0 Typical=
ly a<br>
+=C2=A0 =C2=A0 /// `struct`, though there are exceptions for example `c_cha=
r`<br>
+=C2=A0 =C2=A0 /// for strings, since C strings are of `char *` type).<br>
+=C2=A0 =C2=A0 type Foreign;<br>
+<br>
+=C2=A0 =C2=A0 /// Free the C datum pointed to by `p`.<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// # Safety<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// `p` must be `NULL` or point to valid data.<br>
+=C2=A0 =C2=A0 unsafe fn free_foreign(p: *mut Self::Foreign);<br>
+<br>
+=C2=A0 =C2=A0 /// Convert a native Rust object to a foreign C struct, copy=
ing<br>
+=C2=A0 =C2=A0 /// everything pointed to by `self` (same as `to_glib_full` =
in `glib-rs`)<br>
+=C2=A0 =C2=A0 fn clone_to_foreign(&amp;self) -&gt; OwnedPointer&lt;Self&gt=
;;<br>
+<br>
+=C2=A0 =C2=A0 /// Convert a native Rust object to a foreign C pointer, cop=
ying<br>
+=C2=A0 =C2=A0 /// everything pointed to by `self`.=C2=A0 The returned poin=
ter must<br>
+=C2=A0 =C2=A0 /// be freed with the `free_foreign` associated function.<br=
>
+=C2=A0 =C2=A0 fn clone_to_foreign_ptr(&amp;self) -&gt; *mut Self::Foreign =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.clone_to_foreign().into_inner()<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;T&gt; CloneToForeign for Option&lt;T&gt;<br>
+where<br>
+=C2=A0 =C2=A0 T: CloneToForeign,<br>
+{<br>
+=C2=A0 =C2=A0 type Foreign =3D &lt;T as CloneToForeign&gt;::Foreign;<br>
+<br>
+=C2=A0 =C2=A0 unsafe fn free_foreign(x: *mut Self::Foreign) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 T::free_foreign(x)<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fn clone_to_foreign(&amp;self) -&gt; OwnedPointer&lt;Self&gt=
; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Same as the underlying implementation, but =
also convert `None`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // to a `NULL` pointer.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.as_ref()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .map(CloneToForeign::clone_to_fo=
reign)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .map(OwnedPointer::into)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .unwrap_or_default()<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;T&gt; FromForeign for Option&lt;T&gt;<br>
+where<br>
+=C2=A0 =C2=A0 T: FromForeign,<br>
+{<br>
+=C2=A0 =C2=A0 unsafe fn cloned_from_foreign(p: *const Self::Foreign) -&gt;=
 Self {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Same as the underlying implementation, but =
also accept a `NULL` pointer.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if p.is_null() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Some(T::cloned_from_foreign(p))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;T&gt; CloneToForeign for Box&lt;T&gt;<br>
+where<br>
+=C2=A0 =C2=A0 T: CloneToForeign,<br>
+{<br>
+=C2=A0 =C2=A0 type Foreign =3D &lt;T as CloneToForeign&gt;::Foreign;<br>
+<br>
+=C2=A0 =C2=A0 unsafe fn free_foreign(x: *mut Self::Foreign) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 T::free_foreign(x)<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fn clone_to_foreign(&amp;self) -&gt; OwnedPointer&lt;Self&gt=
; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.as_ref().clone_to_foreign().into()<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;T&gt; FromForeign for Box&lt;T&gt;<br>
+where<br>
+=C2=A0 =C2=A0 T: FromForeign,<br>
+{<br>
+=C2=A0 =C2=A0 unsafe fn cloned_from_foreign(p: *const Self::Foreign) -&gt;=
 Self {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Box::new(T::cloned_from_foreign(p))<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;&#39;a, B&gt; CloneToForeign for Cow&lt;&#39;a, B&gt;<br>
+=C2=A0 =C2=A0 where B: &#39;a + ToOwned + ?Sized + CloneToForeign,<br>
+{<br>
+=C2=A0 =C2=A0 type Foreign =3D B::Foreign;<br>
+<br>
+=C2=A0 =C2=A0 unsafe fn free_foreign(ptr: *mut B::Foreign) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 B::free_foreign(ptr);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fn clone_to_foreign(&amp;self) -&gt; OwnedPointer&lt;Self&gt=
; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.as_ref().clone_to_foreign().into()<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/// Convert a C datum into a native Rust object, taking ownership of<br>
+/// the C datum.=C2=A0 You should not need to implement this trait<br>
+/// as long as Rust types implement `FromForeign`.<br>
+pub trait IntoNative&lt;T&gt; {<br>
+=C2=A0 =C2=A0 /// Convert a C datum to a native Rust object, taking owners=
hip of<br>
+=C2=A0 =C2=A0 /// the pointer or Rust object (same as `from_glib_full` in =
`glib-rs`)<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// # Safety<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// `p` must point to valid data, or can be `NULL` if Self i=
s an<br>
+=C2=A0 =C2=A0 /// `Option` type.=C2=A0 It becomes invalid after the functi=
on returns.<br>
+=C2=A0 =C2=A0 unsafe fn into_native(self) -&gt; T;<br>
+}<br>
+<br>
+impl&lt;T, U&gt; IntoNative&lt;U&gt; for *mut T<br>
+where<br>
+=C2=A0 =C2=A0 U: FromForeign&lt;Foreign =3D T&gt;,<br>
+{<br>
+=C2=A0 =C2=A0 unsafe fn into_native(self) -&gt; U {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 U::from_foreign(self)<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/// A type which can be constructed from a canonical representation as a<b=
r>
+/// C datum.<br>
+pub trait FromForeign: CloneToForeign + Sized {<br>
+=C2=A0 =C2=A0 /// Convert a C datum to a native Rust object, copying every=
thing<br>
+=C2=A0 =C2=A0 /// pointed to by `p` (same as `from_glib_none` in `glib-rs`=
)<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// # Safety<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// `p` must point to valid data, or can be `NULL` is `Self`=
 is an<br>
+=C2=A0 =C2=A0 /// `Option` type.<br>
+=C2=A0 =C2=A0 unsafe fn cloned_from_foreign(p: *const Self::Foreign) -&gt;=
 Self;<br>
+<br>
+=C2=A0 =C2=A0 /// Convert a C datum to a native Rust object, taking owners=
hip of<br>
+=C2=A0 =C2=A0 /// the pointer or Rust object (same as `from_glib_full` in =
`glib-rs`)<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// The default implementation calls `cloned_from_foreign` a=
nd frees `p`.<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// # Safety<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// `p` must point to valid data, or can be `NULL` is `Self`=
 is an<br>
+=C2=A0 =C2=A0 /// `Option` type.=C2=A0 `p` becomes invalid after the funct=
ion returns.<br>
+=C2=A0 =C2=A0 unsafe fn from_foreign(p: *mut Self::Foreign) -&gt; Self {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 let result =3D Self::cloned_from_foreign(p);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Self::free_foreign(p);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+pub struct OwnedPointer&lt;T: CloneToForeign + ?Sized&gt; {<br>
+=C2=A0 =C2=A0 ptr: *mut &lt;T as CloneToForeign&gt;::Foreign,<br>
+}<br>
+<br>
+impl&lt;T: CloneToForeign + ?Sized&gt; OwnedPointer&lt;T&gt; {<br>
+=C2=A0 =C2=A0 /// Return a new `OwnedPointer` that wraps the pointer `ptr`=
.<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// # Safety<br>
+=C2=A0 =C2=A0 ///<br>
+=C2=A0 =C2=A0 /// The pointer must be valid and live until the returned `O=
wnedPointer`<br>
+=C2=A0 =C2=A0 /// is dropped.<br>
+=C2=A0 =C2=A0 pub unsafe fn new(ptr: *mut &lt;T as CloneToForeign&gt;::For=
eign) -&gt; Self {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 OwnedPointer { ptr }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Safely create an `OwnedPointer` from one that has the sa=
me<br>
+=C2=A0 =C2=A0 /// freeing function.<br>
+=C2=A0 =C2=A0 pub fn from&lt;U&gt;(x: OwnedPointer&lt;U&gt;) -&gt; Self<br=
>
+=C2=A0 =C2=A0 where<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 U: CloneToForeign&lt;Foreign =3D &lt;T as Clon=
eToForeign&gt;::Foreign&gt; + ?Sized,<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // SAFETY: the pointer type and =
free function are the same,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // only the type changes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OwnedPointer::new(x.into_inner()=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Safely convert an `OwnedPointer` into one that has the s=
ame<br>
+=C2=A0 =C2=A0 /// freeing function.<br>
+=C2=A0 =C2=A0 pub fn into&lt;U&gt;(self) -&gt; OwnedPointer&lt;U&gt;<br>
+=C2=A0 =C2=A0 where<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 U: CloneToForeign&lt;Foreign =3D &lt;T as Clon=
eToForeign&gt;::Foreign&gt;,<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 OwnedPointer::from(self)<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Return the pointer that is stored in the `OwnedPointer`.=
=C2=A0 The<br>
+=C2=A0 =C2=A0 /// pointer is valid for as long as the `OwnedPointer` itsel=
f.<br>
+=C2=A0 =C2=A0 pub fn as_ptr(&amp;self) -&gt; *const &lt;T as CloneToForeig=
n&gt;::Foreign {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ptr<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 pub fn as_mut_ptr(&amp;self) -&gt; *mut &lt;T as CloneToFore=
ign&gt;::Foreign {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ptr<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /// Return the pointer that is stored in the `OwnedPointer`,=
<br>
+=C2=A0 =C2=A0 /// consuming the `OwnedPointer` but not freeing the pointer=
.<br>
+=C2=A0 =C2=A0 pub fn into_inner(mut self) -&gt; *mut &lt;T as CloneToForei=
gn&gt;::Foreign {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 let result =3D mem::replace(&amp;mut self.ptr,=
 ptr::null_mut());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem::forget(self);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;T: FromForeign + ?Sized&gt; OwnedPointer&lt;T&gt; {<br>
+=C2=A0 =C2=A0 /// Convert a C datum to a native Rust object, taking owners=
hip of<br>
+=C2=A0 =C2=A0 /// the pointer or Rust object (same as `from_glib_full` in =
`glib-rs`)<br>
+=C2=A0 =C2=A0 pub fn into_native(self) -&gt; T {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // SAFETY: the pointer was passed to the unsaf=
e constructor OwnedPointer::new<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe { T::from_foreign(self.into_inner()) }<=
br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;T: CloneToForeign + ?Sized&gt; Debug for OwnedPointer&lt;T&gt; {<b=
r>
+=C2=A0 =C2=A0 fn fmt(&amp;self, f: &amp;mut fmt::Formatter&lt;&#39;_&gt;) =
-&gt; fmt::Result {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 let name =3D std::any::type_name::&lt;T&gt;();=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 let name =3D format!(&quot;OwnedPointer&lt;{}&=
gt;&quot;, name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.debug_tuple(&amp;name).field(&amp;self.as_pt=
r()).finish()<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;T: CloneToForeign + Default + ?Sized&gt; Default for OwnedPointer&=
lt;T&gt; {<br>
+=C2=A0 =C2=A0 fn default() -&gt; Self {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;T as Default&gt;::default().clone_to_forei=
gn()<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+impl&lt;T: CloneToForeign + ?Sized&gt; Drop for OwnedPointer&lt;T&gt; {<br=
>
+=C2=A0 =C2=A0 fn drop(&amp;mut self) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 let p =3D mem::replace(&amp;mut self.ptr, ptr:=
:null_mut());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // SAFETY: the pointer was passed to the unsaf=
e constructor OwnedPointer::new<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe { T::free_foreign(p) }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
diff --git a/qemu/src/util/<a href=3D"http://mod.rs" rel=3D"noreferrer" tar=
get=3D"_blank">mod.rs</a> b/qemu/src/util/<a href=3D"http://mod.rs" rel=3D"=
noreferrer" target=3D"_blank">mod.rs</a><br>
new file mode 100644<br>
index 0000000..be00d0c<br>
--- /dev/null<br>
+++ b/qemu/src/util/<a href=3D"http://mod.rs" rel=3D"noreferrer" target=3D"=
_blank">mod.rs</a><br>
@@ -0,0 +1 @@<br>
+pub mod foreign;<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000e6ac68061c573e27--

