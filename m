Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F4E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 09:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKZmU-0004Iq-0P; Mon, 09 Dec 2024 04:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tKZmH-0004F7-LJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 04:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tKZmF-0000Fi-Cz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 04:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733735400;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/KBsGxv3OmzU86DVmok2nowUeolAlK/Y+I+scNlH9aM=;
 b=STPO0oiKRtyKJPAcELnp1y8PQvuDDJqJU11LmtVPhtf+rI7JDoqu/5WFDO8n89GHA4wYO5
 3kPYlqZ4Mn1qlqsqXzJu4ZHfKKrUglP9YW5cD0Y5DI+nK8ccohggP5A5lIhlpDUeA2D8o8
 SU7Y8HAofDpctFAZ3F3rWJN8WbkVE70=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-Pd5jDOEoNZ23GE1aAveFkw-1; Mon,
 09 Dec 2024 04:09:57 -0500
X-MC-Unique: Pd5jDOEoNZ23GE1aAveFkw-1
X-Mimecast-MFC-AGG-ID: Pd5jDOEoNZ23GE1aAveFkw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 616E21955F3B; Mon,  9 Dec 2024 09:09:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E63E1955F41; Mon,  9 Dec 2024 09:09:50 +0000 (UTC)
Date: Mon, 9 Dec 2024 09:09:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: eric.auger@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH for-10.0] tests/functional: Convert the intel_iommu
 avocado test
Message-ID: <Z1az26HxcIHVlB-d@redhat.com>
References: <20241206181728.1241169-1-thuth@redhat.com>
 <d07f4ade-716c-4d58-b6d9-a95b4ffe58ab@redhat.com>
 <7e81c4a2-cc76-4d8c-b14a-fd008eff0c09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e81c4a2-cc76-4d8c-b14a-fd008eff0c09@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 09, 2024 at 09:26:21AM +0100, Thomas Huth wrote:
> On 09/12/2024 09.12, Eric Auger wrote:
> > Hi Thomas,
> > 
> > On 12/6/24 19:17, Thomas Huth wrote:
> > > Convert the intel_iommu test to the new functional framework.
> > > This test needs some changes since we neither support the old 'LinuxTest'
> > > class in the functional framework yet, nor a way to use SSH for running
> > > commands in the guest. So we now directly download a Fedora kernel and
> > > initrd and set up the serial console for executing the commands and for
> > > looking for the results.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   MAINTAINERS                                   |   1 +
> > >   tests/functional/meson.build                  |   1 +
> > >   .../test_intel_iommu.py}                      | 119 ++++++++----------
> > >   3 files changed, 51 insertions(+), 70 deletions(-)
> > >   rename tests/{avocado/intel_iommu.py => functional/test_intel_iommu.py} (41%)
> > >   mode change 100644 => 100755
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a62659b330..2ca452dbf9 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3679,6 +3679,7 @@ S: Supported
> > >   F: hw/i386/intel_iommu.c
> > >   F: hw/i386/intel_iommu_internal.h
> > >   F: include/hw/i386/intel_iommu.h
> > > +F: tests/functional/test_intel_iommu.py
> > >   AMD-Vi Emulation
> > >   S: Orphan
> > > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > > index 30c3eda7e4..dfc95fd904 100644
> > > --- a/tests/functional/meson.build
> > > +++ b/tests/functional/meson.build
> > > @@ -238,6 +238,7 @@ tests_x86_64_system_quick = [
> > >   tests_x86_64_system_thorough = [
> > >     'acpi_bits',
> > > +  'intel_iommu',
> > >     'x86_64_tuxrun',
> > >     'linux_initrd',
> > >     'multiprocess',
> > > diff --git a/tests/avocado/intel_iommu.py b/tests/functional/test_intel_iommu.py
> > > old mode 100644
> > > new mode 100755
> > > similarity index 41%
> > > rename from tests/avocado/intel_iommu.py
> > > rename to tests/functional/test_intel_iommu.py
> > > index 992583fa7d..6e47b1e9de
> > > --- a/tests/avocado/intel_iommu.py
> > > +++ b/tests/functional/test_intel_iommu.py
> > > @@ -1,3 +1,5 @@
> > > +#!/usr/bin/env python3
> > > +#
> > >   # INTEL_IOMMU Functional tests
> > >   #
> > >   # Copyright (c) 2021 Red Hat, Inc.
> > > @@ -7,116 +9,93 @@
> > >   #
> > >   # This work is licensed under the terms of the GNU GPL, version 2 or
> > >   # later.  See the COPYING file in the top-level directory.
> > > -import os
> > > -from avocado import skipUnless
> > > -from avocado_qemu.linuxtest import LinuxTest
> > > +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
> > > +
> > > +class IntelIOMMU(LinuxKernelTest):
> > > -@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
> > > -class IntelIOMMU(LinuxTest):
> > > -    """
> > > -    :avocado: tags=arch:x86_64
> > > -    :avocado: tags=distro:fedora
> > > -    :avocado: tags=distro_version:31
> > > -    :avocado: tags=machine:q35
> > > -    :avocado: tags=accel:kvm
> > > -    :avocado: tags=intel_iommu
> > > -    :avocado: tags=flaky
> > > -    """
> > > +    ASSET_KERNEL = Asset(
> > > +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> > > +         'releases/39/Server/x86_64/os/images/pxeboot/vmlinuz'),
> > > +        '5f2ef0de47f8d79d5ee9bf8b0ee6d5ba4d987c2f9a16b8b511a7c69e53931fe3')
> > > +
> > > +    ASSET_INITRD = Asset(
> > > +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> > > +         'releases/39/Server/x86_64/os/images/pxeboot/initrd.img'),
> > > +        '5bc29e2d872ceeb39a9698d42da3fb0afd7583dc7180de05a6b78bcc726674bb')
> > >       IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
> > > +    default_kernel_params = 'console=ttyS0 rd.rescue quiet '
> > >       kernel_path = None
> > >       initrd_path = None
> > >       kernel_params = None
> > > -    def set_up_boot(self):
> > > -        path = self.download_boot()
> > > -        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
> > > -                         'drive=drv0,id=virtio-disk0,bootindex=1,'
> > > -                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
> > > -        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
> > > -        self.vm.add_args('-drive',
> > > -                         'file=%s,if=none,cache=writethrough,id=drv0' % path)
> > > -
> > > -    def setUp(self):
> > > -        super(IntelIOMMU, self).setUp(None, 'virtio-net-pci' + self.IOMMU_ADDON)
> > > -
> > >       def add_common_args(self):
> > >           self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
> > >           self.vm.add_args('-object',
> > >                            'rng-random,id=rng0,filename=/dev/urandom')
> > > +        self.vm.add_args('-device', 'virtio-net-pci' + self.IOMMU_ADDON)
> > > +        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
> > > +        self.vm.add_args("-m", "1G")
> > > -    def common_vm_setup(self, custom_kernel=None):
> > > +    def common_vm_setup(self):
> > > +        self.set_machine('q35')
> > >           self.require_accelerator("kvm")
> > >           self.add_common_args()
> > >           self.vm.add_args("-accel", "kvm")
> > > -        if custom_kernel is None:
> > > -            return
> > > -
> > > -        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
> > > -        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
> > > -        initrd_url = self.distro.pxeboot_url + 'initrd.img'
> > > -        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
> > > -        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> > > -        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> > > +        self.kernel_path = self.ASSET_KERNEL.fetch()
> > > +        self.initrd_path = self.ASSET_INITRD.fetch()
> > > +        self.kernel_params = self.default_kernel_params
> > >       def run_and_check(self):
> > >           if self.kernel_path:
> > >               self.vm.add_args('-kernel', self.kernel_path,
> > >                                '-append', self.kernel_params,
> > >                                '-initrd', self.initrd_path)
> > > -        self.launch_and_wait()
> > > -        self.ssh_command('cat /proc/cmdline')
> > > -        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
> > > -        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
> > > -        self.ssh_command('dnf -y install numactl-devel')
> > I understand you cannot use ssh yet but the bulk of the test was the
> > execution of the dnf install meaning we lose the main substance of it
> > through the conversion.
> 
> Ah, I see, so this was exercising the virtio-net device with the IOMMU ...
> and I already wondered why there was this "dnf install" at the end without
> doing anything with  the numactl-devel package ... (a comment would have
> been helpful here)

FYI, I find 'dnf instal' to be a *highly* undesirable thing todo in
our test functional. Its performance is highly non-deterministic
depending on what mirror you happen to get sent to, such that it could
easily push us over the timeouts. It is also susceptible to periodic
broken mirrors, and instability around time of Fefdora EOL. I can't
remember if it was this test case, or a different one, but I've seen
problems before in avocado with 'dnf install'.

If we want to test working networking, then can we arrange for something
more simple & targetted to run, with better worst case performance.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


