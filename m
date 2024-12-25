Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B54E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 14:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQRUW-0004Sy-Ul; Wed, 25 Dec 2024 08:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tQRUQ-0004Rz-G4
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 08:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tQRUL-00086L-H5
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 08:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735133506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rEUlTiKt1UJa5J+z/2Rf7jv1jT1YE8baej933EB0VhM=;
 b=C1WRzBBMRKi7DN1L2qbaI6vwIx5qbzeBCs61pD9N2cud9uLzwzzAucXmm2g1rkMzgD6CrF
 S1i4h8Osd4olVMP+YrIXrkU3ti1Mv07fQsO2VRmq+19D8BJNgWl6YF9D3u/Ua57iUJT5UT
 0G/xSjCOFvP+AgCHdGzpO2cvMmJzDoM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-fti2JbBEOA6DKkhCTy2MxA-1; Wed,
 25 Dec 2024 08:31:44 -0500
X-MC-Unique: fti2JbBEOA6DKkhCTy2MxA-1
X-Mimecast-MFC-AGG-ID: fti2JbBEOA6DKkhCTy2MxA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE450195608F
 for <qemu-devel@nongnu.org>; Wed, 25 Dec 2024 13:31:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09B5119560A3; Wed, 25 Dec 2024 13:31:41 +0000 (UTC)
Date: Wed, 25 Dec 2024 08:31:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/17] vfio queue
Message-ID: <20241225133139.GA930035@fedora>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6/TXom4yhiwDFgDh"
Content-Disposition: inline
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--6/TXom4yhiwDFgDh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi C=C3=A9dric,
Please take a look at the following 32-bit CI failure:

i686-linux-gnu-gcc -m32 -Ilibqemu-x86_64-softmmu.a.p -I. -I.. -Itarget/i386=
 -I../target/i386 -Isubprojects/libvduse -I../subprojects/libvduse -Iqapi -=
Itrace -Iui -Iui/shader -I/usr/include/capstone -I/usr/include/p11-kit-1 -I=
/usr/include/pixman-1 -I/usr/include/libpng16 -I/usr/include/spice-server -=
I/usr/include/spice-1 -I/usr/include/SDL2 -I/usr/include/glib-2.0 -I/usr/li=
b/i386-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/include/bl=
kid -I/usr/include/gio-unix-2.0 -I/usr/include/slirp -I/usr/include/gtk-3.0=
 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/freetype2 =
-I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -=
I/usr/include/i386-linux-gnu -I/usr/include/atk-1.0 -I/usr/include/at-spi2-=
atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/i386-l=
inux-gnu/dbus-1.0/include -I/usr/include/vte-2.91 -I/usr/include/virgl -I/u=
sr/include/cacard -I/usr/include/nss -I/usr/include/nspr -I/usr/include/PCS=
C -I/usr/include/libusb-1.0 -I/usr/include/pipewire-0.3 -I/usr/include/spa-=
0.2 -I/usr/include/fuse3 -I/usr/include/uuid -fdiagnostics-color=3Dauto -Wa=
ll -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wemp=
ty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2=
k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-for=
mat-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration=
 -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototy=
pes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -=
Wno-psabi -Wno-shift-negative-value -isystem /builds/qemu-project/qemu/linu=
x-headers -isystem linux-headers -iquote . -iquote /builds/qemu-project/qem=
u -iquote /builds/qemu-project/qemu/include -iquote /builds/qemu-project/qe=
mu/host/include/i386 -iquote /builds/qemu-project/qemu/host/include/generic=
 -iquote /builds/qemu-project/qemu/tcg/i386 -msse2 -mfpmath=3Dsse -D_GNU_SO=
URCE -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial=
-auto-var-init=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIE -D_FILE_OFFSET=
_BITS=3D64 -D__USE_FILE_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=3D1 -=
pthread -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600 -DNCURSES_WIDECHAR=3D1 -D_R=
EENTRANT -DSTRUCT_IOVEC_DEFINED -isystem../linux-headers -isystemlinux-head=
ers -DCOMPILING_PER_TARGET '-DCONFIG_TARGET=3D"x86_64-softmmu-config-target=
=2Eh"' '-DCONFIG_DEVICES=3D"x86_64-softmmu-config-devices.h"' -MD -MQ libqe=
mu-x86_64-softmmu.a.p/hw_vfio_igd.c.o -MF libqemu-x86_64-softmmu.a.p/hw_vfi=
o_igd.c.o.d -o libqemu-x86_64-softmmu.a.p/hw_vfio_igd.c.o -c ../hw/vfio/igd=
=2Ec
=2E./hw/vfio/igd.c: In function =E2=80=98vfio_igd_pci_config_read=E2=80=99:
=2E./hw/vfio/igd.c:438:18: error: format =E2=80=98%lx=E2=80=99 expects argu=
ment of type =E2=80=98long unsigned int=E2=80=99, but argument 2 has type =
=E2=80=98uint64_t=E2=80=99 {aka =E2=80=98long long unsigned int=E2=80=99} [=
-Werror=3Dformat=3D]
  438 |         hw_error("igd: unsupported pci config read at %lx, size %u",
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  439 |                  offset, size);
      |                  ~~~~~~
      |                  |
      |                  uint64_t {aka long long unsigned int}
=2E./hw/vfio/igd.c: In function =E2=80=98vfio_igd_pci_config_write=E2=80=99:
=2E./hw/vfio/igd.c:463:18: error: format =E2=80=98%lx=E2=80=99 expects argu=
ment of type =E2=80=98long unsigned int=E2=80=99, but argument 2 has type =
=E2=80=98uint64_t=E2=80=99 {aka =E2=80=98long long unsigned int=E2=80=99} [=
-Werror=3Dformat=3D]
  463 |         hw_error("igd: unsupported pci config write at %lx, size %u=
",
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  464 |                  offset, size);
      |                  ~~~~~~
      |                  |
      |                  uint64_t {aka long long unsigned int}
cc1: all warnings being treated as errors

https://gitlab.com/qemu-project/qemu/-/jobs/8722428394#L6317

Once the issue has been resolved, please send a new revision of this
pull request. Thanks!

Stefan

--6/TXom4yhiwDFgDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdsCTsACgkQnKSrs4Gr
c8jQiwgAkrm4zNrY6X3elCnR67Uu8hb4/DH8rbTzvM2zuHZBiEu3FD8jPcZGVuQe
J4yT2YEZzizKpeLi/+ieBZhUOige9HsOT9FmnTqsD7P5qJHeEHa0Z/jlvFUc6OrN
LaTm/W43Iwwd4OridERyj9yUeevIUuNbdVrUHfqVcKjZhe/K+ixDX2NUw7u/LxJd
VW+OhL9r694bOW4zVdCKO6jf23JCE9AF89nv2t1hBWhmZNottkXEBazaGDj4sZDv
e5mPAh+JC212uxD3Kri5pi0F2628pGvzyM6mtTwpBTdhpJgDt7rON+vKaQg/9l13
7Hp+ZLG61u+GgCrsgRTxFSb2k9KiVQ==
=f5ie
-----END PGP SIGNATURE-----

--6/TXom4yhiwDFgDh--


