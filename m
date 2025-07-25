Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D69C83F27
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 04:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufA37-0001VU-Hz; Fri, 25 Jul 2025 00:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufA30-0001Qq-Rw
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufA2y-0007j4-EN
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753417718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ByuGFe3Z3PCUXSP61hHrKtAQ1/wtflBHlkwbGCOk+Zk=;
 b=UYCK/2Ny7YQ5z7wd74vvlkOg/pjCWTLT+mH7RXfMYY1L8fMWIuO/yAQqi/ObTsft8nI4Lx
 WXSnck7OohR5K9iL4zpHuXaewTEcFYG0I7GUNbyWygS1yN0rWkQjm0IVkcS38+WsXoN7pf
 JN6H6QAoUkme3Fq60BzAhaYp3cPm8l0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-L1S7w_8YPoit6CJ2ypWRzw-1; Fri, 25 Jul 2025 00:28:36 -0400
X-MC-Unique: L1S7w_8YPoit6CJ2ypWRzw-1
X-Mimecast-MFC-AGG-ID: L1S7w_8YPoit6CJ2ypWRzw_1753417715
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-455f79a2a16so12646245e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 21:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753417715; x=1754022515;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ByuGFe3Z3PCUXSP61hHrKtAQ1/wtflBHlkwbGCOk+Zk=;
 b=PrTt+HEEeOjGAi9+JX0XHhMGzyLi4WE+oz2qCtltUHyRJsXw5kd8XpeJXVgpEHd2dr
 UHFxPqSDBFls93uCEy5i9J1z2eVleZcFukkPtG9iANF6cIRMHEAOhCStHQr9rC3VBD0c
 aVBt/sDAcdKy236dyrSOMC6lOinRYXzK4dc0U/1bJzq/kNQ3RE3+Al2JWJ5IvHPSfVDZ
 YbrFTzWj2L2z8bLwzfWt1VTpgGxHTV8fELTOUuYJB/hYYf5VQbRlPQ91Cn5YNfjutCk5
 WFAS+TaKH+fkPeAEb+N7c5C1OeYrAbZEoXwHIvd4Dygegdqq8tmwbtjBHP8uqfjFb6WR
 b80Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/LT7aVSYyGh8uz0lHbWK8jtNBJb+mPhvzPG4duKANNJhR3Xj2ZSUO+En4fxFi3p3b1x2O7mDbDyV0@nongnu.org
X-Gm-Message-State: AOJu0YxVcenXFA0zVAr02UD8Om8AuxdNxM/ShYKHYKYpjg3L/D6nr1FG
 3QQOhsv4HdZscQ8c9TP2R+D7s9gbKdNdNpJraKwUnDYrG8/VEP4FntexSb19nvGVS9qXzCBZq2E
 hpARgRYkhCXWN1abixqtLds22h9ffWHVJcx6H5CKcDiIyb2zve0TNcC4z
X-Gm-Gg: ASbGncu/yAj2ZOx3waEFDqGkVKUy3MXOYlJC4S+D7MRtA9EXc75rPGFNOLZQ89y8K9J
 9gp6cgMiAzup3JK8b7+xX03FT3A8mWGb+hcSKByEHPvfyFmWXZvIOzMlwD4nEapFeAD+FZM4WUv
 YZ1EdSmAun0IPJ7SKJZJtMsPIXL8XAdIB8Rp26dDUZTidfPS2JbOzS2/0wBvwNF++LCKNNXl8Gv
 aFcCGNouLwJO5+hpktQROiUi1ZJW0MW7bl/4lbBFgwBkFRsbYt+B6OB8ZAqeMoPd+Xm+kqbWXom
 7+VKvZb2+iRsdD5cSRy5TbLvgaqc7fXzm34kR85fz8DMTzl+1r7wiw0VkBvXNjUe6uVt59Rr+jt
 b3uk=
X-Received: by 2002:a05:600c:4449:b0:456:2000:2f3f with SMTP id
 5b1f17b1804b1-4587655a77emr1665015e9.23.1753417714680; 
 Thu, 24 Jul 2025 21:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn6fgUV1LlaqYgkjpUsfvGEq/otz21+evBiy92V4xVtUPkbE6EEJRUsggYXOi0UYr+6VnJIw==
