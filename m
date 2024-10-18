Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AD5D2127B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1irp-0002Iz-60; Fri, 18 Oct 2024 05:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1irl-0002Ih-5O
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1iri-00056V-Ap
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729242105;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxgSqIWYuy4xcOuSuTF5EAK/Li8iIB+CAAdWFR9KzsM=;
 b=WacROtwBqFH91JyQigpedu+m9lF4LJY0orEG/lyLiu3rQMl9ic07u5qF2vpg+EH/FQfAfv
 CaSSnYmD3AXl0VbAev4+HbY6XJ7HknG1d9sWcVcV2Q3khAnVXgZtJylg+8IOMJGGBHYbm9
 YrJcwG0BPM2op4WT3D2RFDbNmsxeaVk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-vCXDmfTRPWKLyxdqYDpMFQ-1; Fri,
 18 Oct 2024 05:01:40 -0400
X-MC-Unique: vCXDmfTRPWKLyxdqYDpMFQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA5AB1955D4A; Fri, 18 Oct 2024 09:01:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE1C919560A3; Fri, 18 Oct 2024 09:01:34 +0000 (UTC)
Date: Fri, 18 Oct 2024 10:01:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
Message-ID: <ZxIj694WqXwwMRIY@redhat.com>
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de>
 <ZxEl4zYgHLoLeHCT@redhat.com> <87r08e3d74.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r08e3d74.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Thu, Oct 17, 2024 at 01:29:35PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Oct 17, 2024 at 11:32:11AM -0300, Fabiano Rosas wrote:
> >> Recent changes to how we invoke the migration tests have
> >> (intentionally) caused them to not be part of the check-qtest target
> >> anymore. Add the check-migration-quick target so we don't lose
> >> migration code testing in this job.
> >
> > But 'check-migration-quick' is only the subset of migration tests,
> > 'check-migration' is all of the migration tests. So surely this is
> > a massive regressions in covage in CI pipelines.
> 
> I'm not sure it is. There are tests there already for all the major
> parts of the code: precopy, postcopy, multifd, socket. Besides, we can
> tweak migration-quick to cover spots where we think we're losing
> coverage.

Each of the tests in migration-test  were added for a good reason,
generally to address testing gaps where we had functional regressions
in the past. I don't think its a good idea to stop running such tests
in CI as gating on new contributions. Any time we've had optional
tests in QEMU, we've seen repeated regressions in the area in question.

> Since our CI offers nothing in terms of reproducibility or
> debuggability, I don't think it's productive to have an increasing
> amount of tests running in CI if that means we'll be dealing with
> timeouts and intermittent crashes constantly.

Test reliability is a different thing. If a particular test is
flaky, it needs to either be fixed or disabled. Splitting into
a fast & slow grouping doesn't address reliability, just hides
the problem from view.

> > Experience shows us that relying on humans to run tests periodically
> > doesn't work well, and they'll slowly bit rot. Migration maintainers
> > don't have a way to run this as gating test for every pull request
> > that merges, and pull requests coming from non-migration maintainers
> > can still break migration code.
> 
> Right, but migration code would still be tested with migration-quick
> which is executed at every make check. Do we really need the full set in
> every pull request? We must draw a line somewhere, otherwise make check
> will just balloon in duration.

Again, the tests all exist because migration code is incredibly
complicated, with a lot of permutations, with a history of being
very bug / regression prone. With that in mind, it is unavoidable
that we're going to have a significant testing overhead for
migration code.

Looking at its execution time right now, I'd say migration test
is pretty good, considering the permutations we have to target.

It gets a bad reputation because historically it has been as
much as x20 slower than it is today, and has also struggled
with reliability. The latter is a reflection of the complexity
of migration and and IMHO actually justifies greater testing,
as long as we put in time to address bugs.

Also we've got one single test program, covering an entire
subsystem in one go, rather than lots of short individual
test programs, so migration unfairly gets blamed for being
slow, when it simply covers alot of functionality in one
program.

> > Any tests in tree need to be exercised by CI as the minimum bar
> > to prevent bit rot from merges.
> >
> 
> No disagreement here. But then I'm going to need advice on what to do
> when other maintainers ask us to stop writing migration tests because
> they take too long. I cannot send contributors away nor merge code
> without tests.

In general, I think it is unreasonable for other maintainers to
tell us to stop adding test coverage for migration, and would
push back against such a request. 

We should, however, continue to optimize how we add further test
coverage, where practical, overload testing of multiple features
onto a single test case helps.

We've already massively optimized the migration-test compared to
its historical behaviour.

