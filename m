Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cmu22TwM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nmJIuMZS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6PT-0004nQ-O2; Wed, 28 Oct 2026 12:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM6PS-0004km-3y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM6PQ-0006V8-1r
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793204510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8aUFxGaeqo2gfbgxKvuAtRPkQkTo2QMdWXVmIL17e0=;
 b=cmu22TwM/yBRKFW7NoHXy1qDy8qq2wQFdKB2iy3r5sHjji3BfnS+0B57LNezLJxHirF8R3
 EoE6n/d7iC2b8FTQ0HrxlLSd6YZ6OrWryEm/qdIJpfKwY4BCoaHqHJKB7IYhTTe0l2L78c
 ofC6h1gGWPcwiUzKiPS8PBXN+3a2xms=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-fheCASK2OXOczVlwnldirQ-1; Wed, 28 Oct 2026 12:21:43 -0400
X-MC-Unique: fheCASK2OXOczVlwnldirQ-1
X-Mimecast-MFC-AGG-ID: fheCASK2OXOczVlwnldirQ_1793204502
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e0ef019a4so937927f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793204502; x=1793809302; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t8aUFxGaeqo2gfbgxKvuAtRPkQkTo2QMdWXVmIL17e0=;
 b=nmJIuMZS9uvewxVViN3ONpyF/ejyXjKsIcmDZLczg9Fo6qmHx7nYUsTi4m4k8JlbYd
 lKfsAKz8AE4Si664UCNztJLnaVJAyuebAcz0xmUwuv2eXyGFdyd6BgvUkT/IkslKwUDW
 /EZkpmpXi6RjZDgjFfDZG2v63gXEiSFO0oT8q7qjGI7uj9aK94dEfSE25KYDC9Axe+uB
 rWYY0agHNXQQ/ZzHSInzujPuhImQh7odOCk64JSwzVMrk4sfXZ32C1lr9XpawK8b7ly4
 Om4UFdE1q/Qk08LKR3RgKQcDaJgmubY5fuY28i7ETUDqLGd1d2E7/Huc3rmqIxhPI0/p
 cTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793204502; x=1793809302;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t8aUFxGaeqo2gfbgxKvuAtRPkQkTo2QMdWXVmIL17e0=;
 b=DEZl+VBj/MI4avbCugv5FEz7Or17oDAVttb6wpqZw+c3Vg3VG57OE66WFMFnJmpLf9
 xHNai3h1yCP8t/CW3x/k/aF8pt6NhRtcHZDPNwmUB7DmiNXdM4e/ksuCoaA93wRstF71
 6woHjOv/LfeQnrdD+B2+lvh+bHSwjdICbmt696q4YzD03FeB6LKTLoWJtK9vm/JMt3JY
 6zl6Jm8S0+wG2XuPmxS7wIXS7RU9YwW+5tGEiVgHOBmsZkW6//J275r/K6jTaWsoydV2
 9xbyiSAV/7xM3GXbDnwuJfHZr666u1hUDBkwy1jxOVIOoAMgiQlC1p2xM/vth2r+Mnrc
 UcUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAXk0vlmLwcZ+kMZtvHj2Lq3XNMFi2V+r5kqdkz8qaTLfetc5oJRdzCSqZyUZDsNBRA0sbIghTSape@nongnu.org
X-Gm-Message-State: AFq9FYJsqBkhTX/tUjacjR5Cw6pdcl0ZSmK5C8IoIJ05ycIiDlvRVvc2
 0GDFiPzSUuLpaAWknPYgHYWvVW+Zp9eRuEc9LqyOviOuY05ASjR1ox/i76enrVcITPkk3XNOS/i
 r/6EF/st/90XpfQ8lttYQtdbbn8ytkPNV984UZx/CSt0yix9pglzy1MP/
X-Gm-Gg: AYBFou3UV4y3B8+sMpIuxci+rd9dH4SymyLhK/2k62s0pp+IjMIjtfga2UrrE13vPps
 leUBE4Qp3Hql+RxXkkXjBV9553q3BrPL6dryXj4e4EsAVR93jAM5Jst0WGRmJFXc7T316bcN5td
 7B1Dl03dT3YFTlqt3wEAsBCkLUja8vIk/g7255JdEgi08bTURecCqdbchweiaI0RDarVLsK1pvS
 BuZcGNJuyNNshmNrVct7nKdJLpx0bTLqaRSasErAtKKkhl0lS4d+b+DR3DJCnryVTZX8P22OukY
 1xXjr+188zoGeHkBb9KjRbQuTR3x/8tul6s8joN779Xxt41rDRBPFiWo03t17Lf+ogdQk3G8KFK
 SbMdrPID6hBYsgwgLY+ckTTtidCxO6DdrRlMxC9A9
