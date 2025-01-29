Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBC1C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdBP2-0004Hf-T7; Wed, 29 Jan 2025 11:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdBP1-0004H8-6D; Wed, 29 Jan 2025 11:58:59 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdBOz-0005pj-Bs; Wed, 29 Jan 2025 11:58:58 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E058D4E6027;
 Wed, 29 Jan 2025 17:58:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id vXCjyTdHRf-O; Wed, 29 Jan 2025 17:58:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B57194E602A; Wed, 29 Jan 2025 17:58:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B385E74577E;
 Wed, 29 Jan 2025 17:58:53 +0100 (CET)
Date: Wed, 29 Jan 2025 17:58:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] tests/functional: Add a ppc64 mac99 test
In-Reply-To: <20250128212145.1186617-1-clg@redhat.com>
Message-ID: <390bd0cd-c918-33e5-7647-3662944d3066@eik.bme.hu>
References: <20250128212145.1186617-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1280706929-1738169933=:21657"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1280706929-1738169933=:21657
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jan 2025, Cédric Le Goater wrote:
> The test sequence boots from disk a mac99 machine in 64-bit mode, in
> which case the CPU is a PPC 970.
>
> The buildroot rootfs is built with config :
>
> BR2_powerpc64=y
> BR2_powerpc_970=y
>
> and the kernel with the g5 deconfig.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
> Changes in v2:
>
> - Moved self.set_machine('mac99') at the top
> - Dropped sungem nic on the command line
>
> MAINTAINERS                          |  1 +
> tests/functional/meson.build         |  2 ++
> tests/functional/test_ppc64_mac99.py | 43 ++++++++++++++++++++++++++++
> 3 files changed, 46 insertions(+)
> create mode 100755 tests/functional/test_ppc64_mac99.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a2291d17d7e..ebf249173f00 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1446,6 +1446,7 @@ F: include/hw/pci-host/uninorth.h
> F: include/hw/input/adb*
> F: pc-bios/qemu_vga.ndrv
> F: tests/functional/test_ppc_mac.py
> +F: tests/functional/test_ppc64_mac99.py
>
> Old World (g3beige)
> M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 01a87b03e553..821a0a7c49ac 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -41,6 +41,7 @@ test_timeouts = {
>   'ppc64_powernv' : 480,
>   'ppc64_pseries' : 480,
>   'ppc64_tuxrun' : 420,
> +  'ppc64_mac99' : 120,
>   'riscv64_tuxrun' : 120,
>   's390x_ccw_virtio' : 420,
>   'sh4_tuxrun' : 240,
> @@ -181,6 +182,7 @@ tests_ppc64_system_thorough = [
>   'ppc64_powernv',
>   'ppc64_pseries',
>   'ppc64_tuxrun',
> +  'ppc64_mac99',
> ]
>
> tests_riscv32_system_quick = [
> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/test_ppc64_mac99.py
> new file mode 100755
> index 000000000000..9aec7c020748
> --- /dev/null
> +++ b/tests/functional/test_ppc64_mac99.py
> @@ -0,0 +1,43 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a mac99 machine with a PPC970 CPU
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +from qemu_test import exec_command_and_wait_for_pattern
> +
> +class mac99Test(LinuxKernelTest):
> +
> +    ASSET_BR2_MAC99_LINUX = Asset(
> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
> +        'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
> +
> +    ASSET_BR2_MAC99_ROOTFS = Asset(
> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
> +        'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
> +
> +    def test_ppc64_mac99_buildroot(self):
> +        self.set_machine('mac99')
> +
> +        linux_path = self.ASSET_BR2_MAC99_LINUX.fetch()
> +        rootfs_path = self.ASSET_BR2_MAC99_ROOTFS.fetch()
> +
> +        self.vm.set_console()
> +
> +        self.vm.add_args('-kernel', linux_path,
> +                         '-append', 'root=/dev/sda',
> +                         '-drive', f'file={rootfs_path},format=raw',
> +                         '-snapshot', '-nographic') # -nographic to get a console

Nit: # -nographic for serial console or get a console on serial

Regards,
BALATON Zoltan

> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('>> OpenBIOS')
> +        self.wait_for_console_pattern('Linux version')
> +        self.wait_for_console_pattern('/init as init process')
> +        self.wait_for_console_pattern('gem 0000:f0:0e.0 eth0: Link is up at 100 Mbps')
> +        self.wait_for_console_pattern('buildroot login:')
> +        exec_command_and_wait_for_pattern(self, 'root', '#')
> +        exec_command_and_wait_for_pattern(self, 'poweroff', 'Power down')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()
>
--3866299591-1280706929-1738169933=:21657--

