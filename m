Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8C4CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNB3V-0005mI-8h; Wed, 13 May 2026 10:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wNB3K-0005jr-C4
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wNB3F-0000qO-Tr
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778684348;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VSjMpTGHGa+GmF2zn14Zfq27IoeGv188A4ustQ0DhdE=;
 b=Nm1MrZJBmY3N+d70DtEthXppcchPbq5uLj5CeAXxAA1f3IAV9Kis0piVp2Jgi/F9oqjyOp
 +uZcU3q2VxNbyTIjnnyr34nBoE6fR2CbrGkJzeOP7d9iql8TdWDOq89CXbI1jHYFUZf+rH
 rYVa7Km+CrjPiBRd8a7arf7K0cTcrIU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-zD8Fl_JTP62GIlrSdtkX-A-1; Wed,
 13 May 2026 10:59:05 -0400
X-MC-Unique: zD8Fl_JTP62GIlrSdtkX-A-1
X-Mimecast-MFC-AGG-ID: zD8Fl_JTP62GIlrSdtkX-A_1778684344
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0491B19560B5; Wed, 13 May 2026 14:59:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.213])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE46A1800576; Wed, 13 May 2026 14:58:59 +0000 (UTC)
Date: Wed, 13 May 2026 15:58:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 14/16] tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
Message-ID: <agSRsLFnD1Jp--lj@redhat.com>
References: <55b66ce4-218c-462f-8e48-0775d5c36cba@oss.qualcomm.com>
 <agNbJS1WeWaxZ_Gx@redhat.com>
 <31eb8204-97bb-4f0e-b90a-048d1b5bf05d@oss.qualcomm.com>
 <agNiPRnoyxd7rBbz@redhat.com>
 <cd3c6a2a-96ad-4276-aa61-8d458d702ba5@oss.qualcomm.com>
 <agN1a8IULLnpAjUa@redhat.com>
 <d997f55b-2e27-478c-9135-a694b7aa8052@oss.qualcomm.com>
 <agN4xgx6Hh2FdYIq@redhat.com>
 <dd212ed3-8cde-4397-9585-9eb5439fe44e@oss.qualcomm.com>
 <87v7crwg9o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7crwg9o.fsf@suse.de>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 13, 2026 at 11:11:47AM -0300, Fabiano Rosas wrote:
> In the case of an environment variable, it's possible to set it without
> any code change (even to .yaml files), by setting "-o ci.variable=<val>"
> at git push time and also by setting directly in GitLab's web interface
> under "New Pipeline". So it allows anyone wanting to "just get work
> done" to skip broken tests for the duration of a pipeline.
> 
> It also works when running locally and skipping some tests for the
> single local run.
> 
> All temporary changes, of course.
> 
> For the case of a flaky test that will need to be disabled for longer
> than a single run, could we standardize on a list committed to
> meson.build, so it works for both CI and local?  I think so, and I think
> it's a good idea. Having recently taking up maintainership of QTests I
> sometimes stumble into disabled tests that have been there for years and
> everyone forgot about them. Same with the migration subsystem. Having a
> single place to check from time to time would be helpful.

That was one of the reasons why when wwe introduced the "QEMU_TEST_FLAKY_TESTS"
env in tests/functional, we mandated a gitlab issue URL is provided. This 
gives us a record of why it was turned off both in the code and issue tracker.

If we can keep all permanent test disablement behind QEMU_TEST_FLAKY_TESTS
we avoid needing to add logic to meson.build too.


> Migration, by the way, has been using the env variable approach in qtest
> like this:
> 
>     /*
>      * Our CI system has problems with shared memory.
>      * Don't run this test until we find a workaround.
>      */
>     if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> 
> Which is a case in which a single list committed in meson.build wouldn't
> help. We actually do want to skip this only for CI.
> ("problems with shared memory" here means that CI environments simply
> don't have enough shared memory space available to run all the tests
> that make use of it)
> 
> A further complication is that in the migration case above, that skip
> does not apply to the entire migration-test, it applies to a sub-test
> (./migration-test -p /x86/migration/mode/reboot). Constructs in
> meson.build would not be able to skip this, they can only skip the
> entire migration-test. There is an -x option that gtester accepts, so
> we'd need to write some meson-fu to invoke "./migration-test -x
> /x86/migration/mode/reboot -x ..." if any subtest is to be skipped (note
> that this is not migration-specific, all qtests that invoke
> g_test_add_data* more than once are like this).
> 
> Maybe we could work on a proposal to improve this in a generic way for
> all test frameworks.

I have dropped this patch in my v6 posting, as it would indeed be
much more useful if it worked across all the test subsystems.

My v6 has meanwhile introduced the QEMU_TEST_FLAKY_TESTS concept
to the I/O tests (as suggested by Thomas), to skip the dodgy I/O
test universally in all scenarios which satisfies Pierrick's
request.

> PS: I'd even say there's a lot we could make common between
> frameworks. A bunch of what happens around running a test is generic
> programming, not tied to a specific programming language or accelerator
> (in case of qtest).

Yeah, getting everything being represented as meson tests was one
of the things we did to make the frameworks more common.

I think there's scope for having more common env variable names
too. eg we have different env variable names to specify the name
of the QEMU emulator binary which is a bit silly.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


