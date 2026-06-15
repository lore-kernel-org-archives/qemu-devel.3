Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024FECD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ235-0004OE-7H; Mon, 15 Jun 2026 03:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wZ232-0004Fj-To; Mon, 15 Jun 2026 03:47:56 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wZ230-0005Zf-QN; Mon, 15 Jun 2026 03:47:56 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 5BCC11D0011B;
 Mon, 15 Jun 2026 03:47:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 03:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1781509673; x=
 1781596073; bh=xsrfOoVx68KGZLT4cvBPreibWZTSFV8C6AR/pTGysMs=; b=b
 7FedgnLGwkLljKCGBXeQXjci2f4eN995Z4cMIBGg41WfnSbIBM2+OUCk/C5SKMR3
 ZG7PnDnXTU23TJkx90OycvLU9sFu0Ms/Vit+lX75CdrTYPs3IBcsS2uAbMFDS+eb
 psUMorkhx1PQDMV/+zHSXD9u8bya1PJynLhU/RM9LDxk5R21Wa+/ImcT5iIGSsV0
 VRG5PYOOkngwyF6XOKvOWOAj2n93Ew5kO4r2VkAn2RmayXv0ydbBI5FxOiRbMa32
 iZFndAKOgny/cYtfmro1DVRB/gTMX3f8UJpZjyblQAiFOqES3q3dpX3NgFbaNTOx
 0zMuli3ik+RzCNY+Atqew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1781509673; x=1781596073; bh=xsrfOoVx68KGZLT4cvBPreibWZTSFV8C6AR
 /pTGysMs=; b=GWf9mp+OUvIYC5RqC1zVG3b6lzuNmaJDlYlu1n/aFq7B99w3e/n
 6//nUolOxK2nVKHAUh8u2MhwUSOMatotzKMIYa3RWqiaqhnoBW81AzW12PrQNicp
 nFigpZ8JGyI0Du7QMQIm76WR+jxzmIxsHRGzo9FSDrl7JAoJJDUTsgrWrTsa7+LJ
 Wzdt+eHx66tMw0IjTV9UwaxdAydJGBQqqMFZ5ewyZj4liNUgR3Utw2BN5aRwnvT0
 lwZGkQ8IbRAIHMxAX2QImKFzqZHKCi9ALzzKq1h2+/Q7mF0E2hRO3t8+Kg0aR+OO
 rt451Q0i8z1hvYZRY/EcJ8O4WAAXk1TMeCA==
X-ME-Sender: <xms:KK4vaoPc7YTHeKIe43Vfn79IA6Xlv5XIn2YCWe4Jsoh9vguv2CJ-oA>
 <xme:KK4vav4TYWyDhILzk3HgHP2ZgVreU_10dsy7WSVv5q1R1eJZN4rjQVfcv7GAo125h
 jd2nVwUFFZEQ5mYQl1Or6nJmicDMswPiyGHgqTuwkEA-HtmHT5SsQ>
X-ME-Received: <xmr:KK4vavm8IO4XYLzEXbmMiFjCsgjGIFkGlsf3wDlQYItPQpvLH76_5aSFXPwl5Q>
X-ME-Proxy-Cause: dmFkZTFeni88l8NyMZlwisqe+AAzWx9XF1+Hj0uxUAVC7FZKf8372nFWl8thIoYJ+20ujq
 p9HFbMSkpKc4r6UKROzbT7zwuFyOj8PWEXCBREo5pw3X2cWr8QUxCbORanNHSEY8W9LHkp
 NeESAgrM2dox0FCZ3YdFCwXIgNIeEy2NhT+MkPJH3dKwqfrcRLnksNQ4EyNB4CCGnxoS5N
 8gDIa1bKA9oOYA6uQJ6BUemh5bZaOqDTrqeaV3013zMNaQbjnH1ej2oJH+pOGFhSQaghAb
 sM1v2r0N+c3xXi8Bu8Wi0GkMyPD1bjpDIMPjzlm01kIJHUR0vCUXO2WBW15yM4EUJj1XjY
 MacwB9loDapvkZqkWwXfrF2U3J1j13C4+EJXnJ2GCeMsUA5boyiZgRLAXqdP1rneEkUO/6
 PFky/T/cKhzRmtF/juVetaGFj5Vf1mPNtskCtSLKmGeiJ60QziGWOXDH7iR08mLUzEw7M2
 WVnaVo1/xTOIdkXG962L5U8NDL/QswroJFW+rnbO76xR2RTCxMSb7ikg6VaSqhltiZBsuk
 QObqN2P6BNQgrBE+bkwHjpsKCPK6No5UtvtD7wPqefJwcAu4li6p36lQD7t+yktoMK8WUT
 U199FHLHKq+9XybtKrdQ5hCr4twCFM9LTrJPFf8oUsEPNn8gLFfv5KnLIUFg
