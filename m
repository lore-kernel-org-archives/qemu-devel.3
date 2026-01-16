Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB02D47CC3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggnN-0000Gt-OM; Fri, 16 Jan 2026 05:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggnH-0000Fc-7H
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggnF-0003rO-F0
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768558260;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eI68cha5JGUsQpAvzdg6WvnxrlBL6PBlDr3vkBMlqe0=;
 b=CRzjyneoEcD6CZJ9Cl6dkAPHun32LyLQdvtbS732TDUebIuN5krmuaKcIuIbKei9tQG9Gm
 LG6Gz2H71hY2+qp2p0XHWwnDIZ2Mf1Bxf44gwqXsKSfTkexshY2Dezm7eAg1WcIa5rE5JP
 LJEN9xvJ8i+gUMxhyUSxGHpVgTRRh9c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-4M1Iv--2N8CSC6blmS3jBw-1; Fri,
 16 Jan 2026 05:10:56 -0500
X-MC-Unique: 4M1Iv--2N8CSC6blmS3jBw-1
X-Mimecast-MFC-AGG-ID: 4M1Iv--2N8CSC6blmS3jBw_1768558255
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F5F2195605A; Fri, 16 Jan 2026 10:10:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78D5719560A7; Fri, 16 Jan 2026 10:10:52 +0000 (UTC)
Date: Fri, 16 Jan 2026 10:10:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docs/about: propose OS platform/arch support tiers
Message-ID: <aWoOqcWreVutPrM7@redhat.com>
References: <20260115180123.848640-1-berrange@redhat.com>
 <251f819b-8a47-43f5-b74c-6ba5fb307de8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <251f819b-8a47-43f5-b74c-6ba5fb307de8@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Jan 15, 2026 at 09:56:31PM +0100, Thomas Huth wrote:
> On 15/01/2026 19.01, Daniel P. Berrangé wrote:
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
> ...
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
> 
> I don't think that we run any test frameworks for Linux on mips64el or
> riscv64 in the CI, do we? It's only cross-compilation of the code.

I didn't want to put those in tier 3 since I think they're generally
better than that. Perhaps this bullet should be loosened slightly

   "May run some tests frameworks in CI"

> 
> ...
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
> 
> You missed Haiku.

Opps, I knew I'd miss something :-)

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
> 
> Support for 32-bit OSes is currently being removed.

Yep, this doc is slightly anticipating the future. I was expecting
that Richard's series:

  https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg03073.html

will be merged soon enough.

> > + * Any OS not listed above
> 
> Is it possible at all to compile QEMU for any other OS? I though our
> configure script would block such attempts...?

Hmm, true, we should be blocking atttempts to build. So anycode related
to unclassified OS would be non-buildable and definitely OK to remove.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


