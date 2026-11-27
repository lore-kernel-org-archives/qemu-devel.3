Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935E606A32F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iZFVUaLM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxxk-0007oR-Qr; Fri, 27 Nov 2026 10:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWxxa-0007mN-Bv
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:34:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWxxV-0007Er-8c
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795793634;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+ZamDehuheFmHLy4v1S7ZwFePHUEe2FL5waZ2OFubE=;
 b=iZFVUaLMr3aBg/vOirHonmXoTOStPtY718qR+Q3RCLxDVSoDxEsi1T8SihJhu0OQmYXyen
 iav3BRQVU+Nhy5qNXCCEbV+fID1HjxyyfJVH6+cRVqPWL1CcIBFKuBs6fVpYP5XLfXniX0
 PQaUPl7BTa7RJw3NrRsce9nOCCdCwZY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-tNswS4s1OVGv9_ZKaMiZhA-1; Fri,
 27 Nov 2026 15:33:52 +0000
X-MC-Unique: tNswS4s1OVGv9_ZKaMiZhA-1
X-Mimecast-MFC-AGG-ID: tNswS4s1OVGv9_ZKaMiZhA_1795793631
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4258D180063F; Fri, 27 Nov 2026 15:33:51 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03B57589; Fri, 27 Nov 2026 15:33:49 +0000 (UTC)
Date: Fri, 27 Nov 2026 15:33:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] migration-test: Support running a real kernel
Message-ID: <awmi2yjNlqyLzAit@redhat.com>
References: <20261126214704.3108327-1-farosas@suse.de>
 <awmJYLLhnMxlWhQP@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <awmNKb0WevtA0L_L@redhat.com> <87h5h2qp59.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5h2qp59.fsf@suse.de>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 12:18:10PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> On Fri, Nov 27, 2026 at 08:45:04AM -0500, Peter Xu wrote:
> 
> >> On Thu, Nov 26, 2026 at 06:46:59PM -0300, Fabiano Rosas wrote:
> >> > There's a class of migration performance bugs that are very specific
> >> > to the internals of QEMU and most likely require work on our side, but
> >> > are currently invisible to our testing because migration-test runs a
> >> > simple guest workload (not even that, really). The more important ones
> >> > are BQL contention issues that result in vcpu starvation.
> >> > 
> >> > My plan is to incrementally add some pieces to migration-test to
> >> > reduce that testing gap.
> >> > 
> >> > The first piece is adding support for running a kernel + initrd inside
> >> > the guest which gives us an easy way to start exercising migration of
> >> > a more loaded guest that can already cause VM exits.
> >> > 
> >> > This series adds support for -kernel and -initrd arguments to
> >> > migration-test and runs the same set of tests we currently have, but
> >> > with the kernel instead of the custom loop. By default it uses the
> >> > initrd from tests/migration-stress/ which runs a read-write loop over
> >> > all memory and has customizable vcpu and memory size.
> >> 
> > The whole thing sounds useful, I'll read into details after I flush more of
> > the older patches.. which will take some time (it also depends on if next
> > week I got some more urgent task "injected"..).
> > 
> 
> Take your time. I just need to put these out sooner rather than later
> because my internal branch is growing too big and I need feedback from
> the list before I get too deep.
> 
> The hugepages series will come probably sometime next week and then I'll
> give you a break while I work on other stuff.
> ---
> 
> > One high level question: this will grow qtest closer to what the
> > functional test is doing.  Have you thought of the relationship
> > between the two, after we move qtest more over there?
> 
> I'm not sure what "move" you mean. Are we porting tests to python? I'm
> definitely open to discussion, whatever it is.
> 
> > I assumed not, based on what you mentioned
> > in the rest part of cover letter that you planned to have it only for dev
> > debug purpose.  But still, we'll start to ask the question to ourselves at
> > some point, IIUC.  So I ask first. :)
> 
> I'm simply going through the path which I see is of least
> resistance. These additions are simple enough. Importantly: with this
> series we would be adding a different workload to the guest, but it
> still runs all the existing migration-tests.
> 
> The same with the hugepages support, it's just another mem_type. For
> this to work with the functional tests we'd need to either duplicate the
> migration-tests there or write new tests. And we'd isolate the existing
> tests entirely from these new features.
> 
> E.g.: I want to work on the migration performance around dirty log
> disabling, it performs worse when hugepages are enabled, it may trigger
> softlockups in the guest and it only happens when migration is aborted.
> 
> The /migration/cancel/src/after/ tests can already exercise that path,
> work well and have caught bugs before. It just need hugepages and a
> kernel:
> 
> args->mem_type=MEM_TYPE_HUGE 
> 
> MIG_KERNEL=vmlinuz \ 
> HUGEPAGES=/dev/hugepages/... \
> migration-test -p .../cancel/src/after
> 
> >
> > In terms of the boundary between functional tests and qtests, I
> > think the guidance is in the names.
> >
> > If it is a "qtest" test then it should be primarily making use
> > of QTest to interrogate the QEMU internalprocess state.
> >
> 
> Hm, quite arbitrary. A "qtest" is a test that uses QTest, ok, but we can
> do whatever kind of testing we want with it. If we want to stick to any
> formal definition, that is. I'm not sure we need to.
> 
> > If it is a "functional"  test, then it is interested in running
> > real kernels & real accelerators and validating the behaviour of
> > QEMU via its external mgmt interfaces.
> >
> > By this definition, IMHO, the migration-test would be a functional
> > test, if it were created from scratch to.
> >
> 
> By any other definition it already is a functional test.
> 
> I'm maybe being too literal. What I think you're trying to indicate
> (maybe Peter as well), is that we should preferably group the functional
> tests under tests/functional and migration-test.c is more functional
> test than anything else, so it should be in there as well. Except that
> since migration-test is written in a different programming language, we
> would have to leave migration-test.c as is and write new migration tests
> under tests/functional.

Yeah, the functional tests have to be python to take advantage of
the generic testing framework there, especially the asset download
caching.

> > It only uses libqtest.h APIs for the purpose of sending QMP
> > commands, not examining internal device state. Essentially it is a
> > historical accident that it is written as a qtest instead of a
> > functional test, as that was the best choice at the time.
> >
> 
> It uses qtest_read* to validate the guest memory, that was probably the
> reason, no?

Oh, indeed, I missed that call :-(
 
> I also don't understand whatever happened to the whole QGraph/QOS thing,
> which, by initial commits seemed it had been written explicitly to
> support live migration testing.

I don't really know the history behind that.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


