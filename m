Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249D1C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkkVE-000883-KA; Wed, 19 Feb 2025 08:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkkVB-00087f-A3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:52:38 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkkV9-0005ZT-3c
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:52:37 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe84so2382048f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 05:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739973153; x=1740577953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ky0FqEXk3PNMyggSwD0aEVfPAYskpZSffK5UlDh1w10=;
 b=fZcMc8ZbCMGz8KM18hOIwENvGxHgqp465UBN44vfNwQoixGBVBdPEcKbItsarYzgAP
 o3wuYXgQV1GWNcrxI7TmXHAbIJOmM++PeGtpw/W0P2bNncJH9mrL7n3SQiajz72fgX3u
 7b8RVDvXwz/yvCeBbyEnLKEm7iwqkJJVYcLisUigkE8J+x4a0sDAYKfEbkVxK4EPHUQo
 hVFNXSXceY8C+JomII7KbrcV94XeaC5njOOs61X583Yovc/9f8BMMGnEZ0wu8EckDXNS
 pqax9Nu/KUB9smGPFdNm2WIVMUD3Mno/1EieU9pCLd+M4G5kzLJpsw92KeP6XWuKdeqB
 Y86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739973153; x=1740577953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ky0FqEXk3PNMyggSwD0aEVfPAYskpZSffK5UlDh1w10=;
 b=fW+mKG+MBnvTjU+bNNXvxy6yHb3U+SYBenjtA6B6PSzAAJXJUullz7JPYbhhyEuDpT
 llmiR99MdYt+mt+tIeTBBOjW6IJANihN3s7h4lRYeVFAEqAiHrSlCin7E8ri9Kj2QULy
 gRsfLQw1Zqs1P9/9ZB8IxhdENZh4jdUSNSFUcHIoZluhtpNwOVsF2fJwnyBb8Fh/Oez5
 LJgdhLJAk+zvximmskJwVuFsZk3J04O2vY2TbeNdGshSutnyUmstQXPzs72uJ5rAFzzh
 41+u9QjkZKHhWADicKpgCLwRBFcFH43JheWG2kg99WQQG2J0RWpYdlKo2ncj0n7GNx8r
 BSZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1eTtK1BBr0FdaCdKkQ7aLvKOyxn/nlWB3fU4/Wza23gP0Gu4JnKmPsBJvrD8Ynbe1JJAIS4idsa8Z@nongnu.org
X-Gm-Message-State: AOJu0YwGv4mCVIrieFTmNrnUx3nZ5mzjWH31DJcsCjldos2LN1EPo64D
 Rh5B+mxWjNtZHErKRPoj3yV/Kn+vmXb+YjnFZgHA2vc7xoy8tQvaX3evRXABuzE=
X-Gm-Gg: ASbGncspKGcCzFHUgs6DobjLuWaQ5l6BrEuNXq1t2srRQKfaT40l5FxZ0GoEACmmoh8
 6bV71HibZZN1n8WayxgbCQNDAbtGcWpyJGWPUmbHMTQkvuWBeuy3M2pMQ/Qb2kaayB078v4PMdQ
 gu+1i4C4ds/WhDEX6LPjzzqg27AIV6/gJWwsHYU3gcZ44FoEkFz7dBSp9DefEVNhB25EAzQ5HqM
 hzeqQ1gs8t+KPTk127QAi6eWDoMJ/xbVr3600/N61AJ8pHpkT51goIC+uNKw+BDIahbi9zap1dl
 azMhzorIfk5CVH5uHV6O45QfXNqwKIgM8DW9+mEkYU+IPuepYvnOYsTP3Cc=
X-Google-Smtp-Source: AGHT+IF1dV2ICDQlE4h08oCrWDTZlSFQeu19yZxT88E71XyMeaFR07nB+TTVtdoMdky+5t3Tvu9TrA==
X-Received: by 2002:a05:6000:145:b0:38d:b325:471f with SMTP id
 ffacd0b85a97d-38f33f1f725mr14675924f8f.15.1739973153268; 
 Wed, 19 Feb 2025 05:52:33 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8121sm17699059f8f.88.2025.02.19.05.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 05:52:32 -0800 (PST)
Message-ID: <f1066292-2395-44e5-bf2d-543deba647d6@linaro.org>
Date: Wed, 19 Feb 2025 14:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/32] tests/functional: extend test_aarch64_virt with
 vulkan test
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Virt" <qemu-arm@nongnu.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-24-alex.bennee@linaro.org>
 <91a78caf-2200-42b7-8da6-e857af38bad7@linaro.org>
 <87751cfc-b2b9-4995-a024-13905a1c47ca@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87751cfc-b2b9-4995-a024-13905a1c47ca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 19/2/25 14:43, Thomas Huth wrote:
> On 19/02/2025 14.25, Philippe Mathieu-Daudé wrote:
>> (+Markus for CLI)
>>
>> On 10/1/25 14:17, Alex Bennée wrote:
>>> Now that we have virtio-gpu Vulkan support, let's add a test for it.
>>> Currently this is using images build by buildroot:
>>>
>>>    https://lists.buildroot.org/pipermail/buildroot/2024- 
>>> December/768196.html
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>
>>>
>>> diff --git a/tests/functional/test_aarch64_virt.py b/tests/ 
>>> functional/ test_aarch64_virt.py
>>> index 201c5ed023..6b2336a28d 100755
>>> --- a/tests/functional/test_aarch64_virt.py
>>> +++ b/tests/functional/test_aarch64_virt.py
>>> @@ -13,10 +13,12 @@
>>>   import logging
>>>   from subprocess import check_call, DEVNULL
>>> +from qemu.machine.machine import VMLaunchFailure
>>> +
>>>   from qemu_test import QemuSystemTest, Asset
>>> -from qemu_test import exec_command_and_wait_for_pattern
>>> +from qemu_test import exec_command, exec_command_and_wait_for_pattern
>>>   from qemu_test import wait_for_console_pattern
>>> -from qemu_test import get_qemu_img
>>> +from qemu_test import skipIfMissingCommands, get_qemu_img
>>>   class Aarch64VirtMachine(QemuSystemTest):
>>> @@ -132,5 +134,73 @@ def test_aarch64_virt_gicv2(self):
>>>           self.common_aarch64_virt("virt,gic-version=2")
>>> +    ASSET_VIRT_GPU_KERNEL = Asset(
>>> +        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
>>> +        'download?path=%2F&files='
>>> +        'Image',
>>> +        
>>> '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
>>> +
>>> +    ASSET_VIRT_GPU_ROOTFS = Asset(
>>> +        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
>>> +        'download?path=%2F&files='
>>> +        'rootfs.ext4.zstd',
>>> +        
>>> '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
>>> +
>>> +    @skipIfMissingCommands('zstd')
>>> +    def test_aarch64_virt_with_gpu(self):
>>> +        # This tests boots with a buildroot test image that contains
>>> +        # vkmark and other GPU exercising tools. We run a headless
>>> +        # weston that nevertheless still exercises the virtio-gpu
>>> +        # backend.
>>> +
>>> +        self.set_machine('virt')
>>> +        self.require_accelerator("tcg")
>>> +
>>> +        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
>>> +        image_path = self.uncompress(self.ASSET_VIRT_GPU_ROOTFS, 
>>> format="zstd")
>>> +
>>> +        self.vm.set_console()
>>> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>>> +                               'console=ttyAMA0 root=/dev/vda')
>>> +
>>> +        self.vm.add_args("-accel", "tcg")
>>> +        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
>>> +        self.vm.add_args("-machine", "virt,gic-version=max",
>>> +                         '-kernel', kernel_path,
>>> +                         '-append', kernel_command_line)
>>> +        self.vm.add_args("-smp", "2", "-m", "2048")
>>> +        self.vm.add_args("-device",
>>> +                         "virtio-gpu-gl- 
>>> pci,hostmem=4G,blob=on,venus=on")
>>> +        self.vm.add_args("-display", "egl-headless")
>>> +        self.vm.add_args("-display", "dbus,gl=on")
>>
>> [*]
>>
>>> +        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
>>> +        self.vm.add_args("-blockdev",
>>> +                         "driver=raw,file.driver=file,"
>>> +                         "node-name=hd0,read-only=on,"
>>> +                         f"file.filename={image_path}")
>>> +        self.vm.add_args("-snapshot")
>>> +
>>> +        try:
>>> +            self.vm.launch()
>>> +        except VMLaunchFailure as excp:
>>> +            if "old virglrenderer, blob resources unsupported" in 
>>> excp.output:
>>> +                self.skipTest("No blob support for virtio-gpu")
>>> +            elif "old virglrenderer, venus unsupported" in excp.output:
>>> +                self.skipTest("No venus support for virtio-gpu")
>>
>> This seems dependent on the order of the CLI arguments, as I got:
>>
>> qemu-system-aarch64: -device virtio-gpu-gl- 
>> pci,hostmem=4G,blob=on,venus=on: 'virtio-gpu-gl-pci' is not a valid 
>> device model name
>>
>> I understand it is too complex to check this device availability with
>> meson, in order to avoid running the test.
>>
>> Can we use device introspection instead, like we do in QTest with
>> qtest_qom_has_concrete_type() for accelerators? Maybe in the lines of:
>>
>>    @skipIfMissingQOMType('virtio-gpu-gl-pci')
> 
> We already have "self.require_device('...')" that can be used to check 
> for the availability of devices and skip the test if it is not built 
> in ... would that be suitable here?

Yes, perfect, thanks!

> 
>   Thomas
> 