X-Received: by 2002:a05:600c:4449:b0:456:2000:2f3f with SMTP id
 5b1f17b1804b1-4587655a77emr1664835e9.23.1753417714221; 
 Thu, 24 Jul 2025 21:28:34 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-089.pools.arcor-ip.net.
 [47.64.115.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054c819sm38465505e9.13.2025.07.24.21.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 21:28:33 -0700 (PDT)
Message-ID: <71e58abc-9544-47e8-85ae-d880c5dc6d8f@redhat.com>
Date: Fri, 25 Jul 2025 06:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: add --debug CLI arg
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250717-functional_tests_debug_arg-v2-1-4f0d991e16f7@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250717-functional_tests_debug_arg-v2-1-4f0d991e16f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/07/2025 12.34, Manos Pitsidianakis wrote:
> Add argument parsing to functional tests to improve developer experience
> when running individual tests. All logs are printed to stdout
> interspersed with TAP output.
> 
> Example usage, assuming current build directory with qemu source code in
> the parent directory (see docs/devel/testing/functional.rst for details):
> 
>    $ export PYTHONPATH=../python:../tests/functional
>    $ export QEMU_TEST_QEMU_BINARY="$(pwd)/qemu-system-aarch64"
>    $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>    usage: test_aarch64_virt [-h] [-d]
> 
>    QEMU Functional test
> 
>    options:
>      -h, --help   show this help message and exit
>      -d, --debug  Also print test and console logs on stdout. This will
>                   make the TAP output invalid and is meant for debugging
>                   only.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v2:
> - Store stdout handler in `self` object (thanks Daniel)
> - Deduplicate handler removal code (Daniel)
> - Amend commit description to mention PYTHONPATH (thanks Alex)
> - Link to v1: https://lore.kernel.org/qemu-devel/20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org
> ---
>   docs/devel/testing/functional.rst      |  2 ++
>   tests/functional/qemu_test/testcase.py | 48 +++++++++++++++++++++++++++++++---
>   2 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index 9e56dd1b1189216b9b4aede00174c15203f38b41..9d08abe2848277d635befb0296f578cfaa4bd66d 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -63,6 +63,8 @@ directory should be your build folder. For example::
>     $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
>     $ pyvenv/bin/python3 ../tests/functional/test_file.py
>   
> +By default, functional tests redirect informational logs and console output to
> +log files. Specify the ``--debug`` flag to also print those to standard output.
>   The test framework will automatically purge any scratch files created during
>   the tests. If needing to debug a failed test, it is possible to keep these
>   files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 2082c6fce43b0544d4e4258cd4155f555ed30cd4..3ecaaeffd4df2945fb4c44b4ddef6911527099b9 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -11,6 +11,7 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> +import argparse
>   import logging
>   import os
>   from pathlib import Path
> @@ -31,6 +32,20 @@
>   from .uncompress import uncompress
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
>   class QemuBaseTest(unittest.TestCase):
>   
>       '''
> @@ -196,6 +211,16 @@ def assets_available(self):
>           return True
>   
>       def setUp(self):
> +        path = os.path.basename(sys.argv[0])[:-3]
> +        args = parse_args(path)
> +        self.stdout_handler = None
> +        if args.debug:
> +            self.stdout_handler = logging.StreamHandler(sys.stdout)
> +            self.stdout_handler.setLevel(logging.DEBUG)
> +            formatter = logging.Formatter(
> +                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
> +            )
> +            self.stdout_handler.setFormatter(formatter)
>           self.qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
>           self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
>           self.arch = self.qemu_bin.split('-')[-1]
> @@ -215,12 +240,17 @@ def setUp(self):
>               '%(asctime)s - %(levelname)s: %(message)s')
>           self._log_fh.setFormatter(fileFormatter)
>           self.log.addHandler(self._log_fh)
> +        if self.stdout_handler:
> +            self.log.addHandler(self.stdout_handler)
>   
>           # Capture QEMUMachine logging
>           self.machinelog = logging.getLogger('qemu.machine')
>           self.machinelog.setLevel(logging.DEBUG)
>           self.machinelog.addHandler(self._log_fh)
>   
> +        if self.stdout_handler:
> +            self.machinelog.addHandler(self.stdout_handler)
> +
>           if not self.assets_available():
>               self.skipTest('One or more assets is not available')
>   
> @@ -230,11 +260,18 @@ def tearDown(self):
>           if self.socketdir is not None:
>               shutil.rmtree(self.socketdir.name)
>               self.socketdir = None
> -        self.machinelog.removeHandler(self._log_fh)
> -        self.log.removeHandler(self._log_fh)
> +        for handler in [self._log_fh, self.stdout_handler]:
> +            if handler is None:
> +                continue
> +            self.machinelog.removeHandler(handler)
> +            self.log.removeHandler(handler)
>   
>       def main():
>           path = os.path.basename(sys.argv[0])[:-3]
> +        # If argparse receives --help or an unknown argument, it will raise a
> +        # SystemExit which will get caught by the test runner. Parse the
> +        # arguments here too to handle that case.
> +        parse_args(path)

Parsing the args twice, in setUp and main, is somewhat ugly. What about only 
parsing them in main, and then set a global variable if debug mode should be 
enabled? Then it's enough to check that variable in the setUp function.

  Thomas


