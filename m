Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A79BC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 13:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shUAL-0001K1-0e; Fri, 23 Aug 2024 09:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shUAJ-0001CR-GB
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:17:19 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shUAG-0000mZ-SY
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:17:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so16118135e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724419034; x=1725023834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SRypCJq1XkFH5+MsoPVssgeR9U7Ntsjwzpu9U8OmIFU=;
 b=RBgmymWtci7y98WCCliqYqUsgf6yWfsybBhX0gppJ9lQtVZyDGhOwMiqu6HYzKILsH
 +xrJGwdFqcXsI7BkwKXx6fWjUGAtdhPQKbgq25wLCQSt8NAo46neVztGPeXc50ClohCQ
 1IcpbNKLnpyKvTX4tumRj8HoDAVUM7f/mMuoOqkbF1X/2Yb5wiMzTUmKAFVJdPKzRtTm
 7EHOy0mhPBFeDUFh6O9ccGP30ib7mSe+laj2PSHY1blA95vYL0lsvD7Ce9kiz4rAY4Hf
 jNRTdVzD1KDHK7XGx3EG0SOR4Wih0fpPtrl2ZPcCsLJyulDQ/H1El2tWkVKYoruh/TuW
 Vujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724419034; x=1725023834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SRypCJq1XkFH5+MsoPVssgeR9U7Ntsjwzpu9U8OmIFU=;
 b=D3kztBRsSUAmSpnhi8mGsF7w4PgIQOt4WKXxBCJTREA/+S+aKBLnjXEkJeJ7cFgXKC
 CIwQVtWx98tiH078e6TRiKaY+pIppTPETMnoYUup2y3gwDOXN00wiJ9nTeAiCBVQrETC
 dtUF2OhYfTzRV7lmAp7lHMjHRHHqleRciAUm77V+SuMhRZgqOJFgwIO7xTn7qeauLU9m
 WD12/+Y0iCc79kx8BqrYeGM+xNwcBxyLRI01v7KJjkrnRBuY9KRtVxpR857PtbBlRyqn
 mCjY7aetQH/GaM/Zz1SDT58uDtI5Qz2n7h+u9XNwf0HYfJB1+8uLLitk2en3ec7TJbjF
 W44w==
X-Gm-Message-State: AOJu0YwPhKDshs0wM892d9xGKFsTkSSFvcHucxc8o+AWNYCUZeC7oGue
 q0y4t1CY/E3hc2IMU7jAZfDfmUUyBMzIOdufhs+XN6JXwJTaDBPPOUwoIHAB/NFi4S7mk12W5OB
 q
X-Google-Smtp-Source: AGHT+IE0lwlTZj3gRHsCZqi1dVsI7ttdo+ysnsTnNi54v6yQqgSwB0qyILxE6oD1hqoB0eqB88nb/g==
X-Received: by 2002:a05:600c:c07:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-42acc9fda29mr19874645e9.29.1724419033678; 
 Fri, 23 Aug 2024 06:17:13 -0700 (PDT)
