Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F354C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezv0-00053M-2D; Fri, 16 Aug 2024 12:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sezus-0004aV-E2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:35:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sezuo-0001sE-8y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:35:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37186c2278bso1254071f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723826101; x=1724430901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h6OKRj2L7pYie89ERzTKnpJREHhIWZL1ZTfBLnJOiuI=;
 b=MAdTdQ/91Ye50NTNz30WOmIU8h2lmdyCz+c+2msDp60HWdaAA3v9SHOy59YD0h5BaQ
 VKaADd2EMJjaBskw9FUHEUrRE6AvzBghsqXJPkXBP1mLz+wOcTvOJGKonBFUKP50yhUR
 jBKVaUG+zo8/bfRcgIAArwVjtJGbvWjQbVjiScEaPq9wt25jTwVq3Du82G6pVB8nFkMS
 IULJj8mECppjfhUPmc5AXZYVcUzZIRTtj2h1n8j6x7b32YXzViUqdcke3qkGbn3Kkdx1
 m/NMR13V1vek9llRiEXyYDj+Da+SivTypfVOuYrdqPkLx3RCLkfSE8Fs5VSEEZopnPJ7
 a1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826101; x=1724430901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h6OKRj2L7pYie89ERzTKnpJREHhIWZL1ZTfBLnJOiuI=;
 b=pe6tAwZLck49lWdqXnGsxG55nMv9EeLEoUhZ9/Mwg09Vmj3E3bBIh3RymGxNKAxkvI
 EophISQ2R9KWTVpmc7iFuffiifDLPOeHTgESOXorM3II7LTeGL2OhQhUVIv0tdqM9YwJ
 Ygd2rAGHrE9DmK6DHD5U9smKBaro9hvWNtWHcDKJjtppEHziEn+0EC2RlxOgETezZGAL
 xP20fHZzLzI5do1+j8AN/StgB8dD6+m3zbZMgotw1qvAgzAjFkxXcvOQRGC5j1UyKKfC
 yPGhDEMz4I3e68MllQcPR1eZncJMqmwniAy7RGIDo6YBoFX6/aLKrfs8rEzv/NvaWpDM
 arDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0hbGa46zoGjvQ5ZYYwlaFXjDzOCpe29sjQKd+F/GqJK+hjPBjoLRruCpiJjyNzhf9OrwaYNUOyC4QiCVrfho3y4eSKGU=
X-Gm-Message-State: AOJu0YwbYHH0r5MXDh+DOaC0pBvwuCr2Z17eR5vWXcszA+gmRq+Xa9Eu
 gxbxHXCvUUKvqnPULYQfAYsxEHqbFEYs8842RDVx65IUrTXGq/eNNZX2/YEiB9E=
X-Google-Smtp-Source: AGHT+IG2M7mBRWYCKu1CByHV2ZrUok6kpq+t5SVzwM5BrEmGk9myVrMmFTolHIRNDyI7Icz6m6O0Rw==
X-Received: by 2002:a05:6000:136a:b0:367:895f:619e with SMTP id
 ffacd0b85a97d-37186c0077emr5136237f8f.11.1723826100432; 
 Fri, 16 Aug 2024 09:35:00 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189849a80sm3975723f8f.35.2024.08.16.09.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 09:34:59 -0700 (PDT)
Message-ID: <8d07931c-444e-4030-ac7c-b81ad2d3bac4@linaro.org>
Date: Fri, 16 Aug 2024 18:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/windows.yml: Disable the qtests in the MSYS2
 job
To: Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow <jsnow@redhat.com>
References: <20240816153747.319161-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240816153747.319161-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 16/8/24 17:37, Thomas Huth wrote:
> The qtests are broken since a while in the MSYS2 job in the gitlab-CI,
> likely due to some changes in the MSYS2 environment. So far nobody has
> neither a clue what's going wrong here, nor an idea how to fix this
> (in fact most QEMU developers even don't have a Windows environment
> available for properly analyzing this problem), so let's disable the
> qtests here again to get at least the test coverage for the compilation
> and unit tests back to the CI.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index a83f23a786..9f3112f010 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -23,6 +23,8 @@ msys2-64bit:
>       # for this job, because otherwise the build could not complete within
>       # the project timeout.
>       CONFIGURE_ARGS:  --target-list=sparc-softmmu --without-default-devices -Ddebug=false -Doptimization=0
> +    # The qtests are broken in the msys2 job on gitlab, so disable them:
> +    TEST_ARGS: --no-suite qtest

Then building system emulation is pointless, isn't it?

