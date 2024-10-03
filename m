Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688FBCF8574
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swIsK-0007Zm-3b; Thu, 03 Oct 2024 06:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1swIrg-0007TW-6T
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 06:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1swIqp-0000x6-SA
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 06:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727950381;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xewima99F9QkQqenxUJca4FkK/vgdh+y8Hn0A/iQe7s=;
 b=LBTDfhX68/Wv0Ach0iOIUv9CMWzL0lKe2Ge3WqW8iplp5IfsHuqSm1QyEi6arvLoookZqL
 nGREAuVZphAqyBu86PyO4+vU7pm5ErfPObm/fHw6yKhqrcPMYTUasTwNunu1GdfjcV3QNG
 AvM93pyvValE7ph17MiyczE9vbUgn24=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-zj3BqUlCP4KBYqpOdyCE7Q-1; Thu,
 03 Oct 2024 05:53:31 -0400
X-MC-Unique: zj3BqUlCP4KBYqpOdyCE7Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F5D41955D45; Thu,  3 Oct 2024 09:53:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6231930000DF; Thu,  3 Oct 2024 09:53:08 +0000 (UTC)
Date: Thu, 3 Oct 2024 10:53:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
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
Message-ID: <Zv5pgZsHOeXX-3fg@redhat.com>
References: <871q16fq9c.fsf@draig.linaro.org>
 <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Oct 03, 2024 at 02:53:08AM -0600, Warner Losh wrote:
> On Thu, Sep 26, 2024 at 8:24 AM Alex Bennée <alex.bennee@linaro.org> wrote:
> 
> > One output from this discussion should be a clear statement that we are
> > going forward with this work and the road map. A rough roadmap might
> > look like:
> >
> >   - 9.2   --enable-rust is available and developers can build with it.
> >           rust devices have -x-device or -rust-device CLI flags for
> >           runtime selection.
> >
> >   - 10.x  rust devices feature complete and migration compatible, enabled
> >           by default when rust compiler detected. No CLI selection
> >           required as legacy portions won't be built. Any partial
> >           conversions should be behind --enable-prototype-rust configure
> >           flag.
> >
> >   - 11.x  distros have enough infrastructure to build on supported
> >           platforms. Rust becomes a mandatory dependency, old C versions
> >           of converted code removed from build.
> >
> >   - xx.y  QEMU becomes a pure native rust program and all C is expunged.
> >           We may never get to this point.
> >
> > We should publish the intention and the road map prominently although it
> > was unclear if a blog post would be the best place vs expanding a
> > section in the developers manual. Perhaps both make sense with a blog
> > post for the statement of intent and rough timeline and the developer
> > manual being expanded with any new rules and standards to follow?
> >
> 
> FeeBSD is Tier 1 in rust only for amd64 (x86_64). It's Tier 2 for i386
> (which
> admittedly is going away) and Tier 3 for everything else.
> 
> > There was some concern about the missing gaps in the support matrix
> > especially as we support a number of "legacy" TCG backends. While *-user
> > support is more insulated from the effects of rust conversions due to
> > its relatively low set of dependencies it will still be a problem if we
> > convert the core CPU QOM classes to rust.
> >
> 
> Indeed. I have great concerns here, though we've already dropped
> 32-bit host support for bsd-user. The status of aarch64 support and rumored
> difficulty getting that rust support upgraded give me pause for concern
> because it's a FreeBSD Tier 1 platform. While it basically works, the lack
> of commitment by the Rust community is troubling. Even more troubling because
> rust still uses the old FreeBSD 11 compat syscalls, despite upgraded
> being available for years at this point (though maybe this info has changed
> in the last month or two, the years long delay in moving off the interfaces
> that the FreeBSD project obsoleted about 8 years ago is troubling on its
> own).
> Much of the resistance I'm told (I'm not a big rust person, so I have to
> reply on others) has been in the rust team because they don't have enough
> familiarity
> with FreeBSD to make any kind of decision so even properly solved issues
> linger in the official upstream. The FreeBSD project critically depends on
> bsd-user for its release process, though that dependency so far has been
> only on x86 and aarch64, both of which work almost all the time, even if
> they aren't Tier 1 rust platforms.

