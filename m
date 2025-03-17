Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCD9C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuE7Q-0002aJ-Ol; Mon, 17 Mar 2025 13:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuE7N-0002XP-PW
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuE7H-0000KD-VO
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742231945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8NJrv2Q9OBORs8r9pbAIuyVL4ieLBQVOb1zFdbodMI=;
 b=bjLrmP9K57W8EDrIZo+T4hPQsuRcvTsy6lp9bauzuM7Bg3BKiG66Fnzuf+ofhm36ngv6VC
 Z7low8ZEjSF6qRfbCI8Oe++VTYQizFzTzoHb4CoUoV1bBijlzjf0PyvbxpDCYYaaDRDSc2
 uz3PjUdBK+1MhxgpiqJ8etIX/QjHOlA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-g0y30IDFOo6y4Lb1_HaZ9w-1; Mon, 17 Mar 2025 13:19:01 -0400
X-MC-Unique: g0y30IDFOo6y4Lb1_HaZ9w-1
X-Mimecast-MFC-AGG-ID: g0y30IDFOo6y4Lb1_HaZ9w_1742231940
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913aaf1e32so3027599f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 10:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742231939; x=1742836739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8NJrv2Q9OBORs8r9pbAIuyVL4ieLBQVOb1zFdbodMI=;
 b=o59QuWkW1TWRCYBnNg3u2iO7lnXWU8dSzWVEZ72owtLozhbGeWC/AYKdl3Wjw4OF4F
 Q7enSx9dIrkDqz8e3meL88Od5V3HvDZWQ56EAzlLm2ZZ14LHMPD2LN/qZDoNTVwmgBat
 Ak+3b2GYRMYXxD+89KIMKmaK9+KswqP9X/8w42JiW7fq1QwxfVyzaZNLFZoQyCyIYCB/
 CegdVWrJSBG/ySrek6qjOIDrmIuPTlwQa5aSUVCnsEsg/DKQ+6sLpK/1MaisopeAy2qq
 Ec4j/WzO2SRrRGVOX/35nEPNXYEdoE2GJpUGu8OYcs80Givxh+bBLoimUtBuqIk847El
 Qd+A==
X-Gm-Message-State: AOJu0YyPaWZrJ1Le0pnMbTL2cpZpmqK4ynocNcfC3gkMRIbAsjBHQDcs
 SVBwUwOemyD5Gfd+FspG/Cv7WNSnm2axIZSj6oj5/VMHP6l77dRKXsEK63sDoiLZ/wDOpMIot2/
 kT3bJfprBl/JtMqHu9R21bPRdAu0Y8kAriPZP3qjrIuMZV9oKrWTgZ/zRx6akAWVjNAl6ECkUHj
 kOOGBqnGCB06mkcWJEWYRhEYEI6o6A52KJnWrOPQ==
X-Gm-Gg: ASbGnctcjTXnxAlFfn4HVwHTx2pANGXSDeYQVmfPf3jjGobUBtVgaxiO5TfcfviiaCy
 gmM93zq97p504W2NpyxxXX5aAKbAkmmkQTYTZ+lF08W0Nkns5mdFrt5l80xqhrxtY8z5a9CWNQQ
 ==
X-Received: by 2002:a5d:598c:0:b0:391:476f:d3b7 with SMTP id
 ffacd0b85a97d-3971f510ec0mr13263889f8f.49.1742231938610; 
 Mon, 17 Mar 2025 10:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8WIGrTRbXgmT4BGu4xkUEVjrJpV5Rky8OP0QSB/XAKX16wiUEhTXywDoItkWjv2Llu5BroBtww9yTtg7xVGw=
X-Received: by 2002:a5d:598c:0:b0:391:476f:d3b7 with SMTP id
 ffacd0b85a97d-3971f510ec0mr13263863f8f.49.1742231938240; Mon, 17 Mar 2025
 10:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-14-zhao1.liu@intel.com>
