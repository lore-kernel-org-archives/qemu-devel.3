Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA242C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPjj-0001vm-Bv; Mon, 29 Jul 2024 08:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYPji-0001sw-IH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYPjf-0003iu-Ru
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722257058;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBAu68f3GMnOY+J43WEx609iQuyelbFVZ6kpfvjyU4A=;
 b=Bj5lCdkVPb+JXN+Xgn+336EBXvt3JkPMTYwZ3G3qedSwIIqF4AgsQrIdCRT7/c7sH33zpi
 XX6d8q0wgc7l3AlX5pgbqHFKFm4ut1P5YklvUzFmZF7gMhqNTz+6GnYQeCQSjhVGLXPkEe
 IpFP2gG9EWxchGiYAYqNqvrMWjl07A4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-AFJ6ALD2OsWdckHm6LJwfQ-1; Mon,
 29 Jul 2024 08:44:15 -0400
X-MC-Unique: AFJ6ALD2OsWdckHm6LJwfQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1B9A1955BFE; Mon, 29 Jul 2024 12:44:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6E151955D42; Mon, 29 Jul 2024 12:44:09 +0000 (UTC)
Date: Mon, 29 Jul 2024 13:44:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
Message-ID: <ZqeOlkYnzSzwNYBL@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <CA+bd_6LbLbR5hEqUhn5Vutf1k5HsB4Zg=qYF-Tq_pOrxDeWo1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+bd_6LbLbR5hEqUhn5Vutf1k5HsB4Zg=qYF-Tq_pOrxDeWo1A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Jul 25, 2024 at 10:21:54AM -0400, Cleber Rosa wrote:
> On Tue, Jul 16, 2024 at 7:28 AM Thomas Huth <thuth@redhat.com> wrote:
> > There have been several attempts to update the test suite in QEMU
> > to a newer version of Avocado, but so far no attempt has successfully
> > been merged yet.
> >
> 
> So, we've seen in the past an attempt to update Avocado from 88.1 to a
> regular release, and the troubles it caused, including a revert.  My
> take was that a LTS version should be used, but during this time,
> Avocado experienced a rewrite and having it replacing the old
> implementation in a production level project such as QEMU was tricky.

IMHO the problems with updating avocado in QEMU are a sign that we're
suffering from excess complexity, as it shouldn't be this difficult to
update the test harness. That we need to stick on an LTS release to
protect us from further instability further suggests that we would
benefit from a much simpler solution here. 

> > Additionally, the whole "make check" test suite in QEMU is using the
> > meson test runner nowadays, so running the python-based tests via the
> > Avocodo test runner looks and feels quite like an oddball, requiring
> > the users to deal with the knowledge of multiple test runners in
> > parallel (e.g. the timeout settings work completely differently).
> >
> 
> Now I believe we can be very much in sync here.  I've thought for a
> while that there's no reason for Avocado to cooperate or be compatible
> with Meson.  There's no reason why users can't simply pick how the
> test gets run.  In fact, with the new Avocado architecture, you don't
> even need to run "avocado" to run an "avocado-instrumented" test.  You
> could pretty much run "avocado-runner-avocado-instrumented" with the
> right parameters through Meson.

Looking back to when we introduced avocado, we still had our original
home grown build system, and multiple different ways to run integrate
testing betwen our unit tests / qtests and block iotests. Adding
avocado to the mix introduced a third way to run tests. All round it
was rather a mess of inconsistent approaches to testing, but that was
a fact of life with our old home grown build/test process.

Today we have adopted a much more standardized build system via meson.
While we do still have the block iotests harness, we now expose every
test to meson individually to reduce what the intermediate harness
needs to be involved in doing. Thomas' series here is bringing the same
simplified integration to our functional tests, such that each functional
test is known to meson individually. Overall we'll now have a consistent
approach to integrating tests into meson, without intermediate harnesses
adding their own logic.

I think this will make it easier for QEMU maintainers to understand how
the tests are working, and make it easier to maintain them and troubleshoot
failures.

So overall I'm not seeing a compelling reason for us to offer users a
choice between meson & avocado how they run tests. Such choice is a maint
burden over the long term, as we need to validate that both options keep
working. Focusing on a single option reduces the complexity and maint
work and gives us more flexiblity to evolve the code over time.


> > So instead of trying to update the python-based test suite in QEMU
> > to a newer version of Avocado, we should maybe try to better integrate
> > it with the meson test runner instead. Indeed most tests work quite
> > nicely without the Avocado framework already, as you can see with
> > this patch series - it does not convert all tests, just a subset so
> > far, but this already proves that many tests only need small modifi-
> > cations to work without Avocado.
> >
> > Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
> > classes (e.g. based on cloud-init images or using SSH) really depend
> > on the Avocado framework, so we'd need a solution for those if we
> > want to continue using them. One solution might be to simply use the
> > required functions from avocado.utils for these tests, and still run
> > them via the meson test runner instead, but that needs some further
> > investigation that will be done later.
> >
> 
> So, I believe this type of higher level testing is something that
> needs to remain, and even grow.  Speaking for Red Hat, I see the
> movement of QE contributing more Avocado-VT style tests into QEMU
> itself.  This means way more libraries and features that go into a
> common set of utilities and features (more on that later) than it
> currently exists in avocado.utils.

The series here is showing how simple it is to adapt our existing
tests to the new execution approach, so shouldn't have a significant
impact on ability of people to contribute futher tests in future.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


