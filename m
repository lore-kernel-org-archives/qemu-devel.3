Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E6D2F339
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 16:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfh6W-0008Dt-Gb; Tue, 13 Jan 2026 11:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfh6E-00088R-3U
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:18:31 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vfh6A-0006OC-Ko
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:18:28 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4ffbc2b861eso68128481cf.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 08:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768321105; x=1768925905; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZQ3rxvkBPWCzuq/iMjNOjo2tEAE82teY1GGEBVL9F8=;
 b=Juzd2cYlzi/ZAK+VrXWZkTC1+X2yU4QpNt7s+axT7xsQsBJi+A48GcKgAOK8RHx5Fl
 WdwdxsaFwVEqxq853WxCqYslW2akOXLS3AV8DuowAVF3875QBHB6wx6qkKhN1D12CAH4
 xud8Blu4Iw3qlcPyg7ecav8s6J2K686xo1g8/YhM/3vsq4nenJzTuBKEVH54XSHIowJl
 Rtziah9lcp1tQ5R4ZXxd+s0L4ACMYov3E0FMGYb378l8yfO1tS8P51qrGGr/C9cw/+Op
 4N+CzC9KVG4xoho8FQDI4H4KndEgsh8ygjfvr14r+zsTqMXyMyk+FPWoAAdLEHCRu2u8
 zS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768321105; x=1768925905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iZQ3rxvkBPWCzuq/iMjNOjo2tEAE82teY1GGEBVL9F8=;
 b=gqqd93koCxKK4j47RGSJQf/dShXJaMdlTtABV2iaH++rmszNMeGM4/R8g0gUHCtaCz
 KbB+G0rBldLqBNcI7/grD/e2tjwfqo9N+FrxmKlhEKDh1++541+NV5Q67dTMgqYO0NcK
 /OAIkOoyaUm7IWggoJf5HQKcqGLsCQ8l/7vCP3MZmJZ2idfhFzyAAJbox7tKn3pUHhJb
 L1w761QO1svoAPMs7L9chsMVTQJX+hmh3kYEe7sC7We9CQgwmlyIMxAzzQq44nSlKvjn
 Z5L8X0TCk6SPvO6l/SfA4dbpjAIFX631CmqhA3yl4gc/s5wFJcfDYqdHQesX9yt1Q9FA
 sT/g==
X-Gm-Message-State: AOJu0YxsoygisO3V2jpn4fkgtAATkeNfNmUFk+r/TPv7MHn8pvENW+MD
 PnvJ1InnffqkFq2oZpHbXZ1roBMUtp6u8YttBfc5CzeX2g5yjdujqf+RnPLGPGBibPakxv16Y4o
 +q2uWwnJDtPATl5I6cVrDZloZ0SWyrHM=
X-Gm-Gg: AY/fxX5ejBJtIBFPZnYxjkkCHoLzhMqfXVW2AVbDnYS+t+UapkJ6enln6Xn39JLt+dD
 qWFV4ulcmknoH7rcfnHtNnH16xv49IqOjWvAy56Cy0+MzQBpZ9GNdZrzKWDh688BxUA7SPH2bfw
 BmWrFsorxIr98aP/ImoPyyLcbYUaEiCUrOqFC5Pr2oDSLJKo7fWbK5wVx1XpSOSJ1UmTB4QKsVV
 tGBG4zQMiF+S4XMLpsLUR11SlpmwNoW4T+VRjHdPw166hz853IPwJM/AX8lFyZN7GwVIeGz5ZNl
 M5dEUFXjM4pjpPxju/jlL0FrsZcYUXYG1qUM5w==
X-Google-Smtp-Source: AGHT+IEOdSZsYZdJmdXRkwjYdwjW02eIX82RKwVzRIPUuBpW6cveSJGuKF57UuSg5c9I6mlA9cBP2QC1DUOt4SkDT9s=
X-Received: by 2002:a05:622a:5813:b0:501:46f5:5080 with SMTP id
 d75a77b69052e-50146f55452mr6990901cf.41.1768321103678; Tue, 13 Jan 2026
 08:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20260112230127.99125-1-yodel.eldar@yodel.dev>
 <20260112230127.99125-3-yodel.eldar@yodel.dev>