X-ME-Proxy: <xmx:KK4vavL1xZ7lCfHgUOr1uUYMDmbXMIiMUgMsFRbTAobUDs9AT-pPSA>
 <xmx:KK4vanTGTsa74E-SqMf4_r9aREtJ165hOydauMVlFT370P7ecBUaTQ>
 <xmx:KK4vakt2CwqdfcqI78j3NbT-FrBMjus9RzQPtt5qLFf_lvfgIa3VZw>
 <xmx:KK4vai9cLm2IGve9-aIgtPwGrp_xlC_vO8Uspr0dgXjKfU76PR3-nw>
 <xmx:Ka4vasUOwBxRR3QhkDmcT-QIJDju_vd1yvvK_wxL0VyHQ0sXOI80ONkN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 03:47:52 -0400 (EDT)
Date: Mon, 15 Jun 2026 09:47:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v10 7/8] tests/functional/x86_64: add migration test for
 NVMe device
Message-ID: <ai-uJ8mr4uI9Hxc6@AALNPWKJENSEN.aal.scsc.local>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
 <20260611180842.6390-8-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EriCkyEuq3/QeyIh"
Content-Disposition: inline
In-Reply-To: <20260611180842.6390-8-alexander@mihalicyn.com>
Received-SPF: pass client-ip=202.12.124.150; envelope-from=its@irrelevant.dk;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--EriCkyEuq3/QeyIh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 11 20:08, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>=20
> Introduce a very simple test to ensure that NVMe device
> migration works fine.
>=20
> Test plan is simple:
> 1. prepare VM with NVMe device
> 2. run workload that produces relatively heavy IO on the device
> 3. migrate VM
> 4. ensure that workload is alive and finishes without errors
>=20
> Test can be run as simple as:
> $ meson test 'func-x86_64-nvme_migration' --setup thorough -C build
>=20
> In the future we can extend this approach, and introduce some
> fio-based tests. And probably, it makes sense to make this test
> to apply not only to NVMe device, but also virtio-{blk,scsi},
> ide, sata and other migratable devices.
>=20
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>

Acked-by: Klaus Jensen <k.jensen@samsung.com>

