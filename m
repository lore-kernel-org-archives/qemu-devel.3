Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74731CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hOj-0005AS-RN; Fri, 03 Oct 2025 11:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4hOc-00058H-Ib
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:08:35 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4hOQ-0007Ae-8P
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:08:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-27c369f898fso26249685ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759504079; x=1760108879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eWBg2ODG9x+/94FMD/75zNuQZs/FbpeaYZE9Dp0qoQg=;
 b=p5shGTnwfWbr55sol/fD+GijUYYyxMfP56826F6nMnx6LObh+HP+Nv4eB1rPd31uFM
 /nzG+m5eEj+9NxK5NHf1v2aogOISBSuuMJSwxLqnGiwDfrQgFZM9xkiGCV9eIZUceZYE
 aPJXGf4/MPVIij030nkJHe2/HbJYo5dfGFRjkUExYMrXOLdERXdcnKnYRj6aoHiedgF5
 YXrFyt1IOen8UEaw8+9jdo8EiQJEWROHzn6vsx+9mlQrjjgaCjZBfhXgRvGhn35BD8sX
 1oH65QymwxEFovfZG5S/Ck7FANIoRHRtnjr6ZEHVxYAg3qGvqtVy/xNmIOhiEUFHiOxp
 Xljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759504079; x=1760108879;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eWBg2ODG9x+/94FMD/75zNuQZs/FbpeaYZE9Dp0qoQg=;
 b=ljii/RdIs44ptLyqijIphwu1HqclYiAW6BpjYTPBVo8DRGaJAJLf2pbPGoJ7k4m5s3
 hGTzKnnTB4T0I4EN/pHlvgLhyk63aElJVILMVDnvJqwDEsB2Dszp6VsCBBbOII8eYJ5A
 7dpmkC1Gb6r7ThGqLePGWSUJorNJba3inkcqODXoBES4sZc+fMtoZFsuWQc5d2Rrvl7J
 Td0wBz+py72XYcZ2FAOoRuVJcE3Lp/fBTCaog8iOrYQ3GQ2OyEAkXjmm7I4hXEoiDHM1
 lBBPV5V2ckX8FTu+UanDPszXumzvyZN/C5O948v35YDR8iXHZaUwTTUG7CKcoYhOGpzR
 2lWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHv9L3+sAKZaQRQNUvsH4tHVHBYrF7PrapwTn60+wYX98r7VkslwF40ifGc7gFYVcTFJceZGtNmNLt@nongnu.org
X-Gm-Message-State: AOJu0YzIVADLnxGIduE4Oo1XYvxSRXYHhG1RHH4mNrY2SwdLpU7fKDAa
 n58Hsb+WLwqDRCRVpOkg6V3qRdGwY1viIll/a9JxEX9Zx4Xq6qrFmj6rg/0oW21IuKM=
X-Gm-Gg: ASbGncuvoJvQNa4KouRSkdEiUqThk+BFdIN2bmnfLwRKqOVboBELYK62Autvt806iNR
 MCrfvQ0ZUg0t1gITqgGb3zKtWfkyy/t+8yFdgPnSMU//IPy0pUI+bHmuf4y1rlepVnvzqeFz+pR
 6IUYxXZbTkLYjdSCLBebu80wZEV4agQwPKU5lJc2CWUwnescQY6G2t7QJpA7kfLGR62rhjqH0CB
 /HxF3JcBYJ2SPzU4FV8cvYpo2A6ZRI2/wWzsOeftMM0gb0Nxn3FiySLeUbEOPlskEuCv3n5hdH+
 CG1eIMg6yiDEvs+r92W3ULLnANbFgUAe5o8ULe015XRmMBkAz1aYksvzoks8IuiE+7wH/p5hFWZ
 /SPVCSSdOrVy/zADsbkLhS/aDkJbnx/YztCEvsCx5G0PaxDWm6zBlspc5vCq0WWc=
X-Google-Smtp-Source: AGHT+IFNyTfGG7IHUi4BPoU6QyVvhHne0EjSovSclqW1LZPl/ylR7MTNLZGpR27e14Wwl6pCJs7quw==
X-Received: by 2002:a17:903:32c9:b0:28c:834f:d855 with SMTP id
 d9443c01a7336-28e9a5ba9c9mr44733855ad.27.1759504078683; 
 Fri, 03 Oct 2025 08:07:58 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.59.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1f368esm53369365ad.129.2025.10.03.08.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 08:07:58 -0700 (PDT)