In-Reply-To: <20260112230127.99125-3-yodel.eldar@yodel.dev>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jan 2026 20:18:12 +0400
X-Gm-Features: AZwV_QiymtOUE_EHIk-CavoH4ARCtSkISER4hG4fJfRRBb9WZxKFk6bfIZlvaFw
Message-ID: <CAJ+F1C+_BiMR_rzE9s_o7eE-bxrx_o_77NYfuD7nvX2=WpzYYw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] tests/functional/x86_64: Add vhost-user-bridge
 test
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jan 13, 2026 at 3:02=E2=80=AFAM Yodel Eldar <yodel.eldar@yodel.dev>=
 wrote:
>
> Introduce a functional test of vhost-user-bridge and enter it into
> MAINTAINERS under the vhost section.
>
> The test runs vhost-user-bridge as a subprocess, then launches a guest
> with four backends: a unix domain socket for vhost-user, a UDP socket, a
> user-mode net, and a hubport to hub the UDP and user backends; only the
> vhost-user backend is exposed, the rest are deviceless. This
> configuration mimics the testing setup described in the initial commit
> of vhost-user-bridge in 3595e2eb0a23.
>
> A file containing a hardcoded UUID is created by the test in a scratch
> file and exposed to the guest via the tftp parameter of the user netdev.
> The guest requests the file by invoking tftp, and the test verifies its
> sha256 hashsum.
>
> Similarly, a file containing another hardcoded UUID is created in the
> guest. A call to check_http_download() serves the file via http to the
> host and verifies integrity with its hashsum.
>
> Suggested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

by the way, have you left out adding the test to meson on purpose?

+++ b/tests/functional/x86_64/meson.build
@@ -36,4 +36,5 @@ tests_x86_64_system_thorough =3D [
   'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
+  'vhost_user_bridge',
 ]


As I dig into the image creation process, I wonder if your approach
will stand the test of time.

It seems mkosi is the most promising project to create reproducible
bootable images, and that we are moving to UKI instead of separate
initramfs.

Of course it's neat that you managed to put together a buildroot
script that produces a 14Mb bzImage for the test, but it's also slow
to build and perhaps not flexible enough if we generalize this
approach to other built images in the future.


