Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26B2C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 15:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP2Kk-0001EQ-Io; Wed, 03 Jul 2024 11:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sP2Ki-0001E1-Vo
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 11:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sP2Kg-0000qA-Q3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 11:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720022145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhLVMBTm+kvqFl+iW+xo6f9bBAJ2D0QG8QRM/faRBiI=;
 b=Z2LS0IJUXMScpPLgwIvGESPShlFhWxQ5pidTkNDQFuEjdSVdNKXDAbnFDGpo1UhLJLr2m3
 DTaT+qOGI1UFqqtIA7VmZjzQh2c+XmdUB6f3HA0XoBI2mPj+WpvEcbUEBjQwr5zUpmY/oa
 QrNq26L3c3z0lk2yLKs0G2yBVwSahLs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ThZ7K_hcNMu00GVqwZj3JQ-1; Wed, 03 Jul 2024 11:55:42 -0400
X-MC-Unique: ThZ7K_hcNMu00GVqwZj3JQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42568f0cc18so39240795e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 08:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720022141; x=1720626941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhLVMBTm+kvqFl+iW+xo6f9bBAJ2D0QG8QRM/faRBiI=;
 b=eLPTqTtJRvrWs7WXemEAL27YQC/EAuMedgmxmhbFGQHuAyKvyt/DX84Ntwn5/4ZrXl
 UGWPWDeHAzTzl5NjOvjPlJ4bToaN4ZOrBI9LP4LHjjSyJWJBtugM2NR0XQCir+6aNGqh
 kKnlgNd6GflLib4F7dVzN4Yqgu0JqAC19AtuNj/BIoL8386pHfgzwMwEgXmMrfPjKjN7
 ZLbYGhPlBaORA1JRpC81aUOF3TUb53aoCwi6ltXoOPfR79y2uPpz3n/6ce9dJJrgLDox
 DJPZE9Knjn4KkJkvaBH6B319zy5W5tRA8IQu4h8ubLR5I9b7w/c5durkTUGeyt1GCi9u
 gQnA==
X-Gm-Message-State: AOJu0Yzzt2ySqtCk8yJTLYXpyKHAhHFdfFxM8ULj691YKJ99LvEuIxw9
 ROqC8S4sGXIlORs2I1b+4MoClHlyvV8OcS0MRV5ev77pyI/I+e6BfUH9ownlhRRaBf2tMWp0eho
 J9wOmID5mySc/Ni2A/2zX1DttfDopQlbGMtk+pf63Kbe/j2Ny0GjGBH/pwPh2tgp2YlgAIbtnXb
 S7Vf0dS66h00UTwkW7coAxTSDwwD0=
X-Received: by 2002:a05:600c:2d52:b0:425:78fd:ec51 with SMTP id
 5b1f17b1804b1-4257a03497emr61736675e9.40.1720022141620; 
 Wed, 03 Jul 2024 08:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXHvEdeaiJnv9nOS8SSyi2712ERiP1gyoJhBP+DhA+1EVKWRX1TdNmTgV0hbmacFwtB4N2nL891/NT83GHG+w=
X-Received: by 2002:a05:600c:2d52:b0:425:78fd:ec51 with SMTP id
 5b1f17b1804b1-4257a03497emr61736475e9.40.1720022141172; Wed, 03 Jul 2024
 08:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <20240701145853.1394967-4-pbonzini@redhat.com>
 <CAJ+F1C+__WX3EUFw-XdsqtXbwFtH0JZJdNH3WDvFazkNnecAbw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+__WX3EUFw-XdsqtXbwFtH0JZJdNH3WDvFazkNnecAbw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 3 Jul 2024 17:55:29 +0200
Message-ID: <CABgObfaF4FMPWYq7xQ3uWYx=O0XW_+0CWgw6hQTwUMgCQcPK-Q@mail.gmail.com>
Subject: Re: [PATCH 03/14] rust: define traits and pointer wrappers to convert
 from/to C representations
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Sebastian_Dr=C3=B6ge?= <slomo@circular-chaos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

[warning: long email]

On Wed, Jul 3, 2024 at 2:48=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> (adding Sebastian, one of the glib-rs developers in CC)
>
> On Mon, Jul 1, 2024 at 7:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>>
>> The qemu::util::foreign module provides:
>>
>> - A trait for structs that can be converted to a C ("foreign") represent=
ation
>> - A trait for structs that can be built from a C ("foreign") representat=
ion
>> - A wrapper for a pointer that automatically frees the contained data.
>
> You worry about technical debt, and I do too. Here you introduce quite di=
fferent traits than what glib-rs offers.
> We already touched this subject 2y ago, my opinion didn't change much
> (https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redha=
t.com/20210907121943.3498701-13-marcandre.lureau@redhat.com/)

Hi Marc-Andr=C3=A9, first of all thanks for reviewing and, probably, sorry
for not going more into detail as to why I reinvented this particular
wheel.

Like two years ago, I find the full/none nomenclature very confusing
and there is no trace of them in QEMU, but I could get over that
easily.

But also, I think the two have different focus and design. All I
wanted was a place to put common code to convert Rust objects (mostly
CStr/String/str and Error) to and from C representations (char * and
QEMU's Error*), to avoid rewriting it over and over. So I wanted the
traits to be as simple as possible, and I didn't like that glib puts
to_glib_none and to_glib_full into the same trait, though I understand
why it does so. I also didn't like that to_glib_full() is an express
ticket to a memory leak. :)

