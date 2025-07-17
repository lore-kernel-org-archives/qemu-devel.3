Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA098C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGd-0005Ng-Ds; Thu, 17 Jul 2025 05:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucKoh-0000g1-AL
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ucKoe-0000H6-Ai
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752744127;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eat4MdqqdcoNNOo0pq0DG+ZGQriJt93P7gO9aay+hPs=;
 b=hWmo+vKs+o8hXXqTOJm9IYMCWwvslNckDjFvq2c7hcY+BYwv+gncUa78ejnkjobRWatYQ7
 8g+J7A3uRUFnYXhwiqJfoQd/EERPYVVHDqXrJ3cacV6h7TLCcqX1RJ7BzoDGzvLbZhGnMd
 qYbXEPMgcPq849wCVVv/k56VLxs46r8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-yiRuCQvJPbi3ZhqyzLQCDg-1; Thu,
 17 Jul 2025 05:22:04 -0400
X-MC-Unique: yiRuCQvJPbi3ZhqyzLQCDg-1
X-Mimecast-MFC-AGG-ID: yiRuCQvJPbi3ZhqyzLQCDg_1752744123
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD3C7180029D; Thu, 17 Jul 2025 09:22:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.171])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC10818003FC; Thu, 17 Jul 2025 09:21:57 +0000 (UTC)
Date: Thu, 17 Jul 2025 10:21:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
Message-ID: <aHjAsibYCOu0YuU3@redhat.com>
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jul 16, 2025 at 09:08:00AM +0300, Manos Pitsidianakis wrote:
> Add argument parsing to functional tests to improve developer experience
> when running individual tests. All logs are printed to stdout
> interspersed with TAP output.
> 
>   ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>   usage: test_aarch64_virt [-h] [-d]
> 
>   QEMU Functional test
> 
>   options:
>     -h, --help   show this help message and exit
>     -d, --debug  Also print test and console logs on stdout. This will
>                  make the TAP output invalid and is meant for debugging
>                  only.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  docs/devel/testing/functional.rst      |  2 ++
>  tests/functional/qemu_test/testcase.py | 51 ++++++++++++++++++++++++++++++++--
>  2 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb0296f578cfaa4bd66d 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -63,6 +63,8 @@ directory should be your build folder. For example::
>    $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
>    $ pyvenv/bin/python3 ../tests/functional/test_file.py
>  
> +By default, functional tests redirect informational logs and console output to
> +log files. Specify the ``--debug`` flag to also print those to standard output.
>  The test framework will automatically purge any scratch files created during
>  the tests. If needing to debug a failed test, it is possible to keep these
>  files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..fad7a946c6677e9ef5c42b8f77187ba836c11aeb 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -11,6 +11,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> +import argparse
>  import logging
>  import os
>  from pathlib import Path
> @@ -31,6 +32,20 @@
>  from .uncompress import uncompress
>  
>  
> +def parse_args(test_name: str) -> argparse.Namespace:
> +    parser = argparse.ArgumentParser(
> +        prog=test_name, description="QEMU Functional test"
> +    )
> +    parser.add_argument(
> +        "-d",
> +        "--debug",
> +        action="store_true",
> +        help="Also print test and console logs on stdout. This will make the"
> +        " TAP output invalid and is meant for debugging only.",
> +    )
> +    return parser.parse_args()
> +
> +
>  class QemuBaseTest(unittest.TestCase):
>  
>      '''
> @@ -196,6 +211,9 @@ def assets_available(self):
>          return True
>  
>      def setUp(self):
> +        path = os.path.basename(sys.argv[0])[:-3]
> +        args = parse_args(path)

IMHO this is not code that belongs in setUp. Indeed, I don't think
it belongs in this file at all, better have a helper for parsing
args in 'utils', and expose a global 'debug_enabled' flag from utils
that we can reference elsewhere.

> +        self.debug_output = args.debug
>          self.qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
>          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
>          self.arch = self.qemu_bin.split('-')[-1]
> @@ -221,6 +239,16 @@ def setUp(self):
>          self.machinelog.setLevel(logging.DEBUG)
>          self.machinelog.addHandler(self._log_fh)
>  
> +        if self.debug_output:
> +            handler = logging.StreamHandler(sys.stdout)
> +            handler.setLevel(logging.DEBUG)
> +            formatter = logging.Formatter(
> +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> +            )
> +            handler.setFormatter(formatter)
> +            self.log.addHandler(handler)
> +            self.machinelog.addHandler(handler)

There was already a lot of effectively duplicated code between
this and the console_log stuff below. This new addition makes
that duplication even more substantial, such that I think it
all needs to be spun out into a helper method.

> +
>          if not self.assets_available():
>              self.skipTest('One or more assets is not available')
>  
> @@ -230,11 +258,16 @@ def tearDown(self):
>          if self.socketdir is not None:
>              shutil.rmtree(self.socketdir.name)
>              self.socketdir = None
> -        self.machinelog.removeHandler(self._log_fh)
> -        self.log.removeHandler(self._log_fh)
> +        for handler in [self._log_fh, logging.StreamHandler(sys.stdout)]:

We should have stashed the original handler when created,
rather than re-creating StreamHandler at time of removal.
I'm kinda of surprised it even works to re-create it.

> +            self.machinelog.removeHandler(handler)
> +            self.log.removeHandler(handler)
>  
>      def main():
>          path = os.path.basename(sys.argv[0])[:-3]
> +        # If argparse receives --help or an unknown argument, it will raise a
> +        # SystemExit which will get caught by the test runner. Parse the
> +        # arguments here too to handle that case.
> +        _ = parse_args(path)
>  
>          cache = os.environ.get("QEMU_TEST_PRECACHE", None)
>          if cache is not None:
> @@ -292,6 +325,14 @@ def setUp(self):
>          fileFormatter = logging.Formatter('%(asctime)s: %(message)s')
>          self._console_log_fh.setFormatter(fileFormatter)
>          console_log.addHandler(self._console_log_fh)
> +        if self.debug_output:
> +            handler = logging.StreamHandler(sys.stdout)
> +            handler.setLevel(logging.DEBUG)
> +            formatter = logging.Formatter(
> +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> +            )
> +            handler.setFormatter(formatter)
> +            console_log.addHandler(handler)
>  
>      def set_machine(self, machinename):
>          # TODO: We should use QMP to get the list of available machines
> @@ -398,5 +439,9 @@ def set_vm_arg(self, arg, value):
>      def tearDown(self):
>          for vm in self._vms.values():
>              vm.shutdown()
> -        logging.getLogger('console').removeHandler(self._console_log_fh)
> +        for handler in [
> +            self._console_log_fh,
> +            logging.StreamHandler(sys.stdout),
> +        ]:
> +            logging.getLogger("console").removeHandler(handler)
>          super().tearDown()
> 
> ---
> base-commit: c079d3a31e45093286c65f8ca5350beb3a4404a9
> change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375
> 
> --
> γαῖα πυρί μιχθήτω
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


