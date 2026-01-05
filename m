Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64BCCD0400
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 20:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcrZv-0002q2-H3; Mon, 05 Jan 2026 15:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vcrZr-0002oo-VQ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 15:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vcrZp-00013u-0f
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 15:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767646398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2Ehd9f/u7FL5sR8XzfoCx9iDhfjnNUiKMqcdq2+RiE=;
 b=c6MIxt1RwkSMZRHCG8liEx1JHnIw9hdyqkPMKeF4oO9JYqnCWH4LU8p29DubcJoO49bO1N
 ypjy76SVYdWeB7blUXi06lJCK1s4nyC3Csv7J5q7bfV+rX8hLe61Tar2mdKmov2V8+LZFX
 swfQO7jSL+5UnRK+iasF8Bl7sxJ7vQA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-dhZN0bUlNx-cXkyOfasYJw-1; Mon, 05 Jan 2026 15:53:16 -0500
X-MC-Unique: dhZN0bUlNx-cXkyOfasYJw-1
X-Mimecast-MFC-AGG-ID: dhZN0bUlNx-cXkyOfasYJw_1767646395
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so4453975e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767646395; x=1768251195; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t2Ehd9f/u7FL5sR8XzfoCx9iDhfjnNUiKMqcdq2+RiE=;
 b=Sb0INivhLb2YX3sF21/XwCA8rXy3D3JPUsx5edv9utWW6bl4b6SCQQrYvLH/ar40QS
 bWG4f3p/7jlXUzaZiGhvR/nMXjWm8IZTyxma3+OclmxpHVtuyzDQgg1mIhxo2MQD8PEV
 +whgAAd7euwISPE5zlnWw/lujIPn3L+AuA37qvIzJeYLhBw4oYsNC9R+moTYC50BEooW
 jr3dKMxvH3QnMw98NWCrduVsZHIg5Cmf6onX9N9VZtKJwZ6roHlwV9VTkhv4j/B68DrL
 Ps4UE7xqiXtKb26h6YMHnhAp5gYbtYRxNJVcvxrv3PUoRUgo+xpb6DKjzpF6i+RaXowN
 uNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767646395; x=1768251195;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2Ehd9f/u7FL5sR8XzfoCx9iDhfjnNUiKMqcdq2+RiE=;
 b=Ts/NBWIQgbNAoGc3o8A1abH6h0jmR/c5q1A19M35ZbsYH0por2UI8oSP7+uNK0FqmP
 sPUlGxQxyqn7QHIi6oSt8Ywdj5w921MSEptc8HEQEoIcFV/1LUNYtu5u7iscRoBX3GFE
 vRrKa/HDoeaoxoR5qShP9hc8rbrLQJ9Z3UbgXZNv2XmI+czu/arfaXIWlIBiqmtV2ugU
 b9NunS43vG4JyyGNlWZwB15bo5wpL0G7N1rx4H3sEtzU++j8r6zISjUVQc/G884Ct7H4
 NcHfeKkBPi5CepgwBOOcvMqJh1bQqURgdd6JS0Hby9je8d6R0/sXUcmVnSYgqNpsAHdi
 Sblw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8j5eD+bCowRXepuO9/+EoYCOXMitZkNScSlaElvH/eOQblZd0hy/RYHAcBcozbb45ofQVY0gylCqG@nongnu.org
X-Gm-Message-State: AOJu0YzlSJHhA9NnMs6+1SFqqJwcCxnWLL6txH6WSSe5fRWenljW5qNN
 7/SqH504HFHa+w3GaLbdAx7cV/kg/mXAs4CFTyK0g12pqkL2WpavoEb2TPpJ/bq8ABjUhb6NKlG
 2nzrntnMUM+doa1pyT6XZilKMprrIxT2LL8113ZxIHQznj2iaxFBQxlSS
X-Gm-Gg: AY/fxX7A0JKBh40F/iALovUQi24jgs0UP/2apJ1EmKZXnGg+4BbYkQ8GLQ7UQI5rVbt
 r18G7JqbCU/SLXAT8ldJorych5neE2Wa3p3gClbhGbYWgVWGRQsOmNohtVTJUx2nPBLYHxL4ihq
 lDBLOdKsnMw1NdNCXjdvUjShMSty2wldQI4vqNPBrV8JVpfXlBwfXVaicNnk5FdsfxD9u4yTJ33
 TJyuz5HIzqGrTRFxtjY+iGpgT2yh9HeTZH+yqg+vmQlJ4yp9xnoi+8RNiZEf6YlPNDLGycefA/9
 wYiSlwynbP4j+Uww5+yjPn7usTyZ8h/YK/m+ZWG4FCZSxeG6gaq48Vaoha38qG5ElXKihm1cNYk
 FdhP7lM9fSmqh6zUAzoLoif4A4NSNFLFLGQ==
