Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4077C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 19:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s59K6-0003Ed-7X; Thu, 09 May 2024 15:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s59K5-0003ER-EH
 for qemu-devel@nongnu.org; Thu, 09 May 2024 15:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s59K2-0006Er-7f
 for qemu-devel@nongnu.org; Thu, 09 May 2024 15:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715282453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ae6ge9qtV0esnxBHskZ67d5EQ5CAN7MrIjbaTV16q8k=;
 b=OMpNhkRPiaVYsa2zTFFRnbRszGHkK0qQSfkezYjgDBeE1eSaJW1VNK9Pvpuy7Y1sD5205+
 wKV2BCMm+Zb1eSOLveworSWSZP3zl2b/j+xfE929k9KYPqvLtBITC9j7HEh4Lzt1mQ6Vue
 q2qsZZEWBJBJaaNq7nHglOHBVKFjMGE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-DUOTjk8JPQi2n-EBGjnf9Q-1; Thu,
 09 May 2024 15:20:48 -0400
X-MC-Unique: DUOTjk8JPQi2n-EBGjnf9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA76129AA39C;
 Thu,  9 May 2024 19:20:47 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA3BC173CB3;
 Thu,  9 May 2024 19:20:45 +0000 (UTC)
Date: Thu, 9 May 2024 15:20:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 00/12] vhost-user: support any POSIX system (tested on
 macOS, FreeBSD, OpenBSD)