I don't think we should over-think the upstream Rust support tiers for QEMU.
Rust is one of very few OSS projects that bothers to classify platforms
they target to this degree of detail. Most OSS projects will test primarily
on Linux, and x86_64 / aarch64, with most everything else done on an adhoc
basis, relying on user feedback & patches. eg If I look at what Rust says

  "Tier 3 targets are those which the Rust codebase has support
   for, but which the Rust project does not build or test
   automatically, so they may or may not work."

I would say that describes the status of most non-Linux / non-x86/arm64
platform combinations, across a very large part of the OSS software
ecosystem, including a lot of libraries QEMU depends on.

Admittedly, compilers are the area where platform support is taken most
seriously, given they are the foundation for everything else above, and
the comparison benchmark in this case is the support matrix offered by
GCC + CLang combined which is incredibly broad. Above that though, QEMU
has a mandatory dep on Glib, and its supported & tested platform set
is massively narrower than this.

I think it is inevitable that a number of QEMU platforms we can build
on will be classified Tier 2 or even 3 by Rust upstream, as just many
libraries QEMU depends on today would effectively be "Tier 3" if their
upstream actually tried to document such details.

What I think is more important than the absolute Tier level, is whether
Rust has been ported at all to a given OS + arch combination. This is
where tier 3 guides us - an indication that there's been enough interest
in Rust for it to have been ported to that target at some point, and thus
an expectation (or hope) that it can be kept working, if there are
sufficient people downstream who care about that particular Rust target.

> For -system use, this could limit where qemu runs, though to be honest
> the only platform I know has users that might be affected running -system
> might be RISCV.
> 
> There's similar issues with other BSDs, but I've heard even less reliable
> information
> about them, so I'll just leave it at that.

In terms of QEMU upstream, we actively test FreeBSD on x86_64 in Gitlab
CI, via Cirrus, and to a slightly lesser extent test OpenBSD/NetBSD on
x86_64 with our adhoc VM environments. Anything else is delegated to
downstream users of QEMU to report bugs to us, though we try not to
take code that would obviously break other platforms even if we can't
test it ourselves. In Rust, the other BSDs are Tier 3 which is weaker
than QEMU aims for x86_64, but on a par with QEMU for non-x86

  https://doc.rust-lang.org/rustc/platform-support/netbsd.html
  https://doc.rust-lang.org/rustc/platform-support/openbsd.html

at least they have a designated developer who presumably aims to keep
those rust ports working over time.

> So a strawman timeline of 2 years strikes me as unrealistically agressive
> for it to be an absolute requirement given the slow rate of change I've seen
> with upstream rust WRT FreeBSD. At the very least, it would put qemu on
> non-x86/non-aarch64 platforms at risk. While not a huge audience, there are
> some users there. The Tier 2 status for Rust at best for FreeBSD is also a
> bit worrying for elimination of all C or a big reliance on rust in the core
> that can't realistically be avoided. I'm not sure this should gate the start
> of the rust experiment, but I raise it now so as that experiment progresses
> towards production people think to talk to me or others in the FreeBSD
> community as they progress.

I don't think being "Tier 2" is a problem - that is still a pretty strong
level of support from upstream Rust

  https://doc.rust-lang.org/rustc/target-tier-policy.html#tier-2-target-policy

Beyond that, I don't think any of the upstream Rust tiers are neccessarily
a constraint for QEMU, even Tier 3.

IMHO what matters more is whether the OS distro in question has managed
to successfully package Rust + its stdlib in their distro, to the extent
that QEMU is able to build, using the distro provided packages.

That is the bar we have for basically every dependency we add to QEMU.
Distro support is more important that upstream support. The upstream
support is really more of an indication of how hard a life the distro
maintainer is going to have keeping it working in their distro, rather
than whether QEMU should/should not use it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