Message-ID: <30fec60e-b0e8-408c-b577-e4875d8bb133@linaro.org>
Date: Fri, 3 Oct 2025 12:07:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
From: Gustavo Romero <gustavo.romero@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <b5cb30d8-65a2-4bf7-b66f-5bfe61e19835@redhat.com>
 <8fb3351e-f1a1-4a1e-9650-33f0d4ee6d44@redhat.com>
 <bb7801f1-67d3-47d7-b5bd-39b1113ea9e0@linaro.org>
 <8d89f02e-9e5b-4cdd-9a54-d55bea8967bc@linaro.org>
Content-Language: en-US
In-Reply-To: <8d89f02e-9e5b-4cdd-9a54-d55bea8967bc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Thomas,

On 10/3/25 11:38, Gustavo Romero wrote:
> Hi Thomas,
> 
> On 10/3/25 10:30, Gustavo Romero wrote:
>> Hi Thomas,
>>
>> On 10/2/25 14:52, Thomas Huth wrote:
>>> On 02/10/2025 18.53, Thomas Huth wrote:
>>>> On 02/10/2025 04.04, Gustavo Romero wrote:
>>>>> The goal of this series is to remove Avocado as a dependency for running
>>>>> the reverse_debugging functional test.
>>>>>
>>>>> After several rounds of discussions about v1 and v2, and experiments
>>>>> done by Daniel and Thomas (thanks for all the experiments and comments
>>>>> so far), I've taken a new approach and moved away from using a runner
>>>>> for GDB. The changes, I believe, are much simpler now.
>>>>
>>>>   Hi Gustavo,
>>>>
>>>> unfortunately, this still seems to be broken on Fedora. After applying your series, I get:
>>>>
>>>> stderr:
>>>> Traceback (most recent call last):
>>>>    File "/home/thuth/devel/qemu/tests/functional/reverse_debugging.py", line 100, in reverse_debugging
>>>>      self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
>>>>      ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "/usr/lib64/python3.13/unittest/case.py", line 156, in skip_wrapper
>>>>      raise SkipTest(reason)
>>>> unittest.case.SkipTest: Missing env var(s): QEMU_TEST_GDB
>>>
>>> Looks like it's required to explicitly use the --gdb=... parameter of configure to make it work, and it does not work without that paramter? Could you please have a look whether it works without --gdb with the auto-detected gdb for you?
>>
>> Yes, it works without passing --gdb on Ubuntu. I'm checking it on Fedora.
>>
>> But at least have you got the test skipped properly (displayed on Meson as skipped) since QEMU_TEST_GDB is missing?
> 
> hmm actually, no it's not skipped correctly. The @skipIfMissingEnv() annotation is in the wrong method.
> 
> I've just sent a v6 with:
> 
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
> index f06996089a..2a2e51b912 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -63,6 +63,7 @@ def vm_get_icount(vm):
>           return vm.qmp('query-replay')['return']['icount']
> 
>       @skipIfMissingImports("pygdbmi") # Required by GDB class
> +    @skipIfMissingEnv("QEMU_TEST_GDB")
>       def reverse_debugging(self, gdb_arch, shift=7, args=None):
>           from qemu_test import GDB
> 
> @@ -108,7 +109,6 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None):
>               # skipTest(), etc.
>               raise
> 
> -    @skipIfMissingEnv("QEMU_TEST_GDB")
>       def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
>           logger = logging.getLogger('replay')
> 
> 
> Now, I have not idea why GDB is not detected in Fedora. I'm setting up a Fedora env. to try it.

I've just tried it on Fedora 42 and GDB is correctly detected:

$ ../configure --target-list=aarch64-softmmu --disable-docs
$ make -j check-functional-aarch64
   VENVPIP install -e /home/gromero/git/qemu/python/
