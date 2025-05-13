Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D3BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uElZF-0000sn-Jm; Tue, 13 May 2025 05:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uElZC-0000sE-8r
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uElZ9-0000ql-QV
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747127085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6eonsskfOOe3KnGu2tFGL/6iBrDFe3TXuWk4dwBJ9g=;
 b=h3porA6bzhrwI07r7mdso/O52qGRBdmJwn0psJOpYN6iJuScEXUxueeRs5jKbMUi0oa2Ja
 SXPDf+U4PmoN9+0b1Ifmmow26YlINhVkTTo2CF5zgjF7b4+Q7r+3a+nUWJ7MOSZ1x3uIu4
 YHYPqWOophMs60MUMjpdWyazQgycseU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-T1m5vkRMNA-U_2Y6ZRkVoQ-1; Tue, 13 May 2025 05:04:43 -0400
X-MC-Unique: T1m5vkRMNA-U_2Y6ZRkVoQ-1
X-Mimecast-MFC-AGG-ID: T1m5vkRMNA-U_2Y6ZRkVoQ_1747127083
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0bd786a53so2238607f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 02:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747127082; x=1747731882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6eonsskfOOe3KnGu2tFGL/6iBrDFe3TXuWk4dwBJ9g=;
 b=nsh1b5BHopVNJBM68LUPs1OEgQQs79YbbCpA8QkH9TAKF20cc5e6uqnVj92223e+U8
 F9wCH71xLEF2gT7hD4s6dQJA0h2wH+ML2A3CyUtPiDQVE6hcU/vrplhF1cYJihMuu1nM
 VaOhwR68Wo94YkcMjfVLRb0mOgVZOasbeS8JQ3K5o/yV679VuwI7gmPappCMDzq28zwg
 mW3uhuUed1CQvU580uayJeFUFGYUJuMMM9z5HzLhxwueI4Dme6KiAhvPn9jWgMtMMFMm
 5jW4F5aROI06thtl+/Tyl3vPUtYg6h2KKnmW/OxSWEfxsyhaKLYAFISVBKesdgIHQTW9
 aDrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2uXfWu0s+FLbEBCrTgC2uj3rfNIJyJoZuyhCiEiXx0IechU8pWTsGSvbstU6blo3nNgGufgu1Xc+F@nongnu.org
X-Gm-Message-State: AOJu0YxGgRuMhQ+6jKxbziKw/OGUgsk+k4MJ8Whd1dNf9RGYNv63YXbx
 nzZZIX/MwzrgDOVhymMKFy5U0BhRYYVpdLbH8dFbfjrzQIjfH5jjthdamZqjcXmGQJ+02tQcIDt
 GHkLYas0JeD7gfSdZWmJJNlQRA2HtgPONqS3u1jy7smsdIqWQWdMR
X-Gm-Gg: ASbGncs4f2RuennCMAHM6stXwsvMvv078yFSnqG0rhnC0QQyfwwhgj5GOqZhlA+zJb4
 DKELzZaMFH8KdodSyXqQ2uZPFk25ROB41DaKNF7+2BwyyQR5VBwKMurWaLUSzqHrUkU8tZpIBAA
 Sg/RIiUooPd83jTH+pcbhyDJbZYcFlQM2kj8m2azbDyeWE4BA4NYZl6Pnn2FLCBJJNiYoSL2D7i
 iciZqXIxzHulp8UQuDISvtUGtokUNDrHapTOtBsK+2ZtGYO1I2rw237tSN950kJu3MrunXahX5/
 Mpr7WZ4EhX5dUSUt43Ve89htD1RfdCBGVwnPjjTB0Ws4eI0/rgXpntBOTMY=
X-Received: by 2002:a05:6000:2485:b0:39e:e3ef:5cbf with SMTP id
 ffacd0b85a97d-3a1f643a65fmr15077185f8f.24.1747127082618; 
 Tue, 13 May 2025 02:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/dFy1fIFGnenBNXVYO4AOFFRZ+vNpnevwrf7KuZ2fv/yna0FOx8hSifxtqO0RDHih6Ihcng==