In-Reply-To: <20250317151236.536673-14-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Mar 2025 18:18:46 +0100
X-Gm-Features: AQ5f1JqnGoPEsjNRryfrzw6iWM9h_4dDL3AIFUfQ-PyJ3C5NtVwVwU99JsjbAGo
Message-ID: <CABgObfauvyAbmt7GewurAEw9d+HanhjvDa1tT=S_4Oo9Huty0g@mail.gmail.com>
Subject: Re: [PATCH 13/17] rust/vmstate: Support vmstate_validate
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 17, 2025 at 3:52=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> In C version, VMSTATE_VALIDATE accepts the function pointer, which is
> used to check if some conditions of structure could meet, although the
> C version macro doesn't accept any structure as the opaque type.
>
> But it's hard to integrate VMSTATE_VALIDAE into vmstate_struct, a new
> macro has to be introduced to specifically handle the case corresponding
> to VMSTATE_VALIDATE.
>
> One of the difficulties is inferring the type of a callback by its name
> `test_fn`. We can't directly use `test_fn` as a parameter of
> test_cb_builder__() to get its type "F", because in this way, Rust
> compiler will be too conservative on drop check and complain "the
> destructor for this type cannot be evaluated in constant functions".
>
> Fortunately, PhantomData<T> could help in this case, because it is
> considered to never have a destructor, no matter its field type [*].
>
> The `phantom__()` in the `call_func_with_field` macro provides a good
> example of using PhantomData to infer type. So copy this idea and apply
> it to the `vmstate_validate` macro.
>
> [*]: https://doc.rust-lang.org/std/ops/trait.Drop.html#drop-check
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 57 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index bb41bfd291c0..4eefd54ca120 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -25,9 +25,12 @@
>  //!   functionality that is missing from `vmstate_of!`.
>
>  use core::{marker::PhantomData, mem, ptr::NonNull};
> +use std::os::raw::{c_int, c_void};
>
>  pub use crate::bindings::{VMStateDescription, VMStateField};
> -use crate::{bindings::VMStateFlags, prelude::*, qom::Owned, zeroable::Ze=
roable};
> +use crate::{
> +    bindings::VMStateFlags, callbacks::FnCall, prelude::*, qom::Owned, z=
eroable::Zeroable,
> +};
>
>  /// This macro is used to call a function with a generic argument bound
>  /// to the type of a field.  The function must take a
> @@ -292,6 +295,14 @@ pub const fn with_varray_multiply(mut self, num: u32=
) -> VMStateField {
>          self.num =3D num as i32;
>          self
>      }
> +
> +    #[must_use]
> +    pub const fn with_exist_check(mut self) -> Self {
> +        assert!(self.flags.0 =3D=3D 0);
> +        self.flags =3D VMStateFlags(VMStateFlags::VMS_MUST_EXIST.0 | VMS=
tateFlags::VMS_ARRAY.0);
> +        self.num =3D 0; // 0 elements: no data, only run test_fn callbac=
k
> +        self
> +    }
>  }
>
>  /// This macro can be used (by just passing it a type) to forward the `V=
MState`
> @@ -510,6 +521,50 @@ macro_rules! vmstate_fields {
>      }}
>  }
>
> +pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T=
, u8), bool>>(
> +    opaque: *mut c_void,
> +    version_id: c_int,
> +) -> bool {
> +    let owner: &T =3D unsafe { &*(opaque.cast::<T>()) };
> +    let version: u8 =3D version_id.try_into().unwrap();
> +    // SAFETY: the opaque was passed as a reference to `T`.
> +    F::call((owner, version))
> +}
> +
> +pub type VMSFieldExistCb =3D unsafe extern "C" fn(
> +    opaque: *mut std::os::raw::c_void,
> +    version_id: std::os::raw::c_int,
> +) -> bool;
> +
> +#[doc(alias =3D "VMSTATE_VALIDATE")]
> +#[macro_export]
> +macro_rules! vmstate_validate {
> +    ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) =3D> {
> +        $crate::bindings::VMStateField {
> +            name: ::std::ffi::CStr::as_ptr($test_name),
> +            // TODO: Use safe callback.

Why is the TODO still there?

> +            field_exists: {
> +                const fn test_cb_builder__<
> +                    T,
> +                    F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bo=
ol>,
> +                >(
> +                    _phantom: ::core::marker::PhantomData<F>,
> +                ) -> $crate::vmstate::VMSFieldExistCb {
> +                    let _: () =3D F::ASSERT_IS_SOME;
> +                    $crate::vmstate::rust_vms_test_field_exists::<T, F>
> +                }
> +
> +                const fn phantom__<T>(_: &T) -> ::core::marker::PhantomD=
ata<T> {
> +                    ::core::marker::PhantomData
> +                }
> +                Some(test_cb_builder__::<$struct_name, _>(phantom__(&$te=
st_fn)))
> +            },
> +            ..$crate::zeroable::Zeroable::ZERO
> +        }
> +        .with_exist_check()
> +    };

Would it be possible, or make sense, to move most of the code for
field_exists inside .with_exist_check()?

Paolo


