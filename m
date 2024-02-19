Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B9BC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4xN-0000ol-03; Mon, 19 Feb 2024 09:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc4xJ-0000mW-TK; Mon, 19 Feb 2024 09:49:18 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc4xH-00079W-1h; Mon, 19 Feb 2024 09:49:17 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ABFEC4E6013;
 Mon, 19 Feb 2024 15:49:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id cgYGtKlT2F1E; Mon, 19 Feb 2024 15:49:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6321A4E6026; Mon, 19 Feb 2024 15:49:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 616297456FE;
 Mon, 19 Feb 2024 15:49:08 +0100 (CET)
Date: Mon, 19 Feb 2024 15:49:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Warner Losh <imp@bsdimp.com>
Subject: Re: [PULL 09/49] tests/avocado: Add FreeBSD distro boot tests for ppc
In-Reply-To: <20240219082938.238302-10-npiggin@gmail.com>
Message-ID: <dda9aa91-8673-4698-b97a-5c43dae0b0f2@eik.bme.hu>
References: <20240219082938.238302-1-npiggin@gmail.com>
 <20240219082938.238302-10-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024, Nicholas Piggin wrote:
> FreeBSD project provides qcow2 images that work well for testing QEMU.
> Add pseries tests for HPT and Radix, KVM and TCG. This uses a short
> term VM image, because FreeBSD has not set up long term builds for
> ppc64 at present.
>
> Other architectures could be added so this does not get a ppc_ prefix
> but is instead named similarly to boot_linux.
>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Didn't you mean to put this below ---?

Regards,
BALATON Zoltan