X-Received: by 2002:a05:600c:4447:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-47d7f076913mr9084355e9.12.1767646394935; 
 Mon, 05 Jan 2026 12:53:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT8drIbIziuIpSDEoL4BuRKGisf1XRjRd+amW1Eozc3yOxjfJEqx1ZI8Aev9TSwnWPvo2ccQ==
X-Received: by 2002:a05:600c:4447:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-47d7f076913mr9084055e9.12.1767646394466; 
 Mon, 05 Jan 2026 12:53:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fb20ef3sm1521265e9.3.2026.01.05.12.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 12:53:13 -0800 (PST)
Date: Mon, 5 Jan 2026 15:53:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH] tests/functional/x86_64: Add vhost-user-bridge test
Message-ID: <20260105154755-mutt-send-email-mst@kernel.org>
References: <20251230002604.113632-1-yodel.eldar@yodel.dev>
 <648af3ee-5a5b-4c50-9135-6eae776d37a8@redhat.com>
 <CAJ+F1CK78wLaYcjZPoU-9rufDM8pa6wWntn0hToQoF7syA2r3w@mail.gmail.com>
 <e54c0922-2134-4195-a9e2-bce3a295efe5@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e54c0922-2134-4195-a9e2-bce3a295efe5@yodel.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 05, 2026 at 02:28:53PM -0600, Yodel Eldar wrote:
