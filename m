Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F40606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DvsIWSTB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XTlPFKUA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA4t-0005At-2L; Wed, 28 Oct 2026 16:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMA4l-00058t-3N
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xMA4i-0002H9-Sf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793218603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHrBIhjnzIqsRA7An2O+Dq6BmOrE5FtkJN/df63s5xA=;
 b=DvsIWSTB6FPCPZBzoRSOmoKFaZPr3BOOuHKdvy091Y/zWoHAf+/bdrp+6Kwb0wv2IoWLZc
 SLD2nRdgF6y327PggP2qhv3ImFv1W+RWB7Q5Z3u84Lbp+jpiA4XNmxOQxzJCtZEXjVcYS1
 uBokQ0l+wepmM8VlRL9unJFoqB4xxJQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-oBCnnhO9M2a1fkS4hPynug-1; Wed, 28 Oct 2026 16:16:36 -0400
X-MC-Unique: oBCnnhO9M2a1fkS4hPynug-1
X-Mimecast-MFC-AGG-ID: oBCnnhO9M2a1fkS4hPynug_1793218595
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0c896d05so1144357f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793218595; x=1793823395; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LHrBIhjnzIqsRA7An2O+Dq6BmOrE5FtkJN/df63s5xA=;
 b=XTlPFKUAQwnj+Mytd78jtxhqpbzPlpDQOi3odeo+2J1d4XVyISBNG+qu5ATJPVto2H
 M+aaCO5ktH5Ud8rfiYYY50D3oqZWLwV6X9qzK/Joxpm+wYcLyBF9Wk3ex8Yk2L10AjGt
 qmUwjQgbg90iWSjGh/Q86RsVKfU+y+vnvSUAlrE6eOOBsjYyp8yyLx2szC26wgMcS7Y7
 ZwRDyNy8XgYP4OejXGtp5uMkR+yrG3P/xCPw7RrWwiUKGh+P33PRmNzRoRYm29JKXC2k
 R+qRQd8CGv5R7dDuYIgrhZwBxBb64jDqAnKIQ7PEarIgEzWKQ1fXEw4TSvou+zzN+xnY
 oWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218595; x=1793823395;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LHrBIhjnzIqsRA7An2O+Dq6BmOrE5FtkJN/df63s5xA=;
 b=hJpSNjC2bWszSw2D1k/mSan8xNgkfVR1u7LbtqAXRrsUax/aVpnGe0KQLU19Z3PKoz
 Ftkornh9CNqDur5Qc+3WJHTcv5tLliRl0W1ZBwFzuKx+HvbDHH4iKcyWLg/A6Pjwr5LG
 ToDSwBTMBwdyxfUGkeDEFrGL5GYX3cJ3pVFP2Fho0ZFHbPvY2V8S0rZi/+itYpx/TSwl
 ZOfPlRhzpZZSo2JiXpFCvVhjuftFDUrD3X2aoZlFMSy7OapC0Se8IoWw4g2CF7dkrbRH
 Z4d8qOk7V3KL8T0BGq6g/jGH6wH/NLmftGo6N0PPPAnV6kxafm1eYtAqz4vx0g0mcuyS
 tu6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7YXgfzNXOg3TU/kKmY7JnVmaG1etqF92039QHS+vWmsWUIQZEr0xHxhpNwXVDf5nFFdmsKyz3jMWu@nongnu.org
X-Gm-Message-State: AFq9FYLjmy8Gqok9VRtzgScZ3j5k+W7pUzUysr/Kwa3eBTKgIdXm8w7K
 dAAFjFJev3h1Orz9YoA640DXkidJL4F1OHv4UrLvR2MeDImduye2qKYCgmXmu6L/j8gc8Z+Yb6H
 oPZQhx20/Ve7z0g4b/Y+NEzJaqCTNlS+7A0czpYtgCVOACeSBIuMUgUce
