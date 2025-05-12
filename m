Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB34C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESyi-0002Qi-Be; Mon, 12 May 2025 09:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uESyf-0002Q5-GU
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uESyd-0007qb-4J
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747055628;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9nQ0PjLzlHrkIlo/+qVCqb6jCtG75gN3TkxSEmAOuVI=;
 b=FZj+LHeP/a68wGnM5VvKCP7tUZZi+SZVpSgtroJN90wp1+UZVaCdEz6T/RbtE5QV9wG4t3
 PWHHS5EPZlOg3FcpbKomNqol0DnTnkkK8svbUWS1HeB5E1IymjsHwln5KVXMfHYloda++j
 am7kOMkjk2WpDcXvVaaFtMbCTprK8Bk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-sbWtbG2VPVmSwYbcBtbGXg-1; Mon,
 12 May 2025 09:13:45 -0400
X-MC-Unique: sbWtbG2VPVmSwYbcBtbGXg-1
X-Mimecast-MFC-AGG-ID: sbWtbG2VPVmSwYbcBtbGXg_1747055624
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A4EE1800877; Mon, 12 May 2025 13:13:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 314C218018BE; Mon, 12 May 2025 13:13:40 +0000 (UTC)
Date: Mon, 12 May 2025 14:13:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, eric.auger@redhat.com,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Subject: Re: [PATCH v2] tests/functional: Add PCI hotplug test for aarch64
Message-ID: <aCH0ATZVRxI7rtxk@redhat.com>
References: <20250512123646.157447-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512123646.157447-1-gustavo.romero@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 12, 2025 at 01:36:33PM +0100, Gustavo Romero wrote:
> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
> native controller and does not support ACPI-based hotplugging. However,
> since support is planned, this test sets 'acpi=force' and specifies an
> EDK2 firmware image in advance. This is harmless and prepares for future
> ACPI support.

Based on what's written here, it sounds like 'acpi=force' will result
in this test case changing from exercising PCI hotplug, to exercising
ACPI hotplug at some arbitrary point in the future. This isn't what
I'd call a harmless future change.

If the 'virt' machine ever switches from PCI to ACPI hotplug, this
will have to be tied to a machine type version. As such QEMU will
need to support /both/ PCI and ACPI hotplug for a long period of
time, and by implication we would need to be testing both.

I'd think this test should be written to exclusively test the current
PCI hotplug, and at a future date when ACPI hotplug is introduced,
then a 2nd test method can be addded, albeit with a lot of common
code shared.

> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  MAINTAINERS                                  |  5 ++
>  tests/functional/meson.build                 |  1 +
>  tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>  3 files changed, 79 insertions(+)
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
> index 0000000000..05c92d7a45
> --- /dev/null
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -0,0 +1,73 @@
> +#!/usr/bin/env python3
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
> +from os import path
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
> +                         'console=ttyAMA0,115200 acpi=force init=/bin/sh')
> +        self.vm.add_args('-device',
> +                         'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1')
> +        self.vm.add_args('-bios', path.join(BUILD_DIR, 'pc-bios',
> +                         'edk2-aarch64-code.fd'))
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
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


