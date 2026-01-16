Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188BAD47CD3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghM3-0000TE-Br; Fri, 16 Jan 2026 05:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vghM1-0000SS-NX
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vghLz-0001Tb-Jc
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768560412;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgrR3QDqTuIYeOUu3Lj0B91lZcBBcmU23yGctL209UY=;
 b=LuVsVavVXIlgid6HJXhmAnoMmMC9T05S6ExiE0BGpL3WWhG7bhoN/di5T4KrtLbBGGPw3k
 FRPtsTZtFSX59JLY8X8RL7sQ+R7wDrmvRokhxI+0rrBH+1z6bMKMD0mey6ByPXWbd5Sclb
 BzCd/2Kqb/Gfme4oZdcvvCjNzg/7hBg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-tTA4WbFsP_-zw2Nj7s_mvQ-1; Fri,
 16 Jan 2026 05:46:48 -0500
X-MC-Unique: tTA4WbFsP_-zw2Nj7s_mvQ-1
X-Mimecast-MFC-AGG-ID: tTA4WbFsP_-zw2Nj7s_mvQ_1768560407
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A6F51955F34; Fri, 16 Jan 2026 10:46:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C80A530002D6; Fri, 16 Jan 2026 10:46:44 +0000 (UTC)
Date: Fri, 16 Jan 2026 10:46:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docs/about: propose OS platform/arch support tiers
Message-ID: <aWoXEU5kYbLpuKEI@redhat.com>
References: <20260115180123.848640-1-berrange@redhat.com>
 <05bc2cec-874f-48c9-8ba8-9f14f41e9dab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05bc2cec-874f-48c9-8ba8-9f14f41e9dab@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Thu, Jan 15, 2026 at 12:48:56PM -0800, Pierrick Bouvier wrote:
> On 1/15/26 10:01 AM, Daniel P. Berrangé wrote:
> > Informally we have approximately three groups of platforms
> > 
> >   * Tier 1: fully built and fully tested by CI. Must always be
> >             kept working & regressions fixed immediately
> > 
> >   * Tier 2: fully built and partially tested by CI. Should
> >             always be kept working & regressions fixed quickly
> > 
> >   * Tier 3: code exists but is not built or tested by CI.
> >             Should not be intentionally broken but not
> > 	   guaranteed to work at any time. Downstream must
> > 	   manually test, report & fix bugs.
> > 
> > Anything else is "unclassified" and any historical code
> > remnants may be removed.
> > 
> > It is somewhat tricky to define unambiguous rules for each tier,
> > but this doc takes a stab at it. We don't need to cover every
> > eventuality. If we get the core points of view across, then it
> > at least sets the direction for maintainers/contributors/users.
> > Other aspects can be inferred with greater accuracy than today.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > 
> > This came out of the discussion about recent unnoticed breakage
> > in NetBSD builds and what maintainers are expected todo about
> > it (if anything)
> > 
> >    https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02543.html
> > 
> >   docs/about/build-platforms.rst | 152 +++++++++++++++++++++++++++++++++
> >   1 file changed, 152 insertions(+)
> > 
> > diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
> > index e95784cdb5..950e164c02 100644
> > --- a/docs/about/build-platforms.rst
> > +++ b/docs/about/build-platforms.rst
> > @@ -171,3 +171,155 @@ Only 64-bit Windows is supported.
> >   .. _MacPorts: https://www.macports.org/
> >   .. _MSYS2: https://www.msys2.org/
> >   .. _Repology: https://repology.org/
> > +
> > +OS Support Tiers
> > +----------------
> > +
> > +While the QEMU code targets a number of different OS platforms, they don't
> > +all get the same level of support from the project. This applies to
> > +contributor & maintainer expectations, CI automation and requirements
> > +for merge gating.
> > +
> > +Tier 1
> > +~~~~~~
> > +
> > +These platforms attain the highest level of quality offered by
> > +the QEMU project.
> > +
> > + * Builds and all tests pass at all times in both git HEAD and releases
> > +
> > + * Builds for multiple build configuration are integrated in CI
> > +
> > + * Runs all available tests frameworks (unit, qtest, iotests, functional)
> > +   in CI
> > +
> > + * Merging code is gated on successful CI jobs
> > +
> > +This covers
> > +
> > + * Linux (x86_64, aarch64, s390x)
> > +
> > +Responsibilities:
> > +
> > + * Contributors MUST test submitted patches on one of Tier 1 platforms.
> > +
> > + * Contributors SHOULD test submitted patches on Tier 1 platforms
> > +   by running a GitLab CI pipeline in their fork.
> > +
> > + * Maintainers MUST request contributors to fix problems with Tier 1
> > +   platforms.
> > +
> > + * Maintainers MUST test pull requests on Tier 1 platforms
> > +   by running a GitLab CI pipeline in their fork.
> > +
> > + * Maintainers MUST co-ordinate fixing regressions identified
> > +   post-merge immediately.
> > +
> > +
> > +Tier 2
> > +~~~~~~
> > +
> > +These platforms are considered to be near Tier 1 level, but are
> > +lacking sufficient automated CI testing cover to guarantee this.
> > +
> > + * Builds and all tests pass at all times in both git HEAD and releases
> > +
> > + * Builds for multiple build configuration are integrated in CI
> > +
> > + * Runs some test frameworks in CI
> > +
> > +This covers
> > +
> > + * Linux (mips64el, ppc64el, riscv64)
> > +
> > + * FreeBSD (x86_64)
> > +
> > + * macOS (aarch64)
> > +
> > + * Windows (x86_64)
> > +
> > +Responsibilities:
> > +
> > + * Contributors MAY test patches on Tier 2 platforms
> > +   by running a GitLab CI pipeline in their fork
> > +
> > + * Maintainers SHOULD request contributors to fix problems with Tier 2
> > +   platforms.
> > +
> > + * Maintainers MUST test pull requests on all Tier 2 platforms,
> > +   by running a GitLab CI pipeline in their fork.
> > +
> > + * Maintainers MUST co-ordinate fixing regressions identified
> > +   post-merge quickly.
> > +
> > +
> > +Tier 3
> > +~~~~~~
> > +
> > +These platforms have theoretical support in the code, but have
> > +little, or no, automated build and test coverage. Downstream
> > +consumers (users or distributors) who care about these platforms
> > +are requested to perform manual testing, report bugs and provide
> > +patches.
> > +
> > + * Builds and tests may be broken at any time in Git HEAD and
> > +   releases
> > +
> > + * Builds are not integrated into CI
> > +
> > + * Tests are not integrated into CI
> > +
> > + * Merging code is not gated
> > +
> > +This covers:
> > +
> > + * NetBSD
> > + * OpenBSD
> > + * macOS (except aarch64)
> > + * FreeBSD (except x86_64)
> > + * Windows (except x86_64)
> > + * Solaris
> > +
> > +Responsibilities:
> > +
> > + * Contributors MAY test patches on Tier 3 platforms manually
> > +
> > + * Maintainers MAY request contributors to fix problems
> > +   on Tier 3 platforms
> > +
> > + * Maintainers MAY test patches on Tier 3 platforms manually
> > +
> > + * Maintainers SHOULD NOT accept patches that remove code
> > +   targetting Tier 3 platforms even if currently broken
> > +
> > + * Downstream vendors SHOULD test RC releases on Tier 3 platforms
> > +   and provide bug reports and patches to address problems
> > +
> > +Note: if a Tier 3 platform is found to be significantly broken,
> > +no patches are contributed for a prolonged period, and there is
> > +no sign of downstream usage, it is liable to be moved to
> > +"Unclassified" and thus be subject to removal.
> > +
> > +
> > +Unclassified
> > +~~~~~~~~~~~~
> > +
> > +These platforms are not intended to be supported in the code
> > +and outside the scope of any support tiers.
> > +
> > +  * Code supporting these platforms can removed at any time
> > +  * Bugs reports related to these platforms will generally
> > +    be ignored
> > +
> > +This covers:
> > +
> > + * All 32-bit architectures on any OS
> > + * Any OS not listed above
> > +
> > +Responsibilities:
> > +
> > + * Maintainers MAY decline patches that add code targetting
> > +   unclassified platforms
> > +
> > + * Maintainers MAY accept patches that remove code targetting
> > +   unclassified platforms
> 
> That's a good summary, but it should differentiate testing/runtime issues
> from building issues.
> 
> In general, maintainers should ensure code build on all platforms/configs.
> Of course, it's a best effort considering not all of them are built in CI,
> but in case a build issue is caught on time, it should be fixed before
> hitting master.

It is certainly the case for Tier 1/2 platforms, that a known build
issue must not be willfully merged into master.

That's not the case for Tier 3, since we can't guarantee that the QEMU
code builds successfully to begin with. If we do a see a probable issue
in a Tiar 3 platform build, and its easy to resolve then we should. We
can't gate on every Tier 3 problem given the lack of guaranteed working
dev/test envs and lack of CI.

Ideally we should not have any platforms listed under Tier 3 at all,
but today we do. May be some will graduate to Tier 2 at some point.

> It may be worth to mention that all platforms can be accessed for free
> using: https://github.com/second-reality/github-runners.
> If you're open to it, we could move this project under
> https://github.com/qemu and preinstall all dependencies on each runner, so
> people can easily jump on a shell and start debugging things without wasting
> time.

I don't speak for all maintainers, but personally I've no desire
to increase use of github for QEMU, or indeed any other projects.

The choice of platform is about more than just possible features.
The ability to control our own destiny, and maintain use of OSS
infrastructure was/is important.

GitLab is certainly not perfect, but gitlab.com was an acceptable
tradeoff with the ability to switch to self-hosted Gitlab since
it is based on OSS. Beyond that we could also migrate to Forgejo/
Codeberg. Tieing ourselves into GitHub's fully proprietary service
has never really been on the table for QEMU.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


