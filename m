Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5413BC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 15:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKfA0-0007a9-8M; Thu, 29 May 2025 11:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKf9w-0007Zc-9j
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKf9t-00063h-Jq
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748532423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=htQn01KOhxmpTz1AldYE6MzJycG5atucJKOhZwHbOaM=;
 b=gdaSMfgXLX3IFxdHurAWC+2HLAhPmgzRNb2YkDwZTm45kCc6yJYHSilpU6TkhM7BVomqU+
 0OBjd7NyJO4wuK552jogTkGgWkGWBfhsW70zzGR0SlTBV+53qKSdTqHZFzQPjKeStYv8wm
 SljJtCL3z3LX2Q6jWCSV6+H7LG/dFWc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-_BJ_JDyROuejESeyunWS8A-1; Thu,
 29 May 2025 11:27:01 -0400
X-MC-Unique: _BJ_JDyROuejESeyunWS8A-1
X-Mimecast-MFC-AGG-ID: _BJ_JDyROuejESeyunWS8A_1748532420
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66A7B19560B1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 15:27:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D769B19560A7; Thu, 29 May 2025 15:26:59 +0000 (UTC)
Date: Thu, 29 May 2025 11:26:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/25] Functional tests, Microblaze endianness & pc/q35
 cleanups
Message-ID: <20250529152658.GA62516@fedora>
References: <20250528202442.18315-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O4V2xphXjmjVq0Qo"
Content-Disposition: inline
In-Reply-To: <20250528202442.18315-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--O4V2xphXjmjVq0Qo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 10:24:42PM +0200, Thomas Huth wrote:
>  Hi Stefan!
>=20
> The following changes since commit 80db93b2b88f9b3ed8927ae7ac74ca30e643a8=
3e:
>=20
>   Merge tag 'pull-aspeed-20250526' of https://github.com/legoater/qemu in=
to staging (2025-05-26 10:16:59 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2025-05-28v2
>=20
> for you to fetch changes up to 51c214b7c27096e3516aedf6befd69dc6d75b4ac:
>=20
>   tests/unit/test-util-sockets: fix mem-leak on error object (2025-05-28 =
22:16:26 +0200)
>=20
> ----------------------------------------------------------------
> * Functional tests improvements
> * Endianness improvements/clean-ups for the Microblaze machines
> * Remove obsolete -2.4 and -2.5 i440fx and q35 machine types and related =
code
>=20
> v2: Dropped the memlock test patches

Please take a look at the following CI failure:

ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 QTEST=
_QEMU_BINARY=3D./qemu-system-microblaze QTEST_QEMU_IMG=3D./qemu-img UBSAN_O=
PTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stack=
trace=3D1 G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/E8PpwMky/0/qemu-p=
roject/qemu/tests/dbus-vmstate-daemon.sh MSAN_OPTIONS=3Dhalt_on_error=3D1:a=
bort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1=
 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon PY=
THON=3D/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/pyvenv=
/bin/python3 MALLOC_PERTURB_=3D57 MESON_TEST_ITERATION=3D1 /home/gitlab-run=
ner/builds/E8PpwMky/0/qemu-project/qemu/build/tests/qtest/test-netfilter --=
tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
munmap_chunk(): invalid pointer
=2E./tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signa=
l 6 (Aborted) (core dumped)
(test program exited with status code -6)

More info here:
https://gitlab.com/qemu-project/qemu/-/jobs/10190886460#L5038

Thanks!

Stefan

>=20
> ----------------------------------------------------------------
> Matheus Tavares Bernardino (1):
>       tests/unit/test-util-sockets: fix mem-leak on error object
>=20
> Philippe Mathieu-Daud=C3=A9 (17):
>       hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
>       hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
>       hw/i386/pc: Remove pc_compat_2_4[] array
>       hw/core/machine: Remove hw_compat_2_4[] array
>       hw/net/e1000: Remove unused E1000_FLAG_MAC flag
>       hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definiti=
on
>       hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_DISABLE_PCIE definition
>       hw/i386/pc: Remove deprecated pc-q35-2.5 and pc-i440fx-2.5 machines
>       hw/i386/x86: Remove X86MachineClass::save_tsc_khz field
>       hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
>       hw/core/machine: Remove hw_compat_2_5[] array
>       hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_OLD_PCI_CONFIGURATION defi=
nition
>       hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
>       hw/scsi/vmw_pvscsi: Convert DeviceRealize -> InstanceInit
>       hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definiti=
on
>       hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
>       hw/net/vmxnet3: Merge DeviceRealize in InstanceInit
>=20
> Thomas Huth (7):
>       tests/functional/test_sparc64_tuxrun: Explicitly set the 'sun4u' ma=
chine
>       tests/functional/test_mips_malta: Re-enable the check for the PCI h=
ost bridge
>       tests/functional/test_mem_addr_space: Use set_machine() to select t=
he machine
>       hw/microblaze: Add endianness property to the petalogix_s3adsp1800 =
machine
>       tests/functional: Test both microblaze s3adsp1800 endianness varian=
ts
>       hw/microblaze: Remove the big-endian variants of ml605 and xlnx-zyn=
qmp-pmu
>       docs: Deprecate the qemu-system-microblazeel binary
>=20
>  docs/about/deprecated.rst                        |  19 ++--
>  docs/about/removed-features.rst                  |   9 ++
>  include/hw/boards.h                              |   9 +-
>  include/hw/i386/pc.h                             |   7 --
>  include/hw/i386/x86.h                            |   5 --
>  include/hw/loader.h                              |   2 -
>  include/hw/nvram/fw_cfg.h                        |  10 ---
>  include/hw/virtio/virtio-pci.h                   |   8 --
>  hw/core/loader.c                                 |  14 ---
>  hw/core/machine.c                                |  18 ----
>  hw/i386/pc.c                                     |  42 ++-------
>  hw/i386/pc_piix.c                                |  26 ------
>  hw/i386/pc_q35.c                                 |  26 ------
>  hw/i386/x86.c                                    |   1 -
>  hw/microblaze/petalogix_ml605_mmu.c              |  15 +---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c         |  41 +++++++--
>  hw/microblaze/xlnx-zynqmp-pmu.c                  |   7 +-
>  hw/net/e1000.c                                   |  95 +++++++++--------=
---
>  hw/net/vmxnet3.c                                 |  44 ++-------
>  hw/nvram/fw_cfg.c                                | 110 ++---------------=
------
>  hw/scsi/vmw_pvscsi.c                             |  67 +++-----------
>  hw/virtio/virtio-pci.c                           |  11 +--
>  system/vl.c                                      |   5 --
>  target/i386/machine.c                            |   5 +-
>  tests/qtest/test-x86-cpuid-compat.c              |  14 ---
>  tests/unit/test-util-sockets.c                   |   4 +
>  tests/functional/test_mem_addr_space.py          |  63 ++++++-------
>  tests/functional/test_microblaze_s3adsp1800.py   |  18 ++--
>  tests/functional/test_microblazeel_s3adsp1800.py |   6 +-
>  tests/functional/test_mips_malta.py              |   6 +-
>  tests/functional/test_sparc64_tuxrun.py          |   1 +
>  31 files changed, 197 insertions(+), 511 deletions(-)
>=20

--O4V2xphXjmjVq0Qo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg4fMIACgkQnKSrs4Gr
c8h8uAgAtfR6i4iMDYGY2m73iaJar0EwdCQeTk/0UXaF8uyY8MBawktvK7loRfOa
YAdty4XW5xR8EE1jUopfhPKpXxa6criLyavzcCiOrMQJ8URNIj5rVarY2JAwCYm7
a/Oj+FwHXX0awh1//OtawKHYU2/qNgxblZZpmkPnwCFGLjXOEeqiX/6zUdN5fcv8
5Uox8FaE0PjH3RIX1RFgeJ97sL3g0vbZd+LMbRakx4lCXxzao15mGYK8ETxou0+h
5qKeLGv49bqOKdQH6MBmnNCM4/3j3pCZruWrubgVOikN8qX4KJ3Nn4803uc7GrHk
IlHWXsWkd0mkAhMa/OnIk2fAwUKFnQ==
=crwb
-----END PGP SIGNATURE-----

--O4V2xphXjmjVq0Qo--


