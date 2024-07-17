Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB365C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTy9Y-0004wC-5m; Wed, 17 Jul 2024 02:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTy9Q-0004eK-OQ; Wed, 17 Jul 2024 02:28:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTy9N-0002T0-0D; Wed, 17 Jul 2024 02:28:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9933E7B13D;
 Wed, 17 Jul 2024 09:28:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BA17010B09D;
 Wed, 17 Jul 2024 09:28:25 +0300 (MSK)
Received: (nullmailer pid 827663 invoked by uid 1000);
 Wed, 17 Jul 2024 06:28:25 -0000
Subject: [ANNOUNCE] QEMU 7.2.13 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jul 2024 09:28:25 +0300
Message-Id: <1721197705.716677.827662.nullmailer@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi everyone,

The QEMU v7.2.13 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-7.2.13.tar.xz
  https://download.qemu.org/qemu-7.2.13.tar.xz.sig (signature)

v7.2.13 is now tagged in the official qemu.git repository, and the
stable-7.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-7.2

There are 19 changes since the previous v7.2.12 release, including
a fix for CVE-2024-4467 (qemu-img info command lack of input validation).

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-7.2-hash master-hash Author Name: Commmit-Subject):

ee29e78fce Michael Tokarev:
 Update version for 7.2.13 release
6807403eed a0124e333e Maxim Mikityanskiy:
 char-stdio: Restore blocking mode of stdout on exit
f0654b8d91 7aa6492401 Stefano Garzarella:
 virtio: remove virtio_tswap16s() call in vring_packed_event_read()
0408443ecb 7ead946998 Kevin Wolf:
 block: Parse filenames only when explicitly requested
35eb3e49a7 7e1110664e Kevin Wolf:
 iotests/270: Don't store data-file with json: prefix in image
7e3a2a0ee6 2eb42a728d Kevin Wolf:
 iotests/244: Don't store data-file with protocol in image
149bc216f2 bd385a5298 Kevin Wolf:
 qcow2: Don't open data_file with BDRV_O_NO_IO
df3768b1a4 76bccf3cb9 Richard Henderson:
 target/arm: Fix VCMLA Dd, Dn, Dm[idx]
9804d797b9 903916f0a0 Chuang Xu:
 i386/cpu: fixup number of addressable IDs for processor cores in the physi=
=3D
cal package
3d7fa1b3e2 f51f90c65e Thomas Huth:
 gitlab-ci: Disable the riscv64-debian-cross-container by default
0b27d262d1 7c7d369b33 Alex Benn=3DC3=3DA9e:
 tests: don't run benchmarks for the tsan build
ece3cc28df 641b1efe01 Thomas Huth:
 tests: Update our CI to use CentOS Stream 9 instead of 8
c57fe3ac66 d639cf7978 Paolo Bonzini:
 ci, docker: update CentOS and OpenSUSE Python to non-EOL versions
e4213c3dcb 0054dc8bde Marc-Andr=3DC3=3DA9 Lureau:
 Update lcitool and fedora to 37
bd650df6f7 e030d08c2f Thomas Huth:
 gitlab-ci.d/buildtest: Merge the --without-default-* jobs
ca5d7bb952 521d7fb3eb Richard Henderson:
 tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
b07ff6d447 54b2792102 Ilya Leoshkevich:
 linux-user: Make TARGET_NR_setgroups affect only the current thread
c53db9c66d b1cf266c82 Gerd Hoffmann:
 stdvga: fix screen blanking
6ce9033339 2c3e4e2de6 Alexey Dobriyan:
 virtio-net: drop too short packets early
afb890bf17 3973615e7f Mark Cave-Ayland:
 target/i386: fix size of EBP writeback in gen_enter()

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEe3O61ovnosKJMUsicBtPaxppPlkFAmaWRxAACgkQcBtPaxpp
PllFYwf+Nszvl1tugCYBSNGu01fnfFTSs//KIeueF5go3U5AaOXLXJaZpycAhQbL
TURBqlPxEkX4eQL0ivTNA4vyg/YBTz8J/SrF9A+BnLAcbA5RWxdgyC61TNBxIo6N
EeG7PwzMZLUidzUz3MN8ZPpxnIyzV01nLx2hx80OhBkak7I3PMlx8lh3OM0KcSY0
K0vuxGHfyeO+qIAsltG2BykRHRlDKVIYfGBNy7M4lFbnL8u5w2JiYQI3KgJsK1Lg
MqNkbK++kiF7w2sCutJgPLhhFqD2n8EZiGmoBtpMm4pp1Ai9T+HGbabp/R6NDdjb
bO43NLeyQeUGaISUYN3uKpzGRdbMVA=3D=3D
=3DA4oy
-----END PGP SIGNATURE-----