Could we at least test the block tools? qemu-img seems to work:

# ./qemu-img.exe --help
qemu-img version 9.0.92 (v9.1.0-rc2)
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
usage: qemu-img [standard options] command [command options]
QEMU disk image utility

     '-h', '--help'       display this help and exit
     '-V', '--version'    output version information and exit
...

It doesn't work currently:

Administrator@FOOBAR UCRT64 /c/Users/Administrator/qemu/build
# make check-help
Regression testing targets:
  make check                  Run block, qapi-schema, unit, softfloat, 
qtest and decodetree tests
  make bench                  Run speed tests

Individual test suites:
  make check-qtest-TARGET     Run qtest tests for given target
  make check-qtest            Run qtest tests
  make check-unit             Run qobject tests
  make check-qapi-schema      Run QAPI schema tests
  make check-block            Run block tests
  make check-avocado          Run avocado (integration) tests for 
currently configured targets

  make check-report.junit.xml Generates an aggregated XML test report
  make check-venv             Creates a Python venv for tests
  make check-clean            Clean the tests and related data

The following are useful for CI builds
  make check-build            Build most test binaries
  make get-vm-images          Downloads all images used by avocado 
tests, according to configured targets (~350 MB each, 1.5 GB max)


The variable SPEED can be set to control the gtester speed setting.
Default options are -k and (for make V=1) --verbose; they can be
changed with variable GTESTER_OPTIONS.

Administrator@FOOBAR UCRT64 /c/Users/Administrator/qemu/build
# make check-block
make: *** No rule to make target 'check-block'.  Stop.

Administrator@FOOBAR UCRT64 /c/Users/Administrator/qemu/build
#


FWIW when the test is stuck and I hit ^C I get:

Administrator@FOOBAR UCRT64 /c/Users/Administrator/qemu/build
# make check-qtest
[1/6] Generating qemu-version.h with a custom command (wrapped by meson 
to capture output)
/c/Users/Administrator/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 
1  --num-processes 1 --print-errorlogs  --suite qtest
ERROR: The process "3428" not found./ qtest-sparc/qom-test 
                     14/900.0s
  1/13 qemu:qtest+qtest-sparc / qtest-sparc/qom-test 
   INTERRUPT       14.42s   (exit status 3221225786 or signal 3221225658 
SIGinvalid)
 >>> 
PATH=C:/Users/Administrator/msys64/ucrt64/bin;C:\Users\Administrator\msys64\ucrt64\bin;C:\Users\Administrator\msys64\usr\local\bin;C:\Users\Administrator\msys64\usr\bin;C:\Users\Administrator\msys64\usr\bin;C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Users\Administrator\msys64\usr\bin\site_perl;C:\Users\Administrator\msys64\usr\bin\vendor_perl;C:\Users\Administrator\msys64\usr\bin\core_perl 
PYTHON=C:/Users/Administrator/qemu/build/pyvenv/bin/python3.exe 
QTEST_QEMU_BINARY=./qemu-system-sparc QTEST_QEMU_IMG=./qemu-img 
G_TEST_DBUS_DAEMON=C:/Users/Administrator/qemu/tests/dbus-vmstate-daemon.sh 
MALLOC_PERTURB_=164 
C:/Users/Administrator/qemu/build/tests/qtest/qom-test.exe --tap -k

ERROR: The process "860" not found.qtest-sparc/device-introspect-test 
                   4/720.0s
  2/13 qemu:qtest+qtest-sparc / qtest-sparc/cdrom-test 
   SKIP             0.07s
Traceback (most recent call last):
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/runners.py", 
line 190, in run
     return runner.run(main)
            ^^^^^^^^^^^^^^^^
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/runners.py", 
line 118, in run
     return self._loop.run_until_complete(task)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 641, in run_until_complete
     self.run_forever()
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/windows_events.py", 
line 321, in run_forever
     super().run_forever()
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 608, in run_forever
     self._run_once()
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 1898, in _run_once
     event_list = self._selector.select(timeout)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/windows_events.py", 
line 444, in select
     self._poll(timeout)
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/windows_events.py", 
line 825, in _poll
     status = _overlapped.GetQueuedCompletionStatus(self._iocp, ms)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/runners.py", 
line 157, in _on_sigint
     raise KeyboardInterrupt()
KeyboardInterrupt

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
   File "<frozen runpy>", line 198, in _run_module_as_main
   File "<frozen runpy>", line 88, in _run_code
   File 
