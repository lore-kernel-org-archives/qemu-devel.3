Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E791C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwKC-0000SX-BP; Thu, 25 Jul 2024 07:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWwK9-0000Qt-CH
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWwK5-00073O-4X
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721905666;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QT2qBWKWjRgVF/NaP0JTsRomnVoQ99mUQg6tYZ3y3Hk=;
 b=QZUxWCHNj7t6naRmIxxz+8CDANgsNtbXw3j9IcNIxkaNWUvo9Q7jbENVQfjHLn4yocGHNm
 e0DKW0SNmwtr4ASXrv6vK3xJUE8CvhWdjjgP8DhqbfG5b6L5y2xRyuvuUafH5wNKDkr4D8
 esAs8TU9cYaGDZOJeY1SMNL2IwNWlSA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-i1LTZ2WCMyGVv06RSf6Vew-1; Thu,
 25 Jul 2024 07:07:43 -0400
X-MC-Unique: i1LTZ2WCMyGVv06RSf6Vew-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9850C1955F65; Thu, 25 Jul 2024 11:07:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4831955D45; Thu, 25 Jul 2024 11:07:37 +0000 (UTC)
Date: Thu, 25 Jul 2024 12:07:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 00/23] Convert avocado tests to normal Python unittests
Message-ID: <ZqIx9kGMyUShbzUR@redhat.com>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
 <ZqIhJSbT2qQKJ7lj@redhat.com>
 <df67c0be-e0d1-4ac2-9a88-2765417875ac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df67c0be-e0d1-4ac2-9a88-2765417875ac@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 25, 2024 at 08:42:31PM +1000, Richard Henderson wrote:
> On 7/25/24 19:55, Daniel P. Berrangé wrote:
> > On Thu, Jul 25, 2024 at 09:35:22AM +1000, Richard Henderson wrote:
> > > On 7/25/24 03:52, Thomas Huth wrote:
> > > > The Avocado v88 that we use in QEMU is already on a life support
> > > > system: It is not supported by upstream anymore, and with the latest
> > > > versions of Python, it won't work anymore since it depends on the
> > > > "imp" module that has been removed in Python 3.12.
> > > > 
> > > > There have been several attempts to update the test suite in QEMU
> > > > to a newer version of Avocado, but so far no attempt has successfully
> > > > been merged yet.
> > > > 
> > > > Additionally, the whole "make check" test suite in QEMU is using the
> > > > meson test runner nowadays, so running the python-based tests via the
> > > > Avocodo test runner looks and feels quite like an oddball, requiring
> > > > the users to deal with the knowledge of multiple test runners in
> > > > parallel (e.g. the timeout settings work completely differently).
> > > > 
> > > > So instead of trying to update the python-based test suite in QEMU
> > > > to a newer version of Avocado, we should try to better integrate
> > > > it with the meson test runner instead. Indeed most tests work quite
> > > > nicely without the Avocado framework already, as you can see with
> > > > this patch series - it does not convert all tests, just a subset so
> > > > far, but this already proves that many tests only need small modifi-
> > > > cations to work without Avocado.
> > > > 
> > > > Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
> > > > classes (e.g. based on cloud-init images or using SSH) really depend
> > > > on the Avocado framework, so we'd need a solution for those if we
> > > > want to continue using them. One solution might be to simply use the
> > > > required functions from avocado.utils for these tests, and still run
> > > > them via the meson test runner instead, but that needs some further
> > > > investigation that will be done later.
> > > > 
> > > > 
> > > > Now if you want to try out these patches: Apply the patches, then
> > > > recompile and then run:
> > > > 
> > > >    make check-functional
> > > > 
> > > > You can also run single targets e.g. with:
> > > > 
> > > >    make check-functional-ppc
> > > > 
> > > > You can also run the tests without any test runner now by
> > > > setting the PYTHONPATH environment variable to the "python" folder
> > > > of your source tree, and by specifying the build directory via
> > > > QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
> > > > QEMU binary via QEMU_TEST_QEMU_BINARY. For example:
> > > > 
> > > >    export PYTHONPATH=$HOME/qemu/python
> > > >    export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
> > > >    export QEMU_BUILD_ROOT=$HOME/qemu/build
> > > >    ~/qemu/tests/functional/test_virtio_version.py
> > > > 
> > > > The logs of the tests can be found in the build directory under
> > > > tests/functional/<arch>/<testname> - console log and general logs will
> > > > be put in separate files there.
> > > > 
> > > > Still to be done: Update the documentation for this new test framework.
> > > 
> > > I'll say again that the download *must* be handled separately from the test
> > > with timeout. This is an absolute show-stopper.
> > > 
> > > I've tried this twice now, from a decently fast connection in central
> > > Brisbane, and have had multiple downloads be canceled by the timeout.  Since
> > > the download isn't clever enough to pick up where it left off, it will never
> > > succeed.
> > 
> > This is a tricky problem the way the tests are currently written, given the
> > desire for a minimal-change from the old avocado impl.
> > 
> > IIUC, avocado already had a per-test timeout, so would suffer the same
> > problem with downloads exploding the "normal" running time when cached.
> 
> Avocado runs a first pass doing all of the downloads, and only afterward
> runs the actual timed tests.  I don't know the specifics of how, but it
> certainly obvious in the logging.

Oh interesting, I found how it does it..

The file avocado/plugins/assets.py will build an AST of the python
code in a test file, look for all 'fetch_asset' calls, then extract
the parameters to these calls, and donwload them. This is clever.
Basically avoids the refactoring that I suggested.

So yeah, that is a gap.

Practically speaking, we have a choice of either  calling into this
avocado python lib as is, or copying tthat python lib into QEMU.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