Received: from [192.168.69.100] (plb95-h02-176-184-14-228.dsl.sta.abo.bbox.fr.
 [176.184.14.228]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730810ff96sm4142793f8f.14.2024.08.23.06.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 06:17:13 -0700 (PDT)
Message-ID: <6b2fa1d3-84af-4f94-a495-8c631c4bc392@linaro.org>
Date: Fri, 23 Aug 2024 15:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Thomas Huth <thuth@redhat.com>
References: <20240823131614.10269-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240823131614.10269-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/8/24 15:16, Philippe Mathieu-Daudé wrote:
> Straight forward conversion. Since SBSA_FLASH files are not
> tarballs, use lzma_uncompress() method.
> 
> Avocado used to set a timeout of 11 tests * 180s = 1980s.
> Hopefully 600s should be sufficient.
> 
> Running on macOS Sonoma / Apple silicon M1:
> 
>    $ QEMU_TEST_TIMEOUT_EXPECTED=1 make check-functional-aarch64 V=1
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max              OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_off    OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_neoverse_n1      OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_edk2_firmware                 OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_cortex_a57          OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max                 OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_impdef    OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_off       OK
>    ▶ 1/5 test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_neoverse_n1         OK
>    1/5 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_sbsaref        OK   241.79s  11 subtests passed
>    ...
> 

Forgot from v2:
Reviewed-by: Thomas Huth <thuth@redhat.com>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20240821082748.65853-1-thuth@redhat.com>
> 
> v3:
> - Fix ASSET_FLASH1 typo (Marcin)
> - Tune timeout (Marcin)
> ---
>   MAINTAINERS                                   |   2 +-
>   tests/functional/meson.build                  |   5 +
>   .../test_aarch64_sbsaref.py}                  | 144 ++++++------------
>   3 files changed, 55 insertions(+), 96 deletions(-)
>   rename tests/{avocado/machine_aarch64_sbsaref.py => functional/test_aarch64_sbsaref.py} (56%)
>   mode change 100644 => 100755
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91e5b061bf..c720c02800 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -971,7 +971,7 @@ F: hw/misc/sbsa_ec.c
>   F: hw/watchdog/sbsa_gwdt.c
>   F: include/hw/watchdog/sbsa_gwdt.h
>   F: docs/system/arm/sbsa.rst
> -F: tests/avocado/machine_aarch64_sbsaref.py
> +F: tests/functional/test_aarch64_sbsaref.py
>   
>   Sharp SL-5500 (Collie) PDA
>   M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index f1fce045fc..3ab29c0f35 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -11,6 +11,7 @@ endif
>   
>   # Timeouts for individual tests that can be slow e.g. with debugging enabled
>   test_timeouts = {
> +  'aarch64_sbsaref' : 600,
>     'acpi_bits' : 240,
>     'netdev_ethtool' : 180,
>     'ppc_40p' : 240,
> @@ -26,6 +27,10 @@ tests_generic = [
>     'version',
>   ]
>   
> +tests_aarch64_thorough = [
> +  'aarch64_sbsaref',
> +]
> +
>   tests_arm_thorough = [
>     'arm_canona1100',
>     'arm_integratorcp',
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
> old mode 100644
> new mode 100755
> similarity index 56%
> rename from tests/avocado/machine_aarch64_sbsaref.py
> rename to tests/functional/test_aarch64_sbsaref.py
> index f8bf40c192..e90566cdb8
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/functional/test_aarch64_sbsaref.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Functional test that boots a Linux kernel and checks the console
>   #
>   # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
> @@ -8,12 +10,11 @@
>   
>   import os
>   
> -from avocado import skipUnless
> -from avocado.utils import archive
> -
> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern
> -from avocado_qemu import interrupt_interactive_console_until_pattern
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import interrupt_interactive_console_until_pattern
> +from qemu_test.utils import lzma_uncompress
> +from unittest import skipUnless
>   
>   
>   class Aarch64SbsarefMachine(QemuSystemTest):
> @@ -28,6 +29,16 @@ class Aarch64SbsarefMachine(QemuSystemTest):
>   
>       timeout = 180
>   
> +    ASSET_FLASH0 = Asset(
> +        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
> +         '20240619-148232/edk2/SBSA_FLASH0.fd.xz'),
> +        '0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7')
> +
> +    ASSET_FLASH1 = Asset(
> +        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
> +         '20240619-148232/edk2/SBSA_FLASH1.fd.xz'),
> +        'c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee')
> +
>       def fetch_firmware(self):
>           """
>           Flash volumes generated using:
> @@ -44,47 +55,31 @@ def fetch_firmware(self):
>           """
>   
>           # Secure BootRom (TF-A code)
> -        fs0_xz_url = (
> -            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
> -        )
> -        fs0_xz_hash = "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
> -        tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
> -                                      algorithm='sha256')
> -        archive.extract(tar_xz_path, self.workdir)
> +        fs0_xz_path = self.ASSET_FLASH0.fetch()
>           fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
> +        lzma_uncompress(fs0_xz_path, fs0_path)
>   
>           # Non-secure rom (UEFI and EFI variables)
> -        fs1_xz_url = (
> -            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
> -            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
> -        )
> -        fs1_xz_hash = "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
> -        tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
> -                                      algorithm='sha256')
> -        archive.extract(tar_xz_path, self.workdir)
> +        fs1_xz_path = self.ASSET_FLASH1.fetch()
>           fs1_path = os.path.join(self.workdir, "SBSA_FLASH1.fd")
> +        lzma_uncompress(fs1_xz_path, fs1_path)
>   
>           for path in [fs0_path, fs1_path]:
>               with open(path, "ab+") as fd:
>                   fd.truncate(256 << 20)  # Expand volumes to 256MiB
>   
> +        self.set_machine('sbsa-ref')
>           self.vm.set_console()
>           self.vm.add_args(
> -            "-drive",
> -            f"if=pflash,file={fs0_path},format=raw",
> -            "-drive",
> -            f"if=pflash,file={fs1_path},format=raw",
> -            "-machine",
> -            "sbsa-ref",
> +            "-drive", f"if=pflash,file={fs0_path},format=raw",
> +            "-drive", f"if=pflash,file={fs1_path},format=raw",
>           )
>   
>       def test_sbsaref_edk2_firmware(self):
> -        """
> -        :avocado: tags=cpu:cortex-a57
> -        """
>   
>           self.fetch_firmware()
> +
> +        self.vm.add_args('-cpu', 'cortex-a57')
>           self.vm.launch()
>   
>           # TF-A boot sequence:
> @@ -110,87 +105,62 @@ def test_sbsaref_edk2_firmware(self):
>           wait_for_console_pattern(self, "UEFI firmware (version 1.0")
>           interrupt_interactive_console_until_pattern(self, "QEMU SBSA-REF Machine")
>   
> +
> +    ASSET_ALPINE_ISO = Asset(
> +        ('https://dl-cdn.alpinelinux.org/'
> +         'alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso'),
> +        '5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027')
> +
>       # This tests the whole boot chain from EFI to Userspace
>       # We only boot a whole OS for the current top level CPU and GIC
>       # Other test profiles should use more minimal boots
>       def boot_alpine_linux(self, cpu):
>           self.fetch_firmware()
>   
> -        iso_url = (
> -            "https://dl-cdn.alpinelinux.org/"
> -            "alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso"
> -        )
> -
> -        iso_hash = "5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027"
> -        iso_path = self.fetch_asset(iso_url, algorithm="sha256", asset_hash=iso_hash)
> +        iso_path = self.ASSET_ALPINE_ISO.fetch()
>   
>           self.vm.set_console()
>           self.vm.add_args(
> -            "-cpu",
> -            cpu,
> -            "-drive",
> -            f"file={iso_path},media=cdrom,format=raw",
> +            "-cpu", cpu,
> +            "-drive", f"file={iso_path},media=cdrom,format=raw",
>           )
>   
>           self.vm.launch()
>           wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
>   
>       def test_sbsaref_alpine_linux_cortex_a57(self):
> -        """
> -        :avocado: tags=cpu:cortex-a57
> -        :avocado: tags=os:linux
> -        """
>           self.boot_alpine_linux("cortex-a57")
>   
>       def test_sbsaref_alpine_linux_neoverse_n1(self):
> -        """
> -        :avocado: tags=cpu:neoverse-n1
> -        :avocado: tags=os:linux
> -        """
>           self.boot_alpine_linux("neoverse-n1")
>   
>       def test_sbsaref_alpine_linux_max_pauth_off(self):
> -        """
> -        :avocado: tags=cpu:max
> -        :avocado: tags=os:linux
> -        """
>           self.boot_alpine_linux("max,pauth=off")
>   
>       def test_sbsaref_alpine_linux_max_pauth_impdef(self):
> -        """
> -        :avocado: tags=cpu:max
> -        :avocado: tags=os:linux
> -        """
>           self.boot_alpine_linux("max,pauth-impdef=on")
>   
> -    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> +    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
>       def test_sbsaref_alpine_linux_max(self):
> -        """
> -        :avocado: tags=cpu:max
> -        :avocado: tags=os:linux
> -        """
>           self.boot_alpine_linux("max")
>   
>   
> +    ASSET_OPENBSD_ISO = Asset(
> +        ('https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img'),
> +        '7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5')
> +
>       # This tests the whole boot chain from EFI to Userspace
>       # We only boot a whole OS for the current top level CPU and GIC
>       # Other test profiles should use more minimal boots
>       def boot_openbsd73(self, cpu):
>           self.fetch_firmware()
>   
> -        img_url = (
> -            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
> -        )
> -
> -        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
> -        img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
> +        img_path = self.ASSET_OPENBSD_ISO.fetch()
>   
>           self.vm.set_console()
>           self.vm.add_args(
> -            "-cpu",
> -            cpu,
> -            "-drive",
> -            f"file={img_path},format=raw,snapshot=on",
> +            "-cpu", cpu,
> +            "-drive", f"file={img_path},format=raw,snapshot=on",
>           )
>   
>           self.vm.launch()
> @@ -199,38 +169,22 @@ def boot_openbsd73(self, cpu):
>                                    " 7.3 installation program.")
>   
>       def test_sbsaref_openbsd73_cortex_a57(self):
> -        """
> -        :avocado: tags=cpu:cortex-a57
> -        :avocado: tags=os:openbsd
> -        """
>           self.boot_openbsd73("cortex-a57")
>   
>       def test_sbsaref_openbsd73_neoverse_n1(self):
> -        """
> -        :avocado: tags=cpu:neoverse-n1
> -        :avocado: tags=os:openbsd
> -        """
>           self.boot_openbsd73("neoverse-n1")
>   
>       def test_sbsaref_openbsd73_max_pauth_off(self):
> -        """
> -        :avocado: tags=cpu:max
> -        :avocado: tags=os:openbsd
> -        """
>           self.boot_openbsd73("max,pauth=off")
>   
> -    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> +    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
>       def test_sbsaref_openbsd73_max_pauth_impdef(self):
> -        """
> -        :avocado: tags=cpu:max
> -        :avocado: tags=os:openbsd
> -        """
>           self.boot_openbsd73("max,pauth-impdef=on")
>   
> -    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
> +    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
>       def test_sbsaref_openbsd73_max(self):
> -        """
> -        :avocado: tags=cpu:max
> -        :avocado: tags=os:openbsd
> -        """
>           self.boot_openbsd73("max")
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()