OwnedPointer<> and free_foreign solve all the qualms I had with glib-rs:

- OwnedPointer<> takes care of freeing at the cost of extra verbosity
for ".as_ptr()".

- because clone_to_foreign() does not leak, I don't need to think
about to_glib_none() from the get go.

This has a ripple effect on other parts of the design. For example,
because glib has to_glib_none(), its basic design is to never allocate
malloc-ed memory unless ownership of the pointer is passed to C.
glib-rs's to_glib_none can and will "clone to Rust-managed memory" if
needed. Instead, because I have free_foreign(), I can malloc freely.

In the future we could add something like Stash/to_glib_none(), but it
would be very different and with performance properties enforced by
the type system. It would "create a pointer into *existing*
Rust-managed memory" cheaply but, every time a cheap borrow is not
possible, users will have to call clone_to_foreign() explicitly. In
other words there will be a difference between OwnedPointer<> as the
result of an expensive operation, and [the equivalent of glib-rs]
Stash as the result of a cheap operation. This is unlike
to_glib_none() which is e.g. cheap for CStr but not for String. More
on this below.

> Also, you don't offer the equivalent of "to_glib_none" which uses a tempo=
rary stash and is quite useful, as a majority of functions don't take owner=
ship.

Right, in part you have already answered that: OwnedPointer handles
freeing in the same way as g_autofree, so you can use it as a
to_glib_none() replacement. If you need to pass the pointer and forget
about it, you can use clone_to_foreign_ptr(). If you need something
temporary that needs to be freed before returning, you use
clone_to_foreign() and as_ptr().

This is not any more unsafe than to_glib_none(). If you pass a
temporary pointer (x.clone_to_foreign().as_ptr()) where C code expects
full ownership, you get a dangling pointer either way. It is less
leak-happy than to_glib_full() though.

Regarding how to obtain a pointer cheaply, there are two use cases:

- borrow:

  fn borrow_foreign<'a>(&'a self) -> Stash<'a,
      <Self as CloneToForeign>::Foreign, &'a Self>;

Useful for slices and elementary integer types - including cases where
C parameters are passed by reference - and also for CStr. However
right now my main user is strings and it doesn't buy much there.
Because String and &str are not null-terminated, a "borrow" would
allocate memory, as in to_glib_none(), which is pretty weird. At this
point, I find it better to have the more explicit clone_to_foreign()
that tells you how expensive it is.

- consumption, which does not exist in glib-rs:

    fn into_foreign(self) -> Stash<'static,
      <Self as CloneToForeign>::Foreign, Self>;

This works for types that, like String, deref to a stable address even
when moved---this way we don't need to deal with pinning. And it is in
fact especially nice for the String case and therefore for anything
that uses format!(), because it could be implemented as

   s.reserve_exact(1);
   s.push('\0');

The two would be separate traits. There was one case in which I could
have used into_foreign(), namely the call to error_setg_internal() in
patch 5. But I am not sure if this will be more common than functions
taking &str, so I left it for later.

> Because much of our code is using GLib types and API style, I
> think we should strive for something that is close (if not just the
> same) to what glib-rs offers. It's already hard enough to handle
> one binding concept, having 2 will only make the matter worse.
> Consider a type like GHashTable<GUuid, QOM>, it will be very
> annoying to deal with if we have different bindings traits and
> implementations and we will likely end up duplicating glib-rs
> effort.

I'm not even sure if it's even true that much QEMU code is using GLib
types. We use quite a bit of GLib, and took a lot of inspiration from
it because GLib is good. But it's notable that we use very little GLib
*across modules*. There are only a handful of occurrences to
GList/GList/GHashTable in function arguments in include/, for all of
QEMU, and all of them are very rarely used functions. Why? Possibly
because, even where we take inspiration (the Error** idiom, QOM
casts), the implementation ends up completely different for reasons
that aren't just NIH.

In any case I don't see us using glib-rs much, if at all; uses of hash
tables in Rust code can just use HashMap<>. Yes, there is no
equivalent of the expensive, O(n) conversion
self.some_g_hash_table.to_glib_none(); but that's a feature, not a
limitation.

Also, anyway we couldn't extend the glib traits a lot, and glib-rs
only supports HashMap<String, String>.

> As for naming & consistency, glib-rs settled on something clearer imho:
>
> from_glib_full
> from_glib_none
> to_glib_full
> to_glib_none
>
> vs
>
> from_foreign
> cloned_from_foreign
> clone_to_foreign
> /nothing/

These last two are respectively clone_to_foreign_ptr and
clone_to_foreign. I am not wed to my names but I'm not sure the glib
ones are clearer.

What I want from names is clarity on who allocates or frees; I do that
with "clone", which is a common Rust term, to indicate that the C side
still needs to be freed after the call. I find it confusing that
from_glib_full() requires no freeing but to_glib_full() requires
freeing, for example - I understand _why_ but still "full" and "none"
are GIR terms that are not really familiar to most Rust or QEMU
developers.

And secondarily, clarity on what is cheap and what isn't. I don't have
that functionality at all for now, but the nomenclature is easily
extended to borrow_foreign() and into_foreign(). Talking about Rust
terms, glib-rs lacks "into" which is the standard Rust way to do
consuming conversions, while my code has into_native().

All in all, I think there are some significant differences between
glib-rs and this implementation that justify the effort.


Paolo


