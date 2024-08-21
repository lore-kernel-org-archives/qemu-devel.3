Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ADBC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 09:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sghsb-0006KZ-Ek; Wed, 21 Aug 2024 05:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sghsZ-0006JV-LF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 05:43:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sghsX-0007HU-Ah
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 05:43:47 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bed83487aeso5169543a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724233423; x=1724838223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rJKSIRf2muZng0dT02PjnMW71In31L1/8OaOGL31ck4=;
 b=AhQ/1+zymeVnbbvoG/hU/Gh9e/FNPJHkaiUcTG5/Tvq7WVHE9ZuJ0wAtkhoT8nmQ64
 gIbiIVTzs9vbmovVza6KKzzJKposY9x87sN3y/QTcBUJz1qA4cxjINAA3g1NYU4oStSq
 f/myO/NO6rtEaru1ckg1wCskPm9LjTWwApbDt/iMcQZi6npMgZDvOnYf3kL4DvojKKhY
 P6eqR9jyiYtmQmD9euuG5K6FiQnGG58hNmyV26c/mdMnFiaIBrEJE3QGomN31h2ll2Gv
 xCaSJI0yaco8/BwrGLiz7j/wFnZ/1uobHPO5NEcSdKaza6MAjcfB1K3bv11nGKkWOcrR
 X2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724233423; x=1724838223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJKSIRf2muZng0dT02PjnMW71In31L1/8OaOGL31ck4=;
 b=kaXDGhRhYwSGVZwNhSXyCERSY1VHVHoPl1V4wSl8BvQc38mCcwqmp+vrCahl2d3MIV
 pHHcdHCdlm45+DTh27lJPDG9/HFjIdXRkGHhq/A5232rVfvQDJr0pYm54peMaE7rUxh4
 wxO1ImD/6Rf0od+6wZhECMBxmEbaXfMU2U8FeT8nI8i5cPAaF6re/UrrKp2hDBAR98Xz
 918wMH1Lce+3w/DGZtu3CasmsZK5l8zzMHTdeWQTvOtdRkp26bqtVb247EyQCjiaZg2N
 xWiedHL4jMzB17Egbl7bWCLx8rqeDGbM1YXqbGyX5L07bBoiO5IrG+RC/c8xCchgHfBS
 9R0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBISbjnlAA2IlJ1NkDx7t2l4rFnP/NVhYsDdyx0GqZI77+rBOmLnowFsTUuavF7ohYRi1v4WpRSDEW@nongnu.org
X-Gm-Message-State: AOJu0YwBjtkMR/WNxdLbjwXPlYNDHwuBnpdyo8PCnmvPndAts8z6xURP
 m8/1gPuqWwzsZade4EsqdJmhr6mjAC9LPWR5HeDHtdknrPljeDBqKKt37WBj6S0=
X-Google-Smtp-Source: AGHT+IFodaM0JAiVEiR4g3CwysUMY578+9Asv8C++QZosBeEsvWBFZf35sNpgxOqEB7Oo+/bhwfJvg==
X-Received: by 2002:a17:907:7256:b0:a7a:a30b:7b91 with SMTP id
 a640c23a62f3a-a866f8b3552mr141245766b.64.1724233423132; 
 Wed, 21 Aug 2024 02:43:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cfb74sm878750566b.66.2024.08.21.02.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 02:43:42 -0700 (PDT)
