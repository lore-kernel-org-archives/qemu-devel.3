Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA42D47CC3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggi9-0005Z7-9Q; Fri, 16 Jan 2026 05:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggi5-0005YM-VR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggi4-0002lY-4i
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768557939;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcpNYgr3DDa5Mnlz9gSpNx7RjeitHhlFTV+1GjLz4ug=;
 b=HIX9K/ev/p8aI59ZWCHczOu8FAldKoaI4A6q/mwE8jtbKyJ253RItcDUYvZ5UWpesCgFle
 2O3yUE1ggfjtc4WKaeudwoIukfzchgV3xxrmTjuq8ugJpau5BZ9HfP75CT/NgHmAKsLor1
 mHDWIv3dUAj/FZz3qMf9p4mKW73FO2E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-HieWMGTROT-n6R8LH19WJQ-1; Fri,
 16 Jan 2026 05:05:37 -0500
X-MC-Unique: HieWMGTROT-n6R8LH19WJQ-1
X-Mimecast-MFC-AGG-ID: HieWMGTROT-n6R8LH19WJQ_1768557936
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1963D1954B17; Fri, 16 Jan 2026 10:05:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30AB219560A7; Fri, 16 Jan 2026 10:05:32 +0000 (UTC)
Date: Fri, 16 Jan 2026 10:05:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docs/about: propose OS platform/arch support tiers
Message-ID: <aWoNaVemB2oiK9Ui@redhat.com>
References: <20260115180123.848640-1-berrange@redhat.com>
 <c53dbe16-98cb-0cde-7024-3deacabf9bfd@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c53dbe16-98cb-0cde-7024-3deacabf9bfd@eik.bme.hu>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Thu, Jan 15, 2026 at 09:39:13PM +0100, BALATON Zoltan wrote:
> On Thu, 15 Jan 2026, Daniel P. Berrangé wrote:
> > Informally we have approximately three groups of platforms
> > 
> > * Tier 1: fully built and fully tested by CI. Must always be
> >           kept working & regressions fixed immediately
> > 
> > * Tier 2: fully built and partially tested by CI. Should
> >           always be kept working & regressions fixed quickly
> > 
> > * Tier 3: code exists but is not built or tested by CI.
> >           Should not be intentionally broken but not
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
> >  https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02543.html
> > 
> > docs/about/build-platforms.rst | 152 +++++++++++++++++++++++++++++++++
> > 1 file changed, 152 insertions(+)
> > 
> > diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
> > index e95784cdb5..950e164c02 100644
> > --- a/docs/about/build-platforms.rst
> > +++ b/docs/about/build-platforms.rst


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
> 
> If an OS stops supporting a platform in new versions then due to the policy
> of supporting only the last two OS versions in QEMU may lead to breaking
> this. Maybe it tries to say that Tier 3 is intended to be fixed but no
> guarantees on when? It is also clarified below so maybe this clause is not
> needed or need to be reworded?

The policy on only supporting the most recent 2 releases of an
OS applies universally regardless of the Tier levels. I should
state that explicitly in this new doc to make that clear.

IOW, maintainers are free to remove code that is only relevant
to OS versions /older/ than 2 releases whether that code is
broken or not.


> 
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
> 
> can be removed
> 
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

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


