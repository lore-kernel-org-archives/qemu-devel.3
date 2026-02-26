Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A79FD9E0A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 21:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjAX-0006yH-OK; Thu, 26 Feb 2026 16:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjAT-0006xa-As
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:45:09 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjAR-0005tt-66
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 16:45:09 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2adae92249eso14732955ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 13:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772142306; x=1772747106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5T59l1uCFcM1TUoDt0HfcrA0d9/RsIe0ou+RumORGa4=;
 b=ds3FxkaCzfC2m+H8Q4QS2ioSApfo7XvmAXoKABZqoAdCE9kzuOsLDeAozARQzrrhKq
 M2Y/e3sn0aokQ/DM3ML6RIB7rDl/ZvfA+OrmQf8VHCPOynM82pZTshhm6RykLwtdqKu4
 MsTp58ntunsV/2bQBa6A85nRR79WWRgescY0h61Tc4M59YkmmK8zkwo4zoc7E/GXarg/
 hGhazY5xUETS50kNde40oL8Z/gAgXVc2HWQiFO1pnMYCE5ftprqLpMfyJh42tnUI4QbY
 tQVtJB/NSpw8yND5k0HjTDt/Mu3z9h7r27oxjCVwgHQzVpeDvN8lmRqUldUy3kmWhfS8
 4PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772142306; x=1772747106;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5T59l1uCFcM1TUoDt0HfcrA0d9/RsIe0ou+RumORGa4=;
 b=HtZPXc9LN8u+bxGk7h/Fyw2UjlPwYmoLjPrCm4UHNnWHYVdh2YFWr3RKMd+1o+/4Vd
 NEk+Bu+w0z3zM4RkYDyJZDi9Jf0cvZLdr+nM+F2AdizzbcqZ2jnXUbAMUPQSPYMri4Ra
 P9Oxv3+c9xEoMvXcl7MGwhUysyhXFCdjMCRN30+b+1cvSU2RU+zxPA+v1YWkwPLairaw
 UAaOvXdO5EqUEqoEpAEO6KHwvq5E6GBdy/7NhGDCse6rdzwRUJs/56C19fuvzwMcToW+
 EfeV0UIAug9kO1HTZZ6gUcZrIo0Gxny4EHJvdYM8X4dsq24IgXffdduWN042vve9gGPL
 zPwA==
X-Gm-Message-State: AOJu0YyNEGbYSKXeJj9B9Qmw37cOdC3eyG1THTkXMUDdeNrnnDo8XSO4
 lN6OsD3/aMg2c84zPZbMCt5Eu/oi6sP7b+vfLD21u9ZK09h2fIAsZuqqm94aUUu343g=
X-Gm-Gg: ATEYQzx1C46OKPKM1dx438G3Vg3ZTL1ohj6ZJ2IAVmjVvbCLLAhk5FKJ+7ZQhlV0+Gd
 +kO6Skl7OCXbhPWiEhltLVvDBHNM5+I/9KWnL7MsyYA8Nwz46TyLcZgnAGN9M/lVMPVX8ig0ysg
 4TNjmNsCsmPI74nMjlq0h8arWmJmPNKAN7vFkUPZvySRLKIQA8fwInSIhbtO/4/576KHoMyi/R4
 hGZXQON2iOMZ4j0q482quEf9fIJ7TeLhJAgtamqMqiNeDkBg43XkJmk4mvzRK26lKZ7iCnslCaJ
 cxzlScp14f1Ck5itGIacO0R7JQCxXpOj9LvnmateKapTOwssnDPrGpfaPmknmWOwtQaOCbWgPgu
 Vt1ZQ5M+HmFCE83WGGDHlah+kAuQlV6QcT/jyJq0lEWCxIgmxDsTf6Z0h8zO+aU11v8S4ov52yr
 7acqV70xJCFSb/JZZQAGPsYQIElCWYs2i9f5XAl4T1svgZU9gz0G4KiD+KVYM9HCVWs0UT
