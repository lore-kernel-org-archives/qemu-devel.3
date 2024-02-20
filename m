Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA7EC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLxJ-0008JQ-0h; Tue, 20 Feb 2024 03:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rcLxD-0007z3-Qd; Tue, 20 Feb 2024 03:58:20 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rcLxA-0000he-IU; Tue, 20 Feb 2024 03:58:19 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id B3EAE40737C5;
 Tue, 20 Feb 2024 08:57:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B3EAE40737C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1708419470;
 bh=elkSpOAmlNJJ3p1ebAxvciRm89hULlvZlNqyvN3LONE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fK1nnW6+w2QSND08LkPuBWYDr26+T0CzQuXDMYtIuY8GXBEW7jZI3b7Nb90PSa5e8
 mpVWxpIxf+8wSCC2AQGi5IyDbqtHhnoUrwXv8BRCBQS9HtvJs89vsrtZBYGxgx4VJ6
 buPggvMn29XNfI5Gs7GUvQKooRv3eBg6thGHnWGc=
Message-ID: <26a43eca-4bf3-4b35-a00b-b2b085c8ea8b@ispras.ru>
Date: Tue, 20 Feb 2024 11:57:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/21] tests: correct typos
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <723e7a4b522cebce583e924fbd965f110cbc2af4.1708419115.git.manos.pitsidianakis@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <723e7a4b522cebce583e924fbd965f110cbc2af4.1708419115.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 20.02.2024 11:52, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   tests/avocado/acpi-bits/bits-tests/smbios.py2 | 2 +-
>   tests/avocado/mem-addr-space-check.py         | 6 +++---
>   tests/avocado/reverse_debugging.py            | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/avocado/acpi-bits/bits-tests/smbios.py2 b/tests/avocado/acpi-bits/bits-tests/smbios.py2
> index fc623de072..5868a7137a 100644
> --- a/tests/avocado/acpi-bits/bits-tests/smbios.py2
> +++ b/tests/avocado/acpi-bits/bits-tests/smbios.py2
> @@ -1060,7 +1060,7 @@ class EventLogDescriptor(unpack.Struct):
>               0x16: 'Log Area Reset/Cleared',
>               0x17: 'System boot',
>               xrange(0x18, 0x7F): 'Unused, available for assignment',
> -            xrange(0x80, 0xFE): 'Availalbe for system- and OEM-specific assignments',
> +            xrange(0x80, 0xFE): 'Available for system- and OEM-specific assignments',
>               0xFF: 'End of log'
>           }
>           yield 'log_type', u.unpack_one('B'), unpack.format_table("{}", _event_log_type_descriptors)
> diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
> index 363c3f12a6..af019969c0 100644
> --- a/tests/avocado/mem-addr-space-check.py
> +++ b/tests/avocado/mem-addr-space-check.py
> @@ -165,7 +165,7 @@ def test_phybits_low_tcg_q35_70_amd(self):
>           For q35-7.0 machines, "above 4G" memory starts are 4G.
>           pci64_hole size is 32 GiB. Since TCG_PHYS_ADDR_BITS is defined to
>           be 40, TCG emulated CPUs have maximum of 1 TiB (1024 GiB) of
> -        directly addressible memory.
> +        directly addressable memory.
>           Hence, maxmem value at most can be
>           1024 GiB - 4 GiB - 1 GiB per slot for alignment - 32 GiB + 0.5 GiB
>           which is equal to 987.5 GiB. Setting the value to 988 GiB should
> @@ -190,7 +190,7 @@ def test_phybits_low_tcg_q35_71_amd(self):
>           AMD_HT_START is defined to be at 1012 GiB. So for q35 machines
>           version > 7.0 and AMD cpus, instead of 1024 GiB limit for 40 bit
>           processor address space, it has to be 1012 GiB , that is 12 GiB
> -        less than the case above in order to accomodate HT hole.
> +        less than the case above in order to accommodate HT hole.
>           Make sure QEMU fails when maxmem size is 976 GiB (12 GiB less
>           than 988 GiB).
>           """
> @@ -297,7 +297,7 @@ def test_phybits_ok_tcg_q35_71_amd_41bits(self):
>           :avocado: tags=arch:x86_64
>   
>           AMD processor with 41 bits. Max cpu hw address = 2 TiB.
> -        Same as above but by setting maxram beween 976 GiB and 992 Gib,
> +        Same as above but by setting maxram between 976 GiB and 992 Gib,
>           QEMU should start fine.
>           """
>           self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
> diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
> index 4cce5a5598..92855a02a5 100644
> --- a/tests/avocado/reverse_debugging.py
> +++ b/tests/avocado/reverse_debugging.py
> @@ -191,7 +191,7 @@ def reverse_debugging(self, shift=7, args=None):
>           self.check_pc(g, steps[-1])
>           logger.info('successfully reached %x' % steps[-1])
>   
> -        logger.info('exitting gdb and qemu')
> +        logger.info('exiting gdb and qemu')
>           vm.shutdown()
>   
>   class ReverseDebugging_X86_64(ReverseDebugging):


