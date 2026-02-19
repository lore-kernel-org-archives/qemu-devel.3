Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1AFE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Qi-0002fd-ML; Thu, 19 Feb 2026 05:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt1QQ-00028W-3K
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:38:26 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt1QN-0006hG-6K
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:38:24 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8fbe5719ceso168240266b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497501; x=1772102301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chsomSTiq2DFQ8k7peJmKeu4OQisuVdcYciTd1yL4pM=;
 b=yPpuc0jZ0AePyUfTCqtdHtL8eu3ZxYHFjQ8YCj3QGHfnAkW9SmhrD3GFDTXsj9okmw
 LJQKKvatzTV59f3aad4xr7xE0nbKECq/4tAbqaVdBc8DFKdM8o7y4LYaUbLScJQIzpJt
 WqvL9ET/k0eJWTzLOYKOBHe4Bwdz5IFJd9nZ8FqVTgvY5qm/g0rxTEFYafTEVKHdxdFu
 i9FUzKeRyLJnDd4XXvuXVDlNIys50y8IsbyKZRzqrbKWy0AEX8EAIHO79oy3+k7jhT1W
 reqibNGNVsuWcw8vph+Jlj9kzKy6Yd/LhF76IxOlhMC0WP5koMSDPbS6vvl0Eb5etueh
 jX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497501; x=1772102301;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=chsomSTiq2DFQ8k7peJmKeu4OQisuVdcYciTd1yL4pM=;
 b=uP/O35ZoFzntP58ONcPDbQpm5UOtGpWJzXQ8+YCTA5FXaaaZ6h1HD20U8axrARRElX
 0gM81drKzefuNRxNZ46JnUV5FKY38rBY48c8FY89VkiWM9kreAFS2Idz6uEYwG7G2wso
 EREvXAiP8OFWfC1AfBm6lTa41u7r0ghGColJLYG7+5vNk01TkJnDM/arn9yg7CTsVVqh
 8SA112fUQ9gB/+lJFIjureLy60SiYoEgTw7EXvLvSjUtQES7RZ04i+0wDhgRDQ8efwr5
 ZjOml8A12JNxyNhKRqQ/19PChkh/zbrz6q3fBClR/dE6zM3Lr5u+QlBKYukZhv8LWOuV
 lkYA==
X-Gm-Message-State: AOJu0YxVag9DAyL2MykhL5NrKG34I49RNcA7ROqytTsjwjfUrPA6Ahtz
 l7rGKs4RdG/268RcybvxI8fLdLSVCQ03lIfxIPECBtYnRB4EzXuPr6W3OavlNAl/IfbTzDiUl67
 gK1J4
X-Gm-Gg: AZuq6aKNNOo0DHw/+TkJD8zDd1SDe/jReq9gvrABYsLbsEg1m5ZFmCCvvNZIG5FW18L
 UaZBupJVcMso0fFWLN3pf4g7+nZYP9rwYjybkcQe8qzOIEYADXidiX3jtsbYqf/RUDcRG1JPcK1
 k/oIlvVzVC4fGBVRDihKL8LYvC+41jWXqSwsyAsfNvwl03yDea7WxmHP/c92Vhsc1PG4uGGc6SH
 NinxIzJ7QVeg028+8S3f6k/NO159AXJeCD+qdjgJpRf3GiuA/zxAHpWEAdXZQ1njGqG5EJdwUdZ
 JdmelKmrQhHkIDg+6ff4p1kSHiaoFpnN9iZi6usC9/AfaaktbNaNKC79knSWD2sfy/lRMs8+fmp
 toUolUsWXpqz6qOqcpiKSE3rr6vlsGZZoC6gI0snboYHn8T/EpE2P7o7afLMMjuLInLMk4qUxZ0
 VS/HsLcp4V6Q3sCgzFi0F+OF8=