> ---
>  MAINTAINERS                                   |   1 +
>  .../x86_64/test_vhost_user_bridge.py          | 147 ++++++++++++++++++
>  2 files changed, 148 insertions(+)
>  create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a46c7fd0b..f41811d482 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2374,32 +2374,33 @@ F: docs/devel/vfio-iommufd.rst
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  R: Stefano Garzarella <sgarzare@redhat.com>
>  S: Supported
>  F: hw/*/*vhost*
>  F: docs/interop/vhost-user*
>  F: docs/system/devices/vhost-user*
>  F: contrib/vhost-user-*/
>  F: backends/*vhost*
>  F: include/system/vhost-user-backend.h
>  F: include/hw/virtio/vhost*
>  F: include/*/vhost*
>  F: subprojects/libvhost-user/
>  F: block/export/vhost-user*
>  F: util/vhost-user-server.c
>  F: net/vhost*
> +F: tests/functional/x86_64/test_vhost_user_bridge.py
>
>  vhost-shadow-virtqueue
>  R: Eugenio P=C3=A9rez <eperezma@redhat.com>
>  F: hw/virtio/vhost-shadow-virtqueue.*
>
>  virtio
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported
>  F: hw/*/virtio*
>  F: hw/virtio/Makefile.objs
>  F: hw/virtio/trace-events
>  F: qapi/virtio.json
>  F: net/vhost-user.c
>  F: include/hw/virtio/
>  F: docs/devel/virtio*
>  F: docs/devel/migration/virtio.rst
> diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/fu=
nctional/x86_64/test_vhost_user_bridge.py
> new file mode 100755
> index 0000000000..bf152dc959
> --- /dev/null
> +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
> @@ -0,0 +1,147 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) 2025 Software Freedom Conservancy, Inc.
> +#
> +# Author: Yodel Eldar <yodel.eldar@yodel.dev>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +"""
> +Test vhost-user-bridge (vubr) functionality:
> +
> +    1) Run vhost-user-bridge on the host.
> +    2) Launch a guest VM:
> +        a) Instantiate a unix domain socket to the vubr-created path
> +        b) Instantiate a vhost-user backend on top of that socket
> +        c) Map a virtio-net-pci device to the vhost-user backend
> +        d) Instantiate a UDP socket backend
> +        e) Instantiate a user-mode net backend
> +            i) Forward an ephemeral port to port 8080 in-guest with host=
fwd=3D
> +            ii) Expose a generated scratch file to the guest with tftp=
=3D
> +        f) Hub the UDP and user-mode backends.
> +    3) Invoke tftp in the guest to download exported scratch file from t=
he host.
> +    4) Serve a file to the host via http server in the guest.
> +"""
> +
> +import os
> +import shutil
> +import subprocess
> +from qemu_test import Asset, LinuxKernelTest, which
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import is_readable_executable_file
> +from qemu_test import wait_for_console_pattern
> +from qemu_test.ports import Ports
> +
> +class VhostUserBridge(LinuxKernelTest):
> +
> +    ASSET_KERNEL_INITRAMFS =3D Asset(
> +        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/heads/=
main/bzImage",
> +        "8860d7aa59434f483542cdf25b42eacae0d4d4aa7ec923af9589d1ad4703d42=
b")
> +
> +    HOST_UUID =3D "ba4c2e39-627f-487d-ae3b-93cc5d783eb8"
> +    HOST_UUID_HSUM =3D \
> +        "d2932e34bf6c17b33e7325140b691e27c191d9ac4dfa550f68c09506facb09b=
9"
> +
> +    GUEST_UUID =3D "143d2b21-fdf0-4c5e-a9ef-f35ebbac8945"
> +    GUEST_UUID_HSUM =3D \
> +        "14b64203f5cf2afe520f8be0fdfe630aafc1e85d1301f55a0d1681e68881f3a=
2"
> +
> +    def configure_vm(self, ud_socket_path, lport, rport, hostfwd_port, t=
ftpdir):
> +        self.require_accelerator("kvm")
> +        self.require_netdev("vhost-user")
> +        self.require_netdev("socket")
> +        self.require_netdev("hubport")
> +        self.require_netdev("user")
> +        self.require_device("virtio-net-pci")
> +        self.set_machine("q35")
> +        self.vm.add_args(
> +            "-cpu",      "host",
> +            "-accel",    "kvm",
> +            "-append",   "printk.time=3D0 console=3DttyS0",
> +            "-smp",      "2",
> +            "-m",        "128M",
> +            "-object",   "memory-backend-memfd,id=3Dmem0,"
> +                         "size=3D128M,share=3Don,prealloc=3Don",
> +            "-numa",     "node,memdev=3Dmem0",
> +            "-chardev", f"socket,id=3Dchar0,path=3D{ud_socket_path}",
> +            "-netdev",   "vhost-user,id=3Dvhost0,chardev=3Dchar0,vhostfo=
rce=3Don",
> +            "-device",   "virtio-net-pci,netdev=3Dvhost0",
> +            "-netdev",  f"socket,id=3Dudp0,udp=3Dlocalhost:{lport},"
> +                        f"localaddr=3Dlocalhost:{rport}",
> +            "-netdev",   "hubport,id=3Dhub0,hubid=3D0,netdev=3Dudp0",
> +            "-netdev",   "user,id=3Duser0,"
> +                        f"hostfwd=3Dtcp:127.0.0.1:{hostfwd_port}-:8080,"
> +                        f"tftp=3D{tftpdir}",
> +            "-netdev",   "hubport,id=3Dhub1,hubid=3D0,netdev=3Duser0"
> +        )
> +
> +    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport=
):
> +        vubr_args =3D []
> +
> +        if (stdbuf_path :=3D which("stdbuf")) is None:
> +            self.log.info("Could not find stdbuf: vhost-user-bridge "
> +                          "log lines may appear out of order")
> +        else:
> +            vubr_args +=3D [stdbuf_path, "-o0", "-e0"]
> +
> +        vubr_args +=3D [vubr_path, "-u", f"{ud_socket_path}",
> +                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{rpo=
rt}"]
> +
> +        return vubr_args
> +
> +    def test_vhost_user_bridge(self):
> +        prompt =3D "~ # "
> +        host_uuid_filename =3D "vubr-test-uuid.txt"
> +        guest_uuid_path =3D "/tmp/uuid.txt"
> +        kernel_path =3D self.ASSET_KERNEL_INITRAMFS.fetch()
> +
> +        vubr_path =3D self.build_file("contrib", "vhost-user-bridge",
> +                                    "vhost-user-bridge")
> +        if is_readable_executable_file(vubr_path) is None:
> +            self.skipTest("Could not find a readable and executable "
> +                          "vhost-user-bridge")
> +
> +        vubr_log_path =3D self.log_file("vhost-user-bridge.log")
> +        self.log.info("For the vhost-user-bridge application log,"
> +                     f" see: {vubr_log_path}")
> +
> +        sock_dir =3D self.socket_dir()
> +        ud_socket_path =3D os.path.join(sock_dir.name, "vubr-test.sock")
> +
> +        tftpdir =3D self.scratch_file("tftp")
> +        shutil.rmtree(tftpdir, ignore_errors=3DTrue)
> +        os.mkdir(tftpdir)
> +        host_uuid_path =3D self.scratch_file("tftp", host_uuid_filename)
> +        with open(host_uuid_path, "w") as host_uuid_file:
> +            host_uuid_file.write(self.HOST_UUID)
> +
> +        with Ports() as ports:
> +            lport, rport, hostfwd_port =3D ports.find_free_ports(3)
> +
> +            self.configure_vm(ud_socket_path, lport, rport, hostfwd_port=
,
> +                              tftpdir)
> +
> +            vubr_args =3D self.assemble_vubr_args(vubr_path, ud_socket_p=
ath,
> +                                                lport, rport)
> +
> +            with open(vubr_log_path, "w+") as vubr_log, \
> +                 subprocess.Popen(vubr_args, stdin=3Dsubprocess.DEVNULL,
> +                                  stdout=3Dvubr_log,
> +                                  stderr=3Dsubprocess.STDOUT) as vubr_pr=
oc:
> +                self.launch_kernel(kernel_path, wait_for=3Dprompt)
> +
> +                exec_command_and_wait_for_pattern(self,
> +                    f"tftp -g -r {host_uuid_filename} 10.0.2.2 ; "
> +                    f"sha256sum {host_uuid_filename}", self.HOST_UUID_HS=
UM)
> +                wait_for_console_pattern(self, prompt)
> +
> +                exec_command_and_wait_for_pattern(self,
> +                    f"echo -n '{self.GUEST_UUID}' > {guest_uuid_path}", =
prompt)
> +                self.check_http_download(guest_uuid_path, self.GUEST_UUI=
D_HSUM)
> +                wait_for_console_pattern(self, prompt)
> +
> +                self.vm.shutdown()
> +                vubr_proc.terminate()
> +                vubr_proc.wait()
> +
> +if __name__ =3D=3D '__main__':
> +    LinuxKernelTest.main()
> --
> 2.52.0
>


--=20
Marc-Andr=C3=A9 Lureau

