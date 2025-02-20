Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192B5C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBSz-0007aX-2l; Thu, 20 Feb 2025 13:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlBSw-0007aH-4W
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:40:06 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlBSt-0005U9-6e
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:40:05 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fb7d64908fso11229777b3.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740076801; x=1740681601; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=b5N2OpWYwpnsJULljG+ijrcPzMdnZYDX2tHQ1SWBozo=;
 b=Qrx1/YeKLfoO12e+3UGuSPhNTXRtwp6w27ZyVDnx1JXl2NyV5JAZRVGPnX5WXtf2Uv
 0r8qFjzfW4eCRQgXO1V+M/TfQXr2wcFNT6lG/siz9jv4vSkZgQrynV2OeVsGjWFu4iIN
 tC2otOukd4VqjWqUP0b+DLcquFtNZWkJhSuey+ezGzD4eCllVVVTumbqIk/I4hBrImEO
 1QwlVzBuIA892nkrW8Apf3Tuizpruv6emyjQ4Pd7r8WatPLS8P/dFG6mxcZXGzp+LYS8
 qhsX6filyxEaBOGUJgjjLawtSzfVqW4Z3YzuJGIPb3T/FPrqiF56DHZeshDT/pCqMvrA
 bF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740076801; x=1740681601;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b5N2OpWYwpnsJULljG+ijrcPzMdnZYDX2tHQ1SWBozo=;
 b=meSfIF4Ej6IKVVmwr7CqSAodysoHUG6ejAOP4HZqWDZ/Fq6/UMlLYwD6M4QeKqDJfL
 0RfUtP7KXmZEXVgUdDV77vKTcNi6eUpj3t9fIbi75YIVicLuGSTerVYbJXIhoiNqXpAz
 vyNDuhj0w/ngFwgsIYG5z4vx9UxTNOJNlYNiN1htjRDLxig4by9JWeejdpBW6EyoK7yP
 CmNYmW+sEmNZzS3Rh/pI6XLjVsxsAytFoG8m+WvLeO40lqZwd3wpI4jDSvQ+apLnetsB
 tADt0bF/ocH+lV1FWb9t9RtsPTgj7pQT8ucskv/IkS5F6r3Z3K4R+V0T+Nk5b1tiyrxP
 GUcA==
X-Gm-Message-State: AOJu0YwLJjZT9qnGC3MMNCv2C8MqXuMrZZE1CVNSFaiy19aW4KfdrD+z
 NIyGFUqiH2gVrdlUvi23VdVwds/qQYr2LUMwMvO+BPFov73lQ0r5MidaMwMHPMij8vI+jISkFSs
 rOr68wIJrTjpblj3OleKwgw6hoC9L+KbZCsCMGnd27pVEmHtD
X-Gm-Gg: ASbGncveFLwJ7+6T1vuMjZAswts5ZzYx1BFx0UJIXuG/UOZUj1CzFdoHTHXv0DTaux2
 OwbKOU3stRKQJ6udRr6dNq2IBmFehWuw+ftmo6wS5m8cve7XVZdZ8Le3pWXauiMwhri/Ra8n3cQ
 ==
X-Google-Smtp-Source: AGHT+IGGxds7na9aTePEyar5whlssr/xSz+IezQR1yZ1acuLSr/XMJbl3hENHRsNUelZkv5T3tpfWawY4Hlwth5ZSm8=
X-Received: by 2002:a05:690c:c92:b0:6f9:41e3:ea4b with SMTP id
 00721157ae682-6fbcc22c1bemr1048367b3.9.1740076801524; Thu, 20 Feb 2025
 10:40:01 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 18:39:50 +0000
X-Gm-Features: AWEUYZn2gJfx1gshDnrihWl0NtgXGuC6MiU5BtU10DWPNIYFnKr1RP_VtKCgJtg
Message-ID: <CAFEAcA-u+TMgQV8G8LvQixE95BGhfN5hyYdxcZTnxu5StVBKRw@mail.gmail.com>
Subject: debugging functional tests that only fail in 'make check-functional'
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

I'm trying to debug some functional tests that fail for me
with 'make check-functional' on a debug build. Consistently
(well, same set of tests in two runs) when I run
'make -j8 check-functional' these fail:

 7/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_sx1
                        ERROR           173.31s   exit status 1
