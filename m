Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEE0CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 22:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyHJD-0003hQ-Qn; Mon, 15 Sep 2025 18:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHI6-0002wO-GP
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:03:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHI1-0000E9-Rm
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:03:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-244580523a0so48238595ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757973764; x=1758578564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vQJQq0pQj6MwjSMqvJhPFjqAfiJFF8blzNmzuEGPk0A=;
 b=iBwbwTmzeJPFnkdYChtglJqvL/XDrvfp3atDwXl2lD/RGvGQTXCcx7IQT9L7nWLr+6
 4G7O2c95qSDdEwujz7+AKa22zFLbEj2d8zryZDAYSVFuG30XgXKR2ov973huP0/LwJhY
 AXYNnwESwZ0S9qP3eaySmMSlouKTlx3gcRcbXRd8Izq6RXrjOVUn3S8yfbgwTlZsj2S1
 /K5zZU11OeS8KxQnn6PbY6WOp2gGQToWcoB0DuJGxUakUTI3RZc1UWPtHe1G1wT+xjhA
 x72RbHnDH4+Yvwq4Xb9DGCo77z2UGVPnBOdvgqGfBKb1fNp7GHz+SvbXCic0bcGoVVXF
 0nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757973764; x=1758578564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vQJQq0pQj6MwjSMqvJhPFjqAfiJFF8blzNmzuEGPk0A=;
 b=qaTZjcmTMXGzb22sBaRKxZDxH8L+UMb0DzJCckRjpQSyZ4i5vlEc0AHzdIsRbmUE2C
 XD3A9RvkBGVBw7buTb8uNnyZ1XrNUIGndS6nzSOz0XqOaM5V6m+yBuqgoOtTm45Kh/dZ
 m/ulQ6RjtOjdabPHUsk84w/EVm+ZerEgR2vCBBkSKOFoMMpvsfDfG8SAg7INx9XOdbAl
 AG2ilzSZ+hPhEGJZtPvgYDxHOSKIRAwgQJJnC1OOFp6fJihNc1Rnd809IB+qkdSpMyqE
 OfHEqk2zLJ1P56eX72CtR7cGr0bI2SJLZ3EnyfVznpv2XWW9o/QlypuFX9MdIlbD8n/s
 J3sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4oZ8sdsboX/bfifZ3jRW3IzsZk1zoEX+vQfNmi1TUhGw3v1Dav6tt7hNr9FqgbNEqyDXTglArwlzy@nongnu.org
X-Gm-Message-State: AOJu0YxbOUeUJ+7f9TAP2jeAb8s3sjTMHIpe9vWVvdir3pZXXPoszHua
 oHPWuE9JXje0ALr3WXcmvTOpUTWueKq5tQZSVoHII1AGqABllhwiBNfQpdbS37z8hPM=
X-Gm-Gg: ASbGnctzbaLN9bb9XhItnJLM7fEWQj1kG7wm88bEqd4iwlry+aSUrDpW7rMrUj6+2OG
 Cs3PPuiS/f1akN3XZlhkWUMFv7tO8sY2XOm3YsYGXIGqXOlYSI/7je0MiZ8iErV1mMD5VluNB4Y
 MW1+zMwq+yFBuDQiPN9I9o4IRl3yAaAUvR5eFmc6zO2m5F4g2928ZG84LwR8lTJaIPLuJ07bbP4
 NEu32wBwccNo/lVAyza/CIZqToWSywLntj0Xs1IgcK5p1DN3zJH/PEp3vWTIOxaB1z7okPOLE9X
 NWWUJJDVKLnw/P761El34g6r77+09l6AyZJF2EFCaP0ctVBshg/pyJr2mHS+8a4s6+56UOx2B1c
 paA/wnJP0QD3WkEVdQw2p04jgwssdpjJRHq4yusZQ34MC63nbgvMFXw8xAON3t8G7GvY2zwXE5Y
 1Q9Uw=
