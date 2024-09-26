Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004A8CDE025
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 16:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1straX-00067B-9Y; Thu, 26 Sep 2024 12:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1straV-00066f-M2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 12:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1straT-0000a5-1y
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 12:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727369007;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZxC3MNIwThGMd16ClcEzxj2lFrF8POd/0a6o+TS2og=;
 b=AIq3ebl9dcfOjeiODCBsvJjfSofA845ST1bQ3ljidQ+/H2kU6wOb3nbKcV4Ileqw1OtIvS
 t/8kSXgIO2HOPOiNLbgZkdq/bNq2SOh0NMdUIoT/vL6BxEG8sCCj8sz5XjwMpC09RNPBKp
 OeBwlOq7/dTj2xM6i8CKs3O0jVNt318=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-66_kLtuDNyKXcyFKWCdmgw-1; Thu,
 26 Sep 2024 12:43:23 -0400
X-MC-Unique: 66_kLtuDNyKXcyFKWCdmgw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1DAD1955E8E; Thu, 26 Sep 2024 16:43:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE2F21954B0E; Thu, 26 Sep 2024 16:43:14 +0000 (UTC)
Date: Thu, 26 Sep 2024 17:43:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org,
 Michael Tokarev <mjt@tls.msk.ru>, ncopa@alpinelinux.org,
 bofh@freebsd.org, emulation@freebsd.org, virtualization@gentoo.org,
 dilfridge@gentoo.org, hi@alyssa.is, edolstra+nixpkgs@gmail.com,
 brad@comstyle.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
Message-ID: <ZvWPH1f6ZnvH1iYZ@redhat.com>
References: <871q16fq9c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q16fq9c.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 26, 2024 at 03:23:11PM +0100, Alex Bennée wrote:
> During the various conversations I didn't hear anyone speak against the
> proposed migration although some concerns where raised about review and
> knowledge gaps.

Yep, this apparent broad acceptance (or at least tolerance) for use of
Rust is a clear difference from any previous discussion about introducing
new languages in QEMU n the past.

> 
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
> 
>   - xx.y  QEMU becomes a pure native rust program and all C is expunged.
>           We may never get to this point.

Yeah, I think this last step is soo unlikely (or far away) that we could
reasonably just not include it at all. Perhaps any future grandchildren
will do this part for us ;-P

> We should publish the intention and the road map prominently although it
> was unclear if a blog post would be the best place vs expanding a
> section in the developers manual. Perhaps both make sense with a blog
> post for the statement of intent and rough timeline and the developer
> manual being expanded with any new rules and standards to follow?

We should include plans about Rust at the top of the release notes too
for all forthcoming versions until we have it turned on permanently.

> There was some concern about the missing gaps in the support matrix
> especially as we support a number of "legacy" TCG backends. While *-user
> support is more insulated from the effects of rust conversions due to
> its relatively low set of dependencies it will still be a problem if we
> convert the core CPU QOM classes to rust.
> 
> Some of this is made simpler if we deprecate 32 bit host support?

I feel like we're pretty close to wanting todo this regardless of
Rust support.

> What are candidates for conversion?
> -----------------------------------
> 
> One area of discussion was what areas of the code base are likely to be
> converted. This will give maintainers some idea of what to expect over
> the next few cycles as we move ahead.

There's a topical blog from Google about their experiance with
Android that just hit LWN:

  https://security.googleblog.com/2024/09/eliminating-memory-safety-vulnerabilities-Android.html

"vulnerabilities decay exponentially. They have a half-life.
 ...
 the density of Android’s memory safety bugs decreased with
 the age of the code, primarily residing in recent changes.

  This leads to two important takeaways:

   * The problem is overwhelmingly with new code, necessitating a
     fundamental change in how we develop code.
  
   * Code matures and gets safer with time, exponentially, making
     the returns on investments like rewrites diminish over time
     as code gets older."

IOW, if we rush into conversion of existing code, we're likely to
harm QEMU's quality in the short-medium term.

We should thus encourage/prioritize use of Rust for *new* code, and
be more cautious / targetted about converting existing code, to
mitigate the risks inherant in any rewrites.

> Manos' initial patch series [1] adds a pl011 serial device and there is
> an intention to add a pflash device model to exercise the block layer.
> It was suggested other device models such as a network card and watchdog
> device would also be worth doing a conversion for to exercise other
> common backends.

If we want arbitrary new devices to be able to be written in Rust,
we want to make sure we have the backends accessible to the Rust
frontend device, for developers to consume.

To be able to design & validate any Rust abstractions for backends,
we need to have at least 1 Rust device consuming each different
backend type eg, chardev, netdev, blockdev, tpm, rng, watchdog.
Similarly for other helper code like IO channels, crypto.

> Markus asked when will QAPI need rust bindings? As it is the route for
> the public API into QEMU it is spread widely across the code base. While
> the hand written serialisation code can likely be replaced with Rust's
> serde crate it will need to interface to the internal APIs of both rust
> and C modules.

Probably need some kind of QAPI support sooner than we think, given how
widely it spreads.

> One issue that came up is how we handle adequately reviewing code when
> most of the maintainers are experienced C coders but might not know much
> about Rust. While we want to avoid the situation of developers vetoing
> conversion there should be communication ahead of any serious work to
> avoid rust contributions coming out of the blue. If a maintainer feels
> they cannot maintain a bunch of unfamiliar rust code the submitter
> should be prepared to find people willing to become a maintainers as
> unmaintained drive-by submissions are not useful for the long term
> health of the project.

Yep, communication is critical, if proposing to rewrite existing
functionality. Drowning maintainers in conversion patches without
warning is a guaranteed way to create friction between people.

> With relative inexperience there was a concern we could inadvertently
> introduce technical debt in the code base (C-like Rust vs Rusty rust).
> What can we do to mitigate that issue?

On a long enough time frame, all exiting code can be considered
technical debt. Given the relatively sparse Rust experiance
across our community, we're guaranteed to make more design
mistakes in the first few years. Mitigating this is important,
but at the same time, we should also accept we're not going
to get everything perfect.

One thing our community is very good at is obsessing about
perfection of patch series. I can forsee us doing that to an
even greater extent with any Rust conversions of code. If we
are not careful we could really harm  our overall productivity
by spending too much time striving for a perfect Rust abstraction
first time out, even though many of us would still be relative
newcomers to Rust, such that we don't know what we don't know.

IOW, we need to be pragmatic about accepting some level of
technical debt at times. Especially if there are cases where
our Rust design is held back by existing C code, we might be
better off temporarily accepting sub-optimal Rust, to avoid
immediately refactoring piles of C code, and tackle the problems
later.

> Dependencies and Packaging concerns
> -----------------------------------
> 
> Finally there is the topic of dependencies and how that affects
> packaging. One of the benefits of Rust is a large library of crates for
> common dependencies. Typically the management of those crates is handled
> by the cargo build tool and projects tend to regularly update their
> dependencies to stay current with the state of the art. However this
> cargo driven approach is at odds with a lot of distros desire to package
> a single version of a library and manage its updates during the stable
> lifetime of a distro. Some distros do allow exceptions for "vendoring"
> dependencies as part of the build but it is generally discouraged.


> Another challenge is updating versions of crates can often lead to
> additional transitive (indirect) dependencies which then need to be
> checked if they are supported by our distro matrix.

In terms of our distro support matrix, I think we should follow the
same practice as Python. ie we only check that the distro provides
the required toolchain / base language, and never check the crates.
IMHO vendoring is really the only viable option for distros with
non-trivial applications, as IME the de-vendoring crates waaaaay
too much busy-work in the distro.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


