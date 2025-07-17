Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EBDC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLCS-0004aD-HT; Thu, 17 Jul 2025 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucKtu-0004kP-Nx
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:27:41 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucKts-000188-CU
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:27:38 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-60768f080d8so1362779a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752744454; x=1753349254; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJyVsKo6V40Q/oce/4z02JkREpVcdr7tpwIO/CZiuWE=;
 b=bVqVG9xgKEQH3Ho0TdoREGdN49ePzcHwziF9oLTlN5tEbbTEf44SuRCmpuGozlJ/I4
 zoJZB/gOE/GE3gJpMlHsZGQa+5K0IfCC6Aqha0wpiuPpdlnCdwmqWqSDs5pYM6jM17mZ
 mBVraYMqQSJNhiEkXqLTYFOJh5URCPYs/2WlAiogv5C6zRCGiyVMbU6ksgeMcy933pFt
 1iikwMVJUkuh8GP2tx6Vl2zB71gsZQ0SCthf5Wpok1M+49BtNlnDJG7cOt1CaM8dSVBr
 yC8xyWWuCNR4IaAas1GA2WEbPKhpuD2WqNqerZUISyp9ssEtYq8HeagG8CwkYuZtR3bo
 Em2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752744454; x=1753349254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJyVsKo6V40Q/oce/4z02JkREpVcdr7tpwIO/CZiuWE=;
 b=isQxD0jtSXi3HgxfKJlJN5Wyy6AOv4qZsXyF8VYX8wHRbjIfTnG18jwKU3YDsa40E4
 6L9ZW0ugwukSJID27N3ijLbiKGYjMynMADVOQMEK8YY25MBJPVMCugNdmrIsYyhA2erX
 bxg7FaNptcBIjnvz2WAfb3M5MHmhvidTVnIj7IfgCmTGcsv8YczYDSwHrIlhNnPn3gim
 KLhkScAx7w5ykyYVRAuK1dGW/7xaHbnUYJ4x0YK0ZEWxmimyeTRQLBscJfp6GlmTWXFE
 DYoX1KFXWuOmkoh8kBCGBvwOqv+QlNyIGYVUsGxEReYPI7UjznpGs1zAq0TMI8wb7W7x
 mj+A==
X-Gm-Message-State: AOJu0YylSu0cvNUOqJbBvduJlFaR6VuJF72pIMSvOPhntdFecPjQXdmw
 0Hl38LEZsK9P+LdM3vgayyAF/bx211sGEGqhgSZZbxc3Y45KranWAMVoXEkHmXd4OzhyUp6ldNX
 BFPsyR2AO86kkISpIQDuhiFuDjdw+7BPnO+0kQdLI1AK8TbiNUxpZ
X-Gm-Gg: ASbGnctcNUHls3mvEaUczXScn/lkIaRJAjUKvC3JRTfFFsttWFvF2UazqN0dwwnzrKJ
 ARb2a6Owf82k4tzFnFngEF1SIp3pjH7MBWSQ5G5iafuDT34/XRcgceEDZ1OyJySjtE3YO8nK1CA
 vn3Ds/0uMgfNK7ZOcde3mwhstz4UMmK85J/hPwe5cf3agP0NyMben1yQVmH6Bn633+JBcdwY+rR
 X+1MFR2c5irwpxk
X-Google-Smtp-Source: AGHT+IFl62n0riT96YqsNZJXjpnOH8esI3lFPw167FfDcJ6VxXcFd3e9L1A92a+OhN4AqBlY1MUJnqPdZPy3PNpU/ZI=
X-Received: by 2002:a05:6402:40c6:b0:607:f431:33fb with SMTP id
 4fb4d7f45d1cf-6128590a18cmr5610549a12.3.1752744454433; Thu, 17 Jul 2025
 02:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <aHjAsibYCOu0YuU3@redhat.com>
