Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA72C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts09s-0001sw-4L; Tue, 11 Mar 2025 10:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ts09q-0001sX-4a
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ts09m-0003LL-ML
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741701624;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zeq58+/422ZaJvT/EPO/gkv6fz0KNgQz2Hu+FNcwLXw=;
 b=L6C7ob+TpaBcF5OwnRWrQqrcdiFK780uvXG6wToyESU//1DAdFvC81tqp7Wi69xkZaRGSf
 xgy1+Dvk4ZAHCS9k8KwePyR8mek6pXMjnuDyOBeYw/O5xpZkdOcVdfwfl7yV50DvCL8nZo
 AEO7Pa8DvJfU3SsFy/pol9g+6CNI7rk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-pGlXyiL8NliFDjFFFaObFA-1; Tue, 11 Mar 2025 10:00:22 -0400
X-MC-Unique: pGlXyiL8NliFDjFFFaObFA-1
X-Mimecast-MFC-AGG-ID: pGlXyiL8NliFDjFFFaObFA_1741701622
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c3c8f8ab79so985038685a.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 07:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741701621; x=1742306421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zeq58+/422ZaJvT/EPO/gkv6fz0KNgQz2Hu+FNcwLXw=;
 b=aI/KlZXAEQdYHjNPqp8auON9wJD9mlkKyGDbTaL2hXKtP95RmJVgK7/H6+/4oq8ZoI
 +qo8WG6LKvDx+5E7y6QZpdn1YM5W6tP3OzHQvKlsD3zJLNqTiVXGY+y00qnBOo1Ok/Q0
 H9GC4pLFKXz9Dtzh+qAuHsFCQJ2qvCBeS446itOIXR8DZZZwFF4sOHVmiuBwcLJX24vn
 hmUHAW8tQlQSfCgslA96J6ClHgnp4H/lp09yRE6fCm1H7i2qWT4u7StLFdhVooJrevEp
 N+Nu4FPpPNnOS7Fr1gGFpQzeo87j7UOQI/KiVvrDTTJF75J0q+g9yeVoTFZYT1PQCMrI
 shtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUglPrlUKZ20dSa6mogWCHrEPC+jz5S3WGNu+4l4b0soM1BUxmobVcLs5uvq7p2jJhzq4riAeN+5PPj@nongnu.org
X-Gm-Message-State: AOJu0YyHU1qSqaVaY+VajxvmmOmjM2nmx/jbRNqp5atvBhPVXuOy0yRK
 FAW2CY3h949uJg7T6VwUgqQwECovsAQajlWZQup2Iu+MZVUSuTi7j6V9/jM/1iT3+sbvVteA/P+
 Ooqk1OWc8Dg3cVD9mdM9Ioxr96P65uwzfcayyGb4e2SiTCDmFDjc0
X-Gm-Gg: ASbGncvCM3sgQoNuUaDhT27UeXLrQDpwN366pPaaCuEF8ezhXON6dvIxddmKF5CytZY
 OcCiirIsX2YY7iW/TQDQPuXojOaJKEl4YgeWqguhj/UxcjxhV5EylcQAcW3O4DTAAqVTfZIr2GY
 cqonM0LQrHoNwZEMaU42IDn/pYG4MP626iL2WyzaWEbjm47LHozQiNNhp415LSYSjNv007rO7jr
 6WSvD3TU5h6uSYQ/+pBGQRx3NoxA8yYeE2sJYsPz4br/Kj60bYL1l91q/y/0Bc6L58RLDqO4r0g
 sfPv1qF4MY6WdKF8xw3ltIGxFZpnY3N7WBb8fjuxo1KUTTS77NtvlFxSQwiskSA=
X-Received: by 2002:a05:620a:2691:b0:7c5:4eee:5403 with SMTP id
 af79cd13be357-7c55e92b780mr468075885a.38.1741701621529; 
 Tue, 11 Mar 2025 07:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGCZWTlY/2PR1G3v+8Rb8OKvRgUnY6DkEBa1Fq8xdgOddeN7NlzpRI+nB7iGCSavhK/41RLw==
X-Received: by 2002:a05:620a:2691:b0:7c5:4eee:5403 with SMTP id
 af79cd13be357-7c55e92b780mr468067985a.38.1741701620854; 
 Tue, 11 Mar 2025 07:00:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c55212d8c8sm354984585a.42.2025.03.11.07.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 07:00:20 -0700 (PDT)