> ---
> v9:
>     - check-patch fixes
> ---
>  MAINTAINERS                                   |   1 +
>  tests/functional/x86_64/meson.build           |   1 +
>  .../functional/x86_64/test_nvme_migration.py  | 172 ++++++++++++++++++
>  3 files changed, 174 insertions(+)
>  create mode 100755 tests/functional/x86_64/test_nvme_migration.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b5b581e173..d705f5c8e0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2622,6 +2622,7 @@ S: Supported
>  F: hw/nvme/*
>  F: include/block/nvme.h
>  F: tests/qtest/nvme-test.c
> +F: tests/functional/x86_64/test_nvme_migration.py
>  F: docs/system/devices/nvme.rst
>  T: git git://git.infradead.org/qemu-nvme.git nvme-next
> =20
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_6=
4/meson.build
> index 1ed10ad6c29..fd77f19d726 100644
> --- a/tests/functional/x86_64/meson.build
> +++ b/tests/functional/x86_64/meson.build
> @@ -37,6 +37,7 @@ tests_x86_64_system_thorough =3D [
>    'linux_initrd',
>    'multiprocess',
>    'netdev_ethtool',
> +  'nvme_migration',
>    'replay',
>    'reverse_debug',
>    'tuxrun',
> diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/funct=
ional/x86_64/test_nvme_migration.py
> new file mode 100755
> index 00000000000..890f0aab6d6
> --- /dev/null
> +++ b/tests/functional/x86_64/test_nvme_migration.py
> @@ -0,0 +1,172 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# x86_64 NVMe migration test
> +
> +from migration import MigrationTest
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import exec_command, exec_command_and_wait_for_pattern
> +
> +
> +class X8664NVMeMigrationTest(MigrationTest):
> +    ASSET_KERNEL =3D Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/re=
leases'
> +         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
> +        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda0012=
9')
> +
> +    ASSET_INITRD =3D Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/re=
leases'
> +         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
> +        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8=
b')
> +
> +    ASSET_DISKIMAGE =3D Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/re=
leases'
> +         '/31/Cloud/x86_64/images/Fedora-Cloud-Base-31-1.9.x86_64.qcow2'=
),
> +        'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a=
0')
> +
> +    DEFAULT_KERNEL_PARAMS =3D ('root=3D/dev/nvme0n1p1 console=3DttyS0 ne=
t.ifnames=3D0 '
> +                             'rd.rescue quiet')
> +
> +    def wait_for_console_pattern(self, success_message, vm):
> +        wait_for_console_pattern(
> +            self,
> +            success_message,
> +            failure_message=3D"Kernel panic - not syncing",
> +            vm=3Dvm,
> +        )
> +
> +    def exec_command_and_check(self, command, vm):
> +        prompt =3D '# '
> +        exec_command_and_wait_for_pattern(self,
> +                                        f"{command} && echo OK || echo F=
AIL",
> +                                        'FAIL', vm=3Dvm)
> +        # Note, that commands we send to the console are echo-ed back,
> +        # so if we have a word "FAIL" in the command itself, we should
> +        # expect to see it once.
> +        wait_for_console_pattern(self, 'OK', failure_message=3D"FAIL", v=
m=3Dvm)
> +        self.wait_for_console_pattern(prompt, vm)
> +
> +    def configure_machine(self, vm):
> +        kernel_path =3D self.ASSET_KERNEL.fetch()
> +        initrd_path =3D self.ASSET_INITRD.fetch()
> +        diskimage_path =3D self.ASSET_DISKIMAGE.fetch()
> +
> +        vm.set_console()
> +        vm.add_args("-cpu", "max")
> +        vm.add_args("-m", "2G")
> +        vm.add_args("-accel", "kvm")
> +
> +        vm.add_args('-drive',
> +                         f'file=3D{diskimage_path},if=3Dnone,id=3Ddrv0,s=
napshot=3Don')
> +        vm.add_args('-device', 'nvme,bus=3Dpcie.0,' +
> +                    'drive=3Ddrv0,id=3Dnvme-disk0,serial=3Dnvmemigtest,b=
ootindex=3D1')
> +
> +        vm.add_args(
> +            "-kernel",
> +            kernel_path,
> +            "-initrd",
> +            initrd_path,
> +            "-append",
> +            self.DEFAULT_KERNEL_PARAMS
> +        )
> +
> +    def launch_source_vm(self, vm):
> +        vm.launch()
> +
> +        self.wait_for_console_pattern('Entering emergency mode.', vm)
> +        prompt =3D '# '
> +        self.wait_for_console_pattern(prompt, vm)
> +
> +        # Synchronize on NVMe driver creating the root device
> +        exec_command_and_wait_for_pattern(self,
> +                        "while ! (dmesg -c | grep nvme0n1:) ; do sleep 1=
 ; done",
> +                        "nvme0n1", vm=3Dvm)
> +        self.wait_for_console_pattern(prompt, vm)
> +
> +        # prepare system
> +        exec_command_and_wait_for_pattern(self, 'mount /dev/nvme0n1p1 /s=
ysroot',
> +                                          prompt, vm=3Dvm)
> +        exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
> +                                          prompt, vm=3Dvm)
> +        exec_command_and_wait_for_pattern(self, 'mount -t proc proc /pro=
c',
> +                                          prompt, vm=3Dvm)
> +        exec_command_and_wait_for_pattern(self, 'mount -t sysfs sysfs /s=
ys',
> +                                          prompt, vm=3Dvm)
> +
> +        # Run workload before migration to check if it continues
> +        # to run properly after migration.
> +        #
> +        # Workload is simple: it continuously calculates checksums of
> +        # all files in /usr/bin to generate some I/O load on
> +        # the NVMe disk and at the same time it drops caches to
> +        # make sure that we have some read I/O on the disk as well.
> +        # If there are any issues with the migration of the NVMe device,
> +        # we should see errors in dmesg and consequently in the workload=
 log.
> +        exec_command_and_wait_for_pattern(self,
> +            "(while [ ! -f /tmp/test_nvme_mig_workload.stop ]; do \
> +                rm -f /tmp/test_nvme_mig_workload.iter_finished; \
> +                echo 3 > /proc/sys/vm/drop_caches; \
> +                find /usr/bin -type f -exec cksum {} \\;; \
> +                touch /tmp/test_nvme_mig_workload.iter_finished; \
> +            done) > /dev/null 2> /tmp/test_nvme_mig_workload.errors &",
> +            prompt, vm=3Dvm)
> +        exec_command_and_wait_for_pattern(self,
> +            'echo $! > /tmp/test_nvme_mig_workload.pid',
> +            prompt, vm=3Dvm)
> +
> +        # check if process is alive and running
> +        self.exec_command_and_check(
> +            "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
> +
> +    def assert_dest_vm(self, vm):
> +        prompt =3D '# '
> +
> +        # check if process is alive and running after migration,
> +        # if not - fail the test
> +        self.exec_command_and_check(
> +            "kill -0 $(cat /tmp/test_nvme_mig_workload.pid)", vm)
> +
> +        # signal workload to stop
> +        exec_command_and_wait_for_pattern(self,
> +            'touch /tmp/test_nvme_mig_workload.stop',
> +            prompt, vm=3Dvm)
> +
> +        # wait workload to finish, because we want to examine log
> +        # to see if there are any errors
> +        exec_command_and_wait_for_pattern(self,
> +            "while [ ! -f /tmp/test_nvme_mig_workload.iter_finished ]; d=
o \
> +                sleep 1; \
> +            done;",
> +            prompt, vm=3Dvm)
> +
> +        exec_command_and_wait_for_pattern(self,
> +            'cat /tmp/test_nvme_mig_workload.errors',
> +            prompt, vm=3Dvm)
> +
> +        # fail the test if non-empty
> +        self.exec_command_and_check(
> +            "[ ! -s /tmp/test_nvme_mig_workload.errors ]", vm)
> +
> +    def test_migration_with_tcp_localhost(self):
> +        self.set_machine('q35')
> +        self.require_accelerator("kvm")
> +
> +        self.migration_with_tcp_localhost()
> +
> +    def test_migration_with_unix(self):
> +        self.set_machine('q35')
> +        self.require_accelerator("kvm")
> +
> +        self.migration_with_unix()
> +
> +    def test_migration_with_exec(self):
> +        self.set_machine('q35')
> +        self.require_accelerator("kvm")
> +
> +        self.migration_with_exec()
> +
> +
> +if __name__ =3D=3D '__main__':
> +    MigrationTest.main()
> --=20
> 2.47.3
>=20
>=20

--EriCkyEuq3/QeyIh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmovriYACgkQTeGvMW1P
DeluGAf/eBfhP22WdOa40VEDof0BC8xY5q7XvWekNWbGB+UZOZh22EIMXYPRlUyj
hUPaBfgkjQGv5rQ8utPZ8mJYtwcPdM5zAOUqpNNzMgbywy5gxGLWZMpkEYrowG/S
eY3p2m0GC0NTxc7RNtBe5PFuu+cjOPWUvrrAr6KJh3UCk6MDgwoyZnfPZ2xIEN9/
6nF+tTet7PYhw7pPVvja5CUQmMx1F1yQPXAmXEVO/eRZB3SmMj/7XAh39qnXgOjw
x0CELJ8pxRaOIUtmExMk7aeSJUdlkoQcJUgIWr3Z7PhHYHEYvuZQZ4XfzYiXbwM0
vM7S2AANSp9AXiacWigCZmzUe0k4bA==
=Sbbb
-----END PGP SIGNATURE-----

--EriCkyEuq3/QeyIh--

