Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8512CDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 20:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suHQy-0004ps-Hp; Fri, 27 Sep 2024 16:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1suHQx-0004pD-Cj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 16:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1suHQt-0000nE-RJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 16:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727468356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AySi5D3ljbTpaTmQBhtLY91bjoABGKRgTPQ+fMtGr5I=;
 b=DEbSFMm4os9WduzD89ZeKkqhFxsro9h/ChzWja1QyX06cgx+C4OuDplhv64VRCCo6Q0ESx
 UrGfzLs4hupgyxK2qZ6nwte4JcicGhTJO3ZyK7YVTib0xPmXl4CEgCDp4FyLS/a8MpdA1h
 ZjVl4TP3AOEjcPFvm8PA9dCSTz7pfjg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-PA1YUXUhPxuE-iDRNoSXAg-1; Fri, 27 Sep 2024 16:19:15 -0400
X-MC-Unique: PA1YUXUhPxuE-iDRNoSXAg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb050acc3so13854635e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 13:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727468354; x=1728073154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AySi5D3ljbTpaTmQBhtLY91bjoABGKRgTPQ+fMtGr5I=;
 b=szQAEwroxVBRoQGd7RKltAg3kfStdqs9oZUASHqRw1Ln5clzA+ZIiZeDTS9KqBvhx/
 TCkaiaojxwsNlqSwND1wUjSoZ3kRWEujDmE1SVsPHMh+GyHnCCPWcEopnrxYNIYcUhug
 2wkvBlbP7WW2zgYliUJ3q8M5GLg5YnbqldFIwcO83qHvuENQabU6O48NXk4hW510f8aT
 jMX09jJOhXQJhP8Hg2wj7ciUcr4F0euueNnW6a3czigWZSyBarVtRFNtmdwuZ7snX3Gl
 wAEmnlV6OAhhTApa1mm261aJabJDdkG1tGORMTbAtwZYV6FUYq6YKxA3Jd/RrwFX8E6C
 P2sA==
X-Gm-Message-State: AOJu0Yz8/7xy/1nte6X+Wj7pyEVAayMUllKZPTGdyfNcb9XMXsBeIEqo
 pHOr2my1P4wztc17vT60htc8HTrOp/plT+ol0F3PtjVmohMAJhm0JJU81RJAnlweML06F34G7Cv
 xp8zknwyXQ0T4GOE7FUX3wAMoxID/1H0lWJ3l3IQn97KL9l7/8CcIcEcF7JNxeCfTjPGAQsH8K5
 fVQH8rv3I/yB+7lqSoJg2+5ESt9XU=
X-Received: by 2002:a05:600c:3542:b0:42c:bd4d:e8d6 with SMTP id
 5b1f17b1804b1-42f57f5d908mr27816595e9.3.1727468353820; 
 Fri, 27 Sep 2024 13:19:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/07ggdRM2zDzwQ+pMjoQCDLsCUYhwU3XD2rWYsM6mlkw191Mv8PDFm/0vE6GpKK5i+v0SaGgyEAq+eR7Jxyg=
X-Received: by 2002:a05:600c:3542:b0:42c:bd4d:e8d6 with SMTP id
 5b1f17b1804b1-42f57f5d908mr27816525e9.3.1727468353466; Fri, 27 Sep 2024
 13:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <20240701145853.1394967-4-pbonzini@redhat.com>
 <ZvbY0PMWmJPZN7Sq@redhat.com>
In-Reply-To: <ZvbY0PMWmJPZN7Sq@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Sep 2024 22:19:00 +0200
Message-ID: <CABgObfZFPtACPKLgkFninr+Nm5YYG7qent-G4YTYBX2pORAMsg@mail.gmail.com>
Subject: Re: [PATCH 03/14] rust: define traits and pointer wrappers to convert
 from/to C representations
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Sep 27, 2024 at 6:10=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
> Am 01.07.2024 um 16:58 hat Paolo Bonzini geschrieben:
> > The qemu::util::foreign module provides:
> >
> > - A trait for structs that can be converted to a C ("foreign") represen=
tation
> >   (CloneToForeign)
> >
> > - A trait for structs that can be built from a C ("foreign") representa=
tion
> >   (FromForeign), and the utility IntoNative that can be used with less =
typing
> >   (similar to the standard library's From and Into pair)
>
> It makes sense to me that we'll need something to convert data and that
> this usually means creating a new instance, i.e. cloning. However, while
> it's obvious that this is similar to From/Into, the part I'm missing
> here is what's different from it.
>
> In other words, couldn't we just implement the normal From trait between
> FFI types and the native equivalent?

In general yes. Using new traits has two advantages (all IMHO of
course). First, it makes it possible to tie the implementation to the
availability of a freeing function; second, it makes it possible to
define this always, whereas From is limited by the orphan rule (you
cannot provide implementations of a trait for a struct unless you are
the crate that defines either the struct or the trait).

> > - Automatic implementations of the above traits for Option<>, supportin=
g NULL
> >   pointers
>
> This is nice.

... for example, you can't have such a blanket implementation "impl<T,
U: From<T>> From<T> for Option<U> {}".

> > - A wrapper for a pointer that automatically frees the contained data. =
 If
> >   a struct XYZ implements CloneToForeign, you can build an OwnedPointer=
<XYZ>
> >   and it will free the contents automatically unless you retrieve it wi=
th
> >   owned_ptr.into_inner()
>
> Something here feels off to me.
>
> At first, I thought it might be only about naming. This is not about
> owning the pointer (which you probably do anyway), but that the pointer
> owns the object it points to. This concept has in fact a name in Rust:
> It's a Box.
>
> The major difference compared to Box is that we're using a different
> allocator. Not sure if the allocator APIs would actually be viable, but
> they're not stable anyway - but let's at least name this thing in way
> that draws the obvious parallel. Maybe ForeignBox.
> But the other thing that doesn't feel quite right is how this is coupled
> with CloneToForeign. Freeing is different from cloning, and it really
> relates to the foreign type itself, and not to the one that can be
> cloned into a foreign type.

I am not 100% convinced of the ForeignBox name but I see your point.
You'd prefer to have "impl FreeForeign for c_char" and "impl
CloneToForeign for str", where it's the CloneToForeign::Foreign
associated type (in this case c_char) that must implement FreeForeign.
Also, clone_to_foreign() for a str would return an
OwnedPointer<c_char>, not an OwnedPointer<str>. Never be too
optimistic about Rust, but that should be doable and I agree it is
better.

> Bringing both together, what a Box doesn't usually have is a function
> pointer for freeing. We probably don't need it here either, almost
> everything needs g_free().

Is that true? For example we could have qobject_unref, or qapi_free_*
as implementations of FreeForeign.

> There is a different free_foreign()
> implementation for Error, but arguably this could be changed:
> bindings::Error should then implement Drop for the inner value (with an
> error_free_inner() which needs to be exported separately from C first),
> and then ForeignBox can just drop the Error object and g_free() the
> pointer itself like it would do with any other value.

I think that's a bit too magical. Making Error always represent an
owned object seems a bit risky; instead I'm treating the bindings::XYZ
structs as very C-like objects, that are usually managed through
either OwnedPointer<...> (e.g. for a parameter) or *mut XYZ (for a
return value).

Thanks for looking at this. This kind of review is something that
we'll have to do a lot and it's better to have some early experience
of what they look like, independent of whether this code ultimately
will or will not be part of QEMU.

Paolo