> + MST + Stefano
> 
> Hi!
> 
> On 05/01/2026 05:21, Marc-André Lureau wrote:
> > Hi
> > 
> > On Mon, Jan 5, 2026 at 2:36 PM Cédric Le Goater <clg@redhat.com> wrote:
> > > 
> > > + Marc-André
> > > 
> > > (I don't know who maintains this test)
> > 
> > oh vhost-user-bridge is unmaintained...
> > 
> 
> And, it's not covered by MAINTAINERS.
> 
> Is vhost-user-bridge in tests/ instead of contrib/vhost-user-bridge/,
> because it preceded libvhost-user and the first contrib/vhost-user-*
> (vhost-user-scsi), or is tests/ really the best home for it?

I don't remember really.


> If there's interest, I can submit an RFC moving it and this functional
> test and creating a section for it in MAINTAINERS along these lines:
> 
>     diff --git a/MAINTAINERS b/MAINTAINERS
>     index cca9b57c02..742f865a7e 100644
>     --- a/MAINTAINERS
>     +++ b/MAINTAINERS
>     @@ -2774,0 +2775,5 @@ F: hw/display/vhost-user-*
>     +vhost-user-bridge
>     +S: Orphan
>     +F: contrib/vhost-user-bridge/
>     +F: tests/functional/x86_64/test_vhost_user_bridge.py
>     +

I'd rather add it with rest of vhost-user not mark it orphan.

> > > Thanks,
> > > 
> > > C.
> > > 
> > > 
> > > On 12/30/25 01:25, Yodel Eldar wrote:
> > > > This introduces a functional test of vhost-user-bridge.
> > > > 
> > > > The test runs vhost-user-bridge and launches a guest VM that connects
> > > > to the internet through it. The test succeeds if and only if an attempt
> > > > to connect to a hard-coded well-known URL succeeds.
> > > > 
> > > > Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> > > > ---
> > > > 
> > > > This patch introduces a functional test of vhost-user-bridge by
> > > > automating the testing described in its initial commit, 8e3b0cbb72,
> > > > with adjustments like using hubports (formerly the vlan parameter) and
> > > > memfd for the memory backend; hugepages are also omitted to avoid
> > > > requiring root privileges on the host.
> > > > 
> > > > The test configures networking within the guest by invoking udhcpc, then
> > > > makes an http request via wget to a well-known URL, example.org, that
> > > > has a low risk of requiring https for connections (a limitation of the
> > > > the test). An assert on the retcode of wget determines success/failure.
> > > > 
> > > > Please let me know if there are objections to the use of wget's retcode
> > > > as the test's condition; determining wget success through its output is
> > > > straightforward ("remote file exists"), but out of concern of some
> > > > unknown failure message (besides "bad address") locking up the test,
> > > > I've resorted to checking the retcode instead; perhaps, this violates
> > > > some convention?
> > 
> > Imho, the test shouldn't need internet connectivity. It could possibly
> > send custom crafted IP packets instead. wdyt?
> > 
> > 
> 
> That certainly alleviates concerns about depending on example.org to be
> up! The guest can ping the udhcpc-assigned gateway at 10.0.2.2, so that
> the test checks ping's output in the guest and for the guest's MAC
> address and the ping payload (with its -p option) in the vubr log. How
> does that sound? I'm open to other ideas.


The whole idea with vhost user bridge is to use slirp and not
depend on anything expernal.

> > > > 
> > > > Also, I figured checking for memfd support on the host was unnecessary
> > > > in 2026 for the intended users of the test, but perhaps not?
> > > > 
> > > > The guest's kernel contains an integrated initramfs and was built with
> > > > buildroot; an attempt to ensure bit-for-bit reproducibility was made by
> > > > building it via Containerfile based on a snapshot container image and
> > > > use of the BR2_REPRODUCIBLE option of buildroot, but the latter feature
> > > > is "experimental," so future builds may differ slightly (though the
> > > > image in the repo will be left untouched). The image and associated
> > > > build files are hosted on my personal account here:
> > > >        https://github.com/yodel/vhost-user-bridge-test
> > > > and will continue to be well into the future, but if there's some other
> > > > preferred location for the asset, please let me know?
> > 
> > Do we need a new kernel asset? I like the reproducible from scratch
> > way, maybe we should try to consolidate other tests around it. That's
> > just some thoughts.
> > 
> 
> I'm glad you like it! The kernel is significantly stripped of features,
> and has a minimally viable initramfs, so it may need some extending to
> be usable by the plethora of tests we've got.
> 
> If you meant informing the community about a preferred approach to image
> generation, I can add documentation in the manual to gently persuade
> folks to use a similar approach.
> 
> On the other hand, if we want to use the same image for all applicable
> tests, it may be beneficial to have the image/build files in-tree,
> because I anticipate folks will want to make changes to it as needed. If
> there's interest in that, I can prepare an RFC proposing it, though I'd
> look to the community for long-term maintenance of it.
> 
> Or, was there another option you had closer to mind?
> 
> Thanks,
> Yodel
> 
> > > > 
> > > > Lastly, special thanks to Cédric for inspiring me to write the test in
> > > > "<11454796-30d2-4a57-85a5-d42ff0dce2e6@redhat.com>".
> > > > 
> > > > Thanks,
> > > > Yodel
> > > > 
> > > >    .../x86_64/test_vhost_user_bridge.py          | 124 ++++++++++++++++++
> > > >    1 file changed, 124 insertions(+)
> > > >    create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
> > > > 
> > > > diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
> > > > new file mode 100755
> > > > index 0000000000..61afdbceec
> > > > --- /dev/null
> > > > +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
> > > > @@ -0,0 +1,124 @@
> > > > +#!/usr/bin/env python3
> > > > +#
> > > > +# Copyright (c) 2025 Software Freedom Conservancy, Inc.
> > > > +#
> > > > +# Author: Yodel Eldar <yodel.eldar@yodel.dev>
> > > > +#
> > > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > > +"""
> > > > +Test vhost-user-bridge (vubr) functionality:
> > > > +
> > > > +    1) Run vhost-user-bridge on the host.
> > > > +    2) Launch a guest VM:
> > > > +        a) Instantiate a unix domain socket to the vubr-created path
> > > > +        b) Instantiate a vhost-user net backend on top of that socket
> > > > +        c) Expose vhost-user with a virtio-net-pci interface
> > > > +        d) Instantiate UDP socket and user-mode net backends
> > > > +        e) Hub the UDP and user-mode backends
> > > > +    3) Run udhcpc in the guest to auto-configure networking.
> > > > +    4) Run wget in the guest and check its retcode to test internet connectivity
> > > > +
> > > > +The test fails if wget returns 1 and succeeds on 0.
> > > > +"""
> > > > +
> > > > +import os
> > > > +import subprocess
> > > > +from qemu_test import Asset, QemuSystemTest, which
> > > > +from qemu_test import exec_command_and_wait_for_pattern
> > > > +from qemu_test import is_readable_executable_file
> > > > +from qemu_test import wait_for_console_pattern
> > > > +from qemu_test.ports import Ports
> > > > +
> > > > +class VhostUserBridge(QemuSystemTest):
> > > > +
> > > > +    ASSET_KERNEL_INITRAMFS = Asset(
> > > > +        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/heads/main/bzImage",
> > > > +        "3790bf35e4ddfe062425bca45e923df5a5ee4de44e456d6b00cf47f04991d549")
> > > > +
> > > > +    def configure_vm(self, ud_socket_path, lport, rport):
> > > > +        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
> > > > +
> > > > +        self.require_accelerator("kvm")
> > > > +        self.require_netdev("vhost-user")
> > > > +        self.require_netdev("socket")
> > > > +        self.require_netdev("hubport")
> > > > +        self.require_netdev("user")
> > > > +        self.require_device("virtio-net-pci")
> > > > +        self.set_machine("q35")
> > > > +        self.vm.set_console()
> > > > +        self.vm.add_args(
> > > > +            "-cpu",      "host",
> > > > +            "-accel",    "kvm",
> > > > +            "-kernel",   kernel_path,
> > > > +            "-append",   "console=ttyS0",
> > > > +            "-smp",      "2",
> > > > +            "-m",        "128M",
> > > > +            "-object",   "memory-backend-memfd,id=mem0,"
> > > > +                         "size=128M,share=on,prealloc=on",
> > > > +            "-numa",     "node,memdev=mem0",
> > > > +            "-chardev", f"socket,id=char0,path={ud_socket_path}",
> > > > +            "-netdev",   "vhost-user,id=vhost0,chardev=char0,vhostforce=on",
> > > > +            "-device",   "virtio-net-pci,netdev=vhost0",
> > > > +            "-netdev",  f"socket,id=udp0,udp=localhost:{lport},"
> > > > +                        f"localaddr=localhost:{rport}",
> > > > +            "-netdev",   "hubport,id=hub0,hubid=0,netdev=udp0",
> > > > +            "-netdev",   "user,id=user0",
> > > > +            "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
> > > > +        )
> > > > +
> > > > +    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
> > > > +        vubr_args = []
> > > > +
> > > > +        if (stdbuf_path := which("stdbuf")) is None:
> > > > +            self.log.info("Could not find stdbuf: vhost-user-bridge "
> > > > +                          "log lines may appear out of order")
> > > > +        else:
> > > > +            vubr_args += [stdbuf_path, "-o0", "-e0"]
> > > > +
> > > > +        vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
> > > > +                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{rport}"]
> > > > +
> > > > +        return vubr_args
> > > > +
> > > > +    def test_vhost_user_bridge(self):
> > > > +        prompt = "~ # "
> > > > +
> > > > +        vubr_path = self.build_file("tests", "vhost-user-bridge")
> > > > +        if is_readable_executable_file(vubr_path) is None:
> > > > +            self.skipTest("Could not find a readable and executable "
> > > > +                          "vhost-user-bridge")
> > > > +
> > > > +        with Ports() as ports:
> > > > +            sock_dir = self.socket_dir()
> > > > +            ud_socket_path = os.path.join(sock_dir.name, "vubr-test.sock")
> > > > +            lport, rport = ports.find_free_ports(2)
> > > > +
> > > > +            self.configure_vm(ud_socket_path, lport, rport)
> > > > +
> > > > +            vubr_log_path = self.log_file("vhost-user-bridge.log")
> > > > +            self.log.info("For the vhost-user-bridge application log,"
> > > > +                         f" see: {vubr_log_path}")
> > > > +
> > > > +            vubr_args = self.assemble_vubr_args(vubr_path, ud_socket_path,
> > > > +                                                lport, rport)
> > > > +
> > > > +            with open(vubr_log_path, "w") as vubr_log, \
> > > > +                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
> > > > +                                  stdout=vubr_log, stderr=subprocess.STDOUT):
> > > > +                self.vm.launch()
> > > > +
> > > > +                wait_for_console_pattern(self, prompt)
> > > > +                exec_command_and_wait_for_pattern(self, "udhcpc -nt 1", prompt)
> > > > +                exec_command_and_wait_for_pattern(self,
> > > > +                    "wget -qT 2 --spider example.org", prompt)
> > > > +
> > > > +                try:
> > > > +                    exec_command_and_wait_for_pattern(self, "echo $?", "0", "1")
> > > > +                except AssertionError:
> > > > +                    self.log.error("Unable to confirm internet connectivity")
> > > > +                    raise
> > > > +                finally:
> > > > +                    self.vm.shutdown()
> > > > +
> > > > +if __name__ == '__main__':
> > > > +    QemuSystemTest.main()
> > > 
> > > 
> > 
> > 


