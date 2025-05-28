Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C139C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 13:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKGaw-0003vf-Pr; Wed, 28 May 2025 09:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKGas-0003ux-0h
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKGak-0005NV-4z
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748437988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSyq00FxFp/uB3JwzlqpcOQEDruq/lkLgFqqcLgJeBk=;
 b=ZsfYDTOY8vLuenzzUxNYcCu/rn70zG8UK+mzbGti+M7XmiKFmVcls1WXLOUJ26oN4oyn7R
 dCLVfneQjTHFOHfmuvmjRz+kNhltXDki4f6i+i8JEEpSl27ZAO7+88VwehEkSwaqOyPjiI
 lEMlNvIqom7C8EE8MYb7oqTfpuUWnMw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-TVa7NnUBPLiOzzrkIjzr1w-1; Wed,
 28 May 2025 09:13:03 -0400
X-MC-Unique: TVa7NnUBPLiOzzrkIjzr1w-1
X-Mimecast-MFC-AGG-ID: TVa7NnUBPLiOzzrkIjzr1w_1748437982
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 309D41800256; Wed, 28 May 2025 13:13:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 772CA1944B05; Wed, 28 May 2025 13:13:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97F3A21E675E; Wed, 28 May 2025 15:12:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org
Subject: Re: [PATCH 07/12] qemu-api: add bindings to Error
In-Reply-To: <CABgObfY1tAEEy70RSW78Tn+s+xRPw9xXSRmFU-QVYLRLe20SYQ@mail.gmail.com>
 (Paolo Bonzini's message of "Wed, 28 May 2025 12:45:10 +0200")
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-7-pbonzini@redhat.com>
 <87o6vddpzm.fsf@pond.sub.org>
 <CABgObfY1tAEEy70RSW78Tn+s+xRPw9xXSRmFU-QVYLRLe20SYQ@mail.gmail.com>
Date: Wed, 28 May 2025 15:12:58 +0200
Message-ID: <87o6vcdgkl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Wed, May 28, 2025 at 11:49=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>> > diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
>> > new file mode 100644
>> > index 00000000000..f08fed81028
>> > --- /dev/null
>> > +++ b/rust/qemu-api/src/error.rs
>> > @@ -0,0 +1,273 @@
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> > +
>> > +//! Error class for QEMU Rust code
>> > +//!
>> > +//! @author Paolo Bonzini
>> > +
>> > +use std::{
>> > +    borrow::Cow,
>> > +    ffi::{c_char, c_int, c_void, CStr},
>> > +    fmt::{self, Display},
>> > +    panic, ptr,
>> > +};
>> > +
>> > +use foreign::{prelude::*, OwnedPointer};
>> > +
>> > +use crate::{
>> > +    bindings,
>> > +    bindings::{error_free, error_get_pretty},
>> > +};
>> > +
>> > +pub type Result<T> =3D std::result::Result<T, Error>;
>> > +
>> > +#[derive(Debug, Default)]
>> > +pub struct Error {
>>
>> We're defining a custom error type Error for use with Result<>.  This
>> requires implementing a number of traits.  For trait Debug, we take the
>> auto-generated solution here.  Other traits are implemented below, in
>> particular Display.
>>
>> I don't yet understand the role of trait Default.
>
> It defines an Error without any frills attached. It is used below but
> on the other hand it results in those "unknown error"s that you
> rightly despised.

I think I understand how this works now.

>> Does the name Error risk confusion with std::error::Error?
>
> Maybe, but as you can see from e.g. ayhow::Error it's fairly common to
> have each crate or module define its own Error type. In the end you
> always convert them to another type with "?" or ".into()".

Fair enough.

>> This is the Rust equivalent to C struct Error.  High-level differences:
>>
>> * No @err_class.  It's almost always ERROR_CLASS_GENERIC_ERROR in C
>>   nowadays.  You're hardcoding that value in Rust for now.  Good.
>>
>> * @cause, optional.  This is the bridge to idiomatic Rust error types.
>>
>> * @msg is optional.  This is so you can wrap a @cause without having to
>>   add some useless message.
>>
>> Is having Errors with neither @msg nor @cause a good idea?
>
> It makes for slightly nicer code, and avoids having to worry about
> panics from ".unwrap()" in error handling code (where panicking
> probably won't help much). Otherwise it's probably not a good idea,
> but also not something that people will use since (see later patches)
> it's easier to return a decent error message than an empty Error.

I accept that making "need at least one of @msg, @cause" an invariant
could complicate the code a bit.

Having a way to create an Error with neither bothers me, even when it's
obscure.  Making an interface hard to misuse is good.  Making it
impossible to misuse is better.

>> Needed for what?  Oh, method description() is deprecated since 1.42.0:
>> "use the Display impl or to_string()".  I figure we need it because the
>> new way doesn't work with our oldest supported Rust version.  Could
>> perhaps use a comment to help future garbage collectors.
>>
>> > +    fn description(&self) -> &str {
>> > +        self.msg
>> > +            .as_deref()
>> > +            .or_else(|| self.cause.as_deref().map(std::error::Error::=
description))
>> > +            .unwrap_or("error")
>>
>> This gives us @msg, or else @cause, or else "error".
>>
>> Is it a good idea to ignore @cause when we have @msg?
>
>> > +impl Display for Error {
>> > +    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
>> > ...
>> > +    }
>>
>> This combines @msg and @cause:
>>
>> Differs from description().  Why?
>
> Because description() cannot build a dynamically-allocated string, it
> must return something that is already available in the Error. That
> limitation is probably why it was deprecated.
>
> Since it's deprecated we can expect that it won't be used and not
> worry too much.

Could we somehow get away with not implementing it?

>> > +    fn from(msg: String) -> Self {
>> > +        let location =3D panic::Location::caller();
>> > +        Error {
>> > +            msg: Some(Cow::Owned(msg)),
>> > +            file: location.file(),
>> > +            line: location.line(),
>> > +            ..Default::default()
>>
>> I don't understand this line, I'm afraid.
>
> It says "every other field comes from "..Default::default()". I can
> replace it with "cause: None", and likewise below.

I've since learned a bit more about Default.  Since the only field being
defaulted is @cause, I guess I'd use "cause: None" myself for
simplicity.  Matter of taste, you choose.

However, if this is the only real reason for Error having the Default
trait, I'd suggest to kill the trait with fire, because ...

>> > +}
>> > +
>> > +impl From<&'static str> for Error {
>> > +    #[track_caller]
>> > +    fn from(msg: &'static str) -> Self {
>> > +        let location =3D panic::Location::caller();
>> > +        Error {
>> > +            msg: Some(Cow::Borrowed(msg)),
>> > +            file: location.file(),
>> > +            line: location.line(),
>> > +            ..Default::default()
>> > +        }
>> > +    }
>> > +}
>>
>> Same for another string type.
>
> Yes, this is for strings that are not allocated and are always
> valid---such as string constants.
>
>> Is there a way to create an Error with neither @msg nor @cause?
>
> Yes, Default::default()

... I do dislike being able to create such Errors :)

>> > +        errp: *mut *mut bindings::Error,
>> > +    ) -> Option<T> {
>> > +        let Err(err) =3D result else {
>> > +            return result.ok();
>> > +        };
>> > +
>> > +        // SAFETY: caller guarantees errp is valid
>> > +        unsafe {
>> > +            err.propagate(errp);
>> > +        }
>> > +        None
>>
>> @result is an Error.  Propagate it, and return None.
>>
>> This is indeed like self.ok() with propagation added.
>
> Alternatively:
>
>     result
>        .map_err(|err| unsafe { err.propagate(errp) })
>        .ok()
>
> Shorter, but the functional style can be off putting. What do you prefer?

I'm fine with the functional style, and I like brevity.

>> > +    }
>> > +
>> > +    /// Equivalent of the C function `error_propagate`.  Fill `*errp`
>> > +    /// with the information container in `result` if `errp` is not N=
ULL;
>> > +    /// then consume it.
>>
>> Note error_propagate() has the arguments in the opposite order.
>
> Yeah, here "self" must be first so that you use it as a method.
> Though, s/result/self/ as you noted.
>
>> > +    /// # Safety
>> > +    ///
>> > +    /// `errp` must be valid; typically it is received from C code
>>
>> What does "valid" mean exactly?
>
> I will copy from `error_propagate` in v2.
>
>> Brief switch to the design level...
>>
>> In C, you're almost always better off with ERRP_GUARD().  Would you like
>> me to elaborate?
>>
>> You still have to use error_propagate() to accumulate multiple errors so
>> that the first one wins.  That's commonly a dumb idea.  Should we avoid
>> this pattern in Rust?
>
> In Rust there are three kinds of functions that use errors. Two are in qe=
mu_api:
>
> (1) bridges from C to Rust function pointers. They receive a Result<>
> from Rust functions and use error_propagate() (probably via functions
> such as ok_or_propagate, bool_or_propagate, etc.) to prepare a C
> return value.

We received an idiomatic Rust Result<>.  We want to pass it to a C-like
caller, i.e. satisfy the contract "on success, return a value and leave
argument @errp alone; on error, return an error value and store an Error
object in @errp".

(I'm ignoring void values for brevity)

The functions you mentioned split up the Result<>, do the storing, and
return the value to be returned.

> (2) bridges from Rust to C functions. They pass an Error** to the C
> function and use err_or_else() or err_or_unit() to prepare a Rust
> return value

We received a return value and possibly a C Error object.  We want to
pass it to a Rust caller, i.e. return an idiomatic Result<>.

The functions you mentioned assemble the Result<> from the two values.

There's difference between Result<> and what we do in C: Result<> is
either a success value or an Error value.  I.e. we have a success value
on success, an Error on failure.  In C, we have a success value on
success, and both an error value and an Error on failure.

The (1) functions need to make up the missing error value.  That's fine,
it's what we do in C, too.

The (2) functions throw away the error value.  Usually, there's exactly
one error value, so no information is thrown away.  But not necessarily.

I think it's okay to design for the common case now.

> Functions of kind (1) are like functions in C that do a single call
> and just pass down errp, for example user_creatable_add_qapi(). These
> do not need ERRP_GUARD() because:
>
> * the conversion from Result<> to C is pretty much a necessity, and
> it's done with functions that guarantee the propagation
>
> * the conversion function *consumes* the Result<>, guaranteeing that
> you do not propagate more than once with tragic results
>
> Function of kind (2) do not need ERRP_GUARD() because they do not take
> an Error** at all. They pass one down to C, but they return a
> Result<>.
>
> The third kind is Rust functions that are called from (1) and that
> themselves call (2). These are where ERRP_GUARD() would be used in C,
> but in Rust these do not see Error** at all. The "?" operator has the
> same effect as ERRP_GUARD(), i.e. it handles passing the error from
> called function to return value. What in C would be
>
>    ERRP_GUARD();
>    if (!func_that_returns_bool(...)) { return; }
>
> In Rust is
>
>    func_that_returns_result(...)?;
>
> which is a bit disconcerting in the beginning but grows on you.
> (Generally I find that to be the experience with Rust. It's downright
> weird, but unlike C++ the good parts outweigh the weirdness).
>
>> > +    pub unsafe fn err_or_unit(c_error: *mut bindings::Error) -> Resul=
t<()> {
>> > +        // SAFETY: caller guarantees c_error is valid
>> > +        unsafe { Self::err_or_else(c_error, || ()) }
>> > +    }
>> > +
>> > +    /// Convert a C `Error*` into a Rust `Result`, calling `f()` to
>> > +    /// obtain an `Ok` value if `c_error` is NULL.
>> > +    ///
>> > +    /// # Safety
>> > +    ///
>> > +    /// `c_error` must be valid; typically it has been filled by a C
>> > +    /// function.
>> > +    pub unsafe fn err_or_else<T, F: FnOnce() -> T>(
>> > +        c_error: *mut bindings::Error,
>> > +        f: F,
>> > +    ) -> Result<T> {
>> > +        // SAFETY: caller guarantees c_error is valid
>> > +        let err =3D unsafe { Option::<Self>::from_foreign(c_error) };
>> > +        match err {
>> > +            None =3D> Ok(f()),
>> > +            Some(err) =3D> Err(err),
>> > +        }
>> > +    }
>> > +}
>>
>> Getting tired...
>
> No problem. While this is kinda important, it's not used yet. The
> clients would look like this:
>
> fn type_get_or_load_by_name(name: &str) -> Result<&TypeImpl> {
>    unsafe {
>        let err: *mut bindings::Error =3D ptr::null_mut();
>        let typ: *mut TypeImpl =3D bindings::type_get_or_load_by_name(
>            name.clone_to_foreign().as_ptr(), &mut err);
>        // on success, "typ" can be accessed safely
>        // on failure, turn the Error* into a qemu_api::Error and free it
>        Result::err_or_else(err, || &*typ)
> }
>
> This is why I need to write tests.
>
>> > +impl CloneToForeign for Error {
>> > +    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
>> > +        // SAFETY: all arguments are controlled by this function
>> > +        unsafe {
>> > +            let err: *mut c_void =3D libc::malloc(std::mem::size_of::=
<bindings::Error>());
>> > +            let err: &mut bindings::Error =3D &mut *err.cast();
>> > +            *err =3D bindings::Error {
>> > +                msg: format!("{self}").clone_to_foreign_ptr(),
>> > +                err_class: bindings::ERROR_CLASS_GENERIC_ERROR,
>> > +                src_len: self.file.len() as isize,
>> > +                src: self.file.as_ptr().cast::<c_char>(),
>> > +                line: self.line as c_int,
>> > +                func: ptr::null_mut(),
>> > +                hint: ptr::null_mut(),
>> > +            };
>> > +            OwnedPointer::new(err)
>> > +        }
>> > +    }
>> > +}
>>
>> Plausible to this Rust ignoramus :)
>
> Good, since these *Foreign traits are not part of the standard
> library, but rather something that I concocted and published outside
> QEMU. If you had no problems understanding how they were used (e.g.
> stuff like into_native or clone_to_foreign_ptr), that is good.

"Understanding" is a bit strong.  I relied on my voodoo-programming
skills.

Thank you!