X-Google-Smtp-Source: AGHT+IE7Kzk0TCyDSnRVYwMlE5WnTAubNovZV2hp8DscyRoQ0tS9lD5HZW3t51z3zWQIztmt4wNsUA==
X-Received: by 2002:a17:902:c407:b0:24c:784c:4a90 with SMTP id
 d9443c01a7336-25d24cac4e3mr194754945ad.1.1757973763658; 
 Mon, 15 Sep 2025 15:02:43 -0700 (PDT)
Received: from [192.168.0.102] (200-162-224-93.static-corp.ajato.com.br.
 [200.162.224.93]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-267b2246d32sm16907535ad.143.2025.09.15.15.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 15:02:43 -0700 (PDT)
Message-ID: <d18194a3-202c-4495-a133-ae1bd0b8cca2@linaro.org>
Date: Mon, 15 Sep 2025 19:02:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250915124207.42053-1-thuth@redhat.com>
 <20250915124207.42053-3-thuth@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250915124207.42053-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
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

Hi Thomas,

On 9/15/25 09:42, Thomas Huth wrote:
> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> This commit removes Avocado as a dependency for running the
> reverse_debugging test.
> 
> The main benefit, beyond eliminating an extra dependency, is that there
> is no longer any need to handle GDB packets manually. This removes the
> need for ad-hoc functions dealing with endianness and arch-specific
> register numbers, making the test easier to read. The timeout variable
> is also removed, since Meson now manages timeouts automatically.
> 
> The reverse_debugging test is now executed through running GDB via a
> python script. The test itself is only responsible for invoking
> GDB with the appropriate arguments and for passing the test script to
> GDB.
> 
> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
> won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
> before running 'make check-functional' or 'meson test [...]'.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> [thuth: Rework the test to run without tests/guest-debug/run-test.py]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .../functional/aarch64/test_reverse_debug.py  |  16 +-
>   tests/functional/ppc64/test_reverse_debug.py  |  18 +-
>   tests/functional/reverse_debugging.py         | 235 +++++++++++-------
>   tests/functional/x86_64/test_reverse_debug.py |  20 +-
>   4 files changed, 171 insertions(+), 118 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
> index 85e35645db0..a84ddd07acb 100755
> --- a/tests/functional/aarch64/test_reverse_debug.py
> +++ b/tests/functional/aarch64/test_reverse_debug.py
> @@ -2,7 +2,7 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   #
> -# Reverse debugging test
> +# Reverse debugging test for aarch64
>   #
>   # Copyright (c) 2020 ISP RAS
>   #
> @@ -12,14 +12,13 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> -from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
> -from reverse_debugging import ReverseDebugging
> +from qemu_test import QemuSystemTest
> +from qemu_test import Asset, skipFlakyTest
>   
> +from reverse_debugging import reverse_debug
>   
> -@skipIfMissingImports('avocado.utils')
> -class ReverseDebugging_AArch64(ReverseDebugging):
>   
> -    REG_PC = 32
> +class ReverseDebugging_AArch64(QemuSystemTest):
>   
>       ASSET_KERNEL = Asset(
>           ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> @@ -29,9 +28,8 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>       def test_aarch64_virt(self):
>           self.set_machine('virt')
>           self.cpu = 'cortex-a53'
> -        kernel_path = self.ASSET_KERNEL.fetch()
> -        self.reverse_debugging(args=('-kernel', kernel_path))
> +        reverse_debug(self, self.ASSET_KERNEL)
>   
>   
>   if __name__ == '__main__':
> -    ReverseDebugging.main()
> +    QemuSystemTest.main()
> diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
> index 5931adef5a9..7da5ede06c8 100755
> --- a/tests/functional/ppc64/test_reverse_debug.py
> +++ b/tests/functional/ppc64/test_reverse_debug.py
> @@ -2,7 +2,7 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   #
> -# Reverse debugging test
> +# Reverse debugging test for ppc64
>   #
>   # Copyright (c) 2020 ISP RAS
>   #
> @@ -12,14 +12,12 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> -from qemu_test import skipIfMissingImports, skipFlakyTest
> -from reverse_debugging import ReverseDebugging
> +from qemu_test import QemuSystemTest, skipFlakyTest
>   
> +from reverse_debugging import reverse_debug
>   
> -@skipIfMissingImports('avocado.utils')
> -class ReverseDebugging_ppc64(ReverseDebugging):
>   
> -    REG_PC = 0x40
> +class ReverseDebugging_ppc64(QemuSystemTest):
>   
>       @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>       def test_ppc64_pseries(self):
> @@ -27,15 +25,13 @@ def test_ppc64_pseries(self):
>           # SLOF branches back to its entry point, which causes this test
>           # to take the 'hit a breakpoint again' path. That's not a problem,
>           # just slightly different than the other machines.
> -        self.endian_is_le = False
> -        self.reverse_debugging()
> +        reverse_debug(self)
>   
>       @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
>       def test_ppc64_powernv(self):
>           self.set_machine('powernv')
> -        self.endian_is_le = False
> -        self.reverse_debugging()
> +        reverse_debug(self)
>   
>   
>   if __name__ == '__main__':
> -    ReverseDebugging.main()
> +    QemuSystemTest.main()
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
> index f9a1d395f1d..c889247defa 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -1,21 +1,72 @@
> -# Reverse debugging test
> -#
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   #
> +# Reverse debugging test
> +#
>   # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>   #
>   # Author:
>   #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>   #
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
> -import os
> +
>   import logging
> +import os
> +import subprocess
> +import sys
> +
> +try:
> +    import gdb
> +    _has_gdb = True
> +except ModuleNotFoundError:
> +    _has_gdb = False

nit: maybe instead of '_has_gdb' name it '_in_gdb' (for running inside gdb),
since if we have or not GDB in the system is part of our GDB detection in
configure, QEMU_TEST_GDB, etc?



>   from qemu_test import LinuxKernelTest, get_qemu_img
>   from qemu_test.ports import Ports
>   
>   
> +def reverse_debug(test, asset_kernel=None, shift=7, args=None):
> +
> +    # Now launch gdb with our test and collect the result.
> +    gdb_cmd = os.getenv('QEMU_TEST_GDB')
> +    assert(gdb_cmd)

I think we should skip the test if no GDB is available instead of failing it?

So how about something like:

@@ -31,7 +31,8 @@ def reverse_debug(test, asset_kernel=None, shift=7, args=None):
  
      # Now launch gdb with our test and collect the result.
      gdb_cmd = os.getenv('QEMU_TEST_GDB')
-    assert(gdb_cmd)
+    if not gdb_cmd:
+        test.skipTest("Test skipped because there is no GDB available!")


> +    # Run quietly and ignore .gdbinit.
> +    gdb_cmd += " -q -n -batch"
> +    # Disable pagination.
> +    gdb_cmd += " -ex 'set pagination off'"
> +    # Disable prompts in case of crash.
> +    gdb_cmd += " -ex 'set confirm off'"
> +    # Finally the test script itself.
> +    argv = [__file__]
> +    gdb_cmd += f" -ex \"py sys.argv={argv}\""
> +    gdb_cmd += " -x %s" % __file__
> +
> +    test.log.info("GDB CMD: %s" % gdb_cmd)
> +
> +    gdb_env = dict(os.environ)
> +    gdb_pythonpath = gdb_env.get("PYTHONPATH", "").split(os.pathsep)
> +    gdb_pythonpath.append(os.path.dirname(os.path.realpath(__file__)))
> +    gdb_env["PYTHONPATH"] = os.pathsep.join(gdb_pythonpath)
> +    gdb_env["QEMU_TEST_MACHINE"] = test.machine
> +    if test.cpu:
> +        gdb_env["QEMU_TEST_CPU"] = test.cpu
> +    if asset_kernel:
> +        gdb_env["QEMU_TEST_KERNEL"] = asset_kernel.fetch()
> +    result = subprocess.run(gdb_cmd, shell=True, check=False,
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.STDOUT,
> +                            encoding='utf8',
> +                            env=gdb_env)
> +    test.log.info("gdb output:\n %s" % result.stdout)
> +    if result.returncode != 0:
> +        test.fail(f"gdb failed with return code {result.returncode}")
> +    else:
> +        test.log.info("gdb run succeeded!")
> +
> +
>   class ReverseDebugging(LinuxKernelTest):
>       """
>       Test GDB reverse debugging commands: reverse step and reverse continue.
> @@ -28,13 +79,9 @@ class ReverseDebugging(LinuxKernelTest):
>       that the execution is stopped at the last of them.
>       """
>   
> -    timeout = 10
>       STEPS = 10
> -    endian_is_le = True
>   
>       def run_vm(self, record, shift, args, replay_path, image_path, port):
> -        from avocado.utils import datadrainer
> -
>           logger = logging.getLogger('replay')
>           vm = self.get_vm(name='record' if record else 'replay')
>           vm.set_console()
> @@ -52,59 +99,58 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
>           if args:
>               vm.add_args(*args)
>           vm.launch()
> -        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
> -                                    logger=self.log.getChild('console'),
> -                                    stop_check=(lambda : not vm.is_running()))
> -        console_drainer.start()
> +
>           return vm
>   
>       @staticmethod
> -    def get_reg_le(g, reg):
> -        res = g.cmd(b'p%x' % reg)
> -        num = 0
> -        for i in range(len(res))[-2::-2]:
> -            num = 0x100 * num + int(res[i:i + 2], 16)
> -        return num
> +    def gdb_connect(host, port):
> +        # Set debug on connection to get the qSupport string.
> +        gdb.execute("set debug remote 1")
> +        r = gdb.execute(f"target remote {host}:{port}", False, True)
> +        gdb.execute("set debug remote 0")
> +
> +        return r
>   
>       @staticmethod
> -    def get_reg_be(g, reg):
> -        res = g.cmd(b'p%x' % reg)
> -        return int(res, 16)
> -
> -    def get_reg(self, g, reg):
> -        # value may be encoded in BE or LE order
> -        if self.endian_is_le:
> -            return self.get_reg_le(g, reg)
> -        else:
> -            return self.get_reg_be(g, reg)
> +    def get_pc():
> +        val = gdb.parse_and_eval("$pc")
> +        pc = int(val)
>   
> -    def get_pc(self, g):
> -        return self.get_reg(g, self.REG_PC)
> +        return pc
>   
> -    def check_pc(self, g, addr):
> -        pc = self.get_pc(g)
> +    def check_pc(self, addr):
> +        logger = logging.getLogger('reply')
> +        pc = self.get_pc()
>           if pc != addr:
> -            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
> +            logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
> +            gdb.execute("exit 1")
>   
>       @staticmethod
> -    def gdb_step(g):
> -        g.cmd(b's', b'T05thread:01;')
> +    def gdb_step():
> +        gdb.execute("stepi")
>   
>       @staticmethod
> -    def gdb_bstep(g):
> -        g.cmd(b'bs', b'T05thread:01;')
> +    def gdb_bstep():
> +        gdb.execute("reverse-stepi")
>   
>       @staticmethod
>       def vm_get_icount(vm):
>           return vm.qmp('query-replay')['return']['icount']
>   
> -    def reverse_debugging(self, shift=7, args=None):
> -        from avocado.utils import gdb
> -        from avocado.utils import process
> +    def test_reverse_debugging(self):
> +
> +        shift = 7
> +
> +        self.set_machine(os.getenv('QEMU_TEST_MACHINE'))
> +        self.cpu = os.getenv('QEMU_TEST_CPU')
> +        kernel_path = os.getenv('QEMU_TEST_KERNEL')
> +        args = None
> +        if kernel_path:
> +            args = ['-kernel', kernel_path]
>   
>           logger = logging.getLogger('replay')
>   
> -        # create qcow2 for snapshots
> +        # Create qcow2 for snapshots
>           logger.info('creating qcow2 image for VM snapshots')
>           image_path = os.path.join(self.workdir, 'disk.qcow2')
>           qemu_img = get_qemu_img(self)
> @@ -112,11 +158,11 @@ def reverse_debugging(self, shift=7, args=None):
>               self.skipTest('Could not find "qemu-img", which is required to '
>                             'create the temporary qcow2 image')
>           cmd = '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
> -        process.run(cmd)
> +        subprocess.run(cmd, shell=True)
>   
>           replay_path = os.path.join(self.workdir, 'replay.bin')
>   
> -        # record the log
> +        # Record the log.
>           vm = self.run_vm(True, shift, args, replay_path, image_path, -1)
>           while self.vm_get_icount(vm) <= self.STEPS:
>               pass
> @@ -125,72 +171,91 @@ def reverse_debugging(self, shift=7, args=None):
>   
>           logger.info("recorded log with %s+ steps" % last_icount)
>   
> -        # replay and run debug commands
> +        # Replay and run debug commands.
>           with Ports() as ports:
>               port = ports.find_free_port()
>               vm = self.run_vm(False, shift, args, replay_path, image_path, port)
> -        logger.info('connecting to gdbstub')
> -        g = gdb.GDBRemote('127.0.0.1', port, False, False)
> -        g.connect()
> -        r = g.cmd(b'qSupported')
> -        if b'qXfer:features:read+' in r:
> -            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
> -        if b'ReverseStep+' not in r:
> +        logger.info('Connecting to gdbstub')
> +        r = self.gdb_connect('127.0.0.1', port)
> +        if 'ReverseStep+' not in r:
>               self.fail('Reverse step is not supported by QEMU')
> -        if b'ReverseContinue+' not in r:
> +        if 'ReverseContinue+' not in r:
>               self.fail('Reverse continue is not supported by QEMU')
>   
> -        logger.info('stepping forward')
> +        logger.info('Stepping forward')
>           steps = []
> -        # record first instruction addresses
> +        # Record first instruction addresses.
>           for _ in range(self.STEPS):
> -            pc = self.get_pc(g)
> -            logger.info('saving position %x' % pc)
> +            pc = self.get_pc()
> +            logger.info('Saving position %x' % pc)
>               steps.append(pc)
> -            self.gdb_step(g)
> +            self.gdb_step()
>   
> -        # visit the recorded instruction in reverse order
> -        logger.info('stepping backward')
> +        # Visit the recorded instruction in reverse order.
> +        logger.info('Stepping backward')
>           for addr in steps[::-1]:
> -            self.gdb_bstep(g)
> -            self.check_pc(g, addr)
> -            logger.info('found position %x' % addr)
> +            self.gdb_bstep()
> +            self.check_pc(addr)
> +            logger.info('Found position %x' % addr)
>   
> -        # visit the recorded instruction in forward order
> -        logger.info('stepping forward')
> +        # Visit the recorded instruction in forward order.
> +        logger.info('Stepping forward')
>           for addr in steps:
> -            self.check_pc(g, addr)
> -            self.gdb_step(g)
> -            logger.info('found position %x' % addr)
> +            self.check_pc(addr)
> +            self.gdb_step()
> +            logger.info('Found position %x' % addr)
>   
> -        # set breakpoints for the instructions just stepped over
> -        logger.info('setting breakpoints')
> +        # Set breakpoints for the instructions just stepped over.
> +        logger.info('Setting breakpoints')
>           for addr in steps:
>               # hardware breakpoint at addr with len=1
> -            g.cmd(b'Z1,%x,1' % addr, b'OK')
> +            gdb.execute(f"break *{hex(addr)}")
>   
> -        # this may hit a breakpoint if first instructions are executed
> -        # again
> -        logger.info('continuing execution')
> +        # This may hit a breakpoint if first instructions are executed again.
> +        logger.info('Continuing execution')
>           vm.qmp('replay-break', icount=last_icount - 1)
> -        # continue - will return after pausing
> +        # continue - will return after pausing.
>           # This could stop at the end and get a T02 return, or by
>           # re-executing one of the breakpoints and get a T05 return.
> -        g.cmd(b'c')
> +        gdb.execute("continue")
>           if self.vm_get_icount(vm) == last_icount - 1:
> -            logger.info('reached the end (icount %s)' % (last_icount - 1))
> +            logger.info('Reached the end (icount %s)' % (last_icount - 1))
>           else:
> -            logger.info('hit a breakpoint again at %x (icount %s)' %
> -                        (self.get_pc(g), self.vm_get_icount(vm)))
> +            logger.info('Hit a breakpoint again at %x (icount %s)' %
> +                        (self.get_pc(), self.vm_get_icount(vm)))
>   
> -        logger.info('running reverse continue to reach %x' % steps[-1])
> -        # reverse continue - will return after stopping at the breakpoint
> -        g.cmd(b'bc', b'T05thread:01;')
> +        logger.info('Running reverse continue to reach %x' % steps[-1])
> +        # reverse continue - will return after stopping at the breakpoint.
> +        gdb.execute("reverse-continue")
>   
> -        # assume that none of the first instructions is executed again
> -        # breaking the order of the breakpoints
> -        self.check_pc(g, steps[-1])
> -        logger.info('successfully reached %x' % steps[-1])
> +        # Assume that none of the first instructions is executed again
> +        # breaking the order of the breakpoints.
> +        # steps[-1] is the first saved $pc in reverse order.
> +        self.check_pc(steps[-1])
> +        logger.info('Successfully reached %x' % steps[-1])
>   
> -        logger.info('exiting gdb and qemu')
> +        logger.info('Exiting GDB and QEMU...')
> +        # Disconnect from the VM.
> +        gdb.execute("disconnect")
> +        # Guarantee VM is shutdown.
>           vm.shutdown()
> +        # Gently exit from GDB.
> +        gdb.execute('print "test succeeded"')
> +        gdb.execute("exit 0")
> +
> +    @staticmethod
> +    def main():
> +        try:
> +            LinuxKernelTest.main()
> +        except SystemExit:
> +            # If the test is marked with @skipFlakyTest, then it will be exited
> +            # via sys.exit() before we have the chance to exit from GDB gently.
> +            # Because recent versions of GDB will return a failure value if this
> +            # happens, we catch the SystemExit and exit from GDB gently with 77,
> +            # which meson interprets correctly as a skipped test.
> +            gdb.execute("exit 77")

Now that we're not passing the exitcode directly to Meson we can remove this overriden
main() method completely.



> +if __name__ == '__main__':
> +    if not _has_gdb:
> +        sys.exit("This script must be launched via tests/guest-debug/run-test.py!")

Since we don't rely on any run-test.py code anymore, how about:

  if __name__ == '__main__':
      if not _has_gdb:
-        sys.exit("This script must be launched via tests/guest-debug/run-test.py!")
+        sys.exit("This script must be run with GDB using the -x option.")


Cheers,
Gustavo

> +    ReverseDebugging.main()
> diff --git a/tests/functional/x86_64/test_reverse_debug.py b/tests/functional/x86_64/test_reverse_debug.py
> index d713e91e144..e823f0d4953 100755
> --- a/tests/functional/x86_64/test_reverse_debug.py
> +++ b/tests/functional/x86_64/test_reverse_debug.py
> @@ -2,7 +2,7 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   #
> -# Reverse debugging test
> +# Reverse debugging test for x86_64
>   #
>   # Copyright (c) 2020 ISP RAS
>   #
> @@ -12,25 +12,19 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> -from qemu_test import skipIfMissingImports, skipFlakyTest
> -from reverse_debugging import ReverseDebugging
> +from qemu_test import QemuSystemTest, skipFlakyTest
>   
> +from reverse_debugging import reverse_debug
>   
> -@skipIfMissingImports('avocado.utils')
> -class ReverseDebugging_X86_64(ReverseDebugging):
>   
> -    REG_PC = 0x10
> -    REG_CS = 0x12
> -    def get_pc(self, g):
> -        return self.get_reg_le(g, self.REG_PC) \
> -            + self.get_reg_le(g, self.REG_CS) * 0x10
> +class ReverseDebugging_X86_64(QemuSystemTest):
>   
>       @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
>       def test_x86_64_pc(self):
>           self.set_machine('pc')
> -        # start with BIOS only
> -        self.reverse_debugging()
> +        # Start with BIOS only
> +        reverse_debug(self)
>   
>   
>   if __name__ == '__main__':
> -    ReverseDebugging.main()
> +    QemuSystemTest.main()


