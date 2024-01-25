Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98498C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 09:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSvzI-0006Tm-HF; Thu, 25 Jan 2024 04:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSvzH-0006TS-6S; Thu, 25 Jan 2024 04:25:31 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSvzE-0000lb-Tf; Thu, 25 Jan 2024 04:25:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLFmQ1gwRz4x5q;
 Thu, 25 Jan 2024 20:25:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLFmM0NS7z4wbh;
 Thu, 25 Jan 2024 20:25:22 +1100 (AEDT)
Message-ID: <ffdd4ee9-2d76-4840-b661-b873abbd07d2@kaod.org>
Date: Thu, 25 Jan 2024 10:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] tests/avocado: Add ppc pseries and powernv hash
 MMU tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240117141224.90462-1-npiggin@gmail.com>
 <20240117141224.90462-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117141224.90462-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Usek=JD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/17/24 15:12, Nicholas Piggin wrote:
> POWER CPUs support hash and radix MMU modes. Linux supports running in
> either mode, but defaults to radix. To keep up testing of QEMU's hash
> MMU implementation, add some Linux hash boot tests.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   tests/avocado/ppc_powernv.py | 23 +++++++++++++++++++----
>   tests/avocado/ppc_pseries.py | 20 +++++++++++++++++---
>   2 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
> index d0e5c07bde..4342941d5d 100644
> --- a/tests/avocado/ppc_powernv.py
> +++ b/tests/avocado/ppc_powernv.py
> @@ -12,11 +12,11 @@
>   class powernvMachine(QemuSystemTest):
>   
>       timeout = 90
> -    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
>       panic_message = 'Kernel panic - not syncing'
>       good_message = 'VFS: Cannot open root device'
>   
> -    def do_test_linux_boot(self):
> +    def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
>           self.require_accelerator("tcg")
>           kernel_url = ('https://archives.fedoraproject.org/pub/archive'
>                         '/fedora-secondary/releases/29/Everything/ppc64le/os'
> @@ -25,9 +25,8 @@ def do_test_linux_boot(self):
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
>           self.vm.set_console()
> -        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
>           self.vm.add_args('-kernel', kernel_path,
> -                         '-append', kernel_command_line)
> +                         '-append', command_line)
>           self.vm.launch()
>   
>       def test_linux_boot(self):
> @@ -54,6 +53,22 @@ def test_linux_smp_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_linux_smp_hpt_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv
> +        :avocado: tags=accel:tcg
> +        """
> +
> +        self.vm.add_args('-smp', '4')
> +        self.do_test_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
> +                                'disable_radix')
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, 'hash-mmu: Initializing hash mmu',
> +                                 self.panic_message)
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)
> +
>       def test_linux_smt_boot(self):
>           """
>           :avocado: tags=arch:ppc64
> diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
> index a8311e6555..74aaa4ac4a 100644
> --- a/tests/avocado/ppc_pseries.py
> +++ b/tests/avocado/ppc_pseries.py
> @@ -12,11 +12,11 @@
>   class pseriesMachine(QemuSystemTest):
>   
>       timeout = 90
> -    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
>       panic_message = 'Kernel panic - not syncing'
>       good_message = 'VFS: Cannot open root device'
>   
> -    def do_test_ppc64_linux_boot(self):
> +    def do_test_ppc64_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_LINE):
>           kernel_url = ('https://archives.fedoraproject.org/pub/archive'
>                         '/fedora-secondary/releases/29/Everything/ppc64le/os'
>                         '/ppc/ppc64/vmlinuz')
> @@ -24,7 +24,6 @@ def do_test_ppc64_linux_boot(self):
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
>           self.vm.set_console()
> -        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
>           self.vm.add_args('-kernel', kernel_path,
>                            '-append', kernel_command_line)
>           self.vm.launch()
> @@ -62,6 +61,21 @@ def test_ppc64_linux_smp_boot(self):
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>   
> +    def test_ppc64_linux_hpt_smp_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        """
> +
> +        self.vm.add_args('-smp', '4')
> +        self.do_test_ppc64_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
> +                                      'disable_radix')
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, 'hash-mmu: Initializing hash mmu',
> +                                 self.panic_message)
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)
> +
>       def test_ppc64_linux_smt_boot(self):
>           """
>           :avocado: tags=arch:ppc64


