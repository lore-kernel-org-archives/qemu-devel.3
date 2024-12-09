Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15326E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXWV-0003kY-6V; Mon, 09 Dec 2024 01:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7enf=TC=kaod.org=clg@ozlabs.org>)
 id 1tKXWS-0003kJ-TD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:45:37 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7enf=TC=kaod.org=clg@ozlabs.org>)
 id 1tKXWQ-0004Ka-5A
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:45:36 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Y6C6V2sWHz4wcj;
 Mon,  9 Dec 2024 17:45:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y6C6Q5HK5z4wcD;
 Mon,  9 Dec 2024 17:45:18 +1100 (AEDT)
Message-ID: <8e3bcf1b-3a7a-43b1-b7dc-1bca68dd35bc@kaod.org>
Date: Mon, 9 Dec 2024 07:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] tests/functional: Convert the intel_iommu
 avocado test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>
References: <20241206181728.1241169-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241206181728.1241169-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7enf=TC=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/6/24 19:17, Thomas Huth wrote:
> Convert the intel_iommu test to the new functional framework.
> This test needs some changes since we neither support the old 'LinuxTest'
> class in the functional framework yet, nor a way to use SSH for running
> commands in the guest. So we now directly download a Fedora kernel and
> initrd and set up the serial console for executing the commands and for
> looking for the results.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS                                   |   1 +
>   tests/functional/meson.build                  |   1 +
>   .../test_intel_iommu.py}                      | 119 ++++++++----------
>   3 files changed, 51 insertions(+), 70 deletions(-)
>   rename tests/{avocado/intel_iommu.py => functional/test_intel_iommu.py} (41%)
>   mode change 100644 => 100755
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a62659b330..2ca452dbf9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3679,6 +3679,7 @@ S: Supported
>   F: hw/i386/intel_iommu.c
>   F: hw/i386/intel_iommu_internal.h
>   F: include/hw/i386/intel_iommu.h
> +F: tests/functional/test_intel_iommu.py
>   
>   AMD-Vi Emulation
>   S: Orphan
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 30c3eda7e4..dfc95fd904 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -238,6 +238,7 @@ tests_x86_64_system_quick = [
>   
>   tests_x86_64_system_thorough = [
>     'acpi_bits',
> +  'intel_iommu',
>     'x86_64_tuxrun',
>     'linux_initrd',
>     'multiprocess',
> diff --git a/tests/avocado/intel_iommu.py b/tests/functional/test_intel_iommu.py
> old mode 100644
> new mode 100755
> similarity index 41%
> rename from tests/avocado/intel_iommu.py
> rename to tests/functional/test_intel_iommu.py
> index 992583fa7d..6e47b1e9de
> --- a/tests/avocado/intel_iommu.py
> +++ b/tests/functional/test_intel_iommu.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # INTEL_IOMMU Functional tests
>   #
>   # Copyright (c) 2021 Red Hat, Inc.
> @@ -7,116 +9,93 @@
>   #
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
> -import os
>   
> -from avocado import skipUnless
> -from avocado_qemu.linuxtest import LinuxTest
> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
> +
> +class IntelIOMMU(LinuxKernelTest):
>   
> -@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -class IntelIOMMU(LinuxTest):
> -    """
> -    :avocado: tags=arch:x86_64
> -    :avocado: tags=distro:fedora
> -    :avocado: tags=distro_version:31
> -    :avocado: tags=machine:q35
> -    :avocado: tags=accel:kvm
> -    :avocado: tags=intel_iommu
> -    :avocado: tags=flaky
> -    """
> +    ASSET_KERNEL = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> +         'releases/39/Server/x86_64/os/images/pxeboot/vmlinuz'),
> +        '5f2ef0de47f8d79d5ee9bf8b0ee6d5ba4d987c2f9a16b8b511a7c69e53931fe3')
> +
> +    ASSET_INITRD = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> +         'releases/39/Server/x86_64/os/images/pxeboot/initrd.img'),
> +        '5bc29e2d872ceeb39a9698d42da3fb0afd7583dc7180de05a6b78bcc726674bb')
>   
>       IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
> +    default_kernel_params = 'console=ttyS0 rd.rescue quiet '
>       kernel_path = None
>       initrd_path = None
>       kernel_params = None
>   
> -    def set_up_boot(self):
> -        path = self.download_boot()
> -        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
> -                         'drive=drv0,id=virtio-disk0,bootindex=1,'
> -                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
> -        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
> -        self.vm.add_args('-drive',
> -                         'file=%s,if=none,cache=writethrough,id=drv0' % path)
> -
> -    def setUp(self):
> -        super(IntelIOMMU, self).setUp(None, 'virtio-net-pci' + self.IOMMU_ADDON)
> -
>       def add_common_args(self):
>           self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
>           self.vm.add_args('-object',
>                            'rng-random,id=rng0,filename=/dev/urandom')
> +        self.vm.add_args('-device', 'virtio-net-pci' + self.IOMMU_ADDON)
> +        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
> +        self.vm.add_args("-m", "1G")
>   
> -    def common_vm_setup(self, custom_kernel=None):
> +    def common_vm_setup(self):
> +        self.set_machine('q35')
>           self.require_accelerator("kvm")
>           self.add_common_args()
>           self.vm.add_args("-accel", "kvm")
>   
> -        if custom_kernel is None:
> -            return
> -
> -        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
> -        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
> -        initrd_url = self.distro.pxeboot_url + 'initrd.img'
> -        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
> -        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> -        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +        self.kernel_path = self.ASSET_KERNEL.fetch()
> +        self.initrd_path = self.ASSET_INITRD.fetch()
> +        self.kernel_params = self.default_kernel_params
>   
>       def run_and_check(self):
>           if self.kernel_path:
>               self.vm.add_args('-kernel', self.kernel_path,
>                                '-append', self.kernel_params,
>                                '-initrd', self.initrd_path)
> -        self.launch_and_wait()
> -        self.ssh_command('cat /proc/cmdline')
> -        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
> -        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
> -        self.ssh_command('dnf -y install numactl-devel')
> +        self.vm.set_console()
> +        self.vm.launch()
> +        self.wait_for_console_pattern('(or press Control-D to continue):')
> +        prompt = ':/root#'
> +        exec_command_and_wait_for_pattern(self, '', prompt)
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cmdline',
> +                                          'intel_iommu=on')
> +        self.wait_for_console_pattern(prompt)
> +        exec_command_and_wait_for_pattern(self, 'dmesg | grep DMAR:',
> +                                          'IOMMU enabled')
> +        self.wait_for_console_pattern(prompt)
> +        exec_command_and_wait_for_pattern(self,
> +                                    'find /sys/kernel/iommu_groups/ -type l',
> +                                    'devices/0000:00:')
> +        self.wait_for_console_pattern(prompt)
>   
>       def test_intel_iommu(self):
> -        """
> -        :avocado: tags=intel_iommu_intremap
> -        """
> -
> -        self.common_vm_setup(True)
> +        self.common_vm_setup()
>           self.vm.add_args('-device', 'intel-iommu,intremap=on')
>           self.vm.add_args('-machine', 'kernel_irqchip=split')
> -
> -        self.kernel_params = (self.distro.default_kernel_params +
> -                              ' quiet intel_iommu=on')
> +        self.kernel_params += 'intel_iommu=on'
>           self.run_and_check()
>   
>       def test_intel_iommu_strict(self):
> -        """
> -        :avocado: tags=intel_iommu_strict
> -        """
> -
> -        self.common_vm_setup(True)
> +        self.common_vm_setup()
>           self.vm.add_args('-device', 'intel-iommu,intremap=on')
>           self.vm.add_args('-machine', 'kernel_irqchip=split')
> -        self.kernel_params = (self.distro.default_kernel_params +
> -                              ' quiet intel_iommu=on,strict')
> +        self.kernel_params += 'intel_iommu=on,strict'
>           self.run_and_check()
>   
>       def test_intel_iommu_strict_cm(self):
> -        """
> -        :avocado: tags=intel_iommu_strict_cm
> -        """
> -
> -        self.common_vm_setup(True)
> +        self.common_vm_setup()
>           self.vm.add_args('-device', 'intel-iommu,intremap=on,caching-mode=on')
>           self.vm.add_args('-machine', 'kernel_irqchip=split')
> -        self.kernel_params = (self.distro.default_kernel_params +
> -                              ' quiet intel_iommu=on,strict')
> +        self.kernel_params += 'intel_iommu=on,strict'
>           self.run_and_check()
>   
>       def test_intel_iommu_pt(self):
> -        """
> -        :avocado: tags=intel_iommu_pt
> -        """
> -
> -        self.common_vm_setup(True)
> +        self.common_vm_setup()
>           self.vm.add_args('-device', 'intel-iommu,intremap=on')
>           self.vm.add_args('-machine', 'kernel_irqchip=split')
> -        self.kernel_params = (self.distro.default_kernel_params +
> -                              ' quiet intel_iommu=on iommu=pt')
> +        self.kernel_params += 'intel_iommu=on iommu=pt'
>           self.run_and_check()
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