Message-ID: <4b7d75f1-12df-44ab-9435-df517beff716@redhat.com>
Date: Tue, 11 Mar 2025 15:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] tests/functional: Convert the SMMU test to the
 functional framework
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250311104920.364102-1-thuth@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311104920.364102-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Thomas,


On 3/11/25 11:49 AM, Thomas Huth wrote:
> This test was using cloudinit and a "dnf install" command in the guest
> to exercise the NIC with SMMU enabled. Since we don't have the cloudinit
> stuff in the functional framework and we should not rely on having access
> to external networks (once our ASSETs have been cached), we rather boot
> into the initrd first, manually mount the root disk and then use the
> check_http_download() function from the functional framework here instead
> for testing whether the network works as expected.
>
> Unfortunately, there seems to be a small race when using the files
> from Fedora 33: To enter the initrd shell, we have to send a "return"
> once. But it does not seem to work if we send it too early. Using a
> sleep(0.2) makes it work reliably for me, but to make it even more
> unlikely to trigger this situation, let's better limit the Fedora 33
> tests to only run with KVM.
>
> Finally, while we're at it, we also add some lines for testing writes
> to the hard disk, as we already do it in the test_intel_iommu test.

for your info it does not apply anymore on mainline after latest appied
functional test additions.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                   |   2 +-
>  tests/functional/meson.build                  |   2 +
>  .../test_aarch64_smmu.py}                     | 243 +++++++++++-------
>  3 files changed, 159 insertions(+), 88 deletions(-)
>  rename tests/{avocado/smmu.py => functional/test_aarch64_smmu.py} (17%)
>  mode change 100644 => 100755
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90e48b26715..211e70c6942 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -218,7 +218,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
> -F: tests/avocado/smmu.py
> +F: tests/functional/test_aarch64_smmu.py
>  
>  AVR TCG CPUs
>  M: Michael Rolnik <mrolnik@gmail.com>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 43a34c6447e..e8bf0e4a6bc 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -18,6 +18,7 @@ test_timeouts = {
>    'aarch64_rme_sbsaref' : 1200,
>    'aarch64_sbsaref_alpine' : 1200,
>    'aarch64_sbsaref_freebsd' : 720,
> +  'aarch64_smmu' : 720,
>    'aarch64_tuxrun' : 240,
>    'aarch64_virt' : 720,
>    'acpi_bits' : 420,
> @@ -84,6 +85,7 @@ tests_aarch64_system_thorough = [
>    'aarch64_sbsaref',
>    'aarch64_sbsaref_alpine',
>    'aarch64_sbsaref_freebsd',
> +  'aarch64_smmu',
>    'aarch64_tcg_plugins',
>    'aarch64_tuxrun',
>    'aarch64_virt',
> diff --git a/tests/avocado/smmu.py b/tests/functional/test_aarch64_smmu.py
> old mode 100644
> new mode 100755
> similarity index 17%
> rename from tests/avocado/smmu.py
> rename to tests/functional/test_aarch64_smmu.py
> index 83fd79e922e..bba8599401c
> --- a/tests/avocado/smmu.py
> +++ b/tests/functional/test_aarch64_smmu.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>  # SMMUv3 Functional tests
>  #
>  # Copyright (c) 2021 Red Hat, Inc.
> @@ -7,44 +9,48 @@
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> +
>  import os
> +import time
> +
> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
> +from qemu_test import BUILD_DIR
> +from qemu.utils import kvm_available
>  
> -from avocado import skipUnless
> -from avocado_qemu import BUILD_DIR
> -from avocado_qemu.linuxtest import LinuxTest
> -
> -@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> -class SMMU(LinuxTest):
> -    """
> -    :avocado: tags=accel:kvm
> -    :avocado: tags=cpu:host
> -    :avocado: tags=arch:aarch64
> -    :avocado: tags=machine:virt
> -    :avocado: tags=distro:fedora
> -    :avocado: tags=smmu
> -    :avocado: tags=flaky
> -    """
>  
> +class SMMU(LinuxKernelTest):
> +
> +    default_kernel_params = ('earlyprintk=pl011,0x9000000 no_timer_check '
> +                             'printk.time=1 rd_NO_PLYMOUTH net.ifnames=0 '
> +                             'console=ttyAMA0 rd.rescue')
>      IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
>      kernel_path = None
>      initrd_path = None
>      kernel_params = None
>  
> -    def set_up_boot(self):
> -        path = self.download_boot()
> +    GUEST_PORT = 8080
> +
> +    def set_up_boot(self, path):
>          self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
>                           'drive=drv0,id=virtio-disk0,bootindex=1,'
>                           'werror=stop,rerror=stop' + self.IOMMU_ADDON)
>          self.vm.add_args('-drive',
> -                         'file=%s,if=none,cache=writethrough,id=drv0' % path)
> -
> -    def setUp(self):
> -        super(SMMU, self).setUp(None, 'virtio-net-pci' + self.IOMMU_ADDON)
> -
> -    def common_vm_setup(self, custom_kernel=False):
> -        self.require_accelerator("kvm")
> -        self.vm.add_args("-accel", "kvm")
> -        self.vm.add_args("-cpu", "host")
> +                f'file={path},if=none,cache=writethrough,id=drv0,snapshot=on')
> +
> +        self.vm.add_args('-netdev',
> +                         'user,id=n1,hostfwd=tcp:127.0.0.1:0-:%d' %
> +                         self.GUEST_PORT)
> +        self.vm.add_args('-device', 'virtio-net,netdev=n1' + self.IOMMU_ADDON)
> +
> +    def common_vm_setup(self, kernel, initrd, disk):
> +        self.set_machine("virt")
> +        self.require_netdev('user')
> +        if kvm_available(qemu_bin=self.qemu_bin):
> +            self.vm.add_args("-accel", "kvm")
> +            self.vm.add_args("-cpu", "host")
> +        else:
> +            self.vm.add_args("-cpu", "cortex-a57")
> +        self.vm.add_args('-m', '1G')
>          self.vm.add_args("-machine", "iommu=smmuv3")
>          self.vm.add_args("-d", "guest_errors")
>          self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
> @@ -53,87 +59,150 @@ def common_vm_setup(self, custom_kernel=False):
>          self.vm.add_args('-object',
>                           'rng-random,id=rng0,filename=/dev/urandom')
>  
> -        if custom_kernel is False:
> -            return
> +        self.kernel_path = kernel.fetch()
> +        self.initrd_path = initrd.fetch()
> +        self.set_up_boot(disk.fetch())
> +
> +    def run_and_check(self, filename, hashsum):
> +        self.vm.add_args('-initrd', self.initrd_path)
> +        self.vm.add_args('-append', self.kernel_params)
> +        self.launch_kernel(self.kernel_path, initrd=self.initrd_path,
> +                           wait_for='attach it to a bug report.')
> +        prompt = '# '
> +        # Fedora 33 requires 'return' to be pressed to enter the shell.
> +        # There seems to be a small race between detecting the previous ':'
> +        # and sending the newline, so we need to add a small delay here.
> +        self.wait_for_console_pattern(':')
> +        time.sleep(0.2)
> +        exec_command_and_wait_for_pattern(self, '\n', prompt)
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cmdline',
> +                                          self.kernel_params)
> +
> +        # Checking for SMMU enablement:
> +        self.log.info("Checking whether SMMU has been enabled...")
> +        exec_command_and_wait_for_pattern(self, 'dmesg | grep smmu',
> +                                          'arm-smmu-v3')
> +        self.wait_for_console_pattern(prompt)
> +        exec_command_and_wait_for_pattern(self,
> +                                    'find /sys/kernel/iommu_groups/ -type l',
> +                                    'devices/0000:00:')
> +        self.wait_for_console_pattern(prompt)
> +
> +        # Copy a file (checked later), umount afterwards to drop disk cache:
> +        self.log.info("Checking hard disk...")
> +        exec_command_and_wait_for_pattern(self,
> +                        "while ! (dmesg -c | grep vda:) ; do sleep 1 ; done",
> +                        "vda2")
> +        exec_command_and_wait_for_pattern(self, 'mount /dev/vda2 /sysroot',
> +                                          'mounted filesystem')
> +        exec_command_and_wait_for_pattern(self, 'cp /bin/vi /sysroot/root/vi',
> +                                          prompt)
> +        exec_command_and_wait_for_pattern(self, 'umount /sysroot', prompt)
> +        # Switch from initrd to the cloud image filesystem:
> +        exec_command_and_wait_for_pattern(self, 'mount /dev/vda2 /sysroot',
> +                                          prompt)
> +        exec_command_and_wait_for_pattern(self,
> +                ('for d in dev proc sys run ; do '
> +                 'mount -o bind /$d /sysroot/$d ; done'), prompt)
> +        exec_command_and_wait_for_pattern(self, 'chroot /sysroot', prompt)
> +        # Check files on the hard disk:
> +        exec_command_and_wait_for_pattern(self,
> +            ('if diff -q /root/vi /usr/bin/vi ; then echo "file" "ok" ; '
> +             'else echo "files differ"; fi'), 'file ok')
> +        self.wait_for_console_pattern(prompt)
> +        exec_command_and_wait_for_pattern(self, f'sha256sum {filename}',
> +                                          hashsum)
> +
> +        # Check virtio-net via HTTP:
> +        exec_command_and_wait_for_pattern(self, 'dhclient eth0', prompt)
> +        self.check_http_download(filename, hashsum, self.GUEST_PORT)
>  
> -        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
> -        initrd_url = self.distro.pxeboot_url + 'initrd.img'
> -        self.kernel_path = self.fetch_asset(kernel_url)
> -        self.initrd_path = self.fetch_asset(initrd_url)
>  
> -    def run_and_check(self):
> -        if self.kernel_path:
> -            self.vm.add_args('-kernel', self.kernel_path,
> -                             '-append', self.kernel_params,
> -                             '-initrd', self.initrd_path)
> -        self.launch_and_wait()
> -        self.ssh_command('cat /proc/cmdline')
> -        self.ssh_command('dnf -y install numactl-devel')
> +    # 5.3 kernel without RIL #
>  
> +    ASSET_KERNEL_F31 = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> +         'releases/31/Server/aarch64/os/images/pxeboot/vmlinuz'),
> +        '413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120')
the hash seems wrong for the vmlinuz. I get
Exception: Hash of
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/31/Server/aarch64/os/images/pxeboot/vmlinuz
does not match
413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120

