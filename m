Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8A7D15D9D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CmV-0002Bs-C4; Tue, 22 Oct 2024 07:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3CmT-0002BG-A8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3CmQ-0004Mf-E3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729595425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lD9xztm4jlIzugWsFE4dM8acTgux/EjyZt1bkQW1tdw=;
 b=Bq8mPnFqEhO4a87wClGCs+jM89C23xRnO2ztWxKeubqPsQwksXr15rqRvVRGslPnQb/Hia
 VK3+G8qTOhufpWZ3x+bjA2E0ezCsDs+TfPBvFbLKk983hHY/+hXEQlDlwKHsIT//zSEhWM
 TsG6P1qBkilM1q52z6DFBwozOby06ZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-FdlyoJThPAibvG8BV1qw3Q-1; Tue, 22 Oct 2024 07:10:22 -0400
X-MC-Unique: FdlyoJThPAibvG8BV1qw3Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d56061a4cso2815926f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 04:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729595421; x=1730200221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lD9xztm4jlIzugWsFE4dM8acTgux/EjyZt1bkQW1tdw=;
 b=aXO773Ut9UVQ0Xr17AjoGFpKLfyG8nEPszoqYZMFbVUm67e+k36MU2ADjm4v4O/KX0
 IN2KBbiBv63p3LjvfHBelu9hZUTXUxRdSxZwvmAMkWYUIc1z8AZ1rEU+Oz/WSzyyDPhs
 mJH+xoCAveWmP9e2Ji7E4Mdy9hQ3lv9QRqX80dIhr4qVnH6/fuXPdddd3tWqiu5VgUOP
 QTbPe1Gy7Br8gCbj6DoEsrLBS8FxEY7dFwUE4wFWCXRNQXnhWwaezN5P6AKSwQuG/j2U
 K7dY0PvLscaoc8DCeCuOcr9fGQ6mt4WcPTLALO3OK6UNmHS6WAVdplKsRwzx3PVkXZFU
 kajA==
X-Gm-Message-State: AOJu0YwTOO13lZnFTPYy8XqFWE40emyKMnTwgrPgq+6YayZHTtbQNNO7
 elwBgAoZN2l4qW9By7BT1EiJbgsHx0n980Rn9XGla29d0/TWUJLNto0ahbCf3inMiv6ndiyFNsI
 X3WPmdfkUyMjaSD3LcLiqn8sj7jsgH4HMTbEuvkIfPZbNXUYxXb/O/f9N2eBfaXkBxEjFkgjf9b
 s1jRTjKE7bcvKr2K2Tln9jjwaBgDk=
X-Received: by 2002:a5d:574c:0:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-37ef0b7c91dmr2336036f8f.14.1729595420879; 
 Tue, 22 Oct 2024 04:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx0KIelPj2C9YZrFv1RpEl6q0VIQKeclaglIHvRArTHPK3hGoIsdAlTnKg3tls/8NyC1iGqelgEmlvT+aLBDs=
X-Received: by 2002:a5d:574c:0:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-37ef0b7c91dmr2336023f8f.14.1729595420364; Tue, 22 Oct 2024
 04:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <871q16fq9c.fsf@draig.linaro.org>
In-Reply-To: <871q16fq9c.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Oct 2024 13:10:08 +0200
Message-ID: <CABgObfb_1vD9xnkHgfsbY7Bm5JOhJbKRWfWQiRRZP1Gd6QuGgQ@mail.gmail.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, 
 Michael Tokarev <mjt@tls.msk.ru>, ncopa@alpinelinux.org, bofh@freebsd.org, 
 emulation@freebsd.org, virtualization@gentoo.org, dilfridge@gentoo.org, 
 hi@alyssa.is, edolstra+nixpkgs@gmail.com, brad@comstyle.com, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Since I wasn't able to attend the BOF, I delayed my reply until after
