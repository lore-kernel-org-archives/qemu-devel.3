Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBF6C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIRL-00072q-68; Fri, 25 Jul 2025 09:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufIR0-0006rB-3H
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufIQx-0007LO-GZ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753449956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z1i3FVYU9T3t9EoypQId4dBbYTnT4nfA30gvE8ZVzgo=;
 b=EqHg/HiykNbCXStBb8Ji/qA4JI6SjxACMk8Oh7Q0Lq/LcX4LukabIRRSjvdm8U30g7vOEm
 wGT28vxt514REMrdizabazoNv3keouLoApj727WlfpvYu6xZLV5QP44oQd7o/kTi5hnud5
 J59EUv5Ylq7JxZpfN2WbpB4aC7Eg6RQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-undCfIV4NlWgGFbXHtDKhA-1; Fri,
 25 Jul 2025 09:25:54 -0400
X-MC-Unique: undCfIV4NlWgGFbXHtDKhA-1
X-Mimecast-MFC-AGG-ID: undCfIV4NlWgGFbXHtDKhA_1753449952
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3722E1955D90; Fri, 25 Jul 2025 13:25:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED398300018D; Fri, 25 Jul 2025 13:25:49 +0000 (UTC)
Date: Fri, 25 Jul 2025 14:25:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] tests/functional: add -k TEST_NAME_PATTERN CLI arg
Message-ID: <aIOF2gPa8nbec2qp@redhat.com>
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
 <20250725-functional_tests_debug_arg-v3-4-b89921baf810@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725-functional_tests_debug_arg-v3-4-b89921baf810@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

On Fri, Jul 25, 2025 at 12:41:25PM +0300, Manos Pitsidianakis wrote:
> Add a CLI argument that takes fnmatch(3)-style patterns as value and can
> be specified many times. Only tests that match the pattern will be
> executed. This argument is passed to unittest.main which takes the same
> argument.
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  tests/functional/qemu_test/testcase.py | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index ab564f873c303bcc28c3bf7bec8c8c4569fae91c..b045d82caa79d9d161fb868b0b0748ad7de453d9 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -16,6 +16,7 @@
>  import os
>  from pathlib import Path
>  import pycotap
> +import itertools
>  import shutil
>  from subprocess import run
>  import sys
> @@ -37,6 +38,7 @@ class QemuBaseTest(unittest.TestCase):
>      debug: bool = False
>      keep_scratch: bool = "QEMU_TEST_KEEP_SCRATCH" in os.environ
>      list_tests: bool = False
> +    test_name_patterns: list[str] = []
>  
>      """
>      Class method that initializes class attributes from given command-line
> @@ -67,10 +69,19 @@ def parse_args():
>              action="store_true",
>              help="List all tests that would be executed and exit.",
>          )
> +        parser.add_argument(
> +            "-k",
> +            dest="test_name_patterns",
> +            action="append",
> +            type=str,
> +            help="Only run tests which match the given substring. "
> +            "This argument is passed to unittest.main verbatim.",
> +        )
>          args = parser.parse_args()
>          QemuBaseTest.debug = args.debug
>          QemuBaseTest.keep_scratch |= args.keep_scratch
>          QemuBaseTest.list_tests = args.list_tests
> +        QemuBaseTest.test_name_patterns = args.test_name_patterns
>          return
>  
>      '''
> @@ -313,8 +324,16 @@ def main():
>  
>          tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>                                     test_output_log = pycotap.LogMode.LogToError)
> -        res = unittest.main(module = None, testRunner = tr, exit = False,
> -                            argv=["__dummy__", path])
> +        argv = ["__dummy__", path] + (
> +            list(
> +                itertools.chain.from_iterable(
> +                    ["-k", x] for x in QemuBaseTest.test_name_patterns
> +                )
> +            )
> +            if QemuBaseTest.test_name_patterns
> +            else []
> +        )
> +        res = unittest.main(module=None, testRunner=tr, exit=False, argv=argv)

unittest.main() supports a whole bunch of CLI args beyond '-k', but none
of them are accessible as we're not forwarding the sys.argv that we have
received. eg we're missing

$ git diff
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2a78e735f1..5caf7b13fe 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -249,7 +249,7 @@ def main():
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
         res = unittest.main(module = None, testRunner = tr, exit = False,
-                            argv=["__dummy__", path])
+                            argv=[sys.argv[0], path] + sys.argv[1:])
         for (test, message) in res.result.errors + res.result.failures:
 
             if hasattr(test, "log_filename"):

which would unlock

$ QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64  PYTHONPATH=`pwd`/python ./tests/functional/test_version.py  -h
usage: test_version.py [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b] [-k TESTNAMEPATTERNS] [tests ...]

positional arguments:
  tests                a list of any number of test modules, classes and test methods.

options:
  -h, --help           show this help message and exit
  -v, --verbose        Verbose output
  -q, --quiet          Quiet output
  --locals             Show local variables in tracebacks
  --durations N        Show the N slowest test cases (N=0 for all)
  -f, --failfast       Stop on first fail or error
  -c, --catch          Catch Ctrl-C and display results so far
  -b, --buffer         Buffer stdout and stderr during tests
  -k TESTNAMEPATTERNS  Only run tests which match the given substring



One of the goals with the new functional test system was that we stop trying
to (re-)invent a custom test runner harness, as was the case with Avocado,
in favour of relying on the pre-existing python infrastructure to the
greatest extent possible.

Seeing this, and all the other CLI arg handling added in this series, makes
me fairly uncomfortable, as it is effectively inventing a custom test runner
once again which is exactly what we wanted to get away from.

At the same time, there are some pieces in this series that do things that
unittest.main() can't do on its own.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


