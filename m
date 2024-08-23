Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A57AC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 07:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shOj1-0007ZP-8A; Fri, 23 Aug 2024 03:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shOiz-0007WU-P3
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 03:28:45 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shOiw-0006wa-Oh
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 03:28:45 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8692bbec79so216735266b.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724398120; x=1725002920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qMepRNlbuz78tpQIMpc/NUskqbfYCNeOpL4CdkOujx4=;
 b=RFywgthJYTNuWPtjeK0wJaqLLKiZLPg7gxRmjZNhruUwY19gLshocNWyxQmFQWR8Cv
 PEydekfqg+dVrZWSEZfDV+ZvTQ5iXu/yAObYxqF8a9O0+3TshzQXOvK4Tyj9WnClKIBq
 IizJ0xbYy875ZLfLH4mx38FpjekvfyGsCMIIBHXWLqnLf2wi2J7xQr2mZkNajGGEHRDO
 37B80PUivpHNQP30WdcWYRSi1v+kyrHTnCduyxmEpEtYWgpbL1bnb+6n6YTC8Z1kiQ6y
 ZPdLebOQcmYw1kNf9hkHPO7F3YySx0EvB2svJmt/INlmA/QhOqKfXQWt3qpS1ze7xWjX
 eZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724398120; x=1725002920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qMepRNlbuz78tpQIMpc/NUskqbfYCNeOpL4CdkOujx4=;
 b=TU0gV7yLQvCef/ctIH/iwhKrLhPSzfUmMX1dgj6foEQrNiX9UU7jajGMZV4Xo22s7z
 Unr9L20nMLAaMFxX3uFBxa5Ox7Ac7wJcBZGsuiKwjkbEY75c1B288dvXfVHKCUD9xKgk
 lJ3KF+gvJYN4574EcO+URcw0H+fYwo1SgkHr0CpV5Pn12/YP0NwfzfXd7rbA+QTQe7++
 bv0kursgeFaCvCYWe8KLFhG0b8YjusE57B9nVJ87xmp5hSP58m1UrwZWyDR+Gl7O1XG1
 2wEUqoh9wIJjh+1ClCDmmdegM5aIW9PakVzCknLgCv8j7sAxTx9PLdlHBI0ZNL26K8iq
 cJCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW2Mn7zpbJxxxN9D1oLunTvhppBokWql742kfmXtFSXKtFLIEdbNeaTYOWmf8SNfDLO5BlgNw8/UTO@nongnu.org
X-Gm-Message-State: AOJu0YwEQRQDySl+4fbGhxuz6vYvYLkcMEkl+FW++FuWZcu3CL/4MBGo
 Egr9Y90ksJAHtfdp1aI2FCtGOT9xNriKYOcWo833W0IOGve7B6fID5FT2nQODd8=
X-Google-Smtp-Source: AGHT+IEf/UdFpwV4ukntnUK4N7dkyJlp8tXnMu2sgb0W+pEEOhxpfjrsukehAog7fOfxwM0dR/L2cw==
X-Received: by 2002:a17:907:e688:b0:a86:99e9:ffa5 with SMTP id
 a640c23a62f3a-a86a52c4565mr89442566b.34.1724398119978; 
 Fri, 23 Aug 2024 00:28:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f437930sm220133066b.107.2024.08.23.00.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 00:28:39 -0700 (PDT)
Message-ID: <3a435391-f485-4223-93aa-b937a141db16@linaro.org>
Date: Fri, 23 Aug 2024 09:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/35] tests/functional: enable pre-emptive caching of
 assets
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-16-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-16-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

