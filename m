Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADDECCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 02:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGpq7-0003NK-NK; Wed, 05 Nov 2025 21:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGpq4-0003N6-Ll
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 21:35:04 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGpq1-0003Su-F7
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 21:35:04 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A62YjhZ017440
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Nov 2025 11:34:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0UF09S8T5hR7aRzEZDlf6+Uzj1KQusY+JJrSFW2Pec0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762396486; v=1;
 b=fmd4o7ZTWdyAeuYE/zvbPOCS5WCAL8IBjn1UjGQBQjHayTEHXbixAbqJkOqmcDyF
 /I9ZC6rH34W9yjgn4caCbOjYaQfiVuPVMtZDfsFGpu9nOF4qswBTgxQxTAaH74oI
 RMgkXO+xZ66x5xy+xRTdQHhk2ikfbgGe/8kxmmxRmCiOHAxZoTJQRCL7mmZoOhq9
 Aad86BWh1Lq98LcFgrF6JBT9GDjnFx6oyoJQQ+R7faUhiGkP4ZNTDN4TOe0Yk6sO
 b2oLzz6kGIzZ8iLU/6tkmpS0Wz+3arVSNp4q9fIo3ZpdImIS5VbiOkAFjJB9q0Jz
 eIYGmbAxXFyiKm+ecZdycQ==
Message-ID: <7e87716a-45e6-47c0-8d74-8fc87b2e61ee@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Nov 2025 11:34:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64/test_virtio_gpu: Fix various
 issues reported by pylint
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251105120951.15815-1-thuth@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251105120951.15815-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/05 21:09, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Use the recommended order for import statements, specify the kind of
> exceptions that we try to catch, use f-strings where it makes sense,
> rewrite the vug_log_file part with a proper "with" statement and
> fix some FIXMEs by checking for the availability of the devices, etc.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/x86_64/test_virtio_gpu.py | 46 +++++++++++-----------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/functional/x86_64/test_virtio_gpu.py b/tests/functional/x86_64/test_virtio_gpu.py
> index be96de24da2..a25f15cdb00 100755
> --- a/tests/functional/x86_64/test_virtio_gpu.py
> +++ b/tests/functional/x86_64/test_virtio_gpu.py
> @@ -5,22 +5,23 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> +import os
> +import socket
> +import subprocess
>   
>   from qemu_test import QemuSystemTest, Asset
>   from qemu_test import wait_for_console_pattern
>   from qemu_test import exec_command_and_wait_for_pattern
>   from qemu_test import is_readable_executable_file
>   
> -
> -import os
> -import socket
> -import subprocess
> +from qemu.machine.machine import VMLaunchFailure
>   
>   
>   def pick_default_vug_bin(test):
>       bld_dir_path = test.build_file("contrib", "vhost-user-gpu", "vhost-user-gpu")
>       if is_readable_executable_file(bld_dir_path):
>           return bld_dir_path
> +    return None
>   
>   
>   class VirtioGPUx86(QemuSystemTest):
> @@ -46,8 +47,8 @@ def wait_for_console_pattern(self, success_message, vm=None):
>           )
>   
>       def test_virtio_vga_virgl(self):
> -        # FIXME: should check presence of virtio, virgl etc
>           self.require_accelerator('kvm')
> +        self.require_device('virtio-vga-gl')
>   
>           kernel_path = self.ASSET_KERNEL.fetch()
>           initrd_path = self.ASSET_INITRD.fetch()
> @@ -68,7 +69,7 @@ def test_virtio_vga_virgl(self):
>           )
>           try:
>               self.vm.launch()
> -        except:
> +        except VMLaunchFailure:
>               # TODO: probably fails because we are missing the VirGL features
>               self.skipTest("VirGL not enabled?")
>   
> @@ -78,8 +79,8 @@ def test_virtio_vga_virgl(self):
>           )
>   
>       def test_vhost_user_vga_virgl(self):
> -        # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
>           self.require_accelerator('kvm')
> +        self.require_device('vhost-user-vga')
>   
>           vug = pick_default_vug_bin(self)
>           if not vug:
> @@ -95,27 +96,26 @@ def test_vhost_user_vga_virgl(self):
>           os.set_inheritable(qemu_sock.fileno(), True)
>           os.set_inheritable(vug_sock.fileno(), True)
>   
> -        self._vug_log_path = self.log_file("vhost-user-gpu.log")
> -        self._vug_log_file = open(self._vug_log_path, "wb")
> -        self.log.info('Complete vhost-user-gpu.log file can be '
> -                      'found at %s', self._vug_log_path)
> -
> -        vugp = subprocess.Popen(
> -            [vug, "--virgl", "--fd=%d" % vug_sock.fileno()],
> -            stdin=subprocess.DEVNULL,
> -            stdout=self._vug_log_file,
> -            stderr=subprocess.STDOUT,
> -            shell=False,
> -            close_fds=False,
> -        )
> -        self._vug_log_file.close()
> +        vug_log_path = self.log_file("vhost-user-gpu.log")
> +        self.log.info('Complete vhost-user-gpu.log file can be found at %s',
> +                      vug_log_path)
> +        with open(vug_log_path, "wb") as vug_log_file:
> +            # pylint: disable=consider-using-with
> +            vugp = subprocess.Popen(
> +                [vug, "--virgl", f"--fd={vug_sock.fileno()}"],
> +                stdin=subprocess.DEVNULL,
> +                stdout=vug_log_file,
> +                stderr=subprocess.STDOUT,
> +                shell=False,
> +                close_fds=False,
> +            )

Let's use with for subproces.Popen() too.

You may leave vug_log_file.close() after subprocess.Popen(); if 
subprocess.Popen() raises an exception, the with statement for 
vug_log_file will close the file. Otherwise, the vug_log_file.close() 
after subprocess.Popen() will close it and the with statement for 
vug_log_file will be no-op; the documentation says it is allowed to call 
IOBase.call() twice:
https://docs.python.org/3.14/library/io.html#io.IOBase.close

>   
>           self.vm.set_console()
>           self.vm.add_args("-cpu", "host")
>           self.vm.add_args("-m", "2G")
>           self.vm.add_args("-object", "memory-backend-memfd,id=mem,size=2G")
>           self.vm.add_args("-machine", "pc,memory-backend=mem,accel=kvm")
> -        self.vm.add_args("-chardev", "socket,id=vug,fd=%d" % qemu_sock.fileno())
> +        self.vm.add_args("-chardev", f"socket,id=vug,fd={qemu_sock.fileno()}")
>           self.vm.add_args("-device", "vhost-user-vga,chardev=vug")
>           self.vm.add_args("-display", "egl-headless")
>           self.vm.add_args(
> @@ -128,7 +128,7 @@ def test_vhost_user_vga_virgl(self):
>           )
>           try:
>               self.vm.launch()
> -        except:
> +        except VMLaunchFailure:
>               # TODO: probably fails because we are missing the VirGL features
>               self.skipTest("VirGL not enabled?")
>           self.wait_for_console_pattern("as init process")