Message-ID: <20240509192044.GL515246@fedora.redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZzQx5fSFrI9GS143"
Content-Disposition: inline
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ZzQx5fSFrI9GS143
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 09:44:44AM +0200, Stefano Garzarella wrote:
> v1: https://patchew.org/QEMU/20240228114759.44758-1-sgarzare@redhat.com/
> v2: https://patchew.org/QEMU/20240326133936.125332-1-sgarzare@redhat.com/
> v3: https://patchew.org/QEMU/20240404122330.92710-1-sgarzare@redhat.com/
> v4:
>   - rebased on master (commit e116b92d01c2cd75957a9f8ad1d4932292867b81)
>   - added patch 6 to move using QEMU bswap helper functions in a separate
>     patch (Phil)
>   - fail if we find "share=3Doff" in shm_backend_memory_alloc() (David)
>   - added Phil's R-b and David's A-b
>=20
> The vhost-user protocol is not really Linux-specific, so let's try support
> QEMU's frontends and backends (including libvhost-user) in any POSIX syst=
em
> with this series. The main use case is to be able to use virtio devices t=
hat
> we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) e=
ven
> in non-Linux systems.
>=20
> The first 5 patches are more like fixes discovered at runtime on macOS or
> FreeBSD that could go even independently of this series.
>=20
> Patches 6, 7, 8, and 9 enable building of frontends and backends (includi=
ng
> libvhost-user) with associated code changes to succeed in compilation.
>=20
> Patch 10 adds `memory-backend-shm` that uses the POSIX shm_open() API to
> create shared memory which is identified by an fd that can be shared with
> vhost-user backends. This is useful on those systems (like macOS) where
> we don't have memfd_create() or special filesystems like "/dev/shm".
>=20
> Patches 11 and 12 use `memory-backend-shm` in some vhost-user tests.
>=20
> Maybe the first 5 patches can go separately, but I only discovered those
> problems after testing patches 6 - 9, so I have included them in this ser=
ies
> for now. Please let me know if you prefer that I send them separately.
>=20
> I tested this series using vhost-user-blk and QSD on macOS Sonoma 14.4
> (aarch64), FreeBSD 14 (x86_64), OpenBSD 7.4 (x86_64), and Fedora 39 (x86_=
64)
> in this way:
>=20
> - Start vhost-user-blk or QSD (same commands for all systems)
>=20
>   vhost-user-blk -s /tmp/vhost.socket \
>     -b Fedora-Cloud-Base-39-1.5.x86_64.raw
>=20
>   qemu-storage-daemon \
>     --blockdev file,filename=3DFedora-Cloud-Base-39-1.5.x86_64.qcow2,node=
-name=3Dfile \
>     --blockdev qcow2,file=3Dfile,node-name=3Dqcow2 \
>     --export vhost-user-blk,addr.type=3Dunix,addr.path=3D/tmp/vhost.socke=
t,id=3Dvub,num-queues=3D1,node-name=3Dqcow2,writable=3Don
>=20
> - macOS (aarch64): start QEMU (using hvf accelerator)
>=20
>   qemu-system-aarch64 -smp 2 -cpu host -M virt,accel=3Dhvf,memory-backend=
=3Dmem \
>     -drive file=3D./build/pc-bios/edk2-aarch64-code.fd,if=3Dpflash,format=
=3Draw,readonly=3Don \
>     -device virtio-net-device,netdev=3Dnet0 -netdev user,id=3Dnet0 \
>     -device ramfb -device usb-ehci -device usb-kbd \
>     -object memory-backend-shm,id=3Dmem,size=3D512M \
>     -device vhost-user-blk-pci,num-queues=3D1,disable-legacy=3Don,chardev=
=3Dchar0 \
>     -chardev socket,id=3Dchar0,path=3D/tmp/vhost.socket
>=20
> - FreeBSD/OpenBSD (x86_64): start QEMU (no accelerators available)
>=20
>   qemu-system-x86_64 -smp 2 -M q35,memory-backend=3Dmem \
>     -object memory-backend-shm,id=3Dmem,size=3D"512M" \
>     -device vhost-user-blk-pci,num-queues=3D1,chardev=3Dchar0 \
>     -chardev socket,id=3Dchar0,path=3D/tmp/vhost.socket
>=20
> - Fedora (x86_64): start QEMU (using kvm accelerator)
>=20
>   qemu-system-x86_64 -smp 2 -M q35,accel=3Dkvm,memory-backend=3Dmem \
>     -object memory-backend-shm,size=3D"512M" \
>     -device vhost-user-blk-pci,num-queues=3D1,chardev=3Dchar0 \
>     -chardev socket,id=3Dchar0,path=3D/tmp/vhost.socket
>=20
> Branch pushed (and CI started) at https://gitlab.com/sgarzarella/qemu/-/t=
ree/macos-vhost-user?ref_type=3Dheads
>=20
> Thanks,
> Stefano
>=20
> Stefano Garzarella (12):
>   libvhost-user: set msg.msg_control to NULL when it is empty
>   libvhost-user: fail vu_message_write() if sendmsg() is failing
>   libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not supported
>   vhost-user-server: do not set memory fd non-blocking
>   contrib/vhost-user-blk: fix bind() using the right size of the address
>   contrib/vhost-user-*: use QEMU bswap helper functions
>   vhost-user: enable frontends on any POSIX system
>   libvhost-user: enable it on any POSIX system
>   contrib/vhost-user-blk: enable it on any POSIX system
>   hostmem: add a new memory backend based on POSIX shm_open()
>   tests/qtest/vhost-user-blk-test: use memory-backend-shm
>   tests/qtest/vhost-user-test: add a test case for memory-backend-shm
>=20
>  docs/system/devices/vhost-user.rst        |   5 +-
>  meson.build                               |   5 +-
>  qapi/qom.json                             |  17 +++
>  subprojects/libvhost-user/libvhost-user.h |   2 +-
>  backends/hostmem-shm.c                    | 123 ++++++++++++++++++++++
>  contrib/vhost-user-blk/vhost-user-blk.c   |  27 +++--
>  contrib/vhost-user-input/main.c           |  16 +--
>  hw/net/vhost_net.c                        |   5 +
>  subprojects/libvhost-user/libvhost-user.c |  76 ++++++++++++-
>  tests/qtest/vhost-user-blk-test.c         |   2 +-
>  tests/qtest/vhost-user-test.c             |  23 ++++
>  util/vhost-user-server.c                  |  12 +++
>  backends/meson.build                      |   1 +
>  hw/block/Kconfig                          |   2 +-
>  qemu-options.hx                           |  13 +++
>  util/meson.build                          |   4 +-
>  16 files changed, 305 insertions(+), 28 deletions(-)
>  create mode 100644 backends/hostmem-shm.c
>=20
> --=20
> 2.45.0
>=20

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZzQx5fSFrI9GS143
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9IgsACgkQnKSrs4Gr
c8g6yAgAyFC+og+aCiEwFCFUClEuAt5U11SH1yINM7vdr6/+yPV4CFJHiBqxpuAn
ymMPKSNmXHJCMBJ5jnMzRF2fVbbIsz8047/T6RRZnMyPBDXZh3xTlKwyeJ4BuLU7
53PcBcdkCyyGvhtQj0npHsOLxJj9TCZRtcjz6yYmNFqgY3166utib2muM6lje9ge
/Y2KD7g69hKAZszWRw8TSmJh/hU7ukd7MUekgVKDxAQFwF0QwBMBgpj7j53go/uk
1K24CcsxoPMiii437zrO4XxorvXN9EUhClhWL3EGlaOT5Pvw2yUzSWWAjUDNKra6
RkPnEElZ0tMb0bsbmwII9LF8VXSYFw==
=8Ao1
-----END PGP SIGNATURE-----

--ZzQx5fSFrI9GS143--


