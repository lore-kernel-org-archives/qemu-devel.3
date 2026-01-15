Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DBBD46617
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgU7t-0002ae-Co; Thu, 15 Jan 2026 15:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vgU7r-0002W2-2I
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:39:27 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vgU7o-0000wa-Gq
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:39:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1488E596A0E;
 Thu, 15 Jan 2026 21:39:16 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id re94NgKP5oDI; Thu, 15 Jan 2026 21:39:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A3C4F596A0D; Thu, 15 Jan 2026 21:39:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1A575969E4;
 Thu, 15 Jan 2026 21:39:13 +0100 (CET)
Date: Thu, 15 Jan 2026 21:39:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docs/about: propose OS platform/arch support tiers
In-Reply-To: <20260115180123.848640-1-berrange@redhat.com>
Message-ID: <c53dbe16-98cb-0cde-7024-3deacabf9bfd@eik.bme.hu>
References: <20260115180123.848640-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1389464339-1768509553=:70469"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1389464339-1768509553=:70469
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 15 Jan 2026, Daniel P. Berrangé wrote:
> Informally we have approximately three groups of platforms
>
> * Tier 1: fully built and fully tested by CI. Must always be
>           kept working & regressions fixed immediately
>
> * Tier 2: fully built and partially tested by CI. Should
>           always be kept working & regressions fixed quickly
>
> * Tier 3: code exists but is not built or tested by CI.
>           Should not be intentionally broken but not
> 	   guaranteed to work at any time. Downstream must
> 	   manually test, report & fix bugs.
>
> Anything else is "unclassified" and any historical code
> remnants may be removed.
>
> It is somewhat tricky to define unambiguous rules for each tier,
> but this doc takes a stab at it. We don't need to cover every
> eventuality. If we get the core points of view across, then it
> at least sets the direction for maintainers/contributors/users.
> Other aspects can be inferred with greater accuracy than today.
>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>
> This came out of the discussion about recent unnoticed breakage
> in NetBSD builds and what maintainers are expected todo about
> it (if anything)
>
>  https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02543.html
>
> docs/about/build-platforms.rst | 152 +++++++++++++++++++++++++++++++++
> 1 file changed, 152 insertions(+)
>
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
> index e95784cdb5..950e164c02 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -171,3 +171,155 @@ Only 64-bit Windows is supported.
> .. _MacPorts: https://www.macports.org/
> .. _MSYS2: https://www.msys2.org/
> .. _Repology: https://repology.org/
> +
> +OS Support Tiers
> +----------------
> +
> +While the QEMU code targets a number of different OS platforms, they don't
> +all get the same level of support from the project. This applies to
> +contributor & maintainer expectations, CI automation and requirements
> +for merge gating.
> +
> +Tier 1
> +~~~~~~
> +
> +These platforms attain the highest level of quality offered by
> +the QEMU project.
> +
> + * Builds and all tests pass at all times in both git HEAD and releases
> +
> + * Builds for multiple build configuration are integrated in CI
> +
> + * Runs all available tests frameworks (unit, qtest, iotests, functional)
> +   in CI
> +
> + * Merging code is gated on successful CI jobs
> +
> +This covers
> +
> + * Linux (x86_64, aarch64, s390x)
> +
> +Responsibilities:
> +
> + * Contributors MUST test submitted patches on one of Tier 1 platforms.
> +
> + * Contributors SHOULD test submitted patches on Tier 1 platforms
> +   by running a GitLab CI pipeline in their fork.
> +
> + * Maintainers MUST request contributors to fix problems with Tier 1
> +   platforms.
> +
> + * Maintainers MUST test pull requests on Tier 1 platforms
> +   by running a GitLab CI pipeline in their fork.
> +
> + * Maintainers MUST co-ordinate fixing regressions identified
> +   post-merge immediately.
> +
> +
> +Tier 2
> +~~~~~~
> +
> +These platforms are considered to be near Tier 1 level, but are
> +lacking sufficient automated CI testing cover to guarantee this.
> +
> + * Builds and all tests pass at all times in both git HEAD and releases
> +
> + * Builds for multiple build configuration are integrated in CI
> +
> + * Runs some test frameworks in CI
> +
> +This covers
> +
> + * Linux (mips64el, ppc64el, riscv64)
> +
> + * FreeBSD (x86_64)
> +
> + * macOS (aarch64)
> +
> + * Windows (x86_64)
> +
> +Responsibilities:
> +
> + * Contributors MAY test patches on Tier 2 platforms
> +   by running a GitLab CI pipeline in their fork
> +
> + * Maintainers SHOULD request contributors to fix problems with Tier 2
> +   platforms.
> +
> + * Maintainers MUST test pull requests on all Tier 2 platforms,
> +   by running a GitLab CI pipeline in their fork.
> +
> + * Maintainers MUST co-ordinate fixing regressions identified
> +   post-merge quickly.
> +
> +
> +Tier 3
> +~~~~~~
> +
> +These platforms have theoretical support in the code, but have
> +little, or no, automated build and test coverage. Downstream
> +consumers (users or distributors) who care about these platforms
> +are requested to perform manual testing, report bugs and provide
> +patches.
> +
> + * Builds and tests may be broken at any time in Git HEAD and
> +   releases
> +
> + * Builds are not integrated into CI
> +
> + * Tests are not integrated into CI
> +
> + * Merging code is not gated
> +
> +This covers:
> +
> + * NetBSD
> + * OpenBSD
> + * macOS (except aarch64)
> + * FreeBSD (except x86_64)
> + * Windows (except x86_64)
> + * Solaris
> +
> +Responsibilities:
> +
> + * Contributors MAY test patches on Tier 3 platforms manually
> +
> + * Maintainers MAY request contributors to fix problems
> +   on Tier 3 platforms
> +
> + * Maintainers MAY test patches on Tier 3 platforms manually
> +
> + * Maintainers SHOULD NOT accept patches that remove code
> +   targetting Tier 3 platforms even if currently broken

If an OS stops supporting a platform in new versions then due to the 
policy of supporting only the last two OS versions in QEMU may lead to 
breaking this. Maybe it tries to say that Tier 3 is intended to be fixed 
but no guarantees on when? It is also clarified below so maybe this clause 
is not needed or need to be reworded?

> + * Downstream vendors SHOULD test RC releases on Tier 3 platforms
> +   and provide bug reports and patches to address problems
> +
> +Note: if a Tier 3 platform is found to be significantly broken,
> +no patches are contributed for a prolonged period, and there is
> +no sign of downstream usage, it is liable to be moved to
> +"Unclassified" and thus be subject to removal.
> +
> +
> +Unclassified
> +~~~~~~~~~~~~
> +
> +These platforms are not intended to be supported in the code
> +and outside the scope of any support tiers.
> +
> +  * Code supporting these platforms can removed at any time

can be removed

> +  * Bugs reports related to these platforms will generally
> +    be ignored
> +
> +This covers:
> +
> + * All 32-bit architectures on any OS
> + * Any OS not listed above
> +
> +Responsibilities:
> +
> + * Maintainers MAY decline patches that add code targetting
> +   unclassified platforms
> +
> + * Maintainers MAY accept patches that remove code targetting
> +   unclassified platforms

Regards,
BALATON Zoltan
--3866299591-1389464339-1768509553=:70469--

