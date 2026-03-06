Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DD3FCC04F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZAx-0000i1-MT; Fri, 06 Mar 2026 12:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZAt-0000bq-T8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:41:20 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZAq-0005nT-Ro
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:41:19 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so66524155ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772818872; x=1773423672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4FWZ3DbcyQEMGFXXoa/NF9Jfu7Tu+tZcbJ5qkGL8z0o=;
 b=QGQwS4sODD7KSvMQ500Ud6+8lz1TR/PPcUpWmXAerlf4PqW528D20zzrBvr4Xxv5MG
 5aVHPmN0W3fpu/Kpczxa0xcwsJn/YgZxweb/8371fybG+FnjUHmseRXnsPXZjNiATs4H
 FBye+fHn+3DErKUKmnRPvtr4/Ap/f4fbBqbFhvYhLo3ypX71O4BY2tsl9WBH7r5ELTkL
 /b/hdPektMi7CVRYafrLBimLbVVZfabv3gJBvOAWvg7Swcp9rxN7aeApsV0oyImu6n9m
 5sDuq7PEpGGsX9N0jvuTdYwiIeHi2x9et874j4b/19uKWbO1P03XUyTE9I2fwwwVxngf
 xo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818872; x=1773423672;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4FWZ3DbcyQEMGFXXoa/NF9Jfu7Tu+tZcbJ5qkGL8z0o=;
 b=Uj++2MAdoq7xioXgSVg5gd5ijpxfez2wPXVtu9+pX8n0T0FCRe38+ig3LdI3zTzwyF
 ifzRK8X00V4ERM4lMArvyhNKfIu9/xYxBAro9Ik4jMGAACmnrvHpy85NdokoUBU07/mK
 T/o13lRwlR6foThtoyyPIQhzlm+ZsD1uVkQz8/e/8aJQpVCELIGtkJZe0R2rBruGID8o
 nOgHmvbEF7so3Nt0T/o96rU7PRrzBMcWBPBOXnoUzFierCX+PvzKo0j/7Bav1PR6i1wX
 aWHj3/oQidBoYea1GMTWx13PkWEoQ4xfMPxt/t61Iku7itnKpk37S9AwFinc2vXLidjM
 abkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp1y+IWUdmSUQCuqF/V8fpBU+zoTjeuRDK5uYC+sapNbPjTltoMnL/Q/cMrzJAeihz3RFtldiLV6B0@nongnu.org
X-Gm-Message-State: AOJu0YyetayipP92lMEmOqQ4YLzi4nFwntv5+Ncipsx0EesVixRsmtXK
 N12BJKh3yLLaEUZhuTsiW+sA9aeHncpPdpbqCVswXovIK3DV11d7OJY+rQaJ4jygNTI=
X-Gm-Gg: ATEYQzyoIyCuDoEwH0M+r2JiCWDPU3umkSYIo1K8AbD/TlZt6/ViXL+Zxy+hajoUjgm
 enUe//dDPsQWn0zDPvFxI0wICgVWXTcyBE/XfMea3xDu3PoarI5QXxSVr41NhwD3tNG9yudCXJG
 OanD2x6D6IC+OyLAyphQQgqJgE19n6RTfbnMurcebX1hbfaR2bPmoxII0fDqHYzZXKKcGFHEkLa
 s2zdZ9bPmr0b+VL1DjOd8ufWzcXGrfXG12OO04BPjtI5VxSA9WFCc1cYE13kiWdxcdrDuREmcYz
 95ZO50uvvUKFz0oIRL8EFAQzMwOglGdD6+mVtHbtQ+a5bePmDWXnJOiMRDksj8afBCVqz5s7ZeG
 k6vxLwjtXy5Ez/TpXpH8FcISPtjjzra/rNHKCCsdI8SLbNMdJ4xlt2thVtZY+6Uq8YY6gGUdjKj
 MdCD/ljqHj/92qH1aaR9waoWv0rKhWjW9XpbKEkEQQADwWZJQJ2cW2AgHNXcsONZiWHneR
X-Received: by 2002:a17:902:e845:b0:2ae:4f4f:1672 with SMTP id
 d9443c01a7336-2ae75c44e3amr58999515ad.24.1772818871997; 
 Fri, 06 Mar 2026 09:41:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83e78d48sm26982885ad.22.2026.03.06.09.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:41:11 -0800 (PST)