A potentially bigger win could be seen if we change how we exercise
the migration functionality. Since we had the migration qtest that
runs a full migration operation, we've tended to expand testing by
adding new qtest functions. ie we've added a functional test for
everything we want covered. This is nice & simple, but also expensive.
We've ignored unit testing, which I think is a mistake.

If i look at the test list:

# /x86_64/migration/bad_dest
# /x86_64/migration/analyze-script
# /x86_64/migration/validate_uuid
# /x86_64/migration/validate_uuid_error
# /x86_64/migration/validate_uuid_src_not_set
# /x86_64/migration/validate_uuid_dst_not_set
# /x86_64/migration/dirty_ring
# /x86_64/migration/precopy/file
# /x86_64/migration/precopy/unix/plain
# /x86_64/migration/precopy/unix/suspend/live
# /x86_64/migration/precopy/unix/suspend/notlive
# /x86_64/migration/precopy/unix/tls/psk
# /x86_64/migration/precopy/unix/tls/x509/default-host
# /x86_64/migration/precopy/unix/tls/x509/override-host
# /x86_64/migration/precopy/file/offset
# /x86_64/migration/precopy/file/mapped-ram
# /x86_64/migration/precopy/file/offset/fdset
# /x86_64/migration/precopy/file/offset/bad
# /x86_64/migration/precopy/file/mapped-ram/live
# /x86_64/migration/precopy/tcp/plain
# /x86_64/migration/precopy/tcp/plain/switchover-ack
# /x86_64/migration/precopy/tcp/tls/psk/match
# /x86_64/migration/precopy/tcp/tls/psk/mismatch
# /x86_64/migration/precopy/tcp/tls/x509/default-host
# /x86_64/migration/precopy/tcp/tls/x509/override-host
# /x86_64/migration/precopy/tcp/tls/x509/mismatch-host
# /x86_64/migration/precopy/tcp/tls/x509/friendly-client
# /x86_64/migration/precopy/tcp/tls/x509/hostile-client
# /x86_64/migration/precopy/tcp/tls/x509/allow-anon-client
# /x86_64/migration/precopy/tcp/tls/x509/reject-anon-client
# /x86_64/migration/precopy/fd/tcp
# /x86_64/migration/precopy/fd/file
# /x86_64/migration/multifd/file/mapped-ram
# /x86_64/migration/multifd/file/mapped-ram/live
# /x86_64/migration/multifd/file/mapped-ram/dio
# /x86_64/migration/multifd/file/mapped-ram/fdset
# /x86_64/migration/multifd/file/mapped-ram/fdset/dio
# /x86_64/migration/multifd/tcp/uri/plain/none
# /x86_64/migration/multifd/tcp/channels/plain/none
# /x86_64/migration/multifd/tcp/plain/cancel
# /x86_64/migration/multifd/tcp/plain/zlib
# /x86_64/migration/multifd/tcp/plain/zstd
# /x86_64/migration/multifd/tcp/plain/zero-page/legacy
# /x86_64/migration/multifd/tcp/plain/zero-page/none
# /x86_64/migration/multifd/tcp/tls/psk/match
# /x86_64/migration/multifd/tcp/tls/psk/mismatch
# /x86_64/migration/multifd/tcp/tls/x509/default-host
# /x86_64/migration/multifd/tcp/tls/x509/override-host
# /x86_64/migration/multifd/tcp/tls/x509/mismatch-host
# /x86_64/migration/multifd/tcp/tls/x509/allow-anon-client
# /x86_64/migration/multifd/tcp/tls/x509/reject-anon-client
# /x86_64/migration/validate_uri/channels/both_set
# /x86_64/migration/validate_uri/channels/none_set

Individually none of those is very slow on its own - 10 are in
the 2-3 second range,  35 are 1-2 secs,  and 6 are less than
1 second.

A very large portion of those are validating different ways to
establish migration. Hardly any of them actually need to run
a migration to completion. Even without running to completion
though, we have the overheads of spawning 2 QEMUs.

This feels like something that should be amenable to unit testing.
Might need a little re-factoring of migration code to make it
easier to run a subset of its logic in isolation, but that'd
probably be a win anyway, as such work usually makes code cleaner.

> Do we need nightly CI runs? Unit tests? Bear in mind there's a resource
> allocation issue there. Addressing problems with timeouts/races in our
> CI is not something any random person can do.

In terms of running time, I think migration-test is acceptable as it is
to run in 'make check' by default and doesn't justify dropping test
coverage. We should still look to optimize & move to unit testing more
code, and any reliability issues are something that needs to be addressed
too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


