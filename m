Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29358D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jmk-00059I-7s; Fri, 18 Oct 2024 06:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1jmg-00058n-KB
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1jmc-0003eJ-JE
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729245633;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeoxWHbJM+tgdoQ5pazQf6H9dmIG5GQcbkYC6UXrcgc=;
 b=hHgHw2y6GU9MfCCJW0AGefVhr/VvESjL3a4ubODA84/vZQXKNChFZQ6/cnCVLrQIXAXHYR
 nE0G2hDPZuxA3GygBJzCk1CMHAgl2tktbf92madrvNVWPE5zXN6QE5+0oYK8Qz+3Cbn1Pr
 jGNNqpdJQXI1Uabz6Q5ysWWYwBP20XI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-HTPRbvrJNTymUhmiPQEqsg-1; Fri,
 18 Oct 2024 06:00:29 -0400
X-MC-Unique: HTPRbvrJNTymUhmiPQEqsg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B611C1956069; Fri, 18 Oct 2024 10:00:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA35A19560A2; Fri, 18 Oct 2024 10:00:23 +0000 (UTC)
Date: Fri, 18 Oct 2024 11:00:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
Message-ID: <ZxIxsw265Au7fI-x@redhat.com>
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de>
 <ZxEl4zYgHLoLeHCT@redhat.com> <87r08e3d74.fsf@suse.de>
 <ZxIj694WqXwwMRIY@redhat.com>
 <CAFEAcA8XCBrbqGDesL+5su-2Bk_YR1iQ6_X_j9tJZmNK1Kw=pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8XCBrbqGDesL+5su-2Bk_YR1iQ6_X_j9tJZmNK1Kw=pQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 18, 2024 at 10:46:55AM +0100, Peter Maydell wrote:
> On Fri, 18 Oct 2024 at 10:01, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Oct 17, 2024 at 01:29:35PM -0300, Fabiano Rosas wrote:
> > > Daniel P. Berrangé <berrange@redhat.com> writes:
> > >
> > > > On Thu, Oct 17, 2024 at 11:32:11AM -0300, Fabiano Rosas wrote:
> > > >> Recent changes to how we invoke the migration tests have
> > > >> (intentionally) caused them to not be part of the check-qtest target
> > > >> anymore. Add the check-migration-quick target so we don't lose
> > > >> migration code testing in this job.
> > > >
> > > > But 'check-migration-quick' is only the subset of migration tests,
> > > > 'check-migration' is all of the migration tests. So surely this is
> > > > a massive regressions in covage in CI pipelines.
> > >
> > > I'm not sure it is. There are tests there already for all the major
> > > parts of the code: precopy, postcopy, multifd, socket. Besides, we can
> > > tweak migration-quick to cover spots where we think we're losing
> > > coverage.
> >
> > Each of the tests in migration-test  were added for a good reason,
> > generally to address testing gaps where we had functional regressions
> > in the past. I don't think its a good idea to stop running such tests
> > in CI as gating on new contributions. Any time we've had optional
> > tests in QEMU, we've seen repeated regressions in the area in question.
> >
> > > Since our CI offers nothing in terms of reproducibility or
> > > debuggability, I don't think it's productive to have an increasing
> > > amount of tests running in CI if that means we'll be dealing with
> > > timeouts and intermittent crashes constantly.
> >
> > Test reliability is a different thing. If a particular test is
> > flaky, it needs to either be fixed or disabled. Splitting into
> > a fast & slow grouping doesn't address reliability, just hides
> > the problem from view.
> 
> A lot of the current reliability issue is timeouts -- sometimes
> our CI runners just run really slow (I have seen an example where
> between a normal and a slow run on the same commit both the
> compile and test times were 10x different...) So any test
> that is not a fast-to-complete is much much more likely to
> hit its timeout if the runner is running slowly. When I am
> doing CI testing for merges "migration test timed out again"
> is really really common.

If its frequently timing out, then we've got the timeouts
wrong, or we have some genuine bugs in there to be fixed.

> > > No disagreement here. But then I'm going to need advice on what to do
> > > when other maintainers ask us to stop writing migration tests because
> > > they take too long. I cannot send contributors away nor merge code
> > > without tests.
> >
> > In general, I think it is unreasonable for other maintainers to
> > tell us to stop adding test coverage for migration, and would
> > push back against such a request.
> 
> We do not have infinite CI resources, unfortunately. Migration
> is competing with everything else for time on CI. You have to
> find a balance between "what do we run every time" and "what
> do we only run when specifically testing a migration pullreq".
> Similarly, there's a lot of iotests but we don't run all of them
> for every block backend for every CI job via "make check".

The combos we don't run for iotests are a good source of
regressions too :-(

> Long test times for tests run under "make check" are also bad
> for individual developers -- if I'm running "make check" to
> test a target/arm change I've made I don't really want that
> to then spend 15 minutes testing the migration code that
> I haven't touched and that is vanishingly unlikely to be
> affected by my patches.

Migration-test *used* to take 15 minutes to run, but that was a
very long time ago. A run of it today is around 1m20.

That said, if you are building multiple system emulators, we
run the same test multiple times, and with the number of
targets we have, that will be painful.

That could be a good reason to split the migration-test into
two distinct programs. One program that runs for every target,
and one that is only run once, for some arbitrary "primary"
target ?  Or could we make use of glib's g_test_thorough
for this - a primary target runs with "SPEED=through" and
all other targets with normal settings. That would give us
a way to optimize any of the qtests to reduce redundant
testing where appropriate.


If we move alot of testing out into a migration unit test,
this also solves the redundancy problem.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


