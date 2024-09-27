Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559F0CDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 20:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suHY8-0001G9-3Q; Fri, 27 Sep 2024 16:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1suHY6-0001F9-Up
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 16:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1suHXy-0002P0-Ux
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 16:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727468797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nGZkDKq7T/LiC60K6zbnsmg0M2mHJ0hN/DpGtlM0qdE=;
 b=HE9iHuQiGLSh+9rRGLBJhsiM/QIeYDfAP/GZSQpJFaDetgK+IRon4BDi2HHZEimXPpere0
 pXh4rhXTuRKBWE3L9MYzq7/I0KCOKDq24NnvB9jlx+63qo4XxfeyXrK6+xEtuLNIZKBf/F
 3Y01Dx11Y1jFGtqrYBJPqqky/np/4qQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Z9EYdZVqNuWmbx93QywCtg-1; Fri, 27 Sep 2024 16:26:32 -0400
X-MC-Unique: Z9EYdZVqNuWmbx93QywCtg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37cdb0e9eb7so384862f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 13:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727468791; x=1728073591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGZkDKq7T/LiC60K6zbnsmg0M2mHJ0hN/DpGtlM0qdE=;
 b=JDvhTjcvetQ3Jh7pasgPs8Q0miWvP54LMC8keVMKMKXvYix8qKHMMZwkHqvUQeQn8o
 1gAe8wL6J4JQM9aRrEJxgPmTea8FjoejYVDs5sTv91ihwOKHDUyX5n6xD8loalHJ9SoS
 ZCTLno7IuE3l0AfAGuIErhcK/ajpr0DUdr695//KaPRJuHD2hg4C1UAeRWX690XQK+P/
 xFdr7fgA19q/4NptAL3XkNNMDRV5UHBKBJsSA9ilzBdpev5ydy3yGVcFqp5qG+lmXGHo
 3aWoweXH2mmoNb6tixYPFyRrL1v3xefOH5UOWUQu9RftfpALC7H6nsN4mVUYX9oKVHJ6
 JxUQ==
X-Gm-Message-State: AOJu0YxgmHIgcNNrKwW8dyFeW/fnY0vU9i8CJydj7eOq//0mbqp6j4jD
 UYQs476UzNA8ZlE4w3CtcNJdSJOb6LhoQ5JE3IqpsAoopxA8ieUqW52hI7gQ4jFAct97yqViltz
 3SsrMTJ5r2HZLIgfSYik3wkAVO50vVo1xwUCcgayd0E7zmUpPhQGdLnzMb96zW2EzW0apKKd4p9
 GF3x6+rB0uzBQIxaXMYW6Tu01l8uE=
X-Received: by 2002:adf:eac5:0:b0:374:ca43:cda5 with SMTP id
 ffacd0b85a97d-37cd59e250amr2836367f8f.0.1727468791565; 
 Fri, 27 Sep 2024 13:26:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjqQtr6LZs5hAhnjw5XASX4VK5S3sr4fi//QjzfoLhVJ6S+gzyLXsv12oOxCzJL6WR/PwuFC37THEsjBGxgQk=
X-Received: by 2002:adf:eac5:0:b0:374:ca43:cda5 with SMTP id
 ffacd0b85a97d-37cd59e250amr2836354f8f.0.1727468791230; Fri, 27 Sep 2024
 13:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <20240701145853.1394967-4-pbonzini@redhat.com>
 <CAJSP0QU3iT9REzdciVZBhRWLtQXtoabJ9Jb=S9Maun1cDb+WFw@mail.gmail.com>
In-Reply-To: <CAJSP0QU3iT9REzdciVZBhRWLtQXtoabJ9Jb=S9Maun1cDb+WFw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Sep 2024 22:26:19 +0200
Message-ID: <CABgObfY=Lm_868Me7xqEk2zA+UGARbeH-4ELvBJn4tYucUCXJg@mail.gmail.com>
Subject: Re: [PATCH 03/14] rust: define traits and pointer wrappers to convert
 from/to C representations
To: Stefan Hajnoczi <stefanha@gmail.com>
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

On Fri, Sep 27, 2024 at 9:36=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Mon, 1 Jul 2024 at 11:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > +/// A type for which there is a canonical representation as a C datum.
> > +pub trait CloneToForeign {
> > +    /// The representation of `Self` as a C datum.  Typically a
> > +    /// `struct`, though there are exceptions for example `c_char`
> > +    /// for strings, since C strings are of `char *` type).
> > +    type Foreign;
> > +
> > +    /// Free the C datum pointed to by `p`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `p` must be `NULL` or point to valid data.
> > +    unsafe fn free_foreign(p: *mut Self::Foreign);
> > +
> > +    /// Convert a native Rust object to a foreign C struct, copying
> > +    /// everything pointed to by `self` (same as `to_glib_full` in `gl=
ib-rs`)
> > +    fn clone_to_foreign(&self) -> OwnedPointer<Self>;
>
> I expected the return type to be OwnedPointer<Self::Foreign>. Is this a t=
ypo?

Kevin noticed the same. I'd have to check if I am missing something
but it seems to be just tunnel vision.

> Also, why is the return type OwnedPointer<T> instead of just T? I
> guess it's common to want a heap-allocated value here so you decided
> to hard-code OwnedPointer<>, but I'm not sure.

Because at this point it looks like the most important conversion is
to have a clone (meaning its lifetime is independent of the copy) and
a value that is not movable (moves can be unpredictable and then usage
in C is messy). The main example is creating a QEMU Error from
something that implements the Rust std::error::Error trait.

Actually I have written extra code that _borrows_ into a foreign
object (so a CStr can be used as a *const c_char for as long as the
CStr is alive), but I didn't really have a user and wrote it only to
validate the concept.

Paolo