X-Received: by 2002:a05:6000:2485:b0:39e:e3ef:5cbf with SMTP id
 ffacd0b85a97d-3a1f643a65fmr15077153f8f.24.1747127082237; 
 Tue, 13 May 2025 02:04:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57de087sm15669476f8f.16.2025.05.13.02.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 02:04:41 -0700 (PDT)
Message-ID: <67ab5cf1-5e61-4fd0-b3a1-fe5eae690448@redhat.com>
Date: Tue, 13 May 2025 11:04:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tests/functional: Add PCI hotplug test for aarch64
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 thuth@redhat.com, berrange@redhat.com
Cc: alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20250512144629.182340-1-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250512144629.182340-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/12/25 4:45 PM, Gustavo Romero wrote:
> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  MAINTAINERS                                  |  5 ++
>  tests/functional/meson.build                 |  1 +
>  tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23174b4ca7..9ebb768214 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2065,6 +2065,11 @@ S: Supported
>  F: include/hw/pci/pcie_doe.h
>  F: hw/pci/pcie_doe.c
>  
> +ARM PCI Hotplug
> +M: Gustavo Romero <gustavo.romero@linaro.org>
> +S: Supported
> +F: tests/functional/test_aarch64_hotplug_pci.py
> +
>  ACPI/SMBIOS
>  M: Michael S. Tsirkin <mst@redhat.com>
>  M: Igor Mammedov <imammedo@redhat.com>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 52b4706cfe..2d68840fa2 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -83,6 +83,7 @@ tests_aarch64_system_quick = [
>  tests_aarch64_system_thorough = [
>    'aarch64_aspeed_ast2700',
>    'aarch64_aspeed_ast2700fc',
> +  'aarch64_hotplug_pci',
>    'aarch64_imx8mp_evk',
>    'aarch64_raspi3',
>    'aarch64_raspi4',
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
> new file mode 100755
> index 0000000000..fa1bb62c8f
> --- /dev/null
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -0,0 +1,74 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# The test hotplugs a PCI device and checks it on a Linux guest.
> +#
> +# Copyright (c) 2025 Linaro Ltd.
> +#
> +# Author:
> +#  Gustavo Romero <gustavo.romero@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
> +from qemu_test import BUILD_DIR
> +
> +class HotplugPCI(LinuxKernelTest):
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> +         'current/images/netboot/debian-installer/arm64/linux'),
> +        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
> +
> +    ASSET_INITRD = Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> +         'current/images/netboot/debian-installer/arm64/initrd.gz'),
> +        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
> +
> +    def test_hotplug_pci(self):
> +
> +        self.set_machine('virt')
> +        self.vm.add_args('-m', '512M')
> +        self.vm.add_args('-cpu', 'cortex-a57')
> +        self.vm.add_args('-append',
> +                         'console=ttyAMA0,115200 init=/bin/sh')
> +        self.vm.add_args('-device',
> +                         'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1')
> +        self.vm.add_args('-bios', self.build_file('pc-bios',
> +                                                  'edk2-aarch64-code.fd'))
> +
> +        # BusyBox prompt
> +        prompt = "~ #"
> +        self.launch_kernel(self.ASSET_KERNEL.fetch(),
> +                           self.ASSET_INITRD.fetch(),
> +                           wait_for=prompt)
> +
> +        # Check for initial state: 2 network adapters, lo and enp0s1.
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',
> +                                          '2')
> +
> +        # Hotplug one network adapter to the root port, i.e. pcie.1 bus.
> +        self.vm.cmd('device_add',
> +                    driver='virtio-net-pci',
> +                    bus='pcie.1',
> +                    addr=0,
> +                    id='na')
> +        # Wait for the kernel to recognize the new device.
> +        self.wait_for_console_pattern('virtio-pci')
> +        self.wait_for_console_pattern('virtio_net')
> +
> +        # Check if there is a new network adapter.
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',
> +                                          '3')
> +
> +        self.vm.cmd('device_del', id='na')
> +        exec_command_and_wait_for_pattern(self,
> +                                          'ls -l /sys/class/net | wc -l',
> +                                          '2')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