"C:/Users/Administrator/qemu/build/pyvenv/bin/meson.exe/__main__.py", 
line 7, in <module>
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mesonmain.py", 
line 294, in main
     return run(sys.argv[1:], launcher)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mesonmain.py", 
line 285, in run
     return CommandLineParser().run(args)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mesonmain.py", 
line 194, in run
     return options.run_func(options)
            ^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py", 
line 2182, in run
     return th.doit()
            ^^^^^^^^^
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py", 
line 1821, in doit
     self.run_tests(runners)
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py", 
line 1994, in run_tests
     asyncio.run(self._run_tests(runners))
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/runners.py", 
line 189, in run
     with Runner(debug=debug) as runner:
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/runners.py", 
line 63, in __exit__
     self.close()
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/runners.py", 
line 71, in close
     _cancel_all_tasks(loop)
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/runners.py", 
line 201, in _cancel_all_tasks
     loop.run_until_complete(tasks.gather(*to_cancel, 
return_exceptions=True))
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 641, in run_until_complete
     self.run_forever()
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/windows_events.py", 
line 321, in run_forever
     super().run_forever()
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 608, in run_forever
     self._run_once()
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 1898, in _run_once
     event_list = self._selector.select(timeout)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/windows_events.py", 
line 444, in select
     self._poll(timeout)
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/windows_events.py", 
line 825, in _poll
     status = _overlapped.GetQueuedCompletionStatus(self._iocp, ms)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
KeyboardInterrupt
Exception ignored in: <coroutine object TestHarness._run_tests at 
0x000001b004a1bca0>
Traceback (most recent call last):
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py", 
line 2101, in _run_tests
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py", 
line 725, in finish
   File 
"C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py", 
line 605, in report_progress
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/locks.py", 
line 213, in wait
asyncio.exceptions.CancelledError:
Task was destroyed but it is pending!
task: <Task cancelling name='Task-1' coro=<TestHarness._run_tests() 
done, defined at 
C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py:2006> 
wait_for=<Task pending name='Task-23' 
coro=<TestHarness._run_tests.<locals>.run_test() running at 
C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py:2018> 
wait_for=<Future pending cb=[Task.task_wakeup()]> 
cb=[TestHarness._run_tests.<locals>.test_done() at 
C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py:2024, 
Task.task_wakeup()]> cb=[gather.<locals>._done_callback() at 
C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/tasks.py:764]>
Task was destroyed but it is pending!
task: <Task pending name='Task-23' 
coro=<TestHarness._run_tests.<locals>.run_test() running at 
C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py:2018> 
wait_for=<Future pending cb=[Task.task_wakeup()]> 
cb=[TestHarness._run_tests.<locals>.test_done() at 
C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py:2024, 
Task.task_wakeup()]>
Exception ignored in: <coroutine object Queue.get at 0x000001b00524bca0>
Traceback (most recent call last):
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/queues.py", 
line 160, in get
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 762, in call_soon
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 520, in _check_closed
RuntimeError: Event loop is closed
Task was destroyed but it is pending!
task: <Task pending name='Task-25' coro=<TestRunTAP.parse() done, 
defined at 
C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py:1087> 
wait_for=<Future cancelled>>
Task was destroyed but it is pending!
task: <Task pending name='Task-26' 
coro=<TestSubprocess.communicate.<locals>.collect_stdo() running at 
C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py:1303> 
wait_for=<Future pending cb=[Task.task_wakeup()]>>
Task was destroyed but it is pending!
task: <Task pending name='Task-27' 
coro=<TestSubprocess.communicate.<locals>.collect_stde() running at 
C:/Users/Administrator/qemu/build/pyvenv/lib/python3.11/site-packages/mesonbuild/mtest.py:1308> 
wait_for=<Future pending cb=[Task.task_wakeup()]>>
Exception ignored in: <function BaseSubprocessTransport.__del__ at 
0x000001b003dc62a0>
Traceback (most recent call last):
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_subprocess.py", 
line 126, in __del__
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_subprocess.py", 
line 104, in close
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/proactor_events.py", 
line 109, in close
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 762, in call_soon
   File 
"C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/base_events.py", 
line 520, in _check_closed
RuntimeError: Event loop is closed
Task was destroyed but it is pending!
task: <Task pending name='Task-28' coro=<Process.wait() running at 
C:/Users/Administrator/msys64/ucrt64/lib/python3.11/asyncio/subprocess.py:137> 
wait_for=<Future pending cb=[Task.task_wakeup()]>>
make: *** [Makefile.mtest:26: do-meson-check] Interrupt


Administrator@FOOBAR UCRT64 /c/Users/Administrator/qemu/build
#