>  
> -    # 5.3 kernel without RIL #
> +    ASSET_INITRD_F31 = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> +         'releases/31/Server/aarch64/os/images/pxeboot/initrd.img'),
> +        '9f3146b28bc531c689f3c5f114cb74e4bd7bd548e0ba19fa77921d8bd256755a')
> +
> +    ASSET_DISK_F31 = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
> +         '/31/Cloud/aarch64/images/Fedora-Cloud-Base-31-1.9.aarch64.qcow2'),
> +        '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf16fe49')
> +
> +    F31_FILENAME = '/boot/initramfs-5.3.7-301.fc31.aarch64.img'
> +    F31_HSUM = '1a4beec6607d94df73d9dd1b4985c9c23dd0fdcf4e6ca1351d477f190df7bef9'
>  
>      def test_smmu_noril(self):
> -        """
> -        :avocado: tags=smmu_noril
> -        :avocado: tags=smmu_noril_tests
> -        :avocado: tags=distro_version:31
> -        """
> -        self.common_vm_setup()
> -        self.run_and_check()
> +        self.common_vm_setup(self.ASSET_KERNEL_F31, self.ASSET_INITRD_F31,
> +                             self.ASSET_DISK_F31)
> +        self.kernel_params = self.default_kernel_params
> +        self.run_and_check(self.F31_FILENAME, self.F31_HSUM)
>  
>      def test_smmu_noril_passthrough(self):
> -        """
> -        :avocado: tags=smmu_noril_passthrough
> -        :avocado: tags=smmu_noril_tests
> -        :avocado: tags=distro_version:31
> -        """
> -        self.common_vm_setup(True)
> -        self.kernel_params = (self.distro.default_kernel_params +
> +        self.common_vm_setup(self.ASSET_KERNEL_F31, self.ASSET_INITRD_F31,
> +                             self.ASSET_DISK_F31)
> +        self.kernel_params = (self.default_kernel_params +
>                                ' iommu.passthrough=on')
> -        self.run_and_check()
> +        self.run_and_check(self.F31_FILENAME, self.F31_HSUM)
>  
>      def test_smmu_noril_nostrict(self):
> -        """
> -        :avocado: tags=smmu_noril_nostrict
> -        :avocado: tags=smmu_noril_tests
> -        :avocado: tags=distro_version:31
> -        """
> -        self.common_vm_setup(True)
> -        self.kernel_params = (self.distro.default_kernel_params +
> +        self.common_vm_setup(self.ASSET_KERNEL_F31, self.ASSET_INITRD_F31,
> +                             self.ASSET_DISK_F31)
> +        self.kernel_params = (self.default_kernel_params +
>                                ' iommu.strict=0')
> -        self.run_and_check()
> +        self.run_and_check(self.F31_FILENAME, self.F31_HSUM)
> +
>  
>      # 5.8 kernel featuring range invalidation
>      # >= v5.7 kernel
>  
> +    ASSET_KERNEL_F33 = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> +         'releases/33/Server/aarch64/os/images/pxeboot/vmlinuz'),
> +        '0ef9e34f80b49fa2ac098899b27075e95c11d5b646f6ca4df2e89237a40f9e4f')
same here I get
Exception: Hash of
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/33/Server/aarch64/os/images/pxeboot/vmlinuz
does not match
0ef9e34f80b49fa2ac098899b27075e95c11d5b646f6ca4df2e89237a40f9e4f