X-Received: by 2002:a17:903:478d:b0:2ad:ae4f:345a with SMTP id
 d9443c01a7336-2ae2e47fdddmr3290175ad.36.1772142305505; 
 Thu, 26 Feb 2026 13:45:05 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6f8206sm31196565ad.90.2026.02.26.13.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 13:45:05 -0800 (PST)
Message-ID: <1bf211c0-84f4-47a7-b4a3-6308f1a4c9fd@linaro.org>
Date: Thu, 26 Feb 2026 13:45:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] tests/functional: add Arm VBSA uefi conformance
 test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>
References: <20260226185303.1920021-1-alex.bennee@linaro.org>
 <20260226185303.1920021-8-alex.bennee@linaro.org>
 <a42315f0-e84b-46b3-9fac-299f9894de16@linaro.org>
 <87y0kfxmd2.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87y0kfxmd2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/26/26 12:48 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 2/26/26 10:53 AM, Alex Bennée wrote:
>>> The VBSA test is a subset of the wider Arm architecture compliance
>>> suites (ACS) which validate machines meet particular minimum set of
>>> requirements. The VBSA is for virtual machines so it makes sense we
>>> should check the -M virt machine is compliant.
>>> Fortunately there are prebuilt binaries published via github so all
>>> we
>>> need to do is build an EFI partition and place things in the right
>>> place.
>>> There are some additional Linux based tests which are left for
>>> later.
>>> Message-ID: <20260213154859.1551283-7-alex.bennee@linaro.org>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>> v2
>>>     - use the VBSA prebuilt shell
>>>     - fail the test if we see FAILED in the console stream
>>> ---
>>>    tests/functional/aarch64/meson.build       |  1 +
>>>    tests/functional/aarch64/test_virt_vbsa.py | 99 ++++++++++++++++++++++
>>>    2 files changed, 100 insertions(+)
>>>    create mode 100755 tests/functional/aarch64/test_virt_vbsa.py
>>> diff --git a/tests/functional/aarch64/meson.build
>>> b/tests/functional/aarch64/meson.build
>>> index 49eca120589..7ea8c22b048 100644
>>> --- a/tests/functional/aarch64/meson.build
>>> +++ b/tests/functional/aarch64/meson.build
>>> @@ -46,6 +46,7 @@ tests_aarch64_system_thorough = [
>>>      'tuxrun',
>>>      'virt',
>>>      'virt_gpu',
>>> +  'virt_vbsa',
>>>      'xen',
>>>      'xlnx_versal',
>>>    ]
>>> diff --git a/tests/functional/aarch64/test_virt_vbsa.py b/tests/functional/aarch64/test_virt_vbsa.py
>>> new file mode 100755
>>> index 00000000000..3da06904ea9
>>> --- /dev/null
>>> +++ b/tests/functional/aarch64/test_virt_vbsa.py
>>> @@ -0,0 +1,99 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Functional test that runs the Arm VBSA conformance tests.
>>> +#
>>> +# Copyright (c) 2026 Linaro Ltd.
>>> +#
>>> +# Author:
>>> +#  Alex Bennée <alex.bennee@linaro.org>
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +import shutil
>>> +from subprocess import check_call, DEVNULL
>>> +
>>> +from qemu_test import QemuSystemTest, Asset
>>> +from qemu_test import wait_for_console_pattern, get_qemu_img, skipIfMissingCommands
>>> +from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
>>> +
>>> +
>>> +@skipIfMissingCommands("mformat", "mcopy", "mmd")
>>> +class Aarch64VirtMachine(QemuSystemTest):
>>> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>>> +    timeout = 360
>>> +
>>> +    def wait_for_console_pattern(self, success_message, vm=None):
>>> +        wait_for_console_pattern(self, success_message,
>>> +                                 failure_message='FAILED',
>>> +                                 vm=vm)
>>> +
>>> +    ASSET_VBSA_EFI = Asset('https://github.com/ARM-software/sysarch-acs/raw/refs/heads/main'
>>> +                           '/prebuilt_images/VBSA/v25.12_VBSA_0.7.0/Vbsa.efi',
>>> +                           '80f37d2fb86d152d95dec4d05ff099c9e47ee8a89314268e08056b0e1359e1fa')
>>> +
>>> +    ASSET_BSA_SHELL = Asset('https://github.com/ARM-software/sysarch-acs/raw/refs/heads/main'
>>> +                            '/prebuilt_images/VBSA/v25.12_VBSA_0.7.0/Shell.efi',
>>> +                            'e526604f0d329b481c6a1f62f7a0db8ea24ce8178b2c6abda8e247425f38775c')
>>> +
>>> +    def test_aarch64_vbsa_uefi_tests(self):
>>> +        """
>>> +        Launch the UEFI based VBSA test from an EFI file-system
>>> +        """
>>> +
>>> +        self.vm.set_console()
>>> +
>>> +        # virt machine wi
>>> +        self.set_machine('virt')
>>> +        self.vm.add_args('-M', 'virt,gic-version=max,virtualization=on')
>>> +        self.vm.add_args('-cpu', 'max','-m', '1024')
>>> +
>>> +        # We will use the QEMU firmware blobs to boot
>>> +        code_path = self.build_file('pc-bios', 'edk2-aarch64-code.fd')
>>> +        vars_source = self.build_file('pc-bios', 'edk2-arm-vars.fd')
>>> +        vars_path = self.scratch_file('vars.fd')
>>> +        shutil.copy(vars_source, vars_path)
>>> +
>>> +        self.vm.add_args('-drive', f'if=pflash,format=raw,readonly=on,file={code_path}')
>>> +        self.vm.add_args('-drive', f'if=pflash,format=raw,file={vars_path}')
>>> +
>>> +        # Build an EFI FAT32 file-system for the UEFI tests
>>> +        vbsa_efi = self.ASSET_VBSA_EFI.fetch()
>>> +        bsa_shell = self.ASSET_BSA_SHELL.fetch()
>>> +
>>> +        img_path = self.scratch_file('vbsa.img')
>>> +        qemu_img = get_qemu_img(self)
>>> +        check_call([qemu_img, 'create', '-f', 'raw', img_path, '64M'],
>>> +                   stdout=DEVNULL, stderr=DEVNULL)
>>> +
>>> +        check_call(['mformat', '-i', img_path, '-v', 'VBSA', '::'],
>>> +                   stdout=DEVNULL, stderr=DEVNULL)
>>> +
>>> +        check_call(['mmd', '-i', img_path, '::/EFI'],
>>> +                   stdout=DEVNULL, stderr=DEVNULL)
>>> +
>>> +        check_call(['mmd', '-i', img_path, '::/EFI/BOOT'],
>>> +                   stdout=DEVNULL, stderr=DEVNULL)
>>> +
>>> +        check_call(['mcopy', '-i', img_path, bsa_shell, '::/EFI/BOOT/BOOTAA64.EFI'],
>>> +                   stdout=DEVNULL, stderr=DEVNULL)
>>> +
>>> +        check_call(['mcopy', '-i', img_path, vbsa_efi, '::/Vbsa.efi'],
>>> +                   stdout=DEVNULL, stderr=DEVNULL)
>>> +
>>> +        self.vm.add_args('-drive', f'file={img_path},format=raw,if=none,id=drive0')
>>> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=drive0')
>>> +
>>> +        self.vm.launch()
>>> +
>>> +        # wait for EFI prompt
>>> +        self.wait_for_console_pattern('Shell>')
>>> +
>>> +        # Start the VBSA tests
>>> +        ec_and_wait(self, "FS0:Vbsa.efi", 'VBSA Architecture Compliance Suite')
>>> +
>>> +        # could we parse the summary somehow?
>>> +
>>> +        self.wait_for_console_pattern('VBSA tests complete. Reset the system.')
>>> +
>>
>> Same comment than on v1:
>> https://lore.kernel.org/qemu-devel/5befbd0e-5f0f-41c4-99a7-1cf17bfe5454@linaro.org/
>>
>> In case a failing output would not contain any string easy to
>> identify, I'm fine with current patch, but since I didn't receive any
>> answer on previous series, I'm not sure if it has been tried.
> 
> That's why I added the FAILED catch.
>

Oh right. Sorry I missed you overloaded the method at the top.

>>
>> Regards,
>> Pierrick
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