X-Gm-Gg: AYBFou2aeSTA/k08+wsL1W2qv+2OM4Jsv6b+DvRZf2Bnmf7SDHH+lmvHfwyAa/fz2bw
 4ek42/DAzj0gQkyGNk2lxm3f+rmUr/xvBete85vwvUMxX+ivYuvjnwQf6qRj86d8x2VPs2DDf+S
 8nTH+V+cPJy0zphUUHXrE3+FvK7SYeL3PjTWabki6foxfb+m2NxNlHSL5OD+Nci89ADCLUe8SpU
 fnM7ztUm2pe7SvJegJu+luNXzpMu8wvRrMUuA0QKsjPClIuSngQ7EQnJEZMpCbejkjAdadcJY8r
 u56Ok1HizTnLImDa0c4LXwqWK7yppwx9QF0x7OhanA2zHj0ZttmgjBlkMnLe02HI0+AXjKRBinG
 saMKJCSPPiyFcVjs4XwdfaaKn7WTN4EMVf8bp1HIQ
X-Received: by 2002:a05:6000:1a8e:b0:48e:43a:1d84 with SMTP id
 ffacd0b85a97d-48e5d2f1cbbmr8146664f8f.23.1793218595022; 
 Wed, 28 Oct 2026 13:16:35 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8e:b0:48e:43a:1d84 with SMTP id
 ffacd0b85a97d-48e5d2f1cbbmr8146623f8f.23.1793218594560; 
 Wed, 28 Oct 2026 13:16:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecde7c3sm31993347f8f.51.2026.10.28.13.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:16:33 -0700 (PDT)
Date: Wed, 28 Oct 2026 16:16:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: eblake@redhat.com, armbru@redhat.com, th.huth+qemu@posteo.eu,
 philmd@oss.qualcomm.com, berrange@redhat.com, pbonzini@redhat.com,
 zhao1.liu@intel.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/3] tests/funtional: add test_virtio_status.py
Message-ID: <20261028161603-mutt-send-email-mst@kernel.org>
References: <20260922213210.1429435-1-vsementsov@yandex-team.ru>
 <20260922213210.1429435-2-vsementsov@yandex-team.ru>
 <20261028122042-mutt-send-email-mst@kernel.org>
 <23a4b45a-c545-43bd-abc5-c76d83ca0b0b@yandex-team.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a4b45a-c545-43bd-abc5-c76d83ca0b0b@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 11:05:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 28.10.26 19:21, Michael S. Tsirkin wrote:
> > Typo in the subject
> > 
> > On Wed, Sep 23, 2026 at 12:32:08AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Add test that run x-query-virtio-status QMP command, and its
> > > HMP analog.
> > > 
> > > Now QEMU crashes in these scenarios due to bugs, so the test-cases
> > > are skipped. You may run them by setting QEMU_FAILING_TESTS
> > > environment variable.
> > > 
> > > Following commits will fix bug and enable the test-cases.
> > > 
> > > Wrap QEMU run by "unshare" to access vhost-net without sudo.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > >   MAINTAINERS                                   |  1 +
> > >   tests/functional/qemu_test/testcase.py        |  9 +-
> > >   tests/functional/x86_64/meson.build           |  2 +
> > >   tests/functional/x86_64/test_virtio_status.py | 97 +++++++++++++++++++
> > >   4 files changed, 105 insertions(+), 4 deletions(-)
> > >   create mode 100755 tests/functional/x86_64/test_virtio_status.py
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6be9c5725b9..8bd7c8472d9 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2535,6 +2535,7 @@ F: include/hw/virtio/
> > >   F: docs/devel/virtio*
> > >   F: docs/devel/migration/virtio.rst
> > >   F: tests/functional/x86_64/test_virtio_version.py
> > > +F: tests/functional/x86_64/test_virtio_status.py
> > >   virtio-balloon
> > >   M: Michael S. Tsirkin <mst@redhat.com>
> > > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > > index bf2dc1dc101..d719b79eb1e 100644
> > > --- a/tests/functional/qemu_test/testcase.py
> > > +++ b/tests/functional/qemu_test/testcase.py
> > > @@ -387,12 +387,13 @@ def require_device(self, devicename):
> > >           if helptxt.find(devicename) < 0:
> > >               self.skipTest('no support for device ' + devicename)
> > > -    def _new_vm(self, name, monitor_address):
> > > +    def _new_vm(self, name, monitor_address, wrapper):
> > >           vm = QEMUMachine(self.qemu_bin,
> > >                            name=name,
> > >                            base_temp_dir=self.workdir,
> > >                            log_dir=self.log_file(),
> > > -                         monitor_address=monitor_address)
> > > +                         monitor_address=monitor_address,
> > > +                         wrapper=wrapper)
> > >           self.log.debug('QEMUMachine "%s" created', name)
> > >           self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
> > > @@ -407,11 +408,11 @@ def _new_vm(self, name, monitor_address):
> > >       def vm(self):
> > >           return self.get_vm(name='default')
> > > -    def get_vm(self, name=None, monitor_address=None):
> > > +    def get_vm(self, name=None, monitor_address=None, wrapper=()):
> > >           if not name:
> > >               name = str(uuid.uuid4())
> > >           if self._vms.get(name) is None:
> > > -            self._vms[name] = self._new_vm(name, monitor_address)
> > > +            self._vms[name] = self._new_vm(name, monitor_address, wrapper)
> > >               if self.cpu is not None:
> > >                   self._vms[name].add_args('-cpu', self.cpu)
> > >               if self.machine is not None:
> > > diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
> > > index 0353b2af8e1..62dedb2e203 100644
> > > --- a/tests/functional/x86_64/meson.build
> > > +++ b/tests/functional/x86_64/meson.build
> > > @@ -7,6 +7,7 @@ test_x86_64_timeouts = {
> > >     'netdev_ethtool' : 180,
> > >     'replay' : 480,
> > >     'virtio_balloon': 120,
> > > +  'virtio_status': 120,
> > >   }
> > >   tests_x86_64_system_quick = [
> > > @@ -50,5 +51,6 @@ tests_x86_64_system_thorough = [
> > >     'vhost_user_bridge',
> > >     'virtio_balloon',
> > >     'virtio_gpu',
> > > +  'virtio_status',
> > >     'rebuild_vmfd',
> > >   ]
> > > diff --git a/tests/functional/x86_64/test_virtio_status.py b/tests/functional/x86_64/test_virtio_status.py
> > > new file mode 100755
> > > index 00000000000..c8cbdf7c42e
> > > --- /dev/null
> > > +++ b/tests/functional/x86_64/test_virtio_status.py
> > > @@ -0,0 +1,97 @@
> > > +#!/usr/bin/env python3
> > > +#
> > > +# SPDX-License-Identifier: MIT
> > 
> > QEMU uses GPL v2.0 or later.
> 
> Hmm, but there are files with "SPDX-License-Identifier: MIT".. Is there a generic requirement somewhere?
> 
> I just wanted to create less problems for people, after this https://lore.kernel.org/qemu-devel/f88e2d78-68c3-4c56-9d3b-4deba3c49b20@oracle.com/ story.

After a change from GPLv2 was rejected?


> If you still prefer GPL v2.0, I don't care, let's switch. Should I resend this patch alone?
> 
> > 
> > > +
> > > +import os
> > > +import subprocess
> > > +
> > > +from qemu_test import (
> > > +    Asset,
> > > +    LinuxKernelTest,
> > > +    skipIfMissingCommands,
> > > +    skipIfMissingEnv,
> > > +)
> > > +
> > > +
> > > +class VirtioStatus(LinuxKernelTest):
> > > +    ASSET_KERNEL = Asset(
> > > +        "https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/"
> > > +        "netboot-3.24.2/vmlinuz-virt",
> > > +        "be8ae7782de532d1a791c97fbf9ddc955b9de78349382ad097c83ffe9db857f4")
> > > +    ASSET_INITRD = Asset(
> > > +        "https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/"
> > > +        "netboot-3.24.2/initramfs-virt",
> > > +        "385418a99b17c0ef44947d88ea448d43b2df4a2c3343da72e724c6cf3b05e9f7")
> > > +
> > > +    VIRTIO_PATH = "/machine/peripheral/net0/virtio-backend"
> > > +
> > > +    def setUp(self):
> > > +        super().setUp()
> > > +        self.qemu_wrapper = []
> > > +        self.require_accelerator("kvm")
> > > +        self.require_device("virtio-net-pci")
> > > +        self.set_machine("q35")
> > > +
> > > +    def has_hmp(self, vm):
> > > +        commands = vm.cmd('query-commands')
> > > +        return any(cmd['name'] == 'human-monitor-command' for cmd in commands)
> > > +
> > > +    def check_commands(self, vm):
> > > +        if self.has_hmp(vm):
> > > +            vm.cmd(
> > > +                "human-monitor-command",
> > > +                command_line="info virtio-status " + self.VIRTIO_PATH,
> > > +            )
> > > +        vm.cmd("x-query-virtio-status", path=self.VIRTIO_PATH)
> > > +
> > > +    @skipIfMissingCommands("unshare")
> > > +    @skipIfMissingEnv("QEMU_FAILING_TESTS")
> > > +    def test_vhost(self):
> > > +        self.require_netdev("tap")
> > > +        for device in ("/dev/net/tun", "/dev/vhost-net"):
> > > +            if not os.access(device, os.R_OK | os.W_OK):
> > > +                self.skipTest(f"Read/write access to {device} is required")
> > > +
> > > +        wrapper = ["unshare", "-Urn", "--"]
> > > +        probe = subprocess.run(wrapper + ["true"],
> > > +                               capture_output=True,
> > > +                               text=True, check=False)
> > > +        if probe.returncode:
> > > +            self.skipTest("User/network namespaces unavailable: " +
> > > +                          probe.stderr.strip())
> > > +
> > > +        vm = self.get_vm("wrapped", wrapper=wrapper)
> > > +
> > > +        kernel = self.ASSET_KERNEL.fetch()
> > > +        initrd = self.ASSET_INITRD.fetch()
> > > +
> > > +        vm.set_console()
> > > +        vm.add_args("-accel", "kvm")
> > > +        vm.add_args("-kernel", kernel,
> > > +                    "-initrd", initrd,
> > > +                    "-append", "console=ttyS0 modules=virtio_net",
> > > +                    "-netdev",
> > > +                    "tap,id=net,script=,downscript=,vhost=on",
> > > +                    "-device",
> > > +                    "virtio-net-pci,id=net0,netdev=net,romfile=")
> > > +        vm.launch()
> > > +
> > > +        # modules=virtio_net ensures the driver is loaded by this point
> > > +        self.wait_for_console_pattern("Loading boot drivers: ok.", vm=vm)
> > > +        vm.cmd(
> > > +            "x-query-virtio-vhost-queue-status", path=self.VIRTIO_PATH, queue=0
> > > +        )
> > > +
> > > +        self.check_commands(vm)
> > > +
> > > +    @skipIfMissingEnv("QEMU_FAILING_TESTS")
> > > +    def test_no_vhost(self):
> > > +        self.vm.add_args("-accel", "kvm",
> > > +                         "-S", "-net", "none", "-device",
> > > +                         "virtio-net-pci,id=net0,romfile=")
> > > +        self.vm.launch()
> > > +        self.check_commands(self.vm)
> > > +
> > > +
> > > +if __name__ == "__main__":
> > > +    LinuxKernelTest.main()
> > > -- 
> > > 2.43.0
> > 
> 
> 
> -- 
> Best regards,
> Vladimir