10/44 qemu:func-thorough+func-aarch64-thorough+thorough /
func-aarch64-aarch64_virt            TIMEOUT         720.04s   killed
by signal 15 SIGTERM
11/44 qemu:func-thorough+func-arm-thorough+thorough /
func-arm-arm_aspeed_ast2600              TIMEOUT         720.07s
killed by signal 15 SIGTERM
12/44 qemu:func-thorough+func-aarch64-thorough+thorough /
func-aarch64-aarch64_sbsaref_alpine  TIMEOUT         720.07s   killed
by signal 15 SIGTERM
40/44 qemu:func-thorough+func-arm-thorough+thorough /
func-arm-arm_aspeed_ast2500              TIMEOUT         480.01s
killed by signal 15 SIGTERM

The aarch64-virt one is gpu issue, so I know about that one.
The others pass OK on a clang no-debug sanitizer build.

If I try to run just the sx1 tests "by hand":

$ (cd build/x86 && PYTHONPATH=../../python:../../tests/functional
QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./pyvenv/bin/python3
../../tests/functional/test_arm_sx1.py)
TAP version 13
ok 1 test_arm_sx1.SX1Test.test_arm_sx1_flash
ok 2 test_arm_sx1.SX1Test.test_arm_sx1_initrd
ok 3 test_arm_sx1.SX1Test.test_arm_sx1_sd
1..3

they pass; but inside the test framework that third sd test
errors: testlog-thorough.txt says:

===begin===
----------------------------------- stdout -----------------------------------
TAP version 13
ok 1 test_arm_sx1.SX1Test.test_arm_sx1_flash
ok 2 test_arm_sx1.SX1Test.test_arm_sx1_initrd
not ok 3 test_arm_sx1.SX1Test.test_arm_sx1_sd
1..3
----------------------------------- stderr -----------------------------------
Traceback (most recent call last):
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python/qemu/machine/machine.py",
line 611, in _do_shutdown
    self._soft_shutdown(timeout)
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python/qemu/machine/machine.py",
line 596, in _soft_shutdown
    self._subp.wait(timeout=timeout)
  File "/usr/lib/python3.12/subprocess.py", line 1264, in wait
    return self._wait(timeout=timeout)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.12/subprocess.py", line 2045, in _wait
    raise TimeoutExpired(self.args, timeout)
subprocess.TimeoutExpired: Command
'('/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/qemu-system-arm',
'-display', 'none', '-vga', 'none', '-chardev', 'socket,id=mon,fd=5',
'-mon', 'chardev=mon,mode=control', '-machine', 'sx1', '-chardev',
'socket,id=console,fd=10', '-serial', 'chardev:console', '-append',
'kunit.enable=0 root=/dev/mmcblk0 rootwait console=ttyS0,115200
earlycon=uart8250,mmio32,0xfffb0000,115200n8', '-no-reboot',
'-snapshot', '-drive',
'format=raw,if=sd,file=/home/petmay01/.cache/qemu/download/c1db7f43ef92469ebc8605013728c8950e7608439f01d13678994f0ce101c3a8',
'-kernel', '/home/petmay01/.cache/qemu/download/a0271899a8dc2165f9e0adb2d0a57fc839ae3a469722ffc56c77e108a8887615')'
timed out after 60 seconds

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_arm_sx1.py",
line 58, in test_arm_sx1_sd
    self.vm.wait(timeout=60)
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python/qemu/machine/machine.py",
line 666, in wait
    self.shutdown(timeout=timeout)
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python/qemu/machine/machine.py",
line 648, in shutdown
    self._do_shutdown(timeout)
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python/qemu/machine/machine.py",
line 618, in _do_shutdown
    raise AbnormalShutdown("Could not perform graceful shutdown") \
qemu.machine.machine.AbnormalShutdown: Could not perform graceful shutdown

More information on test_arm_sx1.SX1Test.test_arm_sx1_sd could be found here:
 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/tests/functional/arm/test_arm_sx1.SX1Test.test_arm_sx1_sd/base.log
 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/tests/functional/arm/test_arm_sx1.SX1Test.test_arm_sx1_sd/console.log

(test program exited with status code 1)
===endit===

which I interpret to mean "we waited the 60 seconds the test says,
but the test didn't exit within that time".

Any suggestions for how to debug?

(Also the console.log is empty regardless of whether the
test passes or fails; this doesn't seem right.)

thanks
-- PMM