> +
> +    ASSET_INITRD_F33 = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> +         'releases/33/Server/aarch64/os/images/pxeboot/initrd.img'),
> +        '92513f55295c2c16a777f7b6c35ccd70a438e9e1e40b6ba39e0e60900615b3df')
> +
> +    ASSET_DISK_F33 = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
> +         '/33/Cloud/aarch64/images/Fedora-Cloud-Base-33-1.2.aarch64.qcow2'),
> +        'e7f75cdfd523fe5ac2ca9eeece68edc1a81f386a17f969c1d1c7c87031008a6b')
> +
> +    F33_FILENAME = '/boot/initramfs-5.8.15-301.fc33.aarch64.img'
> +    F33_HSUM = '079cfad0caa82e84c8ca1fb0897a4999dd769f262216099f518619e807a550d9'
> +
>      def test_smmu_ril(self):
> -        """
> -        :avocado: tags=smmu_ril
> -        :avocado: tags=smmu_ril_tests
> -        :avocado: tags=distro_version:33
> -        """
> -        self.common_vm_setup()
> -        self.run_and_check()
> +        self.require_accelerator("kvm")
> +        self.common_vm_setup(self.ASSET_KERNEL_F33, self.ASSET_INITRD_F33,
> +                             self.ASSET_DISK_F33)
> +        self.kernel_params = self.default_kernel_params
> +        self.run_and_check(self.F33_FILENAME, self.F33_HSUM)
>  
>      def test_smmu_ril_passthrough(self):
> -        """
> -        :avocado: tags=smmu_ril_passthrough
> -        :avocado: tags=smmu_ril_tests
> -        :avocado: tags=distro_version:33
> -        """
> -        self.common_vm_setup(True)
> -        self.kernel_params = (self.distro.default_kernel_params +
> +        self.require_accelerator("kvm")
> +        self.common_vm_setup(self.ASSET_KERNEL_F33, self.ASSET_INITRD_F33,
> +                             self.ASSET_DISK_F33)
> +        self.kernel_params = (self.default_kernel_params +
>                                ' iommu.passthrough=on')
> -        self.run_and_check()
> +        self.run_and_check(self.F33_FILENAME, self.F33_HSUM)
>  
>      def test_smmu_ril_nostrict(self):
> -        """
> -        :avocado: tags=smmu_ril_nostrict
> -        :avocado: tags=smmu_ril_tests
> -        :avocado: tags=distro_version:33
> -        """
> -        self.common_vm_setup(True)
> -        self.kernel_params = (self.distro.default_kernel_params +
> +        self.require_accelerator("kvm")
> +        self.common_vm_setup(self.ASSET_KERNEL_F33, self.ASSET_INITRD_F33,
> +                             self.ASSET_DISK_F33)
> +        self.kernel_params = (self.default_kernel_params +
>                                ' iommu.strict=0')
> -        self.run_and_check()
> +        self.run_and_check(self.F33_FILENAME, self.F33_HSUM)
> +
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()
Thanks

Eric