On 21/8/24 10:27, Thomas Huth wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Many tests need to access assets stored on remote sites. We don't want
> to download these during test execution when run by meson, since this
> risks hitting test timeouts when data transfers are slow.
> 
> Add support for pre-emptive caching of assets by setting the env var
> QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
> instead of running the test, the assets will be downloaded and saved
> to the cache, then the timestamp file created.
> 
> A meson custom target is created as a dependency of each test suite
> to trigger the pre-emptive caching logic before the test runs.
> 
> When run in caching mode, it will locate assets by looking for class
> level variables with a name prefix "ASSET_", and type "Asset".
> 
> At the ninja level
> 
>     ninja test --suite functional
> 
> will speculatively download any assets that are not already cached,
> so it is advisable to set a timeout multiplier.
> 
>     QEMU_TEST_NO_DOWNLOAD=1 ninja test --suite functional
> 
> will fail the test if a required asset is not already cached
> 
>     ninja precache-functional
> 
> will download and cache all assets required by the functional
> tests
> 
> At the make level, precaching is always done by
> 
>     make check-functional
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Tested-by: Richard Henderson <richard.henderson@linaro.org>
> [thuth: Remove the duplicated "path = os.path.basename(...)" line]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include                 |  3 ++-
>   tests/functional/meson.build           | 33 +++++++++++++++++++++++--
>   tests/functional/qemu_test/asset.py    | 34 ++++++++++++++++++++++++++
>   tests/functional/qemu_test/testcase.py |  7 ++++++
>   4 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 66c8cc3123..010369bd3a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -161,7 +161,8 @@ $(FUNCTIONAL_TARGETS):
>   
>   .PHONY: check-functional
>   check-functional:
> -	@$(MAKE) SPEED=thorough check-func check-func-quick
> +	@$(NINJA) precache-functional
> +	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
>   
>   # Consolidated targets
>   
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 8a8fa0ab99..cef74b82a9 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -33,6 +33,7 @@ tests_x86_64_quick = [
>   tests_x86_64_thorough = [
>   ]
>   
> +precache_all = []
>   foreach speed : ['quick', 'thorough']
>     foreach dir : target_dirs
>       if not dir.endswith('-softmmu')
> @@ -63,11 +64,35 @@ foreach speed : ['quick', 'thorough']
>                                  meson.current_source_dir())
>   
>       foreach test : target_tests
> -      test('func-@0@/@1@'.format(target_base, test),
> +      testname = '@0@-@1@'.format(target_base, test)
> +      testfile = 'test_' + test + '.py'
> +      testpath = meson.current_source_dir() / testfile
> +      teststamp = testname + '.tstamp'
> +      test_precache_env = environment()
> +      test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
> +      test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
> +                                          meson.current_source_dir())
> +      precache = custom_target('func-precache-' + testname,
> +                               output: teststamp,
> +                               command: [python, testpath],
> +                               depend_files: files(testpath),
> +                               build_by_default: false,
> +                               env: test_precache_env)
> +      precache_all += precache
> +
> +      # Ideally we would add 'precache' to 'depends' here, such that
> +      # 'build_by_default: false' lets the pre-caching automatically
> +      # run immediately before the test runs. In practice this is
> +      # broken in meson, with it running the pre-caching in the normal
> +      # compile phase https://github.com/mesonbuild/meson/issues/2518
> +      # If the above bug ever gets fixed, when QEMU changes the min
> +      # meson version, add the 'depends' and remove the custom
> +      # 'run_target' logic below & in Makefile.include
> +      test('func-' + testname,
>              python,
>              depends: [test_deps, test_emulator, emulator_modules],
>              env: test_env,
> -           args: [meson.current_source_dir() / 'test_' + test + '.py'],
> +           args: [testpath],
>              protocol: 'tap',
>              timeout: test_timeouts.get(test, 60),
>              priority: test_timeouts.get(test, 60),
> @@ -75,3 +100,7 @@ foreach speed : ['quick', 'thorough']
>       endforeach
>     endforeach
>   endforeach
> +
> +run_target('precache-functional',
> +           depends: precache_all,
> +           command: ['true'])
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index cbeb6278af..9250ff2b06 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -9,6 +9,8 @@
>   import logging
>   import os
>   import subprocess
> +import sys
> +import unittest
>   import urllib.request
>   from pathlib import Path
>   from shutil import copyfileobj
> @@ -62,6 +64,9 @@ def fetch(self):
>                              self.cache_file, self.url)
>               return str(self.cache_file)
>   
> +        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> +            raise Exception("Asset cache is invalid and downloads disabled")
> +
>           self.log.info("Downloading %s to %s...", self.url, self.cache_file)
>           tmp_cache_file = self.cache_file.with_suffix(".download")
>   
> @@ -95,3 +100,32 @@ def fetch(self):
>   
>           self.log.info("Cached %s at %s" % (self.url, self.cache_file))
>           return str(self.cache_file)
> +
> +    def precache_test(test):
> +        log = logging.getLogger('qemu-test')
> +        log.setLevel(logging.DEBUG)
> +        handler = logging.StreamHandler(sys.stdout)
> +        handler.setLevel(logging.DEBUG)
> +        formatter = logging.Formatter(
> +            '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
> +        handler.setFormatter(formatter)
> +        log.addHandler(handler)
> +        for name, asset in vars(test.__class__).items():
> +            if name.startswith("ASSET_") and type(asset) == Asset:
> +                log.info("Attempting to cache '%s'" % asset)
> +                asset.fetch()
> +        log.removeHandler(handler)
> +
> +    def precache_suite(suite):
> +        for test in suite:
> +            if isinstance(test, unittest.TestSuite):
> +                Asset.precache_suite(test)
> +            elif isinstance(test, unittest.TestCase):
> +                Asset.precache_test(test)
> +
> +    def precache_suites(path, cacheTstamp):
> +        loader = unittest.loader.defaultTestLoader
> +        tests = loader.loadTestsFromNames([path], None)
> +
> +        with open(cacheTstamp, "w") as fh:
> +            Asset.precache_suite(tests)


When using multiple jobs (-jN) I'm observing some hangs,
apparently multiple threads trying to download the same file.
The files are eventually downloaded successfully but it takes
longer. Should we acquire some exclusive lock somewhere?

> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index b2dd863c6e..18314be9d1 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -21,6 +21,7 @@
>   from qemu.machine import QEMUMachine
>   from qemu.utils import kvm_available, tcg_available
>   
> +from .asset import Asset
>   from .cmd import run_cmd
>   from .config import BUILD_DIR
>   
> @@ -58,6 +59,12 @@ def tearDown(self):
>   
>       def main():
>           path = os.path.basename(sys.argv[0])[:-3]
> +
> +        cache = os.environ.get("QEMU_TEST_PRECACHE", None)
> +        if cache is not None:
> +            Asset.precache_suites(path, cache)
> +            return
> +
>           tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>                                      test_output_log = pycotap.LogMode.LogToError)
>           unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])


