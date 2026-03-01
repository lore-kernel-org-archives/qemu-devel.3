Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC48FD005C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 11:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwekY-0007xd-Kw; Sun, 01 Mar 2026 06:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwekV-0007wS-P4
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 06:14:12 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwekT-0005L1-PH
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 06:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772363646; x=1772968446; i=lukasstraub2@web.de;
 bh=DD6ytcJeEnLAyYvi0FRzAvV4KKWRdhYXz36f9Hvh4LM=;
 h=X-UI-Sender-Class:Date:From:Cc:Subject:Message-ID:MIME-Version:
 Content-Type:cc:content-transfer-encoding:content-type:date:from:
 message-id:mime-version:reply-to:subject:to;
 b=TcLoUcQFYmVNWHEhawBg53sPY6s0opOjoke+sRCDKLA58IAIaS/GmBU9XeF0wB5t
 GNCbCYbzdydgiTAtdV8NHCSpPgIywTiWGj1moSQMFR17SnaE82g1q4/J4R3Np+juh
 sKLktTix4ZF6T+IDr+s3Wj+cg2JMUO//YOzxoLia/1xbxvuC+mHL+b+7POzpkqCpL
 VUzEbbZPkMKyx13XJgw+BuylWz8HQyprUgf6uZoalJy/NJJzcXa7pFX9zi+h27YVk
 ve2VThRj7E+7WXHoxhgce6nY3mHq9n4oKgbizkyDusEa4OIxHX/Rnz4/ynFfeB/aC
 6j4Ub8AiJuR4y7tHbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1vHqPF0g03-00pBsl; Sun, 01
 Mar 2026 12:14:06 +0100
Date: Sun, 1 Mar 2026 12:13:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Subject: qemu master compile error in hw/net/rtl8139.c with --enable-asan
Message-ID: <20260301121347.797dc9f4@penguin>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/24=AWyXytR=MhezjuAbYrPr";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:phb8hE1/aWbU1clNd8d7nvajmdkK+Kku480trFLuKOfUJTAITaI
 IhdsIvo8wL8FkrxCPXdoKD4zu3lqvhdRENC9rWaBrAbyNdg+qCUXI+k2JUS16P1lPGuQb3t
 9PTnxi8SRyWHIuZzlVP+Jp9UVY0c7xvgYQ8pdrSvlBeDg4I+7/Vwar272dd9vG1KjahVa4v
 /NnWetlBOu57eCJ/NS4pA==
UI-OutboundReport: notjunk:1;M01:P0:aXMlmnQsRxc=;VzQHT3v3M+o1qsT20HOBeokUyNE
 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
 oLEjqUNckBHovK5eKDRkUCniIGXFS
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Sig_/24=AWyXytR=MhezjuAbYrPr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Ubuntu 24.04:

lukas@build_colo:~/qemu$ cc --version
cc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
lukas@build_colo:~/qemu$ ./configure --target-list=3Dx86_64-softmmu --enabl=
e-replication --enable-docs --enable-asan
lukas@build_colo:~/qemu$ ninja -C build qemu-system-x86_64 qemu-img tests/q=
test/migration-test
ninja: Entering directory `build'
[24/564] Compiling C object libsystem.a.p/hw_net_rtl8139.c.o
FAILED: libsystem.a.p/hw_net_rtl8139.c.o=20
cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/dtc/libfdt -I../subprojects/=
dtc/libfdt -Isubprojects/libvduse -I../subprojects/libvduse -Iui -Iqapi -It=
race -Iui/shader -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I/usr/in=
clude/libpng16 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0=
/include -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-un=
ix-2.0 -I/usr/include/slirp -fdiagnostics-color=3Dauto -Wall -Winvalid-pch =
-Werror -std=3Dgnu11 -O2 -g -mcx16 -msse2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=
=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivia=
l-auto-var-init=3Dzero -fzero-call-used-regs=3Dused-gpr -fsanitize=3Daddres=
s -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-defin=
ed -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrou=
gh=3D2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested=
-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls -=
Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-str=
ings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isyste=
m /home/lukas/qemu/linux-headers -isystem linux-headers -iquote . -iquote /=
home/lukas/qemu -iquote /home/lukas/qemu/include -iquote /home/lukas/qemu/h=
ost/include/x86_64 -iquote /home/lukas/qemu/host/include/generic -iquote /h=
ome/lukas/qemu/tcg/x86_64 -pthread -fPIE -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=
=3D600 -DNCURSES_WIDECHAR=3D1 -DCONFIG_SOFTMMU -DCOMPILING_SYSTEM_VS_USER -=
MD -MQ libsystem.a.p/hw_net_rtl8139.c.o -MF libsystem.a.p/hw_net_rtl8139.c.=
o.d -o libsystem.a.p/hw_net_rtl8139.c.o -c ../hw/net/rtl8139.c
../hw/net/rtl8139.c: In function =E2=80=98rtl8139_io_writeb=E2=80=99:
../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0=
 [-Werror=3Dstringop-overflow=3D]
 2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
      |                 ^
In file included from ../hw/net/rtl8139.c:62:
/home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into dest=
ination object =E2=80=98ip_ver_len=E2=80=99 of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0=
 [-Werror=3Dstringop-overflow=3D]
 2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, =
8);
      |                     ^
/home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into dest=
ination object =E2=80=98ip_ver_len=E2=80=99 of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0=
 [-Werror=3Dstringop-overflow=3D]
 2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, =
8);
      |                     ^
/home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into dest=
ination object =E2=80=98ip_ver_len=E2=80=99 of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
In file included from /home/lukas/qemu/include/system/memory.h:21,
                 from /home/lukas/qemu/include/hw/pci/pci.h:4,
                 from /home/lukas/qemu/include/hw/pci/pci_device.h:4,
                 from ../hw/net/rtl8139.c:54:
In function =E2=80=98stl_he_p=E2=80=99,
    inlined from =E2=80=98stl_be_p=E2=80=99 at /home/lukas/qemu/include/qem=
u/bswap.h:371:5,
    inlined from =E2=80=98rtl8139_cplus_transmit_one=E2=80=99 at ../hw/net/=
rtl8139.c:2244:21,
    inlined from =E2=80=98rtl8139_cplus_transmit=E2=80=99 at ../hw/net/rtl8=
139.c:2345:28,
    inlined from =E2=80=98rtl8139_io_writeb=E2=80=99 at ../hw/net/rtl8139.c=
:2728:17:
/home/lukas/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into a =
region of size 0 [-Werror=3Dstringop-overflow=3D]
  284 |     __builtin_memcpy(ptr, &v, sizeof(v));
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/lukas/qemu/include/net/eth.h: In function =E2=80=98rtl8139_io_writeb=
=E2=80=99:
/home/lukas/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into des=
tination object =E2=80=98ip_ver_len=E2=80=99 of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
cc1: all warnings being treated as errors
[37/564] Compiling C object libsystem.a.p/hw_pci_pci.c.o
ninja: build stopped: subcommand failed.

--Sig_/24=AWyXytR=MhezjuAbYrPr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmkH2sACgkQNasLKJxd
slg+tQ//bmNtbxbF997kQrE5gtm14bG6l08+0Xc8Cz6V6UlnS7j6zKa9atY9LU1z
Mpt9k8dJUtLRw9RpWmHlhRUDmb+aZV8RiD8zooN0TRArlUGXWpGRyzUXsSAKVAXx
wPdgh/8XR/53cacCZSKyf91IroDWVGGu7srFrK6lsFJVFO5s4joBChF/2+7l9twy
sBDFV9LicfduzKQ4lY4aN+XL+kHg8f+1PXYiQF6mp6/CkSUgoydoBJH51WH4oqQQ
eZG5AJGRdgXtpehgIetLeD1/3m1Zv/EHZXeIKQ0g6q7wc9pyn91n5MS8ma0oJHAI
/bd18FKhyqlDQHdC3fs8hb7Av5+Vj1tEkDTY2a+/vIXraLhpRrDLHPvfo1WUD7Dq
qli508+65yjJ0CSVY5ZyjdnQoCA0w3mt2TR+nEcCx/8vyXbaXuXzlYCsBn8E3iXX
XHb3ShEE/HGFfXbWoZcmOcScdRD2zl54hWzYCwYncYd5ZFev8WHFTDxIkTbS0uX3
XtU8d37tQjPLdbwo8Sglpmv0OUfFSE3VVei8W4Mfj1ZCpm0iECcUUcX5avjeywBy
L1c6uPLrBFiPQ7HjefiTtG1V489rD885nUVDJu9qbg1YZa6wY5gt1Su/ikUtP8lQ
4PduAxO4s/AO6WuHi0opIuIFJCYsTAR5R7MRUTn46EETqFvUSpw=
=txtJ
-----END PGP SIGNATURE-----

--Sig_/24=AWyXytR=MhezjuAbYrPr--

