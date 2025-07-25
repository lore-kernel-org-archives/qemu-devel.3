Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B45DC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEhD-0001yQ-WC; Fri, 25 Jul 2025 05:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufEhB-0001vH-78
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufEh8-0002Rh-PJ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753435585;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4npbO3OzrxtQ7IWwzMweWeEERHsy7bOQkXnKYUYgCOQ=;
 b=QrRMomWIefkbCDrai2pg2u1LS+AJEJAUS3tCTvkQFMyA2rx+/ZbRvjC2TldpgRzOV4bVJ4
 bl1HQ1XHtoJYBXbaYrKHXRvUwfrKYzI3do/0ooXedoXGJJZfaVH12hwx/q8eBdgWQ1wZ+T
 xy+7zDtAdRUcan2fMeGYJ01iozZnEMY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-iuoYBcPoO_uq9McPrnfGkg-1; Fri,
 25 Jul 2025 05:26:19 -0400
X-MC-Unique: iuoYBcPoO_uq9McPrnfGkg-1
X-Mimecast-MFC-AGG-ID: iuoYBcPoO_uq9McPrnfGkg_1753435578
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A040B180087F; Fri, 25 Jul 2025 09:26:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80520180035E; Fri, 25 Jul 2025 09:26:15 +0000 (UTC)
Date: Fri, 25 Jul 2025 10:26:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2] tests/functional: add --debug CLI arg
Message-ID: <aINNtGy6FIFbGMWn@redhat.com>
References: <20250717-functional_tests_debug_arg-v2-1-4f0d991e16f7@linaro.org>
 <71e58abc-9544-47e8-85ae-d880c5dc6d8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71e58abc-9544-47e8-85ae-d880c5dc6d8f@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 25, 2025 at 06:28:31AM +0200, Thomas Huth wrote:
> On 17/07/2025 12.34, Manos Pitsidianakis wrote:
> > Add argument parsing to functional tests to improve developer experience
> > when running individual tests. All logs are printed to stdout
> > interspersed with TAP output.
> > 
> > Example usage, assuming current build directory with qemu source code in
> > the parent directory (see docs/devel/testing/functional.rst for details):
> > 
> >    $ export PYTHONPATH=../python:../tests/functional
> >    $ export QEMU_TEST_QEMU_BINARY="$(pwd)/qemu-system-aarch64"
> >    $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
> >    usage: test_aarch64_virt [-h] [-d]
> > 
> >    QEMU Functional test
> > 
> >    options:
> >      -h, --help   show this help message and exit
> >      -d, --debug  Also print test and console logs on stdout. This will
> >                   make the TAP output invalid and is meant for debugging
> >                   only.
> > 
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > Changes in v2:
> > - Store stdout handler in `self` object (thanks Daniel)
> > - Deduplicate handler removal code (Daniel)
> > - Amend commit description to mention PYTHONPATH (thanks Alex)
> > - Link to v1: https://lore.kernel.org/qemu-devel/20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org
> > ---
> >   docs/devel/testing/functional.rst      |  2 ++
> >   tests/functional/qemu_test/testcase.py | 48 +++++++++++++++++++++++++++++++---
> >   2 files changed, 47 insertions(+), 3 deletions(-)
> > 
> > diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> > index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb0296f578cfaa4bd66d 100644
> > --- a/docs/devel/testing/functional.rst
> > +++ b/docs/devel/testing/functional.rst
> > @@ -63,6 +63,8 @@ directory should be your build folder. For example::
> >     $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
> >     $ pyvenv/bin/python3 ../tests/functional/test_file.py
> > +By default, functional tests redirect informational logs and console output to
> > +log files. Specify the ``--debug`` flag to also print those to standard output.
> >   The test framework will automatically purge any scratch files created during
> >   the tests. If needing to debug a failed test, it is possible to keep these
> >   files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..3ecaaeffd4df2945fb4c44b4ddef6911527099b9 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -11,6 +11,7 @@
> >   # This work is licensed under the terms of the GNU GPL, version 2 or
> >   # later.  See the COPYING file in the top-level directory.
> > +import argparse
> >   import logging
> >   import os
> >   from pathlib import Path
> > @@ -31,6 +32,20 @@
> >   from .uncompress import uncompress
> > +def parse_args(test_name: str) -> argparse.Namespace:
> > +    parser = argparse.ArgumentParser(
> > +        prog=test_name, description="QEMU Functional test"
> > +    )
> > +    parser.add_argument(
> > +        "-d",
> > +        "--debug",
> > +        action="store_true",
> > +        help="Also print test and console logs on stdout. This will make the"
> > +        " TAP output invalid and is meant for debugging only.",
> > +    )
> > +    return parser.parse_args()
> > +
> > +
> >   class QemuBaseTest(unittest.TestCase):
> >       '''
> > @@ -196,6 +211,16 @@ def assets_available(self):
> >           return True
> >       def setUp(self):
> > +        path = os.path.basename(sys.argv[0])[:-3]
> > +        args = parse_args(path)
> > +        self.stdout_handler = None
> > +        if args.debug:
> > +            self.stdout_handler = logging.StreamHandler(sys.stdout)
> > +            self.stdout_handler.setLevel(logging.DEBUG)
> > +            formatter = logging.Formatter(
> > +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> > +            )
> > +            self.stdout_handler.setFormatter(formatter)
> >           self.qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
> >           self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
> >           self.arch = self.qemu_bin.split('-')[-1]
> > @@ -215,12 +240,17 @@ def setUp(self):
> >               '%(asctime)s - %(levelname)s: %(message)s')
> >           self._log_fh.setFormatter(fileFormatter)
> >           self.log.addHandler(self._log_fh)
> > +        if self.stdout_handler:
> > +            self.log.addHandler(self.stdout_handler)
> >           # Capture QEMUMachine logging
> >           self.machinelog = logging.getLogger('qemu.machine')
> >           self.machinelog.setLevel(logging.DEBUG)
> >           self.machinelog.addHandler(self._log_fh)
> > +        if self.stdout_handler:
> > +            self.machinelog.addHandler(self.stdout_handler)
> > +
> >           if not self.assets_available():
> >               self.skipTest('One or more assets is not available')
> > @@ -230,11 +260,18 @@ def tearDown(self):
> >           if self.socketdir is not None:
> >               shutil.rmtree(self.socketdir.name)
> >               self.socketdir = None
> > -        self.machinelog.removeHandler(self._log_fh)
> > -        self.log.removeHandler(self._log_fh)
> > +        for handler in [self._log_fh, self.stdout_handler]:
> > +            if handler is None:
> > +                continue
> > +            self.machinelog.removeHandler(handler)
> > +            self.log.removeHandler(handler)
> >       def main():
> >           path = os.path.basename(sys.argv[0])[:-3]
> > +        # If argparse receives --help or an unknown argument, it will raise a
> > +        # SystemExit which will get caught by the test runner. Parse the
> > +        # arguments here too to handle that case.
> > +        parse_args(path)
> 
> Parsing the args twice, in setUp and main, is somewhat ugly. What about only
> parsing them in main, and then set a global variable if debug mode should be
> enabled? Then it's enough to check that variable in the setUp function.

This is what I requested in the v1 too, with the CLI parsing all moved
into the util.py file too.

This would keep the QemuBaseTest class cleanly separated from command
line argument handling.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


