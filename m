Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74738C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 09:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSvwn-00055w-KN; Thu, 25 Jan 2024 04:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSvwm-00055U-4s; Thu, 25 Jan 2024 04:22:56 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Usek=JD=kaod.org=clg@ozlabs.org>)
 id 1rSvwk-0000JT-0l; Thu, 25 Jan 2024 04:22:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLFjN6189z4x3D;
 Thu, 25 Jan 2024 20:22:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLFjK2PnDz4wcX;
 Thu, 25 Jan 2024 20:22:45 +1100 (AEDT)
Message-ID: <a20f1294-3b5a-4d06-beda-628447ffe3d0@kaod.org>
Date: Thu, 25 Jan 2024 10:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] tests/avocado: Mark x86-64 boot_linux.py TCG tests
 as long runtime
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
 <20240117141224.90462-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117141224.90462-3-npiggin@gmail.com>
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
> Re-testing gitlab CI shows the ppc64 and s390x boot_linux tests take
> 100-150 seconds each. The x86-64 TCG tests take a similar ~100s each,
> and are the longest-running avocado tests in gitlab.
>  From avocado-system-centos:
> 
>    boot_linux.py:BootLinuxX8664.test_pc_i440fx_tcg:  PASS (112.34 s)
>    boot_linux.py:BootLinuxX8664.test_pc_q35_tcg:  PASS (97.05 s)
>    boot_linux.py:BootLinuxPPC64.test_pseries_tcg:  PASS (148.86 s)
>    boot_linux.py:BootLinuxS390X.test_s390_ccw_virtio_tcg:  PASS (149.83 s)
> 
> So mark the x86-64 tests as SPEED=slow as well.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> The other way we could go is enabling them all since ppc64 and s390s are
> now much faster than when they were originally disabled; or to only
> enable q35, giving at least one boot_linux.py test.
> 
> [https://gitlab.com/npiggin/qemu/-/jobs/5842257510 for results]


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   tests/avocado/boot_linux.py | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
> index de4c8805f7..7c9cf6ae15 100644
> --- a/tests/avocado/boot_linux.py
> +++ b/tests/avocado/boot_linux.py
> @@ -14,6 +14,9 @@
>   
>   from avocado import skipUnless
>   
> +# We don't run TCG tests in CI, as booting the current Fedora OS in TCG tests
> +# is very heavyweight (~100s per test). There are lighter weight distros which
> +# we use in the machine_aarch64_virt.py, tux_baseline.py, etc.
>   
>   class BootLinuxX8664(LinuxTest):
>       """
> @@ -21,6 +24,7 @@ class BootLinuxX8664(LinuxTest):
>       """
>       timeout = 480
>   
> +    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
>       def test_pc_i440fx_tcg(self):
>           """
>           :avocado: tags=machine:pc
> @@ -39,6 +43,7 @@ def test_pc_i440fx_kvm(self):
>           self.vm.add_args("-accel", "kvm")
>           self.launch_and_wait(set_up_ssh_connection=False)
>   
> +    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
>       def test_pc_q35_tcg(self):
>           """
>           :avocado: tags=machine:q35
> @@ -58,9 +63,6 @@ def test_pc_q35_kvm(self):
>           self.launch_and_wait(set_up_ssh_connection=False)
>   
>   
> -# For Aarch64 we only boot KVM tests in CI as booting the current
> -# Fedora OS in TCG tests is very heavyweight. There are lighter weight
> -# distros which we use in the machine_aarch64_virt.py tests.
>   class BootLinuxAarch64(LinuxTest):
>       """
>       :avocado: tags=arch:aarch64
> @@ -84,14 +86,11 @@ def test_virt_kvm(self):
>           self.launch_and_wait(set_up_ssh_connection=False)
>   
>   
> -# See the tux_baseline.py tests for almost the same coverage in a lot
> -# less time.
>   class BootLinuxPPC64(LinuxTest):
>       """
>       :avocado: tags=arch:ppc64
>       """
> -
> -    timeout = 360
> +    timeout = 480
>   
>       @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
>       def test_pseries_tcg(self):
> @@ -108,8 +107,7 @@ class BootLinuxS390X(LinuxTest):
>       """
>       :avocado: tags=arch:s390x
>       """
> -
> -    timeout = 240
> +    timeout = 480
>   
>       @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
>       def test_s390_ccw_virtio_tcg(self):