In-Reply-To: <aHjAsibYCOu0YuU3@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 17 Jul 2025 12:27:08 +0300
X-Gm-Features: Ac12FXzUPKpRYkYp9TSUb2wVgHXQp357b0aPR7ybMTJ8j1zcsZT2KuNMkcj7SIs
Message-ID: <CAAjaMXY-fMJ9MFjOURct-zxPi8nCVraoxjgy+A960zHD-iFu1A@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 17, 2025 at 12:22=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Wed, Jul 16, 2025 at 09:08:00AM +0300, Manos Pitsidianakis wrote:
> > Add argument parsing to functional tests to improve developer experienc=
e
> > when running individual tests. All logs are printed to stdout
> > interspersed with TAP output.
> >
> >   ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
> >   usage: test_aarch64_virt [-h] [-d]
> >
> >   QEMU Functional test
> >
> >   options:
> >     -h, --help   show this help message and exit
> >     -d, --debug  Also print test and console logs on stdout. This will
> >                  make the TAP output invalid and is meant for debugging
> >                  only.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  docs/devel/testing/functional.rst      |  2 ++
> >  tests/functional/qemu_test/testcase.py | 51 ++++++++++++++++++++++++++=
++++++--
> >  2 files changed, 50 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/fun=
ctional.rst
> > index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb0=
296f578cfaa4bd66d 100644
> > --- a/docs/devel/testing/functional.rst
> > +++ b/docs/devel/testing/functional.rst
> > @@ -63,6 +63,8 @@ directory should be your build folder. For example::
> >    $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64
> >    $ pyvenv/bin/python3 ../tests/functional/test_file.py
> >
> > +By default, functional tests redirect informational logs and console o=
utput to
> > +log files. Specify the ``--debug`` flag to also print those to standar=
d output.
> >  The test framework will automatically purge any scratch files created =
during
> >  the tests. If needing to debug a failed test, it is possible to keep t=
hese
> >  files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=3D1``` as an=
 env
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/=
qemu_test/testcase.py
> > index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..fad7a946c6677e9ef5c42b8=
f77187ba836c11aeb 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -11,6 +11,7 @@
> >  # This work is licensed under the terms of the GNU GPL, version 2 or
> >  # later.  See the COPYING file in the top-level directory.
> >
> > +import argparse
> >  import logging
> >  import os
> >  from pathlib import Path
> > @@ -31,6 +32,20 @@
> >  from .uncompress import uncompress
> >
> >
> > +def parse_args(test_name: str) -> argparse.Namespace:
> > +    parser =3D argparse.ArgumentParser(
> > +        prog=3Dtest_name, description=3D"QEMU Functional test"
> > +    )
> > +    parser.add_argument(
> > +        "-d",
> > +        "--debug",
> > +        action=3D"store_true",
> > +        help=3D"Also print test and console logs on stdout. This will =
make the"
> > +        " TAP output invalid and is meant for debugging only.",
> > +    )
> > +    return parser.parse_args()
> > +
> > +
> >  class QemuBaseTest(unittest.TestCase):
> >
> >      '''
> > @@ -196,6 +211,9 @@ def assets_available(self):
> >          return True
> >
> >      def setUp(self):
> > +        path =3D os.path.basename(sys.argv[0])[:-3]
> > +        args =3D parse_args(path)
>
> IMHO this is not code that belongs in setUp. Indeed, I don't think
> it belongs in this file at all, better have a helper for parsing
> args in 'utils', and expose a global 'debug_enabled' flag from utils
> that we can reference elsewhere.

setUp is where the logs are setup, do you mean logs should be split
into another function/file altogether? Maybe out of scope for this
patch, I can another one that does it before adding the --debug
option. What do you think?

>
> > +        self.debug_output =3D args.debug
> >          self.qemu_bin =3D os.getenv('QEMU_TEST_QEMU_BINARY')
> >          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY mus=
t be set')
> >          self.arch =3D self.qemu_bin.split('-')[-1]
> > @@ -221,6 +239,16 @@ def setUp(self):
> >          self.machinelog.setLevel(logging.DEBUG)
> >          self.machinelog.addHandler(self._log_fh)
> >
> > +        if self.debug_output:
> > +            handler =3D logging.StreamHandler(sys.stdout)
> > +            handler.setLevel(logging.DEBUG)
> > +            formatter =3D logging.Formatter(
> > +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> > +            )
> > +            handler.setFormatter(formatter)
> > +            self.log.addHandler(handler)
> > +            self.machinelog.addHandler(handler)
>
> There was already a lot of effectively duplicated code between
> this and the console_log stuff below. This new addition makes
> that duplication even more substantial, such that I think it
> all needs to be spun out into a helper method.

Ditto

>
> > +
> >          if not self.assets_available():
> >              self.skipTest('One or more assets is not available')
> >
> > @@ -230,11 +258,16 @@ def tearDown(self):
> >          if self.socketdir is not None:
> >              shutil.rmtree(self.socketdir.name)
> >              self.socketdir =3D None
> > -        self.machinelog.removeHandler(self._log_fh)
> > -        self.log.removeHandler(self._log_fh)
> > +        for handler in [self._log_fh, logging.StreamHandler(sys.stdout=
)]:
>
> We should have stashed the original handler when created,
> rather than re-creating StreamHandler at time of removal.
> I'm kinda of surprised it even works to re-create it.

It's the same file descriptor, after all. I'd be surprised if it didn't wor=
k.

>
> > +            self.machinelog.removeHandler(handler)
> > +            self.log.removeHandler(handler)
> >
> >      def main():
> >          path =3D os.path.basename(sys.argv[0])[:-3]
> > +        # If argparse receives --help or an unknown argument, it will =
raise a
> > +        # SystemExit which will get caught by the test runner. Parse t=
he
> > +        # arguments here too to handle that case.
> > +        _ =3D parse_args(path)
> >
> >          cache =3D os.environ.get("QEMU_TEST_PRECACHE", None)
> >          if cache is not None:
> > @@ -292,6 +325,14 @@ def setUp(self):
> >          fileFormatter =3D logging.Formatter('%(asctime)s: %(message)s'=
)
> >          self._console_log_fh.setFormatter(fileFormatter)
> >          console_log.addHandler(self._console_log_fh)
> > +        if self.debug_output:
> > +            handler =3D logging.StreamHandler(sys.stdout)
> > +            handler.setLevel(logging.DEBUG)
> > +            formatter =3D logging.Formatter(
> > +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> > +            )
> > +            handler.setFormatter(formatter)
> > +            console_log.addHandler(handler)
> >
> >      def set_machine(self, machinename):
> >          # TODO: We should use QMP to get the list of available machine=
s
> > @@ -398,5 +439,9 @@ def set_vm_arg(self, arg, value):
> >      def tearDown(self):
> >          for vm in self._vms.values():
> >              vm.shutdown()
> > -        logging.getLogger('console').removeHandler(self._console_log_f=
h)
> > +        for handler in [
> > +            self._console_log_fh,
> > +            logging.StreamHandler(sys.stdout),
> > +        ]:
> > +            logging.getLogger("console").removeHandler(handler)
> >          super().tearDown()
> >
> > ---
> > base-commit: c079d3a31e45093286c65f8ca5350beb3a4404a9
> > change-id: 20250716-functional_tests_debug_arg-aa0a5f6b9375
> >
> > --
> > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

