Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57EAC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGIo-0006ik-Js; Thu, 03 Jul 2025 05:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uXGIl-0006hM-W8
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uXGIg-0000xF-Ci
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751535132;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0F9uhQ7cUDRlzNXIyseGco5TD+/cKcUNINzf4B3/Hw=;
 b=E0xDk/E/v9Ms4cN1O2vbMajxH1T8o+CXky6asOCKA5OP9HBLprgoO59q7NBLEAUCuyG4m6
 cNNlFZuKSrsCdWsVO5nDZP6RPLykcEzSpXCmRBL7dDaQQQ03TZtL9KNGbDU0UU0SZjLMa7
 AbQXVF6sKNSt2BhmMKmoVezziHLe81o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-Q-2sTcvfPveH--V3XgROBQ-1; Thu,
 03 Jul 2025 05:32:10 -0400
X-MC-Unique: Q-2sTcvfPveH--V3XgROBQ-1
X-Mimecast-MFC-AGG-ID: Q-2sTcvfPveH--V3XgROBQ_1751535129
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46C971978F61; Thu,  3 Jul 2025 09:32:09 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 053023000218; Thu,  3 Jul 2025 09:32:05 +0000 (UTC)
Date: Thu, 3 Jul 2025 10:32:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, jean-philippe@linaro.org,
 alex.bennee@linaro.org, eric.auger@redhat.com, smostafa@google.com
Subject: Re: [PATCH v2] tests/functional: test device passthrough on aarch64
Message-ID: <aGZN9fE7jERCWEQC@redhat.com>
References: <20250627200222.5172-1-pierrick.bouvier@linaro.org>
 <aGUvc6XJjsluZtH_@redhat.com>
 <2862e805-e2b5-4b4b-a21e-6e7e61d39639@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2862e805-e2b5-4b4b-a21e-6e7e61d39639@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 02, 2025 at 01:08:41PM -0700, Pierrick Bouvier wrote:
> On 7/2/25 6:09 AM, Daniel P. Berrangé wrote:
> > On Fri, Jun 27, 2025 at 01:02:22PM -0700, Pierrick Bouvier wrote:
> > > This test allows to document and exercise device passthrough, using a
> > > nested virtual machine setup. Two disks are generated and passed to the
> > > VM, and their content is compared to original images.
> > > 
> > > Guest and nested guests commands are executed through two scripts, and
> > > init used in both system is configured to trigger a kernel panic in case
> > > any command fails. This is more reliable and readable than executing all
> > > commands through prompt injection and trying to guess what failed.
> > > 
> > > Initially, this test was supposed to test smmuv3 nested emulation
> > > (combining both stages of translation), but I could not find any setup
> > > (kernel + vmm) able to do the passthrough correctly, despite several
> > > tries.
> > > 
> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > ---
> > >   tests/functional/meson.build                  |   2 +
> > >   .../test_aarch64_device_passthrough.py        | 142 ++++++++++++++++++
> > >   2 files changed, 144 insertions(+)
> > >   create mode 100755 tests/functional/test_aarch64_device_passthrough.py
> > > 
> > > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > > index 3021928a9d4..6cc78abb123 100644
> > > --- a/tests/functional/meson.build
> > > +++ b/tests/functional/meson.build
> > > @@ -13,6 +13,7 @@ endif
> > >   test_timeouts = {
> > >     'aarch64_aspeed_ast2700' : 600,
> > >     'aarch64_aspeed_ast2700fc' : 600,
> > > +  'aarch64_device_passthrough' : 720,
> > >     'aarch64_imx8mp_evk' : 240,
> > >     'aarch64_raspi4' : 480,
> > >     'aarch64_reverse_debug' : 180,
> > > @@ -84,6 +85,7 @@ tests_aarch64_system_quick = [
> > >   tests_aarch64_system_thorough = [
> > >     'aarch64_aspeed_ast2700',
> > >     'aarch64_aspeed_ast2700fc',
> > > +  'aarch64_device_passthrough',
> > >     'aarch64_imx8mp_evk',
> > >     'aarch64_raspi3',
> > >     'aarch64_raspi4',
> > > diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/test_aarch64_device_passthrough.py
> > > new file mode 100755
> > > index 00000000000..1f3f158a9ff
> > > --- /dev/null
> > > +++ b/tests/functional/test_aarch64_device_passthrough.py
> > > @@ -0,0 +1,142 @@
> > > +#!/usr/bin/env python3
> > > +#
> > > +# Boots a nested guest and compare content of a device (passthrough) to a
> > > +# reference image. Both vfio group and iommufd passthrough methods are tested.
> > > +#
> > > +# Copyright (c) 2025 Linaro Ltd.
> > > +#
> > > +# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > +#
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > > +import os
> > > +
> > > +from qemu_test import QemuSystemTest, Asset
> > > +from qemu_test import exec_command, wait_for_console_pattern
> > > +from qemu_test import exec_command_and_wait_for_pattern
> > > +from random import randbytes
> > > +
> > > +guest_script = '''
> > > +#!/usr/bin/env bash
> > > +
> > > +set -euo pipefail
> > > +set -x
> > > +
> > > +# find disks from nvme serial
> > > +dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
> > > +dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
> > > +pci_vfio=$(basename $(readlink -f /sys/block/$dev_vfio/../../../))
> > > +pci_iommufd=$(basename $(readlink -f /sys/block/$dev_iommufd/../../../))
> > > +
> > > +# bind disks to vfio
> > > +for p in "$pci_vfio" "$pci_iommufd"; do
> > > +    if [ "$(cat /sys/bus/pci/devices/$p/driver_override)" == vfio-pci ]; then
> > > +        continue
> > > +    fi
> > > +    echo $p > /sys/bus/pci/drivers/nvme/unbind
> > > +    echo vfio-pci > /sys/bus/pci/devices/$p/driver_override
> > > +    echo $p > /sys/bus/pci/drivers/vfio-pci/bind
> > > +done
> > > +
> > > +# boot nested guest and execute /host/nested_guest.sh
> > > +# one disk is passed through vfio group, the other, through iommufd
> > > +qemu-system-aarch64 \
> > > +-M virt \
> > > +-display none \
> > > +-serial stdio \
> > > +-cpu host \
> > > +-enable-kvm \
> > > +-m 1G \
> > > +-kernel /host/Image.gz \
> > > +-drive format=raw,file=/host/guest.ext4,if=virtio \
> > > +-append "root=/dev/vda init=/init -- bash /host/nested_guest.sh" \
> > > +-virtfs local,path=/host,mount_tag=host,security_model=mapped,readonly=off \
> > > +-device vfio-pci,host=$pci_vfio \
> > > +-object iommufd,id=iommufd0 \
> > > +-device vfio-pci,host=$pci_iommufd,iommufd=iommufd0
> > > +'''
> > > +
> > > +nested_guest_script = '''
> > > +#!/usr/bin/env bash
> > > +
> > > +set -euo pipefail
> > > +set -x
> > > +
> > > +image_vfio=/host/disk_vfio
> > > +image_iommufd=/host/disk_iommufd
> > > +
> > > +dev_vfio=$(lsblk --nvme | grep vfio | cut -f 1 -d ' ')
> > > +dev_iommufd=$(lsblk --nvme | grep iommufd | cut -f 1 -d ' ')
> > > +
> > > +# compare if devices are identical to original images
> > > +diff $image_vfio /dev/$dev_vfio
> > > +diff $image_iommufd /dev/$dev_iommufd
> > > +
> > > +echo device_passthrough_test_ok
> > > +'''
> > > +
> > > +class Aarch64DevicePassthrough(QemuSystemTest):
> > > +
> > > +    # https://github.com/pbo-linaro/qemu-linux-stack
> > > +    #
> > > +    # Linux kernel is compiled with defconfig +
> > > +    # IOMMUFD + VFIO_DEVICE_CDEV + ARM_SMMU_V3_IOMMUFD
> > > +    # https://docs.kernel.org/driver-api/vfio.html#vfio-device-cde
> > > +    ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
> > > +        ('https://fileserver.linaro.org/s/fx5DXxBYme8dw2G/'
> > > +         'download/device_passthrough.tar.xz'),
> > > +         '812750b664d61c2986f2b149939ae28cafbd60d53e9c7e4b16e97143845e196d')
> > > +
> > > +    # This tests the device passthrough implementation, by booting a VM
> > > +    # supporting it with two nvme disks attached, and launching a nested VM
> > > +    # reading their content.
> > > +    def test_aarch64_device_passthrough(self):
> > > +        self.set_machine('virt')
> > > +        self.require_accelerator('tcg')
> > > +
> > > +        self.vm.set_console()
> > > +
> > > +        stack_path_tar_gz = self.ASSET_DEVICE_PASSTHROUGH_STACK.fetch()
> > > +        self.archive_extract(stack_path_tar_gz, format="tar")
> > > +
> > > +        stack = self.scratch_file('out')
> > > +        kernel = os.path.join(stack, 'Image.gz')
> > > +        rootfs_host = os.path.join(stack, 'host.ext4')
> > > +        disk_vfio = os.path.join(stack, 'disk_vfio')
> > > +        disk_iommufd = os.path.join(stack, 'disk_iommufd')
> > > +        guest_cmd = os.path.join(stack, 'guest.sh')
> > > +        nested_guest_cmd = os.path.join(stack, 'nested_guest.sh')
> > 
> > Don't incrementally create paths like this - use the
> > 'scratch_file' method for all components
> > 
> >   ie
> > 
> >     kernel = self.scratch_file('out', 'Image.gz')
> >     rootfs_host =  self.scratch_file('out', 'host.ext4')
> >     ...etc...
> > 
> 
> May I ask what's the benefit of this?
> 
> It forces you to repeat full path (luckily short in this case), but I don't
> see the difference with simply joining paths.

The intent is to eliminate use of os.path.* in general, such that instead
of passing around strings, we can eventually pass around pathlib.Path
objects.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


