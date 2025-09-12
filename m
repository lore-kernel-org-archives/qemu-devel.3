Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE331CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6cg-0003sa-0W; Fri, 12 Sep 2025 12:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux6cc-0003ro-Ii
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux6ca-0005Kq-4j
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757694452;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//L2yzJuGsOhJLqgfock8vAU13aMabEEadblK1cUc18=;
 b=FkSNvXxwtWKfNMUOIQlxzKfRSjNo4SpzuKiEH/E9xF8KgEA3neoO9mXm9OnpaMUUNtyiPg
 gSa+XGsyxNWhyqAkKMA4fnfByXM7lyeEsfdP1bSx6wYUEHcRRHlZNtjmOjOOwKcMRywpYd
 13UvLSKldMGHjpMI/BJyJe4wRf4HXVE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-ICu-BQpNNMGgVsZV6zHXpQ-1; Fri,
 12 Sep 2025 12:27:29 -0400
X-MC-Unique: ICu-BQpNNMGgVsZV6zHXpQ-1
X-Mimecast-MFC-AGG-ID: ICu-BQpNNMGgVsZV6zHXpQ_1757694448
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07D1A1955E9E; Fri, 12 Sep 2025 16:27:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0BE619560B9; Fri, 12 Sep 2025 16:27:25 +0000 (UTC)
Date: Fri, 12 Sep 2025 17:27:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 thuth@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 0/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
Message-ID: <aMRJ6nfXF2l7iu7b@redhat.com>
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <aL7CsSppNc-WZFY-@redhat.com>
 <a6320118-84f0-4088-82de-7192be6093cd@linaro.org>
 <aMQzD0m3QluWzlmh@redhat.com> <871pob64iv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pob64iv.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Sep 12, 2025 at 05:04:40PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Sep 11, 2025 at 08:51:08PM -0300, Gustavo Romero wrote:
