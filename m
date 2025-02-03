Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3B2C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teueK-0002xp-TG; Mon, 03 Feb 2025 06:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1teueJ-0002xd-I2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:29:55 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1teueH-000667-Ag
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:29:55 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E9BA34E6005;
 Mon, 03 Feb 2025 12:29:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id BVyX4JZlGmmY; Mon,  3 Feb 2025 12:29:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A87584E6001; Mon, 03 Feb 2025 12:29:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A660374577C;
 Mon, 03 Feb 2025 12:29:45 +0100 (CET)
Date: Mon, 3 Feb 2025 12:29:45 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/functional: Add a ppc sam460ex test
In-Reply-To: <20250203092606.491933-1-clg@redhat.com>
Message-ID: <bd96e71e-c516-6a09-ba7b-904809c17c84@eik.bme.hu>
References: <20250203092606.491933-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-496182306-1738582185=:49103"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-496182306-1738582185=:49103
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 3 Feb 2025, Cédric Le Goater wrote:
> The test sequence boots from kernel a sam460ex machine with a
> virtio-net device to check PCI.
>
> The buildroot is built with config :
>
>  BR2_powerpc=y
>  BR2_powerpc_440fp=y
>
> and the kernel with the '44x/canyonlands' deconfig and virtio support.
>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> MAINTAINERS                           |  1 +
> tests/functional/meson.build          |  1 +
> tests/functional/test_ppc_sam460ex.py | 38 +++++++++++++++++++++++++++
> 3 files changed, 40 insertions(+)
> create mode 100644 tests/functional/test_ppc_sam460ex.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d30c5bafd87..e4ab6031511b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1555,6 +1555,7 @@ F: pc-bios/canyonlands.dt[sb]
> F: pc-bios/u-boot-sam460ex-20100605.bin
> F: roms/u-boot-sam460ex
> F: docs/system/ppc/amigang.rst
> +F: tests/functional/test_ppc_sam460ex.py
>
> pegasos2
> M: BALATON Zoltan <balaton@eik.bme.hu>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 868f4a64b60b..6a5f1dc405cb 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -193,6 +193,7 @@ tests_ppc_system_thorough = [
>   'ppc_40p',
>   'ppc_amiga',
>   'ppc_bamboo',
> +  'ppc_sam460ex',

Instead of adding a new file this could be within ppc_amiga which was 
meant to be a place for all AmigaNG boards but only has amigaone for now. 
Unless there's a good reason for it to be separate due to how tests work 
that I'm not aware of.

Regards,
BALATON Zoltan

>   'ppc_mac',
>   'ppc_mpc8544ds',
>   'ppc_tuxrun',
> diff --git a/tests/functional/test_ppc_sam460ex.py b/tests/functional/test_ppc_sam460ex.py
> new file mode 100644
> index 000000000000..31cf9dd6de83
> --- /dev/null
> +++ b/tests/functional/test_ppc_sam460ex.py
> @@ -0,0 +1,38 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a sam460ex machine with a PPC 460EX CPU
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +from qemu_test import exec_command_and_wait_for_pattern
> +
> +
> +class sam460exTest(LinuxKernelTest):
> +
> +    ASSET_BR2_SAM460EX_LINUX = Asset(
> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc_sam460ex-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
> +        '6f46346f3e20e8b5fc050ff363f350f8b9d76a051b9e0bd7ea470cc680c14df2')
> +
> +    def test_ppc_sam460ex_buildroot(self):
> +        self.set_machine('sam460ex')
> +        self.require_netdev('user')
> +
> +        linux_path = self.ASSET_BR2_SAM460EX_LINUX.fetch()
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', linux_path,
> +                         '-device', 'virtio-net-pci,netdev=net0',
> +                         '-netdev', 'user,id=net0')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('Linux version')
> +        self.wait_for_console_pattern('Hardware name: amcc,canyonlands 460EX')
> +        self.wait_for_console_pattern('/init as init process')
> +        self.wait_for_console_pattern('lease of 10.0.2.15 obtained')
> +        self.wait_for_console_pattern('buildroot login:')
> +        exec_command_and_wait_for_pattern(self, 'root', '#')
> +        exec_command_and_wait_for_pattern(self, 'poweroff', 'System Halted')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()
>
--3866299591-496182306-1738582185=:49103--

