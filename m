Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3D4C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzk1-0007b9-QU; Wed, 17 Jul 2024 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTzk0-0007aD-SA; Wed, 17 Jul 2024 04:10:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTzjy-00059q-Iv; Wed, 17 Jul 2024 04:10:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6CAC47B21D;
 Wed, 17 Jul 2024 11:10:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A9CF010B137;
 Wed, 17 Jul 2024 11:10:19 +0300 (MSK)
Received: (nullmailer pid 831480 invoked by uid 1000);
 Wed, 17 Jul 2024 08:10:19 -0000
Subject: [ANNOUNCE] QEMU 9.0.2 Stable released
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jul 2024 11:10:19 +0300
Message-Id: <1721203819.679622.831479.nullmailer@tls.msk.ru>
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

Hi everyone,

The QEMU v9.0.2 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-9.0.2.tar.xz
  https://download.qemu.org/qemu-9.0.2.tar.xz.sig (signature)

v9.0.2 is now tagged in the official qemu.git repository, and the
stable-9.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-9.0

There are 27 changes since the previous v9.0.1 release, including
a fix for CVE-2024-4467 (qemu-img info command lack of input validation).

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-9.0-hash master-hash Author Name: Commmit-Subject):

5ebde3b5c0 Michael Tokarev:
 Update version for 9.0.2 release
e0d660aeea 3936bbdf9a Vincent Fu:
 hw/nvme: fix number of PIDs for FDP RUH update
e4a9b44f7a e389929d19 Markus Armbruster:
 sphinx/qapidoc: Fix to generate doc for explicit, unboxed arguments
837864aa6c a0124e333e Maxim Mikityanskiy:
 char-stdio: Restore blocking mode of stdout on exit
8c86d8aa6c 7aa6492401 Stefano Garzarella:
 virtio: remove virtio_tswap16s() call in vring_packed_event_read()
c13615f78f a113d041e8 Cindy Lu:
 virtio-pci: Fix the failure process in kvm_virtio_pci_vector_use_one()
b4efc4ce2c a71d9dfbf6 Richard Henderson:
 tcg/optimize: Fix TCG_COND_TST* simplification of setcond2
5be2bb40e3 7ead946998 Kevin Wolf:
 block: Parse filenames only when explicitly requested
8c022d8af6 7e1110664e Kevin Wolf:
 iotests/270: Don't store data-file with json: prefix in image
0bbe8f9b12 2eb42a728d Kevin Wolf:
 iotests/244: Don't store data-file with protocol in image
312ca4065b bd385a5298 Kevin Wolf:
 qcow2: Don't open data_file with BDRV_O_NO_IO
68473fdd22 e68dcbb079 Daniel P. Berrang=3DC3=3DA9:
 tests: add testing of parameter=3D3D1 for SMP topology
a4fd014e33 9d7950edb0 Daniel P. Berrang=3DC3=3DA9:
 hw/core: allow parameter=3D3D1 for SMP topology on any machine
10f230bd61 7619129f0d Richard Henderson:
 target/arm: Fix FJCVTZS vs flush-to-zero
10b9e0c546 76bccf3cb9 Richard Henderson:
 target/arm: Fix VCMLA Dd, Dn, Dm[idx]
50a8a6b4d6 903916f0a0 Chuang Xu:
 i386/cpu: fixup number of addressable IDs for processor cores in the physi=
=3D
cal package
bbbbc048a5 641b1efe01 Thomas Huth:
 tests: Update our CI to use CentOS Stream 9 instead of 8
d7a4a38a03 6d3279655a Fabiano Rosas:
 migration: Fix file migration with fdset
658fb89bdc 521d7fb3eb Richard Henderson:
 tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
c8fdbb5bab 6b4965373e Cl=3DC3=3DA9ment Chigot:
 target/sparc: use signed denominator in sdiv helper
0556f5fc13 54b2792102 Ilya Leoshkevich:
 linux-user: Make TARGET_NR_setgroups affect only the current thread
7ee955223e 3b279f73fa Anton Johansson:
 accel/tcg: Fix typo causing tb->page_addr[1] to not be recorded
37f037cb69 b1cf266c82 Gerd Hoffmann:
 stdvga: fix screen blanking
1608a7f81f a276ec8e26 Philippe Mathieu-Daud=3DC3=3DA9:
 hw/audio/virtio-snd: Always use little endian audio format
35e5ce5bd6 719c6819ed Stefan Hajnoczi:
 Revert "monitor: use aio_co_reschedule_self()"
0d90c36d9c 77bf310084 Dongwon Kim:
 ui/gtk: Draw guest frame at refresh cycle
09f36a1f3f 2c3e4e2de6 Alexey Dobriyan:
 virtio-net: drop too short packets early
db0a21257e 3973615e7f Mark Cave-Ayland:
 target/i386: fix size of EBP writeback in gen_enter()