> Unfortunately the latest stable (14.0) x86-64 VM image does not seem to
> output to console by default and I've not been able to find a reliable
> way to edit the filesystem to change the boot loader options, or use
> console input in the test case to change it on the fly.
> ---
> tests/avocado/boot_freebsd.py | 174 ++++++++++++++++++++++++++++++++++
> 1 file changed, 174 insertions(+)
> create mode 100644 tests/avocado/boot_freebsd.py
>
> diff --git a/tests/avocado/boot_freebsd.py b/tests/avocado/boot_freebsd.py
> new file mode 100644
> index 0000000000..c01cd06cca
> --- /dev/null
> +++ b/tests/avocado/boot_freebsd.py
> @@ -0,0 +1,174 @@
> +# Functional tests that boot FreeBSD in various configurations
> +#
> +# Copyright (c) 2023 IBM Corporation
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +import subprocess
> +
> +from avocado import skipUnless
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern
> +from avocado_qemu import exec_command
> +from avocado.utils import archive
> +from avocado.utils import process
> +from avocado.utils.path import find_command
> +
> +@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
> +@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
> +class BootFreeBSDPPC64(QemuSystemTest):
> +    """
> +    :avocado: tags=arch:ppc64
> +    """
> +
> +    timeout = 360
> +
> +    def setUp(self):
> +        super().setUp()
> +
> +        # We need zstd for all the tests
> +        # See https://github.com/avocado-framework/avocado/issues/5609
> +        zstd = find_command('zstd', False)
> +        if zstd is False:
> +            self.cancel('Could not find "zstd", which is required to '
> +                        'decompress rootfs')
> +        tar = find_command('tar', False)
> +        if tar is False:
> +            self.cancel('Could not find "tar", which is required to '
> +                        'decompress rootfs')
> +
> +        drive_url = ('https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/8a735ffdf04936c6785ac4fa31486639262dd416/powerpc/powerpc64le/disk.qcow2.zst')
> +        drive_hash = '95d863dbbc4b60f4899d1ef21d6489fca05bf03d'
> +        drive_path_zstd = self.fetch_asset(drive_url, asset_hash=drive_hash)
> +        self.drive_path = os.path.join(self.workdir, 'disk.qcow2')
> +
> +        cmd = f"{zstd} -d {drive_path_zstd} -o {self.drive_path}"
> +        process.run(cmd)
> +
> +        kernel_url = ('https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/8a735ffdf04936c6785ac4fa31486639262dd416/powerpc/powerpc64le/kernel.txz')
> +        kernel_hash = '31d14c2dc658858830a7acab5128a5b91ea548cf'
> +        kernel_path_txz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        self.kernel_path = os.path.join(self.workdir, 'kernel')
> +
> +        with open(self.kernel_path, "w") as outfile:
> +            cmd = f"{tar} OJxf {kernel_path_txz} ./boot/kernel/kernel"
> +            subprocess.run(cmd.split(), stdout=outfile)
> +
> +    def set_pseries_devices(self):
> +        self.vm.add_args('-drive', f"file={self.drive_path},format=qcow2,if=virtio")
> +        self.vm.add_args('-net', 'nic,model=virtio')
> +
> +    def set_powernv_devices(self):
> +        self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
> +                         '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
> +                         '-netdev', 'user,id=net0,hostfwd=::20022-:22,hostname=freebsd')
> +        self.vm.add_args("-drive", f"file={self.drive_path},format=qcow2,if=none,id=drive0")
> +        self.vm.add_args("-kernel", self.kernel_path)
> +
> +    def run_pseries_test(self, force_HPT=False):
> +        if force_HPT:
> +            self.vm.add_args('-m', '4g')
> +        else:
> +            self.vm.add_args('-m', '1g')
> +        self.vm.add_args('-smp', '4')
> +        self.set_pseries_devices()
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'Hit [Enter] to boot immediately, or any other key for command prompt.')
> +        if force_HPT:
> +            exec_command(self, 'x')
> +            wait_for_console_pattern(self, 'OK')
> +            exec_command(self, 'set radix_mmu=0')
> +            exec_command(self, 'boot')
> +            wait_for_console_pattern(self, 'cas: selected hash MMU', 'panic:')
> +        else:
> +            exec_command(self, '')
> +            wait_for_console_pattern(self, 'cas: selected radix MMU', 'panic:')
> +
> +        wait_for_console_pattern(self, 'FreeBSD 15.0-CURRENT', 'panic:')
> +        wait_for_console_pattern(self, 'FreeBSD/SMP: Multiprocessor System Detected: 4 CPUs', 'panic:')
> +        wait_for_console_pattern(self, 'FreeBSD/powerpc (Amnesiac) (ttyu0)', 'panic:')
> +        exec_command(self, 'root')
> +        wait_for_console_pattern(self, 'resizewin: timeout reading from terminal')
> +        exec_command(self, 'poweroff')
> +        wait_for_console_pattern(self, 'Uptime:', 'panic:')
> +        self.vm.wait()
> +
> +    # powernv does not have a bootloader so must load the kernel directly
> +    # and work around manual specification of the root device. Also can't
> +    # specify options like radix_mmu the same way (todo: work out how it
> +    # is done, and add HPT test).
> +    def run_powernv_test(self, force_HPT=False):
> +        self.vm.add_args('-m', '8g')
> +        self.vm.add_args('-smp', '4')
> +        self.set_powernv_devices()
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'FreeBSD 15.0-CURRENT', 'panic:')
> +        wait_for_console_pattern(self, 'FreeBSD/SMP: Multiprocessor System Detected: 4 CPUs', 'panic:')
> +        wait_for_console_pattern(self, '<empty line>    Abort manual input')
> +        exec_command(self, 'ufs:diskid/DISK-1234s3')
> +
> +        wait_for_console_pattern(self, 'FreeBSD/powerpc (Amnesiac) (ttyu0)', 'panic:')
> +        exec_command(self, 'root')
> +        wait_for_console_pattern(self, 'resizewin: timeout reading from terminal')
> +        exec_command(self, 'poweroff')
> +        wait_for_console_pattern(self, 'Uptime:', 'panic:')
> +        wait_for_console_pattern(self, 'OPAL: Shutdown request', 'panic:')
> +        self.vm.wait()
> +
> +    def test_pseries_tcg(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        self.vm.add_args("-cpu", "power10")
> +        self.vm.add_args("-accel", "tcg,thread=multi")
> +        self.run_pseries_test()
> +
> +    def test_pseries_hpt_tcg(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        self.vm.add_args("-accel", "tcg,thread=multi")
> +        self.run_pseries_test(force_HPT=True)
> +
> +    def test_pseries_kvm(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:kvm
> +        """
> +        self.require_accelerator("kvm")
> +        self.vm.add_args("-accel", "kvm")
> +        self.run_pseries_test()
> +
> +    def test_pseries_hpt_kvm(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:kvm
> +        """
> +        self.require_accelerator("kvm")
> +        self.vm.add_args("-accel", "kvm")
> +        self.run_pseries_test(force_HPT=True)
> +
> +    # powernv9 works, powernv10 fails
> +    def test_powernv(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv9
> +        :avocado: tags=accel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        self.vm.add_args("-accel", "tcg,thread=multi")
> +        self.run_powernv_test()
>

