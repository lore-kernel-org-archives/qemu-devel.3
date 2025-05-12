Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70905C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uERx8-00059Q-H7; Mon, 12 May 2025 08:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uERx5-00058d-KT
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:08:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uERx3-000146-1Y
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:08:11 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0b9625662so3553164f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747051686; x=1747656486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k9oSO6VvjoXDKhI2/KCGOYhfCGhHG5VKFyZNM70FjgA=;
 b=upKtmyiWikDF04gKPIWCxrIHi5fTbV6jWnafRCCd1su3xQnDap4VXPNVFGhnHXLGKe
 k1sinIsIREM+6CtvZFvAo+KGe2jo3MMUYzl26XT99/mWuxpkcBDc6md8dT4qvmYwqHCl
 MfJfeFTIGWP+C2TAWPEvB5VMTSPp8DiDu4SJVvMKcgNgybvQqfwspwJb6081xoQnN4UL
 WhstbTKX+sQX1WUGdaahZiw+I5ybEXAZnkCDkwDUiR0qzfz2EUnAH/R1xhO3oPDiTzG1
 3cp2RoD+oMapFRzW4vudSjdt6XFHMygCZAbxwOAzGH3tGmZrdDMHZ71EOeicNjftoM1b
 xSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747051686; x=1747656486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k9oSO6VvjoXDKhI2/KCGOYhfCGhHG5VKFyZNM70FjgA=;
 b=rpki+0qlhiZY+A7LgS8/34aYsYkXrG5pYPuqXR6Lw0N+wvTTLYuBEHxV4BcD7JcagL
 MSi0qksCp5VXjPmhveoG+NLMWngTsyZHUWh8rObHK3qQHL5YTiqqhjlAqd0Z09c8bpqJ
 kbyf4F1FFwgnFuD6XCOIryFDiB31R5/KvP9DQZL5rA3giHITJs6HL9jS8E/6Htr82zSX
 sI5dMYiUQxqGmRxRVn6lu27FiYLZ0pvc5LsgnbqlucBKElImCozjzsN9aHjhSdiZA1mo
 jLhd8wDh9eq1i+pQGY5svC8uizS9BV/PasYY0WtJbak0EUlAj/aegCV5ctftN3uP6l3S
 4zsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIQlh3jVVWK/jxSSbzvYDZk4uRRyGbSA39jxLKF5y1Sh/MC5//hf6iHLOY5CkbJUghhhERj8sctgeR@nongnu.org
X-Gm-Message-State: AOJu0YyO4tj4qxXuq6avw42Mj9wMHT93ZicWmbNMs/MiaX6dtMAzuDXD
 T371Jx4Q1l4pQtNxdiJwPH7Us3j32dm//g4eH4/q5b2MpwyulMoivL9BisHHdtg=
X-Gm-Gg: ASbGncu9/AXRxf/IHD66Z6ZXQ+ScT6H8Lpygyk08rU3/mZddYLGTDId4C8I7bng3b+F
 NhuPM9WmkM/nl5B5QMnA6gVP+bYFEcoGVJfL1daVEP+9A1m8dllnuxddeKMvDzMEvLCm2cWZfFM
 PcmGghCkLulKISspZCqjwVJfcsgVg0pUx6JC/rKrLvhvryEBvyM3lTzeed18Ha75QFq0qiNe4nI
 HWNYTdYyEHLxZ6OKJ8gKNnoj9xjNjIIgbIvTtzt4x3mji5I/kjUPDny6SNjtnKjrirG439wZZXa
 wPEHi/eCCe+ldvExN1NFnLT/qY88ycdqNhcALmrb1COq7Pi+YXmOJqafTcvSq6EkVtQ+Gfjzk0U
 REcv2hbRQgszI
X-Google-Smtp-Source: AGHT+IFtQJKHD/8Mf3N4T537A+vTBCJedSX2E/+iEDuNXFgKrMe1rBR0CcAcF7Mfc7dGHoWk+Vn5jQ==
X-Received: by 2002:a5d:64a8:0:b0:39c:f0d:9146 with SMTP id
 ffacd0b85a97d-3a1f64b5aefmr10518548f8f.45.1747051685842; 
 Mon, 12 May 2025 05:08:05 -0700 (PDT)
Received: from [10.93.5.179] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ec8f1sm12079454f8f.26.2025.05.12.05.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:08:05 -0700 (PDT)
Message-ID: <e25812d6-cc1d-4727-b24e-208dbbe54afa@linaro.org>
Date: Mon, 12 May 2025 13:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add PCI hotplug test for aarch64
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20250509232156.106465-1-gustavo.romero@linaro.org>
 <80e7eacc-0b71-4e1c-981e-607a4ce8a7bd@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <80e7eacc-0b71-4e1c-981e-607a4ce8a7bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Thomas,

Thanks for the review.

On 5/12/25 04:59, Thomas Huth wrote:
>   Hi!
> 
> On 10/05/2025 01.19, Gustavo Romero wrote:
>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
>> native controller and does not support ACPI-based hotplugging. However,
>> since support is planned, this test sets 'acpi=force' and specifies an
>> EDK2 firmware image in advance. This is harmless and prepares for future
>> ACPI support.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/functional/meson.build                 |  1 +
>>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>>   2 files changed, 74 insertions(+)
>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
> 
> Could you also add the test file to one of the sections in the MAINTAINERS file, please?

Any idea under which section I should add this test?

Currently, it's only TCG, but in the future probably there will be
1) a variant with --enable-kvm option and 2) it will have a variant
with ACPI enabled. Hence, currently it doesn't seem to fit neither
under "PCI" nor under "ARM ACPI Subsystem", I think I can create a
section tho? Maybe "ARM PCI Hotplug"? Could you please advise?


>> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
>> new file mode 100755
>> index 0000000000..031540ba22
>> --- /dev/null
>> +++ b/tests/functional/test_aarch64_hotplug_pci.py
>> @@ -0,0 +1,73 @@
>> +#!/usr/bin/env python3
>> +#
>> +# The test hotplugs a PCI device and checks it on a Linux guest.
>> +#
>> +# Copyright (c) 2025 Linaro Ltd.
>> +#
>> +# Author:
>> +#  Gustavo Romero <gustavo.romero@linaro.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +from os import path
>> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
>> +from qemu_test import BUILD_DIR
>> +
>> +class HotplugPCI(LinuxKernelTest):
>> +
>> +    ASSET_KERNEL = Asset(
>> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>> +         'current/images/netboot/debian-installer/arm64/linux'),
>> +        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
>> +
>> +    ASSET_INITRD = Asset(
>> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
>> +         'current/images/netboot/debian-installer/arm64/initrd.gz'),
>> +        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
>> +
>> +    def test_hotplug_pci(self):
>> +
>> +        self.vm.add_args('-m', '512M')
>> +        self.vm.add_args('-machine', 'type=virt')
> 
> Please use self.set_machine('virt') instead so that the test gets correctly skipped in case the machine has not been compiled into the binary.

Sure!


Cheers,
Gustavo