X-Received: by 2002:a05:6000:2689:b0:48e:d88:55e2 with SMTP id
 ffacd0b85a97d-48e5d30836bmr7576930f8f.42.1793204501685; 
 Wed, 28 Oct 2026 09:21:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2689:b0:48e:d88:55e2 with SMTP id
 ffacd0b85a97d-48e5d30836bmr7576838f8f.42.1793204500939; 
 Wed, 28 Oct 2026 09:21:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3a1csm29753136f8f.16.2026.10.28.09.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:21:38 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:21:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: eblake@redhat.com, armbru@redhat.com, th.huth+qemu@posteo.eu,
 philmd@oss.qualcomm.com, berrange@redhat.com, pbonzini@redhat.com,
 zhao1.liu@intel.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/3] tests/funtional: add test_virtio_status.py
Message-ID: <20261028122042-mutt-send-email-mst@kernel.org>
References: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
 <20260922213210.1429435-2-vsementsov@yandex-team.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922213210.1429435-2-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Typo in the subject

On Wed, Sep 23, 2026 at 12:32:08AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add test that run x-query-virtio-status QMP command, and its
> HMP analog.
> 
> Now QEMU crashes in these scenarios due to bugs, so the test-cases
> are skipped. You may run them by setting QEMU_FAILING_TESTS
> environment variable.
> 
> Following commits will fix bug and enable the test-cases.
> 
> Wrap QEMU run by "unshare" to access vhost-net without sudo.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  MAINTAINERS                                   |  1 +
>  tests/functional/qemu_test/testcase.py        |  9 +-
>  tests/functional/x86_64/meson.build           |  2 +
>  tests/functional/x86_64/test_virtio_status.py | 97 +++++++++++++++++++
>  4 files changed, 105 insertions(+), 4 deletions(-)
>  create mode 100755 tests/functional/x86_64/test_virtio_status.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6be9c5725b9..8bd7c8472d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2535,6 +2535,7 @@ F: include/hw/virtio/
>  F: docs/devel/virtio*
>  F: docs/devel/migration/virtio.rst
>  F: tests/functional/x86_64/test_virtio_version.py
> +F: tests/functional/x86_64/test_virtio_status.py
>  
>  virtio-balloon
>  M: Michael S. Tsirkin <mst@redhat.com>
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index bf2dc1dc101..d719b79eb1e 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -387,12 +387,13 @@ def require_device(self, devicename):
>          if helptxt.find(devicename) < 0:
>              self.skipTest('no support for device ' + devicename)
>  
> -    def _new_vm(self, name, monitor_address):
> +    def _new_vm(self, name, monitor_address, wrapper):
>          vm = QEMUMachine(self.qemu_bin,
>                           name=name,
>                           base_temp_dir=self.workdir,
>                           log_dir=self.log_file(),
> -                         monitor_address=monitor_address)
> +                         monitor_address=monitor_address,
> +                         wrapper=wrapper)
>          self.log.debug('QEMUMachine "%s" created', name)
>          self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
>  
> @@ -407,11 +408,11 @@ def _new_vm(self, name, monitor_address):
>      def vm(self):
>          return self.get_vm(name='default')
>  
> -    def get_vm(self, name=None, monitor_address=None):
> +    def get_vm(self, name=None, monitor_address=None, wrapper=()):
>          if not name:
>              name = str(uuid.uuid4())
>          if self._vms.get(name) is None:
> -            self._vms[name] = self._new_vm(name, monitor_address)
> +            self._vms[name] = self._new_vm(name, monitor_address, wrapper)
>              if self.cpu is not None:
>                  self._vms[name].add_args('-cpu', self.cpu)
>              if self.machine is not None:
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
> index 0353b2af8e1..62dedb2e203 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -7,6 +7,7 @@ test_x86_64_timeouts = {
>    'netdev_ethtool' : 180,
>    'replay' : 480,
>    'virtio_balloon': 120,
> +  'virtio_status': 120,
>  }
>  
>  tests_x86_64_system_quick = [
> @@ -50,5 +51,6 @@ tests_x86_64_system_thorough = [
>    'vhost_user_bridge',
>    'virtio_balloon',
>    'virtio_gpu',
> +  'virtio_status',
>    'rebuild_vmfd',
>  ]
> diff --git a/tests/functional/x86_64/test_virtio_status.py b/tests/functional/x86_64/test_virtio_status.py
> new file mode 100755
> index 00000000000..c8cbdf7c42e
> --- /dev/null
> +++ b/tests/functional/x86_64/test_virtio_status.py
> @@ -0,0 +1,97 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: MIT

QEMU uses GPL v2.0 or later.

> +
> +import os
> +import subprocess
> +
> +from qemu_test import (
> +    Asset,
> +    LinuxKernelTest,
> +    skipIfMissingCommands,
> +    skipIfMissingEnv,
> +)
> +
> +
> +class VirtioStatus(LinuxKernelTest):
> +    ASSET_KERNEL = Asset(
> +        "https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/"
> +        "netboot-3.24.2/vmlinuz-virt",
> +        "be8ae7782de532d1a791c97fbf9ddc955b9de78349382ad097c83ffe9db857f4")
> +    ASSET_INITRD = Asset(
> +        "https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/"
> +        "netboot-3.24.2/initramfs-virt",
> +        "385418a99b17c0ef44947d88ea448d43b2df4a2c3343da72e724c6cf3b05e9f7")
> +
> +    VIRTIO_PATH = "/machine/peripheral/net0/virtio-backend"
> +
> +    def setUp(self):
> +        super().setUp()
> +        self.qemu_wrapper = []
> +        self.require_accelerator("kvm")
> +        self.require_device("virtio-net-pci")
> +        self.set_machine("q35")
> +
> +    def has_hmp(self, vm):
> +        commands = vm.cmd('query-commands')
> +        return any(cmd['name'] == 'human-monitor-command' for cmd in commands)
> +
> +    def check_commands(self, vm):
> +        if self.has_hmp(vm):
> +            vm.cmd(
> +                "human-monitor-command",
> +                command_line="info virtio-status " + self.VIRTIO_PATH,
> +            )
> +        vm.cmd("x-query-virtio-status", path=self.VIRTIO_PATH)
> +
> +    @skipIfMissingCommands("unshare")
> +    @skipIfMissingEnv("QEMU_FAILING_TESTS")
> +    def test_vhost(self):
> +        self.require_netdev("tap")
> +        for device in ("/dev/net/tun", "/dev/vhost-net"):
> +            if not os.access(device, os.R_OK | os.W_OK):
> +                self.skipTest(f"Read/write access to {device} is required")
> +
> +        wrapper = ["unshare", "-Urn", "--"]
> +        probe = subprocess.run(wrapper + ["true"],
> +                               capture_output=True,
> +                               text=True, check=False)
> +        if probe.returncode:
> +            self.skipTest("User/network namespaces unavailable: " +
> +                          probe.stderr.strip())
> +
> +        vm = self.get_vm("wrapped", wrapper=wrapper)
> +
> +        kernel = self.ASSET_KERNEL.fetch()
> +        initrd = self.ASSET_INITRD.fetch()
> +
> +        vm.set_console()
> +        vm.add_args("-accel", "kvm")
> +        vm.add_args("-kernel", kernel,
> +                    "-initrd", initrd,
> +                    "-append", "console=ttyS0 modules=virtio_net",
> +                    "-netdev",
> +                    "tap,id=net,script=,downscript=,vhost=on",
> +                    "-device",
> +                    "virtio-net-pci,id=net0,netdev=net,romfile=")
> +        vm.launch()
> +
> +        # modules=virtio_net ensures the driver is loaded by this point
> +        self.wait_for_console_pattern("Loading boot drivers: ok.", vm=vm)
> +        vm.cmd(
> +            "x-query-virtio-vhost-queue-status", path=self.VIRTIO_PATH, queue=0
> +        )
> +
> +        self.check_commands(vm)
> +
> +    @skipIfMissingEnv("QEMU_FAILING_TESTS")
> +    def test_no_vhost(self):
> +        self.vm.add_args("-accel", "kvm",
> +                         "-S", "-net", "none", "-device",
> +                         "virtio-net-pci,id=net0,romfile=")
> +        self.vm.launch()
> +        self.check_commands(self.vm)
> +
> +
> +if __name__ == "__main__":
> +    LinuxKernelTest.main()
> -- 
> 2.43.0