Message-ID: <a0f16778-5ff5-48a3-96ed-8294886274c6@linaro.org>
Date: Wed, 21 Aug 2024 11:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/35] tests/functional: Convert the ppc_hv avocado
 test into a standalone test
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-27-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-27-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 21/8/24 10:27, Thomas Huth wrote:
> A straight forward conversion, we just also have to remove the decorator
> @skipUnless(os.getenv('SPEED')) since all non-trivial functional tests
> are running in SPEED=thorough mode now. Also make sure that the extracted
> assets are writable, so that the test does not fail if it gets re-run
> and there are stale read-only files already around.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  2 +-
>   tests/functional/meson.build                  |  2 +
>   .../test_ppc64_hv.py}                         | 53 ++++++++-----------
>   3 files changed, 25 insertions(+), 32 deletions(-)
>   rename tests/{avocado/ppc_hv_tests.py => functional/test_ppc64_hv.py} (85%)
>   mode change 100644 => 100755
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f01e865025..cca48683ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1532,7 +1532,7 @@ F: tests/qtest/libqos/*spapr*
>   F: tests/qtest/rtas*
>   F: tests/qtest/libqos/rtas*
>   F: tests/functional/test_ppc64_pseries.py
> -F: tests/avocado/ppc_hv_tests.py
> +F: tests/functional/test_ppc64_hv.py
>   
>   PowerNV (Non-Virtualized)
>   M: Cédric Le Goater <clg@kaod.org>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index fba3891e16..f90fb08d6a 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -13,6 +13,7 @@ endif
>   test_timeouts = {
>     'netdev_ethtool' : 180,
>     'ppc_40p' : 240,
> +  'ppc64_hv' : 1000,
>     'ppc64_powernv' : 120,
>     'ppc64_pseries' : 120,
>     's390x_ccw_virtio' : 180,
> @@ -63,6 +64,7 @@ tests_ppc_thorough = [
>   ]
>   
>   tests_ppc64_thorough = [
> +  'ppc64_hv',
>     'ppc64_powernv',
>     'ppc64_pseries',
>   ]
> diff --git a/tests/avocado/ppc_hv_tests.py b/tests/functional/test_ppc64_hv.py
> old mode 100644
> new mode 100755
> similarity index 85%
> rename from tests/avocado/ppc_hv_tests.py
> rename to tests/functional/test_ppc64_hv.py
> index 0e83bbac71..df59667e07
> --- a/tests/avocado/ppc_hv_tests.py
> +++ b/tests/functional/test_ppc64_hv.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Tests that specifically try to exercise hypervisor features of the
>   # target machines. powernv supports the Power hypervisor ISA, and
>   # pseries supports the nested-HV hypervisor spec.
> @@ -7,10 +9,10 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> -from avocado import skipIf, skipUnless
> -from avocado.utils import archive
> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern, exec_command
> +from unittest import skipIf, skipUnless
> +from qemu_test.utils import archive_extract
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern, exec_command
>   import os
>   import time
>   import subprocess
> @@ -45,8 +47,7 @@ def missing_deps():
>   # QEMU already installed and use that.
>   # XXX: The order of these tests seems to matter, see git blame.
>   @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
> -@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
> -@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
> +@skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
>   class HypervisorTest(QemuSystemTest):
>   
>       timeout = 1000
> @@ -54,6 +55,11 @@ class HypervisorTest(QemuSystemTest):
>       panic_message = 'Kernel panic - not syncing'
>       good_message = 'VFS: Cannot open root device'
>   
> +    ASSET_ISO = Asset(
> +        ('https://dl-cdn.alpinelinux.org/alpine/v3.18/'
> +         'releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso'),
> +        'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff')
> +
>       def extract_from_iso(self, iso, path):
>           """
>           Extracts a file from an iso file into the test workdir
> @@ -72,6 +78,7 @@ def extract_from_iso(self, iso, path):
>               subprocess.run(cmd.split(),
>                              stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
>   
> +        os.chmod(filename, 0o600)
>           os.chdir(cwd)
>   
>           # Return complete path to extracted file.  Because callers to
> @@ -83,16 +90,9 @@ def extract_from_iso(self, iso, path):
>       def setUp(self):
>           super().setUp()
>   
> -        iso_url = ('https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso')
> -
> -        # Alpine use sha256 so I recalculated this myself
> -        iso_sha256 = 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff'
> -        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256,
> -                                    algorithm = "sha256")
> -
> -        self.iso_path = iso_path
> -        self.vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
> -        self.initramfs = self.extract_from_iso(iso_path, '/boot/initramfs-lts')
> +        self.iso_path = self.ASSET_ISO.fetch()
> +        self.vmlinuz = self.extract_from_iso(self.iso_path, '/boot/vmlinuz-lts')
> +        self.initramfs = self.extract_from_iso(self.iso_path, '/boot/initramfs-lts')
>   
>       def do_start_alpine(self):
>           self.vm.set_console()

Expanding context:

            kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
            self.vm.add_args("-kernel", self.vmlinuz)
            self.vm.add_args("-initrd", self.initramfs)
            self.vm.add_args("-smp", "4", "-m", "2g")
            self.vm.add_args("-drive", 
f"file={self.iso_path},format=raw,if=none,id=drive0")

Should we use ,media=cdrom here too?