/home/gromero/git/qemu/build/pyvenv/bin/python3 -B /home/gromero/git/qemu/python/scripts/mkvenv.py ensuregroup  --online /home/gromero/git/qemu/pythondeps.toml testdeps
mkvenv: checking for qemu
mkvenv: checking for pygdbmi>=0.11.0.0
mkvenv: installing qemu, pygdbmi==0.11.0.0
make[1]: Entering directory '/home/gromero/git/qemu/build'
[1/6] Generating qemu-version.h with a custom command (wrapped by meson to capture output)
[2/6] Compiling C object libqmp.a.p/monitor_qmp-cmds-control.c.o
[3/6] Compiling C object libsystem.a.p/system_vl.c.o
[4/6] Compiling C object qemu-img.p/qemu-img.c.o
[5/6] Linking target qemu-img
[6/6] Linking target qemu-system-aarch64
/home/gromero/git/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 1 --setup thorough   --print-errorlogs  --suite func-aarch64  --suite func-aarch64-thorough
  1/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-rme_sbsaref                SKIP              0.22s   0 subtests passed
  2/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-rme_virt                   SKIP              0.25s   0 subtests passed
  3/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-virt_gpu                   SKIP              0.22s   0 subtests passed
  4/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-tuxrun                     SKIP              0.22s   0 subtests passed
  5/29 qemu:func-quick+func-aarch64 / func-aarch64-info_usernet                                    SKIP              0.29s   0 subtests passed
  6/29 qemu:func-quick+func-aarch64 / func-aarch64-empty_cpu_model                                 OK                0.32s   1 subtests passed
  7/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-smmu                       SKIP              0.38s   0 subtests passed
  8/29 qemu:func-quick+func-aarch64 / func-aarch64-version                                         OK                0.35s   1 subtests passed
  9/29 qemu:func-quick+func-aarch64 / func-aarch64-vmstate                                         OK                0.42s   1 subtests passed
10/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-multiprocess               SKIP              0.27s   0 subtests passed
11/29 qemu:func-quick+func-aarch64 / func-aarch64-vnc                                             OK                0.53s   3 subtests passed
12/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-replay                     SKIP              0.26s   0 subtests passed
13/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-raspi3                     OK                2.91s   1 subtests passed
14/29 qemu:func-quick+func-aarch64 / func-aarch64-migration                                       OK                3.60s   3 subtests passed
15/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-hotplug_pci                OK               12.90s   1 subtests passed
16/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-xlnx_versal                OK               27.11s   1 subtests passed
17/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-raspi4                     OK               35.83s   2 subtests passed
18/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-sbsaref                    OK               36.41s   1 subtests passed
19/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-reverse_debug              OK               36.98s   1 subtests passed   <===
20/29 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-device_passthrough         OK               41.88s   1 subtests passed
[...]


also:


gromero@gromero13:~/git/qemu/build$ ./pyvenv/bin/meson test --no-rebuild -t 1 --setup thorough  --suite func-thorough  func-aarch64-reverse_debug
1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-reverse_debug        OK              16.68s   1 subtests passed

Ok:                 1
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            0

Full log written to /home/gromero/git/qemu/build/meson-logs/testlog-thorough.txt
gromero@gromero13:~/git/qemu/build$

I have installed:


gromero@gromero13:~/git/qemu/build$ dnf info gdb
Updating and loading repositories:
Repositories loaded.
Installed packages
Name            : gdb
Epoch           : 0
Version         : 16.3
Release         : 1.fc42
Architecture    : x86_64
Installed size  : 455.3 KiB
Source          : gdb-16.3-1.fc42.src.rpm
 From repository : updates
Summary         : A GNU source-level debugger for C, C++, Fortran, Go and other languages
URL             : https://gnu.org/software/gdb/
License         : GPL-3.0-or-later AND BSD-3-Clause AND FSFAP AND LGPL-2.1-or-later AND GPL-2.0-or-later AND LGPL-2.0-or-later AND LicenseRef-Fedora-Public-Domain AND GFDL-1.3-or-later AND LGPL-2.0-or-later WITH
                 :  GCC-exception-2.0 AND GPL-3.0-or-later WITH GCC-exception-3.1 AND GPL-2.0-or-later WITH GNU-compiler-exception AND MIT
Description     : GDB, the GNU debugger, allows you to debug programs written in C, C++,
                 : Fortran, Go, and other languages, by executing them in a controlled
                 : fashion and printing their data.
                 :
                 : If you want to use GDB for development purposes, you should install
                 : the 'gdb' package which will install 'gdb-headless' and possibly other
                 : useful packages too.
Vendor          : Fedora Project
gromero@gromero13:~/git/qemu/build$


I'm wondering if the skipIfMissingEnv bug (fixed in v6) have acted as a red herring and
in fact no GDB was installed in your environment the first time you tried it without passing --gdb?


Cheers,
Gustavo

> Are you sure GDB is installed in your test env?
> 
> Do mind checking if:
> 
> gromero@gromero0:/mnt/git/qemu_$ gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
> gromero@gromero0:/mnt/git/qemu_$ echo $gdb_bin
> /usr/bin/gdb
> 
> works in your env and if QEMU_TEST_GDB is in:
> 
> $ ./pyvenv/bin/meson test  --verbose --no-rebuild -t 1 --setup thorough  --suite func-thorough  func-aarch64-reverse_debug
> 
> output?
> 
> 
> Cheers,
> Gustavo
> 
> 