I could get some experience with Manos's code and make a list of
things to do in the immediate future. I think my recent patches reach
the point at which the work can be parallelized (and a list of
subsequent steps are at https://wiki.qemu.org/RustInQemu#TODO).

On Thu, Sep 26, 2024 at 4:23=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
> During the various conversations I didn't hear anyone speak against the
> proposed migration although some concerns where raised about review and
> knowledge gaps.

Yes, I agree.

> One output from this discussion should be a clear statement that we are
> going forward with this work and the road map. A rough roadmap might
> look like:
>
>   - 9.2   --enable-rust is available and developers can build with it.
>           rust devices have -x-device or -rust-device CLI flags for
>           runtime selection.
>
>   - 10.x  rust devices feature complete and migration compatible, enabled
>           by default when rust compiler detected. No CLI selection
>           required as legacy portions won't be built. Any partial
>           conversions should be behind --enable-prototype-rust configure
>           flag.
>
>   - 11.x  distros have enough infrastructure to build on supported
>           platforms. Rust becomes a mandatory dependency, old C versions
>           of converted code removed from build.

Here is my version:

9.2
--enable-rust is available and developers can build with it. Ideally
this results in feature parity, but we cannot yet be sure that this is
the case. (Current holes are documented in
https://wiki.qemu.org/RustInQemu#TODO)

10.x
--enable-rust is default.
Duplicates of existing code are allowed in order to gain experience
with the creation of bindings to C code, but should (probably must)
have feature parity with C code.
It is possible to build Rust devices that have a limited amount of
unsafe code in the device itself, especially during runtime as opposed
to initialization.

11.x
--enable-rust is mandatory and disabling it will drop support for
devices or boards.

> We should publish the intention and the road map prominently although it
> was unclear if a blog post would be the best place vs expanding a
> section in the developers manual. Perhaps both make sense with a blog
> post for the statement of intent and rough timeline and the developer
> manual being expanded with any new rules and standards to follow?

Agreed. The blog post should also document some of the design decisions.

> There was some concern about the missing gaps in the support matrix
> especially as we support a number of "legacy" TCG backends. While *-user
> support is more insulated from the effects of rust conversions due to
> its relatively low set of dependencies it will still be a problem if we
> convert the core CPU QOM classes to rust.
>
> In theory if LLVM supports the architecture we should be able to
> generate binaries with a rust compiler although we may not have all
> tools available on that host.

Yeah, based on the detection code that we added in "configure", it
seems that LLVM (and Rust) supports all of the targets in our support
matrix?

> Hanna and Stefan were keen to see more use of Rust in the block layer.
> Hanna cautioned that it was hard to find a reasonable starting point for
> the conversion. Originally she had started with the core sub-system but
> it quickly ran into thousands of lines of code which would be hard to
> get well reviewed before switching for such a crucial sub-system. Maybe
> this is an ordering problem and it would make more sense to start with
> individual block drivers first and work up from there.
>
> Alex mentioned softfloat could make a good candidate for conversion as
> while the rewrite had made things easier to follow and extend there were
> still some C macro tricks employed to get code re-use. It would depend
> on if Rust's macro and trait system allows more of the common logic to
> be kept together.
>
> The qboot firmware for MicroVM's was also mentioned as a potential
> candidate.

I am not sure of the benefits there. qboot has a bunch of hand-crafted
C macros to work in 16-bit mode, and does not even have a free()
function (it does have malloc() though). Rewriting qboot code in Rust
is unlikely teach us many lessons that are useful for the rest of
QEMU, and would not have substantial benefits in terms of memory
safety.

> With relative inexperience there was a concern we could inadvertently
> introduce technical debt in the code base (C-like Rust vs Rusty rust).
> What can we do to mitigate that issue?

My main suggestion is to take it slowly. While the recent flurry of
posted patches may suggest otherwise, a lot of those were developed
over several months (sometimes years!) and the posted version is not
the first.

The other suggestion is for reviewers to not be afraid to say "I have
no idea what you're doing". If a reviewer does not understand how the
language is being used, the affected code must either have a clear
documentation explaining the design, or be rewritten.

Of course core bindings code will be more complex/complicated than we
all wish, but the important thing is to _absolutely_ get public APIs
right. Private implementation details can be subject to future
evolution and cleanup, while public APIs are much harder to change.
That said:

- bad public APIs tend to be larger red flags of technical debt in
Rust than in C

- we can look at what other projects (especially Linux) are doing, and
use that to make informed decisions. There aren't many projects doing
integration of Rust into massive C code bases, but we are not first.

- many of our core APIs (chardev, memory region ops, timers, etc.) are
fairly stable

- there are several patterns that are common across QEMU code (for
example Error**, or vtables), and therefore experience writing one set
of C<->Rust bindings will help with other areas of the code as well.

Things may be different in other areas. For example, block devices may
also suffer impedance mismatch between Rust async/await and C
coroutines.

> We make heavy use of GLib throughout the code base and while new Rust
> code should use native structures for arrays and the like there are
> places when Glib structures are passed across API boundaries. Should we
> consider updating APIs as we go or live with a degree of thunking until
> we have a better idea where the pain points are?

I think that's relatively rare and we can cross that bridge when we
get there. The glib_rs crate exists, but I don't really like its
design, because it's very much tuned towards cloning C data to
Rust-managed memory and it hides the performance characteristics of
code that uses it. But if all we need is GArray/GPtrArray/GByteArray,
there's not a lot of code to write and there's no need for thunking.

That said, C<->Rust interoperability is something that has to be
tackled sooner or later for objects such as Error. I have my favored
approach (https://lore.kernel.org/r/all/20240701145853.1394967-4-pbonzini@r=
edhat.com/)
but it's not an easy subject. Again, let's take it slowly. It's okay
if the first devices cannot have a realize() function that fails, just
because we haven't figured out Error yet.

> One of the promises of Rust is its support for inline unit test
> integration although there was a little confusion about how this works
> in practice. Are separate test binaries created with just the code under
> test or is there a unit testable build of QEMU itself? Does this still
> work with mixed C and Rust code?

The posted patches have examples of both unit- and integration-testing
of Rust code.

> It was suggested creating a qemu-rust mailing list that all patches that
> touch or introduce rust could Cc. This would help those willing to
> review rust find patches without having to wade through the qemu-devel
> firehose.

Good idea, who does it? :)

> Some distros do allow exceptions for "vendoring"
> dependencies as part of the build but it is generally discouraged. [...]
> The general consensus seemed to be we should be fairly conservative
> about adding new crate dependencies while the Rust ecosystem in distros
> matures. While we should support rustup/cargo installed tools so
> developers can build and test on existing LTS distros we should be
> aiming to build QEMU without downloading any additional packages. There
> may be some flexibility for build-only dependencies (c.f. our pyenv) but
> runtime dependencies should be served by the distro itself.

Note that this is _not_ what we are doing right now. All dependent
crates are vendored and included in the QEMU tarball. However, this is
also why we are very conservative about adding new crates. Right now
it's basically only "bilge" and its dependency "arbitrary-int", a
crate for "readable bitfields".

Thanks for writing this down!

Paolo


