Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAE5C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyuA-0005eI-PH; Wed, 02 Jul 2025 10:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWyty-0005dp-NG
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWytp-0004Wa-Mt
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751468243;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Zr1m7o+vBDA1X7640SV/6+9ie79yVM/QnE+MqMugg00=;
 b=D+WeeA+RvTDlOr2jWafQhmK6zi8zkvazoqbPyKedpj4U/8ARjlYPoU1climESkn2aIXvNZ
 xZUyqPeXY8S41UIyC7Zlp4VTz7EHy3Ggj3rpcIYUy2eyTJaIwYQz5pnqHtUFtMfZGRjufw
 n37gIrCEjf+OI7qFm2cdXG9FudRAy1w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-eq5MIiPEOBOrsQpcJLqPLg-1; Wed,
 02 Jul 2025 10:57:20 -0400
X-MC-Unique: eq5MIiPEOBOrsQpcJLqPLg-1
X-Mimecast-MFC-AGG-ID: eq5MIiPEOBOrsQpcJLqPLg_1751468239
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2B3518DA5C6; Wed,  2 Jul 2025 14:57:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 867F118003FC; Wed,  2 Jul 2025 14:57:15 +0000 (UTC)
Date: Wed, 2 Jul 2025 15:57:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
Message-ID: <aGVIyAxgyNmcnAfC@redhat.com>
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
 <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
 <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
 <CAJSP0QWSVhAYBtxKV+WDubmif2m=jxTYd-BK=d7ExZXWUNUYXA@mail.gmail.com>
 <CANCZdfqTKUMLbrT9HEXa-O7pyHqfcMWMmYx7iCq=ZU_ewgCaag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfqTKUMLbrT9HEXa-O7pyHqfcMWMmYx7iCq=ZU_ewgCaag@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Jun 24, 2025 at 11:41:28AM -0600, Warner Losh wrote:

> FreeBSD does maintain all our archival releases forever. They never change.
> But, we don't have permanent links to them today. We start with one URL and
> then migrate to a second one when they transition from supported to unsupported.
> We do this, in part, to make sure people upgrade. So in effect, this breakage
> means that our notion is "working" in the sense that the FreeBSD project's goals
> of making people "keep up to date."
> 
> This does, I realize, clash with the views that QEMU wants to have some stable
> way to test images over time, even if the upstream's notion of supported or not
> changes.
> 
> One easy idea might be to 'prestage' the 'legacy' releases when they
> are supported
> on the 'legacy' server so that tests can be written with the legacy
> path so that these
> tests always work, now and in the future.
> 
> So, this is terrible from a FreeBSD point of view. We'd like it if
> qemu always tested
> all of our releases, as well as snapshots of the tip of the spear.

FWIW, there are two distinct POV to testing which are clashing here.

What you're describing, IMHO, is a desire for QEMU to perform what
I would consider integration testing against all FreeBSD releases,
and forthcoming releases of FreeBSD.

What QEMU's functional test suite is aiming to do is provide
sufficient coverage of QEMU's functionality that we avoid
shipping regressions.

Where it gets fuzzy is that a functional test suite has overlap
with, and can be a decent proxy for, an integration test suite.

The key difference I see is around expectations for the results
of the test harness.

For QEMU's functional test suite, an overriding concern is that
a failure of the test suite *MUST* reflect a fault in QEMU.

We want to minimize (ideally eliminate) any failures caused by
factors outside QEMU. A failure should be something that can
be immediately referred back to the author of the PULL that
triggered it, without needing triage to determine if is it a
failure caused by something outside QEMU. A functional test
failure should generally gate the merging of a PULL request,
given that it should reflect a clear QEMU fault.

With this in mind, we don't ever want to be testing unreleased
snapshots, and even for released images, we always want to
fixate on a specific image hash. Similarly the execution  env
of the test suite is a docker container that has fairly well
constrained  software, though currently we do not fixate
our container images on particular package versions, which
has caused us painful spurious failures at times.


An integration test suite, by contrast, should be open to the
idea that failures can be cause by any moving part in the stack,
whether the host OS, QEMU, or the guest OS. Accepting that,
however, means taking on a significantly higher burden in the
triage of failures - that can easily become a full time job for
one or more people, so diagnose problems and then herd cats to
get it fixed in whichever piece was at fault.

This makes integration testing mostly unsuitable for use as a
gating test for merging PULL requests. It would run asynchronously
and problems could potentially take a long time to resolve, though
ideally by resolves by time of rrelease.

> There's got to be some
> way to have some shared responsibility that we can automate. FreeBSD could test
> the most recent release of qemu against a bunch of images in our CI
> cluster. But we
> don't actually have a CI cluster we could put that into (our focus is
> just a little different)
> today.

The issue of CI resources also impacts QEMU :-( We have to be wary that
our upstream testing is using our own limited CI resources, and any
contributors using GitLab CI also have limited quota.

The human constraint is probably the overriding concern I would
have from the QEMU side though. I'd love it if QEMU did full
integration testing across all guestOS we can get our hands on,
both current & forthcoming FreeBSD/Linux releases, and the
countless historical releases of many OS. Realistically we just
don't have the human resources to manage such a testing effort,
even if we found the hardware to support it.

Putting my Fedora hat on, we rebase QEMU in Fedora rawhide when
rc0 comes out, and Fedora's QA team rely on the rawhide QEMU in
doing release testing. While this isn't always timely enough to
prevent QEMU bugs getting into Fedora which then impact Fedora
releases, it is the best we can do given constraints of both
projects.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