> >> Hi Daniel,
> >> 
> >> Thanks a lot for review and the suggestions.
> >> 
> >> On 9/8/25 08:49, Daniel P. Berrangé wrote:
> >> > On Thu, Sep 04, 2025 at 03:46:35PM +0000, Gustavo Romero wrote:
> >> > > In this series, we leveraged the run-test.py script used in the
> >> > > check-tcg tests, making it a GDB runner capable of calling a test script
> >> > > without spawning any VMs. In this configuration, the test scripts can
> >> > > manage the VM and also import gdb, making the GDB Python API inside the
> >> > > functional test scripts.
> >> > > 
> >> > > A --quiet option has been added to run-test.py so it doesn't print the
> >> > > command line used to execute GDB to the stdout. This ensures that users
> >> > > don't get confused about how to re-run the tests. One can re-run the
> >> > > test simply by copying and pasting the command line shown by Meson when
> >> > > V=1 is passed:
> >> > > 
> >> > > $ make -j check-functional V=1
> >> > > 
> >> > > or, alternatively, once the test run completes, the exact command found
> >> > > in the 'command:' field of the build/meson-logs/testlog-thorough.txt
> >> > > file generated by Meson. Both methods provide the correct environment
> >> > > variables required to run the test, such as the proper $PYTHONPATH.
> >> > 
> >> > While I like the conceptual idea of just sending human GDB commands,
> >> > instead of working with GDB protocol packets, I really dislike the
> >> > effect this has on the execution / startup of the functional tests
> >> > via use of the custom runner for a number of reasons
> >> > 
> >> >   * The command line for launching the test outside of meson is very
> >> >     complicated, so not memorable
> >> 
> >> Why very complicated? It calls a simple runner instead of calling the
> >> test script directly, but it doesn't change the way to re-run a single
> >> test. One just have to pass V=1 to see make's command line  and copy
> >> and paste the full command line to re-run the test. I mentioned
> >> inspecting 'testlog-thorough.txt' just for completeness.
> >
> > Today we can run the individual tests directly 
> >
> >  # ./tests/functional/x86_64/test_reverse_debug.py
> >  TAP version 13
> >  ok 1 test_reverse_debug.ReverseDebugging_X86_64.test_x86_64_pc
> >  1..1
> >
> >
> > (assuming you have PYTHONPATH and QEMU_TEST_QEMU_BINARY env set)
> 
> and the old version of Avocado...
> 
> > This gives you a very easy way to interact with the test, see
> > its progress, understand what failed, and debug it with strace,
> > etc.
> >
> > This change looses all that. It appears I can run it with
> >
> >   # ./tests/guest-debug/run-test.py --quiet --gdb gdb --test \
> >        ./tests/functional/x86_64/test_reverse_debug.py
> >
> <snip>
> >
> >
> > This undermines the core goals of what we aimed to achieve with
> > the new functional test harness.
> >
> >> 
> >> >   * It makes the meson.build rules much more complicated
> >> 
> >> Do we want to never augment functional tests' meson.build? Nothing
> >> complicated is being added. Basically, just a new variable suffixed with
> >> '_with_runner' which holds a tuple (test, runner) that tell the test
> >> to be executed, following the same logic we already have for all the other
> >> variables that specify the tests per arch/mode/speed.
> >> 
> >> Another option would be to select a runner based on a suffix in the test
> >> name, for instance, 'reverse_debug_with_runner.py'.
> >
> > IMHO the overall concept of using the run-test.py runner for launching
> > the tests is flawed and not viable. It adds too much complexity to the
> > use of the tests, and harms the output.
> 
> 
> 
> >
> >> >   * Running standalone there is no TAP output available making the
> >> >     test hard to debug on failure or timeout
> >> 
> >> This is because of an unfortunate GDB Python API issue, please see my
> >> reply in your comment on patch 5/5. This can be solved but needs more
> >> investigation on GDB side.
> >> 
> >> 
> >> > I understand the need to spawn the test via gdb, in order to be able
> >> > to import the 'gdb' python module. Looking at what reverse_debugging.py
> >> > does, however, makes me question whether we actually need to directly
> >> > use the 'gdb' python module.
> >> > 
> >> > The only APIs we use are 'gdb.execute' and 'gdb.parse_and_eval'.
> >> > 
> >> > The latter is only used once as
> >> > 
> >> >    gdb.parse_and_eval("$pc")
> >> > 
> >> > and I believe that can be changed to
> >> > 
> >> >    gdb.execute("printf \"0x%x\", $pc", to_string=True)
> >> > 
> >> > IOW, all we need is 'gdb.execute("....", to_string=True)'
> >> 
> >> Yes, I do want to directly use the 'gdb' python module directly in the
> >> tests. We shouldn't look at a solution only for reverse_debug.py but also
> >> think of any future tests that will require the GDB Python API, so I don't
> >> want to specialize here and reduce the API to a single method.
> >
> > If any other tests needing GDB arrive int he future we can consider
> > them at that time.
> 
> We already have a whole chunk of gdb tests under check-tcg. Maybe it
> would be easier just to re-write the tests to use the check-tcg system
> tests rather than jumping through hoops to fit in with the
> check-functional requirements.

Well if 'easy' is our goal, then we can just copy the gdbmi.py
file from avocado into our test suite. It didn't originate in
avocado to begin with, they copied it from its orignal repo
to then port it to py3. The only real downside with gdbmi is
that the machine level protocol is ugly to read, but I'll take
that over this current patch, as I think the reverse debugging
stuff is a match for the functional test suite, and moving to
the tcg tests still leaves us with the unpleasant interaction
and debugging issue that I've described - they're just hidden
from the functional test suite, but still impacting QEMU as a
whole.

> >> > With a little extra helper proxy script, we can achieve this without
> >> > changing the way scripts are launched.
> >> > 
> >> > The script needs to listen on a UNIX socket path. When a client
> >> > connects, it should read lines of data from the client and pass
> >> > them to 'gdb.execute(..., to_string=True)' and whatever data
> >> > gdb returns should be written back to the client.
> >> > 
> >> > A very very crude example with no error handling would be:
> 
> My concern is it probably isn't quite that simple - and we have just
> invented YAGMI (Yet Another GDB Machine Interface) module. The fact that
> we have no widely packaged python gdb interface is probably a testament
> to the edge cases that exist.

I agree it isn't simple if the TCG tests are in scope, but from the POV
to the reverse debugging functional test it looks simple. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