Message-ID: <4aac6bab-7277-41ac-9071-41075b26a56f@linaro.org>
Date: Fri, 6 Mar 2026 09:41:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tests/functional: add VBSA linux tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-8-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260306161728.2657486-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/6/26 8:17 AM, Alex Bennée wrote:
> This extends the VBSA test to run the linux tests. The sysarch-acs
> test suite does provide some pre-built images which is good because
> the tests require a patched kernel. However due to the structure of
> the image we need to jump one or two hoops to get something useful:
> 
>    - download and double decompress (zip then xz) the image
>    - navigate grub to launch the Linux Execution Environment
>    - shutdown the system once tests are done
>    - extract the logs from the MSDOS file system and parse them
> 
> It does make the code a bit ugly but it works for me at least. So far
> the subset of tests run is limited but that might be solved by adding
> some more devices to the PCIe bus to exercise the SMMU behaviour.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/aarch64/test_virt_vbsa.py | 123 +++++++++++++++++++--
>   1 file changed, 112 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_virt_vbsa.py b/tests/functional/aarch64/test_virt_vbsa.py
> index 1dd4cecde1e..0456dfe9fd5 100755
> --- a/tests/functional/aarch64/test_virt_vbsa.py
> +++ b/tests/functional/aarch64/test_virt_vbsa.py
> @@ -10,12 +10,15 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   import shutil
> -from subprocess import check_call, DEVNULL
> +import re
> +from subprocess import check_call, check_output, DEVNULL
>   
>   from qemu_test import QemuSystemTest, Asset
>   from qemu_test import get_qemu_img, skipIfMissingCommands
>   from qemu_test import wait_for_console_pattern
> +from qemu_test import interrupt_interactive_console_until_pattern as int_until
>   from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
> +from qemu_test import send_key
>   
>   
>   @skipIfMissingCommands("mformat", "mcopy", "mmd")
> @@ -28,6 +31,20 @@ def wait_for_console_pattern(self, success_message, vm=None):
>                                    failure_message='FAILED',
>                                    vm=vm)
>   
> +    def append_firmware_blobs(self):
> +        """
> +        Setup QEMU firmware blobs for boot.
> +        """
> +        code_path = self.build_file('pc-bios', 'edk2-aarch64-code.fd')
> +        vars_source = self.build_file('pc-bios', 'edk2-arm-vars.fd')
> +        vars_path = self.scratch_file('vars.fd')
> +        shutil.copy(vars_source, vars_path)
> +
> +        self.vm.add_args('-drive',
> +                         f'if=pflash,format=raw,readonly=on,file={code_path}')
> +        self.vm.add_args('-drive', f'if=pflash,format=raw,file={vars_path}')
> +
> +
>       ASSET_VBSA_EFI = Asset(
>           'https://github.com/ARM-software/sysarch-acs/raw/refs/heads/main'
>           '/prebuilt_images/VBSA/v25.12_VBSA_0.7.0/Vbsa.efi',
> @@ -45,20 +62,12 @@ def test_aarch64_vbsa_uefi_tests(self):
>   
>           self.vm.set_console()
>   
> -        # virt machine wi
> +        # virt machine
>           self.set_machine('virt')
>           self.vm.add_args('-M', 'virt,gic-version=max,virtualization=on')
>           self.vm.add_args('-cpu', 'max', '-m', '1024')
>   
> -        # We will use the QEMU firmware blobs to boot
> -        code_path = self.build_file('pc-bios', 'edk2-aarch64-code.fd')
> -        vars_source = self.build_file('pc-bios', 'edk2-arm-vars.fd')
> -        vars_path = self.scratch_file('vars.fd')
> -        shutil.copy(vars_source, vars_path)
> -
> -        self.vm.add_args('-drive',
> -                         f'if=pflash,format=raw,readonly=on,file={code_path}')
> -        self.vm.add_args('-drive', f'if=pflash,format=raw,file={vars_path}')
> +        self.append_firmware_blobs()
>   
>           # Build an EFI FAT32 file-system for the UEFI tests
>           vbsa_efi = self.ASSET_VBSA_EFI.fetch()
> @@ -102,5 +111,97 @@ def test_aarch64_vbsa_uefi_tests(self):
>           self.wait_for_console_pattern('VBSA tests complete. Reset the system.')
>   
>   
> +    ASSET_SYSREADY_IMAGE = Asset(
> +        'https://github.com/ARM-software/arm-systemready/'
> +        'releases/download/v25.10_SR_3.1.0/systemready_acs_live_image.img.xz.zip',
> +        'df2c359de15784b1da6a8e6f3c98a053ee38ac0b3f241ccea62e17db092eb03a')
> +
> +    ROOT_PROMPT = '/ # '
> +    DOWN_KEY = "\x1b[B"
> +
> +    @skipIfMissingCommands("sfdisk", "jq")
> +    def test_aarch64_vbsa_linux_tests(self):
> +        """
> +        Launch the Linux based VBSA test from the ACS prebuilt images.
> +
> +        We can use the pre-built images and then trigger the Linux
> +        build and run the tests. We then need to slurp the results
> +        from the partition.
> +        """
> +
> +        self.vm.set_console()
> +
> +        # virt machine with SMMU
> +        self.set_machine('virt')
> +        self.vm.add_args('-M', 'virt,gic-version=max,virtualization=on,iommu=smmuv3')
> +        self.vm.add_args('-cpu', 'max', '-m', '1024', '-smp', '4')
> +
> +        self.append_firmware_blobs()
> +
> +        # First fetch, decompress (twice) and prepare the disk image
> +        # on an NVME device (the kernel only has drivers for that).
> +        disk_image_zip = self.ASSET_SYSREADY_IMAGE.fetch()
> +        disk_image_xz = self.uncompress(disk_image_zip,
> +                                        target="sysacs.xz", format="zip")
> +        disk_image = self.uncompress(disk_image_xz,
> +                                     target="sysacs.img", format="xz")
> +
> +        self.vm.add_args('-device',
> +                         'nvme,drive=hd,serial=QEMU_ROOT_SSD')
> +        self.vm.add_args('-blockdev',
> +                         f'driver=raw,node-name=hd,file.driver=file,file.filename={disk_image}')
> +
> +        # Launch QEMU and wait for grub and select the "Linux
> +        # Execution Environment" so we can launch the test.
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Use the ^ and v keys to select which entry is highlighted')
> +
> +        # 3 down arrows then return to select entry
> +        send_key(self, self.DOWN_KEY)
> +        send_key(self, self.DOWN_KEY)
> +        send_key(self, self.DOWN_KEY)
> +

As a suggestion,
Alternatively, is it possible to modify the image to select a different 
kind of command?
I have no idea which bootloader they use, but if it's grub or simply a 
UEFI shell script, it should be quite easy to generate the right entry.

> +        ec_and_wait(self, "\n", self.ROOT_PROMPT)
> +
> +        ec_and_wait(self, "/usr/bin/bsa.sh --skip B_REP_1,B_IEP_1,B_PCIe_11,B_MEM_06",
> +                    self.ROOT_PROMPT)
> +
> +        # Now we can shutdown
> +        ec_and_wait(self, "halt -f", "reboot: System halted")
> +        self.vm.shutdown()
> +
> +        # and extract the test logs
> +        offset = int(check_output(f"sfdisk --json {disk_image} |"
> +                                  "jq '.partitiontable.partitions[0].start * 512'",
> +                                  shell = True))
> +        bsa_app_res = self.scratch_file("BsaResultsApp.log")
> +        bsa_kern_res = self.scratch_file("BsaResultsKernel.log")
> +
> +        check_call(["mcopy", "-i", f"{disk_image}@@{offset}",
> +                    f"::acs_results/Linux/BsaResultsApp.log", bsa_app_res])
> +        check_call(["mcopy", "-i", f"{disk_image}@@{offset}",
> +                    f"::acs_results/Linux/BsaResultsKernel.log", bsa_kern_res])
> +
> +        # for now just check the kernel log for the result summary
> +        test_result_re = re.compile(r"\[.*\]\s+(.+): Result:\s+(\w+)")
> +        summary_re = re.compile(r"Total Tests Run =\s*(\d+), Tests Passed =\s*(\d+), Tests Failed =\s*(\d+)")
> +
> +        with open(bsa_kern_res, 'r') as f:
> +            for line in f:
> +                test_match = test_result_re.search(line)
> +                if test_match:
> +                    desc = test_match.group(1)
> +                    status = test_match.group(2)
> +                    self.log.info(f"Test: {desc} status: {status}")
> +
> +                match = summary_re.search(line)
> +                if match:
> +                    total, passed, failed = match.groups()
> +
> +                    if int(failed) > 0:
> +                        self.fail(f"{failed} tests failed ({total})")
> +
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