X-Received: by 2002:a17:906:eec9:b0:b83:95c8:15d0 with SMTP id
 a640c23a62f3a-b904dea764bmr141004466b.52.1771497500874; 
 Thu, 19 Feb 2026 02:38:20 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad19bfd3sm3860538a12.2.2026.02.19.02.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:38:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 108FB5F805;
 Thu, 19 Feb 2026 10:38:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Brad Smith <brad@comstyle.com>,  Warner Losh
 <imp@bsdimp.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Kyle Evans <kevans@freebsd.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 6/6] tests/functional: add Arm VBSA uefi conformance test
In-Reply-To: <82942191-d0a6-4393-846d-b04e3cb009ce@linaro.org> (Pierrick
 Bouvier's message of "Fri, 13 Feb 2026 10:49:20 -0800")
References: <20260213154859.1551283-1-alex.bennee@linaro.org>
 <20260213154859.1551283-7-alex.bennee@linaro.org>
 <82942191-d0a6-4393-846d-b04e3cb009ce@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 19 Feb 2026 10:38:15 +0000
Message-ID: <87o6ll6mso.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 2/13/26 7:48 AM, Alex Benn=C3=A9e wrote:
>> The VBSA test is a subset of the wider Arm architecture compliance
>> suites (ACS) which validate machines meet particular minimum set of
>> requirements. The VBSA is for virtual machines so it makes sense we
>> should check the -M virt machine is compliant.
>> Fortunately there are prebuilt binaries published via github so all
>> we
>> need to do is build an EFI partition and place things in the right
>> place.
>> There are some additional Linux based tests which are left for
>> later.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/functional/aarch64/meson.build       |  1 +
>>   tests/functional/aarch64/test_virt_vbsa.py | 99 ++++++++++++++++++++++
>>   2 files changed, 100 insertions(+)
>>   create mode 100755 tests/functional/aarch64/test_virt_vbsa.py
>> diff --git a/tests/functional/aarch64/meson.build
>> b/tests/functional/aarch64/meson.build
>> index 49eca120589..7ea8c22b048 100644
>> --- a/tests/functional/aarch64/meson.build
>> +++ b/tests/functional/aarch64/meson.build
>> @@ -46,6 +46,7 @@ tests_aarch64_system_thorough =3D [
>>     'tuxrun',
>>     'virt',
>>     'virt_gpu',
>> +  'virt_vbsa',
>>     'xen',
>>     'xlnx_versal',
>>   ]
>> diff --git a/tests/functional/aarch64/test_virt_vbsa.py b/tests/function=
al/aarch64/test_virt_vbsa.py
>> new file mode 100755
>> index 00000000000..53cabf9d6c5
>> --- /dev/null
>> +++ b/tests/functional/aarch64/test_virt_vbsa.py
>> @@ -0,0 +1,99 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that runs the Arm VBSA conformance tests.
>> +#
>> +# Copyright (c) 2026 Linaro Ltd.
>> +#
>> +# Author:
>> +#  Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import shutil
>> +from subprocess import check_call, DEVNULL
>> +
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern, get_qemu_img, skipIfMis=
singCommands
>> +from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
>> +
>> +
>> +@skipIfMissingCommands("mformat", "mcopy", "mmd")
>> +class Aarch64VirtMachine(QemuSystemTest):
>> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>> +    timeout =3D 360
>> +
>> +    def wait_for_console_pattern(self, success_message, vm=3DNone):
>> +        wait_for_console_pattern(self, success_message,
>> +                                 failure_message=3D'Kernel panic - not =
syncing',
>> +                                 vm=3Dvm)
>> +
>
> May be worth adding a comment with README url:
> https://github.com/ARM-software/sysarch-acs/blob/main/docs/vbsa/README.md
>
>> +    ASSET_VBSA_EFI =3D Asset('https://github.com/ARM-software/sysarch-a=
cs/raw/refs/heads/main'
>> +                           '/prebuilt_images/VBSA/v25.12_VBSA_0.7.0/Vbs=
a.efi',
>> +                           '80f37d2fb86d152d95dec4d05ff099c9e47ee8a8931=
4268e08056b0e1359e1fa')
>> +
>> +    ASSET_BSA_SHELL =3D Asset('https://github.com/ARM-software/bsa-acs/=
raw/refs/heads/main/'
>> +                            'prebuilt_images/BSA_DT/v20.05_05_ALPHA/She=
ll.efi',
>> +                            '763e7b293fa9d1582153ea8fd0cf60e2a7a87d092d=
35d342cf9b3b697f47b588')
>> +
>> +    def test_aarch64_vbsa_uefi_tests(self):
>> +        """
>> +        Launch the UEFI based VBSA test from an EFI file-system
>> +        """
>> +
>> +        self.vm.set_console()
>> +
>> +        # virt machine wi
>> +        self.set_machine('virt')
>> +        self.vm.add_args('-M', 'virt,gic-version=3Dmax,virtualization=
=3Don')
>> +        self.vm.add_args('-cpu', 'max','-m', '1024')
>> +
>> +        # We will use the QEMU firmware blobs to boot
>> +        code_path =3D self.build_file('pc-bios', 'edk2-aarch64-code.fd')
>> +        vars_source =3D self.build_file('pc-bios', 'edk2-arm-vars.fd')
>> +        vars_path =3D self.scratch_file('vars.fd')
>> +        shutil.copy(vars_source, vars_path)
>> +
>> +        self.vm.add_args('-drive', f'if=3Dpflash,format=3Draw,readonly=
=3Don,file=3D{code_path}')
>> +        self.vm.add_args('-drive', f'if=3Dpflash,format=3Draw,file=3D{v=
ars_path}')
>> +
>> +        # Build an EFI FAT32 file-system for the UEFI tests
>> +        vbsa_efi =3D self.ASSET_VBSA_EFI.fetch()
>> +        bsa_shell =3D self.ASSET_BSA_SHELL.fetch()
>> +
>> +        img_path =3D self.scratch_file('vbsa.img')
>> +        qemu_img =3D get_qemu_img(self)
>> +        check_call([qemu_img, 'create', '-f', 'raw', img_path, '64M'],
>> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
>> +
>> +        check_call(['mformat', '-i', img_path, '-v', 'VBSA', '::'],
>> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
>> +
>> +        check_call(['mmd', '-i', img_path, '::/EFI'],
>> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
>> +
>> +        check_call(['mmd', '-i', img_path, '::/EFI/BOOT'],
>> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
>> +
>> +        check_call(['mcopy', '-i', img_path, bsa_shell, '::/EFI/BOOT/BO=
OTAA64.EFI'],
>> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
>> +
>> +        check_call(['mcopy', '-i', img_path, vbsa_efi, '::/Vbsa.efi'],
>> +                   stdout=3DDEVNULL, stderr=3DDEVNULL)
>> +
>> +        self.vm.add_args('-drive', f'file=3D{img_path},format=3Draw,if=
=3Dnone,id=3Ddrive0')
>> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=3Ddrive0')
>> +
>> +        self.vm.launch()
>> +
>> +        # wait for EFI prompt
>> +        self.wait_for_console_pattern('Shell>')
>> +
>> +        # Start the VBSA tests
>> +        ec_and_wait(self, "FS0:Vbsa.efi", 'VBSA Architecture Compliance=
 Suite')
>> +
>> +        # could we parse the summary somehow?
>> +
>> +        self.wait_for_console_pattern('VBSA tests complete. Reset the s=
ystem.')
>> +
>
> What happens in case there is an error, does the test app hangs, or
> still exit with message under?

The failures I had were generally hangs but ideally we would parse the
the summary data and generate our response based on that. Unfortunately
that is at odds with the current send/wait for pass/fail message
infrastructure.

>
> If it always exit with this message, whether we have an error or not,
> then the test is not really checking anything.
>
>> +if __name__ =3D=3D '__main__':
>> +    QemuSystemTest.main()

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

